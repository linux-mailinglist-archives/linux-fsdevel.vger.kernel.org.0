Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9FEC63ABD2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Nov 2022 16:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbiK1PAF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Nov 2022 10:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiK1PAE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Nov 2022 10:00:04 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960B11FD;
        Mon, 28 Nov 2022 07:00:03 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id jn7so10380763plb.13;
        Mon, 28 Nov 2022 07:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j/MaosVFQQsX/2ZeBD2PKV/fnro6FuwwDeFZbx0/DJE=;
        b=AD3LarQoCcw0nSAUuMEy2jyzdf+DZNjS2mlDtY8K6Nwoxp3733ezm4m5RDwws9IxI4
         UZJUS3GcupliuAcZPJZkf/5SEYPr6ONwgHXy9j12ZYvf37fEQe0hB1L1gD308ZF0/tR0
         BTjvC2nD/lAPOsgUAtxC8wdHbgsk/9tQywY0TGXvtb7SXUmn6WrI1AjGEFQto4P8CzqR
         duYZqpjfO3MsS6iGcP0Nw/BTgjFXINknn7C0Tk1JvHDozhhT5aqVDh947kBbWkQbO+aH
         aS4Y9S6r21NTnPyN1ypaP8hSyQwPcLWr2g9WpBf/fNaHGZ8Ss27oCqAaxSEFx7rt7wsP
         RKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j/MaosVFQQsX/2ZeBD2PKV/fnro6FuwwDeFZbx0/DJE=;
        b=TBYvnv3I7Y3Rc4bu+reyN+BmFG+smRguIrmA0MvScY6JZCtj/YcWYqfxiT1hwgkQbt
         mPliqeJGH3nQ4+HGku+PKcTsQo+8MC9o8qTot6MiuJik8uxTG7dmIZ8RJ74FAklioaTQ
         qv9lSD+PrqrwmsH6ABBWGKHmmvKpXjUyCpaFj+r6oImQnzes1Buk9Zvok1oljOU34d+R
         fIqmt3hcxGcYCkpCDd7eUSOTQhQAJTCncSnzZLrG4Lu7wRwJFBk2p5iWuqFxzZcWCblG
         8W4cx2/Qw4tMYXMdUc+7m6VAK4RT78+4zJk6Fh8n5kxKXIss3+TiMEmKcqnXe7XjDzhT
         NPGA==
X-Gm-Message-State: ANoB5plUockUx4egbI2VAyGPkg+N2i++0U8XZe42oelogmCUiTBs7GyJ
        XOjHTWjywNj5Y0oRw9uqRAw=
X-Google-Smtp-Source: AA0mqf6dh5FK6hgl6TiR2NaTWzu983s2UxU2418uDwccwki/iX7MqwluyRwqn4i2Nu7pCjhEe5U6+w==
X-Received: by 2002:a17:90a:9a98:b0:219:2f90:4fb3 with SMTP id e24-20020a17090a9a9800b002192f904fb3mr7285337pjp.109.1669647603007;
        Mon, 28 Nov 2022 07:00:03 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:56ba:c531:2cb5:9601])
        by smtp.gmail.com with ESMTPSA id gc8-20020a17090b310800b002192f87474fsm2722531pjb.37.2022.11.28.07.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 07:00:02 -0800 (PST)
Date:   Mon, 28 Nov 2022 20:29:56 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coredump: fix compile warning when ELF_CORE=n while
 COREDUMP=y
Message-ID: <20221128145956.6rgswicmtsuxxhdt@riteshh-domain>
References: <20221128135056.325-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221128135056.325-1-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/11/28 09:50PM, Jisheng Zhang wrote:
> fix below build warning when ELF_CORE=n while COREDUMP=y:
>
> fs/coredump.c:834:12: warning: ‘dump_emit_page’ defined but not used [-Wunused-function]
>   834 | static int dump_emit_page(struct coredump_params *cprm, struct
>       page *page)
>       |            ^~~~~~~~~~~~~~

Fixes: 06bbaa6dc53c: "[coredump] don't use __kernel_write() on kmap_local_page()"

>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  fs/coredump.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/coredump.c b/fs/coredump.c
> index 7bad7785e8e6..8663042ebe9c 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -831,6 +831,7 @@ static int __dump_skip(struct coredump_params *cprm, size_t nr)
>  	}
>  }
>
> +#ifdef CONFIG_ELF_CORE

Instead of this ^^^, we could even move the definition of dump_emit_page() in
the same #ifdef as of dump_user_range(). Since dump_user_range() is the only
caller of dump_emit_page().

#ifdef CONFIG_ELF_CORE
[here]
int dump_user_range(struct coredump_params *cprm, unsigned long start,
		    unsigned long len)
{..}
#endif

But I guess that's just a nitpick. Feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

-ritesh

>  static int dump_emit_page(struct coredump_params *cprm, struct page *page)
>  {
>  	struct bio_vec bvec = {
> @@ -863,6 +864,7 @@ static int dump_emit_page(struct coredump_params *cprm, struct page *page)
>
>  	return 1;
>  }
> +#endif
>
>  int dump_emit(struct coredump_params *cprm, const void *addr, int nr)
>  {
> --
> 2.37.2
>
