Return-Path: <linux-fsdevel+bounces-77902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAV1KV2/m2no5gMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 03:45:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E8117176B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 03:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EC83302E780
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 02:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8449275AE4;
	Mon, 23 Feb 2026 02:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b="lxehg/1E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from chocolate.ash.relay.mailchannels.net (chocolate.ash.relay.mailchannels.net [23.83.222.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EFF20B80B;
	Mon, 23 Feb 2026 02:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771814605; cv=pass; b=dOa99I/hs8kOWOpvb7wxKoP2213gGymsqRckP7k/jh2jiPMVlchrJK3qYNC5twER6xdIfuGGK7fRDAVLBtl5OQ/L2Iu4BvCNvjRHwIvKICXP1MyK4vY2CdoZXCsmLiNgtZO4eHFLaHqZS2EnNzCNrNVuiAw4kh37nLXLnS+/U3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771814605; c=relaxed/simple;
	bh=Fppz4XqbW7vpobAU4JG/17grv29+FYDLFAOpl+bgv4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dsVPtKOzVb//NDNNvI+XNZ+kGcgV9gtfNtAEAhfJ9HeKOjrgiYAzv5Sv3vW9HboPKPXTszWKH+6c9i/TKq+fWMAi9WjVL79O0xI9lt1REfzP2KTm76cPhL8OfzmYLrEIU0u0autDbW8zvNYO+jIccayZ4PVqtj/uG5znHbhEdyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=pass smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b=lxehg/1E; arc=pass smtp.client-ip=23.83.222.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id DB68192273F;
	Mon, 23 Feb 2026 01:27:52 +0000 (UTC)
Received: from pdx1-sub0-mail-a220.dreamhost.com (trex-green-9.trex.outbound.svc.cluster.local [100.99.99.94])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 787B0922749;
	Mon, 23 Feb 2026 01:27:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1771810072;
	b=a4TfLbL+xWkl3FoRGPcvZXNFn3VWLS4RXhDLC1KITO/46AiXKDYcYmRknZqRd2g7nYbZcQ
	k/VTABhhm7Zn3yscxxHTYULAVNJqbUU1PLLoRrBGwoBkiLW+AmN9QqdoQdybP6C4ijX3Bz
	8TcDH3r63d57+soL/dCLrawV8iZId4lfoGr3mkqndFpINTWdkmjfxQI9bPv8tmcOsc5r6B
	GQmo+rDUxyLX0LJvWazS82AksNk6eCbnj8gGGp36g572JivFZmZtkKrIiCJBrpXSgYKfsE
	CriSJ54qiofQ4NqeYdXLr7UhBeVcFia63qopSQGlDjtk4wb2mlAp3YJYTn4NnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1771810072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=b6UUucr5palJUDrml2pz1tY23CzM6eiRyVkxM3xGuAA=;
	b=HdoEr90CECUgiNkWcdKhY9qPiubDCqdcgP93IcgbJ6bGIJdLPT9mTOqQWq9/KGzSPzpPVM
	iz0tjCQiflDqV799rxXYm+1600dMsIr7Xyl+Na/fSq9W505Z04B/zT54hAubOOYfWbh4/q
	n6JCCES3uB+6VvjQSLT8tIQv20Tp+EnOrEzXTpmRMDlq29Jq6kHqaT7InUUvH61nTramUq
	Wvd33wBqNSJ4P0aUQKSC97ZYm1TxBQXr37iJRDUZ36tvJ5Up0T4wxmo6HassoubYHxofDQ
	L5sfUyRfjMUgvVB8kt5AKNb9EXkBTjSsPg8di3bk+AaQyTpc8kqJRHJcLX2ejA==
ARC-Authentication-Results: i=1;
	rspamd-7f65b64645-vf9m5;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Abiding-Exultant: 6f84e5a4203b0a61_1771810072783_2986007946
X-MC-Loop-Signature: 1771810072783:965855009
X-MC-Ingress-Time: 1771810072782
Received: from pdx1-sub0-mail-a220.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.99.94 (trex/7.1.3);
	Mon, 23 Feb 2026 01:27:52 +0000
Received: from [192.168.14.155] (unknown [209.81.127.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	(Authenticated sender: rob@landley.net)
	by pdx1-sub0-mail-a220.dreamhost.com (Postfix) with ESMTPSA id 4fK3Bb49zqzQf;
	Sun, 22 Feb 2026 17:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
	s=dreamhost; t=1771810072;
	bh=b6UUucr5palJUDrml2pz1tY23CzM6eiRyVkxM3xGuAA=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=lxehg/1EVHOBltxoiNS7w5jDgzxv0VeeWXCmyzs3sqvAEWSbnZP7s4pdZmqwScG+8
	 1AxNCRb9pzm2ejZi/cG0jbrXSV9KBgl/p5jA9/PwK9/ZMi2mGm73jyIezlfgp+pmz+
	 XMEdh7Y5/1tgWjG/EF0W2d72DPfNPTiqiXM8qI+23WiZEYzl2OftBprj0AZ4EG8vq3
	 /oLGIG7LBbXeeajFrZgV9mMO7G+1Km9hqMpN+pZK5midNHTVKs3fWrEyan6WbUf+o4
	 CaZxbDbBexTUZ6Gy8q5AQCeVSfp2ZUODULd6qk0tUqNk0ntr896ekvaQYQTGrRW0On
	 mf8Jex8dpsmrA==
Message-ID: <6d34c95a-a2ea-46a4-b491-45e7cb86049b@landley.net>
Date: Sun, 22 Feb 2026 19:27:50 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] init: ensure that /dev/console is (nearly) always
 available in initramfs
To: David Disseldorp <ddiss@suse.de>, Askar Safin <safinaskar@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, initramfs@vger.kernel.org,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 patches@lists.linux.dev
References: <20260219210312.3468980-1-safinaskar@gmail.com>
 <20260219210312.3468980-2-safinaskar@gmail.com>
 <20260220105913.4b62e124.ddiss@suse.de>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <20260220105913.4b62e124.ddiss@suse.de>
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
	TAGGED_FROM(0.00)[bounces-77902-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[landley.net];
	FREEMAIL_TO(0.00)[suse.de,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[landley.net:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,landley.net:mid,landley.net:url,landley.net:dkim];
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
X-Rspamd-Queue-Id: 00E8117176B
X-Rspamd-Action: no action

On 2/19/26 17:59, David Disseldorp wrote:
>> This problem can be solved by using gen_init_cpio.

It used to work, then they broke it. (See below.)

>> But I think that proper solution is to ensure that /dev/console
>> is always available, no matter what. This is quality-of-implementation
>> feature. This will reduce number of possible failure modes. And
>> this will make easier for developers to get early boot right.
>> (Early boot issues are very hard to debug.)
> 
> I'd prefer not to go down this path:
> - I think it's reasonable to expect that users who override the default
>    internal initramfs know what they're doing WRT /dev/console creation.
> - initramfs can be made up of concatenated cpio archives, so tools which
>    insist on using GNU cpio and run into mknod EPERM issues could append
>    the nodes via gen_init_cpio, while continuing to use GNU cpio for
>    everything else.

Who said anything about gnu? Busybox has a cpio, toybox has a cpio... 
once upon a time it was a posix command, removed from the standard for 
the same reason tar was removed, and that was just as widely ignored.

It's an archive format. There are tools that create that archive format 
from a directory.

The kernel itself had a fairly generic one one built-in, which you 
_could_ use to create cpio archives with /dev/console as a regular 
user... until the kernel guys decided to break it. I carried a patch to 
fix that for a little while myself:

https://landley.net/bin/mkroot/0.8.10/linux-patches/0011-gen_init_cpio-regression.patch

But I just got tired of fighting lkml.

> Thanks, David

Rob

