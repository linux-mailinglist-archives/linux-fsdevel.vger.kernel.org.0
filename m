Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6373C2A18AF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Oct 2020 17:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgJaQUN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Oct 2020 12:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgJaQUN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Oct 2020 12:20:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12A7C0617A6
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2020 09:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k1PEEXuWR7bG1QQkR4pN0hbrop1yryXTxtXR/XMLLqs=; b=RT6JjtaaaTUBjjfbDoIvPlTg5N
        HDINOp8k3xwu/8jorAzp1pigtieOSreHLWxdiorkRz/k+eXhpzU9UilUV0ZdY9eCSHgvxrezJXWsH
        ICFxQ8lVXUftHiHKyoDBP9SPVBUWUhGUxqy8OZP9RaevkVOa+SAinMIbGJ2Px8iiupyzywkQwCDRo
        6j7as1OJqyRKlb6x8KWIMgbSCC882H3Y8hlUso9K+KwPuu7DJFTOCBZpNmjhg3Sd9Hx7z0bjJbOWn
        zNdd9Iif7FZwOGc/PiYA589E0pdAXedrUA7++GqJw3Egw4qdIbGhhvMUc+L5ZHJIBxgPXns7wS40G
        m4OVHzwA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYtbs-00067D-NC; Sat, 31 Oct 2020 16:20:08 +0000
Date:   Sat, 31 Oct 2020 16:20:08 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/13] mm: simplify
 generic_file_buffered_read_no_cached_page
Message-ID: <20201031162008.GR27442@casper.infradead.org>
References: <20201031090004.452516-1-hch@lst.de>
 <20201031090004.452516-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031090004.452516-6-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 31, 2020 at 09:59:56AM +0100, Christoph Hellwig wrote:
> -	page = page_cache_alloc(mapping);
> +	*page = page_cache_alloc(mapping);
>  	if (!page)

	if (!*page)

