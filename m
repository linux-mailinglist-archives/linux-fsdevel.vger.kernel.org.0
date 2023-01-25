Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C9867AA4E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 07:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbjAYG25 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 01:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbjAYG24 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 01:28:56 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D62E2F798;
        Tue, 24 Jan 2023 22:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=b1wjOqEZrpOkxHT+1PUvP0AOFeUjYZhKlkU4+S4GB0k=; b=uWEY9WMexKz+9xXeSpSQQ77B2o
        99rw7YhSRvN4STq0JUdr1YPOz1RTSI6lFRUkjHzXPhv9DNY0z7KCO5yJmpxrSjczZqWbxgUkf0Pw9
        GMIdHLsKmuuIafYwCktI02lb7llqnzyaZU851zyBR8gHrR9zteVmmiBsMq+q55KoTZwB8OsmrIaIQ
        60QEZpmO3lI+1Jbk4ELfJVMYSO5Zgltk0/wwh93FqQ2ey2wb37YuqNtK2d9wfw5sUcGdyawPH7xQn
        jZ9wN+v4XxzvT0XYFzZKG9JU1UqJtxv5NOYsuUx9jVXo34t7QXr01IXmWHt08kO+d1PEtxagOao9I
        cyklzP9A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKZGv-0067kk-0n; Wed, 25 Jan 2023 06:28:37 +0000
Date:   Tue, 24 Jan 2023 22:28:37 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/8] iomap: Don't get an reference on ZERO_PAGE for
 direct I/O block zeroing
Message-ID: <Y9DMFfcBAE3WCKef@infradead.org>
References: <Y9Aq7eJ/RKSDiliq@infradead.org>
 <20230124170108.1070389-1-dhowells@redhat.com>
 <20230124170108.1070389-4-dhowells@redhat.com>
 <1296569.1674592913@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1296569.1674592913@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 24, 2023 at 08:41:53PM +0000, David Howells wrote:
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > On Tue, Jan 24, 2023 at 05:01:03PM +0000, David Howells wrote:
> > > ZERO_PAGE can't go away, no need to hold an extra reference.
> > > 
> > > Signed-off-by: David Howells <dhowells@redhat.com>
> > > Reviewed-by: David Hildenbrand <david@redhat.com>
> > 
> > If you send this on this needs your signoff as well, btw.
> 
> Um.  You quoted my signoff.  Do you mean your signoff?

Umm, I'm confused because you had my signoff on the last version :)
The patch is ok as-is.  
