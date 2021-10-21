Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F345F435DFB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 11:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbhJUJcX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 05:32:23 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:45697 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbhJUJcX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 05:32:23 -0400
Received: by mail-il1-f200.google.com with SMTP id q14-20020a92750e000000b002589d954013so14295586ilc.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Oct 2021 02:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=8PyU5Mj2VjoiXabguVXYfQODn+mSv1LISH3665rY0ms=;
        b=zVJ76yslnggYYB3+5RbhbeotBE/oCtdTV+ILs66hQJqEUzV/iAfJ2PUFhdySikZ55B
         XsMbDC1R6P8ws/3pEZpwHm6svmpm2s/Kano09x5Mro3KxJa6vGm50HVKZVBKoJP/JS5S
         QzYTYoyvb0UZxTJhtwux3nWz81Xo961k6JFDuM0ptZ4HQkmPqCdAHLwoY7BElGfNLnnJ
         1brOD5ZgPyZ3QmELlSS3pEypKH/mUWhw9IZYBOYjOkXihOmUzYELaPuCrs5v1EFNoMol
         nCXpbDfTaadxyVu04u5wdEJc7hYtgIbp2bJ8zrF0EkGvqkQqR8sTWhYDvaq+/0jEIHtY
         oL0Q==
X-Gm-Message-State: AOAM530uxxR5PU98D85vjnjjQjAGF58T/y7PEmHrhbe9/BQwKyUjegJF
        kj5XqzSW258CVogIVgZAkwzK/JZt2dhrx6cRiIyGl/FmdNfo
X-Google-Smtp-Source: ABdhPJzuivB4NB9xmQ9oIDN34OTXIEibrUdziLVht/KsLW7riAywOtkmdpmFE2NkSfJwaM0qnx4LQOG9RGLokYSLPnoMiXC3BQrJ
MIME-Version: 1.0
X-Received: by 2002:a92:cda3:: with SMTP id g3mr2716905ild.103.1634808607418;
 Thu, 21 Oct 2021 02:30:07 -0700 (PDT)
Date:   Thu, 21 Oct 2021 02:30:07 -0700
In-Reply-To: <CAJfpegskcCEZAX+EbnBZyva2NDyhJ9k97ZM_E9OBeXRjDsC_BQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000522fda05ced98aac@google.com>
Subject: Re: [syzbot] general protection fault in fuse_test_super
From:   syzbot <syzbot+74a15f02ccb51f398601@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+74a15f02ccb51f398601@syzkaller.appspotmail.com

Tested on:

commit:         80019f11 fuse: always initialize sb->s_fs_info
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=3decadb8235b4dad
dashboard link: https://syzkaller.appspot.com/bug?extid=74a15f02ccb51f398601
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: testing is done by a robot and is best-effort only.
