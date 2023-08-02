Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A6B76C983
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 11:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbjHBJci (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 05:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbjHBJcf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 05:32:35 -0400
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8AB2728
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 02:32:29 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6bb1755ee51so929457a34.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Aug 2023 02:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690968748; x=1691573548;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BJJTp8LgZ4/XOmmEPjZnCmkTk4xIz+OL5RKwPACSM9I=;
        b=EO3+EFHfxebFBwjVL5ugk1KaElFzI+6zuSJzwiCsasOQ6oI3RvIwd/0zEi6Hwjpjnj
         7DoR6xAlVKlpYaWYE5c4262axczabCUL3UJhG9XjZkxHO1dvqiDUDnSa/CSKppjEV7pB
         tiqHED13RXUbGY5vwbDnHw7+y+loSPG+5rrM1jcB+fol+aPK8h/BIXMKert/JBwtwIO9
         Nuoe3co9bx54snc/S3bm0wDhwSyNP/siAEjYYkeWTDrlTbCWYrnEklj6ALMkzfANCWCg
         BJuASuX1SltH7YXu84z0aSqFwssd4aicOPLD3vF5RGgaTiGYEIVQIu8s7Axpg6Z48bev
         R+oA==
X-Gm-Message-State: ABy/qLZjFeB14Zs9k8nN8Tih5C2xki/Y1xZibcZmKM8hoiqeP6cVQ8/l
        l+GlcR5G8GLSj6cCJTgt43mMVbyh3V/db06P6kVBU+zYF0hi
X-Google-Smtp-Source: APBJJlGK60RDzaFT4IsSwm4H3AwbwuZX8KVE0Wi4Ip++VpDIIOEqm2szOIZKcHCFCBpnUpS02426VOVg02UjTDW0VcjpqNCgqpmx
MIME-Version: 1.0
X-Received: by 2002:a05:6830:26c4:b0:6bc:6658:2d3f with SMTP id
 m4-20020a05683026c400b006bc66582d3fmr28270665otu.1.1690968748112; Wed, 02 Aug
 2023 02:32:28 -0700 (PDT)
Date:   Wed, 02 Aug 2023 02:32:28 -0700
In-Reply-To: <73e2d2a8-9c15-0865-bc38-4cfb17c4c19d@gmx.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008ec0ae0601ed5706@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in prepare_to_merge
From:   syzbot <syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, quwenruo.btrfs@gmx.com,
        syzkaller-bugs@googlegroups.com
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

Reported-and-tested-by: syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com

Tested on:

commit:         aa3cb01e btrfs: avoid race with qgroup tree creation a..
git tree:       https://github.com/adam900710/linux graceful_reloc_mismatch
console output: https://syzkaller.appspot.com/x/log.txt?x=10ae0aa6a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23c579cf0ae1addd
dashboard link: https://syzkaller.appspot.com/bug?extid=ae97a827ae1c3336bbb4
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
