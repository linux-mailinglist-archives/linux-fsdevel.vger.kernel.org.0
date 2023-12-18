Return-Path: <linux-fsdevel+bounces-6427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A40EC817C58
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 22:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1230E2841CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 21:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AC073492;
	Mon, 18 Dec 2023 21:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="YIfzEHM+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB19A2D
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Dec 2023 21:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-28b09aeca73so2525001a91.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Dec 2023 13:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1702933256; x=1703538056; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yCl70P2eXwsD32MiqrmB1dJU3mIh1ffQIY/OsyTsmc0=;
        b=YIfzEHM+joXJA0KroR1tlepEpaEEtwx3YNIoTwcAOssJtY2DBaMpSVe/99rJvzP1GW
         4vhYsfIt5IUNmJkwZ254MtnQSKibPrA3lSAEpd8/capeZiA2R5SzsAAOlc93WtFzR+cF
         Sw6eCJ5xI487j2fqG8bJr+HDQwfdAJExTTqPOYhQZJYGSZbooJ3Ds0yAPIE1IbhaLgaT
         hQx4d08oswccFwYC/AF2LPUftZ45WyKsDH6xfO915PYOx9jED9tB5Fdm7/YjWxnZmMJF
         /3KxAhtJpbRlu8Y1NN2I3FYHD14lk7oEewD+HZGsPqXWK/iOB6U2fjAz6pvoZtpHBoQF
         ASjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702933256; x=1703538056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yCl70P2eXwsD32MiqrmB1dJU3mIh1ffQIY/OsyTsmc0=;
        b=DgKypyM97LdCGA1LVPgk/NDcZXhJBNzgoBc21CSrdeRDc1Z2oE1oF+LZyL6WopXOa+
         sqaAIqiBlpqjMivf+UV5JsUc3pZ2s2fQFLRu7yQFbNWAN6HJKQnZkqpYq2Zt2IHs3c8D
         GoBa6aNOQW/ul4UVPHo3cNd1SzyvUzElb3Vv6OE6ybd3Ry/HMhNMeXRYy0XqsUurX8BU
         6RnXDv6vckqDh7szRNH5nLxudd4Y6atfLcTvoHB0FSQ30iPMcQcrk2m0XjDlsSH7bVZz
         HHbM31psTllnDENW6Q6yslOXbMmjnQpQ4d71gFGXXvhu3k1xKLSijC+IVwFnYow0gZmy
         Ma2g==
X-Gm-Message-State: AOJu0YwxCod+OBkdWdsUG2jHxWeM9LO6bsk9VAFaikggtMmstGVeDp3W
	ieHMk/TxLchSYfdYFOZjthFz5w==
X-Google-Smtp-Source: AGHT+IFRkQHZVHpggsuenU8/ddppEpd5S2UPqIefRShVpVOZW68bvcOoHhDR4JetnCX3kBkUOmYAtA==
X-Received: by 2002:a17:90a:4b4f:b0:28b:5fc3:36c9 with SMTP id o15-20020a17090a4b4f00b0028b5fc336c9mr2440pjl.29.1702933256147;
        Mon, 18 Dec 2023 13:00:56 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id sh18-20020a17090b525200b00286e0c91d73sm20565584pjb.55.2023.12.18.13.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 13:00:55 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rFKjM-00A8r7-12;
	Tue, 19 Dec 2023 08:00:52 +1100
Date: Tue, 19 Dec 2023 08:00:52 +1100
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-mm@kvack.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Convert write_cache_pages() to an iterator v3
Message-ID: <ZYCzBCqetc+tLmq+@dread.disaster.area>
References: <20231218153553.807799-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218153553.807799-1-hch@lst.de>

On Mon, Dec 18, 2023 at 04:35:36PM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> this is basically a evolution of the series Matthew Wilcox originally
> set in June.  Based on comments from Jan a Brian this now actually
> untangles some of the more confusing conditional in the writeback code
> before refactoring it into the iterator.  Because of that all the
> later patches need a fair amount of rebasing and I've not carried any
> reviewed-by over.
> 
> The original cover letter is below:
> 
> Dave Howells doesn't like the indirect function call imposed by
> write_cache_pages(), so refactor it into an iterator.  I took the
> opportunity to add the ability to iterate a folio_batch without having
> an external variable.
> 
> This is against next-20230623.  If you try to apply it on top of a tree
> which doesn't include the pagevec removal series, IT WILL CRASH because
> it won't reinitialise folio_batch->i and the iteration will index out
> of bounds.
> 
> I have a feeling the 'done' parameter could have a better name, but I
> can't think what it might be.
> 
> Diffstat:
>  include/linux/pagevec.h   |   18 ++
>  include/linux/writeback.h |   19 ++
>  mm/page-writeback.c       |  333 +++++++++++++++++++++++++---------------------
>  3 files changed, 220 insertions(+), 150 deletions(-)

I've just done a quick scan of the code - nothing stands out to me
as problematic, and I like how much cleaner the result is.

Acked-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com

