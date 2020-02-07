Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3411560F0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 22:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbgBGV6E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 16:58:04 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:34195 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbgBGV6D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 16:58:03 -0500
Received: by mail-io1-f70.google.com with SMTP id n26so606786ioj.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Feb 2020 13:58:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=W19wD+6tfTNDp+aV2Lk+F8lK/QrKkxo/+Ppz61rvmy0=;
        b=E1kTMUATswlAH5253C16dPiD3VxoonGuuiue3UcLZUdFsghkp5E8KgnyeufiN9ohvz
         S7Xc8tj86q0Ajezk2MmC0rDqW6Qg535a6ckjZtG+uF/pHvPzUq651FPICAK4MxSvJkz4
         5o2Al5XHEnO3F0myx4+qrnpzDY3tuzGAlHw+zx3OcmarEdPVBY1x8tLyP83by8k6nZbT
         HFmx6gYnNz32bQMm1fRL6zaqykgfexf0rEKLrpXRgGf4HUc4En+DT26TYdUYGmfq7aFd
         GpT5O2VL5qgJESYjT5itQUR+JoTnTjhF06QMbjGh3T4MwQf+S+Q6dzBuSFRUD+5arR4u
         nUYw==
X-Gm-Message-State: APjAAAW+21a8p7Ix0Zj2WfdyKnUI4lfXU/JGatMfPcMuERc/iw0Hh0LO
        l8xqSvepJ2lbPGMeTvGUFyjo/4c12dC+EOlkRhPgXKfCDmSX
X-Google-Smtp-Source: APXvYqxVxIlLYhnPbOxSejnGOT841+/VwCnwX8a4WtJ3oEOV5qwNJPQ9lQs8cstQ3checqsjzAkOriGHYbqdsIZkXL/M2UzITXwc
MIME-Version: 1.0
X-Received: by 2002:a02:cc75:: with SMTP id j21mr492335jaq.113.1581112681695;
 Fri, 07 Feb 2020 13:58:01 -0800 (PST)
Date:   Fri, 07 Feb 2020 13:58:01 -0800
In-Reply-To: <000000000000d895bd059dffb65c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000be1109059e037b83@google.com>
Subject: Re: BUG: sleeping function called from invalid context in __kmalloc
From:   syzbot <syzbot+98704a51af8e3d9425a9@syzkaller.appspotmail.com>
To:     idryomov@gmail.com, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        xiubli@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this bug to:

commit 4fbc0c711b2464ee1551850b85002faae0b775d5
Author: Xiubo Li <xiubli@redhat.com>
Date:   Fri Dec 20 14:34:04 2019 +0000

    ceph: remove the extra slashes in the server path

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=166a57bee00000
start commit:   90568ecf Merge tag 'kvm-5.6-2' of git://git.kernel.org/pub..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=156a57bee00000
console output: https://syzkaller.appspot.com/x/log.txt?x=116a57bee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=69fa012479f9a62
dashboard link: https://syzkaller.appspot.com/bug?extid=98704a51af8e3d9425a9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172182b5e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1590aab5e00000

Reported-by: syzbot+98704a51af8e3d9425a9@syzkaller.appspotmail.com
Fixes: 4fbc0c711b24 ("ceph: remove the extra slashes in the server path")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
