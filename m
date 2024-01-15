Return-Path: <linux-fsdevel+bounces-8000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA5682E1D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 21:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9A071F22DDA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 20:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52761AACF;
	Mon, 15 Jan 2024 20:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U3eSg/ik"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0061418635
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 20:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705350703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oo1lY+LUrPGNJa+47ZTljwNXvGKmrXfZHob6MgR5Xqo=;
	b=U3eSg/ik7CFUJWRsVJOsC5xzfnDxmtqc5Dj5dcGbO/BSfOq6U0arVc5cC10Js/x7KTKS/m
	mGAz+I0RTfJrPI7QeiCywykgdxO9t923h5iqyzxEhTE7x8mXUsHZ0iKhVydk5ooS7WpZqi
	GgBeHG1+nkH3DaQ3Kcx8HhrCCUnpgEQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-2PITXVkTMseuWT5bGjy8Dw-1; Mon, 15 Jan 2024 15:31:40 -0500
X-MC-Unique: 2PITXVkTMseuWT5bGjy8Dw-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-429a30f4997so91300501cf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 12:31:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705350699; x=1705955499;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oo1lY+LUrPGNJa+47ZTljwNXvGKmrXfZHob6MgR5Xqo=;
        b=BkYJDkzNAFYXx/rGWCmgu4LNrjqzcN4rKl+zELicbxcQdVexWluwR3pnL0E55z0Ngj
         S2oucHvHr5qVFfBdfH7R+215cXSyqnKYzQEZfGnqhPCcOiMq4BolQZV9t/nA3MBlteqo
         oyNCiCI8ORqEC6Vg/GXqkIhadSAY1R3xm8IpBJMGblXGyhFqUi/VSZ1l1FTKskG3cbC1
         rljwFomT8DP21wUK5dMMfCc3bb4VwkC+Xdtu99Sjpv8qWXYQm7H34QLtWxy3q9xr4JW3
         1biQuk6zWVj+20IA4CC/KLV2lSGqrXyRGnuD0yGDVgZioHNwE4Di+lG72MxuoRZOwTu7
         nC+w==
X-Gm-Message-State: AOJu0YwBo9BEMnz1kHwQjIF8mHww9dppKvq1UMR9zAPwRICI4D+REeT3
	wJBDA1C9vUUaSyKZYNa/VxC0Y5KA1G5a3G09uc8Z447FdepUpcHxu3d9agSxmgzMAVFDYj9fU5q
	CTnbsKL2nwTuBrr/P3apvpBatUTyxNAqWqg==
X-Received: by 2002:ac8:4e4e:0:b0:429:fa83:f4c6 with SMTP id e14-20020ac84e4e000000b00429fa83f4c6mr1096579qtw.39.1705350699499;
        Mon, 15 Jan 2024 12:31:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1lwPkU57DLGFNnwilIHpZk2wzak6MjnE6mfdGCBA9zzIH6qjYFqNMw/TYhiKlJvicPTHWSA==
X-Received: by 2002:ac8:4e4e:0:b0:429:fa83:f4c6 with SMTP id e14-20020ac84e4e000000b00429fa83f4c6mr1096561qtw.39.1705350699222;
        Mon, 15 Jan 2024 12:31:39 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a803:26a5:3f32:e12b:5335:3c2d])
        by smtp.gmail.com with ESMTPSA id jz4-20020a05622a81c400b00427f02d072bsm4132051qtb.95.2024.01.15.12.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 12:31:38 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Leonardo Bras <leobras@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	tglx@linutronix.de,
	x86@kernel.org,
	tj@kernel.org,
	peterz@infradead.org,
	mathieu.desnoyers@efficios.com,
	paulmck@kernel.org,
	keescook@chromium.org,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	will@kernel.org,
	longman@redhat.com,
	boqun.feng@gmail.com,
	brauner@kernel.org
Subject: Re: [PATCH 16/50] sched.h: Move (spin|rwlock)_needbreak() to spinlock.h
Date: Mon, 15 Jan 2024 17:31:34 -0300
Message-ID: <ZaWWJsq2j-TjKxJI@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231216032651.3553101-6-kent.overstreet@linux.dev>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev> <20231216032651.3553101-1-kent.overstreet@linux.dev> <20231216032651.3553101-6-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Dec 15, 2023 at 10:26:15PM -0500, Kent Overstreet wrote:
> This lets us kill the dependency on spinlock.h.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---
>  include/linux/sched.h    | 31 -------------------------------
>  include/linux/spinlock.h | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+), 31 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 5a5b7b122682..7501a3451a20 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2227,37 +2227,6 @@ static inline bool preempt_model_preemptible(void)
>  	return preempt_model_full() || preempt_model_rt();
>  }
>  
> -/*
> - * Does a critical section need to be broken due to another
> - * task waiting?: (technically does not depend on CONFIG_PREEMPTION,
> - * but a general need for low latency)
> - */
> -static inline int spin_needbreak(spinlock_t *lock)
> -{
> -#ifdef CONFIG_PREEMPTION
> -	return spin_is_contended(lock);
> -#else
> -	return 0;
> -#endif
> -}
> -
> -/*
> - * Check if a rwlock is contended.
> - * Returns non-zero if there is another task waiting on the rwlock.
> - * Returns zero if the lock is not contended or the system / underlying
> - * rwlock implementation does not support contention detection.
> - * Technically does not depend on CONFIG_PREEMPTION, but a general need
> - * for low latency.
> - */
> -static inline int rwlock_needbreak(rwlock_t *lock)
> -{
> -#ifdef CONFIG_PREEMPTION
> -	return rwlock_is_contended(lock);
> -#else
> -	return 0;
> -#endif
> -}
> -
>  static __always_inline bool need_resched(void)
>  {
>  	return unlikely(tif_need_resched());
> diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
> index 31d3d747a9db..0c71f06454d9 100644
> --- a/include/linux/spinlock.h
> +++ b/include/linux/spinlock.h
> @@ -449,6 +449,37 @@ static __always_inline int spin_is_contended(spinlock_t *lock)
>  	return raw_spin_is_contended(&lock->rlock);
>  }
>  
> +/*
> + * Does a critical section need to be broken due to another
> + * task waiting?: (technically does not depend on CONFIG_PREEMPTION,
> + * but a general need for low latency)
> + */
> +static inline int spin_needbreak(spinlock_t *lock)
> +{
> +#ifdef CONFIG_PREEMPTION
> +	return spin_is_contended(lock);
> +#else
> +	return 0;
> +#endif
> +}
> +
> +/*
> + * Check if a rwlock is contended.
> + * Returns non-zero if there is another task waiting on the rwlock.
> + * Returns zero if the lock is not contended or the system / underlying
> + * rwlock implementation does not support contention detection.
> + * Technically does not depend on CONFIG_PREEMPTION, but a general need
> + * for low latency.
> + */
> +static inline int rwlock_needbreak(rwlock_t *lock)
> +{
> +#ifdef CONFIG_PREEMPTION
> +	return rwlock_is_contended(lock);
> +#else
> +	return 0;
> +#endif
> +}
> +
>  #define assert_spin_locked(lock)	assert_raw_spin_locked(&(lock)->rlock)
>  
>  #else  /* !CONFIG_PREEMPT_RT */
> -- 
> 2.43.0



Hello Kent,

This patch is breaking PREEMPT_RT builds, but it can be easily fixed.

I sent a patch on the fix, please take a look:
https://lore.kernel.org/all/20240115201935.2326400-1-leobras@redhat.com/

Thanks!
Leo


