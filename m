Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 654EBC2908
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2019 23:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732157AbfI3VoF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Sep 2019 17:44:05 -0400
Received: from albireo.enyo.de ([37.24.231.21]:56896 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728819AbfI3VoF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Sep 2019 17:44:05 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1iF3Sc-0006PF-4d; Mon, 30 Sep 2019 21:44:02 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1iF3RG-0001ar-Am; Mon, 30 Sep 2019 23:42:38 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [bug, 5.2.16] kswapd/compaction null pointer crash [was Re: xfs_inode not reclaimed/memory leak on 5.2.16]
References: <87pnji8cpw.fsf@mid.deneb.enyo.de>
        <20190930085406.GP16973@dread.disaster.area>
        <87o8z1fvqu.fsf@mid.deneb.enyo.de>
        <20190930211727.GQ16973@dread.disaster.area>
Date:   Mon, 30 Sep 2019 23:42:38 +0200
In-Reply-To: <20190930211727.GQ16973@dread.disaster.area> (Dave Chinner's
        message of "Tue, 1 Oct 2019 07:17:27 +1000")
Message-ID: <87ftkdfokx.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Dave Chinner:

>> [ 4001.238446] Call Trace:
>> [ 4001.238450]  __reset_isolation_suitable+0x9b/0x120
>> [ 4001.238453]  reset_isolation_suitable+0x3b/0x40
>> [ 4001.238456]  kswapd+0x98/0x300
>> [ 4001.238460]  ? wait_woken+0x80/0x80
>> [ 4001.238463]  kthread+0x114/0x130
>> [ 4001.238465]  ? balance_pgdat+0x450/0x450
>> [ 4001.238467]  ? kthread_park+0x80/0x80
>> [ 4001.238470]  ret_from_fork+0x1f/0x30
>
> Ok, so the memory compaction code has had a null pointer dereference
> which has killed kswapd. memory reclaim is going to have serious
> problems from this point on as kswapd does most of the reclaim.

Sorry, no.  OpenVPN opened a tun device at the same time (same
second), and udevd reacted to that, but that's it.

I also double-checked, and there haven't been any recent previous
occurrences of that crash.
