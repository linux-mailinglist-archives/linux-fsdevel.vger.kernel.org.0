Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492B47370B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 17:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjFTPk7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 11:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjFTPk6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:40:58 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA8D198E;
        Tue, 20 Jun 2023 08:40:39 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-47167a4ce3cso1304011e0c.2;
        Tue, 20 Jun 2023 08:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687275639; x=1689867639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ImkbtTBshXFrTu51toIVTeMzpJA/vCS2rButKUG6s6U=;
        b=hdsZCoGcUqoptZOvRI+VwvkDGnv+M0jUmluDg0Tdi6HXiySwa9LXh46U6MdnFmh/4d
         d0ydNoXRUgOlDzxZXt3/LC6bLaaT55BZqok9vPsOBjlhT+dYhV+jXenxTli1uXps8y4I
         6L8bft0Pt4DJNUXlbSOeA1NY1uY5y9vCu3D+Br4ncGNwC1DMMnHKPF/BNTVyD9s466He
         cHdPnROzvvi71kaE3Qof4mb++BjYSbrIgsGBRhu2+8tfLxZafA/UF98R2GXUq3ctXcHs
         H8FqepyMA6DYTR+FiVhG6W6LccnyEd6yDG7eW3b98D9J6vRENRNMbJInnSWFfPehpyjF
         /TmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687275639; x=1689867639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ImkbtTBshXFrTu51toIVTeMzpJA/vCS2rButKUG6s6U=;
        b=ieH8wd4VSj+jya2MfJKukn1PEAf/CWJh34uBh300UkmCeXpH+RJEEe9c4r0rvmB6nk
         +8lO500fVK4ODeYhKrxiwfoMwNxr1BaFs+psAW5CwkHs2wf9gKGE5McbgR3BkQxPByCa
         11rQP+IBdfNzK2mQvkRqMGOktV4LpGvB/t6GbEiAvbNdqWWztfv0OUFcPZVY83Ocx9Y2
         Q0e24WaBdGx5QjqJa9gJuURp3TEg1rWThRokXX4lVBFKLBqUJKea7gzNBcJ6NKZvxjbp
         8gY3v+xqvgG0wqsRJu688maHaAVWgWRFRWflA68aDfwLLNhj925kx01aovRD2kLc/Of/
         FTzA==
X-Gm-Message-State: AC+VfDzxtMcjIuVupwcnMKzlXCqWscgXNKbGih4hvzF5zE9GUb7QTy/K
        /+w2vpOH5NH6V0hEVakNCgkPpRTJVEWz53cJ7LA=
X-Google-Smtp-Source: ACHHUZ6dKTU0vB6WjettzF9j1VMkV0hjR/PKt7GwtfhYlpeV44H9FzU2LnL0HWod1q9xqX8qdoRaEj/dbCjkQIcMGp8=
X-Received: by 2002:a67:de05:0:b0:440:cac4:5e40 with SMTP id
 q5-20020a67de05000000b00440cac45e40mr1097086vsk.35.1687275638728; Tue, 20 Jun
 2023 08:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230620-fs-overlayfs-mount-api-remount-v1-1-6dfcb89088e3@kernel.org>
In-Reply-To: <20230620-fs-overlayfs-mount-api-remount-v1-1-6dfcb89088e3@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 20 Jun 2023 18:40:27 +0300
Message-ID: <CAOQ4uxjeDRyLHJHYg9Rb2nwc4E6GnR+=7FCyoU1MyvH7-vH-6A@mail.gmail.com>
Subject: Re: [PATCH] ovl: reserve ability to reconfigure mount options with
 new mount api
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 20, 2023 at 2:42=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> Using the old mount api to remount an overlayfs superblock via
> mount(MS_REMOUNT) all mount options will be silently ignored. For
> example, if you create an overlayfs mount:
>
>         mount -t overlay overlay -o lowerdir=3D/mnt/a:/mnt/b,upperdir=3D/=
mnt/upper,workdir=3D/mnt/work /mnt/merged
>
> and then issue a remount via:
>
>         # force mount(8) to use mount(2)
>         export LIBMOUNT_FORCE_MOUNT2=3Dalways
>         mount -t overlay overlay -o remount,WOOTWOOT,lowerdir=3D/DOESNT-E=
XIST /mnt/merged
>
> with completely nonsensical mount options whatsoever it will succeed
> nonetheless. This prevents us from every changing any mount options we
> might introduce in the future that could reasonably be changed during a
> remount.
>
> We don't need to carry this issue into the new mount api port. Similar
> to FUSE we can use the fs_context::oldapi member to figure out that this
> is a request coming through the legacy mount api. If we detect it we
> continue silently ignoring all mount options.
>
> But for the new mount api we simply report that mount options cannot
> currently be changed. This will allow us to potentially alter mount
> properties for new or even old properties. It any case, silently
> ignoring everything is not something new apis should do.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>

Looks good and tests passed.
I Applied this to overlayfs-next on my github.

Miklos,

Please update your branch.

Thanks,
Amir.

> ---
>  fs/overlayfs/super.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index ed4b35c9d647..c14c52560fd6 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -499,13 +499,24 @@ static int ovl_parse_param(struct fs_context *fc, s=
truct fs_parameter *param)
>         struct ovl_fs_context *ctx =3D fc->fs_private;
>         int opt;
>
> -       /*
> -        * On remount overlayfs has always ignored all mount options no
> -        * matter if malformed or not so for backwards compatibility we
> -        * do the same here.
> -        */
> -       if (fc->purpose =3D=3D FS_CONTEXT_FOR_RECONFIGURE)
> -               return 0;
> +       if (fc->purpose =3D=3D FS_CONTEXT_FOR_RECONFIGURE) {
> +               /*
> +                * On remount overlayfs has always ignored all mount
> +                * options no matter if malformed or not so for
> +                * backwards compatibility we do the same here.
> +                */
> +               if (fc->oldapi)
> +                       return 0;
> +
> +               /*
> +                * Give us the freedom to allow changing mount options
> +                * with the new mount api in the future. So instead of
> +                * silently ignoring everything we report a proper
> +                * error. This is only visible for users of the new
> +                * mount api.
> +                */
> +               return invalfc(fc, "No changes allowed in reconfigure");
> +       }
>
>         opt =3D fs_parse(fc, ovl_parameter_spec, param, &result);
>         if (opt < 0)
>
> ---
> base-commit: cc7e4d7ce5ea183b9ca735f7466b4491a1ee440e
> change-id: 20230620-fs-overlayfs-mount-api-remount-93b210e6ccd8
>
