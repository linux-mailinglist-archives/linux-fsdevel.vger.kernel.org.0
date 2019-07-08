Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6F4F6288C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2019 20:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388316AbfGHSqx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jul 2019 14:46:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52310 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728109AbfGHSqx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jul 2019 14:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dKndpnfDRuzEXqd8NESls6FfbKscantgDxBPwqxYH2I=; b=ggZMUBppZ87RS3mus7iWCiTgQ
        rz2CoMNWgChuBgw9eD1CQ8+ATPL1evNAgZLZGdKBKSOxXvnQ9IBD13LuFPBw9m9SZWj7Wh6quOXce
        d80b/elXqmxei/DpTySs5EoIuFIo9hxKuQ2aioKn04jpLlAUGhXTnD6UxbTmzcO4GIf553j1WpckN
        DbABu0OmCv4ylMcruTT00rKe2R6DOfmMcBlNCl8020SAJiXw8uJkwN4hK4NsHEOpoTtdQ2zKZdLGi
        lxEkAurzQCYD1/Lr9R+b0ixwuomleaGbvlmBdkGWxIdfaBeEBNO+gFHVpi+acxYSwWajd+jozxTZ5
        +FySg7d5w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hkYf6-0007Wh-KL; Mon, 08 Jul 2019 18:46:52 +0000
Date:   Mon, 8 Jul 2019 11:46:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     hch@infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 00/11] iomap: regroup code by functional area
Message-ID: <20190708184652.GB20670@infradead.org>
References: <156200051933.1790352.5147420943973755350.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156200051933.1790352.5147420943973755350.stgit@magnolia>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 01, 2019 at 10:01:59AM -0700, Darrick J. Wong wrote:
> Hi all,
> 
> This series breaks up fs/iomap.c by grouping the functions by major
> functional area (swapfiles, fiemap, seek hole/data, directio, buffered
> writes, buffered reads, page management, and page migration) in separate
> source code files under fs/iomap/.  No functional changes have been
> made.
> 
> Note that this is not the final format of the patches, because I intend
> to pick a point towards the end of the merge window (after everyone
> else's merges have landed), rebase this series atop that, and push it
> back to Linus.  The RFC is posted so that everyone can provide feedback
> on the grouping strategy, not line-specific code movements.
> 
> This has been lightly tested with fstests.  Enjoy!
> Comments and questions are, as always, welcome.

Do you have a branch somewhere for the layout?

To me it seems to be a little too fine grained and creates tons of tiny
files, which make hacking the code painful.
