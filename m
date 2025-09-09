Return-Path: <linux-fsdevel+bounces-60603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BFDB49E1C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 02:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A02B4E0EE0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 00:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD911F875A;
	Tue,  9 Sep 2025 00:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyL/b5p8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F211F4717;
	Tue,  9 Sep 2025 00:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757378410; cv=none; b=JOT2ZLBHZmbspmtzl2qiblENV5kD4hFzEwQRSZUR5vn7rDUFw20QkcYO3hGMl4EDiFKzenuz8ugb22njl0eiArTRPMYut97/BqiDW5vnaecfybp1kM/P1FkNu7MvhiHUoseCdgwJYvk2pNgzDmc3qzWgpawDqbeckuH+YYUxSb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757378410; c=relaxed/simple;
	bh=CR6U4g11j4bNV1OTESMqKsUTlLGVOJCvh5+ygU+K1qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THceTbcS98C1KzUupZRTqEYDqoQZIv5wKnc1FiTSWGwHfb/xdpg2Q7DxJx19cY0g7xMY3TZ6JTJ/jWLf7hyj9CQS0vSlyGYqCrdBvCsuU4esaLu1V2X06l8r8e96NOzuLUDwLPw6PMqUcctEHOfGk1IWLLCYy1RAxkxQHOWZalo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyL/b5p8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5C1C4CEF1;
	Tue,  9 Sep 2025 00:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757378409;
	bh=CR6U4g11j4bNV1OTESMqKsUTlLGVOJCvh5+ygU+K1qk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CyL/b5p8hguUDWmOa0p3VL2hgehgqmtGJaSaZAS7zrLWa3itPPCvFXBZrFgAlKJTm
	 eUoc1MqwhCAsXJBaGFS/ZxMoX9fYiUbjx7uNksJD8xBrTEb/aEErub9NgnyRn4ayIx
	 fS6n5vaw1zwubPqudQAL91gtLvOp6oMMlrXJ7cP83OZ5T3pMEs86mzv4Ss2Qr8VFC9
	 BhFiY75WUkSyJ4zmW0RY8UO/xcGSn5v1m0hv1FxO547rGUSK6Vq/OTX3mPWvhfBNTE
	 9QPvY9PCeV7B1QAHl0H5pNaYwlsuDkcJRuOo9ufXmtDZviw/H5QNminynCv66HJfc+
	 JySQOINki+//g==
Date: Tue, 9 Sep 2025 08:40:00 +0800
From: Gao Xiang <xiang@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>, djwong@kernel.org,
	hch@infradead.org
Cc: brauner@kernel.org, miklos@szeredi.hu, hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 11/16] iomap: add caller-provided callbacks for read
 and readahead
Message-ID: <aL93YDiIEir2qRSs@debian>
Mail-Followup-To: Joanne Koong <joannelkoong@gmail.com>, djwong@kernel.org,
	hch@infradead.org, brauner@kernel.org, miklos@szeredi.hu,
	hsiangkao@linux.alibaba.com, linux-block@vger.kernel.org,
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com, linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
 <20250908185122.3199171-12-joannelkoong@gmail.com>
 <aL9xb5Jw8tvIRMcQ@debian>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aL9xb5Jw8tvIRMcQ@debian>

On Tue, Sep 09, 2025 at 08:14:49AM +0800, Gao Xiang wrote:
> Hi Joanne,
> 
> On Mon, Sep 08, 2025 at 11:51:17AM -0700, Joanne Koong wrote:
> > Add caller-provided callbacks for read and readahead so that it can be
> > used generically, especially by filesystems that are not block-based.
> > 
> > In particular, this:
> > * Modifies the read and readahead interface to take in a
> >   struct iomap_read_folio_ctx that is publicly defined as:
> > 
> >   struct iomap_read_folio_ctx {
> > 	const struct iomap_read_ops *ops;
> > 	struct folio *cur_folio;
> > 	struct readahead_control *rac;
> > 	void *private;
> >   };
> > 
> >   where struct iomap_read_ops is defined as:
> > 
> >   struct iomap_read_ops {
> >       int (*read_folio_range)(const struct iomap_iter *iter,
> >                              struct iomap_read_folio_ctx *ctx,
> >                              loff_t pos, size_t len);
> >       int (*read_submit)(struct iomap_read_folio_ctx *ctx);
> >   };
> > 
> 
> No, I don't think `struct iomap_read_folio_ctx` has another
> `.private` makes any sense, because:
> 
>  - `struct iomap_iter *iter` already has `.private` and I think
>    it's mainly used for per-request usage; and your new
>    `.read_folio_range` already passes
>     `const struct iomap_iter *iter` which has `.private`
>    I don't think some read-specific `.private` is useful in any
>    case, also below.
> 
>  - `struct iomap_read_folio_ctx` cannot be accessed by previous
>    .iomap_{begin,end} helpers, which means `struct iomap_read_ops`
>    is only useful for FUSE read iter/submit logic.
> 
> Also after my change, the prototype will be:
> 
> int iomap_read_folio(const struct iomap_ops *ops,
> 		     struct iomap_read_folio_ctx *ctx, void *private2);
> void iomap_readahead(const struct iomap_ops *ops,
> 		     struct iomap_read_folio_ctx *ctx, void *private2);
> 

btw, if iomap folks really think it looks clean to pass in two
different `private` like this, I'm fine, basically:

I need a way to create an on-stack context in `erofs_read_folio()`
and `erofs_readahead()` and pass it down to .iomap_{begin,end}
because the current `.iomap_begin` and `.iomap_end` has no way to
get the new on-stack context: it can only get inode,pos,len,etc.

As Darrick mentioned, `iter = container_of(iomap)` usage in
`xfs_zoned_buffered_write_iomap_begin()` and
`xfs_buffered_write_delalloc_punch()` looks uneasy to me as well,
because it couples `struct iomap *` and `struct iomap_iter *` with
iomap implementation internals: At least `struct iomap_iter` has
two `struct iomap`, without any details, it's hard to assume it's
the `iter->iomap` one.

> Is it pretty weird due to `.iomap_{begin,end}` in principle can
> only use `struct iomap_iter *` but have no way to access
> ` struct iomap_read_folio_ctx` to get more enough content for
> read requests.
> 
> Thanks,
> Gao Xiang

