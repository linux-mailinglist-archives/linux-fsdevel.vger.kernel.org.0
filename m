Return-Path: <linux-fsdevel+bounces-61260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 297D8B56BEE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 21:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94AD01894828
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 19:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DC82E6135;
	Sun, 14 Sep 2025 19:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="H1p+lIHZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A981D618A
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Sep 2025 19:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757879764; cv=none; b=kK0iGc2c09cloKB+T1nQxAkxwJ6z6ctA9A0yFHYzzmK2Cz0vZAPNzVUOErGzn/3yhEW5NdaqBceH23RVLirEJ1g2aMlJD6q/Q+Puk3Jne9Qb/XpCaPluu4N4/oi2yxYTifC7eD0Pf3A1Wesph0Io4g1PbyHyEMtT4wqMxmP1Dj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757879764; c=relaxed/simple;
	bh=QwLGSbPsOvnCSPAqfW2D5eSaRMiPSlrFYLfjpbQikVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpcUNVrG8608FREkQK7b+t2826qC4wYAYFNK0QzBGlcGnWrVEKFY11kB4/zmEXgVCOSFrdrjG5IcgDPczcoskBuBWgFAeA3sMlxABy9qemfjhfRBTH6SkIy/Phjx2tN571WWOOBECoqzlBcEoq7VjTZQXZzs5K9c2uZ64Hq5+ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=H1p+lIHZ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7YwZ6aUmZVKar37CDz+A4Vh8ZGliQWehcX4/e4Oca1c=; b=H1p+lIHZWfbxw2zs+2QPERqXHW
	4UsxnKCWqhAGJYWCDr7rfoz8t2HKUx90827VGP3AqFqi/FfPRAbBFhtXexoA+SAYyVpV+cy2lZLvg
	6/NlJhVHDJaDxXGS4LORB6lkj9sOQFHWFU+qVnMF3/H1UO3c3qYKoYGOiAha9/G4X5Ms8BP7hUJwA
	L4Oj0gzi+MX+JwUpA6qyANKCgUobyBVtDX4f3PybLGZLWfzk0ZJxY4tPCmbeSUYCZeXX+mrQCE3lN
	Q31zzPHOWUpNOnFMar9wZOkCQ2wJu6UILU8TkGw/XqizqfYWD+3u/twJWNPV8sUi4vDIOQK/egefi
	UHhbeLoQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxspL-0000000G5N6-3AXV;
	Sun, 14 Sep 2025 19:55:59 +0000
Date: Sun, 14 Sep 2025 20:55:59 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Askar Safin <safinaskar@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 46/52] path_umount(): constify struct path argument
Message-ID: <20250914195559.GJ39973@ZenIV>
References: <20250825044355.1541941-46-viro@zeniv.linux.org.uk>
 <20250914182552.1661507-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250914182552.1661507-1-safinaskar@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Sep 14, 2025 at 09:25:52PM +0300, Askar Safin wrote:
> Please, drop this patch.
> 
> I plan to inline path_umount into the only caller in
> v2 version of my initrd removal patchset
> https://lore.kernel.org/lkml/20250913003842.41944-1-safinaskar@gmail.com/
> .
> 
> (path_umount is called in one place only
> after initrd is removed.)

Um...  That'll conflict with more than that commit - take a look at
"do_mount(): use __free(path_put)" in there.  So let's do that inlining
later...

