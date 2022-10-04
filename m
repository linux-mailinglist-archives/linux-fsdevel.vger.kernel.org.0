Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0A35F3CAF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 08:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiJDGTS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Oct 2022 02:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJDGTR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Oct 2022 02:19:17 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB4D3FA0C;
        Mon,  3 Oct 2022 23:19:16 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id c17-20020a4aa4d1000000b0047653e7c5f3so8177306oom.1;
        Mon, 03 Oct 2022 23:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date;
        bh=YtqD9OKSiiGf2kZXxY7qCdxONGxz+6fgB1wC8lkT2ks=;
        b=iklhpEWyj17KV85dEcl1qjRVsgYDedRJPKLwMqljrEhavJ66wj2Lv6veJjnOqe09Pq
         /JJCELFZ19Em8ds+BjTczfyc07ygmk1i5FvWWhLXZfOjASWO+WhSEyUUuPJhddsaX2vE
         TmtxlUFT1tW4KoXM/a3ioVBd8BcUnet89jKIm842eOQCzhFlHschw8e2AQgoa5gLAbnX
         awFmIWPp82/pzhu/fl4whzD32GbYjJ4+hEyJGzexeOzDTPo3OZ84Gwh/Z4RHBGW5fk35
         7hYjY6l2KRdm88fUh+PC2oPAD6GK8rG46FMoSpPVWUb3X4GmUDL7fKSR1Yt/SuneI5Wl
         yPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=YtqD9OKSiiGf2kZXxY7qCdxONGxz+6fgB1wC8lkT2ks=;
        b=JLTboIZumA61OPiYt/RXxaL7r0BXQkUa1peMmRS/z5bFzkDmM5/cG69Zk109Gfz5q5
         /Cd+LDfMp14HIXWxxxjYpWcW2hIPIBRMyjLDybEHUJ4De5JTGs5TI3oS1phW2n9LjAeL
         Ny3i6ZDcBTnpsxXBlfeOGwyiWZI6Qfht/pjZLwMrpDABc0QnFWUwfyzy37d+HNR89G+a
         U6IUJA9HX21ObSjdOMjukgiMbcS0w0XW8MFIgRZ0sh5lFxARxGOrBO6X4JGpguiVm5fe
         Zpk7EajGoInhIyfb1qNCpbq8SW3//e1u/Ibk3xR6D59KT+1/+WknbzXH81AwW7g+hmsM
         E4cg==
X-Gm-Message-State: ACrzQf0ZF0nbVooGGH8fU64abSHGX4/vAxDGOV/hGlR/D/xGm9ck0h0B
        InhvFLnlgOh+asDG76KPqABAo1DJUgSm4XNn2rs=
X-Google-Smtp-Source: AMsMyM7+LkyDvXdb0ncEq3OGCG0twJbMVltcfIsEdG257lG8E7Rsms0Ko5TvOqR/BapzniSey50NNkbOIxj6V9p9Bzs=
X-Received: by 2002:a9d:7a8e:0:b0:655:e0a9:b3c6 with SMTP id
 l14-20020a9d7a8e000000b00655e0a9b3c6mr9804892otn.367.1664864355477; Mon, 03
 Oct 2022 23:19:15 -0700 (PDT)
MIME-Version: 1.0
References: <YzN+ZYLjK6HI1P1C@ZenIV> <YzSSl1ItVlARDvG3@ZenIV>
 <YzpcXU2WO8e22Cmi@iweiny-desk3> <7714.1664794108@jrobl> <Yzs4mL3zrrC0/vN+@iweiny-mobl>
 <YztfvaAFOe2kGvDz@ZenIV> <4011.1664837894@jrobl> <YztyLFZJKKTWcMdO@ZenIV> <CAHk-=whsOyuRhjmUQ5c1dBQYt1E4ANhObAbEspWtUyt+Pq=Kmw@mail.gmail.com>
In-Reply-To: <CAHk-=whsOyuRhjmUQ5c1dBQYt1E4ANhObAbEspWtUyt+Pq=Kmw@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 4 Oct 2022 08:18:39 +0200
Message-ID: <CA+icZUVXvMM-sK41oz_Ne4HyRGxXHNz=fPqy+1AYXmXPiE_=Rw@mail.gmail.com>
Subject: Re: [PATCH][CFT] [coredump] don't use __kernel_write() on kmap_local_page()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        "J. R. Okajima" <hooanon05g@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
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

On Tue, Oct 4, 2022 at 2:51 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Oct 3, 2022 at 4:37 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > One variant would be to revert the original patch, put its
> > (hopefully) fixed variant into -next and let it sit there for
> > a while.  Another is to put this incremental into -next and
> > merge it into mainline once it gets a sane amount of testing.
>
> Just do the incremental fix. It looks obvious enough ("oops, we need
> to get the pos _after_ we've done any skip-lseeks on the core file")
> that I think it would be just harder to follow a "revert and follow up
> with a fix".
>
> I don't think it needs a ton of extra testing, with Okajima having
> already confirmed it fixes his problem case..
>
>                 Linus

[ CC Geert ]

There was another patch from Geert concerning the same coredump changes:

[PATCH] coredump: Move dump_emit_page() to kill unused warning

If CONFIG_ELF_CORE is not set:

    fs/coredump.c:835:12: error: =E2=80=98dump_emit_page=E2=80=99 defined b=
ut not used
[-Werror=3Dunused-function]
      835 | static int dump_emit_page(struct coredump_params *cprm,
struct page *page)
          |            ^~~~~~~~~~~~~~

Fix this by moving dump_emit_page() inside the existing section
protected by #ifdef CONFIG_ELF_CORE.

Fixes: 06bbaa6dc53cb720 ("[coredump] don't use __kernel_write() on
kmap_local_page()")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Please, check yourself!

Best regards,
-Sedat-

[1] https://lore.kernel.org/all/20221003090657.2053236-1-geert@linux-m68k.o=
rg/
