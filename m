Return-Path: <linux-fsdevel+bounces-45613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 492E8A79E56
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 10:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1B173B4CE2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 08:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553A7221DB7;
	Thu,  3 Apr 2025 08:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSpKiThd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B133F2A8D0;
	Thu,  3 Apr 2025 08:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743669569; cv=none; b=IV7Cvd7YAeb2GKfBAHyHQsCPz7lDHmERIhstF9XRQclyVN5mgu9qRoocyHtzNF2QNOd7VLOOmmpnW108ChASY2/JBrhrNveU4/YfUTGkxyMVN0QcOZrXvIpBXcVqL028tSTeM9Jkyd8XscXw8j68tzapjtiyupL1LAaBu8RWyQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743669569; c=relaxed/simple;
	bh=woXakiFirOA6BUAcBYbroO5CI9yF2xY3q87qsceTnLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRC1W4F+E46EPYgQwE1ckHy4AZyw+Ug4Uo32MFrn/sgDUrRnEjyHBKcAOdr4em2z5h79YpBksbJmX3YPvFN4x+Fs+QOFS2rTl2J/vviRxIPibSCxmX/0va7VWXgHYxiv/ZTaXcEqyrymxzNZuBjfsy+zb2sdBY6xK6if+C09N3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSpKiThd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF151C4CEE3;
	Thu,  3 Apr 2025 08:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743669568;
	bh=woXakiFirOA6BUAcBYbroO5CI9yF2xY3q87qsceTnLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hSpKiThdab1OgE5o6/P2bLKIj102XMuacbiUBQgjQcCJBfON8bC2RBYcfzAOexVpX
	 /iUfywTQDO+keO2COJJI1nPqWLF8cdgnCZe524mQCx8NvTbuB5apsooPhi31qN4v02
	 MJfvUn4RQT2W9Cz4vUjd+ylkmLkuGuwvHxvL+D8tOGdcnxspC45bbBGbPBQ8IfXQM9
	 nubvC0L4rJTna9ObXTfM3gX9ftSM21m5hLEEyoeyK7LscPFeujkxTScE560BWbTY1D
	 koKnWOZ9LHsjwiEw/sV2KqeIKDeV9aSe2e5aMZMT8xgLSgOAJTPicWH/BQ2n+co2T4
	 JZnMEmoiwjC/Q==
Date: Thu, 3 Apr 2025 10:39:25 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: remove stale log entries from fs/namei.c
Message-ID: <20250403-tunnel-lethargisch-810d83030763@brauner>
References: <20250401050847.1071675-1-mjguzik@gmail.com>
 <20250401-erwehren-zornig-bc18d8f139e6@brauner>
 <CAGudoHF_Nfjq1nLZhMbFr3GJz-z=9Z4goacCgXbifxrQX7yiwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHF_Nfjq1nLZhMbFr3GJz-z=9Z4goacCgXbifxrQX7yiwA@mail.gmail.com>

On Tue, Apr 01, 2025 at 02:28:08PM +0200, Mateusz Guzik wrote:
> On Tue, Apr 1, 2025 at 12:49 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Tue, 01 Apr 2025 07:08:46 +0200, Mateusz Guzik wrote:
> > >
> >
> > I have zero attachment to these comments so I'm inclined to agree and
> > remove them. Please anyone who really really thinks we need them speak
> > up!
> 
> ouch man
> 
> this submission was a joke, which is why I only sent it to the list
> and skipped the maintainers as direct recipients
> 
> it *adds* the following:
> >  /*[Apr 1 2024 Mateusz Guzik] Removed stale log entries.
> 
> I can't tell if this actually landed because the url:
> > [1/1] fs: remove stale log entries from fs/namei.c
> >       https://git.kernel.org/vfs/vfs/c/3dddecbd2b47
> 
> says "bad object id" at the moment.
> 
> I very much support removal of this kind of commentary, but this could
> be very flamewar inducing and I did not want to spend time on a
> non-tech discussion about it.
> 
> However, if actually doing this, there is more to whack and I'll be
> happy to do a real submission with more files.
> 
> Even in this file alone:
> > /* In order to reduce some races, while at the same time doing additional
> > * checking and hopefully speeding things up, we copy filenames to the
> > * kernel data space before using them..
> 
> I think this comment also needs to get whacked. Copying the path is
> not optional.

I'm thoroughly confused how this would be a meaningful April fools joke?

The comments in that file are literally 20+ years old and no one has
ever bothered to add new updates there even though Al, Neil, Jeff,
myself and a lot of others probably rewrote that file a gazillion number
of times together or significantly or at least subtly changed the rules.

So should we have added comments to the top of the file each time?
And since we didn't does it really serve as an interesting historical log?

The proper place for that has been
Documentation/filesystems/{locking.rst,porting.rst,path_lookup.rst}
for a long time now.

The comments are historical artifacts. At best they serve as a
humble-brag about who massaged what. I venture a guess and think that no
one needs that comment to figure out who has made a significant impact
here.

