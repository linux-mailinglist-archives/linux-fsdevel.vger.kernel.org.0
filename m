Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48D02139A72
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2020 21:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgAMUCC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jan 2020 15:02:02 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:40167 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbgAMUCC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jan 2020 15:02:02 -0500
Received: by mail-io1-f70.google.com with SMTP id e200so6491847iof.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2020 12:02:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=0WQiXIsAJotmOovsOJkAJagLAGPEvGVf6LY+V+HPFS4=;
        b=VsceXNIniUySU4vfCk/IiBrVPdN0KSyB7jl48GWxmf72dIJZnehy8QSy40rH1siVgr
         Qx4fk7Wg7RKrMfhVze778BhrVEVET4o+EPoyVi3evd7hAOKdke/MNJDsBP4dxDkJBk8u
         saXReoNCCQ90TeKYlxFeEI+e1sqEofqrptqQ5EtjIU3+TsErhvEbGwrKimoLoZtaFzTH
         7t0yqKizYHT3HNFlJb0HmyQO4kAtTHOziGZQX44tjj98+epUfr3vIHM69QPibMeFBDsn
         hV/jm8d8JlJeRl86satbJihFG87+4KwgKu+vy7m21NT2vtTacrl6y/A+TwCE3ugJi7Cv
         2XPg==
X-Gm-Message-State: APjAAAXFY2ZJB5/pL5MoqiLo9OKuoBaofWTNj8BXRZAZxMy7dQvcS9oL
        nV4LZhFMRXTVppMI+iSTLXKl1Ll9r/b1CezP3sDVrg+1hMAv
X-Google-Smtp-Source: APXvYqzdqdMaIuaZGYk4ZSDZ03EA/5GJly7oM+QoISUNLEYZzj5obAzt8M8gozRrhbdr7aFXuqtPDKn7Alg0OqUZ9748hJL8D8I9
MIME-Version: 1.0
X-Received: by 2002:a02:c611:: with SMTP id i17mr16208083jan.28.1578945721401;
 Mon, 13 Jan 2020 12:02:01 -0800 (PST)
Date:   Mon, 13 Jan 2020 12:02:01 -0800
In-Reply-To: <0000000000008dcde00590922713@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d80d1a059c0af28a@google.com>
Subject: Re: WARNING: refcount bug in chrdev_open
From:   syzbot <syzbot+1c85a21f1c6bc88eb388@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, will@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 68faa679b8be1a74e6663c21c3a9d25d32f1c079
Author: Will Deacon <will@kernel.org>
Date:   Thu Dec 19 12:02:03 2019 +0000

     chardev: Avoid potential use-after-free in 'chrdev_open()'

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14412659e00000
start commit:   81b6b964 Merge branch 'master' of git://git.kernel.org/pub..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d98e4bd76baeb821
dashboard link: https://syzkaller.appspot.com/bug?extid=1c85a21f1c6bc88eb388
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=147ad0a6e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15483312e00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: chardev: Avoid potential use-after-free in 'chrdev_open()'

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
