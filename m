Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505FC5B5D96
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 17:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiILPqy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 11:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiILPqv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 11:46:51 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5D02ED63;
        Mon, 12 Sep 2022 08:46:50 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id d12-20020a05600c34cc00b003a83d20812fso7492975wmq.1;
        Mon, 12 Sep 2022 08:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=tlHc5SL6klavmLXNHsuFObOY4qTxwFirbaKea93oDWw=;
        b=MoiSIX1/vhHewmEUqi4c8R0aNvsg4lyRmE75DsF58eRwkpE2rgs3ChmOhTcygbBZsI
         bcSnjTQRGYQx4wW52vN/L8UUY76J6qNpNvvLiE8fWmJV7BmqfGthgN/2c1N0XKhJDWhr
         NHBxQWzpC9nS/lX/+FpHOJjvAxbEnmnxCO3Q3Lng072XLVHFjaNB1029X9PqPC6dtL+3
         XRZW89xHS/dK87u5RUESDp4wyIj94l+BAamXZnY44zbDRCxDwRVy88qXh42sxN1eKuAm
         f8EaxZF0nWvgIs6qUlP9s5TCDcIay7+zcJQ6FIZIHS6l3PEcIgvcGdhfRdr/Y5RlXZxa
         UReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=tlHc5SL6klavmLXNHsuFObOY4qTxwFirbaKea93oDWw=;
        b=ohZH6e8vrWnGFGfAKZnHWrUwm2StD6Ex6+b3ID7MKcqI068FV1frwo50FLwA3bbmOa
         iJIeoNn5dpQc2WipfANPROsu0X03TnSkuB0bMmD3FrtndUGPk06eerxFYb5Qt8VdNTTH
         uawJ/YZdn2O4bDQed95S4bR/HamjsPlfMlBSfxNa3PP/8pnW9Ra6/QKtQ7/N5OUjvhKQ
         p5QYUMGb1xatvOsQDnIwBzCQz7W17IMAGnR8vSJr3M6hoLryY2U8hRAtrYXOM3UJD6x2
         tX4FDZ/w6DwsXoT1xy/Oi2XMnVbgwtapCv/clCYJhJg9fsocVwoeKOwjDpsgIx2Qiytd
         bd4A==
X-Gm-Message-State: ACgBeo1tw9xzN/iuuahn1hnvX89AbDlD/x3pbSyOdCdBWyei9m8sGhvk
        g90/xUWCKoCjoiIYvWmOA48=
X-Google-Smtp-Source: AA6agR5xLFlQ15JR02wbgn/L378ErKcZnZ6tUkhahRHeIFlZxB1OUR55agNcE1ZKywYhHXxOStH1HQ==
X-Received: by 2002:a7b:c848:0:b0:3b4:73f4:2320 with SMTP id c8-20020a7bc848000000b003b473f42320mr7285695wml.124.1662997608918;
        Mon, 12 Sep 2022 08:46:48 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id c8-20020a05600c0a4800b003a62052053csm13644407wmq.18.2022.09.12.08.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 08:46:48 -0700 (PDT)
Date:   Mon, 12 Sep 2022 17:46:46 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Subject: Re: [PATCH v6 5/5] landlock: Document Landlock's file truncation
 support
Message-ID: <Yx9UZocFXQ9TbZnO@nuc>
References: <20220908195805.128252-1-gnoack3000@gmail.com>
 <20220908195805.128252-6-gnoack3000@gmail.com>
 <2f9c6131-3140-9c47-cf95-f7fa3cf759ee@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f9c6131-3140-9c47-cf95-f7fa3cf759ee@digikod.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 09, 2022 at 03:51:35PM +0200, Mickaël Salaün wrote:
> 
> On 08/09/2022 21:58, Günther Noack wrote:
> > Use the LANDLOCK_ACCESS_FS_TRUNCATE flag in the tutorial.
> > 
> > Adapt the backwards compatibility example and discussion to remove the
> > truncation flag where needed.
> > 
> > Point out potential surprising behaviour related to truncate.
> > 
> > Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> > ---
> >   Documentation/userspace-api/landlock.rst | 62 +++++++++++++++++++++---
> >   1 file changed, 54 insertions(+), 8 deletions(-)
> > 
> > diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> > index b8ea59493964..57802fd1e09b 100644
> > --- a/Documentation/userspace-api/landlock.rst
> > +++ b/Documentation/userspace-api/landlock.rst
> > @@ -8,7 +8,7 @@ Landlock: unprivileged access control
> >   =====================================
> >   :Author: Mickaël Salaün
> > -:Date: May 2022
> > +:Date: September 2022
> >   The goal of Landlock is to enable to restrict ambient rights (e.g. global
> >   filesystem access) for a set of processes.  Because Landlock is a stackable
> > @@ -60,7 +60,8 @@ the need to be explicit about the denied-by-default access rights.
> >               LANDLOCK_ACCESS_FS_MAKE_FIFO |
> >               LANDLOCK_ACCESS_FS_MAKE_BLOCK |
> >               LANDLOCK_ACCESS_FS_MAKE_SYM |
> > -            LANDLOCK_ACCESS_FS_REFER,
> > +            LANDLOCK_ACCESS_FS_REFER |
> > +            LANDLOCK_ACCESS_FS_TRUNCATE,
> >       };
> >   Because we may not know on which kernel version an application will be
> > @@ -69,16 +70,26 @@ should try to protect users as much as possible whatever the kernel they are
> >   using.  To avoid binary enforcement (i.e. either all security features or
> >   none), we can leverage a dedicated Landlock command to get the current version
> >   of the Landlock ABI and adapt the handled accesses.  Let's check if we should
> > -remove the `LANDLOCK_ACCESS_FS_REFER` access right which is only supported
> > -starting with the second version of the ABI.
> > +remove the `LANDLOCK_ACCESS_FS_REFER` or `LANDLOCK_ACCESS_FS_TRUNCATE` access
> > +rights, which are only supported starting with the second and third version of
> > +the ABI.
> >   .. code-block:: c
> >       int abi;
> >       abi = landlock_create_ruleset(NULL, 0, LANDLOCK_CREATE_RULESET_VERSION);
> > -    if (abi < 2) {
> > -        ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_REFER;
> > +    switch (abi) {
> > +    case -1:
> > +            perror("The running kernel does not enable to use Landlock");
> > +            return 1;
> > +    case 1:
> > +            /* Removes LANDLOCK_ACCESS_FS_REFER for ABI < 2 */
> > +            ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_REFER;
> > +            __attribute__((fallthrough));
> > +    case 2:
> > +            /* Removes LANDLOCK_ACCESS_FS_TRUNCATE for ABI < 3 */
> > +            ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_TRUNCATE;
> >       }
> >   This enables to create an inclusive ruleset that will contain our rules.
> > @@ -127,8 +138,8 @@ descriptor.
> >   It may also be required to create rules following the same logic as explained
> >   for the ruleset creation, by filtering access rights according to the Landlock
> > -ABI version.  In this example, this is not required because
> > -`LANDLOCK_ACCESS_FS_REFER` is not allowed by any rule.
> > +ABI version.  In this example, this is not required because all of the requested
> > +``allowed_access`` rights are already available in ABI 1.
> 
> This fix is correct, but it should not be part of this series. FYI, I have a
> patch almost ready to fix some documentation style issues. Please remove
> this hunk for the next series. I'll deal with the merge conflicts if any.

Can you please clarify what part of it should not be part of this
series?

In this hunk, I've started using double backquote, but I've also
changed the meaning of the sentence slightly so that it is still
correct when the truncate right is introduced.

It is still correct that the backwards compatibility check is not
required because LANDLOCK_ACCESS_FS_REFER is not allowed by any rule.
But with the new truncate flag, LANDLOCK_ACCESS_FS_TRUNCATE may also
not be allowed by any rule so that we can skip this check.

Should I remove this hunk entirely?

Or maybe rather phrase it like

  It may also be required to create rules following the same logic as
  explained for the ruleset creation, by filtering access rights
  according to the Landlock ABI version. In this example, this is not
  required because `LANDLOCK_ACCESS_FS_REFER` and
  `LANDLOCK_ACCESS_FS_TRUNCATE` are not allowed by any rule.
 
?

> >   We now have a ruleset with one rule allowing read access to ``/usr`` while
> >   denying all other handled accesses for the filesystem.  The next step is to
> > @@ -251,6 +262,32 @@ To be allowed to use :manpage:`ptrace(2)` and related syscalls on a target
> >   process, a sandboxed process should have a subset of the target process rules,
> >   which means the tracee must be in a sub-domain of the tracer.
> > +Truncating files
> > +----------------
> > +
> > +The operations covered by `LANDLOCK_ACCESS_FS_WRITE_FILE` and
> 
> I investigated and in fact we should use double backquotes almost everywhere
> because it render the same as when using "%" in header files. Please change
> this for the next series. I'll do the same on the patch I just talk about.

Done. I'm changing double backquote style only in the hunks I touched
so that it'll be easier to merge.

> 
> 
> > +`LANDLOCK_ACCESS_FS_TRUNCATE` both change the contents of a file and sometimes
> > +overlap in non-intuitive ways.  It is recommended to always specify both of
> > +these together.
> > +
> > +A particularly surprising example is :manpage:`creat(2)`.  The name suggests
> > +that this system call requires the rights to create and write files.  However,
> > +it also requires the truncate right if an existing file under the same name is
> > +already present.
> > +
> > +It should also be noted that truncating files does not require the
> > +`LANDLOCK_ACCESS_FS_WRITE_FILE` right.  Apart from the :manpage:`truncate(2)`
> > +system call, this can also be done through :manpage:`open(2)` with the flags
> > +`O_RDONLY | O_TRUNC`.
> > +
> > +When opening a file, the availability of the `LANDLOCK_ACCESS_FS_TRUNCATE` right
> > +is associated with the newly created file descriptor and will be used for
> > +subsequent truncation attempts using :manpage:`ftruncate(2)`.  It is possible to
> > +have multiple open file descriptors for the same file, where one grants the
> > +right to truncate the file and the other does not.  It is also possible to pass
> > +such file descriptors between processes, keeping their Landlock properties, even
> > +when these processes don't have an enforced Landlock ruleset.
> 
> Good addition. Please do not use contractions ("don't").

Done, thanks.

> 
> 
> > +
> >   Compatibility
> >   =============
> > @@ -397,6 +434,15 @@ Starting with the Landlock ABI version 2, it is now possible to securely
> >   control renaming and linking thanks to the new `LANDLOCK_ACCESS_FS_REFER`
> >   access right.
> > +File truncation (ABI < 3)
> > +-------------------------
> > +
> > +File truncation could not be denied before the third Landlock ABI, so it is
> > +always allowed when using a kernel that only supports the first or second ABI.
> > +
> > +Starting with the Landlock ABI version 3, it is now possible to securely control
> > +truncation thanks to the new `LANDLOCK_ACCESS_FS_TRUNCATE` access right.

Changed backquote style here as well.

Thanks for the review!

—Günther

-- 
