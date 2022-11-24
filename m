Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0C263734E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Nov 2022 09:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiKXIHv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Nov 2022 03:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiKXIHu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Nov 2022 03:07:50 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B312E21E04
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Nov 2022 00:07:48 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id w4so840074plp.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Nov 2022 00:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iM0lTfYIhETIe2iFkmswE6KgPm9P1o45ifSWjqS2kL4=;
        b=wHBWJu7XnahJRNfHski75v0ebXsfggZ9mxRunLaXrimWr77OZKf1RzA5GqGB6cACTG
         hC6wX9IKSb0Xbm8xxkNbtohoLNxXB04sU7eauz8EQkvX/fKsM0H5ZgSyaYH7FgELFPQc
         21/3lCLUmnS1cUCZWnaKMK69S5+RlynNwY6f1yw4nHQH8cTxcoWkkrylJ6piX3hcu3oj
         LIN/Jomo1Kom9iFCF921rIBg2Gt4wAcOH0XFwS0dZHl9AvYbCdLlnqO9XlBpXOhnGS6N
         e/HaDtCE9dycBKttx3jw+1XbDVr8cqRrcSbJMxiHVSTIUUie8mPQEEVNaCNEaGyDLnPf
         M0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iM0lTfYIhETIe2iFkmswE6KgPm9P1o45ifSWjqS2kL4=;
        b=MA27eJRbUco+z43ZvXNUUjil3hDx5wjPvccpHeuElbpiMcuiKugbzG8gBZwNf6emCK
         /vTh2Jb8+jubDYSTMHeH2aAahV/tGLa+RGZW/UsC6oMJy5GeY9so4A+AqW4jwOD8plIc
         MXOOAxm0zKIhjN3SmNnYt9Ni4pk0SnA4XT8stRiI2w+mJDwTHge7maANHsIUjxndxYMh
         GLe2yStx8vbABM4KguotQ4xIgKXL4pXmYG+73yuiYEFaVVS9XVKFzieY4hL5g7+91VHe
         1AKvGqlR86FB78zXxCnzUTOdoK7+ihmbpZ6dojhkgmori51NYiipX3Y+TVeEhKJRtjUe
         EjRQ==
X-Gm-Message-State: ANoB5pnz3kGO/oF20PV1M3Y1/A2/uzJBnSNgQHCVtZykWalvKriBp8fa
        qgRrT5+pVt9jfqxxI93Hbsu04A==
X-Google-Smtp-Source: AA0mqf4IiNFSAOrxBSxpg6zWv8oDD+4/IuodLjfEz8dZnd30u3VgZZvbsCqs9I5+E8aU3QDr2TMjdA==
X-Received: by 2002:a17:90a:dc06:b0:218:9196:1cd1 with SMTP id i6-20020a17090adc0600b0021891961cd1mr27437978pjv.230.1669277268155;
        Thu, 24 Nov 2022 00:07:48 -0800 (PST)
Received: from [10.5.67.213] ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id c14-20020aa7952e000000b005745481a614sm555587pfp.76.2022.11.24.00.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 00:07:47 -0800 (PST)
Message-ID: <2250d2e8-f996-4d58-3679-775bcfd5a8dc@bytedance.com>
Date:   Thu, 24 Nov 2022 16:07:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [Linux-cachefs] [PATCH v5 2/2] erofs: switch to
 prepare_ondemand_read() in fscache mode
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, dhowells@redhat.com,
        jlayton@kernel.org, xiang@kernel.org, chao@kernel.org,
        linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221124034212.81892-1-jefflexu@linux.alibaba.com>
 <20221124034212.81892-3-jefflexu@linux.alibaba.com>
From:   Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <20221124034212.81892-3-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2022/11/24 11:42, Jingbo Xu 写道:
> Switch to prepare_ondemand_read() interface and a self-contained request
> completion to get rid of netfs_io_[request|subrequest].
> 
> The whole request will still be split into slices (subrequest) according
> to the cache state of the backing file.  As long as one of the
> subrequests fails, the whole request will be marked as failed.
> 
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
Thanks.
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
>   fs/erofs/fscache.c | 261 ++++++++++++++++-----------------------------
>   1 file changed, 94 insertions(+), 167 deletions(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index af5ed6b9c54d..3cfe1af7a46e 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -11,257 +11,180 @@ static DEFINE_MUTEX(erofs_domain_cookies_lock);
>   static LIST_HEAD(erofs_domain_list);
>   static struct vfsmount *erofs_pseudo_mnt;
>   
> -static struct netfs_io_request *erofs_fscache_alloc_request(struct address_space *mapping,
> +struct erofs_fscache_request {
> +	struct netfs_cache_resources cache_resources;
> +	struct address_space	*mapping;	/* The mapping being accessed */
> +	loff_t			start;		/* Start position */
> +	size_t			len;		/* Length of the request */
> +	size_t			submitted;	/* Length of submitted */
> +	short			error;		/* 0 or error that occurred */
> +	refcount_t		ref;
> +};
> +
> +static struct erofs_fscache_request *erofs_fscache_req_alloc(struct address_space *mapping,
>   					     loff_t start, size_t len)
>   {
> -	struct netfs_io_request *rreq;
> +	struct erofs_fscache_request *req;
>   
> -	rreq = kzalloc(sizeof(struct netfs_io_request), GFP_KERNEL);
> -	if (!rreq)
> +	req = kzalloc(sizeof(struct erofs_fscache_request), GFP_KERNEL);
> +	if (!req)
>   		return ERR_PTR(-ENOMEM);
>   
> -	rreq->start	= start;
> -	rreq->len	= len;
> -	rreq->mapping	= mapping;
> -	rreq->inode	= mapping->host;
> -	INIT_LIST_HEAD(&rreq->subrequests);
> -	refcount_set(&rreq->ref, 1);
> -	return rreq;
> -}
> -
> -static void erofs_fscache_put_request(struct netfs_io_request *rreq)
> -{
> -	if (!refcount_dec_and_test(&rreq->ref))
> -		return;
> -	if (rreq->cache_resources.ops)
> -		rreq->cache_resources.ops->end_operation(&rreq->cache_resources);
> -	kfree(rreq);
> -}
> -
> -static void erofs_fscache_put_subrequest(struct netfs_io_subrequest *subreq)
> -{
> -	if (!refcount_dec_and_test(&subreq->ref))
> -		return;
> -	erofs_fscache_put_request(subreq->rreq);
> -	kfree(subreq);
> -}
> +	req->mapping = mapping;
> +	req->start   = start;
> +	req->len     = len;
> +	refcount_set(&req->ref, 1);
>   
> -static void erofs_fscache_clear_subrequests(struct netfs_io_request *rreq)
> -{
> -	struct netfs_io_subrequest *subreq;
> -
> -	while (!list_empty(&rreq->subrequests)) {
> -		subreq = list_first_entry(&rreq->subrequests,
> -				struct netfs_io_subrequest, rreq_link);
> -		list_del(&subreq->rreq_link);
> -		erofs_fscache_put_subrequest(subreq);
> -	}
> +	return req;
>   }
>   
> -static void erofs_fscache_rreq_unlock_folios(struct netfs_io_request *rreq)
> +static void erofs_fscache_req_complete(struct erofs_fscache_request *req)
>   {
> -	struct netfs_io_subrequest *subreq;
>   	struct folio *folio;
> -	unsigned int iopos = 0;
> -	pgoff_t start_page = rreq->start / PAGE_SIZE;
> -	pgoff_t last_page = ((rreq->start + rreq->len) / PAGE_SIZE) - 1;
> -	bool subreq_failed = false;
> +	bool failed = req->error;
> +	pgoff_t start_page = req->start / PAGE_SIZE;
> +	pgoff_t last_page = ((req->start + req->len) / PAGE_SIZE) - 1;
>   
> -	XA_STATE(xas, &rreq->mapping->i_pages, start_page);
> -
> -	subreq = list_first_entry(&rreq->subrequests,
> -				  struct netfs_io_subrequest, rreq_link);
> -	subreq_failed = (subreq->error < 0);
> +	XA_STATE(xas, &req->mapping->i_pages, start_page);
>   
>   	rcu_read_lock();
>   	xas_for_each(&xas, folio, last_page) {
> -		unsigned int pgpos, pgend;
> -		bool pg_failed = false;
> -
>   		if (xas_retry(&xas, folio))
>   			continue;
> -
> -		pgpos = (folio_index(folio) - start_page) * PAGE_SIZE;
> -		pgend = pgpos + folio_size(folio);
> -
> -		for (;;) {
> -			if (!subreq) {
> -				pg_failed = true;
> -				break;
> -			}
> -
> -			pg_failed |= subreq_failed;
> -			if (pgend < iopos + subreq->len)
> -				break;
> -
> -			iopos += subreq->len;
> -			if (!list_is_last(&subreq->rreq_link,
> -					  &rreq->subrequests)) {
> -				subreq = list_next_entry(subreq, rreq_link);
> -				subreq_failed = (subreq->error < 0);
> -			} else {
> -				subreq = NULL;
> -				subreq_failed = false;
> -			}
> -			if (pgend == iopos)
> -				break;
> -		}
> -
> -		if (!pg_failed)
> +		if (!failed)
>   			folio_mark_uptodate(folio);
> -
>   		folio_unlock(folio);
>   	}
>   	rcu_read_unlock();
> +
> +	if (req->cache_resources.ops)
> +		req->cache_resources.ops->end_operation(&req->cache_resources);
> +
> +	kfree(req);
>   }
>   
> -static void erofs_fscache_rreq_complete(struct netfs_io_request *rreq)
> +static void erofs_fscache_req_put(struct erofs_fscache_request *req)
>   {
> -	erofs_fscache_rreq_unlock_folios(rreq);
> -	erofs_fscache_clear_subrequests(rreq);
> -	erofs_fscache_put_request(rreq);
> +	if (refcount_dec_and_test(&req->ref))
> +		erofs_fscache_req_complete(req);
>   }
>   
> -static void erofc_fscache_subreq_complete(void *priv,
> +static void erofs_fscache_subreq_complete(void *priv,
>   		ssize_t transferred_or_error, bool was_async)
>   {
> -	struct netfs_io_subrequest *subreq = priv;
> -	struct netfs_io_request *rreq = subreq->rreq;
> +	struct erofs_fscache_request *req = priv;
>   
>   	if (IS_ERR_VALUE(transferred_or_error))
> -		subreq->error = transferred_or_error;
> -
> -	if (atomic_dec_and_test(&rreq->nr_outstanding))
> -		erofs_fscache_rreq_complete(rreq);
> -
> -	erofs_fscache_put_subrequest(subreq);
> +		req->error = transferred_or_error;
> +	erofs_fscache_req_put(req);
>   }
>   
>   /*
> - * Read data from fscache and fill the read data into page cache described by
> - * @rreq, which shall be both aligned with PAGE_SIZE. @pstart describes
> - * the start physical address in the cache file.
> + * Read data from fscache (cookie, pstart, len), and fill the read data into
> + * page cache described by (req->mapping, lstart, len). @pstart describeis the
> + * start physical address in the cache file.
>    */
>   static int erofs_fscache_read_folios_async(struct fscache_cookie *cookie,
> -				struct netfs_io_request *rreq, loff_t pstart)
> +		struct erofs_fscache_request *req, loff_t pstart, size_t len)
>   {
>   	enum netfs_io_source source;
> -	struct super_block *sb = rreq->mapping->host->i_sb;
> -	struct netfs_io_subrequest *subreq;
> -	struct netfs_cache_resources *cres = &rreq->cache_resources;
> +	struct super_block *sb = req->mapping->host->i_sb;
> +	struct netfs_cache_resources *cres = &req->cache_resources;
>   	struct iov_iter iter;
> -	loff_t start = rreq->start;
> -	size_t len = rreq->len;
> +	loff_t lstart = req->start + req->submitted;
>   	size_t done = 0;
>   	int ret;
>   
> -	atomic_set(&rreq->nr_outstanding, 1);
> +	DBG_BUGON(len > req->len - req->submitted);
>   
>   	ret = fscache_begin_read_operation(cres, cookie);
>   	if (ret)
> -		goto out;
> +		return ret;
>   
>   	while (done < len) {
> -		subreq = kzalloc(sizeof(struct netfs_io_subrequest),
> -				 GFP_KERNEL);
> -		if (subreq) {
> -			INIT_LIST_HEAD(&subreq->rreq_link);
> -			refcount_set(&subreq->ref, 2);
> -			subreq->rreq = rreq;
> -			refcount_inc(&rreq->ref);
> -		} else {
> -			ret = -ENOMEM;
> -			goto out;
> -		}
> -
> -		subreq->start = pstart + done;
> -		subreq->len	=  len - done;
> -		subreq->flags = 1 << NETFS_SREQ_ONDEMAND;
> +		loff_t sstart = pstart + done;
> +		size_t slen = len - done;
> +		unsigned long flags = 1 << NETFS_SREQ_ONDEMAND;
>   
> -		list_add_tail(&subreq->rreq_link, &rreq->subrequests);
> -
> -		source = cres->ops->prepare_read(subreq, LLONG_MAX);
> -		if (WARN_ON(subreq->len == 0))
> +		source = cres->ops->prepare_ondemand_read(cres,
> +				sstart, &slen, LLONG_MAX, &flags, 0);
> +		if (WARN_ON(slen == 0))
>   			source = NETFS_INVALID_READ;
>   		if (source != NETFS_READ_FROM_CACHE) {
> -			erofs_err(sb, "failed to fscache prepare_read (source %d)",
> -				  source);
> -			ret = -EIO;
> -			subreq->error = ret;
> -			erofs_fscache_put_subrequest(subreq);
> -			goto out;
> +			erofs_err(sb, "failed to fscache prepare_read (source %d)", source);
> +			return -EIO;
>   		}
>   
> -		atomic_inc(&rreq->nr_outstanding);
> +		refcount_inc(&req->ref);
> +		iov_iter_xarray(&iter, READ, &req->mapping->i_pages,
> +				lstart + done, slen);
>   
> -		iov_iter_xarray(&iter, READ, &rreq->mapping->i_pages,
> -				start + done, subreq->len);
> -
> -		ret = fscache_read(cres, subreq->start, &iter,
> -				   NETFS_READ_HOLE_FAIL,
> -				   erofc_fscache_subreq_complete, subreq);
> +		ret = fscache_read(cres, sstart, &iter, NETFS_READ_HOLE_FAIL,
> +				   erofs_fscache_subreq_complete, req);
>   		if (ret == -EIOCBQUEUED)
>   			ret = 0;
>   		if (ret) {
>   			erofs_err(sb, "failed to fscache_read (ret %d)", ret);
> -			goto out;
> +			return ret;
>   		}
>   
> -		done += subreq->len;
> +		done += slen;
>   	}
> -out:
> -	if (atomic_dec_and_test(&rreq->nr_outstanding))
> -		erofs_fscache_rreq_complete(rreq);
> -
> -	return ret;
> +	DBG_BUGON(done != len);
> +	req->submitted += len;
> +	return 0;
>   }
>   
>   static int erofs_fscache_meta_read_folio(struct file *data, struct folio *folio)
>   {
>   	int ret;
>   	struct super_block *sb = folio_mapping(folio)->host->i_sb;
> -	struct netfs_io_request *rreq;
> +	struct erofs_fscache_request *req;
>   	struct erofs_map_dev mdev = {
>   		.m_deviceid = 0,
>   		.m_pa = folio_pos(folio),
>   	};
>   
>   	ret = erofs_map_dev(sb, &mdev);
> -	if (ret)
> -		goto out;
> +	if (ret) {
> +		folio_unlock(folio);
> +		return ret;
> +	}
>   
> -	rreq = erofs_fscache_alloc_request(folio_mapping(folio),
> +	req = erofs_fscache_req_alloc(folio_mapping(folio),
>   				folio_pos(folio), folio_size(folio));
> -	if (IS_ERR(rreq)) {
> -		ret = PTR_ERR(rreq);
> -		goto out;
> +	if (IS_ERR(req)) {
> +		folio_unlock(folio);
> +		return PTR_ERR(req);
>   	}
>   
> -	return erofs_fscache_read_folios_async(mdev.m_fscache->cookie,
> -				rreq, mdev.m_pa);
> -out:
> -	folio_unlock(folio);
> +	ret = erofs_fscache_read_folios_async(mdev.m_fscache->cookie,
> +				req, mdev.m_pa, folio_size(folio));
> +	if (ret)
> +		req->error = ret;
> +
> +	erofs_fscache_req_put(req);
>   	return ret;
>   }
>   
>   /*
>    * Read into page cache in the range described by (@pos, @len).
>    *
> - * On return, the caller is responsible for page unlocking if the output @unlock
> - * is true, or the callee will take this responsibility through netfs_io_request
> - * interface.
> + * On return, if the output @unlock is true, the caller is responsible for page
> + * unlocking; otherwise the callee will take this responsibility through request
> + * completion.
>    *
>    * The return value is the number of bytes successfully handled, or negative
>    * error code on failure. The only exception is that, the length of the range
> - * instead of the error code is returned on failure after netfs_io_request is
> - * allocated, so that .readahead() could advance rac accordingly.
> + * instead of the error code is returned on failure after request is allocated,
> + * so that .readahead() could advance rac accordingly.
>    */
>   static int erofs_fscache_data_read(struct address_space *mapping,
>   				   loff_t pos, size_t len, bool *unlock)
>   {
>   	struct inode *inode = mapping->host;
>   	struct super_block *sb = inode->i_sb;
> -	struct netfs_io_request *rreq;
> +	struct erofs_fscache_request *req;
>   	struct erofs_map_blocks map;
>   	struct erofs_map_dev mdev;
>   	struct iov_iter iter;
> @@ -318,13 +241,17 @@ static int erofs_fscache_data_read(struct address_space *mapping,
>   	if (ret)
>   		return ret;
>   
> -	rreq = erofs_fscache_alloc_request(mapping, pos, count);
> -	if (IS_ERR(rreq))
> -		return PTR_ERR(rreq);
> +	req = erofs_fscache_req_alloc(mapping, pos, count);
> +	if (IS_ERR(req))
> +		return PTR_ERR(req);
>   
>   	*unlock = false;
> -	erofs_fscache_read_folios_async(mdev.m_fscache->cookie,
> -			rreq, mdev.m_pa + (pos - map.m_la));
> +	ret = erofs_fscache_read_folios_async(mdev.m_fscache->cookie,
> +			req, mdev.m_pa + (pos - map.m_la), count);
> +	if (ret)
> +		req->error = ret;
> +
> +	erofs_fscache_req_put(req);
>   	return count;
>   }
>   
