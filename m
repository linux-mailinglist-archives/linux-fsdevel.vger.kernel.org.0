Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641256E49ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 15:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjDQNcD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 09:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDQNcC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 09:32:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA91F30DC;
        Mon, 17 Apr 2023 06:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ShZh+UgjuKcvzPPpwt7z/ffvCMzyCK9AvJi38wN5G0c=; b=kpMI0oB3IFzH6QdUNWc2VVjb4T
        Qu8o0Z/EUsIrOqCDnci47Kn0AWHPc/IoXMRXt0YNgmVTQoZlg2uboTTIvG6zqlXYzLVrmB/513nyc
        V4KsDpzbaUKFiO8G8S1M5mBc9g2CJ9lmlUec/FcKk8n8O6aS01G8GnLMVtRxbKqg9l3EvbTcxafep
        Tz8I8RN+TFLSeduEi7kMi8PF48YTo9Blgo09BcgaO1F3lo8+W4ERISyhmr3KyzhtDm4O9AeQ5f8OC
        rdRjOGiFiBS2QQKrx8ecI0/uTuVc10TjwFAvVw5lwUSPDkfpnX6dPCphVM56X3JAisb9oR1QoXtJP
        HCwODF/g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1poOxU-00BNOv-RW; Mon, 17 Apr 2023 13:31:52 +0000
Date:   Mon, 17 Apr 2023 14:31:52 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        mcgrof@kernel.org, linux-kernel@vger.kernel.org, hare@suse.de,
        gost.dev@samsung.com
Subject: Re: [PATCH 2/4] buffer: add folio_alloc_buffers() helper
Message-ID: <ZD1KSLrWX1p2hIM8@casper.infradead.org>
References: <20230417123618.22094-1-p.raghav@samsung.com>
 <CGME20230417123621eucas1p12ef0592f7d9b97bf105ff9990da22a48@eucas1p1.samsung.com>
 <20230417123618.22094-3-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417123618.22094-3-p.raghav@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 17, 2023 at 02:36:16PM +0200, Pankaj Raghav wrote:
> Folio version of alloc_page_buffers() helper. This is required to convert
> create_page_buffers() to folio_create_buffers() later in the series.
> 
> alloc_page_buffers() has been modified to call folio_alloc_buffers()
> which adds one call to compound_head() but folio_alloc_buffers() removes
> one call to compound_head() compared to the existing alloc_page_buffers()
> implementation.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
