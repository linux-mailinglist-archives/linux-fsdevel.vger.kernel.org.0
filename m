Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690E85886A6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Aug 2022 06:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbiHCExK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Aug 2022 00:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiHCExI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Aug 2022 00:53:08 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22D457220
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Aug 2022 21:53:07 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id m7-20020a056e021c2700b002ddc7d2d529so9817341ilh.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Aug 2022 21:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=bT3YULCXKnZc8y+zrRqHabIVdyfiW1cYQ26ZuMNbOJs=;
        b=st/gA1YBg3tqwbFubengCGxDeYJi3hG6rpJj/bRaGIEwETPD8wL+g3Ckx3U1Rh5aFo
         T0nZ/Ac2gVidsj5M9SvIQV4+GXC4UhhV9elkCVRFCb+h6dUnZUIwUeQuYm6+ISUS1ah4
         WLljHdS+uQ+gLcY1iQ9gbz2fBNZbCmhW40N6puToaHKeQY/8mqRzBJSGA2rSZ2Z1Gdrp
         5VNVE28ngVBbK8R7KyCCRvaU7I5JyViYXEE/0vdJ2dZWvmVKjqBTz7kpmRC9qqmMyUVJ
         qJonBekzimZnTyaWcKFgZ7DaDUx2kNzhnYtmXhtByKIDvkobMsSMjmL4civbMKh8Tnbj
         2zeA==
X-Gm-Message-State: ACgBeo2gkyQeGXb9c4UWh4DFj15SRTLRxijSHZRN2fol/mDKxEtMCkEH
        Iy/dTCD7pkQtP4kZSOYeaABu0Nxj0gAbkuYV1kTe57GditBv
X-Google-Smtp-Source: AA6agR7jwtRilJZsNtewGloH//4KZJ9mP2xale2iRjqRKkPPjGUhtEgBUTn8zZV8ELRAlwrLu5JX7a79CQDtjoxVI7nP7gNXowEy
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:190b:b0:2de:ba7d:40a9 with SMTP id
 w11-20020a056e02190b00b002deba7d40a9mr4550902ilu.52.1659502387164; Tue, 02
 Aug 2022 21:53:07 -0700 (PDT)
Date:   Tue, 02 Aug 2022 21:53:07 -0700
In-Reply-To: <CAJfpeguS6Ta9LcGU0A_JkfvPWZup_Ndg+tpvpbzXJuWPNZwGgw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004a9f7b05e54f0213@google.com>
Subject: Re: [syzbot] memory leak in cap_inode_getsecurity
From:   syzbot <syzbot+942d5390db2d9624ced8@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+942d5390db2d9624ced8@syzkaller.appspotmail.com

Tested on:

commit:         e2b54210 Merge tag 'flexible-array-transformations-UAP..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12c050a2080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5367bd9b8d9fa72
dashboard link: https://syzkaller.appspot.com/bug?extid=942d5390db2d9624ced8
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17a74536080000

Note: testing is done by a robot and is best-effort only.
