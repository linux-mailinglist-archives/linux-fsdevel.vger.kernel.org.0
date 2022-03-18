Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1031D4DDCCF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 16:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235023AbiCRP1d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Mar 2022 11:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237991AbiCRP1b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Mar 2022 11:27:31 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56020BB91F
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Mar 2022 08:26:08 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id x6-20020a923006000000b002bea39c3974so4971427ile.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Mar 2022 08:26:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=2GcyEVDtaG4XJgxlAGsnMFK5mtyDq2UaQEceNXYuEec=;
        b=WiyczZRQLLTaRB3Gr+eZhGIPAhKE4dq5TPSR3YjpmdnGpBWZZaui2Lt+8kU9QQee0S
         NDPhQi/zndrnb5I7whzMsC6075giSaEw2WKUz+ZwF6JSg4EOQrEV97Y+MVcihVXGPGDI
         JihH5b8ppuE02ZjsRZiysOqvXFBdhTxTNKumz00BnLvANc1FHLrFBGQSMzh4XHAPbLWm
         W8h91NXAj3sdn7j137YSCvu/9NRXSZVX/b9FPa0XB8R/jWkIbNvRVUej5dePp8OVxkBm
         RxAyVxXhCSU/KN8cKij0EP3czOsBduruhwivq6AD7W9+HNF/UYb8p88O6wmoTcDK8ONu
         jhDQ==
X-Gm-Message-State: AOAM531Ot1g+3qjxbFaruuiuSpzBXnE1Sa5B2b9oWhxXbjz9zRWyWoW0
        VGtOoID1Rp3Z6ZZlmu10zgtCD2KYCHjrI6xwwFirJvhrEDAq
X-Google-Smtp-Source: ABdhPJyjV/jp17TBgjpyaiGsK0E0XDL32GzByadldQzT+jf/M2CW5BGSJoANsHs2E6Ac1lQpsDjFmVWWmY/Zems2gDB1ORCAWnCk
MIME-Version: 1.0
X-Received: by 2002:a02:6204:0:b0:31a:6f2c:b5f7 with SMTP id
 d4-20020a026204000000b0031a6f2cb5f7mr2930746jac.21.1647617166023; Fri, 18 Mar
 2022 08:26:06 -0700 (PDT)
Date:   Fri, 18 Mar 2022 08:26:06 -0700
In-Reply-To: <20220318151034.2395-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e8202805da7fc37b@google.com>
Subject: Re: [syzbot] WARNING in inc_nlink (3)
From:   syzbot <syzbot+2b3af42c0644df1e4da9@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+2b3af42c0644df1e4da9@syzkaller.appspotmail.com

Tested on:

commit:         aad611a8 Merge tag 'perf-tools-fixes-for-v5.17-2022-03..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=aba0ab2928a512c2
dashboard link: https://syzkaller.appspot.com/bug?extid=2b3af42c0644df1e4da9
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13edf28d700000

Note: testing is done by a robot and is best-effort only.
