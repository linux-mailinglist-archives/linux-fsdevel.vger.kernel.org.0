Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB573DB2C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 07:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbhG3F0p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 01:26:45 -0400
Received: from mout.gmx.net ([212.227.15.15]:48361 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229696AbhG3F0p (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 01:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627622766;
        bh=wBtJWqMwpUtxUaLzEH0VdMAQWv5xXke5bunLFeDBU6A=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=gm6VNrUL9DdOXSS8Jq/UOh1L5L+sP5dmRmGO+exkJiLt+IIkLtyVzokTYEfGAgPjm
         aexAvGt4arn10HhnLxrzzoWOLefugyDKOyi+J677U2T4UmqiQjk7ArqSeyZ/P6N91N
         irUedq5lqhpSDJreU7P8XJMaVQ+5dpADWqjZLsnU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mlf0K-1mqgWd3ejq-00iho1; Fri, 30
 Jul 2021 07:26:06 +0200
To:     NeilBrown <neilb@suse.de>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Neal Gompa <ngompa13@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs@vger.kernel.org,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
 <20210728125819.6E52.409509F4@e16-tech.com>
 <20210728140431.D704.409509F4@e16-tech.com>
 <162745567084.21659.16797059962461187633@noble.neil.brown.name>
 <CAEg-Je8Pqbw0tTw6NWkAcD=+zGStOJR0J-409mXuZ1vmb6dZsA@mail.gmail.com>
 <162751265073.21659.11050133384025400064@noble.neil.brown.name>
 <20210729023751.GL10170@hungrycats.org>
 <162752976632.21659.9573422052804077340@noble.neil.brown.name>
 <20210729232017.GE10106@hungrycats.org>
 <162761259105.21659.4838403432058511846@noble.neil.brown.name>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH/RFC 00/11] expose btrfs subvols in mount table correctly
Message-ID: <341403c0-a7a7-f6c8-5ef6-2d966b1907a8@gmx.com>
Date:   Fri, 30 Jul 2021 13:25:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <162761259105.21659.4838403432058511846@noble.neil.brown.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZoX1S1tTl2zZex6nBbSMnDc/sOKJyEt7mwixy/dFtc8BPHeArXo
 1mjdPWCEV9MdQV2F8uE+aekQzAmI2S1dmKM1Fd8sAtem/9aWmbzIvvNyznI+dX0awcX18/k
 T6W8jMio1m7xIUaZNCyIorpsxEtHAzGtbML8/4NtrbGg62QcG84eUKDGsJHAkJsvnSLjoGe
 VHCRnMypXDwYWnbaBRIkw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JLxysggp5lA=:tjuxHpfknPXLEEU74PgUUD
 gDtZr2395zZnkKFq5Z9oq1qJ7SL5Ib5czQW4/i6Je/vqD96WIWE0ly5esXQjO/bO04STh+r4j
 +05HLbtBFDJ7syTTnvNqRnDzAxZI2MRjO2BibRPvANrvC9wi2RmnQbJ4s7TswkTeQGTJi4j/z
 80srXT4rZ7P3E8bvYyGO2AKm2VV37AUBSEcsXajHlOEIbq0upVdwmFwKXVO4PnS8bK8KFgmGJ
 zVMtOOhRQTWVkmZ9ROo8LIsot5f1yHHNNxY2X1JdO4kb1YHlXJFO1DsmJMErIJJIedeW+F656
 HSNlB70PemMooTLzs6N7z17kOxP1MxaSv7fyEYrTGaB7T8tFIldMM8yPJkzhCOvMMLU5HHrDW
 OOkQaPBZ8WOhrWy9zNpe22TO6m324BtCLt4oPUs7e4OlUvoePrV7bU7BgDkbdfuHk9dou5a6C
 3//A6nBfUi+jDG3te+KCKHiWkncae5sE1UP15/4gkB1rqjMhmsEUjPqzND7APdf/Z9Mph1S6B
 dzCnunmJlj2CE/ZpUh1tLDGKdOjseqIxLuNInDBG64N2pWscBZ5yqERqs0lYnXguH78UvbD+V
 QmSPopMQYGdaLy7Zv566EBWfLDIkl4O1tBWfK7+y3lHN3SfC6VgkNX9RAdI//hxy9+nyd/KTe
 ywWmv7RXfmWocBoHk/Qcug6LvC0AoBfmTd/fU6ceJx/1r/fsMyBAOR0Z1KJVQNW2lNlM5gLNZ
 FA8NIWhQLN5iL1R1NPo1XFNI3OnCC5bsanwnNleiSfzskYBhS+xWQufE7m5MZMQhdGnDS/Ko4
 hTC59yO17yIs46DmYPVs9d5OIBmjTyF6luLsodNTwRu3n7P2r/+twS8w6SxJzjULhAhTlDjfx
 5uoA0+N/AqtCIgC4+GOmxR8YAwdAys7P7S/55filFyu2PdTpsoJqvMPsEePG1PDjCereC8re4
 U+E9VQr9fJM6mpTaGAg5pBFe4DrYrmw2KmxtHJZkYlpVbbVj3Hw/u6ov6dFZUQne7cXOwXq/y
 MB/IvLiVdwgUpkEXwU5ypohp9q7dls7GEB/RptcLcevgGYKLtZ4cxfkaxyM3l3/LfRIgAt6BC
 Wu2hLlU0XnjZ4tfPQco0JpNoLVYdXJIxBmCsapHe8tGjdZsY1TthaVc/g==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/7/30 =E4=B8=8A=E5=8D=8810:36, NeilBrown wrote:
>
> I've been pondering all the excellent feedback, and what I have learnt
> from examining the code in btrfs, and I have developed a different
> perspective.

Great! Some new developers into the btrfs realm!

>
> Maybe "subvol" is a poor choice of name because it conjures up
> connections with the Volumes in LVM, and btrfs subvols are very differen=
t
> things.  Btrfs subvols are really just subtrees that can be treated as a
> unit for operations like "clone" or "destroy".
>
> As such, they don't really deserve separate st_dev numbers.
>
> Maybe the different st_dev numbers were introduced as a "cheap" way to
> extend to size of the inode-number space.  Like many "cheap" things, it
> has hidden costs.
>
> Maybe objects in different subvols should still be given different inode
> numbers.  This would be problematic on 32bit systems, but much less so o=
n
> 64bit systems.
>
> The patch below, which is just a proof-of-concept, changes btrfs to
> report a uniform st_dev, and different (64bit) st_ino in different subvo=
ls.
>
> It has problems:
>   - it will break any 32bit readdir and 32bit stat.  I don't know how bi=
g
>     a problem that is these days (ino_t in the kernel is "unsigned long"=
,
>     not "unsigned long long). That surprised me).
>   - It might break some user-space expectations.  One thing I have learn=
t
>     is not to make any assumption about what other people might expect.

Wouldn't any filesystem boundary check fail to stop at subvolume boundary?

Then it will go through the full btrfs subvolumes/snapshots, which can
be super slow.

>
> However, it would be quite easy to make this opt-in (or opt-out) with a
> mount option, so that people who need the current inode numbers and will
> accept the current breakage can keep working.
>
> I think this approach would be a net-win for NFS export, whether BTRFS
> supports it directly or not.  I might post a patch which modifies NFS to
> intuit improved inode numbers for btrfs exports....

Some extra ideas, but not familiar with VFS enough to be sure.

Can we generate "fake" superblock for each subvolume?
Like using the subolume UUID to replace the FSID of each subvolume.
Could that migrate the problem?

Thanks,
Qu

>
> So: how would this break your use-case??
>
> Thanks,
> NeilBrown
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 0117d867ecf8..8dc58c848502 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -6020,6 +6020,37 @@ static int btrfs_opendir(struct inode *inode, str=
uct file *file)
>   	return 0;
>   }
>
> +static u64 btrfs_make_inum(struct btrfs_key *root, struct btrfs_key *in=
o)
> +{
> +	u64 rootid =3D root->objectid;
> +	u64 inoid =3D ino->objectid;
> +	int shift =3D 64-8;
> +
> +	if (ino->type =3D=3D BTRFS_ROOT_ITEM_KEY) {
> +		/* This is a subvol root found during readdir. */
> +		rootid =3D inoid;
> +		inoid =3D BTRFS_FIRST_FREE_OBJECTID;
> +	}
> +	if (rootid =3D=3D BTRFS_FS_TREE_OBJECTID)
> +		/* this is main vol, not subvol (I think) */
> +		return inoid;
> +	/* store the rootid in the high bits of the inum.  This
> +	 * will break if 32bit inums are required - we cannot know
> +	 */
> +	while (rootid) {
> +		inoid ^=3D (rootid & 0xff) << shift;
> +		rootid >>=3D 8;
> +		shift -=3D 8;
> +	}
> +	return inoid;
> +}
> +
> +static inline u64 btrfs_ino_to_inum(struct inode *inode)
> +{
> +	return btrfs_make_inum(&BTRFS_I(inode)->root->root_key,
> +			       &BTRFS_I(inode)->location);
> +}
> +
>   struct dir_entry {
>   	u64 ino;
>   	u64 offset;
> @@ -6045,6 +6076,49 @@ static int btrfs_filldir(void *addr, int entries,=
 struct dir_context *ctx)
>   	return 0;
>   }
>
> +static inline bool btrfs_dir_emit_dot(struct file *file,
> +				      struct dir_context *ctx)
> +{
> +	return ctx->actor(ctx, ".", 1, ctx->pos,
> +			  btrfs_ino_to_inum(file->f_path.dentry->d_inode),
> +			  DT_DIR) =3D=3D 0;
> +}
> +
> +static inline ino_t btrfs_parent_ino(struct dentry *dentry)
> +{
> +	ino_t res;
> +
> +	/*
> +	 * Don't strictly need d_lock here? If the parent ino could change
> +	 * then surely we'd have a deeper race in the caller?
> +	 */
> +	spin_lock(&dentry->d_lock);
> +	res =3D btrfs_ino_to_inum(dentry->d_parent->d_inode);
> +	spin_unlock(&dentry->d_lock);
> +	return res;
> +}
> +
> +static inline bool btrfs_dir_emit_dotdot(struct file *file,
> +					 struct dir_context *ctx)
> +{
> +	return ctx->actor(ctx, "..", 2, ctx->pos,
> +			  btrfs_parent_ino(file->f_path.dentry), DT_DIR) =3D=3D 0;
> +}
> +static inline bool btrfs_dir_emit_dots(struct file *file,
> +				       struct dir_context *ctx)
> +{
> +	if (ctx->pos =3D=3D 0) {
> +		if (!btrfs_dir_emit_dot(file, ctx))
> +			return false;
> +		ctx->pos =3D 1;
> +	}
> +	if (ctx->pos =3D=3D 1) {
> +		if (!btrfs_dir_emit_dotdot(file, ctx))
> +			return false;
> +		ctx->pos =3D 2;
> +	}
> +	return true;
> +}
>   static int btrfs_real_readdir(struct file *file, struct dir_context *c=
tx)
>   {
>   	struct inode *inode =3D file_inode(file);
> @@ -6067,7 +6141,7 @@ static int btrfs_real_readdir(struct file *file, s=
truct dir_context *ctx)
>   	bool put =3D false;
>   	struct btrfs_key location;
>
> -	if (!dir_emit_dots(file, ctx))
> +	if (!btrfs_dir_emit_dots(file, ctx))
>   		return 0;
>
>   	path =3D btrfs_alloc_path();
> @@ -6136,7 +6210,8 @@ static int btrfs_real_readdir(struct file *file, s=
truct dir_context *ctx)
>   		put_unaligned(fs_ftype_to_dtype(btrfs_dir_type(leaf, di)),
>   				&entry->type);
>   		btrfs_dir_item_key_to_cpu(leaf, di, &location);
> -		put_unaligned(location.objectid, &entry->ino);
> +		put_unaligned(btrfs_make_inum(&root->root_key, &location),
> +			      &entry->ino);
>   		put_unaligned(found_key.offset, &entry->offset);
>   		entries++;
>   		addr +=3D sizeof(struct dir_entry) + name_len;
> @@ -9193,7 +9268,7 @@ static int btrfs_getattr(struct user_namespace *mn=
t_userns,
>   				  STATX_ATTR_NODUMP);
>
>   	generic_fillattr(&init_user_ns, inode, stat);
> -	stat->dev =3D BTRFS_I(inode)->root->anon_dev;
> +	stat->ino =3D btrfs_ino_to_inum(inode);
>
>   	spin_lock(&BTRFS_I(inode)->lock);
>   	delalloc_bytes =3D BTRFS_I(inode)->new_delalloc_bytes;
>
