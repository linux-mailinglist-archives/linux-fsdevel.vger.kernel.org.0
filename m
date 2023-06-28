Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15F9740A29
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 09:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjF1H65 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 03:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjF1H4t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 03:56:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AC53585;
        Wed, 28 Jun 2023 00:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=f/oX02NADlRje3q5zeF8d/lsRD
        0ie6P2tp9ZLIcRdET6WbJV659f9qLy/5ePvPvcRECL2M85BZiUai8g+qEu0zl1sbUTOtGAY88sh9G
        rmXYO7J8TPZYOBvP/G0p8KJkfsmV6FQDpoe1nRiVVsppegJaNjKAjlR5G4Xnnhzy1Tz4PpGgg+RmI
        sn/TFAWTB8yg4Es3at2LtiDsfRKm+lO8Ln+NuwYaHsypIDjtAUHXuLa0P1Qh9L1Sd/utsUoAF+yYx
        +gNN1rkaSq+zMFebGs5dkcCOVe/CWsHEca4RJyQA+R9uEpZZsHMCpcQgQ9icdIJxCxa0bKyl0N1b8
        EzPrCSVA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qENCP-00EpAm-1T;
        Wed, 28 Jun 2023 04:54:37 +0000
Date:   Tue, 27 Jun 2023 21:54:37 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Lu Hongfei <luhongfei@vivo.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
Subject: Re: [PATCH v2] fs: iomap: Change the type of blocksize from 'int' to
 'unsigned int' in iomap_file_buffered_write_punch_delalloc
Message-ID: <ZJu9DVMsLe4/QPHA@infradead.org>
References: <20230628015803.58517-1-luhongfei@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628015803.58517-1-luhongfei@vivo.com>
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
