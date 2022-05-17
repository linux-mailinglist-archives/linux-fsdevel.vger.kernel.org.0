Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA84852A89E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 May 2022 18:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350665AbiEQQw4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 May 2022 12:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346916AbiEQQwz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 May 2022 12:52:55 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB6B3FD99
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 May 2022 09:52:54 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HBGEaF015995;
        Tue, 17 May 2022 09:50:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=k8xyvKAQ+vBHG3lX/bEXoeWScPmGoVdOJqo1d3iF2l0=;
 b=LsBhRj0cBkuinnKFgiBKEUaPD3l0TPzfxeb3gMQGPlJcKa5r7DGSoJwH2QLR7F+pw64H
 NHqgpGyC+qZhSWYBv5VVkIteND9jIkXmSfFsX4UPd2ypfNRo+wf5CuWTqlCNla+hU5zQ
 21B0rQ5A4mY17d4Wf+JJ1MdR0r0+n6nPm2M= 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2049.outbound.protection.outlook.com [104.47.51.49])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g4ap6j9yt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 09:50:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyvTmZ16BCh5QWuv4vgMz22yMwCNw9pF8ac8zz78tH6GGYWObW21viGxAw7DxD2YAUYVEhHY77s0BukDWdWMOCtjK7aP0qlHQS/DoA9GhU8gfFDQLf0gM4zpTxshPlflmvj2efLpIsr++6ZQBXvcmK8d0O04t0LXLn41+26XekrgGoQ55SAha1VuKqK+eu+MQGhA4BIRn5fmIaAlnb6tKZZu+zasYsOi/fi97sJZNdgvPPRb5H71QkThAjF3nyhotat5LoQezRdScLJQ2keSaL/SsTQS95D4gXLXl8qHTR0GuM/qVjgkD9mM/hk49pmBTuWyJ6vR+rPwa+QfpYZvDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8xyvKAQ+vBHG3lX/bEXoeWScPmGoVdOJqo1d3iF2l0=;
 b=auxYTfTKOVgdKH5yz/WkFdUSL61nM1boLZId7rkbnoLFrraXTZfSWpN/gEYWnqChfG6xuzGrSGZDKK5EB3uPbk+WNV9jSMVgOnNrnLCgIMGI/LWaaGpHEae0zk4iAKIGMJ3gH5wCPRltru5njXBkr8eDR8CFOiMfXSFQ77N6/MpEOM+XtG9f4cJVU2sajhpXCxhmmkoX4kHz6Xl+dTgEJk4xRpqOM2477j8lLAL/xe3bxpTkxohbDK/ni6Pp7QR/ek8/M/ZuNPuLhbPf93/cnKFLj6WPb4sx22PySmtofCLR4AsmM8sQIUESj1D/bp5qrgfjok4SyNgb+8x3EaXxEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by SA1PR15MB5298.namprd15.prod.outlook.com (2603:10b6:806:236::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 16:50:37 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::108d:108:5da8:4acb]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::108d:108:5da8:4acb%8]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 16:50:35 +0000
Message-ID: <d6f632bc-c321-488d-f50e-749d641786d6@fb.com>
Date:   Tue, 17 May 2022 12:50:32 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH] fuse: allow CAP_SYS_ADMIN in root userns to access
 allow_other mount
Content-Language: en-US
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org,
        Seth Forshee <sforshee@digitalocean.com>,
        Rik van Riel <riel@surriel.com>,
        kernel-team <kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
References: <20211111221142.4096653-1-davemarchevsky@fb.com>
 <20211112101307.iqf3nhxgchf2u2i3@wittgenstein>
 <0515c3c8-c9e3-25dd-4b49-bb8e19c76f0d@fb.com>
 <CAJfpegtBuULgvqSkOP==HV3_cU2KuvnywLWvmMTGUihRnDcJmQ@mail.gmail.com>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <CAJfpegtBuULgvqSkOP==HV3_cU2KuvnywLWvmMTGUihRnDcJmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0049.namprd03.prod.outlook.com
 (2603:10b6:208:32d::24) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a7b4e9e-145c-4790-cbd9-08da38255cc7
X-MS-TrafficTypeDiagnostic: SA1PR15MB5298:EE_
X-Microsoft-Antispam-PRVS: <SA1PR15MB52981A28CE51CE0D5BD5E321A0CE9@SA1PR15MB5298.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pbh9Vg+JZjvt5vWlt0kRrcLgF8U1PsH8juDkt1DJUGWJhrcq/Q02b6ASO3NFR9sJB4bF+i5WmHFdDp8frRRg2fsIwkJTR+FCu+H72uo6nq2WtBqI1ahxmNgnfUIU0ZAdTu+LWe8gvFzonu0a0Jt4BuBfd5FYI8c84RlC3GswrV4jmtKYdC0RTD9UlraKvNvy8oznqkaLHmxKYi5GnwQyKO4y4VOh1yvIRwUxQ7NKYIEnLKS+UVW0ZD6p30A9AnXSoQTUeLydMu9rl3gczBVOZpkze6BDFx6+H+naon98vN5FFc1PxS9mGteJObrtjGO9lTYqSgLbTSYoFq1tku82MydBN8G2yUvlUtQ8lmIe74s/7Fsy0WS/Q8CVTRd5HNEQW/mtxMyi6M3fIZx+YN3RtR8hZs63RSH89aTcu6AdIRW7iu7c0wvaxNvlLupjGiAbh3MT5Z+qxR410n/KxZC8wipVLWjfbn2rttk0EhE057z7T8+u9wYBCQ9EB+AyCGbLjsG2lfXnycy7kIbzf/nHlXtlIbYRakbTlXb8nRCL0pE/hyEkGFZqJN6quCF62jMXxlp8FUzxp7n6NRwZGKp0RjMtLBfRyn69jB925dS1oen68eSaH3K85UIMu4JoxhTAO/DS4TLwxNoUMixkG5jBxw5hLfOmOVUT83QiwZRINjjoKSdlt98UoUNLEFpb+JAjDtHtN5cOSdC3mQdgT/9BtGJVcpwCb2xpftzmVj3rYk0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(6512007)(86362001)(186003)(4326008)(8676002)(66476007)(31696002)(66556008)(8936002)(83380400001)(31686004)(316002)(6666004)(6916009)(53546011)(6506007)(38100700002)(36756003)(508600001)(54906003)(5660300002)(2616005)(66946007)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3BnUllGZGZDbGZpRzdndzhOWjJLSWlKM0xFOU1UbVBLLyt3UEszeGxwM2JK?=
 =?utf-8?B?TXhKVThvTWFjVmNUUHNzeWZrdnZQcEc1ME8zeHNsTjIydXpoSnVwajdsR0Zj?=
 =?utf-8?B?LzNPZGkrQlRnRTFyY2wyRS8xTkcyd0cvZXJsNGRaSGRWc3RPenhkWVd4emgx?=
 =?utf-8?B?OERUWjB4cmlHSzJEZVZMRkxadGRhcUhMbyt3NXVqVXBQa1EvWENLZVdkc2Ft?=
 =?utf-8?B?RWtpSFozZ090VFBxd3AvZFcxNUhLUk9ydGh1SlE5K2dZRDVYNDhCS2orRk1S?=
 =?utf-8?B?WmM3a2lzRUx3UUFBMEprKzQrbFVjMlZNOUcvYkY5SzB2YjJEWTJ1bVd3ZkIv?=
 =?utf-8?B?ZzRZNUxhc0U3TFZlV2Qwdlp6ekFIZW9MMDlJTE0zU3cxL2x4QXV6VnNwNWh5?=
 =?utf-8?B?dWhNTFBuVnR5MUdVM3YrOUQzR21FMXBFak1FS3Nxb1NiWEQ4eElHRFhFT0tN?=
 =?utf-8?B?dkNNbWhjdWtnOWlCSkJUaGsyWmU5WVQ2Nm92RHM1NzZwMXNXc3dDY0dQaDBr?=
 =?utf-8?B?cDdPaVJrSjYydGF0WTdTeXBCSlNadFRLaGsrLzVFK0lzZ1Z1Y3NBQ1FVaUln?=
 =?utf-8?B?bkxzQ0Z2cHN6VU9LYlprQW5FZGpOT1JjOTBJVUlxZE1sdVhnb3hSeDE0ZzZw?=
 =?utf-8?B?TmZxVGtoQ0dxNjZDUXk0Vy93UFlUMXBWZ3Q0WXBHOXppdHI2NE5USEUwdjcw?=
 =?utf-8?B?UXVnaUQyU09ja0JkWWViVkZQdjNEVDZQZDZNOW4vN0dKb21NUUhMMGZmUkYw?=
 =?utf-8?B?STMxUmtoUkNoVTUzbUl2SlBoZzluVHNFOGtRMERaT3Y0U3FiVWxWaU5VZSt0?=
 =?utf-8?B?THE2MUpSTi9XK2lUeXVkd0p0VDR4MnJDeXVIYitDQmZvd0dMV2JlUG4zTkpS?=
 =?utf-8?B?b3BaTDhvc3B3TlM2ZmoxUjVTeUJ0V3ZOWHV3UW5rNCtnbVVROGxRUWZLWW1l?=
 =?utf-8?B?R2QwMTN2MzMzUUw1aHdGZExIMmprVmhRWDhhUTc0b0RPVHl5bFRxUUZ6Y084?=
 =?utf-8?B?UU8xSERocWYvVU04cytxZTFVZGNBNWFJZGRocTRZKy9xdkFJdHBoeVFNTFdZ?=
 =?utf-8?B?Nm9vVGtOYnlab1dyV0d6ZnEzL1ZuRVJSU2kzUnJrZ0lUMUowVUtYWWhkS3pz?=
 =?utf-8?B?Nzh2K2RoL2h6NE8xVDJ1WnE1cVFzL1R2b09sWnZvS3ZTWmVxMUNzTEJrM0ph?=
 =?utf-8?B?cW9BYy96SmdNalVrOFQrclhqVk9UNmdCZ0prcUgyb0Q0bkdpTzhzVVUyazRY?=
 =?utf-8?B?akFzTFhLcitxNEZNd1BFNmxicWJ2MVFkU0dyU2kwSGVMcHUyYjVKNGx6RTFm?=
 =?utf-8?B?WE9pK2w0TUpUQ1ZBRW1haElSNXluMGFuWFAxbTR5K3V1YnVoMGJJV0UwZ0lD?=
 =?utf-8?B?V1E1VHZuUHRxcTcrdzYyT3JTTGRHempiMGIybVFkNGZqdkRYTHRzMUtIZnpK?=
 =?utf-8?B?U0Vra051dmNPVnMzTG8vaFpZSTB1UWhPQUREcDI1dXFTZFhVaW43UzRPVEdl?=
 =?utf-8?B?Skl2QlBFNUVBSjV6K0tTRGNpNVFxc0svMmM0dXFkSWNFUkhTMXowMFZHNis2?=
 =?utf-8?B?SEc3RlovNjc0Q1kwQVR0N2EwR3Y1dHhsNlpZNk5iOVp1YWtqTFBBdE5rc1FD?=
 =?utf-8?B?ZTBqR3kxU0VaQi9lKytQSEp1amM5ZkJiZnFNdVBOTXo4WUE1QUhPREM5eHht?=
 =?utf-8?B?Q3h5WnpXUzdaNktXQ0lEbUhHOStJeHp5TDdKNXVpUU5NVjlFajJUOUZRb3NV?=
 =?utf-8?B?MWZSUFNScy9iMGdqV1RDcHF2N3JhTGFiUmhlTU1nVFB1aC9yWjBFbU5sMW5Y?=
 =?utf-8?B?QWkyK2pyUGRrZGJucWNQM0ljdmZ1ZTdiMjF1ZjYyNStkcm92cVMzRnFOTWRs?=
 =?utf-8?B?ZitsM1BoeWJFamhVZTA5SzVJYUUvbUoyUHRRTmFZbWpEWTZKNTZ4MGdJNzFB?=
 =?utf-8?B?SUVMOG9xTGlHOFN4Mmdqb2ZwMGJCbjZsWklGWWhhWTJRcnBpd05UNno5UzBK?=
 =?utf-8?B?QjFxNmc4Q1FmZXYxYWRRZmg2b2M4M2h2dDRHc210amVnQ0twUlVGSlNCLzJp?=
 =?utf-8?B?OE1XbHM4T2EwUHFQZGxTaS9SNkhudFo0dWRkSkZyVGhkZlU5TWk1Zmovb0xM?=
 =?utf-8?B?R091dzl1YVFhODlmcERuQnc1K1dzMHRvcmhtaDJhblRBWWVnNEJ2b2JiOEVL?=
 =?utf-8?B?R21zUGVPK1ZMQjVUOUNZWFhUVTNmblVaYXRCek5uZUxNL2dzNVpCVTV3a0Ez?=
 =?utf-8?B?ZWZDdEN1U1RIRENqc0UrTjNob3lKSEVQdDhmSzkyMEtzV1JpVDhSbjVOVkJL?=
 =?utf-8?B?WGhyOFVmUWpFdVRpUlJCaisvRDZlQzZHclFUL082N29USmp6cGVnR3l3NjNa?=
 =?utf-8?Q?mh871xJsbG9ylmjXrd+g650jyB/A1wFq1Nhw8?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a7b4e9e-145c-4790-cbd9-08da38255cc7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 16:50:34.9608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q4L0xBQpWlehnErvXsiX7aq+7rM5rgIDC0jpmAiNVgNFiJ2Jdgl2o6OCiPdQU9RwFlxvH+0Y5vISf2nwuQhHew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5298
X-Proofpoint-GUID: pgtsnbhtapfibgFgw99kbGsKoa3hVSWJ
X-Proofpoint-ORIG-GUID: pgtsnbhtapfibgFgw99kbGsKoa3hVSWJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-17_03,2022-05-17_02,2022-02-23_01
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/15/21 10:28 AM, Miklos Szeredi wrote:   
> On Sat, 13 Nov 2021 at 00:29, Dave Marchevsky <davemarchevsky@fb.com> wrote:
> 
>>> If your tracing daemon runs in init_user_ns with CAP_SYS_ADMIN why can't
>>> it simply use a helper process/thread to
>>> setns(userns_fd/pidfd, CLONE_NEWUSER)
>>> to the target userns? This way we don't need to special-case
>>> init_user_ns at all.
>>
>> helper process + setns could work for my usecase. But the fact that there's no
>> way to say "I know what I am about to do is potentially stupid and dangerous,
>> but I am root so let me do it", without spawning a helper process in this case,
>> feels like it'll result in special-case userspace workarounds for anyone doing
>> symbolication of backtraces.
> 
> Note: any mechanism that grants filesystem access to users that have
> higher privileges than the daemon serving the filesystem will
> potentially open DoS attacks against the higher privilege task.  This
> would be somewhat mitigated if the filesystem is only mounted in a
> private mount namespace, but AFAICS that's not guaranteed.
> 
> The above obviously applies to your original patch but it also applies
> to any other mechanism where the high privilege user doesn't
> explicitly acknowledge and accept the consequences.   IOW granting the
> exception has to be initiated by the high privleged user.
> 
> Thanks,
> Miklos
> 

Sorry to ressurect this old thread. My proposed alternate approach of "special
ioctl to grant exception to descendant userns check" proved unnecessarily
complex: ioctls also go through fuse_allow_current_process check, so a special
carve-out would be necessary for in both ioctl and fuse_permission check in
order to make it possible for non-descendant-userns user to opt in to exception.

How about a version of this patch with CAP_DAC_READ_SEARCH check? This way 
there's more of a clear opt-in vs CAP_SYS_ADMIN.

FWIW we've been running CAP_SYS_ADMIN version of this patch internally and
can confirm it fixes tracing tools' ability to symbolicate binaries in FUSE.

> 
>>
>> e.g. perf will have to add some logic: "did I fail
>> to grab this exe that some process had mapped? Is it in a FUSE mounted by some
>> descendant userns? let's fork a helper process..." Not the end of the world,
>> but unnecessary complexity nonetheless.
>>
>> That being said, I agree that this patch's special-casing of init_user_ns is
>> hacky. What do you think about a more explicit and general "let me do this
>> stupid and dangerous thing" mechanism - perhaps a new struct fuse_conn field
>> containing a set of exception userns', populated with ioctl or similar.
> 
> 
> 
>>
>>>
>>>>
>>>> Note: I was unsure whether CAP_SYS_ADMIN or CAP_SYS_PTRACE was the best
>>>> choice of capability here. Went with the former as it's checked
>>>> elsewhere in fs/fuse while CAP_SYS_PTRACE isn't.
>>>>
>>>>  fs/fuse/dir.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
>>>> index 0654bfedcbb0..2524eeb0f35d 100644
>>>> --- a/fs/fuse/dir.c
>>>> +++ b/fs/fuse/dir.c
>>>> @@ -1134,7 +1134,7 @@ int fuse_allow_current_process(struct fuse_conn *fc)
>>>>      const struct cred *cred;
>>>>
>>>>      if (fc->allow_other)
>>>> -            return current_in_userns(fc->user_ns);
>>>> +            return current_in_userns(fc->user_ns) || capable(CAP_SYS_ADMIN);
>>>>
>>>>      cred = current_cred();
>>>>      if (uid_eq(cred->euid, fc->user_id) &&
>>>> --
>>>> 2.30.2
>>>>
>>>>
>>
