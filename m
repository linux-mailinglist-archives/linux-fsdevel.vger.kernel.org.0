Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA69347CE1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 16:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236723AbhCXPn6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 11:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236733AbhCXPnw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 11:43:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A88C061763
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Mar 2021 08:43:51 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1lP5fi-0004VB-Dv; Wed, 24 Mar 2021 16:43:50 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1lP5ff-0004sE-SM; Wed, 24 Mar 2021 16:43:47 +0100
Date:   Wed, 24 Mar 2021 16:43:47 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        kernel@pengutronix.de, Jan Kara <jack@suse.com>,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH v3 0/2] quota: Add mountpath based quota support
Message-ID: <20210324154347.GA13990@pengutronix.de>
References: <20210304123541.30749-1-s.hauer@pengutronix.de>
 <20210316112916.GA23532@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316112916.GA23532@quack2.suse.cz>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 16:43:03 up 34 days, 19:06, 89 users,  load average: 0.28, 0.52,
 0.50
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 16, 2021 at 12:29:16PM +0100, Jan Kara wrote:
> On Thu 04-03-21 13:35:38, Sascha Hauer wrote:
> > Current quotactl syscall uses a path to a block device to specify the
> > filesystem to work on which makes it unsuitable for filesystems that
> > do not have a block device. This series adds a new syscall quotactl_path()
> > which replaces the path to the block device with a mountpath, but otherwise
> > behaves like original quotactl.
> > 
> > This is done to add quota support to UBIFS. UBIFS quota support has been
> > posted several times with different approaches to put the mountpath into
> > the existing quotactl() syscall until it has been suggested to make it a
> > new syscall instead, so here it is.
> > 
> > I'm not posting the full UBIFS quota series here as it remains unchanged
> > and I'd like to get feedback to the new syscall first. For those interested
> > the most recent series can be found here: https://lwn.net/Articles/810463/
> 
> Thanks. I've merged the two patches into my tree and will push them to
> Linus for the next merge window.

Thanks by the way. Now that these patches are merged I'll respin my
UBIFS quota series soon.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
