Return-Path: <linux-fsdevel+bounces-15112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A791A8870F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 17:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D66B21C2237F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 16:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191225C90A;
	Fri, 22 Mar 2024 16:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oilfk1zh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720CC59163;
	Fri, 22 Mar 2024 16:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711125300; cv=none; b=ohzfMF2ObaL3FD4imUyeBSU6LLoAWDXo7sJgpcHWxGtvAreshxntFpqV6NPM+dIrRFUvzPyJO+dAr/qK+8P+BE4XZBNQylLbWw/RW6EuNl8XNW022dlXVHEra1SvIpiDl75TnjSTSnygihZ9JuAUB0fLOxZoTyY2aqLCa5lonLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711125300; c=relaxed/simple;
	bh=Cm01Q1014eD7bi3Ghg+OrTnDa1xuGXQVz909MO6xnV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjLsqidYFkPyaGAAWe/9MmIU6DJetDSjAItPwfHTh+LOPq1OvCHPQ8/5D9uUwQEw/dQKd+w6yJaXgBNSjoZtzMTeyL5dAXvdhZGWvmXVPFJIj4I1yava1dCXXrjKRh9/YtSNWCclJfgesqzf+gY3tr8H8Zc+S4sbwsSQSjJeMLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oilfk1zh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76F9C433C7;
	Fri, 22 Mar 2024 16:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711125299;
	bh=Cm01Q1014eD7bi3Ghg+OrTnDa1xuGXQVz909MO6xnV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oilfk1zhhkn6/QOWDSz8/xIOh7J5NgEpjruYLPRoOiQu7qb+7CCiRMJ6HGhhZ3G37
	 22WO4Fni5z3Nn7DxP/5MjqDRY7el+s5C9bv1JZLU3yPq9l2G/H2M5wDVc+w63r7+qr
	 gRkiw253U2LkRccgdcHyUFCWWFGf7Aj3XuXLGbxiLUJ4iJjg8uEi6i5CfxoXwxh4G/
	 o8LVa3+Z9Eu1eszg90WUqbizm0iKL+6ux4d7yM2nI8UlJC3wYW+t6pHNq52RMjk9qD
	 YY2utGSjPSnX9dN/R6u1dKE9EPLmLyWFf3JI9xM26pzu+T+qh+sMa8wrSsM7V8LRf+
	 KI6AYxOrY3dTQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rnhrJ-000000002rv-2vlb;
	Fri, 22 Mar 2024 17:35:09 +0100
Date: Fri, 22 Mar 2024 17:35:09 +0100
From: Johan Hovold <johan@kernel.org>
To: Christian Brauner <brauner@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
	ntfs3@lists.linux.dev, Anton Altaparmakov <anton@tuxera.com>,
	Namjae Jeon <linkinjeon@kernel.org>, regressions@lists.linux.dev
Subject: Re: [PATCH] fs: Remove NTFS classic
Message-ID: <Zf2zPf5TO5oYt3I3@hovoldconsulting.com>
References: <20240115072025.2071931-1-willy@infradead.org>
 <20240116-fernbedienung-vorwort-a21384fd7962@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116-fernbedienung-vorwort-a21384fd7962@brauner>

On Tue, Jan 16, 2024 at 10:33:49AM +0100, Christian Brauner wrote:
> On Mon, 15 Jan 2024 07:20:25 +0000, Matthew Wilcox (Oracle) wrote:
> > The replacement, NTFS3, was merged over two years ago.  It is now time to
> > remove the original from the tree as it is the last user of several APIs,
> > and it is not worth changing.

> I see no reason to not at least try and remove it given that we have
> ntfs3 as a replacement. Worst case is we have to put it back in. Let's
> try it.

This patch breaks boot of my Lenovo ThinkPad X13s where I have an fstab
entry to access firmware from the original Windows partition; ended up
in some kind of systemd emergency mode.

Fix is easy enough once I figured out what broke, but requires changing
the fs type from 'ntfs' to 'ntfs3' in the fstab (after enabling NTFS3 in
the kernel config).

Is it possible to provide an alias or something to avoid breaking
people's machines like this? Perhaps something is needed for the Kconfig
too.

I also now get a bunch of warning when listing the root directory:

[   68.967970] ntfs3: nvme0n1p3: ino=130d6, Correct links count -> 1.
[   68.969137] ntfs3: nvme0n1p3: ino=13a, Correct links count -> 1.
[   68.969798] ntfs3: nvme0n1p3: ino=3ad, Correct links count -> 1.
[   68.970431] ntfs3: nvme0n1p3: ino=3d9, Correct links count -> 1.
[   68.971150] ntfs3: nvme0n1p3: ino=26, Correct links count -> 1.
[   68.971780] ntfs3: nvme0n1p3: ino=eb, Correct links count -> 1.
[   68.972263] ntfs3: nvme0n1p3: ino=1ce, Correct links count -> 1.
[   68.973062] ntfs3: nvme0n1p3: ino=a608, Correct links count -> 1.

Flagging this as a regression so that Thorsten is aware of it:

#regzbot introduced: 7ffa8f3d3023

Johan

