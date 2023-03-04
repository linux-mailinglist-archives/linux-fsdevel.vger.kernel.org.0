Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36CC6AA7DE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Mar 2023 04:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjCDDnC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 22:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjCDDnA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 22:43:00 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2082161BE
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Mar 2023 19:42:57 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id g3so17931684eda.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Mar 2023 19:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677901375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRI2r+nGaYoc/6DC9g4x/BneKMapCVAkn7Icxvx9UyE=;
        b=gOk0r7IRyae11l5C54SWiNiUvgkha+5UOxrFtkZuCOq5WzJBwVOKijP66ljuIoVkMx
         OgBLbxOMIQM6b5q0q40eiJtRBjqVkHEcxVbohaNPqvci2K/m+zuK0VJWL7uN4XlbAgw+
         xOiDFKE8EoNI8PDeqzIG4PT5dQQoYmga5jmXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677901375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRI2r+nGaYoc/6DC9g4x/BneKMapCVAkn7Icxvx9UyE=;
        b=FtaM8Q3Q3GG7MetG28FN1+LtaY8XD594h25+YrVLweGmGMthOPueG5FunTyDbdU7Pm
         F7tBWC7U7qQfDUpe0DyWcJuBcUL3TaO3WJ1pQyDkcEP3mjxTjTqNzOmDWQxWPZAADTlr
         ysTSuSY+/VZ6RkwKqUCO3nj5ikAkRaVE7KQIX2S9BkEoVjnwC49vhiboRm2mz7LOPrq2
         DbBW3N5Y1rggqJz9RIuYttUUf1+o6jR2lXY5C0WN1ZWzTHti8CRo+FodY5kjcx3PuCNb
         VFY4CGnWNPAvGb9hsZJ3FkR/irC2WnnPQHBOdLsOOMobunqfXfXsIqxQShkGx3pCP4by
         DEqg==
X-Gm-Message-State: AO0yUKVZ7qk9ht3nCvfjRHxIQ9nm7AonrXy+DNJiucjAwSedG5gwZFL3
        t49ZJHKYaOvNMEJk1FnKv252YNga5Ik9+5AkZBkyDw==
X-Google-Smtp-Source: AK7set+eQ9EdF3V1B/2iK+Al4NSBcmFPwzzNcRePVB1Pqa8MiFa0FC0NtZ7nL9neWjcBeu9TnGndhw==
X-Received: by 2002:a17:906:7948:b0:8b2:37b5:cc4 with SMTP id l8-20020a170906794800b008b237b50cc4mr5629612ejo.7.1677901375140;
        Fri, 03 Mar 2023 19:42:55 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id z92-20020a509e65000000b004bc11e5f8b9sm1891513ede.83.2023.03.03.19.42.53
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 19:42:54 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id cw28so17853118edb.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Mar 2023 19:42:53 -0800 (PST)
X-Received: by 2002:a50:9f47:0:b0:4bc:13f5:68a5 with SMTP id
 b65-20020a509f47000000b004bc13f568a5mr2310202edf.5.1677901373386; Fri, 03 Mar
 2023 19:42:53 -0800 (PST)
MIME-Version: 1.0
References: <ZAD21ZEiB2V9Ttto@ZenIV> <6400fedb.170a0220.ece29.04b8@mx.google.com>
 <ZAEC3LN6oUe6BKSN@ZenIV> <CAG_fn=UQEuvJ9WXou_sW3moHcVQZJ9NvJ5McNcsYE8xw_WEYGw@mail.gmail.com>
 <CAGudoHFqNdXDJM2uCQ9m7LzP0pAx=iVj1WBnKc4k9Ky1Xf5XmQ@mail.gmail.com>
 <CAHk-=wh-eTh=4g28Ec5W4pHNTaCSZWJdxVj4BH2sNE2hAA+cww@mail.gmail.com>
 <CAGudoHG+anGcO1XePmLjb+Hatr4VQMiZ2FufXs8hT3JrHyGMAw@mail.gmail.com>
 <CAHk-=wjy_q9t4APgug9q-EBMRKAybXt9DQbyM9Egsh=F+0k2Mg@mail.gmail.com>
 <CAGudoHGYaWTCnL4GOR+4Lbcfg5qrdOtNjestGZOkgtUaTwdGrQ@mail.gmail.com>
 <CAHk-=wgfNrMFQCFWFtn+UXjAdJAGAAFFJZ1JpEomTneza32A6g@mail.gmail.com> <ZAK6Duaf4mlgpZPP@yury-laptop>
In-Reply-To: <ZAK6Duaf4mlgpZPP@yury-laptop>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Mar 2023 19:42:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh1r3KfATA-JSdt3qt2y3sC=5U9+wZsbabW+dvPsqRCvA@mail.gmail.com>
Message-ID: <CAHk-=wh1r3KfATA-JSdt3qt2y3sC=5U9+wZsbabW+dvPsqRCvA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Mateusz Guzik <mjguzik@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@google.com>,
        Christian Brauner <brauner@kernel.org>, serge@hallyn.com,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 3, 2023 at 7:25=E2=80=AFPM Yury Norov <yury.norov@gmail.com> wr=
ote:
>
> Did you enable CONFIG_FORCE_NR_CPUS? If you pick it, the kernel will
> bind nr_cpu_ids to NR_CPUS at compile time, and the memset() call
> should disappear.

I do not believe CONFIG_FORCE_NR_CPUS makes any sense, and I think I
told you so at the time.

This all used to just work *without* some kind of config thing, First
removing the automatic "do the right thing", and then adding a config
option to "force" doing the right thing seems more than a bit silly to
me.

I think CONFIG_FORCE_NR_CPUS should go away, and - once more - become
just the "is the cpumask small enough to be just allocated directly"
thing.

Of course, the problem for others remain that distros will do that
CONFIG_CPUMASK_OFFSTACK thing, and then things will suck regardless.

I was *so* happy with our clever "you can have large cpumasks, and
we'll just allocate them off the stack" long long ago, because it
meant that we could have one single source tree where this was all
cleanly abstracted away, and we even had nice types and type safety
for it all.

That meant that we could support all the fancy SGI machines with
several thousand cores, and it all "JustWorked(tm)", and didn't make
the normal case any worse.

I didn't expect distros to then go "ooh, we want that too", and enable
it all by default, and make all our clever "you only see this
indirection if you need it" go away, and now the normal case is the
*bad* case, unless you just build your own kernel and pick sane
defaults.

Oh well.

                   Linus
