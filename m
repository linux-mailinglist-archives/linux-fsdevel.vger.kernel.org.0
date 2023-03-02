Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699196A8862
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 19:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjCBSO2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 13:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCBSO1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 13:14:27 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198291ACD4;
        Thu,  2 Mar 2023 10:14:26 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id bk32so14200744oib.10;
        Thu, 02 Mar 2023 10:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677780865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XeSjqmEVUpt1ySPAFm4qdmJX7HPSmSrgaAja9tHaOsA=;
        b=CS+ArVc3AOzzkRlMW7/06hk29HGVImNsghgdip5u5JkDVieKXi8nxFNLQ/IbDax+fv
         Q5X1M2XlZIAmabXRfDu5DHBoritqbRcsbwFZqKEHrjYP2t5c65nXAxGG6+n29danwwsQ
         MgVi0h3WpR50y8LdoGbSRyxX2f0cjok9mMkwGPGehb3rAIVAxAx3DY5EHAa/NQgEIYOG
         FQrRjJnuHLjTsmN52bd0pCg9Ma+e+dU0+WzArOho0rQXDmgk+uRVuQdaP0GcrksZVeE9
         Oo3lww/4rktDRbY2WIOh2Bt9SC38jPN55IDJsV+JpOGE6WruKDvCYKyWmVT9eltoIOk4
         mI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677780865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XeSjqmEVUpt1ySPAFm4qdmJX7HPSmSrgaAja9tHaOsA=;
        b=4VDVKLZFY0/UjEiPKLOqGp/wbgxaWYuHA5Iq9ClWYJPM+YLqNxdXP61ebHOm+iwvGs
         lxhIe7RX7w/3nGiRWcFmAKCbWY0ha3T9tO+FzZ/yHcJb8fWzO6AfI03fBzfRrmA85rBZ
         SjaX5RdlYQTJi6LAF/nm/30l0yE+N0j/fTnFqwgVLqvnht+cGCpr2/aA/KHWnjf5aQB9
         YtPsHTRPKnHKAki9ApBNEEinni04ZPkZybgcfeeMAQkCrQoJxfypUGdbYcAXnYL2JZNy
         JgR711SGROlDrZFv9buDRl3DvFMP2GWIQvFYiaDECkzxv86UMFlT6NkJ1W6ElH6RuzZP
         yThg==
X-Gm-Message-State: AO0yUKVCR756GK4quH8axFLZDL6tnGNWqUbl7KKO6Asb101oKFFT6nxw
        +2LOeXkaUKtwh9NO7GVkuZ6RXSQnMWTUNpvdZvT52wTI
X-Google-Smtp-Source: AK7set/0SB+Xrb5pNo4K27xsX6wsTIfJVo7R4it2eY1eC1OodxMwsJkGjKV/kC7+IWDfwS0Koul/2Fe2WmjbWy8zp8s=
X-Received: by 2002:a05:6808:cb:b0:383:c3d5:6c9f with SMTP id
 t11-20020a05680800cb00b00383c3d56c9fmr3797912oic.11.1677780865454; Thu, 02
 Mar 2023 10:14:25 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac9:4304:0:b0:4c1:4768:8c59 with HTTP; Thu, 2 Mar 2023
 10:14:24 -0800 (PST)
In-Reply-To: <CAHk-=wivxuLSE4ESRYv_=e8wXrD0GEjFQmUYnHKyR1iTDTeDwg@mail.gmail.com>
References: <20230125155557.37816-1-mjguzik@gmail.com> <20230125155557.37816-2-mjguzik@gmail.com>
 <CAHk-=wgbm1rjkSs0w+dVJJzzK2M1No=j419c+i7T4V4ky2skOw@mail.gmail.com>
 <20230302083025.khqdizrnjkzs2lt6@wittgenstein> <CAHk-=wivxuLSE4ESRYv_=e8wXrD0GEjFQmUYnHKyR1iTDTeDwg@mail.gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Thu, 2 Mar 2023 19:14:24 +0100
Message-ID: <CAGudoHF9WKoKhKRHOH_yMsPnX+8Lh0fXe+y-K26mVR0gajEhaQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>, viro@zeniv.linux.org.uk,
        serge@hallyn.com, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/2/23, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Thu, Mar 2, 2023 at 12:30=E2=80=AFAM Christian Brauner <brauner@kernel=
.org>
> wrote:
>>
>> Fwiw, as long as you, Al, and others are fine with it and I'm aware of
>> it I'm happy to pick up more stuff like this. I've done it before and
>> have worked in this area so I'm happy to help with some of the load.
>
> Yeah, that would work. We've actually had discussions of vfs
> maintenance in general.
>
> In this case it really wasn't an issue, with this being just two
> fairly straightforward patches for code that I was familiar with.
>

Well on that note I intend to write a patch which would add a flag to
the dentry cache.

There is this thing named CONFIG_INIT_ON_ALLOC_DEFAULT_ON which is
enabled at least on debian, ubuntu and arch. It results in mandatory
memset on the obj before it gets returned from kmalloc, for hardening
purposes.

Now the problem is that dentry cache allocates bufs 4096 bytes in
size, so this is an equivalent of a clear_page call and it happens
*every time* there is a path lookup.

Given how dentry cache is used, I'm confident there is 0 hardening
benefit for it.

So the plan would be to add a flag on cache creation to exempt it from
the mandatory memset treatment and use it with dentry.

I don't have numbers handy but as you can imagine it gave me a nice bump :)

Whatever you think about the idea aside, the q is: can something like
the above go in without Al approving it?

If so, I'll try to find time to hack it up this or next week. I had
some other patches to write too, but $reallife.

--=20
Mateusz Guzik <mjguzik gmail.com>
