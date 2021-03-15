Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF2D233AF58
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 10:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhCOJ5V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 05:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhCOJ4t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 05:56:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917EAC061574;
        Mon, 15 Mar 2021 02:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=htbYC9iEopWtJ4y8Zm3XAv1Jzw
        bi9Q4J0G7LJqzikz0CjxjwgBMbrifq3uN/CE7RWX1PcJNGS/PXBVpNTKJPqtgmlVRBiZLo3yCX1yI
        EVNS/TNYiYWwQv1T3/uq9dfXj9uJ1q44w5+HFSaZiINukieN7v8bxpVU2td2uJLvI21SvgZflRxRY
        Jdfk2x9WhTwp2OBjD6oNxnDN03fSqRDMMHuqVeNLmIEAVXoUK3eAnDxnAHa+CEYG82ekfCbBJCmBJ
        +nsBfm66Eli8cWVd5Q4iZ+oQa0j9MhI246O84qZy1Vf/qo9JjCOplDrgIZdcQPbWjrtafZ0he9EsB
        fqAPFLNQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lLjxq-00HXpG-E3; Mon, 15 Mar 2021 09:56:42 +0000
Date:   Mon, 15 Mar 2021 09:56:42 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, jack@suse.cz, tytso@mit.edu,
        viro@zeniv.linux.org.uk, hch@infradead.org, axboe@kernel.dk,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com
Subject: Re: [RFC PATCH 0/3] block_dump: remove block dump
Message-ID: <20210315095642.GA4181451@infradead.org>
References: <20210313030146.2882027-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210313030146.2882027-1-yi.zhang@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
