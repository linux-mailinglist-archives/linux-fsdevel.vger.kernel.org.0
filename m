Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6652B7A19
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 10:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgKRJLE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 04:11:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:43500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbgKRJLD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 04:11:03 -0500
Received: from localhost (unknown [89.205.136.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B78812463B;
        Wed, 18 Nov 2020 09:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1605690662;
        bh=Bue2zB2N2pWeoRPAFrKwsKTqFelMoJ7u0NZ6+qsm2lg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AUVDTnsv/loeevWqNPhDEkXzwfiVWRnXETQJyNJXKc5mWs6sh2/R+S+4LQ/OFGnQM
         mOBEBCOR8sMcPnpugDJC5+SsVWCCE8mnORUdyAcVNy/d+rccVY9fUSts6rTlPUQzCj
         zWFg0HoHn1XdWsg1BSMcc/c8vCuPf8k8NOKoeBhI=
Date:   Wed, 18 Nov 2020 10:10:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Coly Li <colyli@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Richard Weinberger <richard@nod.at>, Jan Kara <jack@suse.com>,
        linux-block@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-bcache@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 19/20] bcache: remove a superflous lookup_bdev all
Message-ID: <X7TlIzxJPfa2p+Da@kroah.com>
References: <20201118084800.2339180-1-hch@lst.de>
 <20201118084800.2339180-20-hch@lst.de>
 <e7f826fd-cb9c-b4ab-fae8-dad398c14eed@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7f826fd-cb9c-b4ab-fae8-dad398c14eed@suse.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 18, 2020 at 04:54:51PM +0800, Coly Li wrote:
> On 11/18/20 4:47 PM, Christoph Hellwig wrote:
> > Don't bother to call lookup_bdev for just a slightly different error
> > message without any functional change.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>ist
> 
> Hi Christoph,
> 
> NACK. This removing error message is frequently triggered and observed,
> and distinct a busy device and an already registered device is important
> (the first one is critical error and second one is not).
> 
> Remove such error message will be a functional regression.

What normal operation causes this error message to be emitted?  And what
can a user do with it?

thanks,

greg k-h
