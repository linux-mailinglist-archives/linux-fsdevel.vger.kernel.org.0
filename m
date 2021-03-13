Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163BC339E5B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Mar 2021 14:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbhCMNts (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Mar 2021 08:49:48 -0500
Received: from tartarus.angband.pl ([51.83.246.204]:38454 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbhCMNtP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Mar 2021 08:49:15 -0500
X-Greylist: delayed 2120 seconds by postgrey-1.27 at vger.kernel.org; Sat, 13 Mar 2021 08:49:14 EST
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.94)
        (envelope-from <kilobyte@angband.pl>)
        id 1lL3yz-00GJp4-Ak; Sat, 13 Mar 2021 14:07:05 +0100
Date:   Sat, 13 Mar 2021 14:07:05 +0100
From:   Adam Borowski <kilobyte@angband.pl>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Neal Gompa <ngompa13@gmail.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        darrick.wong@oracle.com, jack@suse.cz, viro@zeniv.linux.org.uk,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com, david@fromorbit.com, hch@lst.de
Subject: Re: [PATCH v2 00/10] fsdax,xfs: Add reflink&dedupe support for fsdax
Message-ID: <YEy4+SPUvQkL44PQ@angband.pl>
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
 <CAEg-Je-OLidbfzHCJvY55x+-cOfiUxX8CJ1AeN8VxXAVuVyxKQ@mail.gmail.com>
 <20210310130227.GN3479805@casper.infradead.org>
 <20210310142159.kudk7q2ogp4yqn36@fiona>
 <20210310142643.GQ3479805@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210310142643.GQ3479805@casper.infradead.org>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 10, 2021 at 02:26:43PM +0000, Matthew Wilcox wrote:
> On Wed, Mar 10, 2021 at 08:21:59AM -0600, Goldwyn Rodrigues wrote:
> > DAX on btrfs has been attempted[1]. Of course, we could not
> 
> But why?  A completeness fetish?  I don't understand why you decided
> to do this work.

* xfs can shapshot only single files, btrfs entire subvolumes
* btrfs-send|receive
* enumeration of changed parts of a file


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ I've read an article about how lively happy music boosts
⣾⠁⢠⠒⠀⣿⡁ productivity.  You can read it, too, you just need the
⢿⡄⠘⠷⠚⠋⠀ right music while doing so.  I recommend Skepticism
⠈⠳⣄⠀⠀⠀⠀ (funeral doom metal).
