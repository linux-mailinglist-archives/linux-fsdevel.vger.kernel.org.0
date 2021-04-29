Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E800636EF52
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 20:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbhD2SJR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Apr 2021 14:09:17 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:47356 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbhD2SJQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Apr 2021 14:09:16 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13TI4mQM116518;
        Thu, 29 Apr 2021 18:08:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=eKyMLfkd1L8ZSyr3kv5lefXF8A9qfmlU8UBDQ1p21Lg=;
 b=0NXqLlDPOe8y2LaLyUs4TOBoT0lFRg1myZRdDMHcJUZBB6xHhkJPKlb2Gpw6TssKiNyL
 o4fcOQSDRwJS7CLby9DOLlb9Ir9zCrhBAkzErq+HALnGCMVLGeaBtlGuNGN2I0rBqe3y
 piUqu4mi+k+AEXksuChOVDpCsYZ4lvfe7KTYkvPEiW+C/g0NmgSDdqP7yt+sUvrEhjyg
 05nlMZqOlBOIpxeew6MHaMgXktLKSmHkHqg4m0e7SlvkKbyJEYpr3fLNzNxrWdkU7Iey
 63pGxZbrhRncmUL9xoULQpW0rJY/ut5Eg8r/lVYJpseFpL0R0DklDbnGsktCbLjclG3Z 3g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 385afq5cyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Apr 2021 18:08:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13TI6t42005218;
        Thu, 29 Apr 2021 18:08:20 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by userp3030.oracle.com with ESMTP id 3848f1f019-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Apr 2021 18:08:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzomY/P+3DYsLY2cDo/aP2j/uOP6bG8NO9gPLRSQpy+kQ3KRXWUWUHc4EO08BMeJTA2dnEntW/LqwnwDGYhTzK5j4pxOs9XeUCFnEYq1x0jRQOvWJrWcoi0Q6utxK73CqrQ+8NGPtrl6s8dLdFNsRmFPSIV+QGE/T1RRxPctdXY+zLwSGp2+vRnqmbOgR3s87uq53yj8qebutN+wvMZBpx58CBhdYX9QODobwt/OJU+ddz+T9sHz5s+SjnOJSEjiI6XwYI5Tu1g6Zn3CqoP4rp04czfK9zIVFwqa/rtcmL20dGsWKdXVrazDNXUpTtfvyV0zJ0R7Emol2AEtKQ6ftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKyMLfkd1L8ZSyr3kv5lefXF8A9qfmlU8UBDQ1p21Lg=;
 b=TET5jYK3kDyLee2ZPFODI63tVT94A73HK1vsjtJo0gpQcOHMTUWWtVvi37E/XdwkwIr6CbR3Mwb7TI8R2MrSWOBojRx70xMrOxRx+kltXLD1yWnLtpyA0GjDt0MYyBwSaUqWNES4Eav9UOQhffno9HTKObPbySfsHho9/SOKO334/uS+0X36112Qn8VvPx6n39ZZHiFanqVO0eR7Yn9+AKKagpLabDdPaR/z2Q6t61ykW6yR3u/Dc7iWakTomHgz7zU8gSPjC+NDRkOqHTtf/g6TDjaBf8Akd4EEyn75cpWIul3C5G7i+YWxX/nNpsudu0FvNIb9+X/pIgY2F2bogA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKyMLfkd1L8ZSyr3kv5lefXF8A9qfmlU8UBDQ1p21Lg=;
 b=gX4R1kRmMWJXGapltkxClV0hcbtjKDjCKgpf0Ctu5u8r/55Yi37muqUGs+2vS5snBVdTCDx0JkPU0EVZAPH2tgBSdy76Cr10Cldz7yli1qfDV/nfLDMYUNGDleld5B+cvKNX7k8m7WmmNc4quHttS+KMhtM+32vooGXe4/qQxjI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by BYAPR10MB2422.namprd10.prod.outlook.com (2603:10b6:a02:a9::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Thu, 29 Apr
 2021 18:08:17 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::7865:7d35:9cee:363f]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::7865:7d35:9cee:363f%5]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 18:08:17 +0000
Subject: Re: [Cluster-devel] [PATCH 1/3] fs/buffer.c: add new api to allow eof
 writeback
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        ocfs2-devel@oss.oracle.com,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20210426220552.45413-1-junxiao.bi@oracle.com>
 <CAHc6FU62TpZTnAYd3DWFNWWPZP-6z+9JrS82t+YnU-EtFrnU0Q@mail.gmail.com>
From:   Junxiao Bi <junxiao.bi@oracle.com>
Message-ID: <3f06d108-1b58-6473-35fa-0d6978e219b8@oracle.com>
Date:   Thu, 29 Apr 2021 11:07:15 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
In-Reply-To: <CAHc6FU62TpZTnAYd3DWFNWWPZP-6z+9JrS82t+YnU-EtFrnU0Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [73.231.9.254]
X-ClientProxiedBy: SA0PR11CA0188.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::13) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-159-251-241.vpn.oracle.com (73.231.9.254) by SA0PR11CA0188.namprd11.prod.outlook.com (2603:10b6:806:1bc::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend Transport; Thu, 29 Apr 2021 18:08:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9d788bb-ebed-4060-127a-08d90b39c365
X-MS-TrafficTypeDiagnostic: BYAPR10MB2422:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB2422B5DB71B3B6B0196E246EE85F9@BYAPR10MB2422.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MP2U/BvUjQ3wfOtdfzD9ZHtLT4agJBehxg3BsuIkZGFk9EO59hF0sZ5mhEMnjuTxZkEYQhRY4zfMTsnzRC8iMkw50PlrGPrV51hpVtD5eFuF0p+6ybBt3kdgoy0z3j/DHR3iVuJHrig1/H8+YtjCT/653kTfvjNTKKqdaNRNrlx2yKSPMDrGfbHB1OkV92Pxg8tUkIa26fy2Y9EqnIh7CXSOyCnb1MbFeOAg4REH2MImTCKc6gE/EazuyRkHBlyzbVy+dZ8mrynrOPztfo6uC2aHqZInzgzp3sVtBNdmgGmCtuBxISmRKUPD5L+jmSd9JjBAUB2N4iAC9IiWnCYGxOGjydm6yV7ZAg4vBoQMeWB46y1xA2Tb/+56X/zkHY6/25oli8WMK1JQE4CZ9TlOoSHzysBvnDtbTD4MlhxL5gFsfr98bI5lfcW1qlI0AobTjARDs/D9bQFDv87xIG1pqFtRsXXyPHv+TTs4ehKH1/YbUJLjjxrytwSrrtThskncA7kzeGypmL4vRT+MOnBaKaNVSQVyo+hGkPG1YpwszryOC2nM5YJoKZDc+ZvUnqCOm6KHh/E/hDFT1Y/RvFui4UBsKFG7aSbpX4tq0ghedOgM/VFtvG6zq9yqVnSlKgAnJPi0jVspTpuZIXtk0OimBEjJzLKYK+U2+KW2HSpu3XUktVWc2OPdpzmckmgHMBH3pw6tUEsRjKLaeqpGk9D6CXaAHxslLsKpzP1tfRnRWofWpE6zZyzjP7Ff/1iRk32+q0/zRI0q49HBB5B1tVdJzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(39860400002)(136003)(346002)(366004)(83380400001)(54906003)(6486002)(8936002)(2616005)(956004)(2906002)(36756003)(31696002)(4326008)(5660300002)(44832011)(6916009)(186003)(26005)(53546011)(7696005)(66476007)(966005)(66946007)(38100700002)(86362001)(8676002)(66556008)(478600001)(316002)(16526019)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Qk1tWHVxazBzc0FYbTA4TElURFRWNUZoWkt0dzVLM2I4QTBrVkp4Y0JPK0to?=
 =?utf-8?B?cDVHZ0t4cWh4WkRPYkZLNDFxYU1JUnNlNFdXS3ZLMlVRa3ZEWUdlQTNobEY1?=
 =?utf-8?B?WW5ia0V0cW02RnF2NkRMVWtZQ3FFVDZvN1FzcEJIYWZwWGxaZTBBSzd1bUc1?=
 =?utf-8?B?VmRzZDRWdlZmVmFjcFlMSTF0WnpTcGR5VlA5dWUwdy9GbGh4ZXQwNVd3TFFY?=
 =?utf-8?B?QVcxcjhiSkp4eHRFUUxVNE0yeTBHKzdrQ1d0YWg1Ykp1RW03akE5MVhqOVhV?=
 =?utf-8?B?RlhnZlRNbU03eFNmOWtyNDFtZlZjT3ZUcVI3ZWR3VGRWS25EOE80Z2swNENp?=
 =?utf-8?B?VUlaZ3E3anY1bm5jWHBidTBXTmtHK2pXbnV2eXhpNjYwamI0TW10RGd3ekc0?=
 =?utf-8?B?eEhzbXZTL1I3VE5NTFptamVOSkRRNzF6aWhzNURFMWVHdjhSaS9Xd2t2OWVF?=
 =?utf-8?B?c3VYaE1ZaG13clM0OC9yRnY3ZmdmRVRFWWt6dlZENDRNRUxNdlBqbTdvQ2xM?=
 =?utf-8?B?N1ZnK3gxeTdhdHFIZWZoZjNLMytpZjNyeFFqVnZocGhrWHh5d2ZLQU1LVWVz?=
 =?utf-8?B?a1Q3bE9Fcm5HcFVTcklLSGVhNzhtdkMrUWhaeTRTL1Rrd2pHRkhweWRtRVdo?=
 =?utf-8?B?QnFCMGdEOXpsMkZKcUs4Vm9qVmc0dEFFUUcwR085NE9NZGVrcjdkRmdjelRT?=
 =?utf-8?B?Wkhmd2ZESjdXY1dzQTRxSnUzcERwOGN2QWtYWmVMOGtVei9xRHQ5UjV4QVgx?=
 =?utf-8?B?bTFxOE1Kak9oY09GTHJhY29MREdVNTJibk9XRHVkbzFuNUVJTXQxM0lqRCtq?=
 =?utf-8?B?N2JTdXpHRGR0WDgvN1A2Y0xmTG5TYkRvWjkveGtkM0M4OVJ2Q1d0SFJvRWxk?=
 =?utf-8?B?cHd4bDdLY1lXTTMzbzNOQ1dVOEtTRFViVU5YMHBHL0JjTTJ1cyt0RVFxNGNu?=
 =?utf-8?B?VWNzODdvT1BKVVIyVEtRTmoyY3lpUG9BK2F0VlpLck4zU0VPN3RuV1RPOGJa?=
 =?utf-8?B?S3ZqbTBYcFlicmE2THFRZDNrMjFnOG5iS2cwYjg0QTlZbkVCU0dVS0xXcEVL?=
 =?utf-8?B?RkFsWnEzcFp4MEhqazFZK0NpME8vaTBsRVZaZGxhMEY1NWs4aENXT0FKMmRo?=
 =?utf-8?B?Snh3WnI2SWxTb0FtRTdkV3pnSGg4RGtBOWllQWcyekk1R3l3RGd4VTNZMW5D?=
 =?utf-8?B?ejRubUxwQi93OXJEWk5vbFo2WGpPK2owbzNVbXJIeThPZzRPdUFJWDhGMzQ1?=
 =?utf-8?B?TEx6cnNOYWd0aUtBaHpyNlR0ZkhwZml0VGdPSGluTUtnd2pCUjFRcm1oL3Fo?=
 =?utf-8?B?d3NHYkJ1cXJZdkFvOGc3Q2t4aVVZdkRBeWk0WlJBaVhqdE5NTjhWT2IyNlEy?=
 =?utf-8?B?V0xING1vR0d4UnlpYWFIUlpQYmVRVUl1YmhMWTZvVDlYREYrUit1aUwwbXRQ?=
 =?utf-8?B?eVVuOTlpQzhnMG93N0RvWnRWV091dktvbUt5VHMvV0Z2MVFqUnNmengrNEZU?=
 =?utf-8?B?VlQ4c2VEQTRCOXJhNytRODRhZnpmWG9PL0JIUUFQbGlsT08vTm1IVmNtMlk3?=
 =?utf-8?B?NkxIMkEvY2V3NXR5V1B0YkhlckJFbUpQaGlqVTZJSzM0bXFZbEVRd3B6NVM2?=
 =?utf-8?B?RzBOVU8rbVAwRDRCVjRiTDQvaHRUdmZMcHJycExlRW9WMTNIdHNBZ0hMMEZu?=
 =?utf-8?B?MjFTODVQVEd4Sjd1eVBuVWRiSDRPbFpPL25UZUpUWVkyM1VBQkFmdEJUdDJ5?=
 =?utf-8?Q?LzvdPy1t1HamyT2YodNVf2l+8K7FtxDuMzfRnmB?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9d788bb-ebed-4060-127a-08d90b39c365
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 18:08:16.9794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CIF4drH56dL/NgTORbzgT9I9qC/itwWjhxSnSW1daxFYBpemT7V+r6XAK18olgGLD5XPm4qs4yLUJAMsCTIl5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2422
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9969 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104290116
X-Proofpoint-ORIG-GUID: tY_u5MJdPBc7dwHoS6qK_0MDqBcTEuUq
X-Proofpoint-GUID: tY_u5MJdPBc7dwHoS6qK_0MDqBcTEuUq
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9969 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 clxscore=1011 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104290116
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/29/21 10:14 AM, Andreas Gruenbacher wrote:

> Junxiao,
>
> On Tue, Apr 27, 2021 at 4:44 AM Junxiao Bi <junxiao.bi@oracle.com> wrote:
>> When doing truncate/fallocate for some filesytem like ocfs2, it
>> will zero some pages that are out of inode size and then later
>> update the inode size, so it needs this api to writeback eof
>> pages.
> is this in reaction to Jan's "[PATCH 0/12 v4] fs: Hole punch vs page
> cache filling races" patch set [*]? It doesn't look like the kind of
> patch Christoph would be happy with.

Thank you for pointing the patch set. I think that is fixing a different 
issue.

The issue here is when extending file size with fallocate/truncate, if 
the original inode size

is in the middle of the last cluster block(1M), eof part will be zeroed 
with buffer write first,

and then new inode size is updated, so there is a window that dirty 
pages is out of inode size,

if writeback is kicked in, block_write_full_page will drop all those eof 
pages.

I guess gfs2 has the similar issue?

I think it would be good to provide an api that allowed eof write back. 
If this is not good,

do you have any advise how to improve/fix it?

Thanks,

Junxiao.


>
> Thanks,
> Andreas
>
> [*] https://lore.kernel.org/linux-fsdevel/20210423171010.12-1-jack@suse.cz/
>
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
>> ---
>>   fs/buffer.c                 | 14 +++++++++++---
>>   include/linux/buffer_head.h |  3 +++
>>   2 files changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/buffer.c b/fs/buffer.c
>> index 0cb7ffd4977c..802f0bacdbde 100644
>> --- a/fs/buffer.c
>> +++ b/fs/buffer.c
>> @@ -1709,9 +1709,9 @@ static struct buffer_head *create_page_buffers(struct page *page, struct inode *
>>    * WB_SYNC_ALL, the writes are posted using REQ_SYNC; this
>>    * causes the writes to be flagged as synchronous writes.
>>    */
>> -int __block_write_full_page(struct inode *inode, struct page *page,
>> +int __block_write_full_page_eof(struct inode *inode, struct page *page,
>>                          get_block_t *get_block, struct writeback_control *wbc,
>> -                       bh_end_io_t *handler)
>> +                       bh_end_io_t *handler, bool eof_write)
>>   {
>>          int err;
>>          sector_t block;
>> @@ -1746,7 +1746,7 @@ int __block_write_full_page(struct inode *inode, struct page *page,
>>           * handle any aliases from the underlying blockdev's mapping.
>>           */
>>          do {
>> -               if (block > last_block) {
>> +               if (block > last_block && !eof_write) {
>>                          /*
>>                           * mapped buffers outside i_size will occur, because
>>                           * this page can be outside i_size when there is a
>> @@ -1871,6 +1871,14 @@ int __block_write_full_page(struct inode *inode, struct page *page,
>>          unlock_page(page);
>>          goto done;
>>   }
>> +EXPORT_SYMBOL(__block_write_full_page_eof);
>> +
>> +int __block_write_full_page(struct inode *inode, struct page *page,
>> +                       get_block_t *get_block, struct writeback_control *wbc,
>> +                       bh_end_io_t *handler)
>> +{
>> +       return __block_write_full_page_eof(inode, page, get_block, wbc, handler, false);
>> +}
>>   EXPORT_SYMBOL(__block_write_full_page);
>>
>>   /*
>> diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
>> index 6b47f94378c5..5da15a1ba15c 100644
>> --- a/include/linux/buffer_head.h
>> +++ b/include/linux/buffer_head.h
>> @@ -221,6 +221,9 @@ int block_write_full_page(struct page *page, get_block_t *get_block,
>>   int __block_write_full_page(struct inode *inode, struct page *page,
>>                          get_block_t *get_block, struct writeback_control *wbc,
>>                          bh_end_io_t *handler);
>> +int __block_write_full_page_eof(struct inode *inode, struct page *page,
>> +                       get_block_t *get_block, struct writeback_control *wbc,
>> +                       bh_end_io_t *handler, bool eof_write);
>>   int block_read_full_page(struct page*, get_block_t*);
>>   int block_is_partially_uptodate(struct page *page, unsigned long from,
>>                                  unsigned long count);
>> --
>> 2.24.3 (Apple Git-128)
>>
