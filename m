Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF3396B5B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2019 07:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbfGQFBS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jul 2019 01:01:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50470 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfGQFBS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jul 2019 01:01:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qeM7q5rFf4fNObP+eToIvhPyAPw3Sg1DHFLyw3PtgAo=; b=m5uLlZ0E9/0NQYj4abbL1tqc2
        9czpmCKBcRb02wedOiwqla7fZrXHP5npN02pMFPWOFMYtHsM8Qi6Ro5W5gjnRB3r/hQla/2dTrM+0
        RsgG0Xt8ffAAlhE/6oX1H4uAxYdAtu0X6sqY55iBDT3MDpSy8DIq5Wl+l7QTfoVcB7V/0lXLSWvwX
        2mxpiRGCJ4+zvzd21UORKsBCTaOX4ooppAUJah39gmoqigTH9ilEkFjFY6Y1dUJhv4kR+JT+2a29E
        4kzWksYTV2Ham4EhRp64VH1yLuT7wa+DEL8FA8PfHmEbxrweSq++LPHkqysRwMBT/VbkSu953TNxp
        tLIoxpUCA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hnc46-0003DI-9O; Wed, 17 Jul 2019 05:01:18 +0000
Date:   Tue, 16 Jul 2019 22:01:18 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     hch@infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, agruenba@redhat.com
Subject: Re: [PATCH 4/9] iomap: move the SEEK_HOLE code into a separate file
Message-ID: <20190717050118.GD7113@infradead.org>
References: <156321356040.148361.7463881761568794395.stgit@magnolia>
 <156321358581.148361.8774330141606166898.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156321358581.148361.8774330141606166898.stgit@magnolia>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> diff --git a/fs/iomap/seek.c b/fs/iomap/seek.c
> new file mode 100644
> index 000000000000..0c36bef46522
> --- /dev/null
> +++ b/fs/iomap/seek.c
> @@ -0,0 +1,214 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2010 Red Hat, Inc.
> + * Copyright (c) 2016-2018 Christoph Hellwig.
> + */

This looks a little odd.  There is nothing in here from Daves original
iomap prototype.  It did start out with code from Andreas though which
might or might not be RH copyright.  So we'll need Andreas and/or RH
legal to chime in.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
