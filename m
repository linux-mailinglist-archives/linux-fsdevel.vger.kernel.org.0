Return-Path: <linux-fsdevel+bounces-13566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6279871162
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 01:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23DDE1C21AF6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 00:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F4A7D09D;
	Tue,  5 Mar 2024 00:00:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.stoffel.org (mail.stoffel.org [172.104.24.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9913D76;
	Tue,  5 Mar 2024 00:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.104.24.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709596847; cv=none; b=D6/626FxKUpLEGxM1vP4aOn5fEJX4WbD+b2+blWDzQHbVutsW+kZK2F+o9bSRje19RnitAceaEbm46T3w0KRNcpjp1PluNsIJp5NJ5/LbdXjT99YU3NtpSqMG3pF5gljyBfLKNBs+CLEcqwi5dS5ZTpiefy5ICaV8+qqYCPsiiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709596847; c=relaxed/simple;
	bh=6/a9wDUr/QyQhXmw269lOeSTRqoP345aUD2SKTmwk6Y=;
	h=MIME-Version:Content-Type:Message-ID:Date:From:To:Cc:Subject:
	 In-Reply-To:References; b=PbsdtK1KR9Ed+If0zLSyS4C3jBGW6gqUPV+mt+LQ4UD/F5qO5OLAbYCs6ZMQnI2ejDaCEr+XjHjGfmmBAdT04uHE7VicCqXwNofe2kkObI6U2iNa3QEdSrQNZItP4fNFzMsXAYpR5/AVvp3lF6xrX8XJISaASr7lDGkj53w2BuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stoffel.org; spf=pass smtp.mailfrom=stoffel.org; arc=none smtp.client-ip=172.104.24.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stoffel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stoffel.org
Received: from quad.stoffel.org (097-095-183-072.res.spectrum.com [97.95.183.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.stoffel.org (Postfix) with ESMTPSA id 4D60E1E727;
	Mon,  4 Mar 2024 19:00:38 -0500 (EST)
Received: by quad.stoffel.org (Postfix, from userid 1000)
	id 1FF6CA0265; Mon,  4 Mar 2024 19:00:37 -0500 (EST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <26086.24741.103765.962843@quad.stoffel.home>
Date: Mon, 4 Mar 2024 19:00:37 -0500
From: "John Stoffel" <john@stoffel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: John Stoffel <john@stoffel.org>,
    linux-bcachefs@vger.kernel.org,
    linux-fsdevel@vger.kernel.org
Subject: Re: [WIP] bcachefs fs usage update
In-Reply-To: <apot5wnom6wqdvjb6hfforcooxuqonmjl7z6morjyhdbgi6isq@5fcb3hld62xu>
References: <gajhq3iyluwmr44ee2fzacfpgpxmr2jurwqg6aeiab4lfila3p@b3l7bywr3yed>
	<26084.50716.415474.905903@quad.stoffel.home>
	<tis2cx7vpb2qyywdwq6a74o2ryjmnn7skhsrcarix7v4sz7vad@7sf7bh2unloo>
	<26085.7607.331602.673876@quad.stoffel.home>
	<apot5wnom6wqdvjb6hfforcooxuqonmjl7z6morjyhdbgi6isq@5fcb3hld62xu>
X-Mailer: VM 8.2.0b under 28.2 (x86_64-pc-linux-gnu)

>>>>> "Kent" == Kent Overstreet <kent.overstreet@linux.dev> writes:

> On Sun, Mar 03, 2024 at 08:02:47PM -0500, John Stoffel wrote:
>> >>>>> "Kent" == Kent Overstreet <kent.overstreet@linux.dev> writes:
>> 
>> > On Sun, Mar 03, 2024 at 01:49:00PM -0500, John Stoffel wrote:
>> >> Again, how does this help the end user?  What can they do to even
>> >> change these values?  They're great for debugging and info on the
>> >> filesystem, but for an end user that's just so much garbage and don't
>> >> tell you what you need to know.
>> 
>> > This is a recurring theme for you; information that you don't
>> > understand, you think we can just delete... while you also say that you
>> > haven't even gotten off your ass and played around with it.
>> 
>> Fair complaint.  But I'm also coming at this NOT from a filesystem
>> developer point of view, but from the Sysadmin view, which is
>> different.  
>> 
>> > So: these tools aren't for the lazy, I'm not a believer in the Gnome
>> > 3 philosophy of "get rid of anything that's not for the lowest
>> > common denominator".
>> 
>> Ok, I can see that, but I never was arguing for simple info, I was
>> also arguing for parseable information dumps, for futher tooling.  I'm
>> happy to write my own tools to parse this output if need be to give
>> _me_ what I find useful.  
>> 
>> But you edlided that part of my comments.  Fine.  
>> 
>> > Rather - these tools will be used by people interested in learning more
>> > about what their computers are doing under the hood, and they will
>> > definitely be used when there's something to debug; I am a big believer
>> > in tools that educate the user about how the system works, and tools
>> > that make debugging easier.
>> 
>> > 'df -h' already exists if that's the level of detail you want :)
>> 
>> Sure, but when it comes to bcachefs, and sub-volumes (I'm following
>> the discussion of statx and how to make sub-volumes distinct from
>> their parent volumes) will df -h from gnu's coreutils package know how
>> to display the extra useful information, like compression ratios,
>> dedupe, etc.  And how snapshots are related to each other in terms of
>> disk space usage.  

> Getting subvolumes plumbed all the way into df -h is not on my short
> term radar. I _am_ looking at, possibly, standardizing some APIs for
> walking subvolumes - so depending on how that goes, perhaps.

And that's fine.  Then maybe one answer is to have a 'bcachefs fs df'
command which does show data like I'm asking for, but the focus is
more on the end user, not the developer.  

>> This is not the same level of detail needed by a filesystem developer,
>> and I _never_ said it was.  I'm looking for the inforation
>> needed/wanted by a SysAdmin when an end user comes whining about
>> needing more space.  And then being able to examine the system
>> holistically to give them an answer.  Which usually means "delete
>> something!"  *grin*

> 'bcachefs fs usage' needs to show _all_ disk accounting information
> bcachefs has, because we need there to be one single tool that shows all
> the information we have - that's this tool.

Sure, but does it need to show all the information all the time?  

> If we're collecting information, it needs to be available.

Sure, but does it need to be shown by default?  

> There will no doubt be switches and options for providing reduced forms,
> but for now I'm mainly concerned with making sure all the information
> that we have is there in a reasonably understandable way.

That's an answer then.  So if I want less information, I have to step
up and generate a patch bundle to propose such changes.  

Whcih I know I won't get to any time soon since I've got other
commitements first, and I'm not a strong developer, I'm a long time
SysAdmin.



