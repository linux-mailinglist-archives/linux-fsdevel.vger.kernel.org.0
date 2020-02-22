Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3F20168D7B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2020 09:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgBVIHQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Feb 2020 03:07:16 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:34631 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgBVIHP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Feb 2020 03:07:15 -0500
Received: from mail-lf1-f49.google.com ([209.85.167.49]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MOzfO-1img6m1muK-00PPN4; Sat, 22 Feb 2020 09:07:12 +0100
Received: by mail-lf1-f49.google.com with SMTP id s23so3185669lfs.10;
        Sat, 22 Feb 2020 00:07:12 -0800 (PST)
X-Gm-Message-State: APjAAAUERwCvXvfjPktZvxZvux4aBnbtp9P35O/TrUejem6kA48vhnWq
        afcYUy01GmsjFZw8KKXjaFN8ssB9XvvVXa2LFRM=
X-Google-Smtp-Source: APXvYqwpdYKZMO/96bj/N5vKrJ0LU+hK+ga1Pp5razsbdMm6ufUcmfcVDWHaahAN/oc9qEUtOll9vonbHUzwZQVvLp4=
X-Received: by 2002:a19:c1cc:: with SMTP id r195mr10024414lff.173.1582358831729;
 Sat, 22 Feb 2020 00:07:11 -0800 (PST)
MIME-Version: 1.0
References: <20190822192451.5983-1-scott.branden@broadcom.com>
 <20190822192451.5983-3-scott.branden@broadcom.com> <s5hef1crybq.wl-tiwai@suse.de>
 <10461fcf-9eca-32b6-0f9d-23c63b3f3442@broadcom.com> <s5hr258j6ln.wl-tiwai@suse.de>
 <93b8285a-e5eb-d4a4-545d-426bbbeb8008@broadcom.com> <s5ho90byhnv.wl-tiwai@suse.de>
 <b440f372-45be-c06c-94a1-44ae6b1e7eb8@broadcom.com> <s5hwoeyj3i5.wl-tiwai@suse.de>
 <20191011133120.GP16384@42.do-not-panic.com> <e65a3ba1-d064-96fe-077e-59bf8ffff377@broadcom.com>
 <CAK8P3a2NJurg_hxVbWYZwJVhYM5-xjWt12Kh0DdyfTGqQPrPAQ@mail.gmail.com> <3731a882-8784-b957-7628-49edfa9683e7@broadcom.com>
In-Reply-To: <3731a882-8784-b957-7628-49edfa9683e7@broadcom.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 22 Feb 2020 09:06:55 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0WWeNxaLYZBOipsALu_Y9isY6jKjRy9tc4Xokktoa1Pg@mail.gmail.com>
Message-ID: <CAK8P3a0WWeNxaLYZBOipsALu_Y9isY6jKjRy9tc4Xokktoa1Pg@mail.gmail.com>
Subject: Re: [PATCH 2/7] firmware: add offset to request_firmware_into_buf
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, Takashi Iwai <tiwai@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:VSS0lrE+jTxSYsb/3xTXnnGOMtXSAO7qXek1a9Rhtelg8xUYL0k
 fYS3SFDkUeYRUIun/OF7XYx+FDGgQn70Q0idx6i8+7cupOe8RkJsdjX/lKIHsqK8mkzUIn+
 z7Kc2hOUQxxOaim+CfznkvXqaZOGsexPB0JupZqg+oSQbP/9jWLqK4La6+Kzg8oodyGRyQy
 +cK9sVsoiY3AkxbmFUxHg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sKEdyQlfYT8=:lOsUdoWyit+edBrSNGaJH6
 fxEvNN89AAEeHmesWC6DvvGMy3EZnNAF/yrfLlpan6ioYigGgldWsfteZ6UsI8Em6rY4w+0BL
 VnuGSpt+OlrmQZz14DIgcbFjiUgO0tKivCIX6yUVVuOw+FKvNcFfLUWcOmBXb3yOOt/TdChDb
 KKnrICkid7Rymi22DdDqYhj6i32MOOcnGOF/qfwjmdnsb/iIxwk6AQC2vPYd3npVHj0E/sKeV
 +CKfnHYYnemOD2oWRCBGirjRmB87PJY9Np+lzuFLZ0kp1rF15H0yelAm7WDHqxkT3EcMDfLSP
 K5Yl9Bz1NIQidm0B9g8Ys2ea2tH2ALly0oAMyJT1iOHjUX+X3o5Ybc6q4R2YePmCRbstctlhp
 lUxTY4TJk742AZFu9MhD9d+tqDJtiVpfAClRvckTKiZ2iCwwJPRGOeEdxNGvCzk750hxpPNwF
 lPFCyRZSAgAdCmNAjW1JX/pDp/2jwuyHUgt0ddwsF2fUBYnoUQEDoPN1xxKlrEBwOGo3Oy45Z
 eaPMINxrznxDg+eqLLM+oHyxyvRuAdS/xls023biXYhy72kNSRqJOEtHDlCbdy8uKY2VPUH2S
 8SbHjeD6181EPf2ZeXq0hLgQRNBkxCKFFKgyFY7bDrf8xCLMLgvKcmPzNfK0AsHAeN/m94ZZ+
 yOe/B706FUVu4iqKKIybavt7uzKk2rIpk/wwHKBfsRs3+wB6/gYUQtZSUZJQ7OiWsESX+N1QT
 Voi3IGbWAasmARnf/J1KJFJwWSlCcqdxLWzyt6Y9CxVbSNiiogO9R3fuDgrQDtjCXcqRcwhMA
 bRk2mjg5n5HSQcMnvIEK1ZrODImlNYCelQ20HpDXqniLe3IfHw=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 22, 2020 at 12:37 AM Scott Branden
<scott.branden@broadcom.com> wrote:
> On 2020-02-21 12:44 a.m., Arnd Bergmann wrote:
> > On Fri, Feb 21, 2020 at 1:11 AM Scott Branden
> > <scott.branden@broadcom.com> wrote:
> >> On 2019-10-11 6:31 a.m., Luis Chamberlain wrote:
> >>> On Tue, Aug 27, 2019 at 12:40:02PM +0200, Takashi Iwai wrote:
> >>>> On Mon, 26 Aug 2019 19:24:22 +0200,
> >>>> Scott Branden wrote:
> >>>>> I will admit I am not familiar with every subtlety of PCI
> >>>>> accesses. Any comments to the Valkyrie driver in this patch series are
> >>>>> appreciated.
> >>>>> But not all drivers need to work on all architectures. I can add a
> >>>>> depends on x86 64bit architectures to the driver to limit it to such.
> >>>> But it's an individual board on PCIe, and should work no matter which
> >>>> architecture is?  Or is this really exclusive to x86?
> >>> Poke Scott.
> >> Yes, this is exclusive to x86.
> >> In particular, 64-bit x86 server class machines with PCIe gen3 support.
> >> There is no reason for these PCIe boards to run in other lower end
> >> machines or architectures.
> > It doesn't really matter that much what you expect your customers to
> > do with your product, or what works a particular machine today, drivers
> > should generally be written in a portable manner anyway and use
> > the documented APIs. memcpy() into an __iomem pointer is not
> > portable and while it probably works on any x86 machine today, please
> > just don't do it. If you use 'sparse' to check your code, that would normally
> > result in an address space warning, unless you add __force and a
> > long comment explaining why you cannot just use memcpy_to_io()
> > instead. At that point, you are already better off usingn memcpy_to_io() ;-)
> >
> >          Arnd
> I am a not performing a memcpy at all right now.
> I am calling a request_firmware_into_buf call and do not need to make a
> copy.
> This function eventually calls kernel_read_file, which then makes at
> indirect call in __vfs_read to perform the read to memory.

Well, that comes down to a memcpy() in the end, even if you don't
spell it like that in your driver. It may be a copy_from_user(), but
clearly not a memcpy_to_io().

>  From there I am lost as to what operation happens to achieve this.
> The read function would need to detect the buf is in io space and
> perform the necessary operation.
> Anyone with any knowledge on how to make this read to io space would be
> appreciated?

I don't think modifying the common code is helpful in this case:
any access to PCI MMIO space is inevitably going to be slow, so
an extra memcpy() in your driver is not going to cause any noticeable
overhead, but the generic functions are meant to be fast for the
normal use case and not gain any other features.

       Arnd
