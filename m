Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B30841FC026
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jun 2020 22:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgFPUlE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jun 2020 16:41:04 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34364 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726464AbgFPUlD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jun 2020 16:41:03 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 05GKegHa004352;
        Tue, 16 Jun 2020 13:40:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=r9iR/Z+s6iv91NrQf4m3Zpjz9qMXVHMl0Yv2cbninHg=;
 b=inn1lpkdDQ7mt8Qfb6WH+IsdmAUJcq87H4f1YY7CLvRhElyjJ3U/T7vbaYHAiYThE1Aj
 M9irHTtf6SbCrKDg8/iQ98zX+MYyT92y9vXa/kBCorzicWfn17+lUD8qygJTQ8RoziaU
 FUD4WH3X55qfndqZ3Me6vyawM11HTzz6w/0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 31pv0htudw-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 16 Jun 2020 13:40:43 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 16 Jun 2020 13:40:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FwUGPLfV0IJne6QhZ6D+axkZo/OjAwvRqFHU6BtFqELPKLC3ixdLLgECBQrY0JxN2OJ+WOCQHaChjXmj1kEo6ef5NQx6gCgbNSmontu7ANRtmxtsOtLFM+UX+o+X4Kz4htTNEFrU0cIE0oXLp1O4ExB12UDRoNIx+8jO+8JYbVQ7WvjN9ieWTBUuu2sDy+1B3VwyU+pbh49yy9YHAb6w4pGRn1V92pxr1bQWHpy9UApnOQAjF9ejFWxz83f0C5Q2jDr5V8vx/fqrn7hggwbk6tuVbGYZRc0MgKujWxBRUev93/5MuTuc76xKmAXHHiAYt8tX0A/15Ov1j5m9HOt3YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9iR/Z+s6iv91NrQf4m3Zpjz9qMXVHMl0Yv2cbninHg=;
 b=dgAF7+tM/xX6qbpgJPbavOeTHBWyNYMDLSWwsAPaOLPrmAMnzQIA1NolXVlZrA3NVa2CGYieLaoqiZzQN14jdH9pZhBNrnPl0xmSDnRC+1M3t8PaLv+mW68hcv/ER0lXf2r15BDq1Sj8DE75IgnQ3fLmhVVNWhLcdPERYXHXue3xTSBV6jEPKizMvh5MrFa3sPw1+A1tc/y0BdoP8xxGfgTP3h5Xwz4MsxrpfIUIIUgYNVlPadO8pGuakCpy/fsrGQ+eBx2mgsZ6Q1AK9EarqsgZQHulzydlj2jCT0Jzt4ui8hs6KQtDRcRfsKCH6XF6Z9ggS8kWQTQ2UAku24uGFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9iR/Z+s6iv91NrQf4m3Zpjz9qMXVHMl0Yv2cbninHg=;
 b=Z3EM5dUr89raYey+wKYHEHOyPXPwlmdDqzlHQYrduMI66aaNTxjbRpzYCpI0ZiCt9o95d3df7LlLuYArMwh42XOApBP4vaAFUn4v0FQQZrrd5o1CU1/ZNZM1m+f/x8YQaWcARdMZMUN0SXKf6uNyezXtLaN3Hf1xhV9wWJb4/Rw=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2997.namprd15.prod.outlook.com (2603:10b6:a03:b0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.25; Tue, 16 Jun
 2020 20:40:28 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301%7]) with mapi id 15.20.3088.028; Tue, 16 Jun 2020
 20:40:28 +0000
Subject: Re: [PATCH bpf-next 4/4] bpf: Add selftests for local_storage
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>
CC:     open list <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Martin KaFai Lau <kafai@fb.com>,
        Florent Revest <revest@chromium.org>
References: <20200526163336.63653-1-kpsingh@chromium.org>
 <20200526163336.63653-5-kpsingh@chromium.org>
 <CAEf4BzY0=Hh3O6qeD=2sMWpQRpHpizxH+nEA0hD0khPf3VAbhA@mail.gmail.com>
 <20200616155433.GA11971@google.com>
 <CAEf4BzZm86BQqhfVHfm7aKvwK-UXC7679DsJe8xQqYR8eUUwAQ@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <eb5e9c81-237a-d2d0-6bc6-26b1d5590a00@fb.com>
Date:   Tue, 16 Jun 2020 13:40:26 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <CAEf4BzZm86BQqhfVHfm7aKvwK-UXC7679DsJe8xQqYR8eUUwAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BYAPR05CA0079.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::20) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::1860] (2620:10d:c090:400::5:4028) by BYAPR05CA0079.namprd05.prod.outlook.com (2603:10b6:a03:e0::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.9 via Frontend Transport; Tue, 16 Jun 2020 20:40:27 +0000
X-Originating-IP: [2620:10d:c090:400::5:4028]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba335b5b-cc20-4e3a-21e5-08d812358136
X-MS-TrafficTypeDiagnostic: BYAPR15MB2997:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB299701A78D322DA805A951D5D39D0@BYAPR15MB2997.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 04362AC73B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fpsbbe8zCOnmcy00roWWWiMQYHyLWKO+jMCWNPJIl+xb7ZN9QP6y2GKzsX6Nl8lBOvzGLlxivgshwWIPGEoKfKmv+ZBdmY0NS7EGZZOogeq/Ywo3cN/vI1n1ISERf5Mj6xv5Cj1TOIjVs77CNzRfh/4RkSj2lobLWi4fTFlzHq6rCCGQ/1CvPySvqBKpQI0zHpma3Scz0DVqFfq7E8oMBF8zsOcZ06HrA0WCCZiep1aIqQtfk51x7kflt9Wxan3C7Ed47Hx1wu5Fwvan5wS9fH65EaWhjt7myG2hCZvbtod2hoMQ46u7qhiVi/H95KERb+8+ZrNjHgN92o/OlvWrkXOgNHJhjI+Cu05SyhaehU9WaB8BooMrNty8LK8rZL0y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(6486002)(83380400001)(7416002)(16526019)(8676002)(498600001)(8936002)(110136005)(54906003)(31686004)(186003)(4326008)(52116002)(31696002)(53546011)(2616005)(86362001)(66946007)(2906002)(66476007)(36756003)(66556008)(5660300002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: UtoKOjmnH1Z7GHQkBAnZO2RqFsEbz9ovUvExCMFZ1/MXZcDqHz+sMP1QHjufm0X/x9tWhkqUBdOGn7lVZLfqWWjlvRFZevMqfH2X4yNL9SLkqKr9EpwjKQUb/tRWppd6zCX/1LvcDx7bPn4cjgPIKUrpeXvcOJdnIVU+tvi4HJDbnjuzlzMxu2FccNFCbs4+gyMoe2JAvPLtIx07iKaDypYwNlI/0gFPTvgU2VYG/EjscN6k1Ikuax1qdXa5RbPvBwiYPr9k3eHU61JoAwM1LOIGIti6cP7kcNcbQtvioRCv8hGM4tUmqZnAV1LhfLrNE37yT5d8/mKFt65p1iImhNrbCjg7L69FJvTx0otORcG7eJhe09HaReY/2Wtjoqh5pJQByxxmUnbPsSOPk6yBKtno2TOtlmiBuj/H+Rh90mwZxJHI+0rmKkHwKCWOlaK7tuPGSEHW+cW/pDfC/Yhzv/yXjAneSMn+3Uew+Jznn1zVAqAuu9xzIwlHIcD2IWuJyuAMHasuS0l0O/qAR57NiA==
X-MS-Exchange-CrossTenant-Network-Message-Id: ba335b5b-cc20-4e3a-21e5-08d812358136
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2020 20:40:28.6418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GFoiah6/hnmi8QJ00CrnoTvDVhJquwa/volfvbgUJh6CdufPcMp3mYF786ndWJCW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2997
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-16_13:2020-06-16,2020-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 priorityscore=1501 clxscore=1011 malwarescore=0 adultscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 cotscore=-2147483648
 lowpriorityscore=0 mlxscore=0 impostorscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006160144
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 6/16/20 12:25 PM, Andrii Nakryiko wrote:
> On Tue, Jun 16, 2020 at 8:54 AM KP Singh <kpsingh@chromium.org> wrote:
>> On 01-Jun 13:29, Andrii Nakryiko wrote:
>>> On Tue, May 26, 2020 at 9:34 AM KP Singh <kpsingh@chromium.org> wrote:
>>>> From: KP Singh <kpsingh@google.com>
>>>>
>>>> inode_local_storage:
>>>>
>>>> * Hook to the file_open and inode_unlink LSM hooks.
>>>> * Create and unlink a temporary file.
>>>> * Store some information in the inode's bpf_local_storage during
>>>>    file_open.
>>>> * Verify that this information exists when the file is unlinked.
>>>>
>>>> sk_local_storage:
>>>>
>>>> * Hook to the socket_post_create and socket_bind LSM hooks.
>>>> * Open and bind a socket and set the sk_storage in the
>>>>    socket_post_create hook using the start_server helper.
>>>> * Verify if the information is set in the socket_bind hook.
>>>>
>>>> Signed-off-by: KP Singh <kpsingh@google.com>
>>>> ---
>>>>   .../bpf/prog_tests/test_local_storage.c       |  60 ++++++++
>>>>   .../selftests/bpf/progs/local_storage.c       | 139 ++++++++++++++++++
>>>>   2 files changed, 199 insertions(+)
>>>>   create mode 100644 tools/testing/selftests/bpf/prog_tests/test_local_storage.c
>>>>   create mode 100644 tools/testing/selftests/bpf/progs/local_storage.c
>>>>
>>> [...]
>>>
>>>> +struct dummy_storage {
>>>> +       __u32 value;
>>>> +};
>>>> +
>>>> +struct {
>>>> +       __uint(type, BPF_MAP_TYPE_INODE_STORAGE);
>>>> +       __uint(map_flags, BPF_F_NO_PREALLOC);
>>>> +       __type(key, int);
>>>> +       __type(value, struct dummy_storage);
>>>> +} inode_storage_map SEC(".maps");
>>>> +
>>>> +struct {
>>>> +       __uint(type, BPF_MAP_TYPE_SK_STORAGE);
>>>> +       __uint(map_flags, BPF_F_NO_PREALLOC | BPF_F_CLONE);
>>>> +       __type(key, int);
>>>> +       __type(value, struct dummy_storage);
>>>> +} sk_storage_map SEC(".maps");
>>>> +
>>>> +/* Using vmlinux.h causes the generated BTF to be so big that the object
>>>> + * load fails at btf__load.
>>>> + */
>>> That's first time I hear about such issue. Do you have an error log
>>> from verifier?
>> Here's what I get when I do the following change.
>>
>> --- a/tools/testing/selftests/bpf/progs/local_storage.c
>> +++ b/tools/testing/selftests/bpf/progs/local_storage.c
>> @@ -4,8 +4,8 @@
>>    * Copyright 2020 Google LLC.
>>    */
>>
>> +#include "vmlinux.h"
>>   #include <errno.h>
>> -#include <linux/bpf.h>
>>   #include <stdbool.h>
>>   #include <bpf/bpf_helpers.h>
>>   #include <bpf/bpf_tracing.h>
>> @@ -37,24 +37,6 @@ struct {
>>          __type(value, struct dummy_storage);
>>   } sk_storage_map SEC(".maps");
>>
>> -/* Using vmlinux.h causes the generated BTF to be so big that the object
>> - * load fails at btf__load.
>> - */
>> -struct sock {} __attribute__((preserve_access_index));
>> -struct sockaddr {} __attribute__((preserve_access_index));
>> -struct socket {
>> -       struct sock *sk;
>> -} __attribute__((preserve_access_index));
>> -
>> -struct inode {} __attribute__((preserve_access_index));
>> -struct dentry {
>> -       struct inode *d_inode;
>> -} __attribute__((preserve_access_index));
>> -struct file {
>> -       struct inode *f_inode;
>> -} __attribute__((preserve_access_index));
>>
>> ./test_progs -t test_local_storage
>> libbpf: Error loading BTF: Invalid argument(22)
>> libbpf: magic: 0xeb9f
>> version: 1
>> flags: 0x0
>> hdr_len: 24
>> type_off: 0
>> type_len: 4488
>> str_off: 4488
>> str_len: 3012
>> btf_total_size: 7524
>>
>> [1] STRUCT (anon) size=32 vlen=4
>>          type type_id=2 bits_offset=0
>>          map_flags type_id=6 bits_offset=64
>>          key type_id=8 bits_offset=128
>>          value type_id=9 bits_offset=192
>> [2] PTR (anon) type_id=4
>> [3] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
>> [4] ARRAY (anon) type_id=3 index_type_id=5 nr_elems=28
>> [5] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
>> [6] PTR (anon) type_id=7
>> [7] ARRAY (anon) type_id=3 index_type_id=5 nr_elems=1
>> [8] PTR (anon) type_id=3
>> [9] PTR (anon) type_id=10
>> [10] STRUCT dummy_storage size=4 vlen=1
>>          value type_id=11 bits_offset=0
>> [11] TYPEDEF __u32 type_id=12
>>
>>    [... More BTF Dump ...]
>>
>> [91] TYPEDEF wait_queue_head_t type_id=175
>>
>>    [... More BTF Dump ...]
>>
>> [173] FWD super_block struct
>> [174] FWD vfsmount struct
>> [175] FWD wait_queue_head struct
>> [106] STRUCT socket_wq size=128 vlen=4
>>          wait type_id=91 bits_offset=0 Invalid member
>>
>> libbpf: Error loading .BTF into kernel: -22.
>> libbpf: map 'inode_storage_map': failed to create: Invalid argument(-22)
>> libbpf: failed to load object 'local_storage'
>> libbpf: failed to load BPF skeleton 'local_storage': -22
>> test_test_local_storage:FAIL:skel_load lsm skeleton failed
>> #81 test_local_storage:FAIL
>>
>> The failiure is in:
>>
>> [106] STRUCT socket_wq size=128 vlen=4
>>          wait type_id=91 bits_offset=0 Invalid member
>>
>>> Clang is smart enough to trim down used types to only those that are
>>> actually necessary, so too big BTF shouldn't be a thing. But let's try
>>> to dig into this and fix whatever issue it is, before giving up :)
>>>
>> I was wrong about the size being an issue. The verifier thinks the BTF
>> is invalid and more specificially it thinks that the socket_wq's
>> member with type_id=91, i.e. typedef wait_queue_head_t is invalid. Am
>> I missing some toolchain patches?
>>
> It is invalid BTF in the sense that we have a struct, embedding a
> struct, which is only defined as a forward declaration. There is not
> enough information and such situation would have caused compilation
> error, because it's impossible to determine the size of the outer
> struct.
>
> Yonghong, it seems like Clang is pruning types too aggressively here?
> We should keep types that are embedded, even if they are not used
> directly by user code. Could you please take a look?

Sure. Will take a look shortly.

>
>
>
>> - KP
>>
>>
>>>> +struct sock {} __attribute__((preserve_access_index));
>>>> +struct sockaddr {} __attribute__((preserve_access_index));
>>>> +struct socket {
>>>> +       struct sock *sk;
>>>> +} __attribute__((preserve_access_index));
>>>> +
>>>> +struct inode {} __attribute__((preserve_access_index));
>>>> +struct dentry {
>>>> +       struct inode *d_inode;
>>>> +} __attribute__((preserve_access_index));
>>>> +struct file {
>>>> +       struct inode *f_inode;
>>>> +} __attribute__((preserve_access_index));
>>>> +
>>>> +
>>> [...]
