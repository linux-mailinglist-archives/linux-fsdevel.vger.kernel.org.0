Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF18278CA00
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 18:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236519AbjH2Qz2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 12:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237597AbjH2QzO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 12:55:14 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230E8CD1
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 09:55:08 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id CFF946418DB6;
        Tue, 29 Aug 2023 18:55:05 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id xl3Y17g1MkGD; Tue, 29 Aug 2023 18:55:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id ECF7C623488D;
        Tue, 29 Aug 2023 18:55:04 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VtTHEh75vM-F; Tue, 29 Aug 2023 18:55:04 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id A93256418DB6;
        Tue, 29 Aug 2023 18:55:04 +0200 (CEST)
Date:   Tue, 29 Aug 2023 18:55:04 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Christian Brauner <brauner@kernel.org>
Cc:     hch <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Message-ID: <340229452.1869458.1693328104443.JavaMail.zimbra@nod.at>
In-Reply-To: <20230829-alpinsport-abwerben-4c19ebb9a437@brauner>
References: <20230829-vfs-super-mtd-v1-0-fecb572e5df3@kernel.org> <20230829-vfs-super-mtd-v1-1-fecb572e5df3@kernel.org> <20230829-alpinsport-abwerben-4c19ebb9a437@brauner>
Subject: Re: [PATCH 1/2] fs: export sget_dev()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: export sget_dev()
Thread-Index: jt9CTlwGHjN4GwA7liSltu9eaRFM8A==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
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
> Gesendet: Dienstag, 29. August 2023 18:29:16
> Betreff: Re: [PATCH 1/2] fs: export sget_dev()

>> +	return sget_fc(fc, super_s_dev_set, super_s_dev_test);
> 
> return sget_fc(fc, super_s_dev_test, super_s_dev_set);
> 
> Sorry, dumb typo that I had already fixed in tree...

What tree does this patch apply to? linux-next?
I gave it a quick try on Linus' tree but it failed too:

fs/super.c: In function ‘get_tree_bdev’:
fs/super.c:1293:19: error: ‘dev’ undeclared (first use in this function); did you mean ‘bdev’?
  s = sget_dev(fc, dev);
                   ^~~
                   bdev
fs/super.c:1293:19: note: each undeclared identifier is reported only once for each function it appears in

Thanks,
//richard
