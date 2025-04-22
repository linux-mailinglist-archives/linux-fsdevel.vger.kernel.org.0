Return-Path: <linux-fsdevel+bounces-46896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A6DA95F77
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 09:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AF9916DE20
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 07:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B8D1B85FD;
	Tue, 22 Apr 2025 07:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwrK8HrY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044F0524C
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 07:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745307078; cv=none; b=ZjM5vTR57wvFzv80GqswmKezGdsJftzpY4wJaI9jyHuGWrbmelZwF9hweu5Qd1Ac4AEpAr4HyU28w9zSa4ZC4jz/cNo4IwSoKL6C74alEd+NC0h0ynVsD0TSE8kn3VBjC1yro+skXcfwaEMrft7i9xEs5/AEdttU5BAJ8fcH1Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745307078; c=relaxed/simple;
	bh=XknI/gqHUX+0xgt6i9DwszW6kLVSB7devccNcUM+jMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FyydmBVo090+JwKJSsO+A96O/di9XpQxu7ZDriZXuG5a0sIhPX1G6eL4Da7PJj48jUbIa0i8s2mPu6aUysyFNIIFmxZQrGEELzLAbOPo9Cs3Yag4NCyzG/rvqxEf2Vjz2F+q09S3glTKf/r67IEBlYqB3nFUj+r5zuuht+qqhl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwrK8HrY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D24CC4CEE9;
	Tue, 22 Apr 2025 07:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745307077;
	bh=XknI/gqHUX+0xgt6i9DwszW6kLVSB7devccNcUM+jMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KwrK8HrY8RT1FP87h/52GLdX7XYdZdUzFW+PbLvWTqriyPbhZEmm69q4l4dC5OA4M
	 tuHURZNNzY9Y/uuz9D8cQZgsOZuUGR1c9zn6DvhispxEPlv0CDqXZ4Xt/wMYAbdHj4
	 scJ57wrmjJD3mBdDo/JNh2PRZXTuq1tEwDtm4StHMI7iqMuiF/YsrKotQGpV7xjwc9
	 zjamwO/GCgE689RjntGGuhBxpgNv2Qc8K9084hLFFvAr1qPSpbq7yk23ADAalYjMum
	 yG3PmLsUHXmcK+WmwwvNUUvUjRsYj4Esv0V6V95JgHG2TFGnuksCIwHw89nNsKUHiY
	 Fw86vhoMGwGHA==
Date: Tue, 22 Apr 2025 09:31:14 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH][RFC] ->mnt_devname is never NULL
Message-ID: <20250422-erbeten-ambiente-f6b13eab8a29@brauner>
References: <20250421033509.GV2023217@ZenIV>
 <20250421-annehmbar-fotoband-eb32f31f6124@brauner>
 <20250421162947.GW2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250421162947.GW2023217@ZenIV>

On Mon, Apr 21, 2025 at 05:29:47PM +0100, Al Viro wrote:
> On Mon, Apr 21, 2025 at 09:56:20AM +0200, Christian Brauner wrote:
> > On Mon, Apr 21, 2025 at 04:35:09AM +0100, Al Viro wrote:
> > > Not since 8f2918898eb5 "new helpers: vfs_create_mount(), fc_mount()"
> > > back in 2018.  Get rid of the dead checks...
> > >     
> > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > > ---
> > 
> > Good idea. Fwiw, I've put this into vfs-6.16.mount with some other minor
> > stuff. If you're keeping it yourself let me know.
> 
> Not sure...  I'm going through documenting the struct mount lifecycle/locking/etc.
> and it already looks like there will be more patches, but then some are going
> to be #fixes fodder.
> 
> Example caught just a couple of minutes ago: do_lock_mount()
>                 if (beneath) {
>                         m = real_mount(mnt);
>                         read_seqlock_excl(&mount_lock);
>                         dentry = dget(m->mnt_mountpoint);
>                         read_sequnlock_excl(&mount_lock);
>                 } else {
>                         dentry = path->dentry;
>                 }
> 
>                 inode_lock(dentry->d_inode);
> What's to prevent the 'beneath' case from getting mnt mount --move'd
> away *AND* the ex-parent from getting unmounted while we are blocked
> in inode_lock?  At this point we are not holding any locks whatsoever
> (and all mount-related locks nest inside inode_lock(), so we couldn't
> hold them there anyway).
> 
> Hit that race and watch a very unhappy umount...

If it gets unmounted or moved we immediately detect this in the next line:

if (beneath && (!is_mounted(mnt) || m->mnt_mountpoint != dentry)) {

