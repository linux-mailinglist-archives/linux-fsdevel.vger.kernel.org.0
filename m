Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9653D4A247
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2019 15:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbfFRNeD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jun 2019 09:34:03 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44599 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfFRNeC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jun 2019 09:34:02 -0400
Received: by mail-qt1-f193.google.com with SMTP id x47so15230102qtk.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jun 2019 06:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uESHdIPMr1/2I8R4apfsQXdORt5EllcKdhz30TRq9+s=;
        b=SGIjcRfjTQPUsAhNx90ES669WIHnpYBE7Vzbgcc9KMOW9MAywDsUZIv2G/R4LfV2M+
         2LsnZzuYigyPY1J6gEHM3x8R4YtQnIUA9Vv7Sdk5AIbMc87ZHs3hnlosIk7SMRI/UQk+
         0V7/Wubit590Sk0vWPTTGIKZV1X2CRsoNZseJh6vw6Vm7BCoSuJ7uUtowk+B3CRXipvv
         gZ0Ggew6XDCbOm7saHGmt+g2SxPKCDPZFeXbJBHG2n71U1nI66ZTr8uYj2Dosb/IWtMY
         T37WCxShSheVxEBWOAo7k9pOYBrLRW1afS52oyo5dybQmJTFWcAZOmvgEFCp+crZdI2+
         wdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uESHdIPMr1/2I8R4apfsQXdORt5EllcKdhz30TRq9+s=;
        b=M4Hx4VRsGteR2RvXnoRq4TAn7+SCRy9NJLZCDUVQSKQ72kFaEZdvnUf382HHLKo9Nc
         m5xrqQ1L0f9EI1cDgB1s/TZ20XELrXcCFc4F/fL1ycnkQWLkCst/yhFQuiMWRwRSXasN
         +3b5kogZ+GDqaP/1zkyUZJ92hPkwANsFOL02SN0EdO7IwGfRJMMwZ6jET/oL/HV2rlTT
         guKT125HkEHTaFddVJP9F61QniCH8qQEU4wcNbfG0BtR1Esl10jaekj91QO33/wIwYTC
         S8/PqQ2ExXbm09bMpuO9KILN5BO1X1PmwwANtPXCHnUFAzUZMHELb4k7pk6GaUBgsAnW
         25vA==
X-Gm-Message-State: APjAAAV+x7LaRjCtWsaPR4Uhapi6SmSptZTDX6PeybcQMPlU/K9k4IB0
        W3oZaNKGmQjAHMZKbU76mx1gJw==
X-Google-Smtp-Source: APXvYqw/NY0+diPdp7TeJ0U/wX2Blgzw4e+gsafs2o0OprtgRoc1/dpCLwmQMVwIB+MyuV9LmnynGA==
X-Received: by 2002:ac8:24f5:: with SMTP id t50mr96953830qtt.285.1560864841328;
        Tue, 18 Jun 2019 06:34:01 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::a0ec])
        by smtp.gmail.com with ESMTPSA id v9sm7627054qti.60.2019.06.18.06.34.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 06:34:00 -0700 (PDT)
Date:   Tue, 18 Jun 2019 09:33:59 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 11/19] btrfs: introduce submit buffer
Message-ID: <20190618133357.l55hwc3x5cpycpji@MacBook-Pro-91.local>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
 <20190607131025.31996-12-naohiro.aota@wdc.com>
 <20190613141457.jws5ca63wfgjf7da@MacBook-Pro-91.local>
 <BYAPR04MB5816E9FC012A289CA438E794E7EB0@BYAPR04MB5816.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB5816E9FC012A289CA438E794E7EB0@BYAPR04MB5816.namprd04.prod.outlook.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 17, 2019 at 03:16:05AM +0000, Damien Le Moal wrote:
> Josef,
> 
> On 2019/06/13 23:15, Josef Bacik wrote:
> > On Fri, Jun 07, 2019 at 10:10:17PM +0900, Naohiro Aota wrote:
> >> Sequential allocation is not enough to maintain sequential delivery of
> >> write IOs to the device. Various features (async compress, async checksum,
> >> ...) of btrfs affect ordering of the IOs. This patch introduces submit
> >> buffer to sort WRITE bios belonging to a block group and sort them out
> >> sequentially in increasing block address to achieve sequential write
> >> sequences with __btrfs_map_bio().
> >>
> >> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > 
> > I hate everything about this.  Can't we just use the plugging infrastructure for
> > this and then make sure it re-orders the bios before submitting them?  Also
> > what's to prevent the block layer scheduler from re-arranging these io's?
> > Thanks,
> 
> The block I/O scheduler reorders requests in LBA order, but that happens for a
> newly inserted request against pending requests. If there are no pending
> requests because all requests were already issued, no ordering happen, and even
> worse, if the drive queue is not full yet (e.g. there are free tags), then the
> newly inserted request will be dispatched almost immediately, preventing
> reordering with subsequent incoming write requests to happen.
> 

This sounds like we're depending on specific behavior from the ioscheduler,
which means we're going to have a sad day at some point in the future.

> The other problem is that the mq-deadline scheduler does not track zone WP
> position. Write request issuing is done regardless of the current WP value,
> solely based on LBA ordering. This means that mq-deadline will not prevent
> out-of-order, or rather, unaligned write requests. These will not be detected
> and dispatched whenever possible. The reasons for this are that:
> 1) the disk user (the FS) has to manage zone WP positions anyway. So duplicating
> that management at the block IO scheduler level is inefficient.

I'm not saying it has to manage the WP pointer, and in fact I'm not saying the
scheduler has to do anything at all.  We just need a more generic way to make
sure that bio's submitted in order are kept in order.  So perhaps a hmzoned
scheduler that does just that, and is pinned for these devices.

> 2) Adding zone WP management at the block IO scheduler level would also need a
> write error processing path to resync the WP value in case of failed writes. But
> the user/FS also needs that anyway. Again duplicated functionalities.

Again, no not really.  My point is I want as little block layer knowledge in
btrfs as possible.  I accept we should probably keep track of the WP, it just
makes it easier on everybody if we allocate sequentially.  I'll even allow that
we need to handle the write errors and adjust our WP stuff internally when
things go wrong.

What I'm having a hard time swallowing is having a io scheduler in btrfs proper.
We just ripped out the old one we had because it broke cgroups.  It just adds
extra complexity to an already complex mess.

> 3) The block layer will need a timeout to force issue or cancel pending
> unaligned write requests. This is necessary in case the drive user stops issuing
> writes (for whatever reasons) or the scheduler is being switched. This would
> unnecessarily cause write I/O errors or cause deadlocks if the request queue
> quiesce mode is entered at the wrong time (and I do not see a good way to deal
> with that).

Again we could just pin the hmzoned scheduler to those devices so you can't
switch them.  Or make a hmzoned blk plug and pin no scheduler to these devices.

> 
> blk-mq is already complicated enough. Adding this to the block IO scheduler will
> unnecessarily complicate things further for no real benefits. I would like to
> point out the dm-zoned device mapper and f2fs which are both already dealing
> with write ordering and write error processing directly. Both are fairly
> straightforward but completely different and each optimized for their own structure.
> 

So we're duplicating this effort in 2 places already and adding a 3rd place
seems like a solid plan?  Device-mapper it makes sense, we're sitting squarely
in the block layer so moving around bio's/requests is its very reason for
existing.  I'm not sold on the file system needing to take up this behavior.
This needs to be handled in a more generic way so that all file systems can
share the same mechanism.

I'd even go so far as to say that you could just require using a dm device with
these hmzoned block devices and then handle all of that logic in there if you
didn't feel like doing it generically.  We're already talking about esoteric
devices that require special care to use, adding the extra requirement of
needing to go through device-mapper to use it wouldn't be that big of a stretch.
Thanks,

Josef
