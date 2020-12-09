Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A579F2D3D88
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 09:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727475AbgLIIcq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 03:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbgLIIck (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 03:32:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA028C0613D6;
        Wed,  9 Dec 2020 00:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=J0jgPdZ2LxvomUJzV57Y8UhS8u
        /d7yy6H6cxGj8sLDTiJO4cFM5VNjov6W4WaZxGNVChVV2E1ejxmfANZUj2PX8psI10YeqOrjgyq30
        fUDLerzrwrw67LAiGPWqEhkO2ZvWg4PPqzV4AZayak9j19W0zzTiDgVUjTPh5Kr9dDRUIvMGYK3U+
        Dz65RJHsEFOl7j2QK6HZqK9R6fGzm5ck9fzagAnkPkbU6mrMA1evzA2FiLmWp3x644nBaeHYZioot
        WeKn5FJhN9UwDptoIGbjW9XZSkv2EAiGxcbSaEk3pv8eonMg4+oVyGYE9e3IP7VHGyx/14QgWSMdV
        cc5HCbhQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmutA-0005go-Pa; Wed, 09 Dec 2020 08:31:56 +0000
Date:   Wed, 9 Dec 2020 08:31:56 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Pavel Begunkov <asml.silence@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V2 1/2] block: add bio_iov_iter_nvecs for figuring out
 nr_vecs
Message-ID: <20201209083156.GA21031@infradead.org>
References: <20201203022940.616610-1-ming.lei@redhat.com>
 <20201203022940.616610-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203022940.616610-2-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
