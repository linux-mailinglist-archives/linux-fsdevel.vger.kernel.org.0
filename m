Return-Path: <linux-fsdevel+bounces-14882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE23880F8C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 11:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 071C21C2237F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 10:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14773D986;
	Wed, 20 Mar 2024 10:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWCD1O6F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C3D3D566;
	Wed, 20 Mar 2024 10:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710930065; cv=none; b=pgn4U17NTxhYdiX6LBJpEEGANMoyhFLBCLvaj/OhGVeZabXdWeaDQL3LOcaLw0QJ6f2hse0V0Idnbz/LiJ6d/pIvteYK32m/+lbG+KKCF4ryeoh+mzh1JH68DG09nDzC4N/VaaUawXHR8/cbedKdE4wGC5SQ/4BkzJrZ7E4V7K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710930065; c=relaxed/simple;
	bh=IipSOTUrpbfVFxPTbW4SJLskOKCRvgsTreIQKJ6a6F8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxjwSkAzKxfgbc4ek/Tyt/xtZSfy37BJK4aXsfQMUdQ4PKS5HT5P+J+lCEXwRbDrxHgd0fFAO2kyeiD66aq7+yz82XaKPTiLYiWSFvEUI95D1N5owtjwabVdhIOYtjD1Fhn3Eg09iXrMt7ydOthQb6Rnuth+Q3Wffhk4/fyMohA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWCD1O6F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B450C433C7;
	Wed, 20 Mar 2024 10:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710930064;
	bh=IipSOTUrpbfVFxPTbW4SJLskOKCRvgsTreIQKJ6a6F8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XWCD1O6FALeplYBj5OA8LMWPCuojnLZozmfgek5zxP6B9NK8pxucIk416IrkDUrjN
	 aMVZ+TEY6c8/Jf0FtVEUPgdqYT/ranTLlz5pyh8F1J1hQnOpwy4L6ehhXNv6/lcS5o
	 46mAtZjAgmEUHiKtxSXShkmkiCv9xlzYaCg0G7RZjyOk5m5sG7GkEcI4yK7AtNFJM0
	 64lMFt05xRSXcyrf28VEHyiwoW9gEhKQUCiAioGbTUfqi6/8PkFKHixaYh8Y/vrSau
	 VUUC5cy3TtMX8cAj2WO/MFr0rTB16nATUlMO9jLAj3hrWapXKvR6U/ZsxwQuFSeAJz
	 p5yWRcYS3CbPA==
Date: Wed, 20 Mar 2024 11:21:00 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] vfs fixes
Message-ID: <20240320-ameisen-werktag-86c781724557@brauner>
References: <20240318-vfs-fixes-e0e7e114b1d1@brauner>
 <CAHk-=wj-uKiYKh7g1=R9jkXB=GmwJ79uDdFKBKib2rDq79VDUQ@mail.gmail.com>
 <CAHk-=wjRukhPxmDFAk+aAZEcA_RQvmbOoJGOw6w2RBSDd1Nmwg@mail.gmail.com>
 <20240319-sobald-reagenzglas-d4c5b1c644ad@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240319-sobald-reagenzglas-d4c5b1c644ad@brauner>

> > Again, this comment (and the previous email) is more based on "this
> > does not feel right to me" than anything else.
> > 
> > That code just makes my skin itch. I can't say it's _wrong_, but it
> > just FeelsWrongToMe(tm).
> 
> So, initially I think the holder ops were intended to be generic by
> Christoph but I agree that it's probably not needed. I just didn't
> massage that code yet. Now on my todo for this cycle!

So, the block holder ops will gain additional implementers in the block
layer that will implement their own separate ops. So I trust the block
layer with this.

The holder is used to determine whether a block device can be reopened.
So both for internal (mounting, log device initialization) or userspace
opens we compare the holders of the block device. We do have allowed for
quite some time to open the same block device exclusively with different
flags. So there are multiple files open to the same block device and the
holder is used as proof that it can be reopened. So always using the
file as the holder would still mean that we have to compare
file->private_data to determine whether the block device can be
reopened. So it won't get us as much as we'd want.

The reason for the holder to remain valid is that the block layer does
have ioctl operations such as removal of a device in the case of nbd,
suspend and resume used in stuff like cryptsetup. In all such cases we
go from arbitrary block device to arbitrary holder and then inform them
about the operation calling the appropriate callback. So we would still
have to guarantee the validity of the holder in file->private_data.

There are also two internal codepaths where the block device is
temporarly marked as being in the process of being claimed. This will
cause actual openers to wait until bd_holder is really set or aborted
but not fail the actual open. This has traditionally been the case in
the loop code and during user initiated and internally triggered
partition scanning. That could be reworked but would be pretty ugly.

We'll continue considering additional cleanups and latest next merge
window I'll give you a detailed write up what happened.

