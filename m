Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C1D3DE286
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 00:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbhHBWfE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Aug 2021 18:35:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:40658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230313AbhHBWfD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Aug 2021 18:35:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B4F8660C3F;
        Mon,  2 Aug 2021 22:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627943693;
        bh=QpkGqnFmSzDqKBaE/ppyp54aIzPSsgbvd75VMZ7ldR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OXeZwlIVw//psovtk+JxSoImIViln7BoS3WgKL7MrXEY2BemPw9LBxkWA48DJzXyB
         LjbvwGOGEZp2/jGYLZgn3ryiVXd9R57pT8uLmXR5Y7+5zY4KmaUf7paAN8sZlLXT3e
         Zgj0BntTmbla9aTDIb+tHUeNvVPGT78xH8Px9EQRH6GMtbJ4aqdMIGi2VBmOgCYczJ
         pcTI0bphgRGrXWKeMGuegHGYvLc1IRvNJHW1a4OAp5JnSCsYJHm57C2PMPgHqQJa5a
         vUnzRujl//PpkUG/fWl3d2Uj2KbM6qKNLy1xVKuEfT8tl1NXBmplvCSHk+q055/MLM
         PGlka2dEmfY0g==
Date:   Mon, 2 Aug 2021 15:34:52 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: iomap 5.15 branch construction ...
Message-ID: <YQhzDPl13/Kl4JdQ@gmail.com>
References: <20210802221114.GG3601466@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802221114.GG3601466@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 02, 2021 at 03:11:14PM -0700, Darrick J. Wong wrote:
> 6. Earlier, Eric Biggers had a patchset that made some iomap changes
> ahead of porting f2fs to use directio.  I /think/ those changes were
> dropped in the latest submission because the intended use of those
> changes (counters of the number of pages undergoing reads or writes,
> iirc?) has been replaced with something simpler.  IOWs, f2fs doesn't
> need any iomap changes for 5.15, right?

Converting f2fs to use iomap for direct I/O doesn't require any iomap changes.
You might be referring to
https://lkml.kernel.org/r/20210604210908.2105870-7-satyat@google.com
("iomap: support direct I/O with fscrypt using blk-crypto"), which will be
needed to support direct I/O on encrypted files.  Direct I/O support on
encrypted files will be a new feature, and it's being held up for other reasons.
So there's nothing for you to do for 5.15.  (And separately, using iomap for
direct I/O in f2fs is being held up by existing f2fs direct I/O bugs.)

- Eric
