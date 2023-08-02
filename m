Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27FD76D40F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 18:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjHBQsz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 12:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbjHBQsd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 12:48:33 -0400
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0B9271C
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 09:48:31 -0700 (PDT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-56c7c54c25fso8729226eaf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Aug 2023 09:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690994910; x=1691599710;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qYKi8o9F6eiWCa6W4LKamwGGGyahz7HtNFcm3VxSBwM=;
        b=eR0nU+qReWYrymrgwVyMjldE0O9JqeG0TTCNRaxaO2CdCzT9kEoYIuRLlJCX3Ax30i
         0CWz3+jp9l6COWeOlRZ9dGbKCsmEGIuPPW2oMQ6zOnRDUZUDfvisRljPk/Cm71j7VRRf
         4W2r7qJDkp1ofSCuMMh55s1NwOE7XneXBbpZZIaq8zzSHbjPZ94m8IOOpxUhBYevrF8x
         YrNMzuzoFLSeXGCbMggTmFJlZaNuo8IkrWlXIKhA473Cpp7SOH4kHXDvvli0ZBrm8U4d
         zLS4KjcMH5zj7DrWNOBtMccNZGuyB0XHwm9NLZLBtWGYKwD2zs61TIcsYpZ47HEh83Go
         XUjg==
X-Gm-Message-State: ABy/qLZkYg3rdPywVOy/MM20yaKmb4SSQ2ip9N1dJMFyDWuG2BYqIjlr
        XgAjtX6z7k7nZ1FrzmmgRUhNuPCADqhMKkkrspAUs9wvjlBe
X-Google-Smtp-Source: APBJJlGJmB7c8epxLUHVlcd5q9o6JmFyZq+1fc1su7ZzZrNN0BVgY079DaI9kO8K9tDJb1lVZUP9D8ESC8PRbct7dF2zSmc0Pgtv
MIME-Version: 1.0
X-Received: by 2002:a05:6870:a888:b0:1bb:4d41:e929 with SMTP id
 eb8-20020a056870a88800b001bb4d41e929mr18010511oab.3.1690994910687; Wed, 02
 Aug 2023 09:48:30 -0700 (PDT)
Date:   Wed, 02 Aug 2023 09:48:30 -0700
In-Reply-To: <1796030.1690982494@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f7f8fc0601f36e4c@google.com>
Subject: Re: [syzbot] [fs?] INFO: task hung in pipe_release (4)
From:   syzbot <syzbot+f527b971b4bdc8e79f9e@syzkaller.appspotmail.com>
To:     bpf@vger.kernel.org, brauner@kernel.org, davem@davemloft.net,
        dhowells@redhat.com, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+f527b971b4bdc8e79f9e@syzkaller.appspotmail.com

Tested on:

commit:         5d0c230f Linux 6.5-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15a8b5d5a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df103238a07f256e
dashboard link: https://syzkaller.appspot.com/bug?extid=f527b971b4bdc8e79f9e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17e285dea80000

Note: testing is done by a robot and is best-effort only.
