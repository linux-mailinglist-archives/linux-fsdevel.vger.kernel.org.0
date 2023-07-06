Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B2D74A105
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 17:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbjGFPaj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 11:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbjGFPai (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:30:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559BC1BE8;
        Thu,  6 Jul 2023 08:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wY5Dot1/zTMAJ+7vVNWs/yMvd7ZTGFOfgJeR2bahFjQ=; b=BTSyek31EkyyPudrxmynZoVthN
        81KWr6uMtnlBbcKq8tTiT4/oN//7sPQ0IUO+/LCa93l+kiLgsCVrkBZe1tB0n7QFBCKuhIAvFK10p
        n13Zryn1H3WWsvqTg7C7I7IJSTEs0sopsCb8K10HznqFkXscj+lpyQsaX37JCHieii+swEiwRnSWA
        JHzgvaU73n1x7ULgjhfZVyOTFik7lvZ8l3ZUFHRoAxlUUy+d2nrIt96GfPJgBOXoHFSpkCP86iuU+
        ALoVEjNSHGDfyGlACeQ0IsaYd24bkCCK3ClVrO+fwcVu/0F92ch134xa1t3tW2DKFQ7G03FUtfOkT
        sOI9ztiw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qHQw8-0020gL-0X;
        Thu, 06 Jul 2023 15:30:28 +0000
Date:   Thu, 6 Jul 2023 08:30:28 -0700
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
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [RFC PATCH 06/11] iov_iter: Use op_is_write() rather than
 iterator direction
Message-ID: <ZKbeFNG5bF5HbcgT@infradead.org>
References: <20230630152524.661208-1-dhowells@redhat.com>
 <20230630152524.661208-7-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630152524.661208-7-dhowells@redhat.com>
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

On Fri, Jun 30, 2023 at 04:25:19PM +0100, David Howells wrote:
> If a request struct is available, use op_is_write() instead of the iterator
> direction.

s/iov_iter/block/ in the subject.

