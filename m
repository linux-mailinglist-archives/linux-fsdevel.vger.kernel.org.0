Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFCF3CB22B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 08:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbhGPGGO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 02:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbhGPGGO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 02:06:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC657C06175F;
        Thu, 15 Jul 2021 23:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VqN67i/AkXmoD+IiyttSlo//iBvW+McMPHFuPzEzzmk=; b=GIT7UGi37zY+XOB7QjWwGW3XJ0
        7qEph9PTVYX9s67VHkRG4pM2K1Afby+1zcT4sTbChUk0zhwAyvHMDjwKoyuHqzaYVj4pcuJsfBlu6
        Fk8V41n3n/B4RnuWGC7pC0bjPas3++sTAW+DXsW4mH4PMi4H+qc1/Itqs3Mg1NFZmSqbSdLAtprKm
        VVBCaBmhmAez+Y8TKo54kjUBLyCv/f1C4pNSPf06xj04j6eN/evkGTDW44O/CcnUbF++coSL2tlTe
        ftIE700GhNS7KbxUeVi0HolIM7XBwDI02Q+6FWVRqI3LsSKOvFhS+z6sl0H15g4PPZ2DyJSyqWuFp
        6VB9QLWw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m4GvT-004CGX-Py; Fri, 16 Jul 2021 06:02:31 +0000
Date:   Fri, 16 Jul 2021 07:02:19 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Ted Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org
Subject: Re: [PATCH 0/14 v10] fs: Hole punch vs page cache filling races
Message-ID: <YPEg63TU0pPzK5xB@infradead.org>
References: <20210715133202.5975-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715133202.5975-1-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 03:40:10PM +0200, Jan Kara wrote:
> Hello,
> 
> here is another version of my patches to address races between hole punching
> and page cache filling functions for ext4 and other filesystems. The only
> change since the last time is a small cleanup applied to changes of
> filemap_fault() in patch 3/14 based on Christoph's & Darrick's feedback (thanks
> guys!).  Darrick, Christoph, is the patch fine now?

Looks fine to me.
