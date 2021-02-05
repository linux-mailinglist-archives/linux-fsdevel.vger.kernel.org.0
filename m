Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF76131149C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 23:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbhBEWIe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 17:08:34 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:64748 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbhBEOwM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:52:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612542657; x=1644078657;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=osl3Cr3Op+kKUp4lrjT4AnmetBsvXvl1ZR931UXyZoI=;
  b=qfJyr/Trf9kYz5YdWfzXpbBOXdKE0dwcrvwL/ChWP6HrcxEkFGb9joxp
   7ocnRTBv4q9VvwhU4A/2B0l75o8TqXniPwiTzX1JgKUbNLA/EZGP2zzkS
   f2NQaTWAi4EEU2eKERxk6XODfgfKMnBvtRByXhoSSpVCPta+K5v408a3a
   p/+BoQcI/LFIlb10f0DECbMQtIiZVp+lFXQhy7XafCf1l70wtZ9/82P/H
   22w86HIhgc9qx4+LL5ZYwNodWoNU18mSLN2ViGk0h74mVyFBeayQFxQVu
   PHYrED0p3NEsbJoVifZ4ZN3RYdVXtFMGsnbO97SdcR/iNoVkb3A5J1s2W
   A==;
IronPort-SDR: F/+dvg5lRPx7eKQyw23xS7HLpnE4FYXtZ8EtKpK6hDMn9HozjmEqH2vgb0lu97Ix4Sl3UFAmQ1
 2Y5aPo9/4mCfizxZqkjw+psT24qpmbiHCE3IhVvw4UL8fHlb/dVC5int1y51qqltL/HJADLepX
 JISuaBeHpfwWrGqYKEjkDe3YOd/VtEwV/6gdekP2e29lK6fp5Dfs4Y3h+3vftZo6cWM/lDca/R
 aoyKnMJ+pNYvQwiSwQTahcOuwbuFEVlQleFJkAv5TiAsMhdoX3FtzdHiuadu/phrpbc2Pc66tE
 jBw=
X-IronPort-AV: E=Sophos;i="5.81,155,1610380800"; 
   d="scan'208";a="163683696"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2021 22:46:51 +0800
IronPort-SDR: Wf+AO90Vr0IY9WX9NmyRLwNfdTYZTLDZqvnfZhUrAVoaWLBxJatcxbvFR7kYlih915ZmJRBm6O
 pcqDYS1XdSQ4MVh89MJY70ycaW9LNiG2zNuzv7/SoBWz6++ZwudbU83HeEl+9/3rQtm+uHMt1/
 /VT5NlcAcztJGloBj4lZGgMPerfJeI2Rtv5U78P9hoYygywJY8RwmPpxEnsE6fup/tPqv3aedg
 hvWVav63WYflmaxnEbjLCQERFU2AkTzRQ2IpEtKujm+m/pk+JEoQTOePOI8tlg9QBg3kLFNlAS
 7zLT7oKD7FNssi3nDK2NssPX
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 06:28:53 -0800
IronPort-SDR: NzR6jfQ2IjhxqcIMWPIVSNyPshTRZgggpaRxs+JW1x8sb94HA/I0C4giK2s6UbM6txuDwRPafO
 buJcE6fQgF/LCOWw9PNiNfPTFKSwQkUx4uo4V/5bk8DfPf2TVp4g1yQBeVO1Sain6K2w5rbDyc
 c+YxQRH9PxlnmQG4k/PqvmUq+70sMVqpXtdTbWmcV5kCbm7mHad3tDc7cjA93riQJJC4vRtgnI
 rYDnDyMKkNUUS6HZzyoFLCtHFcuE1fnD2W8flyIoRSDHz55zD3UuZF9L5FtT0MnjQmnMg47U/U
 McE=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO naota-xeon) ([10.84.71.79])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 06:46:50 -0800
Date:   Fri, 5 Feb 2021 23:46:48 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>, hare@suse.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v15 43/43] btrfs: zoned: deal with holes writing out
 tree-log pages
Message-ID: <20210205144648.lem3344kon2ncfli@naota-xeon>
References: <cover.1612433345.git.naohiro.aota@wdc.com>
 <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
 <20210205092635.i6w3c7brawlv6pgs@naota-xeon>
 <CAL3q7H6REfruE-DSyiqZQ_Y0=HmXbiTbEC3d18Q7+3Z7pf5QzQ@mail.gmail.com>
 <CAL3q7H7YkUAJ1h_hQzJ5C_ek5DD==V1rD1petxrs1aDru5j1+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H7YkUAJ1h_hQzJ5C_ek5DD==V1rD1petxrs1aDru5j1+A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 05, 2021 at 02:19:50PM +0000, Filipe Manana wrote:
> On Fri, Feb 5, 2021 at 11:49 AM Filipe Manana <fdmanana@gmail.com> wrote:
> >
> > On Fri, Feb 5, 2021 at 9:26 AM Naohiro Aota <naohiro.aota@wdc.com> wrote:
> > >
> > > Since the zoned filesystem requires sequential write out of metadata, we
> > > cannot proceed with a hole in tree-log pages. When such a hole exists,
> > > btree_write_cache_pages() will return -EAGAIN. We cannot wait for the range
> > > to be written, because it will cause a deadlock. So, let's bail out to a
> > > full commit in this case.
> > >
> > > Cc: Filipe Manana <fdmanana@gmail.com>
> > > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > > ---
> > >  fs/btrfs/tree-log.c | 19 ++++++++++++++++++-
> > >  1 file changed, 18 insertions(+), 1 deletion(-)
> > >
> > > This patch solves a regression introduced by fixing patch 40. I'm
> > > sorry for the confusing patch numbering.
> >
> > Hum, how does patch 40 can cause this?
> > And is it before the fixup or after?
> >
> > >
> > > diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> > > index 4e72794342c0..629e605cd62d 100644
> > > --- a/fs/btrfs/tree-log.c
> > > +++ b/fs/btrfs/tree-log.c
> > > @@ -3120,6 +3120,14 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
> > >          */
> > >         blk_start_plug(&plug);
> > >         ret = btrfs_write_marked_extents(fs_info, &log->dirty_log_pages, mark);
> > > +       /*
> > > +        * There is a hole writing out the extents and cannot proceed it on
> > > +        * zoned filesystem, which require sequential writing. We can
> >
> > require -> requires
> >
> > > +        * ignore the error for now, since we don't wait for completion for
> > > +        * now.
> >
> > So why can we ignore the error for now?
> > Why not just bail out here and mark the log for full commit? (without
> > a transaction abort)
> >
> > > +        */
> > > +       if (ret == -EAGAIN)
> > > +               ret = 0;
> 
> Thinking again about this, it would be safer, and self-documenting to
> check here that we are in zoned mode:
> 
> if (ret == -EAGAIN && is_zoned)
>     ret = 0;
> 
> Because if we start to get -EAGAIN here one day, from non-zoned code,
> we risk not writing out some extent buffer and getting a corrupt log,
> which may be very hard to find.
> With that additional check in place, we'll end up aborting the
> transaction with -EAGAIN and notice the problem much sooner.

Yeah, I agree.

I'll post a new version with the comments revised and using "if (ret
== -EAGAIN && btrfs_is_zoned(fs_info))".

> > >         if (ret) {
> > >                 blk_finish_plug(&plug);
> > >                 btrfs_abort_transaction(trans, ret);
> > > @@ -3229,7 +3237,16 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
> > >                                          &log_root_tree->dirty_log_pages,
> > >                                          EXTENT_DIRTY | EXTENT_NEW);
> > >         blk_finish_plug(&plug);
> > > -       if (ret) {
> > > +       /*
> > > +        * There is a hole in the extents, and failed to sequential write
> > > +        * on zoned filesystem. We cannot wait for this write outs, sinc it
> >
> > this -> these
> >
> > > +        * cause a deadlock. Bail out to the full commit, instead.
> > > +        */
> > > +       if (ret == -EAGAIN) {
> 
> I would add "&& is_zoned" here too.
> 
> Thanks.
>
> 
> > > +               btrfs_wait_tree_log_extents(log, mark);
> > > +               mutex_unlock(&log_root_tree->log_mutex);
> > > +               goto out_wake_log_root;
> >
> > Must also call btrfs_set_log_full_commit(trans);
> >
> > Thanks.
> >
> > > +       } else if (ret) {
> > >                 btrfs_set_log_full_commit(trans);
> > >                 btrfs_abort_transaction(trans, ret);
> > >                 mutex_unlock(&log_root_tree->log_mutex);
> > > --
> > > 2.30.0
> > >
> >
> >
> > --
> > Filipe David Manana,
> >
> > “Whether you think you can, or you think you can't — you're right.”
> 
> 
> 
> --
> Filipe David Manana,
> 
> “Whether you think you can, or you think you can't — you're right.”
