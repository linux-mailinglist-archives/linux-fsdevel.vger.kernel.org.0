Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1380C5FADCF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Oct 2022 09:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiJKHv6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Oct 2022 03:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiJKHvu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Oct 2022 03:51:50 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D4CA450
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Oct 2022 00:51:48 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id i20so4726300ual.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Oct 2022 00:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vc7NDTHNwCOb+RPvEeMoxB0AoOQKOxkhjrJXDMGxTp4=;
        b=cklujjorezmx5v220APZMQp0R+Ertx4G722M5cJTgUIcwEFRufVDRLUxV8MEo3y1OS
         zUxOjIUS13zBnziQFJ//JH7jQXRQirQN3x2EOM83tg1Wy0B7ZX+bY2czOPW1nJ2hU8oB
         JuFxxrUDuEffNii5gS6S8cv2d71ocxZnc+KVAXBYwY19YypG0jEzFYhAlPS2XCr7kkl8
         NQ82pThV7iL/0QfFoPDNu49p5MH0qG8SaDvGv8aEiTxQStCHODekxZHRn1vHtR1E8x43
         RtGzfNOwyy56SCFTfp7sMRqniCNaY7mVMw5YZRu4c4JwFGPyAttPmrilgalewgNFcKAU
         8eyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vc7NDTHNwCOb+RPvEeMoxB0AoOQKOxkhjrJXDMGxTp4=;
        b=QqjPeXEhwXmLVOAWR1eWE2nYz7sRKqrCeEuE/a+nNgMffCZOgLnhLppIoNKs8bwcT5
         I3oXUQ34/Z8QUSMGf3uHlfAp/tfm8Reo9utpfIb+ED8iWifBAzbfMUJBHu1qcXZFrK5p
         uRLG+G9tUDFcPwzAHONXPHfWS6Qk5iX+tW1v2ByPcMl8VtUk/3M5pNdePt1FRPC5sTCh
         PGf6suUnmB3GBqJXB8pd2VHuGL9Lw57yvrFl9Dj5YvcDDkjOM/VNWchHBbno1dDKiGtc
         DUQJeuKYyXs4GncJzHIFQrzL+B0P0SU/qxIWuG43Hvt3z5rlZqy5mW+wyhv4t/KlcluI
         PWhQ==
X-Gm-Message-State: ACrzQf2RYNptsm2tTEQPfjt5pRjQ9ksfQdEvyhZUolJohfgGKLVH+fiM
        WfLJWLA2tSynXuwZvD2KI2ph20ym3OsapMBbWQg=
X-Google-Smtp-Source: AMsMyM7UbPSc4IOwirjUMZhrL8hl9a2gFVGhDSiy6iGc1uK/nAJdjwnYwwrmq2woFq+lQGoTW+VGy3bcN1uVX4V2O+o=
X-Received: by 2002:ab0:6413:0:b0:3e1:b113:2dfa with SMTP id
 x19-20020ab06413000000b003e1b1132dfamr6617638uao.102.1665474707638; Tue, 11
 Oct 2022 00:51:47 -0700 (PDT)
MIME-Version: 1.0
References: <bb1fef84-4c4c-d0d2-3422-c96773996a1b@nightmared.fr>
In-Reply-To: <bb1fef84-4c4c-d0d2-3422-c96773996a1b@nightmared.fr>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 11 Oct 2022 10:51:36 +0300
Message-ID: <CAOQ4uxiaO4RNdWjcrW=9SHaZyt-E-VXTh91qjy-8-09qixd8yw@mail.gmail.com>
Subject: Re: Enabling unprivileged mounts on fuseblk filesystems
To:     Simon Thoby <work.viveris@nightmared.fr>
Cc:     ebiederm@xmission.com,
        =?UTF-8?Q?CONZELMANN_Fran=C3=A7ois?= 
        <Francois.CONZELMANN@viveris.fr>, simon.thoby@viveris.fr,
        linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 11, 2022 at 1:33 AM Simon Thoby <work.viveris@nightmared.fr> wr=
ote:
>
> Hello Eric,
>
> in 2018 you commited to the FS subsystem a patch to enable mounting FUSE =
filesystems inside user namespaces, for which I am grateful.
>
> That patch (https://lore.kernel.org/all/87tvqqo8w1.fsf_-_@xmission.com/) =
enabled the FS_USERNS_MOUNT filesystem flag for the "fuse" filesystem type.
> To the best of my understanding, this allows any program owning the CAP_S=
YS_ADMIN privilege inside its user namespace to mount filesystems of that t=
ype (unlike the default behavior for filesystems, ~FS_USERNS_MOUNT, that re=
quires owning CAP_SYS_ADMIN inside the "initial" user namespace): https://e=
lixir.bootlin.com/linux/latest/source/fs/super.c#L516.
>
> However that option was not enabled on the "fuseblk" filesystem type.
> I discovered this today while trying to use ntfs-3g on a block device ins=
ide an unprivileged container.
> Looking at it a bit further with a colleague, we realized that programs l=
ike fusefat worked because they relied on the "fuse" type, and not "fuselbl=
k".
> Which is finally what led me to believe that the lack of the FS_USERNS_MO=
UNT flag was the culprit.
> And indeed, patching ntfs-3g to always use the "fuse" filesystem type ins=
tead of the preferred "fuseblk" works reliably, so at least we know some wa=
y to bypass that issue.
>
> However, we were curious to know if I missed some rationale that would pr=
event that flag for being usable on "fuseblk" too?

Seems like an oversight to me.

>
> And if they weren't, would you be opposed to a patch similar to what foll=
ows?

You are asking the wrong person.

Please address a patch with proper commit message to FUSE maintainer.

Thanks,
Amir.

>
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 6b3beda16c1b..d17f87531dc8 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1839,7 +1839,7 @@ static struct file_system_type fuseblk_fs_type =3D =
{
>          .init_fs_context =3D fuse_init_fs_context,
>          .parameters     =3D fuse_fs_parameters,
>          .kill_sb        =3D fuse_kill_sb_blk,
> -       .fs_flags       =3D FS_REQUIRES_DEV | FS_HAS_SUBTYPE,
> +       .fs_flags       =3D FS_REQUIRES_DEV | FS_HAS_SUBTYPE | FS_USERNS_=
MOUNT,
>   };
>   MODULE_ALIAS_FS("fuseblk");
>
>
> Sorry to bother you with this 4 years after the patch ^^
>
> Thanks,
> Simon
