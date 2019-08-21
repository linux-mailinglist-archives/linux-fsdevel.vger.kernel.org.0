Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0072196E00
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 02:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfHUADV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 20:03:21 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33727 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfHUADV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 20:03:21 -0400
Received: by mail-io1-f67.google.com with SMTP id z3so1078413iog.0;
        Tue, 20 Aug 2019 17:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/hK0xzub3tYFlOXLUKC5HkLTnr9OcFK2afBoeU8vIos=;
        b=GUqixZEM/qGpnaXHE1DfSi29Qd96gfn+y1YZOG1EbLraVdbnrXZEsNAtIYIEzXLdNZ
         R1V6Hn8lq//P+bJ4T6hBbCrp/flZP1FD0ZVNhvUaLfrFZbYBBODVrtcvGcRg94IrlxBV
         5OymAdN1L9sc05Wt1nrnW/adiwy0RVXc8JYYKaJLppCLI3VUuvyxdBZULHcqVPQW2tQG
         dO1aeud5wcCfb+0YOeoT8elQVyOuc+4leLAVRqDgAO5ROGlq/3vEhQ7FUHA1nm05j4Dx
         oCTjkIfS2zxQAjNfBvptmOGWiLsV0veBHitA3CkofTU7FV/4R2b/iRgwmvRy8zkU6SSD
         f9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/hK0xzub3tYFlOXLUKC5HkLTnr9OcFK2afBoeU8vIos=;
        b=fntfm2dWtsagSMnMT1zb1RFo4nMkU2YwNEMuPkrjWvrTfe+sdyGdnLcav8inXQpNW7
         Je2U8KxvToS/b4KpQFIPbEGW5drwpB9qLWKATLI56q8rMRXhWQrs6L0FGZAKfu38p94L
         7qMp6zZWjppgE2lwEVO1okrI5xboePQa/71nnP6ekvvCQUnk1I0kOiDkIQgYRfxiJOmp
         42vdJTc4urcXT7xfdE/281aT+sovF/YJIHfeU+koILC9Jo8RpWPmHrle3tFTQKF9YUFU
         +wCPI4duzi/caEjqKz38HIbyV/TA5UyFOgSgZkTjMnh79H6NAViiisPj4isK5OUTgRgm
         C6Tw==
X-Gm-Message-State: APjAAAVoL50Vg71oceKyXiqFcwLhCXM0zgk7sF67fCNwyneLLgxUSY97
        SEMyKoDaUuf5igyT7kaxqOYOpM+vvzhJ7+n1akM=
X-Google-Smtp-Source: APXvYqwsCp2QRaWKlcwHARTdMz/Hzj+coQq02t1hRapfNDDGet0cC76VvV2Lj4s9gi2N9qNvwM9dWQQw1EIRgNhtm+s=
X-Received: by 2002:a02:10:: with SMTP id 16mr6836969jaa.96.1566345800395;
 Tue, 20 Aug 2019 17:03:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190818165817.32634-1-deepa.kernel@gmail.com>
 <20190818165817.32634-20-deepa.kernel@gmail.com> <201908200018.8C876788@keescook>
In-Reply-To: <201908200018.8C876788@keescook>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Tue, 20 Aug 2019 17:03:08 -0700
Message-ID: <CABeXuvpjgE6azA27y8MTpnJ9QogLCPbXrmbDny16tkuAJytcsw@mail.gmail.com>
Subject: Re: [PATCH v8 19/20] pstore: fs superblock limits
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 20, 2019 at 12:20 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Sun, Aug 18, 2019 at 09:58:16AM -0700, Deepa Dinamani wrote:
> > Leaving granularity at 1ns because it is dependent on the specific
> > attached backing pstore module. ramoops has microsecond resolution.
> >
> > Fix the readback of ramoops fractional timestamp microseconds,
> > which has incorrectly been reporting the value as nanoseconds since
> > 3f8f80f0 ("pstore/ram: Read and write to the 'compressed' flag of pstore").
>
> As such, this should also have:
>
> Fixes: 3f8f80f0cfeb ("pstore/ram: Read and write to the 'compressed' flag of pstore")

Will add that in. Thanks.

> > Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> > Acked-by: Kees Cook <keescook@chromium.org>
>
> Also: this is going via some other tree, yes? (Or should I pick this up
> for the pstore tree?)

I am hoping Al can take the series as a whole.

-Deepa
