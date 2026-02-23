Return-Path: <linux-fsdevel+bounces-77878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0B3oM4+em2nP3gMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 01:25:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 647DD170ED0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 01:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 38AFC301A2F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 00:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCAC1B4156;
	Mon, 23 Feb 2026 00:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b="KAdio8I+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fennec.ash.relay.mailchannels.net (fennec.ash.relay.mailchannels.net [23.83.222.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0FA3EBF06;
	Mon, 23 Feb 2026 00:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771806345; cv=pass; b=dMi7qmW/O+Pw/oyghpnMV31pLadTsEcRi9TcZn9s+T4ZRDH68EkUpBmW/ljfZ2x7+tY5/hwdRgCvX7Am8lOTrbNk2BZH1JD/Z+QgjN/0iDnvuM11CD4knVAyQhHbd4NkWnvgp+2bWoRl4zlqu4t1Kcugcy3/ajnp7Cy+Z3yO8LA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771806345; c=relaxed/simple;
	bh=vnl3n6hiLRbYTraiOMb+bVU+YKg9dIaxSlm6mpPCZuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kjrGX7uh0eHjOT7SKxRVrb8/s1u5lo9w2y31+qxzazfl0fX8wYNiQ98aEc2wCFCHvtXqnAQzXUgw7dv2ouKWf18APIb+eoIFQWL5uGQD0CN3WY2cl7k+VeOULni5emHX1QYR/OAxf9NFCf/c/J/BU0o/JBQ0BMFdPXqjnTxuS7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=pass smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b=KAdio8I+; arc=pass smtp.client-ip=23.83.222.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id CB9EA78323A;
	Mon, 23 Feb 2026 00:17:06 +0000 (UTC)
Received: from pdx1-sub0-mail-a220.dreamhost.com (100-97-187-78.trex-nlb.outbound.svc.cluster.local [100.97.187.78])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 5F91078320C;
	Mon, 23 Feb 2026 00:17:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1771805826;
	b=nS39JAZZ1x7GEi8kd6hBEb0VddJIjmIN1ih8vqTrOPa3KljmW925tQ/jr4GcJMBeloTIhs
	2kF6rAvjwWm53D80pv1bzQlek8Ta6Ru6m2tsnx2Jw9Aq0pyp+3EA9cyIarJ7KJXFNThDqS
	gHA7adwCWLFiXr/Agcn3YmoVwQqXuODCKAICZ0n9N6aXLrM8UBnH6lZzGw1O+OTYEP+SYO
	tH7dlHcjVVmxCgh+PzmJ3Wh/HWtT4NOmpUn2m2H79CWJlDZPFQzWod1MdMBs6YTs/RjWsb
	+30P2A1y3daOsjUb1QNGD+BF0Oppuze9E00ZDYlj/tHNOEw5i5yL/ApJnEHIRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1771805826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=ejC93Nu7XMWnzidBneVNGHhfI3IKdCvyfDvNoCmZe5o=;
	b=cKGwSgB0vfBiNtu1dFyo1LGfvIgzprANNnIF+iIunOUk4fNzzMDALACUhLTb1jGPBhZJBR
	W2JA5L2C2mTbl93uGWAuQc5GCFDq3bGhEwzIiQ9pnc8Oi/WRHuT0JD/jSkUzI8KXGLvi3+
	K+73V0R8ajEb//hJJqySV2YXrfMY9T355DReIMR+5HOAN+hIUuf3RYPSzno8m7CgwofQOB
	rUcuEOAUKDC/OlrWxrCZHhB19EHB0bvfYNUljUlAZqjFDBs8BNp0J8DlXazYzeqQvAw9mN
	DJk0ELFjp+CzTBMZCpThq47u2x263zzgvkao57C/94UROTEjh/6vxh5/KWhZMA==
ARC-Authentication-Results: i=1;
	rspamd-7f65b64645-s74qj;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Descriptive-Shrill: 1a594b3400788975_1771805826688_2785434387
X-MC-Loop-Signature: 1771805826688:3386891487
X-MC-Ingress-Time: 1771805826686
Received: from pdx1-sub0-mail-a220.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.97.187.78 (trex/7.1.3);
	Mon, 23 Feb 2026 00:17:06 +0000
Received: from [192.168.14.155] (unknown [209.81.127.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: rob@landley.net)
	by pdx1-sub0-mail-a220.dreamhost.com (Postfix) with ESMTPSA id 4fK1cx3K7JzQf;
	Sun, 22 Feb 2026 16:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
	s=dreamhost; t=1771805826;
	bh=ejC93Nu7XMWnzidBneVNGHhfI3IKdCvyfDvNoCmZe5o=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=KAdio8I+4ZC3SZr9noEGXA1dPIra+K58gvG05zU5jOQZkc0RirZwaZxLAoBlCIsR/
	 c/HYyZhksRxOjmA8bw7SkM0NKHnGPwCAim9zuZMkqYdU1Sj4eC2kp9L85o5ZlHDSqE
	 jZd+rhCiIKRWNeoOt3KDAQEWKhY4ojUDOuMVy8pqiF0FRHsChUdb3wGkvguzfQGDEn
	 CGoc96VpC250tJ29hiSWU9d+igRn0BddbJ/5zIcbamM87+zxhnLyoCxQ0w/vee33Sy
	 V1AbEj4Xyuh7ZQv6jJYUVwmxcaO578FIEOrRq8JHSkdkovJct2YP/a9rGJOYfnvoBf
	 sQhnrkDENDYAQ==
Message-ID: <a7cb199d-928d-4158-8f16-db7ae5309082@landley.net>
Date: Sun, 22 Feb 2026 18:17:04 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] init: ensure that /dev/console and /dev/null are
 (nearly) always available in initramfs
To: Askar Safin <safinaskar@gmail.com>, linux-fsdevel@vger.kernel.org,
 Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, initramfs@vger.kernel.org,
 David Disseldorp <ddiss@suse.de>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nsc@kernel.org>, patches@lists.linux.dev
References: <20260219210312.3468980-1-safinaskar@gmail.com>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <20260219210312.3468980-1-safinaskar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[landley.net:s=dreamhost];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77878-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[landley.net];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kernel.org,zeniv.linux.org.uk,suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[landley.net:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,landley.net:mid,landley.net:url,landley.net:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rob@landley.net,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 647DD170ED0
X-Rspamd-Action: no action

On 2/19/26 15:03, Askar Safin wrote:
> This patchset is for VFS.
> 
> See commit messages for motivation and details.

FYI I've been using (and occasionally posting) variants of 
https://landley.net/bin/mkroot/0.8.13/linux-patches/0003-Wire-up-CONFIG_DEVTMPFS_MOUNT-to-initramfs.patch 
since 2017.

What needs /dev/null? I haven't encountered that.

The problem with no /dev/console is init launches with no 
stdin/stdout/stderr (which is what happens for static initramfs made 
with normal user mode cpio, no easy way to insert /dev nodes into the 
filesystem you're archiving up and most cpio tools don't offer an easy 
way to hallucinate nodes). The problem with having no stderr when init 
launches is if anything goes wrong you can't get debug messages.

I have a shell script I run as PID 1 that mounts devtmpfs and then 
redirects stdin/out/err ala 
https://codeberg.org/landley/toybox/src/branch/master/mkroot/mkroot.sh#L111 
but THAT's fiddly because when the shell is opening the file it 
_becomes_ stderr (with the script _itself_ usually having been opened as 
stdin because first available filehandle) so the shell needs plumbing to 
dup2() them up to a high filehandle and close the original one and that 
tends not to get regression tested when anything changes because "we ran 
with no stdin/stdout/stderr is not a common case...

Having the kernel auto-mount devtmpfs (which it already has a config 
option for and all my patch does is make it work for initramfs) fixes 
this, because /dev/console is then available before launching /init.

How is manually editing initramfs _less_ awkward that automounting 
devtmpfs when the config symbol requests it?

Rob

