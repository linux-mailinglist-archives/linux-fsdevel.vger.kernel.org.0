Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EBB74158F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 17:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbjF1Ppf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 11:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjF1Ppd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:45:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C968F;
        Wed, 28 Jun 2023 08:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pNWkzoWi75OsonEIBJ+Q8m8P+EHacFx3/bbIv67/esU=; b=PGQoiw6ry41ahIi9K93q9gItT9
        vBS47l4+FQ9TTuGxpWKNwSQpvKFaabEvqHZdxi9ejtzAOVCerIuWPBexSZtlBXAuekWNfsTiL4q3W
        soQmokAcXM1mu9qY+s0P5tmuCvURC7yflswz1EbodXQsHPOupksSc1PdnzobyRU5iRlpbJ4EHFVBl
        GELkKp3RU8uzo0s7dfI15MRXg/5xvyDDI+E9wpbpkxbagr7JnCJYUMg02r1ufj5yw1apIwQSj0/eY
        Cmid2DopceX4GgVtuRPtaCXAZmNALw6MyOCRRJX8bxFTNxEN3UpRyNmlfZDHDqLjYYLHrG+4W/YHC
        5hyI5Nmw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qEXMB-003wDU-20; Wed, 28 Jun 2023 15:45:23 +0000
Date:   Wed, 28 Jun 2023 16:45:23 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 23/23] mm: remove folio_account_redirty
Message-ID: <ZJxVk67GJUsyOxhe@casper.infradead.org>
References: <20230628153144.22834-1-hch@lst.de>
 <20230628153144.22834-24-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628153144.22834-24-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 28, 2023 at 05:31:44PM +0200, Christoph Hellwig wrote:
> Fold folio_account_redirty into folio_redirty_for_writepage now
> that all other users except for the also unused account_page_redirty
> wrapper are gone.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

