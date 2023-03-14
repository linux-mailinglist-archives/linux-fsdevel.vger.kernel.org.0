Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5640C6BA277
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 23:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjCNW2f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 18:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjCNW2e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 18:28:34 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B435E23A47
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 15:28:32 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32EMSOaC006269
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 18:28:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1678832905; bh=fWNFcoBy21W5qq7V3IpM4DT7MEjbDp0h6iNvZPsMQdE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=bZPNTn9VX6tjKniSystBP5kcoF2dXe1m3iRUUTvoKjEO4P7HpcEALMtIuCIqUF3IH
         tlienJ0v8CkeeSA7gRkpw/8U4yNrGuH3ulj7R6rsWBgns5NMgX6xf8z4RgZCVhDf5z
         qCWBX1dp7ao7kGMlFATedvCZbUX7xA1E9mmuniToLzi/8fffARftNBXAOY5LDeZT8Z
         0ppfXxsS1OIs77+gBjYD1RNryCIvqflqjLZqTKzwChQb0B5Ri43iuMrWHwdoU84C09
         vO7aPHU5EuNhv9sPu33hfoCkMpXA7aQPHOjqaY+PQvX8Oze1Gos1nq4wsc9p7izp7k
         HVsw57VPDyMPg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0B84F15C5830; Tue, 14 Mar 2023 18:28:24 -0400 (EDT)
Date:   Tue, 14 Mar 2023 18:28:24 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 07/31] ext4: Convert mpage_submit_page() to
 mpage_submit_folio()
Message-ID: <20230314222824.GV860405@mit.edu>
References: <20230126202415.1682629-1-willy@infradead.org>
 <20230126202415.1682629-8-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126202415.1682629-8-willy@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 26, 2023 at 08:23:51PM +0000, Matthew Wilcox (Oracle) wrote:
> All callers now have a folio so we can pass one in and use the folio
> APIs to support large folios as well as save instructions by eliminating
> calls to compound_head().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
