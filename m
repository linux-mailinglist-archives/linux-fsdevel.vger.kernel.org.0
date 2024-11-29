Return-Path: <linux-fsdevel+bounces-36168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C61EF9DED47
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 23:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 834CC163C64
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 22:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E411A7044;
	Fri, 29 Nov 2024 22:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjDx8ZMA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D3B39ACC;
	Fri, 29 Nov 2024 22:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732920710; cv=none; b=foL6Xod93I9tFxjNYDNB+Py5H9xb/r3VFbDqEwzqr/JB8joy2vRE+Mnb9YIMuC1nKFRWqzeRCT3J+uqdMBIgOwj2m3hkJ9KnOoaGBdNm/nksgFUnPRKlGFzhisfcuKkX3eh8lBWtoVSJjTQx2rjJ2L+PehNV6n6yuP//v3rSds0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732920710; c=relaxed/simple;
	bh=Zg3yS4mgSR4cNkXShAnD3HPSN9DdSo24DjduLSZUNdg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rKBw2RW7nsd56H4bRyhCGsxdmEVYOi9fyKgcZRHhtb2mA/Y8YfBPFEzr8+a0OUe7oCcUHfcadh8uWRmq360lQIJMLeIipnDnZ6KM0n5xDDuIRts8PIYZ6PEzazgEFSqeUTvJPqOXXERBUA7n7FXkW4hE2mbkzGFHuAuIT1ksVZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjDx8ZMA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3C4C4CECF;
	Fri, 29 Nov 2024 22:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732920709;
	bh=Zg3yS4mgSR4cNkXShAnD3HPSN9DdSo24DjduLSZUNdg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=TjDx8ZMAqcvswsoZbzWplX4dDytfE+odqW/ynEpLDES8sGDHhVg64H5s+fTPzacoK
	 Kt6cuXIgdpm/TZTkGF+4B8IFydLgCyjNcurMUibI7UfP0uiUuTSXrFg+S8bseK75Pe
	 cYfqEDSsbY1sRdzQ+maS5DRe5UBslyV2nnwGk3M4mr2osEL4+3E7aM0aKFTeL4sT1k
	 wm9HI7LHxsmN7ZIo0cXzBCHwymPfiADzKcYrA6JI1CD2+xXjkczYaUJ7Msv+UjNXpD
	 bqcR4OJ5D0QAy3p+enIV++amIKL0rQwvDRJ7X8wV4iQ1hrLFCCOfjLei4534Lmk/vl
	 1akMJHmwMUZBA==
Date: Fri, 29 Nov 2024 16:51:47 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Aleksandr Nogikh <nogikh@google.com>
Cc: syzbot <syzbot+fe139f9822abd9855970@syzkaller.appspotmail.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev, syzkaller-bugs@googlegroups.com,
	v9fs@lists.linux.dev
Subject: Re: [syzbot] [netfs?] WARNING in netfs_retry_reads
Message-ID: <20241129225147.GA2777799@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANp29Y5ujSAQg4_dhoxQQFHeb15Eukkswrzv9uMiZ5m6y6z4uQ@mail.gmail.com>

On Fri, Nov 29, 2024 at 11:16:08PM +0100, Aleksandr Nogikh wrote:
> So if it's e.g. just the bisection result that was wrong, while the
> crash report itself is legit, it's better to not use the "#syz
> invalid" command. I've added +1 to our backlog issue for adding a
> special command to cancel only the misleading bisection result [1].

What's the appropriate command for a bad bisect?

