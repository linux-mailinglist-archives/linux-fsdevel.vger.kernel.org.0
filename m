Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87142A1844
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 13:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfH2LU6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 07:20:58 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39382 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbfH2LU6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 07:20:58 -0400
Received: by mail-pf1-f196.google.com with SMTP id y200so1842684pfb.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2019 04:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MO1at3htvy+QBiGMsZ4p3IurvkhEqFEhhsP44+X95CE=;
        b=rJojcqdn4jRu5pAqPMUfE93udKprNxEHdg/UMkhlc2PipSnotKuR429QUIPq+cn3cV
         CfBv9d7MeYJZxSeJ/ux5WjlYNSyTOUeK+exsWcN01/HwgXkPwiMKlVspY1lFg1T0LZUo
         KY/UTYXyWNOa+PtCaX69THNbsOp9QaZGboYOwoGc2f6Jsj1i1IocSoFpr+AI2KsKKkMp
         j/FxR6PwtOMR63Oio7sZn5jYz00HzE6dji8DCgzzToWMOE4e7meFLJMtVnkx3H+oLqrv
         V+YUt1P/rZoIGoCkdyGOrmzSF0yxYNkFfR9i1I1yNvVLmtZobazbEI+cR8xCTHG/xGY5
         J0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MO1at3htvy+QBiGMsZ4p3IurvkhEqFEhhsP44+X95CE=;
        b=Dc0yz29pEMgbfUPXJg/qD8fZ9sZV9ptEZFBU9d+36IAESOSXxKNzC0W6JG2sHr60GX
         mMgj5RvqeKeJYhBtmk0pYKCjqXzQ2p53GoREbjM/HrN/d4Tcbc2JIVAVSvp8SBuBAkJk
         9Izwax/YEd5jYQ1zhuO+GC3UfolxhL67SdCB8uQQw4SI/FlyqsYpnNN2Dv96K+Waam5v
         wAvP10JW5TIeiyk8BcjotJ8rmokIAQKKE3od/SslquRgc8Uv7ow17zJJAh3hOTWkJU16
         nNQlCn0jw2ew2vsL4e1nTJ6ughQvOYVBZTKB7XGa8tjjQIxnQbn22gFNVrx+gWN9k1gz
         e0EQ==
X-Gm-Message-State: APjAAAX2/pK5gxAk6LA/Ugsz0KKJ8qRBuTOi/xGjGU4e1FLxCv6q//0p
        2GGM1CXDLb8e+8gSbATw/V/I
X-Google-Smtp-Source: APXvYqyPZX1a8Wl3Hv5h/GqI8hkbGT710z+NBi9F2BVP28ztiJx4E/HcSUO+OhBDFk/z0X/imxPwdA==
X-Received: by 2002:a17:90a:1a8d:: with SMTP id p13mr9579500pjp.15.1567077657344;
        Thu, 29 Aug 2019 04:20:57 -0700 (PDT)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id f26sm3055950pfq.38.2019.08.29.04.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 04:20:56 -0700 (PDT)
Date:   Thu, 29 Aug 2019 21:20:50 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, aneesh.kumar@linux.ibm.com
Subject: Re: [PATCH 0/5] ext4: direct IO via iomap infrastructure
Message-ID: <20190829112048.GA2486@poseidon.bobrowski.net>
References: <20190822120015.GA3330@poseidon.bobrowski.net>
 <20190822141126.70A94A407B@d06av23.portsmouth.uk.ibm.com>
 <20190824031830.GB2174@poseidon.bobrowski.net>
 <20190824035554.GA1037502@magnolia>
 <20190824230427.GA32012@infradead.org>
 <20190827095221.GA1568@poseidon.bobrowski.net>
 <20190828120509.GC22165@poseidon.bobrowski.net>
 <20190828142729.GB24857@mit.edu>
 <20190828180215.GE22343@quack2.suse.cz>
 <20190829063608.GA17426@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829063608.GA17426@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Awesome, and thank you *all* for your very valueable input.

On Wed, Aug 28, 2019 at 11:36:08PM -0700, Christoph Hellwig wrote:
> On Wed, Aug 28, 2019 at 08:02:15PM +0200, Jan Kara wrote:
> > > The original reason why we created the DIO_STATE_UNWRITTEN flag was a
> > > fast path, where the common case is writing blocks to an existing
> > > location in a file where the blocks are already allocated, and marked
> > > as written.  So consulting the on-disk extent tree to determine
> > > whether unwritten extents need to be converted and/or split is
> > > certainly doable.  However, it's expensive for the common case.  So
> > > having a hint whether we need to schedule a workqueue to possibly
> > > convert an unwritten region is helpful.  If we can just free the bio
> > > and exit the I/O completion handler without having to take shared
> > > locks to examine the on-disk extent tree, so much the better.
> > 
> > Yes, but for determining whether extent conversion on IO completion is
> > needed we now use IOMAP_DIO_UNWRITTEN flag iomap infrastructure provides to
> > us. So we don't have to track this internally in ext4 anymore.
> 
> Exactly.  As mentioned before the ioend to track unwritten thing was
> in XFS by the time ext4 copied the ioend approach. but we actually got
> rid of that long before the iomap conversion.  Maybe to make everything
> easier to understand and bisect you might want to get rid of the ioend
> for direct I/O in ext4 as a prep path as well.
> 
> The relevant commit is: 273dda76f757 ("xfs: don't use ioends for direct
> write completions")

Uh ha! So, we conclude that there's no need to muck around with hairy
ioend's, or the need to denote whether there's unwritten extents held
against the inode using tricky state flag for that matter.

> > > To be honest, i'm not 100% sure what would happen if we removed that
> > > restriction; it might be that things would work just fine (just slower
> > > in some workloads), or whether there is some hidden dependency that
> > > would explode.  I suspect we'd have to try the experiment to be sure.
> > 
> > As far as I remember the concern was that extent split may need block
> > allocation and we may not have enough free blocks to do it. These days we
> > have some blocks reserved in the filesystem to accomodate unexpected extent
> > splits so this shouldn't happen anymore so the only real concern is the
> > wasted performance due to unnecessary extent merge & split. Kind of a
> > stress test for this would be to fire of lots of sequential AIO DIO
> > requests against a hole in a file.
> 
> Well, you can always add a don't merge flag to the actual allocation.
> You might still get a merge for pathological case (fallocate adjacent
> to a dio write just submitted), but if the merging is such a performance
> over head here is easy ways to avoid it for the common case.

After I've posted through the next version of this patch series, I
will attempt to perform some stress testing to see what the
performance hit could potentially be.
