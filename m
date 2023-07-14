Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608C9753BE9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 15:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbjGNNia (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jul 2023 09:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235219AbjGNNi3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jul 2023 09:38:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AA41991;
        Fri, 14 Jul 2023 06:38:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6C5761CD5;
        Fri, 14 Jul 2023 13:38:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3470CC433C8;
        Fri, 14 Jul 2023 13:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689341907;
        bh=bUxjcLeAY5nIECnt1V9XKVqDTQ0Fxu1nGmYGL6iJWj8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=fZXaUyKZpntNYWTsZRsmqHEuzDq+s4G8mPDBm5SiKY9g5Y23Fer815ETZHU2PF40d
         nFdrKVE2d07u4dg/+ZKvrAWk1Bz1Er/2Da5jO61g0aZSfCZShGUeAWOk+RzPzV3ksk
         emjo08uAXF5pZDEaaPrNp6E8qqTGWbYBf8m8Y7H55TS/Rxlq+DYqZUsS8SWwsIMV0N
         WnWwqy9ka39gfYVq4uF0hwIq6rcgvUkA78w0LrR15HTNm2GKzcd3tuD/wSDHvv5iNX
         fdX1t/ak54TaW4wUXNPRV1f3heo0gSGmsUwDMxgPwoyrlQmrmUwOXA54gsuY0cY0Y/
         xjODPRecC/JJw==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1b05d63080cso1549949fac.2;
        Fri, 14 Jul 2023 06:38:27 -0700 (PDT)
X-Gm-Message-State: ABy/qLbCVlBgJo9FVnDHz1hDZhyLquvo5e8Boji1KTo8QiVqRVBHkvkU
        nFnhJ8pi4e5W8RD5nMihkpr3SEi7POtDrdFS2F4=
X-Google-Smtp-Source: APBJJlFRldI+k7i6UuMj6WVmDvr/ssBP3tk9bsHdkvSAXr6iJd4PRk7tNWLDXCI7+VLj8e9aqYnm8y5C+ztx5pm25Qc=
X-Received: by 2002:a05:6871:58c:b0:1b0:897d:183d with SMTP id
 u12-20020a056871058c00b001b0897d183dmr6110643oan.20.1689341906330; Fri, 14
 Jul 2023 06:38:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:4c7:0:b0:4e8:f6ff:2aab with HTTP; Fri, 14 Jul 2023
 06:38:25 -0700 (PDT)
In-Reply-To: <00000000000075fd0505ff917517@google.com>
References: <00000000000075fd0505ff917517@google.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Fri, 14 Jul 2023 22:38:25 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9Wv5Swj4fouCLYbdyjWYhT39C3TiHgm-fRiKS_2=zsTA@mail.gmail.com>
Message-ID: <CAKYAXd9Wv5Swj4fouCLYbdyjWYhT39C3TiHgm-fRiKS_2=zsTA@mail.gmail.com>
Subject: Re: [syzbot] Monthly fat report (Jul 2023)
To:     syzbot <syzbot+list96b6ab127c02d379290b@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2023-07-03 18:04 GMT+09:00, syzbot
<syzbot+list96b6ab127c02d379290b@syzkaller.appspotmail.com>:
> Hello fat maintainers/developers,
Hi Syzbot,

It's not fat, it's exfat :)
>
> This is a 31-day syzbot report for the fat subsystem.
> All related reports/information can be found at:
> https://syzkaller.appspot.com/upstream/s/fat
>
> During the period, 3 new issues were detected and 0 were fixed.
> In total, 11 issues are still open and 20 have been fixed so far.
>
> Some of the still happening issues:
>
> Ref Crashes Repro Title
> <1> 347     Yes   possible deadlock in filemap_fault
>
> https://syzkaller.appspot.com/bug?extid=7736960b837908f3a81d
> <2> 257     Yes   possible deadlock in exfat_get_block
>
> https://syzkaller.appspot.com/bug?extid=247e66a2c3ea756332c7
> <3> 181     Yes   possible deadlock in exfat_iterate
>
> https://syzkaller.appspot.com/bug?extid=38655f1298fefc58a904
> <4> 100     Yes   possible deadlock in exc_page_fault
>
> https://syzkaller.appspot.com/bug?extid=6d274a5dc4fa0974d4ad
> <5> 39      Yes   possible deadlock in do_user_addr_fault
>
> https://syzkaller.appspot.com/bug?extid=278098b0faaf0595072b
> <6> 2       Yes   KASAN: slab-use-after-free Write in
> collect_expired_timers
>
> https://syzkaller.appspot.com/bug?extid=fb8d39ebb665f80c2ec1
> <7> 1       Yes   BUG: corrupted list in __mark_inode_dirty
>
> https://syzkaller.appspot.com/bug?extid=4a16683f5520de8e47c4
>

Can you check if deadlock problem(<1>, <2>, <3>, <4>, <5>, <6>) are
fixed with the following patch ?
https://lore.kernel.org/lkml/20230714084354.1959951-1-sj1557.seo@samsung.com/T/#u

Numbers <6>, <7> are not exfat issues. Can you remove them in your list?

Thanks.
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> To disable reminders for individual bugs, reply with the following command:
> #syz set <Ref> no-reminders
>
> To change bug's subsystems, reply with:
> #syz set <Ref> subsystems: new-subsystem
>
> You may send multiple commands in a single email message.
>
