Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1166AF87A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 23:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjCGWWB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 17:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjCGWV7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:21:59 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585AEE055;
        Tue,  7 Mar 2023 14:21:58 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M4b1y-1pY1nG3MBS-001eXY; Tue, 07
 Mar 2023 23:21:41 +0100
Message-ID: <96f5c29c-1b25-66af-1ba1-731ae39d912d@gmx.com>
Date:   Wed, 8 Mar 2023 06:21:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 03/34] btrfs: add a btrfs_inode pointer to struct
 btrfs_bio
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
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230307144106.GA19477@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:e1Ke+vXVlsKJ++zVehuc+AJhjvv9pTgMQFuUeyblgEIczKAlf7N
 G93Dg6SwYbI2+qYogqGGxyjCI1S+HhT7jcX03u0N/hzQqt1ZQam1ZUc/YeUGq9j0dWZHbU5
 GUqkN44Nr8TApAxzcQ9+5W0JvfWalsEtDCH9FFAS8pGqO92YIdSvutXJEpIqoao8x9eW21S
 ISHcn1W37xu28T5FKsRnQ==
UI-OutboundReport: notjunk:1;M01:P0:th6cQcUJOvo=;neg31cJGh5KjgaeGl2d78+kuA3/
 Ia5rUrpAS9eGbbhHZu//gEJTV+O3ZRrbqo0sJav6gkUME5jlog8GU+yf5TO5ksWmX76BA5p7a
 jLKAnBkzUaYa7f+LRs4sM4J36zv8zcxkMsLtSocPmzwoCdm/RM+cPNW0v/xvmB8wMHDb66CmI
 smpGUMGqIIi4k4Faj6KjZyaaIttaYBbwBrVK5cHVy6UGufe9HaaH+pp8/UtIKfsaEUTgwSpdT
 dmmmrbEgQ4Gttl8Du/RFOm7DJU9wXbMAu+nuhoJrk5P8asN8TG2xqoVDCmuDxaO/REJz7by05
 aqLbfxINKhEsxe0M861//ny0nuM++5KveobIR0pWBb72R0ofvSARsB+6HRoqC+fX6cwUIUDmw
 J9Y22BORbVDTukX5szqDtKn7Myi/AYhncpUEPje52J/uHSr1VOUNcQr8oXTOn7u1VoSo59n7D
 4CrBMKT4Ja9TOyTauuN1u2IuT7VV/hbUchvI9JXFqFEZZsj7x5dm6vLIJ4+n/+LU4BTs6NqiS
 U2x4Kdek3b9x6Qbe5HpY8rQ6Cl05pfGp9SyNT62qKWj6S2HIBeAn5jsiwla06Y0I/3AInxg34
 MEvgd/360acXo1NGeABBYkKWhNJ1UNoz9qpNzTVNEuK3rH7CqohKfIUOLMG6G8lc/fFMEC+lm
 57w7EmG9NRF/0lC8gAATQXLi7z6aAU/uZQ3rwFQJQGf8wPXiNIUW5XJpm9SOxMHs2XeKI/uYg
 SH9R/8JKemObQdLqmJWtgBaLRWVX7bohfGzUSXsOAM9/mk9ciornL+J+9+Xnhj3w+zWpDxcYU
 Uko/43zq5Sb2pec288kaRlhZowYxJ8XiJNkQ8hjickHRvxoZ0LmVbQzNp+iENH8zliveAi0OS
 9KLJFgJeLzYI7Kl5s3IOqQNyM+DMQuJXrTB56+CxMK9vdJrBDvcVeJFlZTrdXYnOfsUWsN9Tr
 xh8f9BhyPgoimYHFcAHup0miRIc=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/3/7 22:41, Christoph Hellwig wrote:
> On Tue, Mar 07, 2023 at 09:44:32AM +0800, Qu Wenruo wrote:
>> With my recent restart on scrub rework, this patch makes me wonder, what if
>> scrub wants to use btrfs_bio, but don't want to pass a valid btrfs_inode
>> pointer?
> 
> The full inode is only really needed for the data repair code.  But a lot
> of code uses the fs_info, which would have to be added as a separate
> counter.  The other usage is the sync_writers counter, which is a bit
> odd and should probably be keyed off the REQ_SYNC flag instead.
> 
>> E.g. scrub code just wants to read certain mirror of a logical bytenr.
>> This can simplify the handling of RAID56, as for data stripes the repair
>> path is the same, just try the next mirror(s).
>>
>> Furthermore most of the new btrfs_bio code is handling data reads by
>> triggering read-repair automatically.
>> This can be unnecessary for scrub.
> 
> This sounds like you don't want to use the btrfs_bio at all as you
> don't rely on any of the functionality from it.

Well, to me the proper mirror_num based read is the core of btrfs_bio, 
not the read-repair thing.

Thus I'm not that convinced fully automatic read-repair integrated into 
btrfs_bio is a good idea.

Thanks,
Qu
> 
>>
>> And since we're here, can we also have btrfs equivalent of on-stack bio?
>> As scrub can benefit a lot from that, as for sector-by-sector read, we want
>> to avoid repeating allocating/freeing a btrfs_bio just for reading one
>> sector.
>> (The existing behavior is using on-stack bio with bio_init/bio_uninit
>> inside scrub_recheck_block())
> 
> You can do that right now by declaring a btrfs_bio on-stack and then
> calling bio_init on the embedded bio followed by a btrfs_bio_init on
> the btrfs_bio.  But I don't think doing this will actually be a win
> for the scrub code in terms of speed or code size.
