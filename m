Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA53241C0A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 16:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbgHKODP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 10:03:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:53632 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728516AbgHKODP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 10:03:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 92157B0A5;
        Tue, 11 Aug 2020 14:03:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5B948DA83C; Tue, 11 Aug 2020 16:02:12 +0200 (CEST)
Date:   Tue, 11 Aug 2020 16:02:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: btrfs crash in kobject_del while running xfstest
Message-ID: <20200811140211.GQ2026@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, John Hubbard <jhubbard@nvidia.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <200e5b49-5c51-bbe5-de93-c6bd6339bb7f@nvidia.com>
 <2a3eb48d-6ca1-61c6-20cf-ba2fbda21f45@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a3eb48d-6ca1-61c6-20cf-ba2fbda21f45@nvidia.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 11, 2020 at 04:19:47AM -0700, John Hubbard wrote:
> Somehow the copy-paste of Chris Mason's name failed (user error
> on my end), sorry about that Chris!
> 
> On 8/11/20 4:17 AM, John Hubbard wrote:
> > Hi,
> > 
> > Here's an early warning of a possible problem.
> > 
> > I'm seeing a new btrfs crash when running xfstests, as of
> > 00e4db51259a5f936fec1424b884f029479d3981 ("Merge tag
> > 'perf-tools-2020-08-10' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux") in linux.git.
> > 
> > This doesn't crash in v5.8, so I attempted to bisect, but ended up with
> > the net-next merge commit as the offending one: commit
> > 47ec5303d73ea344e84f46660fff693c57641386 ("Merge
> > git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next"), which
> > doesn't really help because it's 2088 files changed, of course.

Thanks for the report, it's already known and patch is on the way to
Linus' tree (ETA before rc1). You can apply
https://lore.kernel.org/linux-btrfs/20200803062011.17291-1-wqu@suse.com/
locally.
