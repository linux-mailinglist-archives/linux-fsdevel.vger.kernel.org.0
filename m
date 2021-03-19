Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431233428DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 23:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhCSWqw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 18:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbhCSWqY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 18:46:24 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677BAC061761
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Mar 2021 15:46:24 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id v23so3603530ple.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Mar 2021 15:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=33cXKf+qPGNNAeOkK0D8X3mSCgu3W5Iucj/z4eZqBa0=;
        b=tLp5VtDVmmXP1up9uhw+PTnAD50SpZ6QAF5SvhjJaWAz7lsEKqI1v85BGGn8uJe6hA
         QBt5fFhRl4OpLOpus7+NTGOVjh1B5NfQJlqDh4iz+ESx5IU1nizzJSOMjtV/Io9gSiZU
         IIYBx5FNpjpBGaHY5AcaOzxX3OQiovv8SLnrEko9LdZmnOnb/4zOPcp2pjD3SdsKDD1I
         Q9yTLC945y9zWjdTmnPk42qydmBAttcF02c543Sx9igwZg/4Ts+W06O58NfY9aYPLmYb
         KBmP51Ve3o4cTZNF55g/8Ib4KZ+VTE5GfHT1bbOefIZ+klkYIG4pAipPOQW2iQSpzPwy
         QMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=33cXKf+qPGNNAeOkK0D8X3mSCgu3W5Iucj/z4eZqBa0=;
        b=i9DkEH9u7sJ3OVCp+E2li64+vrQmI/rV+k4T72tk5XZxEU2Nfq/FiXRCAzWsarn/It
         ZnQHQ7GaH/29rBwPp26+5CW8laXiqCesXjKcnAGIaZs4QAmAQV/FwXUTocSwwX1o4dH7
         tWXIJz0PQzPXCytkb3DqKX40jxUsrTYqz2f5nJGt4zHaQDPozgU7UAUxaVA3+kKscseq
         7TzIudT+wadKFJjLV7K0qKhS1Ly1Vo+nC/xpnLl2/4t27IPwY8fTPr8WPLvjfv9SSufn
         JoB7XQiX7U+WlsypWmd6I8FrsnPC3guc7wyeMconpVb4lduXCxDgkZ4NMv8FtJpQujUy
         ecXg==
X-Gm-Message-State: AOAM532l6GsfIEYCz+I/+uWDeYBgYGt6trmmehvNRXJIb304Re+7pDvc
        Youb6ZxY8zWicF36bz4ORmn40Q==
X-Google-Smtp-Source: ABdhPJy6e8AxMXKrcjt+I8qVqpYJmL6GK3lZsKaqck1E/jAM3+eeM1w2x2AC0KNTm9JzwSoCrxf5CQ==
X-Received: by 2002:a17:90b:46d0:: with SMTP id jx16mr741470pjb.3.1616193983676;
        Fri, 19 Mar 2021 15:46:23 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:9ec6])
        by smtp.gmail.com with ESMTPSA id g26sm6491517pge.67.2021.03.19.15.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 15:46:22 -0700 (PDT)
Date:   Fri, 19 Mar 2021 15:46:20 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v8 00/10] fs: interface for directly reading/writing
 compressed data
Message-ID: <YFUpvFyXD0WoUHFu@relinquished.localdomain>
References: <cover.1615922644.git.osandov@fb.com>
 <8f741746-fd7f-c81a-3cdf-fb81aeea34b5@toxicpanda.com>
 <CAHk-=wj6MjPt+V7VrQ=muspc0DZ-7bg5bvmE2ZF-1Ea_AQh8Xg@mail.gmail.com>
 <YFUJLUnXnsv9X/vN@relinquished.localdomain>
 <CAHk-=whGEM0YX4eavgGuoOqhGU1g=bhdOK=vUiP1Qeb5ZxK56Q@mail.gmail.com>
 <YFUTnDaCdjWHHht5@relinquished.localdomain>
 <CAHk-=wjhSP88EcBnqVZQhGa4M6Tp5Zii4GCBoNBBdcAc3PUYbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjhSP88EcBnqVZQhGa4M6Tp5Zii4GCBoNBBdcAc3PUYbg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 19, 2021 at 02:47:03PM -0700, Linus Torvalds wrote:
> On Fri, Mar 19, 2021 at 2:12 PM Omar Sandoval <osandov@osandov.com> wrote:
> >
> > After spending a few minutes trying to simplify copy_struct_from_iter(),
> > it's honestly easier to just use the iterate_all_kinds() craziness than
> > open coding it to only operate on iov[0]. But that's an implementation
> > detail, and we can trivially make the interface stricter:
> 
> This is an improvement, but talking about the iterate_all_kinds()
> craziness, I think your existing code is broken.
> 
> That third case (kernel pointer source):
> 
> +    copy = min(ksize - copied, v.iov_len);
> +    memcpy(dst + copied, v.iov_base, copy);
> +    if (memchr_inv(v.iov_base, 0, v.iov_len))
> +        return -E2BIG;
> 
> can't be right. Aren't you checking that it's *all* zero, even the
> part you copied?

Oops, that should of course be

	if (memchr_inv(v.iov_base + copy, 0, v.iov_len - copy))
		return -E2BIG;

like the other cases. Point taken, though.

> Our iov_iter stuff is really complicated already, this is part of why
> I'm not a huge fan of using it.
> 
> I still suspect you'd be better off not using the iterate_all_kinds()
> thing at all, and just explicitly checking ITER_BVEC/ITER_KVEC
> manually.
> 
> Because you can play games like fooling your "copy_struct_from_iter()"
> to not copy anything at all with ITER_DISCARD, can't you?
> 
> Which then sounds like it might end up being useful as a kernel data
> leak, because it will use some random uninitialized kernel memory for
> the structure.
> 
> Now, I don't think you can actually get that ITER_DISCARD case, so
> this is not *really* a problem, but it's another example of how that
> iterate_all_kinds() thing has these subtle cases embedded into it.

Right, that would probably be better off returning EFAULT or something
for ITER_DISCARD.

> The whole point of copy_struct_from_iter() is presumably to be the
> same kind of "obviously safe" interface as copy_struct_from_user() is
> meant to be, so these subtle cases just then make me go "Hmm".
> 
> I think just open-coding this when  you know there is no actual
> looping going on, and the data has to be at the *beginning*, should be
> fairly simple. What makes iterate_all_kinds() complicated is that
> iteration, the fact that there can be empty entries in there, but it's
> also that "iov_offset" thing etc.
> 
> For the case where you just (a) require that iov_offset is zero, and
> (b) everything has to fit into the very first iov entry (regardless of
> what type that iov entry is), I think you actually end up with a much
> simpler model.
> 
> I do realize that I am perhaps concentrating a bit too much on this
> one part of the patch series, but the iov_iter thing has bitten us
> before. And it has bitten really core developers and then Al has had
> to fix up mistakes.
> 
> In fact, it wasn't that long ago that I asked Al to verify code I
> wrote, because I was worried about having missed something subtle. So
> now when I see these iov_iter users, it just makes me go all nervous.

So here's what it looks like with these restrictions (chances are
there's a bug or two in here):

int copy_struct_from_iter(void *dst, size_t ksize, struct iov_iter *i)
{
	size_t usize;
	int ret;

	if (i->iov_offset != 0)
		return -EINVAL;
	if (iter_is_iovec(i)) {
		usize = i->iov->iov_len;
		might_fault();
		if (copyin(dst, i->iov->iov_base, min(ksize, usize)))
			return -EFAULT;
		if (usize > ksize) {
			ret = check_zeroed_user(i->iov->iov_base + ksize,
						usize - ksize);
			if (ret < 0)
				return ret;
			else if (ret == 0)
				return -E2BIG;
		}
	} else if (iov_iter_is_kvec(i)) {
		usize = i->kvec->iov_len;
		memcpy(dst, i->kvec->iov_base, min(ksize, usize));
		if (usize > ksize &&
		    memchr_inv(i->kvec->iov_base + ksize, 0, usize - ksize))
			return -E2BIG;
	} else if (iov_iter_is_bvec(i)) {
		char *p;

		usize = i->bvec->bv_len;
		p = kmap_atomic(i->bvec->bv_page);
		memcpy(dst, p + i->bvec->bv_offset, min(ksize, usize));
		if (usize > ksize &&
		    memchr_inv(p + i->bvec->bv_offset + ksize, 0,
			       usize - ksize)) {
			kunmap_atomic(p);
			return -E2BIG;
		}
		kunmap_atomic(p);
	} else {
		return -EFAULT;
	}
	if (usize < ksize)
		memset(dst + usize, 0, ksize - usize);
	iov_iter_advance(i, usize);
	return 0;
}

Not much shorter, but it is easier to follow.
