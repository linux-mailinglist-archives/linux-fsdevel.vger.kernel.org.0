Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B77A92331E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 14:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgG3MSk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 08:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgG3MSj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 08:18:39 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274ADC061794;
        Thu, 30 Jul 2020 05:18:38 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id d190so5503437wmd.4;
        Thu, 30 Jul 2020 05:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ssgOwtuSxoojGbvdK992E6f0RKSl1f4hgxlzsy7IsF8=;
        b=Gb+/IzTEV4sYLdPjwCAufl3SIMkTrf7Ghq2qHVnA5WWB7gdQv2990KjOYSQnbhaSji
         /bVDEXYlhBTpAmM6ZZjyvoDrerJIYIE3F5W+xiSA20K5P8zcxQ+yRo27hYHr3V2vi79w
         AwOJZVu5uqWrKo2KEbnz3GcoZTT7NvXqUbH5+adqWAllFA6hewf2mXAyEzZ3Ma9cAGkO
         Lm6if8gvmHKeq8mV0xReInuXsYu796sSkwQEizHrdz4Y8nyqaEu8ctaOCIe5Sugeq7n0
         LkwAzxOwhfb7FLKZwUjjis4MQnByI5PkH+f2xRuksl3weRUlv0GMrm0kM200Fw6dc0Dl
         Xazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ssgOwtuSxoojGbvdK992E6f0RKSl1f4hgxlzsy7IsF8=;
        b=lL7cxPAzLbx7hAS0UjPJKnjzFr6xmKncVrnnrN06ZLHuGzz6b2hl1dcbDpjKD5AN8i
         l1D+35zZMz2ZLr/VZabHqHwHnUuk+51waiUM01BfdqT+fYQOuUkGRPfuEzhxu+4Lu2Gv
         kEfF+ztYs3McuT15EnZffUrx6raPDpPeve0LYisra30u6TeBQkew9ckCwfU63t4goi47
         Nm5hBL2is2Mcog8sVuUP1YYFupxPZlethedthZOaaeA9cABIZcA3atGGUTmOKsLMAM1n
         Bmr5hG9ZX0cuxPgl0/zwjlF0+Pn/qYNkMP7ECPyAZq17KlhCYa7wZpxNj0D2Dk0dc6S3
         +LuA==
X-Gm-Message-State: AOAM533hmxthVcPGBTLPH6zU1R7yDtjMvRNqvYK72cZINpGbFwa6s54I
        lulmstzO5C3c9pMjav0xGA==
X-Google-Smtp-Source: ABdhPJxr2iK8oMOGAetqp7RzY1WlShHwp0N8nVXqtU70Bj1DWnnzIadhjm9Dvzuv/HOuZe6fi8CZVA==
X-Received: by 2002:a1c:1f0d:: with SMTP id f13mr13734335wmf.53.1596111516899;
        Thu, 30 Jul 2020 05:18:36 -0700 (PDT)
Received: from localhost.localdomain ([46.53.251.89])
        by smtp.gmail.com with ESMTPSA id i66sm9600776wma.35.2020.07.30.05.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 05:18:36 -0700 (PDT)
Date:   Thu, 30 Jul 2020 15:18:34 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     viro@zeniv.linux.org.uk, davem@davemloft.net,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, areber@redhat.com, serge@hallyn.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 11/23] fs: Add /proc/namespaces/ directory
Message-ID: <20200730121834.GA4490@localhost.localdomain>
References: <159611007271.535980.15362304262237658692.stgit@localhost.localdomain>
 <159611041929.535980.14513096920129728440.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <159611041929.535980.14513096920129728440.stgit@localhost.localdomain>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 30, 2020 at 03:00:19PM +0300, Kirill Tkhai wrote:

> # ls /proc/namespaces/ -l
> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'cgroup:[4026531835]' -> 'cgroup:[4026531835]'
> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'ipc:[4026531839]' -> 'ipc:[4026531839]'
> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'mnt:[4026531840]' -> 'mnt:[4026531840]'
> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'mnt:[4026531861]' -> 'mnt:[4026531861]'
> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'mnt:[4026532133]' -> 'mnt:[4026532133]'
> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'mnt:[4026532134]' -> 'mnt:[4026532134]'
> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'mnt:[4026532135]' -> 'mnt:[4026532135]'
> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'mnt:[4026532136]' -> 'mnt:[4026532136]'
> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'net:[4026531993]' -> 'net:[4026531993]'
> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'pid:[4026531836]' -> 'pid:[4026531836]'
> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'time:[4026531834]' -> 'time:[4026531834]'
> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'user:[4026531837]' -> 'user:[4026531837]'
> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'uts:[4026531838]' -> 'uts:[4026531838]'

I'd say make it '%s-%llu'. The brackets don't carry any information.
And ':' forces quoting with recent coreutils.

> +static int parse_namespace_dentry_name(const struct dentry *dentry,
> +		const char **type, unsigned int *type_len, unsigned int *inum)
> +{
> +	const char *p, *name;
> +	int count;
> +
> +	*type = name = dentry->d_name.name;
> +	p = strchr(name, ':');
> +	*type_len = p - name;
> +	if (!p || p == name)
> +		return -ENOENT;
> +
> +	p += 1;
> +	if (sscanf(p, "[%u]%n", inum, &count) != 1 || *(p + count) != '\0' ||
> +	    *inum < PROC_NS_MIN_INO)
> +		return -ENOENT;

sscanf is banned from lookup code due to lax whitespace rules.
See

	commit ac7f1061c2c11bb8936b1b6a94cdb48de732f7a4
	proc: fix /proc/*/map_files lookup

Of course someone sneaked in 1 instance, yikes.

	$ grep -e scanf -n -r fs/proc/
	fs/proc/base.c:1596:            err = sscanf(pos, "%9s %lld %lu", clock,

> +static int proc_namespaces_readdir(struct file *file, struct dir_context *ctx)

> +		len = snprintf(name, sizeof(name), "%s:[%u]", ns->ops->name, inum);

[] -- no need.
