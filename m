Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645E477F8E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 16:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351900AbjHQO3a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 10:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351911AbjHQO3C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:29:02 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAE03A87
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 07:28:46 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fe32ec7201so85515e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 07:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692282525; x=1692887325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbuzZgm/Epx8Tdu/T82s0Hz/7yMfR8Bq/SJcnCEyV4o=;
        b=1poYC5egN/L6xOHmi8JNPEZSQaU67+euWedtHxcRfgFB0vNSt/wyGJcReBylnswyg7
         iOKELWqutdm6vcnWpe+oc4sFyncdofTTTV7kPPTJ/f2pLYAIo9EWgdUcVpn/AHG8DMXD
         5TACe6rFfRm189F6l8a7wPKipu1Sel9IabgxuIW97OAsZRR8hrLPdqRCZrVVS7lKE4E8
         Z2Yq0e2E+ESpaEwlXcWLP/WIQnUO8pXdbUF3bFSATjijWx4wEytEyfg5TL4ilFc7VU9b
         TMuEeZXxRhlfq43NFbxZu3JhF4/v1uK9hMliHANvkXtReOCdJzAR8uP41QNd5pAR22ls
         SGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692282525; x=1692887325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jbuzZgm/Epx8Tdu/T82s0Hz/7yMfR8Bq/SJcnCEyV4o=;
        b=iIZYVVRftFaXw34NTlGcEMYFo9djRvRhX2O63+ltkcdQV4XX7wWcvYaNFTTo58+fub
         vGr4A8V3s+Zk3dzIbk3ROUYlO7nVM4IM1TY8AtIgTRBsdIdfP51jh29a+NuCJvv6MvHW
         SI8A9fc1Guy1KxM7IA2a4BUeXL3N4CwJCQmWxseyLjQYLNZFqY4a7BFFdDioe8JAAvTY
         ahDjPToXUeG+U2ml8eSZEXkqrc/TxTGlG/cVLhubWnlCkBePcymJYEg/OuICVVC4GZZw
         pRsunqDOjaeC888gSdej7V4kRGchYc8ulJKnRxslXPbO1YZwivOPSvCRzJCqop9kiUzH
         PMMg==
X-Gm-Message-State: AOJu0YzSxBISM2wJb7RnJ4afjGPpv7CtRhKroTzlOSKT7ipY38UHcQUa
        hN2jwykIeSSZQKP2+bH4ERNbtxtwM3wmjyO6wtuXeQ==
X-Google-Smtp-Source: AGHT+IFG/yRimf29UxgTKdkg0735rlP5xHIyoBsVfiAVrbEpmIJ1v2Hkkxn6BPqXlDZvKkQbWWDt2mPcLSxALQBy0bU=
X-Received: by 2002:a05:600c:1d84:b0:3fe:5228:b7a2 with SMTP id
 p4-20020a05600c1d8400b003fe5228b7a2mr85534wms.5.1692282525025; Thu, 17 Aug
 2023 07:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000530e0d060312199e@google.com> <20230817142103.GA2247938@mit.edu>
In-Reply-To: <20230817142103.GA2247938@mit.edu>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Thu, 17 Aug 2023 16:28:33 +0200
Message-ID: <CANp29Y7jbcOw_rS5vbfWNo7Y+ySYhYS-AWC356QN=JRVOm9B8w@mail.gmail.com>
Subject: Re: [syzbot] [ext4?] kernel panic: EXT4-fs (device loop0): panic
 forced after error (3)
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     syzbot <syzbot+27eece6916b914a49ce7@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 17, 2023 at 4:21=E2=80=AFPM Theodore Ts'o <tytso@mit.edu> wrote=
:
>
> On Wed, Aug 16, 2023 at 03:48:49PM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    ae545c3283dc Merge tag 'gpio-fixes-for-v6.5-rc6' of git=
://..
> > git tree:       upstream
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D13e5d553a80=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D171b698bc2e=
613cf
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D27eece6916b91=
4a49ce7
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for D=
ebian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D13433207a=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D109cd837a80=
000
> >
> > EXT4-fs error (device loop0): ext4_validate_block_bitmap:430: comm syz-=
executor211: bg 0: block 46: invalid block bitmap
> > Kernel panic - not syncing: EXT4-fs (device loop0): panic forced after =
error
>
> #syz invalid
>
> This is fundamentally a syzbot bug.  The file system is horrifically
> corrupted, *and* the superblock has the "panic on error" (aka "panic
> onfile system corruption") bit set.

The console log has the following line:

[   60.708717][ T5061] Kernel panic - not syncing: EXT4-fs (device
loop0): panic forced after error

Can we consider a "panic forced after error" line to be a reliable
indicator that syzbot must ignore the report?


>
> This can be desireable because in a failover situation, if the file
> system is found to be corrupted, you *want* the primary server to
> fail, and let the secondary server to take over.  This is a technique
> which is decades old.
>
> So this is Working As Intended, and is a classic example of (a) if you
> are root, you can force the file system to crash, and (b) a classic
> example of syzbot noise.  (Five minutes of my life that I'm never
> getting back.  :-)
>
>                                                 - Ted
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/20230817142103.GA2247938%40mit.edu.
