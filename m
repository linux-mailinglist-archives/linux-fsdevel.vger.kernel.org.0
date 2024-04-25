Return-Path: <linux-fsdevel+bounces-17702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 204F78B1940
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 05:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1A05287AE2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 03:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B747520DFF;
	Thu, 25 Apr 2024 03:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PspTijnP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F78F513;
	Thu, 25 Apr 2024 03:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714014757; cv=none; b=qLuhEiTxRwQPDgzZx8mQQch319DdTsLoxugQLQ/G3sZGZdQeTLhabJD950yCU1z9x2MDoVup7lO0SouBZblOz7lE3ub6Nr0MNrbltB38NdG6jaC1btQob7fFDqf3/1taIn4RVA3rfBjswLDu9Hes1X0bJ5iWIEtKJbdmaqPOFqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714014757; c=relaxed/simple;
	bh=Cc9/KJ14ILnwNdU8czLRH7creacZ14o3hne1jmTaNs0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RsAbKdNp1mjCpTw7Guq/RC+smplDVwBwX1GiCMHzDvCSeMwaSHvw45y5qFh9NDn/XvUkQmS5r3Z87dljqRElzLc+FVU3IdOd0Z3OvcHIYskq8yLOBGR5a1bGkrHOO7r7cNUZvDgnCrS/Wg22ibqGQ/FqbhF+DmHZbrs1jCyzJGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PspTijnP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C57C113CD;
	Thu, 25 Apr 2024 03:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714014756;
	bh=Cc9/KJ14ILnwNdU8czLRH7creacZ14o3hne1jmTaNs0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PspTijnPTb4cLwKaUXaBK6lgKqrykqW7TnXryDjg7qy1V4DjZ9qYPfEzdMwJcLXmE
	 2q4vN4nwJllD1z/pH7aACsx2p2ofCITa183q4xZiAclRBaq/82Q7A/KwffAzVOELei
	 BATUW6SiIq4LeUt/sDYn/hnGKl2shhXeP1rwhzi0rZHTU/OxLjZRFcQA8QACF8kBTq
	 Md3p5a2MNJIshoUuU+UOn1xH4LNXomCzxGby8JGUI0mSu2HkcgWhSAkP5pU+L9gZk0
	 nFvpPG5wZraQmtC6JOcQTZn622/SbjwBkjxqFODHiN0ijyqtZ768dGuDQszSMnLkI8
	 ayXyd+53H5Hzw==
Date: Wed, 24 Apr 2024 20:12:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <linux@weissschuh.net>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Joel Granados
 <j.granados@samsung.com>, Kees Cook <keescook@chromium.org>, Eric Dumazet
 <edumazet@google.com>, Dave Chinner <david@fromorbit.com>,
 linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-mm@kvack.org, linux-security-module@vger.kernel.org,
 bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-xfs@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, kexec@lists.infradead.org,
 linux-hardening@vger.kernel.org, bridge@lists.linux.dev,
 lvs-devel@vger.kernel.org, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org,
 linux-nfs@vger.kernel.org, apparmor@lists.ubuntu.com
Subject: Re: [PATCH v3 00/11] sysctl: treewide: constify ctl_table argument
 of sysctl handlers
Message-ID: <20240424201234.3cc2b509@kernel.org>
In-Reply-To: <20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net>
References: <20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Apr 2024 09:54:35 +0200 Thomas Wei=C3=9Fschuh wrote:
> The series was split from my larger series sysctl-const series [0].
> It only focusses on the proc_handlers but is an important step to be
> able to move all static definitions of ctl_table into .rodata.

Split this per subsystem, please.

