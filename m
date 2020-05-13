Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD15D1D0F2F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 12:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387504AbgEMKFT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 06:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732741AbgEMKFR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 06:05:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F5AC061A0C
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2020 03:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=oZYqXH1LHDm2IBGZfdcNQsu9cV
        Udq4nKB9Ba7EwKlTCSyF++QVoAHSfTyAWhTUvxq9v+QxY7O3+UXYocR2hZESrGoPR8SoNZqmT/Fzh
        OuyNKju5aY4vnb7r7pa2CBv1w91uNmaOtE7cIZHKVjzr7J1TjAdd1y78mwmtuMIWoqcL/em1R7OBl
        yZuKm6CJU1kGi2X+4ssnTHMqwKxY8vbVfBNAsmseVaj9SxmF/K89rUOZmTN3bxXJeappezkiC44Xt
        AyBQ8uVOxVHuyQEUZIXfMqC/rrlOHaR9+39pLcrNM+o+ejTTm2tYtf4JWKCXw9UVnvmOHYBYmXFBL
        iHVb9cvA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYoGK-0005Ws-5w; Wed, 13 May 2020 10:05:16 +0000
Date:   Wed, 13 May 2020 03:05:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 08/12] statx: add mount ID
Message-ID: <20200513100516.GF7720@infradead.org>
References: <20200505095915.11275-1-mszeredi@redhat.com>
 <20200505095915.11275-9-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505095915.11275-9-mszeredi@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
