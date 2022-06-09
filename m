Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C873545536
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jun 2022 21:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240108AbiFIT6l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jun 2022 15:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbiFIT6k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jun 2022 15:58:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542C19858C
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jun 2022 12:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y5fihmUS3SVHkUnu1r+heWGCdbdeH0qXraoMntPM/jQ=; b=QhBiC7IP4kFyuQOw1B2IuJ4t0n
        v+kg5sumZuL4uMiHtdq++wvRYmGdz+NaEMI4/O+6ADJP8YE+ZsjSaH77iBDJMcE5yaclrxN8EMvMV
        b8RHQHjYRGs28Tjskg4IB1sWux2WnwEannarVb+DIjlwRD3BckzZ6b49mj9bf7wN/ycZ9emEtgEf9
        bktgLvyC2tQhqn2PzEe/3jmg6PHdIqloCmen4CLBbd668Mk6JbSSQAyNX62Ct48fZAgOaMIUAFLNU
        zUbgXlXTkf5YtKBuifSo7Cnm/s3miLEFTNcFvcFzk9i/qc0oiPZ55Xj1YVcjDpdCqE3RoRuRRfmB8
        3IAe3/7w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nzOIc-00DoOi-0j; Thu, 09 Jun 2022 19:58:34 +0000
Date:   Thu, 9 Jun 2022 20:58:33 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC][PATCHES] iov_iter stuff
Message-ID: <YqJQ6bMJiF1+Luc6@casper.infradead.org>
References: <Yp7PTZ2nckKDTkKu@zeniv-ca.linux.org.uk>
 <CA+icZUV_kJcwtFK2aACAfKAkx6EdW62u46Qa7kkPXtRhMYCcsw@mail.gmail.com>
 <YqEJEWWfxbNA6AcC@zeniv-ca.linux.org.uk>
 <CA+icZUU_Lzo918raOtEXvMtEoUhZp9e+8Xd0_bxA=1_aZ=ZBTQ@mail.gmail.com>
 <YqJIYd65XeA8Aj6C@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqJIYd65XeA8Aj6C@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 09, 2022 at 08:22:09PM +0100, Matthew Wilcox wrote:
> It's not really that.  This is more about per-IO overhead, so you'd want
> to do a lot of 1-byte writes to maximise your chance of seeing a
> difference.

Here's an earlier thread on ->read_iter vs ->read performance costs:

https://lore.kernel.org/linux-fsdevel/20210107151125.GB5270@casper.infradead.org/
