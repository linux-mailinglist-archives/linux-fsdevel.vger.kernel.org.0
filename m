Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8729221DA23
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 17:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbgGMPeH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 11:34:07 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:36318 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729649AbgGMPeH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 11:34:07 -0400
Received: by mail-il1-f198.google.com with SMTP id t19so9738839ili.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2020 08:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=PuwK5sOU81rM/XoQcuJqMMPHQ+Gr8re6yhX7o7C4muQ=;
        b=GncOLDhZbdWgNkqboOKTfN1K3vHyOQ9oaaAUepxW+IDWthVrqLyk9lYLQcPbMFMoNk
         8Isn3RGpcpllATlt+2PbLehhvvGmyOyRQNAvq8BapiRyfAUDfY5oJYw8U+80SmbLwvDD
         KJ93lMnbHCURe3M2dbAirT1fkjSGXCWdj6p6QqeaOMg7D0e97+4ZO6MRw5kTWi3eozvr
         oyvhPaLZf46lRtYttYQOvSZ5wyk1uA2yk2/lgv40SLlBY9WZ46rAd2hdWDyGO5W0ciVe
         IYrkkLfr7VBKcAEVrD5EPtIL1iVOd3P/hYtpeRpsytHJzq/+13PIvRdqzYpWgiseKbWT
         jWgA==
X-Gm-Message-State: AOAM5311lc8n5xTykRmxCMR5WWsz7Id6TGtynFHsvDt1nEwdMeUkzue9
        aZtng1MbuL2KuHEpv2NCYwQq7rtXQkylBPxdlAEwNkPALS8C
X-Google-Smtp-Source: ABdhPJydbjbFEZskX61aECXgpw3Hf5lQrLPxhVEfS8LhGnBo3W5qg9pPTvobj6Hs8ic5kEJcDP2fXDOcy5fkMgW8HBxuPOvZeySr
MIME-Version: 1.0
X-Received: by 2002:a92:1bd5:: with SMTP id f82mr225494ill.121.1594654446305;
 Mon, 13 Jul 2020 08:34:06 -0700 (PDT)
Date:   Mon, 13 Jul 2020 08:34:06 -0700
In-Reply-To: <0000000000001bbb6705aa49635a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cfc8ff05aa546b84@google.com>
Subject: Re: KASAN: use-after-free Read in userfaultfd_release (2)
From:   syzbot <syzbot+75867c44841cb6373570@syzkaller.appspotmail.com>
To:     Markus.Elfring@web.de, casey@schaufler-ca.com, dancol@google.com,
        hdanton@sina.com, jmorris@namei.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, stephen.smalley.work@gmail.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this bug to:

commit d08ac70b1e0dc71ac2315007bcc3efb283b2eae4
Author: Daniel Colascione <dancol@google.com>
Date:   Wed Apr 1 21:39:03 2020 +0000

    Wire UFFD up to SELinux

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14a79d13100000
start commit:   89032636 Add linux-next specific files for 20200708
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=16a79d13100000
console output: https://syzkaller.appspot.com/x/log.txt?x=12a79d13100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=64a250ebabc6c320
dashboard link: https://syzkaller.appspot.com/bug?extid=75867c44841cb6373570
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13c4c8db100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12cbb68f100000

Reported-by: syzbot+75867c44841cb6373570@syzkaller.appspotmail.com
Fixes: d08ac70b1e0d ("Wire UFFD up to SELinux")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
