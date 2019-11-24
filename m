Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1649108269
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2019 07:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfKXG7s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Nov 2019 01:59:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:54688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbfKXG7s (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Nov 2019 01:59:48 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0DE6207DD;
        Sun, 24 Nov 2019 06:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574578787;
        bh=UNzsmE29i8Dfl827ajZJktcpVG1uXpzWGf8n5ZHc10o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E9karyhD51OwkLOvTr7SGmIQ7XLXLqGxjURpwZgqTdqTF0rt3zzWG4oiMcAUHJuJJ
         VFm6JoCyqRtDf4PhAuRcv3UJzc363uqjWJINDToAsDtYYcr0y/RmNOP1lTPEjq3DKt
         GDi2rpy4PV/SjGwS2/KNuSciLH835ir9XhRk5D3Q=
Date:   Sun, 24 Nov 2019 07:59:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     kbuild test robot <lkp@intel.com>,
        Namjae Jeon <namjae.jeon@samsung.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@lst.de, linkinjeon@gmail.com, Markus.Elfring@web.de,
        sj1557.seo@samsung.com, dwagner@suse.de, nborisov@suse.com
Subject: Re: Signed-off-by: (was Re: [PATCH] exfat: fix boolreturn.cocci
 warnings
Message-ID: <20191124065944.GA2228207@kroah.com>
References: <20191121052618.31117-13-namjae.jeon@samsung.com>
 <20191123155221.gkukcyakvvfdghcj@4978f4969bb8>
 <329028.1574561358@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <329028.1574561358@turing-police>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 23, 2019 at 09:09:18PM -0500, Valdis Klētnieks wrote:
> On Sat, 23 Nov 2019 23:52:21 +0800, kbuild test robot said:
> > From: kbuild test robot <lkp@intel.com>
> >
> > fs/exfat/file.c:50:10-11: WARNING: return of 0/1 in function 'exfat_allow_set_time' with return type bool
> 
> The warning and fix themselves look OK..
> 
> > Signed-off-by: kbuild test robot <lkp@intel.com>
> 
> But somehow, this strikes me as fishy.
> 
> Or more correctly, it looks reasonable to me, but seems to clash with the
> Developer's Certificate of Origin as described in submitting-patches.rst, which
> makes the assumption that the patch submitter is a carbon-based life form. In
> particular, I doubt the kbuild test robot can understand the thing, and I have
> *no* idea who/what ends up owning the GPLv2 copyright on software automatically
> created by other software.
> 
> Or are we OK on this?

We are ok with this, it's been happening for years and we talked about
it with lawyers when it first happened.  So nothing to really worry
about here.

thanks,

greg k-h
