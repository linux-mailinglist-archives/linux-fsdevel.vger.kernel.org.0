Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED7D74A0C5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 17:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbjGFPVb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 11:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjGFPVa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:21:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B891730;
        Thu,  6 Jul 2023 08:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zla1ImuYlSI5ZdeorNKDcqvlZHdC0vro7cklgNetIq4=; b=md2yoQbsnnELLcfX6YH8bFGdgD
        sVm3mfyQyYUBNSKlDnq01v4epjnSUGYjdn0UcoSP/y4qznjsZ5DVvjb7Ednq5ebTwXF4vGlcRcNND
        LHM0q+covQuGM7MQUrnz/4r6PTvLDf17t9LKMo0Y6QNTtcD9gSa8AKjWLG+0EX5OMku5iH7jLNtfR
        TMZay13oaFnWOSnyEOQAeHrFwWMJkHxTimLAEwwF5Sc0FIlDLrpGOFofVyIet7FH6QyCxvzOjElFP
        o0bo0vZKvhnQjryDZlVlhCzo9+Q5jmy5qcpOp9MZ4LG7iGYUVoJF3xPRmKLbhkyjS/ZyZqGZy/Tqe
        zW+T7FUA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qHQn6-001zS5-18;
        Thu, 06 Jul 2023 15:21:08 +0000
Date:   Thu, 6 Jul 2023 08:21:08 -0700
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
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christian Brauner <christian@brauner.io>
Subject: Re: [RFC PATCH 01/11] iov_iter: Fix comment refs to
 iov_iter_get_pages/pages_alloc()
Message-ID: <ZKbb5Hawv6XYTAzJ@infradead.org>
References: <20230630152524.661208-1-dhowells@redhat.com>
 <20230630152524.661208-2-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630152524.661208-2-dhowells@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 30, 2023 at 04:25:14PM +0100, David Howells wrote:
>  	/*
>  	 * FOLL_LONGTERM indicates that the page will be held for an indefinite
>  	 * time period _often_ under userspace control.  This is in contrast to
> -	 * iov_iter_get_pages(), whose usages are transient.
> +	 * iov_iter_get_pages2(), whose usages are transient.
>  	 */

I don't think this should refer to iov_iter_get_pages* at all.  The
flag should document that actual get/pin_user interfaces and not refer
to a (deprecated) interface built on top of it.
