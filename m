Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B4D2CB65B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 09:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387866AbgLBIGs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 03:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387654AbgLBIGs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 03:06:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C2DC0613D4;
        Wed,  2 Dec 2020 00:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=z9KqhaAsXAc9JurpkJ+8oS6ooAn/GC5FmBHauam3UMs=; b=ZSw0Avvkh7WUOglt9xE0h4fhwy
        ByX6PKX0a6yiwAoUtW+SIz61a7zESvPeJJgIrAiiTH9mOe1Wu80EGtMm1R5AuDG0Nxesrph/yNI7p
        d0YtYWvOVHPazt44kGi8cw6rbKjfzrTvBu5r4TgPoaoOi1gSsw8g7IEVAkZZPp8cszjzBpjJz9ZKw
        hea+uo4zl0y2O3nkgDDjYp5aeF34yNI0jTe4U5a9xfjLbQnj0VrTykUpSz6oLPVwwGWH8ek5BDAeo
        igLpxtI5vP/SGTWqoB8z6J6pQ2ZI50Zwn/8/ynAOsaqkmQ4iaspus6QchMckGuMKngqD8dcDlEg9Z
        xTwlHGEA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkN9H-0004W1-9I; Wed, 02 Dec 2020 08:06:03 +0000
Date:   Wed, 2 Dec 2020 08:06:03 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     torvalds@linux-foundation.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org,
        linux-kernel@vger.kernel.org, xfs <linux-xfs@vger.kernel.org>,
        linux-ext4@vger.kernel.org, Xiaoli Feng <xifeng@redhat.com>
Subject: Re: [PATCH V2] uapi: fix statx attribute value overlap for DAX &
 MOUNT_ROOT
Message-ID: <20201202080603.GC15726@infradead.org>
References: <3e28d2c7-fbe5-298a-13ba-dcd8fd504666@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e28d2c7-fbe5-298a-13ba-dcd8fd504666@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good for the urgent fix:

Reviewed-by: Christoph Hellwig <hch@lst.de>

We can keep debatting about stx_attributes_mask for a while once this
is sorted out :)
