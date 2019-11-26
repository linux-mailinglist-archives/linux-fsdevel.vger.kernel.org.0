Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA05F10A0D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2019 15:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfKZO6F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Nov 2019 09:58:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:51864 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726049AbfKZO6F (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Nov 2019 09:58:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7FB4EAC28;
        Tue, 26 Nov 2019 14:58:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DA3B0DA898; Tue, 26 Nov 2019 15:58:01 +0100 (CET)
Date:   Tue, 26 Nov 2019 15:58:01 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        David Sterba <dsterba@suse.cz>
Subject: Re: btrfs/058 deadlock with lseek
Message-ID: <20191126145801.GF2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
References: <3310d598-bd2f-6024-e5ac-c1c6080c0fd7@gmx.com>
 <b99618bc-1215-6c2d-5bdb-e43cb79cbd8e@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b99618bc-1215-6c2d-5bdb-e43cb79cbd8e@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 26, 2019 at 05:56:27PM +0800, Qu Wenruo wrote:
> On 2019/11/26 下午4:17, Qu Wenruo wrote:
> > Just got a reproducible error in btrfs/058.
> > The backtrace is completely in VFS territory, not btrfs related lock at all:
> 
> With the help of Nikolay and Johannes, the offending commit is pinned
> down to 0be0ee71816b ("vfs: properly and reliably lock f_pos in
> fdget_pos()"), and Linus will soon revert it.
> 
> Not a big deal, but testers would have a much easier life using David's
> misc-5.5 (still based on v5.4-rc).
> 
> And to David, would you please keep your misc-5.5 branch until the
> offending patch get reverted?

misc-5.5 will not rebase, it's the branch that gets pulled to master.
I won't rebase misc-next until rc1 at least and will rebase only after I
see that tests pass. During merge window lots of things are in flux so
breakage is expected so we need a development base for testing.
