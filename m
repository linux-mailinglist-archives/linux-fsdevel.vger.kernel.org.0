Return-Path: <linux-fsdevel+bounces-19210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FE38C144D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 19:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E22D9B21399
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 17:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B943A770E2;
	Thu,  9 May 2024 17:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+fJaHSY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212744C8B;
	Thu,  9 May 2024 17:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715276866; cv=none; b=AX/433vfopZQ1MJmjXB+crmTUAXY2JrsDGp6rGkVS0K9Zue8lZyRacMyJNNtgJi81Rq31QIyOoYzX/kfNj8JQdqNHs6/rj29vTb4MdUjsgvBlbDUD/F3hTbSBDvT0QQjt+OVDjMZY6G7mV5cwrkktcz5Oj90fY3FI5UdPOoG7bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715276866; c=relaxed/simple;
	bh=2BpoyfLJpE2n7dg7OXu8AFRKGOsqO8S/HPUzWqSNnUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JF5OTKa5rEg+wr1QeL2TMLToNcDUv/MYajj2BkSQmwA7z2+eF7TXtKM1LA+e+RlkwC/XhDILhRIRE8+m9gr5I2pxyo6GZ/aPZT6AL18QdW4oI7MwvYEpo8bYgFlIjZmNnlnwzbDmc+TYpkvNR2Yz716YwlfuYXz1WbswdamLKL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+fJaHSY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6BD1C116B1;
	Thu,  9 May 2024 17:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715276866;
	bh=2BpoyfLJpE2n7dg7OXu8AFRKGOsqO8S/HPUzWqSNnUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L+fJaHSYVj8m+KtztBVrctcNxRTxNQ/q20yDVgIc3Sa2zVb7pT6aJ6EjZwy5bxbad
	 IV91MA0KrykgQMr0STXmn0mrRHwEDOA5lwR8DCH/f0+x4n2qPyEMG9/jOOPuMeXCNJ
	 1O6AeiK04JofQXMWqB6kYR0TOs+I1WgbywoOR1Y1JsHsV7jij3KiVzgv9VUTkU0/je
	 d/xr41ZqJfo2QDSH2fXVmtRbh4bW7jqu8S3CFOpQ4WSUZLRrP1fpItTQUDIp15/zjr
	 R9fsrut+I1r5D8SiuQypP6ci+EliNTj+LGewzIFesGYFiqsBH1tL1uJYErIiTwxPZ7
	 8p2aZLcMASdog==
Date: Thu, 9 May 2024 10:47:45 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	lsf-pc@lists.linux-foundation.org, xfs <linux-xfs@vger.kernel.org>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Chandan Babu R <chandan.babu@oracle.com>, Jan Kara <jack@suse.cz>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: Re: [Lsf-pc] XFS BoF at LSFMM
Message-ID: <20240509174745.GO360919@frogsfrogsfrogs>
References: <CAB=NE6V_TqhQ0cqSdnDg7AZZQ5ZqzgBJHuHkjKBK0x_buKsgeQ@mail.gmail.com>
 <CAOQ4uxj8qVpPv=YM5QiV5ryaCmFeCvArFt0Uqf29KodBdnbOaw@mail.gmail.com>
 <ZjxZttSUzFTd_UWc@infradead.org>
 <CAOQ4uxhpZ-+Fgrx_LDAO-K5wHaUghPfvGePLVpNaZZza1Wpvrg@mail.gmail.com>
 <20240509155528.GN360919@frogsfrogsfrogs>
 <CAOQ4uxiX=O8NhonBv2Yt6nu4ZiqTLBUZg+M5r0T-ZO5LC=a2dQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxiX=O8NhonBv2Yt6nu4ZiqTLBUZg+M5r0T-ZO5LC=a2dQ@mail.gmail.com>

On Thu, May 09, 2024 at 08:29:19PM +0300, Amir Goldstein wrote:
> On Thu, May 9, 2024 at 6:55 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > [adds ritesh to cc]
> >
> > On Thu, May 09, 2024 at 08:23:25AM +0300, Amir Goldstein wrote:
> > > On Thu, May 9, 2024 at 8:06 AM Christoph Hellwig <hch@infradead.org> wrote:
> > > >
> > > > On Thu, May 09, 2024 at 08:01:39AM +0300, Amir Goldstein wrote:
> > > > >
> > > > > FYI, I counted more than 10 attendees that are active contributors or
> > > > > have contributed to xfs in one way or another.
> > > > > That's roughly a third of the FS track.
> > > >
> > > > FYI, I'm flying out at 4:15pm on Wednesday, and while I try to keep my
> > > > time at the airport short I'd still be gone by 3:30.
> > >
> > > I've penciled XFS BoF at 2:30
> >
> > Ritesh and Ted and Jan and I were chatting during the ext4 concall just
> > now.  Could we have a 30 minute iomap bof at 2:30pm followed by the XFS
> > bof after that?  That would give us some time to chat with hch about
> > iomap (and xfs) direction before he has to leave.
> >
> > Alternately, we could announce a lunchtime discussion group on Monday
> > following Ritesh's presentation about iomap.  That could fit everyone's
> > schedule better?  Also everyone's braincaches will likely be warmer.
> >
> 
> Seems to me that there will be a wider interest in iomap BoF
> Not sure what you mean by lunchtime discussion.

Monday 90-minute lunch is posted as being in "Grand ballroom C", so I
would tell everyone to come find the table(s) I'm sitting at for a
discussion over lunch.  We can move out to a hallway after everyone's
done eating.

> We can move Willy's GFP_NOFS talk to 15:30 and have the iomap BoF
> after Ritesh's session.

<shrug> If you like, though I don't think it's totally necessary.  But
you might have a better idea of what the venue is like than I do, so
I'll let you make that call. :)

> > > >
> > > > But that will only matter if you make the BOF and actual BOF and not the
> > > > usual televised crap that happens at LSFMM.
> > > >
> > >
> > > What happens in XFS BoF is entirely up to the session lead and attendees
> > > to decide.
> > >
> > > There is video in the room, if that is what you meant so that remote attendees
> > > that could not make it in person can be included.
> > >
> > > We did not hand out free virtual invites to anyone who asked to attend.
> > > Those were sent very selectively.
> > >
> > > Any session lead can request to opt-out from publishing the video of the
> > > session publicly or to audit the video before it is published.
> > > This was the same last year and this year this was explicitly mentioned
> > > in the invitation:
> > >
> > > "Please note: As with previous years there will be an A/V team on-
> > > site in order to facilitate conferencing and help with virtual
> > > participants. In order to leave room for off-the-record discussions
> > > the storage track completely opts out of recordings. For all other
> > > tracks, please coordinate with your track leads (mentioned below)
> > > whether a session should explicitly opt-out. This can also be
> > > coordinated on-site during or after the workshop. The track leads
> > > then take care that the given session recording will not be
> > > published."
> > >
> > > I will take a note to keep XFS BoF off the record if that is what you
> > > want and if the other xfs developers do not object.
> >
> > Survey: How many people want to attend the xfs bof virtually?
> >
> > I'd be ok with an OTR discussion with no video, though I reserve the
> > right to change my mind if the score becomes chair: 2 djwong: 0. :P
> 
> The middle ground is to allow video for the selective virtual attendees
> (and trust them not to record and publish) and not publish the video
> on LSMFF site.

I didn't know that was also an option; I'll keep that in mind.

--D

> Thanks,
> Amir.
> 

