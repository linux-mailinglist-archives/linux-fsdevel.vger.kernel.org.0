Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A71362F0F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Nov 2022 10:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241857AbiKRJUr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Nov 2022 04:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241870AbiKRJUo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Nov 2022 04:20:44 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E60FF6
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Nov 2022 01:20:42 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id a5so6262249edb.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Nov 2022 01:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2Ood0JdlHapy0qlBoWOZpW3bqw5R6j3w0iumWkTESo=;
        b=kfqhFz6vYHG2FpQmqzp05UjlDzTafnryN/GKS5hGhTY1xlZHLxfFQvsXsjx5yblFyV
         VzCU85872Gykj622Wz1t/LYLapO/sRmPW2udjLyrPHyC7zkLNLN/AnbLju1dx3vDEjJv
         3oLW/iLUqcQGb4ti1eYGAvxpVKt6iLiEMZEVi8wYoMfi8eHsTu97+ZHR//xNWH6acREf
         psBFEv3U+uyCi9AWX9Zt/3BOJ1vgu+HsaOhn9EGrWvOE6J+ZNimhs5iw/Gpfbk//u7dC
         IrxvvOXFnewbtzmCi3MqnebhWs2bt/0jV5QWW55090bPUuDyjji3waXqCwhz1YvRN8jF
         CmwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2Ood0JdlHapy0qlBoWOZpW3bqw5R6j3w0iumWkTESo=;
        b=EuZZEFHnlYSPiH+ltmOWv9+iW4c38r8RFxkupnkzHWPxkN3dQShORsj+psj3KtSYsm
         D5joEtCMg96HZfya4bMQK9J9x27NSWj0a6J61L+jSRSCJH9KXb7mGKtYxYwKiQL0mJF4
         BdMuXveeHIacKsytG1BdtlHC4PdXK5LLDjhjLlB891lTANLVkEhD82E0QFTR+yqMf+Ya
         cXMEubXuiKG2Il0DpjVAUZMJJ032+fKvjal3bzW25AkXHZQwhfiL1aiL4bxX0yyuU4kg
         AbLZV6SVfbGlwcGgbc/G9HVi83VLj06CCH9VRJzYHeer3eimZTxl5PlgfEevzLpUF0KI
         njOQ==
X-Gm-Message-State: ANoB5pmj19Tw5070ii1h7D+NroKAjqfKeKjB3wd42I9K1RdFDWeUZbTv
        MK0v4NcOTKybk/nZfTZ6m/pUz2TQFlyBjzFb2GeW+I5wG2s=
X-Google-Smtp-Source: AA0mqf6HmUiA0eiPD6JeYGVao1ZRpIAVCCxDJYtF3gS/Pkym22Ib8AmNJ4pvv+5//Ch97KkjRX43LvTa4yhzD5zHFpA=
X-Received: by 2002:a50:fd98:0:b0:467:5f07:b575 with SMTP id
 o24-20020a50fd98000000b004675f07b575mr5466054edt.65.1668763240957; Fri, 18
 Nov 2022 01:20:40 -0800 (PST)
MIME-Version: 1.0
References: <20221114110253.8827-1-sunjunchao2870@gmail.com>
In-Reply-To: <20221114110253.8827-1-sunjunchao2870@gmail.com>
From:   JunChao Sun <sunjunchao2870@gmail.com>
Date:   Fri, 18 Nov 2022 17:20:27 +0800
Message-ID: <CAHB1NajAZZ86js_cgzovsQ8AFV=otWQfmWVTiX+-kbV41+Ne-Q@mail.gmail.com>
Subject: Re: [PATCH] writeback: Remove meaningless comment
To:     linux-fsdevel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, axboe@kernel.dk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

friendly ping...

JunChao Sun <sunjunchao2870@gmail.com> =E4=BA=8E2022=E5=B9=B411=E6=9C=8814=
=E6=97=A5=E5=91=A8=E4=B8=80 19:03=E5=86=99=E9=81=93=EF=BC=9A
>
> nr_pages was removed in 9ba4b2dfafaa
> ("fs: kill 'nr_pages' argument from wakeup_flusher_threads()"),
> but the comment for 'nr_pages' was missed. Remove that.
>
> Signed-off-by: JunChao Sun <sunjunchao2870@gmail.com>
> ---
>  fs/fs-writeback.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 443f83382b9b..78be6762522a 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -2244,10 +2244,6 @@ void wb_workfn(struct work_struct *work)
>                 wb_wakeup_delayed(wb);
>  }
>
> -/*
> - * Start writeback of `nr_pages' pages on this bdi. If `nr_pages' is zer=
o,
> - * write back the whole world.
> - */
>  static void __wakeup_flusher_threads_bdi(struct backing_dev_info *bdi,
>                                          enum wb_reason reason)
>  {
> --
> 2.17.1
>
