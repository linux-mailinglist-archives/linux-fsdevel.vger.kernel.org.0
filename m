Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE61B69486F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Feb 2023 15:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjBMOpw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Feb 2023 09:45:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjBMOpu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:45:50 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66071C328;
        Mon, 13 Feb 2023 06:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HBHZ8z1bM75Bh4e3Q6UBsBCeil4l6wSmZINn4agj1IY=; b=MgfIzSGSw/BoxaCoi0mx7j7AHC
        Z+MvlrozYPzbRcS7kmj0RwEaBDyD/5G6bBzXGBSt+6vgwf6/b6/K4fEbndd/gvctc99Ts740FYM+W
        vBUMLbJWQLzkbKRlXCeysKMFB7T0GttZDsJd8zikc0Kl2YSMk/+Ss7jFBw9xUS3z4yEVUow125rN5
        ACaZmDrxegK2oVNldpkHQ+UNnpl1C4jHK4op1qHq1+SHz3GQ9EFr1T54K1cXdvWP8E+CsqWWe+bkD
        Cp96ffMGIwAREiUe1I6KdlCWg14bGVKuIjtnhRvbQ0gBZyWSnw477MW9hjwf+QIfIdXR21eWziPmd
        mZAsQM5Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pRa5J-00F1uW-Lq; Mon, 13 Feb 2023 14:45:37 +0000
Date:   Mon, 13 Feb 2023 06:45:37 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 2/4] splice: Provide pipe_head_buf() helper
Message-ID: <Y+pNEbQklWdlo2tk@infradead.org>
References: <20230213134619.2198965-1-dhowells@redhat.com>
 <20230213134619.2198965-3-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213134619.2198965-3-dhowells@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 13, 2023 at 01:46:17PM +0000, David Howells wrote:
> Provide a helper, pipe_head_buf(), to get the current head buffer from a
> pipe.  Implement this as a wrapper around a more general function,
> pipe_buf(), that gets a specified buffer.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

There's also a bunch of spots in existing code that should use this
helper.
