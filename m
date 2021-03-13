Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E05A833A193
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Mar 2021 23:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbhCMWID (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Mar 2021 17:08:03 -0500
Received: from tartarus.angband.pl ([51.83.246.204]:41154 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbhCMWHh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Mar 2021 17:07:37 -0500
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.94)
        (envelope-from <kilobyte@angband.pl>)
        id 1lLCJc-00GN3W-3k; Sat, 13 Mar 2021 23:00:56 +0100
Date:   Sat, 13 Mar 2021 23:00:56 +0100
From:   Adam Borowski <kilobyte@angband.pl>
To:     Neal Gompa <ngompa13@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com, david <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 00/10] fsdax,xfs: Add reflink&dedupe support for fsdax
Message-ID: <YE02GArtVnwEeJML@angband.pl>
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
 <CAEg-Je-OLidbfzHCJvY55x+-cOfiUxX8CJ1AeN8VxXAVuVyxKQ@mail.gmail.com>
 <20210310130227.GN3479805@casper.infradead.org>
 <20210310142159.kudk7q2ogp4yqn36@fiona>
 <20210310142643.GQ3479805@casper.infradead.org>
 <YEy4+SPUvQkL44PQ@angband.pl>
 <CAEg-Je-JCW5xa6w5Z9n7+UNnLju251SmqnXiReA2v41fFaXAtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEg-Je-JCW5xa6w5Z9n7+UNnLju251SmqnXiReA2v41fFaXAtw@mail.gmail.com>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 13, 2021 at 11:24:00AM -0500, Neal Gompa wrote:
> On Sat, Mar 13, 2021 at 8:09 AM Adam Borowski <kilobyte@angband.pl> wrote:
> >
> > On Wed, Mar 10, 2021 at 02:26:43PM +0000, Matthew Wilcox wrote:
> > > On Wed, Mar 10, 2021 at 08:21:59AM -0600, Goldwyn Rodrigues wrote:
> > > > DAX on btrfs has been attempted[1]. Of course, we could not
> > >
> > > But why?  A completeness fetish?  I don't understand why you decided
> > > to do this work.
> >
> > * xfs can shapshot only single files, btrfs entire subvolumes
> > * btrfs-send|receive
> > * enumeration of changed parts of a file
> 
> XFS cannot do snapshots since it lacks metadata COW. XFS reflinking is
> primarily for space efficiency.

A reflink is a single-file snapshot.

My work team really wants this very patchset -- reflinks on DAX allow
backups and/or checkpointing, without stopping the world (there's a single
file, "pool", here).

Besides, you can still get poor-man's whole-subvolume(/directory)
snapshots by manually walking the tree and reflinking everything.
That's not atomic -- but rsync isn't atomic either.  That's enough for
eg. dnf/dpkg purposes.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀
⣾⠁⢰⠒⠀⣿⡁
⢿⡄⠘⠷⠚⠋⠀ NADIE anticipa la inquisición de españa!
⠈⠳⣄⠀⠀⠀⠀
