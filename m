Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776871EF631
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 13:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgFELK7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 07:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgFELK6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 07:10:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5B0C08C5C2;
        Fri,  5 Jun 2020 04:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fvrQ52cMxHI9s5VoXtdJj/ZiIAaO8ey4kraRK+T/OVs=; b=irfcWxjMeB2NB3X2YJxnQukkEh
        4BAaXxQoLP0TDn+mSf8mWJ/9RLXBjAitU05x6Aeqno0J1Zesd2OQB4y4ZxrbrB2qFlONdkXPwRfPj
        U2jcW9QcOx25pJst8FTxZQQS4CQ+Xav46/FDaMaRrdS0ZleGE5/Qf74Zd/X6D0oZnMrO1gqtrgQ2Z
        4h7GEa6YDrt6wHqts3h8At3+OiQdxAWeRjVc5iFU0UWjXmhZNAUgRnMm2HkMlRcapAJ2T+9Xj/NRr
        teCiHC6zcAozZqBEI+VOyGJrF/9FK1ieQ5VfiSl8f2HF/+jwPQkiE8iT5SszE12KHJF5VihnkRNXd
        hYUOklYg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jhAFN-0002XB-Pr; Fri, 05 Jun 2020 11:10:49 +0000
Date:   Fri, 5 Jun 2020 04:10:49 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jason Yan <yanaijie@huawei.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hulkci@huawei.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v2] block: Fix use-after-free in blkdev_get()
Message-ID: <20200605111049.GA19604@bombadil.infradead.org>
References: <88676ff2-cb7e-70ec-4421-ecf8318990b1@web.de>
 <5fa658bf-3028-9b5c-30cc-dbdef6bf8f7a@huawei.com>
 <20200605094353.GS30374@kadam>
 <2ee6f2f7-eaec-e748-bead-0ad59f4c378b@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ee6f2f7-eaec-e748-bead-0ad59f4c378b@web.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 05, 2020 at 12:56:45PM +0200, Markus Elfring wrote:
> > A lot of maintainers have blocked Markus and asked him to stop trying
> > to help people write commit message.
> 
> I am trying to contribute a bit of patch review as usual.

Please stop criticising people's commit messages.  Your suggestions
are usually not improvements.

> > Saying "bdev" instead of "block device" is more clear
> 
> I find this view interesting.

Dan is right.

> > so your original message was better.
> 
> Does this feedback include reported spelling mistakes?

You can keep doing that.  But refcount -> reference count is not
particularly interesting.

