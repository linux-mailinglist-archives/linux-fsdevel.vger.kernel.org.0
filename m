Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8866E49DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 15:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjDQNY2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 09:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjDQNYU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 09:24:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D539759F1;
        Mon, 17 Apr 2023 06:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UX9dBUtND+1iEDhWbGXNEzClv52yhi2SUSDbgmLpjVc=; b=noq8vE1MgDafwO6GqTQZfitqua
        0m21IsBmKg9Tx7It1bfqZIkLpgb9wcHmRYjARrgsJEAwOneaLMX7YbLVXmnAfgXWnJpCL5iTdIVTv
        PNH9c2lI099msSqKb7HxnBXQKXzgFQZPWLxWMOVszK2EKfj++5AFaCPKlQB+Kq0qVLxlij8Tm2VB4
        AJAwSIL+D09hvkcA9lodEYBATdzBYZUFy+GnV6Ul97DYux2FEM+5wcurzAbGo1vhED5S8dZ/9V24+
        FwDrdlgUIHbfLv5MVwa3lDofUcTHFGUVjHtsx4KlY6eV2kiyFWWqp9nFzk8k+0bKoqYY7NUy5rs3S
        i2SH3W+A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1poOpx-00BN4N-O5; Mon, 17 Apr 2023 13:24:05 +0000
Date:   Mon, 17 Apr 2023 14:24:05 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        mcgrof@kernel.org, linux-kernel@vger.kernel.org, hare@suse.de,
        gost.dev@samsung.com
Subject: Re: [PATCH 1/4] fs/buffer: add folio_set_bh helper
Message-ID: <ZD1IdasRltcS+sba@casper.infradead.org>
References: <20230417123618.22094-1-p.raghav@samsung.com>
 <CGME20230417123620eucas1p266aa61d2213f94bbe028a98be73b70fc@eucas1p2.samsung.com>
 <20230417123618.22094-2-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417123618.22094-2-p.raghav@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 17, 2023 at 02:36:15PM +0200, Pankaj Raghav wrote:
> The folio version of set_bh_page(). This is required to convert
> create_page_buffers() to folio_create_buffers() later in the series.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

Yep, not worth making this a wrapper for set_bh_page().

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
