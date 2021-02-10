Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBE931674F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 13:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhBJM6z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 07:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbhBJM5x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 07:57:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CCBC061794;
        Wed, 10 Feb 2021 04:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=fzoJARAPzjUvs/qjwHlLZiZRKD
        v8awGIFwZJsrgYHOqj6M5eRZyfTlsV/O+714toL590ueiAiF5k7r/ekTWnBQp/A0kUfSrsa0XD/y2
        epptbKdscVQglGAFaiXRR+lC63xyifeGBt6Zso7kTwc2WcMufW6nWwM5vmUN0yqodoQS3oHa44aJJ
        H5hm3KpXaWOu8vlAZYjByJwxKH/NcukRuJNGc3UWMyYA28K/e43az5czG8lSpw7xINj3mpzO2M2m+
        WTxr70YnQZfRxmIwzultc6ikGSYgErtj9U136suBPIdQrJSUqQ9oeTMm87fE9Vd88WkDxA/qZsUEn
        gbdMYq/Q==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l9p2O-008raL-Jf; Wed, 10 Feb 2021 12:56:10 +0000
Date:   Wed, 10 Feb 2021 12:56:08 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     ira.weiny@intel.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Sterba <dsterba@suse.cz>, clm@fb.com,
        josef@toxicpanda.com, Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V2 6/8] btrfs: use memcpy_[to|from]_page() and
 kmap_local_page()
Message-ID: <20210210125608.GF2111784@infradead.org>
References: <20210210062221.3023586-1-ira.weiny@intel.com>
 <20210210062221.3023586-7-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210062221.3023586-7-ira.weiny@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
