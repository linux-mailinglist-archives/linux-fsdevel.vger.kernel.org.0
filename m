Return-Path: <linux-fsdevel+bounces-2995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BF37EE8FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 22:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D20E2280FA6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 21:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A16E495E4;
	Thu, 16 Nov 2023 21:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="YNdWYl/p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8BBEA
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Nov 2023 13:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dLAq+UGlSw/l1fDPAWDdDJWJ3FuXxRzPsYitFXDPx1g=; b=YNdWYl/p5QDg+IHxevsV2zqhPC
	JaXZnVPkXexplMNr7ro2aMAe9v4zYLVjsg2f2rpfat/P8TqnOt9+JbB6iga5HyZCxkGo6EN51mPOV
	B1dM+gsJPb4PplTYONHPjjr9wKK5rJ5la88oxs7thxKNNmHW+PaA9GHp4PehvmFqDoPsJ7cEJHj9w
	Zw20Dw8pOPp4ClOkgySS+M4FEkXQVMVLhYdZfn9X5qUuESsMV1sg/oSWvgLm3FnFnMP+u7Bp+RROi
	Co6HUBeSLtOZraz8jY6dlW29UDOO+1X8yetSOBpyKWShZo94kGFipc6v9YGY9ZFVvSemfqFTAYVnU
	JCZKQGiA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r3kJA-00GlIq-2M;
	Thu, 16 Nov 2023 21:53:56 +0000
Date: Thu, 16 Nov 2023 21:53:56 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-fsdevel@vger.kernel.org,
	Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [PATCH] fs: export getname()
Message-ID: <20231116215356.GB1957730@ZenIV>
References: <20231116050832.GX1957730@ZenIV>
 <20231116211822.leztxrldjzyqadtm@moria.home.lan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116211822.leztxrldjzyqadtm@moria.home.lan>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Nov 16, 2023 at 04:18:22PM -0500, Kent Overstreet wrote:
> On Thu, Nov 16, 2023 at 05:08:32AM +0000, Al Viro wrote:
> > (in #work.namei; used for bcachefs locking fix)
> > From 74d016ecc1a7974664e98d1afbf649cd4e0e0423 Mon Sep 17 00:00:00 2001
> > From: Al Viro <viro@zeniv.linux.org.uk>
> > Date: Wed, 15 Nov 2023 22:41:27 -0500
> > Subject: [PATCH 1/2] new helper: user_path_locked_at()
> > 
> > Equivalent of kern_path_locked() taking dfd/userland name.
> > User introduced in the next commit.
> 
> also applying this:
> -- >8 --
> 
> The locking fix in bch2_ioctl_subvolume_destroy() also needs getname()
> exported; previous patch provided filename_path_locked()

Not needed anymore...

