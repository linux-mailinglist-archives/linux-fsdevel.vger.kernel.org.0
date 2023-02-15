Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94144697E47
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Feb 2023 15:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjBOOX2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Feb 2023 09:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBOOX1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Feb 2023 09:23:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BEB2385A;
        Wed, 15 Feb 2023 06:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rSyQHylHlbDdD5YdO2HcxQBZqHvFysaqH4PwJpj4Y3Y=; b=hBqIkVNaYkklzO1uEevzugUctk
        VhMHkBF9HuHnF9fEe6o/rci+h6boHsBeLjGo8iHzrwekchmittRBRlFrMgmOCfdNhvzyp7vONhcpb
        l+wtlxi3b/WE+5WXwDXi4sGYOcE9g3q8+2cQTCbfmM96qf1ucoClRk+CEIN02Kmcggf6NLF/qeMt7
        4DIKEkOWg+vM/IJbd13XHQN/OZ6M3zulfuYKEtcdYVK/k7G3bNJbvUV6S0G4KuElvwwzPAVpcb5yU
        Bu8b4jbOxQg+rcduJxcQt6vmiIm/o1eDVggUl+BnpEbazLGZUisq9oQt9WMiy19Zngh5ERJcBNcLs
        rkKsT3yQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pSIgd-006CKS-66; Wed, 15 Feb 2023 14:23:07 +0000
Date:   Wed, 15 Feb 2023 06:23:07 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, smfrench@gmail.com,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v14 00/17] iov_iter: Improve page extraction (pin or just
 list)
Message-ID: <Y+zqy7kyWWo9v/Wt@infradead.org>
References: <867e1e3e-681b-843b-1704-effed736e13d@kernel.dk>
 <20230214171330.2722188-1-dhowells@redhat.com>
 <2877092.1676415412@warthog.procyon.org.uk>
 <2895995.1676448478@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2895995.1676448478@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 15, 2023 at 08:07:58AM +0000, David Howells wrote:
>  	return total_spliced ? total_spliced : error;
>  }
> +EXPORT_SYMBOL(filemap_splice_read);

EXPORT_SYMBOL_GPL for filemap internals, please.
