Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBF55B27E3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 22:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiIHUub (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 16:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIHUua (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 16:50:30 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CF0B0B18;
        Thu,  8 Sep 2022 13:50:28 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id l14so17397247eja.7;
        Thu, 08 Sep 2022 13:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=nhuHvzNlc2TwxMhhsYaDQXiPo9fazG9+H8G6SCSTy2k=;
        b=LxQC+BbtpvQJM7kNytDxCv2d5woStEJnTZMz+oCVZmcjtuHNoYqUlZUO5aetkRXU0N
         P2ZVEiJz3lA47q7AqGI+OvqzALao8yYwrSM5lGBRmrykyopVQv1WPW5ZDqMfPSJUrKYJ
         O9yPYoRlB4utNIWWOrUDuquHCBTMdSTo7MXWe5KjxsqxgBd/8i085arQkDo77d8/GD4X
         ehL4efFLOspcwDccu7+ITmCszDo3DZP0XZ3M038c0FO7wmWbxfKCQQCXmhyBL7WgvrBU
         EI43o3I11ciR6hEzXWNdmfFom0redx97Aq3UZitNSWtSenIu0bYqjTLKtL2qcUTAB/+7
         IiwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nhuHvzNlc2TwxMhhsYaDQXiPo9fazG9+H8G6SCSTy2k=;
        b=koi+UHz+Cu0NgZQC2GhmWYUCgcjyp3s4PF3a/mf+SgSp+sZd7lErSFMVKFwOzaIoLR
         g8jDaLYd4SzZDKgmGoQs4K4+EwC4f5TG6hU8HC2S54jRD9mZhaT9Xdjk4/Ks4oBf5bjG
         ExvkqddGiP520zO0d470/pGggT0hubC6VpApv5/1UMHIUJ0mel3+2qkAa0fuVVE7mb4v
         aoOUXA2o0soWQp5KfMKumqpWPXOngHZZwQJDQsSlB+Wd0sekxgZJWDWpI2CTPwG6Pymm
         L1A+6/WipOPIHyXbd9JpXEcbgvh0KvKGexN/GHiJbkVkh+SnqkiCxlV+vkOdMHQ9YRe0
         /oMg==
X-Gm-Message-State: ACgBeo3XRW3EOMKWf6rLKg5aYdPieZhzpgxLlx5iOX/e/s7Kl10Bt1o+
        ght1hg7TlJIYieNs8m5Vwek=
X-Google-Smtp-Source: AA6agR6DFz/WhqhwtdRUQkU7icsDIcxNT2P0FmKy0c3aSwpuOFJBLzbwPbnQclONzX+s+tQk+1tw4g==
X-Received: by 2002:a17:907:72cf:b0:741:48db:d304 with SMTP id du15-20020a17090772cf00b0074148dbd304mr7296016ejc.391.1662670227254;
        Thu, 08 Sep 2022 13:50:27 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id e9-20020a170906314900b0072f4f4dc038sm1670685eje.42.2022.09.08.13.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 13:50:26 -0700 (PDT)
Date:   Thu, 8 Sep 2022 22:50:24 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH v6 1/5] security: create file_truncate hook from
 path_truncate hook
Message-ID: <YxpVkKqrZhjh5Pn8@nuc>
References: <20220908195805.128252-1-gnoack3000@gmail.com>
 <20220908195805.128252-2-gnoack3000@gmail.com>
 <CAHC9VhSmjF1sYoP-Z8vj+O4=NPQMdw+L4=iFZtDbHzJg7ey6vA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhSmjF1sYoP-Z8vj+O4=NPQMdw+L4=iFZtDbHzJg7ey6vA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 08, 2022 at 04:09:06PM -0400, Paul Moore wrote:
> On Thu, Sep 8, 2022 at 3:58 PM Günther Noack <gnoack3000@gmail.com> wrote:
> >
> > Like path_truncate, the file_truncate hook also restricts file
> > truncation, but is called in the cases where truncation is attempted
> > on an already-opened file.
> >
> > This is required in a subsequent commit to handle ftruncate()
> > operations differently to truncate() operations.
> >
> > Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> > ---
> >  fs/namei.c                    |  6 +++---
> >  fs/open.c                     |  4 ++--
> >  include/linux/lsm_hook_defs.h |  1 +
> >  include/linux/security.h      |  6 ++++++
> >  security/apparmor/lsm.c       |  6 ++++++
> >  security/security.c           |  5 +++++
> >  security/tomoyo/tomoyo.c      | 13 +++++++++++++
> >  7 files changed, 36 insertions(+), 5 deletions(-)
>
> We need to get John and Tetsuo's ACKs on this patch, but in addition
> to that I have two small comments (below).

+CC: John Johansen and Tetsuo Handa -- this change is splitting up the
path_truncate LSM hook into a path_truncate and file_truncate variant,
one operating on the path as before, and one operating on a struct
file*. As a result, AppArmor and TOMOYO need to implement the
file-based hook as well and treat it the same as before by looking at
the file's ->f_path. Does this change seem reasonable to you?


> > diff --git a/fs/namei.c b/fs/namei.c
> > index 53b4bc094db2..52105873d1f8 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -53,8 +53,8 @@
> >   * The new code replaces the old recursive symlink resolution with
> >   * an iterative one (in case of non-nested symlink chains).  It does
> >   * this with calls to <fs>_follow_link().
> > - * As a side effect, dir_namei(), _namei() and follow_link() are now
> > - * replaced with a single function lookup_dentry() that can handle all
> > + * As a side effect, dir_namei(), _namei() and follow_link() are now
> > + * replaced with a single function lookup_dentry() that can handle all
>
> Since this patch(set) is likely to go in via the Landlock tree, it is
> very important to keep changes outside of security/landlock to a bare
> minimum of what is required both to reduce merge conflicts and
> highlight the significant changes.  This change doesn't appear
> necessary ... and I'm having a hard time spotting the difference in
> the lines.

Thanks for pointing this out, I fully agree!

Both edits that you flagged were unintentional, I should have double
checked this patch better. I'll address them in the next version.

(You can't see the difference here because my editor trimmed trailing
whitespace on save (*facepalm*) - I turned this off now.)


> > diff --git a/fs/open.c b/fs/open.c
> > index 8a813fa5ca56..0831433e493a 100644
> > --- a/fs/open.c
> > +++ b/fs/open.c
> > @@ -1271,7 +1271,7 @@ struct file *filp_open(const char *filename, int flags, umode_t mode)
> >  {
> >         struct filename *name = getname_kernel(filename);
> >         struct file *file = ERR_CAST(name);
> > -
> > +
>
> See my comment above about unnecessary changes.

Same here, I'm fixing that for the next version.

Thanks for the review,
Günther

--
