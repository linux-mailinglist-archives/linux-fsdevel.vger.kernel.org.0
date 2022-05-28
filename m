Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2D3536AF2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 May 2022 07:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235883AbiE1FsJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 May 2022 01:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbiE1FsJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 May 2022 01:48:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD7026556
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 22:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ROhb8fpAaS6Hhw6CtsoNTNucFXDZkX7H+gk7MOZT5xk=; b=oYj8STEdM+ldPMkDb3v9Iqjzrd
        7PW22OjjAVzuvP5vKWL9/03Sw272RYCs5tLkI6lK0K4XkqZIFkLy86Q87x/yuVLni4H4iutV72533
        F/B5WoY+r1S0JuemTPOWmnKopchKYgm7D4Q2F/dgcX8JxCWd28HKy/t0br3tySPL6X6KPsCgT0vZP
        guZeQpN2U9tMvllLV8cg1NDZ3I+SqA0Ogh6+3tNzztfxEO9y8jlAkZ9TImRi+ldU8vDFCm5thMm4I
        7NUt5q0LghxDRY7k3ImyQIMtNNvenYwpbZbb9cesoYL53A4LnF0KDcQtBHeUI4wEspKYznC/sajFB
        FeU0jFKA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nupJ1-001VI0-Ql; Sat, 28 May 2022 05:48:07 +0000
Date:   Fri, 27 May 2022 22:48:07 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 03/24] freevxfs: Remove check of PageError
Message-ID: <YpG3l1YvSWEubFlA@infradead.org>
References: <20220527155036.524743-1-willy@infradead.org>
 <20220527155036.524743-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527155036.524743-4-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>  		/** if (!PageChecked(pp)) **/
>  			/** vxfs_check_page(pp); **/
> -		if (PageError(pp))
> -			goto fail;

Can you remove this comment out code as well while you're at it?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
