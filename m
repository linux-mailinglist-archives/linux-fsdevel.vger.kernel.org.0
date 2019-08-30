Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B26E4A3687
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 14:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbfH3MS0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 08:18:26 -0400
Received: from sonic302-21.consmr.mail.gq1.yahoo.com ([98.137.68.147]:39315
        "EHLO sonic302-21.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727935AbfH3MSX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 08:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1567167501; bh=pJNmdYW4A3IZxLHwMlL3CbYdeyHCPUoPhyy4gROfL18=; h=Date:From:To:Subject:References:In-Reply-To:From:Subject; b=p2WSfTLFAYduPbFLvCGjVOey3q8rv3EnshLFdJa5Kqg5dhrJz3lS3HXDCW3ZtXx0S8nvxPJ+JPAoLDe8TpI8/Fls81YXUVwQpFVcLwFSEV13033yJ6FNfLg6kVApdFtHRc2pH6rFVBAr2pmwi0l6w5MGkZib7RsLUpjMf+hGqiXwsqqcNPUaTmTHsvOrKFuxdsxv/+t8KFhJXJeNSh2PLANk0jl2R6F3V1N2tadzxOYAoHEF4ZJaKY/jC/4BXqakzNkZCMXBIGnnRZR0d3ssIyP4pEf5f9gsOwq/wbx5nG4zBFSke+z9qVzhHE+CeIDS9U4tocLVTUsdDu+hBXZnxA==
X-YMail-OSG: 5O846uAVM1nZSuvIYdmUf.GpsVMgh0JWWWvuo8fuQiE9tFQZE3d_IfkfFhKKVRK
 1KPHI.9HNytY681diHE5BYSDR04gJvQWPSTN50g2l3fJ1u9vNlrGBe2UswxkGMl03g4Nqb723kGE
 tBej5k1XRm.d6Yur2QYUIBdl5S4Ts_JfapqPHyZ4HU4NLCmqycirhFpuYZdwjpid7671Ywt_5rgp
 dymKR0c7JvwwxbA_uwtdzGNQkfn6fedu0.qnG12rd.0b1dQCeWmQlAUQuWyTaifjj4LCLEWFkcCT
 hRniCYhQRwBqxQb3pURviuyCjgCHoMwd7G34pBvVw2Ts3GK7MVNoBYgfVFX3fEuHaTV2g.56mJfi
 .0bIcWDa0icL51hNApl7oSuEON.soD46dK0g4NmEUKDATV8KxJZQ04dnJILZuQn.DBLYTkDxiNNO
 AwVrE0ejYx5AmPHT_MhMmmvIvOZa2eZ0xseLLwjtJ.UUq.OdZECwCNZn0B9W1.c9uhrhIe1AQA_Q
 Awv1LboFGhaaor6houJpIvtee8HSu3Pdev1jCGdX1VBfMu53DnoxETT8qBrtGqvnUCbz42iWiM9m
 Q5mSVbJ.NhSdNwskUb.8oRsIeLxboV__Bro0St9g_0aj22QIupPQesD3uIwcdO_N7iht4gu0XhyK
 UibzUaKlPosUQn0fv4GTlCdXDFiVKUf51DVvXp3gUz5zJJNGwpGEPAejK2sJJHUJO7vMBYNNeg88
 JyLDOBl8ZREvsbqQF0m4MJn5LSK_IqM4Vfo_c7.7o6CcJZiYYgidBEhf77pDtl0nqwtu4KvDJXBa
 bAn0IH57T8TyKPn0N.izAQrtp9pIk_aq1.KrU8rZVnqCJalLI1eR902Q_6zB6QM9KZelD0WQF_2j
 c4BR8os0PJu6vz4H3howOskPmFCfKkcRHq8zWPnOzB_mR0t_lG98dYSdqn7mTDT6P8qvKEuEaBcp
 6XNMLDq8LoJZwYf_j2HGj4OJ.pLlAlGlCgGZS59ORqiNkI231hnKLvDqLz_7VEGDUbOqqevpSqXx
 zEPC42KUCju0SBWrsyduO2frlp5tsZKXhzz.LB50MFz31bZtIiYdgMvCppqZBReybAcOqTgoORiS
 kIrMKia8ThBFCS3NAphkJJMacbKztxVRmkitC8b9LB_cgkreRA1WZysacsCImITGKyGY84C0PaDm
 ukFVGCl9UfLZu0T3MEPD46av11c3cxMw3wvvX4WFMh3CuhaFRmq1dTfJ3qi9vUCUpgT7wDc.eLY_
 hN3XezaBvlQxEjIlz9jf5PPFKMTqbd0nP8DU-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Fri, 30 Aug 2019 12:18:21 +0000
Received: by smtp405.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b6c3fb5892809f707687e2f58172e2b8;
          Fri, 30 Aug 2019 12:18:19 +0000 (UTC)
Date:   Fri, 30 Aug 2019 20:18:07 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     dsterba@suse.cz, Joe Perches <joe@perches.com>,
        Gao Xiang <gaoxiang25@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>, Pavel Machek <pavel@denx.de>,
        Amir Goldstein <amir73il@gmail.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
Subject: Re: [PATCH v6 01/24] erofs: add on-disk layout
Message-ID: <20190830121806.GA20984@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190802125347.166018-2-gaoxiang25@huawei.com>
 <20190829095954.GB20598@infradead.org>
 <20190829103252.GA64893@architecture4>
 <67d6efbbc9ac6db23215660cb970b7ef29dc0c1d.camel@perches.com>
 <20190830120714.GN2752@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830120714.GN2752@twin.jikos.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,

On Fri, Aug 30, 2019 at 02:07:14PM +0200, David Sterba wrote:
> On Thu, Aug 29, 2019 at 08:58:17AM -0700, Joe Perches wrote:
> > On Thu, 2019-08-29 at 18:32 +0800, Gao Xiang wrote:
> > > Hi Christoph,
> > > 
> > > On Thu, Aug 29, 2019 at 02:59:54AM -0700, Christoph Hellwig wrote:
> > > > > --- /dev/null
> > > > > +++ b/fs/erofs/erofs_fs.h
> > > > > @@ -0,0 +1,316 @@
> > > > > +/* SPDX-License-Identifier: GPL-2.0-only OR Apache-2.0 */
> > > > > +/*
> > > > > + * linux/fs/erofs/erofs_fs.h
> > > > 
> > > > Please remove the pointless file names in the comment headers.
> > > 
> > > Already removed in the latest version.
> > > 
> > > > > +struct erofs_super_block {
> > > > > +/*  0 */__le32 magic;           /* in the little endian */
> > > > > +/*  4 */__le32 checksum;        /* crc32c(super_block) */
> > > > > +/*  8 */__le32 features;        /* (aka. feature_compat) */
> > > > > +/* 12 */__u8 blkszbits;         /* support block_size == PAGE_SIZE only */
> > > > 
> > > > Please remove all the byte offset comments.  That is something that can
> > > > easily be checked with gdb or pahole.
> > > 
> > > I have no idea the actual issue here.
> > > It will help all developpers better add fields or calculate
> > > these offsets in their mind, and with care.
> > > 
> > > Rather than they didn't run "gdb" or "pahole" and change it by mistake.
> > 
> > I think Christoph is not right here.
> > 
> > Using external tools for validation is extra work
> > when necessary for understanding the code.
> 
> The advantage of using the external tools that the information about
> offsets is provably correct ...
> 
> > The expected offset is somewhat valuable, but
> > perhaps the form is a bit off given the visual
> > run-in to the field types.
> > 
> > The extra work with this form is manipulating all
> > the offsets whenever a structure change occurs.
> 
> ... while this is error prone.

I will redo a full patchset and comments addressing
what Christoph all said yesterday.

Either form is fine with me for this case, let's remove
them instead.

Thanks,
Gao Xiang

> 
> > The comments might be better with a form more like:
> > 
> > struct erofs_super_block {	/* offset description */
> > 	__le32 magic;		/*   0  */
> > 	__le32 checksum;	/*   4  crc32c(super_block) */
> > 	__le32 features;	/*   8  (aka. feature_compat) */
> > 	__u8 blkszbits;		/*  12  support block_size == PAGE_SIZE only */

