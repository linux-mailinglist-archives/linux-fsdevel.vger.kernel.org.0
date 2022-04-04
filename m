Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5064F1B2C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 23:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379484AbiDDVTs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 17:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379509AbiDDRSy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 13:18:54 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188BB13F77
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Apr 2022 10:16:58 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id s13so13808346ljd.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Apr 2022 10:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=42+DYObs0d//YPwipHE3d3izqDTdKuFvDHGNlUWoBx4=;
        b=ryB3WQniryeQTcsabtEMlk77sINOiDMjNnKxQIAPWIDWkgT2HeYr5YNp6DI6AxlrBR
         8fCQ5/lZHreREixoEVspMKO0H9IWt5XPvMwwVhey1g+3nGovFlOSfkDV0fB+9JHSyYww
         MfOlG9ttuJqR+MT95v3VjjepW6WKMqyiEifEd4jSbTESt3OkiuCI9dtDpTgNAJdCfa52
         52rZGeBuik8PbNlp7p70U2xxAl9hUAFZLO3frntLBrwofTgyaMBYv01U5bBe80qh7Dre
         A5puCYMeYPj9WlgAEVQoKrpAdNhAm82ngof0dDWWwAWwi9Ke06cvxAHP01nxxBjhXxtI
         /thg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=42+DYObs0d//YPwipHE3d3izqDTdKuFvDHGNlUWoBx4=;
        b=PQupTe98xIDEAEXm7UHBTsmU4Km6pC0hhwm1T7wzRWxCDYhIqDWrmvtBvqWUJww8pc
         0oIxCKcRjzxbGZ6lzN3IVIeLJQ9TEyrBzv1GgyXrbiTPFSlqravUB+r40yNQBeNFoZDr
         ChrPwA2hCdpuCCVet82WeHFg0OE4Sf0p7+6D9dv6ltMA4lTXmfCCO6C5SaKAEJmQnRjc
         aB+fB6ZWGYf+kMJFGJwLrrMwqczy50zAlthMB0y7qkNL+NHUOo/elhmDwaHfmFbSQqii
         mQpxnSSlhRnJuiS6GDfdUKc0/shRe+p/d+No2nQ5Km+kIUHixsZyq8YBHr1BndqE8v1X
         0fAA==
X-Gm-Message-State: AOAM533X3rVJEuEEjw/kiXVtSRbyrONEYSf4j5au1O1XY9qyDC7uhm11
        aQMrKeViQ1fjNhgBEil0HuLvRlGP1pkFXHoQJL8EWKGR8+y3Yw==
X-Google-Smtp-Source: ABdhPJzCr2hVN0gAAJB3yXGwvjHdQ4zEVxVEi7K2YofZ59SQ5b8dfqk23Flzm5EuxCaAEcQZt2M7qWFk0KKWja6DeYg=
X-Received: by 2002:a05:651c:555:b0:24b:15b7:74ad with SMTP id
 q21-20020a05651c055500b0024b15b774admr361740ljp.239.1649092616178; Mon, 04
 Apr 2022 10:16:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220402084746.2413549-1-lv.ruyi@zte.com.cn>
In-Reply-To: <20220402084746.2413549-1-lv.ruyi@zte.com.cn>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 4 Apr 2022 10:16:44 -0700
Message-ID: <CAKwvOdk=_a98oaJxmYJsk_sjeBg1yELmpFeOKe1Cbox2vnVi4Q@mail.gmail.com>
Subject: Re: [PATCH] fs/buffer.c: remove unneeded code
To:     cgel.zte@gmail.com
Cc:     viro@zeniv.linux.org.uk, nathan@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 2, 2022 at 1:47 AM <cgel.zte@gmail.com> wrote:
>
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
>
> fix clang warning: Value stored to 'err' is never read in line 2944.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>

The change LGTM, but next time please consider putting the exact text
of the warning observed in the commit message.  For instance, it's not
clear to me whether this was a compiler warning via -W flag, or a
DeadStore warning from clang-tidy.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  fs/buffer.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/fs/buffer.c b/fs/buffer.c
> index bfc566de36e5..b2045871e81c 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2941,7 +2941,6 @@ int block_truncate_page(struct address_space *mapping,
>                 pos += blocksize;
>         }
>
> -       err = 0;
>         if (!buffer_mapped(bh)) {
>                 WARN_ON(bh->b_size != blocksize);
>                 err = get_block(inode, iblock, bh, 0);
> --
> 2.25.1
>


-- 
Thanks,
~Nick Desaulniers
