Return-Path: <linux-fsdevel+bounces-19399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5158C49A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 00:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90E9A1C2138E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 22:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E704D84037;
	Mon, 13 May 2024 22:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5fpEsYc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA8CD51A;
	Mon, 13 May 2024 22:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715639636; cv=none; b=G4SZuK1t3NhEs6z780/LqMd4Dd2mGT6YblThsLfeWWrQ1pzZDOuak4Z1l6HTzhMbHaAZrv6HRgqP8FmiCtqujoNGHWiBKpEYgX1r9TbEIP5oSPTazfYyim3zfo2RxuohEIyAd4jsoiAi8L8BP120PkVLIzEC+rUX2OA8qn4DuYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715639636; c=relaxed/simple;
	bh=jlDgwRsvV+Mu6KJmAfR0E1kVaqXPzsFpuHvQptaQzvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ua8/Gt4JEQge2NMiZaqr8xevR1DsTg6FskixWnDNmfAoNRJBw6OrjL59cpuWlnoqQ1EJjXoVErAxY7PIObGuUmuO9Cg3BioP7snV2DGaKxC4VNzRS14zlurJChRbXHMaEFguOV/nkpo8uYDFqq5/bH2ImHtBrNRswZp/6eCELdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5fpEsYc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2939C113CC;
	Mon, 13 May 2024 22:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715639636;
	bh=jlDgwRsvV+Mu6KJmAfR0E1kVaqXPzsFpuHvQptaQzvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S5fpEsYc0ppbyOkrVBBn4DZImDrpiE5vPn43xRg+oBcn4P1/IptoDPncXrZEgHPBA
	 mDzcCr807p1T1xwctggQKAIB2G1Lhb5NXmQtiwCdXUHb4XIRhZuTg/seB3xfrEJGO8
	 sS1ndfatl4PaCj+HTuLy3c9zfxzdf1H7/kdKAijrSXZjkIkagtpXjVPDCFyJH3oKuZ
	 KrPtts44UTN7NzUcTQToGHgHPDQL/6gohuCsynNSr7KkDLuG6VyTw+nhnUIXzMwfww
	 vddHIA3fRvCFZdTBP4iNi0Ln0EnPwpQFaZ0ef/H2uXZR+ipL3Y8YDICoYg7TNhSJzU
	 TjwzWCYRGE8ew==
Date: Mon, 13 May 2024 15:33:55 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	lsf-pc@lists.linux-foundation.org, xfs <linux-xfs@vger.kernel.org>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Chandan Babu R <chandan.babu@oracle.com>, Jan Kara <jack@suse.cz>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: Re: [Lsf-pc] XFS BoF at LSFMM
Message-ID: <20240513223355.GQ2049409@frogsfrogsfrogs>
References: <CAB=NE6V_TqhQ0cqSdnDg7AZZQ5ZqzgBJHuHkjKBK0x_buKsgeQ@mail.gmail.com>
 <CAOQ4uxj8qVpPv=YM5QiV5ryaCmFeCvArFt0Uqf29KodBdnbOaw@mail.gmail.com>
 <ZjxZttSUzFTd_UWc@infradead.org>
 <CAOQ4uxhpZ-+Fgrx_LDAO-K5wHaUghPfvGePLVpNaZZza1Wpvrg@mail.gmail.com>
 <20240509155528.GN360919@frogsfrogsfrogs>
 <CAOQ4uxiX=O8NhonBv2Yt6nu4ZiqTLBUZg+M5r0T-ZO5LC=a2dQ@mail.gmail.com>
 <20240509174745.GO360919@frogsfrogsfrogs>
 <20240513134816.GB520598@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513134816.GB520598@mit.edu>

On Mon, May 13, 2024 at 07:48:16AM -0600, Theodore Ts'o wrote:
> On Thu, May 09, 2024 at 10:47:45AM -0700, Darrick J. Wong wrote:
> > > > Ritesh and Ted and Jan and I were chatting during the ext4 concall just
> > > > now.  Could we have a 30 minute iomap bof at 2:30pm followed by the XFS
> > > > bof after that?  That would give us some time to chat with hch about
> > > > iomap (and xfs) direction before he has to leave.
> > > >
> > > > Alternately, we could announce a lunchtime discussion group on Monday
> > > > following Ritesh's presentation about iomap.  That could fit everyone's
> > > > schedule better?  Also everyone's braincaches will likely be warmer.
> > > 
> > > Seems to me that there will be a wider interest in iomap BoF
> > > Not sure what you mean by lunchtime discussion.
> > 
> > Monday 90-minute lunch is posted as being in "Grand ballroom C", so I
> > would tell everyone to come find the table(s) I'm sitting at for a
> > discussion over lunch.  We can move out to a hallway after everyone's
> > done eating.
> > 
> > > We can move Willy's GFP_NOFS talk to 15:30 and have the iomap BoF
> > > after Ritesh's session.
> > 
> > <shrug> If you like, though I don't think it's totally necessary.  But
> > you might have a better idea of what the venue is like than I do, so
> > I'll let you make that call. :)
> 
> How did we decide to resolve this?  If we have the iomap BOF at
> 2:30pm, with a hard stop at 3:00pm, that would work for everyone
> including Cristoph.
> 
> Or we can try to get all of the people interested in talking about
> iomap at lunch on Wednesday.

It's currently scheduled for 12:30 (Mountain Time, or GMT -0600) tomorrow the
14th.  Schedule still subject to change tho

https://docs.google.com/spreadsheets/d/176LXLys9Uh6A-Eal2flrzcbUSJMUXGkGwyihr9jAAaQ/edit#gid=0

--D

> Or we could do something that requires a lot more juggling of slots,
> which I'll leave to the track leads.  :-)
> 
> All of these ideas work for me.
> 
> 
> As far as scheduling per-file system BOF's, I'd like to claim the slot
> immediately after XFS for an ext4 BOF, it that would be OK.
> 
> Thanks,
> 
> 						- Ted

