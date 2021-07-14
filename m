Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7DFF3C85E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 16:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239518AbhGNOTG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 10:19:06 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:52058 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239513AbhGNOTF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 10:19:05 -0400
Received: by mail-il1-f200.google.com with SMTP id g9-20020a92cda90000b029020cc3319a86so1184892ild.18
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jul 2021 07:16:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=o7vzzn8Fdqo6mJv/pLO3d3/VK2CXYs/bZovvWQfPikg=;
        b=KzCSCSMN+crwLkz593v4j/McVDiLItupJ527b3js324Ib5Ucy6Aj6lxg7B3shtWhbP
         UsQy9hc4XTNaZIvMeq+TR53Z+wvbQPVwnshIqnP+scgyEc++Pvm5pkkYXZ9V+6IPX1xn
         YIQRB0FpI8/DSsRzd1dTviybs0Qgxcd9FISfcbfHfVXJZMmIs8Fcb1LNVsVZeMlQPOSi
         51F2GaRdvK97R3xhTtXDK/S8OTqSNTrCk0yh8tiVMY1oBj6kQ2RJ2b3GNBfOvx3C5mbh
         /z3QXYhdnbjTpWxaVts/EO7vlQ713w2jRTF2zKQkzS/l2KaujCqHGJBcd4vVsMqKvOX/
         s79Q==
X-Gm-Message-State: AOAM530BLFkoV55I5LjAiuCbb24Zc2ZSt92U7FPtxoB4aBEDFOMWyRcn
        gkAc4ZPe7sKr1JGozViWeMurHFM1JqUPx3/pnc0t38tlpM3V
X-Google-Smtp-Source: ABdhPJyn5tnlHP/kmIUxY05yxnh++4KY2h8hZkCs4WMGvpSLvMoszqGmE7eJ+eEIVEap1ROsNTlb3lNO/a43b+1kLs7gtu5pRZC4
MIME-Version: 1.0
X-Received: by 2002:a92:d3d1:: with SMTP id c17mr6620254ilh.86.1626272172775;
 Wed, 14 Jul 2021 07:16:12 -0700 (PDT)
Date:   Wed, 14 Jul 2021 07:16:12 -0700
In-Reply-To: <20210714135756.ammzl2vfiepzg3ve@wittgenstein>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002aa03b05c715ff73@google.com>
Subject: Re: [syzbot] KASAN: null-ptr-deref Read in filp_close (2)
From:   syzbot <syzbot+283ce5a46486d6acdbaf@syzkaller.appspotmail.com>
To:     brauner@kernel.org, christian.brauner@ubuntu.com,
        dvyukov@google.com, gregkh@linuxfoundation.org,
        gscrivan@redhat.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable-commits@vger.kernel.org,
        stable@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+283ce5a46486d6acdbaf@syzkaller.appspotmail.com

Tested on:

commit:         595fac5c cgroup: verify that source is a string
git tree:       https://gitlab.com/brauner/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=20276914ec6ad813
dashboard link: https://syzkaller.appspot.com/bug?extid=283ce5a46486d6acdbaf
compiler:       

Note: testing is done by a robot and is best-effort only.
