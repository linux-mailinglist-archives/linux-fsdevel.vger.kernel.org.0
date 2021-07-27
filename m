Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E3A3D8457
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 01:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbhG0X5P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 19:57:15 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:53845 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbhG0X5P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 19:57:15 -0400
Received: by mail-il1-f199.google.com with SMTP id l14-20020a056e0205ceb02901f2f7ba704aso480414ils.20
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jul 2021 16:57:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Ty4TQPGEDKcGdMb6gqnGGhBMQQtzNle2IFTM2JBzdpw=;
        b=DOVesI+C32M5vWO51i0mL6sml4RmAv8X4teMOGC4fSO8z8LQoit/ZOfadCuLl3r738
         AnqYH27Po22oi64jC529lFFlcefx54AuaNB6pJrfs/099KvsRM+laWsGdBX4kwIkwCJL
         c8Tl42cb7CMUvquLbC+K2DJC234kOzZmPhEkJTKHnVmLy2S8yEVEXJyqI8onWSGDeovQ
         B/tbjCtwGFHDLYCZn4Rhra6zrRfa7czGXmCSIascHiruT8Axc2Ek7t2EEcbCfrhExuFi
         DyXUHTTUl53quohDviXv/M7IMUUP6MFPvY7YXpu8DzxR0S9VMdUMGKtUjfbJmhjQuBz3
         zwYw==
X-Gm-Message-State: AOAM533JDbhZuqv8cQEID74EXdzwAXtITbSXzEKpZXHVyJ/zcd3d34tx
        LC6Imk34qi0vWNzsupIG83lKd/uXIfYqyfPSLqHCpE+tgMwi
X-Google-Smtp-Source: ABdhPJxi794p2hLFiirgR9Foy8pLJY+506lpsOX3kCxS6r/0n5vf9hy+CWYYNJ5uvcSGBDxKN6zzTZCed5eyrCSZB1mmLDJ5Xp/t
MIME-Version: 1.0
X-Received: by 2002:a5d:8d83:: with SMTP id b3mr21141726ioj.179.1627430233390;
 Tue, 27 Jul 2021 16:57:13 -0700 (PDT)
Date:   Tue, 27 Jul 2021 16:57:13 -0700
In-Reply-To: <CAOssrKdqbOr0jeE1pYqkWnFysVbdi+H7sfoc3c4CaiqBUqQz_g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f541e805c823a0fd@google.com>
Subject: Re: [syzbot] possible deadlock in pipe_lock (5)
From:   syzbot <syzbot+579885d1a9a833336209@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, hdanton@sina.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+579885d1a9a833336209@syzkaller.appspotmail.com

Tested on:

commit:         7d549995 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=40eef000d7648480
dashboard link: https://syzkaller.appspot.com/bug?extid=579885d1a9a833336209
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
patch:          https://syzkaller.appspot.com/x/patch.diff?x=104bb746300000

Note: testing is done by a robot and is best-effort only.
