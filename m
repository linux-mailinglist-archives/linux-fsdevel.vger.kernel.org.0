Return-Path: <linux-fsdevel+bounces-74912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNkLNac2cWnKfQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 21:27:19 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5855D341
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 21:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 651D8B48088
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 19:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A213D646D;
	Wed, 21 Jan 2026 19:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b="mG/eSTAe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CF0313268;
	Wed, 21 Jan 2026 19:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.248
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769025411; cv=pass; b=a5adMnmPCFt9F7chfvcexBd9qCykHYX0gOTHLAZ/xg770m+A8KUM5POC6Wkon480gszlQJLIjidnPLQ818+I279z5FyQILkOlTdLiHQsB7HHayVhQcBrxWuI718Bc1DMlx6Y5meyk+ieVHZoy74+664++8AExi/CffkFpFjuASI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769025411; c=relaxed/simple;
	bh=Q30qV0GnuH12TLgAndXDOsWAI0eL9/KOxE0R5cfuz+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r7kxNeu+0wEOagvRHLWT7Rb74prXqIO/VUPuDexOGU0mS6ZUPe8aj05AiC8rXls+X/5P43TIjGyoJ7x/XaOsvZv1ccREOPreFlaYNTAF9PuAZd7o+3kCguT+ynJQZXhnas2EodVBpIW+YSYXZfhjmKydqt8dEqa/MwJeJYkFzIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=pass smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b=mG/eSTAe; arc=pass smtp.client-ip=23.83.218.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id CCD4C7E274A;
	Wed, 21 Jan 2026 19:56:42 +0000 (UTC)
Received: from pdx1-sub0-mail-a228.dreamhost.com (100-117-113-78.trex-nlb.outbound.svc.cluster.local [100.117.113.78])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 2082A7E275A;
	Wed, 21 Jan 2026 19:56:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1769025400;
	b=g4Ws2/lWNJ2A9TkCA/DFPucq137ohvtXTgDJHwMpNB4V6ihTQNUi6mlgYIGl5KI34ZYd3K
	mA+BWusN/P7mGgqt73qKgJU+PChgNRvh+rnS8imnNtvU/DYDko4EPYb0uJKr7YGyw/tmzs
	jNfpXeTPDi6vsQCefnsOkJ5HFtFN2rNIfBLB1QzHejHe2sxwFRFHbc01gtAkvyn+im09vQ
	8QA7xqyBNfRSA7cnfe+1wgdoz+BglzODempBqCulFknLX4wUkmgWXjbGAryMLnRg6ylvzo
	2Mr0yidwHlUtGgOAu1R5ylB28U2EUdHx8qSatwOq9msN7aMILZFyiVJlNFXd2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1769025400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=SYZMu2PthwVJ3NGSR06TqeLRyil+RpjVvva3cQ4KSRI=;
	b=n45eUNUoHFSbf7l6rl489dxt6L2ipv09y/tR8rv2uNFF1yd486qFwZmVhoQWGUEgPOi2DA
	GJ4LlxKIOAFMCy697st6EYh6aPLlq1b9Ic/VDDEv1liqI010lG8XkekisqkuoxUiMOwEzu
	QxvslFlwwGeyjg7V5wXObt4X1Y7XEtOm+5QrCiGA94g+ZoifClKMkmz+dfbSq/0YKvDJx7
	IXCv3mdOd/1rTlamcRIMJNZJwyBLT5DqZrGbuLn2+/8r2BJIBmAjrk3yzwTgWXhW0LvfhV
	l19m2JGO4bQ8DV9w52haS87ICwUZO1zQGo75+yscOxlXLV8HA2f1EsEN3YbUbA==
ARC-Authentication-Results: i=1;
	rspamd-7699b4d5f4-fm8jz;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Soft-Slimy: 15dbbe696bd9606d_1769025402703_632742312
X-MC-Loop-Signature: 1769025402703:656845712
X-MC-Ingress-Time: 1769025402702
Received: from pdx1-sub0-mail-a228.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.117.113.78 (trex/7.1.3);
	Wed, 21 Jan 2026 19:56:42 +0000
Received: from [IPV6:2607:fb91:b0b:1231:d681:a3ff:d72d:8f4b] (unknown [172.56.11.215])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	(Authenticated sender: rob@landley.net)
	by pdx1-sub0-mail-a228.dreamhost.com (Postfix) with ESMTPSA id 4dxFM962DgzRn;
	Wed, 21 Jan 2026 11:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
	s=dreamhost; t=1769025399;
	bh=SYZMu2PthwVJ3NGSR06TqeLRyil+RpjVvva3cQ4KSRI=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=mG/eSTAefdXtZR+MXTqdXQEVDjDb7jQF+If/o0u2eUbhAjhjYCmPp2gkf6JlZZVQ1
	 bcJMVxlJRBnybVKuNri33AATAkDqAq3QjTY2MYnWT58EAu1myTQsyMfejHkzY3/W7X
	 7Pc4LefDCj20+uZBfp384KKzq3ain9ep5yp4BhhBDjX0oMJFEUtDwx8drg8zam+QzN
	 g9q8GAmlYSrzAse+eSR1QiBef752u8xCAamfYWhTpNOB47dLMxZqedLYka0UrlZQgw
	 9PB57Fcw4i/UDmBE/Oke5e0iarTKSB7W//+4QPtE3TTRlQkRLvjT5l+gbqg18zAEp6
	 VF7jQckYDNcDA==
Message-ID: <6375f293-709c-41b8-a23d-12010baa3cae@landley.net>
Date: Wed, 21 Jan 2026 13:56:31 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] mount: add OPEN_TREE_NAMESPACE
To: Jeff Layton <jlayton@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
 Askar Safin <safinaskar@gmail.com>
Cc: amir73il@gmail.com, cyphar@cyphar.com, jack@suse.cz,
 josef@toxicpanda.com, linux-fsdevel@vger.kernel.org,
 viro@zeniv.linux.org.uk, Lennart Poettering <mzxreary@0pointer.de>,
 David Howells <dhowells@redhat.com>, Zhang Yunkai <zhang.yunkai@zte.com.cn>,
 cgel.zte@gmail.com, Menglong Dong <menglong8.dong@gmail.com>,
 linux-kernel@vger.kernel.org, initramfs@vger.kernel.org,
 containers@lists.linux.dev, linux-api@vger.kernel.org, news@phoronix.com,
 lwn@lwn.net, Jonathan Corbet <corbet@lwn.net>, emily@redcoat.dev,
 Christoph Hellwig <hch@lst.de>
References: <20251229-work-empty-namespace-v1-0-bfb24c7b061f@kernel.org>
 <20260119171101.3215697-1-safinaskar@gmail.com>
 <CALCETrWs59ss3ZMdTH54p3=E_jiYXq2SWV1fmm+HSvZ1pnBiJw@mail.gmail.com>
 <acb859e1684122e1a73f30115f2389d2c9897251.camel@kernel.org>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <acb859e1684122e1a73f30115f2389d2c9897251.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[landley.net:s=dreamhost];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74912-lists,linux-fsdevel=lfdr.de];
	DMARC_NA(0.00)[landley.net];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,landley.net:dkim,landley.net:mid,landley.net:url];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,amacapital.net,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,cyphar.com,suse.cz,toxicpanda.com,vger.kernel.org,zeniv.linux.org.uk,0pointer.de,redhat.com,zte.com.cn,lists.linux.dev,phoronix.com,lwn.net,redcoat.dev,lst.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rob@landley.net,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[landley.net:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4F5855D341
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>>>> You want rootfs to be a NULLFS instead of ramfs. You don't seem to want it to
>>>> actually _be_ a filesystem. Even with your "fix", containers could communicate
>>>> with each _other_ through it if it becomes accessible. If a container can get
>>>> access to an empty initramfs and write into it, it can ask/answer the question
>>>> "Are there any other containers on this machine running stux24" and then coordinate.

Or you could just make the ROOT= codepath remount the empty initramfs -o 
ro like some switch_root implementations do. If the PID 1 you launch 
isn't in initramfs, don't leave initramfs writeable. That seems unlikely 
to break userspace.

(Having permissions to remount initramfs but _not_ having already 
"cracked root" seems... a bit funky? You have waaaaay more faith in 
security modules than I do...)

>> I think this new OPEN_TREE_NAMESPACE is nifty, but I don't think the
>> path that gives it sensible behavior should be conditional like this.
>> Either make it *always* mount on top of nullfs (regardless of boot
>> options) or find some way to have it actually be the root.  I assume
>> the latter is challenging for some reason.
> 
> I think that's the plan. I suggested the same to Christian last week,
> and he was amenable to removing the option and just always doing a
> nullfs_rootfs mount.

Since 2013, initramfs might be ramfs or tmpfs depending on 
circumstances. Adding a third option for it be nullfs when there's no 
cpio.gz extracted into it seems reasonable. (You can always mount a 
tmpfs _over_ it if you need that later, it's writeable so a PID 1 
launched in it has workspace.)

That said, if you are changing the semantics, right now we switch_root 
from initramfs instead of pivot_root because initramfs couldn't be 
unmounted. With this change would pivot_root become the mechanism for 
initramfs too? (If the cpio.gz recipient wasn't actually rootfs but was 
an overmount the way ROOT= does it.)

Aside: it would be nice if inaccessible mount points could automatically 
be garbage collected. There's already some "lazy umount" plumbing that 
does that when explicitly requested to, but last I checked there were 
cases that didn't get caught. It's been a while though, might already 
have been fixed. Presumably initramfs would always get pinned because 
it's PID 0's / reference...

Also, could you guys make CONFIG_DEVTMPFS_MOUNT work with initramfs? 
I've posted patches for that on and off since 2017, most recent one's 
probably 
https://landley.net/bin/mkroot/0.8.13/linux-patches/0003-Wire-up-CONFIG_DEVTMPFS_MOUNT-to-initramfs.patch 
(tested on a 6.17 kernel).

> We think that older runtimes should still "just work" with this scheme.
> Out of an abundance of caution, we _might_ want a command-line option
> to make it go back to old way, in case we find some userland stuff that
> doesn't like this for some reason, but hopefully we won't even need
> that.

I assume it will break stuff, but I also assume the systems it breaks 
will never upgrade to a 7.x kernel because the kernel itself would 
consume all available memory before launching PID 1.

Rob

