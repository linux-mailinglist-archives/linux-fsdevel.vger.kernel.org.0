Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03EF5302EF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 May 2022 14:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344630AbiEVMI5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 May 2022 08:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344592AbiEVMIz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 May 2022 08:08:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911B438DA0;
        Sun, 22 May 2022 05:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=2Bti6lrEEqkq5Oi0bLwcRnNHV4
        bfxzL+RNMxEcUpH9xak0/7sfKRhDkuWPMvNeSOJScSea0dfbdhQWgyvnZPm7CzcpX92rqk1ihMxHE
        3VS55uNXPhybdcFBRIkvr2pUAZY5xP6IMSTivvLWb53QCet4F8Qdk30xDzfjXtCTssr4MCyCScTn8
        9FH2pYdiiqrr7AxA+Jc5CVNMUeGrrSAJjmLexBLxocZRwvdGJYkUKRdzezsTCz2enOYraEsZuKEV7
        n4JCPagPYnDaUnn2oGOkjRWlrXUVcsV9obQWDP4bP3xpUA1gDu9Pdyff8eq2+0DJhRFcn0vgBLhqi
        F1G6fnEQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nskOC-001Gj2-Dp; Sun, 22 May 2022 12:08:52 +0000
Date:   Sun, 22 May 2022 05:08:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Jan Kara <jack@suse.cz>, kernel@openvz.org,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] fanotify: fix incorrect fmode_t casts
Message-ID: <Yoon1ED+HnA7691y@infradead.org>
References: <9adfd6ac-1b89-791e-796b-49ada3293985@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9adfd6ac-1b89-791e-796b-49ada3293985@openvz.org>
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
