Return-Path: <linux-fsdevel+bounces-17438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 881998AD5BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 22:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2609C1F21A73
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 20:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF658155725;
	Mon, 22 Apr 2024 20:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="aTzO+K0y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward502c.mail.yandex.net (forward502c.mail.yandex.net [178.154.239.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED70315380B;
	Mon, 22 Apr 2024 20:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713817147; cv=none; b=E5EsyKikvysvUDOHXeppyHku6oDa+UScs9LnAKCtnDWrIFCqvLRarIVGsEDv4bIjEnzUz6PB3Bfowj8penSjOod5+ntVLU5Xh7hHmHW/v8zD2W/eMXTH9F9HqFR37S4VOvwng8GVUwSzptLMrVRvlIJBeK7YxO3e9NHX+CAinnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713817147; c=relaxed/simple;
	bh=F1mNmWXaUViPOcI3rhPMLRbySTqw2L7HBr5ZyZBfc28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WaJ5Qk29nUboiBTJfJBuIpnqgSalJOONrTOCjrhrzplZRc8BtslUJAC27OKaQ/zpTActlsurptIljmHDRvMIS+WvXslkXpCy/+FAqOXDpZ1camJE7wBy9ZKQUV1yr+1gULrE0prJRoLMz7NMGP9FRkD38F1szfbi1pWQCNGt4MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=aTzO+K0y; arc=none smtp.client-ip=178.154.239.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1a14:0:640:8120:0])
	by forward502c.mail.yandex.net (Yandex) with ESMTPS id C661360FB7;
	Mon, 22 Apr 2024 23:18:55 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id rIQbX18oBGk0-arB2myDQ;
	Mon, 22 Apr 2024 23:18:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1713817134; bh=HDviXqLc5+bKGGY93odn/n8dV5Y9Ee3imq7rHYSlhCc=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=aTzO+K0yVNw9Br3tyYBmqgSmifd+pO3NGxMZGia1hJr1G7Z9NEJh0F+2TES5Xv47p
	 gIKMyHtU7Y8ZcqLXLJoplv/wGNjHiN//nGOBKLfkXMrbal1FYpywvydwCHLNuTJQEd
	 vTQj9Z740ANV2IhX0CBPcdNcXzYlerYM+x1y408g=
Authentication-Results: mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <8cb28ed5-b094-4b80-9373-40f93323250e@yandex.ru>
Date: Mon, 22 Apr 2024 23:18:52 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] openat2: add OA2_INHERIT_CRED flag
Content-Language: en-US
To: Stefan Metzmacher <metze@samba.org>, linux-kernel@vger.kernel.org
Cc: Eric Biederman <ebiederm@xmission.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Alexander Aring <alex.aring@gmail.com>, linux-fsdevel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
 Jens Axboe <axboe@kernel.dk>
References: <20240422084505.3465238-1-stsp2@yandex.ru>
 <20240422084505.3465238-2-stsp2@yandex.ru>
 <81ab6c6a-0a9e-4f2f-b455-7585283acf53@samba.org>
From: stsp <stsp2@yandex.ru>
In-Reply-To: <81ab6c6a-0a9e-4f2f-b455-7585283acf53@samba.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

22.04.2024 22:53, Stefan Metzmacher пишет:
> I'm wondering if it would be better to capture the whole cred structure.
>
> Similar to io_register_personality(), which uses get_current_cred().
>
> Only using uid and gid, won't reflect any group memberships or 
> capabilities...
Hmm, I thought about that, but was
under an impression that with get_current_cred()
you only increment a refcount.
But I guess the trick here is that due
to an RCU machinery, you can actually
get your local copy if someone else
changes it?

I'll try what you say, thanks.

