Return-Path: <linux-fsdevel+bounces-12798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC25D86752C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 13:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 823DDB272EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 12:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE847F49D;
	Mon, 26 Feb 2024 12:34:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F7B7EEE6;
	Mon, 26 Feb 2024 12:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708950862; cv=none; b=MjZdVPezxQaTtTENoOcjYqrmGX/cBdibmnv/+yhllKVHonupDH+lF/lU/GxSFztU4w0dXkjs2HaCFw/G/tX4TKSeY/DMKqDsXWxbpvaLTXF7mkR0zpzXlEU/QTuQ0uUkY0IRKf7jWcF35XEPoSiY27MiulwuZUm8ygbEGUduCcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708950862; c=relaxed/simple;
	bh=dbszWLDjXPJNwXKH/pEp8OApSBuWz+lKi4U/CYmXC1s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oCVQDkDRpMp/Uw6Sotdpd/JEo4uHozwS3nCgs0DUTpqisbgMYikUaR27XqBwUJABgYHFTMSibcAyTeSg7sj9GcSIdwDMumOZVWbM1Ws3fbXCkBc1M3KC+WtpGUMI8MPUcvWdyw/nbqilnReajFnP7Plan67PzsJ88hDHjbro0gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tk0Lb3cwgz6K6j5;
	Mon, 26 Feb 2024 20:29:59 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 079E01411DE;
	Mon, 26 Feb 2024 20:34:18 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 26 Feb
 2024 12:34:17 +0000
Date: Mon, 26 Feb 2024 12:34:16 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: John Groves <John@Groves.net>
CC: John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, "Dan
 Williams" <dan.j.williams@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, "Jan
 Kara" <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
	<linux-cxl@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <john@jagalactic.com>, Dave Chinner
	<david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>,
	<dave.hansen@linux.intel.com>, <gregory.price@memverge.com>
Subject: Re: [RFC PATCH 06/20] dev_dax_iomap: Add CONFIG_DEV_DAX_IOMAP
 kernel build parameter
Message-ID: <20240226123416.0000200f@Huawei.com>
In-Reply-To: <13365680ad42ba718c36b90165c56c3db43e8fdf.1708709155.git.john@groves.net>
References: <cover.1708709155.git.john@groves.net>
	<13365680ad42ba718c36b90165c56c3db43e8fdf.1708709155.git.john@groves.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 23 Feb 2024 11:41:50 -0600
John Groves <John@Groves.net> wrote:

> Add the CONFIG_DEV_DAX_IOMAP kernel config parameter to control building
> of the iomap functionality to support fsdax on devdax.

I would squash with previous patch.

Only reason I ever see for separate Kconfig patches is when there is something
complex in the dependencies and you want to talk about it in depth in the
patch description. That's not true here so no need for separate patch.

> 
> Signed-off-by: John Groves <john@groves.net>
> ---
>  drivers/dax/Kconfig | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
> index a88744244149..b1ebcc77120b 100644
> --- a/drivers/dax/Kconfig
> +++ b/drivers/dax/Kconfig
> @@ -78,4 +78,10 @@ config DEV_DAX_KMEM
>  
>  	  Say N if unsure.
>  
> +config DEV_DAX_IOMAP
> +       depends on DEV_DAX && DAX
> +       def_bool y
> +       help
> +         Support iomap mapping of devdax devices (for FS-DAX file
> +         systems that reside on character /dev/dax devices)
>  endif


