Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20954CAF8E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Mar 2022 21:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243126AbiCBUUB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Mar 2022 15:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243093AbiCBUUA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Mar 2022 15:20:00 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4202FC9A21
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Mar 2022 12:19:15 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id t14so3901986ljh.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Mar 2022 12:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uy+qIY61mUv01aVZ77KYqcI4VQ6CnEr5ehBFaIlKwdg=;
        b=Be+smD91jIehBxsphVP8GxPmG9fZ7UzsziFVI8sCcayH4ghcjVwFadN69qX3SSZZfA
         w/nKcppYscRVDTynDM99u+3Int1mDvzuW1vHPoDdJ+8JxYLDdH7+xaY9DZL7COnmW4q3
         yEVm7FisHcBkdW7xwzBny/SyDipBoZU1ONqUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uy+qIY61mUv01aVZ77KYqcI4VQ6CnEr5ehBFaIlKwdg=;
        b=B9ZoTJdCxdRZvQnoNsyVl0La3Ldr1qcmp8M6Ixf9YnJOZ+pgb/yLmbeNe0I4T1aURB
         Kx14+A2BrCGHkpWlUcY4sOg9YJt/HAL2Wyr9kwqtyBgE/zIg6Dc4u+Ddg9U3t3slZ2Sp
         +Paw686X1g0blSpEobYyT86iJGwK4+auY6Y5RShBl+gpnN280mK3AYO77zeIJlP9BhWX
         kmy5B1yLVCq4jewyrDPiUzgRYNkykj+F3/ivZ3PAn3Usuu2uoKohyFI9iIiuy77tf0Yr
         XHfMtrmMRsg8X+A7HsF9gd6dBKgDrlZG3LBFNqUDD1aWupUznP/V6uWB/QQfgy+UsaqO
         kxCA==
X-Gm-Message-State: AOAM533iTYylz5x3wyka8P4eB98Zs3R4TueyUwTcyrdQr52HdqLjrzE4
        E9DPMSiQ6MNZO7yxCVC4ilv9J6P8V3gzUCBCa2M=
X-Google-Smtp-Source: ABdhPJxBHQOJu9TmawMUyOG6TM2CsB52AzpH9Et1TTs57m2IqVWr6I6y6/WQeHD61IEnFWwwdibthA==
X-Received: by 2002:a05:651c:2122:b0:246:7327:cde8 with SMTP id a34-20020a05651c212200b002467327cde8mr18853223ljq.412.1646252353638;
        Wed, 02 Mar 2022 12:19:13 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id g27-20020ac2539b000000b004433dae644fsm10580lfh.153.2022.03.02.12.19.12
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 12:19:13 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id v28so3894679ljv.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Mar 2022 12:19:12 -0800 (PST)
X-Received: by 2002:a2e:3013:0:b0:246:2ca9:365e with SMTP id
 w19-20020a2e3013000000b002462ca9365emr21092331ljw.291.1646252342192; Wed, 02
 Mar 2022 12:19:02 -0800 (PST)
MIME-Version: 1.0
References: <282f0f8d-f491-26fc-6ae0-604b367a5a1a@amd.com> <b2d20961dbb7533f380827a7fcc313ff849875c1.camel@HansenPartnership.com>
 <7D0C2A5D-500E-4F38-AD0C-A76E132A390E@kernel.org> <73fa82a20910c06784be2352a655acc59e9942ea.camel@HansenPartnership.com>
 <CAHk-=wiT5HX6Kp0Qv4ZYK_rkq9t5fZ5zZ7vzvi6pub9kgp=72g@mail.gmail.com>
 <7dc860874d434d2288f36730d8ea3312@AcuMS.aculab.com> <CAHk-=whKqg89zu4T95+ctY-hocR6kDArpo2qO14-kV40Ga7ufw@mail.gmail.com>
 <0ced2b155b984882b39e895f0211037c@AcuMS.aculab.com> <CAHk-=wix0HLCBs5sxAeW3uckg0YncXbTjMsE-Tv8WzmkOgLAXQ@mail.gmail.com>
 <78ccb184-405e-da93-1e02-078f90d2b9bc@rasmusvillemoes.dk> <202203021158.DB5204A0@keescook>
In-Reply-To: <202203021158.DB5204A0@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 2 Mar 2022 12:18:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wikKPC0LUqZ8++EC5JOvGdBqVH9uUaTX=DvBioDoReYww@mail.gmail.com>
Message-ID: <CAHk-=wikKPC0LUqZ8++EC5JOvGdBqVH9uUaTX=DvBioDoReYww@mail.gmail.com>
Subject: Re: [PATCH 2/6] treewide: remove using list iterator after loop body
 as a ptr
To:     Kees Cook <keescook@chromium.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        David Laight <David.Laight@aculab.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        KVM list <kvm@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>,
        "linux1394-devel@lists.sourceforge.net" 
        <linux1394-devel@lists.sourceforge.net>,
        "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "kgdb-bugreport@lists.sourceforge.net" 
        <kgdb-bugreport@lists.sourceforge.net>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Arnd Bergman <arnd@arndb.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        dma <dmaengine@vger.kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        "v9fs-developer@lists.sourceforge.net" 
        <v9fs-developer@lists.sourceforge.net>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "tipc-discussion@lists.sourceforge.net" 
        <tipc-discussion@lists.sourceforge.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 2, 2022 at 12:07 PM Kees Cook <keescook@chromium.org> wrote:
>
> I've long wanted to change kfree() to explicitly set pointers to NULL on
> free. https://github.com/KSPP/linux/issues/87

We've had this discussion with the gcc people in the past, and gcc
actually has some support for it, but it's sadly tied to the actual
function name (ie gcc has some special-casing for "free()")

See

    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=94527

for some of that discussion.

Oh, and I see some patch actually got merged since I looked there last
so that you can mark "deallocator" functions, but I think it's only
for the context matching, not for actually killing accesses to the
pointer afterwards.

               Linus
