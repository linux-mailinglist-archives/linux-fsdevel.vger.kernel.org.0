Return-Path: <linux-fsdevel+bounces-79770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMiYISm+rmlEIgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 13:33:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FE0238E75
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 13:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 87ED130022E8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 12:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1973A960F;
	Mon,  9 Mar 2026 12:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNWnXfn7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24D11E8342
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 12:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773059621; cv=none; b=kocbfsrcHTK9RS9pcS9YFYKwAaRcZBj1GlN8DXOUT89PMIGxOLeyUBTs1Pk7mcaFGjsohKU22JyTWOaJ1+2A05TuOjmOzBRfCz2d8vQAJyNToSyCmW+h13IsYXen5FsrMrri4ddmbNbhoLl6oPqxtgYH+mS06M0pLF9p/fzo7cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773059621; c=relaxed/simple;
	bh=H/FsxX051qVJZALk65Egp9w4P4pjokIsTnuO/WDwcuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/NKAxnp9N0NCW3sPSmxKvwu9FvxK5YmvmO74BGUQLH2athqrFa69Mj6LQhHPg8Gru42bJyR+LLOMbeVhIEFTBz5Y4A2VNmMXYMjnQFoKpBJG+oLOrHW5ed0+CyYfZ1/JmW8RwiX9MKbLus+X1oCHzg1NPHE24vjcCjA8IJeXtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNWnXfn7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA22C4CEF7;
	Mon,  9 Mar 2026 12:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773059621;
	bh=H/FsxX051qVJZALk65Egp9w4P4pjokIsTnuO/WDwcuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jNWnXfn7N3Gp7SIOqr+zgvANts7UGYgtyoVhMR3rfHOtmIz+5J2e18xXFo2km5wJ5
	 fyzisOa4jyR+pXdOgtmhPfRhFrqi41ZQke+balnYgwlfCxQBu1dJ9NkxCHggIK7HTF
	 Ccix9BK1vo2lKULfT51asntSUWVLhBOqaxsVFFYweG4oqkiJ9PF4VTTuFZNtg5iGF2
	 4H67qZo6HWzj0mw6pSZDbZA3vEbtBw40B4BLB6Ep9dv1ytUBR5HpdEiDiaNYkrjcUp
	 OvXlLnkpgZgT79tS/g3TU/MVw48dd11WBDVOMs75wn7mLOZ+9gPHM0IIMvjP2lqz1m
	 jdkEULCp+4HXA==
Date: Mon, 9 Mar 2026 13:33:37 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Lennart Poettering <lennart@poettering.net>, 
	Tejun Heo <tj@kernel.org>, "T . J . Mercier" <tjmercier@google.com>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH 0/5] fanotify namespace monitoring
Message-ID: <20260309-einrad-mitarbeit-18397e65afd3@brauner>
References: <20260307110550.373762-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260307110550.373762-1-amir73il@gmail.com>
X-Rspamd-Queue-Id: 26FE0238E75
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-79770-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.353];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sat, Mar 07, 2026 at 12:05:45PM +0100, Amir Goldstein wrote:
> Jan,
> 
> Similar to mount notifications and listmount(), this is the complementary
> part of listns().
> 
> The discussion about FAN_DELETE_SELF events for kernfs [1] for cgroup
> tree monitoring got me thinking that this sort of monitoring should not be
> tied to vfs inodes.
> 
> Monitoring the cgroups tree has some semantic nuances, but I am told by
> Christian, that similar requirement exists for monitoring namepsace tree,
> where the semantics w.r.t userns are more clear.
> 
> I prepared this RFC to see if it meets the requirements of userspace
> and think if that works, the solution could be extended to monitoring
> cgroup trees.
> 
> IMO monitoring namespace trees and monitoring filesystem objects do not
> need to be mixed in the same fanotify group, so I wanted to try using
> the high 32bits for event flags rather than wasting more event flags
> in low 32bit. I remember that I wanted to so that for mount monitoring
> events, but did not insist, so too bad.
> 
> However, the code for using the high 32bit in uapi is quite ugly and
> hackish ATM, so I kept it as a separate patch, that we can either throw
> away or improve later.
> 
> Christian/Lennart,
> 
> I had considered if doing "recursive watches" to get all events from
> descendant namepsaces is worth while and decided with myself that it was
> not.
> 
> Please let me know if this UAPI meets your requirements.

I think this looks great overall and is very useful as it allows to
monitor namespace events outside of bpf lsms. I agree with the
non-recursive design. You could generalize this approach by deriving the
watch from the namespace file descriptor? Then you can get notifications
for all types of namespaces.

If we ever want recursive watches, then we just need to add a separate
flag. This is only applicable to userns and pidns anyway.

I want to put another - crazier idea - in your head: Since pidfds are
file descriptors and now have the ability to persist information past
pidfd closure via struct pid->attr it is possible to allow fanotify
watches on pidfds.

I think that this opens up a crazy amount of possibilities that will be
tremendously useful - also would mean fsnotify outside of fs/ proper.
Just thinking on the spot: if you allow marking a pidfd it's super easy
to plumb exec notifications via fanotify on top of it. It's also easy to
monitor _all_ namespace events for a specific process via pidfds.

This obviously needs some thinking wrt security etc but I just want to
put the thought out there that the integration of pidfds and fanotify is
possible.

