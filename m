Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37901390FE9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 07:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbhEZFNi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 May 2021 01:13:38 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58502 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhEZFNh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 May 2021 01:13:37 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14Q59uUS017219;
        Wed, 26 May 2021 05:11:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=gzXPgwKP/+fh8ysHumLq9lb+ANH9vl4GxfCMXp2Skqc=;
 b=hQLe4+nfd+MPuGXyxq4JCeuANCSeP6KFUXBBFF8gQj+Qi0J6tWhwse1XhOfeDGTCFlvG
 b6/JjQ6lWBsoTOBBsTYbUmwNSjhirBsyharDT53kJSmpf973sU3FsqLbFRQLKAR8ayY2
 wgy9brRhLVmKwruLN5qtj8QwslfL+plGaRYFUKVueTh/JJRRa2bCNnzWD5VU/aYA6xUU
 5si3RxEV/ocT1ewB3az8ceqDI9eus5rAhZX/XTPVkEmbtgV2iLQdV36YEPJgwTcbIxo/
 Zu5OHuifFuP4TiOVrkfyo5pEj5DcIKxBd6omLEzjBjqp4Q1WqIomIEnSYKD+I3NR7pHv jg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 38ptkp7s9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 May 2021 05:11:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14Q54tME103855;
        Wed, 26 May 2021 05:11:58 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by aserp3020.oracle.com with ESMTP id 38rehbw36k-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 May 2021 05:11:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iaFaUu54tmuVj5jcSByYhn+UxXfNqzF6UhS1TqFtAAQ5JCjTGJphPBKzp6UjiGeSsWXGY07SVAwKH0JsQ5kdM6x3BbyY4WcVhD/xUPgae+yL6iF1m8jObBCg/f5mRxfG2JE2c7P21Id6h+sJzFkXW2JEKosleUpjdPYBTPXiTJbqnBR0K3XU1dgXmiwcxr717+jGfUie/IyNwXKOEkypV5+cVLN58jcSAS3MiV3Ml1P+qCufuXv/najw815amuiQGjflOZFVp15l2HOP3ZZdexSJJEfyLRMKKBkpNsx5sPq+QO+LrtjsEhryD7Y9oNJKkuZGe6LrYfB1BIZRphP+3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzXPgwKP/+fh8ysHumLq9lb+ANH9vl4GxfCMXp2Skqc=;
 b=l8gyYqwnPL38IZ6agrXlOEtDckr93dE9JcVjkUWxfKjHSP5CVhkhzkvsqkKzK8e+JCIJrJgsl2d5VeEte3HRC0QehiCdOrr/yaSNeG1andgABWTNorcAostxU47KFwWe8QWPRFeyedSVbJivdy5u3ohfeXUxlT1lfyMMsr/FMbmZ3lVbqku0pAz6CSDkPAJJmOpFkOZ6VLtLV7pj6/eKwhi38EDf2Iuh40cY3yOK0etRStuCHljokTQ9bK/L3DhTn7xPkI3pNfX7SeAB4m9/wIMyRYEKS0E5ebnK8HKtwNgcEZ9DmYSfwpkiZjbvxq0+Zro0bFgE7AZRyhQRlTZEPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzXPgwKP/+fh8ysHumLq9lb+ANH9vl4GxfCMXp2Skqc=;
 b=HzYfcrrzbGo9Rs/1RiuDrqwRV47Rv3wLC0itVr9z1cXIhNlVhI/8Phhk5RyzLFuHCw1L6VivP2fI0JIYtyfDiBjxeGzEZUzLoOCSxBrMiLbfG30UAiiWWBfmYvJfSk3Ez9RINpqRwfIJQ5AWnhVbEGb8yGhFIjFElAwHcvTgcWk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by BYAPR10MB2599.namprd10.prod.outlook.com (2603:10b6:a02:b2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Wed, 26 May
 2021 05:11:55 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::4519:4046:5549:95d9]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::4519:4046:5549:95d9%6]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 05:11:55 +0000
Subject: Re: [PATCH v2] ocfs2: fix data corruption by fallocate
To:     Joseph Qi <joseph.qi@linux.alibaba.com>, ocfs2-devel@oss.oracle.com
Cc:     jack@suse.cz, linux-fsdevel@vger.kernel.org
References: <20210521233612.75185-1-junxiao.bi@oracle.com>
 <35a1d32b-b8d7-ea9b-d28c-6b4fd837605d@linux.alibaba.com>
 <8aa90f5d-e4db-5107-1d3c-383294871196@oracle.com>
 <21d8b289-541d-50f5-6f86-de3ee69c56c5@linux.alibaba.com>
 <35283832-3294-19e0-6542-d1f925711fe8@oracle.com>
 <cbeec344-adb3-0dc4-51ee-4716c07176f3@linux.alibaba.com>
From:   Junxiao Bi <junxiao.bi@oracle.com>
Message-ID: <297dcd1e-c741-007e-8f53-77eba9656e74@oracle.com>
Date:   Tue, 25 May 2021 22:10:33 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
In-Reply-To: <cbeec344-adb3-0dc4-51ee-4716c07176f3@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [73.231.9.254]
X-ClientProxiedBy: BY5PR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:a03:180::35) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-159-238-224.vpn.oracle.com (73.231.9.254) by BY5PR13CA0022.namprd13.prod.outlook.com (2603:10b6:a03:180::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.12 via Frontend Transport; Wed, 26 May 2021 05:11:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af4e0a79-5d1f-4cf6-34c6-08d92004c7e5
X-MS-TrafficTypeDiagnostic: BYAPR10MB2599:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB259969D3F26952A38254DFF5E8249@BYAPR10MB2599.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C8DAZrITBvQX9lQ4YR2Dtbmy/S36CMlqXP6Cguxmcc+gUL04NjbkzyG8hpORCfdxfCzX+8RWX4c66ubXl6uR86M3hjpLEDYQFnKNlztN3kScSNfp6ozMwf+nr3XjfuYvmHIHOc0s1sosaTtFQdXlPNhmEsbjiTi0H6pWAOqgIGf/QTwz/TtYvg+nfVjNg7/9oRoZX4EJf8qwS9mQeeWzGjEvMK6jMiZRKPn4NPNLspPfB4dImSBxgw0UY0mkv/vg5Gsf+3CHNJdXHOoAB5q5nzyQ5UD809L+Acjo4Wl1dGaxtHCKuK2PVZhvh3tbRYSMeAmrSAfV8tsluMX9Z0Eja3cQ7dte/vkvrQ1JMYAsJSl4HAqT7NpmN+VdCzXss+9aosLujwKiYZfZYyb2vfw4ZVYwAlIyPUrx0WI2m4WjP13o4J9CoaGDmF8TsYQNj8KVnotbcQPEY/M+0nOSZbhLjR55Bvnsf1U5EhV59uP+oL0ycKR6hyyz38ljPVSsehvYfv0ny1rirykgjR1PDX0YtoPmTXgYInYXMDcXEJNPk3Ezhr7NEl8zLx+yWEGf3vapLfzBGCb56yyxbPiFprYAOcScx3a5zjEEMfOQ+taPU1eA4rWF00OcvCXaTq1ieIGg0KITZkO8P5R75B6PyfSVkgmgIUyNnjjClLgdPq1jJDhl+6dIbSXJ3kKOS1HmsDvmiUkxA53P/fLyXYcbzaw2VlLyK3gugUBZ3YeP2WKtMhF4fJj372J2s6En5Bcdr/mKDLHQ7iNBLkLVCAwV0+qdHZLmJpfjpyyw0VbU53O8FoTD3SfCT2W6CNEbfMm3tk1c
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(346002)(396003)(366004)(376002)(16526019)(186003)(26005)(316002)(956004)(31696002)(2616005)(44832011)(966005)(38100700002)(6486002)(86362001)(478600001)(53546011)(66946007)(66556008)(2906002)(31686004)(8936002)(66476007)(5660300002)(8676002)(83380400001)(7696005)(4326008)(36756003)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eG1Kc2Nlb1orOHJSenpoTXJIUVMyU25TOEw5YjlwYTJ4QWhFWnVwK0Y2dmlM?=
 =?utf-8?B?VUlhRUdTUFFMQ2FtVTlSaFBKK1M0Uk03S0Fjc1Z4Nm9XZlNBMVJiUkwxdUN6?=
 =?utf-8?B?VEt6OHFGNDVyVjNFTktLU3BaSHpPbHM3SFRZMnFoa3hTak9lcEJGMmJTckdZ?=
 =?utf-8?B?SDY0OVp1NDB5aTVrWlNhZURUOE9lSEtSaitMdFlxdzdNYnJzZFhQS20wMUh1?=
 =?utf-8?B?R1kzdXZZUndWLzFZWGJ5VGNsNk5EV3ZORjJsM1VaQ25XU0ZxMXIyaUE5QmdS?=
 =?utf-8?B?RW9Eb0Q1NUpRSjBKZ09IU3ZTcEI2VHVmdWREWTFyVUtLcllJYWo3NUFoTE5G?=
 =?utf-8?B?QmVkcmpFeEo2QXpzdm1xTDNNTk1IU1RrYXk5YmNFUzl4K3p1ZFlKSmEzMHM0?=
 =?utf-8?B?VDBUejhvUHVwdlNYaWZKWE1LRkp5a1pSczQzSlFrZVcxVTliRHVGeStlZUs1?=
 =?utf-8?B?dnFGWnBwR0JVZDBJN0Q2NDlHVDhmZ1BLSVVvUzlhUml0K0dJaW5pNnFEUEw0?=
 =?utf-8?B?S2wxVkZORnVtUk9BNWFROXo2RXMxc1hVbm4vbEw5VmNLR0JXbjEwNkZ3ZWUw?=
 =?utf-8?B?NVlWaVdZeWZDMi91VGtpc0ZOZEhVaHBqVmttUGkrWUF4U3hveURuMTNQSk1V?=
 =?utf-8?B?VkVzRFpQNjVnNFFJSTh6N0RJN2hndUYxcHNhbkpGOS9NMGdYSGRLUGQ2dVlS?=
 =?utf-8?B?MFhJTHFBTCtvbkNMcHdqU3pOMjZLM2RCeDFCZGhJU09QUjNjNThDRzBRTkk3?=
 =?utf-8?B?dFIyOU5ZajRsRStqamk1VThFRUZMV3lkY09JQ0d1eG9wTXZIV3lUanplMDAr?=
 =?utf-8?B?VjJxaGpWZFJVVFpjRWMwSitEdVNYVlNxdUdOVU13UklLSzVmM2ZZdHVLaVha?=
 =?utf-8?B?ZTJteElFTEh4WDY3T1pzQnhXa1JmTFhlQytMSlAwSTVOTExPNGVuR0JPZ3Zv?=
 =?utf-8?B?MWNZalR2NXRuMU9DVUFEeHNSRHRhVks3UWM0V2pzNGR3Q0ttNFVuK1gwZTQ1?=
 =?utf-8?B?YTlYempyc2ZhVDJoRHovRjZCOEV1NjU5NkQ3WjIyM2xaQUlkTkxrbTBpR3FZ?=
 =?utf-8?B?ZE03cTZGVXd4clJDL2dzeUlEMEJqRjBVOG15RGFTeTlkM3hobnMrdlV2OWkv?=
 =?utf-8?B?UUxQek5KVUJlZTBpenBIZTdKQXo0VE5GVm9NNDFqbTJTRUJMak8xRWVrL1hI?=
 =?utf-8?B?bFRIaXpMTGV6MUpQN1gyL0EzbWVTSlJ2c1R2Q0s4ZWNFVkl1ZFBPY3gwWGdV?=
 =?utf-8?B?QmlQa3RGcVlMNEhpVHN3NVhJVFpUT0ZabzA0UkxrNzJKdWxCSERORkQ2cEdH?=
 =?utf-8?B?NU1EWmJ1MklLQXI3Y1UyMC9CTXF0TmFDOUFSaTBuZTBlcU8zNXljczJhbmo2?=
 =?utf-8?B?NHVvOGYrQ0NSZTZIa2NIYmlFemk4RHF1VGdXbUc5NjZoVXlFS3RrRXdpUjRj?=
 =?utf-8?B?WHRRamtqdnF4czVJSWxkemNzNnZGaFdnbENlNjRjbzFkQjdmWDFkY09PaTJK?=
 =?utf-8?B?b0VZWHdvMXhSWXVuYjlNMk5OcnMrNitjTDNrYzRNeGNLL0xpc2xlQmlHR3dN?=
 =?utf-8?B?RDE2aEJjanM4bDdRTCtxRVZNL0lFak5YSFU5V1hUKzMxcnVIbFF3MmRLY05Y?=
 =?utf-8?B?aFFrS0Z1OHdUdXRxSDcxYTRvRUNpdzNrdnN5QlQ3SDJUdWRybGpYUndQZGQx?=
 =?utf-8?B?VjY2eVVFT3FTWUdickg4N2NRNFpoYm9mS1BFcVVhTitOZlRINldvb0F3YkUy?=
 =?utf-8?Q?muldxGU4XeFGZGYJYVQuOMtpXvHGIr8M9hqMuXy?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af4e0a79-5d1f-4cf6-34c6-08d92004c7e5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 05:11:55.7292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JbLJJXjnyTS1M42Jkk5L0fW+/aIEL0edAIaE29sHVVvuvc2zF1jCacvoWC+HdUnzV5LTerNcfvNK+Ez75qz7SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2599
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9995 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105260033
X-Proofpoint-GUID: D8MpP2fN3__en3zpUv5JbqWsSx0AJBGf
X-Proofpoint-ORIG-GUID: D8MpP2fN3__en3zpUv5JbqWsSx0AJBGf
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9995 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105260033
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After moving there, i_size_write will be protected by ip_alloc_sem, 
ocfs2_dio_end_io_write will update i_size without holding inode lock, 
but it does holding ip_alloc_sem.

Thanks,

Junxiao.

On 5/25/21 7:11 PM, Joseph Qi wrote:
> Can we simply replace i_size_read() with 'orig_isize' and leave isize
> update along with other dirty inode operations?
> I think this makes more comfortable for the dirty inode transaction.
>
> Thanks,
> Joseph
>
> On 5/26/21 1:58 AM, Junxiao Bi wrote:
>> I would like make the following change to the patch, is that ok to you?
>>
>> diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
>> index 17469fc7b20e..775657943057 100644
>> --- a/fs/ocfs2/file.c
>> +++ b/fs/ocfs2/file.c
>> @@ -1999,9 +1999,12 @@ static int __ocfs2_change_file_space(struct file *file, struct inode *inode,
>>          }
>>
>>          /* zeroout eof blocks in the cluster. */
>> -       if (!ret && change_size && orig_isize < size)
>> +       if (!ret && change_size && orig_isize < size) {
>>                  ret = ocfs2_zeroout_partial_cluster(inode, orig_isize,
>>                                          size - orig_isize);
>> +               if (!ret)
>> +                       i_size_write(inode, size);
>> +       }
>>          up_write(&OCFS2_I(inode)->ip_alloc_sem);
>>          if (ret) {
>>                  mlog_errno(ret);
>> @@ -2018,9 +2021,6 @@ static int __ocfs2_change_file_space(struct file *file, struct inode *inode,
>>                  goto out_inode_unlock;
>>          }
>>
>> -       if (change_size && i_size_read(inode) < size)
>> -               i_size_write(inode, size);
>> -
>>          inode->i_ctime = inode->i_mtime = current_time(inode);
>>          ret = ocfs2_mark_inode_dirty(handle, inode, di_bh);
>>          if (ret < 0)
>>
>> Thanks,
>>
>> Junxiao.
>>
>> On 5/24/21 7:04 PM, Joseph Qi wrote:
>>> Thanks for the explanations.
>>> A tiny cleanup, we can use 'orig_isize' instead of i_size_read() later
>>> in __ocfs2_change_file_space().
>>> Other looks good to me.
>>> Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
>>>
>>> On 5/25/21 12:23 AM, Junxiao Bi wrote:
>>>> That will not work, buffer write zero first, then update i_size, in between writeback could be kicked in and clear those dirty buffers because they were out of i_size. Beside that, OCFS2_IOC_RESVSP64 was never doing right job, it didn't take care eof blocks in the last cluster, that made even a simple fallocate to extend file size could cause corruption. This patch fixed both issues.
>>>>
>>>> Thanks,
>>>>
>>>> Junxiao.
>>>>
>>>> On 5/23/21 4:52 AM, Joseph Qi wrote:
>>>>> Hi Junxiao,
>>>>> If change_size is true (!FALLOC_FL_KEEP_SIZE), it will update isize
>>>>> in __ocfs2_change_file_space(). Why do we have to zeroout first?
>>>>>
>>>>> Thanks,
>>>>> Joseph
>>>>>
>>>>> On 5/22/21 7:36 AM, Junxiao Bi wrote:
>>>>>> When fallocate punches holes out of inode size, if original isize is in
>>>>>> the middle of last cluster, then the part from isize to the end of the
>>>>>> cluster will be zeroed with buffer write, at that time isize is not
>>>>>> yet updated to match the new size, if writeback is kicked in, it will
>>>>>> invoke ocfs2_writepage()->block_write_full_page() where the pages out
>>>>>> of inode size will be dropped. That will cause file corruption. Fix
>>>>>> this by zero out eof blocks when extending the inode size.
>>>>>>
>>>>>> Running the following command with qemu-image 4.2.1 can get a corrupted
>>>>>> coverted image file easily.
>>>>>>
>>>>>>        qemu-img convert -p -t none -T none -f qcow2 $qcow_image \
>>>>>>                 -O qcow2 -o compat=1.1 $qcow_image.conv
>>>>>>
>>>>>> The usage of fallocate in qemu is like this, it first punches holes out of
>>>>>> inode size, then extend the inode size.
>>>>>>
>>>>>>        fallocate(11, FALLOC_FL_KEEP_SIZE|FALLOC_FL_PUNCH_HOLE, 2276196352, 65536) = 0
>>>>>>        fallocate(11, 0, 2276196352, 65536) = 0
>>>>>>
>>>>>> v1: https://www.spinics.net/lists/linux-fsdevel/msg193999.html
>>>>>>
>>>>>> Cc: <stable@vger.kernel.org>
>>>>>> Cc: Jan Kara <jack@suse.cz>
>>>>>> Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
>>>>>> ---
>>>>>>
>>>>>> Changes in v2:
>>>>>> - suggested by Jan Kara, using sb_issue_zeroout to zero eof blocks in disk directly.
>>>>>>
>>>>>>     fs/ocfs2/file.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++--
>>>>>>     1 file changed, 47 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
>>>>>> index f17c3d33fb18..17469fc7b20e 100644
>>>>>> --- a/fs/ocfs2/file.c
>>>>>> +++ b/fs/ocfs2/file.c
>>>>>> @@ -1855,6 +1855,45 @@ int ocfs2_remove_inode_range(struct inode *inode,
>>>>>>         return ret;
>>>>>>     }
>>>>>>     +/*
>>>>>> + * zero out partial blocks of one cluster.
>>>>>> + *
>>>>>> + * start: file offset where zero starts, will be made upper block aligned.
>>>>>> + * len: it will be trimmed to the end of current cluster if "start + len"
>>>>>> + *      is bigger than it.
>>>>>> + */
>>>>>> +static int ocfs2_zeroout_partial_cluster(struct inode *inode,
>>>>>> +                    u64 start, u64 len)
>>>>>> +{
>>>>>> +    int ret;
>>>>>> +    u64 start_block, end_block, nr_blocks;
>>>>>> +    u64 p_block, offset;
>>>>>> +    u32 cluster, p_cluster, nr_clusters;
>>>>>> +    struct super_block *sb = inode->i_sb;
>>>>>> +    u64 end = ocfs2_align_bytes_to_clusters(sb, start);
>>>>>> +
>>>>>> +    if (start + len < end)
>>>>>> +        end = start + len;
>>>>>> +
>>>>>> +    start_block = ocfs2_blocks_for_bytes(sb, start);
>>>>>> +    end_block = ocfs2_blocks_for_bytes(sb, end);
>>>>>> +    nr_blocks = end_block - start_block;
>>>>>> +    if (!nr_blocks)
>>>>>> +        return 0;
>>>>>> +
>>>>>> +    cluster = ocfs2_bytes_to_clusters(sb, start);
>>>>>> +    ret = ocfs2_get_clusters(inode, cluster, &p_cluster,
>>>>>> +                &nr_clusters, NULL);
>>>>>> +    if (ret)
>>>>>> +        return ret;
>>>>>> +    if (!p_cluster)
>>>>>> +        return 0;
>>>>>> +
>>>>>> +    offset = start_block - ocfs2_clusters_to_blocks(sb, cluster);
>>>>>> +    p_block = ocfs2_clusters_to_blocks(sb, p_cluster) + offset;
>>>>>> +    return sb_issue_zeroout(sb, p_block, nr_blocks, GFP_NOFS);
>>>>>> +}
>>>>>> +
>>>>>>     /*
>>>>>>      * Parts of this function taken from xfs_change_file_space()
>>>>>>      */
>>>>>> @@ -1865,7 +1904,7 @@ static int __ocfs2_change_file_space(struct file *file, struct inode *inode,
>>>>>>     {
>>>>>>         int ret;
>>>>>>         s64 llen;
>>>>>> -    loff_t size;
>>>>>> +    loff_t size, orig_isize;
>>>>>>         struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
>>>>>>         struct buffer_head *di_bh = NULL;
>>>>>>         handle_t *handle;
>>>>>> @@ -1896,6 +1935,7 @@ static int __ocfs2_change_file_space(struct file *file, struct inode *inode,
>>>>>>             goto out_inode_unlock;
>>>>>>         }
>>>>>>     +    orig_isize = i_size_read(inode);
>>>>>>         switch (sr->l_whence) {
>>>>>>         case 0: /*SEEK_SET*/
>>>>>>             break;
>>>>>> @@ -1903,7 +1943,7 @@ static int __ocfs2_change_file_space(struct file *file, struct inode *inode,
>>>>>>             sr->l_start += f_pos;
>>>>>>             break;
>>>>>>         case 2: /*SEEK_END*/
>>>>>> -        sr->l_start += i_size_read(inode);
>>>>>> +        sr->l_start += orig_isize;
>>>>>>             break;
>>>>>>         default:
>>>>>>             ret = -EINVAL;
>>>>>> @@ -1957,6 +1997,11 @@ static int __ocfs2_change_file_space(struct file *file, struct inode *inode,
>>>>>>         default:
>>>>>>             ret = -EINVAL;
>>>>>>         }
>>>>>> +
>>>>>> +    /* zeroout eof blocks in the cluster. */
>>>>>> +    if (!ret && change_size && orig_isize < size)
>>>>>> +        ret = ocfs2_zeroout_partial_cluster(inode, orig_isize,
>>>>>> +                    size - orig_isize);
>>>>>>         up_write(&OCFS2_I(inode)->ip_alloc_sem);
>>>>>>         if (ret) {
>>>>>>             mlog_errno(ret);
>>>>>>
