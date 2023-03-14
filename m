Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72DE6BA29C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 23:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjCNWjQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 18:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjCNWjO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 18:39:14 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DDB1CBF8
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 15:39:12 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32EMd5iW011711
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 18:39:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1678833546; bh=xZrLN2qlAAEajR6FubdJejRJJAjAoYO3U6MrEyROW2A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Ln60Lley8pFK0wlj5G8YLH6CIpVl7+x1PS3FeJv5lg1wQUNu7K77azt/Z8wgQs2Oh
         Qmbp2Bpyf03m7SAQ2baVm1XFIeR/LZcGD/NF9FzIIxRLe6AukW6KvtbFjz4o+i2FBy
         NsOWvzCSJ9+IcAXLtQO426vF8CPMTe8r6W+kK2xH/iDeWTJk0hJlj4xRZ6zWf+DiFc
         p52r4VrjJaVZ1V+93AGlKrwbKZkcFKZoWmNO0p6XcyL6oprWWeZApvnnDXEjNeqrXP
         924a/rbTF6COE5HSX/85awuI6JL2zNjguMq3k4FvdTkyoUBxOqDwY/9EXqhnSEPCdf
         6x+sAa0JCElMw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 34FFD15C5830; Tue, 14 Mar 2023 18:39:05 -0400 (EDT)
Date:   Tue, 14 Mar 2023 18:39:05 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 15/31] ext4: Convert ext4_write_inline_data_end() to use
 a folio
Message-ID: <20230314223905.GB860405@mit.edu>
References: <20230126202415.1682629-1-willy@infradead.org>
 <20230126202415.1682629-16-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126202415.1682629-16-willy@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 26, 2023 at 08:23:59PM +0000, Matthew Wilcox (Oracle) wrote:
> Convert the incoming page to a folio so that we call compound_head()
> only once instead of seven times.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
