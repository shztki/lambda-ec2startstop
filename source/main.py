import boto3

ec2 = boto3.resource('ec2')

def lambda_handler(event, context):

    tag_key = 'Ec2StartStop'
    instances = ec2.instances.filter(
        Filters=[
            {
                'Name': 'tag-key',
                'Values': [
                    tag_key,
                ]
            },
        ],
    )

    start_list = []
    stop_list = []
    action = event['Action']

    for i in instances:
        if i.tags != None:
            for t in i.tags:
                if t['Key'] == tag_key:

                    if t['Value'] == 'Auto' or t['Value'] == action:
                        if action == 'Start' and i.state['Name'] == 'stopped':
                                start_list.append(i.instance_id)
                        elif action == 'Stop' and i.state['Name'] == 'running':
                                stop_list.append(i.instance_id)

    try:
        if start_list:
            print('Starting', len(start_list), 'instances', start_list)
            ec2.instances.filter(InstanceIds=start_list).start()
    
        elif stop_list:
            print('Stopping', len(stop_list), 'instances', stop_list)
            ec2.instances.filter(InstanceIds=stop_list).stop()
    except Exception as e:
        print('Error-Reporting:', e)

