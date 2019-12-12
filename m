Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC09911C9CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 10:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbfLLJqF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 04:46:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50128 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfLLJqF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 04:46:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=ZzD6Bq+3Ve/TwFgg9V6264/dt
        4ckQ3ZYeZ8WaKMzGHHp4XObq0LBf1O+tioay65kol4LVpkuQ2jT0lfEp+CXDFc700fcDkcdIGjF/s
        lKDVHcxVc40Xvyjjq/EpCP3FqauJPZG3nGXMlpMC7m991Xe80P0OR0Wc5k49/YIgcPSuvyQp9e3Ru
        sI4jCt9w2X75FOTmtVzHmL7b6HXf3Tiua3OO4P8YZPa9PAmi5Dvf895I93hZYv2TzmyqYzUWhio+G
        vxvy7q6VAk9lhSyt35NAmFtG2o6HahkZUhBznqBEOZcNXh3+RRjFieFE43e08/gkbeJBvFnwG5A/4
        vxw+MNbbw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifL2q-0004Aq-SZ; Thu, 12 Dec 2019 09:46:04 +0000
Date:   Thu, 12 Dec 2019 01:46:04 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, darrick.wong@oracle.com, fdmanana@kernel.org,
        dsterba@suse.cz, jthumshirn@suse.de, nborisov@suse.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 1/8] fs: Export generic_file_buffered_read()
Message-ID: <20191212094604.GA15977@infradead.org>
References: <20191212003043.31093-1-rgoldwyn@suse.de>
 <20191212003043.31093-2-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212003043.31093-2-rgoldwyn@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
