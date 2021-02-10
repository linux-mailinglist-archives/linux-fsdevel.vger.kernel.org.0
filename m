Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35EF31675B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 14:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbhBJNA6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 08:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhBJM6z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 07:58:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41A4C06178B;
        Wed, 10 Feb 2021 04:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=SVwLQp7I5WLE+pXgbUZPeZF3uY
        ooIZc1hfFp/jo9uvZkDnvwH/ilAkzEJZyRQ4tLZLjP+t4lzloo5N1THgvvVyy+nJLjf1Oev7v+UB4
        LxxsgmWeXQQW3PbgW+kfXhS1cHepU1jSPnsJ7wU7bWp4H2iy0XiaenjE49FzzarsJSW4uNAxSvDG3
        TqTm9zBNzI74V01YCsctUlj+R1q9w9WLMmdPb2BE2IJqpukGrC6u9+CvW92XV9yVBHkiyYBq22j4X
        GlyD0WiI/6aOjWo75fd8cPLMbXlsjwjm2FIXireMx+bkbwKSwvlZZnd/xEW+y5swzx08ep89AOIDc
        MFqp/OvQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l9p3u-008rjU-Fh; Wed, 10 Feb 2021 12:57:52 +0000
Date:   Wed, 10 Feb 2021 12:57:42 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     ira.weiny@intel.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Sterba <dsterba@suse.cz>, clm@fb.com,
        josef@toxicpanda.com, Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V2 8/8] btrfs: convert to zero_user()
Message-ID: <20210210125742.GH2111784@infradead.org>
References: <20210210062221.3023586-1-ira.weiny@intel.com>
 <20210210062221.3023586-9-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210062221.3023586-9-ira.weiny@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
