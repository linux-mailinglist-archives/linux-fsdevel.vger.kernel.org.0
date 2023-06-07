Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2527254C5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 08:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238102AbjFGGw0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 02:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238262AbjFGGwV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:52:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8332D1732;
        Tue,  6 Jun 2023 23:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=U/B62Mqog3vp3Vr8Rj93YoSca3WiNsAO+9AwaSdNKrM=; b=Q2Dxgaudt4jZ1gKN+Nh8Hd0BqL
        q+LpdjkjALu4zWxZ67F4HNhj1Swd2uTlkDD3rft98XlVz2gvjE7gPBeipPEln279j7EE7/OCmgXy1
        5uz5VbbebMbcxKkgh2l4qqSIfmJ7TdCZRcNd36BH1wKiwndVdkQhnPDroRcoHuE5iDy32fxqLxcEq
        BkBFiTjxhFRLK9JeXMzk/bZBKvgb/+EJFAKqZEhh75Q1852hNqBfAx4Ul1CnZrCdEw8R83NXXjlkC
        CCDBC/Y8RIBs4rNcb14JhnDzP+ktZAXsCFPmJRsv5Jra/DI7T3UtCu2ghzP9GyhAsmms7FFOKiSMk
        puimT0Ow==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q6n1h-004cvO-1H;
        Wed, 07 Jun 2023 06:52:13 +0000
Date:   Tue, 6 Jun 2023 23:52:13 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCHv8 3/5] iomap: Refactor iomap_write_delalloc_punch()
 function out
Message-ID: <ZIApHVHrTVcPoiUn@infradead.org>
References: <cover.1686050333.git.ritesh.list@gmail.com>
 <ee74cd3dfb34ec321f70ee67c3a5d1f40fdc585f.1686050333.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee74cd3dfb34ec321f70ee67c3a5d1f40fdc585f.1686050333.git.ritesh.list@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 06, 2023 at 05:13:50PM +0530, Ritesh Harjani (IBM) wrote:
> This patch moves iomap_write_delalloc_punch() out of
> iomap_write_delalloc_scan(). No functionality change in this patch.

Please chose one refactor (the existing function), or factor (the
new function) out.  The mix doesn't make much sense.

Also please explain why you're doing that.  The fact tha a new helper
is split out is pretty obvious from the patch, but I have no idea why
you want it.

