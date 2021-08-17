Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A45473EF01B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 18:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhHQQVq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 12:21:46 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:54896 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbhHQQVp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 12:21:45 -0400
Received: by mail-il1-f198.google.com with SMTP id r6-20020a92c506000000b002246015b2a4so6973954ilg.21
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Aug 2021 09:21:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=KOqfcwDCAAyd9Yj7KuDdDJBmhJTsKykvsP7zBce1+GE=;
        b=HN/ldSvZ+2h7wDyxectbWF6yE8wAcJ0dp2qXsvGbhcDB9CdR+/dubrEkfbtXf6nky1
         curN9X+hSdUdVlHZTTkqONZF+G3On3MUsUKFVz6z2sKGNaS7UY5A/elvxB0s9+EqlxVH
         pRnk3CpQSd0zfkSKGkZYIgUvRCeW3yabCA6B99uz9uOKDawdcP+r3YVnO4FnU0XD29wO
         1pUHlc11fZhl2qmTsmlq1sFthCNFRiKtjlKJLUxE7ofIFRU+WfU90Dtn2KXT94hZTU7d
         nEwq1GUyaNOeC6NM2Eaw9h5kkvAlzhZlrkhiGvRYxCGM8q95V4IS52zCAEfEKLIjjaJW
         k3AQ==
X-Gm-Message-State: AOAM533y8VOiQKUHXFaZfN1XD1Yn9f14xvSfgDH9GPp4ZAnHlAg9aUmS
        4tiXGC34XGPDlAIWEvykeMeN/bM0/fSKvneQ3jBog2LngP9J
X-Google-Smtp-Source: ABdhPJzCSydA+1Z0J/QUplR71Dfv66P5r4SwQ+VQoMBL253DFHd/ocNOGwchcI097DHM9/2rZMH1E532vCgx7MXB77OVN8A7Zuqh
MIME-Version: 1.0
X-Received: by 2002:a92:b749:: with SMTP id c9mr2956629ilm.160.1629217272078;
 Tue, 17 Aug 2021 09:21:12 -0700 (PDT)
Date:   Tue, 17 Aug 2021 09:21:12 -0700
In-Reply-To: <CAJfpegv1ztaEvrSX622ru-FRX1VJYZDbRWq6_4HhF0tCY+0uHQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c3c97c05c9c3b4ea@google.com>
Subject: Re: [syzbot] INFO: task hung in fuse_launder_page
From:   syzbot <syzbot+bea44a5189836d956894@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+bea44a5189836d956894@syzkaller.appspotmail.com

Tested on:

commit:         794c7931 Merge branch 'linus' of git://git.kernel.org/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=96f0602203250753
dashboard link: https://syzkaller.appspot.com/bug?extid=bea44a5189836d956894
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
patch:          https://syzkaller.appspot.com/x/patch.diff?x=169e4131300000

Note: testing is done by a robot and is best-effort only.
