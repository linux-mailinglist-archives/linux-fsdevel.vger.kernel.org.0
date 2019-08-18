Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0E59179F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2019 18:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfHRQDi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Aug 2019 12:03:38 -0400
Received: from sonic307-55.consmr.mail.gq1.yahoo.com ([98.137.64.31]:33805
        "EHLO sonic307-55.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726115AbfHRQDi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Aug 2019 12:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1566144216; bh=KCZWmvOcySDCLcuajvFSSm6vq3oz4vDFKctonx3Uly0=; h=Date:From:To:Cc:Subject:In-Reply-To:From:Subject; b=lCG1c4vE1gKQOxKOxOex8reEtGnpiQQqnplP8aIg3wtZ0/WGricrI3Yc2LilWbGT9Nzel0tG7aH47O0paeoAEaOOSCE2Q2I3ojWEO9XCc5JtpC8BvvXWvqS5Pa1kcc4JYxOrngXbJZBo8aCYyBcq7X11y41oeWRbL7NRlo80qFp8DWzdnJhdzIA0jNH7grtptp+oqrweh0uUh7Ujb0gXs7gHLx2WmC+t7jjRD/viTO/mzEv0bJCjHRdj0f/jy7FVMkaPQGe4MRUZPlI5FrbJNYowD/bRhbGl75U8hZCgzxaO7+9OagYDEY8LnUNtQ8QBiGIlpowfXk05Rjurik3eog==
X-YMail-OSG: ePvFpfkVM1m98rFbsI5Rj0dlqADMJy4kMVfD1SMCZdX8DU.zknkSp6hlE2ePLg1
 sKI1Bxa_6iLVAK0RaEW_10ALemwku.e6YLBxHXzmprh4Utqf0BMXvEyQ.KY7fD0GGN4_1PAk9LMW
 slXdAOTdlGv2MQSSt5oc5d_Ej5vUp45Z_3s6FpUXSycfVl6Y1xeX.SIdwrYkofaYDxwles4ie654
 aRjGmboRHFRrYj6EbiztHDLa5onYNfG6kGtqvQ.JFun3tIW6oakEbItcHLnNkUN9Co_.a6CdQR4g
 88rC8GEYmajQjvKcz51zxXCe0Naa3RU1Sd6PrER4L9VOkNnrZBxYqleo5AN972o7lREfDu1Dlf5F
 XxdU95XK2Z_MQATMsAlqwie164IBIlpTMedQfqo92A7FqYmWBOOLTSLUlZ2H5aSrpB5oNYw5TxmN
 W0rArwcolFKDac77Pb.0INCiu2DTL1Kx7l0qUf5kzrV8KTaFFOI48lZcBXuqSJaataVOGlKUf6w4
 vqWEUU_ntlZFH7Bnq0ajCM_FE0FFB3rzgU6cwD4WprdqcL5A2VVWDy1aYqWPkvrvTfsMiqgWAP1n
 3pSOy20xLORJbzUwgsqBrr1JarOSmiXq9F2Kz_8c2HBlP1DLuQ4AOEDQ8UosYznYoJodXjam9kEu
 3FEWXnV9OfoLd0hvzPAOLLlJAYyJ6Y0dxk4KNXyENezgzA31fmp7CZ5k7sIZwldL80vQFI.sAtGi
 WnMoXaxdZBES7ySvHyggFxi.aj2WxqmPzZzKhgexOpbwJX7fvP3oiKUf5JiyyxMwTZIXkkwjHETT
 udKwlHrd2kucI_c6BxAHxwQY9G1ibwvm4qzRtdMJG5_oicWWwqgy22w3_0qNG9ATvd.Qw1Fyz8EH
 eD0AUj8zR5hiFYt1EPeAsmZJx3.PSg1tnSZzFC979w61Lx2Jc7bAgU1QsbH4JYmSPfBnjC0g05Qo
 JKel8CP3q4xlQ8nxETn2QCVS09L0dMk9Fxd1GoW2suyeRB5KyKzEwhDLY1XldzUBeR2Nc_QKQ724
 4A8wZjzArJeTOKcmyp4azLmPf8RQk0OOCmasdrag4cS.gpofXSemp3A2rnrYQou_2y7SbppRbR9v
 fqkk9cfDnucVz_qgUVc.CnqLWKmEAEJqn2u4nGOpWHdQZ.FFx1mUXByLJ1o6s7PVkeVlUgpM8wuA
 N8D2jZ_019q0OWoHi4Pj5fG9waLOUv4zE8Ka73g6SOSAFmIfU4UGPC0fZn4AzdIVkGueq.WwAw8Z
 r38xjD_tRP5_kTX0vXPuKV.XeWbXV9CtnZgTWF2M-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.gq1.yahoo.com with HTTP; Sun, 18 Aug 2019 16:03:36 +0000
Received: by smtp414.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID fc05d2850e66fa74faca8e612efca976;
          Sun, 18 Aug 2019 16:03:34 +0000 (UTC)
Date:   Mon, 19 Aug 2019 00:03:11 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Richard Weinberger <richard@nod.at>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>, Chao Yu <yuchao0@huawei.com>,
        Dave Chinner <david@fromorbit.com>,
        David Sterba <dsterba@suse.cz>, Miao Xie <miaoxie@huawei.com>,
        devel <devel@driverdev.osuosl.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Darrick <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
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
Message-ID: <20190818160305.GA31588@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190818151154.GA32157@mit.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Ted,

On Sun, Aug 18, 2019 at 11:11:54AM -0400, Theodore Y. Ts'o wrote:
> On Sun, Aug 18, 2019 at 11:21:13AM +0200, Richard Weinberger wrote:
> > > Not to say that erofs shouldn't be worked on to fix these kinds of
> > > issues, just that it's not an unheard of thing to trust the disk image.
> > > Especially for the normal usage model of erofs, where the whole disk
> > > image is verfied before it is allowed to be mounted as part of the boot
> > > process.
> > 
> > For normal use I see no problem at all.
> > I fear distros that try to mount anything you plug into your USB.
> > 
> > At least SUSE already blacklists erofs:
> > https://github.com/openSUSE/suse-module-tools/blob/master/suse-module-tools.spec#L24
> 
> Note that of the mainstream file systems, ext4 and xfs don't guarantee
> that it's safe to blindly take maliciously provided file systems, such
> as those provided by a untrusted container, and mount it on a file
> system without problems.  As I recall, one of the XFS developers
> described file system fuzzing reports as a denial of service attack on
> the developers.  And on the ext4 side, while I try to address them, it
> is by no means considered a high priority work item, and I don't
> consider fixes of fuzzing reports to be worthy of coordinated
> disclosure or a high priority bug to fix.  (I have closed more bugs in
> this area than XFS has, although that may be that ext4 started with
> more file system format bugs than XFS; however given the time to first
> bug in 2017 using American Fuzzy Lop[1] being 5 seconds for btrfs, 10
> seconds for f2fs, 25 seconds for reiserfs, 4 minutes for ntfs, 1h45m
> for xfs, and 2h for ext4, that seems unlikely.)
> 
> [1] https://events.static.linuxfound.org/sites/events/files/slides/AFL%20filesystem%20fuzzing%2C%20Vault%202016_0.pdf
> 
> So holding a file system like EROFS to a higher standard than say,
> ext4, xfs, or btrfs hardly seems fair.  There seems to be a very
> unfortunate tendancy for us to hold new file systems to impossibly
> high standards, when in fact, adding a file system to Linux should
> not, in my opinion, be a remarkable event.  We have a huge number of
> them already, many of which are barely maintained and probably have
> far worse issues than file systems trying to get into the clubhouse.
> 
> If a file system is requesting core changes to the VM or block layers,
> sure, we should care about the interfaces.  But this nitpicking about
> whether or not a file system can be trusted in what I consider to be
> COMPLETELY INSANE CONTAINER USE CASES is really not fair.

Thanks for your kind reply and understanding...

Yes, EROFS is now still like a little baby, and what I can do is to write
more code to make it grown up... but I personally cannot write bug-free
code all the time (because sometimes I could be in a low mood...)

In the past year, we already adds many error handling path for corrupted
images and handles all BUG_ONs in a more proper way... we are doing our best...

Our team will continue focusing on all bug reports from external /
internal sources and fix them all in time. and for more wider scenerios,
I'd like to build an autofuzzer tools based on erofs-utils to make EROFS
more strong as one of the next step.

Thanks,
Gao Xiang


> 
> Cheers,
> 
> 						- Ted
