Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFAA040319D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 01:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240071AbhIGXqW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Sep 2021 19:46:22 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:50080 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbhIGXqV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Sep 2021 19:46:21 -0400
Received: by mail-io1-f69.google.com with SMTP id k6-20020a6b3c060000b0290568c2302268so247981iob.16
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Sep 2021 16:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=azO+95TCO/1HFtLgHV37fVlP8fKel1LFnAD0jlvW0n8=;
        b=rWpdIU8ee2wt7zkOyDFMJXHy2AfOlGKFUkwXb2yWhvJ8xRIE98V1smHSKbffV1scTd
         E0P6Sqh6zeuvGk9ZLpvz+glRjkWIsizKP0dtLERNJdWVO1MiOP2YqNZyjHi4uDaIbB12
         BN6jEoMbMQPAs2AV+Fjm7BaVeJYYxoNsvH1+P1BAlDwwo2q7YJhzXFSTwONA4wI44XHH
         hhEQAexPz4r0CSYgcRkwNTtIAwXse9uvrY6OXfVbVdnXdrwtCG2M+LCEAq2Y+//2VSAX
         dAbWMV5VrjBJBFoXrkr8n1LOATQs5HPX5ctAbKvEiH1fUC5NbhfpxMp18Bo7W6453eQD
         t/MQ==
X-Gm-Message-State: AOAM531WrzGIpFsk/9LzxGt+s+DHHMVqjwi8vEpbKGul4gS+2l0OkaP5
        5nnjX+lISnqKG2Tgrr/tZOmGkgQBwoEazjO/zPSRksrogMeF
X-Google-Smtp-Source: ABdhPJyXE68bJO2rLgRncQnLtK+Rmo0JITAwKn95hC4okYl+2TZ29ztaLKHbFGMeYnpeh8qMxrGW+CcMpt9CKnYudar6dZuXcMe3
MIME-Version: 1.0
X-Received: by 2002:a6b:7f42:: with SMTP id m2mr686330ioq.86.1631058314537;
 Tue, 07 Sep 2021 16:45:14 -0700 (PDT)
Date:   Tue, 07 Sep 2021 16:45:14 -0700
In-Reply-To: <CAJfpegvr1y9VTXb3Gm2F1Y9mZzWYAEYutV8kdhnD2Yyo8FTvcQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000072333305cb705ba0@google.com>
Subject: Re: [syzbot] possible deadlock in fuse_reverse_inval_entry
From:   syzbot <syzbot+9f747458f5990eaa8d43@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+9f747458f5990eaa8d43@syzkaller.appspotmail.com

Tested on:

commit:         626bf91a Merge tag 'net-5.15-rc1' of git://git.kernel...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f9bfda6f9dee77cd
dashboard link: https://syzkaller.appspot.com/bug?extid=9f747458f5990eaa8d43
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
patch:          https://syzkaller.appspot.com/x/patch.diff?x=143b02ed300000

Note: testing is done by a robot and is best-effort only.
