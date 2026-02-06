Return-Path: <linux-fsdevel+bounces-76540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPQVJpmFhWmqCwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 07:09:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02952FA920
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 07:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF9B6301AF4C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 06:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9AB2EC090;
	Fri,  6 Feb 2026 06:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuTtsxg1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E471B3EBF05
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 06:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770358164; cv=none; b=QYPdKdSWcD1Yg8Ti0c4wGxaFy7nVRG6q8iI3xT7Pyzc5JAGzd0IhEP0662z5mmijJ+d8BKsFcLJzoRT8ECqSxCUbgJo6IPrHyP1S3ozQn4MoncYzpfh72Lu2dVAPCMm1mMCFD1/DkToMBk5IEECfCReW1vFzPMHTAGMYCRUjETU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770358164; c=relaxed/simple;
	bh=AxeOdYyxAOVfeRDsxMgguG3fXSHWRueIOlepD2l91lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPYEhdicC1L1CQ5AbQXfDuUxVlpEiv1Y5XuXN/WytqYWZiZnZAZJadffD4L2wA33KYwpEV2CmFypNrJKQj5azcXzK22o0sRxXzGk22JgVY1d4zBUE0hNgemAJtQCgexrx8sPZFSncSdfHB6sw5f+xlCJRXmA+PXfM9ZWzn01vxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nuTtsxg1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736E1C116C6;
	Fri,  6 Feb 2026 06:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770358163;
	bh=AxeOdYyxAOVfeRDsxMgguG3fXSHWRueIOlepD2l91lg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nuTtsxg1XFlEILNoi33DL4E1/o1vrLmrXsJxn5Szu2hpyQUfJqWXQss4soivCBCfG
	 LFpEMqPGtVAbru0qK2dtkoCoANIy/EKQLky7MYfbuUe63fQSBfmcfVIsQCOAEngAEu
	 BaVHJJRmCh+rTxS06WUIa4vqP39CAvC68mnjlrcAcdSoJisX1kCLEq/mXVU+OqrY5X
	 R//tAqZ2kl5HrbJ25ySiEltTDT62a7kYu8wGDsMXXJ8vkwQ+yYQ6jVzT3BJdvixX0P
	 YMdeH1hUedNfoSePUD1HFUNhFzmndUfigY55cCJ2pSZid1kodIHq23AfKE609R3d4S
	 RpLbV6mPMwbzQ==
Date: Thu, 5 Feb 2026 22:09:22 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
	John Groves <John@groves.net>, Bernd Schubert <bernd@bsbernd.com>,
	Luis Henriques <luis@igalia.com>,
	Horst Birthelmer <horst@birthelmer.de>,
	lsf-pc <lsf-pc@lists.linux-foundation.org>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
Message-ID: <20260206060922.GG7693@frogsfrogsfrogs>
References: <CAJfpegtzYdy3fGGO5E1MU8n+u1j8WVc2eCoOQD_1qq0UV92wRw@mail.gmail.com>
 <CAOQ4uxjEdJHjbfCFM364V=tBrEyczYvzo-b-Xo0UPOCA2cnPGQ@mail.gmail.com>
 <CAJfpegvg=hqM1vMCyrb61VT6uA+4gdGwvqHe5Djg2RF+DTUMiw@mail.gmail.com>
 <CAJnrk1YKDi9e-eTQyGBD-rFScxGTcsfz3tnmnE_EshPd18aMrw@mail.gmail.com>
 <yndtg2jbj55fzd2kkhsmel4pp5ll5xfvfiaqh24tdct3jiqosd@jzbfzf3rrxrd>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yndtg2jbj55fzd2kkhsmel4pp5ll5xfvfiaqh24tdct3jiqosd@jzbfzf3rrxrd>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76540-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,szeredi.hu,vger.kernel.org,groves.net,bsbernd.com,igalia.com,birthelmer.de,lists.linux-foundation.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,szeredi.hu:email];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 02952FA920
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 11:43:05AM +0100, Jan Kara wrote:
> On Wed 04-02-26 01:22:02, Joanne Koong wrote:
> > On Mon, Feb 2, 2026 at 11:55 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > > > I think that at least one question of interest to the wider fs audience is
> > > >
> > > > Can any of the above improvements be used to help phase out some
> > > > of the old under maintained fs and reduce the burden on vfs maintainers?
> > 
> > I think it might be helpful to know ahead of time where the main
> > hesitation lies. Is it performance? Maybe it'd be helpful if before
> > May there was a prototype converting a simpler filesystem (Darrick and
> > I were musing about fat maybe being a good one) and getting a sense of
> > what the delta is between the native kernel implementation and a
> > fuse-based version? In the past year fuse added a lot of new
> > capabilities that improved performance by quite a bit so I'm curious
> > to see where the delta now lies. Or maybe the hesitation is something
> > else entirely, in which case that's probably a conversation better
> > left for May.
> 
> I'm not sure which filesystems Amir had exactly in mind but in my opinion
> FAT is used widely enough to not be a primary target of this effort. It

OTOH the ESP and USB sticks needn't be high performance.  <shrug>

> would be rather filesystems like (random selection) bfs, adfs, vboxfs,
> minix, efs, freevxfs, etc. The user base of these is very small, testing is
> minimal if possible at all, and thus the value of keeping these in the
> kernel vs the effort they add to infrastructure changes (like folio
> conversions, iomap conversion, ...) is not very favorable.

But yeah, these ones in the long tail are probably good targets.  Though
I think willy pointed out that the biggest barrier in his fs folio
conversions was that many of them aren't testable (e.g. lack mkfs or
fsck tools) which makes a legacy pivot that much harder.

> For these the biggest problem IMO is actually finding someone willing to
> invest into doing (and testing) the conversion. I don't think there are
> severe technical obstacles for most of them.

Yep, that's the biggest hurdle -- convincing managers to pay for a bunch
of really old filesystems that are no longer mainstream.

--D

> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 

