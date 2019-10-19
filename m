Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3B0DD751
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2019 10:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbfJSINs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Oct 2019 04:13:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59708 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfJSINr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Oct 2019 04:13:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GsYPp1GXCnaghYj1liOszhEJYRWtuVk6Cbd+bNryEIY=; b=V8Ar7tp1oXrSRSHF9/AhF1v4p
        KVcWvNwwwcbKN3k64Twp2pNcJLssYz+QRbwOLHbONm5gcN+Zrhjaun+7HKqy5Wr4FaPlG4sizPyi3
        Mpk/qH556b8KNjY/6nCSpLnKBltSZcIs4P6Tz+EXvQc2jGzwkEMwJS0hc5wuYwkwfmU4BdSFSM23P
        GObBbRLTjueK6Il+qqLfazQyb75RWRYBGoCOTDxY8E8SmKKyn4RHQ+DW21HWrApGL2j7pdAS+EK0v
        uKxwRyYte8S3WQVRlXf3LKNA6OH8CcL1OXHvgCE7+cgWoaX21AK87GQmEK1Q43S3GkKLrOr8gyOcT
        tpbCWBOkw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLjrt-0000Ll-2U; Sat, 19 Oct 2019 08:13:45 +0000
Date:   Sat, 19 Oct 2019 01:13:45 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Jan Kara <jack@suse.cz>, mbobrowski@mbobrowski.org,
        riteshh@linux.ibm.com
Subject: Re: [ANNOUNCE] xfs-linux: iomap-for-next updated to b7b293bdaaf4
Message-ID: <20191019081345.GB21691@infradead.org>
References: <20191019012635.GC6719@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191019012635.GC6719@magnolia>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 18, 2019 at 06:26:35PM -0700, Darrick J. Wong wrote:
> Dave Chinner (1):
>       [8a23414ee345] iomap: iomap that extends beyond EOF should be marked dirty

I think this one if 5.4/-stable material.
