Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6364598C8E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 21:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345186AbiHRTaK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 15:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236142AbiHRTaJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 15:30:09 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C618BCB5EA
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Aug 2022 12:30:08 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id d6-20020a056e020be600b002dcc7977592so1724341ilu.17
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Aug 2022 12:30:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=+AlttEUJA20N8NczqgtZNbuuO2ikQ4TymwOUxEi3ryw=;
        b=t9qF5uJd7/+VZTFJszKrfCwaeHUO1e3+uSbf5MOM1vYO7gw0tNq1d0qeEbcKoB9nrs
         X0qe9MEGxxyoeGYLV2uHUv92i7n7sMhGpwvRgz0eEzcU5dPxMYogjJQPWC8YzVR3/JiO
         fJab6I11uVeC+pu0kdxffTZnU+vZpJ/W/gdWgu6hie1CN6tkvXbRdIdNkaojByRRGWQG
         +Ydmia0smZogezYlKCKpsFc0n17D3tXNET/Spr2A5I12L3g+XAqYA+5n+Tn0EiH0rnd8
         FyJGTdwY9a0ohDSTC/LnC6ptSCfLIVg2WldaLTZxucAJ73Lqfhq61E7QGrOQxVHHNvdW
         XK5A==
X-Gm-Message-State: ACgBeo0E4yjzIBzsR4zlvJb8s/h71hFBZ0WjgH1L6XdA0FwvOiT/G/3S
        hk8LfvxvqGkpWZCKmsrt9w7rW5dkG77QxBPbVuNUdu1w7ZoF
X-Google-Smtp-Source: AA6agR4UAmMezLXz1QdL+Jr/HN7ZuXxWjt6l79XDTRgUmOm2Q3m/Ad0paUKaIsuluGGFd2/gPgZAmRNnn2rPNDCOfdhWSkBvggvZ
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:198c:b0:2e0:8759:f959 with SMTP id
 g12-20020a056e02198c00b002e08759f959mr2099905ilf.223.1660851008232; Thu, 18
 Aug 2022 12:30:08 -0700 (PDT)
Date:   Thu, 18 Aug 2022 12:30:08 -0700
In-Reply-To: <20220818111117.102681-1-code@siddh.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005ee4d705e6890242@google.com>
Subject: Re: [syzbot] WARNING in iomap_iter
From:   syzbot <syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com>
To:     code@siddh.me, david@fromorbit.com, djwong@kernel.org,
        fgheet255t@gmail.com, hch@infradead.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        riteshh@linux.ibm.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com

Tested on:

commit:         573ae4f1 tee: add overflow check in register_shm_helpe..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1334aaeb080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9d854f607a68b32
dashboard link: https://syzkaller.appspot.com/bug?extid=a8e049cd3abd342936b6
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=117e96d3080000

Note: testing is done by a robot and is best-effort only.
