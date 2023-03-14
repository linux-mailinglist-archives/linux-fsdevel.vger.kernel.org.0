Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC506B9D18
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 18:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjCNRcf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 13:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjCNRce (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 13:32:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9AF9B997;
        Tue, 14 Mar 2023 10:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=28j9WYgvln7aRho0OI6duSimvP4MftIELf2uPURKALY=; b=ezQ6b9Wz3oP3LuIChxz62KzWUd
        UfTh6YVtINaWGSDW4lKRlfb17SBRw1phWauX5F3WS0AMcb7IIz0NhrPvxAhoGrUvPIc9JxfcbfOzx
        KtMntx4IBgWsjg48yvjhEikc81whrfdeDIMNptNa6JQG8OveNmDKW6EVBDqtyURwlLm5ftY/lO9BI
        ZDnI5cZh1SVUj7BgcdAEOd9YtFenDxYENUFrNDpHv7tbWngE031S4BaPGdaYSIXByEyfro3Dw68q7
        S7hTk8FiTPK0bubryasAgXrRt5LPpvAbSjQSqXKAykY4UxEz32B7PAkYikrMDRCBTcVrtM/TSvGs8
        Pfr6sIqg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pc8Vd-00B1ba-2g;
        Tue, 14 Mar 2023 17:32:25 +0000
Date:   Tue, 14 Mar 2023 10:32:25 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Steve French <smfrench@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>, linux-cifs@vger.kernel.org
Subject: Re: [PATCH v17 07/14] splice: Do splice read from a file without
 using ITER_PIPE
Message-ID: <ZBCvqQyOgEa626ON@infradead.org>
References: <20230308165251.2078898-1-dhowells@redhat.com>
 <20230308165251.2078898-8-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308165251.2078898-8-dhowells@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 08, 2023 at 04:52:44PM +0000, David Howells wrote:
> Make generic_file_splice_read() use filemap_splice_read() and
> direct_splice_read() rather than using an ITER_PIPE and call_read_iter().
> 
> Make cifs use generic_file_splice_read() rather than doing it for itself.

Please split the cifs patch out into a separate one.

Otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
