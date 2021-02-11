Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51CE318E5A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Feb 2021 16:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbhBKPZB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Feb 2021 10:25:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:49290 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230382AbhBKPWN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Feb 2021 10:22:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 62B6FACBF;
        Thu, 11 Feb 2021 15:20:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 32C3EDA6E9; Thu, 11 Feb 2021 16:19:01 +0100 (CET)
Date:   Thu, 11 Feb 2021 16:19:01 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v15 00/42] btrfs: zoned block device support
Message-ID: <20210211151901.GD1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <cover.1612433345.git.naohiro.aota@wdc.com>
 <20210210195829.GW1993@twin.jikos.cz>
 <SN4PR0401MB35987EE941FA59E2ECB8D7269B8C9@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB35987EE941FA59E2ECB8D7269B8C9@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 11, 2021 at 09:58:09AM +0000, Johannes Thumshirn wrote:
> On 10/02/2021 21:02, David Sterba wrote:
> >> This series implements superblock log writing. It uses two zones as a
> >> circular buffer to write updated superblocks. Once the first zone is filled
> >> up, start writing into the second zone. The first zone will be reset once
> >> both zones are filled. We can determine the postion of the latest
> >> superblock by reading the write pointer information from a device.
> > 
> > About that, in this patchset it's still leaving superblock at the fixed
> > zone number while we want it at a fixed location, spanning 2 zones
> > regardless of their size.
> 
> We'll always need 2 zones or otherwise we won't be powercut safe.

Yes we do, that hasn't changed.
