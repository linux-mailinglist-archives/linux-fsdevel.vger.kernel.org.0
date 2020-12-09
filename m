Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFB02D3D8A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 09:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbgLIIc6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 03:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbgLIIcy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 03:32:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408EEC061793;
        Wed,  9 Dec 2020 00:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=cm/PA9kBDqVnxq17iTfOzf6bzV
        QU4k1O8Hpm93PoPChUrRwucnfKzqwI2nh8/IFbpLknKP+cD5xxCiLMfZWoCFWhn1jKeBkhlIrcD5X
        FC6WI/XXDiqzB4JrqYbJJM1/Qzoa53mEBol9WnSKHYNtZQLSHIGrwuxlQn98nsjgRW0w+o/MpYSy3
        x45uzjFij7D6qKXXPzh5pCaERXGtl093Jhf7okpx0Kcu9nL0Nbt4WaZ80V8wjNLhehjwKy2Ay2ZcH
        k1UZfL2F1KVWEhh25P82GEgFLWQ6exuM+arTkzK4iWhEnfoD6TSWahr7EV2ECUfpBfeh3H2fI8Dr/
        +qE7uC3Q==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmutP-0005hR-L8; Wed, 09 Dec 2020 08:32:11 +0000
Date:   Wed, 9 Dec 2020 08:32:11 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Pavel Begunkov <asml.silence@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V2 2/2] block: rename the local variable for holding
 return value of bio_iov_iter_nvecs
Message-ID: <20201209083211.GB21031@infradead.org>
References: <20201203022940.616610-1-ming.lei@redhat.com>
 <20201203022940.616610-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203022940.616610-3-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
