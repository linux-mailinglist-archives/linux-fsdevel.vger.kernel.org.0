Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961B06C76BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 05:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjCXEzM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 00:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjCXEzL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 00:55:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2903612853;
        Thu, 23 Mar 2023 21:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4xfGKhb9IozGjR3IxEIOyqOz3q5+3SGP7o3cHCqrQ7s=; b=riqeIObEAgGyfimLpTLX3gsyA6
        EAE1UYXT9kwcb2lAgX3o1+FeGZdmUscZdv5x/mdFFRaf8GN+iIrpHNGqUShmbITyAgVVMuuYs/bVk
        ZFt7P5ZuGLONo+waQOMDD+zF3Vw6pSz+U7ErEMaL1zCSt5JN23QBmxiwwGHq5VK3+fyX1VAIefWFy
        qWdBBIRqRgw+BBwgQGpV+zbyIZPiD6yMCHOnG4SCm3EevDPRbFK6MzvUPOaCfO7go2oFHfpaqPgiI
        CplNxKLrbVXLwBuK6Iw0LdlR8PkfKwGlRL/CgtRhBwXmZxGGmeI3i41DEHvvAfyrmO5sfVt4HZykA
        qCv/0WXg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfZSD-004ac7-Vm; Fri, 24 Mar 2023 04:55:06 +0000
Date:   Fri, 24 Mar 2023 04:55:05 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 21/31] ext4: Convert __ext4_journalled_writepage() to
 take a folio
Message-ID: <ZB0tKQ+6BM9n2Id5@casper.infradead.org>
References: <20230126202415.1682629-1-willy@infradead.org>
 <20230126202415.1682629-22-willy@infradead.org>
 <20230314224752.GG860405@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314224752.GG860405@mit.edu>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 14, 2023 at 06:47:52PM -0400, Theodore Ts'o wrote:
> On Thu, Jan 26, 2023 at 08:24:05PM +0000, Matthew Wilcox (Oracle) wrote:
> > Use the folio APIs throughout and remove a PAGE_SIZE assumption.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> This patch should be obviated by Jan's "Cleanup data=journal writeback
> path" patch series.

Yup, it's gone in the rebase.
