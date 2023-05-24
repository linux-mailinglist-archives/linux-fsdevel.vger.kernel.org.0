Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1C47100FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 00:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236425AbjEXWb6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 18:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjEXWb4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 18:31:56 -0400
Received: from mail-io1-xd47.google.com (mail-io1-xd47.google.com [IPv6:2607:f8b0:4864:20::d47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DAC1A7
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 May 2023 15:31:17 -0700 (PDT)
Received: by mail-io1-xd47.google.com with SMTP id ca18e2360f4ac-76998d984b0so260664739f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 May 2023 15:31:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684967361; x=1687559361;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EEv2m2tkW3LxgGFisYpUk4xaYXyQdf15D8timEsBePw=;
        b=jj2jXH9D09H9CAJwWi/ABQYqeiSfvkqYFjjtM2ql2HCzG9ib/ThZ5/aHazFxyjySIA
         Qiv7/0cmIuKYSbq3T870A14SteMUhoLFyr+ni8QNnz3w8dHxsx9ZjzaW5L1vAwh/YrKx
         n/LLuuHIgqlncKlbpz54F8TvyI154bjFcmrL6Dgwf6zP0HuOkzeLmIrnOOLs7JxR0ed1
         S+rsUrSSztb1PuW32V9PbbNBxTrj0zQRyZx5/GGOT3RP8cpeVKaSxqPR8vIJp4SyIshb
         BxwoMTY2krbqWaFozprvtmsyMPo37UQDr3Ki4xOnMNG8FxWIAR4sqaEXO1HI7KEEb+fI
         jigw==
X-Gm-Message-State: AC+VfDwDbHvt2e438WbyTZHCLxRqfpL2sXYj2zFAJBpAfL4X0GQXRjYt
        csPYIsWunRJg7cey1lXiV5qOxlmVbqSXdrvRc3GJXVJ/YOte
X-Google-Smtp-Source: ACHHUZ72qrCpncxwPE6/T5eypdjBRfnsPFGFFDWfjAutJOp5v9DIOoQX8UKqk1yaqn3vJLjS3kFKoFiv8AWb/wsRgVElDA5SO5rs
MIME-Version: 1.0
X-Received: by 2002:a02:8521:0:b0:41a:c808:b49f with SMTP id
 g30-20020a028521000000b0041ac808b49fmr8538740jai.3.1684967361648; Wed, 24 May
 2023 15:29:21 -0700 (PDT)
Date:   Wed, 24 May 2023 15:29:21 -0700
In-Reply-To: <000000000000eb49a905f061ada5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000ca36b05fc780953@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in do_symlinkat
From:   syzbot <syzbot+e78eab0c1cf4649256ed@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 267a36ba30a7425ad59d20e7e7e33bbdcc9cfb0a
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Mon Jan 16 08:52:10 2023 +0000

    fs/ntfs3: Remove noacsrules

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15fdf761280000
start commit:   ec35307e18ba Merge tag 'drm-fixes-2023-02-17' of git://ano..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=5f0b8e3df6f76ec
dashboard link: https://syzkaller.appspot.com/bug?extid=e78eab0c1cf4649256ed
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12570890c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14523acf480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs/ntfs3: Remove noacsrules

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
