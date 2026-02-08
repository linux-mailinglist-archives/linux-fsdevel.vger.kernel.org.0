Return-Path: <linux-fsdevel+bounces-76678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAPCLyIfiWkB2wQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 00:41:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E9310A9D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 00:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C1A13007892
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Feb 2026 23:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE45F3859D6;
	Sun,  8 Feb 2026 23:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="icmvq83M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C022341067;
	Sun,  8 Feb 2026 23:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770594074; cv=none; b=YxM4JdUPE55q5RlF0wpq9X+7FNzLY3RBGmD2rI9qgi0PI12vbFI+7ZVbUnGa2Vr2BAfwQHZFSVieSf7IJh6BbHcM+PwpZzymWHa95W43s6M7KPfTDNiSNwrK3kVLm4CgcZcrFsPxEa4n6HTGU5jwxFU+0jhykCquGWyLY1xh83Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770594074; c=relaxed/simple;
	bh=4AQ0Q0dHJv2ItzNvwAqFQ5Up5qrhjz1iE26+v6BfGXM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TCVx2l947jm5dnFBxPtPj+x2u6/z2Dl0dMISYfFqb9gZeBvaq1FeNON5UrKZKG1IRcbmaz71/97AErUKIvWy5vb+AqxUstmmfX44fRhuam3qgdcuHoRbE291yJ5OEcBoeKLcGhhov5HCC+nBWszmsUN3L6hEGHV/Vg4bhZznF94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=icmvq83M; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E678B1400015;
	Sun,  8 Feb 2026 18:41:11 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sun, 08 Feb 2026 18:41:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770594071; x=1770680471; bh=zYQUfpL6tybfrvEFycwdgLlcLVoeJAISA4l
	W02r6RNA=; b=icmvq83M6n7L9cVVIy5p1+sfilttGiKJur1UQKifLFAzII4C3dG
	j6ume94HOzz77Ey67z9nyuCNngCu126Cti2D62GqLrNXiPAWSwm8aRlPAKcrEI0Z
	kFoa6k0ncx4Wfgab8ZZ/UfvDTCqgFInTsZI7T1PGwhJSpYUn5Ei17Lmjl07WrR7I
	pgFHLOD2gc+RjePfgCMFCMc5cQMqU/aBcNnsgk71GhlHO/94vSLjSggqDZwVUvkc
	ENQTYA8isAuceQC/dQxf2KGDow0qjM+3yg05cRlyu4/X6XMqV4XR03sRRsZr6J3y
	Mzcs5/o8hI1RO26p6Bh7EPmySyEJigfqjRw==
X-ME-Sender: <xms:Fx-JaVJPh9olTJ4sJdhNc9ZQyXA4gFRm3xOt2V76oAwunpZ4PaW-yg>
    <xme:Fx-Jacm_Dif1oltrx_0uuui0-Cd_tWJVw9nXKJIY3IBA8wQrlxVEoSPnkAT0XpAUB
    jE_UO13pwHWgaGcgEeP90s4chbUahrsl02Tp18aqwTOwC69XYcnTg>
X-ME-Received: <xmr:Fx-JaRNSzYQEKv1uoriCeuQDGkJNbdIffEXY3SXH928YrL6yDOC_3E2GvLKDazj3fwb3GCGh5mcOgDI84uX4ELmgoIphIfvsl4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleehvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcuvfhh
    rghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtth
    gvrhhnpeelueehleehkefgueevtdevteejkefhffekfeffffdtgfejveekgeefvdeuheeu
    leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfth
    hhrghinheslhhinhhugidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehjrghmvghsrdgsohhtthhomhhlvgihsehhrg
    hnshgvnhhprghrthhnvghrshhhihhprdgtohhmpdhrtghpthhtoheplhhinhhugidqshgt
    shhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqsghloh
    gtkhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshgu
    vghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Fx-Jaa3q2UGKCgdicYMK0ZjEq-ax5T_e4eOX4-K-Z9vvbDkzQWCW9g>
    <xmx:Fx-JaYnsLtOekNb-PDHiu_WeDQx8mIuVYEykM1B5mbD03VsgQvs9KQ>
    <xmx:Fx-JaZX2anWk_wKfS6o8H0oHEL5GdbgUrDnRa97l8KJg7c_ChlEENQ>
    <xmx:Fx-JaWuYhtQ6dB9P5pvb7dQ3viedh6GpkoJua4Jvuhs1OJh6Qp1BRQ>
    <xmx:Fx-JaaV40iHrMeAC9huUWV-P8N89eZLuy39anTdacyzax3O4_8IrCTRh>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Feb 2026 18:41:08 -0500 (EST)
Date: Mon, 9 Feb 2026 10:41:41 +1100 (AEDT)
From: Finn Thain <fthain@linux-m68k.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, 
    "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
    linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Documenting the correct pushback on AI inspired
 (and other) fixes in older drivers
In-Reply-To: <e0a696dea2b68b99f604ce8bfb897fc3d38acc90.camel@HansenPartnership.com>
Message-ID: <f269f82c-9998-f7f7-5786-a153d5adfff8@linux-m68k.org>
References: <32e620691c0ecf76f469a21bffaba396f207ccb9.camel@HansenPartnership.com>  <5938441c-aaa9-c405-a78a-a66f387a5370@linux-m68k.org> <e0a696dea2b68b99f604ce8bfb897fc3d38acc90.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76678-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[messagingengine.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fthain@linux-m68k.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-m68k.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 81E9310A9D6
X-Rspamd-Action: no action


On Sun, 8 Feb 2026, James Bottomley wrote:

> On Fri, 2026-02-06 at 09:57 +1100, Finn Thain wrote:
> > 
> > On Thu, 5 Feb 2026, James Bottomley wrote:
> > 
> > > To set the stage, we in SCSI have seen an uptick in patches to older 
> > > drivers mostly fixing missing free (data leak) and data race 
> > > problems. I'm not even sure they're all AI found, but we don't 
> > > really need to know that.
> > 
> > If I may predict the next scene, by extrapolating only a little, we 
> > are approaching the point where it will be feasible to request that an 
> > AI simply generate a new driver, based on chip datasheets plus all of 
> > the open source drivers available for training, rather than patch the 
> > bugs in an existing driver.
> 
> Seems possible, but do we care?  For a driver we don't have, I think 
> we'd be reasonably happy to try out an AI generated one, assuming 
> there's a maintainer who has hardware to test.  For existing drivers, I 
> think AI rewrites (even in rust) would be rejected.
> 

My hope is that, one day, rewrites would get accepted or rejected on the 
basis of correctness, fitness for purpose, conformance to specification, 
auditability and those user expectations which the Linux project upholds. 
The maintainer's power of veto comes with a duty to attend to those 
things.

Any code which makes the grade could then get called "Linux" regardless of 
whether it was hand-coded last century or generated by machine on demand 
in whatever language best suits the algorithm at hand and the reader's 
personal taste.

> > At that point, what use is a maintainer? I think we can still add 
> > value if we are able to leverage our ability and experience in 
> > validating such code i.e. prove its correctness somehow. If we can do 
> > that, then the codebase we presently call Linux might continue to grow 
> > because it would remain superior than some AI-generated alternative 
> > codebase.
> 
> Well, I don't think regarding Maintainers as being in competition with 
> AI will be very productive.  AI is a tool for maintainers to use, if 
> they wish, to augment their other skills.
> 

OK, but then we must quit competing, and let the tools do those things 
that they do best.

Perhaps I'm being too optimistic -- even though we've had clang-format for 
years, every week I see reviewers checking code style. If reviewers can't 
collaborate and automate that problem away, what hope is there for 
automatic proof checking?

> > Documentation that would raise the bar for patch submissions seems 
> > like a band-aid. The basic complaint seems to be that minor fixes have 
> > become cheaper and easier to produce, overwhelming reviewers. The 
> > solution has to be, make code review cheaper and more effective i.e. 
> > fight fire with fire.
> 
> Chris Mason is already doing that, I think.  However, I didn't anchor my 
> proposal around lack of review, I anchored it to a better documented 
> risk/benefit calculation ... and that doesn't change enormously however 
> many reviews the patch gets.
> 

Yes, on the cost side of the ledger, code review has to be made cheaper 
somehow.

On the benefit side, I think the payoff from fixing theoretical 
correctness bugs is an unknown quantity. For example, it seems likely that 
by defending against hostile hardware, you'd end up with a device driver 
that's much more amenable to a correctness proof than a driver whose 
entire behaviour is a function of hardware timing quirks.

The cost of ignoring minor theoretical correctness fixes is also an 
unknown quantity. But I think it must increase as the tooling becomes more 
capable and more widely deployed. If the tooling is constantly complaining 
about those defects, this would add friction for all tree-wide analysis or 
refactoring.

