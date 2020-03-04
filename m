Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6BED1795A0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 17:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbgCDQsO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 11:48:14 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38015 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729573AbgCDQsO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:48:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583340493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Iwh6ArBhNlC/QzZYMfW6WQM30EkgNyAS0AeU4Ro9sDY=;
        b=b81N1gHOhjaQ6ABo9t5p9T5mcE5ze2sUw3NTfgvSvo6IFYTFG2wlca6PUk2Wp6hM2/QyDe
        kNDhTAbeVi7O0nQerMglJM4uwl3HzhtoEnpWAceCUMSu/xAYV4NoIsRiB2zdkMkHQcKk6/
        s9Oj0lxIdAvPoCpHmSb7Ov7ShW0cNrA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-_6TUz1oLMc6Hc7sLqOXiKQ-1; Wed, 04 Mar 2020 11:48:11 -0500
X-MC-Unique: _6TUz1oLMc6Hc7sLqOXiKQ-1
Received: by mail-wr1-f71.google.com with SMTP id m13so1090983wrw.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Mar 2020 08:48:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Iwh6ArBhNlC/QzZYMfW6WQM30EkgNyAS0AeU4Ro9sDY=;
        b=hFc5/bECWC4HYsqyBrw1OG1DEaLES5M+LS0yN93samk6yJR6wEom58j8lhat4Lv4Ms
         PifAhnbqGikkkzEsrNsqU6eJc+IJRpEJ38mqqvhiJqrTS2gT+wAoNPYrDEvxNgeViKH6
         s9x1+ZDZo0EVr85xSnE1obXm2ulTTg4+xlCfu/Cf5kH/jVkRgytGXp2PQgA9fgoQGXGo
         T0RncO13yW90fap9C7LCXr4Cv9Di5fZqAGXXenmfzkx3+PszHlR6dyaUtUw15tIg28w1
         BSSxdkSAgxvcoyN/dtQjvqVt0gy/sH1QRp4Ok4FAdaAXpnTiHDp7ZmEpXZD26/8gHKFy
         MJvQ==
X-Gm-Message-State: ANhLgQ2m1avhvzeTbUBufhz/derTahaJc8saXKb3iBJ7IjnkQStWkn5S
        HDJcS7Kuarc7n/2CuQqxuxBxf1L9u1TWB8MUXU++Svt6vON4yEPSrGtki0LzEFYUUfqt+x0uZ5k
        l9YGKOEKdFci9wLmKTtNeblRT9Q==
X-Received: by 2002:a05:600c:20e:: with SMTP id 14mr4326641wmi.108.1583340489629;
        Wed, 04 Mar 2020 08:48:09 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsNyLWu0uFAuo01q9LkN1pw0Tdrpz/UjV74a4G/Kr0JlmOeAm6griIqJdEVFCpIlrxATT+Wuw==
X-Received: by 2002:a05:600c:20e:: with SMTP id 14mr4326621wmi.108.1583340489391;
        Wed, 04 Mar 2020 08:48:09 -0800 (PST)
Received: from steredhat (host209-4-dynamic.27-79-r.retail.telecomitalia.it. [79.27.4.209])
        by smtp.gmail.com with ESMTPSA id n11sm6627994wrw.11.2020.03.04.08.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 08:48:08 -0800 (PST)
Date:   Wed, 4 Mar 2020 17:48:06 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] io_uring: Fix unused function warnings
Message-ID: <20200304164806.3bsr2v7cvpq7sw5e@steredhat>
References: <20200304075352.31132-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304075352.31132-1-yuehaibing@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 04, 2020 at 03:53:52PM +0800, YueHaibing wrote:
> If CONFIG_NET is not set, gcc warns:
> 
> fs/io_uring.c:3110:12: warning: io_setup_async_msg defined but not used [-Wunused-function]
>  static int io_setup_async_msg(struct io_kiocb *req,
>             ^~~~~~~~~~~~~~~~~~
> 
> There are many funcions wraped by CONFIG_NET, move them
> together to simplify code, also fix this warning.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  fs/io_uring.c | 98 ++++++++++++++++++++++++++++++++++-------------------------
>  1 file changed, 57 insertions(+), 41 deletions(-)
> 

Since the code under the ifdef/else/endif blocks now are huge, would it make
sense to add some comments for better readability?

I mean something like this:

#if defined(CONFIG_NET)
...
#else /* !CONFIG_NET */
...
#endif /* CONFIG_NET */


Thanks,
Stefano

