Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A325E1EC7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 17:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406438AbfJWPDS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 11:03:18 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:43569 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390431AbfJWPDS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 11:03:18 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MkYg4-1hjEyo1iKk-00lz8E; Wed, 23 Oct 2019 17:03:16 +0200
Received: by mail-qk1-f172.google.com with SMTP id m4so3105942qke.9;
        Wed, 23 Oct 2019 08:03:16 -0700 (PDT)
X-Gm-Message-State: APjAAAXLQRWelsDDq6VW8HremVfTEJc+tZ95PkZnNRdM/08kUoNcvCON
        A2IolviuxL48u/tB3Q8HNiOM6bjieO6XfxKNQ5I=
X-Google-Smtp-Source: APXvYqxb/oybHp/GwbjiOR9LMf6sQshKj2mYiiKO3OlPOokqW0QjnOPGkDW0AzOpBgUax7ZEFmFmk7GyW7E6epBqv/s=
X-Received: by 2002:a37:58d:: with SMTP id 135mr5703900qkf.394.1571842995129;
 Wed, 23 Oct 2019 08:03:15 -0700 (PDT)
MIME-Version: 1.0
References: <20191009190853.245077-1-arnd@arndb.de> <20191009191044.308087-10-arnd@arndb.de>
 <d1022cda6bd6ce73e9875644a5a2c65e4d554f37.camel@codethink.co.uk>
 <CAK8P3a0BYkPTSnQUmde2k+HVcg7XNihzWTEzrCD4d8G8ecO9-w@mail.gmail.com>
 <20191022043051.GA20354@ZenIV.linux.org.uk> <CAK8P3a3yutJU83AfxKXTFuCVQwsX50KYsDgbGbHeJJ0JoLbejg@mail.gmail.com>
 <20191023102937.GK3125@piout.net> <CAK8P3a2+wEH5mtq_vF6fTSkmCfBeKHOvNmjbvViiHFWxUAjV_g@mail.gmail.com>
 <20191023143436.GN3125@piout.net>
In-Reply-To: <20191023143436.GN3125@piout.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 23 Oct 2019 17:02:58 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1TYPCrKQFX10tbLpDwM9zb8kUNH=90Nn5d01fyqLg0_w@mail.gmail.com>
Message-ID: <CAK8P3a1TYPCrKQFX10tbLpDwM9zb8kUNH=90Nn5d01fyqLg0_w@mail.gmail.com>
Subject: Re: [Y2038] [PATCH v6 10/43] compat_ioctl: move rtc handling into rtc-dev.c
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:QPENz3jfS9XFgtYV/TFdNKMGl6rpS0gD/9MdJSC/g9uAKbEpmWT
 Z7HfjwWJ+QoVAAhrV/MaGWmI7dNSi6HhFeZlnP1DwBDGCEz5R4T4XSZfq7o26E9qR1GTeTb
 oT1z3sFN2YLVZd2MIPfVH8N+/maai+QQgPzn1KoiStzyrQLPmIUM8eM3QTZ0xa6su8mZHku
 pSJY08soz24uKFzRNSahg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/2aHZkd0Fgs=:sZ7rn+lWko0U+YCOexeNPx
 n8bDn51MIOzZkaplxUd6C1GGsEE3UkHrudQZj8YBfHOMaO/CUtWXgv9hbuT4vDh48urw7rh1z
 YrnyiRMbgwmLVH3HSM9JwgyYHeDXz7OXe8LvA6ChA+Fkwpz/2V/jO9M5zr6oF8lsSy5SQlKnX
 oY9V3JYeJLAfR7as0bo92EwZ8/tF4zNzxa2eL9UPL07gGd0qi/ag0+UcYOpMu1+0aIh2KEFOw
 tEfL8+ewpii419vh90symYyVu/69xG9RKNXJpgCn3IrhxuWLLMf1nx9XpMJZummE1tO2sx8Zk
 jOQB0oJBb0d2yAcaIBASQPAvT5WhX6uWOOIjkgyjLf+SoSwgbIQKj7rKH5XymUfq0VbwL0VnY
 7Hz+TrbCyMwxSFd+udzMjL9SqbPqkH/5+U23WhLQ7bPtLHqrZlS5AffkjToJE0oTFitQ+jF0f
 7jle1zwwYBFXFQcMclMPzKpxBZQOrh8alH02ROkYJj+u3ogArwuUqE0jvEcsUUSwmxxB24Wd7
 MiMnxqLTglPD5yJeqUeDNcybVNQ79xomg76N6yzDM8p1KA6yjckep0c+AccvptQdOcZ+gDl1H
 RtnCEaZ3HzCLKCJu/bRONoik7uBMummBca/6NlXL+7Kz4ysyLU5Hg5lLpjNPlCi6gaDUpIE/2
 JyAJH7aYp95pu1tqcSrm2v5LacORYfkGTV2fw3qyT9AWYKc895xHZACZzujY78qWKwQMSwIKN
 C4jGdhoEbM29Wlso5sRalwdEAt3dUZpOmcpjY/GVRI4fUDJ2Vh8RdCz8uLV3LIutmPXj1z4oo
 JEQGhBjKagHlKruHlzuWxxhN69UT5IgcDImBKlQbg+T1W4Nre+OLTYiR1E5ne9MxDvhkdU0iA
 TgA77Jyt0+qu+Ba/BgCA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 23, 2019 at 4:34 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> On 23/10/2019 16:28:40+0200, Arnd Bergmann wrote:
> > Ok, done. Speaking of removing rtc drivers, should we just kill off
> > drivers/char/rtc.c and drivers/char/efirtc.c as well? I don't remember
> > why we left them in the tree, but I'm fairly sure they are not actually
> > needed.
> >
>
> https://lore.kernel.org/lkml/CAK8P3a0QZNY+K+V1HG056xCerz=_L2jh5UfZ+2LWkDqkw5Zznw@mail.gmail.com/
>
> That's how we left it ;)

Right, that is roughly what I remembered. Sending a patch to remove them
now, let's see if anyone cares.

          Arnd
