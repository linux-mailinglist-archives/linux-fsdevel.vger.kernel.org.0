Return-Path: <linux-fsdevel+bounces-57475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA682B21FF9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 09:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3113E5051E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 07:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB272E173F;
	Tue, 12 Aug 2025 07:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sotapeli.fi header.i=@sotapeli.fi header.b="NXV/aewe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from se.sotapeli.fi (se.sotapeli.fi [206.168.212.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D592DF3D1;
	Tue, 12 Aug 2025 07:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.168.212.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754985295; cv=none; b=C36Y3QIs5U85jewDxsv8muY8A7V0Llk3wqkEkPV92c//YQRzbifKiw+wvWwDvDydNWIhBrRl039aBzvjkYt/uY7hiuDlN/RBZhsDJ8IbadmLMV2VUpP74T+hh3ou4QBntsmTlx7hnnm3oOawT4BshfFZEAwioUi8zOpR7fqMuE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754985295; c=relaxed/simple;
	bh=G0bZntmSwAfoPQ+6pF2OOgLr6cbO5CLZQzjcmfT3cKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mXjR1MC6KBuLEwbLNPCMknQHNjar9S6EeVaWlUG7izlypog7hKVE1ldVbEbCzE0Wdm9hoL/UIKALjuXzK3N5+7crvreKsNycWnMgkyY0DQJUe3wG22TFX8JIRkgzrCRPduGnWBaGiveiv7gj+3Eo+sL4agF2PfOGo65l/cxXksQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sotapeli.fi; spf=pass smtp.mailfrom=sotapeli.fi; dkim=pass (2048-bit key) header.d=sotapeli.fi header.i=@sotapeli.fi header.b=NXV/aewe; arc=none smtp.client-ip=206.168.212.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sotapeli.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sotapeli.fi
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C12A9181AA00;
	Tue, 12 Aug 2025 09:49:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sotapeli.fi; s=dkim;
	t=1754984950; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references:autocrypt;
	bh=iUxUyma4bnNa8hrTNpMn9u9YO0iIOktTKvT27O4pMpw=;
	b=NXV/aeweTNpKiHipLLyIIOf7bjsdBaFKQCGQGsTbqWsIUsk9FKi/G9ytWyOEZcQLpdpB/f
	vQqy5Kslw6kf67M8yVK/2l4L1BxcagnkEV/iofucOuqId1iJT+Z5942mPHOyMKZktwJAld
	d2wNMadMToBRHArSi4LhPrmoE3UOGby62+SCE/9GyV6WQNxoycXN/f9vrUibh8Yh4rbDSw
	8G9KHW4dNWrJ65rtjdABdVyDMGfd8LKCCQ14Wkwfr/ZBa5rWEelnpf69eOLvg8uSNGZm2N
	2WpSP6qTm4BalY4me8S2z9rsotrCiF3qq3fSPt9gkx/2UMxKNEpRpJ8vGHcIeA==
Message-ID: <c55affa6-4b8e-4110-bf44-c595d4cda81f@sotapeli.fi>
Date: Tue, 12 Aug 2025 10:49:03 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] bcachefs changes for 6.17
To: Kent Overstreet <kent.overstreet@linux.dev>,
 Matthew Wilcox <willy@infradead.org>
Cc: Aquinas Admin <admin@aquinas.su>,
 =?UTF-8?Q?Malte_Schr=C3=B6der?= <malte.schroeder@tnxip.de>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "Carl E. Thompson" <list-bcachefs@carlthompson.net>,
 linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <22ib5scviwwa7bqeln22w2xm3dlywc4yuactrddhmsntixnghr@wjmmbpxjvipv>
 <f4be82e7-d98c-44d1-a65b-8c4302574fff@tnxip.de>
 <1869778184.298.1754433695609@mail.carlthompson.net>
 <5909824.DvuYhMxLoT@woolf>
 <3ik3h6hfm4v2y3rtpjshk5y4wlm5n366overw2lp72qk5izizw@k6vxp22uwnwa>
 <aJfTPliez_WkwOF3@casper.infradead.org>
 <5ip2wzfo32zs7uznaunpqj2bjmz3log4yrrdezo5audputkbq5@uoqutt37wmvp>
Content-Language: en-US
From: Jani Partanen <jiipee@sotapeli.fi>
Autocrypt: addr=jiipee@sotapeli.fi; keydata=
 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
In-Reply-To: <5ip2wzfo32zs7uznaunpqj2bjmz3log4yrrdezo5audputkbq5@uoqutt37wmvp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On 10/08/2025 2.13, Kent Overstreet wrote:
> And now, I just got an email from Linus saying "we're now talking about
> git rm -rf in 6.18", after previously saying we just needed a
> go-between.
>
> So if that's the plan, I need to be arguing forcefully here, because a
> lot is on the line for a lot of people.


No that is not what you need to do. Arguing is the guarantee way that rm 
-rf will happen.

You need to *SHUT* *THE* *FUCK* *UP* *RIGHT* *NOW!* That is what you 
need to do and find very very fast some spokesman/woman/person who deal 
all the communication.

As I already said like month or 2 back, you are unable to do code and 
communication. You do one well (what I understand from comments, I am 
not a coder myself) and you suck on the other.


It does not help:

- that you are trashing constantly other filesystems.

- that you are bragging that you are here to challenge Linus.

  -that you cannot see your own faults.

- that you are playing the victim when shit hits the fan.


You and I have much same. I am also asshole who will argue for the sake 
of argument. So even when I know that I am wrong, I still keep going and 
that is behavior what I am not proud and I start to be too old that I 
can be fixed. After all, I am always right.

Linus is that kind of person who would really feed my hunger to argue. 
Seems like he works for you also.


Minor stuff I want to point out is that you do fearmongering by telling 
how other filesystems constantly break up and world really need bcachefs 
to save the world. This is quite pointless and stupid marketing. I have 
been running btrfs, ext4 and xfs years, sorry decades in multiple 
systems and I cannot even recall when I had last  time any issues with 
them what wasn't user error or hardware error. I am running even btrfs 
raid-5 on system what is not behind UPS and power outtakes is a thing here.


// Jani


