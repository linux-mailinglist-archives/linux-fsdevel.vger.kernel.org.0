Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2006AFEB4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 07:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjCHGEv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 01:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjCHGEu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 01:04:50 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87772B288;
        Tue,  7 Mar 2023 22:04:48 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N8XPt-1qeFMG1dtB-014Wun; Wed, 08
 Mar 2023 07:04:34 +0100
Message-ID: <5aff53ea-0666-d4d6-3bf1-07b3674a405a@gmx.com>
Date:   Wed, 8 Mar 2023 14:04:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20230121065031.1139353-1-hch@lst.de>
 <20230121065031.1139353-4-hch@lst.de>
 <88b2fae1-8d95-2172-7bc4-c5dfc4ff7410@gmx.com>
 <20230307144106.GA19477@lst.de>
 <96f5c29c-1b25-66af-1ba1-731ae39d912d@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 03/34] btrfs: add a btrfs_inode pointer to struct
 btrfs_bio
In-Reply-To: <96f5c29c-1b25-66af-1ba1-731ae39d912d@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jHoIq4V9I6P8AHOnPYOiJ5R27Ssn8X5wQSX4vavWLDjJ/ZBGT8t
 Ikr/j7+hJO54u1oi/kHO0nqUJyz+nWB1mYUb4nX7+4kMiw5l6j1bLb+/GHdHIqevW7mL/IR
 02cfCNLzXNDYZD7zkrAVnRiWSTUJPxmPzOtI1DbUn3IyVev0sGEaechnL0/BQ8gaB1YVPfI
 D94IOns6PsUL7B4n79C0A==
UI-OutboundReport: notjunk:1;M01:P0:datC4IgmbY4=;G7YIPxDWvdtHvKTPCwYKEQ+X2PA
 yQLOg1tsqrpjzUjbUR8X3R1ccmEOTVYWL3aE9lRoQBLdqr9GzapMHTNwkcfro6ipe0pujsTwd
 DDth1Hh3LJcErAQ1fnYMjyU4VEQanOQEZ0qtIeTrPjF5+APkPywrLVJUIu1v8jRTgEOjyaRCL
 FCERCJM0E85InsX6GkzLnez69hg46ydLr0n5FbgxJBLZ9TsJAhbCNsbrO+zIwXc4tYjV+opud
 tFO+AC2u3N2tyPpH9BjlxX+409WO9jmuE46tooGQewMEogoJDgqelnsbVIlQiLcoSYggdzyAN
 gMFiIXkLilH9vglkop5eRFkcfq/B2ybcinFaB7FCUkvBnGgPIsCdNGU8PMC5J4Qsr77ab2pnb
 pEX5OD2j6dKcv6nHU6X5NKU0GE5wU2XdW4dGxZp5rsjx8MHvkat49Tfie+RgSTohXqMiqaGG1
 gq8iVscbJ+rv/ZzEXEJbpMuqmTSZVI6Iy+lS8PA9PW7JWUp/yPvx4X2bPcic998PIJgLUzoRu
 yCqYPirbTof2DKTlSYD6qn2uHg4S8aZnq5OB4yG7OcsjC9ydInGoQPICfvytnMFbcANmsxHwM
 vQaZP0gv+PZieaKHEIt07N9eTFPwBOhUXuId5gindFxxnx36HjJatktLtTkCd/ypArvDzqFnN
 DdelMbbfzZxG/3D1LI4J1gFgju00RZbqePkclwQLsuqPbxtVPTzcsrj4j7YkhDEfVLPLO8cFL
 bpoiBZ+X+HWuBB+yhZmdr5/4tk85ZbU2Cx5PkmlSbl2zp1hUtVJbFGR7DCmeUmbVgXNN+jCfX
 npnlvq4yctssYh1U1LJOaI2XpmxFNRmrBAf17BjCqqftwQdHjRK15e3FxZQmB2jPpiinq7IWr
 //fG43sNnhaHxZUlDANb3UC0spSUo4QkM6UcOoFXbRIlm0BHxfZJBatnff8dESMYYShND470s
 OyrcemC32DeaKOUhKliVhrsPwTU=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/3/8 06:21, Qu Wenruo wrote:
> 
> 
> On 2023/3/7 22:41, Christoph Hellwig wrote:
>> On Tue, Mar 07, 2023 at 09:44:32AM +0800, Qu Wenruo wrote:
>>> With my recent restart on scrub rework, this patch makes me wonder, 
>>> what if
>>> scrub wants to use btrfs_bio, but don't want to pass a valid btrfs_inode
>>> pointer?
>>
>> The full inode is only really needed for the data repair code.  But a lot
>> of code uses the fs_info, which would have to be added as a separate
>> counter.  The other usage is the sync_writers counter, which is a bit
>> odd and should probably be keyed off the REQ_SYNC flag instead.
>>
>>> E.g. scrub code just wants to read certain mirror of a logical bytenr.
>>> This can simplify the handling of RAID56, as for data stripes the repair
>>> path is the same, just try the next mirror(s).
>>>
>>> Furthermore most of the new btrfs_bio code is handling data reads by
>>> triggering read-repair automatically.
>>> This can be unnecessary for scrub.
>>
>> This sounds like you don't want to use the btrfs_bio at all as you
>> don't rely on any of the functionality from it.
> 
> Well, to me the proper mirror_num based read is the core of btrfs_bio, 
> not the read-repair thing.
> 
> Thus I'm not that convinced fully automatic read-repair integrated into 
> btrfs_bio is a good idea.

BTW, I also checked if I can craft a scrub specific version of 
btrfs_submit_bio().

The result doesn't look good at all.

Without a btrfs_bio structure, it's already pretty hard to properly put 
bioc, decrease the bio counter.

Or I need to create a scrub_bio, and re-implement all the needed endio 
function handling.

So please really consider the simplest case, one just wants to 
read/write some data using logical + mirror_num, without any btrfs inode 
nor csum verification.

Thanks,
Qu

> 
> Thanks,
> Qu
>>
>>>
>>> And since we're here, can we also have btrfs equivalent of on-stack bio?
>>> As scrub can benefit a lot from that, as for sector-by-sector read, 
>>> we want
>>> to avoid repeating allocating/freeing a btrfs_bio just for reading one
>>> sector.
>>> (The existing behavior is using on-stack bio with bio_init/bio_uninit
>>> inside scrub_recheck_block())
>>
>> You can do that right now by declaring a btrfs_bio on-stack and then
>> calling bio_init on the embedded bio followed by a btrfs_bio_init on
>> the btrfs_bio.  But I don't think doing this will actually be a win
>> for the scrub code in terms of speed or code size.
