Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07867710044
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 23:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbjEXV52 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 17:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236221AbjEXV50 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 17:57:26 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E5F183
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 May 2023 14:57:25 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-ba81031424dso2186900276.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 May 2023 14:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684965444; x=1687557444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HnrQePs+guIncAtpR4LpewLTG9uJD1WVMzDg7x5+JnQ=;
        b=MOJGgNeeZ2NTaZLOw5dLeQKOsSMdZuOUDLi4BpOvTiIWRhxlewpCkLWFm90AvCFDM0
         dBbOiUgnwSF3tx2OCsfzW5pehrThLZTOsfw+byMilrUxH/Cj5v2axZNDxs+vrOsJ2N4v
         IxXP53ZTgLR3muduWGVYPh1B5tWmAMwq4uWqW4WLkhKPpMI27Eee0C+v/cW+dzVTGCUZ
         4A+99EiMuntUsoYNf+LzQB7aUOpYtEqfYo2C/g9I4lkOyTxkb7Zoy5dm+ieqK7BfUV0z
         H7dMG4Is8HvC4rO8ie0Gg/xc9BXLT61Su2UirLdP/AoEm8mYapaDU29mprZAm7Yp+MSi
         ymhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684965444; x=1687557444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HnrQePs+guIncAtpR4LpewLTG9uJD1WVMzDg7x5+JnQ=;
        b=DEJH0h81a6s+iv5qCUi7r4D6IlGyFcIwa7MzZKI4DOqDlGjLy+yxWbKYb+lakobwjj
         1TqDukp12WtsO9rfxVfT4p+EPLGBW+Ld1JOoCrdPmfewI65ExBdT6DCYeTnp8O2QCoJc
         9YVeefRC4Lx3Yt5O49dh8EMfimEbqB+TB/oQ5tagblVITz/LMzFSFKhymrQwAaO3m6iH
         noavkEg6Dapzl1GPNzdy00FnsWEDrgmJp+VH6oY45p6rB4B+S6e5gT8EphDUkqut9bF/
         DbF2E7T6ADFJdwj4y6Okwn8lEg5xXtulv/Yq7cfErtHDGyeVzPLGBavl2UTP6wAitzH0
         eOjw==
X-Gm-Message-State: AC+VfDyAMF2pWv0OWG7+b7LC1co0XSrUXWw1O7NgoqPlllMXALmsAVLZ
        5MpUzn4edA/IPwX+scn7gu0Hx0LZwlcD47jKWDdb
X-Google-Smtp-Source: ACHHUZ6wwnRp26WVRb5bMlIwp5UO3NdT+DkO9QgYycHZoQNR88qp6I/wrFTyf14xwXWr/rrvRF6bugZWse9TXC6cuUE=
X-Received: by 2002:a0d:e807:0:b0:55a:4ff4:f97d with SMTP id
 r7-20020a0de807000000b0055a4ff4f97dmr19964058ywe.48.1684965444190; Wed, 24
 May 2023 14:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000be039005fc540ed7@google.com> <00000000000018faf905fc6d9056@google.com>
 <CAHC9VhTM0a7jnhxpCyonepcfWbnG-OJbbLpjQi68gL2GVnKSRg@mail.gmail.com> <813148798c14a49cbdf0f500fbbbab154929e6ed.camel@huaweicloud.com>
In-Reply-To: <813148798c14a49cbdf0f500fbbbab154929e6ed.camel@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 24 May 2023 17:57:13 -0400
Message-ID: <CAHC9VhRoj3muyD0+pTwpJvCdmzz25C8k8eufWcjc8ZE4e2AOew@mail.gmail.com>
Subject: Re: [syzbot] [reiserfs?] INFO: task hung in flush_old_commits
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, roberto.sassu@huawei.com,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+0a684c061589dcc30e51@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 24, 2023 at 11:50=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Wed, 2023-05-24 at 11:11 -0400, Paul Moore wrote:
> > On Wed, May 24, 2023 at 5:59=E2=80=AFAM syzbot
> > <syzbot+0a684c061589dcc30e51@syzkaller.appspotmail.com> wrote:
> > > syzbot has bisected this issue to:
> > >
> > > commit d82dcd9e21b77d338dc4875f3d4111f0db314a7c
> > > Author: Roberto Sassu <roberto.sassu@huawei.com>
> > > Date:   Fri Mar 31 12:32:18 2023 +0000
> > >
> > >     reiserfs: Add security prefix to xattr name in reiserfs_security_=
write()
> > >
> > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D11c396=
39280000
> > > start commit:   421ca22e3138 Merge tag 'nfs-for-6.4-2' of git://git.l=
inux-..
> > > git tree:       upstream
> > > final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D13c396=
39280000
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D15c396392=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D7d8067683=
055e3f5
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D0a684c06158=
9dcc30e51
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1431279=
1280000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D12da86052=
80000
> > >
> > > Reported-by: syzbot+0a684c061589dcc30e51@syzkaller.appspotmail.com
> > > Fixes: d82dcd9e21b7 ("reiserfs: Add security prefix to xattr name in =
reiserfs_security_write()")
> > >
> > > For information about bisection process see: https://goo.gl/tpsmEJ#bi=
section
> >
> > Roberto, I think we need to resolve this somehow.  As I mentioned
> > earlier, I don't believe this to be a fault in your patch, rather that
> > patch simply triggered a situation that had not been present before,
> > likely because the reiserfs code always failed when writing LSM
> > xattrs.  Regardless, we still need to fix the deadlocks that sysbot
> > has been reporting.
>
> Hi Paul
>
> ok, I will try.

Thanks Roberto.  If it gets to be too challenging, let us know and we
can look into safely disabling the LSM xattrs for reiserfs, I'll be
shocked if anyone is successfully using LSM xattrs on reiserfs.

> > Has anyone dug into the reiserfs code to try and resolve the deadlock?
> >  Considering the state of reiserfs, I'm guessing no one has, and I
> > can't blame them; I personally would have a hard time justifying
> > significant time spent on reiserfs at this point.  Unless someone has
> > any better ideas, I'm wondering if we shouldn't just admit defeat with
> > reiserfs and LSM xattrs and disable/remove the reiserfs LSM xattr
> > support?  Given the bug that Roberto was fixing with the patch in
> > question, it's unlikely this was working anyway.

--=20
paul-moore.com
