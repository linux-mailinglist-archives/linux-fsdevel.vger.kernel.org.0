Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A4D399651
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 01:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhFBXZu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 19:25:50 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:40653 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhFBXZt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 19:25:49 -0400
Received: by mail-ot1-f54.google.com with SMTP id c31-20020a056830349fb02903a5bfa6138bso4034271otu.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Jun 2021 16:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NWXfOWB2ZcUoziLC2rsM6+AWebQeH0STAUDFqx6ZI84=;
        b=qgSswxigcNOrr2ZMNR8Uj2NB8i7JEi7f/0mfyEP0UOlTnuEMuu1/d+SWh8AD0DeMNf
         LiU69e1Sl+HGQw8xd17EXIkXIG7dfZpwgtALqnrZtvHJwNL0O1wyGr3n9VMYKIGuFrlM
         +nP6B4MWh/aAnXi4vY5APg1X/MMJ4KA8gAOu1awWf+mcxoW5BgYQ5IYXv56gZMbPoy8w
         tHd1WxutfII6lbPvMkF+f6/JR2mwNJ9CSVyPAdS89UaPT3+r4yyp0/jXFNlQUldtZ31J
         eaMhfNCsV1mydY4WRWuSgM1w4OIdyVzy1t7tUf9Z2Tv+TJCXUYKuO1dsIcVfUPfxQUHE
         1jSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NWXfOWB2ZcUoziLC2rsM6+AWebQeH0STAUDFqx6ZI84=;
        b=fWe4yCknNLTqQQ4UPp2NkIlqiAPzMV33CPo1TQ4yLKMtPkHP/xmx/bHa6KAfUWg2Bz
         9AB1Akr5o4W6LIJZI/1HX0o3AeeIFreQw74iZ+NPkwnXea5ZHuHtEF1w5wSquZ5Pml1W
         wfi54wYLSg4og2nq3inrZLqI3s4U6bjwmwyiCcPNhaJ3S2vbgXzmEsVozKeHKiaRWBfX
         j0WGKUNymcU5rwyXZ961onGX+pubAMw5zaMDauIR1SEsgjML8bFNDS/bNtCzxp3NwAUW
         lurdBHqMBOiSkNF3mW95309p/lejpdrm/vxoIZ4+ugDy52cKvzynVQ8RQyKhTfhsFZ5H
         q4Dw==
X-Gm-Message-State: AOAM531ff+ji+B+mP4DHvvxNZ/0vl7AbIlGw8TYLjfRO/FJyBTrv7BpL
        6WlPcwwAXSQRPv1TiGEoclsDYKXdBaIXmE+wuiwMmg==
X-Google-Smtp-Source: ABdhPJx7wYc6+kS658MCpIv4PAwdEIqryfutuR0j19Xo+t9HH4OQ3OJZIwxSQlDk5/DV95gV0+8Tq42zmpoW/H8UvhI=
X-Received: by 2002:a9d:5e8c:: with SMTP id f12mr27745872otl.18.1622676169637;
 Wed, 02 Jun 2021 16:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210602041539.123097-1-drosen@google.com> <20210602041539.123097-3-drosen@google.com>
 <YLfh9pv1fDT+Q3pe@sol.localdomain>
In-Reply-To: <YLfh9pv1fDT+Q3pe@sol.localdomain>
From:   Daniel Rosenberg <drosen@google.com>
Date:   Wed, 2 Jun 2021 16:22:38 -0700
Message-ID: <CA+PiJmR1vWN7ij7ak4q=C0Wxa++t=SCnEFh_iDt7QVOAZy-VFw@mail.gmail.com>
Subject: Re: [PATCH 2/2] f2fs: Advertise encrypted casefolding in sysfs
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 2, 2021 at 12:54 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Wed, Jun 02, 2021 at 04:15:39AM +0000, Daniel Rosenberg wrote:
> > +#ifdef CONFIG_UNICODE
> > +F2FS_FEATURE_RO_ATTR(encrypted_casefold, FEAT_ENCRYPTED_CASEFOLD);
> > +#endif
>
> Shouldn't it be defined(CONFIG_UNICODE) && defined(CONFIG_FS_ENCRYPTION)?
>
> >  #endif
> >  #ifdef CONFIG_BLK_DEV_ZONED
> >  F2FS_FEATURE_RO_ATTR(block_zoned, FEAT_BLKZONED);
> > @@ -815,6 +823,9 @@ static struct attribute *f2fs_feat_attrs[] = {
> >  #ifdef CONFIG_FS_ENCRYPTION
> >       ATTR_LIST(encryption),
> >       ATTR_LIST(test_dummy_encryption_v2),
> > +#ifdef CONFIG_UNICODE
> > +     ATTR_LIST(encrypted_casefold),
> > +#endif
>
> Likewise here.
>
> - Eric

Those are already within an #ifdef CONFIG_FS_ENCRYPTION, so it should
be covered already.
Should I send a v2 set with the

Fixes: 7ad08a58bf67 ("f2fs: Handle casefolding with Encryption")
Cc: stable@vger.kernel.org # v5.11+

appended?

-Daniel
