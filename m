Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55733936F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 22:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235774AbhE0UUQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 16:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235560AbhE0UUP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 16:20:15 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7DDC061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 May 2021 13:18:40 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id v13so510338ple.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 May 2021 13:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=f7IRmmsPc5OJXbvkB9JYG3YVI3enRiW4mz0tA35EDLs=;
        b=coBabAZSQB0o4UI6gGRZpe0ZZUWJ0m/IFaMTF8a/mnc2IY31lrEalgGY391y4ytI8c
         H4lnDmZ23dCUkiJhy+/QJYVtciGcUXgbLHvO17xaZzruz7tZ9RPcvGjCR1x3yQdtyITv
         sUZb1Ki+bq94MrnyC94+ksku9bHrXbSqrvs1etY7TC0trY1mjJoZxySNety3we6fnVV7
         X8wxCOl8y2pX0InvfN/On+B4SwoPdOPRRL6cTTF1jzx7jshBp0pgqMxuYmKYs1et+6ng
         dVNK4A0MRDKeIzYTntItCQXBy+agXhwPAzUJ4yFl/fG70dUGoh0mlFmB2ZlPsquWLqcO
         h1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=f7IRmmsPc5OJXbvkB9JYG3YVI3enRiW4mz0tA35EDLs=;
        b=uNsHD56wZdmurfQoiENuqI8WDBcQOhZWJhaB901W+xHdmzElSLm22EH//pNsm6Gxi7
         Ar1HBDJP3Xo4UVFcbKcqXurbAtKrnWA9FCXSb73v+8kR1UQ3uWZ4v+Smy0yVUowzPHOu
         c5EmvOVjm9w0lCHt/9B6Z5uUx5chCHz+frPu8/pjZg3X0T5g+xnkg3R0fyfhzKv55jfi
         A4Hkfr200O2PKwj18zXrBoLPnLX1gr5szpZ/NuPJlwCNKOg7uOKyI1iY2eEAwY8Fw+sw
         an1Ve3qUvjt2jSv/JLRTQo0/9e7+xUdBCeIdzzVeE7mjJX+W7AlM04NQDwh5ygiM4ZMe
         0iUg==
X-Gm-Message-State: AOAM53023zj4X4bnE6l/kYTv/TqRRGOhT5+mEmCpKlChP5+7s3z4NeCo
        SD2cRk13v9AiCiMx12h4d7b2pQ==
X-Google-Smtp-Source: ABdhPJzy7QbUPxR2+OSSR82fGGeFE/v9nBX9kUVPcpvfShUIvtmxIb0jjchs1/n5EtlQ2OJ+B7d9YQ==
X-Received: by 2002:a17:90a:303:: with SMTP id 3mr220968pje.120.1622146720206;
        Thu, 27 May 2021 13:18:40 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id b23sm2616993pjo.26.2021.05.27.13.18.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 May 2021 13:18:39 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <2BC51066-DC7C-4DAF-80B4-EEE8BD9FD814@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_C4C033CF-45DC-482F-8F11-301CC3B4BE83";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH V2 7/7] ext4: get discard out of jbd2 commit kthread
 contex
Date:   Thu, 27 May 2021 14:18:37 -0600
In-Reply-To: <a4e350a9-ef27-dc82-f610-0d3a0588afdf@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        lishujin@kuaishou.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
To:     Wang Jianchao <jianchao.wan9@gmail.com>
References: <164ffa3b-c4d5-6967-feba-b972995a6dfb@gmail.com>
 <a602a6ba-2073-8384-4c8f-d669ee25c065@gmail.com>
 <49382052-6238-f1fb-40d1-b6b801b39ff7@gmail.com>
 <48e33dea-d15e-f211-0191-e01bd3eb17b3@gmail.com>
 <67eeb65a-d413-c4f9-c06f-d5dcceca0e4f@gmail.com>
 <0b7915bc-193a-137b-4e52-8aaef8d6fef3@gmail.com>
 <a4e350a9-ef27-dc82-f610-0d3a0588afdf@gmail.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_C4C033CF-45DC-482F-8F11-301CC3B4BE83
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On May 26, 2021, at 2:44 AM, Wang Jianchao <jianchao.wan9@gmail.com> =
wrote:
>=20
> Right now, discard is issued and waited to be completed in jbd2
> commit kthread context after the logs are committed. When large
> amount of files are deleted and discard is flooding, jbd2 commit
> kthread can be blocked for long time. Then all of the metadata
> operations can be blocked to wait the log space.
>=20
> One case is the page fault path with read mm->mmap_sem held, which
> wants to update the file time but has to wait for the log space.
> When other threads in the task wants to do mmap, then write mmap_sem
> is blocked. Finally all of the following read mmap_sem requirements
> are blocked, even the ps command which need to read the /proc/pid/
> -cmdline. Our monitor service which needs to read /proc/pid/cmdline
> used to be blocked for 5 mins.
>=20
> This patch frees the blocks back to buddy after commit and then do
> discard in a async kworker context in fstrim fashion, namely,
> - mark blocks to be discarded as used if they have not been allocated
> - do discard
> - mark them free
> After this, jbd2 commit kthread won't be blocked any more by discard
> and we won't get NOSPC even if the discard is slow or throttled.

I definitely agree that sharing the existing fstrim functionality makes
the most sense here.  Some comments inline on the implementation.

> Link: https://marc.info/?l=3Dlinux-kernel&m=3D162143690731901&w=3D2
> Suggested-by: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>
> ---
> fs/ext4/ext4.h    |   2 +
> fs/ext4/mballoc.c | 162 =
+++++++++++++++++++++++++++++++++---------------------
> fs/ext4/mballoc.h |   3 -
> 3 files changed, 101 insertions(+), 66 deletions(-)
>=20
> @@ -3024,30 +3039,77 @@ static inline int ext4_issue_discard(struct =
super_block *sb,
> 		return sb_issue_discard(sb, discard_block, count, =
GFP_NOFS, 0);
> }
>=20
> -static void ext4_free_data_in_buddy(struct super_block *sb,
> -				    struct ext4_free_data *entry)
> +static void ext4_discard_work(struct work_struct *work)
> {
> +	struct ext4_sb_info *sbi =3D container_of(work,
> +			struct ext4_sb_info, s_discard_work);
> +	struct super_block *sb =3D sbi->s_sb;
> +	ext4_group_t ngroups =3D ext4_get_groups_count(sb);
> +	struct ext4_group_info *grp;
> +	struct ext4_free_data *fd, *nfd;
> 	struct ext4_buddy e4b;
> -	struct ext4_group_info *db;
> -	int err, count =3D 0, count2 =3D 0;
> +	int i, err;
> +
> +	for (i =3D 0; i < ngroups; i++) {
> +		grp =3D ext4_get_group_info(sb, i);
> +		if (RB_EMPTY_ROOT(&grp->bb_discard_root))
> +			continue;

For large filesystems there may be millions of block groups, so it
seems inefficient to scan all of the groups each time the work queue
is run.  Having a list of block group numbers, or bitmap/rbtree/xarray
of the group numbers that need to be trimmed may be more efficient?

Most of the complexity in the rest of the patch goes away if the trim
tracking is only done on a whole-group basis (min/max or just a single
bit per group).

Cheers, Andreas

> -	mb_debug(sb, "gonna free %u blocks in group %u (0x%p):",
> -		 entry->efd_count, entry->efd_group, entry);
> +		err =3D ext4_mb_load_buddy(sb, i, &e4b);
> +		if (err) {
> +			ext4_warning(sb, "Error %d loading buddy =
information for %u",
> +					err, i);
> +			continue;
> +		}
>=20
> -	err =3D ext4_mb_load_buddy(sb, entry->efd_group, &e4b);
> -	/* we expect to find existing buddy because it's pinned */
> -	BUG_ON(err !=3D 0);
> +		ext4_lock_group(sb, i);
> +		rbtree_postorder_for_each_entry_safe(fd, nfd,
> +				&grp->bb_discard_root, efd_node) {
> +			rb_erase(&fd->efd_node, &grp->bb_discard_root);
> +			/*
> +			 * If filesystem is umounting, give up the =
discard
> +			 */
> +			if (sb->s_flags & SB_ACTIVE)
> +				ext4_try_to_trim_range(sb, &e4b, =
fd->efd_start_cluster,
> +						fd->efd_start_cluster + =
fd->efd_count - 1, 1);
> +			kmem_cache_free(ext4_free_data_cachep, fd);
> +		}
> +		ext4_unlock_group(sb, i);
> +		ext4_mb_unload_buddy(&e4b);
> +	}
> +}
>=20
> -	atomic_sub(entry->efd_count, &EXT4_SB(sb)->s_mb_free_pending);
> +static int ext4_free_data_in_buddy(struct super_block *sb,
> +		ext4_group_t group, tid_t commit_tid)
> +{
> +	struct ext4_buddy e4b;
> +	struct ext4_group_info *db;
> +	struct ext4_free_data *fd, *nfd;
> +	int cnt, nr_fd;
>=20
> +	/* we expect to find existing buddy because it's pinned */
> +	BUG_ON(ext4_mb_load_buddy(sb, group, &e4b));
> 	db =3D e4b.bd_info;
> -	/* there are blocks to put in buddy to make them really free */
> -	count +=3D entry->efd_count;
> -	count2++;
> -	ext4_lock_group(sb, entry->efd_group);
> -	/* Take it out of per group rb tree */
> -	rb_erase(&entry->efd_node, &(db->bb_free_root));
> -	mb_free_blocks(NULL, &e4b, entry->efd_start_cluster, =
entry->efd_count);
> +	cnt =3D 0;
> +	nr_fd =3D 0;
> +	ext4_lock_group(sb, group);
> +	rbtree_postorder_for_each_entry_safe(fd, nfd,
> +			&db->bb_free_root, efd_node) {
> +		if (fd->efd_tid !=3D commit_tid)
> +			continue;
> +
> +		mb_debug(sb, "gonna free %u blocks in group %u (0x%p):",
> +			 fd->efd_count, fd->efd_group, fd);
> +		atomic_sub(fd->efd_count, =
&EXT4_SB(sb)->s_mb_free_pending);
> +		cnt +=3D fd->efd_count;
> +		nr_fd++;
> +		rb_erase(&fd->efd_node, &db->bb_free_root);
> +		mb_free_blocks(NULL, &e4b, fd->efd_start_cluster, =
fd->efd_count);
> +		if (test_opt(sb, DISCARD))
> +			ext4_insert_free_data(&db->bb_discard_root, fd);
> +		else
> +			kmem_cache_free(ext4_free_data_cachep, fd);
> +	}
>=20
> 	/*
> 	 * Clear the trimmed flag for the group so that the next
> @@ -3055,22 +3117,22 @@ static void ext4_free_data_in_buddy(struct =
super_block *sb,
> 	 * If the volume is mounted with -o discard, online discard
> 	 * is supported and the free blocks will be trimmed online.
> 	 */
> -	if (!test_opt(sb, DISCARD))
> +	if (!test_opt(sb, DISCARD) && cnt)
> 		EXT4_MB_GRP_CLEAR_TRIMMED(db);
>=20
> -	if (!db->bb_free_root.rb_node) {
> +	if (RB_EMPTY_ROOT(&db->bb_free_root) && cnt) {
> 		/* No more items in the per group rb tree
> 		 * balance refcounts from ext4_mb_free_metadata()
> 		 */
> 		put_page(e4b.bd_buddy_page);
> 		put_page(e4b.bd_bitmap_page);
> 	}
> -	ext4_unlock_group(sb, entry->efd_group);
> -	kmem_cache_free(ext4_free_data_cachep, entry);
> +	ext4_unlock_group(sb, group);
> 	ext4_mb_unload_buddy(&e4b);
>=20
> -	mb_debug(sb, "freed %d blocks in %d structures\n", count,
> -		 count2);
> +	mb_debug(sb, "freed %d blocks in %d structures\n", cnt, nr_fd);
> +
> +	return nr_fd;
> }
>=20
> /*
> @@ -3081,52 +3143,21 @@ void ext4_process_freed_data(struct =
super_block *sb, tid_t commit_tid)
> {
> 	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
> 	ext4_group_t ngroups =3D ext4_get_groups_count(sb);
> -	struct ext4_free_data *fd, *nfd;
> 	struct ext4_group_info *grp;
> -	struct bio *discard_bio =3D NULL;
> -	struct list_head freed_data_list;
> -	int err, i;
> +	int i, nr;
>=20
> 	if (!atomic_read(&sbi->s_mb_free_pending))
> 		return;
>=20
> -	INIT_LIST_HEAD(&freed_data_list);
> -	for (i =3D 0; i < ngroups; i++) {
> +	for (i =3D 0, nr =3D 0; i < ngroups; i++) {
> 		grp =3D ext4_get_group_info(sb, i);
> -		ext4_lock_group(sb, i);
> -		rbtree_postorder_for_each_entry_safe(fd, nfd,
> -				&grp->bb_free_root, efd_node) {
> -			if (fd->efd_tid !=3D commit_tid)
> -				continue;
> -			INIT_LIST_HEAD(&fd->efd_list);
> -			list_add_tail(&fd->efd_list, &freed_data_list);
> -		}
> -		ext4_unlock_group(sb, i);
> -	}
> -
> -	if (test_opt(sb, DISCARD)) {
> -		list_for_each_entry(fd, &freed_data_list, efd_list) {
> -			err =3D ext4_issue_discard(sb, fd->efd_group,
> -						 fd->efd_start_cluster,
> -						 fd->efd_count,
> -						 &discard_bio);
> -			if (err && err !=3D -EOPNOTSUPP) {
> -				ext4_msg(sb, KERN_WARNING, "discard =
request in"
> -					 " group:%d block:%d count:%d =
failed"
> -					 " with %d", fd->efd_group,
> -					 fd->efd_start_cluster, =
fd->efd_count, err);
> -			} else if (err =3D=3D -EOPNOTSUPP)
> -				break;
> -		}
> -
> -		if (discard_bio) {
> -			submit_bio_wait(discard_bio);
> -			bio_put(discard_bio);
> -		}
> +		if (RB_EMPTY_ROOT(&grp->bb_free_root))
> +			continue;
> +		nr +=3D ext4_free_data_in_buddy(sb, i, commit_tid);
> 	}
>=20
> -	list_for_each_entry_safe(fd, nfd, &freed_data_list, efd_list)
> -		ext4_free_data_in_buddy(sb, fd);
> +	if (nr && test_opt(sb, DISCARD))
> +		queue_work(ext4_discard_wq, &sbi->s_discard_work);
> }
>=20
> int __init ext4_init_mballoc(void)
> @@ -3146,8 +3177,13 @@ int __init ext4_init_mballoc(void)
> 	if (ext4_free_data_cachep =3D=3D NULL)
> 		goto out_ac_free;
>=20
> -	return 0;
> +	ext4_discard_wq =3D alloc_workqueue("ext4discard", WQ_UNBOUND, =
0);
> +	if (!ext4_discard_wq)
> +		goto out_free_data;
>=20
> +	return 0;
> +out_free_data:
> +	kmem_cache_destroy(ext4_free_data_cachep);
> out_ac_free:
> 	kmem_cache_destroy(ext4_ac_cachep);
> out_pa_free:
> diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
> index e75b474..d76286b 100644
> --- a/fs/ext4/mballoc.h
> +++ b/fs/ext4/mballoc.h
> @@ -79,9 +79,6 @@
> #define MB_DEFAULT_MAX_INODE_PREALLOC	512
>=20
> struct ext4_free_data {
> -	/* this links the free block information from sb_info */
> -	struct list_head		efd_list;
> -
> 	/* this links the free block information from group_info */
> 	struct rb_node			efd_node;
>=20
> --
> 1.8.3.1


Cheers, Andreas






--Apple-Mail=_C4C033CF-45DC-482F-8F11-301CC3B4BE83
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmCv/p4ACgkQcqXauRfM
H+AfKBAAgrw0CfjmsMrI0yQmFdESqwabPJsxuHfNN/hf2b2LFXzBRDpDdl2A+MDh
yeQ0i46mB60jGoU4Uv+BBYGcXPr7xJLdotchJsxaZ2k+bs+Z2Y7XIyG7Fu1OjgmB
pMbJOzaHXkK6ovTLbtN1NgnXPIGuo+4QPoEoSuLGx6iQh8yW3yZp4dzBBE9ItkUZ
cfDsic+ebay4usisdc9p46y4ISIPvb8WvNVbzdlJhog1PFD9G3VFnX4r/saz0JID
dy+rrZ9D9VmW/uE+VVmcU0pVNLGm+1Oa76Zr9FTsCvVPpudHdxLQofjKYFhbfA6Z
kxZu8ansoweNFr04fBgBUoUxx57OSDzO3GmQmyreLy1H9crg4XQHNkx8R5/T8/Od
25SeA5H+mW07Nk/Y38BkWnsb2O10bK1Oo5DpNlTUDnpQ1msEdoQfs9M1pCThjCcW
yNCxHcrT2F6OF7FYTyL2/9cRt5BPdxPhsQfXgsLQbeN0MIRgk0s4ffISYOpg0c6J
H35vhzloRPf5SL2xkj5cpf1bLnxI+EUBq2KACIrNVXrEV68i3fLHHCh2RAZCFY0I
6voODFZLfv+eohJWfQTVepOSkwtGdTdWQqBk4IqASv2ct1VQkD4g7g+81ZUT8FGj
BGdH5LRMw8FjSMX2vQUUh12AW142cZiDxHjhvIAJYzRVblYC56w=
=k38Y
-----END PGP SIGNATURE-----

--Apple-Mail=_C4C033CF-45DC-482F-8F11-301CC3B4BE83--
