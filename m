Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BC84D1E43
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 18:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348667AbiCHRNw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 12:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348668AbiCHRNt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:13:49 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1D022515
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Mar 2022 09:12:50 -0800 (PST)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 228HCh9Q016154
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 8 Mar 2022 12:12:43 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 1384015C00DD; Tue,  8 Mar 2022 12:12:43 -0500 (EST)
Date:   Tue, 8 Mar 2022 12:12:43 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 09/22] ext4: Allow GFP_FS allocations in
 ext4_da_convert_inline_data_to_extent()
Message-ID: <YieOiz5A991FeRxf@mit.edu>
References: <20220222194820.737755-1-willy@infradead.org>
 <20220222194820.737755-10-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222194820.737755-10-willy@infradead.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 22, 2022 at 07:48:07PM +0000, Matthew Wilcox (Oracle) wrote:
> Since commit 8bc1379b82b8, the transaction is stopped before calling
> ext4_da_convert_inline_data_to_extent(), which means we can do GFP_FS
> allocations and recurse into the filesystem.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Theodore Ts'o <tytso@mit.edu>

(Or would you prefer that I take these through the ext4 tree?)

    	      	     	    	 - Ted
