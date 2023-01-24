Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4686267993E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 14:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbjAXN0Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 08:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234188AbjAXN0P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:26:15 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167041204E
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 05:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=v1TYA6BE0SUNRkb9nZa9IDmBfe
        dnwfvoblspPTkSVvrBhuFU8Qci2dkQFIEEY6i0ljfYmv2FnkqnIUaoY6+t+VgFOdGUfkkvZPrtYAW
        EcTyEYnOrhQ3CQXNHmrAI07u4E56CG2qD18OYZnW1+JAq8sQdSgP6dbSepjiE0ownayjlYlDLIOh8
        3aCdHIHBKYsznay/l8T9Y1gSC6g69qfDtYMew/nWJY5l27sCtAp3T++ksw3Tz91tqk/gUhY8nTBY7
        EQaBIzg2188/HjOuDl91RK9mEjsjhJJwGMOeXgXbLdPbDyizt32nlOpPzFEr65Hvw3iZZyMk4VefQ
        aJqibBWw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKJJW-003yWU-Nv; Tue, 24 Jan 2023 13:26:14 +0000
Date:   Tue, 24 Jan 2023 05:26:14 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 04/10] udf: Convert in-ICB files to use udf_write_begin()
Message-ID: <Y8/cdvNzmErOQd/1@infradead.org>
References: <20230124120221.31585-1-jack@suse.cz>
 <20230124120628.24449-4-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124120628.24449-4-jack@suse.cz>
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
