Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF1CA351D19
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 20:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237945AbhDASXy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 14:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237043AbhDASNl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:13:41 -0400
Received: from mail-pf1-x445.google.com (mail-pf1-x445.google.com [IPv6:2607:f8b0:4864:20::445])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7A4C05BD12
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Apr 2021 05:54:33 -0700 (PDT)
Received: by mail-pf1-x445.google.com with SMTP id g205so3330678pfb.15
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Apr 2021 05:54:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=jQVQMiS1LEWH5WtHi83sZSFNvCzxIq0JJNYo0pCyIds=;
        b=VW/VbqkGqTTiSAhR3v0A0HhNagT3t2BS50Xb98zfYmtAIdh6+8dBbAQ6FSlTr2lxN4
         R/seZlVuQ7/hbqgcad9ht9uglA0CzW8S8b8auMWEmSsV/6gULKhx9DRsP1Z7ts6t2abO
         Y9jIQQR9CngB4IrpuSEInp9F5YJ7NFLi3SDZNWXgwIiGJXKpiSnMwHxsW5zgiJtmkgBL
         bc4oyWxhxbyAtUHgOm8Dr/MvygBSMZ8uNFuFxhqnlpKGZNfDXOWVMbqOcTPMS5v9hK3d
         TH9QL8mCBkx8Wozb9W5kbaoy+OAxsQVJtMZ4JwdTEmnJdmNV7umf0e261qFciYZmUFnG
         /UCg==
X-Gm-Message-State: AOAM533yUYaR6NY595yZAg8WkbPYpS6OH8Ihi9+xGqffj/DTnd4T/Oq+
        FKJ8Vi4nvtz8FXN8ih5thQQWObZ9QRKufVOfM5pNZ69P/Sp0
X-Google-Smtp-Source: ABdhPJwmxPi+IqOqqtvOaUuRwBvbO+Ll6B4LsWsA1DP5XCim1o0fOyk+c3GiRfbw6RMMWfUWK190yHSmAtKCH+A6sc01ISQtwEWH
MIME-Version: 1.0
X-Received: by 2002:a5e:841a:: with SMTP id h26mr6461960ioj.179.1617279363658;
 Thu, 01 Apr 2021 05:16:03 -0700 (PDT)
Date:   Thu, 01 Apr 2021 05:16:03 -0700
In-Reply-To: <0000000000003a565e05bee596f2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f9391c05bee831ad@google.com>
Subject: Re: [syzbot] WARNING in mntput_no_expire (2)
From:   syzbot <syzbot+c88a7030da47945a3cc3@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, chaitanya.kulkarni@wdc.com, damien.lemoal@wdc.com,
        hch@lst.de, johannes.thumshirn@edc.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit 73d90386b559d6f4c3c5db5e6bb1b68aae8fd3e7
Author: Damien Le Moal <damien.lemoal@wdc.com>
Date:   Thu Jan 28 04:47:27 2021 +0000

    nvme: cleanup zone information initialization

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1440e986d00000
start commit:   d19cc4bf Merge tag 'trace-v5.12-rc5' of git://git.kernel.o..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1640e986d00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1240e986d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d1a3d65a48dbd1bc
dashboard link: https://syzkaller.appspot.com/bug?extid=c88a7030da47945a3cc3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12f50d11d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=137694a1d00000

Reported-by: syzbot+c88a7030da47945a3cc3@syzkaller.appspotmail.com
Fixes: 73d90386b559 ("nvme: cleanup zone information initialization")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
