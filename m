Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE3651A465
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 May 2022 17:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352690AbiEDPuQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 May 2022 11:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbiEDPuP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 May 2022 11:50:15 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2078.outbound.protection.outlook.com [40.107.101.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2501F638;
        Wed,  4 May 2022 08:46:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgEtl0VHlkdr+lEj8jOgEOQ6WIuLczAV1+W84ySeHaQTg46lRIQ9zSLBsUR7nVwFo9KtJTZqTlZzFXeMt7SkPvcQS2/2/KQHaRoMI7hX8rmzEbZ//8pmrUAZrt/peAxH4VRuQiMSksFmgSfH/7n3+5TjJvqHAj6VrueLqTelkqm85Aii6cyrgmm7avB5qDfiMK0STi9sKrzQ/ylj3nwU7HhEXhX3f/qLL9BU7tatCwqWHzByhERbJTbXxUwIGwLhVAjtseeBS7ynvzWfIctUK3piaeHfIL70QNZdwwOSVkyTbMuZ/TI4Muj75QfSF6s7XjHTxlsom5qHMhETTT9j2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7P5dNERTvhSMprfndxUcfc50a0PSZm4rbgO5m1FSO8=;
 b=mwPpNqzCcfcEHgBM4csmpq50HMjNcDMnKPEuULkLa8cfPCtcdXWdDuNCIwuYiUooNfnLtiTb/Rb5037V+M5n45YyY24N9kMh9wUZkMvSXb1UewIwA3Ohv2/tjUod0SSV3XmNNl8pV7m+9sPMw/AV9HNiB9zEWbUTwSV+HrzyJLFWR8hoi2T7Wj6algGSs6kTaeVWMSwVypafRUTaWLM106w5pKOukn3tscn4kA25JIDT1h8f3No3T3BoSKZALzITMMGHuk6+QC3w/PHvxOm1hWehOm7EA7BPL8itWlSqlPnITfSFvE40RnX5NUQynQmJnHfXhAatgx9doYfKhzGxCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7P5dNERTvhSMprfndxUcfc50a0PSZm4rbgO5m1FSO8=;
 b=fbfLLzlw0YeUNDg0mfKTEQU4c5GoyqxzlhKHeJ8IsyRggoiMCtlQlm+tqRG5P+cwC3N/KXu/Mjd0y3N/vC0SYSD3+EywJ/iKcFbsXsRPG+LcdLzbK283XuqeqfDSPYufLTnqu/MpNVSjihbpgs7QZ4uZ3aBION/5oNlFcziZkfg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by DM5PR19MB0057.namprd19.prod.outlook.com (2603:10b6:4:61::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.27; Wed, 4 May
 2022 15:46:33 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::8072:43ab:7fd0:26a]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::8072:43ab:7fd0:26a%4]) with mapi id 15.20.5186.028; Wed, 4 May 2022
 15:46:33 +0000
Message-ID: <8003098d-6b17-5cdf-866d-06fefdf1ca31@ddn.com>
Date:   Wed, 4 May 2022 17:46:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 1/3] FUSE: Implement atomic lookup + create
Content-Language: en-US
To:     Vivek Goyal <vgoyal@redhat.com>,
        Dharmendra Hans <dharamhans87@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org, Dharmendra Singh <dsingh@ddn.com>
References: <20220502102521.22875-1-dharamhans87@gmail.com>
 <20220502102521.22875-2-dharamhans87@gmail.com> <YnGIUOP2BezDAb1k@redhat.com>
 <CACUYsyGoX+o19u41cZyF92eDBO-9rFN_EEWBvWBGrEMuNn29Mw@mail.gmail.com>
 <YnKR9CFYPXT1bM1F@redhat.com>
From:   Bernd Schubert <bschubert@ddn.com>
In-Reply-To: <YnKR9CFYPXT1bM1F@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR10CA0027.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:89::40) To DM5PR1901MB2037.namprd19.prod.outlook.com
 (2603:10b6:4:aa::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2242c03d-a16a-4b11-8f54-08da2de543a2
X-MS-TrafficTypeDiagnostic: DM5PR19MB0057:EE_
X-Microsoft-Antispam-PRVS: <DM5PR19MB0057DD2B167AD47640D78362B5C39@DM5PR19MB0057.namprd19.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sQLAM57LMHvZ5KKz5J13J6OK3b8mazDOIkkej9ht0FfzCDG23jwI/gbArSMLsfYGNlBlJnWwt9ayMyTMAL28cv+SaBk0+UHjU2Jt66mF6KYKL6bX4aCHuvY8pInsAPE5Dq21BcO8MO/SZoC66qpGcm3yMTfiY9fSV+Zyngx5RFoKHtUj6OI23Za2rDgtz5JRfK9gyiPWUEZWq3x9/blflNWburzI0tAMuhatl5VRrfnJhVhB514FohF3jqnjZeyllvSdjDZ6Lk1ojdGtS2DyW+cUIfcRV91Bqs9vpDobLVB683Tc7UWicgGkk0N/gXAhk8KhuSnE2uAL0TezTHvO2kHmJPnDNxsxTCDmV6z33f6FTdSSvp9djas25qld2Rgw6EUpxHCqDswRMYRdKOh1pmS11Ekwz5cbRwnu9uNFCHzTI3UH8uZF+VQ2+js+6+kXXgknsqq/RKy//14NmaFfgQpBES4rl2V2ZhkLDXLZcZyySIh6Cp5H9mKI1es5IIBaC3I7ZyqQM4/LxH4fnYEulGrInbx2wrx5y/UhqqTYfsbsHA0sNGMbHZH2ztnb8LGVGh+PjlozrFEWSIXfdGE6YZ3GVH0b6jWsQJXfYAuhDdTv5HBQ4I8ZYwAuRBcruiatTaJibsNYEvB4tWd0xH+ilufiLK547al22twI3pBqkZFuH/t/RVMERC8gyFLxSAT2gZDrBu3ZfpWe/PCYunuWLdoGdOT8UTIH6Q3vT/M1gOs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(31696002)(2616005)(316002)(66556008)(66476007)(31686004)(66946007)(54906003)(4326008)(8676002)(186003)(110136005)(5660300002)(38100700002)(86362001)(6506007)(8936002)(53546011)(36756003)(83380400001)(6486002)(508600001)(2906002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0FOQkNnMjIwTTlhQXY2N2ZzYTRUQ3F1djB5bm5hWkdTYlh4Z3gzcmFhbyt3?=
 =?utf-8?B?a0Q3dUFGMXZJRFZvdFdMR2pwb0gzZnpjdVlra0d0RUNCZ0hkNnVXdy92ODJ6?=
 =?utf-8?B?VG8vcW4vaXRkbmVkSG9VRGdXQk1UT3c0dHAwcGVKZk1OQzArUE1WNjBYaVR5?=
 =?utf-8?B?aUZ1R1FTTllvWk9QV3dNTG5qSnFuUWo1R3g4SzBYaS93emRVMmhpSDhDT2R2?=
 =?utf-8?B?RjgvMDExTm1sK3JYYy9YZGpLNEovaUVLd3RDZkQycFZnTmNaeFZvTkxJSVR3?=
 =?utf-8?B?NUpTWjYreHlKSkhPL21FdENsY1dKcE5KN29iMmtqSFNLQWxEd0l0M3hZeWlT?=
 =?utf-8?B?ZUphbTkySHd3MVZNVi9QZ2taY2dvOGZwRXY2RlhpMTl3SG5JUFUrT3VNc1U3?=
 =?utf-8?B?TlVvKzZyeXFFLy9MbUNiMCtTODhPT2xlZDhBRDhMNnliNnVvYTUwWmluaVlq?=
 =?utf-8?B?MkFJaUQzdnk4UVNUcDhGazlDVmdSUDMwTndGYWhPdk93akNOQ25lM0k0VWh2?=
 =?utf-8?B?YUxpSENmSUJBUXN2clpyT3hJSDNPUDVPSFVUdllqOVNnUThZY3RnVHlsbktG?=
 =?utf-8?B?UTY3TTVsMkdmb243TE1uODhGU3k0TTcyZHFiZncxZEVwS2JPN2ovQzVud1U3?=
 =?utf-8?B?MXRPZDZqb0syMVFMZ1JNRHpkZ0dWc3hFc2ZOMjduN3ovVHFZMnpmaHZxVlBG?=
 =?utf-8?B?YWcwclV6cWo3Sy9vamw1aXI3ejFlUUcxbHZzSkMyeGxYSkdKZ204ODFmS0Fs?=
 =?utf-8?B?WEFSd2IxWlREU1d4ckY1WXN3K1FBcGc1VU96RVdqZDhhanhRMkdUVnp2NmE1?=
 =?utf-8?B?S0JEZnhjSmhJRjRnaXZXUm1WZlNXY0xjUGlERlV2MVlQNmg5aCt3bXNlVVZY?=
 =?utf-8?B?Y2VqRTcvZXg2b05obkRLMGwwMVo0cGZ3VXBVRzk1cXpiZVhjdGtCUUZ4bkRQ?=
 =?utf-8?B?UFA5MDhOZG9IOURqMkZBMHlrUVMxc3BqZHdDTERVbC9kZ0tRWDYxek90U3BN?=
 =?utf-8?B?SlRYa0E2aXB5ZlJhQU9QZkNzWTYvYmhEZEFqaFJEZmlhcERBVS9NWTBaeHN0?=
 =?utf-8?B?N3ZhQUpXZGg2NE10dTFId1lCVUs3cWFVRm40amR2N3B2eFdVbkFvM3lKV1Fl?=
 =?utf-8?B?RXozTk8yeUhiN2pLR0hPT2ZERUd3NExUYUg3MHVqcnNBOFJkckhlZTRsTFJz?=
 =?utf-8?B?eHhkTjVCbVJsU0FkMlBXZFN5MStPaUFqcFJ5NzEvcFgyM2hPdVIySC9MRFVj?=
 =?utf-8?B?VHZmbE9nTzY0aTFNdXVwU1JTL0Fna3I4NVNUUjk1QUFSRW9raUZ1bU5rcnVE?=
 =?utf-8?B?dyt4aDN2Rjc0Sy9mb3BaUVI1NzdJb2hTS3loUCtuT1pPM2ZKUjEzTm8ydzhM?=
 =?utf-8?B?ckxiWkRNd3NCV21wNGJyZ0hVeWxDNmEwYjN3NUFqMk9hUE4zNTZYNVQzTjJm?=
 =?utf-8?B?bjRhemRVU0pyNlg0VmsyWWlVdVUzS3kzdUtsSkJnMTVodFJ1cWlDYzhhUWpr?=
 =?utf-8?B?UHpvWW9SMGlmQU1rSDJEdXBXazBPZm5raGl4cW10Tm80QmR1QkpZYVVRTEM2?=
 =?utf-8?B?MGpQK2NvUFdlVWFPcVlEb21DMWpVald1eldHY2JBQTYxQVRzTzdZdjZISTlY?=
 =?utf-8?B?Y25qdFZVeXB5anlIUDVpSVF6dXhwTWRjSHdpYXJvcHJtOFJsVGREVFBGMFY1?=
 =?utf-8?B?WVpMVW1uQUdURUF3U2lDWnNRS0oxZmpMeXUrRyt5OGpoM1A2OW9wZmlmVWFE?=
 =?utf-8?B?dVl2T0JVY1JzR091dS9iM0doVGVXbGpLc2IyRHlMY0dSQUxTbHZKYU9pTEJk?=
 =?utf-8?B?UHBPUFcyOE92dTJLOFBFditNQWlXVUlmWm1kdTdjeU1XZTI2Rkd4T1Z5VzZ6?=
 =?utf-8?B?SXlZVjJpYU9naHVZS2VNUGd0YjFZanNyenArN2IzWnFyVFozeXFuSktzOW9j?=
 =?utf-8?B?U1BsbVNrdlNJQldIenh3d0hmSlRtbjJnaDhwWmp0NzU1S0hZWCthZUZ0d1pI?=
 =?utf-8?B?TFJNZVlhRy9DcFhXRUFFQ3lyaVlSZUJ4MjlhRUlNN3ljVFJMQVAwK0h6dHkv?=
 =?utf-8?B?NFdueFpDUkxVV1lsdzdCb014RkdOZWkyaklWM3BMTVJ0YmFxZVp0TW44NUtX?=
 =?utf-8?B?MUFFMmxzVnhWazROK0pYSWdLMVNQSGM5azljMGJJZkc4YWdKRzZQUnhRTTdE?=
 =?utf-8?B?b3JEcWIzRndDTHptaXF6OHJBc3RkaFozSlZnS2oyZVpjV2pVelF3QlNlUTFK?=
 =?utf-8?B?dHp1MTQ4SEdxemZrQ0lwckVYR3g1RDZ3eklDNEJZUXp1NWR6S1czQW5RaUND?=
 =?utf-8?B?a0x6ZWNmYzh6UG56cGN1bS9seDBGZ2RNcUJDUEROUVVPcmxrU3JZaUxvRGJX?=
 =?utf-8?Q?6P1FgDVjN6aTvnWdNTcZhk3Sz+tUqyrpq36aW1T0DufIS?=
X-MS-Exchange-AntiSpam-MessageData-1: RpJLJ4otC8Rg7w==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2242c03d-a16a-4b11-8f54-08da2de543a2
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 15:46:33.3396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0TDZ3vXmnon5q9H3WWBetTa/whHJK8W72Wivg/xbW+K1UXYOAYZJT+FFmrOmkS5RoPRLVhZ2UETReOQ2BmB1rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR19MB0057
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 5/4/22 16:47, Vivek Goyal wrote:

> Ok, naming is little confusing. I think we will have to put it in
> commit message and where you define FUSE_ATOMIC_CREATE that what's
> the difference between FUSE_CREATE and FUSE_ATOMIC_CREATE. This is
> ATOMIC w.r.t what?
> 
> May be atomic here means that "lookup + create + open" is a single operation.
> But then even FUSE_CREATE is atomic because "creat + open" is a single
> operation.
> 
> In fact FUSE_CREATE does lookup anyway and returns all the information
> in fuse_entry_out.
> 
> IIUC, only difference between FUSE_CREATE and FUSE_ATOMIC_CREATE is that
> later also carries information in reply whether file was actually created
> or not (FOPEN_FILE_CREATED). This will be set if file did not exist
> already and it was created indeed. Is that right?
> 
> I see FOPEN_FILE_CREATED is being used to avoid calling
> fuse_dir_changed(). That sounds like a separate optimization and probably
> should be in a separate patch.
> 
> IOW, I think this patch should be broken in to multiple pieces. First
> piece seems to be avoiding lookup() and given the way it is implemented,
> looks like we can avoid lookup() even by using existing FUSE_CREATE
> command. We don't necessarily need FUSE_ATOMIC_CREATE. Is that right?

The initial non-published patches had that, but I had actually asked not 
to go that route, because I'm scared that some user space file system 
implementations might get broken. Right now there is always a lookup 
before fuse_create_open() and when the resulting dentry is positive 
fuse_create_open/FUSE_CREATE is bypassed. I.e. user space 
implementations didn't need to handle existing files. Out of the sudden 
user space implementations might need to handle it and some of them 
might get broken with that kernel update. I guess even a single broken 
user space implementation would count as regression.
So I had asked to change the patch to require a user space flag.

-- Bernd
