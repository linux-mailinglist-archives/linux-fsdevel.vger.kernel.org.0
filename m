Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D70A7070EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 20:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjEQSiz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 14:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjEQSi2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 14:38:28 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51A0AD15
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 May 2023 11:38:26 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3382b8b357aso7513295ab.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 May 2023 11:38:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684348706; x=1686940706;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Vamjh5zaT+/xLZPoxv52up73xCnN6/tfSU9g/y8Wto=;
        b=FgxWt6Ybjtyn6G55BBCZybGkOeERFPihhlbridxUhfWrmxeSrdSsqsnb7G1Uj98+al
         kVH85WZSD/DSidd96vAcvwmHoarP/9jIGWViwHBszltAGppvEa4o4Gqk9iKeLC5ceeC5
         ccqdehnHzfvrxd02j1Cz7Ap1dysX/dFVHtIUc3JSkAFoPXE1PwxHL0Xv2KbMaqEwM7Ml
         sch4oKzhNoYkOo72N2nBqnUZIUva6CC76UUUWZsJcsJbh1Pa46Rv72w+52cbMABw/Qqd
         i+Q/xahPXljMD+s55xtU+6DS9ixqe9JZom23/b23NqvkHa/O0igaAdk0kPHMe1TC37QL
         nuow==
X-Gm-Message-State: AC+VfDwcE8PT3izRwZowIX4IVFOfhpatL2ZwD1fM5IprIvIl2qXE0qME
        tkWQx2nd+EEB8XnSDc52qF9qhmXH+gol8daxkZu+wtmxxLNy
X-Google-Smtp-Source: ACHHUZ6+DaqJKQq5UGHV13ZmtB1Lik9tk/rPaeURCGSY41bL/WLiaZFVIqeSPs8lpve1mrKhkaVJF6OOQSxfZVx2zQoYNtzKfQVI
MIME-Version: 1.0
X-Received: by 2002:a92:d152:0:b0:331:9a82:33f8 with SMTP id
 t18-20020a92d152000000b003319a8233f8mr1830905ilg.3.1684348706156; Wed, 17 May
 2023 11:38:26 -0700 (PDT)
Date:   Wed, 17 May 2023 11:38:26 -0700
In-Reply-To: <85c61aae-6716-9936-1533-91624f70eefe@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004ef96f05fbe7fe6f@google.com>
Subject: Re: [syzbot] [erofs?] general protection fault in erofs_bread (2)
From:   syzbot <syzbot+bbb353775d51424087f2@syzkaller.appspotmail.com>
To:     chao@kernel.org, hsiangkao@linux.alibaba.com, huyue2@coolpad.com,
        jefflexu@linux.alibaba.com, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, xiang@kernel.org
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

Reported-and-tested-by: syzbot+bbb353775d51424087f2@syzkaller.appspotmail.com

Tested on:

commit:         ae0bac79 erofs: avoid pcpubuf.c inclusion if CONFIG_ER..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=16793226280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6beb6ffe4f59ef2a
dashboard link: https://syzkaller.appspot.com/bug?extid=bbb353775d51424087f2
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
