Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F856BA1CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 23:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjCNWHe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 18:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjCNWHd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 18:07:33 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B5E3028F
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 15:07:32 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32EM7OaZ027324
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 18:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1678831646; bh=jcmelG6obrC15YOqB2zcZfmcMci+2RWg70Q75ODKlSg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=jIJEaJsNu8tUzxBuKvtdVz9Hm7mXbuONAGoKXhUOX7uCrogEPAZNh03MyiivVfpRQ
         328ZjMuVO6RiTygP3wzsA1IQ3q8cjEg4KXszoMMrfbKw18xXnfrJI24XuGU+yqC2uY
         trYVcxvWzeWbFRQBJq+frjr3CRDgiFWTtAKEnaH3UmcqGSjYSxBxSon9mWz/ea9wCG
         U1Fr8nLpxnvwuVKTVdQUGAYOmriD7Va57LwmN7MRpPZkug+x3tCbxGj5Q72eVCG7WI
         fKewjolgLVmQQKWmDbgHvYXokc/UIznRou9t08PwrS9EGv5DyTUBkhZa9jSk3gkS+h
         jA6gYO94Be0KA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A13A415C5830; Tue, 14 Mar 2023 18:07:24 -0400 (EDT)
Date:   Tue, 14 Mar 2023 18:07:24 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/31] ext4: Convert ext4_bio_write_page() to use a folio
Message-ID: <20230314220724.GR860405@mit.edu>
References: <20230126202415.1682629-1-willy@infradead.org>
 <20230126202415.1682629-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126202415.1682629-4-willy@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 26, 2023 at 08:23:47PM +0000, Matthew Wilcox (Oracle) wrote:
> Remove several calls to compound_head() and the last caller of
> set_page_writeback_keepwrite(), so remove the wrapper too.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
