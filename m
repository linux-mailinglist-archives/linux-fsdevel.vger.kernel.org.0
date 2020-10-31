Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8EA2A143A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Oct 2020 09:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgJaIvr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Oct 2020 04:51:47 -0400
Received: from verein.lst.de ([213.95.11.211]:56346 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726355AbgJaIvr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Oct 2020 04:51:47 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E7C4267373; Sat, 31 Oct 2020 09:51:42 +0100 (CET)
Date:   Sat, 31 Oct 2020 09:51:42 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        dsterba@suse.cz, aaptel@suse.com, willy@infradead.org,
        rdunlap@infradead.org, joe@perches.com, mark@harmstone.com,
        nborisov@suse.com, linux-ntfs-dev@lists.sourceforge.net,
        anton@tuxera.com
Subject: Re: [PATCH v11 00/10] NTFS read-write driver GPL implementation by
 Paragon Software
Message-ID: <20201031085142.GA5949@lst.de>
References: <20201030150239.3957156-1-almaz.alexandrovich@paragon-software.com> <20201030164122.vuao3avogggnk42q@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201030164122.vuao3avogggnk42q@pali>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 30, 2020 at 05:41:22PM +0100, Pali Rohár wrote:
> I would like to open discussion about two ntfs kernel drivers. Do we
> really need two drivers (one read only - current version and one
> read/write - this new version)?
> 
> What other people think?
> 
> I remember that Christoph (added to loop) had in past a good argument
> about old staging exfat driver (it had support also for fat32/vfat),
> that it would cause problems if two filesystem drivers would provide
> support for same filesystem.

Yes, we really should not have two drivers normally.  I think Konstantin
and Anton need to have a chat on how to go forard.  Without knowing the
details read-write support sounds like a killer feature we'd really want
if there aren't any code quality or other feature regression problems,
but I haven't had a chance to look at the code at all yet.
