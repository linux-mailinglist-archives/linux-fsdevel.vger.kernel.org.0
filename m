Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1F210A225
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2019 17:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfKZQb0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Nov 2019 11:31:26 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56664 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbfKZQb0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Nov 2019 11:31:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=GkXbmeTQHoMzfcEYzMcDpjJnZ
        ABebPLX6fe7YtXZLGM8mqhq8w+Bd2ylQ3j+4wcL9gE0f7MuGGn4nFHcNXGWmUUtvGzcCW884aZjLZ
        cpsGNh+3JVdJuQo0i0Ucaxq84CewskmuuROj8v2thVAXTkm9NZdz/xZn+1JV5FCt5sHzgQK7tzZiX
        qnqZ2Fm3ZPVF587WLYLQANB4T2pMfmbS5OxoHeNxIfRbmJ8fJBfjRxWwqGz7ElBj/X4+ktsEEyEHf
        0Q5bNASW95t0e7q99cclU0kmoCjmAcCClmU9NtFwuQEf6ynt33h21FeVM669fQaSkYbrwBbGmTR1D
        8atUKS9Jw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iZdkI-0005H0-To; Tue, 26 Nov 2019 16:31:22 +0000
Date:   Tue, 26 Nov 2019 08:31:22 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: [PATCH] iomap: Do not create fake iter in iomap_dio_bio_actor()
Message-ID: <20191126163122.GA3794@infradead.org>
References: <20191125083930.11854-1-jack@suse.cz>
 <20191125111901.11910-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191125111901.11910-1-jack@suse.cz>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
