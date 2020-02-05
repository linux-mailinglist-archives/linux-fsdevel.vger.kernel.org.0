Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1C41534D4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2020 16:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbgBEP5w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Feb 2020 10:57:52 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:53520 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbgBEP5v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Feb 2020 10:57:51 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015FrQpZ044982;
        Wed, 5 Feb 2020 15:57:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=5lbTEkKa/RVA5AT951KVvMm+geaBxj7YxSpcm2IbdQs=;
 b=b9RSVT9comObUwU0UMexlfK82XSrgAXYCW56fgjHzh/gFSJZlQueDwmgK9ZihWgGMm89
 vtx18KGx2k0VBCgsZ975AN+g56Do/DFk1QNmK+9Yr4jZ1bumyYZAkt4Mqfik2olL7jjy
 nnqN0fH6QLZBpNANSNJEyPWkkNz3pcl6URd1RCZShtdwZe3Xivx7nKMeGpXYvQcN5Tnh
 WrWHYBId90+N3WMdxHe+HkWNZhSA52iLGPTct8ZSll44oNum/ktMhjZ8Q3ki4xVssDFi
 H81bPLkoEgl26Qut6cxMqs/E/h3yRn+eHeKf8GhaiIRDcSZTM+vKV+hYziE+h6oXJIRM Eg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2019-08-05;
 bh=5lbTEkKa/RVA5AT951KVvMm+geaBxj7YxSpcm2IbdQs=;
 b=cCFYbSdE9r111wnxTEXvsV8UKXu7qPijn8DFdGtLhj+BIiO+vubNtwUrW3aIGJqaEvaq
 8vs9YUk2+lrfPb0hc95q/+QqteOW9nfprrYp6OnvJSKw+6ypw6Oz9f+Q+9aLZ675Ujje
 SdD2RyLZL8udlamNJfuBj3ykKlvOZ2lkYo77pu7GSo3EcHIbPwAydlRDJps4MwI7QxiH
 KGVM2DfN6zOwp3jV1IehW7bEi577hF9HFsaSO6ReOfZA4LsZr7RQvTG8V8JE1r1HV3l7
 7pJYZ4O7giEAikUF1Wx/y5NyYt9b2mNu1+pcBdWu4PPrCTCquLrRxYU43fh3+Sx7Of4+ pw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2xykbp3x9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Feb 2020 15:57:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015FsDZ9164574;
        Wed, 5 Feb 2020 15:57:38 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2xymut2429-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Feb 2020 15:57:38 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 015FvZeP001922;
        Wed, 5 Feb 2020 15:57:35 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Feb 2020 07:57:34 -0800
Date:   Wed, 5 Feb 2020 07:57:33 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, cmaiolino@redhat.com
Subject: Re: [RFCv2 0/4] ext4: bmap & fiemap conversion to use iomap
Message-ID: <20200205155733.GH6874@magnolia>
References: <cover.1580121790.git.riteshh@linux.ibm.com>
 <20200130160018.GC3445353@magnolia>
 <20200205124750.AE9DDA404D@d06av23.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200205124750.AE9DDA404D@d06av23.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002050123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002050123
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 05, 2020 at 06:17:44PM +0530, Ritesh Harjani wrote:
> 
> 
> On 1/30/20 11:04 PM, Ritesh Harjani wrote:
> > 
> > 
> > On 1/30/20 9:30 PM, Darrick J. Wong wrote:
> > > On Tue, Jan 28, 2020 at 03:48:24PM +0530, Ritesh Harjani wrote:
> > > > Hello All,
> > > > 
> > > > Background
> > > > ==========
> > > > There are RFCv2 patches to move ext4 bmap & fiemap calls to use
> > > > iomap APIs.
> > > > This reduces the users of ext4_get_block API and thus a step
> > > > towards getting
> > > > rid of buffer_heads from ext4. Also reduces a lot of code by
> > > > making use of
> > > > existing iomap_ops (except for xattr implementation).
> > > > 
> > > > Testing (done on ext4 master branch)
> > > > ========
> > > > 'xfstests -g auto' passes with default mkfs/mount configuration
> > > > (v/s which also pass with vanilla kernel without this patch). Except
> > > > generic/473 which also failes on XFS. This seems to be the test
> > > > case issue
> > > > since it expects the data in slightly different way as compared
> > > > to what iomap
> > > > returns.
> > > > Point 2.a below describes more about this.
> > > > 
> > > > Observations/Review required
> > > > ============================
> > > > 1. bmap related old v/s new method differences:-
> > > >     a. In case if addr > INT_MAX, it issues a warning and
> > > >        returns 0 as the block no. While earlier it used to return the
> > > >        truncated value with no warning.
> > > 
> > > Good...
> > > 
> > > >     b. block no. is only returned in case of iomap->type is
> > > > IOMAP_MAPPED,
> > > >        but not when iomap->type is IOMAP_UNWRITTEN. While with
> > > > previously
> > > >        we used to get block no. for both of above cases.
> > > 
> > > Assuming the only remaining usecase of bmap is to tell old bootloaders
> > > where to find vmlinuz blocks on disk, I don't see much reason to map
> > > unwritten blocks -- there's no data there, and if your bootloader writes
> > > to the filesystem(!) then you can't read whatever was written there
> > > anyway.
> > 
> > Yes, no objection there. Just wanted to get it reviewed.
> > 
> > 
> > > 
> > > Uh, can we put this ioctl on the deprecation list, please? :)
> > > 
> > > > 2. Fiemap related old v/s new method differences:-
> > > >     a. iomap_fiemap returns the disk extent information in exact
> > > >        correspondence with start of user requested logical
> > > > offset till the
> > > >        length requested by user. While in previous implementation the
> > > >        returned information used to give the complete extent
> > > > information if
> > > >        the range requested by user lies in between the extent mapping.
> > > 
> > > This is a topic of much disagreement.  The FIEMAP documentation says
> > > that the call must return data for the requested range, but *may* return
> > > a mapping that extends beyond the requested range.
> > > 
> > > XFS (and now iomap) only return data for the requested range, whereas
> > > ext4 has (had?) the behavior you describe.  generic/473 was an attempt
> > > to enforce the ext4 behavior across all filesystems, but I put it in my
> > > dead list and never run it.
> > > 
> > > So it's a behavioral change, but the new behavior isn't forbidden.
> > 
> > Sure, thanks.
> > 
> > > 
> > > >     b. iomap_fiemap adds the FIEMAP_EXTENT_LAST flag also at the last
> > > >        fiemap_extent mapping range requested by the user via fm_length (
> > > >        if that has a valid mapped extent on the disk).
> > > 
> > > That sounds like a bug.  _LAST is supposed to be set on the last extent
> > > in the file, not the last record in the queried dataset.
> > 
> > Thought so too, sure will spend some time to try fixing it.
> 
> Looked into this. I think below should fix our above reported problem with
> current iomap code.
> If no objection I will send send PATCHv3 with below fix as the first
> patch in the series.
> 
> diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
> index bccf305ea9ce..ee53991810d5 100644
> --- a/fs/iomap/fiemap.c
> +++ b/fs/iomap/fiemap.c
> @@ -100,7 +100,12 @@ int iomap_fiemap(struct inode *inode, struct
> fiemap_extent_info *fi,
>         }
> 
>         if (ctx.prev.type != IOMAP_HOLE) {
> -               ret = iomap_to_fiemap(fi, &ctx.prev, FIEMAP_EXTENT_LAST);
> +               u32 flags = 0;
> +               loff_t isize = i_size_read(inode);
> +
> +               if (ctx.prev.offset + ctx.prev.length >= isize)

What happens if ctx.prev actually is the last iomap in the file, but
isize extends beyond that?  e.g.,

# xfs_io -f -c 'pwrite 0 64k' /a
# truncate -s 100m /a
# filefrag -v /a

I think we need the fiemap variant of the iomap_begin functions to pass
a flag in the iomap that the fiemap implementation can pick up.

--D

> +                       flags |= FIEMAP_EXTENT_LAST;
> +               ret = iomap_to_fiemap(fi, &ctx.prev, flags);
>                 if (ret < 0)
>                         return ret;
>         }
> 
> 
> -ritesh
> 
> 
> > 
> > 
> > > 
> > > > But if the user
> > > >        requested for more fm_length which could not be mapped in
> > > > the last
> > > >        fiemap_extent, then the flag is not set.
> > > 
> > > Yes... if there were more extents to map than there was space in the map
> > > array, then _LAST should remain unset to encourage userspace to come
> > > back for the rest of the mappings.
> > > 
> > > (Unless maybe I'm misunderstanding here...)
> > > 
> > > > e.g. output for above differences 2.a & 2.b
> > > > ===========================================
> > > > create a file with below cmds.
> > > > 1. fallocate -o 0 -l 8K testfile.txt
> > > > 2. xfs_io -c "pwrite 8K 8K" testfile.txt
> > > > 3. check extent mapping:- xfs_io -c "fiemap -v" testfile.txt
> > > > 4. run this binary on with and without these patches:- ./a.out
> > > > (test_fiemap_diff.c) [4]
> > > > 
> > > > o/p of xfs_io -c "fiemap -v"
> > > > ============================================
> > > > With this patch on patched kernel:-
> > > > testfile.txt:
> > > >   EXT: FILE-OFFSET      BLOCK-RANGE          TOTAL FLAGS
> > > >     0: [0..15]:         122802736..122802751    16 0x800
> > > >     1: [16..31]:        122687536..122687551    16   0x1
> > > > 
> > > > without patch on vanilla kernel (no difference):-
> > > > testfile.txt:
> > > >   EXT: FILE-OFFSET      BLOCK-RANGE          TOTAL FLAGS
> > > >     0: [0..15]:         332211376..332211391    16 0x800
> > > >     1: [16..31]:        332722392..332722407    16   0x1
> > > > 
> > > > 
> > > > o/p of a.out without patch:-
> > > > ================
> > > > riteshh-> ./a.out
> > > > logical: [       0..      15] phys: 332211376..332211391 flags:
> > > > 0x800 tot: 16
> > > > (0) extent flag = 2048
> > > > 
> > > > o/p of a.out with patch (both point 2.a & 2.b could be seen)
> > > > =======================
> > > > riteshh-> ./a.out
> > > > logical: [       0..       7] phys: 122802736..122802743 flags:
> > > > 0x801 tot: 8
> > > > (0) extent flag = 2049
> > > > 
> > > > FYI - In test_fiemap_diff.c test we had
> > > > a. fm_extent_count = 1
> > > > b. fm_start = 0
> > > > c. fm_length = 4K
> > > > Whereas when we change fm_extent_count = 32, then we don't see
> > > > any difference.
> > > > 
> > > > e.g. output for above difference listed in point 1.b
> > > > ====================================================
> > > > 
> > > > o/p without patch (block no returned for unwritten block as well)
> > > > =========Testing IOCTL FIBMAP=========
> > > > File size = 16384, blkcnt = 4, blocksize = 4096
> > > >    0   41526422
> > > >    1   41526423
> > > >    2   41590299
> > > >    3   41590300
> > > > 
> > > > o/p with patch (0 returned for unwritten block)
> > > > =========Testing IOCTL FIBMAP=========
> > > > File size = 16384, blkcnt = 4, blocksize = 4096
> > > >    0          0          0
> > > >    1          0          0
> > > >    2   15335942      29953
> > > >    3   15335943      29953
> > > > 
> > > > 
> > > > Summary:-
> > > > ========
> > > > Due to some of the observational differences to user, listed above,
> > > > requesting to please help with a careful review in moving this to iomap.
> > > > Digging into some older threads, it looks like these differences
> > > > should be fine,
> > > > since the same tools have been working fine with XFS (which uses
> > > > iomap based
> > > > implementation) [1]
> > > > Also as Ted suggested in [3]: Fiemap & bmap spec could be made
> > > > based on the ext4
> > > > implementation. But since all the tools also work with xfs which
> > > > uses iomap
> > > > based fiemap, so we should be good there.
> > > 
> > > <nod> Thanks for the worked example output. :)
> > 
> > Thanks for the review. :)
> > 
> > ritesh
> > 
> > 
> > > 
> > > --D
> > > 
> > > > 
> > > > References of some previous discussions:
> > > > =======================================
> > > > [1]: https://www.spinics.net/lists/linux-fsdevel/msg128370.html
> > > > [2]: https://www.spinics.net/lists/linux-fsdevel/msg127675.html
> > > > [3]: https://www.spinics.net/lists/linux-fsdevel/msg128368.html
> > > > [4]: https://raw.githubusercontent.com/riteshharjani/LinuxStudy/master/tools/test_fiemap_diff.c
> > > > 
> > > > [RFCv1]: https://www.spinics.net/lists/linux-ext4/msg67077.html
> > > > 
> > > > 
> > > > Ritesh Harjani (4):
> > > >    ext4: Add IOMAP_F_MERGED for non-extent based mapping
> > > >    ext4: Optimize ext4_ext_precache for 0 depth
> > > >    ext4: Move ext4 bmap to use iomap infrastructure.
> > > >    ext4: Move ext4_fiemap to use iomap infrastructure
> > > > 
> > > >   fs/ext4/extents.c | 288 +++++++---------------------------------------
> > > >   fs/ext4/inline.c  |  41 -------
> > > >   fs/ext4/inode.c   |   6 +-
> > > >   3 files changed, 49 insertions(+), 286 deletions(-)
> > > > 
> > > > -- 
> > > > 2.21.0
> > > > 
> 
