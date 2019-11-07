Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B748F302D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2019 14:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389454AbfKGNnD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Nov 2019 08:43:03 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:46618 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389083AbfKGNmI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:42:08 -0500
Received: by mail-il1-f200.google.com with SMTP id i74so2643228ild.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Nov 2019 05:42:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=uJH7mAU4uCSDV4aa0L0fNAi/CNHQFgrnxb0qCcwKuQg=;
        b=Pv+9spe1sqw1jUWKpc2O7Rl7ixBerqTgD3NjRLJ/vvUEDBSVp+pZtreXpWRLlGACFQ
         m+usUd3tNmsAl82xi1AuzncNMoXiDPxfVN+UMPQYZBdPegsDfEHbQXuF9hpQZqVCEIr7
         YV9ebbTAiwvGphXSLaEPxrMCbihoUMHSvmvC0Lxy4LqZcwlZ+qDJg3anfq0c1z1vaP22
         yf/9G0SXi0Ohglk6UR/w9R6ozW+ktBlIKPAV6aTPsIhjv/OGl4LT789AcPIdw9YT0fyi
         7pPAciDVln2fDtD9cxxWux2sAqaQcwKSmF4iNzxCCfOrP7MCjy7nbv820DqH1eL1OMAY
         NdDQ==
X-Gm-Message-State: APjAAAWpel/r3WhxH6vtO27zF93+5syx5tzzKueVX+UxtnB9lI5oS9Od
        Ig+SUkgNMkZ576McSrJ4Yc/v/shGfFsjg9VzJeDpbIU1icNh
X-Google-Smtp-Source: APXvYqyHrfdUeqRJ/p/UmqwSEH2PGF9vcIIDWWp+x12afNV5pmko9MIPBQwQ6EP0UabIBzdD2tA0EO3kdrl2IMEkfnCzwaSnZ0AC
MIME-Version: 1.0
X-Received: by 2002:a6b:ed05:: with SMTP id n5mr3546499iog.273.1573134126204;
 Thu, 07 Nov 2019 05:42:06 -0800 (PST)
Date:   Thu, 07 Nov 2019 05:42:06 -0800
In-Reply-To: <0000000000006971fa05769d22f6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c6cd1b0596c1d4a2@google.com>
Subject: Re: WARNING in request_end
From:   syzbot <syzbot+ef054c4d3f64cd7f7cec@syzkaller.appspotmail.com>
To:     dvyukov@google.com, ebiederm@xmission.com, ktkhai@virtuozzo.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, mszeredi@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 4c316f2f3ff315cb48efb7435621e5bfb81df96d
Author: Miklos Szeredi <mszeredi@redhat.com>
Date:   Fri Sep 28 14:43:22 2018 +0000

     fuse: set FR_SENT while locked

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=113124ba600000
start commit:   0238df64 Linux 4.19-rc7
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=88e9a8a39dc0be2d
dashboard link: https://syzkaller.appspot.com/bug?extid=ef054c4d3f64cd7f7cec
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=119bf2e6400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1760f806400000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: fuse: set FR_SENT while locked

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
