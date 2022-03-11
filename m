Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9A64D596A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 05:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346162AbiCKELL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 23:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbiCKELK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 23:11:10 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C26986FF;
        Thu, 10 Mar 2022 20:10:08 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id n7so8157799oif.5;
        Thu, 10 Mar 2022 20:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9QeKB4cZIGNALzfAGtAHD8EFO6aEieNDe1cqjoQ6gsM=;
        b=W9vUjPbowBxn+x7F9t0T9ph91PQtdPdrKRG92teEt6N37XUEPsuq7+Semk0Sq7eBL6
         dcYQ9Tv22KHCDJpJTZArvmF8RQJMWhrnNFrlH0Z9uAj420D8GZTtOsl5n/GtRwmZJ8IA
         76XZx0gnVjqsOEJfE51RvM5322G6zPl57koGYA+BKcBlE7vuRS9sF5hcoMo88FJDRAK5
         +kwRe4M+oG+gEgYFREXYAIe783yanNbzuJWyEOA9cbY052rFHSqbNMsxjUA23QLzXa3/
         qwh29b/LmPrDFBeRC3n+EEkGfabc7nyxk2erQfzTI/vhMLMU2KsmYvLjrtBhha2kRRP/
         ijHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9QeKB4cZIGNALzfAGtAHD8EFO6aEieNDe1cqjoQ6gsM=;
        b=NZW/LNPYvMyDD0iILIXVPwu3OT8GGJdCO4UJtixsPhNlztP4E6LlKBS9jgeqz3M2AM
         tCweRqyvOVRbGq27iZiMFyj6xf9hBTs5S8ENRkCBDVeR/VMIqtbUWgyS4EBOl+dxKQyv
         oXJoU/QrLAbMqXsBh7gJf5UONGHNHOuGO/1Remqi/V4Zvxp7xxViNvgu3GjM8sVDaVUU
         PtWGGdBIa8dDl+hhhKskXt3wLUTunnprJFb2+bPoGJoEASC0r2yOWUklCuMwXl180Aa2
         mAVzGzGSy3L9MNl1Qu+Xsy9+pIZUtR0RVos1mXFaURus2XzrenovKsHDXTNTGwlDlI5i
         xZbA==
X-Gm-Message-State: AOAM533+F5d23lhlFDMU4ZheXcb+Qdzb8jLj9KFs0TNCPnm0zsEmPZP0
        +npyH6o6yAYkawv1QWEMDsCi5w59RZb1LbvWl9z6yTm6sBQ=
X-Google-Smtp-Source: ABdhPJx+9DTvJp/p1u4f9zeF1IL/TTETZ9pXW0fHuKtmLByfNy/fessGS5yeAZyPOoS/6x3jVT2neAlc+D3agDdooSw=
X-Received: by 2002:a05:6808:23c1:b0:2da:30fd:34d9 with SMTP id
 bq1-20020a05680823c100b002da30fd34d9mr8741863oib.203.1646971807529; Thu, 10
 Mar 2022 20:10:07 -0800 (PST)
MIME-Version: 1.0
References: <20211117015806.2192263-1-dvander@google.com> <CAOQ4uxjjapFeOAFGLmsXObdgFVYLfNer-rnnee1RR+joxK3xYg@mail.gmail.com>
 <Yao51m9EXszPsxNN@redhat.com> <CAOQ4uxjk4piLyx67Ena-FfypDVWzRqVN0xmFUXXPYa+SC4Q-vQ@mail.gmail.com>
 <YapjNRrjpDu2a5qQ@redhat.com> <CAHC9VhQTUgBRBEz_wFX8daSA70nGJCJLXj8Yvcqr5+DHcfDmwA@mail.gmail.com>
 <CA+FmFJA-r+JgMqObNCvE_X+L6jxWtDrczM9Jh0L38Fq-6mnbbA@mail.gmail.com>
 <CAHC9VhRer7UWdZyizWO4VuxrgQDnLCOyj8LO7P6T5BGjd=s9zQ@mail.gmail.com> <CAHC9VhQkLSBGQ-F5Oi9p3G6L7Bf_jQMWAxug_G4bSOJ0_cYXxQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQkLSBGQ-F5Oi9p3G6L7Bf_jQMWAxug_G4bSOJ0_cYXxQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 11 Mar 2022 06:09:56 +0200
Message-ID: <CAOQ4uxhfU+LGunL3cweorPPdoCXCZU0xMtF=MekOAe-F-68t_Q@mail.gmail.com>
Subject: Re: [PATCH v19 0/4] overlayfs override_creds=off & nested get xattr fix
To:     Paul Moore <paul@paul-moore.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Anderson <dvander@google.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        John Stultz <john.stultz@linaro.org>,
        linux-doc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        kernel-team <kernel-team@android.com>, selinux@vger.kernel.org,
        paulmoore@microsoft.com, luca.boccassi@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 11, 2022 at 12:11 AM Paul Moore <paul@paul-moore.com> wrote:
>
> On Wed, Mar 9, 2022 at 4:13 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Tue, Mar 1, 2022 at 12:05 AM David Anderson <dvander@google.com> wro=
te:
> > > On Mon, Feb 28, 2022 at 5:09 PM Paul Moore <paul@paul-moore.com> wrot=
e:
>
> ...
>
> > >> This patchset may not have been The Answer, but surely there is
> > >> something we can do to support this use-case.
> > >
> > > Yup exactly, and we still need patches 3 & 4 to deal with this. My cu=
rrent plan is to try and rework our sepolicy (we have some ideas on how it =
could be made compatible with how overlayfs works). If that doesn't pan out=
 we'll revisit these patches and think harder about how to deal with the co=
herency issues.
> >
> > Can you elaborate a bit more on the coherency issues?  Is this the dir
> > cache issue that is alluded to in the patchset?  Anything else that
> > has come up on review?
> >
> > Before I start looking at the dir cache in any detail, did you have
> > any thoughts on how to resolve the problems that have arisen?
>
> David, Vivek, Amir, Miklos, or anyone for that matter, can you please
> go into more detail on the cache issues?  I *think* I may have found a
> potential solution for an issue that could arise when the credential
> override is not in place, but I'm not certain it's the only issue :)
>

Hi Paul,

In this thread I claimed that the authors of the patches did not present
a security model for overlayfs, such as the one currently in overlayfs.rst.
If we had a model we could have debated its correctness and review its
implementation.

As a proof that there is no solid model, I gave an *example* regarding
the overlay readdir cache.

When listing a merged dir, meaning, a directory containing entries from
several overlay layers, ovl_permission() is called to check user's permissi=
on,
but ovl_permission() does not currently check permissions to read all layer=
s,
because that is not the current overlayfs model.

Overlayfs has a readdir cache, so without override_cred, a user with high
credentials can populate the readdir cache and then a user will fewer
credentials, not enough to access the lower layers, but enough to access
the upper most layer, will pass ovl_permission() check and be allowed to
read from readdir cache.

This specific problem can be solved in several ways - disable readdir
cache with override_cred=3Doff, check all layers in ovl_permission().
That's not my point. My point is that I provided a proof that the current
model of override_cred=3Doff is flawed and it is up to the authors of the
patch to fix the model and provide the analysis of overlayfs code to
prove the model's correctness.

The core of the matter is there is no easy way to "merge" the permissions
from all layers into a single permission blob that could be checked once.

Maybe the example I gave is the only flaw in the model, maybe not
I am not sure. I will be happy to help you in review of a model and the
solution that you may have found.

Thanks,
Amir.
