Return-Path: <linux-fsdevel+bounces-77206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDURJnpqkGmAZQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 13:28:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BE813BDA1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 13:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A444B3021EB5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 12:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF86230BBA6;
	Sat, 14 Feb 2026 12:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uN3PVmDx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E68A2C027E;
	Sat, 14 Feb 2026 12:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771072114; cv=none; b=KIw1fWgwB3yrzYwYsiL7pLXz9mRh9VNTVyvn7YZsXkwCr3ZFN9i4Z0kwCgRsiKLFjBCBCK5b8ln56ZnnKNfXPYzgsToJswgze4hGHG9EbsmhXokkY1bc8HMbRX4QBRPxD09sWa1p1qcazo63BElPNctUIk7Lx5IWqWCLF95xQA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771072114; c=relaxed/simple;
	bh=XTiYcF0x3oonD5iUHJo2/93vF+NyCsgG+227+hCuWus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pa0oB1x3BL25WVz4SHZNuanXkWircXmfHaCGslnV7Fg5Jr1JyrkP3iNMggQ0QqEr6K4x4gVEM6BAfrPbwZurSGH/NfzEoqn/ivfTSNV4/OeUxNRGfrQ1ifiu+CzqBQmyiUCbw7qxOy7IinaK1zGX4LfSfwa9n3hi/gXmT4yHt+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uN3PVmDx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4F9C16AAE;
	Sat, 14 Feb 2026 12:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771072114;
	bh=XTiYcF0x3oonD5iUHJo2/93vF+NyCsgG+227+hCuWus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uN3PVmDxmN0JoWqYNJTGPE1Wj1hr1fkF/iqBD923pCeKQORbQxXYNJyiyR6h4BrPA
	 zPciQnPXj8R5K2i1q/nI5TooDu6wEvKrqexT3b0Nr3gKg4GGJ+sUmjiSY4Ydbzr7Cu
	 ud/0VgkDd9UCgLHbY2D3GS/gY4+06Kg1xfSGiCgHAgeF9NrIkMEp+jF8AIGK5qVVks
	 gojPp8hJu5hE/FYWX9l1+gezs27xa/NSj2hJ+D4oQ/Z+62nbJs/fhlGi5PJl2mT0lV
	 Jmo3PbZKZmf7BG5Q2oT0XbgEHbufLWeKXOU6K8zhhwxG4cxatMJIZidI8IUZbn3Yij
	 qQ/aJpKAP3zkQ==
Date: Sat, 14 Feb 2026 13:28:30 +0100
From: Christian Brauner <brauner@kernel.org>
To: "Zachary M. Raines" <zachary.raines@canonical.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Duplicated entries in /proc/<pid>/mountinfo
Message-ID: <20260214-filmt-seepferdchen-c917d60205dc@brauner>
References: <DG0B0GEW323Q.29Y4J0A0Q5DQ5@canonical.com>
 <20260129-geleckt-treuhand-4bb940acacd9@brauner>
 <DG1B2T5I7REV.30XR7YCI0RSZ4@canonical.com>
 <DGCD3NMVHDJQ.2J8WVPEBM4ZRS@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DGCD3NMVHDJQ.2J8WVPEBM4ZRS@canonical.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77206-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E8BE813BDA1
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 12:59:25PM -0600, Zachary M. Raines wrote:
> On Thu Jan 29, 2026 at 1:04 PM CST, Zachary M. Raines wrote:
> > On Thu Jan 29, 2026 at 8:28 AM CST, Christian Brauner wrote:
> >> On Wed, Jan 28, 2026 at 08:49:12AM -0600, Zachary M. Raines wrote:
> >> I suspect the issue is real though. I'm appending a patch as a proposed
> >> fix. Can you test that and report back, please? I'm traveling tomorrow
> >> so might take a little.
> 
> Just following up on the patch you sent and thanks again.
> 
> > Thank you for the quick turnaround on that patch. I applied it on top
> > of 6.19-rc7 and after about 3 hrs I haven't seen any duplicates, in
> > contrast to without the patch where they appear in under 10 minutes.
> >
> > Let me know if there's any other testing that would help.
> 
> According to my testing, your patch resolves the issue. Do you plan to
> submit it upstream? Please let me know if there's anything
> I can do to help on that front.

It'll go upstream early next week. :) I deferred some pull requests.

