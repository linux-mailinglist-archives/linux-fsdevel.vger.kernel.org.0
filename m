Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AE17B9FD7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 16:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbjJEOaN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 10:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234152AbjJEO2d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:28:33 -0400
Received: from mail-ot1-x346.google.com (mail-ot1-x346.google.com [IPv6:2607:f8b0:4864:20::346])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB70B22CA1
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Oct 2023 03:46:29 -0700 (PDT)
Received: by mail-ot1-x346.google.com with SMTP id 46e09a7af769-6c4afe695a7so1004778a34.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Oct 2023 03:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696502789; x=1697107589;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BGwGxlTuATRVWE5UT3ZKJoT5MpU675X68ZbpYCN+7kY=;
        b=thVB2DwdUkBrk7kvZ0gQHTPnTnfOCoNYiOT7uhA0gTOkfOruOU4AYQVvMwGPMPuWF7
         RCjFOjZCBkX8KGY6UUNFqvnqGPLWiFxBqT/uJw7IlH8Td4NcXH2RYXloW/WBg13YnTpS
         Dku9rIMcWeZZZsdE0OCqw6e0hjx3UwiNdpj7c5Ib/jfdRlnYz2/WXX4GoBWaQ1n8Efyg
         ddlEOROJusdhB2SyHHsXQt5gksVvUArQvytQTTJuI60JjYefsS8EKlvgTWBqV1AI7WQR
         90suKCVGT0Lo1LDTnpBYcchsJhS+QWt6DXdtGIC4MrvcKgNDQmPKJ/HCuUFMCLCMP/yI
         ml6A==
X-Gm-Message-State: AOJu0YzEOji28GJ40Fskl1CRFPPMehpwzallawXxqkL4S1oAtS4WOWQK
        lqQzmi1uUEV+eiD0Fzw26gqteh9saQec4rKrdV3VmOiiMj22
X-Google-Smtp-Source: AGHT+IF6NXpW2zd+hCeIzElnwrg53MI5PnCCJL42D9bvk43rwJ1rmAHq/sIWi88y/rKUpfhhxrW+Yd6VgiNDyLe+SSuoEVFU4PnF
MIME-Version: 1.0
X-Received: by 2002:a05:6870:1987:b0:1dc:768d:bf6b with SMTP id
 v7-20020a056870198700b001dc768dbf6bmr1900344oam.11.1696502788922; Thu, 05 Oct
 2023 03:46:28 -0700 (PDT)
Date:   Thu, 05 Oct 2023 03:46:28 -0700
In-Reply-To: <CAOQ4uxjw_XztGxrhR9LWtz_SszdURkM+Add2q8A9BAt0z901kA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001824660606f5d6ac@google.com>
Subject: Re: [syzbot] [integrity] [overlayfs] possible deadlock in
 mnt_want_write (2)
From:   syzbot <syzbot+b42fe626038981fb7bfa@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, hdanton@sina.com,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        mszeredi@redhat.com, syzbot@syzkalhler.appspotmail.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        zohar@linux.ibm.com, zohar@us.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+b42fe626038981fb7bfa@syzkaller.appspotmail.com

Tested on:

commit:         42555f30 ima: annotate iint mutex to avoid lockdep fal..
git tree:       https://github.com/amir73il/linux ima-ovl-fix
console output: https://syzkaller.appspot.com/x/log.txt?x=16889486680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=57da1ac039c4c78a
dashboard link: https://syzkaller.appspot.com/bug?extid=b42fe626038981fb7bfa
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
