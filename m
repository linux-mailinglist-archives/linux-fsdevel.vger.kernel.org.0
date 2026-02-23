Return-Path: <linux-fsdevel+bounces-77899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Ja4CI2sm2kH4gMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 02:25:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB3A1714FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 02:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47042302335A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 01:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC8E1DE3AD;
	Mon, 23 Feb 2026 01:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b="vZtnMJ+N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bumble.birch.relay.mailchannels.net (bumble.birch.relay.mailchannels.net [23.83.209.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F65D54763;
	Mon, 23 Feb 2026 01:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771809921; cv=pass; b=vFeoR1QR1sC3wU/uEiLU0TJZxFNSvxX/Yds22rbD+NcVm5i2rFIdlEevYAdA+6KrMWXEdeLMM8GH4qqkl5buJbJSffOP/tBCOoImXQCKHkrWK4XWg6iGvNYt9PUsi+s3fVbGP/A+Z/J6DANxamQt7InHRUYCv+q7gbeOxFtf/Vk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771809921; c=relaxed/simple;
	bh=ya6JK5QpUEwhNPlRYYcgwO8/Mxw3gnYEeCTotxgTMU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nng0rBJSRBfhaPypDJAL2kTE42Bo4lXeSaoNyyaQ3qLI6T8QUkZL8gFS3PuybCPlC+vRw/0sHzP7sezanMF8PYD/uBwAuO5U8u4s4SnrXnBdyDIXDkwz1qY1QRzqnNtOF5od7wIK0ldhCkbHMj/SAhJs0MnwSm/LhfjbwHW0D9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=pass smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b=vZtnMJ+N; arc=pass smtp.client-ip=23.83.209.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 372D91617D9;
	Mon, 23 Feb 2026 01:15:51 +0000 (UTC)
Received: from pdx1-sub0-mail-a220.dreamhost.com (100-106-196-237.trex-nlb.outbound.svc.cluster.local [100.106.196.237])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id ACA07161929;
	Mon, 23 Feb 2026 01:15:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1771809350;
	b=D5yB3HeM5MidXwq26kPQy1I/QzNs9TALf1vh236Lj8ONELIuFGUUQkX0GbQpT3TzgzKAcI
	XuEK7OeSfQZgJKICrUK7f+77nu22yePPggbNgATKImdncJroPIDoo11c0P3/gNtMDnpo1M
	BTM82yU6ro9MqcUFcHy0NAkfcaKBsjY6Rk3u5YiEoGKJV3l7jSz7pzWI3srijUrBIDnynq
	TmE0Umgx8CrOeuy1ZFzz09kRmucWeRKaJ7u0MGdBs2RW5GRwZHqOStNG2HyyvRxtmxLkC5
	erzkaZTYa4QWRBUWtY7u/efmtbtUNdZlaKQCkVQRgx6b/jcCYZ5GXzfl/RewMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1771809350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=3nv7pEazH1QjXd2mYdHZhHpxrx3ZA5FYW4d+2tDCmiQ=;
	b=trSgABybJjbzwODRd5DdG5hlTIAOhO8Q8dpjpHL0QyDzIO/kFT2zhDmoHkiRHDo/RoQYIm
	0O3MdQKGaFTyGgYwDYQAHztvSNLy5c5jMIfoFN8eGvmTKpr1v4FMFwgGNpgh8bGpjG7XdY
	hEMvjEyiQ5r+vQ5ivYaEk56zWSbddEEo+GxtHi/qldMvIcO2Z6fRFLuaSaCC3BN6FnuGB6
	MPWvu4Gel3+sHQ/diFCZLTfqDlI5pDQz8giAqEBJNLqu8y+OA8Pi6sBeuznHw4FCV2bM14
	KQWOMsWL77GkIcvzspGWvveamYg36IzUCr3U1cGFnUTvwzoWfLkuoC2qRcxukA==
ARC-Authentication-Results: i=1;
	rspamd-6fbd58c58b-w75sr;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Irritate-Reign: 76e2e42052ea090d_1771809351010_1604037466
X-MC-Loop-Signature: 1771809351010:1092579335
X-MC-Ingress-Time: 1771809351008
Received: from pdx1-sub0-mail-a220.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.106.196.237 (trex/7.1.3);
	Mon, 23 Feb 2026 01:15:51 +0000
Received: from [192.168.14.155] (unknown [209.81.127.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: rob@landley.net)
	by pdx1-sub0-mail-a220.dreamhost.com (Postfix) with ESMTPSA id 4fK2wj5tGwzSH;
	Sun, 22 Feb 2026 17:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
	s=dreamhost; t=1771809350;
	bh=3nv7pEazH1QjXd2mYdHZhHpxrx3ZA5FYW4d+2tDCmiQ=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=vZtnMJ+N8NMTPnIkaZZU3a136hChZ78xb25P52LF4mQbflfEREk7p6//gCcHUbe21
	 x2I2FssrGuuREHU4invWfhxuVzckVMU/mbFPWulpnJ9Tx8PqMhcA2mS91eib3vZoEz
	 zV4eltIm5F98h5o5hPh6r4oot88nG0Hqn7K/iCfWVMjuJDBEyDOi38i44bY9uZf9Bj
	 Kccwn4SwmFn7nMN20xKvLV4Gzc/aVr/rFmrZXuyjgqfpj/IYq+m7O18RsNwN1Gy4tu
	 W2cfGlJNwBJ2GP0sLxcH0+R9FlP9N9giMvAEH8P/Ly0OrbVilUqvFu9htYQbjFOn+K
	 SPxyL7HGHCeOg==
Message-ID: <e67898f6-4e33-428b-8498-b8b28f817bd9@landley.net>
Date: Sun, 22 Feb 2026 19:15:49 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] init: ensure that /dev/null is (nearly) always
 available in initramfs
To: Askar Safin <safinaskar@gmail.com>, linux-fsdevel@vger.kernel.org,
 Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, initramfs@vger.kernel.org,
 David Disseldorp <ddiss@suse.de>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nsc@kernel.org>, patches@lists.linux.dev
References: <20260219210312.3468980-1-safinaskar@gmail.com>
 <20260219210312.3468980-3-safinaskar@gmail.com>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <20260219210312.3468980-3-safinaskar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[landley.net:s=dreamhost];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77899-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[landley.net];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kernel.org,zeniv.linux.org.uk,suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[landley.net:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[landley.net:mid,landley.net:url,landley.net:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iu.edu:url];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rob@landley.net,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AAB3A1714FD
X-Rspamd-Action: no action

On 2/19/26 15:03, Askar Safin wrote:
> Binaries linked with bionic libc require /dev/null to be present,

Elliott fixed that one back in 2021:

http://lists.landley.net/pipermail/toybox-landley.net/2021-October/028766.html

https://android-review.googlesource.com/c/platform/bionic/+/1869594

Are you saying it's reoccurred, or that you plan to run a 5 year old 
userspace with a current kernel?

> otherwise they will crash before entering "main", as explained
> in https://landley.net/toybox/faq.html#cross3 .

Oops, my documentation is out of date. Sorry. Added to the todo heap.

(Although I can't say I've regression tested an init task statically 
linked against bionic launching itself in an empty chroot recently 
either. last I checked I still hadn't convinced the android guys to use 
initramfs at all, and then they had those 12k layoffs (apparently 
copying twitter's mass layoffs) and I largely gave up on the idea of 
turning Android into a self-hosting development environment any time soon.)

> So we should put /dev/null to initramfs, but this is impossible
> if we create initramfs using "cpio" and we are running as normal
> user.

You could just automount devtmpfs using the existing plumbing (and 
touching far fewer files, and having common behavior between the static 
and initrd loader codepaths).

I've been using this trick since 2015:

https://landley.net/notes-2015.html#01-01-2015

And first submitted it to linux-kernel in 2016:

https://lkml.org/lkml/2016/6/22/686

And resubmitted a half-dozen times since then. I linked to my most 
recent one (tested against 6.17) last message, it's generally at 
https://landley.net/bin/mkroot/latest/linux-patches/

Debian had a bug back in something like 2017 (when its initramfs 
script's attempt to mount devtmpfs on /dev failed -- because it was 
already there -- the untested error path would rm -rf everything) but 
they said they were fixing it ~8 years ago, so...

I added workarounds to my reposts for a while (so new kernels could work 
with old debians):

https://lkml.org/lkml/2020/5/14/1584

I don't remember if there's a newer post to this list than 
https://lkml.iu.edu/2201.2/00174.html but nobody else ever seemed to 
care. Oh well. I've posted new ones on my website every mkroot release, 
regression tested against the then-current kernel.

It would be great if I didn't have to worry about 
https://github.com/landley/toybox/commit/0b2d5c2bb3f1 again, but special 
case code instead of using an existing generic mechanism? Eh, I suppose 
that _is_ the modern Linux way...

Rob

