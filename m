Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E62B39A0E7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 14:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhFCMcA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 08:32:00 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:60882 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230197AbhFCMb6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 08:31:58 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1lomUE-0001y4-P9; Thu, 03 Jun 2021 20:30:10 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lomUD-0001dk-QX; Thu, 03 Jun 2021 20:30:09 +0800
Date:   Thu, 3 Jun 2021 20:30:09 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Wu Bo <wubo40@huawei.com>
Cc:     viro@zeniv.linux.org.uk, davem@davemloft.net,
        linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linfeilong@huawei.com
Subject: Re: [PATCH 1/2] crypto: af_alg - use DIV_ROUND_UP helper macro for
 calculations
Message-ID: <20210603123009.GD6161@gondor.apana.org.au>
References: <1621930520-515336-1-git-send-email-wubo40@huawei.com>
 <1621930520-515336-2-git-send-email-wubo40@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621930520-515336-2-git-send-email-wubo40@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 25, 2021 at 04:15:19PM +0800, Wu Bo wrote:
> From: Wu Bo <wubo40@huawei.com>
> 
> Replace open coded divisor calculations with the DIV_ROUND_UP kernel
> macro for better readability.
> 
> Signed-off-by: Wu Bo <wubo40@huawei.com>
> ---
>  crypto/af_alg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
