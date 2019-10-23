Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E398E1E26
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 16:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390007AbfJWO27 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 10:28:59 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:38191 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389521AbfJWO27 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 10:28:59 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MxmBi-1i5ENr47vK-00zICK; Wed, 23 Oct 2019 16:28:58 +0200
Received: by mail-qk1-f176.google.com with SMTP id u22so19897705qkk.11;
        Wed, 23 Oct 2019 07:28:57 -0700 (PDT)
X-Gm-Message-State: APjAAAUpebkaTULw/A7WTcaFgoAZ369yJFKgyFCJMXiAR8nznL2z2oj3
        AkWoDtS1hSVU4qoBZnw+PQaVaSPL4diTKGaETb8=
X-Google-Smtp-Source: APXvYqzP2LPP0EVOvQLFv73W1u8YOBkdDSztlR+gJoeDvIZmUcdwNseA92hgtQnhiy+B/pAU/u5EvOBy39PrXQdnbVo=
X-Received: by 2002:a37:a50f:: with SMTP id o15mr7389101qke.3.1571840936788;
 Wed, 23 Oct 2019 07:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <20191009190853.245077-1-arnd@arndb.de> <20191009191044.308087-10-arnd@arndb.de>
 <d1022cda6bd6ce73e9875644a5a2c65e4d554f37.camel@codethink.co.uk>
 <CAK8P3a0BYkPTSnQUmde2k+HVcg7XNihzWTEzrCD4d8G8ecO9-w@mail.gmail.com>
 <20191022043051.GA20354@ZenIV.linux.org.uk> <CAK8P3a3yutJU83AfxKXTFuCVQwsX50KYsDgbGbHeJJ0JoLbejg@mail.gmail.com>
 <20191023102937.GK3125@piout.net>
In-Reply-To: <20191023102937.GK3125@piout.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 23 Oct 2019 16:28:40 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2+wEH5mtq_vF6fTSkmCfBeKHOvNmjbvViiHFWxUAjV_g@mail.gmail.com>
Message-ID: <CAK8P3a2+wEH5mtq_vF6fTSkmCfBeKHOvNmjbvViiHFWxUAjV_g@mail.gmail.com>
Subject: Re: [Y2038] [PATCH v6 10/43] compat_ioctl: move rtc handling into rtc-dev.c
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:j3q3khfz/zd9/Zc1ZRm1iLAWqMfYAPWxVT1x0kkvwFdE5ei6Jfw
 aJaarYdEiqkKpe1TTRe3WHqtllQb2u/IXAeiqBEwzO+XBA5eEL3jOxpmfeH0Kws0yNCb/nj
 RMkCrNectmQR7z1T/y06NmYB4kVLFTZ7VcZlX3kZOI/zzieqlwv4K56qnW0VIxqllaNtChp
 pBdpaKA4mxA5S7la7CzIw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PiV8fkotnMs=:Wfp8ZqLnz6P85zFhCBlG+x
 qHpx6LvC4+hC+v3wqoQg+oz1+iqg2+dQlEB/xh+gPv1kVd21UbwPxCiTc/PxG2K0lcCfJJp52
 2xIGeZW/7PAnfj24Sf1WJ9zIuSMVckpWfiVvELHPi0NVkvRTU1LBVxhxmyU+azoJv85Xdzt29
 Tq6THYNdrmpkY9V9Bwsr6AOD7SblYjfR+BjLqNVNIieNMb0VowQcNKhfsGPkyjnMvl1gkOV08
 bacWjmCXH7KkzCSRea/Z/ANG7PRqup8oCipTC8A04YKOzpxVYxWYs0dHMxGTfh3KwgxQ7ZXlh
 Rv7lTvcrm5LPGOen8olDOLxUviSHMUt/wfecVy+0MFi7xvv0P0na3dpzt0+E1YmzKonL+hTRd
 oUUJIG3g2bRHKN34Lm2ggWYoeBUXpjuq4xvO6gqW81g02vMpY2l1TptxszXnasUKKE0VQORvK
 B99m0+iEZb9gCXwtWhQKAnuGSxAVJ0Y53SpNN9a9tOR50lEsYeMoy5ONDcpE+cCmF8KEg9qc7
 IrLYGY2GloyYgpR7u7ilwmTomAQpCxFd4GsvHcENdwgGNGdxJg/ZUUTMNhl+cHDiWEtPPRhz/
 PzdyIV/n3GCpurysTvwE1GCRENF1h6wJoLyb9oil5WjCQChurfyDE/5lNMzzcrNYzZz5l6zsM
 9jQOHVI0udONF8/rDyz8vgmr89pdVd/LSdIQf0eyc39HVjbIOYnX5AuLSQo1lu82YNdckDM+6
 Gs1EhWwKiJBtgXL/+89+Yis5J/sEZcrgkFtOSR7nDT9+13zcGuD9+yawnyOLr3M/8M7EjdaOu
 5wypEExuQJR9wQ/ymNmk0ehMIRb8T4KD9gtafFkoa6f1OW9xDUq+RvJJGPfKcObnp+nZb8T7+
 0i04fbpzDneLGNvBheuw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 23, 2019 at 12:29 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> On 22/10/2019 14:14:21+0200, Arnd Bergmann wrote:
> > On Tue, Oct 22, 2019 at 6:30 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > I don't see any chance that this code is revived. If anyone wanted to
> > make it work, the right approach would be to use the rtc framework
> > and rewrite the code first.
> >
> > I could send a patch to remove the dead code though if that helps.
> >
>
> Please do.

Ok, done. Speaking of removing rtc drivers, should we just kill off
drivers/char/rtc.c and drivers/char/efirtc.c as well? I don't remember
why we left them in the tree, but I'm fairly sure they are not actually
needed.

      Arnd
