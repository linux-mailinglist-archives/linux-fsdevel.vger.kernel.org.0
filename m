Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6E22162622
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 13:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgBRMbn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 07:31:43 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40270 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726347AbgBRMbm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 07:31:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582029101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8SlpuMhxEkNsVu++R0qzZ0u0OpROVAfPhZWy1e0dEb8=;
        b=b9jPDwNhgHW6pQ/ivHxq9yoNq13hAo72+D+SA8qy1qLfamlgHIPBKV+giAtDWszM3ozp8c
        GsVGAo4GK7mGeDCFEdiR1lc6BFqGXgemlZXLgKFB7ysLQkTffDaey+uZQrB2lhLSSzghPl
        czKAzwMySXAeXe4G4fwAWGa39fHPFoI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-P7UidK48OQqlwtfEB3Sg6A-1; Tue, 18 Feb 2020 07:31:40 -0500
X-MC-Unique: P7UidK48OQqlwtfEB3Sg6A-1
Received: by mail-wr1-f72.google.com with SMTP id t6so10760114wru.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2020 04:31:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8SlpuMhxEkNsVu++R0qzZ0u0OpROVAfPhZWy1e0dEb8=;
        b=IkOKwMqKzfRukaQoq+kYTFXo39FOsbcDkqHxdIcG6u2nr3cZr758IepvQU7QdoOr+N
         cWCIJaRzx1y6EFV1evsJIWFIBSrbOQTG2IfbGDL7b3GLUno93Jo6/FDY7DESSCfUMgmh
         /VrE0JF7NUMUDeiUtUfCQ0P+nW2JcquUidXj0+c3KyLnqTBbWvjx/qIitX4RcKTC82LX
         /IqnZGyvQhR9+o3kS3hd9N6wB36Q1KraNivcnXzbv9DW4jLWa9Qwrqag+tD8WPZU8dia
         PDlTciPmW4LSjssxt8Xob/z4Etz1MkQ7C9fCEbl+oglrI2CwYPqkoyBxRNR5Ox9WqQIU
         bnWA==
X-Gm-Message-State: APjAAAUDkvz3/kxu7X0ZK5FPlz50AYt6jD21Ny624nuMS9UyJ46vrlRN
        fiI2C3hUf+TxkglScat9DWPPFbBK4Aph5dEuVx9piT4NFM5Jp57Obp098FjCIe4lKUSur+5xs6z
        uS2nCz0ojckhFtZhoiCIRazig7g==
X-Received: by 2002:a5d:6151:: with SMTP id y17mr28368355wrt.110.1582029098848;
        Tue, 18 Feb 2020 04:31:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqyX7L8WQTkUFJv9QhdUj6RJA4xdxAXKjDQbK3r6resoWQuxm7d2+WUtLLTRQZ1zvQ/gtSV0vQ==
X-Received: by 2002:a5d:6151:: with SMTP id y17mr28368330wrt.110.1582029098553;
        Tue, 18 Feb 2020 04:31:38 -0800 (PST)
Received: from steredhat (host209-4-dynamic.27-79-r.retail.telecomitalia.it. [79.27.4.209])
        by smtp.gmail.com with ESMTPSA id b16sm3283514wmj.39.2020.02.18.04.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 04:31:37 -0800 (PST)
Date:   Tue, 18 Feb 2020 13:31:35 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] io_uring: remove unnecessary NULL checks
Message-ID: <20200218123135.5iihagj3lkwx4h52@steredhat>
References: <20200217143945.ua4lawkg22ggfihr@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217143945.ua4lawkg22ggfihr@kili.mountain>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 17, 2020 at 05:39:45PM +0300, Dan Carpenter wrote:
> The "kmsg" pointer can't be NULL and we have already dereferenced it so
> a check here would be useless.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  fs/io_uring.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 72bc378edebc..e9f339453ddb 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -3065,7 +3065,7 @@ static int io_sendmsg(struct io_kiocb *req, struct io_kiocb **nxt,
>  			if (req->io)
>  				return -EAGAIN;
>  			if (io_alloc_async_ctx(req)) {
> -				if (kmsg && kmsg->iov != kmsg->fast_iov)
> +				if (kmsg->iov != kmsg->fast_iov)
>  					kfree(kmsg->iov);
>  				return -ENOMEM;
>  			}
> @@ -3219,7 +3219,7 @@ static int io_recvmsg(struct io_kiocb *req, struct io_kiocb **nxt,
>  			if (req->io)
>  				return -EAGAIN;
>  			if (io_alloc_async_ctx(req)) {
> -				if (kmsg && kmsg->iov != kmsg->fast_iov)
> +				if (kmsg->iov != kmsg->fast_iov)
>  					kfree(kmsg->iov);
>  				return -ENOMEM;
>  			}

Make sense.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

