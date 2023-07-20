Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372F175AB5F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 11:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjGTJsg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 05:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbjGTJsK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:48:10 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382AC1710
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jul 2023 02:47:09 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fc075d9994so67915e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jul 2023 02:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689846428; x=1690451228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H70QPrwV0n7u44BE2OYdm8oLTPU3a+ECk2OOoT5kVss=;
        b=Vtp6c/hWNuy+zRZB1kkCrooRRCMmOfl0Mj0AkZbvIBgm4lLaDLhSHDI2fTAoObdK/e
         yhKRAalQqy/DsE7ijEVnwHwyiID5OcPmP0SNq0jqYYjUR4jY8M44g2aYAfuoSCRPvAHy
         4bsZIAnguX/MD6WKAmJquT1iHShJEwve+tpK26LDWqk2lbIl5+QHz/kDO2RvviTsBAEA
         uOnZXsINb7eGccM+7yv6Sn9gexHRADbk5V79KY4M0z5q8N0Et+VwlovQbN4Guz3Fh0Mz
         bQaRHxjhZZNUdfEboB3RslAyiUm0wacAikdNpR1e631d03C4qRwBKa2Q5ZLeBqcLS089
         ww9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689846428; x=1690451228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H70QPrwV0n7u44BE2OYdm8oLTPU3a+ECk2OOoT5kVss=;
        b=XDtmvwLJ5iUeuHJnh/FZ9Cn45tbtwyeWvnaeEELol+4loef4r918etkn1mfrTETPGu
         CJEy16O0hAHfQmmSx2Xcf2kbd40l07UE6owj3yzcEcvQEKYVS8+JVC4NXI+zhYasFzqK
         YNqsCVG/QCqQiq99BlEowodAyvjqwxLFZIU0l6CHruWvmRX8IJoiR+W7fu8ZrDWt6fD3
         HST5s2TAyGMA77N3sa9gUbc+mpH+ug60wqGAAZwfTnRiVWQonvMC1eszaeYEKGWLwVKX
         q8uF27sOW9gGTJJoOlS7LWL9iv9ccL1Ouvou6Npt7hJ8GUAxbDWUXb6Ruv9iL4ANSARQ
         aE7A==
X-Gm-Message-State: ABy/qLbGOJzNtiO++mNuZFnyFhvgU/kjHnpeNWWTKOs4QA3k4qTLvcXh
        99IesXKEPrhyc6LlWNUTnAtTiAemA/aHH6Beh417dQ==
X-Google-Smtp-Source: APBJJlGu/xW7CTKYLQzNfqfiCyBaMnRPgnvnypkk/JE6dvatTfikV5svcnxVAUFi3SwaEZ1LRGuE2fsFvbJbIaZBhrE=
X-Received: by 2002:a05:600c:5126:b0:3f4:2736:b5eb with SMTP id
 o38-20020a05600c512600b003f42736b5ebmr65885wms.1.1689846427341; Thu, 20 Jul
 2023 02:47:07 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f7b82505e9982685@google.com> <0000000000002f22130600e7fb01@google.com>
In-Reply-To: <0000000000002f22130600e7fb01@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Thu, 20 Jul 2023 11:46:55 +0200
Message-ID: <CANp29Y5HZDVrsZcauU2BbHy2TgRcV26e4g7Oud991dk6B-e55A@mail.gmail.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in assertfail (2)
To:     syzbot <syzbot+c4614eae20a166c25bf0@syzkaller.appspotmail.com>
Cc:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        wqu@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 20, 2023 at 11:43=E2=80=AFAM syzbot
<syzbot+c4614eae20a166c25bf0@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 745806fb4554f334e6406fa82b328562aa48f08f
> Author: Qu Wenruo <wqu@suse.com>
> Date:   Sun Jun 11 00:09:13 2023 +0000
>
>     btrfs: do not ASSERT() on duplicated global roots
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D16d92676a8=
0000
> start commit:   830b3c68c1fb Linux 6.1
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D26d9ba6d9b746=
f4
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dc4614eae20a166c=
25bf0
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D14078087880=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1403948f88000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: btrfs: do not ASSERT() on duplicated global roots

Looks reasonable.

#syz fix: btrfs: do not ASSERT() on duplicated global roots

>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>
