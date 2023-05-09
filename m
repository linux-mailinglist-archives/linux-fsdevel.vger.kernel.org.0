Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D94E6FD07B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 23:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjEIVER (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 17:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjEIVEQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 17:04:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BE71731;
        Tue,  9 May 2023 14:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=/cFC9qe7DxZKNLxVh5LKtTe70b6eucfrF/IOiV70OOM=; b=s1MbtfcF0qGE9Jp7gKW9H3t5Ru
        37lyYzzDwKdUZzy6Cgok8AFvmdmzNvlyA/Hpw31C03pG999F+K4Io6uzchsZJjFEGeMn35brb2Xhg
        wbGoJUr1GSdtQoO2s9SEMbsAQLpiHSLXkk5+wPaWUItUGOpv/jl6a1M8tJzqQmHwMDjjdCQXfEfxm
        TQzSvXYdaOrkuGgvf1tBccFfI7I5tEN/7eQFniFYm4ojyeBorLb9vEVlcHPlw0+Ugja4HngNGa2H2
        pFev+rPwX/SFhk5kEhxA3dUUAnEhlpoF3knGm7CQlAEZinotb8a1leL3OaXwWAxEqIaPKo+/v/EVn
        93Kxts0A==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pwUV7-004Gbz-16;
        Tue, 09 May 2023 21:04:01 +0000
Message-ID: <08fed8bc-0a15-2d13-81d3-2a81408457ae@infradead.org>
Date:   Tue, 9 May 2023 14:04:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 32/32] MAINTAINERS: Add entry for bcachefs
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-33-kent.overstreet@linux.dev>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230509165657.1735798-33-kent.overstreet@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 5/9/23 09:56, Kent Overstreet wrote:
> bcachefs is a new copy-on-write filesystem; add a MAINTAINERS entry for
> it.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dbf3c33c31..0ac2b432f0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3509,6 +3509,13 @@ W:	http://bcache.evilpiepirate.org
>  C:	irc://irc.oftc.net/bcache
>  F:	drivers/md/bcache/
>  
> +BCACHEFS:

No colon at the end of the line.


> +M:	Kent Overstreet <kent.overstreet@linux.dev>
> +L:	linux-bcachefs@vger.kernel.org
> +S:	Supported
> +C:	irc://irc.oftc.net/bcache
> +F:	fs/bcachefs/
> +
>  BDISP ST MEDIA DRIVER
>  M:	Fabien Dessenne <fabien.dessenne@foss.st.com>
>  L:	linux-media@vger.kernel.org

-- 
~Randy
