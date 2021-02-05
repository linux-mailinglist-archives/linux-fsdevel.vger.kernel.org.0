Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04899310B79
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 14:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbhBENAP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 08:00:15 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:65166 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbhBEM4w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 07:56:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612530901; x=1644066901;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=nPbJNNiKhDXUmDl63Oh5kvlKMraRDsXrcXttq+porWE=;
  b=gMBCqqbmaZK33xAIy85R5h79yDT1k01xvUyOksSXGyEeJYI+vO5zxela
   Lox05lToYJqvvfWcXzQCsIqYrThWOy5axh6r+DrCfLT++IUM3mtFS/FX8
   A4kMr934ubVNq7nVayiosTUGZMEiFDpVGDUVzukTIA0Dw0cyBA47Mbwjb
   rNemwCA9AsyHkBnHGXVzPps3rbbO97JqoM0M/lAPV+TxrR3XrAM6VGQqx
   1wNyV9zrYcewQ5HysxQHIoXptBgDAAP+DvDpVggRckKHopB8x9YiiGaHm
   zcDo1Ow7ngfLwunnT0D51Kh7zdtstpCoDxALAcO4eBb5m7gliqCvPHIrY
   A==;
IronPort-SDR: tI17OXoFy/ChcfG4FzTGtVhJeG7HgehImzg/C+omr3kL8lHkiZ14Q/9zqVhfp82eufKOdYU/ip
 e2aeoxUktNc19HRgKjF1iQ97k2QCRF+8B0lIKkoCaALhkD1lb59DHE/f8y+2SmbIlMb769aW3m
 BlprxsacsHa/QqThRAgLUiBbAnZdu61jPGIadJKsEw6CeOF23dRy+pnYPj+O3q4CUxTiQxLcXM
 7wD7ycPEH1jM+zuDBfr+lWdpH2MSXwn9m7Sx3nx1q9n4fUsl+rBJMw2yg1HyASV6iKNcIdU+Fc
 o7I=
X-IronPort-AV: E=Sophos;i="5.81,154,1610380800"; 
   d="scan'208";a="263336881"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2021 21:12:59 +0800
IronPort-SDR: TmxEXe4ReweihNG02w8BQYYdI6OaT6wQjQB5RyefxwzJff2IU/waXTJAsTvdrbQpruvcpmoWns
 oV4nH4LyLqCvrj/BIpGnWEbw5l+2xaEem6RWT8uCmnapi9y2+sMpM5ObtFpshOANQN7j9eyGF0
 1TVSPSH3AJBjSux3IfUTJSkmYguZiVKQm+8W085ZYzRkUd4HKI6uBZrzG53SFAKIdEMnDvB/bC
 cCHONTZSW8e7VCmQjzo7PatI//j68gBYWsbYpYvS9JHLK1RLSbTqfKWU+WYU4xrX3C9OfSKoFO
 6ejAyqDpPsh9KnatiQSgL02B
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 04:37:32 -0800
IronPort-SDR: CGPXaILYdaFGQb6SHnpVfqGic51mOVIIi4Uw7TTdaDvS6PRYBzJyFSaT8HrlNORSrAr59+GUji
 Qh0H4u8tqZHTI4GtTRE9Ga90TkX/dHAv3Zv5OYFzy7Y6Ios1rnq5CcjZoBkVBR3KsI/mal+ZSZ
 0hOT8mpw43frHzKiChAIBcVt+Nya/SHtKXyEAHfH1zTuGFp5WkQIr0tEU30vJrzOcG8EEOqjvt
 vtSCDn9ol1bnpHa48Vz9w/R/x6mxs7adUCRKouTzB9P2KFgEQk3Wr3dmZ4CjqgO+duVT23bmgG
 nEY=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO naota-xeon) ([10.84.71.79])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 04:55:27 -0800
Date:   Fri, 5 Feb 2021 21:55:26 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>, hare@suse.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v15 43/43] btrfs: zoned: deal with holes writing out
 tree-log pages
Message-ID: <20210205125526.4oeqd3utuho3b2hv@naota-xeon>
References: <cover.1612433345.git.naohiro.aota@wdc.com>
 <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
 <20210205092635.i6w3c7brawlv6pgs@naota-xeon>
 <CAL3q7H6REfruE-DSyiqZQ_Y0=HmXbiTbEC3d18Q7+3Z7pf5QzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H6REfruE-DSyiqZQ_Y0=HmXbiTbEC3d18Q7+3Z7pf5QzQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 05, 2021 at 11:49:05AM +0000, Filipe Manana wrote:
> On Fri, Feb 5, 2021 at 9:26 AM Naohiro Aota <naohiro.aota@wdc.com> wrote:
> >
> > Since the zoned filesystem requires sequential write out of metadata, we
> > cannot proceed with a hole in tree-log pages. When such a hole exists,
> > btree_write_cache_pages() will return -EAGAIN. We cannot wait for the range
> > to be written, because it will cause a deadlock. So, let's bail out to a
> > full commit in this case.
> >
> > Cc: Filipe Manana <fdmanana@gmail.com>
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > ---
> >  fs/btrfs/tree-log.c | 19 ++++++++++++++++++-
> >  1 file changed, 18 insertions(+), 1 deletion(-)
> >
> > This patch solves a regression introduced by fixing patch 40. I'm
> > sorry for the confusing patch numbering.
> 
> Hum, how does patch 40 can cause this?
> And is it before the fixup or after?

With pre-5.10 code base + zoned series at that time, it passed
xfstests without this patch.

With current code base + zoned series without the fixup for patch 40,
it also passed the tests, because we are mostly bailing out to a full
commit.

The fixup now stressed the new fsync code on zoned mode and revealed
an issue to have -EAGAIN from btrfs_write_marked_extents(). This error
happens when a concurrent transaction commit is writing a dirty extent
in this tree-log commit. This issue didn't occur previously because of
a longer critical section, I guess.

> 
> >
> > diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> > index 4e72794342c0..629e605cd62d 100644
> > --- a/fs/btrfs/tree-log.c
> > +++ b/fs/btrfs/tree-log.c
> > @@ -3120,6 +3120,14 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
> >          */
> >         blk_start_plug(&plug);
> >         ret = btrfs_write_marked_extents(fs_info, &log->dirty_log_pages, mark);
> > +       /*
> > +        * There is a hole writing out the extents and cannot proceed it on
> > +        * zoned filesystem, which require sequential writing. We can
> 
> require -> requires
> 
> > +        * ignore the error for now, since we don't wait for completion for
> > +        * now.
> 
> So why can we ignore the error for now?
> Why not just bail out here and mark the log for full commit? (without
> a transaction abort)

As described above, -EAGAIN happens when a concurrent process writes
out an extent buffer of this tree-log commit. This concurrent write
out will fill a hole for us, so the next write out might
succeed. Indeed we can bail out here, but I opted to try the next
write.

> > +        */
> > +       if (ret == -EAGAIN)
> > +               ret = 0;
> >         if (ret) {
> >                 blk_finish_plug(&plug);
> >                 btrfs_abort_transaction(trans, ret);
> > @@ -3229,7 +3237,16 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
> >                                          &log_root_tree->dirty_log_pages,
> >                                          EXTENT_DIRTY | EXTENT_NEW);
> >         blk_finish_plug(&plug);
> > -       if (ret) {
> > +       /*
> > +        * There is a hole in the extents, and failed to sequential write
> > +        * on zoned filesystem. We cannot wait for this write outs, sinc it
> 
> this -> these
> 
> > +        * cause a deadlock. Bail out to the full commit, instead.
> > +        */
> > +       if (ret == -EAGAIN) {
> > +               btrfs_wait_tree_log_extents(log, mark);
> > +               mutex_unlock(&log_root_tree->log_mutex);
> > +               goto out_wake_log_root;
> 
> Must also call btrfs_set_log_full_commit(trans);

Oops, I missed this one.

> Thanks.
> 
> > +       } else if (ret) {
> >                 btrfs_set_log_full_commit(trans);
> >                 btrfs_abort_transaction(trans, ret);
> >                 mutex_unlock(&log_root_tree->log_mutex);
> > --
> > 2.30.0
> >
> 
> 
> -- 
> Filipe David Manana,
> 
> “Whether you think you can, or you think you can't — you're right.”
