Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E7D26D342
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 07:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgIQFtS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 01:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgIQFtR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 01:49:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E404C06174A;
        Wed, 16 Sep 2020 22:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GiwFRW1ZtIFDAqQ61AdUJkp4N6IEsRuymLNdIuMlYHE=; b=I/vt8ixGVQ9KLQmUhMfUWDBZW/
        QbD8MPFgsPr/fTIbN2C/qjx5rL7hD9IKJsZTGMqzf5F1vwVZ73tbPHFjSOXBAEmmEIM2rb2fsQaPv
        /gvzflqbIkgjTGXAUPC/nijE1gxJfVAIWlnS0OdOgsMUlHZAq5yEzyDn9kGvKTop4XF4V1dXMGFIW
        bYWCVXnD/wQW83xwWYfmD4OsjIhhqrkjRCdlkMsa3DK6NEc8+GvlWn1ajVy/oSWTe15UOseX1JgAO
        kSvgioiQMA8aTeYhAkJs2WSoSvuOvUVkaWQGkp52yzCv1Z2OJ1XttJyQv4FPkM0a7yzjmpNJ4tUKg
        No0jzIxw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kImnC-0007tX-0n; Thu, 17 Sep 2020 05:49:14 +0000
Date:   Thu, 17 Sep 2020 06:49:13 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Qu Wenruo <wqu@suse.com>
Subject: Re: THP support for btrfs
Message-ID: <20200917054913.GA30181@infradead.org>
References: <20200917033021.GR5449@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917033021.GR5449@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 17, 2020 at 04:30:21AM +0100, Matthew Wilcox wrote:
> I was pointed at the patches posted this week for sub-page support in
> btrfs, and I thought it might be a good idea to mention that THP support
> is going to hit many of the same issues as sub-PAGE_SIZE blocks, so if
> you're thinking about sub-page block sizes, it might be a good idea to
> add THP support at the same time, or at least be aware of it when you're
> working on those patches to make THP work in the future.

I think the right path is to switch btrfs to use iomap for buffered I/O
as well and piggy back on all the work you've done..
