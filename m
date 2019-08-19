Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A99D91C96
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2019 07:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbfHSFfn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Aug 2019 01:35:43 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:35110 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725308AbfHSFfn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Aug 2019 01:35:43 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 1A406362A16C0B40E993;
        Mon, 19 Aug 2019 13:35:38 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 19 Aug 2019 13:35:37 +0800
Received: from 138 (10.175.124.28) by dggeme762-chm.china.huawei.com
 (10.3.19.108) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 19
 Aug 2019 13:35:36 +0800
Date:   Mon, 19 Aug 2019 13:52:43 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Joe Perches <joe@perches.com>
CC:     Gao Xiang <hsiangkao@aol.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        devel <devel@driverdev.osuosl.org>,
        linux-erofs <linux-erofs@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chao Yu <yuchao0@huawei.com>, Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
Subject: Re: [PATCH] erofs: Use common kernel logging style
Message-ID: <20190819055243.GB30459@138>
References: <20190817082313.21040-1-hsiangkao@aol.com>
 <1746679415.68815.1566076790942.JavaMail.zimbra@nod.at>
 <20190817220706.GA11443@hsiangkao-HP-ZHAN-66-Pro-G1>
 <1163995781.68824.1566084358245.JavaMail.zimbra@nod.at>
 <20190817233843.GA16991@hsiangkao-HP-ZHAN-66-Pro-G1>
 <1405781266.69008.1566116210649.JavaMail.zimbra@nod.at>
 <20190818084521.GA17909@hsiangkao-HP-ZHAN-66-Pro-G1>
 <1133002215.69049.1566119033047.JavaMail.zimbra@nod.at>
 <20190818092839.GA18975@hsiangkao-HP-ZHAN-66-Pro-G1>
 <52e4e3a7f160f5d2825bec04a3bc4eb4b0d1165a.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <52e4e3a7f160f5d2825bec04a3bc4eb4b0d1165a.camel@perches.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Originating-IP: [10.175.124.28]
X-ClientProxiedBy: dggeme708-chm.china.huawei.com (10.1.199.104) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Joe,

On Sun, Aug 18, 2019 at 10:28:41PM -0700, Joe Perches wrote:
> Rename errln, infoln, and debugln to the typical pr_<level> uses
> to the typical kernel styles of pr_<level>

How about using erofs_err / ... to instead that?
 - I can hardly see directly use pr_<level> for those filesystems in fs/...

 - maybe we will introduce super_block to print more information
   about the specific filesystem...

> 
> Miscellanea:
> 
> o Add newline terminations to the uses
> o Use "%s: ...", __func__ and not the atypical "%s, ...", __func__

Agreed.

Thanks,
Gao Xiang

> o Trivial grammar changes in output logging
> o Delete the now unused macros
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/staging/erofs/data.c         |  6 ++--
>  drivers/staging/erofs/decompressor.c |  6 ++--
>  drivers/staging/erofs/dir.c          |  8 +++---
>  drivers/staging/erofs/inode.c        | 16 +++++------
>  drivers/staging/erofs/internal.h     |  8 ++----
>  drivers/staging/erofs/namei.c        |  4 +--
>  drivers/staging/erofs/super.c        | 54 +++++++++++++++++++-----------------
>  drivers/staging/erofs/xattr.c        |  4 +--
>  drivers/staging/erofs/zdata.c        | 12 ++++----
>  drivers/staging/erofs/zdata.h        |  2 +-
>  drivers/staging/erofs/zmap.c         | 26 ++++++++---------
>  11 files changed, 73 insertions(+), 73 deletions(-)
> 
> diff --git a/drivers/staging/erofs/data.c b/drivers/staging/erofs/data.c
> index 4cdb743c8b8d..677d95e8fdeb 100644
> --- a/drivers/staging/erofs/data.c
> +++ b/drivers/staging/erofs/data.c
> @@ -152,8 +152,8 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
>  
>  		map->m_flags |= EROFS_MAP_META;
>  	} else {
> -		errln("internal error @ nid: %llu (size %llu), m_la 0x%llx",
> -		      vi->nid, inode->i_size, map->m_la);
> +		pr_err("internal error @ nid: %llu (size %llu), m_la 0x%llx\n",
> +		       vi->nid, inode->i_size, map->m_la);
>  		DBG_BUGON(1);
>  		err = -EIO;
>  		goto err_out;
> @@ -363,7 +363,7 @@ static int erofs_raw_access_readpages(struct file *filp,
>  
>  			/* all the page errors are ignored when readahead */
>  			if (IS_ERR(bio)) {
> -				pr_err("%s, readahead error at page %lu of nid %llu\n",
> +				pr_err("%s: readahead error at page %lu of nid %llu\n",
>  				       __func__, page->index,
>  				       EROFS_V(mapping->host)->nid);
>  
> diff --git a/drivers/staging/erofs/decompressor.c b/drivers/staging/erofs/decompressor.c
> index 5361a2bbedb6..24d450ce66c1 100644
> --- a/drivers/staging/erofs/decompressor.c
> +++ b/drivers/staging/erofs/decompressor.c
> @@ -166,9 +166,9 @@ static int lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
>  					  inlen, rq->outputsize,
>  					  rq->outputsize);
>  	if (ret < 0) {
> -		errln("%s, failed to decompress, in[%p, %u, %u] out[%p, %u]",
> -		      __func__, src + inputmargin, inlen, inputmargin,
> -		      out, rq->outputsize);
> +		pr_err("%s: failed to decompress, in[%p, %u, %u] out[%p, %u]\n",
> +		       __func__, src + inputmargin, inlen, inputmargin,
> +		       out, rq->outputsize);
>  		WARN_ON(1);
>  		print_hex_dump(KERN_DEBUG, "[ in]: ", DUMP_PREFIX_OFFSET,
>  			       16, 1, src + inputmargin, inlen, true);
> diff --git a/drivers/staging/erofs/dir.c b/drivers/staging/erofs/dir.c
> index 2fbfc4935077..526c7b5dd4db 100644
> --- a/drivers/staging/erofs/dir.c
> +++ b/drivers/staging/erofs/dir.c
> @@ -29,8 +29,8 @@ static void debug_one_dentry(unsigned char d_type, const char *de_name,
>  	memcpy(dbg_namebuf, de_name, de_namelen);
>  	dbg_namebuf[de_namelen] = '\0';
>  
> -	debugln("found dirent %s de_len %u d_type %d", dbg_namebuf,
> -		de_namelen, d_type);
> +	pr_debug("found dirent %s de_len %u d_type %d\n",
> +		 dbg_namebuf, de_namelen, d_type);
>  #endif
>  }
>  
> @@ -104,8 +104,8 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>  
>  		if (unlikely(nameoff < sizeof(struct erofs_dirent) ||
>  			     nameoff >= PAGE_SIZE)) {
> -			errln("%s, invalid de[0].nameoff %u",
> -			      __func__, nameoff);
> +			pr_err("%s: invalid de[0].nameoff %u\n",
> +			       __func__, nameoff);
>  
>  			err = -EIO;
>  			goto skip_this;
> diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
> index 286729143365..7b91f3baf8d4 100644
> --- a/drivers/staging/erofs/inode.c
> +++ b/drivers/staging/erofs/inode.c
> @@ -21,8 +21,8 @@ static int read_inode(struct inode *inode, void *data)
>  	vi->datamode = __inode_data_mapping(advise);
>  
>  	if (unlikely(vi->datamode >= EROFS_INODE_LAYOUT_MAX)) {
> -		errln("unsupported data mapping %u of nid %llu",
> -		      vi->datamode, vi->nid);
> +		pr_err("unsupported data mapping %u of nid %llu\n",
> +		       vi->datamode, vi->nid);
>  		DBG_BUGON(1);
>  		return -EIO;
>  	}
> @@ -92,8 +92,8 @@ static int read_inode(struct inode *inode, void *data)
>  		if (is_inode_layout_compression(inode))
>  			nblks = le32_to_cpu(v1->i_u.compressed_blocks);
>  	} else {
> -		errln("unsupported on-disk inode version %u of nid %llu",
> -		      __inode_version(advise), vi->nid);
> +		pr_err("unsupported on-disk inode version %u of nid %llu\n",
> +		       __inode_version(advise), vi->nid);
>  		DBG_BUGON(1);
>  		return -EIO;
>  	}
> @@ -167,14 +167,14 @@ static int fill_inode(struct inode *inode, int isdir)
>  	blkaddr = erofs_blknr(iloc(sbi, vi->nid));
>  	ofs = erofs_blkoff(iloc(sbi, vi->nid));
>  
> -	debugln("%s, reading inode nid %llu at %u of blkaddr %u",
> -		__func__, vi->nid, ofs, blkaddr);
> +	pr_debug("%s: reading inode nid %llu at %u of blkaddr %u\n",
> +		 __func__, vi->nid, ofs, blkaddr);
>  
>  	page = erofs_get_meta_page(inode->i_sb, blkaddr, isdir);
>  
>  	if (IS_ERR(page)) {
> -		errln("failed to get inode (nid: %llu) page, err %ld",
> -		      vi->nid, PTR_ERR(page));
> +		pr_err("failed to get inode (nid: %llu) page, err %ld\n",
> +		       vi->nid, PTR_ERR(page));
>  		return PTR_ERR(page);
>  	}
>  
> diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
> index 4ce5991c381f..3833ae713355 100644
> --- a/drivers/staging/erofs/internal.h
> +++ b/drivers/staging/erofs/internal.h
> @@ -23,13 +23,10 @@
>  #undef pr_fmt
>  #define pr_fmt(fmt) "erofs: " fmt
>  
> -#define errln(x, ...)   pr_err(x "\n", ##__VA_ARGS__)
> -#define infoln(x, ...)  pr_info(x "\n", ##__VA_ARGS__)
>  #ifdef CONFIG_EROFS_FS_DEBUG
> -#define debugln(x, ...) pr_debug(x "\n", ##__VA_ARGS__)
> +#define DEBUG
>  #define DBG_BUGON               BUG_ON
>  #else
> -#define debugln(x, ...)         ((void)0)
>  #define DBG_BUGON(x)            ((void)(x))
>  #endif	/* !CONFIG_EROFS_FS_DEBUG */
>  
> @@ -108,7 +105,8 @@ struct erofs_sb_info {
>  
>  #ifdef CONFIG_EROFS_FAULT_INJECTION
>  #define erofs_show_injection_info(type)					\
> -	infoln("inject %s in %s of %pS", erofs_fault_name[type],        \
> +	pr_info("inject %s in %s of %pS\n",				\
> +		erofs_fault_name[type],					\
>  		__func__, __builtin_return_address(0))
>  
>  static inline bool time_to_inject(struct erofs_sb_info *sbi, int type)
> diff --git a/drivers/staging/erofs/namei.c b/drivers/staging/erofs/namei.c
> index 8e06526da023..1cba4d471433 100644
> --- a/drivers/staging/erofs/namei.c
> +++ b/drivers/staging/erofs/namei.c
> @@ -233,8 +233,8 @@ static struct dentry *erofs_lookup(struct inode *dir,
>  	} else if (unlikely(err)) {
>  		inode = ERR_PTR(err);
>  	} else {
> -		debugln("%s, %s (nid %llu) found, d_type %u", __func__,
> -			dentry->d_name.name, nid, d_type);
> +		pr_debug("%s: %s (nid %llu) found, d_type %u\n",
> +			 __func__, dentry->d_name.name, nid, d_type);
>  		inode = erofs_iget(dir->i_sb, nid, d_type == EROFS_FT_DIR);
>  	}
>  	return d_splice_alias(inode, dentry);
> diff --git a/drivers/staging/erofs/super.c b/drivers/staging/erofs/super.c
> index f65a1ff9f42f..97096bfa5e73 100644
> --- a/drivers/staging/erofs/super.c
> +++ b/drivers/staging/erofs/super.c
> @@ -75,8 +75,8 @@ static bool check_layout_compatibility(struct super_block *sb,
>  
>  	/* check if current kernel meets all mandatory requirements */
>  	if (requirements & (~EROFS_ALL_REQUIREMENTS)) {
> -		errln("unidentified requirements %x, please upgrade kernel version",
> -		      requirements & ~EROFS_ALL_REQUIREMENTS);
> +		pr_err("unidentified requirements %x, please upgrade kernel version\n",
> +		       requirements & ~EROFS_ALL_REQUIREMENTS);
>  		return false;
>  	}
>  	return true;
> @@ -93,7 +93,7 @@ static int superblock_read(struct super_block *sb)
>  	bh = sb_bread(sb, 0);
>  
>  	if (!bh) {
> -		errln("cannot read erofs superblock");
> +		pr_err("cannot read erofs superblock\n");
>  		return -EIO;
>  	}
>  
> @@ -103,15 +103,15 @@ static int superblock_read(struct super_block *sb)
>  
>  	ret = -EINVAL;
>  	if (le32_to_cpu(layout->magic) != EROFS_SUPER_MAGIC_V1) {
> -		errln("cannot find valid erofs superblock");
> +		pr_err("cannot find valid erofs superblock\n");
>  		goto out;
>  	}
>  
>  	blkszbits = layout->blkszbits;
>  	/* 9(512 bytes) + LOG_SECTORS_PER_BLOCK == LOG_BLOCK_SIZE */
>  	if (unlikely(blkszbits != LOG_BLOCK_SIZE)) {
> -		errln("blksize %u isn't supported on this platform",
> -		      1 << blkszbits);
> +		pr_err("blksize %u isn't supported on this platform\n",
> +		       1 << blkszbits);
>  		goto out;
>  	}
>  
> @@ -187,7 +187,7 @@ static void __erofs_build_fault_attr(struct erofs_sb_info *sbi,
>  static int erofs_build_fault_attr(struct erofs_sb_info *sbi,
>  				  substring_t *args)
>  {
> -	infoln("fault_injection options not supported");
> +	pr_info("fault_injection options not supported\n");
>  	return 0;
>  }
>  
> @@ -205,7 +205,7 @@ static int erofs_build_cache_strategy(struct erofs_sb_info *sbi,
>  	int err = 0;
>  
>  	if (!cs) {
> -		errln("Not enough memory to store cache strategy");
> +		pr_err("Not enough memory to store cache strategy\n");
>  		return -ENOMEM;
>  	}
>  
> @@ -216,7 +216,7 @@ static int erofs_build_cache_strategy(struct erofs_sb_info *sbi,
>  	} else if (!strcmp(cs, "readaround")) {
>  		sbi->cache_strategy = EROFS_ZIP_CACHE_READAROUND;
>  	} else {
> -		errln("Unrecognized cache strategy \"%s\"", cs);
> +		pr_err("Unrecognized cache strategy \"%s\"\n", cs);
>  		err = -EINVAL;
>  	}
>  	kfree(cs);
> @@ -226,7 +226,7 @@ static int erofs_build_cache_strategy(struct erofs_sb_info *sbi,
>  static int erofs_build_cache_strategy(struct erofs_sb_info *sbi,
>  				      substring_t *args)
>  {
> -	infoln("EROFS compression is disabled, so cache strategy is ignored");
> +	pr_info("EROFS compression is disabled, so cache strategy is ignored\n");
>  	return 0;
>  }
>  #endif
> @@ -294,10 +294,10 @@ static int parse_options(struct super_block *sb, char *options)
>  			break;
>  #else
>  		case Opt_user_xattr:
> -			infoln("user_xattr options not supported");
> +			pr_info("user_xattr options not supported\n");
>  			break;
>  		case Opt_nouser_xattr:
> -			infoln("nouser_xattr options not supported");
> +			pr_info("nouser_xattr options not supported\n");
>  			break;
>  #endif
>  #ifdef CONFIG_EROFS_FS_POSIX_ACL
> @@ -309,10 +309,10 @@ static int parse_options(struct super_block *sb, char *options)
>  			break;
>  #else
>  		case Opt_acl:
> -			infoln("acl options not supported");
> +			pr_info("acl options not supported\n");
>  			break;
>  		case Opt_noacl:
> -			infoln("noacl options not supported");
> +			pr_info("noacl options not supported\n");
>  			break;
>  #endif
>  		case Opt_fault_injection:
> @@ -326,7 +326,8 @@ static int parse_options(struct super_block *sb, char *options)
>  				return err;
>  			break;
>  		default:
> -			errln("Unrecognized mount option \"%s\" or missing value", p);
> +			pr_err("Unrecognized mount option \"%s\" or missing value\n",
> +			       p);
>  			return -EINVAL;
>  		}
>  	}
> @@ -398,13 +399,13 @@ static int erofs_fill_super(struct super_block *sb, void *data, int silent)
>  	struct erofs_sb_info *sbi;
>  	int err;
>  
> -	infoln("fill_super, device -> %s", sb->s_id);
> -	infoln("options -> %s", (char *)data);
> +	pr_info("%s: device -> %s\n", __func__, sb->s_id);
> +	pr_info("options -> %s\n", (char *)data);
>  
>  	sb->s_magic = EROFS_SUPER_MAGIC;
>  
>  	if (unlikely(!sb_set_blocksize(sb, EROFS_BLKSIZ))) {
> -		errln("failed to set erofs blksize");
> +		pr_err("failed to set erofs blksize\n");
>  		return -EINVAL;
>  	}
>  
> @@ -434,7 +435,7 @@ static int erofs_fill_super(struct super_block *sb, void *data, int silent)
>  		return err;
>  
>  	if (!silent)
> -		infoln("root inode @ nid %llu", ROOT_NID(sbi));
> +		pr_info("root inode @ nid %llu\n", ROOT_NID(sbi));
>  
>  	if (test_opt(sbi, POSIX_ACL))
>  		sb->s_flags |= SB_POSIXACL;
> @@ -451,8 +452,8 @@ static int erofs_fill_super(struct super_block *sb, void *data, int silent)
>  		return PTR_ERR(inode);
>  
>  	if (unlikely(!S_ISDIR(inode->i_mode))) {
> -		errln("rootino(nid %llu) is not a directory(i_mode %o)",
> -		      ROOT_NID(sbi), inode->i_mode);
> +		pr_err("rootino(nid %llu) is not a directory(i_mode %o)\n",
> +		       ROOT_NID(sbi), inode->i_mode);
>  		iput(inode);
>  		return -EINVAL;
>  	}
> @@ -468,7 +469,8 @@ static int erofs_fill_super(struct super_block *sb, void *data, int silent)
>  		return err;
>  
>  	if (!silent)
> -		infoln("mounted on %s with opts: %s.", sb->s_id, (char *)data);
> +		pr_info("mounted on %s with opts: %s\n",
> +			sb->s_id, (char *)data);
>  	return 0;
>  }
>  
> @@ -487,7 +489,7 @@ static void erofs_kill_sb(struct super_block *sb)
>  	struct erofs_sb_info *sbi;
>  
>  	WARN_ON(sb->s_magic != EROFS_SUPER_MAGIC);
> -	infoln("unmounting for %s", sb->s_id);
> +	pr_info("unmounting for %s\n", sb->s_id);
>  
>  	kill_block_super(sb);
>  
> @@ -526,7 +528,7 @@ static int __init erofs_module_init(void)
>  	int err;
>  
>  	erofs_check_ondisk_layout_definitions();
> -	infoln("initializing erofs " EROFS_VERSION);
> +	pr_info("initializing erofs " EROFS_VERSION "\n");
>  
>  	err = erofs_init_inode_cache();
>  	if (err)
> @@ -544,7 +546,7 @@ static int __init erofs_module_init(void)
>  	if (err)
>  		goto fs_err;
>  
> -	infoln("successfully to initialize erofs");
> +	pr_info("successfully initialized erofs\n");
>  	return 0;
>  
>  fs_err:
> @@ -563,7 +565,7 @@ static void __exit erofs_module_exit(void)
>  	z_erofs_exit_zip_subsystem();
>  	erofs_exit_shrinker();
>  	erofs_exit_inode_cache();
> -	infoln("successfully finalize erofs");
> +	pr_info("successfully finalized erofs\n");
>  }
>  
>  /* get filesystem statistics */
> diff --git a/drivers/staging/erofs/xattr.c b/drivers/staging/erofs/xattr.c
> index 289c7850ec96..e774a8c1bfae 100644
> --- a/drivers/staging/erofs/xattr.c
> +++ b/drivers/staging/erofs/xattr.c
> @@ -69,8 +69,8 @@ static int init_inode_xattrs(struct inode *inode)
>  	 *    undefined right now (maybe use later with some new sb feature).
>  	 */
>  	if (vi->xattr_isize == sizeof(struct erofs_xattr_ibody_header)) {
> -		errln("xattr_isize %d of nid %llu is not supported yet",
> -		      vi->xattr_isize, vi->nid);
> +		pr_err("xattr_isize %d of nid %llu is not supported yet\n",
> +		       vi->xattr_isize, vi->nid);
>  		ret = -ENOTSUPP;
>  		goto out_unlock;
>  	} else if (vi->xattr_isize < sizeof(struct erofs_xattr_ibody_header)) {
> diff --git a/drivers/staging/erofs/zdata.c b/drivers/staging/erofs/zdata.c
> index 2d7aaf98f7de..17daf286747e 100644
> --- a/drivers/staging/erofs/zdata.c
> +++ b/drivers/staging/erofs/zdata.c
> @@ -585,7 +585,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
>  	}
>  
>  	/* go ahead the next map_blocks */
> -	debugln("%s: [out-of-range] pos %llu", __func__, offset + cur);
> +	pr_debug("%s: [out-of-range] pos %llu\n", __func__, offset + cur);
>  
>  	if (z_erofs_collector_end(clt))
>  		fe->backmost = false;
> @@ -665,8 +665,8 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
>  out:
>  	z_erofs_onlinepage_endio(page);
>  
> -	debugln("%s, finish page: %pK spiltted: %u map->m_llen %llu",
> -		__func__, page, spiltted, map->m_llen);
> +	pr_debug("%s: finish page: %pK spiltted: %u map->m_llen %llu\n",
> +		 __func__, page, spiltted, map->m_llen);
>  	return err;
>  
>  	/* if some error occurred while processing this page */
> @@ -1308,7 +1308,7 @@ static int z_erofs_vle_normalaccess_readpage(struct file *file,
>  	(void)z_erofs_collector_end(&f.clt);
>  
>  	if (err) {
> -		errln("%s, failed to read, err [%d]", __func__, err);
> +		pr_err("%s: failed to read, err [%d]\n", __func__, err);
>  		goto out;
>  	}
>  
> @@ -1380,8 +1380,8 @@ static int z_erofs_vle_normalaccess_readpages(struct file *filp,
>  		if (err) {
>  			struct erofs_vnode *vi = EROFS_V(inode);
>  
> -			errln("%s, readahead error at page %lu of nid %llu",
> -			      __func__, page->index, vi->nid);
> +			pr_err("%s: readahead error at page %lu of nid %llu\n",
> +			       __func__, page->index, vi->nid);
>  		}
>  		put_page(page);
>  	}
> diff --git a/drivers/staging/erofs/zdata.h b/drivers/staging/erofs/zdata.h
> index e11fe1959ca2..e96e8ee270d2 100644
> --- a/drivers/staging/erofs/zdata.h
> +++ b/drivers/staging/erofs/zdata.h
> @@ -184,7 +184,7 @@ static inline void z_erofs_onlinepage_endio(struct page *page)
>  			SetPageUptodate(page);
>  		unlock_page(page);
>  	}
> -	debugln("%s, page %p value %x", __func__, page, atomic_read(u.o));
> +	pr_debug("%s: page %p value %x\n", __func__, page, atomic_read(u.o));
>  }
>  
>  #define Z_EROFS_VMAP_ONSTACK_PAGES	\
> diff --git a/drivers/staging/erofs/zmap.c b/drivers/staging/erofs/zmap.c
> index aeed5c674d9e..b2adf531379a 100644
> --- a/drivers/staging/erofs/zmap.c
> +++ b/drivers/staging/erofs/zmap.c
> @@ -66,8 +66,8 @@ static int fill_inode_lazy(struct inode *inode)
>  	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
>  
>  	if (vi->z_algorithmtype[0] >= Z_EROFS_COMPRESSION_MAX) {
> -		errln("unknown compression format %u for nid %llu, please upgrade kernel",
> -		      vi->z_algorithmtype[0], vi->nid);
> +		pr_err("unknown compression format %u for nid %llu, please upgrade kernel\n",
> +		       vi->z_algorithmtype[0], vi->nid);
>  		err = -ENOTSUPP;
>  		goto unmap_done;
>  	}
> @@ -77,8 +77,8 @@ static int fill_inode_lazy(struct inode *inode)
>  					((h->h_clusterbits >> 3) & 3);
>  
>  	if (vi->z_physical_clusterbits[0] != LOG_BLOCK_SIZE) {
> -		errln("unsupported physical clusterbits %u for nid %llu, please upgrade kernel",
> -		      vi->z_physical_clusterbits[0], vi->nid);
> +		pr_err("unsupported physical clusterbits %u for nid %llu, please upgrade kernel\n",
> +		       vi->z_physical_clusterbits[0], vi->nid);
>  		err = -ENOTSUPP;
>  		goto unmap_done;
>  	}
> @@ -358,8 +358,8 @@ static int vle_extent_lookback(struct z_erofs_maprecorder *m,
>  		map->m_la = (lcn << lclusterbits) | m->clusterofs;
>  		break;
>  	default:
> -		errln("unknown type %u at lcn %lu of nid %llu",
> -		      m->type, lcn, vi->nid);
> +		pr_err("unknown type %u at lcn %lu of nid %llu\n",
> +		       m->type, lcn, vi->nid);
>  		DBG_BUGON(1);
>  		return -EIO;
>  	}
> @@ -417,8 +417,8 @@ int z_erofs_map_blocks_iter(struct inode *inode,
>  		}
>  		/* m.lcn should be >= 1 if endoff < m.clusterofs */
>  		if (unlikely(!m.lcn)) {
> -			errln("invalid logical cluster 0 at nid %llu",
> -			      vi->nid);
> +			pr_err("invalid logical cluster 0 at nid %llu\n",
> +			       vi->nid);
>  			err = -EIO;
>  			goto unmap_out;
>  		}
> @@ -433,8 +433,8 @@ int z_erofs_map_blocks_iter(struct inode *inode,
>  			goto unmap_out;
>  		break;
>  	default:
> -		errln("unknown type %u at offset %llu of nid %llu",
> -		      m.type, ofs, vi->nid);
> +		pr_err("unknown type %u at offset %llu of nid %llu\n",
> +		       m.type, ofs, vi->nid);
>  		err = -EIO;
>  		goto unmap_out;
>  	}
> @@ -449,9 +449,9 @@ int z_erofs_map_blocks_iter(struct inode *inode,
>  		kunmap_atomic(m.kaddr);
>  
>  out:
> -	debugln("%s, m_la %llu m_pa %llu m_llen %llu m_plen %llu m_flags 0%o",
> -		__func__, map->m_la, map->m_pa,
> -		map->m_llen, map->m_plen, map->m_flags);
> +	pr_debug("%s: m_la %llu m_pa %llu m_llen %llu m_plen %llu m_flags 0%o\n",
> +		 __func__, map->m_la, map->m_pa,
> +		 map->m_llen, map->m_plen, map->m_flags);
>  
>  	trace_z_erofs_map_blocks_iter_exit(inode, map, flags, err);
>  
> 
> 
