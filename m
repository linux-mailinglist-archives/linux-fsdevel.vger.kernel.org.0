Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE364EB151
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 18:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239278AbiC2QIV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 12:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239398AbiC2QIS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 12:08:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499569681A;
        Tue, 29 Mar 2022 09:06:35 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22TFxHNS006533;
        Tue, 29 Mar 2022 16:06:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=wSmRL6dJercjeBoUNj/TkwHRYgaN9rhonaXP0VvEoEs=;
 b=CObl/CgrwL2wkdD54agOu6R5wWi41QiHIVSeP8Y2tbVkAUz3SaTHq7LsFHRQDoG9pW1h
 L9UqpgUW8dWlVG+1BefTQvvmGnn4BexC+9VB+mr7m7SygpfRVHI3W2iZ7U+5wmsksMrj
 m+EidgPCuA+vOKOB63iJx2hw5EzmzbW0uk7Xk25tEqzebbJtKPNSNhEgnQ1qm3Ns/rmM
 MHAjojV0lHXaChAH9UtRSxamKXDZAdScz3B6Om1lzzm0gHj2eK5vU6M1wJtKACdDL3tJ
 5X4Rv44DoDwEco+tyCtuPw7klj13TGkQjqtwObPxn8UtfVZX+bS+ZdEkY65JVzH/aBiB jA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1se0f3dj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 16:06:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22TG0dKc107672;
        Tue, 29 Mar 2022 16:06:30 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by userp3020.oracle.com with ESMTP id 3f1v9fh293-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 16:06:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgE7MyOLbRu6h122h9bczA894yjOHkAbguFzqJJqpGZN/OeB+Qyhm0pRtcDS4d3/4BdZYKQqsHpJ5goGXe6y3pFXItHeKKm0Ecw8ZsHRGj8i2uJa5tiCGQGOBNmVjr2g9oTxXPZcPrSI2qyg1DZf7sx7u/7Gz3wwWy5Xd8wYVQqyRblTfrFD8yR1pPJkBq20xzOiPkSRknT1wYLHv4JX+iMMRCee5IEdoVFYGKTb6Vlk9qDPKw0hQpf/udb2gjH9zgy5h3xJhvD3sCIxoqZsf3NDQcUaqRvTm+qwB1IP0dGKb/cznJmXf3BQuVldaNPMHS61esBMfb2pr8josLjYAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSmRL6dJercjeBoUNj/TkwHRYgaN9rhonaXP0VvEoEs=;
 b=fM8Rk2UQcw7uQbB3AoKtnqiLK+Lt6+9M0K/VfErf1+YqZAXF8awrtj4d1pfbLUbWIg/w1k/C3gh7zRjLhhRtKmnhCFv8JnKw+HK+4+bv7A+CRKcA0ZEZxaf1GwfBjUlMlxJySlpiJAGORX7G+mJIM9NIs4O1Fi5jt3ZIScKQgI3THGv38IBCP8XUbWacNldabzie2jOp0FTa8f7ywenvZNGe/c19+iuhjA2chfqEB5k4VXTY7Qo9ECh5Hj81gqmbeuV3MWylzHrKlvUtPGYfJaNTlEY6GzuTfeyEELSY+gaqMoFKzXyyRdWCVZnSWTCXP2eqIQalhVrZgFqL6voR8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSmRL6dJercjeBoUNj/TkwHRYgaN9rhonaXP0VvEoEs=;
 b=OFTvW5oJEh8KxC58Ni6oP7gTbDQJvgzZ7KEDY79ji/sL9JQzUEMthABxMgcQK+LG6SIxIais747b6tADkcoOOks0aBimRaffKQ+PuY5tonNk1J0Pv1JiSaMvlwFP3SQd+tWGjSx7CjWpj9uu9qnJlX4iPORyVQvDOPAshPbhxV4=
Received: from MN2PR10MB4270.namprd10.prod.outlook.com (2603:10b6:208:1d6::21)
 by DM8PR10MB5495.namprd10.prod.outlook.com (2603:10b6:8:22::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Tue, 29 Mar
 2022 16:06:27 +0000
Received: from MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::ec41:df7c:ccb0:22b4]) by MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::ec41:df7c:ccb0:22b4%7]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 16:06:27 +0000
Message-ID: <e2b0140e-0580-5885-9305-d72b5a4f1d78@oracle.com>
Date:   Tue, 29 Mar 2022 09:06:23 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH RFC v18 05/11] NFSD: Update nfs4_get_vfs_file() to handle
 courtesy client
Content-Language: en-US
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <1648182891-32599-1-git-send-email-dai.ngo@oracle.com>
 <1648182891-32599-6-git-send-email-dai.ngo@oracle.com>
 <20220329152400.GD29634@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20220329152400.GD29634@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::27) To MN2PR10MB4270.namprd10.prod.outlook.com
 (2603:10b6:208:1d6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be72df2e-b430-49ca-affc-08da119e148a
X-MS-TrafficTypeDiagnostic: DM8PR10MB5495:EE_
X-Microsoft-Antispam-PRVS: <DM8PR10MB549567146F3F5EF1E31D2401871E9@DM8PR10MB5495.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T5wOD12ReueDwlNj1xITEwbEdy4W/T1Rl3zxwAK9MZnowetNRGV3rVc839giNUj/HwxUhT4nMk5MNoczrgHrFlklTZPqjU3WpekhRtyxjfAmokwftCS5Iagf7byK2ME8FTUfq369iuxZ0W3hzfYvMRpsPd3ojcXXWaBgRnmf245cK2plahF5QNgf621PQKK1VYGsXTtBDyYsm3rs4k7hbB5Yj6wNDPlMSkZ7EehCa6I8abxu+6PIWTPXKeQzzAJrVL2eNjVmjGokAIwmaO4ihWM9cS/6s8lX5laICCn2FZ7SFnppfc89Pfhfr/FJaBUklMwL0dt168qtm+oDuaI6DXVBVzUVLoxGzzklbB5jMwF7sdhB31QpocvVwYc8ChsdTwOzhoFns1Oipu+PE1/89N41G8f58irr/+n2qvXLq0Y+be3JI0AAr9anBGra6QHpat73uPfOI+h5FZm0rUNwbKv3bjlqll2P4kt6tYpcXuNk90hWi11R1D3qrDVUjrPuGH919HRbaIyziJoJytfqvPS7DFHOm1oqZa7fSd/KTKhal28GEoBwUtc3dQUcrVzih90s5S5/tPwJ4J+hYDYu0NnWISKNYoQr57pyfx+wERrqLa6DWyQDJMiPza45dVgIJtnivEV2RKQ6w++iw7Xi2iLPY/zpvRaDivbZj9wkRX9LzPSJHZk6hjSD0WwbZ4qNEan168K7EJeDWqCzWECf4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4270.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(316002)(5660300002)(38100700002)(86362001)(6916009)(36756003)(6666004)(31686004)(31696002)(15650500001)(8676002)(4326008)(508600001)(6486002)(66946007)(66476007)(66556008)(6512007)(2906002)(26005)(186003)(2616005)(53546011)(6506007)(9686003)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEt1c3JyS0NUS0FZMTkxcThhbytOQ3lOZlFETTVlVElObXJlTDB1dms3Q2Yz?=
 =?utf-8?B?dWNaWjBGbFUyOGJOMnVBTHpZb3lHWnFPWStlTllJOUVYL05iTnVYellqSDk4?=
 =?utf-8?B?aTVHYXpNMkllQnl4STc0T0dqUDNUMUd1TlRuUVdqU1ZLdE5zcTZBaGtaQy8x?=
 =?utf-8?B?ejdNODBvWXR5dktaUzF5cXhOcFlCVmRkWHpISmpodjhWN29KbnZxQXJXanhJ?=
 =?utf-8?B?V3ZJZlNROVBJM0dwM3V6WEMvM1RMaWV4VWdGdm9VRUdDWUFVL1g0cEJFYzRY?=
 =?utf-8?B?YlZDakhtQXYrdCs5MUVzNlJyUzdMS0Z6d01oSXNiaTVQUmtEeDhNMDJ1NUQ3?=
 =?utf-8?B?ejFFaEhqR3h6UGw1RHFBNkhlSHd2ODI3ampXTTVBNktvUVRVajhINlFQdHh5?=
 =?utf-8?B?TWtoR0pzbVU0L0F3NDVZRHdJOExEMFAvQUxDdXNRS2hnZ3BadzJQbXBZNkp1?=
 =?utf-8?B?VlJGb3h4RHVSQngrbGtRZ0lqdXdnT3RzYUw0YVZ4WVRIc09iVnNkZG96cUZh?=
 =?utf-8?B?Qm5KNHZ0UzRTalNZdGRrai83TEZlcGlUNlk0aFk5ek1SR0FMMEJpZDU2NjRU?=
 =?utf-8?B?VCtwRFJ1RlNUVFJqdFY2ZktPZ0wyRXZKUzhFMXFVSVF2Rk42NlM5NWNCK2dp?=
 =?utf-8?B?ZXBjWTRiSnNFT0RqalpyYjNzNUd5ZXZONjdJOTlONDFOMG14bWp4NHUyVkRh?=
 =?utf-8?B?MFd6Z0xnZUswUk96dzJUellwalpCditpZTh1SmNWTmhXNmlSK3JqcVdXOEdI?=
 =?utf-8?B?cEk5YXQzbm9md1ZpdS93M0hqSWJJZGNaOFdBUlVWZzhyK1NZM3hXQUcvUFFC?=
 =?utf-8?B?c0xVbmZEbkJZait2SkEzc3NWdjcwZEYrUzRxK0xmc0J3RTJqcmlhc29RTk1L?=
 =?utf-8?B?K0kwcjNsNmplT1c1RGNyK2RXSCtFS095UEY4Vi8yR24ycmlZRCtPWU0zanBE?=
 =?utf-8?B?WnZBa1d5MTdQckFNRHJZOU9tVTRHanBzVFBPd1h6WDc1ZHI3QTA1QlFrSUcy?=
 =?utf-8?B?aEMzbWpjZTV2MUlMRmxkVkFza3RBczRKYWVKa3VQcmkwMTg1ZndEeE5FNk1E?=
 =?utf-8?B?dEpoUFE4cjFmSkFXNk1NNkY2bm9tN1UzUFV6Mmt4NVFvZ2g5cVZpczhQOXM3?=
 =?utf-8?B?UVY3TEtOdWQxVE9pVkdLVEdNZFRYU3BwSjdlTFBNN2s1MVU0aEoyT0Q2ZFNY?=
 =?utf-8?B?THdXUnBqcGR3NFR4QkNxRnZUWUQxcVVvczZXQ3pmc0N1TUVlRTR1M3JZRE9V?=
 =?utf-8?B?UURMSEl3SXU4RkhMQkYwU3JUZ215bkhSdDlEUzZWYmFBVWlMbWFueStaOFBM?=
 =?utf-8?B?SXMvNGFwcXlaUVpyMmJDYTJLVlJIUElkR3FxZGFzNncwM2lBSTZkbFJoeHBJ?=
 =?utf-8?B?RUdLdU5HMG80NGh6bDVicFl1R3JsVmpuMFVleno0eGlYVWJWUldRMFp5Tmth?=
 =?utf-8?B?YllzQXlaYWF1N3d2aEJQcjlTRHNSME5kNGNVcERrZGhZWjllOXFpOFEyU0Zq?=
 =?utf-8?B?WDU1VW1paFgyelVZbnErdHlUcEhqMVFxYnoyblhWMFZsRmZvSWRwL2pCbERl?=
 =?utf-8?B?aG5qWHRGaXVBYjJVWHY2T05SQVVLRmdSaG9JZnBwTnhUbXZ5RUc4Vk1pNVVs?=
 =?utf-8?B?RFdpTE9DUEpXSFk5QXVkbmVub01PSEtMQUFMbGEzRmcydTR0bkF4K0gwZnVW?=
 =?utf-8?B?WVVjZ1JiNEFRemNoL1Q5dys2QThhWWZrOEg5bU5aTEhxL3d6TW1sS0RZcHFU?=
 =?utf-8?B?S0tVTko4azFKdGYzNmgxK3lHMS9FQXN3cEo3RGRHSHZEQ3BqUkRYMXVkdEJ3?=
 =?utf-8?B?SlBXbE93NFZKUmc4K0c4NTY2ck1yTG83bzM3R0s0emk4Y3NPWlVIZlhmTm1z?=
 =?utf-8?B?VVhMTWs4UElROXFvRnE4Yk5STktKWnUzOW90ZUN0YkJodHhyQkJzSHVPcCtC?=
 =?utf-8?B?KzgvbGFkVXAyRllWVHhxMys4TGlTVzhRTjRGcnNjbkdIb0dGSWJ5eGFrcVJR?=
 =?utf-8?B?Sk80dzhkeTllK0diVnc4NDJCWUU2K0tSOEdqVUNSTE93dFZBSlkzRWcrdGxV?=
 =?utf-8?B?QzhPMFhYUGdGWSt6NUZTNXdoQyt6Q0ZObW1TK1oxRHpIeXdPSWE2czA0QzhG?=
 =?utf-8?B?ckkxOXpWclFwYmg5aGJLV3k0dzZJdnN1enp6NlY1dDF1K254eTcvTW1WcG9t?=
 =?utf-8?B?YXlBNnZFUG5iZVViQkFjbWttZ1NuZ0NvWC80TjFxbEJUMDJpQnFqaTAxbVN5?=
 =?utf-8?B?dkRBZFZRV2xybGttU1lVNVB0RTVsdHJXeFE0U1NJVTR3NUFDVk1lU3ZTeHVC?=
 =?utf-8?B?RmJSV2lZWGlVVjdJdmlFVy9nck9NQ2ttaUY0RnJXOXV0WEdVdUpjUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be72df2e-b430-49ca-affc-08da119e148a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4270.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 16:06:27.5359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fTD4UuvZbgjmDzSeehMt2sOzJLzTSwyNzXjt47zMNvTDL9hbKHBk9PSwolWt6Rnp2EcOxXedf0nTwbV/v8FS2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5495
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10301 signatures=695566
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203290094
X-Proofpoint-ORIG-GUID: 8zgNRD_d3LBQFds32Izw5Y8K_-Eb3oz0
X-Proofpoint-GUID: 8zgNRD_d3LBQFds32Izw5Y8K_-Eb3oz0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 3/29/22 8:24 AM, J. Bruce Fields wrote:
> On Thu, Mar 24, 2022 at 09:34:45PM -0700, Dai Ngo wrote:
>> Update nfs4_get_vfs_file and nfs4_upgrade_open to handle share
>> reservation conflict with courtesy client.
>>
>> Update nfs4_get_vfs_file and nfs4_upgrade_open to handle share
>> reservation conflict with courtesy client.
>>
>> When we have deny/access conflict we walk the fi_stateids of the
>> file in question, looking for open stateid and check the deny/access
>> of that stateid against the one from the open request. If there is
>> a conflict then we check if the client that owns that stateid is
>> a courtesy client. If it is then we set the client state to
>> CLIENT_EXPIRED and allow the open request to continue. We have
>> to scan all the stateid's of the file since the conflict can be
>> caused by multiple open stateid's.
>>
>> Client with CLIENT_EXPIRED is expired by the laundromat.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4state.c | 85 +++++++++++++++++++++++++++++++++++++++++++++--------
>>   1 file changed, 72 insertions(+), 13 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index f20c75890594..fe8969ba94b3 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -701,9 +701,56 @@ __nfs4_file_get_access(struct nfs4_file *fp, u32 access)
>>   		atomic_inc(&fp->fi_access[O_RDONLY]);
>>   }
>>   
>> +/*
>> + * Check if courtesy clients have conflicting access and resolve it if possible
>> + *
>> + * access:  is op_share_access if share_access is true.
>> + *	    Check if access mode, op_share_access, would conflict with
>> + *	    the current deny mode of the file 'fp'.
>> + * access:  is op_share_deny if share_access is false.
>> + *	    Check if the deny mode, op_share_deny, would conflict with
>> + *	    current access of the file 'fp'.
>> + * stp:     skip checking this entry.
>> + * new_stp: normal open, not open upgrade.
>> + *
>> + * Function returns:
>> + *	false - access/deny mode conflict with normal client.
>> + *	true  - no conflict or conflict with courtesy client(s) is resolved.
>> + */
>> +static bool
>> +nfs4_resolve_deny_conflicts_locked(struct nfs4_file *fp, bool new_stp,
>> +		struct nfs4_ol_stateid *stp, u32 access, bool share_access)
>> +{
>> +	struct nfs4_ol_stateid *st;
>> +	struct nfs4_client *clp;
>> +	bool conflict = true;
>> +	unsigned char bmap;
>> +
>> +	lockdep_assert_held(&fp->fi_lock);
>> +	list_for_each_entry(st, &fp->fi_stateids, st_perfile) {
>> +		/* ignore lock stateid */
>> +		if (st->st_openstp)
>> +			continue;
>> +		if (st == stp && new_stp)
>> +			continue;
>> +		/* check file access against deny mode or vice versa */
>> +		bmap = share_access ? st->st_deny_bmap : st->st_access_bmap;
>> +		if (!(access & bmap_to_share_mode(bmap)))
>> +			continue;
> As I said before, I recommend just doing *both* checks here.  Then you
> can remove the "bool share_access" argument.  I think that'll make the
> code easier to read.

Bruce, I'm not clear how to check both here as I mentioned in my previous
email.

nfs4_resolve_deny_conflicts_locked is called from nfs4_file_get_access
and nfs4_file_check_deny to check either access or deny mode separately
so how do we check both access and deny in nfs4_resolve_deny_conflicts_locked?

Thanks,
-Dai

>
> Otherwise, this version looks OK to me, thanks for the revisions.
>
> --b.
>
>> +		clp = st->st_stid.sc_client;
>> +		if (nfsd4_expire_courtesy_clnt(clp))
>> +			continue;
>> +		conflict = false;
>> +		break;
>> +	}
>> +	return conflict;
>> +}
>> +
>>   static __be32
>> -nfs4_file_get_access(struct nfs4_file *fp, u32 access)
>> +nfs4_file_get_access(struct nfs4_file *fp, u32 access,
>> +		struct nfs4_ol_stateid *stp, bool new_stp)
>>   {
>> +
>>   	lockdep_assert_held(&fp->fi_lock);
>>   
>>   	/* Does this access mode make sense? */
>> @@ -711,15 +758,21 @@ nfs4_file_get_access(struct nfs4_file *fp, u32 access)
>>   		return nfserr_inval;
>>   
>>   	/* Does it conflict with a deny mode already set? */
>> -	if ((access & fp->fi_share_deny) != 0)
>> -		return nfserr_share_denied;
>> +	if ((access & fp->fi_share_deny) != 0) {
>> +		if (!nfs4_resolve_deny_conflicts_locked(fp, new_stp,
>> +				stp, access, true))
>> +			return nfserr_share_denied;
>> +	}
>>   
>>   	__nfs4_file_get_access(fp, access);
>>   	return nfs_ok;
>>   }
>>   
>> -static __be32 nfs4_file_check_deny(struct nfs4_file *fp, u32 deny)
>> +static __be32 nfs4_file_check_deny(struct nfs4_file *fp, u32 deny,
>> +		struct nfs4_ol_stateid *stp, bool new_stp)
>>   {
>> +	__be32 rc = nfs_ok;
>> +
>>   	/* Common case is that there is no deny mode. */
>>   	if (deny) {
>>   		/* Does this deny mode make sense? */
>> @@ -728,13 +781,19 @@ static __be32 nfs4_file_check_deny(struct nfs4_file *fp, u32 deny)
>>   
>>   		if ((deny & NFS4_SHARE_DENY_READ) &&
>>   		    atomic_read(&fp->fi_access[O_RDONLY]))
>> -			return nfserr_share_denied;
>> +			rc = nfserr_share_denied;
>>   
>>   		if ((deny & NFS4_SHARE_DENY_WRITE) &&
>>   		    atomic_read(&fp->fi_access[O_WRONLY]))
>> -			return nfserr_share_denied;
>> +			rc = nfserr_share_denied;
>> +
>> +		if (rc == nfserr_share_denied) {
>> +			if (nfs4_resolve_deny_conflicts_locked(fp, new_stp,
>> +					stp, deny, false))
>> +				rc = nfs_ok;
>> +		}
>>   	}
>> -	return nfs_ok;
>> +	return rc;
>>   }
>>   
>>   static void __nfs4_file_put_access(struct nfs4_file *fp, int oflag)
>> @@ -4952,7 +5011,7 @@ nfsd4_truncate(struct svc_rqst *rqstp, struct svc_fh *fh,
>>   
>>   static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
>>   		struct svc_fh *cur_fh, struct nfs4_ol_stateid *stp,
>> -		struct nfsd4_open *open)
>> +		struct nfsd4_open *open, bool new_stp)
>>   {
>>   	struct nfsd_file *nf = NULL;
>>   	__be32 status;
>> @@ -4966,14 +5025,14 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
>>   	 * Are we trying to set a deny mode that would conflict with
>>   	 * current access?
>>   	 */
>> -	status = nfs4_file_check_deny(fp, open->op_share_deny);
>> +	status = nfs4_file_check_deny(fp, open->op_share_deny, stp, new_stp);
>>   	if (status != nfs_ok) {
>>   		spin_unlock(&fp->fi_lock);
>>   		goto out;
>>   	}
>>   
>>   	/* set access to the file */
>> -	status = nfs4_file_get_access(fp, open->op_share_access);
>> +	status = nfs4_file_get_access(fp, open->op_share_access, stp, new_stp);
>>   	if (status != nfs_ok) {
>>   		spin_unlock(&fp->fi_lock);
>>   		goto out;
>> @@ -5027,11 +5086,11 @@ nfs4_upgrade_open(struct svc_rqst *rqstp, struct nfs4_file *fp, struct svc_fh *c
>>   	unsigned char old_deny_bmap = stp->st_deny_bmap;
>>   
>>   	if (!test_access(open->op_share_access, stp))
>> -		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open);
>> +		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open, false);
>>   
>>   	/* test and set deny mode */
>>   	spin_lock(&fp->fi_lock);
>> -	status = nfs4_file_check_deny(fp, open->op_share_deny);
>> +	status = nfs4_file_check_deny(fp, open->op_share_deny, stp, false);
>>   	if (status == nfs_ok) {
>>   		set_deny(open->op_share_deny, stp);
>>   		fp->fi_share_deny |=
>> @@ -5376,7 +5435,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
>>   			goto out;
>>   		}
>>   	} else {
>> -		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open);
>> +		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open, true);
>>   		if (status) {
>>   			stp->st_stid.sc_type = NFS4_CLOSED_STID;
>>   			release_open_stateid(stp);
>> -- 
>> 2.9.5
