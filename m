Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09C6742AB3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 18:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbjF2QeN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 12:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbjF2QeG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 12:34:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1AF30EC
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 09:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tw7B7S6847KV8tj1KhN46eiEpct/gLxR3c63gjpKPFc=; b=Rw0MaSe+Y+F561uHRp3BOZ81hm
        RerUADbFNkTEBDxSAFZRLErAECERYYgejOVP10aJueogxsBCdgBNeSw1C2mbdeCZ3oIa4abZe5P2Y
        7G2WzQ+tDpYxH3EComAjyoo2HatXlqpKGpZAGzprgcvaA5ljnNFUJzA9RB52CaamwtDUl4HdJi7xj
        vdLP3hdGZI98gAGYfrsDEiOw0kDGGtq8ttX+Y2iKeBABLZhxs/zP0fnB6eznBmb4UTxW+rYEoM1uE
        C11WKd6jsLrs8s/ggFTBJXIuDallRfTdfHelimr/18nLKsp0i6s2jtRhPiN8F+Mw8f3We+EjddTCp
        seIVUC4A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qEuam-00506W-Hk; Thu, 29 Jun 2023 16:34:00 +0000
Date:   Thu, 29 Jun 2023 17:34:00 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Daniel Dao <dqminh@cloudflare.com>
Cc:     Dave Chinner <david@fromorbit.com>, djwong@kernel.org,
        kernel-team <kernel-team@cloudflare.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Backporting of series xfs/iomap: fix data corruption due to
 stale cached iomap
Message-ID: <ZJ2yeJR5TB4AyQIn@casper.infradead.org>
References: <CA+wXwBRdcjHW2zxDABdFU3c26mc1u+g6iWG7HrXJRL7Po3Qp0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+wXwBRdcjHW2zxDABdFU3c26mc1u+g6iWG7HrXJRL7Po3Qp0w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 29, 2023 at 05:09:41PM +0100, Daniel Dao wrote:
> Hi Dave and Derrick,
> 
> We are tracking down some corruptions on xfs for our rocksdb workload,
> running on kernel 6.1.25. The corruptions were
> detected by rocksdb block checksum. The workload seems to share some
> similarities
> with the multi-threaded write workload described in
> https://lore.kernel.org/linux-fsdevel/20221129001632.GX3600936@dread.disaster.area/
> 
> Can we backport the patch series to stable since it seemed to fix data
> corruptions ?

For clarity, are you asking for permission or advice about doing this
yourself, or are you asking somebody else to do the backport for you?
