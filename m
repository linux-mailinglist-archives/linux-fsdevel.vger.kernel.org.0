Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5F378DB00
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238611AbjH3SiQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243176AbjH3KP7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:15:59 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7FF1B0
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 03:15:55 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 843EE623488E;
        Wed, 30 Aug 2023 12:15:53 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id eD9wWK5irV8B; Wed, 30 Aug 2023 12:15:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 72C286234893;
        Wed, 30 Aug 2023 12:15:52 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 42i6GJN1hRBV; Wed, 30 Aug 2023 12:15:52 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 50A97623488E;
        Wed, 30 Aug 2023 12:15:52 +0200 (CEST)
Date:   Wed, 30 Aug 2023 12:15:52 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Christian Brauner <brauner@kernel.org>
Cc:     hch <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Message-ID: <19741192.1872587.1693390552117.JavaMail.zimbra@nod.at>
In-Reply-To: <20230830-strahl-turnier-8e082a720041@brauner>
References: <20230829-vfs-super-mtd-v1-0-fecb572e5df3@kernel.org> <20230830-strahl-turnier-8e082a720041@brauner>
Subject: Re: [PATCH 0/2] mtd: switch to keying by dev_t
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: switch to keying by dev_t
Thread-Index: gLm1MSB29DqL9EllbJF1u7ydMC9EOg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Christian Brauner" <brauner@kernel.org>
> An: "hch" <hch@lst.de>, "Jan Kara" <jack@suse.cz>, "richard" <richard@nod.at>
> CC: "Miquel Raynal" <miquel.raynal@bootlin.com>, "Vignesh Raghavendra" <vigneshr@ti.com>, "linux-mtd"
> <linux-mtd@lists.infradead.org>, "linux-fsdevel" <linux-fsdevel@vger.kernel.org>
> Gesendet: Mittwoch, 30. August 2023 11:50:58
> Betreff: Re: [PATCH 0/2] mtd: switch to keying by dev_t

>> I plan on taking this upstream as a fix during the merge window.
> 
> Btw, I tested this all with jffs2:
> 
> sudo flash_erase -j /dev/mtd0 0 0
> sudo mount -t jffs2 mtd0 /mnt
> 
> and then some variants with racing umounts and mounts.

Good to know!
Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
