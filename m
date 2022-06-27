Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30BE55D551
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbiF0JIk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jun 2022 05:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbiF0JIh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jun 2022 05:08:37 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461ECBA4
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jun 2022 02:08:35 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ge10so17712747ejb.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jun 2022 02:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=k1e7Wwe1AjCbXe7sromgO+mILN6P9Y2vdSpGp2oCkCk=;
        b=b8qCSWEOKka9s84N0wcEJ/GTZwusewGy5IsaK2F9Q4UFzB6+y+8ozRjXh89hAvLlMU
         K12dt4t2k478igf5w1imCsx/nqsNQMxOs1sQIJ30nQnGe+id+s6HkddlqiCTvSHJSysA
         9g99nL0Wk1M/DhvRrpm4pO91F74cEKsE6GmoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=k1e7Wwe1AjCbXe7sromgO+mILN6P9Y2vdSpGp2oCkCk=;
        b=CbXo+N7uflE771+VbLGmts10ARjaa5oYybELQwBK0xFSLI9W+mgipIFIKLOimdW15L
         fWMr5UTTgQ6AQaZ7MEhmTcB8nshjnSkVdyG5ENW0CB8zLDyUR8/4NUDTK6NYx/ZLk4Ei
         r+uCnNBW3TP6RonViqvoM2HIeHHZ/SRd1aDQA82L9B/+OKQco13ZInvv6GlQogOonKsL
         Sa6S6s8GUKjz59rm3cjqDlz65XNurkBetPvT0UKbOgjZd2c40mI31JjelVZPzrsABD8u
         +pTjMpmI7xXd/Js5LolBeldMjVY+P2LDIhM0paAF6d5LCOcW2LZN40ocWUyVIqEE/1a5
         q7Ew==
X-Gm-Message-State: AJIora/GgDWayglUAaD+/BxWLo02Fhy3P8WpLy82qMwqI8AvXjlSwVaC
        0iSsfaOytalaypDXaYeODHTlwQ==
X-Google-Smtp-Source: AGRyM1vFhPN1meHKKImI2keGZpwl6qEWNsZwQgQPLYnEouybFA2jLTjk/b7ksAjiA+H1CLyv+UeX1w==
X-Received: by 2002:a17:907:7811:b0:6ef:a896:b407 with SMTP id la17-20020a170907781100b006efa896b407mr11583984ejc.645.1656320914396;
        Mon, 27 Jun 2022 02:08:34 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id b7-20020a50e787000000b0042ab4e20543sm7225848edn.48.2022.06.27.02.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 02:08:33 -0700 (PDT)
Date:   Mon, 27 Jun 2022 11:08:32 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        dri-devel@lists.freedesktop.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH v2 7/8] dma-buf: remove useless FMODE_LSEEK flag
Message-ID: <YrlzkAlheCR0ZMuO@phenom.ffwll.local>
Mail-Followup-To: "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        dri-devel@lists.freedesktop.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
References: <20220625110115.39956-1-Jason@zx2c4.com>
 <20220625110115.39956-8-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220625110115.39956-8-Jason@zx2c4.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 25, 2022 at 01:01:14PM +0200, Jason A. Donenfeld wrote:
> This is already set by anon_inode_getfile(), since dma_buf_fops has
> non-NULL ->llseek, so we don't need to set it here too.
> 
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

I'm assuming this is part of a vfs cleanup and lands through that tree?
For that:

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/dma-buf/dma-buf.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 32f55640890c..3f08e0b960ec 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -549,7 +549,6 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
>  		goto err_dmabuf;
>  	}
>  
> -	file->f_mode |= FMODE_LSEEK;
>  	dmabuf->file = file;
>  
>  	mutex_init(&dmabuf->lock);
> -- 
> 2.35.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
