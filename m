Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B57751F9E4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 12:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbiEIKdp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 06:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbiEIKc6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 06:32:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C0524FDA9
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 May 2022 03:28:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33A3160DFB
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 May 2022 10:28:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33310C385AB;
        Mon,  9 May 2022 10:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652092094;
        bh=Za84684D0gxamc1aIKXclbLmlRreHOzJ9l61bQRkWVM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=vDBQT8eWL13qXEkSr81ceyM8ipyos1NkEGnOd95yKw9Gw1DQGx1iVtDqC2QtOkKsy
         3KMTWjhGg8BnkfDkLwfsn0Dih9gp+MX+Ai4ayoNq6Jv5dspz5wa3GAKtHi3SvkwhgW
         qxWq/kS0p6LJaYi54Lm+8M+KpfsncW1DrfXHoHSJtmQ2RErMxPl7xcDZ+LqIXj1J3i
         nXIC1Iu3bvNTZuR9t6fnq9fWc3oPks/8Jk9KrzyW+vgA6UOaayrI8Qw3iw9dPVNO8S
         BaiVcqzvCBqE2Ww6spq9SKrwQi8Q15aixI+49Xywgh6aEqAotfbQIMpbZnQ4Ga2S4o
         RFj83E7PZQ34A==
Message-ID: <7a2de98766bbb81c2db2cf7a5b827c122bc7be81.camel@kernel.org>
Subject: Re: [PATCH] Appoint myself page cache maintainer
From:   Jeff Layton <jlayton@kernel.org>
To:     Dave Chinner <david@fromorbit.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Date:   Mon, 09 May 2022 06:28:12 -0400
In-Reply-To: <20220508231644.GP1949718@dread.disaster.area>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
         <20220508202849.666756-1-willy@infradead.org>
         <20220508231644.GP1949718@dread.disaster.area>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2022-05-09 at 09:16 +1000, Dave Chinner wrote:
> On Sun, May 08, 2022 at 09:28:48PM +0100, Matthew Wilcox (Oracle) wrote:
> > This feels like a sufficiently distinct area of responsibility to be
> > worth separating out from both MM and VFS.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
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

Ditto. Thanks for stepping up!

Reviewed-by: Jeff Layton <jlayton@kernel.org>
