Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3B65F846B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Oct 2022 10:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiJHItx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Oct 2022 04:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiJHItm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Oct 2022 04:49:42 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F3EEA;
        Sat,  8 Oct 2022 01:49:38 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id s2so9864317edd.2;
        Sat, 08 Oct 2022 01:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ffUY4ExQOOFTvskz6qhPEsEN8497Tuw4sv0ZJSQHczY=;
        b=R3WJpCR+A/cxjcdvKLICbOMesbwk+RZDoI5TVpdDTRVNO3uQzWVx5FDeCSXBaHMCS+
         3Igpi4CY+YAZXdZjJGtfGXcmhVXRcu6Z2wM8vF8Rxevht3Hk1AUEwQXlFnu4UxLBcRv1
         kmV7K0sk0RT2AuL4NjfnSvpy6NNXilnRFAyTULgsn/vuBPZITw7i6KwmolQp1yxrzAgo
         6nBBQPg0jNmz8fcR9m1iKeGphXLNA3S1bmzdl+Tv+Ece1HIMXrdX1KeHF78a2BkRHAwM
         fJY64ObBeFe/yhwq/38RKJRPdk54yrUzS1xHvPVD/XMzAMaM/WvKLBQomBNpHPp4hSsN
         YrLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ffUY4ExQOOFTvskz6qhPEsEN8497Tuw4sv0ZJSQHczY=;
        b=KyJUINHFvCNWPexTO14UiKfmk93f5WxBSqsu3ntoo1xCV0Fl/BLYnH2k0yD4GaAIGx
         4tMZ54N3gbgsQxusqXkz8F8QFC124UkmnCdckCObsWh6hs83Hqt0y2tv4LdWEekk2uOU
         f9qhmSoupk0L/CA6yUplPzwTpO1l3Vv0jhLbVH2STOw9prH/6EMebv7PECVBRCOSJJ7V
         DyWfm1N3oJm32YgmK07egScovsf+nKfjncj6ImT7dwTu7Xsd/mx6kOu657KSA0FmfIW/
         VpJpa/UxP5FTwyE1MH96QpSyR0o3yEn20zf6lLCGM+KDLZgni0KhVAHqklS+mG0SiHFy
         EGqA==
X-Gm-Message-State: ACrzQf1FvL6CS0+mv5uyuXV2OSrrVGIqB+aP+bWuunSttbI5z1BWpStn
        pgxiNIXZg2yaLcexg5yi8X0=
X-Google-Smtp-Source: AMsMyM5Ny/0guSNDQPY0d5A726Ncrw8A8BgI1fUqwHKPPHyZQCGrjH7hfQY+per0DK83W5C22ccI2A==
X-Received: by 2002:a50:c31b:0:b0:458:cc93:8000 with SMTP id a27-20020a50c31b000000b00458cc938000mr8428472edb.264.1665218977323;
        Sat, 08 Oct 2022 01:49:37 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id s22-20020a05640217d600b0045af1e70137sm1282356edy.14.2022.10.08.01.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 01:49:37 -0700 (PDT)
Date:   Sat, 8 Oct 2022 10:49:35 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Subject: Re: [PATCH v8 9/9] landlock: Document Landlock's file truncation
 support
Message-ID: <Y0E5n9JFaf1q2cmz@nuc>
References: <20221001154908.49665-1-gnoack3000@gmail.com>
 <20221001154908.49665-10-gnoack3000@gmail.com>
 <9c340d63-c90b-6049-ac4d-1415a93a5fc6@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c340d63-c90b-6049-ac4d-1415a93a5fc6@digikod.net>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 05, 2022 at 08:57:37PM +0200, Mickaël Salaün wrote:
> 
> On 01/10/2022 17:49, Günther Noack wrote:
> > Use the LANDLOCK_ACCESS_FS_TRUNCATE flag in the tutorial.
> > 
> > Adapt the backwards compatibility example and discussion to remove the
> > truncation flag where needed.
> > 
> > Point out potential surprising behaviour related to truncate.
> > 
> > Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> > ---
> >   Documentation/userspace-api/landlock.rst | 66 +++++++++++++++++++++---
> >   1 file changed, 59 insertions(+), 7 deletions(-)
> > 
> > diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> > index b8ea59493964..44d6f598b63d 100644
> > --- a/Documentation/userspace-api/landlock.rst
> > +++ b/Documentation/userspace-api/landlock.rst
> > @@ -8,7 +8,7 @@ Landlock: unprivileged access control
> >   =====================================
> >   :Author: Mickaël Salaün
> > -:Date: May 2022
> > +:Date: October 2022
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
> > @@ -69,16 +70,27 @@ should try to protect users as much as possible whatever the kernel they are
> >   using.  To avoid binary enforcement (i.e. either all security features or
> >   none), we can leverage a dedicated Landlock command to get the current version
> >   of the Landlock ABI and adapt the handled accesses.  Let's check if we should
> > -remove the `LANDLOCK_ACCESS_FS_REFER` access right which is only supported
> > -starting with the second version of the ABI.
> > +remove the ``LANDLOCK_ACCESS_FS_REFER`` or ``LANDLOCK_ACCESS_FS_TRUNCATE``
> > +access rights, which are only supported starting with the second and third
> > +version of the ABI.
> >   .. code-block:: c
> >       int abi;
> >       abi = landlock_create_ruleset(NULL, 0, LANDLOCK_CREATE_RULESET_VERSION);
> > -    if (abi < 2) {
> > +    if (abi < 0) {
> > +        perror("The running kernel does not enable to use Landlock");
> 
> Please insert in a dedicated line this comment: /* Degrades gracefully if
> Landlock is not handled. */

Done, moved the comment to a dedicated line and added the "s".

> > +        return 0;  /* Degrade gracefully if Landlock is not handled. */
> > +    }
> > +    switch (abi) {
> > +    case 1:
> > +        /* Removes LANDLOCK_ACCESS_FS_REFER for ABI < 2 */
> >           ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_REFER;
> > +        __attribute__((fallthrough));
> > +    case 2:
> > +        /* Removes LANDLOCK_ACCESS_FS_TRUNCATE for ABI < 3 */
> > +        ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_TRUNCATE;
> >       }
> >   This enables to create an inclusive ruleset that will contain our rules.
> > @@ -127,8 +139,8 @@ descriptor.
> >   It may also be required to create rules following the same logic as explained
> >   for the ruleset creation, by filtering access rights according to the Landlock
> > -ABI version.  In this example, this is not required because
> > -`LANDLOCK_ACCESS_FS_REFER` is not allowed by any rule.
> > +ABI version.  In this example, this is not required because all of the requested
> > +``allowed_access`` rights are already available in ABI 1.
> >   We now have a ruleset with one rule allowing read access to ``/usr`` while
> >   denying all other handled accesses for the filesystem.  The next step is to
> > @@ -251,6 +263,37 @@ To be allowed to use :manpage:`ptrace(2)` and related syscalls on a target
> >   process, a sandboxed process should have a subset of the target process rules,
> >   which means the tracee must be in a sub-domain of the tracer.
> > +Truncating files
> > +----------------
> > +
> > +The operations covered by ``LANDLOCK_ACCESS_FS_WRITE_FILE`` and
> > +``LANDLOCK_ACCESS_FS_TRUNCATE`` both change the contents of a file and sometimes
> > +overlap in non-intuitive ways.  It is recommended to always specify both of
> > +these together.
> > +
> > +A particularly surprising example is :manpage:`creat(2)`.  The name suggests
> > +that this system call requires the rights to create and write files.  However,
> > +it also requires the truncate right if an existing file under the same name is
> > +already present.
> > +
> > +It should also be noted that truncating files does not require the
> > +``LANDLOCK_ACCESS_FS_WRITE_FILE`` right.  Apart from the :manpage:`truncate(2)`
> > +system call, this can also be done through :manpage:`open(2)` with the flags
> > +``O_RDONLY | O_TRUNC``.
> > +
> > +When opening a file, the availability of the ``LANDLOCK_ACCESS_FS_TRUNCATE``
> > +right is associated with the newly created file descriptor and will be used for
> > +subsequent truncation attempts using :manpage:`ftruncate(2)`.  The behavior is
> > +similar to opening a file for reading or writing, where permissions are checked
> > +during :manpage:`open(2)`, but not during the subsequent :manpage:`read(2)` and
> > +:manpage:`write(2)` calls.
> > +
> > +As a consequence, it is possible to have multiple open file descriptors for the
> > +same file, where one grants the right to truncate the file and the other does
> > +not.  It is also possible to pass such file descriptors between processes,
> > +keeping their Landlock properties, even when these processes do not have an
> > +enforced Landlock ruleset.
> > +
> >   Compatibility
> >   =============
> > @@ -397,6 +440,15 @@ Starting with the Landlock ABI version 2, it is now possible to securely
> >   control renaming and linking thanks to the new `LANDLOCK_ACCESS_FS_REFER`
> >   access right.
> > +File truncation (ABI < 3)
> > +-------------------------
> > +
> > +File truncation could not be denied before the third Landlock ABI, so it is
> > +always allowed when using a kernel that only supports the first or second ABI.
> > +
> > +Starting with the Landlock ABI version 3, it is now possible to securely control
> > +truncation thanks to the new ``LANDLOCK_ACCESS_FS_TRUNCATE`` access right.
> > +
> >   .. _kernel_support:
> >   Kernel support

-- 
