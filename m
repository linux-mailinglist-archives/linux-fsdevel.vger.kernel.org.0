Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CDD7326D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 07:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjFPFwd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jun 2023 01:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjFPFwc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jun 2023 01:52:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991E72D50;
        Thu, 15 Jun 2023 22:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=VRdHWbShPBGm+sow1Ck5fVeEGr
        D6OimfTFLrtCge4h95BkV5oz4um8EOzUtjtt7Di9ScqY5bzB5+rlyLaYfxml6q5eG5scma88fOOT4
        1U9m1DOEtUzYhjeGrmaz1lvZtA8b3IYMIWzvzGMy8ysybd+tqQ4tSD3jqawUAG6BYcZlfyABvNwvr
        y7OfOfBdEa6ePcdBAsQJdDA5gjGWIADweptdTnIzkjh2ZYRRvIYJJgRG9PySfpFBDOqKGViZ4cG1T
        JNsb/Xxb+h5M9qAc7GKzkym8hzySQoNAX1Sh3Wt/sJmELbb2nSqvwXk+3VzNfdAmu74JNeAXDlm/h
        qt04k5FQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qA2Np-00GwZe-2x;
        Fri, 16 Jun 2023 05:52:29 +0000
Date:   Thu, 15 Jun 2023 22:52:29 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, mcgrof@kernel.org,
        hch@infradead.org, ruansy.fnst@fujitsu.com
Subject: Re: [PATCH 3/3] fs: Drop wait_unfrozen wait queue
Message-ID: <ZIv4nfjH3LdGSRhs@infradead.org>
References: <168688010689.860947.1788875898367401950.stgit@frogsfrogsfrogs>
 <168688012399.860947.1514236710068241356.stgit@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168688012399.860947.1514236710068241356.stgit@frogsfrogsfrogs>
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
