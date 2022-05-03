Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2145186E5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 16:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237178AbiECOm1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 10:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235833AbiECOmZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 10:42:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C1B35859
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 May 2022 07:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=EP+r2I1P0vKI7yJRgQMvYyRBf8
        ieis/+W+MOPXiz0qZLURubcfhuKHocUXX1gq2admFVO0MT+pkh0yCUWED6mqzsqMThF/TiNkWPfv5
        GImHAe6puEM4eZN/tujQUexgyLFKB5HFYH4mHJxF2jZQEBJl9MA6JIqjsvAj5CExIhdKbxbiEjyvp
        nuoW1J/3eYPet/ZGTnx/l+XPACRCZc+OldFdwlHncPGv9BUH+PqHbQmp3puW/df+4wF9ejA1ZaqbY
        jd+3oHpJCeYgzbSRLoVjt6Wp6iTlV2T/OPM028R1p4p6QhHrkYs3oukQ7UIKNeu1TCInmO3LzhLV8
        yUbFJrWg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nltfx-006InR-Gn; Tue, 03 May 2022 14:38:53 +0000
Date:   Tue, 3 May 2022 07:38:53 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 29/69] readahead: Use a folio in read_pages()
Message-ID: <YnE+ffXsQNoxRRNe@infradead.org>
References: <20220429172556.3011843-1-willy@infradead.org>
 <20220429172556.3011843-30-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429172556.3011843-30-willy@infradead.org>
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

