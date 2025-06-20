Return-Path: <linux-fsdevel+bounces-52335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9AEAE1EAE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 17:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F360817C1A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 15:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B6C2E3384;
	Fri, 20 Jun 2025 15:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b="eR29HlEw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailrelay.tugraz.at (mailrelay.tugraz.at [129.27.2.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562FE12A177;
	Fri, 20 Jun 2025 15:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.27.2.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750433193; cv=none; b=O4fUTSQmDUPgzoqIonOXmVXjSPABvA3Bddw5eY6/UJjoViaMzBzCoAgCLrr8jGiTvenLdIBTjDOjimyQxmTMwqbldssEpNzGAwVjbvWedvCqkWXfX8nM2JfE4/HZTFI4y6kM0x4f2QPRENRv4bPcYitUvL/OizuFm3oSJs5DUJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750433193; c=relaxed/simple;
	bh=E4agwpxGFwqFeVJHeOCM9PGifChpw9gXLh90YWEsmCM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=XVs9FfIZbNlW3Sc3s/NsmqKkarNpcL7ytDN8MexQNcIron30SQ60+qQ+2Y+cTASSypaOVWzJv04YTsHN5cr2v1KN8LNIkXjVOq0rVNAWJoeiaJzvo2j5PCMgGVCGZsYk8xWQaC6T8bQJAcWL+CqTOYMPNjOKvnL34t/SfypMyJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=student.tugraz.at; spf=pass smtp.mailfrom=student.tugraz.at; dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b=eR29HlEw; arc=none smtp.client-ip=129.27.2.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=student.tugraz.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=student.tugraz.at
Received: from [10.0.0.5] (178-189-174-90.adsl.highway.telekom.at [178.189.174.90])
	by mailrelay.tugraz.at (Postfix) with ESMTPSA id 4bP1L86r7hz1LQwm;
	Fri, 20 Jun 2025 17:17:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailrelay.tugraz.at 4bP1L86r7hz1LQwm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tugraz.at;
	s=mailrelay; t=1750432641;
	bh=9ajYOC1IbfhtjE7fvp73fh+D1VdWRvU4dVnosjwrY8k=;
	h=Date:To:Cc:References:Subject:From:In-Reply-To:From;
	b=eR29HlEwJg3v3GBMZqac+sDtM+0wyFt3SvPD0p9LjNopg1EjYMM0M6vyLdnqvrXNt
	 35fZmhTZBygX5vK75wqZ2aMzAnVr7vm8arNSxdn5dFxuVfJWXHB29VqZ6kEH4F7Ne+
	 AFKhQBOUAlWjx4yGSaa6kq1o1y0ZNhADwCGN5hS0=
Message-ID: <46b1a3d8-c77d-44bc-9d92-edc32d7b88eb@student.tugraz.at>
Date: Fri, 20 Jun 2025 17:17:20 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: tytso@mit.edu
Cc: jiipee@sotapeli.fi, kent.overstreet@linux.dev,
 linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, martin@lichtvoll.de,
 torvalds@linux-foundation.org
References: <20250620124346.GB3571269@mit.edu>
Subject: Re: [GIT PULL] bcachefs fixes for 6.16-rc3
Content-Language: en-US
From: Christoph Heinrich <christoph.heinrich@student.tugraz.at>
In-Reply-To: <20250620124346.GB3571269@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TUG-Backscatter-control: gmwzW8oMfNreqDqbcncFhA
X-Spam-Scanner: SpamAssassin 3.003001 
X-Spam-Score-relay: 0.0
X-Scanned-By: MIMEDefang 2.74 on 129.27.10.117

> On Fri, Jun 20, 2025 at 04:14:24AM -0400, Kent Overstreet wrote:
>> 
>> There is a time and a place for rules, and there is a time and a place
>> for using your head and exercising some common sense and judgement.
>> 
>> I'm the one who's responsible for making sure that bcachefs users have a
>> working filesystem. That means reading and responding to every bug
>> report and keeping track of what's working and what's not in
>> fs/bcachefs/. Not you, and not Linus.
> 
> Kent, the risk as always of adding features after the merge window is
> that you might introduce regressions.  This is especially true if you
> are making changes to relatively sensitive portions of any file system
> --- such as journalling.
> > The rules around the merge window is something which the vast majority
> of the kernel developers have agreeded upon for well over a decade.
> And it is Linus's responsibility to *enforce* those rules.
While bcachefs is marked as experimental, perhaps the rules should be
somewhat relaxed. After all those rules were made in the context of
"stable" parts of the kernel and thus might not be the best strategy
for parts explicitly marked as experimental.

After following bcachefs development for a while now, I'd be totally
fine with him pushing new features up to rc5 or so.
Of course such a relaxed rule set should be agreed upon _before_
sending something.

> If, as you say, bcachefs is experimental, and no sane person should be
> trusting their data on it, then perhaps this shouldn't be urgent.  On
> the flip side, perhaps if you are claiming that people should be using
> it for critical data, then perhaps your care for user's data safety
> should be.... revisted.

Considering bcachefs's track record of not loosing data, it shouldn't
be surprising that some people start trusting it, despite being marked
experimental. With that one fs being saved by journal rewind, I guess
we're back to nobody ever loosing any data to bcachefs, which is quite
impressive.

FWIW I'm running two multi device filesystems with bcachefs right
now. They are purely for bulk storage so far, so I'm not the best
advocate for daily use stability. However I've been lurking in IRC ever
since Kent saved my ass after I screwed up one of those filesystems
(100% user error, wouldn't have blamed it on the fs for loosing it),
and after watching him work his magic for other users, I'd trust
bcachefs more to not permanently eat my data then other filesystems.

- Christoph

