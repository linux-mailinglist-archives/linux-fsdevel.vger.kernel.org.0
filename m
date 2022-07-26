Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B648580FD9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jul 2022 11:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237807AbiGZJ1V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jul 2022 05:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiGZJ1U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jul 2022 05:27:20 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117D02E9F6;
        Tue, 26 Jul 2022 02:27:18 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 26Q9QrdN024374;
        Tue, 26 Jul 2022 18:26:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 26Q9QrdN024374
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1658827614;
        bh=d6NNJ+nW6fZ2WWBYBA5DCiVLw0ZFlnZQJAM4KipXE4A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jPARB7HAapfEkUCDpves2bids8NaztvHxYcrpmaz30aXBKKCq5Fls6fPm6JMl4NEB
         A+CXQn86ICJNahuYe+wJUVp4X42qyknJGMTFem8Fg39gyqprHgP6bGqygnGJySLLpY
         Fi0TJ4n8AGHy1QHghgmYAb6tG67BBglbtafIao4SUkicjwCuxWlMCf234yupSWwONe
         QXTA/NB4xuFdazVACjtFGA/3J6GXfrlFE7KiQy3L10fGJswdIINwUuYL80GwdwbA/X
         1oaSD81CRh1UXkmTAspo/hdqn56A4uPd0xGP0lEi/wZspTN5MpNFXg4n7sMAhQFY4U
         xr5ezJ4ImSfvQ==
X-Nifty-SrcIP: [209.85.128.41]
Received: by mail-wm1-f41.google.com with SMTP id w8-20020a05600c014800b003a32e89bc4eso7783829wmm.5;
        Tue, 26 Jul 2022 02:26:53 -0700 (PDT)
X-Gm-Message-State: AJIora/2pKak2LpGwKZTl3vd0m6XP8zASBoBMlLp0+mjXsh8PgPb+uHl
        x6DEomJxckWccPXLwh36ZnUSnHhXNk2KwJ6TOHg=
X-Google-Smtp-Source: AGRyM1uGeaCDAN8z8yKxHxFJ9V3AepuKKOjXcNTD81j1E/+9R+DcEVLuRRv9FUeLk7HNSkZXBvwGr+EHMfBpPdhcGfg=
X-Received: by 2002:a05:600c:35ce:b0:3a3:1b7f:bbd8 with SMTP id
 r14-20020a05600c35ce00b003a31b7fbbd8mr11063089wmq.22.1658827612274; Tue, 26
 Jul 2022 02:26:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220722022416.137548-1-mfo@canonical.com> <20220722022416.137548-4-mfo@canonical.com>
In-Reply-To: <20220722022416.137548-4-mfo@canonical.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 26 Jul 2022 18:25:51 +0900
X-Gmail-Original-Message-ID: <CAK7LNARvJEhEOwg_PHe3WKT9BkSchnGOmeiUaB+7E__NS9qrVw@mail.gmail.com>
Message-ID: <CAK7LNARvJEhEOwg_PHe3WKT9BkSchnGOmeiUaB+7E__NS9qrVw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/6] sysctl, mod_devicetable: shadow struct
 ctl_table.procname for file2alias
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
> In order to expose a sysctl entry to modpost (file2alias.c, precisely)
> we have to shadow 'struct ctl_table' in mod_devicetable.h, as scripts
> should not access kernel headers or its types (see file2alias.c).
>
> The required field is '.procname' (basename of '/proc/sys/.../entry').
>
> Since 'struct ctl_table' is annotated for structure randomization and
> we need a known offset for '.procname' (remember, no kernel headers),
> take it out of the randomized portion (as in, eg, 'struct task_struct').
>
> Of course, add build-time checks for struct size and .procname offset
> between both structs. (This has to be done on kernel side; for headers.)
>
> With that in place, use the regular macros in devicetable-offsets.c to
> define SIZE_... and OFF_... macros for the shadow struct and the field
> of interest.
>
> Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
> ---
>  fs/proc/proc_sysctl.c             | 19 +++++++++++++++++++
>  include/linux/mod_devicetable.h   | 25 +++++++++++++++++++++++++
>  include/linux/sysctl.h            | 11 ++++++++++-
>  kernel/sysctl.c                   |  1 +
>  scripts/mod/devicetable-offsets.c |  3 +++
>  5 files changed, 58 insertions(+), 1 deletion(-)
>
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index 021e83fe831f..ebbf8702387e 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -19,6 +19,24 @@
>  #include <linux/kmemleak.h>
>  #include "internal.h"
>
> +#ifdef CONFIG_MODULES
> +#include <linux/mod_devicetable.h>
> +
> +static void check_struct_sysctl_device_id(void)
> +{
> +       /*
> +        * The shadow struct sysctl_device_id for file2alias.c needs
> +        * the same size of struct ctl_table and offset for procname.
> +        */
> +       BUILD_BUG_ON(sizeof(struct sysctl_device_id)
> +                       != sizeof(struct ctl_table));
> +       BUILD_BUG_ON(offsetof(struct sysctl_device_id, procname)
> +                       != offsetof(struct ctl_table, procname));


Nit:

If you use static_assert(), you can remove
 check_struct_sysctl_device_id().


You can write static_assert() out of a function.



> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 223376959d29..15073621cfa8 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -2487,6 +2487,7 @@ int __init sysctl_init_bases(void)
>
>         return 0;
>  }
> +


Noise.




>  #endif /* CONFIG_SYSCTL */
>  /*
>   * No sense putting this after each symbol definition, twice,
> diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
> index c0d3bcb99138..43b2549940d2 100644
> --- a/scripts/mod/devicetable-offsets.c
> +++ b/scripts/mod/devicetable-offsets.c
> @@ -262,5 +262,8 @@ int main(void)
>         DEVID(ishtp_device_id);
>         DEVID_FIELD(ishtp_device_id, guid);
>
> +       DEVID(sysctl_device_id);
> +       DEVID_FIELD(sysctl_device_id, procname);
> +
>         return 0;
>  }
> --
> 2.25.1
>


-- 
Best Regards
Masahiro Yamada
