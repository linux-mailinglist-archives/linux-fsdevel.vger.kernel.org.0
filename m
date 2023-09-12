Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1CD79D66B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 18:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236927AbjILQgK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Sep 2023 12:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236874AbjILQgJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:36:09 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F1F10EB
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Sep 2023 09:36:05 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c3a2ea2816so175865ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Sep 2023 09:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694536565; x=1695141365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rBrBJw2gZiMOtwReeER2gBrgb6ZIuVFflAABYnAKhrk=;
        b=RGNjMKh8qtLWWtNHR1wJBKmmO6Da0yuynqUzZvvRMA0Rciin3ZAmTpJwfj5BufiMfY
         Mkl3XrVasZdL5kGXDHOZxx8poW27Tgsn91AarlLnmHElWThM+0+H7grnZ9YfcxzIUw2f
         mBTZ11LB2nVsBGP7XGMlH8m5D5H9aw2cxrloTRR5Tz0RL+eghmTwyAVeNc9qWSVgoRB2
         aYDjky+XJi/yVfBB3IC1Z7Zu+xXN0d9OV1+DRBRzZSOtABUnWvSVZz25Ij4j2Nj+aud8
         szKbYP/fs9BDtV6ZyY52pWK2InJYDl9GevrU3ubJTRPoYaKdUK3q8xNJOTKFHCNSRqB8
         Ou2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694536565; x=1695141365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rBrBJw2gZiMOtwReeER2gBrgb6ZIuVFflAABYnAKhrk=;
        b=arAF+khn/khqfUbsX1JcLIbLZwLc1Z6H9z3H0yiI4g68+x9Kq9dQ/tCahAuDv3eemf
         qukMOrwp2Ydvgf8KizFUKPFt1/XvkcUoYwWn2OFoA5GgSBqFR9lTY9SxloAjIQBdZ3kL
         GJZrvy8VhsnhW1Luy9x363CDYH6xK3Z3FMWWk5+kg8PSheDs5cJz2WGOO2mje1dqMRa+
         /ieWybmWF9W5NEYsBpmvZb1Zz/2+qzhqbBbRZspuFdS7JiwCGPoHd7iXTwkXKzvSgDtp
         drcSA68aBm2WKh2qusfce3qpJoEChHs/U3WZIfrqrzFpsz5LP3YNWZUvvjgSwkYWz6bH
         1YOw==
X-Gm-Message-State: AOJu0Yw5zD3OVtNIiGpSN6Qe5kQyFXtc/AccKxj/ORAu8c1Uh1XXrdhb
        YsO3mUE/i6uNQG3ldE8ztuqgTvnkN6BUuMz/lU9gNNQ0/YQkMNnBXfsNsA==
X-Google-Smtp-Source: AGHT+IH3yw1KQNicyRwhKFqkEhYAfiCu9BnkuuCHiTL6C29NVJIiyzWoabvHTqX9X9C7G33wNG3lJ/jg+qgo0YhIAeM=
X-Received: by 2002:a17:902:fb05:b0:1bf:208a:22ff with SMTP id
 le5-20020a170902fb0500b001bf208a22ffmr341670plb.6.1694536565042; Tue, 12 Sep
 2023 09:36:05 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000019e05005ef9c1481@google.com> <00000000000088fbf106052bab18@google.com>
In-Reply-To: <00000000000088fbf106052bab18@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Tue, 12 Sep 2023 18:35:53 +0200
Message-ID: <CANp29Y54FeFU3Wtw9qXM81dha9zLyj_nvqHqDpRE6T9AiL8DWA@mail.gmail.com>
Subject: Re: [syzbot] [xfs?] KASAN: stack-out-of-bounds Read in xfs_buf_delwri_submit_buffers
To:     syzbot <syzbot+d2cdeba65d32ed1d2c4d@syzkaller.appspotmail.com>
Cc:     chandan.babu@oracle.com, davem@davemloft.net, djwong@kernel.org,
        hdanton@sina.com, jiri@nvidia.com, kuba@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hmm, no, this might have caused the reproducer to stop working, but it
has nothing to do with the actual issue.

Please ignore the bisection result.

This commit has been popping up quite a number of times already. I'll
add it to the syzbot's ignore list.

On Tue, Sep 12, 2023 at 6:09=E2=80=AFPM syzbot
<syzbot+d2cdeba65d32ed1d2c4d@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit d772781964415c63759572b917e21c4f7ec08d9f
> Author: Jakub Kicinski <kuba@kernel.org>
> Date:   Fri Jan 6 06:33:54 2023 +0000
>
>     devlink: bump the instance index directly when iterating
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D15554ba468=
0000
> start commit:   3ecc37918c80 Merge tag 'media/v6.1-4' of git://git.kernel=
...
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dd58e7fe7f9cf5=
e24
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd2cdeba65d32ed1=
d2c4d
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D170a950b880=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1625948f88000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: devlink: bump the instance index directly when iterating
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/00000000000088fbf106052bab18%40google.com.
