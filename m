Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7C0403684
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 11:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351222AbhIHJCa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 05:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348385AbhIHJCY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 05:02:24 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B21BC061575;
        Wed,  8 Sep 2021 02:01:16 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id j13so1854630edv.13;
        Wed, 08 Sep 2021 02:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CWSESMWDkMfMeRSoL9IsfVXiKU3coRndu8gqx7VGgiY=;
        b=SOKhMxGTz39hIr4b1nClxsKceeoE1sO4WLsCobLRBxuHVeWkLX6g2EtFj15lBGZ3p8
         s+nUJQ03Uc8JPsr3GLGUKjjeQkXFqJUc8WlttAbbDNONyrTqGXpjVa3RXhlyt74xJYL2
         k9Wlg8cXGtpXBY596dHa6rd+ulmoQ0WnKaQQeWoj8sWvXxpm4I+AWJ8ACD3NmwZD6NhP
         T01wF5UkqnWUqOHTj+Zv8C8NzoY7t4cIzIM2Wp2nXDXJ4B8sxO0nYGItE8MBhQCW13H+
         KX/9/cayXbAyRprY/cG84+ocMmV1s5e9dtDxelg9O1yXDwpdoETTL+3VOVjpbSapzj/7
         kk2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CWSESMWDkMfMeRSoL9IsfVXiKU3coRndu8gqx7VGgiY=;
        b=C/9mSROr8jt9GRviDVTh9y35QUqka3ojMrKCxKxtPAQF2ItJ2ZlJ4aRACsOpftH0Wy
         2U1l0aejlmpBu3XeUDLNXxkYDQ960NqC1EhIfoCOpp9WfMPdeRZiueKJzEWA+sohA0rA
         sGW60k6tdj73cP+M4lJe0o9zlPPBBe72k4FkNpPSgyjAntbkPeYE/poiwkobwdZu/Qub
         l5WCVyyJlBWXbPdOlbvD2GEU9YpICCa31D3JoXQGWDz4zEVm7Byj3TXIYK0Rqwjh4FDO
         uPLYRFsrdg4hRp7lrntG8Bi3RkSdooeh8pQAY6XOkOlNRqYwZfNczUgn6a1DLFKmqTqz
         RWxA==
X-Gm-Message-State: AOAM532j6yglX1sTnWqd0rnw8u1oKTBlSZcFBsH0VSn3N4Ba6Lw39Nwn
        tMuipp1IcqY9p9fBQEbU2Natnha6wbFXaWyzgWE=
X-Google-Smtp-Source: ABdhPJyhHIKB4FGHtP3jwCkTR07epcdIGTg6FU/1oyD5wraYT8GY2qS2JF69ii4jNq+94kAnUbsOUIXVdVFH4PXM81M=
X-Received: by 2002:a05:6402:5242:: with SMTP id t2mr2750682edd.240.1631091675019;
 Wed, 08 Sep 2021 02:01:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210829095614.50021-1-kari.argillander@gmail.com>
 <20210907073618.bpz3fmu7jcx5mlqh@kari-VirtualBox> <69c8ab24-9443-59ad-d48d-7765b29f28f9@paragon-software.com>
 <CAHp75Vd==Dm1s=WK9p2q3iEBSHxN-1spHmmtZ21eRNoqyJ5v=Q@mail.gmail.com> <CAC=eVgTwDsE+i3jG+iwZJhFDBXzCyPprRnGk5tjUKXP+Ltrw4w@mail.gmail.com>
In-Reply-To: <CAC=eVgTwDsE+i3jG+iwZJhFDBXzCyPprRnGk5tjUKXP+Ltrw4w@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 8 Sep 2021 12:00:38 +0300
Message-ID: <CAHp75VetzFedGyqaB5TmsBH5UjBYpR8rimGmt8scn5fZ4FRbqg@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] fs/ntfs3: Use new mount api and change some opts
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 7, 2021 at 11:47 PM Kari Argillander
<kari.argillander@gmail.com> wrote:
> On Tuesday, September 7, 2021, Andy Shevchenko
> (andy.shevchenko@gmail.com) wrote:
> > On Tuesday, September 7, 2021, Konstantin Komarov <almaz.alexandrovich@paragon-software.com> wrote:
> >> On 07.09.2021 10:36, Kari Argillander wrote:

...

> >> Yes, everything else seems good.
> >> We tested patches locally - no regression was
> >
> > The formal answer in such case should also contain the Tested-by tag. I would suggest you to read the Submitting Patches document (available in the Linux kernel source tree).
>
> He is a maintainer so he can add tags when he picks this up.

It's a good practice to do so. Moreover, it's better to do it
patch-by-patch, so tools like `b4` can cope with tags for *anybody*
who will use it in automated way.

> This is not
> really relevant here.

Why not?

> Yes it should be good to include that but I have already
> sended v4 which he has not tested. So I really cannot put this tag for him.
> So at the end he really should not even put it here.

For v4 I agree with you.

> Also usually the maintainers will always make their own tests and usually
> they will not even bother with a tested-by tag.

If it's their own code, yes, if it's others', why not? See above as well.

> Or do you say to me that I
> should go read Submitting Patches document as I'm the one who submit
> this?

It's always good to refresh memory, so why not? :-)

-- 
With Best Regards,
Andy Shevchenko
