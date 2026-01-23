Return-Path: <linux-fsdevel+bounces-75257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFrIGoRLc2liugAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 11:20:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFCF743E5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 11:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C41A2301E184
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 10:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617E737AA99;
	Fri, 23 Jan 2026 10:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pirA/R+/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EEB34E76E;
	Fri, 23 Jan 2026 10:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769163383; cv=none; b=KN7rudzPIIh7u+UT7mlVuY+U5bo9AyS5TYwFfALSnWflzwkHqBmbVaEY6tjUeY08UoONxe997IzXydVBZRTmfrLYZ0+SKRpfUPgTpE5oLIb/AvV7uvV0tYDQO7QCkUOvwQbRLKlWo7IYkaZ4aa7mqySL4toHjNCPpSHWhxA61r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769163383; c=relaxed/simple;
	bh=dV7OD68w4lvCtztzozVMpLB/2SClOxfAXtVQLTQ5gXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lU5q1nwnDJa+UKWN8sxujj9bi1keuJPRHgSjlMeEZwur1087YA2dSX6IYORQ4X/NuLi5JxmM3RtqRUHFi7g48bZXgNubEcp0W/4xSRUvOiRfRHFC9Ws5zEfmmHBjjOgSEOhf4wgVR+qCtXsLbDcefMwIMeSzLgKrXYX1tBEtvw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pirA/R+/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B969C116D0;
	Fri, 23 Jan 2026 10:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769163382;
	bh=dV7OD68w4lvCtztzozVMpLB/2SClOxfAXtVQLTQ5gXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pirA/R+/2zZgeVASEHCvXJwdGfbcUhC/QEgvd4O6omiCCGSmej7CWGKARHZz93p0o
	 Hu+pwhUc+Q7HNGRU9x/u4IeyvNf7yyVpI/p1pvrANlSj0EkVexzyJoV5tNraPP+yYW
	 KDOesYJYyjdieoPLbcUbeS35UyO8A6mOYhMn/3qO7IP/NNL204fSii3deyrSaSieEa
	 Fk4XdbvOwBo/R4SFPulWYmVwaxbCZDE5DYeoTstZCsJplKcwrnRVJmnfrbThOkHu3l
	 Vlq2addVfCkNUBzg5NoLy85a04sbN5Mx4IOpJLQ27wyxWaMBJF5rNQzAqqkQuQQwLj
	 XgkVIHS/LzbgA==
Date: Fri, 23 Jan 2026 11:16:17 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-nvme@lists.infradead.org, bpf@vger.kernel.org, lsf-pc@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
Subject: Re: LSF/MM/BPF: 2026: Call for Proposals
Message-ID: <20260123-tapir-perspektive-e6466483739a@brauner>
References: <20260110-lsfmm-2026-cfp-ae970765d60e@brauner>
 <20260122032209.GE3183987@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260122032209.GE3183987@ZenIV>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-75257-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4CFCF743E5
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 03:22:09AM +0000, Al Viro wrote:
> On Sat, Jan 10, 2026 at 02:24:17PM +0100, Christian Brauner wrote:
> > The annual Linux Storage, Filesystem, Memory Management, and BPF
> > (LSF/MM/BPF) Summit for 2026 will be held May 4–6, 2026 in Zagreb,
> > Croatia.
> > 
> > LSF/MM/BPF is an invitation-only technical workshop to map out
> > improvements to the Linux storage, filesystem, BPF, and memory
> > management subsystems that will make their way into the mainline
> > kernel within the coming years.
> > 
> > LSF/MM/BPF 2026 will be a three-day, stand-alone conference with four
> > subsystem-specific tracks, cross-track discussions, as well as BoF and
> > hacking sessions.
> 
> Will there be an option for remote participation this year?

I did already have you in mind as a remote attendee and we will have a
solution for such cases. But we do not provide a general first-class
"virtual experience" as some tracks do not even want any remote
attendeeds.

TL;DR you're good.

