Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697AC4CF303
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 08:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235995AbiCGH4w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 02:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbiCGH4v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 02:56:51 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52374506C
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Mar 2022 23:55:57 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id b5so8280015ilj.9
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Mar 2022 23:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xo58dTEXY/F27fYmOPR69bFboaa6IH78uUyf90/I3RI=;
        b=ouJ9RdXFMnX5gGHLKbsx9hsTgcffnj3wGWeNg4qpAqsc97iAu8JCrIunoXNmm1vqIi
         Pcq8dvQIYDuAbl+956vKOKPiO8YtE/7zS4bGkXjil5DclKrGUwMv88jrCN562G6miir9
         wL759rF4Dumw6tsge2gPyhKrQwPMfQOSg2CtK+oNuH8odEq7z/7UMfbc6FuboeH+/h3c
         6mBauXZMFi+HU8TkLdDRnu797IqogPdUqxC7MgM3B+YiVqQ43mdzb95dMOjbtGIDHId1
         3bre+uwFJ7ampbhJ+GMbnQBRBACVRxL1bw03GwyodfxOK0QZ6RMdGIum/qp710NMUN9r
         mO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xo58dTEXY/F27fYmOPR69bFboaa6IH78uUyf90/I3RI=;
        b=lTrYvu5A/d9BwtpMHhCXOsAYbyCFAV/TL0dcaFkpbVH/u5AvZ/eAj1YysEs8rp6bHM
         8TVUTGACmqBDoHCifQZAlUjykf7AX/oXNkSH2AOHLGY5ROcYyS9pqYfVJ5/u9mgcJb1W
         DhvS2GmZpq1dKWmPJQrXxJYYdiPD8/K+36VE5hcjjy5/ZM2GsH2T5fyp04XWU6FVL9Om
         YUI27V/BgkBGfu9w1dMZtMjIs7doNB0OCTVNzCA9mXns+LWILYba5tjNR5Phgx/wfU78
         qQFeX0KWNXu0rrXT1oKPE66T/KBvAOggLsvSqW8nWUmJWO/3+OMQqlFTQH2cfkWHvmWT
         aKVQ==
X-Gm-Message-State: AOAM533lBYZmpyvt3DBxCVkqnvivcddkqeo4OriHes74YEyVDOqF3tgX
        /roJU/iv2UP4iXdpzD6kdq5LQrfT/hKGhkNmyIY41uOaoDldTA==
X-Google-Smtp-Source: ABdhPJwS/bLUDjG66OuG9kDu3XVfgunh5kbfyN6i+8T3f3mMdXidurrKrq/cKnLH3uPLi90tx8VbI8LSCnG2kSGKvPM=
X-Received: by 2002:a92:6907:0:b0:2bc:4b18:e671 with SMTP id
 e7-20020a926907000000b002bc4b18e671mr9712117ilc.299.1646639757324; Sun, 06
 Mar 2022 23:55:57 -0800 (PST)
MIME-Version: 1.0
References: <20211229040239.66075-1-zhangjiachen.jaycee@bytedance.com>
 <YhX1QlW87Hs/HS4h@miu.piliscsaba.redhat.com> <CAFQAk7gUCefe7WJhLD-oJdnjowqDVorpYv_u9_AqkceTvn9xNA@mail.gmail.com>
 <CAJfpegt=9D1wAdxbr82br-cCnikNTiEZ=9NfPo02LAbTPMNb2Q@mail.gmail.com>
In-Reply-To: <CAJfpegt=9D1wAdxbr82br-cCnikNTiEZ=9NfPo02LAbTPMNb2Q@mail.gmail.com>
From:   Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Date:   Mon, 7 Mar 2022 15:55:46 +0800
Message-ID: <CAFQAk7j-Osw7jR6YxOL3OgcAiwmVq_bfV-ceqrD4JzyLEnBe7Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] fuse: fix deadlock between atomic
 O_TRUNC open() and page invalidations
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xie Yongji <xieyongji@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 4, 2022 at 11:30 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Fri, 4 Mar 2022 at 07:23, Jiachen Zhang
> <zhangjiachen.jaycee@bytedance.com> wrote:
>
> > I tested this fix, and it did pass the xfstests generic/464 in our
>
> Thanks for testing!
>
> > environment. However, if I understand correctly, one of the usages of
> > the nowrite is to protect file truncation, as said in the commit
> > message of e4648309b85a78f8c787457832269a8712a8673e. So, does that
> > mean this fix may introduce some other problems?
>
> That's an excellent question.  I don't think this will cause an issue,
> since the nowrite protection is for truncation of the file on the
> server (userspace) side.   The inode lock still protects concurrent
> writes against page cache truncation in the writeback cache case.   In
> the non-writeback cache case the nowrite protection does not do
> anything.

Got it. So the nowrite is protecting O_TRUNC FUSE_OPEN (or truncating
FUSE_SETATTR) against FUSE_WRITE in writeback_cache mode? Then this
patch looks good to me.

Thanks,
Jiachen

>
> Thanks,
> Miklos
