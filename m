Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB0F0EDA1B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2019 08:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfKDHs7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Nov 2019 02:48:59 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47579 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfKDHs7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Nov 2019 02:48:59 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1iRX6f-0004bU-Of; Mon, 04 Nov 2019 08:48:57 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1iRX6d-0003bW-Jo; Mon, 04 Nov 2019 08:48:55 +0100
Date:   Mon, 4 Nov 2019 08:48:55 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Jan Kara <jack@suse.com>, Richard Weinberger <richard@nod.at>,
        kernel@pengutronix.de
Subject: Re: [PATCH 01/10] quota: Make inode optional
Message-ID: <20191104074855.plqnfznzvdzxdotf@pengutronix.de>
References: <20191030152702.14269-1-s.hauer@pengutronix.de>
 <20191030152702.14269-2-s.hauer@pengutronix.de>
 <20191101180721.GB23441@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101180721.GB23441@quack2.suse.cz>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:47:43 up 119 days, 13:57, 109 users,  load average: 0.14, 0.14,
 0.10
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 01, 2019 at 07:07:21PM +0100, Jan Kara wrote:
> On Wed 30-10-19 16:26:53, Sascha Hauer wrote:
> > To add support for filesystems which do not store quota informations in
> > an inode make the inode optional.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Umm, I don't quite like how the first three patches work out. I have
> somewhat refactored quota code to make things nicer and allow enabling of
> quotas only with superblock at hand. I'll post the patches once they pass
> some testing early next week.

Ok, thanks. I'll rebase my series onto that then and repost after
integrating the other feedback from you.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
