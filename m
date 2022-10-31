Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C500D613864
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Oct 2022 14:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiJaNu2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 09:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiJaNu1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 09:50:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F72101FA
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Oct 2022 06:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=iQrl5j+o4nSjJbyPNCGpMXm5FB
        yChHSnpCtAizwbsDoeW9pKo82bC5glMyHHQnquXDJ4OMdN72cwjlKzr6qfggnriV7Z5X8dJbbyy1C
        EwPoZYtZw0xammFqy8vhPmOWLViqasyeQQcpxAz4Gn2Lar3JOKSXDja3zZMHEE4isZxX1LbMjw+9u
        cZ+3aaqlXUvMEVZNFaFWjxxo0s2zOyeTmYU/V+4Qaq0Ya8Rmr71/xvrkhkgs3T/IryQJoBaZSL2DV
        kwp38NruB5MgMgBHFNsYryMvt03pTfJwXtJUhDsiOa9aUWzvghGr25gpw94oHfCcFYd0/BL6+mikv
        FOA6rtSA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opVBD-00C8dz-9r; Mon, 31 Oct 2022 13:50:19 +0000
Date:   Mon, 31 Oct 2022 06:50:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     hch@infradead.org, viro@zeniv.linux.org.uk, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fs: fix undefined behavior in bit shift for SB_NOUSER
Message-ID: <Y1/Sm4iJ45ZgtY54@infradead.org>
References: <20221031134811.178127-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031134811.178127-1-cuigaosheng1@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
