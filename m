Return-Path: <linux-fsdevel+bounces-54302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE802AFD76A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 21:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 858171BC5583
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 19:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009D023F299;
	Tue,  8 Jul 2025 19:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRIL5sdr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5653923C507;
	Tue,  8 Jul 2025 19:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752003944; cv=none; b=XR3WSiUwv0u/sQuF2scx6gf94TpFpwp1K1//Vn/PdTA/UdLfPKAzwxmjoXzP4b30gvhqaFOTpw3aCKCp1koTuAitYSAK/xlEjOwJCCW7Ehcvpqsx1Bslzs8f8Wp2NHMx4jSnQOS40MpPaUqyZehN+i2rNH9/slw+xUTv6nbS0Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752003944; c=relaxed/simple;
	bh=/8NzYs9A6jTvYl+W2Y15ETEaIfiQ2pFc4/Y+QOFtzwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+YJ+/Om0WLWpVC59+3LE3coSepx6VyvAisAF5UgedHbezyaKgE0NoPtq5JmZPwhVp9hq40BYHJB1UUuJpr5K/7OC/6/TBT8ArlTVSqxYNkm+PvJ8G84GCdOSEEXXattPaqzjBIKyeErw2nwPcEoqkATjNDk7Y4xYTi0wiw6omU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRIL5sdr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1947C4CEED;
	Tue,  8 Jul 2025 19:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752003943;
	bh=/8NzYs9A6jTvYl+W2Y15ETEaIfiQ2pFc4/Y+QOFtzwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KRIL5sdrTuZ3xR/HnQB+yrlbcM6dbmX40jxMdm/cb2jGN7adWe4jDZE6V764vNfpY
	 FeMMxb6gk4i6XO+AMqmu79cxCvEo41d8bPowi7vR9WSe5Lj+hDeS6lefSvUBXJX4BK
	 +A7NXZCOeaXxZSHfshMRqlLmkL9l9qcb30jg+Oh35v1KeKbMBiXOlZusOuKF2YoVxL
	 miZQRw+2/eMsrP3GBRx6qSFWgHNlwKvTWBCR92saZl15XL9uRcaGlntyWx47ALqmeE
	 nySw/IT4YNxg9ZwsG6DfdPTRoY/nVKTHuwV7etlq+5OxoKEjrJgqsWK+m6/CcMcXea
	 vPy5nQjPnqLvg==
Date: Tue, 8 Jul 2025 12:45:43 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Subject: Re: [PATCH 01/14] iomap: header diet
Message-ID: <20250708194543.GF2672049@frogsfrogsfrogs>
References: <20250708135132.3347932-1-hch@lst.de>
 <20250708135132.3347932-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708135132.3347932-2-hch@lst.de>

On Tue, Jul 08, 2025 at 03:51:07PM +0200, Christoph Hellwig wrote:
> Drop various unused #include statements.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Assuming the build bots don't hate this,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 10 ----------
>  fs/iomap/direct-io.c   |  5 -----
>  fs/iomap/fiemap.c      |  3 ---
>  fs/iomap/iter.c        |  1 -
>  fs/iomap/seek.c        |  4 ----
>  fs/iomap/swapfile.c    |  3 ---
>  fs/iomap/trace.c       |  1 -
>  7 files changed, 27 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 3729391a18f3..addf6ed13061 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -3,18 +3,8 @@
>   * Copyright (C) 2010 Red Hat, Inc.
>   * Copyright (C) 2016-2023 Christoph Hellwig.
>   */
> -#include <linux/module.h>
> -#include <linux/compiler.h>
> -#include <linux/fs.h>
>  #include <linux/iomap.h>
> -#include <linux/pagemap.h>
> -#include <linux/uio.h>
>  #include <linux/buffer_head.h>
> -#include <linux/dax.h>
> -#include <linux/writeback.h>
> -#include <linux/swap.h>
> -#include <linux/bio.h>
> -#include <linux/sched/signal.h>
>  #include <linux/migrate.h>
>  #include "internal.h"
>  #include "trace.h"
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 844261a31156..6f25d4cfea9f 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -3,14 +3,9 @@
>   * Copyright (C) 2010 Red Hat, Inc.
>   * Copyright (c) 2016-2025 Christoph Hellwig.
>   */
> -#include <linux/module.h>
> -#include <linux/compiler.h>
> -#include <linux/fs.h>
>  #include <linux/fscrypt.h>
>  #include <linux/pagemap.h>
>  #include <linux/iomap.h>
> -#include <linux/backing-dev.h>
> -#include <linux/uio.h>
>  #include <linux/task_io_accounting_ops.h>
>  #include "internal.h"
>  #include "trace.h"
> diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
> index 80675c42e94e..d11dadff8286 100644
> --- a/fs/iomap/fiemap.c
> +++ b/fs/iomap/fiemap.c
> @@ -2,9 +2,6 @@
>  /*
>   * Copyright (c) 2016-2021 Christoph Hellwig.
>   */
> -#include <linux/module.h>
> -#include <linux/compiler.h>
> -#include <linux/fs.h>
>  #include <linux/iomap.h>
>  #include <linux/fiemap.h>
>  #include <linux/pagemap.h>
> diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
> index 6ffc6a7b9ba5..cef77ca0c20b 100644
> --- a/fs/iomap/iter.c
> +++ b/fs/iomap/iter.c
> @@ -3,7 +3,6 @@
>   * Copyright (C) 2010 Red Hat, Inc.
>   * Copyright (c) 2016-2021 Christoph Hellwig.
>   */
> -#include <linux/fs.h>
>  #include <linux/iomap.h>
>  #include "trace.h"
>  
> diff --git a/fs/iomap/seek.c b/fs/iomap/seek.c
> index 04d7919636c1..56db2dd4b10d 100644
> --- a/fs/iomap/seek.c
> +++ b/fs/iomap/seek.c
> @@ -3,12 +3,8 @@
>   * Copyright (C) 2017 Red Hat, Inc.
>   * Copyright (c) 2018-2021 Christoph Hellwig.
>   */
> -#include <linux/module.h>
> -#include <linux/compiler.h>
> -#include <linux/fs.h>
>  #include <linux/iomap.h>
>  #include <linux/pagemap.h>
> -#include <linux/pagevec.h>
>  
>  static int iomap_seek_hole_iter(struct iomap_iter *iter,
>  		loff_t *hole_pos)
> diff --git a/fs/iomap/swapfile.c b/fs/iomap/swapfile.c
> index c1a762c10ce4..0db77c449467 100644
> --- a/fs/iomap/swapfile.c
> +++ b/fs/iomap/swapfile.c
> @@ -3,9 +3,6 @@
>   * Copyright (C) 2018 Oracle.  All Rights Reserved.
>   * Author: Darrick J. Wong <darrick.wong@oracle.com>
>   */
> -#include <linux/module.h>
> -#include <linux/compiler.h>
> -#include <linux/fs.h>
>  #include <linux/iomap.h>
>  #include <linux/swap.h>
>  
> diff --git a/fs/iomap/trace.c b/fs/iomap/trace.c
> index 728d5443daf5..da217246b1a9 100644
> --- a/fs/iomap/trace.c
> +++ b/fs/iomap/trace.c
> @@ -3,7 +3,6 @@
>   * Copyright (c) 2019 Christoph Hellwig
>   */
>  #include <linux/iomap.h>
> -#include <linux/uio.h>
>  
>  /*
>   * We include this last to have the helpers above available for the trace
> -- 
> 2.47.2
> 
> 

