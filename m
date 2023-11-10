Return-Path: <linux-fsdevel+bounces-2714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C52667E7A72
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 10:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 026311C20BCA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 09:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F641094C;
	Fri, 10 Nov 2023 09:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mr3rv5/l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593CCD307
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 09:07:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0569C433C8;
	Fri, 10 Nov 2023 09:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699607256;
	bh=vKAKC1nL6sEIub3jsYc6Rk9UP2CQn8JXQLHWvlUnsKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mr3rv5/l5+HdejWBX4kxd9IzSF27T0jYlnFBWaH68llxkaXANHTi68RYd6i/ws53h
	 wNfaw2SEZquclIANHOL5f3/CwFCx9+qD+SBDwqW6H8Fld+mSWTUZ1c9TBwzCYeF/GK
	 ueY16ddBSWM/FiWwYApLlr6LCNqfz7TX+fTVkGtkTbqOHgAEtqQuNkqb8mNFGlqg1f
	 5Yuw/kZ+hbsM+10Rx8XA0ynxpjQ+ypOwvzPR/1vXte30RDz+KP1MhWxx9cpj3P5oVm
	 WiGWWEhOv562J9PUkkyc14U42K2qcJvtsOVX8V4cyPvIms89EMcNLv0GibnDAB9dke
	 obzUIWNAWtMLw==
Date: Fri, 10 Nov 2023 10:07:32 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 17/22] don't try to cut corners in shrink_lock_dentry()
Message-ID: <20231110-geklagt-parkbank-d1d03be3de23@brauner>
References: <20231109061932.GA3181489@ZenIV>
 <20231109062056.3181775-1-viro@zeniv.linux.org.uk>
 <20231109062056.3181775-17-viro@zeniv.linux.org.uk>
 <20231109-designen-menschheit-7e4120584db1@brauner>
 <20231109214537.GH1957730@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231109214537.GH1957730@ZenIV>

On Thu, Nov 09, 2023 at 09:45:37PM +0000, Al Viro wrote:
> On Thu, Nov 09, 2023 at 06:20:08PM +0100, Christian Brauner wrote:
> 
> > It's a bit unfortunate that __lock_parent() locks the parent *and* may
> > lock the child which isn't really obvious from the name. It just becomes
> > clear that this is assumed by how callers release the child's lock.
> 
> __lock_parent() is gone by the end of the series.

Yes, I saw that once I got to the end of the series. Thanks.

