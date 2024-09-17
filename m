Return-Path: <linux-fsdevel+bounces-29545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C777C97AB23
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 07:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 757431F210DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 05:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF67F136E3B;
	Tue, 17 Sep 2024 05:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="knXtipmy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71E83FB9F;
	Tue, 17 Sep 2024 05:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726551606; cv=none; b=OTpwf2QDCrzbGpVmWeAoQ7uxNpK/5qJjNCJtCwwmySXlnuHvl+k2xfIwPL038ongWrWEk/mT/sdj21mXjk3QXc8RaWYM7CwmalAzHT8mbn6e/0LNO8Xx02fq3idJjhDj/Twh7GXNjWKjYZz8UqFmqt8unr+VLIwFGLCDsoHS22Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726551606; c=relaxed/simple;
	bh=6G9vS8+BogHJ85OPot1tsWSF9cmXW5NRko76RGNNmKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qz8y1EfudJS38cvBAae2Mu9LKXHQG7aStnoenHd0XGRNji+0EDYpwBo+fKGLTIcuG8GUjrnkyk5fQHXRwTSVH4lZpEiPUmd3pz5TiKVUD525e/ruIgAkmTh8BRgqmWkQgLLnTjgE0vXNGW70CQ/sPTCu2nFGitO+7NUpGg5XobE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=knXtipmy; arc=none smtp.client-ip=148.135.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 06E2269910;
	Tue, 17 Sep 2024 01:40:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726551603; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=/rNsH8fwqQ99fQIkyXWrjp4kESfkbqMuFCS7j+lnONE=;
	b=knXtipmypuDuPGLEVzoNibIPS2gDWwWjmkNpJMzYwTO3Hh47ACEfpfjUxhRng8tSdRQaDP
	lzedY/Ngjowq6P31HJ+o8k+QeI10bYs7ZtXYC5o1MxE39GNcv75xT9VBP98IqwLhcRr73u
	iYeQQmeBKqEgdOC/0xJoPA3dOdMclL1wdbFOR0AD0txHUCgqoeKH0ShTLK1pzCFr9MblH1
	Ku48QZEryboHPyxFaPMJzAQuK2IeLtc4luuECSui2+PqvVOwTEK60yOE8eJoT8SoIk26WS
	5cSRZL0qErwO0mgkIe6tWVxGn47VkVUfDZN25faZTAi6ac5aJWEgRkgIRRLZEg==
Date: Tue, 17 Sep 2024 13:39:57 +0800
From: Yiyang Wu <toolmanp@tlmp.cc>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-erofs@lists.ozlabs.org, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 02/24] erofs: add superblock data structure in Rust
Message-ID: <fleabfstkn2ciljoszwoqwpatanznrjlpkowrldqybn44xp4pq@kqsssm5uujuq>
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
 <20240916135634.98554-3-toolmanp@tlmp.cc>
 <2024091655-sneeze-pacify-cf28@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024091655-sneeze-pacify-cf28@gregkh>
X-Last-TLS-Session-Version: TLSv1.3

On Mon, Sep 16, 2024 at 07:55:43PM GMT, Greg KH wrote:
> On Mon, Sep 16, 2024 at 09:56:12PM +0800, Yiyang Wu wrote:
> > diff --git a/fs/erofs/rust/erofs_sys.rs b/fs/erofs/rust/erofs_sys.rs
> > new file mode 100644
> > index 000000000000..0f1400175fc2
> > --- /dev/null
> > +++ b/fs/erofs/rust/erofs_sys.rs
> > @@ -0,0 +1,22 @@
> > +#![allow(dead_code)]
> > +// Copyright 2024 Yiyang Wu
> > +// SPDX-License-Identifier: MIT or GPL-2.0-or-later
> 
> Sorry, but I have to ask, why a dual license here?  You are only linking
> to GPL-2.0-only code, so why the different license?  Especially if you
> used the GPL-2.0-only code to "translate" from.
> 
> If you REALLY REALLY want to use a dual license, please get your
> lawyers to document why this is needed and put it in the changelog for
> the next time you submit this series when adding files with dual
> licenses so I don't have to ask again :)
> 
> thanks,
> 
> greg k-h

C'Mon, I have no intension to make this discussion look heated.

I mean what I original code is under MIT and i've learned that Linux
is GPL-2.0, so I naively thought it's OK to dual licensed this to
support flexibility according the Wikipedia, should I quote: "When
software is multi-licensed, recipients can typically choose the terms
under which they want to use or distribute the software, but the simple
presence of multiple licenses in a software package or library does not
necessarily indicate that the recipient can 
freely choose one or the other. "[1]. Since it says multiple licenses
does not necessarily indicate that the recipient can freely choose one
or other,I thought the strictest license applies here and it should
GPL-2.0-only in this case.

I don't have any previous experience in Kernel Development so I really
just have no ideas about you guys attitude towards this kind of issue.
If insisted on switching back to GPL-2.0-only code, It's fine for me
and i'llchange this in the next version. Again I don't have this kind
of knowledge in advance, and if multi-license is inspected case-by-case,
project-by-project, then I will take notes and never make this
kind of mistakes again.

Best Regards,
Yiyang Wu.

