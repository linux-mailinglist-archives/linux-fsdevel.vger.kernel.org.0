Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F20741EA4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 05:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjF2DTE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 23:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjF2DTC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 23:19:02 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B05271B
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 20:19:00 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-117-150.bstnma.fios.verizon.net [173.48.117.150])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35T3Iqpu024993
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 23:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1688008734; bh=qadv2SsiyzYwbM+c4ST7Ty4dKUz2fdSBs9NoPLrUPyo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Dq7+8hEGou0JzRVP3SvEjp/EHC/iOwv2pFgdOxabcroLsMpompjvXQS2c5xan1hxT
         4WqPy1ksj/jEGq3lZ3KnTdTVa/GLuK+2vy0i8G0UmTihhbiNk1C9zaCZsVaw7RxQ4v
         ItXOiZYGT36kPLZTMfZQcQQ1iB5Amv/PDD+w8WvkuPvNlJ89o5H4JCZj0hRVsQfPct
         VI6EIiaYnNhDFxSM9JOwMH7ef8tasQh1+2gLMTFUFRBSIJFwepezIuWYovV1qKVoiV
         +Xxw6zwaslicKwLBY+AA4o3xGL4/t9X/DcXMRH7rbSjnHMUaaiJanNfZbyx8uOlxd2
         5oHAcj9EuibRQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 1E42515C027F; Wed, 28 Jun 2023 23:18:52 -0400 (EDT)
Date:   Wed, 28 Jun 2023 23:18:52 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     syzbot <syzbot+7ec4ebe875a7076ebb31@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ext4?] KASAN: use-after-free Read in ext4_find_extent
 (3)
Message-ID: <20230629031852.GH8954@mit.edu>
References: <000000000000c7970f05ff1ecb4d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000c7970f05ff1ecb4d@google.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

#syz set prio: low

On Tue, Jun 27, 2023 at 09:16:56AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8a28a0b6f1a1 Merge tag 'net-6.4-rc8' of git://git.kernel.o..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=12f5b40b280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e74b395fe4978721
> dashboard link: https://syzkaller.appspot.com/bug?extid=7ec4ebe875a7076ebb31
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15a2b5c0a80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1181c5c0a80000

This report is via writing to the block device, while the file system
is mounted.

     	       		 	 	    - Ted
