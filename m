Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D7036892D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Apr 2021 01:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239667AbhDVXEs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Apr 2021 19:04:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:53446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235977AbhDVXEs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Apr 2021 19:04:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07C5561404;
        Thu, 22 Apr 2021 23:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1619132651;
        bh=vA4fccGurUW70w+o8RGtEPk7gkY8fpTMPGiph2c4fI0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pkg01P7P4zQf82ckyoI+kHR/5EDiAY8k12vsYKYnZg025s5d1GB9O3kRxsW4IhiyM
         ikaFwQ+siH4nlM+erGeZ2zUwhYT97OGoCLG0kM82icgE4BWv/KAFEKM5wzfzdRszio
         Sz1nLEdUH3ivSnSsO0tYigZNDQPWuvEqGfIzfypA=
Date:   Thu, 22 Apr 2021 16:04:10 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Dave Chinner <dchinner@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2 2/2] mm/filemap: fix mapping_seek_hole_data on THP &
 32-bit
Message-Id: <20210422160410.e9014b38b843d7a6ec06a9bb@linux-foundation.org>
In-Reply-To: <alpine.LSU.2.11.2104221347240.1170@eggly.anvils>
References: <alpine.LSU.2.11.2104211723580.3299@eggly.anvils>
        <alpine.LSU.2.11.2104211737410.3299@eggly.anvils>
        <20210422011631.GL3596236@casper.infradead.org>
        <alpine.LSU.2.11.2104212253000.4412@eggly.anvils>
        <alpine.LSU.2.11.2104221338410.1170@eggly.anvils>
        <alpine.LSU.2.11.2104221347240.1170@eggly.anvils>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 22 Apr 2021 13:48:57 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:

> Andrew, I'd have just sent a -fix.patch to remove the unnecessary u64s,
> but need to reword the commit message: so please replace yesterday's
> mm-filemap-fix-mapping_seek_hole_data-on-thp-32-bit.patch
> by this one - thanks.

Actually, I routinely update the base patch's changelog when queueing a -fix.
