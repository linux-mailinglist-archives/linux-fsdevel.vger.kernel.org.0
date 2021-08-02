Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD913DD435
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Aug 2021 12:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbhHBKqD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Aug 2021 06:46:03 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44158 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbhHBKqD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Aug 2021 06:46:03 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CBE8A1FF6F;
        Mon,  2 Aug 2021 10:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627901152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VxFAlZRWfHE8zP8qOh62DFtxrnipd396WDxPmF91GQE=;
        b=udrXl7FqvE6M9vDvdJm1BLdKineY5Z+XwdtCOraHx5bLsG+m8S0DHHa4wmqZ/oYGoco40w
        mv8v+/9htuPIMmH9tUXIHjhuofYWeig6EkBN5DXEdwYZRfrNFG42Zb5rw/7dfULgUV4ibk
        9TanxJ7ZRbxcla/cfJOR9W7NlyRTBlM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627901152;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VxFAlZRWfHE8zP8qOh62DFtxrnipd396WDxPmF91GQE=;
        b=YQX27ccuwy7LpoziV3ARKuYHpgktNzmSz4QO8dAUBCLu6p8epOLDK8/IOzcbLFUi5Y5brt
        hkwFg0kACsvDs8Aw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 7A2D3A3BB3;
        Mon,  2 Aug 2021 10:45:52 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6471D1F2C91; Mon,  2 Aug 2021 12:45:49 +0200 (CEST)
Date:   Mon, 2 Aug 2021 12:45:49 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, Jan Kara <jack@suse.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com,
        Mel Gorman <mgorman@techsingularity.net>,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [fsnotify] 4c40d6efc8: unixbench.score -3.3% regression
Message-ID: <20210802104549.GA28745@quack2.suse.cz>
References: <20210720155944.1447086-9-krisman@collabora.com>
 <20210731063818.GB18773@xsang-OptiPlex-9020>
 <CAOQ4uxgtke-jK3a1SxowdEhObw8rDuUXB-DSGCr-M1uVMWarww@mail.gmail.com>
 <87lf5mi7mv.fsf@collabora.com>
 <CAOQ4uxhsb_iVBTWVVreS7eSRCUapFFcyhXwnekaqptbMJSm1KQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhsb_iVBTWVVreS7eSRCUapFFcyhXwnekaqptbMJSm1KQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 01-08-21 09:32:40, Amir Goldstein wrote:
> On Sat, Jul 31, 2021 at 10:51 PM Gabriel Krisman Bertazi
> <krisman@collabora.com> wrote:
> >
> > Amir Goldstein <amir73il@gmail.com> writes:
> >
> > > On Sat, Jul 31, 2021 at 9:20 AM kernel test robot <oliver.sang@intel.com> wrote:
> > >>
> > >>
> > >>
> > >> Greeting,
> > >>
> > >> FYI, we noticed a -3.3% regression of unixbench.score due to commit:
> > >>
> > >>
> > >> commit: 4c40d6efc8b22b88a45c335ffd6d25b55d769f5b ("[PATCH v4 08/16] fsnotify: pass arguments of fsnotify() in struct fsnotify_event_info")
> > >> url: https://github.com/0day-ci/linux/commits/Gabriel-Krisman-Bertazi/File-system-wide-monitoring/20210721-001444
> > >> base: https://git.kernel.org/cgit/linux/kernel/git/jack/linux-fs.git fsnotify
> > >>
> > >> in testcase: unixbench
> > >> on test machine: 96 threads 2 sockets Intel(R) Xeon(R) CPU @ 2.30GHz with 128G memory
> > >> with following parameters:
> > >>
> > >>         runtime: 300s
> > >>         nr_task: 1
> > >>         test: pipe
> > >>         cpufreq_governor: performance
> > >>         ucode: 0x4003006
> > >>
> > >> test-description: UnixBench is the original BYTE UNIX benchmark suite aims to test performance of Unix-like system.
> > >> test-url: https://github.com/kdlucas/byte-unixbench
> > >>
> > >> In addition to that, the commit also has significant impact on the following tests:
> > >>
> > >> +------------------+-------------------------------------------------------------------------------------+
> > >> | testcase: change | will-it-scale: will-it-scale.per_thread_ops -1.3% regression                        |
> > >> | test machine     | 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory |
> > >> | test parameters  | cpufreq_governor=performance                                                        |
> > >> |                  | mode=thread                                                                         |
> > >> |                  | nr_task=100%                                                                        |
> > >> |                  | test=eventfd1                                                                       |
> > >> |                  | ucode=0x5003006                                                                     |
> > >> +------------------+-------------------------------------------------------------------------------------+
> > >>
> > >>
> > >> If you fix the issue, kindly add following tag
> > >> Reported-by: kernel test robot <oliver.sang@intel.com>
> > >>
> > >
> > > Gabriel,
> > >
> > > It looks like my change throws away much of the performance gain for
> > > small IO on pipes without any watches that was achieved by commit
> > > 71d734103edf ("fsnotify: Rearrange fast path to minimise overhead
> > > when there is no watcher").
> > >
> > > I think the way to fix it is to lift the optimization in __fsnotify()
> > > to the fsnotify_parent() inline wrapper as Mel considered doing
> > > but was not sure it was worth the effort at the time.
> > >
> > > It's not completely trivial. I think it requires setting a flag
> > > MNT_FSNOTIFY_WATCHED when there are watches on the
> > > vfsmount. I will look into it.
> >
> > Amir,
> >
> > Since this patch is a clean up, would you mind if I drop it from my
> > series and base my work on top of mainline? Eventually, we can rebase
> > this patch, when the performance issue is addressed.
> >
> > I ask because I'm about to send a v5 and I'm not sure if I should wait
> > to have this fixed.
> 
> I guess you mean that you want to add the sb to fsnotify() args list.
> I don't mind, it's up to Jan.

Yeah, no problem with that from my side either.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
