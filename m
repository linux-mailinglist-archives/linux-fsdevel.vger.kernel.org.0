Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200FA7A28A5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 22:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237312AbjIOUu2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 16:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237574AbjIOUuL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:50:11 -0400
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2325930D1
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 13:49:30 -0700 (PDT)
Received: from eig-obgw-6001a.ext.cloudfilter.net ([10.0.30.140])
        by cmsmtp with ESMTP
        id hAJoqOjdHWU1chFknqThCU; Fri, 15 Sep 2023 20:49:30 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id hFknqDLh41SF3hFknqcwJm; Fri, 15 Sep 2023 20:49:29 +0000
X-Authority-Analysis: v=2.4 cv=Avr9YcxP c=1 sm=1 tr=0 ts=6504c359
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=37rDS-QxAAAA:8 a=drOt6m5kAAAA:8 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8
 a=HvF037n1xESchLcPDVoA:9 a=QEXdDO2ut3YA:10 a=k1Nq6YrhK2t884LQW06G:22
 a=RMMjzBEyIzXRtoq5n5K6:22 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dbvnwKJQfGsgQH7tlRR/jd5p7nHOn0NX5cYdBxx3AwM=; b=KmckCKfhNPNWKTdU/U2RVIyYPB
        xExI9mPYCjcuCOZhzrKa18b35yBJj1J92lH4mBNy+h5WcLsVj4D0zifQrWGCC5XRBRITAQNc6Pp6V
        OxJcCmDe1AIsvGONJEJRKHwJYEsfm+Q7OKJRWgh7ZA3XDtl5+SpDKmqg1+SQqWqntt+Ey+1mZQOxA
        Up7v+NCAQtGjfCGeZGC4YnGvLDKALmSGT8zz6vOFpg8WkJCdLkNwKQoIJLVYGERSbaaWunv2G8adv
        T1kitsK1Pcc7UoMVPYgCmUHvEo7vfoEU+DuAL7vqOCEINvaYJkTXkVt7hXOEC8m71LtLjZkIKwcTb
        g42p5LUQ==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:56838 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qhFkm-002ek3-0U;
        Fri, 15 Sep 2023 15:49:28 -0500
Message-ID: <b81647db-097e-cbf1-e4d6-53a4a96b85ea@embeddedor.com>
Date:   Fri, 15 Sep 2023 14:50:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] aio: Annotate struct kioctx_table with __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Benjamin LaHaise <bcrl@kvack.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230915201413.never.881-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230915201413.never.881-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1qhFkm-002ek3-0U
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:56838
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 428
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDnipcMzfoVn/SK6RKr3AWtWg4QYUJFnwZ3nYABF4BFY4RNCyakNutxJWiAgGhjlAINA32ecC/kfNg3jiCmd6vbKq68xiMqkL2xeAshZlSvC2P2jZg16
 RdXbpZWULO/lJ720lCIn8MAwM6jSfju768SnFgfSGxFvqsF7apO789meUtWZuNL/6r3tmuHgfUlln+l9cq1AR6x6S0Mw2kEpHPO2xDWrYL3ZD4cW3p164uk8
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/15/23 14:14, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct kioctx_table.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Benjamin LaHaise <bcrl@kvack.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: linux-aio@kvack.org
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   fs/aio.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index a4c2a6bac72c..f8589caef9c1 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -80,7 +80,7 @@ struct aio_ring {
>   struct kioctx_table {
>   	struct rcu_head		rcu;
>   	unsigned		nr;
> -	struct kioctx __rcu	*table[];
> +	struct kioctx __rcu	*table[] __counted_by(nr);
>   };
>   
>   struct kioctx_cpu {
