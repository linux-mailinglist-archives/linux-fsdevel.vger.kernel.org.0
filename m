Return-Path: <linux-fsdevel+bounces-57576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 553DBB23A03
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 22:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD9895670F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 20:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344602D73BE;
	Tue, 12 Aug 2025 20:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTynvEuJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5A63594F;
	Tue, 12 Aug 2025 20:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755030646; cv=none; b=CHsQQZE960tEfywrZ/y97hgIBoZqiCWEweuWBaXIFsPbb1pJYWiwvZdBPRYpioziXcwNkrVkMQgHFETRCdPukqK0NqXN+WBETODz2hk5LObu9ECMbxQ22G3XbBRJORfv415igVD7VCnZr9EeSvDqx952FnsSokq5uUHgLJWvqTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755030646; c=relaxed/simple;
	bh=C7Zan8R4dIjGaXNNFSK51VuqKxXjZm7KmeThegus+1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7ueO4RIuNLSQZqxJCCcWSFKCaIb31USr7df+j/ZltJbfQPe3/2EPv1iwHC4gdGXsRMpIKUXfXsKkHy+JkV6j3t6esbRucodri/GKhtM1NBJ4+YdTds2GnL4RcRlhE4h5B5Qo0p/ZJgPnedqr/J56NEuf8PZ+/l6zZ3OrsuIoz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTynvEuJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B773BC4CEF0;
	Tue, 12 Aug 2025 20:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755030646;
	bh=C7Zan8R4dIjGaXNNFSK51VuqKxXjZm7KmeThegus+1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nTynvEuJXJyCB1WIqYH8bG0noAxAVgb4QN8892IG2eok5kjGnVY0G6ZzGoWOu6I/+
	 t+agr9V2069mX3wpn0D/zzWXKciOp6lUufeRMWDCzeSenXuetZd3JjQwgvOtHD7t7U
	 dazn2XDTdttFTAAvQJ/lKhBC+BFkhxhByjfYUSH92txYTCLD4nkri1RYYH7qHKM+/t
	 VGsb6BjltmEOPfd7NuQJKJGrWsaWAN0qMZWdqMkRZdP2X0whbmYipMc13dCpAMQsPI
	 VYG/kv+a+4V4ulzZOQM38e2CzMcKtc4nntGw6ykOQVBOcHKQ7FeXavMSSo7G1e+8Gm
	 /7rOGmgDthKAA==
Date: Tue, 12 Aug 2025 14:30:44 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Konstantin Shelekhin <k.shelekhin@ftml.net>, admin@aquinas.su,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, list-bcachefs@carlthompson.net,
	malte.schroeder@tnxip.de, torvalds@linux-foundation.org
Subject: Re: [GIT PULL] bcachefs changes for 6.17
Message-ID: <aJukdHj1CSzo6PmX@kbusch-mbp>
References: <3ik3h6hfm4v2y3rtpjshk5y4wlm5n366overw2lp72qk5izizw@k6vxp22uwnwa>
 <55e623db-ff03-4d33-98d1-1042106e83c6@ftml.net>
 <iktaz2phgjvhixpb5a226ebar7hq6elw6l4evcrkeu3wwm2vs7@fsdav6kbz4og>
 <aJuXnOmDgnb_9ZPc@kbusch-mbp>
 <htfkbxsxhdmojyr736qqsofghprpewentqzpatrvy4pytwublc@32aqisx4dlwj>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <htfkbxsxhdmojyr736qqsofghprpewentqzpatrvy4pytwublc@32aqisx4dlwj>

On Tue, Aug 12, 2025 at 04:03:17PM -0400, Kent Overstreet wrote:
> On Tue, Aug 12, 2025 at 01:35:56PM -0600, Keith Busch wrote:
> > On Mon, Aug 11, 2025 at 10:26:03AM -0400, Kent Overstreet wrote:
> > > On the other hand, for the only incidences I can remotely refer to in
> > > the past year and a half, there has been:
> > ...
> > 
> > > - the block layer developer who went on a four email rant where he,
> > >   charitably, misread the spec or the patchset or both; all this over a
> > >   patch to simply bring a warning in line with the actual NVME and SCSI
> > >   specs.
> > 
> > Are you talking about this thread?
> > 
> >   https://lore.kernel.org/linux-block/20250311201518.3573009-14-kent.overstreet@linux.dev/
> > 
> > I try to closely follow those lists, and that's the only thread I recall
> > that even slightly rings a bell from your description, however it's not
> > an accurate description (you were the one who misread the specs there; I
> > tried to help bridge the gap). I recall the interaction was pretty tame
> > though, so maybe you're talking about something else. Perhaps a link for
> > context if I got it wrong?
> 
> I've since seen a lot of actual test data from SCSI hard drives - fua
> reads are definitely not cached, without exception across manufacturers.
> 
> On NVME the situation is much murkier.

Okay, I take it I got the right thread then. I just wanted to get the
context. For the record, all the specs align with what read fua does
(anyone interested can visit the linked thread, I don't want to hijack
this one for it).

