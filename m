Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC446DD19A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 07:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjDKF1P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 01:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjDKF1P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 01:27:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3B11BF7;
        Mon, 10 Apr 2023 22:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pYrKCITtwCdF/rcxxVKn5VZep4eKY2TOamrgjv0L1Y4=; b=XBGL3jtlw/timZ6jk72FmyQXMH
        iqUJbIPKezhNMQgDqP0w9EXYugGMQINqH1jOcnWgVA0/xsU0EhuWc2ykCYPlLRKWX+8CWEO3x3A8U
        tGK7TqiC4W8ksu5L9fNoviDVlh5L7o43t0h9RoaRP+RGuPJVLmUuSb2Nbb+z0KlO8Joon61i5IC5Y
        BpejunAhqtuf6pnFCmTjn5ui/tifOjHzyZFNFIGlyG8vyx4GOrqPkuy6DqraZngF5xhfD9fhW1t2g
        s4N8vdu9MTVIzNzDac1wGYP2eEpxXZGBT0NS15a86S8TXkbKEVz6jiCdamwxtmRyiCjQ7l01pJx/A
        hMcqM4WQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pm6X8-00GSSH-1n;
        Tue, 11 Apr 2023 05:27:10 +0000
Date:   Mon, 10 Apr 2023 22:27:10 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>
Subject: Re: [RFCv2 2/8] libfs: Add __generic_file_fsync_nolock implementation
Message-ID: <ZDTvrmFR1/nXUqMl@infradead.org>
References: <cover.1681188927.git.ritesh.list@gmail.com>
 <6fad2ec25bccbbb9b3effbd18c2d6d6965b9a33c.1681188927.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fad2ec25bccbbb9b3effbd18c2d6d6965b9a33c.1681188927.git.ritesh.list@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 11, 2023 at 10:51:50AM +0530, Ritesh Harjani (IBM) wrote:
> +/**
> + * __generic_file_fsync_nolock - generic fsync implementation for simple
> + * filesystems with no inode lock

No reallz need for the __ prefix in the name.

> +extern int __generic_file_fsync_nolock(struct file *, loff_t, loff_t, int);

No need for the extern.  And at least I personally prefer to spell out
the parameter names to make the prototype much more readable.

