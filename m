Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E279A68B202
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Feb 2023 22:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjBEVuJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Feb 2023 16:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjBEVuI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Feb 2023 16:50:08 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B221816C
        for <linux-fsdevel@vger.kernel.org>; Sun,  5 Feb 2023 13:50:05 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id s8so4878248pgg.11
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Feb 2023 13:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h7yJpiP9ttw5sFfLyFtqc0KGl8DklAykC2zfpl3J1T0=;
        b=Sy6WO6aUbt4hKJI79krfYMxHyrk8VlNpZFJCscjnaf0dsl5WUq31QJSrKvkMtQIaza
         EihA37h2D2LwC+6MaXmtTMsPZL/p9MyUxMS9kdpzLDu0jEeMTwRw17E10TchJzuiLTyp
         jrGU7LZSvlpKECTzI6x2jpq7GW6foI37PRVUtckaO+b++7hmWyYymrrrdJucpnk0IGcA
         7fUy8W0DeTe6f9XQ0rXzO6B+K0YyjsIoWs0iGHMbi3zvdTe2V/dN4y80uskdkr7ryzrO
         /zKGNWHUODK7nylWFEqljJV+7XUzs4LKVVUb4h4mpsMLzFO2Xln/JIVQW7jF3oC1bKid
         lkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7yJpiP9ttw5sFfLyFtqc0KGl8DklAykC2zfpl3J1T0=;
        b=Y6uv/Z6haV2IRi2fwwNIxlY5QAKIOSE7n03XfoYk0r0kpzWvcYxxjA3wqnWetYlh+Z
         W4SO1Nkpe/wiSKs2IvIBvGz3D4bo7Md7Cm1eUJlp9u3fFiTXXOZVlOXWNrKcjhvmWS+C
         FPNBiRauhVULn53FY7eyp4Hn0DtkR8HYlGfSQSu8Is5sxTNiAQt56VYzH0r8GDUqhqLR
         ZKvu13PnKnyNvnqIzn/wMdxjxuvsea74oA6GI3mgo8POQe/O29rF4l9GDdNhs0wUOgIE
         F020Tzr2o0tWwhaP/AoWjpJ7+ifPWadUSsdyQNdhAZNbGJ1vacyioSaLV8OkkzuvbIkS
         aQfA==
X-Gm-Message-State: AO0yUKV2ER4Cba9i16OQ0RnAGwdopm5zT0uDwcUk1vODLcsQWQ8BUeZx
        4BrifZvfAUyI2lq8gTNBvGs8MA==
X-Google-Smtp-Source: AK7set/Qbh4FDtzACwf+BWf7UNO2tnGdJAA6iW0zDj8wSxkzi8r3CMK8bAHVC0ZExvoKYvkFgHaAyQ==
X-Received: by 2002:a62:1dc2:0:b0:592:4502:fb0 with SMTP id d185-20020a621dc2000000b0059245020fb0mr16441670pfd.0.1675633805007;
        Sun, 05 Feb 2023 13:50:05 -0800 (PST)
Received: from dread.disaster.area (pa49-181-4-128.pa.nsw.optusnet.com.au. [49.181.4.128])
        by smtp.gmail.com with ESMTPSA id y10-20020a056a001c8a00b0058119caa82csm5497038pfw.205.2023.02.05.13.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 13:50:04 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pOmtc-00Bo2z-SX; Mon, 06 Feb 2023 08:50:00 +1100
Date:   Mon, 6 Feb 2023 08:50:00 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, jane.chu@oracle.com
Subject: Re: [PATCH v9 3/3] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
Message-ID: <20230205215000.GT360264@dread.disaster.area>
References: <1675522718-88-1-git-send-email-ruansy.fnst@fujitsu.com>
 <1675522718-88-4-git-send-email-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1675522718-88-4-git-send-email-ruansy.fnst@fujitsu.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 04, 2023 at 02:58:38PM +0000, Shiyang Ruan wrote:
> This patch is inspired by Dan's "mm, dax, pmem: Introduce
> dev_pagemap_failure()"[1].  With the help of dax_holder and
> ->notify_failure() mechanism, the pmem driver is able to ask filesystem
> (or mapped device) on it to unmap all files in use and notify processes
> who are using those files.

.....

> @@ -182,12 +188,24 @@ xfs_dax_notify_failure(
>  	struct xfs_mount	*mp = dax_holder(dax_dev);
>  	u64			ddev_start;
>  	u64			ddev_end;
> +	int			error;
>  
>  	if (!(mp->m_super->s_flags & SB_BORN)) {
>  		xfs_warn(mp, "filesystem is not ready for notify_failure()!");
>  		return -EIO;
>  	}
>  
> +	if (mf_flags & MF_MEM_PRE_REMOVE) {
> +		xfs_info(mp, "device is about to be removed!");
> +		down_write(&mp->m_super->s_umount);
> +		error = sync_filesystem(mp->m_super);
> +		/* invalidate_inode_pages2() invalidates dax mapping */
> +		super_drop_pagecache(mp->m_super, invalidate_inode_pages2);
> +		up_write(&mp->m_super->s_umount);

I really don't like this.

super_drop_pagecache() doesn't guarantee that everything is removed
from cache. It is racy - it doesn't touch inodes being freed or
being instantiated, nor does it prevent concurrent accesses to the
inodes from re-instantiating page cache pages and dirtying them
after the inode has been scanned by super_drop_pagecache().

If we are about to remove the block device and we want to guarantee
that the filesystem is cleaned and stable before the device gets
yanked out from under running applications, then we have to
guarantee that we stall the running applications trying to modify
the filesystem between the MF_MEM_PRE_REMOVE and the actual removal
event that then shuts down the filesystem. Invalidating the page
cache is not enough to guarantee this.

Keep in mind that we're going to walk the rmap after writing the
data to kill any processes that have mmap()d files in the filesystem
after we've dropped the page cache - the page cache invalidation
doesn't change this at all - and this will kill any active userspace
DAX mappings before the device is unplugged. So I don't actually see
how walking the page cache to invalidate it here actually helps
"invalidate dax mapping" reliably as new write page faults on dax
VMAs can still occur between super_drop_pagecache() and the rmap
walk triggering kills on processes with DAX mapped VMAs.

We also don't care if read-only operations race with device unplug -
they are going to get EIO the moment the device is actually
unplugged or the filesystem is shutdown anyway, so it doesn't matter
if reads race with the device remove event.  Hence all we really
care about here is not dirtying the filesystem after we've started
processing the MF_MEM_PRE_REMOVE event.

Realistically, I think we need to freeze the filesystem here to
prevent racing modifications occurring during the rmap + VMA walk +
proc kill. That could be write() IO dirtying new data or other
transactions running dirtying the journal/metadata. Both
sync_filesystem() and super_drop_pagecache() operate on current
state - they don't prevent future dax mapping instantiation or
dirtying from happening on the device, so they don't prevent this...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
