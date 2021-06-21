Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296B43AF580
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 20:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbhFUSuu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 14:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbhFUStJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 14:49:09 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE66C061767
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jun 2021 11:46:53 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id u18so8997181pfk.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jun 2021 11:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uL42HY8VlJREjfdLY2mBJzSmeljzMYYYKlWMhT3H0y0=;
        b=1jwQIzzwBurBAPJ1Q3HQ+QDPPD+Sot5nm9znVTSkxh3auGbJymMdlb+ig/jErsLYNv
         8Wc8ZGD+Koaekj3tBcBf4gErMvlr58VMb94TA3Lx/2UF+mLOxnNbO+Xy98c8Aq+N6C8v
         1pqIEXH1NWOC+MVQk9oavvnM3d0RToPw8JyQY5DTfPWQnod0hET8evSCbAZm9sE96pqp
         ZF81K20Cz52IBidFWuvCTWpssSPVJXJDArLvhvLDSpKBZ/NbPPlTLw3Poi1ZkIk88MZw
         qrKs6egrR/LpRHr2IxE7nA1SP1SLfsw5ZA72tTv50mBxP9Gl2wQ3pyHxcpfken45dWEB
         OCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uL42HY8VlJREjfdLY2mBJzSmeljzMYYYKlWMhT3H0y0=;
        b=EzqziXinmljCZ+w/GcMp8MKacdmTNKMDOedL8yBz+LVyC2zbpRdn+56rter3cWStRp
         R0401sOJvDRch95sg4oJoVX1cwu3/bkB102Pp2dmxb4fZnxKGezjt93u9hqFISlzE1t0
         WHY5dbotYJ8mO9X2cPmpCduKLfNGAVtlruDD2qTnVsF4z+et9G32L2mepbCEed7WAKnC
         1UWTyOvBk/ruLa199hlnfeYRemCy6JGZeSC5ClTWycImGQ9zr0unqbm3h0b+GspEWt1r
         AAYnSm1lOrjo0IVVGAJmlk+U2sMEZ6HGitbbcv4Wae7kfwGIcB1SjWERS9U8h2Xps+gs
         BTBA==
X-Gm-Message-State: AOAM532/m0TtCAml4KCEV8YtZuwer2dzaV1WLrRL2+5+Mpxlbwz3SSmS
        mDBUpUA3UlPdTmT0V/LdgfnmLg==
X-Google-Smtp-Source: ABdhPJz47BBhcenbhytG6OdP+DxO/RsazurFaw70c4fLgUzwa0FzusVvUXFOyWxd2fV57wyngPPOIg==
X-Received: by 2002:a63:5d5:: with SMTP id 204mr24823530pgf.72.1624301213253;
        Mon, 21 Jun 2021 11:46:53 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:cc49])
        by smtp.gmail.com with ESMTPSA id s126sm6762341pfb.164.2021.06.21.11.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 11:46:52 -0700 (PDT)
Date:   Mon, 21 Jun 2021 11:46:51 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH RESEND x3 v9 1/9] iov_iter: add copy_struct_from_iter()
Message-ID: <YNDem7R6Yh4Wy9po@relinquished.localdomain>
References: <CAHk-=whRA=54dtO3ha-C2-fV4XQ2nry99BmfancW-16EFGTHVg@mail.gmail.com>
 <YMz3MfgmbtTSQljy@zeniv-ca.linux.org.uk>
 <YM0C2mZfTE0uz3dq@relinquished.localdomain>
 <YM0I3aQpam7wfDxI@zeniv-ca.linux.org.uk>
 <CAHk-=wgiO+jG7yFEpL5=cW9AQSV0v1N6MhtfavmGEHwrXHz9pA@mail.gmail.com>
 <YM0Q5/unrL6MFNCb@zeniv-ca.linux.org.uk>
 <CAHk-=wjDhxnRaO8FU-fOEAF6WeTUsvaoz0+fr1tnJvRCfAaSCQ@mail.gmail.com>
 <YM0Zu3XopJTGMIO5@relinquished.localdomain>
 <YM0fFnMFSFpUb63U@zeniv-ca.linux.org.uk>
 <YM09qaP3qATwoLTJ@relinquished.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YM09qaP3qATwoLTJ@relinquished.localdomain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 18, 2021 at 05:43:21PM -0700, Omar Sandoval wrote:
> On Fri, Jun 18, 2021 at 10:32:54PM +0000, Al Viro wrote:
> > On Fri, Jun 18, 2021 at 03:10:03PM -0700, Omar Sandoval wrote:
> > 
> > > Or do the same reverting thing that Al did, but with copy_from_iter()
> > > instead of copy_from_iter_full() and being careful with the copied count
> > > (which I'm not 100% sure I got correct here):
> > > 
> > > 	size_t copied = copy_from_iter(&encoded, sizeof(encoded), &i);
> > > 	if (copied < offsetofend(struct encoded_iov, size))
> > > 		return -EFAULT;
> > > 	if (encoded.size > PAGE_SIZE)
> > > 		return -E2BIG;
> > > 	if (encoded.size < ENCODED_IOV_SIZE_VER0)
> > > 		return -EINVAL;
> > > 	if (encoded.size > sizeof(encoded)) {
> > > 		if (copied < sizeof(encoded)
> > > 			return -EFAULT;
> > > 		if (!iov_iter_check_zeroes(&i, encoded.size - sizeof(encoded))
> > > 			return -EINVAL;
> > > 	} else if (encoded.size < sizeof(encoded)) {
> > > 		// older than what we expect
> > > 		if (copied < encoded.size)
> > > 			return -EFAULT;
> > > 		iov_iter_revert(&i, copied - encoded.size);
> > > 		memset((void *)&encoded + encoded.size, 0, sizeof(encoded) - encoded.size);
> > > 	}    
> > 
> > simpler than that, actually -
> > 
> > 	copied = copy_from_iter(&encoded, sizeof(encoded), &i);
> > 	if (unlikely(copied < sizeof(encoded))) {
> > 		if (copied < offsetofend(struct encoded_iov, size) ||
> > 		    copied < encoded.size)
> > 			return iov_iter_count(i) ? -EFAULT : -EINVAL;
> > 	}
> > 	if (encoded.size > sizeof(encoded)) {
> > 		if (!iov_iter_check_zeroes(&i, encoded.size - sizeof(encoded))
> > 			return -EINVAL;
> > 	} else if (encoded.size < sizeof(encoded)) {
> > 		// copied can't be less than encoded.size here - otherwise
> > 		// we'd have copied < sizeof(encoded) and the check above
> > 		// would've buggered off
> > 		iov_iter_revert(&i, copied - encoded.size);
> > 		memset((void *)&encoded + encoded.size, 0, sizeof(encoded) - encoded.size);
> > 	}
> > 
> > should do it.
> 
> Thanks, Al, I'll send an updated version with this approach next week.

Okay, so this works for the write side of RWF_ENCODED, but it causes
problems for the read side. That currently works like so:

	struct encoded_iov encoded_iov;
	char compressed_data[...];
	struct iovec iov[] = {
		{ &encoded_iov, sizeof(encoded_iov) },
		{ compressed_data, sizeof(compressed_data) },
	};
	preadv2(fd, iov, 2, -1, RWF_ENCODED);

The kernel fills in the encoded_iov with the compression metadata and
the remaining buffers with the compressed data. The kernel needs to know
how much of the iovec is for the encoded_iov. The backwards
compatibility is similar to the write side: if the kernel size is less
than the userspace size, then we can fill in extra zeroes. If the kernel
size is greater than the userspace size and all of the extra metadata is
zero, then we can omit it. If the extra metadata is non-zero, then we
return an error.

How do we get the userspace size with the encoded_iov.size approach?
We'd have to read the size from the iov_iter before writing to the rest
of the iov_iter. Is it okay to mix the iov_iter as a source and
destination like this? From what I can tell, it's not intended to be
used like this.
