Return-Path: <linux-fsdevel+bounces-76531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNLBKMR5hWmOCAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 06:19:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3505FA52E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 06:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18802301ECFE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 05:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3703358CD;
	Fri,  6 Feb 2026 05:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcBAFjlY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3432F3EBF05;
	Fri,  6 Feb 2026 05:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770355128; cv=none; b=Wv43bFI94nxbg64JOhgIRLjGtSAGkGX4KGtVsvv18e0OtY2iDMsedD+UjgHHluDwPO3jj8plPU9eVjSqiu9EewOpKnrGIXLDBxhMfp65GvaMMrHbuM1tCXCyUNuyf/oBe8AaQtzziw/J5jG3CoefaaHzEDdlq7ZGGfiHaT66+hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770355128; c=relaxed/simple;
	bh=FZNH784GGb4GOFa2gP0d0sk/tFStKKWrmX+xaMQBKB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwxwQ1zChE70TJ/aZTCo+y5Yj+/o4nMm0wIkwpCSV6+Ky0Py58uOdWMuYNSmyZl/fN8bJAWnhTJuqpKj7NCSFkdbinPbUiTBsou6XWuIZ/6JOD8m6eFNTkY+tY3WSEY/jtTxS/1PiW02pibPwfpngH4lVIFfcFVlMCgN3H6hkAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcBAFjlY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E11C116C6;
	Fri,  6 Feb 2026 05:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770355127;
	bh=FZNH784GGb4GOFa2gP0d0sk/tFStKKWrmX+xaMQBKB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GcBAFjlYL08UwsdOs7JUF3eDItw4S+eoWqjU+Za3wkvy+8mwJRBgCfOo7Cv/9Xi6s
	 i6/ITKBawlLKl1FqbGbOcLPtitxaPGWd+GV+GzM9ZhVzXg9SueLPglDl2WUtXih/6Y
	 l2++mlybLV2v33cXZwNTgvrDyAHWoNBj7wkKhv9cJwjVkOrXlFZ9BHqtc5BlMrMhbe
	 MlasUmj65R9v+44l6VfS1+CK4zjuGx5BYtSK7b5KeVs4ASAnXraKmYpU2V70Fy2Mlq
	 N1CQpIacyYObpLIiGye27U/USzGz4c/JuqUox3/70vV41m3UDdOspj9Ml5/wttz0WP
	 pWZJsgzpgbaXA==
Date: Thu, 5 Feb 2026 21:18:47 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Finn Thain <fthain@linux-m68k.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Documenting the correct pushback on AI
 inspired (and other) fixes in older drivers
Message-ID: <20260206051847.GC7693@frogsfrogsfrogs>
References: <32e620691c0ecf76f469a21bffaba396f207ccb9.camel@HansenPartnership.com>
 <5938441c-aaa9-c405-a78a-a66f387a5370@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5938441c-aaa9-c405-a78a-a66f387a5370@linux-m68k.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-76531-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F3505FA52E
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 09:57:45AM +1100, Finn Thain wrote:
> 
> On Thu, 5 Feb 2026, James Bottomley wrote:
> 
> > To set the stage, we in SCSI have seen an uptick in patches to older
> > drivers mostly fixing missing free (data leak) and data race problems.
> > I'm not even sure they're all AI found, but we don't really need to
> > know that. 
> 
> If I may predict the next scene, by extrapolating only a little, we are 
> approaching the point where it will be feasible to request that an AI 
> simply generate a new driver, based on chip datasheets plus all of the 
> open source drivers available for training, rather than patch the bugs in 
> an existing driver.
> 
> At that point, what use is a maintainer? I think we can still add value if 

Being a magic sources of datasheets obtained through murky means,
obviously.  What /was/ grandpa doing when he came home with a bunch of
weird machinery at 3am in 1957??  :P

--D

> we are able to leverage our ability and experience in validating such code 
> i.e. prove its correctness somehow. If we can do that, then the codebase 
> we presently call Linux might continue to grow because it would remain 
> superior than some AI-generated alternative codebase.
> 
> Documentation that would raise the bar for patch submissions seems like a 
> band-aid. The basic complaint seems to be that minor fixes have become 
> cheaper and easier to produce, overwhelming reviewers. The solution has to 
> be, make code review cheaper and more effective i.e. fight fire with fire.
> 

