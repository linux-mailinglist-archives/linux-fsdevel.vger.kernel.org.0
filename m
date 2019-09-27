Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1541BC0112
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2019 10:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfI0IZO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Sep 2019 04:25:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:58578 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726118AbfI0IZO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Sep 2019 04:25:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D4486AECB;
        Fri, 27 Sep 2019 08:25:12 +0000 (UTC)
Date:   Fri, 27 Sep 2019 10:25:10 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Cyril Hrubis <chrubis@suse.cz>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: Re: copy_file_range() errno changes introduced in v5.3-rc1
Message-ID: <20190927082510.GA12604@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20190926155608.GC23296@dell5510>
 <20190926160432.GC9916@magnolia>
 <20190926161906.GD23296@dell5510>
 <CAOQ4uxixSy7Wp7yWYOMpp8R5tFXD2SWR9t3koYO4jBE-Wnt8sQ@mail.gmail.com>
 <20190926175700.GA12619@x230>
 <CAOQ4uxisQx1C7DXrcmq0gma4-bxbaPS5UNwpwnoDOtjYVypXwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxisQx1C7DXrcmq0gma4-bxbaPS5UNwpwnoDOtjYVypXwA@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Amir,

> > LTP hasn't defined yet any policy about changing errnos,
> > as it's probably best to check whether change was intentional
> > (like your obvious fixes) or not.


> IIUC, copy_file_range02 was written after v5.3 changes to verify that
> copy_file_range
> stays unbroken.
> As such, I would suggest that you check if kernel supports cross-fs copy, like
> copy_file_range01 does and if it doesn't, skip the test entirely.
> If some one ever backports cross-fs copy to any distro stable kernel, then one
> would better also backkport all of those API fixes, otherwise test will fail.
Thanks for a tip, I'll send a patch today.

> Thanks,
> Amir.

Kind regards,
Petr
