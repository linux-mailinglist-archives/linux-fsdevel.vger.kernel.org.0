Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6CB123DE2F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Aug 2020 19:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgHFRXB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Aug 2020 13:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729964AbgHFRFS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:05:18 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5308CC06179E
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Aug 2020 03:48:03 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id i80so25845293lfi.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Aug 2020 03:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+F2bvw4279AFpRAqqHr9VWj7UEazWN4PYw+oY2vMYa8=;
        b=FZytDxuwtIQKZP3iyMnkL/T5/O6IjGWF8fDMueWvMixfJVT0mifTHd743Bj5ndEbvF
         Ry3pSxktKyczlATkt3Yt3ovkS/7xygecOfGuZjdmwzIF1ipy2NB6pzZh7ao+//ZmTBdi
         CNueY6UNDJK95eeClCokRBbkY+gs/dvS4CmGuViCqjkLaaAk6CHbcDPe2G0ACzGAQgJk
         e2j0KobbMTFzhGr0tX49nsTraHwHmcfyZkGr3JFEYz5IDfkFrtxpTM5/yJ2kbliylX1/
         6CdNnBknNmq8X/aEHsaa3VyymRzrCUR2fqPcatDBEnKFlg1Ox34Pspo9XJ0SqdLbbNBm
         6rHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+F2bvw4279AFpRAqqHr9VWj7UEazWN4PYw+oY2vMYa8=;
        b=bjHEFF4p0266Pkwi1mBlYaUoa6oNZGUrxLDqiA5/i0WQ02RA0IcbV953Zk4bgItHZM
         nZESXW6b32k7rKSbp6NirCR+rZ+TZc5Dn176E7gszJGiTlSIeKyHi8ia3qSpc26tzAzW
         m+X4+ysQj7+wH6zUJZjsMnVsTWLZ3qk6XYouGPONl3i71/TXcf7WA/gnyCZo9+FaLyCW
         0shme2Km8QCOpIsZ4Rh9gk4Px98JHROLLcJ6sTEbEpPBcCuNJwrBF8lThTFLsdMQerZw
         W8DIG/quOY7hliJnoe1LcTXixJi5Hc2KzQtoTC2nFGdelpkbwbuMzneL6XedfADzdO8x
         GsPQ==
X-Gm-Message-State: AOAM531SPLKf4gUWVHuMP0YBqYCvqGTLwpVVuut4Dp3pIcg2nW4G6pNt
        0KjnhNkgGS/wc3WgaQVTXiaC5SvEKXuDzQycgUD90kgQj0E=
X-Google-Smtp-Source: ABdhPJw3YRS5JPfc1W80PkQQEw6/Xj8PLvezRr9eMiA5H0m5fq09Fro360+A1GEpHIZKK8g2u9ca4vq/md8Y6ToCaw0=
X-Received: by 2002:ac2:5e26:: with SMTP id o6mr3576663lfg.194.1596710881135;
 Thu, 06 Aug 2020 03:48:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200529072017.2906-1-linus.walleij@linaro.org>
 <CAFEAcA-x0y6ufRXebckRdGSLOBzbdBsk=uw+foK4p+HDeVrA9A@mail.gmail.com>
 <CACRpkdZk-Pv49PyhtrW7ZQo+iebOapVb7L2T_cxh0SpYtcv5Xw@mail.gmail.com> <CACRpkdbOiL7=KUNa0==P+H-3SynhMt1=JweCY8ihbEZLK=b78w@mail.gmail.com>
In-Reply-To: <CACRpkdbOiL7=KUNa0==P+H-3SynhMt1=JweCY8ihbEZLK=b78w@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 Aug 2020 12:47:49 +0200
Message-ID: <CACRpkdY-w7TD89eRMJQSvhrPC7gxSPYPmMhPO2FUOxtzYRcRsg@mail.gmail.com>
Subject: Re: [PATCH v2] fcntl: Add 32bit filesystem mode
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>,
        Florian Weimer <fw@deneb.enyo.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 19, 2020 at 2:34 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Jul 6, 2020 at 10:54 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> > Ted, can you merge this patch?
> >
> > It seems QEMU is happy and AFICT it uses the approach you want :)
>
> Gentle ping!

Special merge-window ping.

Shall I resend the patch?

Yours,
Linus Walleij
