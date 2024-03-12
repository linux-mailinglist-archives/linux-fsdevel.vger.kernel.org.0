Return-Path: <linux-fsdevel+bounces-14217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4540D8797E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 16:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F050E28315E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 15:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709987C6F0;
	Tue, 12 Mar 2024 15:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="bu9t8r5i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward501c.mail.yandex.net (forward501c.mail.yandex.net [178.154.239.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68877C6E5
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Mar 2024 15:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710258369; cv=none; b=PlpqxKWGV68wOj3V7PK6+1gJx5dqyNOUdTNO9QdJBdtvPEtOspFWNd+aRHtlRZ1dCbWEkp/kOQD9UevABQKCdgVgQBMO1cUx+A2CJ5sQh4MWP0q7rNmod5KX/McQuAloy2IWVvPFGxdtWHAuVPQjU70R8GxGd9wqZtUawuBvW/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710258369; c=relaxed/simple;
	bh=QKTFfwMBtA+yfdfxXTemh8OiwmSKM+kvpNhX7XWjrd0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=FmYepLm3/pvS+GEBYzHZYlBiELVxBXvvupdnDmo+qUhqSa5xTlBYUzKJRUAdK31vctgvq2gowMqe6iCPC1mhnsXEyKPTgBGRjDQeyy6Fe4D5XIAtzUXywpRtadDEW/lzbdNaLWiSLCUoEckxepp8SRxRGIHfYhob4zsSXTCfwuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=bu9t8r5i; arc=none smtp.client-ip=178.154.239.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:5199:0:640:a94b:0])
	by forward501c.mail.yandex.net (Yandex) with ESMTPS id E409B60F5C
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Mar 2024 18:45:04 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 3jollLC7QSw0-ANzKcxQz;
	Tue, 12 Mar 2024 18:45:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1710258304; bh=uK7Y6pBClWQZdxMt6cgB8tVmqMM8GZLy9f27TrarrBY=;
	h=To:Subject:From:Date:Message-ID;
	b=bu9t8r5itZAxvDs/FCwUnT6KPaJlzwsElazfzZvLSwHHQuq5UGCXBAUfsta4jJzWH
	 /bAZ0BB+Ax/T8kBKzyNln7BlrJ6U95VfoY/qfBjSr2TqrmEbETpscUp/svyt7i3jCr
	 yZsveLlRiNkKfX+lTjrfO6ZxPl4QewA3jjo8Awb4=
Authentication-Results: mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <01b28ef6-10f6-4701-8eda-6f0ff0664ce1@yandex.ru>
Date: Tue, 12 Mar 2024 18:45:03 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Ivan Trofimov <i.trofimow@yandex.ru>
Subject: [QUESTION] epoll: try to reuse allocations of epitem
To: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi! A complete newbie here, hope this is not a straight out nonsense.

For every successful epoll_ctl(EPOLL_CTL_ADD/EPOLL_CTL_DEL) kernel 
allocates/de-allocates the corresponding epitem.
In a presumably widespread case (libev even has a trick to optimize this 
exact case) of level-triggered behavior and a epoll_ctl(DEL) + 
epoll_ctl(ADD) dance per read cycle this leads to tossing epitem back 
and forth to the slab cache allocator.
In my completely synthetic user-space benchmark of just doing 
epoll_ctl(ADD) + epoll_ctl(DEL) in a loop these [de]allocations are 
responsible for 25% of CPU time.

What if instead of unconditionally [de]allocating an epitem, we try to 
reuse its memory by preserving a single "up for grabs" epitem in the 
eventpoll struct, which epoll_ctl(ADD) would try to acquire and 
epoll_ctl(DEL) would update? A single-item cache before the allocator, 
if you will.

I see (and I might be missing A LOT) the following pros/cons:
Pros:
   * allocations reduced by a varying percentage, from 0% to 100%, 
depending on the usage.
Cons:
   * sizeof(epitem) + sizeof(epitem*) memory overhead per epoll instance
   * a slight code complication
   * we lose whatever locality the allocator gives

Does this make any sense, and if so do the pros outweigh the cons?

