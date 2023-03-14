Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD006BA287
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 23:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjCNWcC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 18:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjCNWcB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 18:32:01 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D1646081
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 15:32:00 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32EMVqEH007995
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 18:31:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1678833114; bh=hknc82xKwui71VsF/Wb2h5iAJRiD/wPUDmgjUOu+/cY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=NA6+6xmctqSvfP9zf9tdj8bocLoQMZ1mRi20ciZzmW63U2VSqIhqozpdry1izo7kT
         5LDC0jZ7s36wvFMLvlW5OGfVE1a2ndBPKBQQF2KGGw8beCLV316gq5LZ8YoXHPBDSx
         5Y+96sODzACxGgwXwupeXOadDEdss3cFzKkX9ApzdJqr8FerO4TzCyMk5B8LXM+h18
         Bgxvv3Ff2LuD8aN3ZJFuZL25pouVcf2m/axNf5eImUlgMbzD0k5L2qktM5Z908b1CY
         ps72dYH2Ola061Ci2Neh3W+YtY8B9CZgop4jbTZYTYIAe7qNj4qf7y7ueePGf32shm
         g0y/NeWnmFlsA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C34AE15C5830; Tue, 14 Mar 2023 18:31:52 -0400 (EDT)
Date:   Tue, 14 Mar 2023 18:31:52 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 09/31] ext4: Convert ext4_readpage_inline() to take a
 folio
Message-ID: <20230314223152.GX860405@mit.edu>
References: <20230126202415.1682629-1-willy@infradead.org>
 <20230126202415.1682629-10-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126202415.1682629-10-willy@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 26, 2023 at 08:23:53PM +0000, Matthew Wilcox (Oracle) wrote:
> Use the folio API in this function, saves a few calls to compound_head().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
