Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEBD27F24B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Sep 2020 21:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730352AbgI3TDI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Sep 2020 15:03:08 -0400
Received: from mail-io1-f77.google.com ([209.85.166.77]:33748 "EHLO
        mail-io1-f77.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730784AbgI3TDH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Sep 2020 15:03:07 -0400
Received: by mail-io1-f77.google.com with SMTP id m10so200713ioq.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2020 12:03:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=4BsGJwLCSmtEpgZ5Z5TL9+bN9hykq9gqd70JSnuK+q4=;
        b=n4LfMLvnyC4X10gOizrwqfevlutOK6uuy1hqlkbz0+C/U4x5l+MTrqUEnMQRWn8ngd
         8cbNEH2a2oYUzi4JcgcYYPuo4pz67dlAstxvRW1X7/gNXOKPHmA/TnjUObHAn8Bw/nAk
         R8vzg5+CuSgLSipzupYGsKMECpA1YpKCyVnkCAzU2rtnb1huBZLHSh9rf/6Q3sjDwxjC
         Zk0e6f+QY3fzo+E2tRN5W4FIKYMTXH705RN1Jl2TPBkSUboxBa4rzSBCPhDxFDGRkte1
         r+g0FSxOjSsEGfHF4YaHgu0jT83qqVjsaEweb2MTsohkgA3GOlOtItqeOhHKVIZjA9jD
         JDgw==
X-Gm-Message-State: AOAM5319Ek9bv8/V8QoHCHRGs2p8KmOgIWq9UCyV5BM5cgT9/d5kKcjE
        iIc7c9iDTKnLYrspPFsqXrtVJl1DHTBPUgxIaIDigGsZF7Cw
X-Google-Smtp-Source: ABdhPJxT/TNj9sdzI1Jlqa8xdgNr1o/U4WTpEAMAVh5Rh6fkvvL6SudGSXDHlQCQ7DGsgEXq2bYAjTIEJDAHSbWWWWn5XGCRZh0F
MIME-Version: 1.0
X-Received: by 2002:a05:6602:121c:: with SMTP id y28mr2845266iot.156.1601492584835;
 Wed, 30 Sep 2020 12:03:04 -0700 (PDT)
Date:   Wed, 30 Sep 2020 12:03:04 -0700
In-Reply-To: <000000000000e82e1a05afd0605d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a1321d05b08c8c9b@google.com>
Subject: Re: KASAN: use-after-free Read in afs_deactivate_cell (2)
From:   syzbot <syzbot+a5e4946b04d6ca8fa5f3@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit 13fcc6837049f1bd76d57e9abc217a91fdbad764
Author: David Howells <dhowells@redhat.com>
Date:   Thu Nov 1 23:07:27 2018 +0000

    afs: Add fs_context support

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13ea9ea7900000
start commit:   49e7e3e9 Add linux-next specific files for 20200929
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=101a9ea7900000
console output: https://syzkaller.appspot.com/x/log.txt?x=17ea9ea7900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b823d07e241e7aee
dashboard link: https://syzkaller.appspot.com/bug?extid=a5e4946b04d6ca8fa5f3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=173c446d900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ba5be3900000

Reported-by: syzbot+a5e4946b04d6ca8fa5f3@syzkaller.appspotmail.com
Fixes: 13fcc6837049 ("afs: Add fs_context support")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
