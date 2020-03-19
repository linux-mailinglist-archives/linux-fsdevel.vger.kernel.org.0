Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0C2018B2CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 12:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgCSL5C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 07:57:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37120 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgCSL5B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 07:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zSKNJpg3bSHQZrR6eSGgkELs7AnAMsGUFTR84vG8N+Q=; b=taEbISgvSjSBP5vFWW8bUzGpnP
        MKArSkuRIrMUVzeknqF5IG82BQ0rRpdBkhyPwGJUstzncqnKATxyqnIPY7+1YlPamettzIY62SIOe
        NjePxFuSuYvIN1CyExl08KgCgVOKlBp6PwGzsLBofMZTKcaPyXK6XFyVMrgf7MonLR3osphoWenlX
        sundTKrs1nNxBZQfX9U36K6/ARMpgehcUsyKFiio1oi1/7QqJNa7OAtqjBW7hTx52h5XWExEECCbA
        ybmTAPaH80ciWSV+Cg1RcHvxXwu291GiNoqQjE6jJmuU2a2XkiCwZXJKbC6saBE1jZ5T2EQuOpNT9
        kqks7pWQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEtnJ-0000ue-IU; Thu, 19 Mar 2020 11:57:01 +0000
Date:   Thu, 19 Mar 2020 04:57:01 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v8 00/25] Change readahead API
Message-ID: <20200319115701.GJ22433@bombadil.infradead.org>
References: <20200225214838.30017-1-willy@infradead.org>
 <20200319102038.GE3590@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319102038.GE3590@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 19, 2020 at 03:20:38AM -0700, Christoph Hellwig wrote:
> Any plans to resend this with the little nitpicks fixed?  I'd love to
> get this series into 5.7..

The only nitpick I see left is the commit comment in the btrfs patch,
and a note from Dave Sterba that he intends to review it.  I can collect
up the additional Reviewed-by tags and repost the series.

I'm assuming it'll go through Andrew's tree?
