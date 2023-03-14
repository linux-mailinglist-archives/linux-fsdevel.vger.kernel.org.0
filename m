Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE306BA296
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 23:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjCNWhh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 18:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjCNWhg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 18:37:36 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAA948E3F
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 15:37:35 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32EMbSGw010983
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 18:37:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1678833450; bh=jotX2Zk8u51GwO1KnbxwU/nV6csm+6YqiDnrqdYjavs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=NmvdnR4JSpIVmZvwHT/41iuuOPckSoH2DO/0+N3/pqDitKXQjsH87hctZD9C/76cn
         dzItmeuCpdmqpatZxmTihMvomTOSIUlOdjzyQR58XZv1DKzYvIlPvlslvI4y9CJ9D3
         RZdml7GfgiEm6Iyvz9oDPtEVRH4n4nljxLS8ulTekXMgnjF+X4A7b2kAn5F1pmTCK+
         q+TYGY1BxPg5/AslM4/dY92vbNpoNHavltuMB+6cifmVA6UHDBdDbf3hTJ0V9BIklI
         UEF9hl4P19AzCJbuoHhIoB5jeevpQqy9yhtk1HzzTpLy2Dex8XotuqK4qHsHBTMD9v
         QGc2v4o19eTBg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7647115C5830; Tue, 14 Mar 2023 18:37:28 -0400 (EDT)
Date:   Tue, 14 Mar 2023 18:37:28 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 11/31] ext4: Convert ext4_try_to_write_inline_data() to
 use a folio
Message-ID: <20230314223728.GZ860405@mit.edu>
References: <20230126202415.1682629-1-willy@infradead.org>
 <20230126202415.1682629-12-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126202415.1682629-12-willy@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 26, 2023 at 08:23:55PM +0000, Matthew Wilcox (Oracle) wrote:
> Saves a number of calls to compound_head().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Same comments as patch #10 -- calls to compound_head() and
memfs_nofs_save vs. FGP_NOFS?

					- Ted
