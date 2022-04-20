Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797BE508863
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 14:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352501AbiDTMrA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Apr 2022 08:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240154AbiDTMq6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Apr 2022 08:46:58 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97638205C2
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Apr 2022 05:44:12 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id x13-20020a0566022c4d00b0065491fa5614so1140863iov.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Apr 2022 05:44:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=D4cHpkDZsSvHotz5ZPOKW6x/SBIpuMTJuj0KKbrXmlU=;
        b=pSm61kJDZjbAC3jISkKekkEdl4SjkOYtVohFICKdbk0IDiSJFyoGdNRJa+zY4r70RH
         EOSme0O5fXPu1G6pXmU9kmpu1KH6/0xGDa3scXv4eL06sET4KmihGfx+A4039XXuJohG
         p6rOldkBgIDQGKG9jGEkcwiN8VD31T6l0bp7nBwz5eAHO9ddSYXyuDnliGT+jcXdeNXz
         cwzfSCZ22crdBvRg8P61D/bfnKzrJictKezVmK3WgXG7up7lnZ1NAs47wHx5A9vzkIWX
         k0MU05NqCFlZlXXrY4jWTBNoAGY84OaXIaKnLh6px4FzQRbY4bbsRhcSIZtE9N7UKeyk
         ef+g==
X-Gm-Message-State: AOAM5303EDY1T9yzMGiQfAWqLMyP3w1g6hAhjEk0QSLfauNeUJHaCzXB
        hPbeReDgmzFwxggbBs50q70e7DveRxoou/SLQMmryFZEr/Zx
X-Google-Smtp-Source: ABdhPJx7zci4bHGbHwRnpnbelQqfHsdh0Sg1WcrSrtVffdHJmd8RaDbRAPVvE6sTVjZii++8vphDSFbKIFmI1qbD8sYdsqyVg32C
MIME-Version: 1.0
X-Received: by 2002:a02:8604:0:b0:326:681e:eef1 with SMTP id
 e4-20020a028604000000b00326681eeef1mr9259926jai.275.1650458651970; Wed, 20
 Apr 2022 05:44:11 -0700 (PDT)
Date:   Wed, 20 Apr 2022 05:44:11 -0700
In-Reply-To: <20220420122610.7k2qx5dwdchu27mg@wittgenstein>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aacee405dd1559b7@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in sys_setxattr (2)
From:   syzbot <syzbot+10a16d1c43580983f6a2@syzkaller.appspotmail.com>
To:     brauner@kernel.org, fweisbec@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+10a16d1c43580983f6a2@syzkaller.appspotmail.com

Tested on:

commit:         bbc1e8c5 fs: unset MNT_WRITE_HOLD on failure
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git fs.mount_setattr.cleanup
kernel config:  https://syzkaller.appspot.com/x/.config?x=34d641b059469a42
dashboard link: https://syzkaller.appspot.com/bug?extid=10a16d1c43580983f6a2
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
