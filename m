Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82E8493DC9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jan 2022 16:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355331AbiASP5G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jan 2022 10:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242656AbiASP5F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jan 2022 10:57:05 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A29C061574;
        Wed, 19 Jan 2022 07:57:05 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id m11so14028638edi.13;
        Wed, 19 Jan 2022 07:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QbbEs7xlljJ9OZYiN3yevk0GUCKL84eHLAEdoItRUt8=;
        b=l4QeBCm+hbgu0GoZPBuNcRqAXRwJDC5yrKIxYx3BRU+swXLgSwzGDZ3GanbQrt1LSa
         ax0ibom1VT/HNROBH3mpdlZCzMevr7AaQnIKvXuaJbVeC/X1C0WDA+1CGqYMaJotOAex
         g/KxhtBEUOintFV0oZJ+yDk2TttlA9SirUxACzvwi8+xkLCU7iG9KsSJ7Ph4nHSSJEPx
         sqBDttdvimcNrPjbCHqN7Xh4oJ3z1PzLeODN/lFEc7ZH2x18LgS3CzvSGWKwnSEjxKTn
         c48SwLK9M39mMZDImYXGZ3ScjZsTTL8brzAJneGqUXgdQKVZ+VbKuJFQUcRg5ssBeZ4Q
         N02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QbbEs7xlljJ9OZYiN3yevk0GUCKL84eHLAEdoItRUt8=;
        b=IKyywdhOnGvI71hVLT7Dr/+EzRxoSZfzxYTfvI/yRkvA5Hz8qN8YAzPe1lDxdAFxy3
         FzKMpiZbqpR+FmZKh9YxC2hL3xMzVE2JPnMrDxvFpBfLGsa9Z1jbNEa/htTxsSBeKeQO
         kHfUFORZMvw4V6WJeCZEw1ANMQ77G7ciAvXdFDhkrGlXSp9BS9k2vQP26DmElD0r7YvY
         HwQBqG7+TH1PBVANe26vrjqZLH8ST8wAZ39AQ86VFnuZEsfC5TWYFGaUxmhQt1arUl5X
         MQKPARTiWVNAhwTWfoGdqI4weX/hOJjsOFx+9eqzHofdm/+e0mqegfYcKGOYNP9LCR43
         iguQ==
X-Gm-Message-State: AOAM531827exmcbKtvVAh7GIcDezUE219niChcWrcWo/47zTysxwfOQW
        aI6p3JmnSS/9sO09iXgCe8ZS/Xq+eQ==
X-Google-Smtp-Source: ABdhPJyCyfPpe2MZbpo2f+Xl/1UxsWavHIpIxaG75rImKZ2ABU9U2vBrX/iEiNEqt8AwMtr4vrsUtg==
X-Received: by 2002:a50:8ad2:: with SMTP id k18mr1509163edk.166.1642607824141;
        Wed, 19 Jan 2022 07:57:04 -0800 (PST)
Received: from localhost.localdomain ([46.53.251.254])
        by smtp.gmail.com with ESMTPSA id gz19sm30426ejc.10.2022.01.19.07.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 07:57:03 -0800 (PST)
Date:   Wed, 19 Jan 2022 18:57:02 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     stephen.s.brennan@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        stephen.s.brennan@oracle.com, legion@kernel.org,
        viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH v2] proc: "mount -o lookup=" support
Message-ID: <Yeg0zoI8d3oyWuzw@localhost.localdomain>
References: <YegysyqL3LvljK66@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YegysyqL3LvljK66@localhost.localdomain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 19, 2022 at 06:48:03PM +0300, Alexey Dobriyan wrote:
> 	# mount -t proc -o lookup=/ proc /proc

> +static int proc_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc)
> +{
> +	struct proc_fs_context *src = fc->fs_private;
> +	struct proc_fs_context *dst;
> +
> +	dst = kmemdup(src, sizeof(struct proc_fs_context), GFP_KERNEL);
> +	if (!dst) {
> +		return -ENOMEM;
> +	}
> +
> +	dst->lookup_list = kmemdup(dst->lookup_list, dst->lookup_list_len, GFP_KERNEL);
> +	if (!dst->lookup_list) {
> +		kfree(dst);
> +		return -ENOMEM;
> +	}
> +	get_pid_ns(dst->pid_ns);
> +
> +	fc->fs_private = dst;
> +	return 0;
> +}

Stephen, sorry for not replying earlier.

I don't pretend to understand fully what ->dup() is supposed to do.
And the above code was not tested.

In particular

	p->a = kmemdup(p->a, ...)

reads like "MEMORY LEAK" on the first glance but it is not.

Understanding ->dup is the next thing.
