Return-Path: <linux-fsdevel+bounces-4843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18081804A3B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 07:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A3441F20C17
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 06:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EAF12E51
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 06:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OXFcYcad"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A82D10F;
	Mon,  4 Dec 2023 21:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mRb7xFsPGPOcQr70Y646igDQeTsMEFmwOCx2p8B3wDk=; b=OXFcYcadr22LLBCAH0u0bB6miD
	CYzgc3Vgv8AqGQoH8GoyA+TJ6AmilWwPB01/7Yb3gqRnbZQS9ve1jAD0zCpaGgPUMABKL7R/CCPdY
	dIXeyyeieZxKFqhUewym+rrUNyfj2sfwwMi9/PZ/Rggr4V1FV40NPebnxgfd96FpDyFCLEPvGIcKh
	DcIZihEraHyGDtAht0+8QHmCwL/oi9Nx0cuzADc4h7RzExCSvMs05mYdl0iKZRiabo9vWZsrHxqt0
	K5xSezNSm6nCrV5tIF1dsQDN6dOxEGLKlPT8H+fmAOMidqXzVBzO2W3AgSx9U/q8pxrz7dHeKxPBy
	Cbtpr5dQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rAOE9-006KQC-32;
	Tue, 05 Dec 2023 05:44:13 +0000
Date: Mon, 4 Dec 2023 21:44:13 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: j.granados@samsung.com
Cc: Kees Cook <keescook@chromium.org>, Iurii Zaikin <yzaikin@google.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH 0/3] sysctl: Fix out of bounds access for empty syscl
 ctl_tables
Message-ID: <ZW64rS219+6o+7mC@bombadil.infradead.org>
References: <20231121-jag-fix_out_of_bounds_insert-v1-0-571e76d51316@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121-jag-fix_out_of_bounds_insert-v1-0-571e76d51316@samsung.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Tue, Nov 21, 2023 at 12:02:17PM +0100, Joel Granados via B4 Relay wrote:
> Fix an out of bounds access reported in
> https://lore.kernel.org/oe-lkp/202311201431.57aae8f3-oliver.sang@intel.com
> Make sure that the ctl_table header size is greater than 0 before
> evaluating if a ctl_table is permanently empty; this evaluation accesses
> the first element regardless of the size. Adjusted the ctl_table_size of
> Permanently empty ctl_table registers to 1 as they the check now
> requires them to have size greater than 0. Added tests for empty
> directory handling; in response to the path followed by empty ctl_tables
> changing slightly. Clarified the results of sysctl self tests to more
> easily identify which ones are OK, Skipped and Failed.
> 
> Comments are greatly appreciated

Applied, thanks!

  Luis

