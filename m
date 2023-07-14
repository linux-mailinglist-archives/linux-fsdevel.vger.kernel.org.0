Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA897540FD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 19:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236158AbjGNRr1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jul 2023 13:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235463AbjGNRrY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:47:24 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAAF3C35
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Jul 2023 10:46:56 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbb07e7155so7975e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Jul 2023 10:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689356814; x=1691948814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V79V8Ob9kDVtoKhHxfd/ZHppf+Xb+pXM39lQ/ZKj5AA=;
        b=S31bnNT3GDqZ5z203JkpEIu36kZcKiyLgCYoB7XGIpR6wqV4kTdPHcQKQYkUUIPwfs
         yduMqjrvndVREn4OFHzB+nMXt+fogQeE0uAZffvq0vW1cLnwUr/ng5EaaS5oYbARdzIq
         XYzcIAUquwxrHPeAI1L5ctcYveELaQLcbhI+KMRnjk0fJus/p+zVTc0SL3gRVAYbDEQ+
         0BQFVJOSNfe5bJW4p4u8J4QB6oCYcsTx43w2Ml1hnB2TOV/cCrQZWeHuXg3n0JlSKE18
         7sZMld6BvPNRiHHWifIdVCMoWG0PUQGaz4VYUttZQDpuqjiHKchpP1o6f3vssJ08x1/8
         pGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356814; x=1691948814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V79V8Ob9kDVtoKhHxfd/ZHppf+Xb+pXM39lQ/ZKj5AA=;
        b=XtM4V66ZnYihFpVY0Hb8uF4CYaszE4Ocl2ArTtCF07EN/e3p1tbteAnzCAGLkeT4T0
         uVzzRb2iK0TZsgkj6+HP4Jr3hz+ou4xK/6OVAmI0IdgCakfoUMj2JDCPusRfrXp2uwkf
         6N+NxLyb0DZF+aLp3TpW0NWZty/1x/4u40kH5k31wjh2yZObNocZP7xJXlcp79yg23Ko
         3MXxHyo3hrdIPmZSIWPuzKSqeUe4puF7hbptwUKqY2lOqfYX6VAYXIo0IdNYWvRx/pOV
         FYWIj4E1C173E09ccfMy5IFwbKCghhO2AowqJ2XhsMcp2slgQhtWGwXkBg54GeB+5fVA
         EG/g==
X-Gm-Message-State: ABy/qLaCYoS4n2F8LBrCRScfrFts9mQawlCGfgOTa51dfgEgTkelX9z7
        tYCk29fOEErgy7QGUopQOIjSP7L5jMBkcWr9RlziOQ==
X-Google-Smtp-Source: APBJJlEgmPkFMojaotDjbFoM8e1VgkXNNe+Uom0kHyquw6TPemNfxqNuS0Ui3xa5/ip2rpjClcP+hofflb35Wa/RkgQ=
X-Received: by 2002:a05:600c:8609:b0:3f1:73b8:b5fe with SMTP id
 ha9-20020a05600c860900b003f173b8b5femr345595wmb.3.1689356813789; Fri, 14 Jul
 2023 10:46:53 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000075fd0505ff917517@google.com> <CAKYAXd9Wv5Swj4fouCLYbdyjWYhT39C3TiHgm-fRiKS_2=zsTA@mail.gmail.com>
In-Reply-To: <CAKYAXd9Wv5Swj4fouCLYbdyjWYhT39C3TiHgm-fRiKS_2=zsTA@mail.gmail.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Fri, 14 Jul 2023 19:46:42 +0200
Message-ID: <CANp29Y7ynmqhmRQ0hABs=uVHQY1sN+Ldw3V93UGSxh+SqfYC=Q@mail.gmail.com>
Subject: Re: [syzbot] Monthly fat report (Jul 2023)
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     syzbot <syzbot+list96b6ab127c02d379290b@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 14, 2023 at 3:45=E2=80=AFPM Namjae Jeon <linkinjeon@kernel.org>=
 wrote:
>
> 2023-07-03 18:04 GMT+09:00, syzbot
> <syzbot+list96b6ab127c02d379290b@syzkaller.appspotmail.com>:
> > Hello fat maintainers/developers,
> Hi Syzbot,
>
> It's not fat, it's exfat :)

I'll look into renaming it on syzbot :)

> >
> > This is a 31-day syzbot report for the fat subsystem.
> > All related reports/information can be found at:
> > https://syzkaller.appspot.com/upstream/s/fat
> >
> > During the period, 3 new issues were detected and 0 were fixed.
> > In total, 11 issues are still open and 20 have been fixed so far.
> >
> > Some of the still happening issues:
> >
> > Ref Crashes Repro Title
> > <1> 347     Yes   possible deadlock in filemap_fault
> >
> > https://syzkaller.appspot.com/bug?extid=3D7736960b837908f3a81d
> > <2> 257     Yes   possible deadlock in exfat_get_block
> >
> > https://syzkaller.appspot.com/bug?extid=3D247e66a2c3ea756332c7
> > <3> 181     Yes   possible deadlock in exfat_iterate
> >
> > https://syzkaller.appspot.com/bug?extid=3D38655f1298fefc58a904
> > <4> 100     Yes   possible deadlock in exc_page_fault
> >
> > https://syzkaller.appspot.com/bug?extid=3D6d274a5dc4fa0974d4ad
> > <5> 39      Yes   possible deadlock in do_user_addr_fault
> >
> > https://syzkaller.appspot.com/bug?extid=3D278098b0faaf0595072b
> > <6> 2       Yes   KASAN: slab-use-after-free Write in
> > collect_expired_timers

#syz set <6> subsystems: reiserfs

> >
> > https://syzkaller.appspot.com/bug?extid=3Dfb8d39ebb665f80c2ec1
> > <7> 1       Yes   BUG: corrupted list in __mark_inode_dirty

#syz set <7> subsystems: reiserfs

> >
> > https://syzkaller.appspot.com/bug?extid=3D4a16683f5520de8e47c4
> >
>
> Can you check if deadlock problem(<1>, <2>, <3>, <4>, <5>, <6>) are
> fixed with the following patch ?
> https://lore.kernel.org/lkml/20230714084354.1959951-1-sj1557.seo@samsung.=
com/T/#u

We currently unfortunately don't support bulk testing, I've sent a few
requests manually (<1>, <3>, <4>):
https://groups.google.com/g/syzkaller-bugs/c/ynCUkcnqEiQ/m/qsVWSdWOBAAJ
https://groups.google.com/g/syzkaller-bugs/c/jKpqY82OuZk
https://groups.google.com/g/syzkaller-bugs/c/7CO-77jYTAQ/m/lBmXby-OBAAJ

>
> Numbers <6>, <7> are not exfat issues. Can you remove them in your list?

Thanks for triaging! I've updated their subsystems to reiserfs (see
commands above).

>
> Thanks.
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > To disable reminders for individual bugs, reply with the following comm=
and:
> > #syz set <Ref> no-reminders
> >
> > To change bug's subsystems, reply with:
> > #syz set <Ref> subsystems: new-subsystem
> >
> > You may send multiple commands in a single email message.
> >
>
> --
