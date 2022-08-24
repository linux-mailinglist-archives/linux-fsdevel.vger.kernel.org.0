Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D358459FAA7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 14:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237752AbiHXM6L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Aug 2022 08:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiHXM6I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Aug 2022 08:58:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E1D979DC;
        Wed, 24 Aug 2022 05:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2VBvEifQjJ0B2yEyDwr1KfnpR0QVvoOJrb8XD2pI0T4=; b=VrXTD/1Gt1++tPqmEJJZcE06QC
        HuraL9RvVOD2Gr1Kg5a+FP38JYMFJ66udtbfysdVRDvBbiZwaLYqx54wnhn7/tjtZeu5r3qjKiwmX
        lSKIvV3wUmyUJBbgsGtuUzGOSf6vTOVLJBF/P2d3w9vEm1BXWeeLFl4dAFYDapASZML5uGKISvD1b
        TSpRMC9TabM+CWy7pZPhN5/2rhM1sD47YesIFjrDEeBviAPjXMnmoz3Gqf6e5DPiu7bhQ3dMkyjs4
        VitTic6le3eAIuY8uB0Rlx40LnH6b5hi+OV3gusBZvIK4odFICYRXJHHFNLBmNkNYySW0Q3z0lfLy
        w3DaE+9g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQpxM-00GLHL-Qr; Wed, 24 Aug 2022 12:58:04 +0000
Date:   Wed, 24 Aug 2022 13:58:04 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     xu xin <cgel.zte@gmail.com>
Cc:     akpm@linux-foundation.org, corbet@lwn.net, bagasdotme@gmail.com,
        adobriyan@gmail.com, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, xu xin <xu.xin16@zte.com.cn>,
        Xiaokai Ran <ran.xiaokai@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>
Subject: Re: [PATCH v4 1/2] ksm: count allocated ksm rmap_items for each
 process
Message-ID: <YwYgXNJIzNxcVDnp@casper.infradead.org>
References: <20220824124512.223103-1-xu.xin16@zte.com.cn>
 <20220824124615.223158-1-xu.xin16@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824124615.223158-1-xu.xin16@zte.com.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 24, 2022 at 12:46:15PM +0000, xu xin wrote:
>  #ifdef CONFIG_KSM
>  	ONE("ksm_merging_pages",  S_IRUSR, proc_pid_ksm_merging_pages),
> +	ONE("ksm_rmp_items",  S_IRUSR, proc_pid_ksm_rmp_items),

You misspelled "rmap" in the file name.

> +		/*
> +		 * Represent how many pages are checked for ksm merging
> +		 * including merged and not merged.
> +		 */
> +		unsigned long ksm_rmp_items;

Also here.

