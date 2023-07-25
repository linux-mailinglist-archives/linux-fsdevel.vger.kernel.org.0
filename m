Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A056176061C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 04:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjGYC7Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 22:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGYC7Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 22:59:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30088F1;
        Mon, 24 Jul 2023 19:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Epb2csY3/LqtVAz22W5Sq6XOj60dVZlS3UYZJuViHC0=; b=tMuQxowIiARLb+tpOBJ1PfxQoh
        Bd8AAXbOn8bHIHxQ13dcAxi08oV9PyTtn1WmGWtW2ULg/V8n3jVEvTxgedGkxLE4hv9qbeHAAU9f8
        ope+pLJjR678BV/ydqlc6C/AAS4tgtRp1uH54vDOY5q5dVWfHGVDvkRQ16emEAPxEPy+xnKNvmXMD
        5iUFX8qw3mSfMQ/2oZ6yp1Z/JKGOYETUBCNj+CnFD4cgChWNWE2eqAioTJJSTBNGMteT75ZnvAUJ+
        Xgnv2HWGmlL+W0FsrtcZIRxF7p7HWnM/5JSIyFKl5iUm5oYGbhujoRRPSR5XpXONaBdOAvOUlndzx
        Vh3V7cuQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qO8Ge-0054V5-9p; Tue, 25 Jul 2023 02:59:20 +0000
Date:   Tue, 25 Jul 2023 03:59:20 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 04/20] block: Add some exports for bcachefs
Message-ID: <ZL86iDwK4EwdUJ9b@casper.infradead.org>
References: <20230712211115.2174650-1-kent.overstreet@linux.dev>
 <20230712211115.2174650-5-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712211115.2174650-5-kent.overstreet@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 12, 2023 at 05:10:59PM -0400, Kent Overstreet wrote:
>  - bio_add_folio() - this should definitely be exported for everyone,
>    it's the modern version of bio_add_page()

Looks like this one got added in cd57b77197a4, so it just needs to be
dropped from the changelog.
