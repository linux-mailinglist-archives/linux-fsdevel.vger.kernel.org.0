Return-Path: <linux-fsdevel+bounces-15195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5984288A2AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 14:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E7A41F3BDE5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 13:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F627152171;
	Mon, 25 Mar 2024 10:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0abnv1e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFC8129A9A;
	Mon, 25 Mar 2024 08:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711355311; cv=none; b=eXBuhdpT4xsY8z3k2G1Ju8ZvJ5p9dEz0nlVDgQKIRL12EqUsOpQ+BYX+joAtR1zTVgjvx8Qbnw7iu6AnITdY/xdZm2Ahw8dSU5v7kpI3hONVaP6vWptpkKJIi611BulJ3BpF/K2DBLsPOpfv3KxuslrlUtSXAKRyvjk14g++pKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711355311; c=relaxed/simple;
	bh=RMBDhtLJFHpfCbaX9R2WGjf18nDYg0WPC7sGTRlkJws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCvfSArLP112g+6OoaRioUVEh8yWbQXGndR6xKasBy+6KbWawcUQ5qBv7s9Agcr9CMInxu1VV9o9JUu8gSrJVaYioLWR5co/5F6wSXnw0jntZfp1jXA11vpGZttLWFo0zLnvsokXl90hxiZU4X/B/BqDGqj+9ZoBOyWc7wB/MtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0abnv1e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E064CC433C7;
	Mon, 25 Mar 2024 08:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711355311;
	bh=RMBDhtLJFHpfCbaX9R2WGjf18nDYg0WPC7sGTRlkJws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U0abnv1e2DCdX9wu4/1zgBQRQ+WknXqlH9QwRLIVjD6t/wrheAkk3iektDmq0QmVx
	 fXrAVvmUTyq9BatngAtaSVKYWats+U5O9qcbIQz4GsBQt+FWg3zMC+M90YyN/svuCo
	 BMXQ+zwvocKn+Bd2sfxc3Kz8gFjdaMidc9qtSi5o9tIf6WtUln5TrXKCTbsdMSrHfQ
	 lMO09G20QnfJYE96Ag5bYgu6VoAMbfursYfW6L3ZquWsNpVuOwGWTjflcr8s1eBsrO
	 DjNjSiWI202gx2qK1M+OBHd6uQfVzCct+PcILEZ1IqVFkRoOBkfgGa6d3y4z0B9fWM
	 lgd4d5AKtcYGw==
Date: Mon, 25 Mar 2024 09:28:25 +0100
From: Christian Brauner <brauner@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	linux-fsdevel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev, 
	Anton Altaparmakov <anton@tuxera.com>, Namjae Jeon <linkinjeon@kernel.org>, regressions@lists.linux.dev
Subject: Re: [PATCH] fs: Remove NTFS classic
Message-ID: <20240325-halbnackt-flutlicht-688f1de80b35@brauner>
References: <20240115072025.2071931-1-willy@infradead.org>
 <20240116-fernbedienung-vorwort-a21384fd7962@brauner>
 <Zf2zPf5TO5oYt3I3@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zf2zPf5TO5oYt3I3@hovoldconsulting.com>

On Fri, Mar 22, 2024 at 05:35:09PM +0100, Johan Hovold wrote:
> On Tue, Jan 16, 2024 at 10:33:49AM +0100, Christian Brauner wrote:
> > On Mon, 15 Jan 2024 07:20:25 +0000, Matthew Wilcox (Oracle) wrote:
> > > The replacement, NTFS3, was merged over two years ago.  It is now time to
> > > remove the original from the tree as it is the last user of several APIs,
> > > and it is not worth changing.
> 
> > I see no reason to not at least try and remove it given that we have
> > ntfs3 as a replacement. Worst case is we have to put it back in. Let's
> > try it.
> 
> This patch breaks boot of my Lenovo ThinkPad X13s where I have an fstab
> entry to access firmware from the original Windows partition; ended up
> in some kind of systemd emergency mode.
> 
> Fix is easy enough once I figured out what broke, but requires changing
> the fs type from 'ntfs' to 'ntfs3' in the fstab (after enabling NTFS3 in
> the kernel config).
> 
> Is it possible to provide an alias or something to avoid breaking
> people's machines like this? Perhaps something is needed for the Kconfig
> too.
> 
> I also now get a bunch of warning when listing the root directory:
> 
> [   68.967970] ntfs3: nvme0n1p3: ino=130d6, Correct links count -> 1.
> [   68.969137] ntfs3: nvme0n1p3: ino=13a, Correct links count -> 1.
> [   68.969798] ntfs3: nvme0n1p3: ino=3ad, Correct links count -> 1.
> [   68.970431] ntfs3: nvme0n1p3: ino=3d9, Correct links count -> 1.
> [   68.971150] ntfs3: nvme0n1p3: ino=26, Correct links count -> 1.
> [   68.971780] ntfs3: nvme0n1p3: ino=eb, Correct links count -> 1.
> [   68.972263] ntfs3: nvme0n1p3: ino=1ce, Correct links count -> 1.
> [   68.973062] ntfs3: nvme0n1p3: ino=a608, Correct links count -> 1.

This shouldn't warn because it's correcting this on the fly.

> 
> Flagging this as a regression so that Thorsten is aware of it:
> 
> #regzbot introduced: 7ffa8f3d3023

Thanks for the report. I'll send a fix.

