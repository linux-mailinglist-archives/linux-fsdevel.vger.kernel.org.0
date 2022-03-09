Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644874D31B3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Mar 2022 16:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbiCIP1U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 10:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiCIP1T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 10:27:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BF19F6EB;
        Wed,  9 Mar 2022 07:26:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ADBDAB82206;
        Wed,  9 Mar 2022 15:26:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 061A3C340E8;
        Wed,  9 Mar 2022 15:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646839578;
        bh=wE8WScMA30oNgZIX8sgYX722g0p0ycgmgh/CjHL+/9w=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=saBHRU4rxxqAcFBQKx8VXhVd6Txoc8aJG9uJ8Y2DdijC8a6sESxud37tDU6VI6LpN
         LEGtepyE0wLYuFchvbMlHh+APL6RmUim4Uauz2QLj35GhT3/yynrYMkndXBu3rTXUL
         HVAm5j7okn3Lw3uBthbQ38cWSm7PTv1KXX4kBbxuJDARAYqjvS02bBwwe60C3/2WJs
         WB+6mn4Azf+jRxi7ukfUPFXcUMI2Ose765kUGV/vzSBrSzz1KlYYPBpACr7LqRQff+
         V2JtM5G0UfLKMCfY/oORRVoyolYe+JD+aNY5oO+dNETtfNRYozYh4joHKh8Ko/vtw6
         SLHP8MQv9n5dA==
Message-ID: <9132b97b5e52fec9c2838b31739175619df3e752.camel@kernel.org>
Subject: Re: [PATCH v2 01/19] fscache: export fscache_end_operation()
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        David Wysochanski <dwysocha@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 09 Mar 2022 10:26:15 -0500
In-Reply-To: <164678190346.1200972.7453733431978569479.stgit@warthog.procyon.org.uk>
References: <164678185692.1200972.597611902374126174.stgit@warthog.procyon.org.uk>
         <164678190346.1200972.7453733431978569479.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2022-03-08 at 23:25 +0000, David Howells wrote:
> From: Jeffle Xu <jefflexu@linux.alibaba.com>
> 
> Export fscache_end_operation() to avoid code duplication.
> 
> Besides, considering the paired fscache_begin_read_operation() is
> already exported, it shall make sense to also export
> fscache_end_operation().
> 

Not what I think of when you say "exporting" but the patch itself looks
fine.

> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-cachefs@redhat.com
> 
> Link: https://lore.kernel.org/r/20220302125134.131039-2-jefflexu@linux.alibaba.com/ # Jeffle's v4
> Link: https://lore.kernel.org/r/164622971432.3564931.12184135678781328146.stgit@warthog.procyon.org.uk/ # v1
> ---
> 
>  fs/cifs/fscache.c       |    8 --------
>  fs/fscache/internal.h   |   11 -----------
>  fs/nfs/fscache.c        |    8 --------
>  include/linux/fscache.h |   14 ++++++++++++++
>  4 files changed, 14 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/cifs/fscache.c b/fs/cifs/fscache.c
> index 33af72e0ac0c..b47c2011ce5b 100644
> --- a/fs/cifs/fscache.c
> +++ b/fs/cifs/fscache.c
> @@ -134,14 +134,6 @@ void cifs_fscache_release_inode_cookie(struct inode *inode)
>  	}
>  }
>  
> -static inline void fscache_end_operation(struct netfs_cache_resources *cres)
> -{
> -	const struct netfs_cache_ops *ops = fscache_operation_valid(cres);
> -
> -	if (ops)
> -		ops->end_operation(cres);
> -}
> -
>  /*
>   * Fallback page reading interface.
>   */
> diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
> index f121c21590dc..ed1c9ed737f2 100644
> --- a/fs/fscache/internal.h
> +++ b/fs/fscache/internal.h
> @@ -70,17 +70,6 @@ static inline void fscache_see_cookie(struct fscache_cookie *cookie,
>  			     where);
>  }
>  
> -/*
> - * io.c
> - */
> -static inline void fscache_end_operation(struct netfs_cache_resources *cres)
> -{
> -	const struct netfs_cache_ops *ops = fscache_operation_valid(cres);
> -
> -	if (ops)
> -		ops->end_operation(cres);
> -}
> -
>  /*
>   * main.c
>   */
> diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
> index cfe901650ab0..39654ca72d3d 100644
> --- a/fs/nfs/fscache.c
> +++ b/fs/nfs/fscache.c
> @@ -249,14 +249,6 @@ void nfs_fscache_release_file(struct inode *inode, struct file *filp)
>  	}
>  }
>  
> -static inline void fscache_end_operation(struct netfs_cache_resources *cres)
> -{
> -	const struct netfs_cache_ops *ops = fscache_operation_valid(cres);
> -
> -	if (ops)
> -		ops->end_operation(cres);
> -}
> -
>  /*
>   * Fallback page reading interface.
>   */
> diff --git a/include/linux/fscache.h b/include/linux/fscache.h
> index 296c5f1d9f35..d2430da8aa67 100644
> --- a/include/linux/fscache.h
> +++ b/include/linux/fscache.h
> @@ -456,6 +456,20 @@ int fscache_begin_read_operation(struct netfs_cache_resources *cres,
>  	return -ENOBUFS;
>  }
>  
> +/**
> + * fscache_end_operation - End the read operation for the netfs lib
> + * @cres: The cache resources for the read operation
> + *
> + * Clean up the resources at the end of the read request.
> + */
> +static inline void fscache_end_operation(struct netfs_cache_resources *cres)
> +{
> +	const struct netfs_cache_ops *ops = fscache_operation_valid(cres);
> +
> +	if (ops)
> +		ops->end_operation(cres);
> +}
> +
>  /**
>   * fscache_read - Start a read from the cache.
>   * @cres: The cache resources to use
> 
> 

Reviewed-by: Jeff Layton <jlayton@kernel.org>
