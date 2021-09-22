Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE774414DCA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 18:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236579AbhIVQMi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 12:12:38 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:36662 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236568AbhIVQMh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 12:12:37 -0400
Received: by mail-io1-f69.google.com with SMTP id o18-20020a0566022e1200b005c3adb2571fso3262380iow.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Sep 2021 09:11:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=UmA5fLnL3GwryS2xj+yPX5YOnEleOA06k1MW7m7x+TQ=;
        b=sXNL6De8TCT9o969kT4UUfHuuOUwl4ixZ1ZHXc4G9D7gAfxNmPbDpvciE/XwtgjDnY
         PY/xRwtILHerZ4bv68sEzvwJT3BuZZiPv3t0lpSCVNWiKhIcN1RssnHLE6bhyqIDrpXc
         LsiwcxZtPdolnLOVLlZ4XoUBIPq94VbGkXjv3yKi/PnKI2oaoVb8qpzcsL/vY7r24Y6s
         iXXg1TgnfchdV4Ebx1RNzT/ssvNfd6flXB4TuEnllSRyk8uhil91KwjfHOJeUSkzljSu
         PVD3PFT8Mc1Jmmo490/muvEEaaNSrVHwG3XkIK+gZiHebKRlChT3aNVqSaOknKeFDDge
         NVvQ==
X-Gm-Message-State: AOAM532F92KNSy4Wlvh/5ZdHSjiqt5jkQF8PKHaiP1bzFU7KFdAIhFEY
        3IWd81rMLIUjJWhZlS4C/HoOYKiXKMGkF4j53p2qkukdvh6s
X-Google-Smtp-Source: ABdhPJxk7hBdI+nl+8MGWPeeiUS55BURR8MW1W0ABkOhmmB6xfRPaH4Zg21gdAytWslsTLtv90L4YtBUY3Dpl8CGzWDD5CQx3GH8
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:d86:: with SMTP id i6mr378919ilj.28.1632327067566;
 Wed, 22 Sep 2021 09:11:07 -0700 (PDT)
Date:   Wed, 22 Sep 2021 09:11:07 -0700
In-Reply-To: <000000000000e692c905bbe9192c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000050d0d05cc97c35f@google.com>
Subject: Re: [syzbot] general protection fault in nbd_disconnect_and_put
From:   syzbot <syzbot+db0c9917f71539bc4ad1@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, cs.temp3@bpchargemaster.com, hdanton@sina.com,
        josef@toxicpanda.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mail@anirudhrb.com, nbd@other.debian.org, nsd-public@police.gov.hk,
        stephen.s.brennan@oracle.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 794ebcea865bff47231de89269e9d542121ab7be
Author: Stephen Brennan <stephen.s.brennan@oracle.com>
Date:   Wed Sep 1 17:51:42 2021 +0000

    namei: Standardize callers of filename_lookup()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1163691d300000
start commit:   acd3d2859453 Merge tag 'fixes-v5.13' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f04bb30bd3c55050
dashboard link: https://syzkaller.appspot.com/bug?extid=db0c9917f71539bc4ad1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13f63543d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=122c8ef1d00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: namei: Standardize callers of filename_lookup()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
