Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792761EA086
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jun 2020 11:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbgFAJJf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jun 2020 05:09:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:35866 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbgFAJJf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:09:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BFFBEAC51;
        Mon,  1 Jun 2020 09:09:34 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 56AF61E0948; Mon,  1 Jun 2020 11:09:31 +0200 (CEST)
Date:   Mon, 1 Jun 2020 11:09:31 +0200
From:   Jan Kara <jack@suse.cz>
To:     Martijn Coenen <maco@android.com>
Cc:     Jan Kara <jack@suse.cz>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, miklos@szeredi.hu, tj@kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@android.com
Subject: Re: Writeback bug causing writeback stalls
Message-ID: <20200601090931.GA3960@quack2.suse.cz>
References: <CAB0TPYGCOZmixbzrV80132X=V5TcyQwD6V7x-8PKg_BqCva8Og@mail.gmail.com>
 <20200522144100.GE14199@quack2.suse.cz>
 <CAB0TPYF+Nqd63Xf_JkuepSJV7CzndBw6_MUqcnjusy4ztX24hQ@mail.gmail.com>
 <20200522153615.GF14199@quack2.suse.cz>
 <CAB0TPYGJ6WkaKLoqQhsxa2FQ4s-jYKkDe1BDJ89CE_QUM_aBVw@mail.gmail.com>
 <20200525073140.GI14199@quack2.suse.cz>
 <CAB0TPYHVfkYyFYqp96-PfcP60PKRX6VqrfMHJPkG=UT2956EqQ@mail.gmail.com>
 <20200529152036.GA22885@quack2.suse.cz>
 <CAB0TPYFuT7Gp=8qBCGBKa3O0=hkUMTZsmhn3VqZuoKYM4bZOSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB0TPYFuT7Gp=8qBCGBKa3O0=hkUMTZsmhn3VqZuoKYM4bZOSw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 29-05-20 21:37:50, Martijn Coenen wrote:
> Hi Jan,
> 
> On Fri, May 29, 2020 at 5:20 PM Jan Kara <jack@suse.cz> wrote:
> > I understand. I have written a fix (attached). Currently its under testing
> > together with other cleanups. If everything works fine, I plan to submit
> > the patches on Monday.
> 
> Thanks a lot for the quick fix! I ran my usual way to reproduce the
> problem, and did not see it, so that's good! I do observe write speed
> dips - eg we usually sustain 180 MB/s on this device, but now it
> regularly dips down to 10 MB/s, then jumps back up again. That might
> be unrelated to your patch though, I will run more tests over the
> weekend and report back!

Thanks for testing! My test run has completed fine so I'll submit patches
for review. But I'm curious what's causing the dips in throughput in your
test...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
