Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB87287D16
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 22:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730373AbgJHU2P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 16:28:15 -0400
Received: from mail-io1-f78.google.com ([209.85.166.78]:34487 "EHLO
        mail-io1-f78.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730369AbgJHU2N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 16:28:13 -0400
Received: by mail-io1-f78.google.com with SMTP id y70so4641946iof.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Oct 2020 13:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=7y3B3XsOiPTLYLIDns6NguVsL9ucnpw4TXcZn72tI0c=;
        b=TpzLfWTWgXl92MSUzTwr3sE8B4+2PiLbwd/oYm1J19C/5ttGVF3k0Qm45cGh8UI1sY
         HKA3d/6nVoecH3BHhGQxWsIVvFR+tA45UlFBIHHOQu526MxPthm3mOhnhrLxDU4+vY/l
         6V7095LLfzZe8BR2jV8DeiMMES1a2uJRpYYQApTWqVnGF0BBKRY6vxfbfvLCzbypX+8u
         O6ZCuanXnH7ag7ezWDMTIB3GjXOJNBzdBgWD2VyoLNSTpvZkyav2s9eFxk7E0ZvxuUUs
         sK8a18uIZi0lMQhft5r35zc0bJh0OVD1ylH34ae8AlTKCEsrnZVShCvu8QkjhRtpWhSI
         xWvg==
X-Gm-Message-State: AOAM533gvm/bhRjH1qf0CNh43xCQFCmIvozCXyecJ3LWO+jaTOt/S18i
        TE6g2Kq3R1N+iZPpOmJ3r2xcM2PKQQl/vcLj8beLYKVTR6Cl
X-Google-Smtp-Source: ABdhPJxQG7zkhxy1g7ndmakw3pFTvWpidkFGm3ConSOutpg5F4NLy+BDbf/l7aHvxuH3DwXEGuIgtAHY6s+z1objQuaP9/PVvEnF
MIME-Version: 1.0
X-Received: by 2002:a92:1f44:: with SMTP id i65mr7622723ile.280.1602188890683;
 Thu, 08 Oct 2020 13:28:10 -0700 (PDT)
Date:   Thu, 08 Oct 2020 13:28:10 -0700
In-Reply-To: <00000000000084dcbd05b12a3736@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b1412b05b12eab0a@google.com>
Subject: Re: general protection fault in percpu_ref_exit
From:   syzbot <syzbot+fd15ff734dace9e16437@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, bcrl@kvack.org, hch@lst.de, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, syzkaller-bugs@googlegroups.com,
        tj@kernel.org, viro@zeniv.linux.org.uk, vkabatov@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit 2b0d3d3e4fcfb19d10f9a82910b8f0f05c56ee3e
Author: Ming Lei <ming.lei@redhat.com>
Date:   Thu Oct 1 15:48:41 2020 +0000

    percpu_ref: reduce memory footprint of percpu_ref in fast path

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=126930d0500000
start commit:   8b787da7 Add linux-next specific files for 20201007
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=116930d0500000
console output: https://syzkaller.appspot.com/x/log.txt?x=166930d0500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aac055e9c8fbd2b8
dashboard link: https://syzkaller.appspot.com/bug?extid=fd15ff734dace9e16437
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=119a0568500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=106c0a8b900000

Reported-by: syzbot+fd15ff734dace9e16437@syzkaller.appspotmail.com
Fixes: 2b0d3d3e4fcf ("percpu_ref: reduce memory footprint of percpu_ref in fast path")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
