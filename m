Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A1F294BAE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Oct 2020 13:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441941AbgJULQE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Oct 2020 07:16:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:36616 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441936AbgJULQB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Oct 2020 07:16:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5F6BCB27D;
        Wed, 21 Oct 2020 11:15:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A14E4DA7C5; Wed, 21 Oct 2020 13:14:28 +0200 (CEST)
Date:   Wed, 21 Oct 2020 13:14:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: UBSAN: shift-out-of-bounds in get_init_ra_size()
Message-ID: <20201021111428.GC6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Matthew Wilcox <willy@infradead.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <SN4PR0401MB3598C9C5B4D7ED74E79F28A09B1C0@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB3598C9C5B4D7ED74E79F28A09B1C0@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 21, 2020 at 10:57:02AM +0000, Johannes Thumshirn wrote:
> Hi Willy,
> 
> I've encountered a USBSN [1] splat when running xfstests (hit it with generic/091)
> on the latest iteration of our btrfs-zoned patchset.

This first showed up with btrfs' dio-iomap switch
(https://github.com/btrfs/fstests/issues/5) so it's not related to the
zoned patches.
