Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D657F130B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2019 10:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfKFJ7N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Nov 2019 04:59:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:51284 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727239AbfKFJ7N (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Nov 2019 04:59:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EC3E8B028;
        Wed,  6 Nov 2019 09:59:11 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B81A91E47E5; Wed,  6 Nov 2019 10:59:11 +0100 (CET)
Date:   Wed, 6 Nov 2019 10:59:11 +0100
From:   Jan Kara <jack@suse.cz>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/7] quota: Allow quota support without quota files
Message-ID: <20191106095911.GB16085@quack2.suse.cz>
References: <20191104091335.7991-1-jack@suse.cz>
 <20191106081752.6dhmivu2e4qnkb5d@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106081752.6dhmivu2e4qnkb5d@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 06-11-19 09:17:52, Sascha Hauer wrote:
> Hi Jan,
> 
> On Mon, Nov 04, 2019 at 11:51:48AM +0100, Jan Kara wrote:
> > Hello,
> > 
> > this patch series refactors quota enabling / disabling code and allows
> > filesystems to implement quota support without providing quota files (ubifs
> > wants to do this).
> > 
> > Patches have passed testing with fstests, review is welcome.
> 
> Thank you for creating this series. I can confirm my UBIFS quota patches
> are working fine on top of this series. I'll send an updated UBIFS quota
> series shortly.

Thanks for testing! I've pushed the series to linux-next so that it gets
wider exposure and will send it to Linus in the next maintenance window.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
