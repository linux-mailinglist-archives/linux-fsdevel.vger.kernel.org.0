Return-Path: <linux-fsdevel+bounces-77849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id lPzEIKJZmWnSSwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 08:07:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C137216C515
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 08:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B9C0300F52A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 07:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7A834253C;
	Sat, 21 Feb 2026 07:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3QO1fWm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199F4342529
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Feb 2026 07:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771657627; cv=none; b=WzR/wITWmtgAi72NmwEy3opAwCu2xo2WPjPfeBRrjsXabIlj9++jPEP67aGiKdTItVjRTZZQT3u1/+QfaoM/1gKF5TRWq+MPnz1qZHL+8bghpPzltyPK9eYR5eU+nfZ+X13GthUsvNvh9cG0P7L5q3kWFbr3jOfHVYwxqqVpxfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771657627; c=relaxed/simple;
	bh=lMcD6bLCd5KeMlL8cuic9Qf1RrV6sB375uD3CsS2Nd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uysVrxmWBBuShq9SkEXVGZQkZptA+dwcO7PHsuSQ+1Uar/Vj+6qWJ9nZl93+/A/4OiKwlhSgTBWC2ERppjDiZ7YAYS71vvV/j7qVWNRFO9x7z2hRmaJ7FBOPZkRDWJ+V/OSaDV8gIG8skrXszTMfEcyypYwKZa25zXXhczxHJEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3QO1fWm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995D5C4CEF7;
	Sat, 21 Feb 2026 07:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771657626;
	bh=lMcD6bLCd5KeMlL8cuic9Qf1RrV6sB375uD3CsS2Nd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S3QO1fWmk6kKy3LVsTn44ImAS+DGMaS8FpDa68HifEpvPxR6OySG2AOxZ0h0V+nwJ
	 aCp+nNfferiZSAgR4t4wvLsiPeNkP1jxqDgMqr+ZWRJmyRzIpEb5XiT5zsqkptmEMw
	 SYBEeBbnxPhU+E+qrmiuHzF+vWA7sZ1k61edogEY52RmNCZlToZgKzd+uAp4/aRmOj
	 2nMDeasEhPx4y9+6O9nIPjEqLbgL5/V7mmhT0UTzVM2Q+Bp8y1yYwFq6dJHxRM38Js
	 hE3egPWF0dXMcUyJCOqs1g1grxByez8fxxwdzPk4hYZsV0orBdF/IxwNl1wOw5Z+aM
	 3HpZsAOjNuvBA==
Date: Fri, 20 Feb 2026 23:07:05 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Joanne Koong <joannelkoong@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
	John Groves <John@groves.net>, Bernd Schubert <bernd@bsbernd.com>,
	Luis Henriques <luis@igalia.com>,
	Horst Birthelmer <horst@birthelmer.de>,
	lsf-pc <lsf-pc@lists.linux-foundation.org>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
Message-ID: <20260221070705.GA11120@frogsfrogsfrogs>
References: <CAJfpegtzYdy3fGGO5E1MU8n+u1j8WVc2eCoOQD_1qq0UV92wRw@mail.gmail.com>
 <CAOQ4uxjEdJHjbfCFM364V=tBrEyczYvzo-b-Xo0UPOCA2cnPGQ@mail.gmail.com>
 <CAJfpegvg=hqM1vMCyrb61VT6uA+4gdGwvqHe5Djg2RF+DTUMiw@mail.gmail.com>
 <CAJnrk1YKDi9e-eTQyGBD-rFScxGTcsfz3tnmnE_EshPd18aMrw@mail.gmail.com>
 <yndtg2jbj55fzd2kkhsmel4pp5ll5xfvfiaqh24tdct3jiqosd@jzbfzf3rrxrd>
 <20260206060922.GG7693@frogsfrogsfrogs>
 <cec1a25a-9919-491f-b105-26ad6682cc39@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cec1a25a-9919-491f-b105-26ad6682cc39@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,szeredi.hu,vger.kernel.org,groves.net,bsbernd.com,igalia.com,birthelmer.de,lists.linux-foundation.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77849-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[szeredi.hu:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: C137216C515
X-Rspamd-Action: no action

On Sat, Feb 21, 2026 at 01:07:55AM -0500, Demi Marie Obenour wrote:
> On 2/6/26 01:09, Darrick J. Wong wrote:
> > On Wed, Feb 04, 2026 at 11:43:05AM +0100, Jan Kara wrote:
> >> On Wed 04-02-26 01:22:02, Joanne Koong wrote:
> >>> On Mon, Feb 2, 2026 at 11:55 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >>>>> I think that at least one question of interest to the wider fs audience is
> >>>>>
> >>>>> Can any of the above improvements be used to help phase out some
> >>>>> of the old under maintained fs and reduce the burden on vfs maintainers?
> >>>
> >>> I think it might be helpful to know ahead of time where the main
> >>> hesitation lies. Is it performance? Maybe it'd be helpful if before
> >>> May there was a prototype converting a simpler filesystem (Darrick and
> >>> I were musing about fat maybe being a good one) and getting a sense of
> >>> what the delta is between the native kernel implementation and a
> >>> fuse-based version? In the past year fuse added a lot of new
> >>> capabilities that improved performance by quite a bit so I'm curious
> >>> to see where the delta now lies. Or maybe the hesitation is something
> >>> else entirely, in which case that's probably a conversation better
> >>> left for May.
> >>
> >> I'm not sure which filesystems Amir had exactly in mind but in my opinion
> >> FAT is used widely enough to not be a primary target of this effort. It
> > 
> > OTOH the ESP and USB sticks needn't be high performance.  <shrug>
> 
> Yup.  Also USB sticks are not trusted.
> 
> >> would be rather filesystems like (random selection) bfs, adfs, vboxfs,
> >> minix, efs, freevxfs, etc. The user base of these is very small, testing is
> >> minimal if possible at all, and thus the value of keeping these in the
> >> kernel vs the effort they add to infrastructure changes (like folio
> >> conversions, iomap conversion, ...) is not very favorable.
> > 
> > But yeah, these ones in the long tail are probably good targets.  Though
> > I think willy pointed out that the biggest barrier in his fs folio
> > conversions was that many of them aren't testable (e.g. lack mkfs or
> > fsck tools) which makes a legacy pivot that much harder.
> 
> Does it make sense to keep these filesystems around?  If all one cares
> about is getting the data off of the filesystem, libguestfs with an
> old kernel is sufficient.  If the VFS changes introduced bugs, an old
> kernel might even be more reliable.  If there is a way to make sure
> the FUSE port works, that would be great.  However, if there is no
> way to test them, then maybe they should just be dropped.
> 
> >> For these the biggest problem IMO is actually finding someone willing to
> >> invest into doing (and testing) the conversion. I don't think there are
> >> severe technical obstacles for most of them.
> > 
> > Yep, that's the biggest hurdle -- convincing managers to pay for a bunch
> > of really old filesystems that are no longer mainstream.
> 
> Could libguestfs with old guest kernels be a sufficient replacement?
> It's not going to be fast, but it's enough for data preservation.

In principle it might work, though I have questions about the quality of
whatever's internally driving guestmount.

Do you know how exactly libguestfs/guestmount accesses (say) an XFS
filesystem?  I'm curious because libxfs isn't a shared library, so
either it would have to manipulate xfs_db (ugh!), run the kernel in a VM
layer, or ... do they have their own implementation ala grub?

--D

> libguestfs supports "fixed appliances", which allow using whatever
> kernel one wants.  They even provide some as precompiled binaries.
> -- 
> Sincerely,
> Demi Marie Obenour (she/her/hers)






