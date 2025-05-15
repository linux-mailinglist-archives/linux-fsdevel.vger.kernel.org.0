Return-Path: <linux-fsdevel+bounces-49115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD93FAB8283
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 11:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6241D3AB5F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 09:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8401E29712E;
	Thu, 15 May 2025 09:26:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF660296FC8;
	Thu, 15 May 2025 09:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.157.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747301188; cv=none; b=QrU6CmctrVBism+T1SMMGRxSI3hLgzLlV+ENDp5g1nPDhNthgmyJGNTou3ccIt+42bk4qTa5VdBiH11cvCTB2FFp7ySd9xkGPFV8DZIpGX9MSWKKTvrKsPNvsftqLZTBxjnYzm2JQQNx15A0Wsy8sn3m2x7hPvEn+ZqumFyWclU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747301188; c=relaxed/simple;
	bh=+yvk+y/BFJBzQOBxJ2/jSQOkaomv38brdxHq6fz2wUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mh9DrBAgrjS/YRDNMNOkTBvtqRLCb2Mwddt61xt0XzR7LI9Hq1JuDfetLYPVXpO28s2rQijmTN7Rqoe0l/uIiJDxCKr9+782XpkoErOuTVO6S9t95cgBifar50AJIV9dvamSE/j/PmnWX/LOKjApgAolsqFTiuxKTqdB4viC08M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de; spf=pass smtp.mailfrom=0pointer.de; arc=none smtp.client-ip=85.214.157.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0pointer.de
Received: from gardel-login.0pointer.net (gardel-mail [85.214.157.71])
	by gardel.0pointer.net (Postfix) with ESMTP id 4AD78E803E2;
	Thu, 15 May 2025 11:26:16 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id 5CD7A16005E; Thu, 15 May 2025 11:26:14 +0200 (CEST)
Date: Thu, 15 May 2025 11:26:14 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	David Rheinsberg <david@readahead.eu>,
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>,
	Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Subject: Re: [PATCH v7 0/9] coredump: add coredump socket
Message-ID: <aCWzNrAwTK4YvOcv@gardel-login>
References: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org>

On Do, 15.05.25 00:03, Christian Brauner (brauner@kernel.org) wrote:

> Coredumping currently supports two modes:

[...]
> ---
> base-commit: 4dd6566b5a8ca1e8c9ff2652c2249715d6c64217
> change-id: 20250429-work-coredump-socket-87cc0f17729c

Looks lovely, thank you!

Looking forward to hooking this up with systemd-coredump!

Lennart

--
Lennart Poettering, Berlin

