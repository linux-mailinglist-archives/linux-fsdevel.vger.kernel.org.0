Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309E11F17CD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jun 2020 13:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbgFHL0h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 07:26:37 -0400
Received: from verein.lst.de ([213.95.11.211]:36827 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729310AbgFHL0h (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 07:26:37 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id F1A6C68B02; Mon,  8 Jun 2020 13:26:33 +0200 (CEST)
Date:   Mon, 8 Jun 2020 13:26:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Christoph Hellwig <hch@lst.de>, Jason Yan <yanaijie@huawei.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hulkci@huawei.com, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [PATCH v4] block: Fix use-after-free in blkdev_get()
Message-ID: <20200608112633.GA21310@lst.de>
References: <1612c34d-cd28-b80c-7296-5e17276a6596@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1612c34d-cd28-b80c-7296-5e17276a6596@web.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 08, 2020 at 11:48:24AM +0200, Markus Elfring wrote:
> > Looks good,
> >
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> How does this feedback fit to remaining typos in the change description?
> Do you care for any further improvements of the commit message
> besides the discussed tag “Fixes”?

Just go away please.
