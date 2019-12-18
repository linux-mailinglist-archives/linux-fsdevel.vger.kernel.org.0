Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB85D124D07
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 17:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfLRQVB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 11:21:01 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:40259 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbfLRQVB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 11:21:01 -0500
Received: by mail-il1-f197.google.com with SMTP id 138so1219132ilb.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2019 08:21:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=IuaTqXhxelJhKDHw5O7rzxkzTsdD5izns8/dKhJuhOU=;
        b=gc+D1k8IokXdLFmst4QiWZ6nFCnPcsKyuJapNOxNA4IuyRwOO7TZ6aRvvaD9mcC/y7
         9fS4dCmh51ZVsWPJGYJjerVjmH8WYhvB/W+bzriJPA1o4XwO+L9j910PnYL+J282UWpv
         3fQy5yCt7vvUEa4+oxUDc+ZqxF2nuGvVbshAqMEOXNidOi53gMj7flIYQa6aqQipPSgL
         Fx+bO0JGPfmHwiYYPkF/VvEEcZ3Ss4v95809vdKj9DkwrBERewryaKbOg4OybZDKqST3
         +BH3dUZ50s6E94I1m+wH15q25diuGA/SV3d6+xeAKQjLOaiW6OuWRAlwRzXqML4WotTr
         F4Jw==
X-Gm-Message-State: APjAAAVuRUk7o3o/kTGusN4mjHvszr+zEZ3GsiFJrNbL845z7EA38Mrr
        H9tukxEcJn/aSfun3Uc1mEyupXDdLpvEsROSbkxel5HJM1Ha
X-Google-Smtp-Source: APXvYqxlpQuOxZYicynxx6hVRSGFToWAMtcNMVHatrpxa6mopdSMqi85r6C8n0BH/LoOoq7aqqMM4kgR3L2zKnho69XDz0uvKC9k
MIME-Version: 1.0
X-Received: by 2002:a92:8dc3:: with SMTP id w64mr2462439ill.68.1576686061030;
 Wed, 18 Dec 2019 08:21:01 -0800 (PST)
Date:   Wed, 18 Dec 2019 08:21:01 -0800
In-Reply-To: <0000000000002df264056a35b16b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009716290599fcd496@google.com>
Subject: Re: kernel BUG at fs/buffer.c:LINE!
From:   syzbot <syzbot+cfed5b56649bddf80d6e@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, bvanassche@acm.org, jaegeuk@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this bug to:

commit 5db470e229e22b7eda6e23b5566e532c96fb5bc3
Author: Jaegeuk Kim <jaegeuk@kernel.org>
Date:   Thu Jan 10 03:17:14 2019 +0000

     loop: drop caches if offset or block_size are changed

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13f3ca8ee00000
start commit:   2187f215 Merge tag 'for-5.5-rc2-tag' of git://git.kernel.o..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=100bca8ee00000
console output: https://syzkaller.appspot.com/x/log.txt?x=17f3ca8ee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dcf10bf83926432a
dashboard link: https://syzkaller.appspot.com/bug?extid=cfed5b56649bddf80d6e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1171ba8ee00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=107440aee00000

Reported-by: syzbot+cfed5b56649bddf80d6e@syzkaller.appspotmail.com
Fixes: 5db470e229e2 ("loop: drop caches if offset or block_size are  
changed")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
