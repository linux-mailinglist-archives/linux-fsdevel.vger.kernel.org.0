Return-Path: <linux-fsdevel+bounces-3223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6F87F1939
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 18:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17CFE1C216CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 17:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEE51802A;
	Mon, 20 Nov 2023 17:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Vmz2uzF9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEEABE
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 09:01:18 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-db048181cd3so4451978276.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 09:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1700499678; x=1701104478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nhO17ACEb9N3k278JmuH9xS2cGwGZBcXP1d2ZoEd5Fg=;
        b=Vmz2uzF9vRVjJrJdNEZLQ2ARgxGQG7vdILhLx1jceefaRnwsTQrPgjhswkpC7NH8a/
         JGX64hA8aEWghY4mUL0DaqrY31KObUr1i3JX/RBRu1ZHTaz6GR4wTj9i7SK9MLey4jOZ
         gXDOZZgzTaeYyI21cbWbXu/7MhP4mYrUuCyWeAAEbWqhiqcMAg29OYGF8DryS3UtSwaf
         MRSknisY1HUgQ6aujk35AgOFxJ4nYvsJQDy72fwdHMkSrDCfoKL/E4jNkthJAhfyAbPF
         rSz+Oz+yu18i5hREfknKLe8aWStIHE9vNf2RXAh/MunjFaDbg8ZPphAcC3OlebexZjP0
         Ixng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700499678; x=1701104478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhO17ACEb9N3k278JmuH9xS2cGwGZBcXP1d2ZoEd5Fg=;
        b=UieTXEbJJOzOWLXR0Ru3m/lz4b9FAO2gvOuRLQR+W6TYvXwSPyqQk3MXspRmAgo942
         +Z6dPqyu2HLjJgZ0y4hPdhKuMLY1SLACeOiwqadSV9/AUAt+H0GLrxhgbA06inENOgz2
         ms8Eg57mwYNVcEG3Hzp0F9lI+huMoU7873QAQHNrgEBFnt2p7HbbAUoqHsmYHQjor/ML
         U/a9v1Q2QbyytcixK5eWDsiEAQ9yulwnvTj2dtfrbcWxUJZSncy2AemdZRe+rsfYZrV1
         Crn5jpqx8FEmTb0WgpNHyNS6u5yX7By3X1QoxOaOSqLIzhOGhhzIeww+zO4hYO43UwCk
         XwrA==
X-Gm-Message-State: AOJu0YyVkPtTAKHcbxXM81bfd+pqyAe2fxI6wDY+bhd4MxALGqy12DIU
	vEnHTf3Q9Fxb+XsGsAM7XO2GXW5DnqYTp9qhLaGv3ZIV
X-Google-Smtp-Source: AGHT+IFveLu09tYCCy5wzh5NEYCuDzcyrXE4KfGq1QWQ9tyX0cRGa7YdARCuHZY+v2sRNfJaGHVtDA==
X-Received: by 2002:a25:af14:0:b0:d9a:4b0f:402b with SMTP id a20-20020a25af14000000b00d9a4b0f402bmr7530911ybh.38.1700499677804;
        Mon, 20 Nov 2023 09:01:17 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id l15-20020a25250f000000b00d7745e2bb19sm112585ybl.29.2023.11.20.09.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 09:01:17 -0800 (PST)
Date: Mon, 20 Nov 2023 12:01:16 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: Rename mapping private members
Message-ID: <20231120170116.GB1606827@perftesting>
References: <20231117215823.2821906-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117215823.2821906-1-willy@infradead.org>

On Fri, Nov 17, 2023 at 09:58:23PM +0000, Matthew Wilcox (Oracle) wrote:
> It is hard to find where mapping->private_lock, mapping->private_list and
> mapping->private_data are used, due to private_XXX being a relatively
> common name for variables and structure members in the kernel.  To fit
> with other members of struct address_space, rename them all to have an
> i_ prefix.  Tested with an allmodconfig build.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---

Given that there's plenty of other things with i_ in there I think this is a
reasonable naming scheme.  I agree with Darrick that maybe a_ would be better,
but we'd have to change everything in there and that's a bit trickier.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

