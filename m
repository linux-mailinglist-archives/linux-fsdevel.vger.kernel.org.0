Return-Path: <linux-fsdevel+bounces-79353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDxTBaItqGlPpQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 14:03:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF69520004D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 14:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E1D9330338A5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 13:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A7326B75B;
	Wed,  4 Mar 2026 13:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOffS5g7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712DB1B0439;
	Wed,  4 Mar 2026 13:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772629404; cv=none; b=GU1fZ5NZ6c9VuLXGanHWBQf7pXT09H0tQ5f1PVKy/OWxcBUcH050wztBayxC9oNI4P7wjvx5jEH74cFr0V7uRlwtlD3m69AchSQG2Sa7UyuywDuFUTuKqbNjfnCIiHem+VIB9Gxwi08iSySWi53i67YIx+cLMEHrvGJ/RpKx1Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772629404; c=relaxed/simple;
	bh=as/+AFDxUQJJH9EQ7+j52oWVIpgXyF9JEaGwrMSUpWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SaM8QHk0KGn27k18yTzCCAzKMoQlPo94Ck1rYJg5/uBzQr76Ft07HRdsLgCOKuh7y7OFsgJUvY79GStEOCfssQEnw7Jb5X5iHzNSpYwAwG3prEnLD2G6xAH5VdZmgsvePeSaxj/EA3062TLDIlrDykWEQzrn0lr70g8H7OnzL+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOffS5g7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29C4C2BC87;
	Wed,  4 Mar 2026 13:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772629404;
	bh=as/+AFDxUQJJH9EQ7+j52oWVIpgXyF9JEaGwrMSUpWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IOffS5g7+hhMm74zWhFLTABJyW9rGFMQ2Sp2AI+HJGM1rnjhdUI9tsNnW58SHX0wR
	 PUNJNohuW8tSNFDVvunJaOXvH0VrmSgsbl/9f7iWOnZewE82rHuT9A8LawpzBBaY/x
	 mTUfps13Cj0X9ctvsxFKOlbDJySzcmnhy2lRCXoTvKNW/+VDP0XlAJnT1XjiQF0wIa
	 8kCLaiNv+6g7C9kJWoNpgFg/GNYlAPCjQC1f/pRtYdCrMjVkR8CwBLNHsSgWK31+HC
	 nWl0UYe1BNnR1Vehvgo97Tkic5VUB4vsrr4LgcuTOgKImZXbPoNNOKGcGfo/0VzBTd
	 NHJ1bnXVqpPiw==
Date: Wed, 4 Mar 2026 14:03:20 +0100
From: Christian Brauner <brauner@kernel.org>
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org
Subject: Re: Possible newline injection into fdinfo
Message-ID: <20260304-wertigkeit-rockkonzert-ac7270334804@brauner>
References: <08f230b4-8c01-45b8-9956-7cfb9f82eeff@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <08f230b4-8c01-45b8-9956-7cfb9f82eeff@gmail.com>
X-Rspamd-Queue-Id: AF69520004D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79353-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 01:53:42AM -0500, Demi Marie Obenour wrote:
> I noticed potentially missing input sanitization in dma_buf_set_name(),
> which is reachable from DMA_BUF_SET_NAME.  This allows inserting a name
> containing a newline, which is then used to construct the contents of
> /proc/PID/task/TID/fdinfo/FD.  This could confuse userspace programs
> that access this data, possibly tricking them into thinking a file
> descriptor is of a different type than it actually is.
> 
> Other code might have similar bugs.  For instance, there is code that
> uses a sysfs path, a driver name, or a device name from /dev.  It is
> possible to sanitize the first, and the second and third should come
> from trusted sources within the kernel itself.  The last area where
> I found a potential problem is BPF.  I don't know if this can happen.
> 
> I think this should be fixed by either sanitizing data on write
> (by limiting the allowed characters in dma_buf_set_name()), on read
> (by using one of the formats that escapes special characters), or both.
> 
> Is there a better way to identify that a file descriptor is of
> a particular type, such as an eventfd?  fdinfo is subject to

The problem is that most of the anonymous inodes share a single
anonymous inode so any uapi that returns information based inode->i_op
is not going to be usable.

> bugs of this type, which might happen again.  readlink() reports
> "anon_inode:[eventfd]" and S_IFMT reports a mode of 0, but but my

That is definitely uapi by now. We've tried to change S_IFMT and it
breaks lsfd and other tools so we can't reasonably change it. In fact,
pidfds pretend to be anon_inode even though they're not simply because
some tools parse that out.

> reading of the kernel source code is that neither is intended to be
> stable uAPI.  Is there a better interface that can be used?

