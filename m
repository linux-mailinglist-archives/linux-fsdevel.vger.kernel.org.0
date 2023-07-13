Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68FFD751BC7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 10:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbjGMIiX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 04:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234353AbjGMIhy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:37:54 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138BC4EF9
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 01:32:09 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbd33a1819so43325e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 01:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689237127; x=1691829127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ZXFTzZ23tBD9HLQ6KgmQfM1q8HQlCUmLAo2N+jQgyQ=;
        b=ex2YC8/yDLqNpP6R+BAdB+o08HynDsjMbJ48xoaS3vhuyNfQFKPILnqmnZYvjL1tDv
         p5TaPb1oAbo2DpdKeRR6VWKRxq/V/P5bA1DeqgD4VQTrE/zrK0ioQ7LA55ZAK7lpw0+T
         doC/1Nv9st++dDqdBr+xRhMTdjhiH1Utf5EfYVQIVkLyYtDjK7h3BILyLPLAPIm6JsrR
         eAjwxflsLOprvTo+sE2GjEz5fSwM+GmTBwFzKAvI5M/cauBYCOOgmRUicRBvk2llX8iU
         ZyHeP2zmdkPYu/pmt2LyU/171rz5UHlSG2gUfAymA0p/yJbsMUoBtm+Pmm1ot/6w6qn/
         R/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689237127; x=1691829127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ZXFTzZ23tBD9HLQ6KgmQfM1q8HQlCUmLAo2N+jQgyQ=;
        b=B4Fj/4CFeR1jXgJ11Fni9BlTzA6Me8EvwowRSGTF5b+qPNHLNJB5dSbaP618xwss7r
         eLIkQEqcGH47y8tPRmaz4FiJiGVNoKbyTCFfWBk8Ww8ohqUdrbVsqGEBglaMl+OVuDmD
         zlqIOhM8rdBByDV5lwgB1ZZVup7lYKOtOWPy7tubPQSjsmF2InhZLVYQ1MOIeKPc41ws
         Mwv4lwQ6ayaBK/XuJgtp7gs7bIyb4euL7X1g38yOzj8pa29SVN6xT+rmA5RfUqgGNyJF
         VtQ0mZrVgheEPKIddjYS4tyRNhqkKi5z7wjqyO6PdpjW5pOPdis9/3LGjqBPuX3oj36Q
         npeg==
X-Gm-Message-State: ABy/qLbRPKW8nTf2aAaHvzyCEKwLEIgKBpfaWzLMQ2lGVTrFenmsC6Ht
        hD4S0CLW8UQjCkDbBAwJbiP65L80CdbFU92zy0zszIUwpMT1O39FYR2j3A==
X-Google-Smtp-Source: APBJJlEc9EZE8pYaZ2NssNIo57gADVB0lUq6rpskj6IUCA4s3O+BuqWJPo9l+Ye6E3lzSHTKA26gblQsnM6dChRfViM=
X-Received: by 2002:a05:600c:3ba6:b0:3f7:7bd4:3b9d with SMTP id
 n38-20020a05600c3ba600b003f77bd43b9dmr201139wms.6.1689237127389; Thu, 13 Jul
 2023 01:32:07 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000fd3bbe05efb0d1fd@google.com> <000000000000a5d5ab060055215c@google.com>
In-Reply-To: <000000000000a5d5ab060055215c@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Thu, 13 Jul 2023 10:31:55 +0200
Message-ID: <CANp29Y7LG7szcmLzfjNAZRpitQwn6Yh-h7zPk+demObAwuxwZw@mail.gmail.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in walk_component
To:     syzbot <syzbot+eba014ac93ef29f83dc8@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org,
        almaz.alexandrovich@paragon-software.com, davem@davemloft.net,
        hughd@google.com, jiri@nvidia.com, kuba@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 13, 2023 at 4:31=E2=80=AFAM syzbot
<syzbot+eba014ac93ef29f83dc8@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit d772781964415c63759572b917e21c4f7ec08d9f
> Author: Jakub Kicinski <kuba@kernel.org>
> Date:   Fri Jan 6 06:33:54 2023 +0000
>
>     devlink: bump the instance index directly when iterating
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D12801432a8=
0000
> start commit:   f3e8416619ce Merge tag 'soc-fixes-6.1-5' of git://git.ker=
n..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Db83f3e90d7476=
5ea
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Deba014ac93ef29f=
83dc8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D117d216b880=
000
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: devlink: bump the instance index directly when iterating

That commit fixes a second problem triggerable by the same reproducer
-- "INFO: rcu detected stall", but it is not related to the original
"WARNING in walk_component" crash.

>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>
> --
