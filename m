Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9296BA299
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 23:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjCNWiT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 18:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbjCNWiR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 18:38:17 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB5930F7
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 15:38:16 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32EMc9qV011375
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 18:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1678833491; bh=XLAq7Zvrq5P0gY91Jf54oZ/F8r2eK3cRG/4+JLVEvLY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=kw4DmEYpI+Kqq/SKxdlF9zsKz5cF2FWKawCreMegq3UtCxIyezbgEOKWl5SIfrI7o
         k1osP+eRZvAx4NmZK8Hm1Wsvjiqy8jNd3jUbGPOw5qti8v6fzvuMqNLWDjyM26KjzM
         sxKLmn3hzX8gy9l82xO7fRYblCPAanGqQjo6N2pY5SRYOIQQZ2CXJbrvTqmTQbKT74
         c1yVXAMW76tTuUqqZdBPQP1Ymm8GYJeYk1nDEf7khyxK2Jz53kv0NyxyrAaq1EuoC6
         AecqHuvT8b1FhfsxGLCMl/n3Ll5FGPfD0Yo8gjP5Ancvm7/mnhRRn3l/dxVQD81HfW
         u/h62PJW6HBPA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8EFD215C5830; Tue, 14 Mar 2023 18:38:09 -0400 (EDT)
Date:   Tue, 14 Mar 2023 18:38:09 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 14/31] ext4: Convert ext4_read_inline_page() to
 ext4_read_inline_folio()
Message-ID: <20230314223809.GA860405@mit.edu>
References: <20230126202415.1682629-1-willy@infradead.org>
 <20230126202415.1682629-15-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126202415.1682629-15-willy@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 26, 2023 at 08:23:58PM +0000, Matthew Wilcox (Oracle) wrote:
> All callers now have a folio, so pass it and use it.  The folio may
> be large, although I doubt we'll want to use a large folio for an
> inline file.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
