Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42C9E104516
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 21:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfKTUbE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 15:31:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:52394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbfKTUbD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 15:31:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3057B2075E;
        Wed, 20 Nov 2019 20:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574281862;
        bh=ZAsD94r5JDGs9DmQJh/W8WRcSASA5q7vIIXbKGEe0lw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mx4EUAuwL6jDFV1VYKbYUS+OG4hYLZIe3/ZLXdbc04gtf/GY3QVknsNM444T3atsM
         w7pj3GssEFwHP6NoecFM3TFk+NUD5V7soS+ddUSHhyDxQ3V26q+mVpRS8KUpDr2IP+
         ghrdFGrHWsCILfgseb5fdvClDlKtbHxZfSF3V9Ng=
Date:   Wed, 20 Nov 2019 21:31:00 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Daniel Wagner <dwagner@suse.de>,
        Nikolay Borisov <nborisov@suse.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linkinjeon@gmail.com
Subject: Re: [PATCH v3 01/13] exfat: add in-memory and on-disk structures and
 headers
Message-ID: <20191120203100.GA3109949@kroah.com>
References: <20191119093718.3501-1-namjae.jeon@samsung.com>
 <CGME20191119094020epcas1p26de9d7e4e2ab8ad5d6ecaf23e2dfdca8@epcas1p2.samsung.com>
 <20191119093718.3501-2-namjae.jeon@samsung.com>
 <30222888-e62e-494e-269e-cb1a0746a01f@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <30222888-e62e-494e-269e-cb1a0746a01f@web.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 20, 2019 at 09:21:13PM +0100, Markus Elfring wrote:
> …
> > +++ b/fs/exfat/exfat_fs.h
> …
> > +/* balloc.c */
> > +int exfat_load_bitmap(struct super_block *sb);
> …
> 
> Such function declarations were grouped according to the mentioned
> source file.
> How do you think about to include them from separate header files
> for the desired programming interface?

No.
