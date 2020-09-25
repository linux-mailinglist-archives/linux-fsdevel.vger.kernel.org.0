Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD19277D60
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Sep 2020 03:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgIYBGK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 21:06:10 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:17559 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbgIYBGJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 21:06:09 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200925005812epoutp0211c6430186c33042be68788a98102c83~34OsQ4WL92873428734epoutp02O
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2020 00:58:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200925005812epoutp0211c6430186c33042be68788a98102c83~34OsQ4WL92873428734epoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1600995492;
        bh=yY4vQbux56tXZtWN33wn68QvpZOrzz1lQugW5oKJ6GY=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=dcc/42kd1Mfmv+4yqR13XCG5AZkCIWTebhVNsjWR5ZVFk3sYdiMjcaEmavR+5rCX6
         Fvzer7CYHEUmRPVLiCufI4aoyxIqDdoQazuE785yxWnQgvT7NTU77zaB57QJ0/Zxps
         u9bnvKfPK6YZQdQcltiW+2epzg9d+YRX4BoILvAI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200925005812epcas1p192a419439dd97d937fd8b648f8b7d460~34Or8nqdD0889708897epcas1p1U;
        Fri, 25 Sep 2020 00:58:12 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.163]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4ByD6p0znWzMqYkV; Fri, 25 Sep
        2020 00:58:10 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        03.90.10463.1A04D6F5; Fri, 25 Sep 2020 09:58:10 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200925005809epcas1p39cc2c1dbe964690828383fe762df9607~34OpZO_0O0148401484epcas1p3h;
        Fri, 25 Sep 2020 00:58:09 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200925005809epsmtrp270b21f36ed5d8a849dd2100565886dfb~34OpYhTc40994809948epsmtrp2C;
        Fri, 25 Sep 2020 00:58:09 +0000 (GMT)
X-AuditID: b6c32a38-f11ff700000028df-91-5f6d40a1ac1e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        77.2C.08745.1A04D6F5; Fri, 25 Sep 2020 09:58:09 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200925005809epsmtip1b3c768d9ac11d85a9644c25fee4453d6~34OpJUoS11718317183epsmtip1Y;
        Fri, 25 Sep 2020 00:58:09 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        "'Namjae Jeon'" <namjae.jeon@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200917013916.4523-1-kohada.t2@gmail.com>
Subject: RE: [PATCH v2] exfat: remove 'rwoffset' in exfat_inode_info
Date:   Fri, 25 Sep 2020 09:58:08 +0900
Message-ID: <716101d692d6$ef1dc2d0$cd594870$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQI3QAIiS02qQVZr3s2cWPTf2qgwLQKUIcn3qKKMmPA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmge4ih9x4g7ZZzBY/5t5msXhzciqL
        xZ69J1ksLu+aw2Zx+f8nFosf0+sd2Dy+zDnO7tF8bCWbx85Zd9k9+rasYvT4vEkugDUqxyYj
        NTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6AAlhbLEnFKg
        UEBicbGSvp1NUX5pSapCRn5xia1SakFKToGhQYFecWJucWleul5yfq6VoYGBkSlQZUJOxvK/
        G5kLJhlUtJ75wtrAuFiti5GTQ0LARGLnrS7GLkYuDiGBHYwSj1o3QDmfGCUm3HjPClIlJPCZ
        UaJ3jipMx8avO5kginYxSpzZ28AC4bxklDj8bysLSBWbgK7Ekxs/mUFsEQE9iZMnr7OBFDEL
        XGSU+Ph5B1A7BwengIXEjkmRIDXCAi4SCzZtYgexWQRUJf7v2sQEYvMKWEo8717GBmELSpyc
        +QRsPrOAvMT2t3OYIS5SkNj96SgryEgRASuJsy2aECUiErM725hB1koITOWQ+NJxmQmi3kVi
        zu9ZjBC2sMSr41vYIWwpic/v9rJB2PUS/+evZYdobmGUePhpG9jNEgL2Eu8vWYCYzAKaEut3
        6UOUK0rs/D2XEWIvn8S7rz2sENW8Eh1tQhAlKhLfP+xkgdl05cdVpgmMSrOQPDYLyWOzkHww
        C2HZAkaWVYxiqQXFuempxYYFJshxvYkRnDa1LHYwzn37Qe8QIxMH4yFGCQ5mJRHe4xty4oV4
        UxIrq1KL8uOLSnNSiw8xmgKDeiKzlGhyPjBx55XEG5oaGRsbW5iYmZuZGiuJ8z68pRAvJJCe
        WJKanZpakFoE08fEwSnVwNQds79ppsYea8eXQu7t7oIr5OXDosR7F85fYbqs6c8sl4J3EY6e
        OmHbDzlsmp20Szn3xhL5OSvYw49IRy9fnZxr5v7n4uz8BQm9fdd/r/gyvfzVotJ9BT9q55Y8
        Wx10Ws641GENt0/j2xffQ+YKnxTtm6fidlOFV1Vb4owd/5eExwqz4gW/vFUpDc76vWyb7QK3
        TZ6WAm+9zbcmTPst5WmSULniT/GU/tmfV7fJbHXK1nWcsr7W22X5wglftl9bW5bubB4rH/8n
        8Hqfi3hC3/YHfKs+de5Nv/XiumTPm47dV++Hbin81pJ2I0w42Wiq0lMlAc+kHeX3amYc7LXL
        SHv/88imR5dcrjp46FW+3KzEUpyRaKjFXFScCACSFXLIJAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsWy7bCSnO5Ch9x4g9Nf5S1+zL3NYvHm5FQW
        iz17T7JYXN41h83i8v9PLBY/ptc7sHl8mXOc3aP52Eo2j52z7rJ79G1ZxejxeZNcAGsUl01K
        ak5mWWqRvl0CV8byvxuZCyYZVLSe+cLawLhYrYuRk0NCwERi49edTF2MXBxCAjsYJc69+MHY
        xcgBlJCSOLhPE8IUljh8uBii5DmjxOw//5hBetkEdCWe3PgJZosI6EmcPHmdDaSIWeAyo8S+
        SQ/YITo6GSUu73nHDDKJU8BCYsekSJAGYQEXiQWbNrGD2CwCqhL/d21iArF5BSwlnncvY4Ow
        BSVOznzCAtLKDLSgbSMjSJhZQF5i+9s5zBD3K0js/nSUFaRERMBK4myLJkSJiMTszjbmCYzC
        s5AMmoUwaBaSQbOQdCxgZFnFKJlaUJybnltsWGCUl1quV5yYW1yal66XnJ+7iREcO1paOxj3
        rPqgd4iRiYPxEKMEB7OSCO/xDTnxQrwpiZVVqUX58UWlOanFhxilOViUxHm/zloYJySQnliS
        mp2aWpBaBJNl4uCUamCqijs9e4PBgog0u7mW2nsEPvjekf7PfOZozqNDKoc/6ZpuXaH+88QZ
        24lOHz9q/+hMk5RdYBkx+8YbAb+zfwQW9qyevn/SgsA9tfyO4q1nFH9JPH3veXvx61gD79ln
        hbqi9MomSUv0bVyQybkxvbNsUali9ZH1ShzfrP37dm4tOTXvxfpf/55ye1/46yTcnjB5wrsf
        /3pM9H5MnVXIrPuo8aqNa9QRV91fTOK37s44n3z9voMHN3dyYr3Kiikbts/crlT99c/sXq0/
        WtsT9jtqe0dauabURzeq/39QtPLqghDF0E/1KXHJCZuZW/1eSlypSma6kf1g8Z4vm9Zmbcqw
        /BdnJMFjuu/8KgWeiQ6pSizFGYmGWsxFxYkAWc+sPgwDAAA=
X-CMS-MailID: 20200925005809epcas1p39cc2c1dbe964690828383fe762df9607
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200917014010epcas1p335c9ba540cd41ff9bf6b0ce2e39d7519
References: <CGME20200917014010epcas1p335c9ba540cd41ff9bf6b0ce2e39d7519@epcas1p3.samsung.com>
        <20200917013916.4523-1-kohada.t2@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Remove 'rwoffset' in exfat_inode_info and replace it with the parameter of
> exfat_readdir().
> Since rwoffset is referenced only by exfat_readdir(), it is not necessary
> a exfat_inode_info's member.
> Also, change cpos to point to the next of entry-set, and return the index
> of dir-entry via dir_entry->entry.
> 
> Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>

Acked-by: Sungjong Seo <sj1557.seo@samsung.com>
> ---
> Changes in v2
>  - 'cpos' point to the next of entry-set
>  - return the index of dir-entry via dir_entry->entry
>  - fix commit-message
> 
>  fs/exfat/dir.c      | 21 +++++++++------------
>  fs/exfat/exfat_fs.h |  2 --
>  fs/exfat/file.c     |  2 --
>  fs/exfat/inode.c    |  3 ---
>  fs/exfat/super.c    |  1 -
>  5 files changed, 9 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c index
> a9b13ae3f325..82bee625549d 100644
> --- a/fs/exfat/dir.c
> +++ b/fs/exfat/dir.c
> @@ -59,9 +59,9 @@ static void exfat_get_uniname_from_ext_entry(struct
> super_block *sb,  }
> 
>  /* read a directory entry from the opened directory */ -static int
> exfat_readdir(struct inode *inode, struct exfat_dir_entry *dir_entry)
> +static int exfat_readdir(struct inode *inode, loff_t *cpos, struct
> +exfat_dir_entry *dir_entry)
>  {
> -	int i, dentries_per_clu, dentries_per_clu_bits = 0;
> +	int i, dentries_per_clu, dentries_per_clu_bits = 0, num_ext;
>  	unsigned int type, clu_offset;
>  	sector_t sector;
>  	struct exfat_chain dir, clu;
> @@ -70,7 +70,7 @@ static int exfat_readdir(struct inode *inode, struct
> exfat_dir_entry *dir_entry)
>  	struct super_block *sb = inode->i_sb;
>  	struct exfat_sb_info *sbi = EXFAT_SB(sb);
>  	struct exfat_inode_info *ei = EXFAT_I(inode);
> -	unsigned int dentry = ei->rwoffset & 0xFFFFFFFF;
> +	unsigned int dentry = EXFAT_B_TO_DEN(*cpos) & 0xFFFFFFFF;
>  	struct buffer_head *bh;
> 
>  	/* check if the given file ID is opened */ @@ -127,6 +127,7 @@
> static int exfat_readdir(struct inode *inode, struct exfat_dir_entry
> *dir_entry)
>  				continue;
>  			}
> 
> +			num_ext = ep->dentry.file.num_ext;
>  			dir_entry->attr = le16_to_cpu(ep->dentry.file.attr);
>  			exfat_get_entry_time(sbi, &dir_entry->crtime,
>  					ep->dentry.file.create_tz,
> @@ -157,12 +158,13 @@ static int exfat_readdir(struct inode *inode, struct
> exfat_dir_entry *dir_entry)
>  				return -EIO;
>  			dir_entry->size =
>  				le64_to_cpu(ep->dentry.stream.valid_size);
> +			dir_entry->entry = dentry;
>  			brelse(bh);
> 
>  			ei->hint_bmap.off = dentry >> dentries_per_clu_bits;
>  			ei->hint_bmap.clu = clu.dir;
> 
> -			ei->rwoffset = ++dentry;
> +			*cpos = EXFAT_DEN_TO_B(dentry + 1 + num_ext);
>  			return 0;
>  		}
> 
> @@ -178,7 +180,7 @@ static int exfat_readdir(struct inode *inode, struct
> exfat_dir_entry *dir_entry)
>  	}
> 
>  	dir_entry->namebuf.lfn[0] = '\0';
> -	ei->rwoffset = dentry;
> +	*cpos = EXFAT_DEN_TO_B(dentry);
>  	return 0;
>  }
> 
> @@ -242,12 +244,10 @@ static int exfat_iterate(struct file *filp, struct
> dir_context *ctx)
>  	if (err)
>  		goto unlock;
>  get_new:
> -	ei->rwoffset = EXFAT_B_TO_DEN(cpos);
> -
>  	if (cpos >= i_size_read(inode))
>  		goto end_of_dir;
> 
> -	err = exfat_readdir(inode, &de);
> +	err = exfat_readdir(inode, &cpos, &de);
>  	if (err) {
>  		/*
>  		 * At least we tried to read a sector.  Move cpos to next
> sector @@ -262,13 +262,10 @@ static int exfat_iterate(struct file *filp,
> struct dir_context *ctx)
>  		goto end_of_dir;
>  	}
> 
> -	cpos = EXFAT_DEN_TO_B(ei->rwoffset);
> -
>  	if (!nb->lfn[0])
>  		goto end_of_dir;
> 
> -	i_pos = ((loff_t)ei->start_clu << 32) |
> -		((ei->rwoffset - 1) & 0xffffffff);
> +	i_pos = ((loff_t)ei->start_clu << 32) |	(de.entry & 0xffffffff);
>  	tmp = exfat_iget(sb, i_pos);
>  	if (tmp) {
>  		inum = tmp->i_ino;
> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h index
> 44dc04520175..e586daf5a2e7 100644
> --- a/fs/exfat/exfat_fs.h
> +++ b/fs/exfat/exfat_fs.h
> @@ -263,8 +263,6 @@ struct exfat_inode_info {
>  	 * the validation of hint_stat.
>  	 */
>  	unsigned int version;
> -	/* file offset or dentry index for readdir */
> -	loff_t rwoffset;
> 
>  	/* hint for cluster last accessed */
>  	struct exfat_hint hint_bmap;
> diff --git a/fs/exfat/file.c b/fs/exfat/file.c index
> 4831a39632a1..a92478eabfa4 100644
> --- a/fs/exfat/file.c
> +++ b/fs/exfat/file.c
> @@ -208,8 +208,6 @@ int __exfat_truncate(struct inode *inode, loff_t
> new_size)
>  	/* hint information */
>  	ei->hint_bmap.off = EXFAT_EOF_CLUSTER;
>  	ei->hint_bmap.clu = EXFAT_EOF_CLUSTER;
> -	if (ei->rwoffset > new_size)
> -		ei->rwoffset = new_size;
> 
>  	/* hint_stat will be used if this is directory. */
>  	ei->hint_stat.eidx = 0;
> diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c index
> 7f90204adef5..70a33d4807c3 100644
> --- a/fs/exfat/inode.c
> +++ b/fs/exfat/inode.c
> @@ -114,8 +114,6 @@ static int exfat_map_cluster(struct inode *inode,
> unsigned int clu_offset,
>  	unsigned int local_clu_offset = clu_offset;
>  	unsigned int num_to_be_allocated = 0, num_clusters = 0;
> 
> -	ei->rwoffset = EXFAT_CLU_TO_B(clu_offset, sbi);
> -
>  	if (EXFAT_I(inode)->i_size_ondisk > 0)
>  		num_clusters =
>
EXFAT_B_TO_CLU_ROUND_UP(EXFAT_I(inode)->i_size_ondisk,
> @@ -567,7 +565,6 @@ static int exfat_fill_inode(struct inode *inode,
> struct exfat_dir_entry *info)
>  	ei->hint_stat.eidx = 0;
>  	ei->hint_stat.clu = info->start_clu;
>  	ei->hint_femp.eidx = EXFAT_HINT_NONE;
> -	ei->rwoffset = 0;
>  	ei->hint_bmap.off = EXFAT_EOF_CLUSTER;
>  	ei->i_pos = 0;
> 
> diff --git a/fs/exfat/super.c b/fs/exfat/super.c index
> 3b6a1659892f..b29935a91b9b 100644
> --- a/fs/exfat/super.c
> +++ b/fs/exfat/super.c
> @@ -342,7 +342,6 @@ static int exfat_read_root(struct inode *inode)
>  	ei->flags = ALLOC_FAT_CHAIN;
>  	ei->type = TYPE_DIR;
>  	ei->version = 0;
> -	ei->rwoffset = 0;
>  	ei->hint_bmap.off = EXFAT_EOF_CLUSTER;
>  	ei->hint_stat.eidx = 0;
>  	ei->hint_stat.clu = sbi->root_dir;
> --
> 2.25.1


