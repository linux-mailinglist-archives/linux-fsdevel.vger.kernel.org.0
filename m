Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C74270B1F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Sep 2020 08:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgISGbZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Sep 2020 02:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgISGbZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Sep 2020 02:31:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA667C0613CE;
        Fri, 18 Sep 2020 23:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0OIz+Y/tmGoktY412KC48pn65AR3ttVllKRQnW+2Z20=; b=KHZPlrmdERh7cvy81ooz/Z2f2C
        0MpnExqDk4+/ZWajFltkGJaub6uzSHvCOIo3bZLAn7pNFz5mEvmfd32kV6o6/cp68s524Bsh6VBWp
        CVWLCZWoK/pyp/KlkWLVHgtzXLpTuZQ3V21JQ0cSG5Fb57uZ+Qgee3Gai9dAEnrEgmG8T/pzCfaMd
        +zaDkgvk8lcXn45oOhfMhFOL1S6G7BYtfCJLY3edXbDcwNObrz/ed28uamTjR82ExEQNxtwN5EzeF
        5G3vLyF4/AVJDDxctrGXhKdbaGSpeydichvhHnhsTZMoscYKx64pfkxk+zL/64BwrHlNYa/n7Ybr2
        id3ZBN7g==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJWP5-0003sO-9b; Sat, 19 Sep 2020 06:31:23 +0000
Date:   Sat, 19 Sep 2020 07:31:23 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 15/13] iomap: Inline iomap_read_finish into its one caller
Message-ID: <20200919063123.GG13501@infradead.org>
References: <20200917151050.5363-1-willy@infradead.org>
 <20200917225647.26481-1-willy@infradead.org>
 <20200917225647.26481-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917225647.26481-2-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 17, 2020 at 11:56:46PM +0100, Matthew Wilcox (Oracle) wrote:
> iomap_read_page_end_io() is the only caller of iomap_read_finish()
> and it makes future patches easier to have it inline.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
