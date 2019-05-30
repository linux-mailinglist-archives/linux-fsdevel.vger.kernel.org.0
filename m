Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAFF2FFC3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2019 17:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfE3P7d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 May 2019 11:59:33 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44710 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfE3P7c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 May 2019 11:59:32 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4UFwRdT062994;
        Thu, 30 May 2019 15:58:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=uc+UXzmyPv/D6QTYV3WBqRHnc34bk0BoVJelHBRrxEY=;
 b=g4SFiEg7+6ARWlAP18PYeQaguCtnJ1oiJ1ZUQMZVzGJjc1+xIKWGNTpLdW7vd6zBR8ro
 p4daXSHTZqiPW3zaZzWOfFVGCGcJe+UQQMMxfJ43dSDYm6EQfkDZupn8Ppoq358X+CYw
 93itavr5Nv69+cOmLvyEb/NxR3xVanHek3GgNcnYNKk2uZOueOL9pPzLCySE3z4Qm7AL
 Wzd8ZtKoJsT9vrThAWtKHj+XtEMGkpJPzBUzFhhB+dCYnyQgCTYl0OPgMBlrEM7r1I7Z
 hwHunBmKqbLJhzbRE+Mrtxcl1w/gWc544wmMRRZaxd5RUNvxMCVRaBM/NnkS7XGQWi2d 3A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2spxbqgyve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 15:58:56 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4UFwFx1146681;
        Thu, 30 May 2019 15:58:56 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2srbdy34a3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 15:58:56 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4UFwtrm015760;
        Thu, 30 May 2019 15:58:55 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 May 2019 08:58:54 -0700
Date:   Thu, 30 May 2019 08:58:51 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     sfrench@samba.org, anna.schumaker@netapp.com,
        trond.myklebust@hammerspace.com, fengxiaoli0714@gmail.com
Cc:     fstests@vger.kernel.org, Murphy Zhou <xzhou@redhat.com>,
        linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: NFS & CIFS support dedupe now?? Was: Re: [PATCH] generic/517: notrun
 on NFS due to unaligned dedupe in test
Message-ID: <20190530155851.GB5383@magnolia>
References: <20190530094147.14512-1-xzhou@redhat.com>
 <20190530152606.GA5383@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530152606.GA5383@magnolia>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905300113
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905300113
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi everyone,

Murphy Zhou sent a patch to generic/517 in fstests to fix a dedupe
failure he was seeing on NFS:

On Thu, May 30, 2019 at 05:41:47PM +0800, Murphy Zhou wrote:
> NFSv4.2 could pass _require_scratch_dedupe, since the test offset and
> size are aligned, while generic/517 is performing unaligned dedupe.
> NFS does not support unaligned dedupe now, returns EINVAL.
> 
> Signed-off-by: Murphy Zhou <xzhou@redhat.com>
> ---
>  tests/generic/517 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/generic/517 b/tests/generic/517
> index 601bb24e..23665782 100755
> --- a/tests/generic/517
> +++ b/tests/generic/517
> @@ -30,6 +30,7 @@ _cleanup()
>  _supported_fs generic
>  _supported_os Linux
>  _require_scratch_dedupe
> +$FSTYP == "nfs"  && _notrun "NFS can't handle unaligned deduplication"

I was surprised to see a dedupe fix for NFS since (at least to my
knowledge) neither of these two network filesystems actually support
server-side deduplication commands, and therefore the
_require_scratch_dedupe should have _notrun the test.

Then I looked at fs/nfs/nfs4file.c:

static loff_t nfs42_remap_file_range(struct file *src_file, loff_t src_off,
		struct file *dst_file, loff_t dst_off, loff_t count,
		unsigned int remap_flags)
{
	<local variable declarations>

	if (remap_flags & ~(REMAP_FILE_DEDUP | REMAP_FILE_ADVISORY))
		return -EINVAL;

	<check alignment, lock inodes, flush pending writes>

	ret = nfs42_proc_clone(src_file, dst_file, src_off, dst_off, count);

The NFS client code will accept REMAP_FILE_DEDUP through remap_flags,
which is how dedupe requests are sent to filesystems nowadays.  The nfs
client code does not itself compare the file contents, but it does issue
a CLONE command to the NFS server.  The end result, AFAICT, is that a
user program can write 'A's to file1, 'B's to file2, issue a dedup
ioctl to the kernel, and have a block of 'B's mapped into file1.  That's
broken behavior, according to the dedup ioctl manpage.

Notice how remap_flags is checked but is not included in the
nfs42_proc_clone call?  That's how I conclude that the NFS client cannot
possibly be sending the dedup request to the server.

The same goes for fs/cifs/cifsfs.c:

static loff_t cifs_remap_file_range(struct file *src_file, loff_t off,
		struct file *dst_file, loff_t destoff, loff_t len,
		unsigned int remap_flags)
{
	<local variable declarations>

	if (remap_flags & ~(REMAP_FILE_DEDUP | REMAP_FILE_ADVISORY))
		return -EINVAL;

	<check files, lock inodes, flush pages>

	if (target_tcon->ses->server->ops->duplicate_extents)
		rc = target_tcon->ses->server->ops->duplicate_extents(xid,
			smb_file_src, smb_file_target, off, len, destoff);
	else
		rc = -EOPNOTSUPP;

Again, remap_flags is checked here but it has no influence over the
->duplicate_extents call.

Next I got to thinking that when I reworked the clone/dedupe code last
year, I didn't include REMAP_FILE_DEDUP support for cifs or nfs, because
as far as I knew, neither protocol supports a verb for deduplication.
The remap_flags checks were modified to allow REMAP_FILE_DEDUP in
commits ce96e888fe48e (NFS) and b073a08016a10 (CIFS) with this
justification (the cifs commit has a similar message):

"Subject: Fix nfs4.2 return -EINVAL when do dedupe operation

"dedupe_file_range operations is combiled into remap_file_range.
"    But in nfs42_remap_file_range, it's skiped for dedupe operations.
"    Before this patch:
"      # dd if=/dev/zero of=nfs/file bs=1M count=1
"      # xfs_io -c "dedupe nfs/file 4k 64k 4k" nfs/file
"      XFS_IOC_FILE_EXTENT_SAME: Invalid argument
"    After this patch:
"      # dd if=/dev/zero of=nfs/file bs=1M count=1
"      # xfs_io -c "dedupe nfs/file 4k 64k 4k" nfs/file
"      deduped 4096/4096 bytes at offset 65536
"      4 KiB, 1 ops; 0.0046 sec (865.988 KiB/sec and 216.4971 ops/sec)"

This sort of looks like monkeypatching to make an error message go away.
One could argue that this ought to return EOPNOSUPP instead of EINVAL,
and maybe that's what should've happened.

So, uh, do NFS and CIFS both support server-side dedupe now, or are
these patches just plain wrong?

No, they're just wrong, because I can corrupt files like so on NFS:

$ rm -rf urk moo
$ xfs_io -f -c "pwrite -S 0x58 0 31048" urk
wrote 31048/31048 bytes at offset 0
30 KiB, 8 ops; 0.0000 sec (569.417 MiB/sec and 153846.1538 ops/sec)
$ xfs_io -f -c "pwrite -S 0x59 0 31048" moo
wrote 31048/31048 bytes at offset 0
30 KiB, 8 ops; 0.0001 sec (177.303 MiB/sec and 47904.1916 ops/sec)
$ md5sum urk moo
37d3713e5f9c4fe0f8a1f813b27cb284  urk
a5b6f953f27aa17e42450ff4674fa2df  moo
$ xfs_io -c "dedupe urk 0 0 4096" moo
deduped 4096/4096 bytes at offset 0
4 KiB, 1 ops; 0.0012 sec (3.054 MiB/sec and 781.8608 ops/sec)
$ md5sum urk moo
37d3713e5f9c4fe0f8a1f813b27cb284  urk
2c992d70131c489da954f1d96d8c456e  moo

(Not sure about cifs, since I don't have a Windows Server handy)

I'm not an expert in CIFS or NFS, so I'm asking: do either support
dedupe or is this a kernel bug?

--D
