Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D208F3F3D47
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Aug 2021 05:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbhHVDcu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Aug 2021 23:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbhHVDcu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Aug 2021 23:32:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50C6C061575;
        Sat, 21 Aug 2021 20:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=F3EUlb3R/Jkd83ODBtsIny7A4msWrAlpyjp5NKlJHP0=; b=XPKz3sMtd1ZsLY003mry3sF2zf
        XiwazOIRt2825xKagpLkvJ5AWVQVQ/LWr1w0hTeTkUHb8WiGA9VxpcKMQAeGzlmdgj/3U+wfuT8p1
        cd9zN3pWfQmPyR+9cVcKargExQNQN/ShukVXh0VK1uZqXR5RqIZD66VgWJ53pim66JTeHxbqvn7qG
        rxii3qRQu0iPlgEx/mmyAJR4eqGhOvYNSu/tIKHys4lAlKwlQWU63/j7M+yfzSS8g49eXWn8Kaaei
        qcnZWLS+YY0yKmcG6BqNDCe1OEAcnZh6aDGQRLAcENWF9piAwAKv3zcnwh1d0BVeuU4d5lfhoRuZF
        LN6EniVQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mHeBk-008ARv-8l; Sun, 22 Aug 2021 03:30:46 +0000
Date:   Sun, 22 Aug 2021 04:30:24 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] iomap: standardize tracepoint formatting and storage
Message-ID: <YSHE0MwgIugfkAzf@casper.infradead.org>
References: <20210822023223.GY12640@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210822023223.GY12640@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 21, 2021 at 07:32:23PM -0700, Darrick J. Wong wrote:
> @@ -58,8 +58,7 @@ DECLARE_EVENT_CLASS(iomap_range_class,
>  		__entry->offset = off;
>  		__entry->length = len;
>  	),
> -	TP_printk("dev %d:%d ino 0x%llx size 0x%llx offset %lx "
> -		  "length %x",
> +	TP_printk("dev %d:%d ino 0x%llx size 0x%llx offset 0x%llx length 0x%llx",

%#llx is one character shorter than 0x%llx ;-)

