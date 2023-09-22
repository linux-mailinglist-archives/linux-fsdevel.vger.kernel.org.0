Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6DE57AAA38
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 09:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjIVH1i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 03:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjIVH1g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:27:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0283192;
        Fri, 22 Sep 2023 00:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fTffBsX5ZQ8vPtCXH0LV4fT/b+RfyYh64dbzhekWoNI=; b=mshh8jDMfgVNGvBmiFE6AIEqGr
        4vbNkAMCy52Tor4002Rv+fFwYNRp6Q17WNzhpkCJv82PADIydl+YLCs0JkH9oJM7bBWbXGKyj01Ct
        9NXn8tywK6JBQlGclnH7teUEAO36gdE2M5f7/heRL12x3OOGj2TbJLYalVTmZvUJzL2SBHSjpA7/b
        M5S/mWBZLIjs0fvnqEMRWrUDr/gXANRBWdP+3JfDQhoH8bXM6RggDiPk1xK+jH+Jf1si6dX8ybKTQ
        KVUfSXQsmikclPXIixb41wVocMwTkk06XC8qe3URN59KVOrfIXNYJnyrLEEQLGbhjGM5PA/bJbxth
        yt5INcUA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qjaZO-00Gv6p-QT; Fri, 22 Sep 2023 07:27:22 +0000
Date:   Fri, 22 Sep 2023 08:27:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Minjie Du <duminjie@vivo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "open list:PAGE CACHE" <linux-fsdevel@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com
Subject: Re: [PATCH v1] mm/filemap: increase usage of folio_next_index()
 helper
Message-ID: <ZQ1B2vtv5b2K4lwg@casper.infradead.org>
References: <20230921081535.3398-1-duminjie@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921081535.3398-1-duminjie@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 21, 2023 at 04:15:35PM +0800, Minjie Du wrote:
> Simplify code pattern of 'folio->index + folio_nr_pages(folio)' by using
> the existing helper folio_next_index() in filemap_map_pages().
> 
> Signed-off-by: Minjie Du <duminjie@vivo.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
