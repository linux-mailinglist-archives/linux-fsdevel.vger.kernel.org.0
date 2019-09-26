Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 915B1BF68C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 18:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfIZQTK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Sep 2019 12:19:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:44740 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727239AbfIZQTK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Sep 2019 12:19:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 63CB4B173;
        Thu, 26 Sep 2019 16:19:08 +0000 (UTC)
Date:   Thu, 26 Sep 2019 18:19:06 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <dchinner@redhat.com>,
        Cyril Hrubis <chrubis@suse.cz>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Subject: Re: copy_file_range() errno changes introduced in v5.3-rc1
Message-ID: <20190926161906.GD23296@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20190926155608.GC23296@dell5510>
 <20190926160432.GC9916@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926160432.GC9916@magnolia>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Darrick,

> On Thu, Sep 26, 2019 at 05:56:08PM +0200, Petr Vorel wrote:
> > Hi Amir,

> > I'm going to fix LTP test copy_file_range02 before upcoming LTP release.
> > There are some returning errno changes introduced in v5.3-rc1, part of commit 40f06c799539
> > ("Merge tag 'copy-file-range-fixes-1' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux").
> > These changes looks pretty obvious as wanted, but can you please confirm it they were intentional?

> > * 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices") started to return -EXDEV.
> > * 96e6e8f4a68d ("vfs: add missing checks to copy_file_range") started to return -EPERM, -ETXTBSY, -EOVERFLOW.

> I'm not Amir, but by my recollection, yes, those are intentional. :)
Thanks for a quick confirmation.

> --D

Kind regards,
Petr
