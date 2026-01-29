Return-Path: <linux-fsdevel+bounces-75839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOAlO2EPe2nqAwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 08:42:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 134D3ACDC7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 08:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5DF2E300EBC5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 07:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F1337A4B7;
	Thu, 29 Jan 2026 07:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="ks6H4zHV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F26379971;
	Thu, 29 Jan 2026 07:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769672072; cv=none; b=q8+4B+4MJ9+aA42plDmi2j9qe8ucOUti10LztK8k6hHeHRA1MBQqr5CYvWsuSByo8dv8j2ARxpsKToJxiHJN3FaD4fz5uODnFS83SBbACSlAOzN9pOFmLgzbbdwlSEelApSCAuGZrUxFaWaXnA1uzgVc7kPoR/PAJlRVNKM8XMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769672072; c=relaxed/simple;
	bh=yQEqfz2MbvPICSTCvSNhPztnZBDYtLxhQtKzjXKMjjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBDSsnxsv8yaTVGcvckuCyDkQmxK0TC4ZKMYcvIPc4u/KQrBgtnkp/2gpOUj34b2s0oNi3JnWyOFPJPzUhGs6B+NtVz3IJHO49JjLQZMe3XKwNV2ZjCGFGbLDd/2lkBjs3IbqZpn7MuXr4Ef8uBXqaZ50Xd8CtP4SxKDyn2UcN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=ks6H4zHV; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id F222E14C2D6;
	Thu, 29 Jan 2026 08:34:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1769672060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CbxMfdr18Mlajagyem0pImC+MrLNxD7wwFw85H+Wpok=;
	b=ks6H4zHVlmo7Yoo+AA3awTv6g9/sYwGLO36r5FOEao0lqDDdJijKIX9bpFGRloK1qXqskv
	gWN9THhZOrrCeVewxDNMn+Xbe7DG8Tz1UrGXpFcb4yZqWkagZQrY+45ZZE8/GvpsFaA3uq
	iEwJp5N8Pyj7FICer3teyYkLiMNqgnkCYtYxYw/kRTjLL3U6+6W+GX3pg4SZJFzvxFbmZK
	53FlgMg9y8v8Gb58StknjrWw3G1mfI9SZ3v+5kvfEyE3nvJqaGcKr9Gwbnm22lQI3NzD6X
	7CsrIg0d5PqMsZ9INItChNi3pf8pE0mmp7kVE4BFucGKKkyuipXmq/+Rx3G58w==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 3200ecac;
	Thu, 29 Jan 2026 07:34:16 +0000 (UTC)
Date: Thu, 29 Jan 2026 16:34:01 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Remi Pommarel <repk@triplefau.lt>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	v9fs@lists.linux.dev, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] 9p: Track 9P RPC waiting time as IO
Message-ID: <aXsNaUU9I9FoY8IW@codewreck.org>
References: <cover.1769179462.git.repk@triplefau.lt>
 <b8601271263011203fa34eada2e8ac21d9f679e5.1769179462.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b8601271263011203fa34eada2e8ac21d9f679e5.1769179462.git.repk@triplefau.lt>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codewreck.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[codewreck.org:s=2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[codewreck.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75839-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmadeus@codewreck.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[triplefau.lt:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,codewreck.org:email,codewreck.org:dkim,codewreck.org:mid]
X-Rspamd-Queue-Id: 134D3ACDC7
X-Rspamd-Action: no action

Remi Pommarel wrote on Fri, Jan 23, 2026 at 03:48:08PM +0100:
> Use io_wait_event_killable() to ensure that time spent waiting for 9P
> RPC transactions is accounted as IO wait time.
> 
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>

Thank you!

Peter, Ingo -- I'll take both patches unless you prefer to take all
changes to include/linux/wait.h in the scheduler tree, please let me
know.

If this doesn't go through my tree:
Acked-by: Dominique Martinet <asmadeus@codewreck.org>

-- 
Dominique Martinet | Asmadeus

