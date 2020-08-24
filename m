Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8BEE250883
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 20:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgHXSyM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 14:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgHXSyI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 14:54:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37ECC061573;
        Mon, 24 Aug 2020 11:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/RZ8lu4GLqWgx2SJy7gstpvyOrfX+P6Ib1IzLL5uMvU=; b=r4GUC126jrVcHWcAK7iDriIIMT
        xQQdHj1FiRNXVRnXsSD5TnlV5iKg0relX2TxVrk5gKJfT+iz/+PelC7p5NpgeOhKHPK4UKVPdj0/1
        GUO9GYv2mQ9+x0RQ6kElcjX4wwgs8J+qm2KROL3HH2GDwNlQZfghoaGk94YF9b+9a1G2yRa2rKn1H
        y8OB50lIr/isEArR1LHELITcDAwYBB+aJWzDAphJ64foh07hSD9sdklDUBA4Tbs3Xb5ueEno8/IJK
        vA1p4/W5ihT0FpBgEYptG6cvRIfeFYw0CSupxEcgVmeG9AfKtWS2YhvdGbdVJBY6jg6Xm+if97dVK
        3cPWSzDA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAHbU-0002Xb-SQ; Mon, 24 Aug 2020 18:54:00 +0000
Date:   Mon, 24 Aug 2020 19:54:00 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] fs/ceph: use pipe_get_pages_alloc() for pipe
Message-ID: <20200824185400.GE17456@casper.infradead.org>
References: <20200822042059.1805541-1-jhubbard@nvidia.com>
 <20200822042059.1805541-6-jhubbard@nvidia.com>
 <048e78f2b440820d936eb67358495cc45ba579c3.camel@kernel.org>
 <c943337b-1c1e-9c85-4ded-39931986c6a3@nvidia.com>
 <af70d334271913a6b09bfd818bc3d81eef5a19b2.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af70d334271913a6b09bfd818bc3d81eef5a19b2.camel@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 24, 2020 at 02:47:53PM -0400, Jeff Layton wrote:
> Ok, I'll plan to pick it up providing no one has issues with exporting that symbol.

_GPL, perhaps?
