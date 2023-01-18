Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3618B672C50
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 00:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjARXOX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 18:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjARXOV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:14:21 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86779613E1;
        Wed, 18 Jan 2023 15:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Iy1uWwVulPG3hrx1I1WJTYNcZh04GnKRBWwHbBjzu8E=; b=nRjWm/jIaPLeKa9UhHLJFo5Pum
        n9V0mCn4+uFm0H1kcsJssX4s9/142JWVlZxOnx0bhMbMrdDb4zQOqPmIsRODxLKTV4pWaalWqeG79
        fQxJjdSg0L2O11bIQhU5rShiuLiR+Trsq8jRkrMD3rdfszZjZoTgiXx+7Qa3Mb48BHXA2Jc7wkjg+
        Q2VRO9YObBQ/iwj7xt0mriULw0mewtvvZbjdZMrpbnh/4acjG4d1OK157rnsIDMWemA6RD2qoeZrh
        1dLvhqB/g+HH1mZ1mNEFM55nYL+vqsHD+GGkWB2jNUxLENTNZR3KSpDCkBfqkM/8D2nxXJDCbAI/z
        0yGHPGtQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pIHdD-002dQf-31;
        Wed, 18 Jan 2023 23:14:12 +0000
Date:   Wed, 18 Jan 2023 23:14:11 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 05/34] iov_iter: Change the direction macros into an
 enum
Message-ID: <Y8h9Q9fyUGBFsiMj@ZenIV>
References: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
 <167391051810.2311931.8545361041888737395.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167391051810.2311931.8545361041888737395.stgit@warthog.procyon.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 16, 2023 at 11:08:38PM +0000, David Howells wrote:
> Change the ITER_SOURCE and ITER_DEST direction macros into an enum and
> provide three new helper functions:
> 
>  iov_iter_dir() - returns the iterator direction
>  iov_iter_is_dest() - returns true if it's an ITER_DEST iterator
>  iov_iter_is_source() - returns true if it's an ITER_SOURCE iterator

What for?  We have two valid values -
	1) it is a data source
	2) it is not a data source
Why do we need to store that as an enum?
