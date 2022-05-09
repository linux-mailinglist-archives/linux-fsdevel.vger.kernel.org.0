Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8F751F23E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 03:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiEIBaQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 21:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236139AbiEIBJu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 21:09:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37B72DFD
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 18:05:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CF7160EBB
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 May 2022 01:05:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DFD6C385AC;
        Mon,  9 May 2022 01:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652058356;
        bh=LAMkXBXg3fhVG6OmqDTRkl6U8qsnTIFLXwHkJl0vh2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lAUa7K4H0RpVrPk+1yuHcAQbS8QarvN0sPhTcq3003GpBfXMEVX+onoFcNFLZaH6c
         9GfJBNb0AbRt4Ff92KLMNoz83yQ1BiHUsE/oaJNzYDhra3bwK8nGmQf5u1bjXDhUVW
         hQA3QgQNoQ6rZ5PmSFjMqNEcYEIajoMxrc5FYbJ0HkekKtFoSKncvwJ9yzW5YOJdFj
         yJxlK8sSsX5Xvk4hl8MBguHMWL5MpgEBoCBHkUoMozWVsfyUOCyF7ZsLJ+YnHBTaQH
         gRVaI17fNk3qYnG28EOK5TqiFJz1OLouhK5UzDFWJdn5Dyln0hT6m0A7cXph/mUw+7
         6CcHZOskHRZAQ==
Date:   Sun, 8 May 2022 18:05:55 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Appoint myself page cache maintainer
Message-ID: <20220509010555.GA284271@magnolia>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508202849.666756-1-willy@infradead.org>
 <20220508231644.GP1949718@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220508231644.GP1949718@dread.disaster.area>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 09, 2022 at 09:16:44AM +1000, Dave Chinner wrote:
> On Sun, May 08, 2022 at 09:28:48PM +0100, Matthew Wilcox (Oracle) wrote:
> > This feels like a sufficiently distinct area of responsibility to be
> > worth separating out from both MM and VFS.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Yes plz,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> > ---
> >  MAINTAINERS | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 9d47c5e7c6ae..5871ec2e1b3e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -14833,6 +14833,18 @@ F:	Documentation/core-api/padata.rst
> >  F:	include/linux/padata.h
> >  F:	kernel/padata.c
> >  
> > +PAGE CACHE
> > +M:	Matthew Wilcox (Oracle) <willy@infradead.org>
> > +L:	linux-fsdevel@vger.kernel.org
> > +S:	Supported
> > +T:	git git://git.infradead.org/users/willy/pagecache.git
> > +F:	Documentation/filesystems/locking.rst
> > +F:	Documentation/filesystems/vfs.rst
> > +F:	include/linux/pagemap.h
> > +F:	mm/filemap.c
> > +F:	mm/page-writeback.c
> > +F:	mm/readahead.c
> 
> A big thumbs up from me.
> 
> Reviewed-by: Dave Chinner <dchinner@redhat.com>
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
