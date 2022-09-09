Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BAB5B2F3C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 08:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiIIGpi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 02:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiIIGpg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 02:45:36 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30152D1EB;
        Thu,  8 Sep 2022 23:45:34 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id q63so696817pga.9;
        Thu, 08 Sep 2022 23:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=I8PBnVuso42Lf8DghkrkORINCJIw/NNGEd7qLTShBCg=;
        b=iQHsq+0XUdDC87Uor3v4Ubs/wKzsrooqcujwFitg3OmdhmV3vYfO6ub0M4jPd0ayoO
         QseC5lwBTc/LOY/nhOqfYzqI2HQKZNYbsYrX+C3AKm+zfhoZY9dIyi+mNLd1kDTBfjs2
         rct+3E77H1PsgFwL7ftthrxt2t7lPDL1Qkf87EqYKQBhtSgXKVfdmH0xe/MLKu9nyTUH
         ZHY4lo0NKtYYulw67Lpy0jnQuyiOVx2uLQijw2e62LeukbM5r3a9nWdxiGJGERTH6R7u
         NwtetV8aRMLUdjizlSbQ9w2am0FRlz3tPCcFddR+g+BYASked3OpdqSkAxKuiXOBGIIS
         PP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=I8PBnVuso42Lf8DghkrkORINCJIw/NNGEd7qLTShBCg=;
        b=XeznjGjTr7pedtg9fTej/aamz1arFqyp2SoCDUPDRsRfcR9MIKnhzwxbQhdzbqMxCa
         A8HTBQMtZZ0sX79G3C6gW+zahb/vBmnbtpY2xsCXMlTNTe+DCcAmcKVG+D2u8M1Cj1Vn
         0OnyaXHZJXayezkUab9xUFF+hpFxy/e4UPoBw8HlbUok95YTKm6fhGrReUIJofKI6Xj1
         yyhESQdysrB4b/3RwrcHasd5SqbQgXCtR5P0fwPN5IDlo0658kNGBgGU4dBL3oJYg3FT
         xKHVk7fAUPh0BSGgKpJOI80AVGBgM3qgCF0M9zxYhZ7MqdoHYKFRjWa91amoq0LA+TyH
         WIwA==
X-Gm-Message-State: ACgBeo0PM0pT6FuQrQreqXIzbIkAcGy6gUiOdGjxzdkcvEAtoKLPsb8+
        6cThhft7c0aAF0CT6g7f/7c=
X-Google-Smtp-Source: AA6agR5yAGcbTXNwHYAqHZABOLzG1u6FcbM2Kb1e0v0KLxRBtnzzpHmIcaHUTJiuhR6YQNp1FEzG/w==
X-Received: by 2002:a63:a1f:0:b0:434:dd36:c639 with SMTP id 31-20020a630a1f000000b00434dd36c639mr10668967pgk.165.1662705934547;
        Thu, 08 Sep 2022 23:45:34 -0700 (PDT)
Received: from localhost ([2406:7400:63:83c4:f166:555c:90a1:a48d])
        by smtp.gmail.com with ESMTPSA id t128-20020a625f86000000b0052d2b55be32sm805403pfb.171.2022.09.08.23.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 23:45:34 -0700 (PDT)
Date:   Fri, 9 Sep 2022 12:15:28 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     jack@suse.cz, amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fsnotify: remove unused declaration
Message-ID: <20220909064528.vbjafykgbm7kt35q@riteshh-domain>
References: <20220909033828.993889-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909033828.993889-1-cuigaosheng1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/09/09 11:38AM, Gaosheng Cui wrote:
> fsnotify_alloc_event_holder() and fsnotify_destroy_event_holder()
> has been removed since commit 7053aee26a35 ("fsnotify: do not share
> events between notification groups"), so remove it.

It's a 2014 commit. Nice spotting. 
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

> 
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  fs/notify/fsnotify.h | 4 ----
>  1 file changed, 4 deletions(-)


> 
> diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
> index 87d8a50ee803..fde74eb333cc 100644
> --- a/fs/notify/fsnotify.h
> +++ b/fs/notify/fsnotify.h
> @@ -76,10 +76,6 @@ static inline void fsnotify_clear_marks_by_sb(struct super_block *sb)
>   */
>  extern void __fsnotify_update_child_dentry_flags(struct inode *inode);
>  
> -/* allocate and destroy and event holder to attach events to notification/access queues */
> -extern struct fsnotify_event_holder *fsnotify_alloc_event_holder(void);
> -extern void fsnotify_destroy_event_holder(struct fsnotify_event_holder *holder);
> -
>  extern struct kmem_cache *fsnotify_mark_connector_cachep;
>  
>  #endif	/* __FS_NOTIFY_FSNOTIFY_H_ */
> -- 
> 2.25.1
> 
