Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09FE1A46B8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2019 03:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfIABhc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Aug 2019 21:37:32 -0400
Received: from sonic306-21.consmr.mail.gq1.yahoo.com ([98.137.68.84]:34853
        "EHLO sonic306-21.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725806AbfIABhc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Aug 2019 21:37:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1567301850; bh=h5kluZPg6YyzYPkg7FMpxAkd2+TEu8mj8Oli0gjbxxI=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=TpitVzhjwc6MLeoUX8KU8Q9Ll99RNBscvIx+uFUKZSkMAuTqZAiffc213/IxmxDOmt7ApHV31XCEDGN8Mnxe95KMUI00JsRrW2zUp9no0QkAL9jlEwyuSljh9HOyL8O1sG/2iweJKA7rZbxcQdWPqWGARreDlt6rmvh6NtRyHqyU/5eN1lprTgv4XPgkvpWjFdhX1ftMCRWqLmseWpKwf6paEFvOKyKU3rwPWVZ3MUJgAaqz4yaGs06hEBSvKiyvOoq8BdqeI2uKQuMZMy0jECBq4abVZFDUYE+1ak/U9In6HYBltGc3ElrFV7NVGOuAiqGn85DRZa02WZkRemjU4w==
X-YMail-OSG: ZIgHkTsVM1l.FexEeQECdoJ4yYg78ASs6dusnC1ouKz24a53THRr4H4_UMOujgG
 DdvjnX2M1bfH5rGKXD_KtMQ2dme4vPOly13MebourPvBgEIGL81xNsjTC9kxq6GehSi2T5B5Ift7
 0WwL6mBZLcH2_7nmiQsFcnj0v9_2hx4EPB8v3S1CoaNNkb8kIQkbVwwNvpkt3Hrrw8u6YIk7VF35
 GRRDr8RjB7tc5y1m1Gbrxldsgwa_9XmBR98yPuOIdJAwK47nECLqmlaqbG6Qd8bTwGkvKyO2QSa9
 aZmD1kew7I_Nh22wAr_tjlIVECUQpFdtTybHE3BfgaRJ3KL0.nb_0Gf0kS5stu.Uop3SP1doHMZN
 Q0d62jbilxUGVZmXQIVYneljxLVFLVELS7Z8hYVYl83zp2qsAipxPozT3GqSxrsq.lv4ZP_xQ7w5
 phqAXPTB3JgdJItyfYsU1s3B8oCzn8wB9Nd6jrafgBwkQwUSqmw6AZ4FqBqzGnnaunQ5_4qXpX0u
 0GWsGt4vcF1x61SzNRArrSzMOoKn7.0hN8th8AvmpMo251GDQLJyiRn6wNMaO2OGUwXYD2YfTALx
 F.X5Ze5AGXVI27GST1urU5CH8dzj0esKIkBOvJPOCA5V5NLgc2O0snD2X3Gfy67J6L0dRYI_CS2c
 BZd.Z0YZwcEsB2OOtCOWsnRTpZ8hsFAw3qptFcKu8QZsRRVUvGL_DAGvutQJNnAOFMV_sPC8SVid
 eOhDqlIzZj0OCahZWW1EBzLNAv8zcmsqcmtzQKh9SdFpFBBNlmSFaiPbGOyN6d56rjLFGXg_sLrk
 P1p0IsO8H28MguzCS7dsQMfRJiwprjBpIXKk_8VVK02XMIfcRXM9S_Zqcj.STs_E5.QbdzRdKvCa
 7XkeGnJRpAqFpBsPowGArIfKditknctkK1k04UK7yAX0YM2tTcULjtFvZGUgT5Wrs4Cq4VtWYH32
 s7URbUA0FzxFUfaRht1QUhlKArv2lMoGuwXo6zMyF6J8xj1L1YSQ33g2ZmBQXIlVP_bEoeIOCmkz
 8Lvom4CA7rboIiKHPE1Z0a_e16.Xbmm1CMmDr7Ze3qFYxKhDM3cyfit6xRFpmoCahbRu84jC0F28
 VwIAb4CM6pepF..Lnxg6desBjGIy87GafksQEBD_Z3qvIDYO.ojox..2QgFYhtIbRYaiFQQeNrJp
 EmbZCs0ErPWmD0xRrzWkNynH.5yBxDnELUFzRDDGGEMTb9hNdvq3CS_8ByyA0F02ahzpBWHh61f4
 zlViWVpRGCPFauj0khrq265Vk
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.gq1.yahoo.com with HTTP; Sun, 1 Sep 2019 01:37:30 +0000
Received: by smtp412.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 24369f664944151e8107c236514cbc63;
          Sun, 01 Sep 2019 01:37:26 +0000 (UTC)
Date:   Sun, 1 Sep 2019 09:37:19 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Valdis =?gbk?Q?Kl=A8=A5tnieks?= <valdis.kletnieks@vt.edu>,
        Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/staging/exfat - by default, prohibit mount of
 fat/vfat
Message-ID: <20190901013715.GA8243@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <245727.1567183359@turing-police>
 <20190830164503.GA12978@infradead.org>
 <267691.1567212516@turing-police>
 <20190831064616.GA13286@infradead.org>
 <295233.1567247121@turing-police>
 <20190901010721.GG7777@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=gbk
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190901010721.GG7777@dread.disaster.area>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dave,

On Sun, Sep 01, 2019 at 11:07:21AM +1000, Dave Chinner wrote:
> On Sat, Aug 31, 2019 at 06:25:21AM -0400, Valdis Kl??tnieks wrote:
> > On Fri, 30 Aug 2019 23:46:16 -0700, Christoph Hellwig said:
> > > Since when did Linux kernel submissions become "show me a better patch"
> > > to reject something obviously bad?
> > 
> > Well, do you even have a *suggestion* for a better idea?  Other than "just rip
> > it out"?  Keeping in mind that:
> > 
> > > As I said the right approach is to probably (pending comments from the
> > > actual fat maintainer) to merge exfat support into the existing fs/fat/
> > > codebase.  You obviously seem to disagree (and at the same time not).
> > 
> > At this point, there isn't any true consensus on whether that's the best
> > approach at the current.
> 
> Which, quite frankly, means it has been merged prematurely.
> 
> Valdis - the model for getting a new filesystem merged is the one
> taken by Orangefs. That was not merged through the staging tree,
> it was reviewd via patches to linux-fsdevel that were iterated far
> faster than the stable merge cycle allows, allowed all the cleanups
> to be done independently of the feature work needed, the structural
> changes we easy to discuss, quote, etc.

fs/orangefs/dir.c
 61 static int do_readdir(struct orangefs_inode_s *oi,
 62     struct orangefs_dir *od, struct dentry *dentry,
 63     struct orangefs_kernel_op_s *op)

131 static int parse_readdir(struct orangefs_dir *od,
132     struct orangefs_kernel_op_s *op)

189 static int fill_from_part(struct orangefs_dir_part *part,
190     struct dir_context *ctx)

fs/orangefs/file.c
 19 static int flush_racache(struct inode *inode)

 48 ssize_t wait_for_direct_io(enum ORANGEFS_io_type type, struct inode *inode,
 49     loff_t *offset, struct iov_iter *iter, size_t total_size,
 50     loff_t readahead_size, struct orangefs_write_range *wr, int *index_return)

fs/orangefs/super.c
304 
305 int fsid_key_table_initialize(void)
306 {
307         return 0;
308 }
309 
310 void fsid_key_table_finalize(void)
311 {
312 }

----> no prefix and empty functions

fs/orangefs/xattr.c
 31 static int is_reserved_key(const char *key, size_t size)
 40 static inline int convert_to_internal_xattr_flags(int setxattr_flags)
 54 static unsigned int xattr_key(const char *key)

> 
> These are the sorts of problems we are having with EROFS right now,
> even though it's been in staging for some time, and it's clear we
> are already having them with exfat - fundamental architecture issues
> have not yet been decided, and so there's likely major structural
> change yet to be done.
> 
> That's stuff that is much more easily done and reveiwed by patches
> on a mailing list. You don't need the code in the staging tree to
> get this sort of thing done and, really, having it already merged
> gets in the way of doing major structural change as it cannot be
> rapidly iterated independently of the kernel dev cycle...
> 
> So when Christoph say:
> 
> > "Just rip it out"
> 
> what he is really saying is that Greg has jumped the jump and is -
> yet again - fucking over filesystem developers because he's
> taken the review process for a new filesystem out of hands _yet
> again_.
> 
> He did this with POHMELFS, then Lustre, then EROFS - they all got
> merged into stable over the objections of senior filesystem
> developers.  The first two were an utter disaster, the latter is
> rapidly turning into one.

I don't know what "rapidly turning" means:
 This round I am working on all suggestions from fs developers;
 and I have been addressing what Christoph said for days, he hope that
 all functions should be prefixed with "erofs_" and I am doing.

That is all.

Thanks,
Gao Xiang
