Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB396A9E05
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 18:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjCCRy3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 12:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjCCRy1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 12:54:27 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9125B5F7
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Mar 2023 09:54:20 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id o12so13468109edb.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Mar 2023 09:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677866059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2o3rQetZgv6ewfCPpQy7L56u60VboNrnPcXuCAU8c9I=;
        b=b/8Up02i2lcrK9UBtAHNAFlHN+tAL1/wHdc0XhoMSka0tX2DP8lx5sAMlbGKaqcdVS
         SvP/tXbfh/AzsAsUA6ekLx2G/ixheTP3F6AJykzFcVW97CP/ckEdcwhNmU6ZiwRed0Vk
         VP7RWbGcaBSleim2c4xAdaBtWU894VPVlzRRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677866059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2o3rQetZgv6ewfCPpQy7L56u60VboNrnPcXuCAU8c9I=;
        b=6C9q8cEED9MIuAiSIk9Rpg7RNSZWnOmH8LRx4ty2BNfAOfclRz1G14S2zk5lyV3nXJ
         7ULJ5uPjf4238XzveqcQYgGI4M0M14uHj1DghhPrHH/U6CUNxKTPIp7dw5mYdS4Wfhap
         vb3+khPIUb51/mGB/qtInxrqRIrLQbDjwObqq3g3lUA+c+RutfNlcSv61SMUkVJZRyZA
         O/UmACIRVqP8q1iKeydIf5lzUOg2dCxD76W1jDVOWd3urpGX9vXEptFmGSRQEAA32PvA
         fPgdyILVd64KYtXlyN4AmfV+9LcJouBl924qw6YJWUb8ZJjJ69VO5t8AdBEITx9f4BqD
         eEHQ==
X-Gm-Message-State: AO0yUKWw/OgvVqrGREz8jrlOmg10x3Bg5YD6ckOeYXbG6KKTE5HCEQMq
        e6kgL4RSYtjKpkvQTv3WTI+GKgfljRJB2HCvC+2I9A==
X-Google-Smtp-Source: AK7set9iwAcQgYowd7agvbQSQj0ICtH9HviSfOd0jmImd8BBvfFXEw/ofjrylicEUMh6oIMaiG498A==
X-Received: by 2002:a17:906:9b88:b0:8b1:fc:b06d with SMTP id dd8-20020a1709069b8800b008b100fcb06dmr3427421ejc.77.1677866058967;
        Fri, 03 Mar 2023 09:54:18 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id gj14-20020a170906e10e00b008df7d2e122dsm1167972ejb.45.2023.03.03.09.54.17
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 09:54:17 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id s11so13494293edy.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Mar 2023 09:54:17 -0800 (PST)
X-Received: by 2002:a17:906:b281:b0:8b8:aef3:f2a9 with SMTP id
 q1-20020a170906b28100b008b8aef3f2a9mr1190087ejz.0.1677866056901; Fri, 03 Mar
 2023 09:54:16 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgbm1rjkSs0w+dVJJzzK2M1No=j419c+i7T4V4ky2skOw@mail.gmail.com>
 <20230302083025.khqdizrnjkzs2lt6@wittgenstein> <CAHk-=wivxuLSE4ESRYv_=e8wXrD0GEjFQmUYnHKyR1iTDTeDwg@mail.gmail.com>
 <CAGudoHF9WKoKhKRHOH_yMsPnX+8Lh0fXe+y-K26mVR0gajEhaQ@mail.gmail.com>
 <ZADoeOiJs6BRLUSd@ZenIV> <CAGudoHFhnJ1z-81FKYpzfDmvcWFeHNkKGdr00CkuH5WJa2FAMQ@mail.gmail.com>
 <CAHk-=wjp5fMupRwnROtC5Yn+MVLA7v=J+_QJSi1rr3qAjdsfXw@mail.gmail.com>
 <CAHk-=wi11ZbOBdMR5hQDz0x0NNZ9gM-4SxXxK-7R3_yh7e10rQ@mail.gmail.com>
 <ZAD21ZEiB2V9Ttto@ZenIV> <6400fedb.170a0220.ece29.04b8@mx.google.com>
 <ZAEC3LN6oUe6BKSN@ZenIV> <CAG_fn=UQEuvJ9WXou_sW3moHcVQZJ9NvJ5McNcsYE8xw_WEYGw@mail.gmail.com>
 <CAGudoHFqNdXDJM2uCQ9m7LzP0pAx=iVj1WBnKc4k9Ky1Xf5XmQ@mail.gmail.com>
In-Reply-To: <CAGudoHFqNdXDJM2uCQ9m7LzP0pAx=iVj1WBnKc4k9Ky1Xf5XmQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Mar 2023 09:54:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh-eTh=4g28Ec5W4pHNTaCSZWJdxVj4BH2sNE2hAA+cww@mail.gmail.com>
Message-ID: <CAHk-=wh-eTh=4g28Ec5W4pHNTaCSZWJdxVj4BH2sNE2hAA+cww@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Alexander Potapenko <glider@google.com>,
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

On Fri, Mar 3, 2023 at 9:39=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> wr=
ote:
>
> So the key is: memset is underperforming at least on x86-64 for
> certain sizes and the init-on-alloc thingy makes it used significantly
> more, exacerbating the problem

One reason that the kernel memset isn't as optimized as memcpy, is
simply because under normal circumstances it shouldn't be *used* that
much outside of page clearing and constant-sized structure
initialization.

Page clearing is fine, and constant-sized structure inits are also
generally fine (ie the compiler does the small ones directly).

So this is literally a problem with pointless automated memset,
introduced by that hardening option. And hardening people generally
simply don't care about performance, and the people who _do _care
about performance usually don't enable the known-expensive crazy
stuff.

Honestly, I think the INIT_ONCE stuff is actively detrimental, and
only hides issues (and in this case adds its own). So I can't but help
to say "don't do that then". I think it's literally stupid to clear
allocations by default.

I'm not opposed to improving memset, but honestly, if the argument is
based on the stupid hardening behavior, I really think *that* needs to
be fixed first.

               Linus
