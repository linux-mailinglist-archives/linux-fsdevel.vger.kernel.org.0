Return-Path: <linux-fsdevel+bounces-77986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iP46FjGKnGl8JQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 18:11:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C820817A717
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 18:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2537F302B3A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 17:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A1B329E43;
	Mon, 23 Feb 2026 17:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b="E7yTKFH6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2094B32939C;
	Mon, 23 Feb 2026 17:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771866431; cv=pass; b=uPSwl/3YdX+s2sRDixxIIbtdNfZJBYhEPD4hHQTDmUxWgA6ACyakJgPDuKLQNWcySxt1Q6PwIfKnssThiJ1YXQlIkmCesPFdG4WFWmKdrgYsISUIjTOt7FOvXbtdUjmNBEtaZBUGY4ChDJcrRr+ifXy1W+zylWaIiZ4vvWAAg6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771866431; c=relaxed/simple;
	bh=QmuNg1tBtzwmz+wkhgiXHLezpaCUDOCDyd8P/htnkvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PuyuPB6eaRFsjLx/5JKE8UESFFnafWugjypXOn77c0+dVK1EN4++Y4W8zdpX9yQSX1OhXqm0mhLLi9IB0sQ9rCll5PVmuE/XZN07mSioryMTFQM+utpgoxUw7i5eClWEsTvRJ6nal87R4/+u+IXOLF/yeOWLLaedzBzxZvqchwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=pass smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b=E7yTKFH6; arc=pass smtp.client-ip=23.83.212.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 96639160C57;
	Mon, 23 Feb 2026 16:11:12 +0000 (UTC)
Received: from pdx1-sub0-mail-a229.dreamhost.com (100-103-37-158.trex-nlb.outbound.svc.cluster.local [100.103.37.158])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 13DC4163A9E;
	Mon, 23 Feb 2026 16:11:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1771863070;
	b=D10lQ/C9uKN0awKaoY1DJbyw883z2sXTh1CP2yS9BDRhSH58rsf1CoH5LujX2k7UdyXoBD
	t1bhwmCoGJUp9Vlj46sIobRvYohwXZMku0zgzlMBomVvtklhx9MTfMCq18nqt7BfSfv5sy
	JVyRXMl+RWIB9TE/S+JSDtdPUzvkDAid+ovXQx2YKRnNJmpm5dGpxNqaSlaH32r3Q7Bgj8
	Df91LPvo+OF+8/1j3YKIG3yfMANeWaohaeRJukOVHk0/p9XDuYaSP7vRB736CZPbK9+1uR
	Q5fyNplw8uWgFHsNE6fxqfshimehi1AB1J9EDCVb/DyMbdGOH2nQUoa/y2CAhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1771863070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=XuD6XCjlTOuLfHYtXzVsTlp4WOA/ge30qcw+P5i9Neg=;
	b=J4JKNO/Aq56Qgvep1jBeLGTX0W4LsZYTzravitWIiHbtcBK53abXlKnP3aSwFPPxC8WCdU
	2HKgwjMY25lyHqUUf86/lzeAksAERcKa5INoAEp/MKbQs0d2mcu9Vh7PZdoezJ3mJP05lD
	9YgRxaG/As8lvZTDA3Ry3nd2hF4QVxeimG3XC4CAgaSbTC3J7Y1U6NJowVojfIyx2Ds9Dw
	JldXum/9uH/Pg/DjU6owlT5lDyq1K7rZYtfgNDqXZbFJf3u6vf8yNkQzu+9oPmutrcJdcE
	eMdaySlElaVd84WcD02Igp0Re0WMlbkG4IY++BztF09xTyEHTrW2wno/ZJNfTw==
ARC-Authentication-Results: i=1;
	rspamd-6fbd58c58b-q6pqj;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Glossy-Stupid: 51eb68441b29b606_1771863072406_1607851710
X-MC-Loop-Signature: 1771863072406:3925674246
X-MC-Ingress-Time: 1771863072404
Received: from pdx1-sub0-mail-a229.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.37.158 (trex/7.1.3);
	Mon, 23 Feb 2026 16:11:12 +0000
Received: from [IPV6:2607:fb90:9a0f:889c:175:8594:632c:fd9c] (unknown [172.56.10.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	(Authenticated sender: rob@landley.net)
	by pdx1-sub0-mail-a229.dreamhost.com (Postfix) with ESMTPSA id 4fKQnm4c9Yz6N;
	Mon, 23 Feb 2026 08:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
	s=dreamhost; t=1771863069;
	bh=XuD6XCjlTOuLfHYtXzVsTlp4WOA/ge30qcw+P5i9Neg=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=E7yTKFH61K6Rf3nyxMlL5gJn8Vu7IRd1pAZWYgnNR9pCVRRJUpvhMLFsUk6Xig3sX
	 d6NWEP3DpNrj+DxqHNetE2uHwz9ZJUf/MP/SxA4TNEVqYNX1XyMQxsMbqnOItaYmhx
	 kMG9i8DHBsDuwQZ/6swAy5TFwwx11Zc5Ry3lX1XRq5mq4C6CTDl7cGtAYkgBgq25SO
	 fh7Lt1Up1B6KsjeaobDjAYsrfx59zhVGH+ott0uRMP1JJ71tbhFsbxkxnwXEXqRvlu
	 t7uZaYSEx+P719OVfP3zRy8hYDm/Xq10VI5hBE26ZbFU1tWk0vFK0xtefoKtamHS2O
	 AcHbh4zCO+A7w==
Message-ID: <7e309fc3-7d55-4e95-8dea-f164a7a96b6c@landley.net>
Date: Mon, 23 Feb 2026 10:11:05 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] init: ensure that /dev/console is (nearly) always
 available in initramfs
To: David Disseldorp <ddiss@suse.de>
Cc: Askar Safin <safinaskar@gmail.com>, linux-fsdevel@vger.kernel.org,
 Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, initramfs@vger.kernel.org,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 patches@lists.linux.dev
References: <20260219210312.3468980-1-safinaskar@gmail.com>
 <20260219210312.3468980-2-safinaskar@gmail.com>
 <20260220105913.4b62e124.ddiss@suse.de>
 <6d34c95a-a2ea-46a4-b491-45e7cb86049b@landley.net>
 <20260223133357.0c3b8f8e.ddiss@suse.de>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <20260223133357.0c3b8f8e.ddiss@suse.de>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77986-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,zeniv.linux.org.uk,suse.cz,infradead.org,lists.linux.dev];
	DMARC_NA(0.00)[landley.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[landley.net:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[landley.net:mid,landley.net:url,landley.net:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rob@landley.net,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C820817A717
X-Rspamd-Action: no action

On 2/22/26 20:33, David Disseldorp wrote:
>> It's an archive format. There are tools that create that archive format
>> from a directory.
>>
>> The kernel itself had a fairly generic one one built-in, which you
>> _could_ use to create cpio archives with /dev/console as a regular
>> user... until the kernel guys decided to break it. I carried a patch to
>> fix that for a little while myself:
>>
>> https://landley.net/bin/mkroot/0.8.10/linux-patches/0011-gen_init_cpio-regression.patch
> 
> This seems like a helpful feature to me.

It was, but I want mkroot to at least be _able_ to build with vanilla 
kernels, so couldn't depend on a feature upstream had abandoned.

The real problem isn't cpio, it's that the kernel interface for 
statically linking a cpio into the kernel wants you to point it at a 
directory of files for _it_ to cpio up, and when you do that you need 
root access (or fakeroot) to mknod.

You used to be able to point it at one of those generated files (and 
thus edit the file yourself to add the extra nodes), but that went away 
the same time they broke the rest of the interface.

> Thanks, David

Rob

