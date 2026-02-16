Return-Path: <linux-fsdevel+bounces-77257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCjDGB9rkml4twEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 01:55:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFFC140812
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 01:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8050301E973
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 00:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3468726F2A0;
	Mon, 16 Feb 2026 00:55:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from janus.otherwize.co.uk (janus.otherwize.co.uk [185.73.44.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E24A1D63D1;
	Mon, 16 Feb 2026 00:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.73.44.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771203346; cv=none; b=WcnTO/r8ufBxcspusayFUYcovnrZsFctsUkJoyZMtyRQmOeuOaFp/kn1u25jTMLpZkFuYVZvv4jwacBj8k0CVYb/jPRnnlmjwfHYGyyXtbRom6A7L+6Sxj/hq4MCH17R2KI74oW9dR3rHhFyf1MDPNsE7Towhclgr7HJQ0Fuy2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771203346; c=relaxed/simple;
	bh=fvkR0Wh8KtO0lrdxTcYcUHxzWKd3DSAIhWmKgWV6eIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OzIYUNmkVnlFkuQKs+ARDtzGIQbExhsE0YtKXN0NyexH5AgbB4kszc2xPjD04tTwTNNgNWUAEgccMR1pbAyy9BxCqoJ1uLM8xpyawOiR5MSBEZ5Ez82NR3wpHmy/SrEy/lB3i/2reY02egvm1KumluJXV0qNm95sdkGeSXv86U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dgl.cx; spf=pass smtp.mailfrom=dgl.cx; arc=none smtp.client-ip=185.73.44.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dgl.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dgl.cx
Received: from melos.hm.i.d.cx (melos.hm.i.d.cx [10.1.91.149])
	by janus.otherwize.co.uk (OpenSMTPD) with ESMTP id 3d60e48d;
	Mon, 16 Feb 2026 00:49:03 +0000 (UTC)
Received: from localhost (melos.hm.i.d.cx [local])
	by melos.hm.i.d.cx (OpenSMTPD) with ESMTPA id 53709845;
	Mon, 16 Feb 2026 11:48:27 +1100 (AEDT)
Date: Mon, 16 Feb 2026 11:48:27 +1100
From: David Leadbeater <dgl@dgl.cx>
To: Shyam Prasad N <nspmangalore@gmail.com>
Cc: lsf-pc@lists.linux-foundation.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, keyrings@vger.kernel.org, CIFS <linux-cifs@vger.kernel.org>, 
	linux-nfs@vger.kernel.org, brauner@kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [LSF/MM/BPF TOPIC] Namespace-aware upcalls from kernel
 filesystems
Message-ID: <aZJmthYtk33KYDud@melos.hm.i.d.cx>
References: <CANT5p=rDxeYKXoCJoWRwGGXv4tPCM2OuX+US_G3hm_tL3UyqtA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANT5p=rDxeYKXoCJoWRwGGXv4tPCM2OuX+US_G3hm_tL3UyqtA@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77257-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dgl.cx];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dgl@dgl.cx,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,spinics.net:url]
X-Rspamd-Queue-Id: ACFFC140812
X-Rspamd-Action: no action

On Sat, Feb 14, 2026 at 03:36:22PM +0530, Shyam Prasad N wrote:
> I tried to prototype a namespace aware upcall mechanism for kernel keys here:
> https://www.spinics.net/lists/keyrings/msg17581.html
> But it has not been successful so far. I'm seeking reviews on this
> approach from security point of view.

I have more context from the containers side, but to me this doesn't
appear safe. Entering the right namespaces isn't enough to safely run
code within a container. The container runtime may have set up seccomp
or other limits which this upcall won't respect.

I would like to see a solution to this though, we currently have custom
callback code to make this work. I'm not familiar enough with the
interfaces but an approach where something registers also seems
desirable because it is able to preserve backwards compatibility, which
changing the namespace the upcall runs in doesn't.

David

