Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCA359EA0E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 19:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbiHWRmN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 13:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbiHWRlA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:41:00 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482B2AC258
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Aug 2022 08:38:16 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id w6-20020a056e02190600b002e74e05fdc2so10798618ilu.21
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Aug 2022 08:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=jj+DJXwrsYlSJItXjtgoHdex4lZY6RIyfIJzSWY+0OA=;
        b=3R56ki14b39TaISVmP9JIaU7Y3hLa7pbZ/T/x3iJi4JRuH9olJgG509qOkp3FAB1Lu
         f8fMiL+USbbFiUkdY+AtLF+CQsoFh1q4yWlCvCmchTVkAwCYx+WixXHp6c4Zhx4poAZO
         aY1P4lSr/A3nVqZSPEVlCSJWc+9Z39wxBQcO22pcXTWADkaDwh19sWsmkflGvn/tOhQs
         +5iAaUnFq7nUAqlsE93xQ/jQorTE3BxWhLwwt9YP83K/JjtbSre1Z8t8dDsnbD8lBlCh
         JbmhhlHrd+XDu54pwojlbq3ghmQShuBh3Nf569ocQ6yshYyzyc0YBeiKlaMhkb6HZGoR
         CbtQ==
X-Gm-Message-State: ACgBeo1GEEbPeFH3bzhKApzNF5tYemAHIXoQfBEOSPmeujA15vfOzQL5
        VQ4MDXkfoZz74hYuXAjWin+SwWPf0hish64m94186ghkt5R6
X-Google-Smtp-Source: AA6agR6E5kQeZsO1i1vYztRzxIpze53XHYtfM9V0vZY1WanZlXP3pyvAqhiEdhMjqZJTJnrTzmbfrJBk/YwRG3atOe+jou2IskV/
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c07:b0:2e9:221e:9c77 with SMTP id
 l7-20020a056e021c0700b002e9221e9c77mr98428ilh.176.1661269095633; Tue, 23 Aug
 2022 08:38:15 -0700 (PDT)
Date:   Tue, 23 Aug 2022 08:38:15 -0700
In-Reply-To: <20220823152101.165538-1-code@siddh.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000525beb05e6ea5aeb@google.com>
Subject: Re: [syzbot] WARNING in iomap_iter
From:   syzbot <syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com>
To:     code@siddh.me, david@fromorbit.com, djwong@kernel.org,
        fgheet255t@gmail.com, hch@infradead.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        riteshh@linux.ibm.com, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com

Tested on:

commit:         072e5135 Merge tag 'nfs-for-5.20-2' of git://git.linux..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=120a311d080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3f885f57a0f25c38
dashboard link: https://syzkaller.appspot.com/bug?extid=a8e049cd3abd342936b6
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=169d8e5b080000

Note: testing is done by a robot and is best-effort only.
