Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A471271198B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 23:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241985AbjEYVuU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 17:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242311AbjEYVuG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 17:50:06 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05036173B
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 14:49:41 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-ba818eb96dcso162150276.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 14:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1685051379; x=1687643379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OC+9NjL0irobHibDiO4Xj0w+axMGUz0a3YWUxzC5iGM=;
        b=Xli9upD25QW3yaKVzMKeJym2HC6mDnRJ2oNlJGpRtJQwE+0RjgFyE9NaGRZl/KANmT
         hqxJeSbWCtsnkz5POe4lDP5ZDSW+iz2uoBYWRnbQOZxpzeMMJ0S05Y32fG9dWgPm1Gjd
         LG/Au3dHaY1f9YS5PEcLPsYE+UlHmQH+YtNM2kiwuVjctXfG8vNraS6leg7ZoqoS1HAH
         sNPt7D1kLZ3XbX2Zp9+xHyW+DjX4cuP1mNAa5KGNeNtQiywsb1xh2PsgdnZ3kivM04x6
         LXzXHOT6hFj2j7eGDlSygweyJb31DKXEO0OP7xcFeOiJcRu9bIHckRGXf8gpAwZqCV1c
         VMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685051379; x=1687643379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OC+9NjL0irobHibDiO4Xj0w+axMGUz0a3YWUxzC5iGM=;
        b=XuHV6xtp+d66n0Et1YMz5WnhujnWU0+tcKfQAakhPxP3/reX2b48P9ILGxUdgbsj2L
         2cup+QPEijmYOsxWaIeYDEQsQNYAHpFFKtKcRYYozVIVD5nOOU8oteHRdE6TFORGpefO
         Cl37KLrrsJYBBbh2HSOMnSosK26qD4C9r3WUjyUYC3s/HdcoCF+44wwdkUox5kJMSNGJ
         wuQBwy0O50T2qiZCC1eyhRZmXT2pMw4qmb4WUj/Mh2Hw8uR0xFPKPjhegDV6GaNSEsln
         pxqnplhCqdwq29K6ORF62CkxMX0xm7laH0rME7nHMTr5B87UutxzssQtWoljJz0a+Ru/
         dhlg==
X-Gm-Message-State: AC+VfDyTvVmHxJNuMxxDLAuLV134tmnHu5VoUfJPQaha19s1vxUYWv0t
        oryEMIjU39gFBd+JvdR9dyuBjxOyBvYdWl6Pu0TDg17Z3ZYSTJ8=
X-Google-Smtp-Source: ACHHUZ6lpc0Ms3TflRcikKP9rQMUcNUUX12zKG6c7RupY5OQ+TBvP2H/Du0k5GoZMiQR8/JmxXHq1tN/wEo2i5a4DLc=
X-Received: by 2002:a81:4e84:0:b0:55a:985e:8ad1 with SMTP id
 c126-20020a814e84000000b0055a985e8ad1mr798556ywb.33.1685051378870; Thu, 25
 May 2023 14:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000d368dd05fb5dd7d3@google.com> <a800496b-cae9-81bf-c79e-d8342418c5be@I-love.SAKURA.ne.jp>
 <CAHC9VhSEd5BK=ROaN7wMB4WtGMZ=vXz7gQk=xjjn1-mbp_RWSQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSEd5BK=ROaN7wMB4WtGMZ=vXz7gQk=xjjn1-mbp_RWSQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 25 May 2023 17:49:28 -0400
Message-ID: <CAHC9VhSGwM9VXshWwopr3d2epVksFNZUbS-mQyFOg9bVBOC1aA@mail.gmail.com>
Subject: Re: [PATCH] reiserfs: Initialize sec->length in reiserfs_security_init().
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzbot <syzbot+00a3779539a23cbee38c@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        reiserfs-devel@vger.kernel.org, glider@google.com,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 20, 2023 at 3:47=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Thu, May 11, 2023 at 10:49=E2=80=AFAM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >
> > syzbot is reporting that sec->length is not initialized.
> >
> > Since security_inode_init_security() returns 0 when initxattrs is provi=
ded
> > but call_int_hook(inode_init_security) returned -EOPNOTSUPP, control wi=
ll
> > reach to "if (sec->length && ...) {" without initializing sec->length.
> >
> > Reported-by: syzbot <syzbot+00a3779539a23cbee38c@syzkaller.appspotmail.=
com>
> > Closes: https://syzkaller.appspot.com/bug?extid=3D00a3779539a23cbee38c
> > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > Fixes: 52ca4b6435a4 ("reiserfs: Switch to security_inode_init_security(=
)")
> > ---
> >  fs/reiserfs/xattr_security.c | 1 +
> >  1 file changed, 1 insertion(+)
>
> Adding the LSM list to the CC line.

I haven't seen any objections, and it looks reasonable to me so I've
gone ahead and merged it into lsm/next.  This is arguably
lsm/stable-6.4 material, but I'm going to stick with lsm/next in hopes
that Roberto can resolve the other reiserfs issue and we can push all
the reiser fixes up to Linus in one shot.

The reality is that LSM xattrs have been broken on reiserfs for a long
time and no one has complained, I figure a few more weeks isn't going
to matter that much.

Regardless, thanks for digging into this syzbot failure and sending a patch=
.

> > diff --git a/fs/reiserfs/xattr_security.c b/fs/reiserfs/xattr_security.=
c
> > index 6e0a099dd788..078dd8cc312f 100644
> > --- a/fs/reiserfs/xattr_security.c
> > +++ b/fs/reiserfs/xattr_security.c
> > @@ -67,6 +67,7 @@ int reiserfs_security_init(struct inode *dir, struct =
inode *inode,
> >
> >         sec->name =3D NULL;
> >         sec->value =3D NULL;
> > +       sec->length =3D 0;
> >
> >         /* Don't add selinux attributes on xattrs - they'll never get u=
sed */
> >         if (IS_PRIVATE(dir))
> > --
> > 2.18.4

--=20
paul-moore.com
