Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A794316D13
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 18:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbhBJRoJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 12:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbhBJRnX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 12:43:23 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB30C061574;
        Wed, 10 Feb 2021 09:42:42 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id l12so3568998wry.2;
        Wed, 10 Feb 2021 09:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DG+Kk/mvSEl70a4MZYIsbuCj3RK0HikfGS5wv5kv6BU=;
        b=cbA7lPXWfj1p85njhLAtiEEXFskNhI8Qf2lhnTOm3twQyvb023mIsT3VI1npSPzxKO
         0j6aXoQkx0ZlV74ybHa929efsV0emGFmMhmTwAcs0hTjGj99ENJ5N3FvCkE4wj+gLBq0
         yLaRqL6LruDmppC/2Bacuace4oE/bgCVYb7nZkfiYMCBb/43XwFBlKXU4MVF3Qy++5mN
         5xER6/Jr+5XhG3sfAwyVTSI9s1T7qn6A9W9kyJYtO5M9cMLnx0gKbrc19cBLgIw26Oc+
         uo73FybLxuk+ygfRcDYRc3866vCzoe04sWizvNfO2qrlOPdV6wKaUPd1YGj2UBjgEeIB
         3JhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=DG+Kk/mvSEl70a4MZYIsbuCj3RK0HikfGS5wv5kv6BU=;
        b=CJCE8Zb3V/toFF2I2KUuZJ7yJusuyV9c1oufg6Irt+soFItFREU/N9mKSrQcc9D2AH
         2lBkD36rlAZkevWXDbJ2Np935rFw7JBT20rHluTEPlvoZnLHo4IOmvO9tRvD5h/Q3Mmj
         hBkY+spY1FLEMA87yZcWTGPSJH8yen/ZAmRJ2n9AAY+pDiFMZ+Iz2nLKe72wZcsqYmjJ
         Yjk8tHcZxc/iRgZjEAq9yevVuk7VvEpLHHkDylhVrDmBXz58vo6IVEM9cb7p45pNaarL
         JDb+ambEMUS7tkhYmL0iS0UMJOTRUSId2QqgyAiStcfUEgfUqgTAzrwUIa8jiNMNmkC0
         eCqQ==
X-Gm-Message-State: AOAM530d/aKpMIga4RR1d/beYlIA1gFnyrbLKXwPcBHvPCyYeMAIXgtr
        Y12yzenGVNuLG+7zgQiGeuDy7Ch1TTr9cA==
X-Google-Smtp-Source: ABdhPJzuqq8oUeagES7+gL6+GQDnZYDPZ/m0NckVxNxIne86tQVURwSi9LbSYx83tkaS4HqQPyf7IQ==
X-Received: by 2002:adf:d20c:: with SMTP id j12mr4877208wrh.407.1612978960642;
        Wed, 10 Feb 2021 09:42:40 -0800 (PST)
Received: from [192.168.8.194] ([148.252.132.126])
        by smtp.gmail.com with ESMTPSA id f3sm3409536wme.26.2021.02.10.09.42.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 09:42:40 -0800 (PST)
Subject: Re: [PATCH -next] fs: io_uring: build when CONFIG_NET is disabled
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org
References: <20210210173740.22328-1-rdunlap@infradead.org>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Message-ID: <f9dbd75d-cbce-292a-b9e4-7cf8fb6f4cd7@gmail.com>
Date:   Wed, 10 Feb 2021 17:38:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20210210173740.22328-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/02/2021 17:37, Randy Dunlap wrote:
> Fix build errors when CONFIG_NET is not enabled.

Thanks, but already fixed up.

> 
> Fixes: b268c951abf8 ("io_uring: don't propagate io_comp_state")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Pavel Begunkov <asml.silence@gmail.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/io_uring.c |   18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> --- linux-next-20210210.orig/fs/io_uring.c
> +++ linux-next-20210210/fs/io_uring.c
> @@ -5145,14 +5145,12 @@ static int io_sendmsg_prep(struct io_kio
>  	return -EOPNOTSUPP;
>  }
>  
> -static int io_sendmsg(struct io_kiocb *req, unsigned int issue_flags,
> -		      struct io_comp_state *cs)
> +static int io_sendmsg(struct io_kiocb *req, unsigned int issue_flags)
>  {
>  	return -EOPNOTSUPP;
>  }
>  
> -static int io_send(struct io_kiocb *req, unsigned int issue_flags,
> -		   struct io_comp_state *cs)
> +static int io_send(struct io_kiocb *req, unsigned int issue_flags)
>  {
>  	return -EOPNOTSUPP;
>  }
> @@ -5163,14 +5161,12 @@ static int io_recvmsg_prep(struct io_kio
>  	return -EOPNOTSUPP;
>  }
>  
> -static int io_recvmsg(struct io_kiocb *req, unsigned int issue_flags,
> -		      struct io_comp_state *cs)
> +static int io_recvmsg(struct io_kiocb *req, unsigned int issue_flags)
>  {
>  	return -EOPNOTSUPP;
>  }
>  
> -static int io_recv(struct io_kiocb *req, unsigned int issue_flags,
> -		   struct io_comp_state *cs)
> +static int io_recv(struct io_kiocb *req, unsigned int issue_flags)
>  {
>  	return -EOPNOTSUPP;
>  }
> @@ -5180,8 +5176,7 @@ static int io_accept_prep(struct io_kioc
>  	return -EOPNOTSUPP;
>  }
>  
> -static int io_accept(struct io_kiocb *req, unsigned int issue_flags,
> -		     struct io_comp_state *cs)
> +static int io_accept(struct io_kiocb *req, unsigned int issue_flags)
>  {
>  	return -EOPNOTSUPP;
>  }
> @@ -5191,8 +5186,7 @@ static int io_connect_prep(struct io_kio
>  	return -EOPNOTSUPP;
>  }
>  
> -static int io_connect(struct io_kiocb *req, unsigned int issue_flags,
> -		      struct io_comp_state *cs)
> +static int io_connect(struct io_kiocb *req, unsigned int issue_flags)
>  {
>  	return -EOPNOTSUPP;
>  }
> 

-- 
Pavel Begunkov
