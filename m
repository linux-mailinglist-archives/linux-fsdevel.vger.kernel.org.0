Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB48959A587
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Aug 2022 20:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350553AbiHSSNy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Aug 2022 14:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350408AbiHSSNa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Aug 2022 14:13:30 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D913FFDF;
        Fri, 19 Aug 2022 11:05:42 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-11ba6e79dd1so6030030fac.12;
        Fri, 19 Aug 2022 11:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=yu5IZUHI3cBawr1N/5hlYoG5ZXlCmymb1dtlh//8sOs=;
        b=h+OQqd6rUc/dgACYrYixZnZhbFprpl2aNMzUPu13lEAEqlTbVQM3keegYdBVn7BNuK
         OcPVyOPSBHMbfHp+qxQPPNxWvUk4SndWsxAyc00XyJxrhrSU9Qz8Jdiam9x4IUDSmHUP
         BbD4pU1KiGGhmUCYxJv4awxzsX7wPoXJdrjv5GNaIN9Hv8V8qD0NKVC2z7DoMgAvmlTI
         N6ib4XD6KyRhibvo5AW9qNyYJBTtXUqATiewepX+JKV8ZLgqDDmsEMgT8NBegiAV83kI
         Bv3MBFOMk535EOg27SI+W8kW0OPG8EqdWlKZl1fZlVXquq00WpnbcSew2FHUZ6Q2fcZU
         QC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=yu5IZUHI3cBawr1N/5hlYoG5ZXlCmymb1dtlh//8sOs=;
        b=E5XS/vOZ4kReEgZiUvnz6XFLnDwkFdvmf2mlHaXlmRki9O6Q12b4a7w86qMovX8hF1
         4hfuElEg11t6qPxUUqoIB3kcOeab/NWeSDdaQuludvHxBCVrB89iGr9vKXJlbE3zPxWC
         Ik/RjCLHZAk8VJIyFczFa1gP8V05s3KQvQCKjLXm7SwvPg+CbwBcimn7S6sLoKBGHBKv
         uIHR8ueBPxXKtLUX4Qx8rMTUOyp0159QjF5rqt3smFiF274owYXcV//Qpo1zuuE3WJum
         U/wpPZDnX2k/XBBgV03BhI34Ihl91Dihu+1Ar8ojJ/aboCJcBaOudQjIcHFb5r+Igyfs
         WsUQ==
X-Gm-Message-State: ACgBeo2wSlme+umpY3Rfi6LJKp7nzaJJWZhLCPcLashtZBtmFpxVH7dg
        2zxRuGQbkeo1Yi58pupSkcg0WCmjh3XQW95l1+c=
X-Google-Smtp-Source: AA6agR5cmaKR9BsbXyWWqSlgxm+2/qW3n9sQsGbO+C5C4jK9P6vWwiLaGGzA41ZiUH1qYTuxSnv8o4qTS53eKB6aZCQ=
X-Received: by 2002:a05:6871:6a1:b0:11c:7c79:6bfb with SMTP id
 l33-20020a05687106a100b0011c7c796bfbmr4441641oao.205.1660932342149; Fri, 19
 Aug 2022 11:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220607153139.35588-1-cgzones@googlemail.com>
 <20220608112728.b4xrdppxqmyqmtwf@wittgenstein> <CAOQ4uxipD6khNUYuZT80WUa0KOMdyyP0ia55uhmeRCLj4NBicg@mail.gmail.com>
 <20220608124808.uylo5lntzfgxxmns@wittgenstein> <CAOQ4uxjP7kC95ou56wabVhQcc2vkNcD-8usYhLhbLOoJZ-jkOw@mail.gmail.com>
 <20220618031805.nmgiuapuqeblm3ba@senku> <CAOQ4uxg6QLJ26pX8emXmUvq6jDDEH_Qq=Z4RPUK-jGLsZpHzfg@mail.gmail.com>
 <20220620060741.3clikqadotq2p5ja@senku> <CAOQ4uxhq8HVoM=6O_H-uowv65m6tLAPUj2a_r3-CWpiX-48MoQ@mail.gmail.com>
 <20220622025715.upflevvao3ttaekj@senku>
In-Reply-To: <20220622025715.upflevvao3ttaekj@senku>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Fri, 19 Aug 2022 20:05:31 +0200
Message-ID: <CAJ2a_DfkMvh7EdOA6k+omxhi18-oVbSXSGzXnpU1tXPD55B2qw@mail.gmail.com>
Subject: Re: [RFC PATCH] f*xattr: allow O_PATH descriptors
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Wed, 22 Jun 2022 at 04:57, Aleksa Sarai <cyphar@cyphar.com> wrote:
>
> On 2022-06-20, Amir Goldstein <amir73il@gmail.com> wrote:
> > To be a reasonable reaction to the currently broken API is
> > to either accept the patch as is or request that setxattrat()
> > will be added to provide the new functionality.
>
> Since the current functionality cannot be retroactively disabled as it
> is being used already through /proc/self/fd/$n, adding
> *xattrat(AT_EMPTY_PATH) doesn't really change what is currently possible
> by userspace.
>
> I would say we should add *xattrat(2) and then we can add an upgrade
> mask blocking it (and other operations) later.
>

It seems setxattrat() is the preferred way to continue.
fsetxattr() would have one advantage though (w.r.t. SELinux):

The steps to label a file are:
  1. get the type of the file (via stat(2) family)
  2. lookup the desired label from the label database via selabel_lookup(3)
  3. assign the retrieved label to the file

The label is sensitive to the file type, e.g.

    $ matchpathcon -m file /etc/shadow
    /etc/shadow     system_u:object_r:shadow_t:s0
    $ matchpathcon -m lnk_file /etc/shadow
    /etc/shadow     system_u:object_r:etc_t:s0

Using the *at() family the file type could change between step 1. and 3.,
which operating on an O_PATH file descriptor would prevent.
