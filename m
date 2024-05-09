Return-Path: <linux-fsdevel+bounces-19200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0508C1254
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 17:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6681BB21E8D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 15:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5385813B2A4;
	Thu,  9 May 2024 15:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GP6ph3D7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECCE16F84D;
	Thu,  9 May 2024 15:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715270129; cv=none; b=kuz3coplsy04OdxwiB5rzp5IE55o0VuxjhYSPVNv7b7lhwLGtdv6xwAB6amWFNu9qoKx/NEREHcxqB3WOVEgQSMWpxB/AqONSjCYRE4Vzl1H49FrfB2ec84K6JZtoMEBIZKSpnUwPlxjDurvVVaOKYCDaqNphK6ngyMIT54iT6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715270129; c=relaxed/simple;
	bh=Ohoc8DMSWjAMlELW1YceONMFsy6KgowhiUKldNk5K2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHiNKKhv0dlXk+bvozovvp7NajsmPIjadZrwDWNDbfO0gpzd+aehTYWQfdz3nOtM6c1TnjVrI8he0/zE8zr+r2Mk8gCJBNi1dCCJjJYXSuZNis0OkT0GoEVSg8UrzGE48i56vhadEcSFeRUvEateQGYghyzZuVkOzqgkEMuhPCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GP6ph3D7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA08C2BD11;
	Thu,  9 May 2024 15:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715270129;
	bh=Ohoc8DMSWjAMlELW1YceONMFsy6KgowhiUKldNk5K2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GP6ph3D7skHs7aLMFBm5FbG6e3+40O76hzNvcxvhRRTfjgiZtWydaFngBxYWPb7mJ
	 fWfDF9Ih7F9Gz8hVrfG1cfR8QtR8d1yaH2xBuBwH3+z6770g/k4hYZQMEs6t3OPELF
	 //sPi4pbsvSRERd9F6vPRiZbDW2H4pY/FHi85NpQ2wNyzF6c4NK6zmtUg46KBOOL6x
	 UX6LGwdXA4+WCsyiiv9c/X3SGKIB13D5+fFxatnSafgGd+3IyLD4O8cvtw+uixxQsJ
	 tHp1NxdS1wknZ5KT0xNm+YZ+oKDiWjHENvVUhxWgYzFsiMPk0dTmUiiFLvlx+Iw5hI
	 QpOKLUKyZC3hA==
Date: Thu, 9 May 2024 08:55:28 -0700
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
Message-ID: <20240509155528.GN360919@frogsfrogsfrogs>
References: <CAB=NE6V_TqhQ0cqSdnDg7AZZQ5ZqzgBJHuHkjKBK0x_buKsgeQ@mail.gmail.com>
 <CAOQ4uxj8qVpPv=YM5QiV5ryaCmFeCvArFt0Uqf29KodBdnbOaw@mail.gmail.com>
 <ZjxZttSUzFTd_UWc@infradead.org>
 <CAOQ4uxhpZ-+Fgrx_LDAO-K5wHaUghPfvGePLVpNaZZza1Wpvrg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhpZ-+Fgrx_LDAO-K5wHaUghPfvGePLVpNaZZza1Wpvrg@mail.gmail.com>

[adds ritesh to cc]

On Thu, May 09, 2024 at 08:23:25AM +0300, Amir Goldstein wrote:
> On Thu, May 9, 2024 at 8:06 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Thu, May 09, 2024 at 08:01:39AM +0300, Amir Goldstein wrote:
> > >
> > > FYI, I counted more than 10 attendees that are active contributors or
> > > have contributed to xfs in one way or another.
> > > That's roughly a third of the FS track.
> >
> > FYI, I'm flying out at 4:15pm on Wednesday, and while I try to keep my
> > time at the airport short I'd still be gone by 3:30.
> 
> I've penciled XFS BoF at 2:30

Ritesh and Ted and Jan and I were chatting during the ext4 concall just
now.  Could we have a 30 minute iomap bof at 2:30pm followed by the XFS
bof after that?  That would give us some time to chat with hch about
iomap (and xfs) direction before he has to leave.

Alternately, we could announce a lunchtime discussion group on Monday
following Ritesh's presentation about iomap.  That could fit everyone's
schedule better?  Also everyone's braincaches will likely be warmer.

> >
> > But that will only matter if you make the BOF and actual BOF and not the
> > usual televised crap that happens at LSFMM.
> >
> 
> What happens in XFS BoF is entirely up to the session lead and attendees
> to decide.
> 
> There is video in the room, if that is what you meant so that remote attendees
> that could not make it in person can be included.
> 
> We did not hand out free virtual invites to anyone who asked to attend.
> Those were sent very selectively.
> 
> Any session lead can request to opt-out from publishing the video of the
> session publicly or to audit the video before it is published.
> This was the same last year and this year this was explicitly mentioned
> in the invitation:
> 
> "Please note: As with previous years there will be an A/V team on-
> site in order to facilitate conferencing and help with virtual
> participants. In order to leave room for off-the-record discussions
> the storage track completely opts out of recordings. For all other
> tracks, please coordinate with your track leads (mentioned below)
> whether a session should explicitly opt-out. This can also be
> coordinated on-site during or after the workshop. The track leads
> then take care that the given session recording will not be
> published."
> 
> I will take a note to keep XFS BoF off the record if that is what you
> want and if the other xfs developers do not object.

Survey: How many people want to attend the xfs bof virtually?

I'd be ok with an OTR discussion with no video, though I reserve the
right to change my mind if the score becomes chair: 2 djwong: 0. :P

--D

> Thanks,
> Amir.
> 

