Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293C94FBCC9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 15:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346358AbiDKNKT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 09:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233939AbiDKNKS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 09:10:18 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B95F2AE26
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Apr 2022 06:08:04 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id c1so3709270qvl.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Apr 2022 06:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z1NVtOyODcRgWvF6Zrh3KPe0Rk4GIJmlyj/e/JaJSSs=;
        b=Q//JY3G/W3FwfFvJvkG69JkBzgu2d9QtUqQZz9XmHYYi8EgI4riacE7+8H7JOQn+5U
         I849wmtiCjLtXIgarR/V5CqVk4YinCcgHmvUvlo2obgLpJo4QW/JJBhlVXrGDvTmxtPE
         0qUY2v2ZY78ey+C4DeMGKBAUgc4RhfCXegO4sYYAKD1cJH4vOXSz+80jwXLSipoo2K5x
         ng7+LaG+WhfGnK8YXJDHe8z1doAURJyU6pDuI/M3J7AFlz/F+mzAWm/8G0zG4BrRWZMj
         9ZSXDD4xu9j9Fa2lyyZxiu/Ph5qrSr9UHr+mzKsGME4ELj57sWZFys+ntPm1k/dfolg8
         t7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z1NVtOyODcRgWvF6Zrh3KPe0Rk4GIJmlyj/e/JaJSSs=;
        b=VNfAShoH0Oa56z/3Y8FdOwEy/tS3u26ORVHH2/js+WHV1a2V1JqX9EOTQ/e228rjJY
         mthOQwaAq6JIXsaFtDQSqaPtM7bYMWAg7KILTXNRXzHpLrCQ7jAj2rMrcCPM8u8/US6z
         9VK/8YS1xNlprwNog0zTN8pASz5LbZegACA7pGmv9mN3S4vBVvtWdrKJMf3BOplYxGRs
         fnCO6TNV44zlDbnVfwK14je7h/4Wh9FMSyCzlBwo6MgTC51gzi5RE+lg4mrgwnXcA0th
         tbWVGCJiLx3TnuUM9DvhVa2r4qp1miQLk1naEJGyY+VZPeztSatDKdtjCkn5wSiktgoM
         9dEg==
X-Gm-Message-State: AOAM530y/rlfViyr5xsBelPjmpYFR39aoT0ELLOVefEJ2YJmGeE8hcOU
        KGpkcBScd9nVkLwREZ/YBzLwN1AG9QqoimkAd/jRRNKLiQo=
X-Google-Smtp-Source: ABdhPJxHXoaHrUJi80ssC0DoWTgBCtU0ojK65s+u3aygW3XF9Ns0I3siI9KcnOXxgotBzTdAYxsik3dV13g8RdwUzu8=
X-Received: by 2002:a05:6214:2607:b0:444:3e1c:9491 with SMTP id
 gu7-20020a056214260700b004443e1c9491mr5899101qvb.12.1649682483664; Mon, 11
 Apr 2022 06:08:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220329074904.2980320-1-amir73il@gmail.com> <20220329074904.2980320-15-amir73il@gmail.com>
 <20220411125353.o2psnjccrqwcmhuw@quack3.lan>
In-Reply-To: <20220411125353.o2psnjccrqwcmhuw@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 11 Apr 2022 16:07:52 +0300
Message-ID: <CAOQ4uxgk2rA6i+a3dopnrpj-gBmfBZ-j8DDPNAvoU1=oTocFKw@mail.gmail.com>
Subject: Re: [PATCH v2 14/16] fanotify: add FAN_IOC_SET_MARK_PAGE_ORDER ioctl
 for testing
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 11, 2022 at 3:53 PM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 29-03-22 10:49:02, Amir Goldstein wrote:
> > The ioctl can be used to request allocation of marks with large size
> > and attach them to an object, even if another mark already exists for
> > the group on the marked object.
> >
> > These large marks serve no function other than testing direct reclaim
> > in the context of mark allocation.
> >
> > Setting the value to 0 restores normal mark allocation.
> >
> > FAN_MARK_REMOVE refers to the first mark of the group on an object, so
> > the number of FAN_MARK_REMOVE calls need to match the number of large
> > marks on the object in order to remove all marks from the object or use
> > FAN_MARK_FLUSH to remove all marks of that object type.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> I understand this is useful as a debugging patch but I'm not sure we want
> this permanently in the kernel. I'm wondering if generally more useful
> approach would not be to improve error injection for page allocations to
> allow easier stressing of direct reclaim...

I think you are probably right, but I had to stay within time budget
to create a reproducer and it took me a lot of time even with this hack
so I don't see myself investing more time on a reproducer with improved
error injections.

So for me, it is an adequate solution to carry this patch out-of-tree
along with a matching out-of tree patch for LTP test:

https://github.com/amir73il/ltp/commit/383db59959c44bb27dbec81e74d1d9caba45b0f2

For the community, we could rely on lockdep reports users now that
we sorted out the lockdep annotations.

BTW, before resorting to this ioctl I also started going down the path of
running the test inside a restricted memcg, only to figure out that it
is the inodes
that need to be evicted not the marks and inodes are not accounted to memcg.
I think there may have been some work in the direction of somehow accounting
inode cache to memcg, but not sure where this stands.

I am open for other suggestions.

Thanks,
Amir.
