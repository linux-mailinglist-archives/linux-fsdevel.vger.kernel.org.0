Return-Path: <linux-fsdevel+bounces-50324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F26ACAE85
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 15:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A70A2189F658
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 13:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DD221B9C2;
	Mon,  2 Jun 2025 13:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0JO1AY1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527B142A92
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Jun 2025 13:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748869576; cv=none; b=snb9EZIsztsWJdGzUAiMsZMyzVQnkPWiGCaR9pwA4nmrxviYCAMHemw2DIC1siKcd1SjTnnSrHrSh3cKh9Kra6nqqlipgIH+/QxfpaAj5ym4YI6VxPMVfjuLVNMWHQcZLNG3gj/wE1YrmgLfHduo78rVqH9vRuVkynMWCq6dDCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748869576; c=relaxed/simple;
	bh=AyHIHBe0wO/gvgYdRcrn/FERSouSkrQ1ujvkCR3psOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0YPnfc67kpeHJT1rJMRGQKRHwSh+5HVXuFoXrHTd55icqG8xXLkpMY2ipIh0Q/uFzh4PfkQtviz3uBaFuFxVXcesITge1YU8lGuvR/JFCDhWEFMvKNuYHpYEl5N22/qpOOaX8fer+YdJcKybt681KB2WAc2uvmqdTkeRakM4T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0JO1AY1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A094C4CEEB;
	Mon,  2 Jun 2025 13:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748869575;
	bh=AyHIHBe0wO/gvgYdRcrn/FERSouSkrQ1ujvkCR3psOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E0JO1AY1yY8j9YXE5VwxWaE1TEHEdWKIOzvLg+K+/SRUG3HHTwsa5YMXijfRmtzPW
	 MtW/FhgLG9c+5S20JdcCmCQhDlJs7RT7syjPQo+i73lmtAK4dgimhHYm/FSVXkv/hh
	 lJ1rScu1C3vTXvnFjvDkohuMoWqlbhKfJYfpDKwxuK6ODLyGk4vT2CfkGqFaL7heu5
	 fJ4CKcUKe7ud0sNmwjrr2vusI9zkZ926yNe0XI/6rMMEhCKO4wRgcoHGt1G6Blrfrc
	 Lv8l5gpVSg7CEY+TRgYTWBQZknnARQWE3bQ3PkTQj+jqVQNO45Izf4NyeS+t9XJAbe
	 bzTKsKi4e1CRg==
Date: Mon, 2 Jun 2025 15:06:12 +0200
From: Christian Brauner <brauner@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Luca Boccassi <bluca@debian.org>, stable@kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: Please consider backporting coredump %F patch to stable kernels
Message-ID: <20250602-getextet-stehplatz-35f704165888@brauner>
References: <CAMw=ZnT4KSk_+Z422mEZVzfAkTueKvzdw=r9ZB2JKg5-1t6BDw@mail.gmail.com>
 <20250602-vulkan-wandbild-fb6a495c3fc3@brauner>
 <2025060211-egotistic-overnight-9d10@gregkh>
 <20250602-eilte-experiment-4334f67dc5d8@brauner>
 <2025060256-talcum-repave-92be@gregkh>
 <20250602-substantiell-zoologie-02c4dfb4b35d@brauner>
 <20250602-analphabeten-darmentleerung-a49c4a8e36ee@brauner>
 <2025060246-backlit-perish-c1ab@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2025060246-backlit-perish-c1ab@gregkh>

On Mon, Jun 02, 2025 at 02:49:32PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Jun 02, 2025 at 02:32:24PM +0200, Christian Brauner wrote:
> > v5.14
> 
> Nit, the stable tree is "5.15", not "5.14" :)

Whoops, sorry about that. I misread the kernel.org page. Here's a pr for
v5.15:

The following changes since commit 98f47d0e9b8c557d3063d3ea661cbea1489af330:

  Linux 5.15.184 (2025-05-22 14:08:28 +0200)

are available in the Git repository at:

  git@github.com:brauner/linux-stable.git tags/vfs-5.15.stable.coredump.pidfd

for you to fetch changes up to 6f5694eb02eb15c5976d75ba47fc25b87bc9b717:

  coredump: hand a pidfd to the usermode coredump helper (2025-06-02 15:03:06 +0200)

----------------------------------------------------------------
vfs-5.15.stable.coredump.pidfd

----------------------------------------------------------------
Christian Brauner (4):
      coredump: fix error handling for replace_fd()
      pid: add pidfd_prepare()
      fork: use pidfd_prepare()
      coredump: hand a pidfd to the usermode coredump helper

 fs/coredump.c           | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------
 include/linux/binfmts.h |  1 +
 include/linux/pid.h     |  1 +
 kernel/fork.c           | 98 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 4 files changed, 163 insertions(+), 17 deletions(-)

