Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645DB6F6498
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 May 2023 08:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjEDGAM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 May 2023 02:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEDGAK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 May 2023 02:00:10 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E4E1984;
        Wed,  3 May 2023 23:00:07 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-44fa9d3cdf3so26629e0c.3;
        Wed, 03 May 2023 23:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683180007; x=1685772007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zITf+aZO120SwVmAaxZfxL9dJZ5Kk0XX5IThG2UHBk4=;
        b=GM0xWkbI8A1lCMudwhPXHDntWog3oiC97+ZA8wlZeByxI/jR+w4cRyzpOaoYD+RHZx
         gTqZlBQ1XjmHLv4N6aeOQesW2C+ljCSXUJs2qrFpvzYTuEwTo5PoH/Cca1vnOal7GVab
         YwVaYPI8jE6aVeC7ftoWW9FH2inQ/eEbNmWhS2PxNFYQ3w0aRgGc7qrbcJ0LEhwmrUzX
         HZ8hswkGXCw6SEoGWu8d8EsTxg0f38ZYPb75AXN+niZGAPgDYU1PjXpQXSqp9zTHFKFQ
         P/4QOHkjm3ooBYrZcbopmJlcYHZ1Aeg/zF5DtfEhrfFyVK8xUnxzTMcCS3QOqd1Ahiu+
         dJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683180007; x=1685772007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zITf+aZO120SwVmAaxZfxL9dJZ5Kk0XX5IThG2UHBk4=;
        b=hrVLyVEIom8zABt7miGLKRt/rchKlCnEPOxTYfa79Q+e8D8mnIqPeYaD3M1VfDlx2e
         N4OkxFcJnuKz+/chvcO/vguEBmxXFLNQ3GA+/Slb0iriagb6TcDthY3QgIXn0ysjq7nj
         N0NqJb10xqWnRvg777rze7KErzLLvlckFiewgi7CpeP6zMbJW36/Q3Hxd9rNBoDi6jU5
         HsjoxEhJIcVh1KJAmw1raMtHF/NBxhkWw4b0sj/ZpjGxxfZTQWcUR+BJKd60Gn1AUaXp
         Dpg5CwZc2/9usHr6PqXKgTK0XCuiPTWEmTPhnjVYjaM17uBbCHJm2urgudFCE42YQi9E
         R0LA==
X-Gm-Message-State: AC+VfDybjLiY4FV/mAyp1fzx5FmPVTevBiCvFdhFItPfWEEU+c46UW/N
        f3i8hrYpYnbg+M6A49+S28F1n9/1+LYN0CSoyiE=
X-Google-Smtp-Source: ACHHUZ7s/FXhRQZiw4RYh8wZQ3p/i2Iw+SGGSGyQF69lPe3QWqGfNm0Mnz0DZvNt6noU9cQ/vIjDbyMuEgV7d4NNZXM=
X-Received: by 2002:a1f:ea05:0:b0:43f:cadf:9ef3 with SMTP id
 i5-20020a1fea05000000b0043fcadf9ef3mr6514362vkh.8.1683180006410; Wed, 03 May
 2023 23:00:06 -0700 (PDT)
MIME-Version: 1.0
References: <Y9YFgDXnB9dTZIXA@bombadil.infradead.org> <e44bb405be06fe97dbb0af3e47b4e8dd1c065f29.camel@kernel.org>
In-Reply-To: <e44bb405be06fe97dbb0af3e47b4e8dd1c065f29.camel@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 4 May 2023 08:59:55 +0300
Message-ID: <CAOQ4uxh3z40js7f5gcVcfM_9V8Y7dM3VShNzMQtfKBtzd9Qdzw@mail.gmail.com>
Subject: Re: LSF/MM/BPF BoF: pains / goods with automation with kdevops
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        lsf-pc@lists.linux-foundation.org, a.manzanares@samsung.com,
        chandan.babu@oracle.com, josef@toxicpanda.com,
        Pankaj Raghav <p.raghav@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 3, 2023 at 11:02=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Sat, 2023-01-28 at 21:34 -0800, Luis Chamberlain wrote:
> > More suitable towards a BoF as I don't *think* a larger audience would =
be
> > interested. At the last LSF during our talks about automation it was su=
ggested
> > we could share a repo and go to town as we're all adults. That's been d=
one:
> >
> > https://github.com/linux-kdevops/kdevops
> >
> > At ALPSS folks suggested maybe non-github, best we can do for now is
> > gitlab:
> >
> > https://gitlab.com/linux-kdevops/kdevops
> >
> > There's been quite a bit of development from folks on the To list. But
> > there's also bugs even on the upstream kernel now that can sometimes er=
k us.
> > One example is 9p is now used to be able to compile Linux on the host
> > instead of the guests. Well if you edit a file after boot on the host
> > for Linux, the guest won't see the update, so I guess 9p doesn't update
> > the guest's copy yet. Guests just have to reboot now. So we have to fix=
 that
> > and I guess add 9p to fstests. Or now that we have NFS support thanks t=
o
> > Jeff, maybe use that as an option? What's the overhead for automation V=
s 9p?
> >
> > We dicussed sharing more archive of results for fstests/blktests. Done.
> > What are the other developer's pain points? What would folks like? If
> > folks want demos for complex setups let me know and we can just do that
> > through zoom and record them / publish online to help as documentation
> > (please reply to this thread in private to me and I can set up a
> > session). Let's use the time at LSF more for figuring out what is neede=
d
> > for the next year.
> >
> >   Luis
>
> Luis mentioned that no one had replied to this expressing interest. I'm
> definitely interested in discussing kdevops if the schedule's not
> already full.

No worries.
It's already on the schedule, which btw, is now available on the website:
https://events.linuxfoundation.org/lsfmm/

It's a cross FS-IO session, but I see that MM also left this slot clean.
Not sure if they have interest in kdevops as well?
If so, I can make it official FS-IO-MM.

Thanks,
Amir.
