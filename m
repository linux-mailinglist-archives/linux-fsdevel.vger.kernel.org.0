Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC454560E2F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 02:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiF3AsH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jun 2022 20:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiF3AsH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jun 2022 20:48:07 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC13C2F;
        Wed, 29 Jun 2022 17:48:06 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id w83so23975183oiw.1;
        Wed, 29 Jun 2022 17:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vlWcreAQDwZHu5EpZovJb8TbUi6QeIHo7octOq1kCoU=;
        b=LhYU9+vEWIBDOh4wI2eS6Tte5bKZJ9g8UVOzlHqUhYNoR1TLprZkjdXNuHZP2+/gYC
         TMmNU4N0tmT1DJ1Q0xihsWw7+rxirU4Ck97l6vzIJ9mM7+IntiZvmikdaFYSeBOk9IvM
         VHYRcN6kBMvP2G1o1IOipbm6lWC/Z7hhrODdPpjJQZDqZzs/QdW9+ag4lheTG8baUtlk
         RJSMI7P2RR4iUM9nxUPjofLWVAfz3G6i22W+KSA7AkwWajfQ7FhLZ/snegSi325PpzUo
         b2jtLDvhVoRvAhyv1wrm9Re/JGOa1ew/TKgdZfQcjdxfEzs978Xl2cZ496jgtNWRyqAF
         rkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vlWcreAQDwZHu5EpZovJb8TbUi6QeIHo7octOq1kCoU=;
        b=xy1j8steTz8sjo1OoFS+RFpY/1M+ePO9/68NrfxhqRSgWuvOZ/KE4Dgcgio9fOWpn9
         oiLsCnyZhr+TWoSpr3lRIYeQ997MtSSgsrrRdhwMMOpKCHBgxG3Uztxq97vdu4q9IfXx
         LqQ+K0UfJYZhsRwCsps3MvSP/sIgVZ2yclIE8dxKjQkhc7zE1KJNGJ5BZS3b+bkgyJ1A
         fs2sWnPFlZ+2ikdp21dj30YYU9loFS7A+aMovqdq5ghU5DaIpZ/qZBHv6TH9qT5h5aD1
         boMUMV57RqYDZbYA2hjxIsyr+xVc6Z/hMs88PL3wcjxhIhky/8A7z8rb/BjdF/4aSlX8
         lUHg==
X-Gm-Message-State: AJIora+rjAOwPHt+i5UM7NZqUMKP8eOyvpozUC/8FIUQ3kT8TsQtJzw1
        KVCZ3YXnDfLn9KEEnAic0e30uy/DVz7sbKcapyc=
X-Google-Smtp-Source: AGRyM1vu3Cyb+ZseP9e3PFjRsT1FqHUJUZQnECa3Ip5zDwFOWqj3C7gSihUEZsLLgZzkpF/tR3ndrcZa5bNU1SpIo7k=
X-Received: by 2002:aca:1113:0:b0:335:6d08:31a2 with SMTP id
 19-20020aca1113000000b003356d0831a2mr3944081oir.258.1656550085532; Wed, 29
 Jun 2022 17:48:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220629072932.27506-1-jiaming@nfschina.com>
In-Reply-To: <20220629072932.27506-1-jiaming@nfschina.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Thu, 30 Jun 2022 06:17:55 +0530
Message-ID: <CAFqt6zZivU3XJmjwdCqhSJBAoNwWfJZeUipG4es4u+iaEnDGtw@mail.gmail.com>
Subject: Re: [PATCH] exec: Fix a spelling mistake
To:     Zhang Jiaming <jiaming@nfschina.com>
Cc:     ebiederm@xmission.com, Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel@vger.kernel.org, liqiong@nfschina.com,
        renyu@nfschina.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 29, 2022 at 1:07 PM Zhang Jiaming <jiaming@nfschina.com> wrote:
>
> Change 'wont't' to 'won't'.
>
> Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>

Reviewed-by: Souptick Joarder (HPE) <jrdr.linux@gmail.com>
> ---
>  fs/exec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/exec.c b/fs/exec.c
> index 96b9847fca99..5f0656e10b5d 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1156,7 +1156,7 @@ static int de_thread(struct task_struct *tsk)
>                 /*
>                  * We are going to release_task()->ptrace_unlink() silently,
>                  * the tracer can sleep in do_wait(). EXIT_DEAD guarantees
> -                * the tracer wont't block again waiting for this thread.
> +                * the tracer won't block again waiting for this thread.
>                  */
>                 if (unlikely(leader->ptrace))
>                         __wake_up_parent(leader, leader->parent);
> --
> 2.34.1
>
>
