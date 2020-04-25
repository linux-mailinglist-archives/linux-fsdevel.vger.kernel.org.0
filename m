Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46FEA1B870D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Apr 2020 16:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgDYOcK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Apr 2020 10:32:10 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:55755 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgDYOcF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Apr 2020 10:32:05 -0400
Received: by mail-io1-f69.google.com with SMTP id f4so14252356iov.22
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Apr 2020 07:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=rmlyaSN6XAcsIU4KSfybtQVJJEftnTSClaEZrW6WcQU=;
        b=MCHLCm341jdewq9GIte6AREZ64C+2OE0hSmTvPadU143lJkl/QHKFSrNGKVdUdUQMl
         0ndn3FcDmrf3Lrbpi//fN9jPapfAOni+xvnhXHOnzY2JxOvloq9hj47HBGw71nFvklIk
         VH81RzRI+OrD7h3FtcVVhK8ZwvbMDq9WDboPWGPSHw7krSh6NehruAtTdPqLRK/pyXSK
         +Osm4Td51O1gOsf3egV0mFujQ/zU7QGRuz7rcwqLSSi3gkyQ1vZtWuYkSoKKpApO3MDy
         aOPe4HwHmS/TEYmilS3ZCCkIWr57uGk+33dtRQiu44TkIEHSD+zcbO3ddKqioaeB+R9a
         JlAQ==
X-Gm-Message-State: AGi0PuZkq5HxspMuu126GvWk96Ig/Md7iBsGixzJ826mXG9CPAO6GvFr
        Q8TVSYKY4vhALQUGSP4qG8NiyOqSRUfZLv4Xz20EKzJ5m2KG
X-Google-Smtp-Source: APiQypI++Mtlx8XClDy5/XNNiu+1H0kUMLFRZD3sWDB4Aa8lzzoEoKOC3FYxwiJ9yXlLAmyYuF2FE58rlTm2ekn/XWhGCsiAbA/k
MIME-Version: 1.0
X-Received: by 2002:a92:8499:: with SMTP id y25mr13978461ilk.268.1587825123164;
 Sat, 25 Apr 2020 07:32:03 -0700 (PDT)
Date:   Sat, 25 Apr 2020 07:32:03 -0700
In-Reply-To: <0000000000006233e4059aa1dfb6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006e8a3e05a41e5813@google.com>
Subject: Re: possible deadlock in do_io_accounting (3)
From:   syzbot <syzbot+87a1b40b8fcdc9d40bd0@syzkaller.appspotmail.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org, avagin@gmail.com,
        bernd.edlinger@hotmail.de, casey@schaufler-ca.com,
        christian@brauner.io, ebiederm@xmission.com,
        kent.overstreet@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhocko@suse.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 76518d3798855242817e8a8ed76b2d72f4415624
Author: Bernd Edlinger <bernd.edlinger@hotmail.de>
Date:   Fri Mar 20 20:27:41 2020 +0000

    proc: io_accounting: Use new infrastructure to fix deadlocks in execve

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=124347cfe00000
start commit:   46cf053e Linux 5.5-rc3
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ed9d672709340e35
dashboard link: https://syzkaller.appspot.com/bug?extid=87a1b40b8fcdc9d40bd0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15693866e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12847615e00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: proc: io_accounting: Use new infrastructure to fix deadlocks in execve

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
