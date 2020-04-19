Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5FF1AF77A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Apr 2020 08:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgDSGEI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 02:04:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:60428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbgDSGEH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 02:04:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 413BA2076A;
        Sun, 19 Apr 2020 06:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587276247;
        bh=agNi+92Rk4VTgZzA3ehgkSQ9y4v1a+tAYpxKg5s3wAQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2a4P62AV1qdwRJhSwItZe45Wmyq7eJCSCexW9g0a3N4ujoGZ8gNWS52E9mXAEcDMu
         MVTzEtKlOCze+k1ZHx9ZbgImXxdUJq4+HCQIb6h6A/d0jQvRT8FYmdVneCtPIDW3ea
         oBSwXeCSPEAnzjcpBuad/kRHbvJ+xX2EHIlpiMHI=
Date:   Sun, 19 Apr 2020 08:04:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-usb@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        Zzy Wysm <zzy@zzywysm.com>
Subject: Re: [PATCH 7/9] drivers/base: fix empty-body warnings in
 devcoredump.c
Message-ID: <20200419060404.GB3535909@kroah.com>
References: <20200418184111.13401-1-rdunlap@infradead.org>
 <20200418184111.13401-8-rdunlap@infradead.org>
 <20200419060247.GA3535909@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200419060247.GA3535909@kroah.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 19, 2020 at 08:02:47AM +0200, Greg Kroah-Hartman wrote:
> On Sat, Apr 18, 2020 at 11:41:09AM -0700, Randy Dunlap wrote:
> > Fix gcc empty-body warning when -Wextra is used:
> > 
> > ../drivers/base/devcoredump.c:297:42: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
> > ../drivers/base/devcoredump.c:301:42: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
> > 
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Johannes Berg <johannes@sipsolutions.net>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > ---
> >  drivers/base/devcoredump.c |    5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > --- linux-next-20200417.orig/drivers/base/devcoredump.c
> > +++ linux-next-20200417/drivers/base/devcoredump.c
> > @@ -9,6 +9,7 @@
> >   *
> >   * Author: Johannes Berg <johannes@sipsolutions.net>
> >   */
> > +#include <linux/kernel.h>
> 
> Why the need for this .h file being added for reformatting the code?

Ah, the function you add, nevermind, need more coffee...
