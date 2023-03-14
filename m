Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCCC6BA29E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 23:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjCNWkb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 18:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjCNWkb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 18:40:31 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E231C654
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 15:40:29 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32EMeME4012257
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 18:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1678833623; bh=ryy2gHceCz7U7eBLE+KsWWRcNA3fC3y1BsyvrZqEWFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=NvQSTG11p1BOW9X+k8F6SBsf4DFd58M4Qd1A5zxfVgGWGDO6mpcAhgVCT6TnQzHke
         MhWcNhXRBSW3HW34+O/UFygQS4G3q+pjLWgnogaDDJfZlA7PaH6jKoLWRfe+DTxsys
         5RS9v93hq9JX5MGxjdyhmNxz6szmnq/E6z3VjB1TenPjOcYppzn43eQHvC0NaaVIT2
         6B3GOV/peFZpXtnN1uYVWnkvK86CCud0pfpUCu6aaD2TsrjVZHtLR+ZD1YxnU1BxOS
         8vyMXjWk2wYav24vFBVbMbCdCcToKRzKOhDBi9BRSTYxE1oK6bMXrlFiOF8u9fcrIg
         zB6ukIPGR3EjA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 5093915C5830; Tue, 14 Mar 2023 18:40:22 -0400 (EDT)
Date:   Tue, 14 Mar 2023 18:40:22 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 16/31] ext4: Convert ext4_write_begin() to use a folio
Message-ID: <20230314224022.GC860405@mit.edu>
References: <20230126202415.1682629-1-willy@infradead.org>
 <20230126202415.1682629-17-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126202415.1682629-17-willy@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 26, 2023 at 08:24:00PM +0000, Matthew Wilcox (Oracle) wrote:
> Remove a lot of calls to compound_head().

I'm still puzzled about how this removes a lot of calls to
compound_head().  I must be missing something...

