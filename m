Return-Path: <linux-fsdevel+bounces-14727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1954687E689
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 10:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9AE7281048
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 09:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D28F2D03D;
	Mon, 18 Mar 2024 09:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="i6wGUz12"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [178.154.239.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40232C1B6
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Mar 2024 09:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710755888; cv=none; b=QQcB1L/lc+WsqqlF5t8cZZuBil34pwCTYk+5NHRlBGRy506e7/JqyxP2x6PvfDpq/RoHcngoNMV0rBu1lMLbAMiRpQDJfLkY7sagF1L+o081sFDcy6nJOU1r6cpzYEppalObyvd2XNpCagW3HIlmjiQdAWAzjOtL/cQoKomQgMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710755888; c=relaxed/simple;
	bh=spU6HUf+UJvvn9Bx9ek6JyAdcdb6DV/Ki7Cb4wy2pBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ir40HuZWWERZi8dK8/3s6u8kC2CvFmI1vp/OfiVZPL6vliu2pWRU24D47HbKMNtf2mS3Yx6WQKyQuwYpIWlD5quwrTNJKbgehwodBrzlOGOK78D1baocRr7raKcJDiUPLKZSbELnfTcrL8IvG9cGeBiJYpp6rynz9W1yg+FZuMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=i6wGUz12; arc=none smtp.client-ip=178.154.239.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:2214:0:640:d6b5:0])
	by forward501b.mail.yandex.net (Yandex) with ESMTPS id E257C60F85;
	Mon, 18 Mar 2024 12:57:56 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id tv9T9GMe7uQ0-9U6WC3EY;
	Mon, 18 Mar 2024 12:57:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1710755876; bh=AhGUZt8Xh5SsT/zD3ei3IbfHTtQwspQ0IiLuvfXqygg=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=i6wGUz125lgk15nDuJqfDbDdk1WdriMCvDAOy0kMpA7rZdGdkpnr4UdWuaVH6cYbw
	 W5iZzfRT80zS4M16Kj1PNg6LjvOBPGdOaJgiMUxs7ZiYI65MhaxwzpPq1ZvfWBuk34
	 vxh7AqbeU6ANBGsZcpzl7azxfGeRawKvOgJ7xWbk=
Authentication-Results: mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <fc8906c7-66ec-4a20-af5d-22447f317763@yandex.ru>
Date: Mon, 18 Mar 2024 12:57:55 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] eventpoll: optimize epoll_ctl by reusing eppoll_entry
 allocations
Content-Language: en-US
To: Eric Biggers <ebiggers@kernel.org>
Cc: brauner@kernel.org, linux-fsdevel@vger.kernel.org
References: <20240317222004.76084-1-i.trofimow@yandex.ru>
 <20240318045903.GA63337@sol.localdomain>
From: Ivan Trofimov <i.trofimow@yandex.ru>
In-Reply-To: <20240318045903.GA63337@sol.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

 >> +/*
 >> + * This functions either consumes the pwq_slot, or allocates a new
 >
 > "This function"
Thanks, will fix.

 >> +	if (ep->pwq_slot)
 >> +		kmem_cache_free(pwq_cache, ep->pwq_slot);
 >
 > A NULL check isn't necessary before kmem_cache_free().
Thanks, noted, will fix.

 >> @@ -1384,7 +1419,7 @@ static void ep_ptable_queue_proc(struct file 
*file, wait_queue_head_t *whead,
 >>   	if (unlikely(!epi))	// an earlier allocation has failed
 >>   		return;
 >>
 >> -	pwq = kmem_cache_alloc(pwq_cache, GFP_KERNEL);
 >> +	pwq = ep_alloc_pwq(epi->ep);
 >
 > What guarantees that ep->mtx is held here?
The "ep_ptable_queue_proc" is invoked as a poll callback when
"ep_insert" attaches the item added to the poll hooks,
"ep_insert" is called with the "ep->mtx" held.

