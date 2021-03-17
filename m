Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD10833EF6F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 12:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhCQLXD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 07:23:03 -0400
Received: from mout.gmx.net ([212.227.17.22]:41795 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230171AbhCQLWa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 07:22:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615980117;
        bh=RaypvbWDaTq0R3Sta1H/6o8ha2Kkog36bPTZmHZ9K58=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=cUTdxz/jN/vV3L8Y+6lCbfSxLnUJ09yn21hPz89SPZZzm/FY65lBbdi+r3SYCf4fd
         wrZf9lmkGy1WICCMhg96DO9guBveUFoMbmOG5sVwbNb3BbxnnDCYjpF8mhUT6C4xs+
         zFiWxyQUtE3FBy1LlZNo1oiHQBU0WyBi4hbVZW28=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N6KUT-1lkCGw0oXp-016j6F; Wed, 17
 Mar 2021 12:21:57 +0100
Subject: Re: [PATCH v8 04/10] btrfs: fix check_data_csum() error message for
 direct I/O
To:     Omar Sandoval <osandov@osandov.com>, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1615922644.git.osandov@fb.com>
 <3a20de6d6ea2a8ebbed0637480f9aa8fff8da19c.1615922644.git.osandov@fb.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <885fa39a-713f-f594-53ae-241d9cd7a113@gmx.com>
Date:   Wed, 17 Mar 2021 19:21:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <3a20de6d6ea2a8ebbed0637480f9aa8fff8da19c.1615922644.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nlF9JdA67zyIRnx2Vqcy9uI9M790o1rdQvo6QTwnva7js9Ra9yD
 pGvXPeX3MlGmOwzBCV/JNF4lSDeAvrF8WjfIU4sFJJ1dFsOF9/1cBkq1+jCJxaDc7ws3Pqz
 7bVE2KkqthZSMgZxFAL8/q0UGEjHhEKpk00PsaZcQWU2Jc4RticHoaiwPOBGywUsxxpZQPx
 mviKDvc6PFb3jPg7djx1Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JzqaSUzhPjc=:5jNN5YiZEOb4uAyJbUIQrE
 Ylap1Af5MRPtnXIjuQDyVC7EdwWZk/JYT8R4aH1r6sw6IJuGfsRWVtZO3GSSdlNfHBkXl3pHz
 ibUjUDWZY/we986fF3HGMFEIahOxhyCNTU2l79wov3YDHAy6OEYf44CE9mezeN2+xRZoxWf0k
 dgR0Qsjj6B+Q+iLyouNtVi6Gzi1Ma92IRS4VyW4nbzaryY7muhNhh57BzySHaGlU9jgyGRvNs
 B6R+hz8kVauI1MPtBg+aHX7w02VSYJKmzSENGH5/Wwm1aK15w72JA4Na0aYyatMnMVMmty0VQ
 qImN/8iHt/Nnmf0GYTJU8Tz6DazMaCwyIjrtI57BPrc79Ot1tUiLx5vzxm8Uwobk63NkqZ/OP
 5u10LkTGncYpTt9amLScldbRGyLfPS+WY1C5HXo6jfgZNIHqgbjgMEOWeIl7ksVwRZII9pT+D
 0mEaO8Ui+4Jlk7PvSsWQe6PTVPmyqmKz1KZDM789U0vyFE+qU6cHBOgi8tWHhbj1x97Ht3ehX
 5ccnJPepqibpb7CFTPGYkFvUfrBRE37LCtxaNYlcU+88l9Er2f0mMCDsN/67oLRnnEa0detud
 m0bTS5n7glNGg89axO/IVYI3LW9MCRlePfWsqLdPYBdaFkhlpO747mSyUjm40uWSE529LNOgD
 G2Luj97iGN97G38w7rCbrSfzFT9o+KeBHZQN7JWSbQ1rYmhL6o5VhL741aKeHIdW/iPAqxeVo
 qLCIuFo4zANzmTUWhW6N8riMFviZQf3LyFCxVN2G9ajC6/eT/3vrBCz3hf/Ms/Y2oVW8rsBNz
 wQhMPSOxszw5Wm9AIufrcMraUrzIzETV49LLOTV77YkDQkGZfLyeBgLt2v0dw43uuXczwB7wZ
 cj4KLdyDUTVSho6AjaMg==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/3/17 =E4=B8=8A=E5=8D=883:43, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
>
> Commit 1dae796aabf6 ("btrfs: inode: sink parameter start and len to
> check_data_csum()") replaced the start parameter to check_data_csum()
> with page_offset(), but page_offset() is not meaningful for direct I/O
> pages. Bring back the start parameter.

So direct IO pages doesn't have page::index set at all?

Any reproducer? I'd like to try to reproduce it first.

>
> Fixes: 265d4ac03fdf ("btrfs: sink parameter start and len to check_data_=
csum")
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>   fs/btrfs/inode.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index ef6cb7b620d0..d2ece8554416 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2947,11 +2947,13 @@ void btrfs_writepage_endio_finish_ordered(struct=
 page *page, u64 start,
>    * @bio_offset:	offset to the beginning of the bio (in bytes)
>    * @page:	page where is the data to be verified
>    * @pgoff:	offset inside the page
> + * @start:	logical offset in the file

Please add some comment if only for direct IO we need that @start paramete=
r.

Thanks,
Qu
>    *
>    * The length of such check is always one sector size.
>    */
>   static int check_data_csum(struct inode *inode, struct btrfs_io_bio *i=
o_bio,
> -			   u32 bio_offset, struct page *page, u32 pgoff)
> +			   u32 bio_offset, struct page *page, u32 pgoff,
> +			   u64 start)
>   {
>   	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
>   	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
> @@ -2978,8 +2980,8 @@ static int check_data_csum(struct inode *inode, st=
ruct btrfs_io_bio *io_bio,
>   	kunmap_atomic(kaddr);
>   	return 0;
>   zeroit:
> -	btrfs_print_data_csum_error(BTRFS_I(inode), page_offset(page) + pgoff,
> -				    csum, csum_expected, io_bio->mirror_num);
> +	btrfs_print_data_csum_error(BTRFS_I(inode), start, csum, csum_expected=
,
> +				    io_bio->mirror_num);
>   	if (io_bio->device)
>   		btrfs_dev_stat_inc_and_print(io_bio->device,
>   					     BTRFS_DEV_STAT_CORRUPTION_ERRS);
> @@ -3032,7 +3034,8 @@ int btrfs_verify_data_csum(struct btrfs_io_bio *io=
_bio, u32 bio_offset,
>   	     pg_off +=3D sectorsize, bio_offset +=3D sectorsize) {
>   		int ret;
>
> -		ret =3D check_data_csum(inode, io_bio, bio_offset, page, pg_off);
> +		ret =3D check_data_csum(inode, io_bio, bio_offset, page, pg_off,
> +				      page_offset(page) + pg_off);
>   		if (ret < 0)
>   			return -EIO;
>   	}
> @@ -7742,7 +7745,8 @@ static blk_status_t btrfs_check_read_dio_bio(struc=
t inode *inode,
>   			ASSERT(pgoff < PAGE_SIZE);
>   			if (uptodate &&
>   			    (!csum || !check_data_csum(inode, io_bio,
> -					bio_offset, bvec.bv_page, pgoff))) {
> +						       bio_offset, bvec.bv_page,
> +						       pgoff, start))) {
>   				clean_io_failure(fs_info, failure_tree, io_tree,
>   						 start, bvec.bv_page,
>   						 btrfs_ino(BTRFS_I(inode)),
>
