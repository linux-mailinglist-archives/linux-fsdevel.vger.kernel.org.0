Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BD37207C9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 18:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236368AbjFBQjg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 12:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235916AbjFBQjf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 12:39:35 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398E41B7
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jun 2023 09:39:33 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-772d796bbe5so114663739f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Jun 2023 09:39:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685723972; x=1688315972;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jQGoC7vlZtXDhLEgYv1SxcnvHwW74JFQkSojIS2V8g0=;
        b=jviWsLVYQexBynl9SEbxR+GUbXqWqHA4KpWNzpRaDjkg9BXSwYGsy/nkQcfA7JIdL+
         3MRf4SQkGo6doEh+x67Y0x1vgwuMhN1G0gYWHK7zcWqoX3WVudYVOnKSNIDVIWRGHF+M
         08seORvPAkrDECSnQldJZo8AOySoq2D0vBGznK2V5zP0G33jV+Rr31GadVi7WGuEVavX
         OpbCFe/ANp92O2Nc4WZ5l46rVkx/bNhK71+b0uWzk8nPfS+IdInEMm7AhyZIm27/O34s
         GsHCn/XZblWR4qFsISHWXsUQ/PewJsbgAw3gxBPBtYktX6XSeGH7W52MvSnaKyucavlv
         7ggw==
X-Gm-Message-State: AC+VfDwFZdb4wcK5KRn8Q4BI0OkSpiSit38GdrYu3jSG/OtHCu4oRU5r
        t1iMyw169W33/lJRC4082N13OAirTzGvY1u/xmom5bZfeTRX
X-Google-Smtp-Source: ACHHUZ6HfjrvFZwBLUA1rgPFDPGlIB6ktQF0HD8+Jk0f0mP7NTLlW+yzUOsQpQQ1SxCI/wQRIIkKKwq6mZsV05N5tdLLaJF2T/rJ
MIME-Version: 1.0
X-Received: by 2002:a05:6638:10ea:b0:41d:77ab:bc2 with SMTP id
 g10-20020a05663810ea00b0041d77ab0bc2mr924254jae.4.1685723972618; Fri, 02 Jun
 2023 09:39:32 -0700 (PDT)
Date:   Fri, 02 Jun 2023 09:39:32 -0700
In-Reply-To: <4aa799a0b87d4e2ecf3fa74079402074dc42b3c5.camel@huaweicloud.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000093d48c05fd2832a7@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in open_xa_dir
From:   syzbot <syzbot+8fb64a61fdd96b50f3b8@syzkaller.appspotmail.com>
To:     hdanton@sina.com, jack@suse.cz, jeffm@suse.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, paul@paul-moore.com, peterz@infradead.org,
        reiserfs-devel@vger.kernel.org, roberto.sassu@huawei.com,
        roberto.sassu@huaweicloud.com, syzkaller-bugs@googlegroups.com,
        will@kernel.org
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

Reported-and-tested-by: syzbot+8fb64a61fdd96b50f3b8@syzkaller.appspotmail.com

Tested on:

commit:         4432b507 lsm: fix a number of misspellings
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git next
console output: https://syzkaller.appspot.com/x/log.txt?x=16b47dd1280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=178a8c28652084e1
dashboard link: https://syzkaller.appspot.com/bug?extid=8fb64a61fdd96b50f3b8
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=102f6ab6280000

Note: testing is done by a robot and is best-effort only.
