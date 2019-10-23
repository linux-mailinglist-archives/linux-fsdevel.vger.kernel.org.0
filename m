Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7FEE1E3F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 16:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392232AbfJWOek (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 10:34:40 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:54531 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732328AbfJWOek (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 10:34:40 -0400
X-Originating-IP: 92.137.17.54
Received: from localhost (alyon-657-1-975-54.w92-137.abo.wanadoo.fr [92.137.17.54])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id A562DFF815;
        Wed, 23 Oct 2019 14:34:37 +0000 (UTC)
Date:   Wed, 23 Oct 2019 16:34:36 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Y2038] [PATCH v6 10/43] compat_ioctl: move rtc handling into
 rtc-dev.c
Message-ID: <20191023143436.GN3125@piout.net>
References: <20191009190853.245077-1-arnd@arndb.de>
 <20191009191044.308087-10-arnd@arndb.de>
 <d1022cda6bd6ce73e9875644a5a2c65e4d554f37.camel@codethink.co.uk>
 <CAK8P3a0BYkPTSnQUmde2k+HVcg7XNihzWTEzrCD4d8G8ecO9-w@mail.gmail.com>
 <20191022043051.GA20354@ZenIV.linux.org.uk>
 <CAK8P3a3yutJU83AfxKXTFuCVQwsX50KYsDgbGbHeJJ0JoLbejg@mail.gmail.com>
 <20191023102937.GK3125@piout.net>
 <CAK8P3a2+wEH5mtq_vF6fTSkmCfBeKHOvNmjbvViiHFWxUAjV_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2+wEH5mtq_vF6fTSkmCfBeKHOvNmjbvViiHFWxUAjV_g@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 23/10/2019 16:28:40+0200, Arnd Bergmann wrote:
> On Wed, Oct 23, 2019 at 12:29 PM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> > On 22/10/2019 14:14:21+0200, Arnd Bergmann wrote:
> > > On Tue, Oct 22, 2019 at 6:30 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > I don't see any chance that this code is revived. If anyone wanted to
> > > make it work, the right approach would be to use the rtc framework
> > > and rewrite the code first.
> > >
> > > I could send a patch to remove the dead code though if that helps.
> > >
> >
> > Please do.
> 
> Ok, done. Speaking of removing rtc drivers, should we just kill off
> drivers/char/rtc.c and drivers/char/efirtc.c as well? I don't remember
> why we left them in the tree, but I'm fairly sure they are not actually
> needed.
> 

https://lore.kernel.org/lkml/CAK8P3a0QZNY+K+V1HG056xCerz=_L2jh5UfZ+2LWkDqkw5Zznw@mail.gmail.com/

That's how we left it ;)

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
