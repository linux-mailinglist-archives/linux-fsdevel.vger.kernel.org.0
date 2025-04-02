Return-Path: <linux-fsdevel+bounces-45489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF43A7875A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 06:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 747BD7A3575
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 04:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E77230BF3;
	Wed,  2 Apr 2025 04:43:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFB42F4A;
	Wed,  2 Apr 2025 04:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743569021; cv=none; b=JdQG81JZQX/teY37a5N0qfswEsz6MVREZbG4I5GMVywV5ean6EIPsjZ8GtM3b8QjIq4TP1ihAq9snPPyjofR1aQRsd+Vau6KZIYCzWfiBzEmwEF8VNI28Pfv7TFY+YLWZA3tasBJDsdKpB11QpDPy/6HoD3kGgcVl1lStFD4f5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743569021; c=relaxed/simple;
	bh=uz9b61nKBl2wacNaAk7DwWcKhDzagZRIJ5Ms1Nts/+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=U6/EIl4EQ5Fd2jv9yCBA4cO1a/QWytlaJVQT+eKqbfkAnrf65v7HFTgYSMbY2fq9LVigpSpBs52G9EL/p8hHRT9wYDKMLkDbFVdW1BXgNaSvfr93uN6Lh+2QOxW6i+5K2OKZczsZnJfhCS11PM9TECNfALCiz/Ra+v0v3edndhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZSBzk4kLmztRLS;
	Wed,  2 Apr 2025 12:42:10 +0800 (CST)
Received: from kwepemg500010.china.huawei.com (unknown [7.202.181.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D46661800B4;
	Wed,  2 Apr 2025 12:43:35 +0800 (CST)
Received: from [10.174.178.209] (10.174.178.209) by
 kwepemg500010.china.huawei.com (7.202.181.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 2 Apr 2025 12:43:34 +0800
Message-ID: <15d52659-5a86-4601-be20-4662cac76c60@huawei.com>
Date: Wed, 2 Apr 2025 12:43:34 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: [PATCH][SMB3 client] fix TCP timers deadlock after rmmod
To: Kuniyuki Iwashima <kuniyu@amazon.com>
CC: <edumazet@google.com>, <ematsumiya@suse.de>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <smfrench@gmail.com>, <zhangchangzhong@huawei.com>
References: <20250401202810.81863-1-kuniyu@amazon.com>
 <20250402005841.19846-1-kuniyu@amazon.com>
From: Wang Zhaolong <wangzhaolong1@huawei.com>
In-Reply-To: <20250402005841.19846-1-kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg500010.china.huawei.com (7.202.181.71)

Hi.

sorry for the late response.

I tested this patch below and it works fine.

Best Regards,
Wang Zhaolong

> 
> I verified the patch below fixed the null-ptr-deref in lockdep by
> preventing cifs from being unloaded while TCP sockets are alive.
> 
> I'll post this officialy, and once this is merged and pulled into
> the cifs tree, I'll send a revert of e9f2517a3e18.
> 
> ---8<---
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 8daf1b3b12c6..e6515ef9116a 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -547,6 +547,10 @@ struct sock {
>   	struct rcu_head		sk_rcu;
>   	netns_tracker		ns_tracker;
>   	struct xarray		sk_user_frags;
> +
> +#if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
> +	struct module		*sk_owner;
> +#endif
>   };
>   
>   struct sock_bh_locked {
> @@ -1583,6 +1587,16 @@ static inline void sk_mem_uncharge(struct sock *sk, int size)
>   	sk_mem_reclaim(sk);
>   }
>   
> +#if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
> +static inline void sk_set_owner(struct sock *sk, struct module *owner)
> +{
> +	__module_get(owner);
> +	sk->sk_owner = owner;
> +}
> +#else
> +#define sk_set_owner(sk, owner)
> +#endif
> +
>   /*
>    * Macro so as to not evaluate some arguments when
>    * lockdep is not enabled.
> @@ -1592,6 +1606,7 @@ static inline void sk_mem_uncharge(struct sock *sk, int size)
>    */
>   #define sock_lock_init_class_and_name(sk, sname, skey, name, key)	\
>   do {									\
> +	sk_set_owner(sk, THIS_MODULE);					\
>   	sk->sk_lock.owned = 0;						\
>   	init_waitqueue_head(&sk->sk_lock.wq);				\
>   	spin_lock_init(&(sk)->sk_lock.slock);				\
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 323892066def..b54f12faad1c 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2324,6 +2324,12 @@ static void __sk_destruct(struct rcu_head *head)
>   		__netns_tracker_free(net, &sk->ns_tracker, false);
>   		net_passive_dec(net);
>   	}
> +
> +#if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
> +	if (sk->sk_owner)
> +		module_put(sk->sk_owner);
> +#endif
> +
>   	sk_prot_free(sk->sk_prot_creator, sk);
>   }
>   
> ---8<---
> 


