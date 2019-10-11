Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47A5DD3C91
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 11:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfJKJmr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 05:42:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43728 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfJKJmr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 05:42:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Eic02bz3wsWMdxLROiOCRsYno
        52Ve7wWgkuks0g+16BKMM9z/0zerb4gsMM9/m4kpSw5E3L2VOx7ZEz29M6L2OBm0JMzAwYOIPBrVb
        pkVzgULu+b8ZfIH6vuN9An/wozem2nC7poEyTNWKNmFto43/HQ9qk2ko7MX7zL25sNBRp2IjV7gRm
        i4WC2FsSwWUOM3Z43a56cRhsVgvTPqFHppn4+8S22i4rMHxxVHZbBQ0ALY0Hi/sIjogckW+sg0uur
        tx6jeHFDq9CKcdgyJmP+mHw2q4DCdNu2dohrJ+c9iywDZhwiH1Vl02derqoaQHhqq8fGkr3oRWiHB
        DbFYPxo8A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIrRf-0005tz-5L; Fri, 11 Oct 2019 09:42:47 +0000
Date:   Fri, 11 Oct 2019 02:42:47 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 06/26] xfs: synchronous AIL pushing
Message-ID: <20191011094247.GB5787@infradead.org>
References: <20191009032124.10541-1-david@fromorbit.com>
 <20191009032124.10541-7-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009032124.10541-7-david@fromorbit.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
