Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083E731672D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 13:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhBJMz1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 07:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbhBJMzU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 07:55:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1CEC061756;
        Wed, 10 Feb 2021 04:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=Hv0rYVEpd1n4OEP7iXk9Rumz6n
        qLB15xerCtNFgLjaXnn8lxBnOqSEs0kX/QBvbkjaayIzwslZ2ax24PBqKLktBcEBxj5QupDLvr4XN
        LnWQ9wu13NNEeEy0DQuf4xZufOH/AxyVUzdWjjr1m7DVx+Insm0MtDR9gAiwRWIW0C+oIgYAPkH9F
        4DgX13eV80JCEr3QXYRE7SQiyHIfc5it7o6Yw2xR23c8d60FUsh+AgtcJHK41pf72LQNKgmYMeOQZ
        w3LoHI5ZnVUv7QsNLW0lXHbvEzf1RIfPgSpGUw4EY1THwTI80Inc6RlVXOGOQdjF1MZhOIzLksCUU
        h80zQgvg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l9p0q-008rR7-JQ; Wed, 10 Feb 2021 12:54:33 +0000
Date:   Wed, 10 Feb 2021 12:54:32 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     ira.weiny@intel.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Sterba <dsterba@suse.cz>,
        Christoph Hellwig <hch@infradead.org>, clm@fb.com,
        josef@toxicpanda.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V2 3/8] mm/highmem: Introduce memcpy_page(),
 memmove_page(), and memset_page()
Message-ID: <20210210125432.GC2111784@infradead.org>
References: <20210210062221.3023586-1-ira.weiny@intel.com>
 <20210210062221.3023586-4-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210062221.3023586-4-ira.weiny@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
