Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3677755AFF7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jun 2022 09:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbiFZHoj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jun 2022 03:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbiFZHoi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jun 2022 03:44:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52F211C11;
        Sun, 26 Jun 2022 00:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Iy6cD5DCOeFOLAW+fQ9+Rc4QoR
        lE4tffSLo5LJZ9H+2zdIPq3KEIIsTBJD1NFq3/s28/iJmoYI04ZkA+jv5V33QK4C51x1otsDHeYoA
        aACWcHMmPXH0+CZdYRjHtkxS7b5HDeyz3OTA6VfMb7B5wkCq/ALG3NuUBJg8BZhl7BUfvqN1ZoFcb
        NIB8G7crIjR8Nx0uv7hGj2tGXnalID1CCBb60FgK9A9fBEcqIcxAM8eTtHup4ZfbWGypCoRFWT01B
        G9F7vZeXNsZUdBuyZZsTq22ddMeaEjxPFJpybnhgLPayZ3iXCsV8IWQEB4Sg0d6Vaaqivtm+aPW+4
        kpKN6btg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o5Mwf-00ARbQ-Br; Sun, 26 Jun 2022 07:44:37 +0000
Date:   Sun, 26 Jun 2022 00:44:37 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v3 1/8] statx: add direct I/O alignment information
Message-ID: <YrgOZSJVzUyJ4QC+@infradead.org>
References: <20220616201506.124209-1-ebiggers@kernel.org>
 <20220616201506.124209-2-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616201506.124209-2-ebiggers@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
