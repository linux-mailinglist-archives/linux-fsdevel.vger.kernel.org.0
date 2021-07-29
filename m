Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E843DA268
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jul 2021 13:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbhG2Lpu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jul 2021 07:45:50 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:46474 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbhG2Lpu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jul 2021 07:45:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 93E5D60A59E0;
        Thu, 29 Jul 2021 13:45:45 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id aO_TuqCBAGxP; Thu, 29 Jul 2021 13:45:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 3EEFA60A59E2;
        Thu, 29 Jul 2021 13:45:45 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ubc79fz-8zcI; Thu, 29 Jul 2021 13:45:45 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 15DB260A59E0;
        Thu, 29 Jul 2021 13:45:45 +0200 (CEST)
Date:   Thu, 29 Jul 2021 13:45:44 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Pintu Agarwal <pintu.ping@gmail.com>,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>,
        Greg KH <greg@kroah.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Sean Nyekjaer <sean@geanix.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Phillip Lougher <phillip@squashfs.org.uk>
Message-ID: <1668790824.35266.1627559144878.JavaMail.zimbra@nod.at>
In-Reply-To: <CAAEAJfCY+X-G=7Oe9NqrJ4yQZ29DBA78jOFAX44GD0g6=s7qhg@mail.gmail.com>
References: <CAOuPNLjzyG_2wGDYmwgeoQuuQ7cykJ11THf8jMrOFXZ7vXheJQ@mail.gmail.com> <CAOuPNLh_KY4NaVWSEV2JPp8fx0iy8E1MU8GHT-w7-hMXrvSaeA@mail.gmail.com> <1556211076.48404.1626763215205.JavaMail.zimbra@nod.at> <CAOuPNLhti3tocN-_D7Q0QaAx5acHpb3AQyWaUKgQPNW3XWu58g@mail.gmail.com> <2132615832.4458.1626900868118.JavaMail.zimbra@nod.at> <CAOuPNLhCMT7QTF+QadJyGDFNshH9VjEAzWStRpe8itw7HXve=A@mail.gmail.com> <CAFLxGvywv29u6DJZrJxnJJmUDSQ4xpbT0u5LNKY1uGKyQom+WA@mail.gmail.com> <CAAEAJfCY+X-G=7Oe9NqrJ4yQZ29DBA78jOFAX44GD0g6=s7qhg@mail.gmail.com>
Subject: Re: MTD: How to get actual image size from MTD partition
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF90 (Linux)/8.8.12_GA_3809)
Thread-Topic: How to get actual image size from MTD partition
Thread-Index: o5rhXDaMb949oL+oV/E2gN2BDVZpgg==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ezequiel,

----- Ursprüngliche Mail -----
> [snip]
> 
> Ouch, so surprised that after all these years someone is doing squashfs/mtdblock
> instead of using ubiblock :-)
> 
> Can we patch either Kconfig or add some warn_once on mtdblock
> usage, suggesting to use ubiblock instead?

a hint in Kconfig makes IMHO sense. Do you want to send a patch?
A warning is too much since on some tiny embedded system with NOR flash mtdblock is still
a good choice.
ubiblock is mostly useful for NAND flash.

> I remember there was still some use case(s) for mtdblock but I can't remember
> now what was it, perhaps we should document the expectations?
> (Is that for JFFS2 to mount?)

a long time ago mount didn't accept character devices, so you had to pass mtdblockX to mount
JFFS2.
This limitation is gone.

Thanks,
//richard
