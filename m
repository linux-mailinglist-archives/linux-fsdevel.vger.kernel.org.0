Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C64551677DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 09:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731672AbgBUIoz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 03:44:55 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:46791 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729786AbgBUIoy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:44:54 -0500
Received: from mail-qv1-f42.google.com ([209.85.219.42]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Mcp3E-1jdZfK1u6s-00Zwen; Fri, 21 Feb 2020 09:44:52 +0100
Received: by mail-qv1-f42.google.com with SMTP id s6so677553qvq.4;
        Fri, 21 Feb 2020 00:44:51 -0800 (PST)
X-Gm-Message-State: APjAAAVAU/ImSor+Ax3laoPhdKX5HRhehG0LGNGTI/C3F2tU/AC+9LXl
        LPR4Dha7noghjKvkCg8FI3YIhvkEzHm1xzWsFfg=
X-Google-Smtp-Source: APXvYqzj1wLcyLw4ngVb5K8R3sXCBn2n0mT50jnZtzTAPCNVFsS4L0kHny9k1yvtFZI5LzSCmfqqMbz+qs/vG+JMXNI=
X-Received: by 2002:ad4:52eb:: with SMTP id p11mr27330655qvu.211.1582274691062;
 Fri, 21 Feb 2020 00:44:51 -0800 (PST)
MIME-Version: 1.0
References: <20190822192451.5983-1-scott.branden@broadcom.com>
 <20190822192451.5983-3-scott.branden@broadcom.com> <s5hef1crybq.wl-tiwai@suse.de>
 <10461fcf-9eca-32b6-0f9d-23c63b3f3442@broadcom.com> <s5hr258j6ln.wl-tiwai@suse.de>
 <93b8285a-e5eb-d4a4-545d-426bbbeb8008@broadcom.com> <s5ho90byhnv.wl-tiwai@suse.de>
 <b440f372-45be-c06c-94a1-44ae6b1e7eb8@broadcom.com> <s5hwoeyj3i5.wl-tiwai@suse.de>
 <20191011133120.GP16384@42.do-not-panic.com> <e65a3ba1-d064-96fe-077e-59bf8ffff377@broadcom.com>
In-Reply-To: <e65a3ba1-d064-96fe-077e-59bf8ffff377@broadcom.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 21 Feb 2020 09:44:35 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2NJurg_hxVbWYZwJVhYM5-xjWt12Kh0DdyfTGqQPrPAQ@mail.gmail.com>
Message-ID: <CAK8P3a2NJurg_hxVbWYZwJVhYM5-xjWt12Kh0DdyfTGqQPrPAQ@mail.gmail.com>
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
X-Provags-ID: V03:K1:R+5/2IwZLX0GpLbPDDVE48wJ9xBdmfM+8J7qrFfyCmHlAdtRw1R
 /K5hbg4vcItdPyeaI2gMUPQvAe3KI+g8fgumg/ys5OrFhj8SXXMHDaRwP/jTMjNeqk1Ihux
 tdMUA47Dtk2OinScdeJ30BbZ6Kq/L/WCgUa4fXW5HpJBIROPbCh5l0wVoloceAtugRhPeXX
 AmXilR8SPDoKmyxcwyyGA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:eW7GHi9pDno=:KM/eM3AxK8K6bT4Ho8Ua8x
 DoTGO8zJuIuTsCjvL3EX3mLRg/BDoTwyy2kDNAI3C/EFolMNYvPhaOemr5GeZPvaEkZyyrb3P
 Vtymm4/0ToYA8ChWUkYnYC//AiL6lBLZ1ce4MpOx61HYqLuByrn4dEtFseN/SzMbJhWQB8c6y
 e12I3t7jcpcF5tTuRUOG5zi5vy7hfgfWxc4lSvmun6RQO7I7Injs0jJICjMhiY+QM4jY8rSyJ
 twMj/WT9zxXZlKzHJYeyjymFxx5cOSX3uV4K9adpGym4r93DbjjY/aZzYDOauH51rhZV1y4Ow
 isS71V71BjskgDHI040qtt18alRqXXlmPLpJSBUYtiZ8+As4zojeKOwfKFwANYUnYUU5Ksmh2
 dyhTXohPPEaWKCWks5K3WK321Pg9ADnjGoQH5z8aeCRXoqJtZcSG5jovP05xjsjz2GT6RBcUn
 NZA8LRg9eBbu/Y9G+x9inOZ7q2GVnPoofJ0mplDc7ly4Aw+MIFgp7WxOtry6zeN8Z+Eoav75l
 EnJCA07/eED8AdHSqhuK2KKPagerm1mhIuySFhfhhexH3sIYwMfLrTj7mCvCetuVz6fYgUBb7
 6+8789HV4V74skaCgtCwunj/qLwA85KCuZCUxaMCnv1Co126ZNaNLwu11I4pXMawMHeP3t6q6
 pCW0zHSUHfKwNW7wejLqzdaV1Ya47jba1lRzvDqfNz6MHSLIL0vHS0zbYRQz/Sg2KdaZ6gted
 2j5SL4SlxBeg7UtcsUOTP6j+MWHIr7HFSySoxw1nIt6nJldnGFXx3wSd8gworWeqIHaEfKzDv
 7z2wxMGTrgTuerVtnbyrJfJ8+2CkBIj0/7pjWy4kNAazDzt7Bk=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 21, 2020 at 1:11 AM Scott Branden
<scott.branden@broadcom.com> wrote:
> On 2019-10-11 6:31 a.m., Luis Chamberlain wrote:
> > On Tue, Aug 27, 2019 at 12:40:02PM +0200, Takashi Iwai wrote:
> >> On Mon, 26 Aug 2019 19:24:22 +0200,
> >> Scott Branden wrote:
> >>> I will admit I am not familiar with every subtlety of PCI
> >>> accesses. Any comments to the Valkyrie driver in this patch series are
> >>> appreciated.
> >>> But not all drivers need to work on all architectures. I can add a
> >>> depends on x86 64bit architectures to the driver to limit it to such.
> >> But it's an individual board on PCIe, and should work no matter which
> >> architecture is?  Or is this really exclusive to x86?
> >
> > Poke Scott.
>
> Yes, this is exclusive to x86.
> In particular, 64-bit x86 server class machines with PCIe gen3 support.
> There is no reason for these PCIe boards to run in other lower end
> machines or architectures.

It doesn't really matter that much what you expect your customers to
do with your product, or what works a particular machine today, drivers
should generally be written in a portable manner anyway and use
the documented APIs. memcpy() into an __iomem pointer is not
portable and while it probably works on any x86 machine today, please
just don't do it. If you use 'sparse' to check your code, that would normally
result in an address space warning, unless you add __force and a
long comment explaining why you cannot just use memcpy_to_io()
instead. At that point, you are already better off usingn memcpy_to_io() ;-)

        Arnd
