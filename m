Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685916B36FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 08:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjCJHAz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 02:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCJHAx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 02:00:53 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D725AF92C5
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Mar 2023 23:00:52 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4F89A68AFE; Fri, 10 Mar 2023 08:00:49 +0100 (CET)
Date:   Fri, 10 Mar 2023 08:00:47 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/3] ufs: don't flush page immediately for DIRSYNC
 directories
Message-ID: <20230310070047.GB13563@lst.de>
References: <20230307143125.27778-1-hch@lst.de> <20230307143125.27778-2-hch@lst.de> <20230310035353.GM3390869@ZenIV> <20230310063756.GA13484@lst.de> <20230310065235.GR3390869@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310065235.GR3390869@ZenIV>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 10, 2023 at 06:52:35AM +0000, Al Viro wrote:
> > > Umm...  I'll throw it in ufs pile, I guess (tomorrow - I'll need to
> > > sort out Fabio's patches in the area as well; IIRC, the latest
> > > had been in late December).
> > 
> > Well, the three patches really should go together, otherwise we miss
> > yet another merge window.
> 
> Umm...  Do you need them in the same (never-rebased?) branch, or would
> it suffice to have all of them reach mainline by 6.4-rc1?

The latter.  But patch 3 depends on 1 and 2.
