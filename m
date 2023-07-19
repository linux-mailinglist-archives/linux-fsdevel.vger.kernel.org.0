Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09111759CD2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 19:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjGSRwj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 13:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGSRwi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 13:52:38 -0400
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0144E1BFC
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 10:52:36 -0700 (PDT)
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-565b0ec169aso10492922eaf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 10:52:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689789156; x=1692381156;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hiRiXJW3cvp7FSsZTUGSxXp2M76eBloK3LBfm2fpvAw=;
        b=Rl7wla5oBLNxf29YF5lM/DQLgnOSEj08WdKmXCpRcZOuTF3xGLPEldJvPjHhgWAImg
         LdqzKpGgU3bho1YCV5uj+ISCdls7I65/jHYq83LuT+LwmFE+8e/h1gd2AYqycxxTTaYr
         XBfu417T4zrjh4NlcRWdjoLwndNcT2vwBEUMGW75Bpliv01znkHa5nZwIruW9qhyfzMG
         DBuLdrHqrKZKXwdd5U7ag3UPNbQZmel/YGaim1aegajbEvjLvFoTpnkj+iSZxtDArFID
         1uOwIb7gFDssMyg3nxRcwuJJfq1xKC0xOEAPKhFYfURhNErguzLYF4bTqBnX2aRqu1A6
         QznA==
X-Gm-Message-State: ABy/qLZox01qgSpYL0ranlKPyd/5UKDcAL3Moghika/mCQUR0tePWzs2
        3b+Sd9ZVgkjHTQqp5oO9supIsNta1U+h1Z/YdcrmlYYUeGaS
X-Google-Smtp-Source: APBJJlG5ugVl7dPPwQXLSskdx//wo3Cxwyt6xyJHDlFhfMqOYOoEiwYraGQnxOCt15oVej8GHXbJ8Vy/Q7WgiHAYGdyqnMHSkz9m
MIME-Version: 1.0
X-Received: by 2002:a05:6808:f0a:b0:3a3:644a:b55 with SMTP id
 m10-20020a0568080f0a00b003a3644a0b55mr30865038oiw.4.1689789156368; Wed, 19
 Jul 2023 10:52:36 -0700 (PDT)
Date:   Wed, 19 Jul 2023 10:52:36 -0700
In-Reply-To: <30f03978-3035-a28e-c097-112036901bcb@nerdbynature.de>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000069291b0600dab2d6@google.com>
Subject: Re: [syzbot] [wireguard?] [jfs?] KASAN: slab-use-after-free Read in wg_noise_keypair_get
From:   syzbot <syzbot+96eb4e0d727f0ae998a6@syzkaller.appspotmail.com>
To:     broonie@kernel.org, dave.kleikamp@oracle.com, davem@davemloft.net,
        edumazet@google.com, jason@zx2c4.com,
        jfs-discussion@lists.sourceforge.net, kuba@kernel.org,
        kuninori.morimoto.gx@renesas.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, lists@nerdbynature.de,
        netdev@vger.kernel.org, pabeni@redhat.com, povik@cutebit.org,
        syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
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

Reported-and-tested-by: syzbot+96eb4e0d727f0ae998a6@syzkaller.appspotmail.com

Tested on:

commit:         6e2bda2c jfs: fix invalid free of JFS_IP(ipimap)->i_im..
git tree:       https://github.com/kleikamp/linux-shaggy.git
console output: https://syzkaller.appspot.com/x/log.txt?x=172aecaaa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f631232ee56196bd
dashboard link: https://syzkaller.appspot.com/bug?extid=96eb4e0d727f0ae998a6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
