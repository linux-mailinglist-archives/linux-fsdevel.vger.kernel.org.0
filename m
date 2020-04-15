Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7BF41AB011
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 19:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436600AbgDORuM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 13:50:12 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:52361 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411463AbgDORuF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:50:05 -0400
Received: by mail-io1-f69.google.com with SMTP id c15so20742079iom.19
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2020 10:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=nHxID+TcYcl1NAxOyN05IyLFyVfL/SAIIcfsEnpexvY=;
        b=Z7APX3Z1lcyJfaccCGANtZDMxsdgb1UbN1yOx1ZfPsyj//6kXmB53lvj0Kxy/jdplD
         9DGVH8jqPxkUD05l/Iw0DZVg/TlLt+exou6IUUxF9OCdfmH1uIqkKtqtO1/yfPLzTL0r
         R5ufqqYx6HrpMiHgJKL8JSyP/pZnMKn8VLcE0D1j6PYm23LMxbJ0B+QVcA+Gbz4tubdX
         R5+YrXc9VrnWutiWPjohDYsgrVmRXQCQmnIBMxxSbZ+Nr4/0tk04itpPj/qq25xiY9OQ
         0FGy6XKdXxTYYkYWP5r4x+17ejeGeoVH+27s5VikIUwOSpIsBRbTccryXefp0K4Hvy/k
         SlMg==
X-Gm-Message-State: AGi0PuasnJciPMPiisat4T1kVH1wmuhPb9n8m5suc3FMSGPHVYPHrQ34
        V3hWJqdpFhXz+n5ue9ymgbZhHNtz8kTCfnX/W4cA5VNaHeB7
X-Google-Smtp-Source: APiQypKCFYBPF9OFykDZd9n8d4hXnAVLQ6F+DTzMLIY+9TSrA/7PY0fhxsgiHvbNThyhKTwcCS3oyc4PK82BmuGBS5ArqpOAKflC
MIME-Version: 1.0
X-Received: by 2002:a02:7785:: with SMTP id g127mr26306155jac.134.1586973002978;
 Wed, 15 Apr 2020 10:50:02 -0700 (PDT)
Date:   Wed, 15 Apr 2020 10:50:02 -0700
In-Reply-To: <000000000000f8a16405a0376780@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001c5eaa05a357f2e1@google.com>
Subject: Re: possible deadlock in proc_pid_personality
From:   syzbot <syzbot+d9ae59d4662c941e39c6@syzkaller.appspotmail.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org, avagin@gmail.com,
        bernd.edlinger@hotmail.de, christian@brauner.io,
        ebiederm@xmission.com, guro@fb.com, kent.overstreet@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhocko@suse.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 2db9dbf71bf98d02a0bf33e798e5bfd2a9944696
Author: Bernd Edlinger <bernd.edlinger@hotmail.de>
Date:   Fri Mar 20 20:27:24 2020 +0000

    proc: Use new infrastructure to fix deadlocks in execve

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=136aea00100000
start commit:   63623fd4 Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d2e033af114153f
dashboard link: https://syzkaller.appspot.com/bug?extid=d9ae59d4662c941e39c6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1374670de00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: proc: Use new infrastructure to fix deadlocks in execve

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
