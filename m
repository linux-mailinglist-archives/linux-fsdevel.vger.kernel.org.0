Return-Path: <linux-fsdevel+bounces-45693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BADF8A7AFD7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 23:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A594916D0DF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 20:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B22259491;
	Thu,  3 Apr 2025 19:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClqRYcez"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9D2254853;
	Thu,  3 Apr 2025 19:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743709564; cv=none; b=t0s0jGAwNCi/G5iwVRM4cZMGDJIeMWnmdFPPGnm621SnJzvCH4TAv/kRT7muBZwMalynrEVPs0uiaremIgp8hTl2zeinlylEJcdgFMgUA2D91Te83EaRQ6FxSrEbpVWPuTzg3QEUzCF4MPiBILDnqWz5Ao7EUyrzwQ0I6Xva6YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743709564; c=relaxed/simple;
	bh=Klyb4olxuB+2/KZIemN3cXLVyoeOvyIGGgqOo5lLl60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0ORQqnTXbLI4PuUtL3UTM7qp6UM9dIoruPqU03Kxv0QtHCciCvDB3X9Nt9jeJ0tYtqaUBnTMwZV08K971Si8eA8FHkJXyQ/vVEvO1QCCtmd08j5MmFLsBVKvs0VsznTfG4EusW+n4hLKLv1AkD+Lb0QsrEkWL/6aW6ozyj7/eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClqRYcez; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B786AC4CEE3;
	Thu,  3 Apr 2025 19:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743709564;
	bh=Klyb4olxuB+2/KZIemN3cXLVyoeOvyIGGgqOo5lLl60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ClqRYcezxUuF6r/G44V7e1W7ReAn6XHyFMnE5UtWahyDEFxxhAAhgrv6oPDzyjou0
	 uo7NfB9l0S3j8AlbmRN5veTOG/kdK7nnqtZPXlzMWv1foLtB1xYNTLenEBLHi8RbQs
	 OscwAfS9EkTi/j/vtvxIUPgoLzBatMH6uo31PrzR6Ru4bOUqXSOXWf2lOQiejzOGgL
	 77uOzGtvGgsyZfrZPeIPx+ataN4pfcbaid/E0HdePoeZBN/s3ViNNxbWSbz0OLuaRY
	 PVrA/Vs2EOxvoE/ilHlPX5WBKBYC98Qn1U9CMnyOtmHjaCD36fM6eTNKlwbE4Xf15r
	 /57YKljJlB23Q==
Date: Thu, 3 Apr 2025 21:45:59 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Leon Romanovsky <leon@kernel.org>, pr-tracker-bot@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] vfs mount
Message-ID: <20250403-auferlegen-erzwang-a7ee009ea96d@brauner>
References: <20250322-vfs-mount-b08c842965f4@brauner>
 <174285005920.4171303.15547772549481189907.pr-tracker-bot@kernel.org>
 <20250401170715.GA112019@unreal>
 <20250403-bankintern-unsympathisch-03272ab45229@brauner>
 <20250403-quartal-kaltstart-eb56df61e784@brauner>
 <20250403182455.GI84568@unreal>
 <CAHk-=wj7wDF1FQL4TG1Bf-LrDr1RrXNwu0-cnOd4ZQRjFZB43A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wj7wDF1FQL4TG1Bf-LrDr1RrXNwu0-cnOd4ZQRjFZB43A@mail.gmail.com>

On Thu, Apr 03, 2025 at 12:18:45PM -0700, Linus Torvalds wrote:
> On Thu, 3 Apr 2025 at 11:25, Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > -     scoped_guard(rwsem_read, &namespace_sem)
> > > +     guard(rwsem_read, &namespace_sem);
> >
> > I'm looking at Linus's master commit a2cc6ff5ec8f ("Merge tag
> > 'firewire-updates-6.15' of git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394")
> > and guard is declared as macro which gets only one argument: include/linux/cleanup.h
> >   318 #define guard(_name) \
> >   319         CLASS(_name, __UNIQUE_ID(guard))
> 
> Christian didn't test his patch, obviously.

Yes, I just sent this out as "I get why this happens." after my
screaming "dammit" moment. Sorry that I didn't make this clear. I had a
pretty strong "ffs" 10 minutes after I had waded through the overlayfs
code I added without being able to figure out how the fsck this could've
happened. In any case, there's the obviously correct version now sitting
in the tree and it's seen testing obviously.

