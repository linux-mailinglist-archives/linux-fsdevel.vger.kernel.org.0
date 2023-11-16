Return-Path: <linux-fsdevel+bounces-2996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5AA7EE904
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 22:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8A47281116
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 21:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30ECF49F66;
	Thu, 16 Nov 2023 21:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xvP6G/XT"
X-Original-To: linux-fsdevel@vger.kernel.org
X-Greylist: delayed 2300 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Nov 2023 13:56:47 PST
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3DFEA
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Nov 2023 13:56:47 -0800 (PST)
Date: Thu, 16 Nov 2023 16:56:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700171805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cq9GvMuVJ4Bx3oDZ4+mluXXwnNf/SxM6Ocz/rtKGd+E=;
	b=xvP6G/XTSE1RcQsoLIztcTmF+uHjYDc3TXMzqmOUnYQv7KzWnWlfTzdp1VyaCZqCulSYBy
	X63M8vB8QL/VsPl5Gep+BIPpj/ifQhAtCzDnOMUiTiqtPkmhVKEkmX9FfAqoSLSyuizjIH
	JVzng+WSHBR54LCij7a3DgXuICDwsTI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [PATCH] fs: export getname()
Message-ID: <20231116215642.ikwr5uc7burwtv2i@moria.home.lan>
References: <20231116050832.GX1957730@ZenIV>
 <20231116211822.leztxrldjzyqadtm@moria.home.lan>
 <20231116215356.GB1957730@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116215356.GB1957730@ZenIV>
X-Migadu-Flow: FLOW_OUT

On Thu, Nov 16, 2023 at 09:53:56PM +0000, Al Viro wrote:
> On Thu, Nov 16, 2023 at 04:18:22PM -0500, Kent Overstreet wrote:
> > On Thu, Nov 16, 2023 at 05:08:32AM +0000, Al Viro wrote:
> > > (in #work.namei; used for bcachefs locking fix)
> > > From 74d016ecc1a7974664e98d1afbf649cd4e0e0423 Mon Sep 17 00:00:00 2001
> > > From: Al Viro <viro@zeniv.linux.org.uk>
> > > Date: Wed, 15 Nov 2023 22:41:27 -0500
> > > Subject: [PATCH 1/2] new helper: user_path_locked_at()
> > > 
> > > Equivalent of kern_path_locked() taking dfd/userland name.
> > > User introduced in the next commit.
> > 
> > also applying this:
> > -- >8 --
> > 
> > The locking fix in bch2_ioctl_subvolume_destroy() also needs getname()
> > exported; previous patch provided filename_path_locked()
> 
> Not needed anymore...

Saw your message about user_path_locked(); dropping these

