Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9AF4EC77B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 16:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238798AbiC3Ozj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 10:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347705AbiC3Ozb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:55:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A363F674EB
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Mar 2022 07:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yzu252QPBiI376hjwGJQTIrM0etmUmbtIsQJ6LliUu8=; b=ZI2lxAgXOwQhzSUVgCPP1c/UBX
        lbm9EH7WJNKgC88NESa2w9foNWrfEqdmL42AKP3S9TAGDBz+x9/Akkt32fGxHpsTNPtoFFM/vqMoU
        co+KLp62u0drZbDlJG5Z7C0tVAF3JPIpll+3Su+Rd6n5oneeTg4DP7jMEBXBpz6FVbMNekhB5mfyT
        Tu/BE+rDGsng+OMIPjytgw0IUMnndYkl5QVJyPdk7luBiPjnsPTwMMbQPdtSDhufyMpZnEMWnMCwg
        vuKN9cre/xftgp3/YdQgzz+b2GlpplzTEUc0BrlgY73KUF3t4ecYwdMG11XJH40vyqIYzM0ZsbXVm
        yYNzmUyQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZZhH-00GK9l-9K; Wed, 30 Mar 2022 14:53:19 +0000
Date:   Wed, 30 Mar 2022 07:53:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 09/12] f2fs: Correct f2fs_dirty_data_folio() conversion
Message-ID: <YkRu32/TVozQSjqE@infradead.org>
References: <20220330144930.315951-1-willy@infradead.org>
 <20220330144930.315951-10-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330144930.315951-10-willy@infradead.org>
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

On Wed, Mar 30, 2022 at 03:49:27PM +0100, Matthew Wilcox (Oracle) wrote:
> I got the return value wrong.  Very little checks the return value
> from set_page_dirty(), so nobody noticed during testing.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
