Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C69CB49D03C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 18:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243431AbiAZRCA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 12:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236882AbiAZRB7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:01:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDDEC06161C;
        Wed, 26 Jan 2022 09:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=GeDcodj5U6Vv8NWJbcjSwhfYDI
        nzUKwLRYLrUPi7RdBD2VOGhe4AfPXYJH5ECiZwGu3qiKGNqfLP2ZPBNvqxeqBMLufwsbzEjox9yMo
        szb+fO75z5c8h16Q7RZPLo3wTitXWRwhKbNa8VrsMNIXkyDOwjkBUmPMFrqDzENIPbRjRRe6AMn2W
        julqw63blJYJ1cCRlp47Z56hmL/BHlNiwnvK4lhYuk/XcZpEoyjs8+ldShwJ3PFrsszsjFMLJfeLY
        jvuCiu5mYGjJfOTGSpEFhdCx/1QU2S1ImiZOs+LqQtOPXLUfZDxcfSyy8Z95ubwv7TdneyFQJeh4T
        2As5o37Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nClgF-00Cq1f-GC; Wed, 26 Jan 2022 17:01:59 +0000
Date:   Wed, 26 Jan 2022 09:01:59 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.com
Subject: Re: [PATCH 2/4] vfs: make sync_filesystem return errors from
 ->sync_fs
Message-ID: <YfF+hyv5pnrOzy9h@infradead.org>
References: <164316348940.2600168.17153575889519271710.stgit@magnolia>
 <164316350055.2600168.13687764982467881652.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164316350055.2600168.13687764982467881652.stgit@magnolia>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
