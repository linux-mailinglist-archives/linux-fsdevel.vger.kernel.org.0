Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD40BA49B9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2019 16:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbfIAOGB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Sep 2019 10:06:01 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:47763 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfIAOGB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Sep 2019 10:06:01 -0400
Received: by mail-io1-f69.google.com with SMTP id b22so15547441iod.14
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Sep 2019 07:06:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=9+b64TJ7Wgc7oSj44lFhNcMZ8K+apd8ZDigaEmOoDQs=;
        b=bmQ2PHvPehz7ily3EAUc3nRfLqV9jJiVT8TQI2l/r+6WExzwP34w1NPPMU0P4/zU1e
         co7tIwuBAhgJftnuQoDx2dG1CQ0tNPlj1nvDbmiOiY2RPWzhfCyHPU2GQcbmg5eB0WAt
         Gl9iSRpTsyvGQFrx3R5IxyN+oFxDsDA8SvOmQE6Pa/X/ycVXzhi3Bpvgt8Y6zDLHNDNl
         MPFKH3e/fLLSaf9IFdHQ8jgNu55xheoB1L3sYASRJrjRZleqm85mI08RRjq+LLq07omh
         eLeh5FGkmLIJv6F4a+XRlpjAr37LSQOB19jFxNRRwZK7mD1YCrEOejEapmMPaGmNie42
         3Z8g==
X-Gm-Message-State: APjAAAX0K442NsGapLJgQUbX9Q+jHhaOkLv3OTo2/Oi8jifJ+vMnKS4O
        tDafB4HXWjqap+XEh8YN39xAHkvB/TtrTOgZe3d7H6/dpDzq
X-Google-Smtp-Source: APXvYqygGQ3rpl4o7+tjLJB/SJ7oeQRVOkbVbQnlAaICG51/j53rAYoLcGLBC5rWvW23w9FodKiZbrc7PyHh4kLjEr+72FGrPdt/
MIME-Version: 1.0
X-Received: by 2002:a5d:81ce:: with SMTP id t14mr8009244iol.97.1567346760477;
 Sun, 01 Sep 2019 07:06:00 -0700 (PDT)
Date:   Sun, 01 Sep 2019 07:06:00 -0700
In-Reply-To: <0000000000003675ae05915a9fd3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e5f0e805917e5a60@google.com>
Subject: Re: WARNING in kfree
From:   syzbot <syzbot+5aca688dac0796c56129@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, ebiggers@kernel.org,
        gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this bug to:

commit 3deadeebafcec6a0a7c9397bd32ea5ac6d5191c1
Author: David Howells <dhowells@redhat.com>
Date:   Mon Jan 21 14:04:22 2019 +0000

     vfs: Convert debugfs to use the new mount API

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=115d9e56600000
start commit:   ed2393ca Add linux-next specific files for 20190827
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=135d9e56600000
console output: https://syzkaller.appspot.com/x/log.txt?x=155d9e56600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ef5940a07ed45f4
dashboard link: https://syzkaller.appspot.com/bug?extid=5aca688dac0796c56129
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1595ee12600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16df7fd2600000

Reported-by: syzbot+5aca688dac0796c56129@syzkaller.appspotmail.com
Fixes: 3deadeebafce ("vfs: Convert debugfs to use the new mount API")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
