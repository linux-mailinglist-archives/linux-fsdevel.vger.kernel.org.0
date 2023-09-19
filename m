Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4391F7A5BDD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 10:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjISIDk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 04:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjISIDi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:03:38 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2044811C;
        Tue, 19 Sep 2023 01:03:33 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68fe39555a0so4940308b3a.3;
        Tue, 19 Sep 2023 01:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695110612; x=1695715412; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WnPeW+zDgf4KVLZMg3rRMs3NIhagmhnqy1UYVMH/L5s=;
        b=TYCLF82f8ABa9oaYiFFvHtagSFyMD3pezgMdugDIixLdIVepLnm4kgeXqey4Y/GAL/
         bOXpcMoaApM1gK3rKt4hEquIGUuhHF1ZmHJ1yTqZW2ztpBngUURrjsAn98Yhqa8DA3RV
         Fxjv2Sng17cgJRt3kpX3+JCI5wUxt5wOFyN5UKgJEfB928yFgsOwNwTxhH5Fn1raxEIR
         4YUmoGWHEVOvlXVaLHzhDrMT6bnq9ePROUCAdHgDGS6+KboluDLhakBedxlwgikmPN3u
         s8e5DtwGXvg8CUwMZyLa5IO/krrELObvVGPfephSBIToCtb+obNwqwbJBT5spNNjxPce
         VtUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695110612; x=1695715412;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WnPeW+zDgf4KVLZMg3rRMs3NIhagmhnqy1UYVMH/L5s=;
        b=ZzVgJDkXa+21yEdET4iIC5hifXusAtdHkgSVc6ZEBDNOaQ2PiENIxe98N8lgF62ehv
         rY8HSdTGynb9a96BrzMxsPF1Ex12H17/7cbYbG6Ay3f7qv4OrKCbLeHXXs+F7IBrmxQG
         9KGi67v0EwWe+6QgmK6a1r3S5wVoItkAROEVzgOzlTIGro7KPFdgAAElIpJNfozSSPl9
         ndtIYiH5MmIBn3NFc5NnGOsBJIHJlUQU2LnYLg9IW/0IDcWSyRkcFqEed8R/DU8zZ5bS
         Otkh/Ce1jsPKExS/8i/3m0ZNrNv8AbLJweZ3PL4AdMy2Zc+fTBHStDayxMnGg3jxQLHN
         Qk1A==
X-Gm-Message-State: AOJu0YxE+kmAc0iRP/LyWbuzz/ih6jnQnEUQJ8r8sQ0dvqPl8Cvl5ZRD
        uUdoWAUpf7C3cq29ahAFI1A=
X-Google-Smtp-Source: AGHT+IGUkBNiw+2ebFSaZaVgIWRqq3qr5ttLFIEk2HnZw6AkU2zM93qFZPveDuwf3XLIT/eCf2a4GQ==
X-Received: by 2002:a05:6a00:9a8:b0:68c:57c7:1eb0 with SMTP id u40-20020a056a0009a800b0068c57c71eb0mr12722294pfg.11.1695110612342;
        Tue, 19 Sep 2023 01:03:32 -0700 (PDT)
Received: from dw-tp ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id i3-20020aa78d83000000b0068be7119c70sm8118958pfr.186.2023.09.19.01.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 01:03:31 -0700 (PDT)
Date:   Tue, 19 Sep 2023 13:33:27 +0530
Message-Id: <87il867fow.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     "Darrick J. Wong" <djwong@kernel.org>, djwong@kernel.org
Cc:     willy@infradead.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, willy@infradead.org
Subject: Re: [PATCH 2/2] iomap: convert iomap_unshare_iter to use large folios
In-Reply-To: <169507873100.772278.2320683121600245730.stgit@frogsfrogsfrogs>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Darrick J. Wong" <djwong@kernel.org> writes:

> From: Darrick J. Wong <djwong@kernel.org>
>
> Convert iomap_unshare_iter to create large folios if possible, since the
> write and zeroing paths already do that.  I think this got missed in the
> conversion of the write paths that landed in 6.6-rc1.
>
> Cc: ritesh.list@gmail.com, willy@infradead.org
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/iomap/buffered-io.c |   22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)

Looks right to me. Feel free to add - 

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

(small nit below)

>
>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 0350830fc989..db889bdfd327 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1263,7 +1263,6 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
>  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
>  	loff_t pos = iter->pos;
>  	loff_t length = iomap_length(iter);
> -	long status = 0;
>  	loff_t written = 0;
>  
>  	/* don't bother with blocks that are not shared to start with */
> @@ -1274,9 +1273,10 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
>  		return length;
>  
>  	do {
> -		unsigned long offset = offset_in_page(pos);
> -		unsigned long bytes = min_t(loff_t, PAGE_SIZE - offset, length);
>  		struct folio *folio;
> +		int status;
> +		size_t offset;
> +		size_t bytes = min_t(u64, SIZE_MAX, length);
>  
>  		status = iomap_write_begin(iter, pos, bytes, &folio);
>  		if (unlikely(status))
> @@ -1284,18 +1284,22 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
>  		if (iter->iomap.flags & IOMAP_F_STALE)

Just noticed that we already have "iomap = &iter->iomap" at the start of this
function. We need not dereference for iomap again here.
(Not related to this patch, but I thought I will mention while we are
still at it)

>  			break;
>  
> -		status = iomap_write_end(iter, pos, bytes, bytes, folio);
> -		if (WARN_ON_ONCE(status == 0))
> +		offset = offset_in_folio(folio, pos);
> +		if (bytes > folio_size(folio) - offset)
> +			bytes = folio_size(folio) - offset;
> +
> +		bytes = iomap_write_end(iter, pos, bytes, bytes, folio);
> +		if (WARN_ON_ONCE(bytes == 0))
>  			return -EIO;
>  
>  		cond_resched();
>  
> -		pos += status;
> -		written += status;
> -		length -= status;
> +		pos += bytes;
> +		written += bytes;
> +		length -= bytes;
>  
>  		balance_dirty_pages_ratelimited(iter->inode->i_mapping);
> -	} while (length);
> +	} while (length > 0);
>  
>  	return written;
>  }
