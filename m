Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A42C73A1CBC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jun 2021 20:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbhFISao convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Wed, 9 Jun 2021 14:30:44 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:56814 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhFISan (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Jun 2021 14:30:43 -0400
X-Greylist: delayed 385 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Jun 2021 14:30:42 EDT
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id B28CA610819B;
        Wed,  9 Jun 2021 20:22:21 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id NzIECcYGWfXl; Wed,  9 Jun 2021 20:22:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 59F426083273;
        Wed,  9 Jun 2021 20:22:21 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HwGQNDz1K7Wk; Wed,  9 Jun 2021 20:22:21 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 1E7456108194;
        Wed,  9 Jun 2021 20:22:21 +0200 (CEST)
Date:   Wed, 9 Jun 2021 20:22:20 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Pintu Agarwal <pintu.ping@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Message-ID: <295072107.94766.1623262940865.JavaMail.zimbra@nod.at>
In-Reply-To: <CAOuPNLiRDZ9M4n3uh=i6FpHXoVEWMHpt0At8YaydrOM=LvSvdg@mail.gmail.com>
References: <CAOuPNLiRDZ9M4n3uh=i6FpHXoVEWMHpt0At8YaydrOM=LvSvdg@mail.gmail.com>
Subject: Re: qemu: arm: mounting ubifs using nandsim on busybox
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: qemu: arm: mounting ubifs using nandsim on busybox
Thread-Index: RJ64NFz5i2HW9LxJVNrur1Kl9viauw==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pintu,

----- Ursprüngliche Mail -----
> Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(31,0)
> =============================
> 
> If any one has used nandsim on qemu before, please let us know the exact steps.

nandsim works as expected. It creates a new and *erased* NAND for you.
So you have no UBI volumes. Therfore UBIFS cannot be mounted.
I suggest creating a tiny initramfs that creates UBI volumes before mounting UBIFS on
one of the freshly created (and empty) volumes.

Thanks,
//richard
