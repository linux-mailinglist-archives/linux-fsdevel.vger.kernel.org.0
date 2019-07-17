Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C62C96B5AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2019 07:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfGQE7C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jul 2019 00:59:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50388 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfGQE7C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jul 2019 00:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=b4mrzusAw4iT5psfLneDDFEiUNUZ9oNkgSeJ+kbUh0Q=; b=cBx+b466rNFuMfUCRhrar3rJm
        0f2lbvOUf3KBA+pfIO0rUrp2Ngzgtuxv82ighuc9NXtVuwTF+24c2LQTR4cQBLrxovuvp/qtY3zb5
        XSmB7iy96BAhJXjKx0+mghyNao37NkiFLPaAPErcyEdHKJpFWv6BTmUmGjVwaQpBWMAfsQnckYUyp
        yCWL7Re+VsFxCf7LD/3OxMgebmbKLKOy59mZrsktb/wEP3GblnGZj278ZsozGnkpVxTypLrF2WB5r
        HZhn6Rvi4cXARUNY5kmcjp8C3DFaE2T1864naiFQ6g2g18XzcNLj7Uzwl/I9WXbeIYIcX4Tp+KGgl
        nrDD8PwWQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hnc1t-0001tW-Kb; Wed, 17 Jul 2019 04:59:01 +0000
Date:   Tue, 16 Jul 2019 21:59:01 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     hch@infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, agruenba@redhat.com
Subject: Re: [PATCH 1/9] iomap: start moving code to fs/iomap/
Message-ID: <20190717045901.GA7113@infradead.org>
References: <156321356040.148361.7463881761568794395.stgit@magnolia>
 <156321356685.148361.4004787941003993925.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156321356685.148361.4004787941003993925.stgit@magnolia>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 15, 2019 at 10:59:26AM -0700, Darrick J. Wong wrote:
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0-or-newer
> +#
> +# Copyright (c) 2019 Oracle.
> +# All Rights Reserved.
> +#
> +
> +ccflags-y += -I $(srctree)/$(src)/..

Is this for the fs/internal.h include?  Can't we just include that
using #include "../internal.h" ?
