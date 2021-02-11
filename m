Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85DB7319388
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Feb 2021 20:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhBKTzg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Feb 2021 14:55:36 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43450 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhBKTzV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Feb 2021 14:55:21 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11BJropw175229;
        Thu, 11 Feb 2021 19:54:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=jOF1sd+MlUM05lre0xeip1w/RGD5ELxJms0+QfLje1U=;
 b=okq6qnpCy/a+/nxyHIVzDmOBUyYpvz9EFG8PVwJNCbbNmL3dnBEz2PWobmPvjwWWKY/l
 fZpw0PgdwRkJq1ozEc1ffPF4fu7DiRztHOg8u5f1uw2k5L7PgI3cE0z3HeqlkRoX/bwm
 pa35dlBjC0MoEbvCJbCClzVWageuR0QQNXkQ/iwNvBi5XM12/X0hu3PzUttMi+GPi3J9
 j/jRR27m1DieQfa+8ti6tiSzt5C8Mha63hbdRwy5GGc1Gl+uFBke/qNSdvcX8H7o62DF
 JlHRGr/8jDF4ST68PEUdw/hihI6Joma1yef6uKrSnP4ZFr3fVyCXncYU6B1VT0vZ/gFK dA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 36hkrn8v1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 19:54:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11BJimxo061626;
        Thu, 11 Feb 2021 19:54:29 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by userp3020.oracle.com with ESMTP id 36j4vuqfbq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 19:54:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OaaOH1ZW5Ktnavs28ESvmaMGDB90VvqGZSBlHOmJJzrxziCAq8O0ZfvflLBJ6zSoEpflIaFGt/zIaCrFEm2NKthXOan7Qfc8lFpAELq+sO9opqFDK0pDaxQAicNRTERq59XnDR2FVE8Y4UGG21K3OM33Y+twvSIZSIoLkG+hmzJGfDsc482gjZgNVB1R3fQJAHIFpzbPGQ/K3/LCd+PkcXwHu6aE7bOvh4DAzkxirEMQFR/73TgYmex6nSKF2kPekAZmqIoCSn/uDAkMOkKF1U61DvqHd1vCga9BN5yUm1ufBv4bFU1GDMqODXOIAO1hghQ2356VMh+DIrJ/N7pxaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOF1sd+MlUM05lre0xeip1w/RGD5ELxJms0+QfLje1U=;
 b=FlUUeubP2aOTp6L+4NpJP1Alm64mdKP+Ih98NXmtq7zbPpGTkMw3/UZAJ07B+hPyNgpnKluMe1PzvtYmXZ14F+pjv7bWaoHMpXcjX5IaJ4Y4p6I24zBzworbtkCXzqki9GtayaYgZ2xx23Fy8LmaXVGZDHiXULjVuN4IpzDSR5BNBWVn8GZmYu4SxQ8k1LRe4ijMhpg14pPFe8XRyoYCNi16Ks1HDUm1VKxmBVwrVJWrXhIuOoxCbzGG9M17x82Oc9icUeV2xIapQWAHP84e2LgiIrsW5JvT21RhjPfANPbrT+/ITPqlQhPMdeConSOVugqQFbtvgAUEzQktRfeUwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOF1sd+MlUM05lre0xeip1w/RGD5ELxJms0+QfLje1U=;
 b=l0XVIuWdZB9V2CihMOWA/cp1qMOexLttRwWB4iClHl1r3nJBMA6G+EM6EMa1QDyJyitgJXEMkdL9646193kimnTEnzEoWGhTYW/9O9JnoLXWQMR2h5pjFs+eHFC8fZLOAhIGB3CnVXqN8hQHGK9c3EBrbEZ3lZFKZjmhDINBe1s=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BN7PR10MB2434.namprd10.prod.outlook.com (2603:10b6:406:c8::25)
 by BN8PR10MB3169.namprd10.prod.outlook.com (2603:10b6:408:c8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Thu, 11 Feb
 2021 19:54:26 +0000
Received: from BN7PR10MB2434.namprd10.prod.outlook.com
 ([fe80::20d8:7ca1:a6d5:be6b]) by BN7PR10MB2434.namprd10.prod.outlook.com
 ([fe80::20d8:7ca1:a6d5:be6b%3]) with mapi id 15.20.3846.026; Thu, 11 Feb 2021
 19:54:26 +0000
Subject: Re: [PATCH v2] vfs: generic_copy_file_checks should return EINVAL
 when source offset is beyond EOF
From:   dai.ngo@oracle.com
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20210201204952.74625-1-dai.ngo@oracle.com>
 <20210201211446.GA7187@magnolia>
 <7bc01c35-886b-05d4-3d0c-46cac378a61e@oracle.com>
Message-ID: <4ee45bae-4da5-e365-8bb3-933fab2df94a@oracle.com>
Date:   Thu, 11 Feb 2021 11:54:23 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
In-Reply-To: <7bc01c35-886b-05d4-3d0c-46cac378a61e@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: BYAPR08CA0017.namprd08.prod.outlook.com
 (2603:10b6:a03:100::30) To BN7PR10MB2434.namprd10.prod.outlook.com
 (2603:10b6:406:c8::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-154-140-11.vpn.oracle.com (72.219.112.78) by BYAPR08CA0017.namprd08.prod.outlook.com (2603:10b6:a03:100::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend Transport; Thu, 11 Feb 2021 19:54:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0cb4cd0-85a3-4f82-0aca-08d8cec6d617
X-MS-TrafficTypeDiagnostic: BN8PR10MB3169:
X-Microsoft-Antispam-PRVS: <BN8PR10MB316909822E6561C441E1817C878C9@BN8PR10MB3169.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DAykUU5SGTOJu1+b8Npokqg+iI+1WxKgtSel3wcGVxHRLQu9+/wRvysUEsMjvSOWzaENbPBj5QPzljNCODF5bXhTD1u+G1fxhTRk3Re06HJCJY8gjkP4eKew96JPtr32jILO6pMdoB2k3vaA+CPZ8WKEdIw2RC9NIGrL6lH/ECKv0Lg8JiMsVEi0nLYAdck0eBbuhNC8LBwsW5aaYZRTMzX3X/3PozfB+23SStBO+UqqN04wGetmJmum1oMb0fNFmTThtQa+6ZFZ9h40GaNZTg1bmnjLcqKvLs8heo8EnPUH0Am8mhiqHq9CxVLd9LuI1M0k09GBhoKHQPWCd3RdZcAX90EXPgwy9WCWRvuphP5lcbc/vTTyllydOmEStl44zsgV28eCMknbb3g4sQiFZkxRU/xOuUH6D1rIY36Z+zbwF6Ja9sNJhoG8ea3eIH3KQn8VexTvkNCMRRoQhm4zEblLxV8AFYZ9VulwWLUr0xmIn/hnGysWZeO+zjqYmTHy9GfGsTv/myqF/bQea+kYZU3WHJw8xbycdB0wT6RIUCqbvBHIOdoA/TH7YM/YnWUZ6PKFpIVNSX0HnO0fBCdkIGT+nwpSl+2U+BtuiiInDSIPzJyWIFqa/Qdwz6ex6BpEk3otNdYDUYL5J5Ed2i6liYh/aM5lPVmzZ5LrUtjBkMgA9QVASfoLmyQleLdRZ9EE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR10MB2434.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(396003)(346002)(39860400002)(186003)(31696002)(2616005)(5660300002)(16526019)(31686004)(2906002)(316002)(966005)(86362001)(8936002)(83380400001)(956004)(4326008)(6486002)(478600001)(66476007)(53546011)(66556008)(7696005)(8676002)(26005)(6916009)(36756003)(66946007)(9686003)(41533002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZkJHVXlWck40MlM4VGVPT2tUVXFaMEdHSnNFeW5HNXprWjFZOWhpZFh3WWtL?=
 =?utf-8?B?a29mL1kwYVl3RTh5WXhLWWsyUGJQVGZrdnB5bnI5Z2dBR29SSnpUaFFPbm1R?=
 =?utf-8?B?T2NBd2VJVzBicENSVHJKZGt5UXVUTGtucGN0YnFmOGQ5NGFMUzNLdE93bXZv?=
 =?utf-8?B?VlIyeTIzYXJnVWdiZ3B2Q2F2TUM1eXNiR1lFckF5UHZCTkljVFB2V05wWHJh?=
 =?utf-8?B?M0FIWUtFbGV4d2Rod1pPcHJQOFdKTDc1UXlrRW1rbjJ2K1QvelJZYk1ScWRh?=
 =?utf-8?B?dGEwc25JV1hoUUdFYThPWTc2ZzBIYitKQnFwWFlPUStxY0ZXcDNpdlpvLzE0?=
 =?utf-8?B?bDJJSjQyL3JKOWczNVl3QndnZVBpS1YxanNXTkFvdVlkc0NxSURycWxtb3Ez?=
 =?utf-8?B?UFppU0lYUFA5RG5MQmswZENoN0tUY2FOVy9PR3pkSG1OODNPUmpRaEx5cCtq?=
 =?utf-8?B?RkVobkhxYWRCb2s1SWt2ZGxwWFJ1MmN6cGJ4THY4RUY1TER3RmJvckpDRURs?=
 =?utf-8?B?RTJUN3czUzFiMUNKTmhvMVE4ZEJQVFVEdlRGZlUxd2dUL09lcklQQlpjU1dq?=
 =?utf-8?B?Y2hlR3J3V3M0d0dETEw4SUxBdTZoczhhYmMwak1LSm9TejlJUm1VWHIzM3VL?=
 =?utf-8?B?MGFqakh4dTUyWUd2cXMwMlJiQjNsQWhOMGdkdDRrSWJrU1BzSWtmSkc3R1hn?=
 =?utf-8?B?ODZobFcrVk93SllPQkxBNWFnblVwY0ZFU1hCUy9yR1pVMzd6anhIUmZJL05r?=
 =?utf-8?B?R214TUdaVlByT0xsNk5OcDFOVnZKNDdkZW9BWnRyeURFNjM1MU45MDRyUmtF?=
 =?utf-8?B?ZDNWdW45MkxEWkcyNjE0MkJJTm5EM1JVLzRrR3ltMldPcEVPMGpMVUJBdTQ3?=
 =?utf-8?B?QVRveGw3RmdOUWpYTW9Ca3MvUTl3K25Cd2VQcXpBZXhxVm93Rmo0UHZza0Y0?=
 =?utf-8?B?eU9vcThjUnNNK2dDS254a25wSVVRandnKys0NitoMThPdkRYRHVESHdudTI5?=
 =?utf-8?B?aE0xMWJoVXpSa1NKYml4cmc0eXZIMzZQdWhwd3VhQXBYZnBINmI1cHFDS2dC?=
 =?utf-8?B?VHQ5SkpmLy96VTJqWE4weVVGNFRzeEFKS0NlZ05ZUTBmNzJHR2RUc3RKVC9J?=
 =?utf-8?B?YUI4NVBpYlpNekh2Uk1PY2ZUOWZNZ3RKbHdnS3JYbUg3LzZYZ29VeUk2Qzl2?=
 =?utf-8?B?RFpiN1MrSU9reUpMenNXemRVekdqY0E2MXA4cHlIaTF4RVh6bTdtMUZwRUEr?=
 =?utf-8?B?ZWtFbzRzQjFWVjhkV1d3OHYySk1xZENBcm82Vm1ZZGJXQi9FQzdrbHFUSGd2?=
 =?utf-8?B?bmZZNXh6bWh1cVlNWE1KZGF0ZjZocDR1Y2xUS2I1L09IT3p5YUVvcWdwZ2J2?=
 =?utf-8?B?MUNqd1psbnVkNnZlWkJGaXhmM2dKdUNubEhVOTROcnlraDJ1VnAvS2QzNFBN?=
 =?utf-8?B?cVVWWlNiY0Vvb3BrRVorcUVTYjJnb2VDS05qbnN0Q1RmeVgxdDZDVmd5YlQ5?=
 =?utf-8?B?Zm5MY1UrbndhUyszaGpFakd6QVpJenBVK1dmYmY2bDZiNDY4c2tXYlVwZlFJ?=
 =?utf-8?B?ZW9YNkFUZmlVZDN5bmFZZFlLb2FObDVvTkkxMjhWZlhLdzdLdVprWmZSZFVr?=
 =?utf-8?B?SG1JajRBNjNpSVRFRjhTTExBazJIQjBYTkV0WkZxL0wwQjF6bE5wdE55UDhr?=
 =?utf-8?B?V0ZzZlAxOVRrRXMrMlJnM1FHRlIwNkkyd2szbnhVdWIwREN5UDJiMjNXbVcw?=
 =?utf-8?Q?ku8OoUI7XEQcQy4WHcmo1V4ApJ/cO0XH5ank/vQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0cb4cd0-85a3-4f82-0aca-08d8cec6d617
X-MS-Exchange-CrossTenant-AuthSource: BN7PR10MB2434.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 19:54:26.6764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nMr3rjZkVcySPrkQW8nGdxN/LiRv2FMxsI5vGO9c+J9+Ni2jdzd04MF06F9G4/B2O41cHjyv8BMD332Ec8EsWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3169
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9892 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102110155
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9892 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102110156
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Darrick,

My man page was out-of-date. The latest man page of coy_file_range is more clear:

This EINVAL was removed:

        EINVAL Requested range extends beyond the end of the source file; or the flags argument is not 0.

and replaced with this:
         
*EINVAL *The/flags/  argument is not 0

Thanks,
-Dai

On 2/1/21 1:51 PM, dai.ngo@oracle.com wrote:
>
> On 2/1/21 1:14 PM, Darrick J. Wong wrote:
>> On Mon, Feb 01, 2021 at 03:49:52PM -0500, Dai Ngo wrote:
>>> Fix by returning -EINVAL instead of 0, per man page of copy_file_range,
>> Huh?  That's not what the manpage[1] says:
>>
>> RETURN VALUE
>>         Upon successful completion, copy_file_range() will return the
>> number of bytes copied between files.  This could be less than the
>> length originally requested.  If the file offset of fd_in is at or past
>> the end of file, no bytes are copied, and copy_file_range() returns
>> zero.
>
> In the ERROR section:
>
> ERROR
>     EINVAL Requested range extends beyond the end of the source file; 
> or the flags argument is not 0.
>
> -Dai
>
>>
>> --D
>>
>> [1] 
>> https://urldefense.com/v3/__https://man7.org/linux/man-pages/man2/copy_file_range.2.html*RETURN_VALUE__;Iw!!GqivPVa7Brio!N8XGLyK9dUTWOYWmb3NCuq-9kL-tX8OGcq-sV7M53ub5KMgr7e93a2B8eUryKw$
>>
>>> when the requested range extends beyond the end of the source file.
>>> Problem was discovered by subtest inter11 of nfstest_ssc.
>>>
>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>> ---
>>>   fs/read_write.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/read_write.c b/fs/read_write.c
>>> index 75f764b43418..438c00910716 100644
>>> --- a/fs/read_write.c
>>> +++ b/fs/read_write.c
>>> @@ -1445,7 +1445,7 @@ static int generic_copy_file_checks(struct 
>>> file *file_in, loff_t pos_in,
>>>       /* Shorten the copy to EOF */
>>>       size_in = i_size_read(inode_in);
>>>       if (pos_in >= size_in)
>>> -        count = 0;
>>> +        count = -EINVAL;
>>>       else
>>>           count = min(count, size_in - (uint64_t)pos_in);
>>>   --
>>> 2.9.5
>>>
