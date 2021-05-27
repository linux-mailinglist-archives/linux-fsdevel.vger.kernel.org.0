Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68423936D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 22:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235683AbhE0ULD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 16:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235508AbhE0UK7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 16:10:59 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4369AC061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 May 2021 13:09:25 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id v12so498229plo.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 May 2021 13:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=6VwlB2Tc0IkHPxnbnp1OXxNLyZThxA06dLXoz3MCtW0=;
        b=mXT59a/QbPb2D53xTbnC9yvp3O0yneCpikemXt+PG5nNqzw4+qmPzHGtp7qltoRe1M
         WT7KNwqJ/BqNhR37hypnc+CRstB/Ae3GisA+otpuKy3KgWQ10FH+QBtnc91IauFPZljy
         ZaNXZ2Pa9v47MuNLfg1JQYLe4q82QsXwPgiw9Mz3maPuEILllxp2NSL6ZT8pphn/8bQy
         PHCBXAWX2Hinr4Xft1oOeW5M+i8imZRfIV11M9O3O/rfvKu+sErKttdt6ETXpC1BHhfp
         IdZlpdiZsGJ01R6wdjWA03MXJCM1z80UWBPxVJdxCKew93jt54lVzkGmtiPqnTjVouI3
         agBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=6VwlB2Tc0IkHPxnbnp1OXxNLyZThxA06dLXoz3MCtW0=;
        b=TktxFkhbT8NpKUyL97b1XiCgsvgGmKufsTFWyzPoAzm9QKa8RfdV/p4gEPOUZoZL8u
         O1iICu9y5QiiYOUeJ/SfdaWh8Y/WEsDG6dgssBGD9RnyyICfElwLSlbAK2FG9wdVoxbB
         lqNwNlNB7F8xLd9r1C+ajVOmCoSUPj6sVc8U3IHWbv3syopz/Dmqlkwr5y8lFrtzgTVk
         /ifUZK3vRAv980ECOUZ7GQKXniAdb4d7AjaJAoy9zGWPS0ePfMg9umkSyD5GpsLmiI7l
         hMVABCaePMG4Mtn7hK85KRjbB9URjKeZ0Ix/9lyzwEm2Tdq2PNwIjPalgV506I7D63W2
         KrtQ==
X-Gm-Message-State: AOAM530JT6OhrLu/N7g2IyfBHqZfg0cp7eQFnHEMwaEAYXKk0/aCCFA/
        m9h6K1Y//b/BWWSxI4gjFLSetg==
X-Google-Smtp-Source: ABdhPJz3mdvmJEPF0MLZvalrslrWmZ27YtfzTHThy53OLFa5c79vdkr5A2S/YxoW3pm9lC7qVV6GGg==
X-Received: by 2002:a17:90a:f18e:: with SMTP id bv14mr167249pjb.234.1622146164673;
        Thu, 27 May 2021 13:09:24 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id h24sm2603937pfn.180.2021.05.27.13.09.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 May 2021 13:09:24 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <D928EE21-92AA-40D8-BEAF-33A46E7DFFD3@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_D2F3CDB5-F4A7-4E22-BB6F-7D0F481045D5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH V2 4/7] ext4: add new helper interface
 ext4_insert_free_data
Date:   Thu, 27 May 2021 14:09:22 -0600
In-Reply-To: <83fab578-b170-c515-d514-1ed366f07e8a@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        lishujin@kuaishou.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
To:     Wang Jianchao <jianchao.wan9@gmail.com>
References: <164ffa3b-c4d5-6967-feba-b972995a6dfb@gmail.com>
 <a602a6ba-2073-8384-4c8f-d669ee25c065@gmail.com>
 <49382052-6238-f1fb-40d1-b6b801b39ff7@gmail.com>
 <48e33dea-d15e-f211-0191-e01bd3eb17b3@gmail.com>
 <83fab578-b170-c515-d514-1ed366f07e8a@gmail.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_D2F3CDB5-F4A7-4E22-BB6F-7D0F481045D5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On May 26, 2021, at 2:43 AM, Wang Jianchao <jianchao.wan9@gmail.com> =
wrote:
>=20
> Split the codes that inserts and merges ext4_free_data structures
> into a new interface ext4_insert_free_data. This is preparing for
> following async background discard.

Thank you for your patch series.  I think this is an important area to
improve, since the current "-o discard" option adds too much overhead
to be really usable in practice.

One problem with tracking the fine-grained freed extents and then using
them directly to submit TRIM requests is that the underlying device may
ignore TRIM requests that are too small.  Submitting the TRIM right
after each transaction commit does not allow much time for freed blocks
to be aggregated (e.g. "rm -r" of a big directory tree), so it would be
better to delay TRIM requests until more freed extents can be merged.
Since most users only run fstrim once a day or every few days, it makes
sense to allow time to merge freed space (tunable, maybe 5-15 minutes).

However, tracking the rbtree for each group may be quite a lot of =
overhead
if this is kept in memory for minutes or hours, so minimizing the memory
usage to track freed extents is also important.

We discussed on the ext4 developer call today whether it is necessary
to track the fine-grained free extents in memory, or if it would be
better to only track min/max freed blocks within each group?  Depending
on the fragmentation of the free blocks in the group, it may be enough
to just store a single bit in each group (as is done today), and only
clear this when there are blocks freed in the group.

Either way, the improvement would be that the kernel is scheduling
groups to be trimmed, and submitting TRIM requests at a much larger =
size,
instead of depending on userspace to run fstrim.  This also allows the
fstrim scheduler to decide when the device is less busy and submit more
TRIM requests, and back off when the device is busy.

The other potential improvement is to track the TRIMMED state =
persistently
in the block groups, so that unmount/remount doesn't result in every =
group
being trimmed again.  It would be good to refresh and include patches =
from:

"ext4: introduce EXT4_BG_WAS_TRIMMED to optimize trim"
https://patchwork.ozlabs.org/project/linux-ext4/list/?series=3D184981

and

e2fsprogs: add EXT2_FLAG_BG_WAS_TRIMMED to optimize fstrim
https://patchwork.ozlabs.org/project/linux-ext4/list/?series=3D179639

along with this series.

> Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>
> ---
> fs/ext4/mballoc.c | 96 =
+++++++++++++++++++++++++++++--------------------------
> 1 file changed, 51 insertions(+), 45 deletions(-)
>=20
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 85418cf..16f06d2 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -350,6 +350,12 @@ static void ext4_mb_generate_from_pa(struct =
super_block *sb, void *bitmap,
> static void ext4_mb_generate_from_freelist(struct super_block *sb, =
void *bitmap,
> 						ext4_group_t group);
> static void ext4_mb_new_preallocation(struct ext4_allocation_context =
*ac);
> +static inline struct ext4_free_data *efd_entry(struct rb_node *n)
> +{
> +	return rb_entry_safe(n, struct ext4_free_data, efd_node);
> +}
> +static int ext4_insert_free_data(struct ext4_sb_info *sbi,
> +		struct rb_root *root, struct ext4_free_data *nfd);
>=20
> /*
>  * The algorithm using this percpu seq counter goes below:
> @@ -5069,28 +5075,53 @@ static void ext4_try_merge_freed_extent(struct =
ext4_sb_info *sbi,
> 	kmem_cache_free(ext4_free_data_cachep, entry);
> }
>=20
> +static int ext4_insert_free_data(struct ext4_sb_info *sbi,
> +		struct rb_root *root, struct ext4_free_data *nfd)
> +{
> +	struct rb_node **n =3D &root->rb_node;
> +	struct rb_node *p =3D NULL;
> +	struct ext4_free_data *fd;
> +
> +	while (*n) {
> +		p =3D *n;
> +		fd =3D rb_entry(p, struct ext4_free_data, efd_node);
> +		if (nfd->efd_start_cluster < fd->efd_start_cluster)
> +			n =3D &(*n)->rb_left;
> +		else if (nfd->efd_start_cluster >=3D
> +			 (fd->efd_start_cluster + fd->efd_count))
> +			n =3D &(*n)->rb_right;
> +		else
> +			return -EINVAL;
> +	}
> +
> +	rb_link_node(&nfd->efd_node, p, n);
> +	rb_insert_color(&nfd->efd_node, root);
> +
> +	/* Now try to see the extent can be merged to left and right */
> +	fd =3D efd_entry(rb_prev(&nfd->efd_node));
> +	if (fd)
> +		ext4_try_merge_freed_extent(sbi, fd, nfd, root);
> +
> +	fd =3D efd_entry(rb_next(&nfd->efd_node));
> +	if (fd)
> +		ext4_try_merge_freed_extent(sbi, fd, nfd, root);
> +
> +	return 0;
> +}
> +
> static noinline_for_stack int
> ext4_mb_free_metadata(handle_t *handle, struct ext4_buddy *e4b,
> -		      struct ext4_free_data *new_entry)
> +		      struct ext4_free_data *nfd)
> {
> -	ext4_group_t group =3D e4b->bd_group;
> -	ext4_grpblk_t cluster;
> -	ext4_grpblk_t clusters =3D new_entry->efd_count;
> -	struct ext4_free_data *entry;
> 	struct ext4_group_info *db =3D e4b->bd_info;
> 	struct super_block *sb =3D e4b->bd_sb;
> 	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
> -	struct rb_node **n =3D &db->bb_free_root.rb_node, *node;
> -	struct rb_node *parent =3D NULL, *new_node;
>=20
> 	BUG_ON(!ext4_handle_valid(handle));
> 	BUG_ON(e4b->bd_bitmap_page =3D=3D NULL);
> 	BUG_ON(e4b->bd_buddy_page =3D=3D NULL);
>=20
> -	new_node =3D &new_entry->efd_node;
> -	cluster =3D new_entry->efd_start_cluster;
> -
> -	if (!*n) {
> +	if (!db->bb_free_root.rb_node) {
> 		/* first free block exent. We need to
> 		   protect buddy cache from being freed,
> 		 * otherwise we'll refresh it from
> @@ -5099,44 +5130,19 @@ static void ext4_try_merge_freed_extent(struct =
ext4_sb_info *sbi,
> 		get_page(e4b->bd_buddy_page);
> 		get_page(e4b->bd_bitmap_page);
> 	}
> -	while (*n) {
> -		parent =3D *n;
> -		entry =3D rb_entry(parent, struct ext4_free_data, =
efd_node);
> -		if (cluster < entry->efd_start_cluster)
> -			n =3D &(*n)->rb_left;
> -		else if (cluster >=3D (entry->efd_start_cluster + =
entry->efd_count))
> -			n =3D &(*n)->rb_right;
> -		else {
> -			ext4_grp_locked_error(sb, group, 0,
> -				ext4_group_first_block_no(sb, group) +
> -				EXT4_C2B(sbi, cluster),
> -				"Block already on to-be-freed list");
> -			kmem_cache_free(ext4_free_data_cachep, =
new_entry);
> -			return 0;
> -		}
> -	}
> -
> -	rb_link_node(new_node, parent, n);
> -	rb_insert_color(new_node, &db->bb_free_root);
> -
> -	/* Now try to see the extent can be merged to left and right */
> -	node =3D rb_prev(new_node);
> -	if (node) {
> -		entry =3D rb_entry(node, struct ext4_free_data, =
efd_node);
> -		ext4_try_merge_freed_extent(sbi, entry, new_entry,
> -					    &(db->bb_free_root));
> -	}
>=20
> -	node =3D rb_next(new_node);
> -	if (node) {
> -		entry =3D rb_entry(node, struct ext4_free_data, =
efd_node);
> -		ext4_try_merge_freed_extent(sbi, entry, new_entry,
> -					    &(db->bb_free_root));
> +	if (ext4_insert_free_data(sbi, &db->bb_free_root, nfd)) {
> +		ext4_grp_locked_error(sb, e4b->bd_group, 0,
> +				ext4_group_first_block_no(sb, =
e4b->bd_group) +
> +				EXT4_C2B(sbi, nfd->efd_start_cluster),
> +				"Block already on to-be-freed list");
> +		kmem_cache_free(ext4_free_data_cachep, nfd);
> +		return 0;
> 	}
>=20
> 	spin_lock(&sbi->s_md_lock);
> -	list_add_tail(&new_entry->efd_list, &sbi->s_freed_data_list);
> -	sbi->s_mb_free_pending +=3D clusters;
> +	list_add_tail(&nfd->efd_list, &sbi->s_freed_data_list);
> +	sbi->s_mb_free_pending +=3D nfd->efd_count;
> 	spin_unlock(&sbi->s_md_lock);
> 	return 0;
> }
> --
> 1.8.3.1
>=20


Cheers, Andreas






--Apple-Mail=_D2F3CDB5-F4A7-4E22-BB6F-7D0F481045D5
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmCv/HIACgkQcqXauRfM
H+DYBw/+LHeLPSpVAXJgmQR1LcGoY28KMcylMR0WsQhdSxyD835gH6QLsyiYIfvV
tEA3e1aRMTLJ2YL+yFajGcnGeWeMyCbZ3OGLPYVZZq9ssFsdDwqJZHl1Ws09hmve
az4k+fIhYPESdN89rwaCQYCkID6T7DXUMHMrmd+QVs8EVyBxQ+Peqk2KTq34aSu/
benclflejtdh1HSXmm+oQt0kLfpQty9Y31ELBdkIyU874w76JyhCL/ttyW4h2jrj
vIOUk9PzLF0BP3AbgWNI1U9a8E5HnreF2jnmXJytQaMZx/cKYVVuKxY1AGGxI24B
rSDR35YLdm3Y19XyhBJHG8bmzV30K/bOS5X8xFFumxoOrGIVqVBXqvHTH0Z4Ip2O
iSi8OEscKKTHspnEDQBgc9w4Lv+UBUWQT/mI8IvSrLvHIal2amRDE6VGRPc9f+sx
doquP5eRLAvqNOwo/b1o/w1Eyy2XxOhBTxB1oNk6lGlmbh/KIeswahcodgpykT50
KJIIKHiZXrbsWz65HEYOI7ijpXkCEZD+iSOusteWMcipy46b0/ByYzGHqf0GtXna
72cADLcUk/rnNijN7uIz3Ci8vcw3c6lhQbJi2Dq34MxIOX5sWVIqlPsQWs/47IKH
cGVDkcnga8Lazy+Z1L0P8dJoXI0Ux+u/YbFP16ORgyNKsn8cOik=
=vIZ2
-----END PGP SIGNATURE-----

--Apple-Mail=_D2F3CDB5-F4A7-4E22-BB6F-7D0F481045D5--
