Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B13754566
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jul 2023 01:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjGNX3w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jul 2023 19:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjGNX3v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jul 2023 19:29:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301503A87;
        Fri, 14 Jul 2023 16:29:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2A3F61E23;
        Fri, 14 Jul 2023 23:29:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307C7C433C9;
        Fri, 14 Jul 2023 23:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689377389;
        bh=4LpNaMdSYDEJOwlMTYUk8LndPPGLU1EDtS1sNmA1iJM=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=mhhDIVSzp7BOv/pVFAClu0lyIl3h+wVHht/b282Abo99F3kqEMBO1d58Vs1YDKxkc
         udSMYlAhTxK7xj/oRv8S36T/7Rr2mwWnoSg0VWQTh0nxMdDCgJg0my3JP8KQ7flyjO
         sx+aHqvT9pRuk+IvZhuv2rCsA/p0h8hqlASkNblNw3M9637VNxBbooamKqfH5fbPrA
         vWUcZpqkXc14ODN18eqosc3osPgPCwf7pkK9HQlwPawYd8zRfEHop+a8hu9rNGuYPU
         OAcHCIINciZg6NHT83+GNrHOu48LbJKqrC0GZyW/I5cQsmr/vYQelxPWA2+qHlC7xo
         wWlx0J7R6c3oQ==
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3a1c162cdfeso1887660b6e.2;
        Fri, 14 Jul 2023 16:29:49 -0700 (PDT)
X-Gm-Message-State: ABy/qLZvLGH48QfkeUuls4DfYXw4kQg4A60snKLzWQO+unNrKfbczecC
        H67y2rdAesn4aLxOo45juDu3GNg6BT1KvZKs/vM=
X-Google-Smtp-Source: APBJJlHuA4EaFROUWIHCjKCvgvqiVFsWG7Vas9Enp0VyfJ+0ncIJnksZrjrhpfCnrBJ7i6pAaFGSkO3eJhjxyL5JeG0=
X-Received: by 2002:a05:6808:1314:b0:3a4:2460:2b9a with SMTP id
 y20-20020a056808131400b003a424602b9amr8187745oiv.34.1689377388337; Fri, 14
 Jul 2023 16:29:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:4c7:0:b0:4e8:f6ff:2aab with HTTP; Fri, 14 Jul 2023
 16:29:47 -0700 (PDT)
In-Reply-To: <CANp29Y7ynmqhmRQ0hABs=uVHQY1sN+Ldw3V93UGSxh+SqfYC=Q@mail.gmail.com>
References: <00000000000075fd0505ff917517@google.com> <CAKYAXd9Wv5Swj4fouCLYbdyjWYhT39C3TiHgm-fRiKS_2=zsTA@mail.gmail.com>
 <CANp29Y7ynmqhmRQ0hABs=uVHQY1sN+Ldw3V93UGSxh+SqfYC=Q@mail.gmail.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Sat, 15 Jul 2023 08:29:47 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-A9D3EtU=0+Qt5ktQH_KVdrvLFiSWB73964fmhkjVrRg@mail.gmail.com>
Message-ID: <CAKYAXd-A9D3EtU=0+Qt5ktQH_KVdrvLFiSWB73964fmhkjVrRg@mail.gmail.com>
Subject: Re: [syzbot] Monthly fat report (Jul 2023)
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     syzbot <syzbot+list96b6ab127c02d379290b@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2023-07-15 2:46 GMT+09:00, Aleksandr Nogikh <nogikh@google.com>:
> On Fri, Jul 14, 2023 at 3:45=E2=80=AFPM Namjae Jeon <linkinjeon@kernel.or=
g> wrote:
>>
>> 2023-07-03 18:04 GMT+09:00, syzbot
>> <syzbot+list96b6ab127c02d379290b@syzkaller.appspotmail.com>:
>> > Hello fat maintainers/developers,
>> Hi Syzbot,
>>
>> It's not fat, it's exfat :)
>
> I'll look into renaming it on syzbot :)
>
>> >
>> > This is a 31-day syzbot report for the fat subsystem.
>> > All related reports/information can be found at:
>> > https://syzkaller.appspot.com/upstream/s/fat
>> >
>> > During the period, 3 new issues were detected and 0 were fixed.
>> > In total, 11 issues are still open and 20 have been fixed so far.
>> >
>> > Some of the still happening issues:
>> >
>> > Ref Crashes Repro Title
>> > <1> 347     Yes   possible deadlock in filemap_fault
>> >
>> > https://syzkaller.appspot.com/bug?extid=3D7736960b837908f3a81d
>> > <2> 257     Yes   possible deadlock in exfat_get_block
>> >
>> > https://syzkaller.appspot.com/bug?extid=3D247e66a2c3ea756332c7
>> > <3> 181     Yes   possible deadlock in exfat_iterate
>> >
>> > https://syzkaller.appspot.com/bug?extid=3D38655f1298fefc58a904
>> > <4> 100     Yes   possible deadlock in exc_page_fault
>> >
>> > https://syzkaller.appspot.com/bug?extid=3D6d274a5dc4fa0974d4ad
>> > <5> 39      Yes   possible deadlock in do_user_addr_fault
>> >
>> > https://syzkaller.appspot.com/bug?extid=3D278098b0faaf0595072b
>> > <6> 2       Yes   KASAN: slab-use-after-free Write in
>> > collect_expired_timers
>
> #syz set <6> subsystems: reiserfs
>
>> >
>> > https://syzkaller.appspot.com/bug?extid=3Dfb8d39ebb665f80c2ec1
>> > <7> 1       Yes   BUG: corrupted list in __mark_inode_dirty
>
> #syz set <7> subsystems: reiserfs
>
>> >
>> > https://syzkaller.appspot.com/bug?extid=3D4a16683f5520de8e47c4
>> >
>>
>> Can you check if deadlock problem(<1>, <2>, <3>, <4>, <5>, <6>) are
>> fixed with the following patch ?
>> https://lore.kernel.org/lkml/20230714084354.1959951-1-sj1557.seo@samsung=
.com/T/#u
>
> We currently unfortunately don't support bulk testing, I've sent a few
> requests manually (<1>, <3>, <4>):
> https://groups.google.com/g/syzkaller-bugs/c/ynCUkcnqEiQ/m/qsVWSdWOBAAJ
> https://groups.google.com/g/syzkaller-bugs/c/jKpqY82OuZk
> https://groups.google.com/g/syzkaller-bugs/c/7CO-77jYTAQ/m/lBmXby-OBAAJ

I understood that the problem are fixed with this patch. We will apply
it with syzbot's tested-by tag.
Thanks for your help!
>
>>
>> Numbers <6>, <7> are not exfat issues. Can you remove them in your list?
>
> Thanks for triaging! I've updated their subsystems to reiserfs (see
> commands above).
>
>>
>> Thanks.
>> > ---
>> > This report is generated by a bot. It may contain errors.
>> > See https://goo.gl/tpsmEJ for more information about syzbot.
>> > syzbot engineers can be reached at syzkaller@googlegroups.com.
>> >
>> > To disable reminders for individual bugs, reply with the following
>> > command:
>> > #syz set <Ref> no-reminders
>> >
>> > To change bug's subsystems, reply with:
>> > #syz set <Ref> subsystems: new-subsystem
>> >
>> > You may send multiple commands in a single email message.
>> >
>>
>> --
>
