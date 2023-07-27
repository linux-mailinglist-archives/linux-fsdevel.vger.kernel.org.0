Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E38D76472D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 08:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjG0Grh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 02:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjG0Grf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 02:47:35 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6062681
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 23:47:34 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbd33a1819so35485e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 23:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690440453; x=1691045253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VjR3y/NhR9d/n61OfA+UcoVAqNvKvdj5JIvCgpy4QI=;
        b=vWi0HoNz9kZOWjQXYjAK3yS2FAp9xevHHfdZL+JMaqd6T1nJeDxYGUnHVn9aTbcRyf
         CkvLJmOdfIHaqFmZACgSG7ocQHLeQEQPIcyvXHlU/TWBafHoqrqBCf9fPNKWnOK6oGTI
         +ICbgKpvcuvEGOZ9zADv1LL/p/RXZ1/WF1puToYh1UEE13if8IuWgAQgFIHCwmFRDHbk
         0KszdEtQXcDPjxL/VbnIzLC4lbbKb6ovkfCyDCJM50W4yUuv+v5FuBlJNefCHgwokfC7
         gojmBvcisRWDlm66Bg8lHIaEZ7ib74z6o5xgx2qDzpLxtsnvymJc2hB+xBN5J78I8n2L
         lANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690440453; x=1691045253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VjR3y/NhR9d/n61OfA+UcoVAqNvKvdj5JIvCgpy4QI=;
        b=gGXUZHC+TAPBiQkg+XQQZQAlJ6RC4yw6W1v12gyziJ/JOCIMrNUEx2/enfzPqs+xfF
         SuaoYtrRc/UDdW3nlHVIMiL3TdworTHWstYcl4H2ruD3FR+Lu7qLnAVINXmBi4TnMdlB
         zJ1ng9aFCNxibaxJ4efjEaJmGiyuPLqetFJxdhHIuzoFvEWANFKW6a3VgDTwd87gw3Dz
         JzTBRoyrO8A9XXbEYPx8k3bqIZJuAMPceF+BG1x8qqNH9QAau7yBD5A27daYX5o45qwU
         +9lEbudPFhJlf9nLyqjE4GTxqUnv/cJ9Lhuaza2Ng0m5XeZfJNRDfihkud91ULimlIze
         sNNQ==
X-Gm-Message-State: ABy/qLaKVOHBLAgp4/yDxNYh+mMt6VVV0FNOpdM3XpKR0/k5Qoonup57
        ruT7Qr15/xbxUTll0XZvEa6sU5UN8MzdJinYNdNw2w==
X-Google-Smtp-Source: APBJJlHfJHMB79wmPcYAX+eRz3l3yJooxMVKXpu6Z2nTr7RChJGtq0JGjXHvXpOL9DCD74cw420Zqm1UmohQ13kUBC8=
X-Received: by 2002:a05:600c:3b21:b0:3f7:7bd4:3b9d with SMTP id
 m33-20020a05600c3b2100b003f77bd43b9dmr1852wms.6.1690440436670; Wed, 26 Jul
 2023 23:47:16 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000a0d7f305eecfcbb9@google.com> <000000000000ca24700601714dd2@google.com>
In-Reply-To: <000000000000ca24700601714dd2@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Thu, 27 Jul 2023 08:47:04 +0200
Message-ID: <CANp29Y5htGCC0X73qb-iGwjN0OaFCmCRKTEdhCcF_nx7aLpe2w@mail.gmail.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in path_openat
To:     syzbot <syzbot+be8872fcb764bf9fea73@syzkaller.appspotmail.com>
Cc:     almaz.alexandrovich@paragon-software.com, bp@alien8.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, yazen.ghannam@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Please ignore this bisection result.

On Thu, Jul 27, 2023 at 7:33=E2=80=AFAM syzbot
<syzbot+be8872fcb764bf9fea73@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 00e4feb8c0476bbde3c8bf4a593e0f82ca9a4df6
> Author: Yazen Ghannam <yazen.ghannam@amd.com>
> Date:   Fri Jan 27 17:04:03 2023 +0000
>
>     EDAC/amd64: Rename debug_display_dimm_sizes()
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D157a6f81a8=
0000

accumulated error probability: 0.50
< .. >
reproducer is flaky (0.11 repro chance estimate)

The reproducer was too unstable and the threshold for non-reporting is
currently exactly 0.5 :)
I'll decrease it.

> start commit:   c1649ec55708 Merge tag 'nfsd-6.2-4' of git://git.kernel.o=
r..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D319a3509d25b0=
f85
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dbe8872fcb764bf9=
fea73
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D17c604fe480=
000
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: EDAC/amd64: Rename debug_display_dimm_sizes()
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>
