Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C34874F03F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 15:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjGKNe6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jul 2023 09:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjGKNe4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:34:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B45E6F;
        Tue, 11 Jul 2023 06:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+BmIGfZ8mUxPdweCAo3LBuoEvRT/aOTQDEICBJuQjnQ=; b=LqyzUctD7qNU+lRe3xpcVLzJXL
        lyynTs8AalGWPmlguziXZ3eYQuuuRmVeRZoDZm4kSNAVdK8tm1Kb7M1fYzHLG/BHfGiobLsfXJQ0G
        EEqKDLvd33Cbkzrlvtr8plnm2pSMVs87m4F17jLPlzJFGD9my+8zlDwXFqPPW/vKv00ju5QCbOW64
        J/nFMFi+Uo6dJo7zRaMxErfQduotAqFnvUJ7k33Gn66EOtEaxOitTAABrkID8f9BwOmALB7sqv1es
        TomKmuBQWf5DUntx2sHabJ7LZBA+/I4qoIVLippGZzqwVTM7gtbaQFNFKWpGSp1iUREYtcrkTez4W
        jb03/mLg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qJDVh-00Fl0B-2f; Tue, 11 Jul 2023 13:34:33 +0000
Date:   Tue, 11 Jul 2023 14:34:33 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Zehao Zhang <zhangzehao@vivo.com>
Cc:     linkinjeon@kernel.org, sj1557.seo@samsung.com, rostedt@goodmis.org,
        mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] exfat: Add ftrace support for exfat and add some
 tracepoints
Message-ID: <ZK1aaREkOh/0aIj8@casper.infradead.org>
References: <20230711122208.65020-1-zhangzehao@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711122208.65020-1-zhangzehao@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 11, 2023 at 08:22:08PM +0800, Zehao Zhang wrote:
> Add ftrace support for exFAT file system,
> and add some tracepoints:

Why?  I don't believe these are useful.  Because if you actually had use
for them, you would have noticed that you're missing 99% of the reads
issued to the filesystem from the VFS -- through exfat_readahead(),
which you didn't instrument.

So what do you actually want to know, and why can't you get that
information already?
