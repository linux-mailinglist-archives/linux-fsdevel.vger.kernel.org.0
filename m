Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8A018E854
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Mar 2020 12:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgCVLXU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Mar 2020 07:23:20 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35015 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgCVLXT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Mar 2020 07:23:19 -0400
Received: by mail-wm1-f67.google.com with SMTP id m3so11202453wmi.0;
        Sun, 22 Mar 2020 04:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F8mcezLWlN1D+aaiCPvy8WRKCEUgqEGkNNa4pF/Y1i8=;
        b=j0Uf4Ty8I3Yt63MRcEZywxTkeeKs2MT+buv25ZfPPcJHv+cfgUfAUEttHOspG+VPR+
         2i6rqZgwcM1+1n7BIEKl2+dHBcPyEopbpnwrFRiQwkJeWq+4XMI8ZtViom6AnbzaaiBF
         3pFrWIRwNSMWgw1FcWHKPzvi4yiJvwzn6tctMnaszNi/PkpIvH4I5oUkZckXedgdFFHw
         y18OajtONQ+dwpl++o7XMj3Fa40g6nMa05XXDLT7m7l6VUxhsBrTZGhnIuXEPqwp/CdS
         CuVT34HTMliAzORkNubrzCZz76LVjWiwSg4BIbKzHV4XhbBHruBK1L/gJMPfBkjEAtxb
         zktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=F8mcezLWlN1D+aaiCPvy8WRKCEUgqEGkNNa4pF/Y1i8=;
        b=tZdZNRymQ5NVIt1+bw5lIZqJlgbQqqLBkOrLSESGkPxH6vcFZRTAD1rd8E6+9tiGjR
         VzFsulcXJRHRiSkAFI+CxOuxj2zRjQ5Se+sBq05i4y+cZxBXxqOwNXahbPSnrfCNjlTM
         A0F6bL9Ox5Qj+xIRhhyZRk16D3QB3rQZfnASV5YK1+lOsXuO4vhlyjG7gLsEWv3Esk0B
         2vGYrxDyOr5if8OclwF/qQVblqxf2xs/EGMAXkbkPIO5tL1ntGP02MqL9olDrDOEY/iF
         CsJtsVUxgVK67uSHRx5UV14fPrYub8e1wvRRRA0F+8oFOiwNIZ71r6MLeack54UkxSwz
         UFHw==
X-Gm-Message-State: ANhLgQ2RpnhlRoRRdz9/mBn+E2kvTblL5GT/dJg1R0aomkx8UMGp5rgU
        Cfizn6XCuGzE2R2iWqsd1ww=
X-Google-Smtp-Source: ADFU+vt1RWdKfg6+qOcvt+s4OrsW32NVTMMe1MgQBwBUt6VJ4O01V3nkEowEu0oTU7OAys8hfBPkGg==
X-Received: by 2002:a7b:cc96:: with SMTP id p22mr4694618wma.118.1584876197072;
        Sun, 22 Mar 2020 04:23:17 -0700 (PDT)
Received: from dumbo (ip4da2e549.direct-adsl.nl. [77.162.229.73])
        by smtp.gmail.com with ESMTPSA id k204sm2886587wma.17.2020.03.22.04.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 04:23:16 -0700 (PDT)
Date:   Sun, 22 Mar 2020 12:23:14 +0100
From:   Domenico Andreoli <domenico.andreoli@linux.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org, mkleinsoft@gmail.com,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2] hibernate: Allow uswsusp to write to swap
Message-ID: <20200322112314.GA22738@dumbo>
References: <20200304170646.GA31552@dumbo>
 <5202091.FuziMeULnI@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5202091.FuziMeULnI@kreacher>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 22, 2020 at 08:14:21AM +0100, Rafael J. Wysocki wrote:
> On Wednesday, March 4, 2020 6:06:46 PM CET Domenico Andreoli wrote:
> > From: Domenico Andreoli <domenico.andreoli@linux.com>
> > 
> > It turns out that there is one use case for programs being able to
> > write to swap devices, and that is the userspace hibernation code.
> > 
> > Quick fix: disable the S_SWAPFILE check if hibernation is configured.
> > 
> > Fixes: dc617f29dbe5 ("vfs: don't allow writes to swap files")
> > Reported-by: Domenico Andreoli <domenico.andreoli@linux.com>
> > Reported-by: Marian Klein <mkleinsoft@gmail.com>
> > Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
> > 
> > v2:
> >  - use hibernation_available() instead of IS_ENABLED(CONFIG_HIBERNATE)
> >  - make Fixes: point to the right commit
> 
> This looks OK to me.
> 
> Has it been taken care of already, or am I expected to apply it?

I don't know who is supposed to take it, I did not receive any notification.

> 
> > ---
> >  fs/block_dev.c |    4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > Index: b/fs/block_dev.c
> > ===================================================================
> > --- a/fs/block_dev.c
> > +++ b/fs/block_dev.c
> > @@ -34,6 +34,7 @@
> >  #include <linux/task_io_accounting_ops.h>
> >  #include <linux/falloc.h>
> >  #include <linux/uaccess.h>
> > +#include <linux/suspend.h>
> >  #include "internal.h"
> >  
> >  struct bdev_inode {
> > @@ -2001,7 +2002,8 @@ ssize_t blkdev_write_iter(struct kiocb *
> >  	if (bdev_read_only(I_BDEV(bd_inode)))
> >  		return -EPERM;
> >  
> > -	if (IS_SWAPFILE(bd_inode))
> > +	/* uswsusp needs write permission to the swap */
> > +	if (IS_SWAPFILE(bd_inode) && !hibernation_available())
> >  		return -ETXTBSY;
> >  
> >  	if (!iov_iter_count(from))
> > 
> 
> 
> 
> 

-- 
rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05
