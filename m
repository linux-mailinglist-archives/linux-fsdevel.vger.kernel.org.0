Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 103F58D008
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2019 11:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbfHNJs5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 05:48:57 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46527 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfHNJs5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 05:48:57 -0400
Received: by mail-pf1-f195.google.com with SMTP id q139so4978282pfc.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2019 02:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Ve+BsJCVJIEcifwtByCuOW28rmegYHRoXiLEkQ98LcE=;
        b=SvtDodok5nVnLyoolfForJK0EHeOoyIDE5YgsUdqEMry1xgwS6kWH5illdoZweCHeq
         UYls/IAXDe9T4P8V69E/48WknUmCXkPKyZv83mXWJA4WEUbv55J3rNP1cHgnh5Mm4MwB
         dzIUL4v6Cd2JT3H8lVc3EIPMDG8AoyqwdDuOTT3dCbCBXP/LWRqZF0SatqAnHgBFtb+B
         M8Sc0VvG+qa64YHj1lop64haV2iZDuq1V16Fwdoq+Ljr7FN7bfd3o+sLaRx/j1lJCQ5z
         M7lZdLSKtn8+SrlNQHNEyVdT7kUWwxaiRUc4z7PNcyqG1KkNX/SPqZWPlllEN8jSfxCZ
         SpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Ve+BsJCVJIEcifwtByCuOW28rmegYHRoXiLEkQ98LcE=;
        b=PiQCFcdiihwqCfEtEicoKtR6FoxJctaGtkJX4EZYaZ4Qav1424UC7HYfGNPXiCQLFX
         soJ5xV3X2b8wzMpl05kETk350BwmVYzHnrK0HavYqZ1Ici+XkRkmn+zhZD/1xFI9uxEf
         UEagHD3yx+HsCXvhS7UMb43reo13F9I1+HcSx5jltBwyCRuqN5OUUH6Kdz66nYBldc8A
         UfIL+Wz3PwSzDYb5hFiypKZeg8i0VawguX3ivkR2dYnuna2D4MlbjPzeionhZqd6WNpi
         uMdaYvTQhi/rJ51gg9ckKkb5AIpnhFiLEM+sJYWAZGod7RrRi5DHwirAjrej6LKgy2Dr
         HQRw==
X-Gm-Message-State: APjAAAWG7vUKfVmy6Xrm6k9guxkmvHJUnYwfVaBOrVd1iI9uQkuKwCku
        Xiz0nT+T31bVApYoTS/eOAL3ODrXew==
X-Google-Smtp-Source: APXvYqxMlpcm6/wPGb0sQMZFIa96c2xrKfs+EEDRJyQn8exRvnglI6LUZzNlec+lxXfArVXrgPFpnQ==
X-Received: by 2002:a65:4c4d:: with SMTP id l13mr37500934pgr.156.1565776136665;
        Wed, 14 Aug 2019 02:48:56 -0700 (PDT)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id r137sm28915301pfc.145.2019.08.14.02.48.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 02:48:56 -0700 (PDT)
Date:   Wed, 14 Aug 2019 19:48:50 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     RITESH HARJANI <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.cz, tytso@mit.edu
Subject: Re: [PATCH 0/5] ext4: direct IO via iomap infrastructure
Message-ID: <20190814094848.GA23465@poseidon.bobrowski.net>
References: <cover.1565609891.git.mbobrowski@mbobrowski.org>
 <20190812173150.AF04F5204F@d06av21.portsmouth.uk.ibm.com>
 <20190813111004.GA12682@poseidon.bobrowski.net>
 <20190813122723.AE6264C040@d06av22.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190813122723.AE6264C040@d06av22.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 13, 2019 at 05:57:22PM +0530, RITESH HARJANI wrote:
> On 8/13/19 4:40 PM, Matthew Bobrowski wrote:
> > On Mon, Aug 12, 2019 at 11:01:50PM +0530, RITESH HARJANI wrote:
> > > I was under the assumption that we need to maintain
> > > ext4_test_inode_state(inode, EXT4_STATE_DIO_UNWRITTEN) or
> > > atomic_read(&EXT4_I(inode)->i_unwritten))
> > > in case of non-AIO directIO or AIO directIO case as well (when we may
> > > allocate unwritten extents),
> > > to protect with some kind of race with other parts of code(maybe
> > > truncate/bufferedIO/fallocate not sure?) which may call for
> > > ext4_can_extents_be_merged()
> > > to check if extents can be merged or not.
> > > 
> > > Is it not the case?
> > > Now that directIO code has no way of specifying that this inode has
> > > unwritten extent, will it not race with any other path, where this info was
> > > necessary (like
> > > in above func ext4_can_extents_be_merged())?
> > Ah yes, I was under the same assumption when reviewing the code
> > initially and one of my first solutions was to also use this dynamic
> > 'state' flag in the ->end_io() handler. But, I fell flat on my face as
> > that deemed to be problematic... This is because there can be multiple
> > direct IOs to unwritten extents against the same inode, so you cannot
> > possibly get away with tracking them using this single inode flag. So,
> > hence the reason why we drop using EXT4_STATE_DIO_UNWRITTEN and use
> > IOMAP_DIO_UNWRITTEN instead in the ->end_io() handler, which tracks
> > whether _this_ particular IO has an underlying unwritten extent.
> 
> Thanks for taking time to explain this.
> 
> But what I meant was this (I may be wrong here since I haven't really looked
> into it),
> but for my understanding I would like to discuss this -
> 
> So earlier with this flag(EXT4_STATE_DIO_UNWRITTEN) we were determining on
> whether a newextent can be merged with ex1 in function
> ext4_extents_can_be_merged. But now since we have removed that flag we have
> no way of knowing that whether
> this inode has any unwritten extents or not from any DIO path.
> What I meant is isn't this removal of setting/unsetting of
> flag(EXT4_STATE_DIO_UNWRITTEN)
> changing the behavior of this func - ext4_extents_can_be_merged?

Ah yes, I see. I believe that what you're saying is correct and I
think we will need to account for this case. But, I haven't thought
about how to do this just yet.

> Also - could you please explain why this check returns 0 in the first place
> (line 1762 - 1766 below)?

I cannot explain why, because I myself don't know exactly why in this
particular case the extents cannot be merged. Perhaps `git blame` is
our friend and we can direct that question accordingly, or someone
else on this mailing list knows the answer. :-)

> 1733 int
> 1734 ext4_can_extents_be_merged(struct inode *inode, struct ext4_extent
> *ex1,
> 1735                                 struct ext4_extent *ex2)
> <...>
> 
> 1762         if (ext4_ext_is_unwritten(ex1) &&
> 1763             (ext4_test_inode_state(inode, EXT4_STATE_DIO_UNWRITTEN) ||
> 1764              atomic_read(&EXT4_I(inode)->i_unwritten) ||
> 1765              (ext1_ee_len + ext2_ee_len > EXT_UNWRITTEN_MAX_LEN)))
> 1766                 return 0;

--M

