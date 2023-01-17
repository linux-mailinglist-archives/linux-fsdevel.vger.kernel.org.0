Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A0E66D76A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 09:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235913AbjAQICq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 03:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235946AbjAQICe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:02:34 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8B42749A;
        Tue, 17 Jan 2023 00:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sPOZ2wlCVM0LsIFdWIWwF+5cY5g64XohSvy3053HAoM=; b=MnWH8E02IbQoXq7LnGcgMaRKPM
        FSQKm+jId4KyHBsgDm7EyqlgemDXMyQ7IkfqmspsZk6VUeKwn+o1EejlJ6BYrOr3qygBs3LQ7N7Ij
        BlXK9nc4aH/6r1ET7Fex2ugtDTG7j4tv28IkjLiMPvAs3THJ7q78PNA9D36+mi6Nj0FcDhRzhmOo3
        RLMwqMVWwoN6D8j4hPmTkBjEaZTGn+38IekWSWeiit3+FYFGMmzsFwtdneuwpSJNi1dLXPX7r3PoT
        x47II/jP9d8ovAw6KffKB3DBxmk+6hirOkuhuXHSUS660Grtnqk5A3owlUdqEkL0c1e+tiiubN8Wi
        xTCFtAdg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHgvH-00DGcT-RZ; Tue, 17 Jan 2023 08:02:23 +0000
Date:   Tue, 17 Jan 2023 00:02:23 -0800
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
Subject: Re: [PATCH v6 08/34] mm: Provide a helper to drop a pin/ref on a page
Message-ID: <Y8ZWD82dvoulSG8k@infradead.org>
References: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
 <167391053934.2311931.17229969100836070492.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167391053934.2311931.17229969100836070492.stgit@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 16, 2023 at 11:08:59PM +0000, David Howells wrote:
> Provide a helper in the get_user_pages code to drop a pin or a ref on a
> page based on being given FOLL_GET or FOLL_PIN in its flags argument or do
> nothing if neither is set.

Please don't add new page based helpers.
