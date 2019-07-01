Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7695BB4E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 14:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbfGAMOB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 08:14:01 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:44939 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbfGAMOB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 08:14:01 -0400
Received: by mail-io1-f72.google.com with SMTP id i133so14933625ioa.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jul 2019 05:14:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=NWf6zAXmXdVI9wmyrTa+FuCFWEZ41w0HLTqj15sQqqk=;
        b=NKDXb5cMoeURel876B699Bjycc0VYO1ht2RuuDoW5ougczRNK9VNUuY7HCbv8OiArR
         aAC5S/Ovvrhpoge4KO7FlnotxenLWF09/514y1hqVpdKuGA/r/50Ts3RjQzrKrebbk0W
         gLE1vdQdoeFuiMsqx0yvwKwI4AbKV+t4CKgIz0ygQdZRW+/1529oZauqc+abh/fcdNn/
         m62cUGaDD82Bv4PoQA4JszgThUJftdbzP+hnus+9eJ7r02FOmuzQpFBoO9pJcUpdoP/n
         mEm4SM07hScW2J6w0TeWTQW57Gey9uLccb/Qic5xVRQsLcWDms0+TkrKAsLFt+2HLfs3
         mGZQ==
X-Gm-Message-State: APjAAAXNtP82E0cvWRWV6CKpDsnhB3+y0Vn0M7Ne8eRR1jZ0CE22V2Ma
        DIWa3f6CMC9chluoyej5yfcPNPXKtmciX37qKj/VJuh9C2ix
X-Google-Smtp-Source: APXvYqymMtF4Sb3QSuurBcHYsH3E8Req+IEh12sC9+1vRDayQ+vOG5A9GROOa0/UnLqUgLp/5wtZGfRSO49p8UhKW1mNXVSK9KiL
MIME-Version: 1.0
X-Received: by 2002:a5d:8497:: with SMTP id t23mr25182314iom.298.1561983240729;
 Mon, 01 Jul 2019 05:14:00 -0700 (PDT)
Date:   Mon, 01 Jul 2019 05:14:00 -0700
In-Reply-To: <000000000000a5d3cb058c9a64f0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000357fba058c9d906d@google.com>
Subject: Re: kernel panic: corrupted stack end in dput
From:   syzbot <syzbot+d88a977731a9888db7ba@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this bug to:

commit e9db4ef6bf4ca9894bb324c76e01b8f1a16b2650
Author: John Fastabend <john.fastabend@gmail.com>
Date:   Sat Jun 30 13:17:47 2018 +0000

     bpf: sockhash fix omitted bucket lock in sock_close

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17f7f4d5a00000
start commit:   7b75e49d net: dsa: mv88e6xxx: wait after reset deactivation
git tree:       net
final crash:    https://syzkaller.appspot.com/x/report.txt?x=140ff4d5a00000
console output: https://syzkaller.appspot.com/x/log.txt?x=100ff4d5a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e7c31a94f66cc0aa
dashboard link: https://syzkaller.appspot.com/bug?extid=d88a977731a9888db7ba
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=130f49bda00000

Reported-by: syzbot+d88a977731a9888db7ba@syzkaller.appspotmail.com
Fixes: e9db4ef6bf4c ("bpf: sockhash fix omitted bucket lock in sock_close")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
