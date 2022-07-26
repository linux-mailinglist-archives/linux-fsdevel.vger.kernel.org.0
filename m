Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A16580FCF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jul 2022 11:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237522AbiGZJYR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jul 2022 05:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238069AbiGZJYN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jul 2022 05:24:13 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24665313B2;
        Tue, 26 Jul 2022 02:24:11 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 26Q9NY5k018458;
        Tue, 26 Jul 2022 18:23:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 26Q9NY5k018458
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1658827416;
        bh=suUWYzVOY7FlQPtXbW2xKgn26g78PFV4KRYYwLKjSVY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Qr8kpyxY8zGQpoJ4/6KdW3z0WglY2sF1dm65NG86Iafc1XuhRdbnP2nhichdJPIFX
         5lnS7vOwbw0lbFjrn/NiigJXCORpPg4lz05P6mZmgE8mXJhRjpsMMJHOf2ycWcQmd7
         9djySl6cLeQ/1bnRZCoqx8n88lTsgiAarXkpAGn8iM86grTOOVha9WlE+gmbMt0ck0
         yGXlKjiWOhOkHMHVsFbJSAuC+bXyxqfcwmRWsyT9qo6TAecS67u69CPRJBitdY43oT
         XtboHvaR7xiw3gVNnvZv080aFb2keEKJBehfmWLL5/A2Sfjty5r4/bAdH+/AY9jX2d
         tdU3FOtTWVQVg==
X-Nifty-SrcIP: [209.85.128.49]
Received: by mail-wm1-f49.google.com with SMTP id w8-20020a05600c014800b003a32e89bc4eso7778882wmm.5;
        Tue, 26 Jul 2022 02:23:35 -0700 (PDT)
X-Gm-Message-State: AJIora8uN/XTy4dIqO+2gCB49c5spDuioJ8fBcBHUnUe1fG9hP2BJt4z
        5LuRn4ownK+SApIdyLq+kqU00Lg9+n2PwSrX+gM=
X-Google-Smtp-Source: AGRyM1vdAioWMgMeyjvnhKf6Et3OoTadOF2/0EqoJYDW7HanfxQoQtpASvWPrZaycwTmkbKzEgxDVE2NOKXRVzlG0HM=
X-Received: by 2002:a05:600c:a18e:b0:3a3:10ef:672a with SMTP id
 id14-20020a05600ca18e00b003a310ef672amr23296583wmb.14.1658827413858; Tue, 26
 Jul 2022 02:23:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220722022416.137548-1-mfo@canonical.com> <20220722022416.137548-7-mfo@canonical.com>
In-Reply-To: <20220722022416.137548-7-mfo@canonical.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 26 Jul 2022 18:22:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNARbSjmZgp1vg5m2j4oRYHgCUv7Wsj+4-OYdo9Cpe0Xs3A@mail.gmail.com>
Message-ID: <CAK7LNARbSjmZgp1vg5m2j4oRYHgCUv7Wsj+4-OYdo9Cpe0Xs3A@mail.gmail.com>
Subject: Re: [RFC PATCH 6/6] sysctl: introduce /proc/sys/kernel/modprobe_sysctl_alias
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-modules <linux-modules@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 22, 2022 at 11:24 AM Mauricio Faria de Oliveira
<mfo@canonical.com> wrote:
>
> The goal of the earlier patches is to let sysctl userspace tools
> load the kernel module with a sysctl entry that is not available
> yet in /proc/sys/ when the tool runs (so it can become available).
>
> Let's expose this file for userspace for two reasons:
>
> 1) Allow such tools to identify that the running kernel has the
>    code which produces sysctl module aliases, so they could run
>    'modprobe sysctl:<entry>' only when it may actually help.
>
> 2) Allow an administrator to hint such tools not to do that, if
>    that is desired for some reason (e.g., rather have the tools
>    fail if something is misconfigured in a critical deployment).

This flag is just a hint.
User-space tools are still able to ignore it.

Perhaps, such administrator's choice might be specified in
tools' configuration file.

For example,

/etc/modprobe.d/forbid-sysctl-alias.conf

may specify

    blacklist:  sysctl:*

if they want to forbid sysctl aliasing.
(but I do not know if this works or not).














> Also add a module parameter for that (proc.modprobe_sysctl_alias),
> for another method that doesn't depend on sysctl tools to be set
> (that wouldn't fail them to try and set it if it's not there yet).
>
> Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
> ---
>  fs/proc/proc_sysctl.c  | 8 ++++++++
>  include/linux/module.h | 1 +
>  kernel/sysctl.c        | 9 +++++++++
>  3 files changed, 18 insertions(+)
>
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index ebbf8702387e..1e63819fcda8 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -33,6 +33,14 @@ static void check_struct_sysctl_device_id(void)
>         BUILD_BUG_ON(offsetof(struct sysctl_device_id, procname)
>                         != offsetof(struct ctl_table, procname));
>  }
> +
> +/*
> + * Hint sysctl userspace tools whether or not to run modprobe with sysctl alias
> + * ('modprobe sysctl:entry') if they cannot find the file '/proc/sys/.../entry'
> + */
> +int modprobe_sysctl_alias = 1;
> +module_param(modprobe_sysctl_alias, int, 0644);
> +
>  #else
>  static void check_struct_sysctl_device_id(void) {}
>  #endif
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 3010f687df19..5f565491c596 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -304,6 +304,7 @@ struct notifier_block;
>  #ifdef CONFIG_MODULES
>
>  extern int modules_disabled; /* for sysctl */
> +extern int modprobe_sysctl_alias; /* for proc sysctl */
>  /* Get/put a kernel symbol (calls must be symmetric) */
>  void *__symbol_get(const char *symbol);
>  void *__symbol_get_gpl(const char *symbol);
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 15073621cfa8..b396cfcb55fc 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1763,6 +1763,15 @@ static struct ctl_table kern_table[] = {
>                 .mode           = 0644,
>                 .proc_handler   = proc_dostring,
>         },
> +#ifdef CONFIG_PROC_SYSCTL
> +       {
> +               .procname       = "modprobe_sysctl_alias",
> +               .data           = &modprobe_sysctl_alias,
> +               .maxlen         = sizeof(modprobe_sysctl_alias),
> +               .mode           = 0644,
> +               .proc_handler   = proc_dointvec,
> +       },
> +#endif
>         {
>                 .procname       = "modules_disabled",
>                 .data           = &modules_disabled,
> --
> 2.25.1
>


--
Best Regards
Masahiro Yamada
