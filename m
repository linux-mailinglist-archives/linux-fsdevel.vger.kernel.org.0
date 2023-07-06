Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB73E74992B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 12:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbjGFKPO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 06:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbjGFKOr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:14:47 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602F92105;
        Thu,  6 Jul 2023 03:14:26 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-440bc794fcdso158684137.3;
        Thu, 06 Jul 2023 03:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688638460; x=1691230460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhQqU5Yz/JT+HPms2OHuWNTi6R2tVVUTMviH7q7Cu94=;
        b=rEuLB2NabxKUC5ag022F6IL0G1BwTWhIPqiiccCmZCcuZ1QFxVWw9m/mldJAKd3sBH
         IRT6hUh1QdBZ23WtrnNRnQRAZB9SqQwFPFJxyaU+FNwedO1VeE6cghaGSMvHFVUXss7f
         P5KVJCvBLkRCxv9Dr3k1xSizuR5rXV4JT9oSuyuHzFhI1yLRCGXdd0hpaS+Cq4Cf/bfc
         0O+T/0FpXG464E3Uhj3QQZq09f0atNHTxNjntA0sVNTxbT50/qRADL2dgECG9mpPGUbZ
         9x9vgyQghDI03xBoPVniNKG6ogv8zU9zBC3pFahnqGe19hjEvpFDmI1sp91fKQGESvR9
         G0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688638460; x=1691230460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nhQqU5Yz/JT+HPms2OHuWNTi6R2tVVUTMviH7q7Cu94=;
        b=NpjH8r4xk0JQHRiFcZhA505Ku2vPJ+AIHTbAe4BT6/lFe8aiJrOVpWmDUtJLr1ZQTh
         eAMryRLlgQM8pDNHgKJt5DUJ5ZLIPgb1sF56ircrWBw00GRCOE/tPFTIDT/W/8bTbmUP
         kRyxWoamdniscZfNY9Y9rEXIn5l/fl6On2C6nls3m8jYpYSUpPum5CUaulT2LfpzrIEM
         YNp7THh57GG5Xf/8xaYUTYh77f1H35v3kOSQkjIlezXt0V6aK/J5nB/r2v0tzt7HgJuL
         nzlI2v+qgVKTv66jQwoDOp7ruEth71/RYcK87s6zeo1nHzEtiTWBkQAgIGgpJtjQy/6g
         Cmnw==
X-Gm-Message-State: ABy/qLYCLAefUTJ9Twh2AvklsaekrfYg7WGtkMmKfGFn/QGGdbmcmkxf
        lwsR53n5Xm81SFbCWwocGykNqf3fxCRB295u5EhhbXve
X-Google-Smtp-Source: APBJJlFiUWz12SRf67vLaQmmFLzoASc/YgbCiNxQV5khLx0FvqtfXtkNyQHR2sYWfhJ58JFQ0D5/Mp1Fw7CY338XcO8=
X-Received: by 2002:a05:6102:3bce:b0:443:ef68:1f06 with SMTP id
 a14-20020a0561023bce00b00443ef681f06mr733233vsv.18.1688638460263; Thu, 06 Jul
 2023 03:14:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230425132223.2608226-1-amir73il@gmail.com> <20230425132223.2608226-4-amir73il@gmail.com>
 <CAOQ4uxgX0Tx07q2gAzsB2kPsUm+MjsYw9BG4W7-h8ODNnqH_1A@mail.gmail.com>
In-Reply-To: <CAOQ4uxgX0Tx07q2gAzsB2kPsUm+MjsYw9BG4W7-h8ODNnqH_1A@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 6 Jul 2023 13:14:09 +0300
Message-ID: <CAOQ4uxhh6fh8spdBSxaPQCMK8OKGLjvi=JvwAM0J9vZaEeAgZg@mail.gmail.com>
Subject: Re: [RFC][PATCH 3/3] ovl: use persistent s_uuid with index=on
To:     Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
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

On Thu, Jul 6, 2023 at 10:19=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Tue, Apr 25, 2023 at 4:22=E2=80=AFPM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> >
> > With index=3Don, overlayfs instances are non-migratable, meaning that
> > the layers cannot be copied without breaking the index.
> >
> > So when indexdir exists, store a persistent uuid in xattr on the
> > indexdir to give the overlayfs instance a persistent identifier.
> >
> > This also makes f_fsid persistent and more reliable for reporting
> > fid info in fanotify events.
> >
> > With mount option uuid=3Dnogen, a persistent uuid is not be initialized
> > on indexdir, but if a persistent uuid already exists, it will be used.
> >
>
> This behavior (along with the grammatical mistakes) was changed in
> https://github.com/amir73il/linux/commits/ovl_encode_fid
>
> uuid=3Doff or uuid=3Dnull both set ovl fsid to null regardless of persist=
ent
> uuid xattr.
>

Sorry, that was meant to say "set ovl uuid to null..."
when ovl uuid is null then ovl fsid is not null, it is the fsid of the
uppermost fs.

This creates a dilemma wrt backward compat.

With index=3Doff, the mounter has a choice between two sub-optimal options:
1. persistent ovl fsid (of upper fs)
2. unique ovl fsid (from random uuid)

If we change the default from legacy (1) to unique (2), that
could also break systems that rely on the persistent ovl fsid
of existing overlayfs layers.

With index=3Don, the choice is between:
1. persistent ovl fsid (of upper fs)
2. persistent and unique ovl fsid (from uuid xattr)

option (2) is superior, but still could break existing systems
that rely on (1) being persistent.

The decision to tie uuid xattr to the index dir and index=3Don
was rationalized in the commit message, but persistent and
unique fsid could also be implemented regardless of index=3Don.

I think I may have found a dignified way out of this mess:
- In ovl_fill_super(), check impure xattr on upper root dir
- If impure xattr does not exist (very likely new overlay),
  uuid_gen() and write the persistent uuid xattr on upper fs root
- If uuid xattr is written or already exists, use that to initialize
  s_uuid otherwise, leave it null
- in ovl_statfs(), override the upper fs fsid, only if ovl uuid is non-null

This gives:
1. Old overlayfs deployments retain old behavior wrt null uuid
    and upper fsid, as long as they have had at least one subdir
    of root copied up or looked up to trigger ovl_fix_origin()
2. New overlayfs deployments always generate and use a unique
    and persistent uuid/fsid
3. mount option uuid=3Doff/null (*) can be used to retain legacy behavior
    on old/new overlayfs deployments (for whatever reason) and ignore
    existing persistent uuid xattr
4. mount option uuid=3Don can be used to force new behavior on an
    existing overlayfs with impure xattr and without uuid xattr

(*) uuid=3Doff was originally introduced for the use case of copied layers.
     That is similar to the use case of copying disk images and dropping
     the old persistent ovl uuid makes sense in that case.

I will try to write this up.

Thanks,
Amir.
