Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05EEA740CFA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 11:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbjF1J1M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 05:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbjF1H4Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 03:56:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FBD30D1;
        Wed, 28 Jun 2023 00:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=C33zFIpKW844M7vGJZLSrDh0in
        5zuFrOdj/j3Rrj343ckHaurAox21yI9kRoPymItAHVDQyn9YAY/xZi5oc4ZuLeoMgXAWXbQmeqpCZ
        PakCICXSdR/LkWA5P5nIgx+v2gmdlnaOb406+eZlOutumJDRinM5u2TX0riUphi1poTuQNkg/gKRr
        noO7opbZsFkrK5LrVAckgnbRLyp1YgcOLBDhNN302Oyrxs4r4zFe8AYCrLz3JLzmoCIdLfhONCG1l
        PMIsDOmUqrysER74ktMDvKoXVBNOzQmTG+aCcUZl9byobsPEtQy0+w61ukQ60FvTeVPgVsZQZqej3
        GNd6t4WA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qENBy-00Ep7x-12;
        Wed, 28 Jun 2023 04:54:10 +0000
Date:   Tue, 27 Jun 2023 21:54:10 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        akpm@linux-foundation.org, tytso@mit.edu, willy@infradead.org,
        adilger.kernel@dilger.ca, hughd@google.com, hch@infradead.org
Subject: Re: [PATCH] mm: increase usage of folio_next_index() helper
Message-ID: <ZJu88ptO6k2xrosy@infradead.org>
References: <20230627174349.491803-1-sidhartha.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627174349.491803-1-sidhartha.kumar@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
