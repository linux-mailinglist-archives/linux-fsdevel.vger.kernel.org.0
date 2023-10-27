Return-Path: <linux-fsdevel+bounces-1458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E417DA346
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 00:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9093B20E64
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 22:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A936D405DD;
	Fri, 27 Oct 2023 22:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ryYOFteN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4B33FE33;
	Fri, 27 Oct 2023 22:14:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B170CE;
	Fri, 27 Oct 2023 15:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=CMf95GxFR8SIbHmrNw3UEkZJ72B9RcomHcSfUASgMLY=; b=ryYOFteNyJn3xL50GW8vCIdkTM
	OcKJT32lSdCpPKAjPbWcMmH2bHycXecgENHdB6FEGwWGtwQnOwtbnEyjJtZXHZg1MxWNTg6EY7aBf
	NVT/lum+j2pR+2NcpDz9N1OIYgmu1n/LBxYr3MO004xMWh8RO3yfTOmqJur7GcueMwJO17YzRifYA
	EI05e3OuCRsaradAexMOL+z+AICs7GbvuYal3sOLVo5ggtu/hT9cVywDe9DKLuOCuyktnGsnEWD43
	3uRbpPmCy5HXM37oVG/2Q9csmUNSeqsdbUyIBD4k9XPbicOr89C4lwTvn6A9h7Apm5qstLVpL4hTC
	3bcywDSA==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qwV6B-00HHV2-0J;
	Fri, 27 Oct 2023 22:14:35 +0000
Message-ID: <c211ae84-1e72-4c3f-b69b-e4d0e58560a8@infradead.org>
Date: Fri, 27 Oct 2023 15:14:34 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: vfs: fix typo in struct xattr_handlers
Content-Language: en-US
To: Ariel Miculas <amiculas@cisco.com>, linux-doc@vger.kernel.org
Cc: serge@hallyn.com, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231027152101.226296-1-amiculas@cisco.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231027152101.226296-1-amiculas@cisco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/27/23 08:21, Ariel Miculas wrote:
> The structure is called struct xattr_handler, singular, not plural.
> Fixing the typo also makes it greppable with the whole word matching
> flag.
> 
> Signed-off-by: Ariel Miculas <amiculas@cisco.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/filesystems/vfs.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> index 99acc2e98673..276a219ff8d9 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -437,7 +437,7 @@ field.  This is a pointer to a "struct inode_operations" which describes
>  the methods that can be performed on individual inodes.
>  
>  
> -struct xattr_handlers
> +struct xattr_handler
>  ---------------------
>  
>  On filesystems that support extended attributes (xattrs), the s_xattr

-- 
~Randy

