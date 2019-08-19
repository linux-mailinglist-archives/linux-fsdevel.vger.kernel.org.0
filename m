Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 153E794F08
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2019 22:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbfHSUbO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Aug 2019 16:31:14 -0400
Received: from sonic305-21.consmr.mail.ir2.yahoo.com ([77.238.177.83]:45705
        "EHLO sonic305-21.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728283AbfHSUbO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Aug 2019 16:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1566246671; bh=njtX/1gQOuZJ8x+D/bPD6qmpv4bUeLjYu756qxFnLJg=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=UqwoNxkOLsELf2H+0ricyNKFddngxwjkdxfdbFNGbRuaBKUhtU04Lc7m3P45n/w5Pu6PAqSzHrEcgd/vyB1ePEy27/islvx9c/+V+iIqAcFXR9gV3+LCE2FFiFMLLUT4H+DhnX+8ygpTEsAphpgR/v3bc6xuAh6PU1/VhHTzSl+p3EZwkxNsRu6WaNAjrI8VrPG5zDEIDUS7k0u815ynhHw4Bg5f9jwUMXbV9z6YdMS6SHEXe+C5R3u3vxUJoN4JZJN1yFXz3pKRlkBPHb8dZB2dwQ3qWtSxmIqpk2kQJ4gDxGGCRfFvQb3oqyMUO0dHPMAgzjZwPw5pGCKu9xKKNg==
X-YMail-OSG: ANSjFK4VM1nyU8pv7pcMdikj6jet_fSvLaDibf3PqVjzfWUTgu80tFsuoGSQxud
 M7oqnioTcbti4MlGoRnmFwdwqKTWkKvv36NBe0Ltm.diWfGY8d4PLmAwnDjsEJAol3SYYq.UqIX2
 i5NMSzHpUbvvLzgeqtoTe7EKwGOgQANvUAyaY.e.0t3jDCCeVT9LsdZjHi9Ln27DpI7twvVSK8Pz
 r.PZz9WHqAmf5q8Pge2i1o8Egl2ozVTWUnZ9vDpYDVIlozVQFOqI5WMq1Cvw_M96uw7sUJYPbIRo
 OMXJWeXQkwg6c2nevLBHqufLfJFZD2cfMfuHXzRmBcILnEPAl3E3bK79Irt_bnmCxtzoFegVE9Fu
 8XeHtM0S9oGc9j4LfqqZMRQ5S0OSy9.Hz.Ye8FC54EN3SzAezHeJmPtC._G.pHYqZk1Y1qEq_n56
 Z6Pt_ynvgdHfC846VBnp70zvAtrzXbMG8eAoQPqlfW3SRlmY4HvxoiCe2XRpoKp2AmX5wH5q0CgZ
 xuaI3UOQRgrxCEaYKPbSIzehnbwSKfLM9a27_BkFbfYxaWKJSHhpGK6NCA0g8fsxq6GtIX4QmrLm
 tMto4JS.u37PT7yQvi6kuL3WEima.VcqYF0HNXf6x7LYBGyCRsUVGsv3LQ0XVErwsxWBFyas1W4i
 uWvc2vjhtcAz3Fp3Z_AwGGg9Lxg6tzxmpHQa05qeOOEsH21wBvhegIRHal3RW.IKtQTsUwqcBfE5
 99H7QZBN6Agi6wXqw4jhRsRq6gJOGyTX8Nxwn6Jsh1tFKULnaduAW4Y1W5d8fAfjWoKtVNbPyvdV
 GE55bNHnGVJyEB1_IuRJHmFEFX8xrP4k4YcgvqKfnGp31Fvsb5xvWP8cOauVovDQMRXfGG6uzys2
 xS8B.RJ61Zx0WGo_aWYYKzK5WO1UC9_PTfYuXeP31yfA1MZoI_YeWqe60yRnzbQvb6OtNaGoBpaB
 rfHmvJgzKhiu8hP5xxTxSI9cRkWE.cmSOR50.zWw_YzwJf1ybPohs6_.lDP9ecKqzt.k1kMU1uSB
 2o3uFDYVEoVbYoSGam3N5Y9OH7.DTfOsXlP9CyxqcJvf2U3D8YUD8xtQWbsoAqc62WZeHPtrGcxK
 KdLuCS0A4sXTMGlTphsOuIuCs_JoWRVbMVl8zt7K0YbHOWUnt2ioP4z3qXXuZFzHoGMpKjvMJc_c
 9LMtARbJuRBdx9h_EHxkR8yNetLrCiA1eFFNg.tykfGyZYUGf1_pa6mBdkZjmOMJfrO7Bn2IXUKP
 0XacAltv0_hVPfsYeu3TkqngJxpWE
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ir2.yahoo.com with HTTP; Mon, 19 Aug 2019 20:31:11 +0000
Received: by smtp421.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 08b49598277d5feef885e8f543c497a0;
          Mon, 19 Aug 2019 20:31:07 +0000 (UTC)
Date:   Tue, 20 Aug 2019 04:30:56 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>, Chao Yu <yuchao0@huawei.com>,
        Dave Chinner <david@fromorbit.com>,
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
Message-ID: <20190819203051.GA10075@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <790210571.69061.1566120073465.JavaMail.zimbra@nod.at>
 <20190818151154.GA32157@mit.edu>
 <20190818155812.GB13230@infradead.org>
 <20190818161638.GE1118@sol.localdomain>
 <20190818162201.GA16269@infradead.org>
 <20190818172938.GA14413@sol.localdomain>
 <20190818174702.GA17633@infradead.org>
 <20190818181654.GA1617@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20190818201405.GA27398@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20190819160923.GG15198@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819160923.GG15198@magnolia>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Darrick,

On Mon, Aug 19, 2019 at 09:09:23AM -0700, Darrick J. Wong wrote:
> On Mon, Aug 19, 2019 at 04:14:11AM +0800, Gao Xiang wrote:
> > Hi all,
> > 
> > On Mon, Aug 19, 2019 at 02:16:55AM +0800, Gao Xiang wrote:
> > > Hi Hch,
> > > 
> > > On Sun, Aug 18, 2019 at 10:47:02AM -0700, Christoph Hellwig wrote:
> > > > On Sun, Aug 18, 2019 at 10:29:38AM -0700, Eric Biggers wrote:
> > > > > Not sure what you're even disagreeing with, as I *do* expect new filesystems to
> > > > > be held to a high standard, and to be written with the assumption that the
> > > > > on-disk data may be corrupted or malicious.  We just can't expect the bar to be
> > > > > so high (e.g. no bugs) that it's never been attained by *any* filesystem even
> > > > > after years/decades of active development.  If the developers were careful, the
> > > > > code generally looks robust, and they are willing to address such bugs as they
> > > > > are found, realistically that's as good as we can expect to get...
> > > >
> > > > Well, the impression I got from Richards quick look and the reply to it is
> > > > that there is very little attempt to validate the ondisk data structure
> > > > and there is absolutely no priority to do so.  Which is very different
> > > > from there is a bug or two here and there.
> > > 
> > > As my second reply to Richard, I didn't fuzz all the on-disk fields for EROFS.
> > > and as my reply to Richard / Greg, current EROFS is used on the top of dm-verity.
> > > 
> > > I cannot say how well EROFS will be performed on malformed images (and you can
> > > also find the bug richard pointed out is a miswritten break->continue by myself).
> > > 
> > > I posted the upstream EROFS post on July 4, 2019 and a month and a half later,
> > > no one can tell me (yes, thanks for kind people reply me about their suggestion)
> > > what we should do next (you can see these emails, I sent many times) to meet
> > > the minimal upstream requirements and rare people can even dip into my code.
> > > 
> > > That is all I want to say. I will work on autofuzz these days, and I want to
> > > know how to meet your requirements on this (you can tell us your standard,
> > > how well should we do).
> > > 
> > > OK, you don't reply to my post once, I have no idea how to get your first reply.
> > 
> > I have made a simple fuzzer to inject messy in inode metadata,
> > dir data, compressed indexes and super block,
> > https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/commit/?h=experimental-fuzzer
> > 
> > I am testing with some given dirs and the following script.
> > Does it look reasonable?
> > 
> > # !/bin/bash
> > 
> > mkdir -p mntdir
> > 
> > for ((i=0; i<1000; ++i)); do
> > 	mkfs/mkfs.erofs -F$i testdir_fsl.fuzz.img testdir_fsl > /dev/null 2>&1
> 
> mkfs fuzzes the image? Er....

Thanks for your reply.

First, This is just the first step of erofs fuzzer I wrote yesterday night...

> 
> Over in XFS land we have an xfs debugging tool (xfs_db) that knows how
> to dump (and write!) most every field of every metadata type.  This
> makes it fairly easy to write systematic level 0 fuzzing tests that
> check how well the filesystem reacts to garbage data (zeroing,
> randomizing, oneing, adding and subtracting small integers) in a field.
> (It also knows how to trash entire blocks.)

Actually, compared with XFS, EROFS has rather simple on-disk format.
What we inject one time is quite deterministic.

The first step just purposely writes some random fuzzed data to
the base inode metadata, compressed indexes, or dir data field
(one round one field) to make it validity and coverability.

> 
> You might want to write such a debugging tool for erofs so that you can
> take apart crashed images to get a better idea of what went wrong, and
> to write easy fuzzing tests.

Yes, we will do such a debugging tool of course. Actually Li Guifu is now
developping a erofs-fuse to support old linux versions or other OSes for
archiveing only use, we will base on that code to develop a better fuzzer
tool as well.

Thanks,
Gao Xiang

> 
> --D
> 
> > 	umount mntdir
> > 	mount -t erofs -o loop testdir_fsl.fuzz.img mntdir
> > 	for j in `find mntdir -type f`; do
> > 		md5sum $j > /dev/null
> > 	done
> > done
> > 
> > Thanks,
> > Gao Xiang
> > 
> > > 
> > > Thanks,
> > > Gao Xiang
> > > 
