Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE1AA41A8BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 08:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238948AbhI1GYn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 02:24:43 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:4046 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234207AbhI1GYn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 02:24:43 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18S5Lhs9011484;
        Tue, 28 Sep 2021 06:23:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=tYeKp2kQTktGqCz/sM3t/8D7g5AHV/VIHrPHytQluU0=;
 b=xNViB2zWTFkIrHa3XiRT3WkYbowZM/aM/ImrQPZAfH+WuNYCfaCysPNtGDkJKaAfIkLH
 vb5RkF2Q/4PRZU+oL4+i/uTFKhAtqPJA5w9f0wsKQPuTipo7kdTrZ7/7ONpfkPQ5sC7j
 89wxypjXKcaJmo4Oq8NWt4K4H3M0HTbLkxnmKPR1Awrk4grp2BZ+Xf5SnXO965QP/0pb
 6mrfdDnOUREmqwiPlKL0pTetPgJi3LplcKVj+dzZ0UORKkUuccHsevQhRKNq57+wVnCj
 KbC4hQyFZIel4BLv9hlmF1QJZ9vhbi4xzQzkY2dFde6naieaAAgcY9jd4mrFigQn703f GQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bbh6nmmnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Sep 2021 06:23:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18S69ucN003355;
        Tue, 28 Sep 2021 06:23:01 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by userp3030.oracle.com with ESMTP id 3b9rvuuqwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Sep 2021 06:23:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pqab5DNN1Uos77Gkyb0ptaF870/vRRKlgPG1fo42rMFfBqlClcG0vZv3m0R2HgWtA+dLil4rNcLryzq5YIhQBAUGkgXNqsddkSIvsV36LFHOv1H4pHDkipADSARjDzUOg2HLer1srBp4noY55dX8Gso8Ox26B52sVftvzQy+lUqYYnkjq6Io2A3PJf5HRAU4BQTsfhnDqNN/oKqPdSOVWhmoUaPoSX/j+dQ3urO/0ll3+aNHnHVXVTf6S71qEKPNp8Iycz3iTY81rn/4KTsJhc+nfdVRO5y5nh0bvp9mu4GN3luAzPxWy3NmTSAt+VxV4y9m1ji13uOaiOvnuds5zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=tYeKp2kQTktGqCz/sM3t/8D7g5AHV/VIHrPHytQluU0=;
 b=CcIqPlpOMpHaLYvIjIf3anxkhPGyI+wFZeUrwwj9goOCtW4zDcNm5H/luSRmickdtxtAHCXktt9rBkvBK52GTWnB2sz/R45moHCgesGBbmWN+6d+GotujMTt02JOifpHG9VEpiQMQeUxOcVLLqLDHUP3V4Ps/H3Pffh1Nyqwy/GOMJC3sAzaS093mzLvupTzAKmypmlw/UBeyrfrL9Hb36A0/MumKdXQpZSRWzThfAVyel3nD9jFL3UvdYxndL5AXvRcHmSDKUb4+/GS9ZhpQl+FTEdJGQ+GIBNGtcSdhNsie418o4uPwquojCScN1AUopWG8YNdRU8atVppbol0WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYeKp2kQTktGqCz/sM3t/8D7g5AHV/VIHrPHytQluU0=;
 b=Y5REdVJ/lkA7nN4pYaixdESYT6RSX7wks6Nd7ygXA1svhlt/NFX212XIMxMzcHePv9zA3jfmLeJ07fJ4HxrXLuOP/lGPx9DRsMYXGJjDZHstdIhhqEWRfz4w5xpKu9Lq0CB+RRxZjkHOJdzlUkL7ikS9d2TJOzK+wA8QR9q4hJo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ0PR10MB4656.namprd10.prod.outlook.com (2603:10b6:a03:2d1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 28 Sep
 2021 06:22:59 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::1c92:fda3:604:a90d]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::1c92:fda3:604:a90d%7]) with mapi id 15.20.4544.022; Tue, 28 Sep 2021
 06:22:59 +0000
Subject: Re: [PATCH RFC v4 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20210924205252.82502-1-dai.ngo@oracle.com>
 <20210927201433.GA1704@fieldses.org> <20210927203952.GB1704@fieldses.org>
From:   dai.ngo@oracle.com
Message-ID: <4f5cdc04-9584-282c-8add-4b0c1e313f1b@oracle.com>
Date:   Mon, 27 Sep 2021 23:22:54 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <20210927203952.GB1704@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SA9PR10CA0002.namprd10.prod.outlook.com
 (2603:10b6:806:a7::7) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
Received: from dhcp-10-65-151-114.vpn.oracle.com (138.3.200.50) by SA9PR10CA0002.namprd10.prod.outlook.com (2603:10b6:806:a7::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 06:22:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 488fdc89-c5d8-4b2c-6f62-08d982486ace
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4656:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB46567E883CF57EEB2587DEC287A89@SJ0PR10MB4656.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RSyOLcuZ3x8ukiaiA2CuNIvFrQC679JUpDFzo1wCaASwldwDdrd+PwWYzgtmKFiW5irGnA+YKymqEnNMhMwzR+L7hHEvQUQPOo+JcdkGWlU1aAyQFPdv3NxhxkqtNsZdBp/7s0nG9ys6m6UmubKfTKud3VPp0W9LAyL9SrYE1kmvaCfFOy/NQ5k5hay4adhUMSkcknwwjYrBowoXa4lPwkhS840CTAnZOadDqjdE7SPQlfZUE5QqO53ShYQBaQ4HuLlQvP9pyLlJGEGhUzsrpdlh/Te1OXP+kkvIErgoOvecJKqn2gdpwAfHTAbTswaiIC1s1pLOwcRjG0wc3kildz7+H6uusTP5UPWTmfqbzFqEMXYhLhyE9krNodXady5m4eIKVyDHUF88k0XxDPBzDKkcLeFw3dfbs5vjeGtq/vC+Mm1zYz+cc2Uv1MwLZNlUh8dbOW3itmRIofUOe6in9yHi///YgABO91P/yEGXkxQMZOgZiORrGNLwP9O7btXOdsP8IZ2nBbwp+uzORtE7p1knVwbb0rI5V5wE8X2Ovye89XpKmBpfLakTpCsY1frzUUGetwBFM8mm3un/XBWjdhhqaNxFP/b1Yq60ntS/t94EMEw0nAFeA5qzrvWyEHv2rF6e2G4dFkvP+9nw2KuH4Fe8tjTy1x4aLFTeHe74XfATnkbM1u7hMV2zkuzaTL6ZJACX72Vbd7wIuQDJsbDUCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31686004)(4326008)(86362001)(316002)(38100700002)(508600001)(31696002)(66946007)(6916009)(9686003)(66556008)(2906002)(8936002)(66476007)(186003)(7696005)(956004)(30864003)(2616005)(8676002)(83380400001)(6486002)(6666004)(36756003)(26005)(5660300002)(53546011)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUN0MUVwTS9WK096QzZ6UXovaktCQVBQY1JTVXFONWM0KzlKZGpiblRMSDQv?=
 =?utf-8?B?V01PcjkyUy9HZVRkOWlNOUYrbkhZOXFsY1ZZNEQzVXdzZ0h4cFpERkk0MjJ4?=
 =?utf-8?B?ckNteWpqVmp1TERGY1k3RXZFSThSRVFuYUFtTU4rU1R0U3ZQcWhqSThmd25q?=
 =?utf-8?B?ZXIySlBQeEpkcFQvVyt6aThkQ0kxWjloVEZ2b0hlUUV5ckdjVUFqandDQXVV?=
 =?utf-8?B?blhmRnBiMm8rdDBKUGE4bk1LRFVWbzg5RmpNalljdkpQNnA0WEU2NVB3Vzk0?=
 =?utf-8?B?NzNOVm9Zdk5KS2RtZ1VQVXY4cUp2QkdzWjJ1MmVZUmdGOEFwM1VDUm1DZXFZ?=
 =?utf-8?B?VWpkMWlNcHY0RzliSlFONnZUa1M3UVhTRStvMmFsY3FSSGpVclNJcjE3d1p6?=
 =?utf-8?B?dGhDeU1iZmVSYUx6ZDdnTkEzcWpaVjVIK2tLN29va0ZmY1dUZFE3U2lGelpi?=
 =?utf-8?B?Qnljckxra2MwUFRHLy9oUFBud0h4WlUrLzQvaVJVZWVCcURkbUxMUXVqMlhw?=
 =?utf-8?B?S2JYMnphckdRRkxTbitFTzNLMXZWa3czZE9kMzRrZU5jdEdORStXbXg2LzFX?=
 =?utf-8?B?ZnFuT0Q5ZlgzczZQRHp5aWxzVmxoWGwvMXZZWmNsalVRbElzbkRJQUNjMUwx?=
 =?utf-8?B?eVVRUU5iQmI4SFE4QjZ4c29MRitpZ2tMb3FEYW0yL0pKZlFlWG15SVJkK0Ra?=
 =?utf-8?B?NW42a21SdGh0MWtiSXJOYzNQc1Z2TE56Y2h2Q2NJSmdQRHM4QnNXVGxhSkla?=
 =?utf-8?B?MWdvMFBoLzZXNzBZMUVSbkJ5OE1jNjErMFhMeGVDOExoQTBiUWFnQVFsY3ov?=
 =?utf-8?B?WlkrMldEN0plYWFQRjQzVStodjBaN25pSlNhbVA2Z0hETTEycTBFNjZyWXFZ?=
 =?utf-8?B?aThLZktldHVJaTdaZlhmU1JpQzJleFIxNVFESzFlMUtzTS9TM3lZRVlDUTdZ?=
 =?utf-8?B?eld5M2dqNU1weUwycS9IMlF0Zi9CWFBkMzVMOVlZb21DWUU1RHp6ZU9KY2xz?=
 =?utf-8?B?OUo0RElBalVXaHNkVTE5WEhmWjhLaVFYRUpLbzJtT25ETTVSazM1R1VLMFdI?=
 =?utf-8?B?dTRESzdFaTk5OHpBQUdxcFNrZ1pJUDgrOVlnQ1R4ZkNzTWw0Tjc3RXA0TFBw?=
 =?utf-8?B?Z01tcGplNFlTRHYyTHVNY2dtRm1VcXRrZ0VwM25xOE1zQWxZL1ZhVURrRTVV?=
 =?utf-8?B?NjZoUXNZOUVHbVVGNEtMU1duS1ZvYzYxa201Tno3TERERkdOOWJBekNTd2gy?=
 =?utf-8?B?UUtJcHVVVDlwakVpMlBBSjQyVVdIS0grd0UvZFdYcWtIMDVuWHRpM2lCR1dN?=
 =?utf-8?B?YVQ5RkZqejlidDdhVXJROFlsdVMybFhiTmpndzRiOW1TQ1loNHM1ZzFWNDBW?=
 =?utf-8?B?eVUzU2ZGTmFPc05Eb2cwQXIzWVdqOHRXUGFmSUlZNXlkK3gxK051YW5mS29W?=
 =?utf-8?B?L0tWYzRudWxiK3JxRkxmNHhCK0p1aW9VSExldWQrM3paZ3R4aTNHYnd6U0Uw?=
 =?utf-8?B?M1VxeW5mS1Z3TkQydGxYZG5McitHeC9CY0h2ZE1kRzVQdklLQVpDK3Q2S29T?=
 =?utf-8?B?Z2ZEa2pYVVNKbHlRRVR3UUdrdStpdHN3M2YwVVdRYWNwSVRlYmlVYUpRL0hY?=
 =?utf-8?B?VGRGcHNZU1VJYzJSZW1tbktZRWdYNWtRc0xWT1JMellCQ28rVUlHMHY5dERH?=
 =?utf-8?B?dTFvUlNQa2FvV3AxM2xRc0o5b25VUWxpNzRsSDY0Q1hKcWxndnlrOGprUUF2?=
 =?utf-8?Q?/0PsZ4BfzkYT7qkq+BiuZYIJ9nNbN5MRuJXZSbz?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 488fdc89-c5d8-4b2c-6f62-08d982486ace
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 06:22:59.2418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2SItQ6D/ZYJjG+Jhp7Qdem9YOkaGdKKzoWG2kqN8n44nmzShB0jxmMmsEwAg3r3EIbOk22q3Ei3X1fL8mNqloA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4656
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10120 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0 mlxscore=0
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109280035
X-Proofpoint-ORIG-GUID: SCuK_Xstaexl0VnIixjsrGvU-kho7AKj
X-Proofpoint-GUID: SCuK_Xstaexl0VnIixjsrGvU-kho7AKj
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/27/21 1:39 PM, J. Bruce Fields wrote:
> On Mon, Sep 27, 2021 at 04:14:33PM -0400, J. Bruce Fields wrote:
>> The file_rwsem is used for /proc/locks; only the code that produces the
>> /proc/locks output calls down_write, the rest only calls down_read.
>>
>> I assumed that it was OK to nest read acquisitions of a rwsem, but I
>> think that's wrong.
>>
>> I think it should be no big deal to move the lm_expire_lock(.,0) call
>> outside of the file_rwsem?
> You probably want to turn on LOCKDEP for any more testing.

I use 'make menuconfig' to turn on LOCKDEP by enabling
'Kernel hacking/Lock debugging/prove locking correctness'. However
when I boot this kernel, DHCP failed to get an IP address making
the system inaccessible from the network. I'm not sure if it's
related to this error:

Sep 27 23:14:51 nfsvme24 kernel: unchecked MSR access error: WRMSR to 0xe00 (tried to write 0x0000000000010003) at rIP: 0xffffffff8101584d (wrmsrl+0xb/0x1f)
Sep 27 23:14:51 nfsvme24 kernel: Call Trace:
Sep 27 23:14:51 nfsvme24 kernel: uncore_box_ref.part.0+0x60/0x78
Sep 27 23:14:51 nfsvme24 kernel: ? uncore_pci_pmu_register+0xea/0xea
Sep 27 23:14:51 nfsvme24 kernel: uncore_event_cpu_online+0x51/0x107
Sep 27 23:14:51 nfsvme24 kernel: ? uncore_pci_pmu_register+0xea/0xea
Sep 27 23:14:51 nfsvme24 kernel: cpuhp_invoke_callback+0xb2/0x23d
Sep 27 23:14:51 nfsvme24 kernel: ? __schedule+0x5d3/0x625
Sep 27 23:14:51 nfsvme24 kernel: cpuhp_thread_fun+0xc6/0x111
Sep 27 23:14:51 nfsvme24 kernel: ? smpboot_register_percpu_thread+0xcc/0xcc
Sep 27 23:14:51 nfsvme24 kernel: smpboot_thread_fn+0x1b1/0x1c6
Sep 27 23:14:51 nfsvme24 kernel: kthread+0x107/0x10f
Sep 27 23:14:51 nfsvme24 kernel: ? kthread_flush_worker+0x75/0x75
Sep 27 23:14:51 nfsvme24 kernel: ret_from_fork+0x22/0x30

Here is the diff of the working config and non-working (LOCKDEP) config:

[dngo@nfsdev linux]$ diff .config .config-LOCKDEP
245c245
< # CONFIG_KALLSYMS_ALL is not set
---
> CONFIG_KALLSYMS_ALL=y
470a471
> # CONFIG_LIVEPATCH is not set
905,909c906
< CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
< CONFIG_INLINE_READ_UNLOCK=y
< CONFIG_INLINE_READ_UNLOCK_IRQ=y
< CONFIG_INLINE_WRITE_UNLOCK=y
< CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
---
> CONFIG_UNINLINE_SPIN_UNLOCK=y
4463,4470c4460,4475
< # CONFIG_PROVE_LOCKING is not set
< # CONFIG_LOCK_STAT is not set
< # CONFIG_DEBUG_RT_MUTEXES is not set
< # CONFIG_DEBUG_SPINLOCK is not set
< # CONFIG_DEBUG_MUTEXES is not set
< # CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
< # CONFIG_DEBUG_RWSEMS is not set
< # CONFIG_DEBUG_LOCK_ALLOC is not set
---
> CONFIG_PROVE_LOCKING=y
> CONFIG_PROVE_RAW_LOCK_NESTING=y
> CONFIG_LOCK_STAT=y
> CONFIG_DEBUG_RT_MUTEXES=y
> CONFIG_DEBUG_SPINLOCK=y
> CONFIG_DEBUG_MUTEXES=y
> CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
> CONFIG_DEBUG_RWSEMS=y
> CONFIG_DEBUG_LOCK_ALLOC=y
> CONFIG_LOCKDEP=y
> CONFIG_LOCKDEP_BITS=15
> CONFIG_LOCKDEP_CHAINS_BITS=16
> CONFIG_LOCKDEP_STACK_TRACE_BITS=19
> CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
> CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
> CONFIG_DEBUG_LOCKDEP=y
4479c4484,4486
< # CONFIG_DEBUG_IRQFLAGS is not set
---
> CONFIG_TRACE_IRQFLAGS=y
> CONFIG_TRACE_IRQFLAGS_NMI=y
> CONFIG_DEBUG_IRQFLAGS=y
4498a4506
> CONFIG_PROVE_RCU=y
4526a4535
> CONFIG_PREEMPTIRQ_TRACEPOINTS=y
[dngo@nfsdev linux]$

can you share your config with LOCKDEP enabled so I can give
it a try?

Thanks,
-Dai

>
> I wonder if there's any potential issue with the other locks held here
> (st_mutex, rp_mutex).
>
> --b.
>
>> --b.
>>
>> [  959.807364] ============================================
>> [  959.807803] WARNING: possible recursive locking detected
>> [  959.808228] 5.15.0-rc2-00009-g4e5af4d2635a #533 Not tainted
>> [  959.808675] --------------------------------------------
>> [  959.809189] nfsd/5675 is trying to acquire lock:
>> [  959.809664] ffffffff8519e470 (file_rwsem){.+.+}-{0:0}, at: locks_remove_posix+0x37f/0x4e0
>> [  959.810647]
>>                 but task is already holding lock:
>> [  959.811097] ffffffff8519e470 (file_rwsem){.+.+}-{0:0}, at: nfsd4_lock+0xcb9/0x3850 [nfsd]
>> [  959.812147]
>>                 other info that might help us debug this:
>> [  959.812698]  Possible unsafe locking scenario:
>>
>> [  959.813189]        CPU0
>> [  959.813362]        ----
>> [  959.813544]   lock(file_rwsem);
>> [  959.813812]   lock(file_rwsem);
>> [  959.814078]
>>                  *** DEADLOCK ***
>>
>> [  959.814386]  May be due to missing lock nesting notation
>>
>> [  959.814968] 3 locks held by nfsd/5675:
>> [  959.815315]  #0: ffff888007d42bc8 (&rp->rp_mutex){+.+.}-{3:3}, at: nfs4_preprocess_seqid_op+0x395/0x730 [nfsd]
>> [  959.816546]  #1: ffff88800f378b70 (&stp->st_mutex#2){+.+.}-{3:3}, at: nfsd4_lock+0x1f91/0x3850 [nfsd]
>> [  959.817697]  #2: ffffffff8519e470 (file_rwsem){.+.+}-{0:0}, at: nfsd4_lock+0xcb9/0x3850 [nfsd]
>> [  959.818755]
>>                 stack backtrace:
>> [  959.819010] CPU: 2 PID: 5675 Comm: nfsd Not tainted 5.15.0-rc2-00009-g4e5af4d2635a #533
>> [  959.819847] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-3.fc34 04/01/2014
>> [  959.820637] Call Trace:
>> [  959.820759]  dump_stack_lvl+0x45/0x59
>> [  959.821016]  __lock_acquire.cold+0x175/0x3a5
>> [  959.821316]  ? lockdep_hardirqs_on_prepare+0x400/0x400
>> [  959.821741]  lock_acquire+0x1a6/0x4b0
>> [  959.821976]  ? locks_remove_posix+0x37f/0x4e0
>> [  959.822316]  ? lock_release+0x6d0/0x6d0
>> [  959.822591]  ? find_held_lock+0x2c/0x110
>> [  959.822852]  ? lock_is_held_type+0xd5/0x130
>> [  959.823139]  posix_lock_inode+0x143/0x1ab0
>> [  959.823414]  ? locks_remove_posix+0x37f/0x4e0
>> [  959.823739]  ? do_raw_spin_unlock+0x54/0x220
>> [  959.824031]  ? lockdep_init_map_type+0x2c3/0x7a0
>> [  959.824355]  ? locks_remove_flock+0x2e0/0x2e0
>> [  959.824681]  locks_remove_posix+0x37f/0x4e0
>> [  959.824984]  ? do_lock_file_wait+0x2a0/0x2a0
>> [  959.825287]  ? lock_downgrade+0x6a0/0x6a0
>> [  959.825584]  ? nfsd_file_put+0x170/0x170 [nfsd]
>> [  959.825941]  filp_close+0xed/0x130
>> [  959.826191]  nfs4_free_lock_stateid+0xcc/0x190 [nfsd]
>> [  959.826625]  free_ol_stateid_reaplist+0x128/0x1f0 [nfsd]
>> [  959.827037]  release_openowner+0xee/0x150 [nfsd]
>> [  959.827382]  ? release_last_closed_stateid+0x460/0x460 [nfsd]
>> [  959.827837]  ? rwlock_bug.part.0+0x90/0x90
>> [  959.828115]  __destroy_client+0x39f/0x6f0 [nfsd]
>> [  959.828460]  ? nfsd4_cb_recall_release+0x20/0x20 [nfsd]
>> [  959.828868]  nfsd4_fl_expire_lock+0x2bc/0x460 [nfsd]
>> [  959.829273]  posix_lock_inode+0xa46/0x1ab0
>> [  959.829579]  ? lockdep_init_map_type+0x2c3/0x7a0
>> [  959.829913]  ? locks_remove_flock+0x2e0/0x2e0
>> [  959.830250]  ? __init_waitqueue_head+0x70/0xd0
>> [  959.830568]  nfsd4_lock+0xcb9/0x3850 [nfsd]
>> [  959.830878]  ? nfsd4_delegreturn+0x3b0/0x3b0 [nfsd]
>> [  959.831248]  ? percpu_counter_add_batch+0x77/0x130
>> [  959.831594]  nfsd4_proc_compound+0xcee/0x21d0 [nfsd]
>> [  959.831973]  ? nfsd4_release_compoundargs+0x140/0x140 [nfsd]
>> [  959.832414]  nfsd_dispatch+0x4df/0xc50 [nfsd]
>> [  959.832737]  ? nfsd_svc+0xca0/0xca0 [nfsd]
>> [  959.833051]  svc_process_common+0xdeb/0x2480 [sunrpc]
>> [  959.833462]  ? svc_create+0x20/0x20 [sunrpc]
>> [  959.833830]  ? nfsd_svc+0xca0/0xca0 [nfsd]
>> [  959.834144]  ? svc_sock_secure_port+0x36/0x40 [sunrpc]
>> [  959.834578]  ? svc_recv+0xd9c/0x2490 [sunrpc]
>> [  959.834915]  svc_process+0x32e/0x4a0 [sunrpc]
>> [  959.835249]  nfsd+0x306/0x530 [nfsd]
>> [  959.835499]  ? nfsd_shutdown_threads+0x300/0x300 [nfsd]
>> [  959.835899]  kthread+0x391/0x470
>> [  959.836094]  ? _raw_spin_unlock_irq+0x24/0x50
>> [  959.836394]  ? set_kthread_struct+0x100/0x100
>> [  959.836698]  ret_from_fork+0x22/0x30
>> [  960.750222] nfsd: last server has exited, flushing export cache
>> [  960.880355] NFSD: Using nfsdcld client tracking operations.
>> [  960.880956] NFSD: starting 15-second grace period (net f0000098)
>> [ 1403.405511] nfsd: last server has exited, flushing export cache
>> [ 1403.656335] NFSD: Using nfsdcld client tracking operations.
>> [ 1403.657585] NFSD: starting 15-second grace period (net f0000098)
>> [ 1445.741596] nfsd: last server has exited, flushing export cache
>> [ 1445.981980] NFSD: Using nfsdcld client tracking operations.
>> [ 1445.983143] NFSD: starting 15-second grace period (net f0000098)
>> [ 1450.025112] NFSD: all clients done reclaiming, ending NFSv4 grace period (net f0000098)
>> [ 1472.325551] nfsd: last server has exited, flushing export cache
>> [ 1472.583073] NFSD: Using nfsdcld client tracking operations.
>> [ 1472.583998] NFSD: starting 15-second grace period (net f0000098)
>> [ 1473.175582] NFSD: all clients done reclaiming, ending NFSv4 grace period (net f0000098)
>> [ 1494.637499] nfsd: last server has exited, flushing export cache
>> [ 1494.885795] NFSD: Using nfsdcld client tracking operations.
>> [ 1494.886484] NFSD: starting 15-second grace period (net f0000098)
>> [ 1495.393667] NFSD: all clients done reclaiming, ending NFSv4 grace period (net f0000098)
>> [ 1516.781474] nfsd: last server has exited, flushing export cache
>> [ 1516.902903] NFSD: Using nfsdcld client tracking operations.
>> [ 1516.903460] NFSD: starting 15-second grace period (net f0000098)
>> [ 1538.045156] NFSD: all clients done reclaiming, ending NFSv4 grace period (net f0000098)
>> [ 1559.125362] nfsd: last server has exited, flushing export cache
>> [ 1559.362856] NFSD: Using nfsdcld client tracking operations.
>> [ 1559.363658] NFSD: starting 15-second grace period (net f0000098)
>> [ 1559.480531] NFSD: all clients done reclaiming, ending NFSv4 grace period (net f0000098)
>> [ 1583.745353] nfsd: last server has exited, flushing export cache
>> [ 1583.876877] NFSD: Using nfsdcld client tracking operations.
>> [ 1583.877573] NFSD: starting 15-second grace period (net f0000098)
>> [ 1586.401321] nfsd: last server has exited, flushing export cache
>> [ 1586.525629] NFSD: Using nfsdcld client tracking operations.
>> [ 1586.526388] NFSD: starting 15-second grace period (net f0000098)
>> [ 1625.993218] nfsd: last server has exited, flushing export cache
>> [ 1626.442627] NFSD: Using nfsdcld client tracking operations.
>> [ 1626.444397] NFSD: starting 15-second grace period (net f0000098)
>> [ 1627.117214] nfsd: last server has exited, flushing export cache
>> [ 1627.351487] NFSD: Using nfsdcld client tracking operations.
>> [ 1627.352663] NFSD: starting 15-second grace period (net f0000098)
>> [ 1627.854410] NFSD: all clients done reclaiming, ending NFSv4 grace period (net f0000098)
>> [ 3285.818905] clocksource: timekeeping watchdog on CPU3: acpi_pm retried 2 times before success
