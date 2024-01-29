Return-Path: <linux-fsdevel+bounces-9423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF3784110C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 18:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E27311F2357C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 17:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524363F9E1;
	Mon, 29 Jan 2024 17:42:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F48D3F9D2
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 17:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706550162; cv=none; b=gaHy9wweuRVP1gZ0OtumXi4a+6fh5Thw8YacKg74IgN6gJRIsQ+vmRZMqMOaQ1zceRqPpSpP1PoSBYHPayLuuOf5r12P8hgd5G+xdz3zUt0jtTN0UPxlxs48Bf8SSsoiGtjDBsl5FosEevBnAw4Dx98knXSuC+6JLmVJC2OAXaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706550162; c=relaxed/simple;
	bh=TosvVxwquqInZxOX0CZp6UFQe750GXHzXLT2bzJ8KRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DE9zLZ/Z8DQXvJ5qUbMqChalEKlZVp2VBl95iHYm+Uo1LnEyC3zXEEwGKVvC8TMGR8BXov3HiY2qfdMpmjkWrXBwO4/PHpi0HksRsRmwyl4KCcXKmfgMiQmQsGZ86Rd+TecXfkpy0945e8pts2C7IOhYJP6Y4lCP5qW+ZTZhIGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-680b1335af6so37434026d6.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 09:42:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706550160; x=1707154960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGSfs+oLah5p8atiIFDkPtIIBxDhbFoFkuAT3N8FnRs=;
        b=CtLum7EeMfszqt8N4yjDimTxOt2uInG7n8XA9l1R+E2w4Wso6Tt4rIZjkBTNO+XPKy
         FFdilJzQcSbb1IBOSuZLgxtn3E6ySdi7t0bbq5phVX89DE3w45Wj+pimI4iykv9YTNhU
         qbSeH4Owyx3Rr5pzptksfgTVM7yhh5yda9B6TCWbXLSseU3nGmWXAI5MFNHn/Hogm8S3
         /4OAnwvzJMUQHfrWbaucAzrROg1QaJ2QbEZI7ScG+V4MP5T4RIQE1UHXLZFxsAE0q8PF
         ME/WhumBOwYZtdgysWUCC8nyxRpGo2SK8iI+PuE9vPGblGWihukJweEk32htEIxpRRNu
         WNRw==
X-Gm-Message-State: AOJu0YxNjZiQRtEZFh72/o/vvgLDcZRUdW9Ie94JHtxshugDVcRjaAAB
	D3paNhTKbtujSJ5mL4ZssiZ4675HUu+30iL8KE2Xz6a7izrmT5LmbGLj/OcA9A==
X-Google-Smtp-Source: AGHT+IGROYSRd+aTFKXf01w8ewa6J639byauVRJVy14CUWOtG5LUP0MzE9zts2MzsVEEracFsaYmiQ==
X-Received: by 2002:a05:6214:4008:b0:67f:26c9:ffdb with SMTP id kd8-20020a056214400800b0067f26c9ffdbmr6347580qvb.22.1706550160222;
        Mon, 29 Jan 2024 09:42:40 -0800 (PST)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id s17-20020ad44b31000000b0068c523609e6sm777249qvw.20.2024.01.29.09.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 09:42:39 -0800 (PST)
Date: Mon, 29 Jan 2024 12:42:38 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Ming Lei <ming.lei@redhat.com>, Dave Chinner <david@fromorbit.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Don Dutile <ddutile@redhat.com>,
	Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, linux-block@vger.kernel.org
Subject: Re: [RFC PATCH] mm/readahead: readahead aggressively if read drops
 in willneed range
Message-ID: <ZbfjjmlvPrbdKIjX@redhat.com>
References: <ZbenbtEXY82N6tHt@casper.infradead.org>
 <Zbc0ZJceZPyt8m7q@dread.disaster.area>
 <20240128142522.1524741-1-ming.lei@redhat.com>
 <ZbfeBrKVMaeSwtYm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbfeBrKVMaeSwtYm@redhat.com>

On Mon, Jan 29 2024 at 12:19P -0500,
Mike Snitzer <snitzer@kernel.org> wrote:
 
> While I'm sure this legacy application would love to not have to
> change its code at all, I think we can all agree that we need to just
> focus on how best to advise applications that have mixed workloads
> accomplish efficient mmap+read of both sequential and random.
> 
> To that end, I heard Dave clearly suggest 2 things:
> 
> 1) update MADV/FADV_SEQUENTIAL to set file->f_ra.ra_pages to
>    bdi->io_pages, not bdi->ra_pages * 2
> 
> 2) Have the application first issue MADV_SEQUENTIAL to convey that for
>    the following MADV_WILLNEED is for sequential file load (so it is
>    desirable to use larger ra_pages)
> 
> This overrides the default of bdi->io_pages and _should_ provide the
> required per-file duality of control for readahead, correct?

I meant "This overrides the default of bdi->ra_pages ..." ;)

