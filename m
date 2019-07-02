Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3185D69B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2019 21:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfGBTJa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jul 2019 15:09:30 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38426 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbfGBTJa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jul 2019 15:09:30 -0400
Received: by mail-pf1-f194.google.com with SMTP id y15so8741826pfn.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jul 2019 12:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=7MbyDYqaqvSFQxOK+144mOVh5/lF6H2bN9YDe1mqXsE=;
        b=gf9AynaRipCPNwL4fqUj1Kgn+M7Ben9Z5cpa9swnWQpDwgucDeCPC01FXDrDkJ6uY0
         NSSCVdOhd5rccsRnUlWJ3ltnJlP3CpkB1Z4l9dmROza6n7s9SAwfvaIofJOW+IwiIL9D
         rzCy4GxgcbCFYjvq+xCwL1krM+FxBF9je/WbpobhrRQYa2zVlcD4/XurltNaGbLN9rvS
         ede+qAXNcAhTef1SGO6BUKHn/q2Nvk/NaAg2z6OGVU+ZBiu/dqAHr+Q4jibrC9xFD2D6
         NHug/qhQbzlj3lSwkRlT7jw6/nXJDtW+gVpRHI/qNjTEGJuGadXUqOSUe5XpcXv/SWGi
         fj7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=7MbyDYqaqvSFQxOK+144mOVh5/lF6H2bN9YDe1mqXsE=;
        b=OsvclodeAzd1NW/jL1mMBCYhoQqoQ9+wMpgSsO+uJqXjDpgz+mBePXD4lRcjbK3BmV
         rqt+HotOZgcTeYov+R8IEMfNd5CDBJOSVuQPimBQvgmiprhYDO61qqhSt9qmsSh/1rH+
         c0EUVQfnSjy6I2jaYckYPuoeHIIXqeCLlkKOsCaPZfoMovpsXQUJ2BzaZrC9AcVPRemQ
         vsqNMCv3sm5qo0QZalgQmEwUpTPj5GRkCVyJcev3bC8BO9w9eGG6SnIybkMoTRrhBLAA
         hHblQic2dF/f31OhlWYpZ+tQO0JF9RvIJxF+wxg1kmYup3fK8ZDqlsbHz6wZrEhloXYg
         DZdw==
X-Gm-Message-State: APjAAAUIT81UBpOhLN4SqEaLlF5LZxJIQfVHSiodk7X04WYtDdLcKNaC
        sEbNqFx6l6FfqYeF0cum78CrLw==
X-Google-Smtp-Source: APXvYqx9wyjGr3gEZi8btnw1XM/Out5qiZEDMv6+jCbc/ZJawA+a4NDQhc2TqwqowTNEDVgPQ/xJhA==
X-Received: by 2002:a17:90a:338b:: with SMTP id n11mr7294382pjb.21.1562094569110;
        Tue, 02 Jul 2019 12:09:29 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id y22sm29677631pfo.39.2019.07.02.12.09.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 12:09:27 -0700 (PDT)
Date:   Tue, 2 Jul 2019 12:09:27 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Waiman Long <longman@redhat.com>
cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH] mm, slab: Extend slab/shrink to shrink all the memcg
 caches
In-Reply-To: <20190702183730.14461-1-longman@redhat.com>
Message-ID: <alpine.DEB.2.21.1907021206000.67286@chino.kir.corp.google.com>
References: <20190702183730.14461-1-longman@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2 Jul 2019, Waiman Long wrote:

> diff --git a/Documentation/ABI/testing/sysfs-kernel-slab b/Documentation/ABI/testing/sysfs-kernel-slab
> index 29601d93a1c2..2a3d0fc4b4ac 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-slab
> +++ b/Documentation/ABI/testing/sysfs-kernel-slab
> @@ -429,10 +429,12 @@ KernelVersion:	2.6.22
>  Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
>  		Christoph Lameter <cl@linux-foundation.org>
>  Description:
> -		The shrink file is written when memory should be reclaimed from
> -		a cache.  Empty partial slabs are freed and the partial list is
> -		sorted so the slabs with the fewest available objects are used
> -		first.
> +		A value of '1' is written to the shrink file when memory should
> +		be reclaimed from a cache.  Empty partial slabs are freed and
> +		the partial list is sorted so the slabs with the fewest
> +		available objects are used first.  When a value of '2' is
> +		written, all the corresponding child memory cgroup caches
> +		should be shrunk as well.  All other values are invalid.
>  

This should likely call out that '2' also does '1', that might not be 
clear enough.

>  What:		/sys/kernel/slab/cache/slab_size
>  Date:		May 2007
> diff --git a/mm/slab.h b/mm/slab.h
> index 3b22931bb557..a16b2c7ff4dd 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -174,6 +174,7 @@ int __kmem_cache_shrink(struct kmem_cache *);
>  void __kmemcg_cache_deactivate(struct kmem_cache *s);
>  void __kmemcg_cache_deactivate_after_rcu(struct kmem_cache *s);
>  void slab_kmem_cache_release(struct kmem_cache *);
> +int kmem_cache_shrink_all(struct kmem_cache *s);
>  
>  struct seq_file;
>  struct file;
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 464faaa9fd81..493697ba1da5 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -981,6 +981,49 @@ int kmem_cache_shrink(struct kmem_cache *cachep)
>  }
>  EXPORT_SYMBOL(kmem_cache_shrink);
>  
> +/**
> + * kmem_cache_shrink_all - shrink a cache and all its memcg children
> + * @s: The root cache to shrink.
> + *
> + * Return: 0 if successful, -EINVAL if not a root cache
> + */
> +int kmem_cache_shrink_all(struct kmem_cache *s)
> +{
> +	struct kmem_cache *c;
> +
> +	if (!IS_ENABLED(CONFIG_MEMCG_KMEM)) {
> +		kmem_cache_shrink(s);
> +		return 0;
> +	}
> +	if (!is_root_cache(s))
> +		return -EINVAL;
> +
> +	/*
> +	 * The caller should have a reference to the root cache and so
> +	 * we don't need to take the slab_mutex. We have to take the
> +	 * slab_mutex, however, to iterate the memcg caches.
> +	 */
> +	get_online_cpus();
> +	get_online_mems();
> +	kasan_cache_shrink(s);
> +	__kmem_cache_shrink(s);
> +
> +	mutex_lock(&slab_mutex);
> +	for_each_memcg_cache(c, s) {
> +		/*
> +		 * Don't need to shrink deactivated memcg caches.
> +		 */
> +		if (s->flags & SLAB_DEACTIVATED)
> +			continue;
> +		kasan_cache_shrink(c);
> +		__kmem_cache_shrink(c);
> +	}
> +	mutex_unlock(&slab_mutex);
> +	put_online_mems();
> +	put_online_cpus();
> +	return 0;
> +}
> +
>  bool slab_is_available(void)
>  {
>  	return slab_state >= UP;

I'm wondering how long this could take, i.e. how long we hold slab_mutex 
while we traverse each cache and shrink it.

Acked-by: David Rientjes <rientjes@google.com>
