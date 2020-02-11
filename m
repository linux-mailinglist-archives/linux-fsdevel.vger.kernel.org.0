Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 364E41587F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 02:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbgBKBbW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 20:31:22 -0500
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:57241 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727599AbgBKBbW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 20:31:22 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 99B2C3BE;
        Mon, 10 Feb 2020 20:31:20 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 10 Feb 2020 20:31:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=y/Fnv943LYH/Lk/Amb909SmXxb/
        iCqOAVAq5vX+rEoY=; b=Kox7VrMJzfNc2khvsfALGd1cFbgRBrSDWo6qp6J61v2
        nzeoWKK5l+oxPo9FfDJ3fp0jNo5O9l18csC2riph4GT4yQexFQ9hf4ogWY9NGZTx
        Jp07f/0z4S5KZQ9Kmj+Kn6SMtzrAnOUrS+3lNFKXYT79ROzauxkMR8mD/PDLzvJf
        DNcoIR4KJY++Q65g50oBJovqnzDPwZhD6PRaIfowSjaeOf3y8QQZHEYArr0ZNY6B
        hG5K2CIoge9O9NkRskXBzIKLLDM1+Z3Mbi9YIU0DcC1Wpk/YTLcJ4AUtSwTJMc39
        iKv2aM6LU5JDyym40rlNh7u9sJQP+GIDaS2ZVpkn9Tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=y/Fnv9
        43LYH/Lk/Amb909SmXxb/iCqOAVAq5vX+rEoY=; b=LTniJWHNoESl1lWEuvhOBU
        7RKw/FDmw2nT+BEB8ggI9dwN19EtHAGHXlzNJKgP4ngoG/W/3IyNL6a33+uEcYqT
        J/smPupvfhqOw7jOQz4/wYXuvfA3RtykQ1DUFuWkEkqrEiNOB4eq5OzLzT9KayEl
        xv+WeJLpEk8zm5Yp2t/ToRAxnVLLngDzmZBSSVRL3/xfd85xK8rVfd3PVlWxSOmg
        BXeZAJNdAj/liIyda28t7LbYHNPf+euDANMrM44if88GUEGVgPe3Yyz9vHRHQyFU
        /woGQKMHHKeDDAyRVvyoVzbE4wFaw7h0zv4a+sl32BdVFi7HVDXgtQt5fh8RpBtA
        ==
X-ME-Sender: <xms:5wNCXvO681y0lBQ83HzlcDhjEvLwcS36QYdVId9-kshO_6nzGLaRTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedriedvgdefhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehnughrvghs
    ucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuffhomhgrih
    hnpehkvghrnhgvlhdrohhrghenucfkphepieejrdduiedtrddvudejrddvhedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvghsse
    grnhgrrhgriigvlhdruggv
X-ME-Proxy: <xmx:5wNCXkBLDvIU_vcO5IbCFrc3Nnm51eYlnhpXSWdyJUs8tAx1won64w>
    <xmx:5wNCXuLlizr61gtKenj4P440ZodRX7olVZZGPl_L6rgjjkSi7KC4qg>
    <xmx:5wNCXlPo2hQG4n_hkwMubKV04fYO-TnIRuLQwQbSW-pYyPyuLKF_yA>
    <xmx:6ANCXhbpsSt17C0cfaY-P4sugOTox2SfJafTar2Rn2YBMjqdUxo25RFLAcc>
Received: from intern.anarazel.de (c-67-160-217-250.hsd1.ca.comcast.net [67.160.217.250])
        by mail.messagingengine.com (Postfix) with ESMTPA id E8F9F3060840;
        Mon, 10 Feb 2020 20:31:18 -0500 (EST)
Date:   Mon, 10 Feb 2020 17:31:17 -0800
From:   Andres Freund <andres@anarazel.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, willy@infradead.org, hch@infradead.org,
        jack@suse.cz, akpm@linux-foundation.org
Subject: Re: [PATCH v3 0/3] vfs: have syncfs() return error when there are
 writeback errors
Message-ID: <20200211013117.23z3ftgeorx6a3qk@alap3.anarazel.de>
References: <20200207170423.377931-1-jlayton@kernel.org>
 <20200207205243.GP20628@dread.disaster.area>
 <20200207212012.7jrivg2bvuvvful5@alap3.anarazel.de>
 <20200210214657.GA10776@dread.disaster.area>
 <20200211000405.5fohxgpt554gmnhu@alap3.anarazel.de>
 <20200211004830.GB10737@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211004830.GB10737@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

I shortly after this found a thread where Linus was explicitly asking
for potential userspace users of the feature, so I also responded there:
https://lore.kernel.org/linux-fsdevel/20200211005626.7yqjf5rbs3vbwagd@alap3.anarazel.de/

On 2020-02-11 11:48:30 +1100, Dave Chinner wrote:
> On Mon, Feb 10, 2020 at 04:04:05PM -0800, Andres Freund wrote:
> > On 2020-02-11 08:46:57 +1100, Dave Chinner wrote:
> > As far as I can tell the superblock based stuff does *not* actually
> > report any errors yet (contrast to READONLY, EDQUOT). Is the plan here
> > to include writeback errors as well? Or just filesystem metadata/journal
> > IO?
> 
> Right, that part hasn't been implemented yet, though it's repeatedly
> mentioned as intended to be supported functionality. It will depend
> on the filesystem to what it is going to report

There really ought to be some clear guidelines what is expected to be
reported though. Otherwise we'll just end up with a hodgepodge of
different semantics, which'd be, ummm, not good.


> but I would expect that it will initially be focussed on reporting
> user data errors (e.g. writeback errors, block device gone bad data
> loss reports, etc). It may not be possible to do anything sane with
> metadata/journal IO errors as they typically cause the filesystem to
> shutdown.

I was mostly referencing the metadata/journal errors because it's what a
number of filesystems seem to treat as errors (cf errors=remount-ro
etc), and I just wanted to be sure that more than just those get
reported up...

I think the patch already had support for getting a separate type of
notification for SBs remounted ro, shouldn't be too hard to change that
so it'd report error shutdowns / remount-ro as a different
category. Without


> Of course, a filesystem shutdown is likely to result in a thundering
> herd of userspace IO error notifications (think hundreds of GB of
> dirty page cache getting EIO errors). Hence individual filesystems
> will have to put some thought into how critical filesystem error
> notifications are handled.

Probably would make sense to stop reporting them individually once the
whole FS is shutdown/remounted due to errors, and a notification about
that fact has been sent.


> That said, we likely want userspace notification of metadata IO
> errors for our own purposes. e.g. so we can trigger the online
> filesystem repair code to start trying to fix whatever went wrong. I
> doubt there's much userspace can do with things like "bad freespace
> btree block" notifications, whilst the filesystem's online repair
> tool can trigger a free space scan and rebuild/repair it without
> userspace applications even being aware that we just detected and
> corrected a critical metadata corruption....

Neat.


> > I don't think that block layer notifications would be sufficient for an
> > individual userspace application's data integrity purposes? For one,
> > it'd need to map devices to relevant filesystems afaictl. And there's
> > also errors above the block layer.
> 
> Block device errors separate notifications to the superblock
> notifications. If you want the notification of raw block device
> errors, then that's what you listen for. If you want the filesystem
> to actually tell you what file and offset that EIO was generated
> for, then you'd get that through the superblock notifier, not the
> block device notifier...

Not something we urgently need, but it might come in handy at a later
point.

Thanks,

Andres
