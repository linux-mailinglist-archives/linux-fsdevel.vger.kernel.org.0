Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF7AA4873
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2019 10:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbfIAIzL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Sep 2019 04:55:11 -0400
Received: from sonic308-54.consmr.mail.gq1.yahoo.com ([98.137.68.30]:36419
        "EHLO sonic308-54.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728829AbfIAIzK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Sep 2019 04:55:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1567328109; bh=2T51wfLeso6fqYmhF4Q+DmVdeuKTXdhukyK2Q6Uk8Qs=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=azR6xs8Y0MaN1hedD9e+nh7laftJZbI5g4hJw/9O+dA8LmfbZ/R04RBwLcQfEUoLqi5yvGhoXZDGAMZdB2+VAmvxO2OjrY7GvXAZzZXytUd4UuEpbuZ7S32Ws/l/xFEs8dpV2Yxxw9EMGSeKLPgMcCVkPAsnApKCc8ro2kGEbO/x5x8BcBCrquxX5T+cRhNFL6xPS5fRaxouUp4JHN7ByZhy21bOJComz4Zj/VBgnTNMDlAYTrkoZhZHGEAs47z1Gu3oTnLpAQEtiQWQAbfTwqIrIclJbgTBFG13y7wLKvo5Dx1w9SH1Jo2JxTT5mngCcIqYWS9WevH73ncMMZP06Q==
X-YMail-OSG: lwVpAlMVM1kyFIQv33969BR4RnCx3_IO9fyUSJldVLAZ7.ZGoYRQUS4gOAHVAzL
 m8LPsMJVXBRkzHz665ce1L3VE.LojgTmLDErlnLPoPGehSlIyotVZsAO1bt9Ub1xbL7T5.faOyf1
 La5ESlsY5A7DhKU7R4jvSjXa29HvfcO_ry27irB9INX9RfTyqhgcfA8ovpAZZvIpHHZPZxwbSp.u
 OTyXXWJjIaINl23VAi7PgHzsuo76TB_fOGcNNUWy8Cj8sDznXEdRf03cchnV17bjTeVVUcncDXaZ
 2oA4ONm813vmW51rclHamQ8WA2T2tP2p2wzAQ_Tzz.wl5MYMPW4PrCcfg3HUmwHh0YJkdWADE3SZ
 OviyYHjkJ2O_4mSH4dXte5Ai8S4AFv8Oqc4rEmwMOMSshoQmRMA_fc4T11MAjoAk3R70u4CHDBcM
 Md_ZSCoXmDX16pXsG1Q7Y3n80aF3XkSqZOOcb_IM9OtfxHe8.6t8TYRt6_s6jy4GcjQjxjjHt2qV
 XMJg_Q37eGXL8LTiMOGV5j4AnvOF1vxQPRu08ckUISnBhTdwHOTngZvxtA28Nrv8n2FWQbRAYMRl
 iTt9CL8kYNe4PIblciIQyqyV7M7xlKDXMa7vR16WtUyFqZ4WNdPzLezsI_KHq9l6.oq96rQl2VC5
 3EoOob.TIDLZZeOj21pOlMnsN6owqtcUEv0h0A1cy_M.pM.uMuRb_75N.VvIVZtPZ1GPtxdOQ4MZ
 4HLqirRJVn904UuMA2NLxSOQE8MFZoTrUQ5kwuuciAfaxFUSaDuGZ.sW7x2CCOcUEf0jQ9oywm6m
 sogBc4ofIRmeJp8OAlUfbT8KN9lBGOo.l8MqCVfhHwSVltF39A0yPrJ8qZae8WknRZGTpY6j2W.D
 u_Rr814KRKOZR0TPQzxXaGy2HVjbYFfJiAx_lipsF8AybHhYB4Ar7h2q_x9mRZ.I3yE1.erWohg7
 Hry4BkGSKQWZFyaojPNhuxnLooFIULI.Afq8bhATU2YpeXTZMZe_Ojp0c9V0bK.qTlfeaLA64qTZ
 Viu_Oo_0UDvcsh.GWC_dR8DaFMXuiOsvj8Ot8_2FSCXLiiyBzpCoTsYJPsMluIYiEuvEXIEYMAXz
 EMnzEsvubTphUaSpbgWmy82gBOpOkaroAVuOC9tAQD.wHLbGUVdTwevLTedn5hsxj5oa4jy4VLiD
 1kPl3wDTsIcP9YH04wVAx5ZkycrBeQW.ApO13YVeXfKAiy_IctPX_kNco.AfXHWNymA.SO_UkXDM
 OEo3NYeip0en.Men2SIrwcH_TuvCP0NUMd5LD_g--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.gq1.yahoo.com with HTTP; Sun, 1 Sep 2019 08:55:09 +0000
Received: by smtp403.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID c571dfb48f74266536ca9ef163c4409d;
          Sun, 01 Sep 2019 08:55:05 +0000 (UTC)
Date:   Sun, 1 Sep 2019 16:54:55 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Gao Xiang <gaoxiang25@huawei.com>, Jan Kara <jack@suse.cz>,
        Chao Yu <yuchao0@huawei.com>,
        Dave Chinner <david@fromorbit.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Miao Xie <miaoxie@huawei.com>, devel@driverdev.osuosl.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Pavel Machek <pavel@denx.de>,
        David Sterba <dsterba@suse.cz>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH v6 03/24] erofs: add super block operations
Message-ID: <20190901085452.GA4663@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190802125347.166018-4-gaoxiang25@huawei.com>
 <20190829101545.GC20598@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829101545.GC20598@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,

Here is also my redo-ed comments...

On Thu, Aug 29, 2019 at 03:15:45AM -0700, Christoph Hellwig wrote:
> On Fri, Aug 02, 2019 at 08:53:26PM +0800, Gao Xiang wrote:
> > +static int __init erofs_init_inode_cache(void)
> > +{
> > +	erofs_inode_cachep = kmem_cache_create("erofs_inode",
> > +					       sizeof(struct erofs_vnode), 0,
> > +					       SLAB_RECLAIM_ACCOUNT,
> > +					       init_once);
> > +
> > +	return erofs_inode_cachep ? 0 : -ENOMEM;
> 
> Please just use normal if/else.  Also having this function seems
> entirely pointless.

Fixed in
https://lore.kernel.org/r/20190901055130.30572-7-hsiangkao@aol.com/

> 
> > +static void erofs_exit_inode_cache(void)
> > +{
> > +	kmem_cache_destroy(erofs_inode_cachep);
> > +}
> 
> Same for this one.

Fixed in
https://lore.kernel.org/r/20190901055130.30572-7-hsiangkao@aol.com/

> 
> > +static void free_inode(struct inode *inode)
> 
> Please use an erofs_ prefix for all your functions.

free_inode and most short, common static functions are fixed in
https://lore.kernel.org/r/20190901055130.30572-19-hsiangkao@aol.com/

For all non-static functions, all are prefixed with "erofs_"

> 
> > +{
> > +	struct erofs_vnode *vi = EROFS_V(inode);
> 
> Why is this called vnode instead of inode?  That seems like a rather
> odd naming for a Linux file system.

Fixed in
https://lore.kernel.org/r/20190901055130.30572-8-hsiangkao@aol.com/

> 
> > +
> > +	/* be careful RCU symlink path (see ext4_inode_info->i_data)! */
> > +	if (is_inode_fast_symlink(inode))
> > +		kfree(inode->i_link);
> 
> is_inode_fast_symlink only shows up in a later patch.  And really
> obsfucates the check here in the only caller as you can just do an
> unconditional kfree here - i_link will be NULL except for the case
> where you explicitly set it.

Fixed in
https://lore.kernel.org/r/20190901055130.30572-10-hsiangkao@aol.com/

and with my following comments....
https://lore.kernel.org/r/20190831005446.GA233871@architecture4/

> 
> Also this code is nothing like ext4, so the code seems a little confusing.
> 
> > +static bool check_layout_compatibility(struct super_block *sb,
> > +				       struct erofs_super_block *layout)
> > +{
> > +	const unsigned int requirements = le32_to_cpu(layout->requirements);
> 
> Why is the variable name for the on-disk subperblock layout?  We usually
> still calls this something with sb in the name, e.g. dsb. for disk
> super block.

Fixed in
https://lore.kernel.org/r/20190901055130.30572-12-hsiangkao@aol.com/

> 
> > +	EROFS_SB(sb)->requirements = requirements;
> > +
> > +	/* check if current kernel meets all mandatory requirements */
> > +	if (requirements & (~EROFS_ALL_REQUIREMENTS)) {
> > +		errln("unidentified requirements %x, please upgrade kernel version",
> > +		      requirements & ~EROFS_ALL_REQUIREMENTS);
> > +		return false;
> > +	}
> > +	return true;
> 
> Note that normally we call this features, but that doesn't really
> matter too much.

No modification at this... (some comments already right here...)

 20 /* 128-byte erofs on-disk super block */
 21 struct erofs_super_block {
...
 24         __le32 features;        /* (aka. feature_compat) */
...
 38         __le32 requirements;    /* (aka. feature_incompat) */
...
 41 };

> 
> > +static int superblock_read(struct super_block *sb)
> > +{
> > +	struct erofs_sb_info *sbi;
> > +	struct buffer_head *bh;
> > +	struct erofs_super_block *layout;
> > +	unsigned int blkszbits;
> > +	int ret;
> > +
> > +	bh = sb_bread(sb, 0);
> 
> Is there any good reasons to use buffer heads like this in new code
> vs directly using bios?

As you said, I want it in the page cache.

The reason "why not use read_mapping_page or similar?" is simply
read_mapping_page -> .readpage -> (for bdev inode) block_read_full_page
 -> create_page_buffers anyway...

sb_bread haven't obsoleted... It has similar function though...

> 
> > +
> > +	sbi->blocks = le32_to_cpu(layout->blocks);
> > +	sbi->meta_blkaddr = le32_to_cpu(layout->meta_blkaddr);
> > +	sbi->islotbits = ffs(sizeof(struct erofs_inode_v1)) - 1;
> > +	sbi->root_nid = le16_to_cpu(layout->root_nid);
> > +	sbi->inos = le64_to_cpu(layout->inos);
> > +
> > +	sbi->build_time = le64_to_cpu(layout->build_time);
> > +	sbi->build_time_nsec = le32_to_cpu(layout->build_time_nsec);
> > +
> > +	memcpy(&sb->s_uuid, layout->uuid, sizeof(layout->uuid));
> > +	memcpy(sbi->volume_name, layout->volume_name,
> > +	       sizeof(layout->volume_name));
> 
> s_uuid should preferably be a uuid_t (assuming it is a real BE uuid,
> if it is le it should be a guid_t).

For this case, I have no idea how to deal with...
I have little knowledge about this uuid stuff, so I just copied
from f2fs... (Could be no urgent of this field...)

> 
> > +/* set up default EROFS parameters */
> > +static void default_options(struct erofs_sb_info *sbi)
> > +{
> > +}
> 
> No need to add an empty function.

My fault of spilting patches...

> 
> > +static int erofs_fill_super(struct super_block *sb, void *data, int silent)
> > +{
> > +	struct inode *inode;
> > +	struct erofs_sb_info *sbi;
> > +	int err;
> > +
> > +	infoln("fill_super, device -> %s", sb->s_id);
> > +	infoln("options -> %s", (char *)data);
> 
> That is some very verbose debug info.  We usually don't add that and
> let people trace the function instead.  Also you should probably
> implement the new mount API.
> new mount API.

Fixed in
https://lore.kernel.org/r/20190901055130.30572-13-hsiangkao@aol.com/

(For new mount API,
 https://lore.kernel.org/r/20190721040547.GF17978@ZenIV.linux.org.uk/
 , I will a look later)

> 
> > +static void erofs_kill_sb(struct super_block *sb)
> > +{
> > +	struct erofs_sb_info *sbi;
> > +
> > +	WARN_ON(sb->s_magic != EROFS_SUPER_MAGIC);
> > +	infoln("unmounting for %s", sb->s_id);
> > +
> > +	kill_block_super(sb);
> > +
> > +	sbi = EROFS_SB(sb);
> > +	if (!sbi)
> > +		return;
> > +	kfree(sbi);
> > +	sb->s_fs_info = NULL;
> > +}
> 
> Why is this needed?  You can just free your sb privatte information in
> ->put_super and wire up kill_block_super as the ->kill_sb method
> directly.

The background is Al's comments in erofs v2....
(which simplify erofs_fill_super logic)
https://lore.kernel.org/r/20190720224955.GD17978@ZenIV.linux.org.uk/

with a specific notation...
https://lore.kernel.org/r/20190721040547.GF17978@ZenIV.linux.org.uk/

"
> OTOH, for the case of NULL ->s_root ->put_super() won't be called
> at all, so in that case you need it directly in ->kill_sb().
"

Thanks,
Gao Xiang

