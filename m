Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF98165F063
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jan 2023 16:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbjAEPq7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Jan 2023 10:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbjAEPq4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:46:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26414BD53;
        Thu,  5 Jan 2023 07:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UcJOViUb3NSYcRTFH9cclg0kjcJfbEsdzUY3Qy3AQl4=; b=ZNCMIIaxbDu3V7R1jisPBDBvpa
        ken2r2RDD8vUKBbC2QosGTKt9pm55rqbG+uTEPjI/QivcOyszHXgumpfYWZ322QAnQ/ss3Uj4K39L
        5HyMg+r2vq8bphd6CTkqEo4NzckSwttCfnU2TmNLYG5jiqC7+D8WExSZiMKThlRi+Wvde+XIfwr8S
        83Sab9lTu0MdZTsBkjtIr6XTc60RPPxPfHP8pUU+fYnISSW2jASDW9zloQFOG3EaMgSAYetaJ2oOI
        rfs+NSi5EtotiWO6zd5GRo+2b+4jSgQWSM9Sns/Ghw47kC0vZfBUnIvnN1IpDsamhnST+BaYopVaR
        R82T7ddw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pDSSD-00GFKq-4P; Thu, 05 Jan 2023 15:46:53 +0000
Date:   Thu, 5 Jan 2023 15:46:53 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Viacheslav Dubeyko <slava@dubeyko.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+7bb7cd3595533513a9e7@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        christian.brauner@ubuntu.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        ZhangPeng <zhangpeng362@huawei.com>,
        linux-m68k@lists.linux-m68k.org
Subject: Re: [syzbot] [hfs?] WARNING in hfs_write_inode
Message-ID: <Y7bw7X1Y5KtmPF5s@casper.infradead.org>
References: <000000000000dbce4e05f170f289@google.com>
 <5f45bb9a-5e00-48dd-82b0-46b19b1b98a3@app.fastmail.com>
 <CAHk-=wi8XyAUF9_z6-oa4Ava6PVZeE-=TVNcFK1puQHpOtqLLw@mail.gmail.com>
 <ab7a9477-ddc7-430f-b4ee-c67251e879b0@app.fastmail.com>
 <2575F983-D170-4B79-A6BA-912D4ED2CC73@dubeyko.com>
 <46F233BB-E587-4F2B-AA62-898EB46C9DCE@dubeyko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46F233BB-E587-4F2B-AA62-898EB46C9DCE@dubeyko.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 04, 2023 at 08:37:16PM -0800, Viacheslav Dubeyko wrote:
> Also, as far as I can see, available volume in report (mount_0.gz) somehow corrupted already:

Syzbot generates deliberately-corrupted (aka fuzzed) filesystem images.
So basically, you can't trust anything you read from the disc.

