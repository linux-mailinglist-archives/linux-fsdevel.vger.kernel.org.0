Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02A28F10DF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2019 09:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbfKFIRz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Nov 2019 03:17:55 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49097 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729881AbfKFIRy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Nov 2019 03:17:54 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1iSGVl-0004VZ-GX; Wed, 06 Nov 2019 09:17:53 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1iSGVk-0001TZ-Sa; Wed, 06 Nov 2019 09:17:52 +0100
Date:   Wed, 6 Nov 2019 09:17:52 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/7] quota: Allow quota support without quota files
Message-ID: <20191106081752.6dhmivu2e4qnkb5d@pengutronix.de>
References: <20191104091335.7991-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104091335.7991-1-jack@suse.cz>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:13:24 up 121 days, 14:23, 107 users,  load average: 0.02, 0.10,
 0.12
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jan,

On Mon, Nov 04, 2019 at 11:51:48AM +0100, Jan Kara wrote:
> Hello,
> 
> this patch series refactors quota enabling / disabling code and allows
> filesystems to implement quota support without providing quota files (ubifs
> wants to do this).
> 
> Patches have passed testing with fstests, review is welcome.

Thank you for creating this series. I can confirm my UBIFS quota patches
are working fine on top of this series. I'll send an updated UBIFS quota
series shortly.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
