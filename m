Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBA478D332
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 08:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235893AbjH3GOO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 02:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237425AbjH3GNw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 02:13:52 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1142CD7
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 23:13:49 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 054CF6732D; Wed, 30 Aug 2023 08:13:46 +0200 (CEST)
Date:   Wed, 30 Aug 2023 08:13:45 +0200
From:   hch <hch@lst.de>
To:     Richard Weinberger <richard@nod.at>
Cc:     Christian Brauner <brauner@kernel.org>, hch <hch@lst.de>,
        Jan Kara <jack@suse.cz>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/2] fs: export sget_dev()
Message-ID: <20230830061345.GA17785@lst.de>
References: <20230829-vfs-super-mtd-v1-0-fecb572e5df3@kernel.org> <20230829-vfs-super-mtd-v1-1-fecb572e5df3@kernel.org> <20230829-alpinsport-abwerben-4c19ebb9a437@brauner> <340229452.1869458.1693328104443.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <340229452.1869458.1693328104443.JavaMail.zimbra@nod.at>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 29, 2023 at 06:55:04PM +0200, Richard Weinberger wrote:
> What tree does this patch apply to? linux-next?
> I gave it a quick try on Linus' tree but it failed too:
> 
> fs/super.c: In function ‘get_tree_bdev’:
> fs/super.c:1293:19: error: ‘dev’ undeclared (first use in this function); did you mean ‘bdev’?
>   s = sget_dev(fc, dev);
>                    ^~~
>                    bdev
> fs/super.c:1293:19: note: each undeclared identifier is reported only once for each function it appears in

Should be against the latest Linus tree after the merge of the vfs
branches yesterday.

