Return-Path: <linux-fsdevel+bounces-13414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0749786F815
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 02:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C26F1F21283
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 01:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67EA184E;
	Mon,  4 Mar 2024 01:02:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.stoffel.org (mail.stoffel.org [172.104.24.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A723115B7;
	Mon,  4 Mar 2024 01:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.104.24.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709514171; cv=none; b=um+flYl4Dk1XfJ/x0TXwwVF9j2SgfO60xTroUUPw6fFbOSau4+PZndzw7uwf1+G/vEWe+XbSXzvqndQBdgIh5jkr4z06JJRdz+iyPWDZhwFeXfntpcwFaFImd6nTolsZtGwof8oMAFrg3Us5t7bJXXDU+hJWAc9b13FCF8ZvAsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709514171; c=relaxed/simple;
	bh=U9k/P27/Lah9ghCJIGEOZLB31C4fseQ9ZjKUey9Obik=;
	h=MIME-Version:Content-Type:Message-ID:Date:From:To:Cc:Subject:
	 In-Reply-To:References; b=FKlA9flB+PgeRFkOHdkEBXICeUz8U/15IzcftsWSqFgSrZEvPeqgIE2jV6H5E2FtA74BrabYgt8AquRcP+RqC1x/2lHxf0gdtMbD/RRc1/i4qan/IDRpCMyO9+wey8ZASbti5+dAjnkYrMZbQrm1kJuVRrAQurtyQJO1I1zgVOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stoffel.org; spf=pass smtp.mailfrom=stoffel.org; arc=none smtp.client-ip=172.104.24.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stoffel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stoffel.org
Received: from quad.stoffel.org (097-095-183-072.res.spectrum.com [97.95.183.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.stoffel.org (Postfix) with ESMTPSA id 6FC9A1E12B;
	Sun,  3 Mar 2024 20:02:48 -0500 (EST)
Received: by quad.stoffel.org (Postfix, from userid 1000)
	id 56C49A025D; Sun,  3 Mar 2024 20:02:47 -0500 (EST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <26085.7607.331602.673876@quad.stoffel.home>
Date: Sun, 3 Mar 2024 20:02:47 -0500
From: "John Stoffel" <john@stoffel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: John Stoffel <john@stoffel.org>,
    linux-bcachefs@vger.kernel.org,
    linux-fsdevel@vger.kernel.org
Subject: Re: [WIP] bcachefs fs usage update
In-Reply-To: <tis2cx7vpb2qyywdwq6a74o2ryjmnn7skhsrcarix7v4sz7vad@7sf7bh2unloo>
References: <gajhq3iyluwmr44ee2fzacfpgpxmr2jurwqg6aeiab4lfila3p@b3l7bywr3yed>
	<26084.50716.415474.905903@quad.stoffel.home>
	<tis2cx7vpb2qyywdwq6a74o2ryjmnn7skhsrcarix7v4sz7vad@7sf7bh2unloo>
X-Mailer: VM 8.2.0b under 28.2 (x86_64-pc-linux-gnu)

>>>>> "Kent" == Kent Overstreet <kent.overstreet@linux.dev> writes:

> On Sun, Mar 03, 2024 at 01:49:00PM -0500, John Stoffel wrote:
>> Again, how does this help the end user?  What can they do to even
>> change these values?  They're great for debugging and info on the
>> filesystem, but for an end user that's just so much garbage and don't
>> tell you what you need to know.

> This is a recurring theme for you; information that you don't
> understand, you think we can just delete... while you also say that you
> haven't even gotten off your ass and played around with it.

Fair complaint.  But I'm also coming at this NOT from a filesystem
developer point of view, but from the Sysadmin view, which is
different.  

> So: these tools aren't for the lazy, I'm not a believer in the Gnome
> 3 philosophy of "get rid of anything that's not for the lowest
> common denominator".

Ok, I can see that, but I never was arguing for simple info, I was
also arguing for parseable information dumps, for futher tooling.  I'm
happy to write my own tools to parse this output if need be to give
_me_ what I find useful.  

But you edlided that part of my comments.  Fine.  

> Rather - these tools will be used by people interested in learning more
> about what their computers are doing under the hood, and they will
> definitely be used when there's something to debug; I am a big believer
> in tools that educate the user about how the system works, and tools
> that make debugging easier.

> 'df -h' already exists if that's the level of detail you want :)

Sure, but when it comes to bcachefs, and sub-volumes (I'm following
the discussion of statx and how to make sub-volumes distinct from
their parent volumes) will df -h from gnu's coreutils package know how
to display the extra useful information, like compression ratios,
dedupe, etc.  And how snapshots are related to each other in terms of
disk space usage.  

This is not the same level of detail needed by a filesystem developer,
and I _never_ said it was.  I'm looking for the inforation
needed/wanted by a SysAdmin when an end user comes whining about
needing more space.  And then being able to examine the system
holistically to give them an answer.  Which usually means "delete
something!"  *grin*

John

