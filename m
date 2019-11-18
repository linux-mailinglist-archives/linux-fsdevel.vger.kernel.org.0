Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19EA0FFD08
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2019 03:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfKRCOC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Nov 2019 21:14:02 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:35537 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfKRCOC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Nov 2019 21:14:02 -0500
Received: by mail-il1-f197.google.com with SMTP id w69so15093696ilk.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Nov 2019 18:14:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=0hJK8rPWOFUddMB0lJimGQDZPQJFXDrAgb0buhY0TvU=;
        b=T0TxwHn9/84d+Ov1yhVoAyAOGkhIzug4oAk/xsIG2advpgENcOn6ZGgp+TNVIg3l/P
         v8pYMjMMLbNOC4oNfU+G/kgt0yqd/pTIc5M+NZ7tiSflc+QtGqftc+M9x3VNmrekmBpK
         ZfDusSmagf9EL65gd3xBWBriJUNudjnVdcLaGmRyitMRnbKOx4KiqH7L5kQTUNXk7gld
         TbIHS3A1XZYWckzDlpH3vjmmwWzIu0xsiolWz5FgJocMIFL0UyySHwGHbBKkfjd7R+A9
         SkoLVSMps2N6sBMRanyAuxDKaKFKTesxegy+8HAegcXuRrWQg8IxJ+tjBCPEwdCgtxo6
         1rnQ==
X-Gm-Message-State: APjAAAUtrZFVa869xFeTw0x5rKhdRlrMOjJDkwo4wFZzK3t2GiClpX2C
        MTDXZbroyHi/0jVIbIdGTAPL+e7S7nme4Rvw0l2lXs4ANUvX
X-Google-Smtp-Source: APXvYqwZhRrNpOcp3K1jSna3NVMQ3Y9eKDGXT7VjA9/ZYXXiCNJMlXd57obKMz7tPT7gqZ5PakMzS/X78yIoSTTNHjwPUi2z8UDS
MIME-Version: 1.0
X-Received: by 2002:a92:660e:: with SMTP id a14mr13677440ilc.235.1574043241343;
 Sun, 17 Nov 2019 18:14:01 -0800 (PST)
Date:   Sun, 17 Nov 2019 18:14:01 -0800
In-Reply-To: <00000000000044cbf80576baaecd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000042f41905979580cc@google.com>
Subject: Re: possible deadlock in path_openat
From:   syzbot <syzbot+a55ccfc8a853d3cff213@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, ast@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this bug to:

commit 8e54cadab447dae779f80f79c87cbeaea9594f60
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Sun Nov 27 01:05:42 2016 +0000

     fix default_file_splice_read()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=108f4416e00000
start commit:   6d906f99 Merge tag 'arm64-fixes' of git://git.kernel.org/p..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=128f4416e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=148f4416e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=856fc6d0fbbeede9
dashboard link: https://syzkaller.appspot.com/bug?extid=a55ccfc8a853d3cff213
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101767b7200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13c15013200000

Reported-by: syzbot+a55ccfc8a853d3cff213@syzkaller.appspotmail.com
Fixes: 8e54cadab447 ("fix default_file_splice_read()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
