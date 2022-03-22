Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16354E4942
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 23:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238253AbiCVWnJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 18:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236889AbiCVWnI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 18:43:08 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2E65BD12
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Mar 2022 15:41:40 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id q129so19034000oif.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Mar 2022 15:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HEQg0eIGwGGy7PpGy1QT39r4icNZYKU8XYDsqIK8MEo=;
        b=WjQK6LWvSPRm4oItSaTP3KQWI2i/rktQSvBtG3YzMucSkLebD5GyAAqfr2RF29lgH6
         lnQZfU9WmXhNtv+HhMJERNhMgeag63HgqJHrJuxeYkal7DosSOc6CNC6sX6dGtW5BFmH
         AI5GjeFHP71CYLdk2rkR4/MH41xzQGTx8jfjXKuRXOaz8rXHgP0/vyhkIQPPWCIeFrtE
         GmOOUOS+OjXpzfPhY8pw20xglFIVfvt+y0hUlsYxHmw9ZyGjt8GjguvPTn1Wgh1ZvzE5
         XJkP59kXnt9Nk5dR2XjZX3ACO7s5K12INhPWBTUHSnCxxQIzrgvCX2TSd9aXIOJ2w1On
         BkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HEQg0eIGwGGy7PpGy1QT39r4icNZYKU8XYDsqIK8MEo=;
        b=uzjsZx/8CP5m8kRqfPLipzuB3vnsroCOei6olIcJfayHNgqsfSf9F1ImhKdW0ENy1+
         kzGgRmM3lRkEsMD06hXhYGRJfoFVlvnUwj1mur6WS96YqsnZxjFPCkesV6ORUrczYjnb
         CFFtDTLVFmZPbqoru+UtjIo4qBaNgDFHvKOPTA7W1ZkvYzXGmbLTsKgkEG4mrgeUUFQp
         K+B1ChQQtE/dsgAfF3N6xhCZYmMzFYwguXoR7fdxjburzP7YFc+btSsnvi4Nks6AEPG0
         C/ezH8uEr4c0Mcge1D/BvnhZ99PrLqsMmf+iEFZWMoHHY2LfduvmdHMsRlNMXEuNB0ca
         s2WQ==
X-Gm-Message-State: AOAM5304dSbvoGoIBmAiR5XE+/GylzKIAQG4XRk8SrXrABMxO/OM2139
        IGmu1EpwQkmwpphxqb+qoaYrgXRXC47O14D8LLI=
X-Google-Smtp-Source: ABdhPJyfMifeHdylVS0avluM+oj2A3TiLGM84y54zrr0W4JsEY0sapqA5cP/gfy6DMSaBH0ObCzwbgGlRMVEiIJi36g=
X-Received: by 2002:a05:6808:23c1:b0:2da:30fd:34d9 with SMTP id
 bq1-20020a05680823c100b002da30fd34d9mr3282226oib.203.1647988900195; Tue, 22
 Mar 2022 15:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220319001635.4097742-1-khazhy@google.com> <ea2afc67b92f33dbf406c3ebf49a0da9c6ec1e5b.camel@hammerspace.com>
 <CAOQ4uxgTJdcO-xZbtTSUkjD2g0vSHr=PLFc6-T6RgO0u5DS=0g@mail.gmail.com>
 <20220321112310.vpr7oxro2xkz5llh@quack3.lan> <CAOQ4uxiLXqmAC=769ufLA2dKKfHxm=c_8B0N2y4c-aZ5Qci2hg@mail.gmail.com>
 <20220321145111.qz3bngofoi5r5cmh@quack3.lan>
In-Reply-To: <20220321145111.qz3bngofoi5r5cmh@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 23 Mar 2022 00:41:28 +0200
Message-ID: <CAOQ4uxgOpfezQ4ydjP4SPA8-7x9xSXjTmTyZOYQE3d24c2Zf7Q@mail.gmail.com>
Subject: Re: [PATCH RFC] nfsd: avoid recursive locking through fsnotify
To:     Jan Kara <jack@suse.cz>
Cc:     "khazhy@google.com" <khazhy@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
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

> > > So the cleanest solution I currently see is
> > > to come up with helpers like "fsnotify_lock_group() &
> > > fsnotify_unlock_group()" which will lock/unlock mark_mutex and also do
> > > memalloc_nofs_save / restore magic.
> > >
> >
> > Sounds good. Won't this cause a regression - more failures to setup new mark
> > under memory pressure?
>
> Well, yes, the chances of hitting ENOMEM under heavy memory pressure are
> higher. But I don't think that much memory is consumed by connectors or
> marks that the reduced chances for direct reclaim would really
> substantially matter for the system as a whole.
>
> > Should we maintain a flag in the group FSNOTIFY_GROUP_SHRINKABLE?
> > and set NOFS state only in that case, so at least we don't cause regression
> > for existing applications?
>
> So that's a possibility I've left in my sleeve ;). We could do it but then
> we'd also have to tell lockdep that there are two kinds of mark_mutex locks
> so that it does not complain about possible reclaim deadlocks. Doable but
> at this point I didn't consider it worth it unless someone comes with a bug
> report from a real user scenario.

Are you sure about that?
Note that fsnotify_destroy_mark() and friends already use lockdep class
SINGLE_DEPTH_NESTING, so I think the lockdep annotation already
assumes that deadlock from direct reclaim cannot happen and it is that
assumption that was nearly broken by evictable inode marks.

IIUC that means that we only need to wrap the fanotify allocations
with GFP_NOFS (technically only after the first evictable mark)?

Thanks,
Amir.
