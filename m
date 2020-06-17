Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904C01FD54E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jun 2020 21:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgFQTTr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 15:19:47 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:16452 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726496AbgFQTTq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 15:19:46 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05HJFckO027427;
        Wed, 17 Jun 2020 12:19:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=7IHBJ8bo0Lb9HdCOSNE1XgJyQ54ZtZiACmOwbh1FZTw=;
 b=Yxp4zBEFFpT4I5W0usNkghcPTSJ2skQ4QuHCJ5a9ZGESALFxZk2LoRs2fuBpDocWX8WN
 WMCw0FbJCW7C+gETRDtLaY5ieX9wUTzxTyJ75s45xkm8QS+Ze4/JDBM9/5MmOg3cHD5o
 QkIe+7niPtJPTQMfCSDrA/DyiIraPN9vTdk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31q660qex7-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 17 Jun 2020 12:19:30 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 17 Jun 2020 12:19:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jt3Ukts9ApPWWChx0Hxn8ZXv2Qsb+Is1iuHX8m6EmGqvbc6Tiwok3NkJmV3QqYubczMtW6eOVQXL1yn+51mJNvNPIHKOkVffji7vUZ0QOUpctTrMMwlhVv8iVwwRo2xgNwI+ipnzIcQtqcfWtgVXTUdDyycNJdCLvOTB/unGQTwAApZYA4A8ZrO1Li2cyWovlNGbIm98lgE/o44HwfQDcAwp70NVyiAGKtoOFA6NydVXLFcozNJFia8egfQp9Cp/Nb9PHPj2n4ESFMmOglXMP/EZLdL61/OAAeepODjWcV8sZPsAY4Q/DwYZUaQeYAlf3aeUKYo94oL64MDMgMfiuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IHBJ8bo0Lb9HdCOSNE1XgJyQ54ZtZiACmOwbh1FZTw=;
 b=RNTa1LaBlO0Kt1Xo9wMPH0VCTYDEKb6izHEOdV0D+52IhEW2a64fAT36Jnv9zNIflaT92hXZugqKMxUx5cG0CJhHJ8MXSVKN3XCIUoUhuuEZ0lDUzdIhPN1EDDjcIv+E4JP0goAVzBj+qQRBtTaFDV/BFuymhHQDCm09RA6AriAjCIqXXbiq0KXT36Pp3DI8bi9zP/ZFgxmDvjFJ5eb3JNiVjSdaeaob1bvH2W3FZEN5XleJtLQbHXIwtakMjpYQ8ziXdT0JwWinaPXSs4XdPpBxPLXyt9lvIs/X1pWgAbxXDA/8Cm4xYQLmLRIE9W+LLGvilmzQ4pPw8fzZ8kT6aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IHBJ8bo0Lb9HdCOSNE1XgJyQ54ZtZiACmOwbh1FZTw=;
 b=LaaoFWBcutGJ7i7oRsOZmlsADzrMNy+kjIPKL+dHMG5q+74cAKbRGOOzyE9tk7ku4KBR6B/kj0lrz7vLaCFqSsp3/TFrrJlnM/hEedlJU4dQ8XHCQtY9QbmwvmdUXeE5AjGhYy/lDaW9Eplo38IgpxOwQxy3nnZgOeq9lTAX51E=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2488.namprd15.prod.outlook.com (2603:10b6:a02:90::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Wed, 17 Jun
 2020 19:19:24 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301%7]) with mapi id 15.20.3109.021; Wed, 17 Jun 2020
 19:19:24 +0000
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
Message-ID: <7ecf2765-614c-8576-af2c-b4d354e0ffbf@fb.com>
Date:   Wed, 17 Jun 2020 12:19:20 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <CAEf4BzZm86BQqhfVHfm7aKvwK-UXC7679DsJe8xQqYR8eUUwAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BYAPR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::36) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::1860] (2620:10d:c090:400::5:a77c) by BYAPR07CA0023.namprd07.prod.outlook.com (2603:10b6:a02:bc::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Wed, 17 Jun 2020 19:19:22 +0000
X-Originating-IP: [2620:10d:c090:400::5:a77c]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0403b0f3-1d73-41a7-ec95-08d812f35836
X-MS-TrafficTypeDiagnostic: BYAPR15MB2488:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2488CDC1702A31EFECD0BED8D39A0@BYAPR15MB2488.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 04371797A5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oZkO0eRhv95B0htD627+MEFYBLy2Xo+pdPkh5FQDn5U8vDjVQ3eyolFM+/Pl01Ha1qtzacArnUQ1IGobsjivlYxpNPcWs3cZ2hAorPu6OJ3BrpSN/FzOfls9GPP7BElTBfk8agQR6p0yNg1nAqSGqg//yKFZUeXw2wjWPfvitVCWSXqXY1RgeuYur9ximABen9aQngLxJ3a05A7vmHuzOyNZ8t3vihO2n6i0EYQiqAzhHhuN0cpJvCA71t/Oz2pWdMysV7aGz9fn3rEXL9YVtMhQgW+PJD86lnhTX680TmkZcgR7w9RwBk0WfebXGb54ZaBUzHfBQWx4/vEBsP0CbFtIL53eNIZczPqPAkJiZQjbF5VIqW8Gk1KXL8e5yuzj02KRlZmiacVW/DuBqphDyzFSVFkTirdiSJfLlOuQe3s79ja0JnJkltS8qpcejRUXjjBHFGNPKUBxf7LWnm3c1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(39860400002)(136003)(366004)(396003)(376002)(2906002)(966005)(83380400001)(31686004)(478600001)(52116002)(6486002)(8936002)(110136005)(8676002)(54906003)(316002)(186003)(16526019)(53546011)(4326008)(2616005)(86362001)(66556008)(66946007)(66476007)(5660300002)(31696002)(7416002)(36756003)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 0QtHuhTWCf1RPCAsKtM6zS3c/vKpKD7ern8sijAK2z7Qa1wpcETH4EJ1eJHR+Q9YnDkji+d4QzPY6dDZ6O88PefQ5RlFEf+FNALq0p4vxiE9jJ4MlWSm8pGnD4ZCQoRRH8KO0OaJrPmMOqiIuc1bjMYfR1Z+JyQpzTL4/8dOMmA50S5amLA8lkhaHLfTJg+WKUsrmnuSyc0zMd9jNO4hJsqqIhTCf9tzwYsfscQam9Ilk6HOFYzHeUlth/Y1vYYBYiBkjxOrT2OqOW0VgFbWFnRpY/R/h9qfpSc9YLG+BhD6VCQA+4XxokUIYfMFhvAMftNl5LZftWCj3aiOwGHBbU9Qgj0SJP36RVEFWLE6ggr8Fo/nXtut75nA7almpiFQYPc/Sc+flShZEaRZH346qR5XtTXDKMYXQuEc9cIrW4vN+vqTe7VyrCjWQufnUtan7eCQ8LS7WLf948NAJBcSqhPBsO1Ft25cEyn6Bzd9ylRfqxfl/bCkwCeByslFhNB46z3UNnBYW625Shlc1Vy8Gg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0403b0f3-1d73-41a7-ec95-08d812f35836
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2020 19:19:24.0781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S52ODcG0/LUyf9uKhFzxgX/oFJVi8FJppmqdwP1jtOmxG6iIuwPXpjF5VMFtnmu3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2488
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-17_10:2020-06-17,2020-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 clxscore=1015 mlxscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 impostorscore=0 malwarescore=0
 cotscore=-2147483648 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006170146
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

Yes, this is a llvm bug. The proposed patch is here.

https://reviews.llvm.org/D82041

Will merge into llvm 11 trunk after the review. Not sure

whether we can get it into llvm 10.0.1 or not as its release

date is also very close.


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
