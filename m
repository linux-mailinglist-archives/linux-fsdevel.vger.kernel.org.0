Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC905E7997
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 13:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiIWLaO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 07:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiIWLaM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 07:30:12 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480EED4A9E;
        Fri, 23 Sep 2022 04:30:11 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id x21so10521654edd.11;
        Fri, 23 Sep 2022 04:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=wLIQK9681VVUjetrYqLs0ipg37RcyeD0aT+jCMfoVj0=;
        b=BzakHYLzymLeLlnIL1OSUDJ+ED9JwYWu7c/BnWNyhWlEjGjtq/izedWEe5WxvrZMFj
         IlT774PlyHurBAo/VIKQmNaR/Y5yyGYSvtEfAItSo+jNCXu8PpHaIO+klj6rdWZpCQ+6
         U2jt+NJB9saSz+2Glu/74n/LfKcPAqlVYaizSQQQDRi6Xgu9rPjcde1aF4jGDs4YFSaW
         DK2eZlZ8UHh0FqUwD+/dw6WWrIk4WINvqK1Dx2X9wfLA0XrTDMLhurbr8aYrz6iGHY2K
         dpa758LgiaC2EisMcSjiF1b8C/beoP0Lplqg1P64S88oUg75lCcsMo+W3VU359iJcsCY
         YJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=wLIQK9681VVUjetrYqLs0ipg37RcyeD0aT+jCMfoVj0=;
        b=5KWXxDyPrARrOYngvnpwfObOqK1oMeQWOTRE1mpsw/klcXMgzGMKqGAeRLdjql26/N
         j4DOVbPMk1bXq2N8fZc7EEMSHW2CMaISPW9G4LT2SL1Vs5PXcdeCxj+Iyj0kEPgKzhIs
         5z+hn5S7r1dT9O9VYqw+gfgErubj4vbjHRQLdrcFakyPfonH6rmE3RXZS0L+wHnb9Hp+
         jDro5tGVXPVFxJHoby6rUeIlTaCT4lMs5RvtfNxzB/1rqXr8bgOGcvGcENQe3dJpMCE8
         RubdOrux6ZD88C52yydWqPhJithLY1d/5HilF0euOAlovVZ+Oc5df7W0sFL715OYCFux
         yl/w==
X-Gm-Message-State: ACrzQf1FKdupfjnYQ4OZBcMwq+Bzb1YdBNK8ffB1CRzAMnMMfnUlfgAo
        63zry3vDBMaw5TO14KNpxEw=
X-Google-Smtp-Source: AMsMyM5sm0UM4U3r4LqhwevMMnlo098wtMRwFAQtRzfxAFUF8CqwtDSEkekfERAOf5P6SclxK4UwuA==
X-Received: by 2002:a05:6402:50d1:b0:452:899e:77c with SMTP id h17-20020a05640250d100b00452899e077cmr7982645edb.0.1663932609653;
        Fri, 23 Sep 2022 04:30:09 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id 5-20020a170906310500b0078238c1c182sm2578062ejx.222.2022.09.23.04.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 04:30:09 -0700 (PDT)
Date:   Fri, 23 Sep 2022 13:30:07 +0200
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
Message-ID: <Yy2Yv5ZmF4ZOAAn3@nuc>
References: <20220908195805.128252-1-gnoack3000@gmail.com>
 <20220908195805.128252-6-gnoack3000@gmail.com>
 <7f6e5b08-379d-2670-2869-3a0e3843b222@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7f6e5b08-379d-2670-2869-3a0e3843b222@digikod.net>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 12, 2022 at 09:15:06PM +0200, Mickaël Salaün wrote:
> 
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
> 
> I think it would be easier to understand to explicitly check for abi < 0
> in a dedicated block as in the sample, instead of case -1, and return 0
> (instead of 1) with a comment to inform that Landlock is not handled but
> it is OK (expected error).

Done.

> 
> 
> > +    case 1:
> > +            /* Removes LANDLOCK_ACCESS_FS_REFER for ABI < 2 */
> > +            ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_REFER;
> > +            __attribute__((fallthrough));
> > +    case 2:
> > +            /* Removes LANDLOCK_ACCESS_FS_TRUNCATE for ABI < 3 */
> > +            ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_TRUNCATE;
> >       }
> >   This enables to create an inclusive ruleset that will contain our rules.

-- 
