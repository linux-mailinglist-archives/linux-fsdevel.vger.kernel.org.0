Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC093452B18
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 07:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbhKPGkz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 01:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbhKPGkk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 01:40:40 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CE8C079784;
        Mon, 15 Nov 2021 22:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HC6Dgegab7Q5ywGVPZerihzK6ieT/qmHCnJlr5hbOe0=; b=qSfpEjoo0bl9E+6cAQG05Cv21e
        C7i+5MHqJOzbrZrLN90Fdgb6mkBazsdctZM/b3EVc6flilW8k3v6rnCbwTUPUhBX1kw+t6iHtRXm9
        bzI+7CQLhspG0RNSdfn8btQZvaxsPw4GWB3ZUd0gw1URWuTbYclGDvkYYw35xUbHi5m9iOGMmmXxP
        hfFlSht0YXTFQ/FtWdBilD5x2nhgWNmmm7NxQRiiR4mh8KmANZkG0AqumRXzdDXKBE9S+iwM6odcv
        fXdjH7vslgcQmc9w/LqRfuYs62lcgfAKKJ+1YHwzbkl9MVnc5vkfsQxe+uFlxgCPRy9lTvjtOVds5
        R1J8Q8KA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mms2S-000Qzi-HD; Tue, 16 Nov 2021 06:33:52 +0000
Date:   Mon, 15 Nov 2021 22:33:52 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong " <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 04/28] fs: Rename AS_THP_SUPPORT and
 mapping_thp_support
Message-ID: <YZNQ0Pg7mjYNoMXm@infradead.org>
References: <20211108040551.1942823-1-willy@infradead.org>
 <20211108040551.1942823-5-willy@infradead.org>
 <YYo0L60o7ThqGzlX@infradead.org>
 <YZKEyrrH4SjqV8W7@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZKEyrrH4SjqV8W7@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 15, 2021 at 04:03:22PM +0000, Matthew Wilcox wrote:
> I think I prefer the term 'large' to 'multi'.  What would you think to
> this patch (not on top of any particular branch; just to show the scope
> of it ...)

I don't really care either way. Just be consistent and maybe add a
comment here and there..
