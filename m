Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518AB679929
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 14:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbjAXNWN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 08:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbjAXNWM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:22:12 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4575A4489
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 05:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=NU8WWuUFsbBkKqiOJpWCpttL2B
        cGRJKC/mflkFbS2VrS5iSBQvlHf4GCE0MSoIFNL+b6Sh53xLCCpaIPGr4SvC6uKmcZiUjjWSQByQn
        DFWukWd71sKeqSOTy/oKhNXOghqwknb5Nl+R9yhSIB/P/+by0ppDaVb/JwzJ3UcV2yBbPZDkhyv1o
        bXX98a+q2X5t8EkDexcyE+pcMY/naD16/4z6y56N+tAifNfUryHoxuddxB5xPmnvEWerDN63D0uu6
        TVoB7i5/A7VGd/3mDmb4EI68fSkDH6Vo8jNClKr8v9e++Gr2SAhdIX8VxVYKuuwC7ENov57PUS27G
        fNbN39dQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKJFb-003x4u-So; Tue, 24 Jan 2023 13:22:11 +0000
Date:   Tue, 24 Jan 2023 05:22:11 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 01/10] udf: Unify .read_folio for normal and in-ICB files
Message-ID: <Y8/bg1lkJsvFkFGJ@infradead.org>
References: <20230124120221.31585-1-jack@suse.cz>
 <20230124120628.24449-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124120628.24449-1-jack@suse.cz>
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
