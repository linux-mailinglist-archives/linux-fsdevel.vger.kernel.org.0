Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C21E678464
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 19:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbjAWSVF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 13:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjAWSVE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:21:04 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E080A5E3;
        Mon, 23 Jan 2023 10:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Plgp53G48CfKihctGYd0SLClixtWLSYNuPjY8g+qU4M=; b=gHjCb2IhHRG55quQCF5YejskEm
        wWA8cHIh34h5ssVq4pWsRYa/HRcaarsvbsCPZsUtLWli7BY7ZU16wdpZXjdyzUaQ0Yy17M0QzQM88
        ar4koWT5INYYOhvnrNB1JwbBJq9zcGFNNqgAZmG9kx4RQbGiJjBUvlWxr948T1s7vEgM1jikjM8Kg
        PK9q1FIdGVPoIlVn3Eob9W2f36MzsQM8KMr6Qn+TwMHrCd/gyTRfhc4LIZEbF2kp7Aq74cZn+t9ln
        XASghiLDgZGQ3bkYtJBm/JMks27q6sFfxN8yWTAFX9T+ZP0mtA8HFQJErAhV6TCWYfhuSj6xO8yzi
        jyRWgfWA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pK1R2-000zs4-Aw; Mon, 23 Jan 2023 18:20:48 +0000
Date:   Mon, 23 Jan 2023 10:20:48 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 01/10] iov_iter: Define flags to qualify page
 extraction.
Message-ID: <Y87QALPDje97EJZG@infradead.org>
References: <20230123173007.325544-1-dhowells@redhat.com>
 <20230123173007.325544-2-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123173007.325544-2-dhowells@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 23, 2023 at 05:29:58PM +0000, David Howells wrote:
> Define flags to qualify page extraction to pass into iov_iter_*_pages*()
> rather than passing in FOLL_* flags.
> 
> For now only a flag to allow peer-to-peer DMA is supported.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
