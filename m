Return-Path: <linux-fsdevel+bounces-76684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJoFBNt2iWlm9gQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 06:55:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0498810BE80
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 06:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6693302335E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 05:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F002D7D2E;
	Mon,  9 Feb 2026 05:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="hAIqYxbU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57D82222B2
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Feb 2026 05:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770616413; cv=none; b=D3HTCKhX3QXIQltvtSIpvkbJYfVmwwl5Iv1WV1f1fiPiuNQYhFW/Bl4vLbgFy9lEWzYKZLDzEhW8vMSTjTAQP20w8hZQ6K9HfMAfosu1dDVcQu4TYllRcTEDRuxpX9SR4t5MmcbGZzLDVdUdsY7/hMvBkopqhIW/fINHi7pOeXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770616413; c=relaxed/simple;
	bh=YSWVGhknRSYN6/8V+ssyrvOe3ckX2Sj+uIo5r1zB7lM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=E+kVG/uTzj54la9TIdo78kvaouxVgHeE08MqIyfF20VlZDI5r7Qh+cXYsOq0rXPozSLqNVdt+4sNO0lQT7Loa6euMiF74HKsEUD3XAzFnEz9tUHu9B6uub7haDTJu96n8vNSseb1ImSQDma3fg9/2GYTwbjBblTEVtMxi4PA8d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=hAIqYxbU; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 6195rKKU2640801
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sun, 8 Feb 2026 21:53:21 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 6195rKKU2640801
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026012301; t=1770616401;
	bh=jJ5YJqHA5U9H2Y5cb9DW/Pvkh+enhGlHyNQCSgVSI5s=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=hAIqYxbUV7YJoxy381sGyLz+mjQqldWGbOSkjgufidkjHlfsD4A09q0SrM4+TFcB5
	 tKWdtZ6myot9RlhrRPYO9ErzxOzr/ewdq0ShPLNNdQ99056+5IXCUIri9SC/RQlBI4
	 YckaIxio6mYoB7s3LSU3ub3TYBcry6EoqjiqYEpI7srp2BbFZ8Xy4aEt4iBMHv6e4L
	 Z9DA8WVheGmfd6VvVHpw6XqwW8X1v1uTJQ8LIB/XIQlEDQER+BmDvnI2zlxAj9Wfna
	 COKrmY3qOpp3IZmoOEBk9nuJiJG+4qdU7L0amEf5cXZyhGSyWOPMZpieVMSwNTbijH
	 GPW27ZvffSkxw==
Date: Sun, 08 Feb 2026 21:53:14 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
CC: linux-fsdevel@vger.kernel.org, Christian Brauner <christian@brauner.io>,
        Jan Kara <jack@suse.cz>, Werner Almesberger <werner@almesberger.net>
Subject: Re: [RFC] pivot_root(2) races
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=whoVEhWbBJK9SiA0XoUbyurn9gN8O0gUAne88a4gXDLyQ@mail.gmail.com>
References: <20260209003437.GF3183987@ZenIV> <CAHk-=whoVEhWbBJK9SiA0XoUbyurn9gN8O0gUAne88a4gXDLyQ@mail.gmail.com>
Message-ID: <17624EFF-F10E-462A-95E4-6E8A1D691DAA@zytor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zytor.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[zytor.com:s=2026012301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76684-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[zytor.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hpa@zytor.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.org.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,zytor.com:mid,zytor.com:dkim]
X-Rspamd-Queue-Id: 0498810BE80
X-Rspamd-Action: no action

On February 8, 2026 9:49:40 PM PST, Linus Torvalds <torvalds@linux-foundati=
on=2Eorg> wrote:
>On Sun, 8 Feb 2026 at 16:32, Al Viro <viro@zeniv=2Elinux=2Eorg=2Euk> wrot=
e:
>>
>>         AFAICS, the original rationale had been about the kernel thread=
s
>> that would otherwise keep the old root busy=2E
>
>I don't think it was even about just kernel threads, it was about the
>fact that pivot_root was done early, but after other user space things
>could have been started=2E
>
>Of course, now it's used much more widely than the original "handle
>initial root switching in user space"
>
>>         Unfortunately, the way it's been done (all the way since the
>> original posting) is racy=2E  If pivot_root() is called while another
>> thread is in the middle of fork(), it will not see the fs_struct of
>> the child to be=2E
>
>I think that what is much more serious than races is the *non*racy behavi=
or=2E
>
>Maybe I'm missing something, but it looks like anybody can just switch
>things around for _other_ namespaces if they have CAP_SYS_ADMIN in
>_their_ namespace=2E It's just using may_mount()", which i sabout the
>permission to modify the locall namespace=2E
>
>I probably am missing something, and just took a very quick look, and
>am missing some check for "only change processes we have permission to
>change"=2E
>
>         Linus

Kernel threads were absolutely the motivation early on=2E pivot_root() its=
elf was expected to be run by the ramdisk pre-init which would then chroot(=
) itself=2E

