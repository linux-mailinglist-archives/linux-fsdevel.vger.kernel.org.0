Return-Path: <linux-fsdevel+bounces-77997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLGoMZeunGmYJwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 20:46:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC4E17C805
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 20:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F1FE30A9AA2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 19:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E654537418F;
	Mon, 23 Feb 2026 19:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b="XY1m8g4/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from hamster.birch.relay.mailchannels.net (hamster.birch.relay.mailchannels.net [23.83.209.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACB919CD1B;
	Mon, 23 Feb 2026 19:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771875941; cv=pass; b=cOHfh8/qsuem0WGTdLrtlNUD340UqnXWGDKg1X/zdDAAVV1RgdPaiZ31d9SPkDwvGPPpOdazblDQrcQRmgFDZuLlBpJbPBF3laC/By3yCL/90tTzuckzR06or/HP4LEnNn3h52l+qIGtYPKk5aNwqhviKK6TcF8oe6YdF5bmUyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771875941; c=relaxed/simple;
	bh=kOpRYhHICy8M4SINTpbmzOgXn90nTxRGVtaM2dJPMms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bLeCRlZH5GrW2c3cSn0DXrsy4d+7pd8OVdryx3jI1i0D6nvG0qRMSLMljXMEBV2D26o2taOz/QYLwTABCYLoHQAX3yR0SgwDrrI4hXgvxUIgm9sUVEsbIiAkkfwbis9SZjAohxS3PQxHoCjUT1qWkQOWmFuOB4O/DsXDrmPK4jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=pass smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b=XY1m8g4/; arc=pass smtp.client-ip=23.83.209.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 566F1782A22;
	Mon, 23 Feb 2026 19:45:33 +0000 (UTC)
Received: from pdx1-sub0-mail-a220.dreamhost.com (trex-green-0.trex.outbound.svc.cluster.local [100.97.23.125])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id A95BE78268C;
	Mon, 23 Feb 2026 19:45:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1771875930;
	b=HS5BrAtCEc9sQVMENjEq5WJsoLSU3vyiM4PMStZ0Utnr8A+oyp/BqCE3XoQDSYnuDkoegI
	iLN/wlLpRUhR+88Ub7PL7JUw3lEK51p0ozxaigfCpevNwUcdWsfJdONyFWJrLAtePbDJQ7
	IUJQUsNsIvqpOvpeJA1iGkDp0FJOx88GwkZycSWozOBvB6BioUfvwuUekNU7ESotGGGL8x
	Y5TNdVbRYN9t8Oc7dwji+W/gXj9In85xuEt0xj6IQ4Z9mQNhAI+77Qjye97x/307dOKqSY
	hoYSEazgD3wo53v4LjK1h8IvkvCkZN9dflik2QMdNWosBZI8ZH2B2Q7yvTuOaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1771875930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=wP25vflJhT12hSbFEFhoEPhTLE25qhuBvB1ca50gT0Y=;
	b=O1SjRmuSoyyubokfLY8RlZneLPRlPtiPe5md2mFzL/iLoV3MGdOqkUBkiTgkz5YwUfSzr4
	l/ckiAXiCCzZZVLMljhUryHQzQ03zkARhhKOMiDEWv28/RRhTiiteiLUdTlboMGE3w3hEZ
	u4yE776biH5EYubatmsOfYYxlX3szNYCwS/JHCq1UpQt8sTJ0JBrKFc8/D7sM8y8L83gwl
	yd9F3GEB5ac5MxSNJ6BIKHg0GjHX4PfGTBKrxmRd9fkDBydEDzEssXj5dlbPWW/V5htVt3
	Fwy5YFdBUHxrm1BH/6lEMNrdWaaXf7GzYK0qNHg7laCAkg8DEU3nMPLMPKFzQg==
ARC-Authentication-Results: i=1;
	rspamd-7f65b64645-qcchb;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Drop-Reaction: 4b431d3e42cdc168_1771875933028_3808452060
X-MC-Loop-Signature: 1771875933028:597152274
X-MC-Ingress-Time: 1771875933027
Received: from pdx1-sub0-mail-a220.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.97.23.125 (trex/7.1.3);
	Mon, 23 Feb 2026 19:45:33 +0000
Received: from [IPV6:2607:fb90:9a14:8897:ebb1:ed79:f171:374e] (unknown [172.58.13.16])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	(Authenticated sender: rob@landley.net)
	by pdx1-sub0-mail-a220.dreamhost.com (Postfix) with ESMTPSA id 4fKWY52WL0zT0;
	Mon, 23 Feb 2026 11:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
	s=dreamhost; t=1771875930;
	bh=wP25vflJhT12hSbFEFhoEPhTLE25qhuBvB1ca50gT0Y=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=XY1m8g4/QBg4E6ewMEcQ8V1Tjeut+kdxCsuE7nMtxPHcm7ZqvuMPg/LrJ6sA76CGq
	 +qImaZdzYY3mhA6dv2J6crcasv2ctHij1gsgBU4Ak415BNn9sDTWPm97RlO2XVGu1K
	 7470VXh/i+51E/9aBbD5hjCBErklyDCM1REnzB833ydfZt7K11OXkbAhkceQrxssvr
	 80HIANGhLOKPb7nv1tQUPaHAX8ljV7HL1hzwJFhyhmvt3Jzr3D2T7DzbvirpwNOq6b
	 0W6OOBTopIDqQcQ6AgNd44u4m40icwLs0ZT5P2Sz136ZirdAssvaNVZJvH2YrGlnqP
	 u2QhLfQuRCW5A==
Message-ID: <258dbf49-c034-4e5d-b912-5723c7a68361@landley.net>
Date: Mon, 23 Feb 2026 13:45:25 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] init: ensure that /dev/console is (nearly) always
 available in initramfs
To: Askar Safin <safinaskar@gmail.com>
Cc: brauner@kernel.org, ddiss@suse.de, initramfs@vger.kernel.org,
 jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, nathan@kernel.org, nsc@kernel.org,
 patches@lists.linux.dev, rdunlap@infradead.org, viro@zeniv.linux.org.uk
References: <7e309fc3-7d55-4e95-8dea-f164a7a96b6c@landley.net>
 <20260223173443.327797-1-safinaskar@gmail.com>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <20260223173443.327797-1-safinaskar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[landley.net:s=dreamhost];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77997-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[landley.net];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[landley.net:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[landley.net:mid,landley.net:dkim,landley.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rob@landley.net,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5EC4E17C805
X-Rspamd-Action: no action

On 2/23/26 11:34, Askar Safin wrote:
> Rob Landley <rob@landley.net>:
>> The real problem isn't cpio, it's that the kernel interface
> 
> So there is some bug here?
> 
> Then, please, describe properly this bug.
> 
> I. e. using usual formula "steps to reproduce - what I got - what I expected to see".

I think that the kernel special case creating files in initramfs is the 
wrong design approach, but it would address the problem and it's what 
the kernel already did in a different codepath.

> Also, does the kernel broke *documented* feature? If indeed some
> *documented* feature doesn't work, then this is indeed very real bug.

Documentation/filesystems/ramfs-rootfs-initramfs.txt section "populating 
initramfs" described using the text file format back in 2005 
(https://github.com/mpe/linux-fullhistory/commit/7f46a240b0a1 line 135) 
and then commit 
https://github.com/mpe/linux-fullhistory/commit/99aef427e206f a year 
later described running usr/gen_init_cpio to create those files from a 
directory to give you an easy starting point to edit.

But I wrote that documentation, so it probably doesn't count.

> I kindly ask you, please, please, describe this bug. I really want
> to help you.
Back when the gen_init_cpio stuff let you create the file and consume 
the file separately so you could edit it in between, there was an easy 
way to address this problem by creating a cpio containing /dev/console 
as a regular user using the kernel plumbing. Then the kernel broke that 
and created a regression, which they decided to fix with special case 
code doing mknod within the kernel before launching PID 1, but only for 
one of two codepaths.

I think adding the special case hack to the other codepath is the wrong 
_WAY_ to fix it... but I guess that ship has sailed. I agree doing that 
can avoid the "init has no stdin/stdout/stderr" problem and thus address 
the issue.

(I still think if you have a CONFIG_DEVTMPFS_MOUNT config symbol, it 
should actually work, but that's a somewhat separate issue and a 
half-dozen patches ignored by linux-kernel for a decade now apparently 
argue otherwise...)

Rob

