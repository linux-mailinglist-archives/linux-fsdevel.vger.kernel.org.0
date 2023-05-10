Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B315B6FD371
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 May 2023 03:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234919AbjEJBKp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 21:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjEJBKo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 21:10:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F59049C1;
        Tue,  9 May 2023 18:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=n2OhR/8mqrfmCbzZz2bw4Ksr3yVT2zjV2VuBFia7p0M=; b=3gduoDpVeCKaG6IgJCxOVeZWee
        PCg7JZnh3Qo24BhIaWRQpLstjtCLm1uTC8v9odGmPJzmXEvsO/uGVA1IFFNz0IIdFCy7XFeDtv9mC
        wbnyQbVRS8VUYsO8xUZBrnRkudgWTWeLnVsOPkvQH10ADrFMt0I3OA4t6JG7kFDNNNdhBtgzQOvW/
        13STx74ghdMZMaE38YvYCWeIea740XYs9boIiQejTYPkGtyUqXRDgI2Lj+EKI4PXUtHwUKA6x+a5I
        CIh2bvm6SVR4aBWz5BKWysfgJvQRlmvqS2Z8axLbMu/p5wVEnuslHAMDNcayhb1guBzMkdIOCfmVR
        pNKLCkjw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pwYLo-004fBx-2i;
        Wed, 10 May 2023 01:10:40 +0000
Message-ID: <efa69d65-d5bd-b3b8-14e0-323cfdd67b62@infradead.org>
Date:   Tue, 9 May 2023 18:10:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 15/32] bcache: move closures to lib/
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Coly Li <colyli@suse.de>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-16-kent.overstreet@linux.dev>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230509165657.1735798-16-kent.overstreet@linux.dev>
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
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 39d1d93164..3dba7a9aff 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1618,6 +1618,15 @@ config DEBUG_NOTIFIERS
>  	  This is a relatively cheap check but if you care about maximum
>  	  performance, say N.
>  
> +config DEBUG_CLOSURES
> +	bool "Debug closures (bcache async widgits)"
> +	depends on CLOSURES
> +	select DEBUG_FS
> +	help
> +	Keeps all active closures in a linked list and provides a debugfs
> +	interface to list them, which makes it possible to see asynchronous
> +	operations that get stuck.

According to coding-style.rst, the help text (3 lines above) should be
indented with 2 additional spaces.

> +	help
> +	  Keeps all active closures in a linked list and provides a debugfs
> +	  interface to list them, which makes it possible to see asynchronous
> +	  operations that get stuck.

-- 
~Randy
