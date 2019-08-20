Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60CBC965C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 18:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729933AbfHTQAR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 12:00:17 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:42188 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727006AbfHTQAR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 12:00:17 -0400
Received: from callcc.thunk.org (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7KFx2Xh012879
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Aug 2019 11:59:06 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 4037D420843; Tue, 20 Aug 2019 11:56:23 -0400 (EDT)
Date:   Tue, 20 Aug 2019 11:56:23 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Gao Xiang <hsiangkao@aol.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        David Sterba <dsterba@suse.cz>, Miao Xie <miaoxie@huawei.com>,
        devel <devel@driverdev.osuosl.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-erofs <linux-erofs@lists.ozlabs.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>, Pavel Machek <pavel@denx.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] erofs: move erofs out of staging
Message-ID: <20190820155623.GA10232@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Chao Yu <yuchao0@huawei.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Gao Xiang <hsiangkao@aol.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        David Sterba <dsterba@suse.cz>, Miao Xie <miaoxie@huawei.com>,
        devel <devel@driverdev.osuosl.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-erofs <linux-erofs@lists.ozlabs.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Li Guifu <bluce.liguifu@huawei.com>, Fang Wei <fangwei1@huawei.com>,
        Pavel Machek <pavel@denx.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds <torvalds@linux-foundation.org>
References: <20190818161638.GE1118@sol.localdomain>
 <20190818162201.GA16269@infradead.org>
 <20190818172938.GA14413@sol.localdomain>
 <20190818174702.GA17633@infradead.org>
 <20190818181654.GA1617@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20190818201405.GA27398@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20190819160923.GG15198@magnolia>
 <20190819203051.GA10075@hsiangkao-HP-ZHAN-66-Pro-G1>
 <bdb91cbf-985b-5a2c-6019-560b79739431@gmx.com>
 <ad62636f-ef1b-739f-42cc-28d9d7ed86da@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad62636f-ef1b-739f-42cc-28d9d7ed86da@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 20, 2019 at 10:24:11AM +0800, Chao Yu wrote:
> Out of curiosity, it looks like every mainstream filesystem has its own
> fuzz/injection tool in their tool-set, if it's really such a generic
> requirement, why shouldn't there be a common tool to handle that, let specified
> filesystem fill the tool's callback to seek a node/block and supported fields
> can be fuzzed in inode. It can help to avoid redundant work whenever Linux
> welcomes a new filesystem....

The reason why there needs to be at least some file system specific
code for fuzz testing is because for efficiency's sake, you don't want
to fuzz every single bit in the file system, but just the ones which
are most interesting (e.g., the metadata blocks).  For file systems
which use checksum to protect against accidental corruption, the file
system fuzzer needs to also fix up the checksums (since you can be
sure malicious attackers will do this).

What you *can* do is to make the file system specific portion of the
work as small as possible.  Great work in this area is Professor Kim's
Janus[1][2] and Hydra[2] work.  (Hydra is about to be published at SOSP 19,
and was partially funded from a Google Faculty Research Work.)

[1] https://taesoo.kim/pubs/2019/xu:janus.pdf
[2] https://github.com/sslab-gatech/janus
[3] https://github.com/sslab-gatech/hydra

> > Personally speaking, debugging tool is way more important than a running
> > kernel module/fuse.
> > It's human trying to write the code, most of time is spent educating
> > code readers, thus debugging tool is way more important than dead cold code.

I personally find that having a tool like e2fsprogs' debugfs program
to be really handy.  It's useful for creating regression test images;
it's useful for debugging results from fuzzing systems like Janus;
it's useful for examining broken file systems extracted from busted
Android handsets during dogfood to root cause bugs which escaped
xfstests testing; etc.

Cheers,

						- Ted
