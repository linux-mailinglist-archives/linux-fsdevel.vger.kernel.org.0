Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDFD7939D8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 12:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238989AbjIFK2n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 06:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbjIFK2m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 06:28:42 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3888F10C8;
        Wed,  6 Sep 2023 03:28:39 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-411f5dd7912so23521711cf.3;
        Wed, 06 Sep 2023 03:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693996118; x=1694600918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unw3hN0Jsf7yZF3t4Yk9uPBU7tvhkv2SzT1b1nOos6s=;
        b=Lv3/GvHBA4mpo2NS7mu/J3LmnKt1yb2dU85dmp4b+gf05KtTitv7wCC0Lbr1/qF98R
         I11mf9NJOBZ3QrdX3r9KCUfJZg9sC5zd0usXIlZoXPJwzZuG7HzQ4DSLldyXmzMMFGh5
         UVfoJD9ww1gA79gKbb/D/xBjJN/rt5/aZyzFFPwBSNLKnXm6YvFcD714E4PCGKdNVWOX
         o9eY8VZcT0vb1uX4DXwCuE6kabQCrPvJqXJnv5UF2b0VNHQvK/ULZ8medCGyEOOZNAaE
         AWUFUYU14fEg8nxjv8fLSfs+WRh3nndRZPw792+jeYvyS0P6RqUoPX2w+fM+WxScIyh9
         U2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693996118; x=1694600918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=unw3hN0Jsf7yZF3t4Yk9uPBU7tvhkv2SzT1b1nOos6s=;
        b=HuI+c/YiMCIjdg0XI6XP8x5+LTgmDQ8au34q21OufcZlQp3pwTeBOymIdf0KGaLecj
         IJGVh3KZ2u0rfz39XmRmcdGE6KOnVks05APJ9x5RxOVupStzZnyMggJcqFJ+cSnrZyLt
         DgUiTFaa2DozJkjs4OTz4KFle/Wlih8NXXtuIOeLNw6DI+D2TIWPSa4UqByy60ioVE58
         npTmewN9wlfKoxXz9AemCYcTrorD6ZBAmClbSs79Rs03o1H75kSiuOn/VI9tg6+RPWB5
         kppYvgHuNcHYeZOJ3trAebHDZjyhLf0N68tUZf1OoNTQ2ZVK30QvIyEziHljzt8FGuVS
         a3IQ==
X-Gm-Message-State: AOJu0YwLEKcA/NRlM317QnDq591U10QIyedseappljlntjSBDEolWeI4
        nwWPMbuJ9gKgySWbGp1Tmn7DthYhsixLLlAspdw=
X-Google-Smtp-Source: AGHT+IE5Z/OzudmNQji9Aj5KqpKfkzoXojjJf5hnSCvtORN41w5USBetbpaC3mYY8dCp0qK+2M1nRf/LuAg6nUR6N5Q=
X-Received: by 2002:ac8:5e11:0:b0:412:184d:cfe7 with SMTP id
 h17-20020ac85e11000000b00412184dcfe7mr19191173qtx.26.1693996117933; Wed, 06
 Sep 2023 03:28:37 -0700 (PDT)
MIME-Version: 1.0
References: <8eb5498d-89f6-e39e-d757-404cc3cfaa5c@vivier.eu>
 <20230630083852.3988-1-norbert.lange@andritz.com> <e8161622-beb0-d8d5-6501-f0bee76a372d@vivier.eu>
 <20230630-hufen-herzallerliebst-fde8e7aecba0@brauner> <202307121239.1EB4D324@keescook>
In-Reply-To: <202307121239.1EB4D324@keescook>
From:   Norbert Lange <nolange79@gmail.com>
Date:   Wed, 6 Sep 2023 12:28:27 +0200
Message-ID: <CADYdroNw5ZPPUqXQ5Psb8ffzi47SzvJAixQgxm+vsmV9eX_kYg@mail.gmail.com>
Subject: Re: [PATCH v8 1/1] ns: add binfmt_misc to the user namespace
To:     Kees Cook <keescook@chromium.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Laurent Vivier <laurent@vivier.eu>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org, jan.kiszka@siemens.com,
        jannh@google.com, avagin@gmail.com, dima@arista.com,
        James.Bottomley@hansenpartnership.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am Mi., 12. Juli 2023 um 21:40 Uhr schrieb Kees Cook <keescook@chromium.org=
>:
>
> On Fri, Jun 30, 2023 at 11:06:59AM +0200, Christian Brauner wrote:
> > On Fri, Jun 30, 2023 at 10:52:22AM +0200, Laurent Vivier wrote:
> > > Hi Norbert,
> > >
> > > Le 30/06/2023 =C3=A0 10:38, Norbert Lange a =C3=A9crit :
> > > > Any news on this? What remains to be done, who needs to be harrasse=
d?
> > > >
> > > > Regards, Norbert
> > >
> > > Christian was working on a new version but there is no update for 1 y=
ear.
> > >
> > > [PATCH v2 1/2] binfmt_misc: cleanup on filesystem umount
> > > https://lkml.org/lkml/2021/12/16/406
> > > [PATCH v2 2/2] binfmt_misc: enable sandboxed mounts
> > > https://lkml.org/lkml/2021/12/16/407
> > >
> > > And personally I don't have the time to work on this.
> >
> > I've actually rebased this a few weeks ago:
> > https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=3Dvf=
s.binfmt_misc
> > It has Acks, it's done. The only thing back then was Kees had wanted to
> > take this but never did. I'll ping him.
>
> Hi! Can you resend this now that the merge window is closed? I looked at
> it in your tree and it seems okay. I remain a bit nervous about exposing
> it to unpriv access, but I'd like to give it a try. It'd be very useful!
>
> -Kees
>
> --
> Kees Cook

Hate to be that guy, but did anything move closer towards upstream
since that post?

Norbert
