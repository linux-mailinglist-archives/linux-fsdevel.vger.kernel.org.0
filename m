Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2005A752C5E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 23:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbjGMVrj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 17:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbjGMVrh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 17:47:37 -0400
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320932119
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 14:47:36 -0700 (PDT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3a044f9104dso2064799b6e.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 14:47:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689284855; x=1691876855;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KUG8RKD0pfrG2394ON25fkHyWSD9eo4LkpOPF3F2CCs=;
        b=Cv0ys6X1e9WUu/0K+fLvlERFjca54SeeSO5DIrJJ8wh4mLmE9Ctvkp5GCvFFssSxmr
         ODWvciL5daZLGMfxBnhUkoMZMp6OGHpOT6fKhtAfJfiIsX2j5+Z0FWctDqACryFewvNy
         lHBJHJ6aFc7aasI5qOfwVcEP4wH5uKms1hSi+ztD5InELifcEyz8xL7WNa+lb0qfT1Ef
         VK03opoLBldLeQTi1ZwkmID9ub0uZzVENxr/pX2cz3Bc9CLpdRBbLKR3V9Agp61a6EUe
         Gk+9OhFHDN44FoxnlXAhQpCaaV6VfKL+w3WjclV3IHT/91fEJYsxrEIHI8ajYaaxqoTx
         twPg==
X-Gm-Message-State: ABy/qLYImMKCguIGGButEJR7c6zlgZBk80njE47gjvjpNeIGcWVZKJkC
        zid/b0jgBnYV+NmwAkMr5gfDiK0mWJeWTvvSZPTwjNqvTur/
X-Google-Smtp-Source: APBJJlGoKW4zDGN2PvlsuktwYSqHm10JrHpVzazG0QH2nNwFSt1OcvwTZuQ5Nuj4JGXZ1da1F/RXi2zeYqC0EbyD4QYj/9abyOQC
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1810:b0:3a1:f1ce:10e2 with SMTP id
 bh16-20020a056808181000b003a1f1ce10e2mr3841051oib.0.1689284855603; Thu, 13
 Jul 2023 14:47:35 -0700 (PDT)
Date:   Thu, 13 Jul 2023 14:47:35 -0700
In-Reply-To: <b85911af-b7e1-0ef4-b102-1bc9c602a936@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000be2656060065470a@google.com>
Subject: Re: [syzbot] [ntfs3?] KASAN: use-after-free Read in bcmp
From:   syzbot <syzbot+53ce40c8c0322c06aea5@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        ntfs3@lists.linux.dev, paskripkin@gmail.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+53ce40c8c0322c06aea5@syzkaller.appspotmail.com

Tested on:

commit:         eb26cbb1 Merge tag 'platform-drivers-x86-v6.5-2' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=119e1bd4a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d0f369ef5fb88c9
dashboard link: https://syzkaller.appspot.com/bug?extid=53ce40c8c0322c06aea5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1405dac4a80000

Note: testing is done by a robot and is best-effort only.
