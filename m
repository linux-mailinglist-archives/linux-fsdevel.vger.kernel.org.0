Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A7F73D8F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 09:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjFZH4L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 03:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjFZH4K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 03:56:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5551B0;
        Mon, 26 Jun 2023 00:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=koVawv21+4nk5EmTbsanG4scAf
        ZitGqUvhvb1pqnPUhBu8dq18h3NwC/QTNsIILUylVoEZCpMnZtvi1lb+uVfA1T6WIwkc6Gg1JAz/e
        mfetdA1UmIoPkuTvY3Pf9m8xgyCC/v1Wtt9grLUvTSVhnFB94EITb2VhmuQIwbACiW2XYQJQvVb44
        axh4/1XFEP/blscM5RSV62nkUxG0UkKipGI3oezFI/uZUMVCca7frZ0UEN3AKB6mOXss8OFgFAymn
        JArOJ92nkFhJIEIkoH6UStLcAan3QGemr4oMhZOaIIK+qxoAdMtOfzingDwxJUwRDQg3srsRb20NF
        KiJxWXBg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qDh4m-009bLM-0z;
        Mon, 26 Jun 2023 07:55:56 +0000
Date:   Mon, 26 Jun 2023 00:55:56 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Bean Huo <beanhuo@iokpp.de>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        akpm@linux-foundation.org, jack@suse.cz, jack@suse.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        willy@infradead.org, hch@infradead.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, beanhuo@micron.com
Subject: Re: [RESEND PATCH v3 2/2] fs: convert block_commit_write to return
 void
Message-ID: <ZJlEjEFzWb+P1ygx@infradead.org>
References: <20230626055518.842392-1-beanhuo@iokpp.de>
 <20230626055518.842392-3-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626055518.842392-3-beanhuo@iokpp.de>
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
