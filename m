Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A16912E60B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 13:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgABMZ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 07:25:59 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:49400 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728260AbgABMZ7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 07:25:59 -0500
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 60F1E8F4D27687D7720E;
        Thu,  2 Jan 2020 20:25:57 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 2 Jan 2020 20:25:56 +0800
Received: from architecture4 (10.160.196.180) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Thu, 2 Jan 2020 20:25:56 +0800
Date:   Thu, 2 Jan 2020 20:25:30 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Vladimir Zapolskiy <vladimir@tuxera.com>
CC:     Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        "Anton Altaparmakov" <anton@tuxera.com>,
        Miao Xie <miaoxie@huawei.com>
Subject: Re: [PATCH] erofs: correct indentation of an assigned structure
 inside a function
Message-ID: <20200102122530.GA39947@architecture4>
References: <20200102120232.15074-1-vladimir@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200102120232.15074-1-vladimir@tuxera.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.160.196.180]
X-ClientProxiedBy: dggeme720-chm.china.huawei.com (10.1.199.116) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 02, 2020 at 02:02:32PM +0200, Vladimir Zapolskiy wrote:
> Trivial change, the expected indentation ruled by the coding style
> hasn't been met.
> 
> Signed-off-by: Vladimir Zapolskiy <vladimir@tuxera.com>
> ---
>  fs/erofs/xattr.h | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/erofs/xattr.h b/fs/erofs/xattr.h
> index 3585b84d2f20..50966f1c676e 100644
> --- a/fs/erofs/xattr.h
> +++ b/fs/erofs/xattr.h
> @@ -46,18 +46,19 @@ extern const struct xattr_handler erofs_xattr_security_handler;
>  
>  static inline const struct xattr_handler *erofs_xattr_handler(unsigned int idx)
>  {
> -static const struct xattr_handler *xattr_handler_map[] = {
> -	[EROFS_XATTR_INDEX_USER] = &erofs_xattr_user_handler,
> +	static const struct xattr_handler *xattr_handler_map[] = {
> +		[EROFS_XATTR_INDEX_USER] = &erofs_xattr_user_handler,
>  #ifdef CONFIG_EROFS_FS_POSIX_ACL
> -	[EROFS_XATTR_INDEX_POSIX_ACL_ACCESS] = &posix_acl_access_xattr_handler,
> -	[EROFS_XATTR_INDEX_POSIX_ACL_DEFAULT] =
> -		&posix_acl_default_xattr_handler,
> +		[EROFS_XATTR_INDEX_POSIX_ACL_ACCESS] =
> +			&posix_acl_access_xattr_handler,
> +		[EROFS_XATTR_INDEX_POSIX_ACL_DEFAULT] =
> +			&posix_acl_default_xattr_handler,
>  #endif
> -	[EROFS_XATTR_INDEX_TRUSTED] = &erofs_xattr_trusted_handler,
> +		[EROFS_XATTR_INDEX_TRUSTED] = &erofs_xattr_trusted_handler,
>  #ifdef CONFIG_EROFS_FS_SECURITY
> -	[EROFS_XATTR_INDEX_SECURITY] = &erofs_xattr_security_handler,
> +		[EROFS_XATTR_INDEX_SECURITY] = &erofs_xattr_security_handler,
>  #endif
> -};
> +	};
>  
>  	return idx && idx < ARRAY_SIZE(xattr_handler_map) ?
>  		xattr_handler_map[idx] : NULL;
> -- 
> 2.20.1
>

Thanks, will apply for linux-next.

Thanks,
Gao Xiang

