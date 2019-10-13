Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE52D5807
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Oct 2019 22:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbfJMUUy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Oct 2019 16:20:54 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43536 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbfJMUUy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Oct 2019 16:20:54 -0400
Received: by mail-lj1-f194.google.com with SMTP id n14so14533180ljj.10
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Oct 2019 13:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eJmSPxWD5/TkHbFJUcVPXh6iFR/S6K/PI1RETNfV6+Q=;
        b=F06ZA8X2/ZCMYGLX0R+bf2JXirE2mkKo7IKs4CYOx5tLbue+pdhZGlAlH+MMsJTsSI
         JJhOLZ3SHIGQ5/J8Vp7sV6c23/uIAr/0wnjI+wmnPX+pGWhBIOqPiagnxJJBrXOmjf7F
         atW5/J+N+Y2hPd11tAYDnE+8xGz6Q+ljHks94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eJmSPxWD5/TkHbFJUcVPXh6iFR/S6K/PI1RETNfV6+Q=;
        b=biyXIQ64lacc+GB4eBkt5jK89E3+WM3AyXiJgrgtYAuh6xk6lNPWa24YI78eC+2mnO
         FXl1OuPONWM9QnaBfwcdty2eW79WZe/PWTQx9yZIujPZ95HCixaO0TSTTknuzR65ctup
         hM09agnvyJXxP4LHs3DeXyzQdxKe2yTSePdmwI5TNZtviG0Rgbf8wL98nVamrxcIDE9E
         d/ibRATqu9MQ2L+Z71uMsET4yjhQRQF2EL4xUSlclCymLTlFSjS3v+IW63GmlS7ARlfy
         P6yOhaTo7B6Vv2/ObpMtTga2gPes93EICLSDgpRr1Z3lijBO9XRQRh2G0nReFz2MsMwl
         iooA==
X-Gm-Message-State: APjAAAU/eUe4vQe2ahjSUcRSJDPnX6SrsZLBPFWf6Ez4tCxzfHXn26Fy
        lswSm1reZDd6/8YGjVA+DUhtnlaBChI=
X-Google-Smtp-Source: APXvYqy1w+9NFkrGmrqiX3NCiW4WN1O/G+543motOMI9AwPUS/gU5ngFMR9QY6wo8PhpCIV+f4CfIQ==
X-Received: by 2002:a2e:9759:: with SMTP id f25mr5740499ljj.173.1570998051872;
        Sun, 13 Oct 2019 13:20:51 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id c18sm4243756ljd.27.2019.10.13.13.20.50
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Oct 2019 13:20:50 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id c195so10328057lfg.9
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Oct 2019 13:20:50 -0700 (PDT)
X-Received: by 2002:a05:6512:219:: with SMTP id a25mr15490954lfo.61.1570998050112;
 Sun, 13 Oct 2019 13:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiAyZmsEp6oQQgHiuaDU0bLj=OVHSGV_OfvHRSXNPYABw@mail.gmail.com>
 <CAHk-=wgOWxqwqCFuP_Bw=Hxxf9njeHJs0OLNGNc63peNd=kRqw@mail.gmail.com>
 <20191010195504.GI26530@ZenIV.linux.org.uk> <CAHk-=wgWRQo0m7TUCK4T_J-3Vqte+p-FWzvT3CB1jJHgX-KctA@mail.gmail.com>
 <20191011001104.GJ26530@ZenIV.linux.org.uk> <CAHk-=wgg3jzkk-jObm1FLVYGS8JCTiKppEnA00_QX7Wsm5ieLQ@mail.gmail.com>
 <20191013181333.GK26530@ZenIV.linux.org.uk> <CAHk-=wgrWGyACBM8N8KP7Pu_2VopuzM4A12yQz6Eo=X2Jpwzcw@mail.gmail.com>
 <20191013191050.GL26530@ZenIV.linux.org.uk> <CAHk-=wjJNE9hOKuatqh6SFf4nd65LG4ZR3gQSgg+rjSpVxe89w@mail.gmail.com>
 <20191013195949.GM26530@ZenIV.linux.org.uk>
In-Reply-To: <20191013195949.GM26530@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 13 Oct 2019 13:20:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgO1EW5qVuy7=sc9Kua98-afMx75gaeX4FHKf3+wPLmkw@mail.gmail.com>
Message-ID: <CAHk-=wgO1EW5qVuy7=sc9Kua98-afMx75gaeX4FHKf3+wPLmkw@mail.gmail.com>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to unsafe_put_user()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 13, 2019 at 12:59 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Re plotting: how strongly would you object against passing the range to
> user_access_end()?  Powerpc folks have a very close analogue of stac/clac,
> currently buried inside their __get_user()/__put_user()/etc. - the same
> places where x86 does, including futex.h and friends.
>
> And there it's even costlier than on x86.  It would obviously be nice
> to lift it at least out of unsafe_get_user()/unsafe_put_user() and
> move into user_access_begin()/user_access_end(); unfortunately, in
> one subarchitecture they really want it the range on the user_access_end()
> side as well.

Hmm. I'm ok with that.

Do they want the actual range, or would it prefer some kind of opaque
cookie that user_access_begin() returns (where 0 would mean "failure"
of course)?

I'm thinking like a local_irq_save/restore thing, which might be the
case on yet other architectures.

         Linus
