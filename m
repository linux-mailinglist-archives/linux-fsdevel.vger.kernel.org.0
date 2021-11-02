Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3E24427E2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 08:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhKBHOo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 03:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhKBHOn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 03:14:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED6EC061714;
        Tue,  2 Nov 2021 00:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=Z/i47oRjm65FDJeAJMJXJFDgcO
        o5M89MJmNludMjyf4GVCTEfyih+az4VR3DP8gSnBXqPLFTSICwQwty1fEk1vG0EiIFNlNlGiXafMF
        mf+CBHymarTAwKU4LH7C3etSDffStFptLoeus+Z72VIzI0AtGglVLerJO2QVucL5c8IcgIcbATuxB
        PaW+zc/+GbdlW63vxMEoy8OfJbQZyTh3iV+pbc4SRUsxdbATqVC7g+MFP/fXrMuOEMn8tD/KrmTbQ
        A5GyvuUDu8jDfOrKNHqKCFODo4usOQ0SJZHG8Rl8lN8v/WCMfr4Aw06Wr7ky5SgxcEPzNR29Up1p8
        M06hegeg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhnxm-000jBh-Bb; Tue, 02 Nov 2021 07:12:06 +0000
Date:   Tue, 2 Nov 2021 00:12:06 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 01/21] fs: Remove FS_THP_SUPPORT
Message-ID: <YYDkxhEO81CY06ii@infradead.org>
References: <20211101203929.954622-1-willy@infradead.org>
 <20211101203929.954622-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101203929.954622-2-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
