Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAE87161347
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 14:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbgBQN0y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 08:26:54 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37974 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbgBQN0y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 08:26:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PBhD8cmezTHFasz5vzVH0dWQzfsH7+46R6pRA6K+f/c=; b=HZ73dCSyraHQd8K1CeZ64PsCdb
        wIN4YvlZr163/33vNmQ67J2vp9tS+qcPQW1ItzsLMDNnJC+7Tuz2KbrYzHm1xKuw1VTS/78ev5pS2
        j2n/CW/9K+jHHbPA44C+s92ARIYYRXBM3cxouPjo7Djf80/byoKJDjQHNUp/DIbsp98rfaJLaA8vM
        cQ1gRAAQWXFUcZaa7YETpCSLML5iPt5236UKcQ8Luz36p7yZT3lE1DsOXbnP5Bwx62twtrygAH1vp
        R7c/zuB8gnXOAGsWPKMWVgewHy2rh2pf8bUovUWmwk4+bRHnOB5LR7rN9d1964kXv4BM0NSdpXnxF
        g89Vdhww==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3gQI-0004gP-3m; Mon, 17 Feb 2020 13:26:54 +0000
Date:   Mon, 17 Feb 2020 05:26:54 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        hch@infradead.org, dan.j.williams@intel.com, dm-devel@redhat.com,
        vishal.l.verma@intel.com
Subject: Re: [PATCH v3 6/7] dax,iomap: Start using dax native
 zero_page_range()
Message-ID: <20200217132654.GE14490@infradead.org>
References: <20200207202652.1439-1-vgoyal@redhat.com>
 <20200207202652.1439-7-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207202652.1439-7-vgoyal@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 07, 2020 at 03:26:51PM -0500, Vivek Goyal wrote:
> Get rid of calling block device interface for zeroing in iomap dax
> zeroing path and use dax native zeroing interface instead.
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
