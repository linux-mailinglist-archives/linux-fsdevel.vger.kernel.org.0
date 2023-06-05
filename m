Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1647A721F2E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 09:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjFEHND (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 03:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjFEHMs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:12:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E975E6D;
        Mon,  5 Jun 2023 00:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kpvDwBWP98BpcNb3DiIFjEcF/SJseZ6dCm2E0Nls3Ns=; b=VKzKGIJVCpycyBgOJdUi7yckYJ
        MUc1nrCgRsGQEC7eveCHjMiRG/yDmt0t8gARz/7BFKVtc3zFALFCiD70in/XBuL345GsTuAiDo1MG
        8p9ELpJdexG4oRO7bEMrBZZIWnvHIaNGxUywDgmb+CT5kHqpdFUgWlMM9rGkrJcCCu2HOT2XXFyGu
        0Y9KiHIdm2zLiAyJbupFio/iblo1zBKZ2gALOzBMCjnkC/Cw5NLQ03iXrsL2vYh0O2gIgNbecUDSl
        JL9nphdA+oa9uE7M4WcuI9iLergCuEq2c3f8tOuRJ7xd5ViRoZ6l5kY3GjUUgklnfCn1lKfyHSiR9
        EhFYiOpw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q64No-00EVnU-07;
        Mon, 05 Jun 2023 07:12:04 +0000
Date:   Mon, 5 Jun 2023 00:12:04 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v2 2/7] doc: Correct the description of ->release_folio
Message-ID: <ZH2KxNW7PxABMOx6@infradead.org>
References: <20230602222445.2284892-1-willy@infradead.org>
 <20230602222445.2284892-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602222445.2284892-3-willy@infradead.org>
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

Never mind the shism on the nature of the holy trinity of
vfs/mm/pagecache the substance looks good here:

Reviewed-by: Christoph Hellwig <hch@lst.de>
