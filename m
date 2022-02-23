Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25BA4C0CD4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 07:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237806AbiBWGzJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 01:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbiBWGzJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 01:55:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D49B6E4DD
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Feb 2022 22:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=h6hbjyX3Gig/hZKOdfXJBBwpqT
        T6VyBYvn9jpfyiW7uQNjatleYk6ktRX9uza5WlsKsq2JGUsc0JR31TxWDEUiZB+5P8qZGA6n46Pe2
        aFRmui0AemD9lXlxTOe14BjEXtAuCrS6mW6rIks80uMLYqPpvo2C33re99zrzApjoqiYl4BaABJ+G
        wErG9fh2x7uXz+WLsztjzt4RrTA7cNpEpwGlxH2Tln8bzkWAqAWv+VUt8yPw4NSqwQTWFgJIupIaH
        cfzGj24YTP6Kf5wocM40qYAVlRFVwQjhzUaAiCnPlM2VqvE6oT8AFtr933NRk90nUpn8Y34U6s9f6
        /3zKg/aQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMlXu-00D39M-1n; Wed, 23 Feb 2022 06:54:42 +0000
Date:   Tue, 22 Feb 2022 22:54:42 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/22] ext4: Use page_symlink() instead of
 __page_symlink()
Message-ID: <YhXaMo5l07lEqSXC@infradead.org>
References: <20220222194820.737755-1-willy@infradead.org>
 <20220222194820.737755-6-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222194820.737755-6-willy@infradead.org>
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
