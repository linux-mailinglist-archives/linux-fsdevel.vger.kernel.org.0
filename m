Return-Path: <linux-fsdevel+bounces-29543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B3597AB00
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 07:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44DAAB219C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 05:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FD762171;
	Tue, 17 Sep 2024 05:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="lXLv26ys"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA39B1BC41;
	Tue, 17 Sep 2024 05:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726550879; cv=none; b=BiguELZAJQv14u3AAcj2i+x/FMB63RPAlzK/mdGgcQcsmEtb4A2ymKdQNz0HaAKHm/Pk4//YDpc2Bzf98w2PRlbLE1Itiix0uLdmuonMMpyGLtW4oVkL+IhkuvvoX6/Y/c2Kfew/bNtczM5K1zdYpNABxxOcBZxx8wrDbuweClw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726550879; c=relaxed/simple;
	bh=mPptHASd9tL+XEXg5ZdKM6m7SrQZ+NB0mubeoxadEYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qczXvRdclajsFiEIVtSF/ctWnq9DqmZiyOezGZkcSn2/EyEDP9YELHexMefUGtF94zUSGPBwDMWPvmzO4mG9fml3F6m5vxkKyFt9ylLZut9+wr03MbPRS+5AvQ6rt/mrU8RncZcnj72lqiW49G/x2M+kNWHS7AztIhlmwWRTT6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=lXLv26ys; arc=none smtp.client-ip=148.135.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A71626982E;
	Tue, 17 Sep 2024 01:27:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726550875; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=UqoAnaFjj0g05/20IdLuYc+XLZjT4bqDf94/49ZqBlk=;
	b=lXLv26ysjmiyZ4/wYXdHjA/yN/rFjNJ3nx9N1P0zGIOySd6NphncUuFbURMTF9hF+727Zc
	5x9TRzpKES2GWMmYucBPjQ3rRewe3pVJW7YacN/tMHe2Z9aEio5p6pvPHx15moKaApTag0
	dNxB5WK1p9Jt4OI1eDuAbi90c4PNewEQ52oiYKV1bdiUNKAPpf9zl8jVYVUZ3Sv2cD10Av
	PF56Yb4nuXhm040Z4BMCBxYjeHiPsqgclFYTsqVtp0WpCZmfqKN11E+/MY1TulPCELeIpz
	Z/FnzhJEFh7E2o9CLUBbQMXdTNNVvBDt1wZkVfREW2PT5o5EG755Wv7pNDweCw==
Date: Tue, 17 Sep 2024 13:27:39 +0800
From: Yiyang Wu <toolmanp@tlmp.cc>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-erofs@lists.ozlabs.org, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 02/24] erofs: add superblock data structure in Rust
Message-ID: <igyrm2gfmedt6v654lxcarcc7gqhc2qjkyopkwk65cdtnue3uh@rkz3m5s2qcm4>
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

C'mon, I just don't want this discussion to be heated.

I mean my original code is licensed under MIT and I've already learned
that Linux is under GPL-2.0. So i originally thought modifying it to
dual licenses can help address incompatiblity issues. According to
wikipedia, may I quote: "When software is multi-licensed, recipients
can typically choose the terms under which they want to use or
distribute the software, but the simple presence of multiple licenses
in a software package or library does not necessarily indicate that
the recipient can freely choose one or the other."[1], so according
to this, I believe putting these under a GPL-2.0 project should be
OK, since it will be forcily licensed **only** under GPL-2.0.

Since I wasn't involved in Kernel Development before, 
I just don't know you guys attitudes towards this kind of stuff.
If you guys are not pretty happy with this, I can just switch back to
GPL-2.0 and it's a big business for me.

Best Regards,
Yiyang Wu.

