Return-Path: <linux-fsdevel+bounces-25720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA15094F822
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 22:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62AD1281D26
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 20:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A04919413B;
	Mon, 12 Aug 2024 20:20:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464C1191F80;
	Mon, 12 Aug 2024 20:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723494052; cv=none; b=YRUTuU+iXtkQsT4YuhGalLNrI39yIlHfbjId4kaZZfI/5yyUykVzUZ+orXWufN0TrqhVGk5sJdggarSJohbRdEvop97kAVVCT6DWUygFUjR4V88/MgrKa0EfbGdxzKWIxZzc0RrToFbuVsNA7Ci6pf/J19uCJWheV8r8ZDOcLGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723494052; c=relaxed/simple;
	bh=kInFWNpWiwM+iiF50l6b901Z5qcRDLx5S8leRBXplFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRAc27u2Tng2E8niHn8NbsonDmNGKqxdcjQMlXnQ9FUhm0QHPEovaQkoB6bC2B2m4Yj5OwrCoQ58y5sV43m9GkHN1pKHYoeT2sL/rJ/N0n5F9neBT8W5al4hTHRrUOhYHYUa5LSedxZ+H0pbh4GxM6doFs1ZfQFlIy0ABavWeyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fc52394c92so44077845ad.1;
        Mon, 12 Aug 2024 13:20:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723494050; x=1724098850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktYSPZAgGje2ea+VDHWGA24RZOqecMJEdUlJC7G5nVI=;
        b=qTjgKMIaF/YtcSqRdvvlfwOFsC8Z0b3LRiCaZnwrzln/xyT024w9JbU/uWWVDB36hk
         DPJ3lPYJ8FvPAx/F0/urzv2uL22+8d3cbEm1emyOXJgouqd9qtuPexBvVkmqPJ3qegOv
         ejXfHLj4vK+C/z3bGeTPo6pm5f8AcoNjFVh5NepkWiEjFh8+rdrVkVnqdJm/NlEqyr72
         nk4KpEmVkS35h1JjKi+5tG7W8g543xzn7rkVi2pz+eexqm0k3BmFqPKKVRm1xbujvr/K
         /RpiVwRhxbYaV63BvUAhAdkrK8a9221iUFiVK9R/VifTMmaL6Xdo3PdaMlS5egjBBTzh
         /rsw==
X-Forwarded-Encrypted: i=1; AJvYcCV5wlJrwDPuY1G3TOAt0dTf+Us5OpBM9FFciGQ4I7LxCXvvTyD9H4lw/60ciiyKCbC87PN6WT531ksE+NPNfM+m/QDiWYFChq6eYh8sPkjgog2DzD3+xRI+w4ekmutO/EC7wXKx8vFbkou7dA==
X-Gm-Message-State: AOJu0Yzm88y/N7WdONDSRHiJT+ZjHca/CNh04J0a33EnrxzkflsLo4Ob
	B/87R2UrS/iIbZgkyOuiN8IiaVoVbqz25KJ8iq9/cpoCv6TSlEc=
X-Google-Smtp-Source: AGHT+IE/1pxRmNn4lGz7smnMnw64zQr4fbBrZhmlAusRlv6NQ4ab6SeK2qAMh+mu7f1m/myArraxUw==
X-Received: by 2002:a17:902:e88d:b0:1fc:6c23:8a3b with SMTP id d9443c01a7336-201ca13dabbmr19909705ad.17.1723494050386;
        Mon, 12 Aug 2024 13:20:50 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1bba6bsm796875ad.225.2024.08.12.13.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 13:20:50 -0700 (PDT)
Date: Mon, 12 Aug 2024 13:20:49 -0700
From: Stanislav Fomichev <sdf@fomichev.me>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next 5/5] eventpoll: Control irq suspension for
 prefer_busy_poll
Message-ID: <ZrpuodWa6cKh0sPk@mini-arch>
References: <20240812125717.413108-1-jdamato@fastly.com>
 <20240812125717.413108-6-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240812125717.413108-6-jdamato@fastly.com>

On 08/12, Joe Damato wrote:
> From: Martin Karsten <mkarsten@uwaterloo.ca>
> 
> When events are reported to userland and prefer_busy_poll is set, irqs are
> temporarily suspended using napi_suspend_irqs.
> 
> If no events are found and ep_poll would go to sleep, irq suspension is
> cancelled using napi_resume_irqs.
> 
> Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
> Co-developed-by: Joe Damato <jdamato@fastly.com>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Tested-by: Joe Damato <jdamato@fastly.com>
> Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
> ---
>  fs/eventpoll.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index cc47f72005ed..d74b5b9c1f51 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -457,6 +457,8 @@ static bool ep_busy_loop(struct eventpoll *ep, int nonblock)
>  		 * it back in when we have moved a socket with a valid NAPI
>  		 * ID onto the ready list.
>  		 */
> +		if (prefer_busy_poll)
> +			napi_resume_irqs(napi_id);
>  		ep->napi_id = 0;
>  		return false;
>  	}
> @@ -540,6 +542,14 @@ static long ep_eventpoll_bp_ioctl(struct file *file, unsigned int cmd,
>  	}
>  }
>  
> +static void ep_suspend_napi_irqs(struct eventpoll *ep)
> +{
> +	unsigned int napi_id = READ_ONCE(ep->napi_id);
> +
> +	if (napi_id >= MIN_NAPI_ID && READ_ONCE(ep->prefer_busy_poll))
> +		napi_suspend_irqs(napi_id);
> +}
> +
>  #else
>  
>  static inline bool ep_busy_loop(struct eventpoll *ep, int nonblock)
> @@ -557,6 +567,10 @@ static long ep_eventpoll_bp_ioctl(struct file *file, unsigned int cmd,
>  	return -EOPNOTSUPP;
>  }
>  
> +static void ep_suspend_napi_irqs(struct eventpoll *ep)
> +{
> +}
> +
>  #endif /* CONFIG_NET_RX_BUSY_POLL */
>  
>  /*
> @@ -788,6 +802,10 @@ static bool ep_refcount_dec_and_test(struct eventpoll *ep)
>  
>  static void ep_free(struct eventpoll *ep)
>  {
> +	unsigned int napi_id = READ_ONCE(ep->napi_id);
> +
> +	if (napi_id >= MIN_NAPI_ID && READ_ONCE(ep->prefer_busy_poll))
> +		napi_resume_irqs(napi_id);
>  	mutex_destroy(&ep->mtx);
>  	free_uid(ep->user);
>  	wakeup_source_unregister(ep->ws);
> @@ -2005,8 +2023,10 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
>  			 * trying again in search of more luck.
>  			 */
>  			res = ep_send_events(ep, events, maxevents);
> -			if (res)
> +			if (res) {
> +				ep_suspend_napi_irqs(ep);

Aren't we already doing defer in the busy_poll_stop? (or in napi_poll
when it's complete/done). Why do we need another rearming here?

