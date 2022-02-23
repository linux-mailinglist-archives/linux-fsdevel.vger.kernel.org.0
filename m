Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0174C0CD9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 07:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238411AbiBWG5e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 01:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238142AbiBWG5d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 01:57:33 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6C031210
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Feb 2022 22:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NTb0asQ2ToC7tz5guh6L3MFGSOTJCsCSxcNejJOP+ZY=; b=rxBpps73zbjcb1vBgyKfSq0Jvv
        sOJ/ZEA+9HyoR2JIQN/qK2ASFR6gfcOxMHBnSRUKdP9xMhxzQTQkK4qkW8SPoaR4tWsvQfOEFhShk
        V2OyeL4UryXsp+7FKAzDvxein+06ixSt87vjl3g0PbvFzsO69DATExOe3l8g+Fa5KFFgwBN+Q7V8B
        YqMv+HS/qomAOLH+l2SRT79K94vP4kpVAdi9kyp2uc0rsz1UEk0Cjr6KWA+52c1xz+T1VrMe0ct3G
        iou6+X9+WpBgQQ58kZytMyW9q5HAxH9FeSLUbylho92DVkK60Du6DaiYjzvrCUu6nBSkY/shg+ge6
        91Ru3Mlw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMlaD-00D3Mz-E5; Wed, 23 Feb 2022 06:57:05 +0000
Date:   Tue, 22 Feb 2022 22:57:05 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 08/22] f2fs: Convert f2fs_grab_cache_page() to use scoped
 memory APIs
Message-ID: <YhXawZCs9aQ/kz9R@infradead.org>
References: <20220222194820.737755-1-willy@infradead.org>
 <20220222194820.737755-9-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222194820.737755-9-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 22, 2022 at 07:48:06PM +0000, Matthew Wilcox (Oracle) wrote:
> Prevent GFP_FS allocations by using memalloc_nofs_save() instead
> of AOP_FLAG_NOFS.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
