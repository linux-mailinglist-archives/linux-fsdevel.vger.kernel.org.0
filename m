Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 373B3DEAFA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 13:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbfJULcN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 07:32:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43736 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbfJULcN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 07:32:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id c2so8302568wrr.10;
        Mon, 21 Oct 2019 04:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dmRonkI3afpK0imoXn1gq5xR7xj6dy0LkZHT5B+WJK4=;
        b=WAB+IVuKri7jyIS+XrkdoQjF/G1NPV05XAIxTDCvTQWJKxQzUkQgo2hySIbm2mQM0W
         JExD82SpklgFPYFn/C0cyfEwjnkn3bTM/i9fzxcMFiCT9nYtCUXvRowCdR1KMFuYQE5n
         Ee6XfNvGgmykJ3mdNEQ68xHCLwARAQCEeFkvqGxzO4Y4wzFS9DDuMBt/wOcb6odAeky5
         KVJKGsryqDF6E0edd0XHPOvRfdZgotLjgd5yf9xDAGrgrUBbNZNmcwd/LqLPNignYlrr
         YU2aSXwoqmNZ1Qs1UCcHASroQAQAuQ57sTmuWGbxZEbAa8ePKRJplh5UdrXmI1wzAc65
         9SZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dmRonkI3afpK0imoXn1gq5xR7xj6dy0LkZHT5B+WJK4=;
        b=YZZdJICk/kWCqq1LqEnAkGS67R1S3KCu5EUtqqOxaXj4Ln+uiQRRmMKd1gYuOZeTHg
         NFzPlmkR7+0vCtR9NtVlzvz1os0tZKZ3yeihkxDO+ar2lpSZb3AkmvXy0yuqJPcQwYSa
         ojDkq4pThkKzDkQ+TOCSIqbDWBR8VYYDzha8lndp16+cU2a3guPDKLGco5mWgRp3pWrt
         Tz3q6a5JT+FShxLtd3mOGvWvqTgHoUZAT/fRcgdXYhatEMM0VaHNcArjUMSuJiGjToWH
         gtp78PI1cviIvFTrCI2IWKHJPvd2/oZvololysqwl3gWXoDJ9OX/ZrhAlvxYgp3R1/zr
         3r5w==
X-Gm-Message-State: APjAAAWABCLC9FD4JDSUsxkPWNMsLl99F0C7/nnyHT7Dvg+0YxhGYLA4
        4gcq45G+8q6ZA/D6Pp6y6U1gOK6Sgx6Kuls6Z+s13jg2El4=
X-Google-Smtp-Source: APXvYqz+ZPbQLozAQPGPER0WaspvJJddEsUd8jsTQ7g1P2xNiYmNSqmTPpYmSVUbh64hlbHHCu7ymudOIHJcBIQ34/g=
X-Received: by 2002:a5d:5544:: with SMTP id g4mr892556wrw.72.1571657531203;
 Mon, 21 Oct 2019 04:32:11 -0700 (PDT)
MIME-Version: 1.0
References: <453A1153-9493-4A04-BF66-CE6A572DEBDB@paragon-software.com>
 <CAFLxGvyFBGiDab4wxWidjRyDgWkHVfigVsHiRDB4swpB3G+hvQ@mail.gmail.com>
 <20191021105409.32okvzbslxmcjdze@pali> <0877502e-8369-9cfd-36e8-5a4798260cd4@redhat.com>
 <20191021111357.q2lg2g43y7hrddqi@pali>
In-Reply-To: <20191021111357.q2lg2g43y7hrddqi@pali>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Mon, 21 Oct 2019 13:31:59 +0200
Message-ID: <CAFLxGvyWtWUm81-qyQ-F20bt1pL7_C6rRsCzO84QSLs=gxMDAg@mail.gmail.com>
Subject: Re: [PATCH] fs: exFAT read-only driver GPL implementation by Paragon Software.
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     Maurizio Lombardi <mlombard@redhat.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 21, 2019 at 1:13 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrot=
e:
> On Monday 21 October 2019 13:08:07 Maurizio Lombardi wrote:
> > Dne 21.10.2019 v 12:54 Pali Roh=C3=A1r napsal(a):
> Maurizio, thank you for reference! I have not caught this Samsung
> activity yet! So we now we have +1 for count of exFAT drivers.

This is how I counted three exfat drivers.
1. staging/exfat (old samsung driver)
2. sdfat (new samsung dirver)
3. paragon read-only

--=20
Thanks,
//richard
