Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E82C511C9E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 10:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbfLLJwP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 04:52:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51722 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728455AbfLLJwP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 04:52:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iyWUngZoHDVl3BdJcfYJwS0fRida7K3TUbzKmjVHp+Q=; b=VBzMtDTIOe63C0tza3UQFoFfp
        be6D6TCsfEMSEvu7tIqUdocH5erdehx+75Tq+KEk3Z48woJdSu6M4jtIRiEc0sVY1k5zsZX8yRFsJ
        zpmlNYCaAmk5eqY8tj9MR64ln+q90KfYzs/ypa3CwZJQlxLejqD91dyG80FlQWMbTIT21WgPRuGmr
        rlmQPsTZaPMn446vBlVfgGxLvY/YHceqZyB3IkFGrW9ZuVyaL+uvuggi7Z5tpR58iR3Nc1nA2rOSY
        8QRWeh3SUxgIblojN71Wt1bGdcC9n6CSjC6H5Oe3tf6fjCOZekWw9CZJvTptNrNpK099NTkdqPzDm
        zGzuycs5g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifL8p-0006Bn-4s; Thu, 12 Dec 2019 09:52:15 +0000
Date:   Thu, 12 Dec 2019 01:52:15 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, darrick.wong@oracle.com, fdmanana@kernel.org,
        dsterba@suse.cz, jthumshirn@suse.de, nborisov@suse.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 7/8] btrfs: Use iomap_end() instead of btrfs_dio_data
Message-ID: <20191212095215.GF15977@infradead.org>
References: <20191212003043.31093-1-rgoldwyn@suse.de>
 <20191212003043.31093-8-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212003043.31093-8-rgoldwyn@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Maybe s/iomap_end()/->iomap_end/g in the subject and commit log?
