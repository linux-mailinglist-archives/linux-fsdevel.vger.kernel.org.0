Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB342B220D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Nov 2020 18:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbgKMRVB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 12:21:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:58540 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbgKMRU7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:20:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 72459ABD9;
        Fri, 13 Nov 2020 17:21:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 643F2DA87A; Fri, 13 Nov 2020 18:19:28 +0100 (CET)
Date:   Fri, 13 Nov 2020 18:19:28 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Filipe Manana <fdmanana@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC] fs: Avoid to use lockdep information if it's turned off
Message-ID: <20201113171927.GG6756@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Filipe Manana <fdmanana@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@kernel.org>
References: <20201110013739.686731-1-boqun.feng@gmail.com>
 <20201110153327.GL6756@suse.cz>
 <20201111140121.GN6756@suse.cz>
 <20201112032212.GF3025@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112032212.GF3025@boqun-archlinux>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 12, 2020 at 11:22:12AM +0800, Boqun Feng wrote:
> For the "BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!" warning, do you see
> that every time when you run xfstests and don't see other lockdep
> splats? If so, that means we reach the limitation of number of lockdep
> hlock chains, and we should fix that.

It's not every time and depends on the release, eg. I found no reports
in a sample log for 5.7..5.9, while there are many for 5.2..5.6 and
5.10, every 2nd or 3rd run.

[    0.185150] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.186202] ... MAX_LOCK_DEPTH:          48
[    0.187286] ... MAX_LOCKDEP_KEYS:        8192
[    0.188404] ... CLASSHASH_SIZE:          4096
[    0.189519] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.190672] ... MAX_LOCKDEP_CHAINS:      65536
[    0.191814] ... CHAINHASH_SIZE:          32768
