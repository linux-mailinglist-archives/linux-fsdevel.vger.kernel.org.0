Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B53C542321
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 08:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbiFHBS4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 21:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385944AbiFHAWJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 20:22:09 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2052.outbound.protection.outlook.com [40.107.96.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CBC12B019;
        Tue,  7 Jun 2022 15:42:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGUy9Z3KPXQwvNjDwnnNe0OScGEozgTyCMZmPuU2G3JInpZy6BMIiFTYUVptERWp04gurLTHnDLC73Cm9oQfzvr/wfZA53hD3tm74O0ciJfhBDBHFSfDJ9+faMyWlHH3cYa3IGNewNiqsnKveUpXw4rHiQHJ3bcgUfTTIZWX9Ety2sPoWNu0OBTOe9H5enfZgp09+srC+NqVlf6m+bqbDTgZ+hj1IDVYFCFzTvCyey5/thKRUFveCNDeJcTqwxCyBSB8bT5CX66iIqkEi2fa0hBBHrDeQQ/bBTXP/iu7TES7NBKTudgounSb3zIDqey476hkhS0Xmqe5JVfKMu+2Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxhH89H/for469fzbR7GqtC2C7haBhc2Rh9SoTJCrCM=;
 b=KV+IaL7txfeKOGH6aqUAvTnW/2BFllf/micqzlIjvLvZAfCE7Wf8+6JFZEW/QDOzTaotcpuCuruzF6VvSAa/Jv50va8SkmgSI5MC3JVWyaJgtASy9UQsIfu6WJyOdwDW9Ycf31rYYTtZWbH5WDmZs7XkwJxUq5ta85nwJhBWfEilLzlLMqUkjG/DSykNwl5a0+s3O6p+SGe2J38pDTXXDThLGz6v7za9rppbdIDDBoJK5mF1F8UdQDqUGxHuSUllU/dfCslu0bLzkXgJqQRbvrFzHHUNxsjPDyEIm2raZ80G9Rfg4d9UfJcfMUeTcNb4JnSCKjusTRZuhadnIjWfZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxhH89H/for469fzbR7GqtC2C7haBhc2Rh9SoTJCrCM=;
 b=rCB6kRXWTuUxlrfC7/fE2GE/oK4EgSGB9/a0NszRHXNF6aw1dCmYKTFl4RiTfq3fJklcVG27sbkVjkR1hDEqBIcAEhciTFt2QJV3uw7npcJBxBXqoP+OtxVl4Dx1MlqsCqLXXy9KQmROBVylzRxlNb+AeSzvbgZrLLn5XOVDJwQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by MW3PR19MB4171.namprd19.prod.outlook.com (2603:10b6:303:45::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Tue, 7 Jun
 2022 22:42:26 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::3994:ad08:1a41:d93a]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::3994:ad08:1a41:d93a%7]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 22:42:26 +0000
Message-ID: <3d189ccc-437e-d9c0-e9f1-b4e0d2012e3c@ddn.com>
Date:   Wed, 8 Jun 2022 00:42:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 1/1] Allow non-extending parallel direct writes on the
 same file.
Content-Language: en-US
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Dharmendra Singh <dharamhans87@gmail.com>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Dharmendra Singh <dsingh@ddn.com>
References: <20220605072201.9237-1-dharamhans87@gmail.com>
 <20220605072201.9237-2-dharamhans87@gmail.com> <Yp/CYjONZHoekSVA@redhat.com>
 <34dd96b3-e253-de4e-d5d3-a49bc1990e6f@ddn.com> <Yp/KnF0oSIsk0SYd@redhat.com>
From:   Bernd Schubert <bschubert@ddn.com>
In-Reply-To: <Yp/KnF0oSIsk0SYd@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0055.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2ca::11) To DM5PR1901MB2037.namprd19.prod.outlook.com
 (2603:10b6:4:aa::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9ad60ca-f2ac-44d0-3cfb-08da48d6fe9a
X-MS-TrafficTypeDiagnostic: MW3PR19MB4171:EE_
X-Microsoft-Antispam-PRVS: <MW3PR19MB41718A1DB393567126952E3FB5A59@MW3PR19MB4171.namprd19.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A62LKZkkQUipXuMjgwsqqMcHC1rlktCSQxGrMc6fTZwP9RzNrMqqA7DOQXJwlq+3a4tAuvUDRfiTWWxTuR0eXUFYjs6tQW6UND/iwohX/Dx1UgVESi4O9iclXVbrGxar0Cy9QtK56YcTJpyvSgsTzewhb53kdMrxshnrACKt4dMcuoWD91383gKbjNGt5fyhpXW2qPfYbO23gC3nO15XExEpse2FhP1MlRPnEgScJyRPt+KA4sIVAkPb2p6oUzHralZ5fsBBu4rW7AD9mAVgkkb5432BfRjzCP3b4TkhyO4+VYnakNGNi9IsJfhCVoZP0WwTO/31XQoO+6ZFWfUmo3/aU1ncIahY41kJWkmuOwIqLDyp6Q8tAWQrKavaYQOamN2F2LBVy2iLXMoBJIG4gbv60HXsKFNcFaMQF3Rx79KTGjVTNkyhNnrjFAu78mTaaBScQGzTaF/4RwKLbcDuMzAS10gANL6OA5whmPnGqfhM0HMGC/NBqBYHjQ32jHqCwygAASuX5/Du2wZ0FGWRD42aXcSm9brRXcZwGbXnLUZnk/WOJOi0+W/CF9C0wN1MOlkw5FA+4ew5Ti+yGGBOPLKVfWcsdYCFq+f5c7vag7zPZ+vk0IaMNLDWy0MgULwZJwtwzzjcrfWJEWGDE4esTrRuSFJPpMC9l/nGB2fRhbT1EzDJwhs64JEP6PTkYlrCAmmmuz+4GTOC09UHma7sqijZwGMmRjtx//y690+86DcreodXgPu8yQqm76vAfahw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(2906002)(4326008)(66476007)(6506007)(6512007)(38100700002)(6486002)(66946007)(6666004)(66556008)(86362001)(508600001)(31696002)(53546011)(6916009)(83380400001)(54906003)(31686004)(316002)(8676002)(5660300002)(186003)(36756003)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjhZNEJ5Ym9XQktGZlZzZkJhVSt2RDNSRG13aGhMangxR1p5OVA2T0VtWFdI?=
 =?utf-8?B?UWlmV2hLZXg1ZlVOQkV3SjVsbzh2Yjh4aitPY0pPcGhYbE4rK3FLNzVFOEdx?=
 =?utf-8?B?YmhLemtBQnhsbElwaTNuNVR3SkJxaWRIOTdhVEp4ejNleURTdWp6amRRelJ5?=
 =?utf-8?B?akRVZk9EVFBKUk5hSUtYUXJDRkF0Y3gveTNrUXRYbm1yUHdrM2tiOUhRV2ds?=
 =?utf-8?B?ZFFrVDFlQzQzSGJsUHROWnJ3WjNWdG9hMk9ESTI5NDloZDkzWWRqMlMvN0N2?=
 =?utf-8?B?VGJBV0xENnVGWEl6ZTFvSmZFN2g2bWdXMDBPbWhnbEJKcURiSFJQMVZtcWdu?=
 =?utf-8?B?L01GeCs4Q3VLY3ZlNDNKTkRPTmVDUUplcmVNbnI4R2JaSDV0aW41K29CL3Nw?=
 =?utf-8?B?UEYxZzFGNHQ1K2pzRnR6V0o4L09UZG04TE1qRXlTZmlDa1EyVVNLZG9MdnNs?=
 =?utf-8?B?RTRQcWZTemozR3NuaHo3eFpKWGplSkJEbEJ0b0c2bktPbzkyb2VWRUZCTzJ6?=
 =?utf-8?B?RmpGKzNIODF2WDlQTlY5Qmp2VVF3QUZPYzcwcTJEc1Roei9WbjhvRGlqQjdz?=
 =?utf-8?B?YUVGbGFlMUgzbTk3bFE4aUt4UHFZN0k1RHdjdWNwTnFLaDlyRDhYTWNEU29s?=
 =?utf-8?B?TGI4ek5iQkM3aGRtZVBObGpRYmt1Tm50TUE5Y3BWcDRWaHZiVTZXV2tWS29i?=
 =?utf-8?B?RjFDc2FWMFpvMjQzRlIrSFNEajVIdmJmWktwdDdXemZ6eXIzVFY1bG1KbG15?=
 =?utf-8?B?YzFidm94anYyOXp3NHVXZmFTc2c4UzVwVHIzc3ZCTElJRmZadG9wUTVoSUpu?=
 =?utf-8?B?MkxnK0I4cW1LLytIaGZXOFViWkMwZzdKZHpQaFJtRkdXYWhVb2FuQUJZcXk1?=
 =?utf-8?B?dUNrSzdMMDNkdUNHajBhWGcwNEpwenhZSnlqYUxSQVJzWlFDUU92dTlxbXN5?=
 =?utf-8?B?UWhFV012ZFlFM0M1RVB6UzNKQnhIUEUyaThhakwwamo0SUptL2wrRFR1bExv?=
 =?utf-8?B?KzU0Y3I0a21ZNm9EU2hybVE0WE1JUkRyM1d3Q3ljUE9XYjVhTFAvMk1NcmVy?=
 =?utf-8?B?anluRTRxZ2w2OTY3QVZrYlBmVzNwWkhramRVTFNqODlDOGxjRHU3eVB5ODhQ?=
 =?utf-8?B?SjVvUVFoUXA3SmZCUW9WTSt1RUFDVUpJTXlHcXZISm8zaFhYRi9hTWpIYW9V?=
 =?utf-8?B?MjQ5UTdteGpoc0NhWXYwS2hkdG5wczlSdFFQYW9MS0UveXRQc3dPUzkweEZI?=
 =?utf-8?B?S01jbHdJcDQreXJvYW1XdG5QZjk3WkRXLytTL3JjUUJabEtsdy9CYkJzTGpE?=
 =?utf-8?B?Z3gzRU8rYWthQ3Nyb3l1cUZXeGczUmZWTUZuYlRHdlBPMmxKSXZMVFRnRFlM?=
 =?utf-8?B?RVNaTUN6RnQxNVRRTDAxZklsb0FNcmR4WTZQR0laNTFsUGFzeEhZRWZrU2FM?=
 =?utf-8?B?bkViSTNsL0hybEhWYnRYZENpK3U4U3QwVS96YStRbnZ1RlNKRFV5VldxREUv?=
 =?utf-8?B?TWxLQUY5OER0THpranFacHF0QkVsTXZJSW83SlAzQWtlYUJXaDhHc2NocVFI?=
 =?utf-8?B?SDlVWFFvSVdzVGtWLzZkb1IrU2xhTzNGRmNJOUZvbUt0dDBHNXU0a1hpT1Fy?=
 =?utf-8?B?d2J1RTJYWXAzM2xNaEswQWM2ZFFzb2ZkK0JlMm5GTEVpVlhkNjFKRVhGV0U0?=
 =?utf-8?B?NWw1MXIyelh0UkRWN2djS1Rsei9zSEpHTmJJWUdxZU1Id3NJVFlXQ3ZIZVJI?=
 =?utf-8?B?WTg0Tm1VSXpUUCtma1V2eWRINjR2aTVEN0tRbEM3eGIybC9sSDA5TkdraG9Q?=
 =?utf-8?B?RzYwaWUzTlk3VVV3TUZTY3Y0SGdkRkR1MTBJSDM2Y1poODl1QXNPeWJhS3l1?=
 =?utf-8?B?cm1ucCtpWldHdnppc0tRZXRMSFNSQkhWRjlCRldERzhCek5ic2ZQeGp1TENj?=
 =?utf-8?B?bVMyeExwYlhGam0rRHhMU0UyU2dEcExYcVA2RERvOTNDaTdueXlGYzNsckhi?=
 =?utf-8?B?dWY1UWdQR3dYdmxvTEZqdWxGUHk2L0RqYXlRKzNmYk5hZHFyeEFmVG5iU2V1?=
 =?utf-8?B?UTFmR2w3L0pOaXFBTnh5L2NqSGg5dUFhWDJvdEdZc3dKS1FBaFo1RmQzYnZJ?=
 =?utf-8?B?bmNGNEc4cjlyMFdQd2lvMXpXOVdPQ1ozL2JPSTZxbE1SM3Y4akVIN0NidmtU?=
 =?utf-8?B?Lzlxd1dRSkd6MW1ydlhqVFplSGZJUmRCeGlVbzR3dkMyUzNjRnE3V0FaTWtq?=
 =?utf-8?B?bHVtUk9RRzd0Rjl4L01vRDRsUXZDRXVNYlhqSGI5dDJRdXBoVGQvcmZyaUhO?=
 =?utf-8?B?VXVDMmp5N3FnZnJUTWlCWi9ENzMxbTkzT3pZWi9MTFdDOFFOQ3IxZkNaa3Jy?=
 =?utf-8?Q?zy1z7zAhiRzRZGFSSzrt1EsYBiiaAdvTVdmKT+RsRg8Lw?=
X-MS-Exchange-AntiSpam-MessageData-1: MF3RGBkvn49QjA==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ad60ca-f2ac-44d0-3cfb-08da48d6fe9a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 22:42:25.9318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: giF690Iwv272828VpLK0iY/OAwB+2Xz2BlsxKhy5lt1qCkT9IO7V2yZv5ME8RURnExDYSMv1qg0zNGhpgHHyGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR19MB4171
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 6/8/22 00:01, Vivek Goyal wrote:
> On Tue, Jun 07, 2022 at 11:42:16PM +0200, Bernd Schubert wrote:
>>
>>
>> On 6/7/22 23:25, Vivek Goyal wrote:
>>> On Sun, Jun 05, 2022 at 12:52:00PM +0530, Dharmendra Singh wrote:
>>>> From: Dharmendra Singh <dsingh@ddn.com>
>>>>
>>>> In general, as of now, in FUSE, direct writes on the same file are
>>>> serialized over inode lock i.e we hold inode lock for the full duration
>>>> of the write request. I could not found in fuse code a comment which
>>>> clearly explains why this exclusive lock is taken for direct writes.
>>>>
>>>> Following might be the reasons for acquiring exclusive lock but not
>>>> limited to
>>>> 1) Our guess is some USER space fuse implementations might be relying
>>>>      on this lock for seralization.
>>>
>>> Hi Dharmendra,
>>>
>>> I will just try to be devil's advocate. So if this is server side
>>> limitation, then it is possible that fuse client's isize data in
>>> cache is stale. For example, filesystem is shared between two
>>> clients.
>>>
>>> - File size is 4G as seen by client A.
>>> - Client B truncates the file to 2G.
>>> - Two processes in client A, try to do parallel direct writes and will
>>>     be able to proceed and server will get two parallel writes both
>>>     extending file size.
>>>
>>> I can see that this can happen with virtiofs with cache=auto policy.
>>>
>>> IOW, if this is a fuse server side limitation, then how do you ensure
>>> that fuse kernel's i_size definition is not stale.
>>
>> Hi Vivek,
>>
>> I'm sorry, to be sure, can you explain where exactly a client is located for
>> you? For us these are multiple daemons linked to libufse - which you seem to
>> call 'server' Typically these clients are on different machines. And servers
>> are for us on the other side of the network - like an NFS server.
> 
> Hi Bernd,
> 
> Agreed, terminology is little confusing. I am calling "fuse kernel" as
> client and fuse daemon (user space) as server. This server in turn might
> be the client to another network filesystem and real files might be
> served by that server on network.
> 
> So for simple virtiofs case, There can be two fuse daemons (virtiofsd
> instances) sharing same directory (either on local filesystem or on
> a network filesystem).

So the combination of fuse-kernel + fuse-daemon == vfs mount.

> 
>>
>> So now while I'm not sure what you mean with 'client', I'm wondering about
>> two generic questions
>>
>> a) I need to double check, but we were under the assumption the code in
>> question is a direct-io code path. I assume cache=auto would use the page
>> cache and should not be effected?
> 
> By default cache=auto use page cache but if application initiates a
> direct I/O, it should use direct I/O path.

Ok, so we are on the same page regarding direct-io.

> 
>>
>> b) How would the current lock help for distributed clients? Or multiple fuse
>> daemons (what you seem to call server) per local machine?
> 
> I thought that current lock is trying to protect fuse kernel side and
> assumed fuse server (daemon linked to libfuse) can handle multiple
> parallel writes. Atleast that's how I thought about the things. I might
> be wrong. I am not sure.
> 
>>
>> For a single vfs mount point served by fuse, truncate should take the
>> exclusive lock and parallel writes the shared lock - I don't see a problem
>> here either.
> 
> Agreed that this does not seem like a problem from fuse kernel side. I was
> just questioning that where parallel direct writes become a problem. And
> answer I heard was that it probably is fuse server (daemon linked with
> libfuse) which is expecting the locking. And if that's the case, this
> patch is not fool proof. It is possible that file got truncated from
> a different client (from a different fuse daemon linked with libfuse).
> 
> So say A is first fuse daemon and B is another fuse daemon. Both are
> clients to some network file system as NFS.
> 
> - Fuse kernel for A, sees file size as 4G.
> - fuse daemon B truncates the file to size 2G.
> - Fuse kernel for A, has stale cache, and can send two parallel writes
>    say at 3G and 3.5G offset.

I guess you mean inode cache, not data cache, as this is direct-io. But 
now why would we need to worry about any cache here, if this is 
direct-io - the application writes without going into any cache and at 
the same time a truncate happens? The current kernel side lock would not 
help here, but a distrubuted lock is needed to handle this correctly?

int fd = open(path, O_WRONLY | O_DIRECT);

clientA: pwrite(fd, buf, 100G, 0) -> takes a long time
clientB: ftruncate(fd, 0)

I guess on a local file system that will result in a zero size file. On 
different fuse mounts (without a DLM) or NFS, undefined behavior.


> - Fuser daemon A might not like it.(Assuming this is fuse daemon/user
>    space side limitation).

I think there are two cases for the fuser daemons:

a) does not have a distributed lock - just needs to handle the writes, 
the local kernel lock does not protect against distributed races. I 
guess most of these file systems can enable parallel writes, unless the 
kernel lock is used to handle userspace thread synchronization.

b) has a distributed lock - needs a callback to fuse kernel to inform 
the kernel to invalidate all data.

At DDN we have both of them, a) is in production, the successor b) is 
being worked on. We might come back with more patches for more callbacks 
for the DLM - I'm not sure yet.


> 
> I hope I am able to explain my concern. I am not saying that this patch
> is not good. All I am saying that fuse daemon (user space) can not rely
> on that it will never get two parallel direct writes which can be beyond
> the file size. If fuse kernel cache is stale, it can happen. Just trying
> to set the expectations right.


I don't see an issue yet. Regarding virtiofs, does it have a distributed 
lock manager (DLM)? I guess not?


Thanks,
Bernd
