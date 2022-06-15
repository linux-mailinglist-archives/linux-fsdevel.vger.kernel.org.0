Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A206554C8A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 14:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344921AbiFOMfg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 08:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243457AbiFOMff (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 08:35:35 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9378A3057D;
        Wed, 15 Jun 2022 05:35:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hxmp9d+5KYx+1sl3Ryfwx2Ru5kwlr0xFriLeEhov6bypYsJJv86IvsFlP0DR3UfrU+JF55tHeBMLCjLcNL7RPpVTxB8bdtzC2aQY9Y4n4NEQyLIE99tv0yxhJ0TqMjSXv/MN6Qbf+r1LeLge2kBWkN21KAUqX8xuQjOHB18dvSkK6/cyBpls1/Dnd6RZ2cDP5gvEoxQHyqkGLdU8r0t2RBKMgQzlwWtSE9Je0lKUGin15iBpG25wroRC6cfqdic7rp8SfrYM9SOxjrGVU0YH9ZscQwQa6RygRMt+OJIyLNlSulh667ev28qSEjU0ZuOyxykevGjzQxBtNF75raGi3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBsB15QHb2e3BP5C0cRXuymKg2tuz7g8M/n6PB3FVew=;
 b=NuK8Rd29x1asUv4ptDHxDRfPnAPVqDBaqCc5dCvmer39GnaQ+bX4K9KFgQw+MuXx9MR/cc9noPz8QgAs4QNO04S5oyWUJvER89TdElNweoZw7dgC5YT4Xgd+RyGS2jYDKr6msOyVmWFPyGKBtkHuTFdRGhwpnv1hlvcD9V8f6Dk4VCeHrP7yfHHA5fUhzxNBzYEbH3XV+MEpHvqMEB0kjjPJeuKIHuxV5iZ2QgOFKV/12vn7fcEZzAYbJ7ADe/iWnqVqfFC+6gymeRUhEx9HwIfG2IZ5b2+5TKXPNt1yC5NnVOE4AN0jd9EbaFCt2RmVk3qo7vBgYi3SzTzu/OJyEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBsB15QHb2e3BP5C0cRXuymKg2tuz7g8M/n6PB3FVew=;
 b=iL957Z4cI8aF+9GNZVscUFS7vnZUz3VKB9YKJhDqkojzNzIxQCcDkEJZDOUT4UQDMGH8x3uMRXguGR/AEeq9dQz8Qy5pmqSnDktZkbyUa1FZq3CL00tMEYYksaHBNvoC5ZLcViRTdCDmCbETH0y7r9Ax96L2uSwh/97/RQi742w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM6PR12MB2988.namprd12.prod.outlook.com (2603:10b6:5:3d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Wed, 15 Jun
 2022 12:35:30 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e0fd:45cf:c701:2731]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e0fd:45cf:c701:2731%6]) with mapi id 15.20.5353.014; Wed, 15 Jun 2022
 12:35:30 +0000
Message-ID: <9e170201-35df-cfcc-8d07-2f9693278829@amd.com>
Date:   Wed, 15 Jun 2022 14:35:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 03/13] mm: shmem: provide oom badness for shmem files
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        alexander.deucher@amd.com, daniel@ffwll.ch,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        hughd@google.com, andrey.grodzovsky@amd.com
References: <YqIMmK18mb/+s5de@dhcp22.suse.cz>
 <3f7d3d96-0858-fb6d-07a3-4c18964f888e@gmail.com>
 <YqMuq/ZrV8loC3jE@dhcp22.suse.cz>
 <2e7e050e-04eb-0c0a-0675-d7f1c3ae7aed@amd.com>
 <YqNSSFQELx/LeEHR@dhcp22.suse.cz>
 <288528c3-411e-fb25-2f08-92d4bb9f1f13@gmail.com>
 <Yqbq/Q5jz2ou87Jx@dhcp22.suse.cz>
 <b8b9aba5-575e-8a34-e627-79bef4ed7f97@amd.com>
 <YqcpZY3Xx7Mk2ROH@dhcp22.suse.cz>
 <34daa8ab-a9f4-8f7b-0ea7-821bc36b9497@gmail.com>
 <YqdFkfLVFUD5K6EK@dhcp22.suse.cz>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <YqdFkfLVFUD5K6EK@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR04CA0063.eurprd04.prod.outlook.com
 (2603:10a6:20b:f0::40) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ee299bd-72c5-420e-bfe2-08da4ecb889c
X-MS-TrafficTypeDiagnostic: DM6PR12MB2988:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB298839FBD123EB5C91226E5D83AD9@DM6PR12MB2988.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3MKDx0tiesF6XaqBkDqLJbrNbcN+G+4VSoZJ549VJF7deZtjLxomv7sRbNJixNTHLZuf6rHvctlOv/ainko3rsqV/lkkgguVe9hQ/hn9DwzDMpXTI2HsbMuuhGI/tmNPZBtzXtms752PcJGvw0rcFr84+TwfVgXoX05+8Y2UpxzOULhMvRBBo2p1DmyOGBof6/RSftqBfQG5NF5SeRQEDX9BnMQKwdJd6bbe5TmFjo4wXJtF8SEazobtDBSGMMBJxle+bF3ip7cBy/+2bzzr+SXs6Ir7VVt/7lLqKxwwcOz4VFopFD7zRy9E1+BbNdJe7XL1nH2R6GkgZYPWv4W8p5fHQRlPikkc33mebuaQiqYTuO9W2X0XqgMxbi/Hm91mmnfJZyCgR2qyYdp8cX6f3AOQ4ttRYf4Hm+ooKaAUNIz3AcOQcDAXjqAS4yQ3FaeF/joMYFW9APaLUMZ8r42jBshefT5Aa+JmqV/m6e3dyI24s41g0BGS42v8no9vInlohOX0x9g3DBTL3nJr8O/yX9G7RQ0jLYQA+9RdOaoKk4aRjK3VJs++f7SPh+9+6jYWiW9aZL9p1KtUmnTK/6WDVM3xRGQ+Dn8DCvzqzVn5o0IVnHPibu8V+6MgWjvEI/e2xlBK6SbD+ZYS4ZevPDORSTfUJc9OMLlEZqOz991N9Ge+Ki/SRdOVmYXL9LnO7gi/Ltgzp1TJR3imCfA8CXiddc1+2kWxb01ITGAmysljTCLqtyKtotql2STiX6EN0w3v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(86362001)(5660300002)(7416002)(66946007)(2906002)(6486002)(66556008)(508600001)(110136005)(8936002)(186003)(26005)(6512007)(2616005)(83380400001)(38100700002)(36756003)(31696002)(4326008)(6666004)(8676002)(316002)(6506007)(66476007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3JXNHRqUldxNTJTL1EyVkRYYmVESzJDSGJjd0hIeGRpN2lmdmtJYVpJU1Zn?=
 =?utf-8?B?OWM4M0FTWnVUTG1XME9Pb0dhVS9YdlNES2dDTm5WeHA3NDZQejBpYU91R2Vw?=
 =?utf-8?B?WDk4bG9YNE45V2FqOEhyZE1yU2ZqZEUwN0FmRUhsU0VraWl5ekJMWG5OZFZP?=
 =?utf-8?B?aG5qd3hxV3kxc2NpWnpqV2pkRk85bzBGK0l2VHNFbFg1V3BmdFFmVWZqSGd0?=
 =?utf-8?B?M2hkZSs3M0tneXpUa0JSczFvTjFKMkdXZnZXQmNyU2hqbkxwckdPOVE1aUg4?=
 =?utf-8?B?ci9RYzNNVnEyL0JwQVJiUWVCQmJYbzM2TERoS3ZUcVR2ZUI1TUk5VWZ5eUtr?=
 =?utf-8?B?UDhxOUN0NUVFSUZTTk1ScTE5QmpzV2RMTGtnVCtoVnZOb2EyS1o0aTJCaWt5?=
 =?utf-8?B?RXJpRGk4QkRVQVl5Q3hUM0lseUVscm03RTZwdjRXNmluaWVtUVdxYy9jZjlp?=
 =?utf-8?B?cWdjZlVoRG1RY3JvZm9OK2kxTmtNeUFtcG1ZSCtncUhSNzRCT29sTGZueHpt?=
 =?utf-8?B?U3VFNGVoUnFZUEdGaE9BWkxwSzBkVHA2WERUeWFyMkx2dnJpYkVQUHk3ZE01?=
 =?utf-8?B?bDhlZFdIY2dPOTVFdHErY1V1cGNZVDZXV0Y2WFE2NUtJb3RnTEJVamVkZVds?=
 =?utf-8?B?bzBOZnVIdDBEVHFCeXBFaUNJbzhnY1dGS1dyQTBMVm1PR2o4RldvbUVlaXFk?=
 =?utf-8?B?a2IwemEydXJFZGlMcmVTaWVaSGlVNlJzMEd2clA3NmNPbWpYNkdoQU5yRFll?=
 =?utf-8?B?UXNrYmpYay84M3ZRdmRaQ0lYakMxLzNncW9LNlJQVVRUMTRyNXdmYU0xSmJT?=
 =?utf-8?B?eFB0SkQzSUY4MmtQWFR4ZjFoeFUxblkyTkNoVkZrUEVLUDZSZ254N3crbGEw?=
 =?utf-8?B?K1BhL0VDMHhQVVFqTkIvajZVUnBqVnVVaHU3S0EwcHVoV3daTllVUmpvK3Nx?=
 =?utf-8?B?UUJDb1RLK0dtMmlkenJZY1p3ZzgwQjVlVHEvcTEwZ3dmMVFrMDlSWDhrdVdO?=
 =?utf-8?B?WHJlNHR2bVY5MzhRWE9qV0tzUXF0UzBoWDhFME5OeFByZHVScFQ2dmJ0VE9E?=
 =?utf-8?B?VHplVy9YNGREQUpFN0NrTmtlUm1TSkU2cW8yVEZBQkNiVXRRM3dpU2EzNTN1?=
 =?utf-8?B?UHFLeDFLREdad3dXNGFHRUJKb3VMVlZrRnlCYTA5RHF1LzZEQ29wV0kyQVJl?=
 =?utf-8?B?anpoNXJUcTZ0RzRmNkF3V1gxTmdxL1dIcnIrZmJVZjEyTXFSZ1NBLzRCbWl6?=
 =?utf-8?B?WGtFMEJCcWVNOXVrSzY5eExZWmFTa29LWUhEejc3UHhJY0hNYVRpSjZDenBj?=
 =?utf-8?B?UkhlcjMyWDRseDFMOGlWMWdUL1p1eGp2WlFUZHRBZGh2cFFiOWlWbDJwTUEx?=
 =?utf-8?B?NnIveEVwM25xVG5Qd3o1azhmcXoyZFlPckNQZ0RYeHNwUStTZ0paMC96U0hj?=
 =?utf-8?B?RmhCNXNaajU3QmRnc09DdFBmRmUyZmdkbXliREhKUWN5WEFXYVQ0VjM1VnNw?=
 =?utf-8?B?L3VYNWppWVdmZGhqY1J4QkErUEM4RFFINW50ckVLa2xTaVJFM2xCNFVjeXlY?=
 =?utf-8?B?VFRkOEhpdHVwRHkvQVllcFJ5MzNWUTRGdXQ5c1Q3Q1M5bFkwVVo3SGZZTDZJ?=
 =?utf-8?B?alU5NlNta0o2Ums1cytIeDR4NGJNNTBKZjlBajExbGdlMTEraGY2c3pjeWZO?=
 =?utf-8?B?NjJ0dnhPRDJzdDdtQ1Jsd1dNenBWd0p1Ukx5c0JNditvbTNyOVFuTUtHTU9n?=
 =?utf-8?B?QnhUK0QzZFFFS1h3dFliTllYd3JYazMrQlF1ZVVGTlNUcXV2TmlWMHNMUFU5?=
 =?utf-8?B?dnNJZ0M0YWtyR3pJT3FwQ3I2ZzJHTHQ5SnRya3l0cWlqMEhMOUN6ZkdKL2dn?=
 =?utf-8?B?YWNVRzRLT3dzT0dOMzdjdFFlNXdYaDN2RlE0eElUZXNtamtpTVdqeVN0Ry9R?=
 =?utf-8?B?bE5OMFlrbnhKZnFhaG9IWHZBU0IyQVRNN2R5SDhDTmF5cVd4TElDZWxZZTVj?=
 =?utf-8?B?Yk1DaE1vTHFTMXhEbWVpUWtGbS9wYVFNQ1RwYjZlYmNRSVhTaWtWR3MyMzFG?=
 =?utf-8?B?ZVNVTTJjbktVTFoyQjVHZWxxMGxiSmhvVG5lN1hraGhqc0JFR1lmRDhWNUxG?=
 =?utf-8?B?S2FxOGE2WUlWMjVjTmNuQ3dMbm5UL1Qyc0J6WTRrNEt2K05qZkdTWG8zNTIw?=
 =?utf-8?B?c09Td0ttVDdnVi9SVURobGZNMlRSVzUwakxRby82cXBRaDRsSytma1p0N3hN?=
 =?utf-8?B?c25mcCtWTmxNODl5NjA5bDBXaDhHM3k4eHVmR0JoMndsblY3dUlhWXQwdXhX?=
 =?utf-8?B?RlljZnN4amxiVXhCaTBsOXl4ZHdybXN5Snk3d2hMSFExT0RKSUphUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ee299bd-72c5-420e-bfe2-08da4ecb889c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 12:35:30.6304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HB9uEk9iA0wbSI9UmNPGku71foBYSRHmaKfRo9QDa1Pai1HOcRKOIb5itTnyhCLk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2988
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am 13.06.22 um 16:11 schrieb Michal Hocko:
> [SNIP]
>> Let me maybe get back to the initial question: We have resources which are
>> not related to the virtual address space of a process, how should we tell
>> the OOM killer about them?
> I would say memcg, but we have discussed this already...

Well memcg is at least closer to the requirements than the classic 
mm_struct accounting.

It won't work for really shared buffers, but if that's the requirement 
to find some doable solution for the remaining 99% then I can live with 
that.

> I do not think that exposing a resource (in a form of a counter
> or something like that) is sufficient. The existing oom killer
> implementation is hevily process centric (with memcg extension for
> grouping but not changing the overall design in principle). If you
> want to make it aware of resources which are not directly accounted to
> processes then a a new implementation is necessary IMHO. You would need
> to evaluate those resources and kill all the tasks that can hold on that
> resource.

Well the OOM killer is process centric because processes are what you 
can kill.

Even the classic mm_struct based accounting includes MM_SHMEMPAGES into 
the badness. So accounting shared resources as badness to make a 
decision is nothing new here.

The difference is that this time the badness doesn't come from the 
memory management subsystem, but rather from the I/O subsystem.

> This is also the reason why I am not really fan of the per file
> badness because it adds a notion of resource that is not process bound
> in general so it will add all sorts of weird runtime corner cases which
> are impossible to anticipate [*]. Maybe that will work in some scenarios
> but definitely not something to be done by default without users opting
> into that and being aware of consequences.

Would a kernel command line option to control the behavior be helpful here?

> There have been discussions that the existing oom implementation cannot
> fit all potential usecases so maybe we need to finally decide to use a
> plugable, BPFable etc architecture allow implementations that fit
> specific needs.

Yeah, BPF came to my mind as well. But need to talk with out experts on 
that topic first.

When the OOM killer runs allocating more memory is pretty much a no-go 
and I'm not sure what the requirements of running a BPF to find the 
badness are.

> [*] I know it is not directly related but kinda similar. In the past
> we used to have heuristics to consider work done as a resource . That is
> kill younger processes preferably to reduce the damage.  This has turned
> out to have a very unpredictable behavior and many complains by
> users. Situation has improved when the selection was solely based on
> rss. This has its own cons of course but at least they are predictable.

Good to know, thanks.

Regards,
Christian.
