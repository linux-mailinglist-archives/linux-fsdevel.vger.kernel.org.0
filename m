Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F225D1BDB79
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 14:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgD2MME (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 08:12:04 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:42915 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbgD2MME (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 08:12:04 -0400
Received: by mail-io1-f71.google.com with SMTP id d188so2189925iof.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2020 05:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=PcO8Kd1YBitB52qqPhTJQcKlql/IIwrSnAimZeG48WY=;
        b=i6cvyuHvPD4bNbBPfXIDpeqkVi8V+C/8iNKveabx5QIfg8iJYAZWYYBH9EDTIbFAEe
         DTctARbMRX/H3BYObL56IFXekMkejU9MZV2guiM4GOXoEu2dgpfskdLTZ2VoPuToQLhy
         pmkRk+6YUvDYqhnlSsa94z26UFyRqbTbJAKGlJxdF+ud4Kuj+F3Yw4TL8XILwgIgYRRj
         P/Wwd416Vbk/PtkGL0mTfcGS/BNHQDTkjRILEKA1NrJ6s0vTH/ym/T3TiEJVUOrrHGGJ
         IseFCcmvD9SadlIlV1zsHTCF3poL2F1DOguxi3FXnuSb8Bs2pen0WifRdrAJaWg7f9Kc
         56dA==
X-Gm-Message-State: AGi0PuaPBRpVFPhZfbpG0/gxcttjaW+5mOZaURRnt27Bn9yLi3ataLNV
        ySjJMH6DeeB8dU1/KZ5soWpteB7xBuSoNT2z35sJmVSLUuH9
X-Google-Smtp-Source: APiQypJP2W68RxtxIieiSS1l8KwM59eBNQMIxwjGv9JUZ6878yRXgSmubwKDBS1vqBOIm8e+WhASeRnX1wkEPaga96kMUFN9cOqO
MIME-Version: 1.0
X-Received: by 2002:a92:6c0b:: with SMTP id h11mr72208ilc.158.1588162322766;
 Wed, 29 Apr 2020 05:12:02 -0700 (PDT)
Date:   Wed, 29 Apr 2020 05:12:02 -0700
In-Reply-To: <00000000000051770905984d38d3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001821b605a46cdb7f@google.com>
Subject: Re: WARNING in exfat_bdev_read
From:   syzbot <syzbot+1930da7118e99b06e4ab@syzkaller.appspotmail.com>
To:     alexander.levin@microsoft.com, davem@davemloft.net,
        devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, namjae.jeon@samsung.com,
        pragat.pandya@gmail.com, syzkaller-bugs@googlegroups.com,
        valdis.kletnieks@vt.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 5f33771fb0ac484d6e8cc34cb1e27c37442cd0db
Author: Namjae Jeon <namjae.jeon@samsung.com>
Date:   Fri Jan 3 01:13:45 2020 +0000

    staging: exfat: add STAGING prefix to config names

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1407f818100000
start commit:   32ef9553 Merge tag 'fsnotify_for_v5.5-rc1' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff560c3de405258c
dashboard link: https://syzkaller.appspot.com/bug?extid=1930da7118e99b06e4ab
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e208a6e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11f83882e00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: staging: exfat: add STAGING prefix to config names

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
