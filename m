Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2A9E1F1F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 14:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730691AbfEOL7C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 May 2019 07:59:02 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:44047 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730461AbfEOL7B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 May 2019 07:59:01 -0400
Received: by mail-it1-f200.google.com with SMTP id o83so2023527itc.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 May 2019 04:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=wLlE37yrPzANdfG8Iq9EHwFi5Q9N85cm606vgS2oU/4=;
        b=Zc4DiB5H2qMnGTf87hgXEQjYVPYAu4Y5Ko8yOGyVDvic+9BCs5qNP5BGLbDwujDOrK
         ya893djp2schtlW5gnI38C5sZ57WlQpkcWSj7Um0xzz03h7CG0/IMDY1MhSmxkg2MDcV
         O0aPATPqdPcbps44h4gKnezOlD4hFYZefw34VLL/cRW2RrGQv2b4EyYm1Cis6qFZ1hXf
         FkOrHdblpUQ4Qx0De7TTyOV7EnyFAJ+5RP8NmbQAbqKyjqWwOCB76/fq4AwDax9mvH9v
         KWCCZaPok39G6Azu0ve2dPQT/1Qj6TEoUpKtlQ0K86wTDWsXQc476IwCVNjrgCMXQoRU
         eevw==
X-Gm-Message-State: APjAAAVLlmT7QB479wT4Q1b8G9SPLUmEdN5UHQASvcfBX+pCdHhNHDSA
        3w92EBH/GjW2Lve/3WUZNJagDtrYgJEr5Y1GcuGoWMmjqXTn
X-Google-Smtp-Source: APXvYqxhuea74sT72yLEr885VWUmC0yDDZPYDcDl1CPKw5tL3esMrV9W9iAbuAnr0eDXBy6JlimI1pULYWtWhNarz5FlgldoTSCn
MIME-Version: 1.0
X-Received: by 2002:a24:f68b:: with SMTP id u133mr7534350ith.139.1557921541063;
 Wed, 15 May 2019 04:59:01 -0700 (PDT)
Date:   Wed, 15 May 2019 04:59:01 -0700
In-Reply-To: <20190515102133.GA16193@quack2.suse.cz>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000b0c360588ebe04f@google.com>
Subject: Re: INFO: task hung in __get_super
From:   syzbot <syzbot+10007d66ca02b08f0e60@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, dvyukov@google.com, jack@suse.cz,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+10007d66ca02b08f0e60@syzkaller.appspotmail.com

Tested on:

commit:         e93c9c99 Linux 5.1
git tree:        
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v5.1
kernel config:  https://syzkaller.appspot.com/x/.config?x=5edd1df52e9bc982
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=133626d8a00000

Note: testing is done by a robot and is best-effort only.
