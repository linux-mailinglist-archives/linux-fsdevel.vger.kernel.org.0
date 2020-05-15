Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC401D5200
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 16:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgEOOm0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 10:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726197AbgEOOmZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 10:42:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9584CC05BD0A;
        Fri, 15 May 2020 07:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3iIrLwrSNZL+S3txYZ5ooYztJBCNqoUdcfH+RABdtvQ=; b=UR/nOTlnhIjsUEaBJZCcE3BngJ
        mfu05i2j+WxKcr7aadUXmtCEMRqOGo8WlZiQcx/CF8O8Rt7VlltOFibGIiO9P22FMxwIm7yBF8pe9
        eEuctwJJMTPdOLuB8TUsI66Z8LbJfV8pRhC6x0MIbl2R5sDpGINXt46eX1O7UBNhHMd1KH7QjKpiZ
        /5Zl8grCV+zYizEQ8IUVoKnDv4so/Q+I9YBcJP6FHitob64xgOTqY8THukAMIu6SoYdmnPlFrqER/
        Sz/OPP9samLEqnBB+HoFo8cCU8Zk0RqWmPgXOuI9l/9nOTkQMdZWW+2MZHgH6F/gb7Upu6y68wMpy
        mKCQoBMg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZbXc-00040w-57; Fri, 15 May 2020 14:42:24 +0000
Date:   Fri, 15 May 2020 07:42:24 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v13 00/12] Inline Encryption Support
Message-ID: <20200515144224.GA12040@infradead.org>
References: <20200514003727.69001-1-satyat@google.com>
 <20200514051053.GA14829@sol.localdomain>
 <8fa1aafe-1725-e586-ede3-a3273e674470@kernel.dk>
 <20200515074127.GA13926@infradead.org>
 <20200515122540.GA143740@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515122540.GA143740@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 15, 2020 at 12:25:40PM +0000, Satya Tangirala wrote:
> One of the nice things about the current design is that regardless of what
> request queue an FS sends an encrypted bio to, blk-crypto will be able to handle
> the encryption (whether by using hardware inline encryption, or using the
> blk-crypto-fallback). The FS itself does not need to worry about what the
> request queue is.

True.  Which just makes me despise that design with the pointless
fallback even more..
