Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A5B679945
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 14:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbjAXN2x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 08:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbjAXN2w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:28:52 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B16136FE6
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 05:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=BAFHWxomQOHwCVJkCSk6rjjc4W
        Zn4q66p2454piaRztE8L9IFVR5sFykid/sm1B0A5jQQL/7L+uyQwItQzveEv6nKWxl8j5B+nbdTGC
        rKdnu2B/PpjI7y9yAMtfa1pS4hkuWQie1GYIK510paKrTQsH8HkQt6yndlvkmwCk768m4uYJEtHEb
        43gjw8u3e0dlc9fmuMF2bRDY+T8/MSLviVz4D1dwNKQBLpkqDNgzk2MCkKUC8VzgbdF59FH7+yi1z
        jmM/waMZxHki8qrZ/qa9jGSbBnxp1XHYyemjq8pywW7HJJif31fsqA/CeXGP6XwCBzkVOAg5JXkGw
        3RkU9ZqA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKJM3-003z7Z-T0; Tue, 24 Jan 2023 13:28:51 +0000
Date:   Tue, 24 Jan 2023 05:28:51 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 09/10] udf: Move udf_adinicb_readpage() to inode.c
Message-ID: <Y8/dE91W+bwsDl8i@infradead.org>
References: <20230124120221.31585-1-jack@suse.cz>
 <20230124120628.24449-9-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124120628.24449-9-jack@suse.cz>
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
