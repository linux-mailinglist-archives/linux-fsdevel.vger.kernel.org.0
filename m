Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECF46D00AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 12:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjC3KJZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 06:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjC3KJX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:09:23 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF0283FF
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 03:09:17 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-3e390e23f83so476041cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 03:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680170956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QHfYK4L+ShyHkhoulB2o8AHckH/Mpd3a3lRdE+7Qyg=;
        b=OFheN3XNdX8YEQe4sywLKUI2sM6vwFMNrlsCdxQS6E/CE5Au90/oAJtr1iRriRGja4
         5+0/cHgi1vRdBxW1Ir0bUevE7Ijz7ufuw9YS1GuzdyaUYo9WFmMqYYcJfRYL2E20yepH
         dITqa6az4fu6qcLuQF38artlSvVdQlUbMS4WZpiYsOQVfpiTpmatRLFyZYNscjfaQ/Bu
         ye63v6UUyPjNAYZg9v490wFsHNbyjvzO3Oao19MVgk9ohYD/UG5FnPKG+wxtuaaWXrCR
         P+IOplx08kkFuVVaP2E8Pbvy0NNLjVrnmbocX9ybtLC1W1qYHgVoBL/VyWTNCqiQHHXc
         GuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680170956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5QHfYK4L+ShyHkhoulB2o8AHckH/Mpd3a3lRdE+7Qyg=;
        b=5jSJJrQYfwaX2ArmFdVhnFVV7UKIiQST46lRZt3BkZsHSscWFhPk2jzwTprIpn5FgF
         ylKcY55BVSJ/EcOHdd8fwZNrDvllGCemdRr8sxVN64fvJ9mG8HGr/CzK//pnEnPnFofG
         +qlWeObJIIdRILsIrHxJJoJa3lY974HZfWALZSrmcd5vWIh1+awAr+z52fR0jv2TPpDt
         XDGIwf1OacpdgTFQKNqZ0f8/Qc40QSP82OY0o/oGadBsVfGG06sJhUuWkrxVD3x3clBj
         zFOhZVmjIuj7LZUtx3ZNs5SOVP5XSW97w6OYe7o50yb6aeE8aIdwdq0QQMgf5wIoA8fB
         GeVQ==
X-Gm-Message-State: AAQBX9eUeS0VzvvVZIEuxK4i0M2DVS8yCJ/C9RqHYVZFsbmuYNwWGsR7
        xiEK5CK5gDY7n5SLE54SDEcyR5C1PIzkUtP9Kho6cQ==
X-Google-Smtp-Source: AKy350Y80+QkSJsZopsDohV2gcHyIz6/stE6BaGOTjtia6jmm8aSYAzJcTz5XTMBRHxX57rCN7LBoqUFEPkvdOkl6to=
X-Received: by 2002:ac8:7f87:0:b0:3d3:3cc:6f70 with SMTP id
 z7-20020ac87f87000000b003d303cc6f70mr72806qtj.17.1680170956136; Thu, 30 Mar
 2023 03:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000bdc7df05f7f837ff@google.com>
In-Reply-To: <000000000000bdc7df05f7f837ff@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Thu, 30 Mar 2023 12:09:02 +0200
Message-ID: <CANp29Y50uKR9SgXi+wFGQkdcrSn98MfTsmwQXxofYngkzWaKjQ@mail.gmail.com>
Subject: Re: [syzbot] Monthly cluster report
To:     syzbot <syzbot+list6e220af77940a0f2148c@syzkaller.appspotmail.com>
Cc:     cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

FTR The subsystem was recently renamed to gfs2 on syzbot, so the list
of gfs2 bugs can now be found at:
https://syzkaller.appspot.com/upstream/s/gfs2

On Tue, Mar 28, 2023 at 6:19=E2=80=AFPM syzbot
<syzbot+list6e220af77940a0f2148c@syzkaller.appspotmail.com> wrote:
>
> Hello cluster maintainers/developers,
>
> This is a 30-day syzbot report for the cluster subsystem.
> All related reports/information can be found at:
> https://syzkaller.appspot.com/upstream/s/cluster
>
> During the period, 1 new issues were detected and 0 were fixed.
> In total, 23 issues are still open and 12 have been fixed so far.
>
> Some of the still happening issues:
>
> Crashes Repro Title
> 237     Yes   kernel BUG in gfs2_glock_nq (2)
>               https://syzkaller.appspot.com/bug?extid=3D70f4e455dee59ab40=
c80
> 111     Yes   INFO: task hung in gfs2_jhead_process_page
>               https://syzkaller.appspot.com/bug?extid=3Db9c5afe053a08cd29=
468
> 108     Yes   general protection fault in gfs2_evict_inode (2)
>               https://syzkaller.appspot.com/bug?extid=3D8a5fc6416c175cece=
a34
> 23      Yes   INFO: task hung in __gfs2_trans_begin
>               https://syzkaller.appspot.com/bug?extid=3Da159cc6676345e04f=
f7d
> 21      Yes   WARNING in gfs2_check_blk_type
>               https://syzkaller.appspot.com/bug?extid=3D092b28923eb79e0f3=
c41
> 18      Yes   UBSAN: array-index-out-of-bounds in __gfs2_iomap_get
>               https://syzkaller.appspot.com/bug?extid=3D45d4691b1ed3c48eb=
a05
> 13      Yes   INFO: task hung in gfs2_gl_hash_clear (3)
>               https://syzkaller.appspot.com/bug?extid=3Ded7d0f71a89e28557=
a77
> 6       No    KMSAN: uninit-value in inode_go_dump
>               https://syzkaller.appspot.com/bug?extid=3D79333ce1ae874ab7f=
fbb
> 3       Yes   general protection fault in gfs2_dump_glock (2)
>               https://syzkaller.appspot.com/bug?extid=3D427fed3295e9a7e88=
7f2
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/000000000000bdc7df05f7f837ff%40google.com.
