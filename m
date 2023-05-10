Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C19B6FE460
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 May 2023 21:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236282AbjEJTEK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 May 2023 15:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236194AbjEJTEE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 May 2023 15:04:04 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6229B2D74
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 May 2023 12:03:41 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-33164ec77ccso385055ab.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 May 2023 12:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683745420; x=1686337420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QbhNMNTbdw0qSNr0k4GpjBRX50qyOAXsQymwFeq14SQ=;
        b=ALKj+cgF6QebrDIyAnmVX9FjK0szrVsXsON/2iAcGk0STw53FR1dwLN7acc5qq5JEP
         zTfJzSZx4XigbhJsQJzq55FJCy3hUPonwmhltIzQu6RXKjP/S+DHm6Xmv11fyYjSCtg6
         Y05NP1Q8h+wTJIgIQdP2sMwFzQAv/gbnNSRDF5OKxvpUQ/g8+9RvWr5zGpPqNZmcY+t0
         tXG65o7WNuwLUWNV0DeN2rOJmlhmAPIHZQphqhRRzGwGZRPr+TRKgK4/4UHLf+ndm49i
         ZdHFOY0JrGWBMXytzvLWAqnvwblCdIXDo2Gv9iFRNu5uarqlfLODc62jEfzAm8iztL2O
         3HLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683745420; x=1686337420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QbhNMNTbdw0qSNr0k4GpjBRX50qyOAXsQymwFeq14SQ=;
        b=kyqDpxgdAU12OmDkHqC+CT70sNT228qSLV9LflprnBD6WKTVy/zTU9GGnf2DS+vPAu
         NgF+U4sZRqkXbL2qGpli2foVbzbNtYn60O+nGLoOJzGLEKp9mgPvINR+OTHrQH4o/4sO
         t122VgIOAymBH97BNxWaVU3R6eizGFfEo4y3O0mDDqYlYT6MNrRa8Lm/Z5TupDCSAeed
         1dG9FwyvmovKBJDpjy6OJIQ16ZGLSCLZ+HG3TQvw/xVL5YhWSGsuPG7SAX1o2luFtFep
         eGo/M4ypCnFE7aSfaJiYBxb4YlpQxMiLzy/Tn18B65BDAYmccFEVcYkapUMvrAfWLbIy
         6E3w==
X-Gm-Message-State: AC+VfDxVOyti/NXnpAbAnNmZPIMliiZeeaWFfkWIqaTr6OA62Md0Kukq
        HluQPpSYhE1KOqJgDhzLz+SlsO+GZRhCgB2IrENfgw==
X-Google-Smtp-Source: ACHHUZ6veQGLSpr6GGUnXWOfjv15A2Rk/hJDrJPU/i7J6ttYheTKI1yAN0to5XpAHpU2QEXKoI2EPyA9y24FdQDEIy4=
X-Received: by 2002:a05:6e02:1d03:b0:331:2623:c5f4 with SMTP id
 i3-20020a056e021d0300b003312623c5f4mr24618ila.1.1683745420690; Wed, 10 May
 2023 12:03:40 -0700 (PDT)
MIME-Version: 1.0
References: <ZFvpefM2MgrdJ7v4@mit.edu> <000000000000bd687205fb5b7714@google.com>
In-Reply-To: <000000000000bd687205fb5b7714@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Wed, 10 May 2023 21:03:29 +0200
Message-ID: <CANp29Y6kwK_BAjtOrc0_3NhOzU1RaA2dH2ctwE3uRHg-S56P0g@mail.gmail.com>
Subject: Re: [syzbot] [ext4?] BUG: sleeping function called from invalid
 context in alloc_buffer_head
To:     syzbot <syzbot+3c6cac1550288f8e7060@syzkaller.appspotmail.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

#syz set subsystems: mm

On Wed, May 10, 2023 at 8:59=E2=80=AFPM syzbot
<syzbot+3c6cac1550288f8e7060@syzkaller.appspotmail.com> wrote:
>
> > #syz set: subsystems mm
>
> The specified label "mm" is unknown.
> Please use one of the supported labels.
>
> The following labels are suported:
> missing-backport, no-reminders, prio: {low, normal, high}, subsystems: {.=
. see below ..}
> The list of subsystems: https://syzkaller.appspot.com/upstream/subsystems=
?all=3Dtrue
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/000000000000bd687205fb5b7714%40google.com.
