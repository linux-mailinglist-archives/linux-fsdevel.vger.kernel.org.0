Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E4A518816
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 17:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238024AbiECPSS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 11:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbiECPSQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 11:18:16 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB373A714;
        Tue,  3 May 2022 08:14:43 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id k2so7193634qtp.1;
        Tue, 03 May 2022 08:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vuqvJ8A4FAPCd0ZxLOVcJFiWq1cjGCU3yw1SfcBfSUY=;
        b=kzKzv3NsXMvjvu1MlZgBFVmD91rFPoTzjrJ2cUZ3tIWOgXoc+s+4GrxtRxTSr1Mxab
         ApzybxelwdHze5Xmq6vH0KQCKguGSNdCYOj2bOjeFly7Q1IjNoy9Yb+BCB8f1huhcAqC
         k40vKwB4nKAqQM4+ekc9iHBrbxyN7MXBSd+W4pI9sxXh97alepbvUMQqOTaslybLp4+D
         hRFtry5y3FiAB63k3qa88Cw+6+/mn84vG/epS8gnCHc66XJViQqT+gXDoZjeKk/2qnzb
         2oJBHpsOlNvkhYFuD+EcItAgPN5PWZ9SomdTJPbVu1yH6RLDx0B8/8kogRLq1WnIc+w7
         kMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vuqvJ8A4FAPCd0ZxLOVcJFiWq1cjGCU3yw1SfcBfSUY=;
        b=JOLFYkBq4xGdHT33N3/d2T4n+UYnLaUpFANKqTfKWlnqpc7rAdfylqvwRq+rKP+FVO
         YjSSpSsRKcZLLHGudqp3mamuCBNuGH1A4fvEJ9ZP3BdSNuT29/X13eH8jUQeW1X3myAH
         1aa4655GJpaRncmSaRxxjstKmSG3UiX461KCTvCFpGv4Q+qnsy31izGaP5fcgm/T6cdv
         BuEcNvQs8kmTXgnj2M+PuQgaq79V8Moe/ocfH1kaVBuur0BbrQJ0NpOoXuKCyDHYmU0/
         uuqomCHCL9hhGouFfskIzMc2K4SFbJ7JgYrslV8bWGm1eWvIs/aflUzSSY7kR9LHETYv
         itig==
X-Gm-Message-State: AOAM533km2AkrsC7LRJwFXXJctVMe0PBsiNY4SNZ6BrbHYGTOhxlKLIm
        My18WFfYDNti9H9y7iH/vBceg4zaj0EF7kGPlxQ=
X-Google-Smtp-Source: ABdhPJwkmrc8+A8LLLRMtq2qm8/vNyS036IFhaV1AfKVJA/p+3tLccnsxkgGbgL2IHademLNBz1XLf8TdlEeJeOhD/U=
X-Received: by 2002:a05:622a:c9:b0:2f3:b100:648c with SMTP id
 p9-20020a05622a00c900b002f3b100648cmr1883202qtw.157.1651590883121; Tue, 03
 May 2022 08:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com> <CAOQ4uxim+JmFbXPQcasELDEgRDP-spdPtJrLuhvSiyxErSUkvw@mail.gmail.com>
 <YnFB/ct2Q/yYBnm8@kroah.com> <CAJfpegtZjRca5QPm2QgPtPG0-BJ=15Vtd48OTnRnr5G7ggAtmA@mail.gmail.com>
In-Reply-To: <CAJfpegtZjRca5QPm2QgPtPG0-BJ=15Vtd48OTnRnr5G7ggAtmA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 3 May 2022 18:14:31 +0300
Message-ID: <CAOQ4uxiBsQXbxQJf7Az3T+gq7Oph4joykqMB0EP87U=bj4LvSg@mail.gmail.com>
Subject: Re: [RFC PATCH] getting misc stats/attributes via xattr API
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Karel Zak <kzak@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
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

On Tue, May 3, 2022 at 6:04 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Tue, 3 May 2022 at 16:53, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, May 03, 2022 at 05:39:46PM +0300, Amir Goldstein wrote:
>
> > > It should be noted that while this API mandates text keys,
> > > it does not mandate text values, so for example, sb iostats could be
> > > exported as text or as binary struct, or as individual text/binary records or
> > > all of the above.
> >
> > Ugh, no, that would be a total mess.  Don't go exporting random binary
> > structs depending on the file, that's going to be completely
> > unmaintainable.  As it is, this is going to be hard enough with random
> > text fields.
> >
> > As for this format, it needs to be required to be documented in
> > Documentation/ABI/ for each entry and key type so that we have a chance
> > of knowing what is going on and tracking how things are working and
> > validating stuff.
>
> My preference would be a single text value for each key.
>
> Contents of ":mnt:info" contradicts that, but mountinfo has a long
> established, well documented format, and nothing prevents exporting
> individual attributes with separate names as well (the getvalues(2)
> patch did exactly that).
>

Right, the fun is that ":mnt:info" and ":mnt:info:" can co-exist.

Thanks,
Amir.
