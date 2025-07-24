Return-Path: <linux-fsdevel+bounces-55937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87949B103B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 10:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D62E1CC11F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 08:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6649274B58;
	Thu, 24 Jul 2025 08:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1K017Ay4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c7lH1Gvx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCAC274B37;
	Thu, 24 Jul 2025 08:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753346303; cv=none; b=E4pm8co1P9JMvjH0B1SmTeQ9Hrx7EikCj3iudMhvK+tdYQNjkwQPx86/YRIM1sylpsf778e/S0FwTY2DNRHdNqbKh6cxSXhP3VTZfX6PuvQiKVtr2mJn9Nf7a5GKOYzJxf7zlSkfqXSRjZLmdXkofHIXS7F2j2Qkw4Vjanq59os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753346303; c=relaxed/simple;
	bh=xkmAuchO85PXJX6a5YJj/SsULjLX5eE61/0pFhqyTbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3iFGkKet3pkQlEn7qJRmDUiw/wYKCGPFgvU2LkMn7tVswfATypENf9VU9y7/gR4uzjqpvNVqDaPOuBLjj64q0naw0poHRtv2zZQApxS4yZ7xKrCLXMz7GEmEymorgtrHBepY1bDpFuT6yb3U3mZttjhmDw8gwbbhwcOjaI1Xyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1K017Ay4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c7lH1Gvx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 24 Jul 2025 10:38:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753346299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gjP9VTQcQv8SUZ/OchZ93SeeJHdOv3bj7hY4mJLpZUY=;
	b=1K017Ay4LjE/Tiz3tzMHvqQ6/w6geRLJA3i+jcUyOBS8HcXbY8ry9Hywk3fjnfcgJzYhjE
	xDEEiqM7fjkX1bIERVXGXe9wajuRrG1qyrYUK6GqKEbzr61pRAsGh7+sc3v5MgtEar1T8v
	Bo2MAw9G34Va8xx/xS/4zsjN6DlVTbE1PZd0EQ/5MLoTsalTc+KxODzavJHaghDNvlwfDy
	/bDba1tMpLGLrJK4PEIl/4arkdILj90VDMAAAxOzaLvmpMqYcAq1+jH7EgfDEEJOxJ0pJH
	nsc9fNTLSvbyuvSO+Nn8sZEhRFLl/oGcJd+H9Jxuer8xs+AQsSSErutShgVxFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753346299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gjP9VTQcQv8SUZ/OchZ93SeeJHdOv3bj7hY4mJLpZUY=;
	b=c7lH1GvxJpP+TlVwmmbf6h7ApUcZFBC3nBNiLkDtqWFXw+auY1gCrjQ9igrjn0N9iHD81c
	ON9bImb9aXUqmtCw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/2] umd: Remove usermode driver framework
Message-ID: <20250724103305-c034585a-d090-4998-a40e-af3b5cca5ef6@linutronix.de>
References: <20250721-remove-usermode-driver-v1-0-0d0083334382@linutronix.de>
 <20250721-remove-usermode-driver-v1-2-0d0083334382@linutronix.de>
 <20250722063411.GC15403@lst.de>
 <20250723090039-b619abd2-ecd2-4e40-aef9-d0bbb1e5875e@linutronix.de>
 <20250724072918.GA29512@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250724072918.GA29512@lst.de>

On Thu, Jul 24, 2025 at 09:29:18AM +0200, Christoph Hellwig wrote:
> On Wed, Jul 23, 2025 at 09:01:16AM +0200, Thomas Weißschuh wrote:
> > On Tue, Jul 22, 2025 at 08:34:11AM +0200, Christoph Hellwig wrote:
> > > On Mon, Jul 21, 2025 at 11:04:42AM +0200, Thomas Weißschuh wrote:
> > > > The code is unused since commit 98e20e5e13d2 ("bpfilter: remove bpfilter"),
> > > 
> > > Overly long commit message here.
> > 
> > 75 characters are allowed, no?
> 
> 73.

Documentation/process/submitting-patches.rst:

	The canonical patch message body contains the following:

	  (...)

	  - The body of the explanation, line wrapped at 75 columns, which will
	    be copied to the permanent changelog to describe this patch.


scripts/checkpatch.pl:

	# Check for line lengths > 75 in commit log, warn once
			if ($in_commit_log && !$commit_log_long_line &&
			    length($line) > 75 &&
			      (...)) {
				WARN("COMMIT_LOG_LONG_LINE",
				     "Prefer a maximum 75 chars per line (possible unwrapped commit description?)\n" . $herecurr);
				$commit_log_long_line = 1;
			}


What am I missing?

