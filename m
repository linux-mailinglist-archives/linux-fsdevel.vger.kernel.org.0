Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF887316759
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 14:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhBJNAB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 08:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbhBJM6O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 07:58:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB65DC06174A;
        Wed, 10 Feb 2021 04:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=IqKIAsTBBNlTHGgnaNfur7O4aM
        bC3ZcQe3VRDVMH+R2JJZvZXQ4N9qHALLsw6mJxdNS8g5Elop4lib+IvaqMMH/ccmZ/lnA83bpq2f3
        uBN7ixHV9DzJD7nKnUv7m7iTIFAWugHaTmhkyYQMwW9sJaARMf8Oc0AC9uGltmUYLl6me9fg8ka8n
        wm8nqgWsGxTajD7XXUeNBWnofahEjo6zhbar1RBoPB1E3l+6iPiFqRWGSDLbPdRgiHtaChDxlOR8X
        1HkNHaBOjLpag+41ITdCXrAM+HiFIEHzwFP87EdOmf53scy4beBArU54bkrRjv+C3ee6hSDG5wOd+
        azl/uieA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l9p38-008rem-2V; Wed, 10 Feb 2021 12:56:55 +0000
Date:   Wed, 10 Feb 2021 12:56:54 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     ira.weiny@intel.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Sterba <dsterba@suse.cz>, clm@fb.com,
        josef@toxicpanda.com, Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V2 7/8] btrfs: use copy_highpage() instead of 2 kmaps()
Message-ID: <20210210125654.GG2111784@infradead.org>
References: <20210210062221.3023586-1-ira.weiny@intel.com>
 <20210210062221.3023586-8-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210062221.3023586-8-ira.weiny@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
