Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692ED76601A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 01:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjG0XBr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 19:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjG0XBq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 19:01:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF78894;
        Thu, 27 Jul 2023 16:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ejHA7FmenXKGQyWqGe1uUh0jEtBuCM0/1PLFM8OH3iw=; b=hTd+/S4/7TFQPhaXWdMsHxc4J5
        tgm3Of1OlmnjvpvbW7qrGuwpdLMHMkcJIaMH6feS4f9zB4mQzXgQoLYFs4zpYkRNNNGx+/xtv6Wze
        md/BwO+TpOSTwm9hkU7nmhlYBagwt+zIQDdEQ3nYqHrR3ctOxgjbqDGZxU6Xrw7wbDIOFwGESoJbI
        uveMxe+J6gNi/hGO4bYX2n8Qhw9hcLAHc94Hp5BhU6wtSPb0egC3Qx3ZLpEtpge6xYhXhgfrIaysf
        Fk0WRQ/hWKI/Ht4OzLw3V+hNLlNJFZFKVgsvGtE+x7TqiAL8Iyf1l5gjMuQqIZM25NDcMG3SdEmnw
        LPsK+Fmw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qP9zM-000qU2-0N;
        Thu, 27 Jul 2023 23:01:44 +0000
Date:   Thu, 27 Jul 2023 16:01:44 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Chandan Babu R <chandan.babu@oracle.com>
Subject: Re: xfs kdevops baseline for next-20230725
Message-ID: <ZML3WJyqSYwzZW0w@bombadil.infradead.org>
References: <ZMK1r91ByQERwDK+@bombadil.infradead.org>
 <20230727225859.GF11352@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727225859.GF11352@frogsfrogsfrogs>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 27, 2023 at 03:58:59PM -0700, Darrick J. Wong wrote:
> On Thu, Jul 27, 2023 at 11:21:35AM -0700, Luis Chamberlain wrote:
> > The sections tested for are:
> > 
> > xfs_crc
> > xfs_reflink
> > xfs_reflink-normapbt
> > xfs_reflink_1024
> > xfs_reflink_2k
> > xfs_reflink_4k
> > xfs_nocrc
> > xfs_nocrc_512
> > xfs_nocrc_1k
> > xfs_nocrc_2k
> > xfs_nocrc_4k
> > xfs_logdev
> > xfs_rtdev
> > xfs_rtlogdev
> 
> Question: Have you turned on gcov to determine how much of fs/xfs/ and
> fs/iomap/ are actually getting exercised by these configurations?

Not yet, and it would somehow have to be the aggregate sum of the
different guests, is that easy to sum up these days, given the same
kernel is used?

> I have for my fstests fleet; it's about ~90% for iomap, ~87% for
> xfs/libxfs, ~84% for the pagecache, and ~80% for xfs/scrub.  Was
> wondering what everyone else got on the test.

Neat, it's something we could automate provided if you already have
a way to sum this up, dump it somehwere and we I can make a set of
ansible tasks to do it.

  Luis
