Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA5A1F36B2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 11:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgFIJMr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 05:12:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:47050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728274AbgFIJMq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 05:12:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB207207ED;
        Tue,  9 Jun 2020 09:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591693966;
        bh=cMnh1J3zIuMgLcOFHAluJupv/1cWiYti0VxOKtCtA7c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fVknH7VyENSTts/MC/kWp3DsuA9wOc6QMHppAfJY4iaSlvc0XyTPE4vI29PvcEPVp
         rZa4qOMzifRp+cg4CSF5H6D3RbJ1XsM3RqAU3hh7Gf86u/2xv0CqIkKLMhLEYMX03i
         IOlT+dcBboerhZ+SIPLWHW3VBFutK+qPn5SaL3do=
Date:   Tue, 9 Jun 2020 11:12:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
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
Message-ID: <20200609091244.GB529192@kroah.com>
References: <1612c34d-cd28-b80c-7296-5e17276a6596@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1612c34d-cd28-b80c-7296-5e17276a6596@web.de>
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

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot
