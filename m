Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C212548BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 17:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgH0PLS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 11:11:18 -0400
Received: from mail-qv1-f70.google.com ([209.85.219.70]:52956 "EHLO
        mail-qv1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728864AbgH0LnZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 07:43:25 -0400
Received: by mail-qv1-f70.google.com with SMTP id q12so4177128qvm.19
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 04:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=pwNkg447Nvt9DP6BHMmIFvIl++UIZS1Yr2SQgfIT/uI=;
        b=myfZmqiUjwzR73goP6Oq7axysOZOBDlYLvvz24I0piSmV7f2G7RSZOunr21Zyf4VyC
         eIRQb4COLUdTX8jJgLJhlJcViw53/nlE6P9iii5LzRlS+xvzPHh4xec7Llbr8GC6JWuW
         HJ5RnA6Jy7XkcejI7G+6/LWJUIkLvSbWGE9++mSq7cBa+6D2pvHEt3Osbl4LeWk3w2qh
         pY5Qg4g9GZ8l9DQnmcE54HVM0UGhjphOOfFnFTb7piORn5YB5lPmtysiedpdI/ZcEvo2
         7IiWo6GjFaU1KR4PXGqqEsk7OvlQd/gtONO5UYJD5R9HgMuuL4/LwwLIbyAdmrl0KsTm
         xiTw==
X-Gm-Message-State: AOAM531RFw5s/93snDe5jfrsA4paYrIB60id6zdtoCuZIywSPRYJozQN
        utrms4O2oYeFj6jtM19NG+M8Ey4jK+Ct/xdC/pDUV4xCGDa5
X-Google-Smtp-Source: ABdhPJxDRrpZipHuFzQ757CmsZAIU/5jJofSaXf8x7xPsEtScojRDRY1s41xcjRSEzQrCEIS6tw+8a9moYMqcFRKFDnWyN4YaXIz
MIME-Version: 1.0
X-Received: by 2002:a02:234c:: with SMTP id u73mr19132402jau.141.1598526846052;
 Thu, 27 Aug 2020 04:14:06 -0700 (PDT)
Date:   Thu, 27 Aug 2020 04:14:06 -0700
In-Reply-To: <00000000000068340d05add74c29@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d2adea05adda0870@google.com>
Subject: Re: WARNING: ODEBUG bug in get_signal
From:   syzbot <syzbot+e3cf8f93cf86936710db@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, arnd@arndb.de, axboe@kernel.dk,
        baolin.wang@linaro.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, oleg@redhat.com,
        perex@perex.cz, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tiwai@suse.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit a9ed4a6560b8562b7e2e2bed9527e88001f7b682
Author: Marc Zyngier <maz@kernel.org>
Date:   Wed Aug 19 16:12:17 2020 +0000

    epoll: Keep a reference on files added to the check list

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15e57751900000
start commit:   15bc20c6 Merge tag 'tty-5.9-rc3' of git://git.kernel.org/p..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17e57751900000
console output: https://syzkaller.appspot.com/x/log.txt?x=13e57751900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=978db74cb30aa994
dashboard link: https://syzkaller.appspot.com/bug?extid=e3cf8f93cf86936710db
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13236eb6900000

Reported-by: syzbot+e3cf8f93cf86936710db@syzkaller.appspotmail.com
Fixes: a9ed4a6560b8 ("epoll: Keep a reference on files added to the check list")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
