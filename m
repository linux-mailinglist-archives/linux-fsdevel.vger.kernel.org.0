Return-Path: <linux-fsdevel+bounces-74697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GYSAODbb2n8RwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 20:47:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7684A4AB34
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 20:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6468D9895FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 16:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A782433B960;
	Tue, 20 Jan 2026 16:51:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from brightrain.aerifal.cx (brightrain.aerifal.cx [104.156.224.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E63F33B961
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.156.224.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768927912; cv=none; b=YK//Q9yt8jSKGYwGvlJ/pm6BhV7K3W7NBpAbzXDJRgUAUpYYg3hDsBqmBOpUSCPC2pmAmdQccb4kBdI9PNRDF/n3JPCaqxH+sRrlBc+JEin+5nbHjnaYmR3BKlgP0EFxw94Eg8Q1OmQgr9OWicZP0hwuX24BxwTVTF6DwLBiu60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768927912; c=relaxed/simple;
	bh=RRHhR59VpK2Pq3cDuEw1hfQ219ndyvVTqG3fHGZjqbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWEZVttwdyENbak1hIUWNWlvuBsz2CYFDgMxV3BHpbisydSQHczSdiK6yJ/UgfBCz0KOIDiRB2A2/ZaWMTTarxjOJqz6TS+q3/qdNY2j+n/wR0geLnkbRQOwvWAEI6rHg1sYlM2k+clO4LyTrqGyBAGVnofi58uT1M7sxoo5v04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org; spf=pass smtp.mailfrom=aerifal.cx; arc=none smtp.client-ip=104.156.224.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aerifal.cx
Date: Tue, 20 Jan 2026 11:36:34 -0500
From: Rich Felker <dalias@libc.org>
To: Zack Weinberg <zack@owlfolio.org>
Cc: Alejandro Colomar <alx@kernel.org>,
	Vincent Lefevre <vincent@vinc17.net>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
	GNU libc development <libc-alpha@sourceware.org>
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from
 POSIX.1-2024
Message-ID: <20260120163634.GD6263@brightrain.aerifal.cx>
References: <a5tirrssh3t66q4vpwpgmxgxaumhqukw5nyxd4x6bevh7mtuvy@wtwdsb4oloh4>
 <efaffc5a404cf104f225c26dbc96e0001cede8f9.1747399542.git.alx@kernel.org>
 <20250516130547.GV1509@brightrain.aerifal.cx>
 <20250516143957.GB5388@qaa.vinc17.org>
 <20250517133251.GY1509@brightrain.aerifal.cx>
 <5jm7pblkwkhh4frqjptrw4ll4nwncn22ep2v7sli6kz5wxg5ik@pbnj6wfv66af>
 <8c47e10a-be82-4d5b-a45e-2526f6e95123@app.fastmail.com>
 <aW1dE9j91WAte1gf@devuan>
 <60c77e5c-dbab-4cca-8d0d-9857875c73fb@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60c77e5c-dbab-4cca-8d0d-9857875c73fb@app.fastmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Spamd-Result: default: False [-1.26 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[libc.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dalias@libc.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-74697-lists,linux-fsdevel=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,brightrain.aerifal.cx:mid]
X-Rspamd-Queue-Id: 7684A4AB34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 11:15:15AM -0500, Zack Weinberg wrote:
> Rich and I have an irreconciliable disagreement on what the semantics of close
> _should_ be.  I'm not going to do any more work on this until/unless he
> changes his mind.

It's been way too long since I read this thread to recall what our
point of disagreement is or what point glibc might be at in
reconciling the Linux kernel disagreement with POSIX.

I believe my position is basically this:

1. Documentation should reflect that the EINTR behavior on raw Linux
   syscall and traditional glibc is non-conforming to POSIX, but make
   applications aware of it and that it's unsafe to retry close on
   these systems.

2. Documentation should be descriptive not polemic or proscriptive of
   coding style or practices. When there is a disagreement like this
   it should document that and faithfully represent the different
   positions, not represent the author's views on which one is
   correct.

3. It may be helpful to have further information on what types of
   errors can actually be expected from close on Linux, and under what
   conditions, but only if these behaviors can actually be guaranteed.
   If it's just documenting what Linux currently happens to do, but
   without any existing promise to preserve that for new file types
   etc., then this is stepping out of line of the role of
   documentation into defining the specification, and that requires
   input from other folks.

4. If musl behavior is being documented, it should be noted that we do
   not have the non-conforming EINTR issue. If the kernel produces
   EINTR, we return 0. From 0.9.7 to 1.1.6 we produced EINPROGRESS,
   but this was changed in 1.1.7 as it was found that applications
   would treat EINPROGRESS as an error condition.

Rich

