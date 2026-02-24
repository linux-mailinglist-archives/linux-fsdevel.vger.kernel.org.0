Return-Path: <linux-fsdevel+bounces-78296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGGLI4b2nWlzSwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 20:05:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FE618BA89
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 20:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A07D030A5418
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 19:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD302EB5A1;
	Tue, 24 Feb 2026 19:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b="ZlK/Uv01"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from siberian.tulip.relay.mailchannels.net (siberian.tulip.relay.mailchannels.net [23.83.218.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923B11D5170;
	Tue, 24 Feb 2026 19:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.246
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771959773; cv=pass; b=XpyqOJLJWmT01efYL7StfDCyKvS33fzJ8jxW8fLDUDjmbBzsU9kBaHT+Vsn1b8Yr3jBn4vHnGTAwz8ChutrPig/OJ/Glf9azhaiZ6EBMNWr9ZAPtSnflhjX5xfqeNNaeUCGfJKopuFN6h146AHDtBSoN77NPdAh1tuLjLv3Mcf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771959773; c=relaxed/simple;
	bh=Jr/PDVnNKvKlpq+USPz3dMI/D1o2FqG9PRfJXdMbzxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PNKb33NAL5409R7xjIQ7Dp/+0s2WY4bCBTUfAUzKDK26ToUUZaIiuDE7PDVC0JxI06Hti29LBPJYST/CQi6ZJ5dPgAOzSfC+Hs/GE/F2LN4r7zanGpudlZaqrVKNHjIXomnKp873Mz+Z7/dy3RurZuY8p2iSunzmpGXHj/erTT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=pass smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b=ZlK/Uv01; arc=pass smtp.client-ip=23.83.218.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id C9EE6181FB5;
	Tue, 24 Feb 2026 19:02:47 +0000 (UTC)
Received: from pdx1-sub0-mail-a209.dreamhost.com (100-99-12-80.trex-nlb.outbound.svc.cluster.local [100.99.12.80])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 468A218277C;
	Tue, 24 Feb 2026 19:02:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1771959767;
	b=pvB/qBHCxCT0aHmBMwVI5e+2bMlJq8Cj+GFdb+Sox00GZWxo5WXxg+DhMdvEQGGAwviO2/
	Q+PxTOLTcm5iM5iw+FAz+JpT14a0XQdwGRxsry+6TOERxrwrCredRnM70ZOmHqermKw/pk
	KLyPHjCmVaBs/TbhTsmyq8NXgu9fXRSI+PH8MsLr8ykhi+57Eoe/f/wt3+wWq723G/W6pJ
	WiiCSyzF+ov17/F1PYHyHAzilQBTY9/1GtJbFuhB6C2YjEyoLYLDrzI8DmWmBWSB1Nad7+
	9n1rvsee4KUhrNX1tHyyKggC1sFcrVr178CzTkJZqWItIzI8Qoi4cGfbqgvnBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1771959767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=BKJGCewKEjcg+ipjOOUMSQ1gSJ8lDiWlCzg0lPxp+p8=;
	b=bJQjHP5OPsK78libaOkE8diCp0+pfQ1K0djQ3GdAQQPTDPPXNV48+h/ZxdoB+H0c8pA6QU
	uqloVPhDfsxBhwZOZ97iyKZGzCr6tjRTMqRMwR7B/4DM774XhKAoHQeIJG60a4bkKJ/pXe
	ms49778XHbWt0KHRwuQcBtCEiofzoBdzzUlDcn/DZQ7B3fgh+S2s6gSR48q6Yi8l8BHPSn
	SuKK3xijAApfyEW1Wdi9pR7yurwRST8hOG8dtoERHqqQkk8PUEN6hY1YnbPmzae4DWBJDJ
	ZBpIF84pNoooSxRInfrwtsNmlfjy5krcuP4Dxw80YZHgJ2obEOoj31yudui+bg==
ARC-Authentication-Results: i=1;
	rspamd-7f65b64645-pztnx;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Fearful-Lettuce: 4ec8746d1357a7d7_1771959767655_491962063
X-MC-Loop-Signature: 1771959767655:2667290202
X-MC-Ingress-Time: 1771959767654
Received: from pdx1-sub0-mail-a209.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.12.80 (trex/7.1.3);
	Tue, 24 Feb 2026 19:02:47 +0000
Received: from [192.168.88.6] (unknown [209.81.127.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: rob@landley.net)
	by pdx1-sub0-mail-a209.dreamhost.com (Postfix) with ESMTPSA id 4fL6YK4QY7zTC;
	Tue, 24 Feb 2026 11:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
	s=dreamhost; t=1771959767;
	bh=BKJGCewKEjcg+ipjOOUMSQ1gSJ8lDiWlCzg0lPxp+p8=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=ZlK/Uv01G4CStwmTz++hMmyuEPPue6aqD3QQmJmKX61oV8Mc1a91AZfjp8H1Ro7dq
	 0xU54vLor8XgZzFwEGghruMb0kbafUwQgai7nlI4muNOgg7OephR/snaicxNn/0LMY
	 3b4Nvo0brV2P9bgfO6jNno/UJO7tARXrIjdyilRLWHWAu/ovsXRNZZFaxEkAOvbt4A
	 py0RuSV1BsL2/o7bMkRIvvwgnC7/9M/NHf6yN0YKqEEr+yGaEEwpMLrQn7tB4klxqH
	 oMHi33bHek9jPgWCsGrs9g3Ty7GW0EptpcXDkzGP3Hnt5MmcMcSZ9m0+jgGVbTAUnw
	 45uzkY8a0rfIQ==
Message-ID: <bd45c86c-e1ea-4995-bb00-df83cc873105@landley.net>
Date: Tue, 24 Feb 2026 13:02:44 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] init: ensure that /dev/console and /dev/null are
 (nearly) always available in initramfs
To: Askar Safin <safinaskar@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, initramfs@vger.kernel.org,
 David Disseldorp <ddiss@suse.de>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nsc@kernel.org>, patches@lists.linux.dev
References: <20260219210312.3468980-1-safinaskar@gmail.com>
 <a7cb199d-928d-4158-8f16-db7ae5309082@landley.net>
 <CAPnZJGAw9o8BetWs_wO2B6YD7mYuOopP0CwD=KCfOJXw2QU4Gg@mail.gmail.com>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <CAPnZJGAw9o8BetWs_wO2B6YD7mYuOopP0CwD=KCfOJXw2QU4Gg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[landley.net:s=dreamhost];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78296-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[landley.net];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[landley.net:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[landley.net:mid,landley.net:dkim,landley.net:url,landley.net:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rob@landley.net,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E5FE618BA89
X-Rspamd-Action: no action

On 2/23/26 14:58, Askar Safin wrote:
> On Mon, Feb 23, 2026 at 3:17 AM Rob Landley <rob@landley.net> wrote:
>> FYI I've been using (and occasionally posting) variants of
>> https://landley.net/bin/mkroot/0.8.13/linux-patches/0003-Wire-up-CONFIG_DEVTMPFS_MOUNT-to-initramfs.patch
>> since 2017.
> 
> drivers/base/Kconfig says on CONFIG_DEVTMPFS_MOUNT:
>> This option does not affect initramfs based booting
> 
> So CONFIG_DEVTMPFS_MOUNT works as documented.

I.E. they added that instead of merging any of my patches. Doubling down 
on "initramfs isn't a REAL root filesystem"...

*shrug*

> (But I am not against your CONFIG_DEVTMPFS_MOUNT approach
> if it helps you fix your problem.)

Oh I've been patching it locally for years. I'm only replying because I 
was cc'd.

Rob

