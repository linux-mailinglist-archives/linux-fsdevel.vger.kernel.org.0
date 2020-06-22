Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F0B202E21
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 03:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgFVBlW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Jun 2020 21:41:22 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31566 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbgFVBlW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Jun 2020 21:41:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592790081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=maTjhuPOCYI1RBgjCHgYVBP3U6NfJYTgjBB5thICW+A=;
        b=KsOjwcS+mzHlTZhjKzoxlgYfR2oWgXAGObHk8b/X1eFCzZSiBf67oywFliuYOdaIgHlObL
        B+xsMt4XxqBoYkBpNX/Ec2pBuD6GsddYqRIOMTyNVhR1vSzwsq6wQLILIJi1rgbn+QLefs
        3ijp4IjmPCninSZD7MV5AIKJtc02AUk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-W3t0NUcjO-O85ICBmpvTGA-1; Sun, 21 Jun 2020 21:41:19 -0400
X-MC-Unique: W3t0NUcjO-O85ICBmpvTGA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BADC9107ACCD;
        Mon, 22 Jun 2020 01:41:17 +0000 (UTC)
Received: from T590 (ovpn-12-19.pek2.redhat.com [10.72.12.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BF76D5C240;
        Mon, 22 Jun 2020 01:41:10 +0000 (UTC)
Date:   Mon, 22 Jun 2020 09:41:06 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>, Brian Foster <bfoster@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] fs/fs-writeback.c: not WARN on unregistered BDI
Message-ID: <20200622014106.GA795360@T590>
References: <20200611072251.474246-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611072251.474246-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 11, 2020 at 03:22:51PM +0800, Ming Lei wrote:
> BDI is unregistered from del_gendisk() which is usually done in device's
> release handler from device hotplug or error handling context, so BDI
> can be unregistered anytime.
> 
> It should be normal for __mark_inode_dirty to see un-registered BDI,
> so kill the WARN().
> 
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Brian Foster <bfoster@redhat.com>
> Cc: Dave Chinner <dchinner@redhat.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-block@vger.kernel.org
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Hello Guys,

Ping...


Thanks,
Ming

