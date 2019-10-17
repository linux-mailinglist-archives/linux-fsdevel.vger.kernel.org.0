Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 125B8DA776
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2019 10:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408238AbfJQIc2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Oct 2019 04:32:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:47828 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388788AbfJQIc2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Oct 2019 04:32:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9F7E5B73E;
        Thu, 17 Oct 2019 08:32:26 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2F4061E485F; Thu, 17 Oct 2019 10:32:26 +0200 (CEST)
Date:   Thu, 17 Oct 2019 10:32:26 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@lists.codethink.co.uk, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fsnotify: move declaration of
 fsnotify_mark_connector_cachep to fsnotify.h
Message-ID: <20191017083226.GB20260@quack2.suse.cz>
References: <20191015132518.21819-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015132518.21819-1-ben.dooks@codethink.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 15-10-19 14:25:18, Ben Dooks wrote:
> Move fsnotify_mark_connector_cachep to fsnotify.h to properly
> share it with the user in mark.c and avoid the following warning
> from sparse:
> 
> fs/notify/mark.c:82:19: warning: symbol 'fsnotify_mark_connector_cachep' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

OK, fair enough. Applied. Thanks for the patch.

								Honza

> ---
> Cc: Jan Kara <jack@suse.cz>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  fs/notify/fsnotify.c | 2 --
>  fs/notify/fsnotify.h | 2 ++
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 2ecef6155fc0..3e77b728a22b 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -381,8 +381,6 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_is,
>  }
>  EXPORT_SYMBOL_GPL(fsnotify);
>  
> -extern struct kmem_cache *fsnotify_mark_connector_cachep;
> -
>  static __init int fsnotify_init(void)
>  {
>  	int ret;
> diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
> index f3462828a0e2..ff2063ec6b0f 100644
> --- a/fs/notify/fsnotify.h
> +++ b/fs/notify/fsnotify.h
> @@ -65,4 +65,6 @@ extern void __fsnotify_update_child_dentry_flags(struct inode *inode);
>  extern struct fsnotify_event_holder *fsnotify_alloc_event_holder(void);
>  extern void fsnotify_destroy_event_holder(struct fsnotify_event_holder *holder);
>  
> +extern struct kmem_cache *fsnotify_mark_connector_cachep;
> +
>  #endif	/* __FS_NOTIFY_FSNOTIFY_H_ */
> -- 
> 2.23.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
