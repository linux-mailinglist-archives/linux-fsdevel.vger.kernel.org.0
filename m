Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 376A33DF305
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 18:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbhHCQmx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 12:42:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:59438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234565AbhHCQmw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 12:42:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0416660555;
        Tue,  3 Aug 2021 16:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628008961;
        bh=hJz+8h+1bPkjlwbjSsncSGCIoIMEkSuRDoLBTB9ttAQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hVB3kBXzSWg9T4lAeDOH2Oo2HKYb3i/eVRbGRy1ZiI6Z/JL0RX0Jro3CGC9hWqKUP
         en53RrDnniTSbnnMQPJwM7KIIazRyobXzS6oXuuVQ9g7h46gDg2rzt4sT0TNgs6OxA
         oe8F7l1zZBDmBYZs73NQ4/udtdGZHaPA0yK7OBkcyJ9rzpMtsMLlryvQYDuYDCnEvt
         7HBO4IPuwhUfNblrC/FELftqDVzS+2pPtIx3jxAYQnCA05fD5Ccsxx+ZvShPaOvm2r
         t7CJau1y3CsZBX3S8rDsl50mrucfxqI7kj1JTcjVdzZjfquEJx1ONaIM1JA1oQIHFd
         e1HdzvIPJDrJA==
Date:   Tue, 3 Aug 2021 09:42:40 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: iomap 5.15 branch construction ...
Message-ID: <20210803164240.GC3601405@magnolia>
References: <20210802221114.GG3601466@magnolia>
 <YQhzDPl13/Kl4JdQ@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQhzDPl13/Kl4JdQ@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 02, 2021 at 03:34:52PM -0700, Eric Biggers wrote:
> On Mon, Aug 02, 2021 at 03:11:14PM -0700, Darrick J. Wong wrote:
> > 6. Earlier, Eric Biggers had a patchset that made some iomap changes
> > ahead of porting f2fs to use directio.  I /think/ those changes were
> > dropped in the latest submission because the intended use of those
> > changes (counters of the number of pages undergoing reads or writes,
> > iirc?) has been replaced with something simpler.  IOWs, f2fs doesn't
> > need any iomap changes for 5.15, right?
> 
> Converting f2fs to use iomap for direct I/O doesn't require any iomap changes.
> You might be referring to
> https://lkml.kernel.org/r/20210604210908.2105870-7-satyat@google.com
> ("iomap: support direct I/O with fscrypt using blk-crypto"), which will be
> needed to support direct I/O on encrypted files.  Direct I/O support on
> encrypted files will be a new feature, and it's being held up for other reasons.
> So there's nothing for you to do for 5.15.  (And separately, using iomap for
> direct I/O in f2fs is being held up by existing f2fs direct I/O bugs.)

Ok, thank you for the update!

--D

> 
> - Eric
