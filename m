Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920B626150C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 18:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732130AbgIHQmq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 12:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731775AbgIHQmO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:42:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4346C08E81D;
        Tue,  8 Sep 2020 07:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=s/ZFP3A4QjWDXlAZV9vLPQDEWpTEXzJrBneXxVLN8q0=; b=h1Yf2ewJmFOXLhqiClP3zy+NZZ
        0XaMxkev1MwPE3wrcOaqeZbWERyA8fuefnxrrZgGqD8mn0AL3HvSvo8VmWFEOAEPzYmavfJP9kkGp
        o5u1AcntYdpU3RqFo5kgNPbk6+vlrQxPCO/O+fCV5hgf0AixS7fUCMUwEAW1Sejxx74SAAVAm2Od5
        N9sLDNmGKz0TQiUJQOzHJhxmGa0f+u3/UAC2YgqAKbaYHpPHX6RhlAzsDFVJwMeUHTT7CHZaETE2j
        l/kpiHOoFSGm1JP1x6QS5/XyYFW5h/FeCbg0ibdVQpwKjbicx6esZH4pWMLpbGgQMq8/UBf2+5PTc
        HDN82t4A==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFegp-0001qR-QX; Tue, 08 Sep 2020 14:33:52 +0000
Date:   Tue, 8 Sep 2020 15:33:43 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v2] quota: widen timestamps for the fs_disk_quota
 structure
Message-ID: <20200908143343.GA6039@infradead.org>
References: <20200905164703.GC7955@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200905164703.GC7955@magnolia>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 05, 2020 at 09:47:03AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Soon, XFS will support quota grace period expiration timestamps beyond
> the year 2038, widen the timestamp fields to handle the extra time bits.
> Internally, XFS now stores unsigned 34-bit quantities, so the extra 8
> bits here should work fine.  (Note that XFS is the only user of this
> structure.)
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
