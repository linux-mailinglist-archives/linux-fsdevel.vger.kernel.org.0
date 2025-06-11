Return-Path: <linux-fsdevel+bounces-51280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1E5AD51F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 12:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06CA73AAA27
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 10:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E452276054;
	Wed, 11 Jun 2025 10:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXp2xmk2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C9B26AAB2
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 10:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749637918; cv=none; b=hqMzTBQtpoDZ88AdDgbpGNa7Cl+htvwbdszVEM/rC54pJAI/BxQ/i1lIrpIVdd7DSz7iuvMRXZ0So3Z2cSaR6t8klppaGR2r0DKfHPPvrM9pHnw5YvqtXFBpFvr+iBBUmMydqdwrYL5CR3jKKnryHkRxWVL/CyPI8UAPsWSYe2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749637918; c=relaxed/simple;
	bh=52iJakoNUfL/vAC7DCoVjogWZewMXcj2zycvmDtd2gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BL5eaiaVfTv6ykd51HrloE87rCAz75zHsvED2YrpYjTpnymVq+4BN/GqPxH0uVeAcvi/n+2PTvVSjt/EQJa24AE+GKEXPL0zdCtWTaRKtbDRL8/zuabHKubbzd68rsF5RbmT8X7E5dAeqJUk2qntvb+kIIzAQ9+/Ns/L3jSdSow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXp2xmk2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1DDEC4CEF3;
	Wed, 11 Jun 2025 10:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749637918;
	bh=52iJakoNUfL/vAC7DCoVjogWZewMXcj2zycvmDtd2gc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lXp2xmk2/AXohPFG0Uu+pAwBzm1UtYDf6kdqy4Ve1IThSYTxbWLOrlgiXGdUf5lQ3
	 NdRsrQVpDczImbe+ZHA2bREyjxe5xvnxQuXEkCl8T4IKvmnE/KQmG/nZRJwB2BReVo
	 KGS0toLSNCD5VotAghLyaji6O/DLbZ3s4WSIB+F4qPEgb3Iu33mzmeD61+Thzq5ciV
	 4573DhlAekNus95HPVQwgA5QIstQlugLvClSnBUcFq9eeqXaT+Cm96WlHh1cs/iNRJ
	 3u7qsf1n2ydgsSaB8j90MslIafYx1Q5XvyEcVVKJQORNXaX6OC2svxlKPTaz/CbVOO
	 h6E5zm0NTUlVg==
Date: Wed, 11 Jun 2025 12:31:54 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCHES][RFC][CFR] mount-related stuff
Message-ID: <20250611-ehrbaren-nahbereich-7bb253d46a94@brauner>
References: <20250610081758.GE299672@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250610081758.GE299672@ZenIV>

On Tue, Jun 10, 2025 at 09:17:58AM +0100, Al Viro wrote:
> 	The next pile of mount massage; it will grow - there will be
> further modifications, as well as fixes and documentation, but this is
> the subset I've got in more or less settled form right now.
> 
> 	Review and testing would be very welcome.
> 
> 	This series (-rc1-based) sits in
> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.mount
> individual patches in followups.
> 
> 	Rough overview:
> 
> Part 1: trivial cleanups and helpers:
> 
> 1) copy_tree(): don't set ->mnt_mountpoint on the root of copy
> 	Ancient bogosity, fortunately harmless, but confusing.
> 2) constify mnt_has_parent()
> 3) pnode: lift peers() into pnode.h
> 4) new predicate: mount_is_ancestor()
> 	Incidentally, I wonder if the "early bail out on move
> of anon into the same anon" was not due to (now eliminated)
> corner case in loop detection...  Christian?

No, that wasn't the reason. When moving mounts between anonymous mount
namespaces I wanted a very simple visual barrier that moving mounts into
the same anonymous mount namespace is not possible.

I even mentioned in the comment that this would be caught later but that
I like it being explicitly checked for.

