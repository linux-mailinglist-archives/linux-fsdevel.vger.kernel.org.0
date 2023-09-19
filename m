Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8345E7A62B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 14:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbjISMWB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 08:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbjISMWA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:22:00 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D258BF7
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 05:21:53 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-490cd6db592so2374120e0c.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 05:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695126113; x=1695730913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKiLqkpWy+S+WoGeFtcZ1DuWQfWBMujV0V4EJecZnd4=;
        b=a4Q5n8dFSvLkl4PovE7hhHuocfpYE5JXv69Ct3titda2+VN/2kf1Ruv5H9bRCsHU+/
         ovPk47Ptg9ejo7X1BVVVYT+Q6GPkh64x0UhMJ0IQ+E30y4Iy1POzlejKkvOFk23f3kJj
         74N1aFUUpbp2agWtjgnmcG0bAeOxuTeu7D+QuZYfcs4wB08HJNUo7kvHUrRX0myCowdH
         9FBeD4E6ssS9UIPzQ1I6Gny8H75PhlMqVKuQOjapTpdYeypxxtaW4I7C3vLzxkLgmzGw
         m5s4bCFaGVjhzx/FiBAw08gaq+i9+8iXRCtIxx1MXboSpKU2ZJlNjyIgezydI2wnWHI6
         8BQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695126113; x=1695730913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OKiLqkpWy+S+WoGeFtcZ1DuWQfWBMujV0V4EJecZnd4=;
        b=g3Re3XNUQVaoJRKAEl6PPEQ7GPM1cHP2vQDPJYTXCRcOlXMluF0PFSWVKGQ3WHJo9n
         I2cEjGg4GLPWCzY0h2NJXk4zqSjGmoK4JMuNTYnzG7w1/7Xuof0Rpc0lUUCO6dxXJN7R
         o2Qw9WP7/2qSVmx8F4iBUXOwvPcd83cQn4CzQgsNaJH1C8+RyokILFKtdBd8Z08H0QLV
         Su5h/weLJgDoVf6gmy/sQLjraFYcJR+3ULbU3u4MbzAewQcGH5FYJ1x64G5kiyab+84i
         PcODP4P7EZRbCX0F+K8QTB/m8J7rHeLTA0WhgdrEZq6QSw+OeF4R8IlI4fLcaLHxt+2a
         spwA==
X-Gm-Message-State: AOJu0YwKYymawaA+9LjOHiKEdmN7dqfH8TKU1XFnRFQQ2bZce2RAAQw5
        qh7atoptu4NU9ypNnn0FW965es03XjlRXhectei2J8tRKus=
X-Google-Smtp-Source: AGHT+IHuouSdg0KEqh42ZqH60aYuxu874yipvrtWqrcXkhBVeqzhRiVsdPHz+ARXf4h5n1nzAQGbmXm5dLdM4GoGX80=
X-Received: by 2002:a1f:cac7:0:b0:495:e236:a73 with SMTP id
 a190-20020a1fcac7000000b00495e2360a73mr9242251vkg.11.1695126112866; Tue, 19
 Sep 2023 05:21:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230918123217.932179-1-max.kellermann@ionos.com>
 <20230918123217.932179-3-max.kellermann@ionos.com> <20230918124050.hzbgpci42illkcec@quack3>
 <CAKPOu+-Nx_cvBZNox63R1ah76wQp6eH4RLah0O5mDaLo9h60ww@mail.gmail.com>
 <20230918142319.kvzc3lcpn5n2ty6g@quack3> <CAOQ4uxic7C5skHv4d+Gek_uokRL8sgUegTusiGkwAY4dSSADYQ@mail.gmail.com>
 <CAOQ4uxjzf6NeoCaTrx_X0yZ0nMEWcQC_gq3M-j3jS+CuUTskSA@mail.gmail.com>
 <CAOQ4uxjkL+QEM+rkSOLahLebwXV66TwyxQhRj9xksnim5F-HFw@mail.gmail.com>
 <CAKPOu+_s8O=kfS1xq-cYGDcOD48oqukbsSA3tJT60FxC2eNWDw@mail.gmail.com>
 <20230919100112.nlb2t4nm46wmugc2@quack3> <CAKPOu+-apWRekyqRyYfsFkdx13uocCPKMzYJqmTsVEc6a=9uuA@mail.gmail.com>
 <CAOQ4uxgG6ync6dSBJiGW98docJGnajALiV+9tuwGiRt8NE8F+w@mail.gmail.com> <CAKPOu+9ds-dbq2-idehU5XR2s3Xz2NL-=fB+skKoN_zCym_OtA@mail.gmail.com>
In-Reply-To: <CAKPOu+9ds-dbq2-idehU5XR2s3Xz2NL-=fB+skKoN_zCym_OtA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 19 Sep 2023 15:21:41 +0300
Message-ID: <CAOQ4uxgvh6TG3ZsjzzdD+VhMUss3NLTO8Hk7YWDZs=yZagc+oQ@mail.gmail.com>
Subject: Re: inotify maintenance status
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Ivan Babrou <ivan@cloudflare.com>,
        Matthew Bobrowski <repnop@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 19, 2023 at 2:22=E2=80=AFPM Max Kellermann <max.kellermann@iono=
s.com> wrote:
>
> On Tue, Sep 19, 2023 at 12:59=E2=80=AFPM Amir Goldstein <amir73il@gmail.c=
om> wrote:
> > Any API complexity can be hidden from users with userspace
> > libraries. You can use the inotify-tools lib if you prefer.
>
> That doesn't convince me at all, but that's a question of taste. We'll
> just keep using inotify (with a patched kernel, which we have anyway).
>

ok.

> > > Getting an already-opened file descriptor, or just the file_handle, i=
s
> > > certainly an interesting fanotify feature. But that could have easily
> > > been added to inotify with a new "mask" flag for the
> > > inotify_add_watch() function.
> > >
> >
> > "could have easily been added" is not a statement that I am willing
> > to accept.
>
> Are you willing to take a bet? I come up with a patch for implementing
> this for inotify, let's say within a week, and you agree to merge it?
>
> (I'm not interested in this feature, I won't ever use it - all I
> wanted is dfd support for inotify_add_watch()).
>

I am not into ego fights. I have no desire to win an argument.
If you have an improvement that you want to make, you can
submit it and it will be judged technically.

If you want to improve inotify you can argue your case
and it will be judged technically.

But if you do that, I strongly advise to share the community
early in the design review of the new feature/API.
It can save you time.

> > The things that you are complaining about in the API are the exact
> > things that were needed to make the advanced features work.
>
> Not exactly - I complain that fanotify makes the complexity mandatory,
> the complexity is the baseline of the API. It would have been possible
> to design an API that is simple for 99% of all users, as simple as
> inotify; and only those who need the advanced features get the
> complexity as an option.
>
> I don't agree with your point that unnecessary complexity should be
> mitigated by throwing more (library) code at it. That's just adding
> more complexity and more overhead, the opposite of what I want.
>

Sorry, "what I want" is not a technical argument :)
"what many users want" with proof could be a start of a technical
argument.

I agree that simplicity of the kernel UAPI vs. delegating
simplicity to user libraries is a matter of taste and different subsystem
maintainers have different opinions in that regard.

And also, it is a bit late to discuss design preferences of an API
that was merged 4 years ago.
Design flaws and problems, sure, but for complexity it's a bit late.

Regarding inotify improvements, as I wrote, they will each be judged
technically, but the trend is towards phasing it out.

Thanks,
Amir.
