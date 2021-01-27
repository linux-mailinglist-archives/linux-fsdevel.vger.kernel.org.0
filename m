Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E44230513A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 05:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236705AbhA0EqV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 23:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237120AbhA0Dr4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 22:47:56 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6460FC061574;
        Tue, 26 Jan 2021 19:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=Zj/SeFFQ0DPQiZOul3omKOYcchar1PDV+FfUWz8iVLY=; b=XC8weHwcgwkduDzj8UlGC53QHZ
        LNJHTuataRohH3ieb8X7GXuoNlozXlgh1xjt2Yo7AvulVTOYnYeYHXnVF17PM881Ar5I5aKWJOBTd
        akIuWJ/G3PoKB//dv3Nuw/4vt51/m3cW0Liu3yseIDpxibyscOMXpB2JwESJb5Aq3dILToNUQmC8f
        yPQvO1XeBYsvP0MV38XOHDGnCTuNjdk7AaYYdoGJK3NNby74qkggnM8dWPgoVQRdoV+1HGVvh/hDG
        ISidqHZT5pLZDFx9+OrqUslwVkMevx9I4kooClmvWcDwQjHrbac7tgKOpefhdz7cONWT1xANzLmBU
        SxYYWQ6Q==;
Received: from [2601:1c0:6280:3f0::7650]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l4bnL-0007fz-Av; Wed, 27 Jan 2021 03:47:03 +0000
Subject: Re: [PATCH 1/2] fs/efs/inode.c: follow style guide
To:     Amy Parker <enbyamy@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <CAE1WUT55QViS=XE9QUTDp1KQ1_5fwuddLY3+2XSrMdoOuCOyYg@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5d005259-feec-686d-dc32-e1b10cf74459@infradead.org>
Date:   Tue, 26 Jan 2021 19:46:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAE1WUT55QViS=XE9QUTDp1KQ1_5fwuddLY3+2XSrMdoOuCOyYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Amy,

What mail client did you use?
It is breaking (splitting) long lines into shorter lines and that
makes it not possible to apply the patch cleanly.

You can see this problem below or on the web in an email archive.

Possibly Documentation/process/email-clients.rst can help you.


On 1/26/21 12:58 PM, Amy Parker wrote:
> This patch updates inode.c for EFS to follow the kernel style guide.
> 
> Signed-off-by: Amy Parker <enbyamy@gmail.com>
> ---
> fs/efs/inode.c | 64 +++++++++++++++++++++++++-------------------------
> 1 file changed, 32 insertions(+), 32 deletions(-)
> 
> diff --git a/fs/efs/inode.c b/fs/efs/inode.c
> index 89e73a6f0d36..4e81e7a15afb 100644
> --- a/fs/efs/inode.c
> +++ b/fs/efs/inode.c
> @@ -109,9 +109,9 @@ struct inode *efs_iget(struct super_block *super,
> unsigned long ino)
>        /* this is the number of blocks in the file */
>        if (inode->i_size == 0) {
>                inode->i_blocks = 0;
> -       } else {
> +       else
>                inode->i_blocks = ((inode->i_size - 1) >>
> EFS_BLOCKSIZE_BITS) + 1;
> -       }
> +
> 
>        rdev = be16_to_cpu(efs_inode->di_u.di_dev.odev);
>        if (rdev == 0xffff) {
> @@ -120,15 +120,16 @@ struct inode *efs_iget(struct super_block
> *super, unsigned long ino)
>                        device = 0;
>                else
>                        device = MKDEV(sysv_major(rdev), sysv_minor(rdev));
> -       } else
> +       } else {
>                device = old_decode_dev(rdev);
> +    }
> 
>        /* get the number of extents for this object */
>        in->numextents = be16_to_cpu(efs_inode->di_numextents);
>        in->lastextent = 0;
> 
>        /* copy the extents contained within the inode to memory */
> -       for(i = 0; i < EFS_DIRECTEXTENTS; i++) {
> +       for (i = 0; i < EFS_DIRECTEXTENTS; i++) {
>                extent_copy(&(efs_inode->di_u.di_extents[i]), &(in->extents[i]));
>                if (i < in->numextents && in->extents[i].cooked.ex_magic != 0) {
>                        pr_warn("extent %d has bad magic number in inode %lu\n",
> @@ -142,28 +143,28 @@ struct inode *efs_iget(struct super_block
> *super, unsigned long ino)
>        pr_debug("efs_iget(): inode %lu, extents %d, mode %o\n",
>                 inode->i_ino, in->numextents, inode->i_mode);
>        switch (inode->i_mode & S_IFMT) {
> -               case S_IFDIR:
> -                       inode->i_op = &efs_dir_inode_operations;
> -                       inode->i_fop = &efs_dir_operations;
> -                       break;
> -               case S_IFREG:
> -                       inode->i_fop = &generic_ro_fops;
> -                       inode->i_data.a_ops = &efs_aops;
> -                       break;
> -               case S_IFLNK:
> -                       inode->i_op = &page_symlink_inode_operations;
> -                       inode_nohighmem(inode);
> -                       inode->i_data.a_ops = &efs_symlink_aops;
> -                       break;
> -               case S_IFCHR:
> -               case S_IFBLK:
> -               case S_IFIFO:
> -                       init_special_inode(inode, inode->i_mode, device);
> -                       break;
> -               default:
> -                       pr_warn("unsupported inode mode %o\n", inode->i_mode);
> -                       goto read_inode_error;
> -                       break;
> +    case S_IFDIR:
> +        inode->i_op = &efs_dir_inode_operations;
> +        inode->i_fop = &efs_dir_operations;
> +        break;
> +    case S_IFREG:
> +        inode->i_fop = &generic_ro_fops;
> +        inode->i_data.a_ops = &efs_aops;
> +        break;
> +    case S_IFLNK:
> +        inode->i_op = &page_symlink_inode_operations;
> +        inode_nohighmem(inode);
> +        inode->i_data.a_ops = &efs_symlink_aops;
> +        break;
> +    case S_IFCHR:
> +    case S_IFBLK:
> +    case S_IFIFO:
> +        init_special_inode(inode, inode->i_mode, device);
> +        break;
> +    default:
> +        pr_warn("unsupported inode mode %o\n", inode->i_mode);
> +        goto read_inode_error;
> +        break;
>        }
> 
>        unlock_new_inode(inode);
> @@ -189,11 +190,10 @@ efs_extent_check(efs_extent *ptr, efs_block_t
> block, struct efs_sb_info *
> sb) {
>        length = ptr->cooked.ex_length;
>        offset = ptr->cooked.ex_offset;
> 
> -       if ((block >= offset) && (block < offset+length)) {
> +       if ((block >= offset) && (block < offset+length))
>                return(sb->fs_start + start + block - offset);
> -       } else {
> +       else
>                return 0;
> -       }
> }
> 
> efs_block_t efs_map_block(struct inode *inode, efs_block_t block) {
> @@ -225,7 +225,7 @@ efs_block_t efs_map_block(struct inode *inode,
> efs_block_t block) {
>                 * check the stored extents in the inode
>                 * start with next extent and check forwards
>                 */
> -               for(dirext = 1; dirext < direxts; dirext++) {
> +               for (dirext = 1; dirext < direxts; dirext++) {
>                        cur = (last + dirext) % in->numextents;
>                        if ((result =
> efs_extent_check(&in->extents[cur], block, sb))) {
>                                in->lastextent = cur;
> @@ -242,7 +242,7 @@ efs_block_t efs_map_block(struct inode *inode,
> efs_block_t block) {
>        direxts = in->extents[0].cooked.ex_offset;
>        indexts = in->numextents;
> 
> -       for(indext = 0; indext < indexts; indext++) {
> +       for (indext = 0; indext < indexts; indext++) {
>                cur = (last + indext) % indexts;
> 
>                /*
> @@ -253,7 +253,7 @@ efs_block_t efs_map_block(struct inode *inode,
> efs_block_t block) {
>                 *
>                 */
>                ibase = 0;
> -               for(dirext = 0; cur < ibase && dirext < direxts; dirext++) {
> +               for (dirext = 0; cur < ibase && dirext < direxts; dirext++) {
>                        ibase += in->extents[dirext].cooked.ex_length *
>                                (EFS_BLOCKSIZE / sizeof(efs_extent));
>                }
> --
> 2.29.2
> 


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
netiquette: https://people.kernel.org/tglx/notes-about-netiquette
