Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218426AAC84
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Mar 2023 21:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjCDUvf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Mar 2023 15:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjCDUve (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Mar 2023 15:51:34 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D954CC29;
        Sat,  4 Mar 2023 12:51:33 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id ks17so4112957qvb.6;
        Sat, 04 Mar 2023 12:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677963092;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6TaFZwa4dQ8VpWg4ffSDgoAWzDgJ+B4G5XtE19x0ex8=;
        b=E7qScYQOLltuFF7Ld/pcEESL8F5HbYcCqG3VBW5DZXSDwXJGeduxpBEEuM/TlG3kS2
         Ym0GmvUFhdcBffEIgcL5uq70H9ZDe4cmqdRnIgtO+TgAXrfBzVX78MppFoeayheqgalp
         kZnAvANkDyDKqN69jom2LMnA/+zudEOOhy2BtWqCHZ7wZlMbXHVZuK8ymH8dybHJitcI
         EfYNOhzlJ6U0Y2UHoB2QChUNREnJtFN538hFy/6f0wWI17M6znT87u6+7RD2USR+Ev6P
         GGFNsIg84DzlKplKFF3/1Vi+uJJU0L9FbRDlhGMKapVKQfRC313hnmYKbq+XWZjEnikN
         DtWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677963092;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6TaFZwa4dQ8VpWg4ffSDgoAWzDgJ+B4G5XtE19x0ex8=;
        b=TkvaEMZAI2rdmqtNVhUcoq/srJ5MLB5ANKYDA32c4R7RoTbDstUnNSyYRQSrKmnvJ0
         eQWqiHCQPtHomz+BYwV/rbogp+WvD5gL+IsFI66w2W6hCNBDWaX0S/biIQR1DgycvoX3
         8cXQeptAGQO1tB/tF/1w8NDjVeI5oClCA9KTU/ZWHjH4chMf96BBZSt5qBH17SCwS0xs
         ELAwGYc1mt0NXnNG7LBMWXP6pbFElqzc9G3k2tUKlGcvg4Nzxv5fvMiosfA2Cz8Opiha
         k/pt5k2bvevMc8seUahZrbPDXbmUanR8I8EqoWloY8eQEeCygxkq8HyW1tcu/kLTV+xS
         ayyQ==
X-Gm-Message-State: AO0yUKXAe4mJ0NWd9r0qDJTUccxQx4ORF7uL2CV5Tc9ZlW51isliGTl5
        QHYCGvMS1dsFv4cV8xR3jnw=
X-Google-Smtp-Source: AK7set9qZPX5wL03Z6I64vO78GDDyOiWk5iCzHMuG2gM50lf4dsHTU1q0omITzRh5ydYdnoj6y6wRQ==
X-Received: by 2002:a05:6214:250e:b0:56e:bdfb:f4c5 with SMTP id gf14-20020a056214250e00b0056ebdfbf4c5mr10940595qvb.36.1677963091965;
        Sat, 04 Mar 2023 12:51:31 -0800 (PST)
Received: from localhost ([2601:2c1:c80c:2efe:22eb:11d1:76e5:8725])
        by smtp.gmail.com with ESMTPSA id y191-20020a3764c8000000b00741921f3f60sm4353338qkb.42.2023.03.04.12.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 12:51:31 -0800 (PST)
Date:   Sat, 4 Mar 2023 12:51:30 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mateusz Guzik <mjguzik@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@google.com>,
        Christian Brauner <brauner@kernel.org>, serge@hallyn.com,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if
 possible
Message-ID: <ZAOvUuxJP7tAKc1e@yury-laptop>
References: <CAGudoHFqNdXDJM2uCQ9m7LzP0pAx=iVj1WBnKc4k9Ky1Xf5XmQ@mail.gmail.com>
 <CAHk-=wh-eTh=4g28Ec5W4pHNTaCSZWJdxVj4BH2sNE2hAA+cww@mail.gmail.com>
 <CAGudoHG+anGcO1XePmLjb+Hatr4VQMiZ2FufXs8hT3JrHyGMAw@mail.gmail.com>
 <CAHk-=wjy_q9t4APgug9q-EBMRKAybXt9DQbyM9Egsh=F+0k2Mg@mail.gmail.com>
 <CAGudoHGYaWTCnL4GOR+4Lbcfg5qrdOtNjestGZOkgtUaTwdGrQ@mail.gmail.com>
 <CAHk-=wgfNrMFQCFWFtn+UXjAdJAGAAFFJZ1JpEomTneza32A6g@mail.gmail.com>
 <ZAK6Duaf4mlgpZPP@yury-laptop>
 <CAHk-=wh1r3KfATA-JSdt3qt2y3sC=5U9+wZsbabW+dvPsqRCvA@mail.gmail.com>
 <ZALcbQoKA7K8k2gJ@yury-laptop>
 <CAHk-=wjit4tstX3q4DkiYLTD6zet_7j=CfjbvTMqtnOwmY7jzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wjit4tstX3q4DkiYLTD6zet_7j=CfjbvTMqtnOwmY7jzA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 04, 2023 at 11:19:54AM -0800, Linus Torvalds wrote:
> On Fri, Mar 3, 2023 at 9:51 PM Yury Norov <yury.norov@gmail.com> wrote:
> >
> > And the following code will be broken:
> >
> > cpumask_t m1, m2;
> >
> > cpumask_setall(m1); // m1 is ffff ffff ffff ffff because it uses
> >                     // compile-time optimized nr_cpumask_bits
> >
> > for_each_cpu(cpu, m1) // 32 iterations because it relied on nr_cpu_ids
> >         cpumask_set_cpu(cpu, m2); // m2 is ffff ffff XXXX XXXX
> 
> So  honestly, it looks like you picked an example of something very
> unusual to then make everything else slower.

What about bootable sticks?
 
> Rather than commit aa47a7c215e7, we should just have fixed 'setall()'
> and 'for_each_cpu()' to use nr_cpu_ids, and then the rest would
> continue to use nr_cpumask_bits.

No, that wouldn't work for all.

> That particular code sequence is arguably broken to begin with.
> setall() should really only be used as a mask, most definitely not as
> some kind of "all possible cpus".

Sorry, don't understand this.

> The latter is "cpu_possible_mask", which is very different indeed (and
> often what you want is "cpu_online_mask")

Don't understand this possible vs online argument, but OK. What about this?

        if (cpumask_setall_is_fixed)
                cpumask_setall(mask);
        else {
                for_each_online_cpu(cpu)
                        cpumask_set_cpu(cpu, mask);
             }

        // You forgot to 'fix' cpumask_equal()
        BUG_ON(!cpumask_equal(cpu_online_mask, mask));

Or this:

        cpumask_clear(mask);
        for_each_cpu_not(cpu, mask)
                cpumask_set_cpu(cpu, mask);
        BUG_ON(!cpumask_full(mask));

The root of the problem is that half of cpumask API relies (relied) on
compile-time nr_cpumask_bits, and the other - on boot-time nr_cpu_ids.

So, if you consistently propagate your 'fix', you'll get rid of
nr_cpumask_bits entirely with all that associate overhead.

That's what I actually did. And even tried to minimize the
overhead the best way I can think of.

> But I'd certainly be ok with using nr_cpu_ids for setall, partly
> exactly because it's so rare. It would probably be better to remove it
> entirely, but whatever.
> 
>               Linus
