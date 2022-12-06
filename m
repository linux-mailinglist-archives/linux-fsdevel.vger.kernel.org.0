Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1095C643F15
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Dec 2022 09:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbiLFIxD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Dec 2022 03:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234232AbiLFIxB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Dec 2022 03:53:01 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943D1FCFB;
        Tue,  6 Dec 2022 00:52:59 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3EBCF68B05; Tue,  6 Dec 2022 09:52:55 +0100 (CET)
Date:   Tue, 6 Dec 2022 09:52:54 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Aditya Garg <gargaditya08@live.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hfsplus: Add module parameter to enable force writes
Message-ID: <20221206085254.GA9597@lst.de>
References: <53821C76-DAFE-4505-9EC8-BE4ACBEA9DD9@live.com> <20221202125344.4254ab20d2fe0a8e784b33e8@linux-foundation.org> <20221204080752.GA26794@lst.de> <A35CC249-5F77-4B1A-B68F-8E07A38AB73B@live.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A35CC249-5F77-4B1A-B68F-8E07A38AB73B@live.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 04, 2022 at 11:01:49AM +0000, Aditya Garg wrote:
> Although, if you think its worth it, the following improvements can be made :-
> 
> 1. There is no logging showing that writes have been force enabled. We could add that.

I think this would be very useful.

> 2. We could have separate mount options for journaled and locked volumes (although I dunno in what case we get locked volumes).

We can't really retire the existing option, but if for your use case
you'd prefer to only allow one of them and want to not write to the
other case feel free to submit a patch to add that option.
