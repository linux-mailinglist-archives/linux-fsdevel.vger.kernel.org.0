Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088196E1C1B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 07:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjDNF72 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 01:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjDNF71 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 01:59:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC8A1BC5;
        Thu, 13 Apr 2023 22:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8QSq2j34Q7yVthaqQ/nZW1vwb5PpDz/V/KWQ3wbcvHw=; b=DWDXdR3MgdC0Th+F9Y1Frmw8MN
        darbSydcHymgUTCtb1LPFQktYMbihfjHMKqKuP0UxGfMKjlnCCmc6AnVVX1Rr8hz0fNVZqWOUaywC
        zWMEsf7JBWewr8vX4zJAgkWez9dI2BHYM9vVE4PRBbUU/EVFn112zVtnUfsJuCugvC0UXkpSQ4oHq
        V5HHesf/c+xQdu4qorkL6QmEmOFESaAS344x2X5VQ2iyzrAgaW3URA7NxD2Hv2mu/K31xBPdIN3C7
        XFypE/cf7UA6Do2OdaUsiua76+7wO8rIJX0jFs/6Pf29v3853k69F1Xflp10QNOQ47nmWWEmWQ6Vd
        N2mOxp1A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pnCSy-008QAR-1X;
        Fri, 14 Apr 2023 05:59:24 +0000
Date:   Thu, 13 Apr 2023 22:59:24 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFCv3 02/10] libfs: Add __generic_file_fsync_nolock
 implementation
Message-ID: <ZDjrvCbCwxN+mRUS@infradead.org>
References: <cover.1681365596.git.ritesh.list@gmail.com>
 <e65768eb0fe145c803ba4afdc869a1757d51d758.1681365596.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e65768eb0fe145c803ba4afdc869a1757d51d758.1681365596.git.ritesh.list@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Still no fan of the naming and placement here.  This is specific
to the fs/buffer.c infrastructure.

