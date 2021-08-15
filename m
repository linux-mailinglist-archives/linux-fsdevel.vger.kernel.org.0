Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780903EC805
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Aug 2021 09:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236170AbhHOHry (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Aug 2021 03:47:54 -0400
Received: from smtp-31.italiaonline.it ([213.209.10.31]:51596 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232774AbhHOHrv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Aug 2021 03:47:51 -0400
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Aug 2021 03:47:50 EDT
Received: from venice.bhome ([78.12.137.210])
        by smtp-31.iol.local with ESMTPA
        id FAjcmVP3mzHnRFAjcmGhoC; Sun, 15 Aug 2021 09:39:10 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1629013150; bh=+7Gxj7b1TSy535vs0VCmPjSvbElXiMQ7PMMmW+6jlvM=;
        h=From;
        b=l0t5WPtaa/PUy7ooU0A9wUG8GKn5uIwR22xeCjBSjM8coMjJ9kq66vSsHm+T6SBtY
         yW4yndSMJYEe78oSxmBQ77PK430/TaPkFaBRVK+fmxB3M4cZfCVBMM1NUIqVcKei/9
         bHrdwMKBBgiu807RdIpcuBUsR16f66gfO9WOhECgIfe21J0QRiUNcsPrr5d0KkHOcy
         dwoOTZ4Y1yoS1iCPLH+G5+I9DDBFwmKJN28YL4nOADy5vNzGC1Sf0CzwCr72w/CJt5
         mBHQcIiVPIbKtfDIXnSeGxtx6+T62OUopETTQHepSwo0qPueM4vRnWHQi7WlICDFQh
         R0F5H2Oxk3Kcg==
X-CNFS-Analysis: v=2.4 cv=L6DY/8f8 c=1 sm=1 tr=0 ts=6118c49e cx=a_exe
 a=VHyfYjYfg3XpWvNRQl5wtg==:117 a=VHyfYjYfg3XpWvNRQl5wtg==:17
 a=IkcTkHD0fZMA:10 a=3jRIoorFTcgkMpjqpWoA:9 a=hC5zjGdhJ67ffH3v:21
 a=2_0S_fzlarmj8puM:21 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH] VFS/BTRFS/NFSD: provide more unique inode number for
 btrfs export
To:     NeilBrown <neilb@suse.de>, Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
 <162881913686.1695.12479588032010502384@noble.neil.brown.name>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <bf49ef31-0c86-62c8-7862-719935764036@libero.it>
Date:   Sun, 15 Aug 2021 09:39:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <162881913686.1695.12479588032010502384@noble.neil.brown.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfKBECCtUm+/m3ngWAQ5bzWkgSKfnLPPiNVXPPAK6cWyr8XizGdFiCEHrYT7+XpDKvCu3nSK0/Hucd9ca3REjr5I55HnWnYLVDCT8on5XyHTqpPb7rBOm
 Vlqb1bydOfZ9bzGK9g8lK7bdM/Ev/RfklFrZf22N4tqr20ZKkBniU9qnseZiYmLlr+/+Qp1RAj2xurXUrHPmsqJbq5bzhMgQou/DnzkcPNW8PAko98z2Uqqh
 EwLV9Btepy8JYow+X5fQoZP+NJSmKpzdlGUZ/iqBJJYdvqtp/+CZbD4PQUBPWPRrLt47T4QutjC+M/3RCLtZgnEPQ/WJxL2BoitPTu+d6eJV3fpCfRydse3j
 2ri+U/7PV2R96ixRkiaCINSQiayQD9NbEEvwvxxuHQQL4sZDL41KysvT/Te8SEd7BnFETytGG8teF2T5PLYD3xMxFOL+7+Np0ZbifOmksZFXhRhyjQjYa/eV
 Kiac7m1xYsqddyBAwJcsRWKUyRK9D2BFMwbV0w==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi All,

On 8/13/21 3:45 AM, NeilBrown wrote:
> 
> [[This patch is a minimal patch which addresses the current problems
>    with nfsd and btrfs, in a way which I think is most supportable, least
>    surprising, and least likely to impact any future attempts to more
>    completely fix the btrfs file-identify problem]]
> 
> BTRFS does not provide unique inode numbers across a filesystem.
> It *does* provide unique inode numbers with a subvolume and
> uses synthetic device numbers for different subvolumes to ensure
> uniqueness for device+inode.
> 
> nfsd cannot use these varying device numbers.  If nfsd were to
> synthesise different stable filesystem ids to give to the client, that
> would cause subvolumes to appear in the mount table on the client, even
> though they don't appear in the mount table on the server.  Also, NFSv3
> doesn't support changing the filesystem id without a new explicit
> mount on the client (this is partially supported in practice, but
> violates the protocol specification).

I am sure that it was discussed already but I was unable to find any track of this discussion.
But if the problem is the collision between the inode number of different subvolume in the nfd export, is it simpler if the export is truncated to the subvolume boundary ? It would be more coherent with the current behavior of vfs+nfsd.

In fact in btrfs a subvolume is a complete filesystem, with an "own synthetic" device. We could like or not this solution, but this solution is the more aligned to the unix standard, where for each filesystem there is a pair (device, inode-set). NFS (by default) avoids to cross the boundary between the filesystems. So why in BTRFS this
should be different ?

May be an opt-in option would solve the backward compatibility (i.e. to avoid problem with setup which relies on this behaviour).

> So currently, the roots of all subvolumes report the same inode number
> in the same filesystem to NFS clients and tools like 'find' notice that
> a directory has the same identity as an ancestor, and so refuse to
> enter that directory.
> 
> This patch allows btrfs (or any filesystem) to provide a 64bit number
> that can be xored with the inode number to make the number more unique.
> Rather than the client being certain to see duplicates, with this patch
> it is possible but extremely rare.
> 
> The number than btrfs provides is a swab64() version of the subvolume
> identifier.  This has most entropy in the high bits (the low bits of the
> subvolume identifer), while the inoe has most entropy in the low bits.
> The result will always be unique within a subvolume, and will almost
> always be unique across the filesystem.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>   fs/btrfs/inode.c     |  4 ++++
>   fs/nfsd/nfs3xdr.c    | 17 ++++++++++++++++-
>   fs/nfsd/nfs4xdr.c    |  9 ++++++++-
>   fs/nfsd/xdr3.h       |  2 ++
>   include/linux/stat.h | 17 +++++++++++++++++
>   5 files changed, 47 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 0117d867ecf8..989fdf2032d5 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -9195,6 +9195,10 @@ static int btrfs_getattr(struct user_namespace *mnt_userns,
>   	generic_fillattr(&init_user_ns, inode, stat);
>   	stat->dev = BTRFS_I(inode)->root->anon_dev;
>   
> +	if (BTRFS_I(inode)->root->root_key.objectid != BTRFS_FS_TREE_OBJECTID)
> +		stat->ino_uniquifier =
> +			swab64(BTRFS_I(inode)->root->root_key.objectid);
> +
>   	spin_lock(&BTRFS_I(inode)->lock);
>   	delalloc_bytes = BTRFS_I(inode)->new_delalloc_bytes;
>   	inode_bytes = inode_get_bytes(inode);
> diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
> index 0a5ebc52e6a9..669e2437362a 100644
> --- a/fs/nfsd/nfs3xdr.c
> +++ b/fs/nfsd/nfs3xdr.c
> @@ -340,6 +340,7 @@ svcxdr_encode_fattr3(struct svc_rqst *rqstp, struct xdr_stream *xdr,
>   {
>   	struct user_namespace *userns = nfsd_user_namespace(rqstp);
>   	__be32 *p;
> +	u64 ino;
>   	u64 fsid;
>   
>   	p = xdr_reserve_space(xdr, XDR_UNIT * 21);
> @@ -377,7 +378,10 @@ svcxdr_encode_fattr3(struct svc_rqst *rqstp, struct xdr_stream *xdr,
>   	p = xdr_encode_hyper(p, fsid);
>   
>   	/* fileid */
> -	p = xdr_encode_hyper(p, stat->ino);
> +	ino = stat->ino;
> +	if (stat->ino_uniquifier && stat->ino_uniquifier != ino)
> +		ino ^= stat->ino_uniquifier;
> +	p = xdr_encode_hyper(p, ino);
>   
>   	p = encode_nfstime3(p, &stat->atime);
>   	p = encode_nfstime3(p, &stat->mtime);
> @@ -1151,6 +1155,17 @@ svcxdr_encode_entry3_common(struct nfsd3_readdirres *resp, const char *name,
>   	if (xdr_stream_encode_item_present(xdr) < 0)
>   		return false;
>   	/* fileid */
> +	if (!resp->dir_have_uniquifier) {
> +		struct kstat stat;
> +		if (fh_getattr(&resp->fh, &stat) == nfs_ok)
> +			resp->dir_ino_uniquifier = stat.ino_uniquifier;
> +		else
> +			resp->dir_ino_uniquifier = 0;
> +		resp->dir_have_uniquifier = 1;
> +	}
> +	if (resp->dir_ino_uniquifier &&
> +	    resp->dir_ino_uniquifier != ino)
> +		ino ^= resp->dir_ino_uniquifier;
>   	if (xdr_stream_encode_u64(xdr, ino) < 0)
>   		return false;
>   	/* name */
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 7abeccb975b2..ddccf849c29c 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -3114,10 +3114,14 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
>   					fhp->fh_handle.fh_size);
>   	}
>   	if (bmval0 & FATTR4_WORD0_FILEID) {
> +		u64 ino = stat.ino;
> +		if (stat.ino_uniquifier &&
> +		    stat.ino_uniquifier != stat.ino)
> +			ino ^= stat.ino_uniquifier;
>   		p = xdr_reserve_space(xdr, 8);
>   		if (!p)
>   			goto out_resource;
> -		p = xdr_encode_hyper(p, stat.ino);
> +		p = xdr_encode_hyper(p, ino);
>   	}
>   	if (bmval0 & FATTR4_WORD0_FILES_AVAIL) {
>   		p = xdr_reserve_space(xdr, 8);
> @@ -3285,6 +3289,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
>   			if (err)
>   				goto out_nfserr;
>   			ino = parent_stat.ino;
> +			if (parent_stat.ino_uniquifier &&
> +			    parent_stat.ino_uniquifier != ino)
> +				ino ^= parent_stat.ino_uniquifier;
>   		}
>   		p = xdr_encode_hyper(p, ino);
>   	}
> diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
> index 933008382bbe..b4f9f3c71f72 100644
> --- a/fs/nfsd/xdr3.h
> +++ b/fs/nfsd/xdr3.h
> @@ -179,6 +179,8 @@ struct nfsd3_readdirres {
>   	struct xdr_buf		dirlist;
>   	struct svc_fh		scratch;
>   	struct readdir_cd	common;
> +	u64			dir_ino_uniquifier;
> +	int			dir_have_uniquifier;
>   	unsigned int		cookie_offset;
>   	struct svc_rqst *	rqstp;
>   
> diff --git a/include/linux/stat.h b/include/linux/stat.h
> index fff27e603814..a5188f42ed81 100644
> --- a/include/linux/stat.h
> +++ b/include/linux/stat.h
> @@ -46,6 +46,23 @@ struct kstat {
>   	struct timespec64 btime;			/* File creation time */
>   	u64		blocks;
>   	u64		mnt_id;
> +	/*
> +	 * BTRFS does not provide unique inode numbers within a filesystem,
> +	 * depending on a synthetic 'dev' to provide uniqueness.
> +	 * NFSd cannot make use of this 'dev' number so clients often see
> +	 * duplicate inode numbers.
> +	 * For BTRFS, 'ino' is unlikely to use the high bits.  It puts
> +	 * another number in ino_uniquifier which:
> +	 * - has most entropy in the high bits
> +	 * - is different precisely when 'dev' is different
> +	 * - is stable across unmount/remount
> +	 * NFSd can xor this with 'ino' to get a substantially more unique
> +	 * number for reporting to the client.
> +	 * The ino_uniquifier for a directory can reasonably be applied
> +	 * to inode numbers reported by the readdir filldir callback.
> +	 * It is NOT currently exported to user-space.
> +	 */
> +	u64		ino_uniquifier;
>   };

Why don't rename "ino_uniquifier" as "ino_and_subvolume" and leave to the filesystem the work to combine the inode and the subvolume-id ?

I am worried that the logic is split between the filesystem, which synthesizes the ino_uniquifier, and to NFS which combine to the inode. I am thinking that this combination is filesystem specific; for BTRFS is a simple xor but for other filesystem may be a more complex operation, so leaving an half in the filesystem and another half to the NFS seems to not optimal if other filesystem needs to use ino_uniquifier.


>   #endif
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
