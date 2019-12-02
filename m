Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60C0910EDB9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2019 18:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfLBRDg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Dec 2019 12:03:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41710 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbfLBRDg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Dec 2019 12:03:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4Bog2FcHzbVHTGABIFboxW3D8q+dKfFuUFtGCAvbJN8=; b=SbCAbqhl8BRByWXfNxrs1pif9
        h1kuXOWtY5KlKFGagbhiuSkdoQ8JTC3tVkOtyn7IDbslxfoLacwaCo9JhBbnclgHD6EiMIarWctt4
        BmfhVDD8DdqCJwKvltRp77ZzUz2+t7BrAuuxTADLlgCvFrdC/Sw6UFGWmY9MucMUflWd6YH2SCb49
        AxZksLP9TKMgCA7M/p3ge6FA0nY77A+fBYDdZGQY/B1xIiUwbDL9leZ9CoKm16Tz2b47hwQQuu16T
        sjQENJmZI8qWH53Ebo13NhIo60AsJeRUiBsd0r2yUYqFXTj3rTafZNTQvNrBDM/sFqG0ix3JICDw2
        Ya7gGk/lw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ibp57-000150-Vc; Mon, 02 Dec 2019 17:01:53 +0000
Date:   Mon, 2 Dec 2019 09:01:53 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     ira.weiny@intel.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH V3 2/3] fs: Move swap_[de]activate to file_operations
Message-ID: <20191202170153.GA2870@infradead.org>
References: <20191129163300.14749-1-ira.weiny@intel.com>
 <20191129163300.14749-3-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191129163300.14749-3-ira.weiny@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While the patch itself looks fine, I kinda disagree with the rationale.
If we want different ops for DAX that applies to file operations just
as much as to the address space operations.

However I agree that the ops are logically a better fit for the file
operations, so:

Reviewed-by: Christoph Hellwig <hch@lst.de>
