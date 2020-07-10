Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F58321BC9D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jul 2020 19:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgGJRwv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jul 2020 13:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgGJRwv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jul 2020 13:52:51 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C959C08C5DC
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2020 10:52:51 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id v8so6941158iox.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2020 10:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X4sn28XQAInZ6oRA/4Miu/453HHyk6jIfO1A6nENhso=;
        b=ZOwmy3TcyKaYApKKIQPxqj0LaKTYVT7Yme9kGN/xV7hHfvlyAwatmbOYm1j0fas7mF
         5ROVhfgF9tarevn4hiEZhn7AcCnN6kSKkA53aFbJdS7IVJqgfI7pX7sMVIOphfExGnpg
         5JtVT5rTSDrM8HYhogou6Z8s46HSr3YVCvtQq+aJYqXxuyYm4Z7Ur0DOvFv80a/ISPTD
         FK/UA61DACU3FI3jSQ54LvnEZ5CntbU7BYeHIHHiaiA++Bh5kd4Hlz76H+3lbj4IFkZo
         +ddZgu2t9g24vcKnMae55i04/pg+X13EK++ZigSSfoJtwccft/3D6UK6AyWtLLeoxFld
         yr2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X4sn28XQAInZ6oRA/4Miu/453HHyk6jIfO1A6nENhso=;
        b=Mgjgp9p2U1HsZIuDlq30w1QMpjZef9jNRj4bmtqKBmc80+htuM6iXJ+/kZhDGrjUuv
         v8wGNqS0uwSY8SmX3pUYPXvbAa8R4lGyfHKpVfDgIo/LUkmTq+QrEoV9llDe6UcW76+L
         53i+zg5UiBqGHMHxPjUNKUzfJUdmBW6J6JGrTE5AuWO2ET03vPhy65HAV/3YSuMQVNmh
         ulwej0rkeTdxvQrJzLSUT7FKg2vC1TlUrnWi5BzKQ37C+x1jxunU82OMEDIy2t5igjvp
         zoGAxDJLv/g+JTLpg8Lh9BMEus74Vuokw/xtZXp3Jh3XBWqKlgiP8IS6gAtojnKHnCZa
         U14g==
X-Gm-Message-State: AOAM531pKVfdx+OLR7F6tgk1ODu9oyra5lO1WEqVjvGdmKM6vvjUuVD8
        bNkS2ZFLW+XL8tlwUT+NRK5wLw==
X-Google-Smtp-Source: ABdhPJwPQKF+EcvlyUkz8Mn5ccD8YvTlNprEGWbyCG+1XhL4L0vi4FeRZSlpkfHNv5e7wABJkHpTaQ==
X-Received: by 2002:a5d:8d12:: with SMTP id p18mr48507405ioj.148.1594403570543;
        Fri, 10 Jul 2020 10:52:50 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c29sm3947388ilg.53.2020.07.10.10.52.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 10:52:49 -0700 (PDT)
Subject: Re: [PATCH RFC 2/3] io_uring: add IOURING_REGISTER_RESTRICTIONS
 opcode
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Jann Horn <jannh@google.com>, Aleksa Sarai <asarai@suse.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        io-uring@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Moyer <jmoyer@redhat.com>
References: <20200710141945.129329-1-sgarzare@redhat.com>
 <20200710141945.129329-3-sgarzare@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f39fe84d-1353-1066-c7fc-770054f7129e@kernel.dk>
Date:   Fri, 10 Jul 2020 11:52:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200710141945.129329-3-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/10/20 8:19 AM, Stefano Garzarella wrote:
> The new io_uring_register(2) IOURING_REGISTER_RESTRICTIONS opcode
> permanently installs a feature whitelist on an io_ring_ctx.
> The io_ring_ctx can then be passed to untrusted code with the
> knowledge that only operations present in the whitelist can be
> executed.
> 
> The whitelist approach ensures that new features added to io_uring
> do not accidentally become available when an existing application
> is launched on a newer kernel version.

Keeping with the trend of the times, you should probably use 'allowlist'
here instead of 'whitelist'.
> 
> Currently is it possible to restrict sqe opcodes and register
> opcodes. It is also possible to allow only fixed files.
> 
> IOURING_REGISTER_RESTRICTIONS can only be made once. Afterwards
> it is not possible to change restrictions anymore.
> This prevents untrusted code from removing restrictions.

A few comments below.

> @@ -337,6 +344,7 @@ struct io_ring_ctx {
>  	struct llist_head		file_put_llist;
>  
>  	struct work_struct		exit_work;
> +	struct io_restriction		restrictions;
>  };
>  
>  /*

Since very few will use this feature, was going to suggest that we make
it dynamically allocated. But it's just 32 bytes, currently, so probably
not worth the effort...

> @@ -5491,6 +5499,11 @@ static int io_req_set_file(struct io_submit_state *state, struct io_kiocb *req,
>  	if (unlikely(!fixed && io_async_submit(req->ctx)))
>  		return -EBADF;
>  
> +	if (unlikely(!fixed && req->ctx->restrictions.enabled &&
> +		     test_bit(IORING_RESTRICTION_FIXED_FILES_ONLY,
> +			      req->ctx->restrictions.restriction_op)))
> +		return -EACCES;
> +
>  	return io_file_get(state, req, fd, &req->file, fixed);
>  }

This one hurts, though. I don't want any extra overhead from the
feature, and you're digging deep in ctx here to figure out of we need to
check.

Generally, all the checking needs to be out-of-line, and it needs to
base the decision on whether to check something or not on a cache hot
piece of data. So I'd suggest to turn all of these into some flag.
ctx->flags generally mirrors setup flags, so probably just add a:

	unsigned int restrictions : 1;

after eventfd_async : 1 in io_ring_ctx. That's free, plenty of room
there and that cacheline is already pulled in for reading.


-- 
Jens Axboe

