Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4877D75A2F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 01:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjGSXw4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 19:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjGSXw4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 19:52:56 -0400
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580A1E69
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 16:52:55 -0700 (PDT)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-560c7abdbdcso460161eaf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 16:52:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689810774; x=1692402774;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A9gJwVZwzQg0baOMHo3naKFdZASs/9RCrT4IGNjRFMc=;
        b=ZWT+5DDT2j/c+iPqykEeuMQH6WRcw6g1JGy7MeQdoPa1bCporgcwKFo1CygCuA5mZL
         cdDF10aTXQPOmH1jy53urg5jZbpoWT0I/7RKFKzZvNc2WprFkXpIGzxkKuBpGMmBgQ1V
         GnOelb8f8gz57k7CTDSgWGI4uZaiEhu2ggqw3foAWX1vmvLBIZrvj0Z2tdRSsKl5+5pc
         z8AGEFq2aKo0L+VLlDieJlAI0fhsnI/NIme3E8iT/YzLeLDubihSW9Xu5o7ZlMJFX5Ai
         37cMgJw8YsNrtgKr71u//cGy0c6WpQYCk+zDus/G1dJWlbrAL0Rr+cOeJJWMbe9iXK0p
         gnXA==
X-Gm-Message-State: ABy/qLa0ByOPuP923U1+ubEN1aCwIO3s1wIylRGwv9pwISRucoARI8p3
        npA3fRCLvUx5F2ZBpVFpwcAfvwGH6U8QYv81nI6Dr4Ko25sd8+4=
X-Google-Smtp-Source: APBJJlF3aS+sqsqnzDE8uhYbIzzKieuKgZfPG27IJi0z++r3NRFpF4nI8tTNRI4l65VIRweYXLw4hXHCqKFpqjH2f6jRroFGM3d9
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3011:b0:39e:b6a2:98c7 with SMTP id
 ay17-20020a056808301100b0039eb6a298c7mr7704963oib.8.1689810774760; Wed, 19
 Jul 2023 16:52:54 -0700 (PDT)
Date:   Wed, 19 Jul 2023 16:52:54 -0700
In-Reply-To: <1fa2f7f07ebff31ddc24bbbd9ec47cc9@disroot.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f7a4210600dfba8c@google.com>
Subject: Re: [syzbot] [hfs?] kernel BUG in hfsplus_show_options
From:   syzbot <syzbot+98d3ceb7e01269e7bf4f@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sel4@disroot.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+98d3ceb7e01269e7bf4f@syzkaller.appspotmail.com

Tested on:

commit:         aeba4568 Add linux-next specific files for 20230718
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14ccebe4a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e7ec534f91cfce6c
dashboard link: https://syzkaller.appspot.com/bug?extid=98d3ceb7e01269e7bf4f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=144204aea80000

Note: testing is done by a robot and is best-effort only.
