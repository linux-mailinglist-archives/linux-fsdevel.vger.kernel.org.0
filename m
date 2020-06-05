Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D22631EF205
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 09:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgFEHdH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 03:33:07 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:34634 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgFEHdG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 03:33:06 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200605073302epoutp041eeae61383b6e2edf07e6f391e612374~VlXc955gZ2573325733epoutp04F
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2020 07:33:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200605073302epoutp041eeae61383b6e2edf07e6f391e612374~VlXc955gZ2573325733epoutp04F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591342382;
        bh=IYmVT6LXiTfKRU5NQZmPFl2JZaILX14zPoksKb2X3nU=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Mt/1itLzzAquYeIS3LkByB6ZHu7P2mYYWimLzG8FwZie6Ku5y9G1mjDQNiuyFrN2n
         PLjFvo3pv2anSnZEUpwisULa2sZPAcaSBDcqSadu8KPZH4qgo4oNw1qVis5lRRZL7a
         pxkUqMVzXZoyW7Ojq9pDYl7XbPlQHsgqf+ugz9wg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200605073300epcas1p21d1618e5ae79ea37023fa7a55f59507f~VlXaf1WlI2178421784epcas1p2N;
        Fri,  5 Jun 2020 07:33:00 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.160]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 49dZB25xXRzMqYkf; Fri,  5 Jun
        2020 07:32:58 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        56.E0.18978.925F9DE5; Fri,  5 Jun 2020 16:32:57 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200605073254epcas1p20c70f0d1525c1c53e235b6f11dc769fe~VlXU-kZ4d2178421784epcas1p2C;
        Fri,  5 Jun 2020 07:32:54 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200605073254epsmtrp18da38ef533826faf6f160f7fc13ae1bc~VlXU_0zlR0424504245epsmtrp1j;
        Fri,  5 Jun 2020 07:32:54 +0000 (GMT)
X-AuditID: b6c32a35-603ff70000004a22-25-5ed9f529b882
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B2.2E.08303.525F9DE5; Fri,  5 Jun 2020 16:32:54 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200605073253epsmtip16987614e03d5729ed8e5eb2dffda4f17~VlXUwz_Gd2581525815epsmtip1S;
        Fri,  5 Jun 2020 07:32:53 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200604084445.19205-3-kohada.t2@gmail.com>
Subject: RE: [PATCH 3/3] exfat: set EXFAT_SB_DIRTY and VOL_DIRTY at the same
 timing
Date:   Fri, 5 Jun 2020 16:32:53 +0900
Message-ID: <000401d63b0b$8664f290$932ed7b0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLXKQP27k1kxA/L0Bi34tDQsKzyRwIaHrMyAgnBFJmmppquoA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmvq7m15txBu3L5Cx+zL3NYvHm5FQW
        iz17T7JYXN41h83i8v9PLBbLvkxmsdjy7wirA7vHlznH2T3aJv9j92g+tpLNY+esu+wefVtW
        MXp83iQXwBaVY5ORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6Dr
        lpkDdIuSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8DQoECvODG3uDQvXS85P9fK
        0MDAyBSoMiEno+vZKfaCh74Ve5/9Y2pgPGXfxcjBISFgItGzTauLkYtDSGAHo8S/xtcsEM4n
        RokFy2exQjifGSXenNzL1sXICdZxYcVjqKpdjBJ7l/dBVb1klJgwdQkLSBWbgK7Evz/7wTpE
        BPQkTp68zgZSxCzQyCSx/MQXZpAEp4ClRN+9P6wgtrBAqETr483sIDaLgIrE3rONjCA2L1DN
        9K5rLBC2oMTJmU/AbGYBeYntb+cwQ5ykIPHz6TJWiGVOEtu6H7JB1IhIzO5sYwZZLCEwl0Pi
        7Id/UD+4SJxf9RCqWVji1fEt7BC2lMTL/jZ2SMhUS3zcD1XSwSjx4rsthG0scXP9BlaQEmYB
        TYn1u/QhwooSO3/PZYRYyyfx7msPK8QUXomONiGIElWJvkuHmSBsaYmu9g/sExiVZiF5bBaS
        x2YheWAWwrIFjCyrGMVSC4pz01OLDQsMkSN7EyM4nWqZ7mCc+PaD3iFGJg7GQ4wSHMxKIrzP
        fW/GCfGmJFZWpRblxxeV5qQWH2I0BQb1RGYp0eR8YELPK4k3NDUyNja2MDEzNzM1VhLnFZe5
        ECckkJ5YkpqdmlqQWgTTx8TBKdXAtFlDQbxGdl3fFrel8ztLly7zOa6uxG7vP/2pJmOXnWWM
        kY7d08M+fd0dV6X0627tCl6+NSP5oA3v7z0ygtOKd98MmHyhft2ODTutjlS1Hjnh3/+D++3T
        8onmFwTMHL5v/cwl+KCWKeTxr+8vuNb9mcxwacHuuy7sd5+vuKy6lVFf4yxTzIJQswUHFDbt
        ZujyrUnqKNw/wcCk6d21lu8O0+Yxp+muWXyg7NikoLUqcw8v0gxxkrEQsQtbOlslc1NL0g+D
        C9U/N/8qYjnq3KHJuPD3pDT2mVa7xZhndLg3PMzljfFjsHYz0xcO27/TUHBucn/FhEWPe8sl
        ci989511wifoQky74rfW+uIrhp5eSizFGYmGWsxFxYkAEPuY4jAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42LZdlhJTlft6804g+b1jBY/5t5msXhzciqL
        xZ69J1ksLu+aw2Zx+f8nFotlXyazWGz5d4TVgd3jy5zj7B5tk/+xezQfW8nmsXPWXXaPvi2r
        GD0+b5ILYIvisklJzcksSy3St0vgyuh6doq94KFvxd5n/5gaGE/ZdzFyckgImEhcWPGYpYuR
        i0NIYAejxOyrj9khEtISx06cYe5i5ACyhSUOHy6GqHnOKDFp4QlGkBo2AV2Jf3/2s4HYIgJ6
        EidPXmcDKWIWaGaS+PZsCTNEx3ZGia7+2WAdnAKWEn33/rCC2MICwRKLrhwCi7MIqEjsPdsI
        ZvMC1UzvusYCYQtKnJz5hAXkCmagDW0bwUqYBeQltr+dwwxxqILEz6fLWCGOcJLY1v2QDaJG
        RGJ2ZxvzBEbhWUgmzUKYNAvJpFlIOhYwsqxilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/d
        xAiOKy2tHYx7Vn3QO8TIxMF4iFGCg1lJhPe57804Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxf
        Zy2MExJITyxJzU5NLUgtgskycXBKNTBpxv1eKcntkhbV0ZJ2PzsjYlNNov7OoCX9eW8dHY47
        JSw4WWUrm/omw0aoqoPF33NF1Z0CzeMhx9pTPDxlY7PEuD9aSx+W1pGd933Ks+r3nt6sWtGF
        628IHXmTtW+n1BQj96zDpRu/xp9OeHxuvZlh/8bE/tnBbianv7Gl6nce2Ch2yKegvFZHcgGn
        9/W2onm9J7NWq26N/jA9dKtD7GSJBD+xzoNB79Tcrvx6MdcnRuza7MKExJzyZfMnMcY8en79
        tqPdDZ/fQif8jHJcjU98OKz4sLG61q5Sdbq+xFb2JzY7TqpszD8SvG+eyZ6GX6El1UKHd1bp
        PfyTXHVod3KIcQsH39uzbVonC88nKrEUZyQaajEXFScCAHo+F8AaAwAA
X-CMS-MailID: 20200605073254epcas1p20c70f0d1525c1c53e235b6f11dc769fe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200604084534epcas1p281a332cd6d556b5d6c0ae61ec816c5a4
References: <20200604084445.19205-1-kohada.t2@gmail.com>
        <CGME20200604084534epcas1p281a332cd6d556b5d6c0ae61ec816c5a4@epcas1p2.samsung.com>
        <20200604084445.19205-3-kohada.t2@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Set EXFAT_SB_DIRTY flag in exfat_put_super().
> 
> In some cases, can't clear VOL_DIRTY with 'sync'.
> ex:
> 
> VOL_DIRTY is set when rmdir starts, but when non-empty-dir is detected, return error without setting
> EXFAT_SB_DIRTY.
> If performe 'sync' in this state, VOL_DIRTY will not be cleared.
Good catch.

Can you split this patch into two? (Don't set VOL_DIRTY on -ENOTEMPTY and Setting EXFAT_SB_DIRTY is
merged into exfat_set_vol_flag). I need to check the second one more.

Thanks!
> 
> Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
> ---
>  fs/exfat/balloc.c   |  4 ++--
>  fs/exfat/dir.c      | 18 ++++++++----------
>  fs/exfat/exfat_fs.h |  2 +-
>  fs/exfat/fatent.c   |  6 +-----
>  fs/exfat/misc.c     |  3 +--
>  fs/exfat/namei.c    | 12 ++++++------
>  fs/exfat/super.c    |  3 +++
>  7 files changed, 22 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c index 4055eb00ea9b..a987919686c0 100644
> --- a/fs/exfat/balloc.c
> +++ b/fs/exfat/balloc.c
> @@ -158,7 +158,7 @@ int exfat_set_bitmap(struct inode *inode, unsigned int clu)
>  	b = BITMAP_OFFSET_BIT_IN_SECTOR(sb, ent_idx);
> 
>  	set_bit_le(b, sbi->vol_amap[i]->b_data);
> -	exfat_update_bh(sb, sbi->vol_amap[i], IS_DIRSYNC(inode));
> +	exfat_update_bh(sbi->vol_amap[i], IS_DIRSYNC(inode));
>  	return 0;
>  }
> 
> @@ -180,7 +180,7 @@ void exfat_clear_bitmap(struct inode *inode, unsigned int clu)
>  	b = BITMAP_OFFSET_BIT_IN_SECTOR(sb, ent_idx);
> 
>  	clear_bit_le(b, sbi->vol_amap[i]->b_data);
> -	exfat_update_bh(sb, sbi->vol_amap[i], IS_DIRSYNC(inode));
> +	exfat_update_bh(sbi->vol_amap[i], IS_DIRSYNC(inode));
> 
>  	if (opts->discard) {
>  		int ret_discard;
> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c index 3eb8386fb5f2..96c9a817d928 100644
> --- a/fs/exfat/dir.c
> +++ b/fs/exfat/dir.c
> @@ -468,7 +468,7 @@ int exfat_init_dir_entry(struct inode *inode, struct exfat_chain *p_dir,
>  			&ep->dentry.file.access_date,
>  			NULL);
> 
> -	exfat_update_bh(sb, bh, IS_DIRSYNC(inode));
> +	exfat_update_bh(bh, IS_DIRSYNC(inode));
>  	brelse(bh);
> 
>  	ep = exfat_get_dentry(sb, p_dir, entry + 1, &bh, &sector); @@ -478,7 +478,7 @@ int
> exfat_init_dir_entry(struct inode *inode, struct exfat_chain *p_dir,
>  	exfat_init_stream_entry(ep,
>  		(type == TYPE_FILE) ? ALLOC_FAT_CHAIN : ALLOC_NO_FAT_CHAIN,
>  		start_clu, size);
> -	exfat_update_bh(sb, bh, IS_DIRSYNC(inode));
> +	exfat_update_bh(bh, IS_DIRSYNC(inode));
>  	brelse(bh);
> 
>  	return 0;
> @@ -514,7 +514,7 @@ int exfat_update_dir_chksum(struct inode *inode, struct exfat_chain *p_dir,
>  	}
> 
>  	fep->dentry.file.checksum = cpu_to_le16(chksum);
> -	exfat_update_bh(sb, fbh, IS_DIRSYNC(inode));
> +	exfat_update_bh(fbh, IS_DIRSYNC(inode));
>  release_fbh:
>  	brelse(fbh);
>  	return ret;
> @@ -536,7 +536,7 @@ int exfat_init_ext_entry(struct inode *inode, struct exfat_chain *p_dir,
>  		return -EIO;
> 
>  	ep->dentry.file.num_ext = (unsigned char)(num_entries - 1);
> -	exfat_update_bh(sb, bh, sync);
> +	exfat_update_bh(bh, sync);
>  	brelse(bh);
> 
>  	ep = exfat_get_dentry(sb, p_dir, entry + 1, &bh, &sector); @@ -545,7 +545,7 @@ int
> exfat_init_ext_entry(struct inode *inode, struct exfat_chain *p_dir,
> 
>  	ep->dentry.stream.name_len = p_uniname->name_len;
>  	ep->dentry.stream.name_hash = cpu_to_le16(p_uniname->name_hash);
> -	exfat_update_bh(sb, bh, sync);
> +	exfat_update_bh(bh, sync);
>  	brelse(bh);
> 
>  	for (i = EXFAT_FIRST_CLUSTER; i < num_entries; i++) { @@ -554,7 +554,7 @@ int
> exfat_init_ext_entry(struct inode *inode, struct exfat_chain *p_dir,
>  			return -EIO;
> 
>  		exfat_init_name_entry(ep, uniname);
> -		exfat_update_bh(sb, bh, sync);
> +		exfat_update_bh(bh, sync);
>  		brelse(bh);
>  		uniname += EXFAT_FILE_NAME_LEN;
>  	}
> @@ -578,7 +578,7 @@ int exfat_remove_entries(struct inode *inode, struct exfat_chain *p_dir,
>  			return -EIO;
> 
>  		exfat_set_entry_type(ep, TYPE_DELETED);
> -		exfat_update_bh(sb, bh, IS_DIRSYNC(inode));
> +		exfat_update_bh(bh, IS_DIRSYNC(inode));
>  		brelse(bh);
>  	}
> 
> @@ -606,10 +606,8 @@ int exfat_free_dentry_set(struct exfat_entry_set_cache *es, int sync)  {
>  	int i, err = 0;
> 
> -	if (es->modified) {
> -		set_bit(EXFAT_SB_DIRTY, &EXFAT_SB(es->sb)->s_state);
> +	if (es->modified)
>  		err = exfat_update_bhs(es->bh, es->num_bh, sync);
> -	}
> 
>  	for (i = 0; i < es->num_bh; i++)
>  		err ? bforget(es->bh[i]):brelse(es->bh[i]);
> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h index f4fa0e833486..0e094d186612 100644
> --- a/fs/exfat/exfat_fs.h
> +++ b/fs/exfat/exfat_fs.h
> @@ -514,7 +514,7 @@ void exfat_set_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
>  		u8 *tz, __le16 *time, __le16 *date, u8 *time_cs);
>  u16 exfat_calc_chksum16(void *data, int len, u16 chksum, int type);
>  u32 exfat_calc_chksum32(void *data, int len, u32 chksum, int type); -void exfat_update_bh(struct
> super_block *sb, struct buffer_head *bh, int sync);
> +void exfat_update_bh(struct buffer_head *bh, int sync);
>  int exfat_update_bhs(struct buffer_head **bhs, int nr_bhs, int sync);  void exfat_chain_set(struct
> exfat_chain *ec, unsigned int dir,
>  		unsigned int size, unsigned char flags); diff --git a/fs/exfat/fatent.c
> b/fs/exfat/fatent.c index 5d11bc2f1b68..f8171183b4c1 100644
> --- a/fs/exfat/fatent.c
> +++ b/fs/exfat/fatent.c
> @@ -75,7 +75,7 @@ int exfat_ent_set(struct super_block *sb, unsigned int loc,
> 
>  	fat_entry = (__le32 *)&(bh->b_data[off]);
>  	*fat_entry = cpu_to_le32(content);
> -	exfat_update_bh(sb, bh, sb->s_flags & SB_SYNCHRONOUS);
> +	exfat_update_bh(bh, sb->s_flags & SB_SYNCHRONOUS);
>  	exfat_mirror_bh(sb, sec, bh);
>  	brelse(bh);
>  	return 0;
> @@ -174,7 +174,6 @@ int exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain)
>  		return -EIO;
>  	}
> 
> -	set_bit(EXFAT_SB_DIRTY, &sbi->s_state);
>  	clu = p_chain->dir;
> 
>  	if (p_chain->flags == ALLOC_NO_FAT_CHAIN) { @@ -261,7 +260,6 @@ int exfat_zeroed_cluster(struct
> inode *dir, unsigned int clu)
>  			memset(bhs[n]->b_data, 0, sb->s_blocksize);
>  		}
> 
> -		set_bit(EXFAT_SB_DIRTY, &sbi->s_state);
>  		err = exfat_update_bhs(bhs, n, IS_DIRSYNC(dir));
>  		if (err)
>  			goto release_bhs;
> @@ -326,8 +324,6 @@ int exfat_alloc_cluster(struct inode *inode, unsigned int num_alloc,
>  		}
>  	}
> 
> -	set_bit(EXFAT_SB_DIRTY, &sbi->s_state);
> -
>  	p_chain->dir = EXFAT_EOF_CLUSTER;
> 
>  	while ((new_clu = exfat_find_free_bitmap(sb, hint_clu)) != diff --git a/fs/exfat/misc.c
> b/fs/exfat/misc.c index dc34968e99d3..564718747fb2 100644
> --- a/fs/exfat/misc.c
> +++ b/fs/exfat/misc.c
> @@ -163,9 +163,8 @@ u32 exfat_calc_chksum32(void *data, int len, u32 chksum, int type)
>  	return chksum;
>  }
> 
> -void exfat_update_bh(struct super_block *sb, struct buffer_head *bh, int sync)
> +void exfat_update_bh(struct buffer_head *bh, int sync)
>  {
> -	set_bit(EXFAT_SB_DIRTY, &EXFAT_SB(sb)->s_state);
>  	set_buffer_uptodate(bh);
>  	mark_buffer_dirty(bh);
> 
> diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c index 5b0f35329d63..e36c9fc4a5d6 100644
> --- a/fs/exfat/namei.c
> +++ b/fs/exfat/namei.c
> @@ -387,7 +387,7 @@ static int exfat_find_empty_entry(struct inode *inode,
>  			ep->dentry.stream.valid_size = cpu_to_le64(size);
>  			ep->dentry.stream.size = ep->dentry.stream.valid_size;
>  			ep->dentry.stream.flags = p_dir->flags;
> -			exfat_update_bh(sb, bh, IS_DIRSYNC(inode));
> +			exfat_update_bh(bh, IS_DIRSYNC(inode));
>  			brelse(bh);
>  			if (exfat_update_dir_chksum(inode, &(ei->dir),
>  			    ei->entry))
> @@ -1071,7 +1071,7 @@ static int exfat_rename_file(struct inode *inode, struct exfat_chain *p_dir,
>  			epnew->dentry.file.attr |= cpu_to_le16(ATTR_ARCHIVE);
>  			ei->attr |= ATTR_ARCHIVE;
>  		}
> -		exfat_update_bh(sb, new_bh, sync);
> +		exfat_update_bh(new_bh, sync);
>  		brelse(old_bh);
>  		brelse(new_bh);
> 
> @@ -1083,7 +1083,7 @@ static int exfat_rename_file(struct inode *inode, struct exfat_chain *p_dir,
>  			return -EIO;
> 
>  		memcpy(epnew, epold, DENTRY_SIZE);
> -		exfat_update_bh(sb, new_bh, sync);
> +		exfat_update_bh(new_bh, sync);
>  		brelse(old_bh);
>  		brelse(new_bh);
> 
> @@ -1100,7 +1100,7 @@ static int exfat_rename_file(struct inode *inode, struct exfat_chain *p_dir,
>  			epold->dentry.file.attr |= cpu_to_le16(ATTR_ARCHIVE);
>  			ei->attr |= ATTR_ARCHIVE;
>  		}
> -		exfat_update_bh(sb, old_bh, sync);
> +		exfat_update_bh(old_bh, sync);
>  		brelse(old_bh);
>  		ret = exfat_init_ext_entry(inode, p_dir, oldentry,
>  			num_new_entries, p_uniname);
> @@ -1155,7 +1155,7 @@ static int exfat_move_file(struct inode *inode, struct exfat_chain *p_olddir,
>  		epnew->dentry.file.attr |= cpu_to_le16(ATTR_ARCHIVE);
>  		ei->attr |= ATTR_ARCHIVE;
>  	}
> -	exfat_update_bh(sb, new_bh, IS_DIRSYNC(inode));
> +	exfat_update_bh(new_bh, IS_DIRSYNC(inode));
>  	brelse(mov_bh);
>  	brelse(new_bh);
> 
> @@ -1167,7 +1167,7 @@ static int exfat_move_file(struct inode *inode, struct exfat_chain *p_olddir,
>  		return -EIO;
> 
>  	memcpy(epnew, epmov, DENTRY_SIZE);
> -	exfat_update_bh(sb, new_bh, IS_DIRSYNC(inode));
> +	exfat_update_bh(new_bh, IS_DIRSYNC(inode));
>  	brelse(mov_bh);
>  	brelse(new_bh);
> 
> diff --git a/fs/exfat/super.c b/fs/exfat/super.c index e650e65536f8..199a1e78f9e5 100644
> --- a/fs/exfat/super.c
> +++ b/fs/exfat/super.c
> @@ -104,6 +104,9 @@ int exfat_set_vol_flags(struct super_block *sb, unsigned short new_flag)
>  	struct boot_sector *p_boot = (struct boot_sector *)sbi->boot_bh->b_data;
>  	bool sync;
> 
> +	if (new_flag == VOL_DIRTY)
> +		set_bit(EXFAT_SB_DIRTY, &sbi->s_state);
> +
>  	/* flags are not changed */
>  	if (sbi->vol_flag == new_flag)
>  		return 0;
> --
> 2.25.1


