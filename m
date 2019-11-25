Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B768109320
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2019 18:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbfKYRxX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Nov 2019 12:53:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48152 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfKYRxW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Nov 2019 12:53:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=CUspaLOyQtYXf/XJRMblfacdM
        uSDKI465v20UC1JNlRSflesBQMrqV49/8cJX8u0q4ojKkY5DR34Qa6rvqd4hTKsLCcXlcrg4dBw+l
        esG8xIBT/whpBplU1N6FgoJtnFKjJ8c3uzG5dlqtO6vsVjhQm1iTzagsDhdV2+rn2iNGRTom5QaQF
        IpPU41FxuRgM5xeGpU+JMJS/tpUE5js42uB8Cy4e3bpx9Yd0flrVxsaMYbK812ibE7xYpIRZxkyoj
        7o1XxRZ+7gBpsWjsA1FE9WSsDPbs98VBLl9A+t3Ff2BjcXhXU5GyLdSkD2IkuyV49Tk77ZVZcNFnt
        KUqdkQHKg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iZIY3-0005aP-Qd; Mon, 25 Nov 2019 17:53:19 +0000
Date:   Mon, 25 Nov 2019 09:53:19 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: [PATCH] iomap: Do not create fake iter in iomap_dio_bio_actor()
Message-ID: <20191125175319.GA21279@infradead.org>
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

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
