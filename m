Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12F76AE94D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2019 13:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731138AbfIJLjm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Sep 2019 07:39:42 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:42885 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730304AbfIJLjm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Sep 2019 07:39:42 -0400
Received: by mail-ua1-f65.google.com with SMTP id w16so5417598uap.9;
        Tue, 10 Sep 2019 04:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=3Rm/1Qq19YYv+1SXtr8/QYQm4VhWVV5tge6bTOKGrto=;
        b=dmsk+EJ5KhJsXCP/FnHoz/vT0G7PHB5ARBL6aFB2eHFmTnKtJiIlnaf5y+r4A+rLh6
         EEhYgmlfheMD6lWK6DmaEmh/p5I5LzeN7khwCZQV252Lj/pVrnkMQzyXbDlLUEO+pJkH
         bhit3hMTv7poA42s4RwHyfWt+FelpJt2/23zKuV66yCipDND6+9Zc4IOreBSSP1BRTW5
         3Ptsd7bOzXN76NflKSYXE/f4xNpJMBaoJSAZGDQsSIHAdFVQm1bkm8XmSNxr0BZua9Aa
         3D+PjVilLcoNy0P5pb7GNC9ZhsnqY6TxpTXJGm8oFq+uWHgjtJrz8OqVKfywboriXf3M
         +jfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=3Rm/1Qq19YYv+1SXtr8/QYQm4VhWVV5tge6bTOKGrto=;
        b=IDO3YMOs14oCF0x5O2/Kz0v8AdhtBVeH2wRqyhOAg10sidMWUeTgHum947RWPFR7p9
         oR1hp02WqRbnqGR1WrMO0lsBgVgy848tWDEs2H82OhuEGf8GDGmwpZJsQKj+J5ffRUXq
         JBpuymv8XW1lZiHjjEKUSndVNSn8CJL1AhCLJ7ju5gyPxaOe6UKyNzg4ieeb7TP6whAl
         z5/5Ks41/tTnuLEJjITQBCIoxWupJJA83uwOrPPOX/wCWnXKD3OllkOCUw4h1QFUHzqX
         byryCV+XvZnHUC6ojinWZuG/y6SNc5VclVmSi2EUPojhjQWnCP8FD6x6EvrmL8MKQ7m2
         BMxQ==
X-Gm-Message-State: APjAAAWH/C2vPMM771wmg86vuALAIYBsf/7WI/YIvoCN18YEyNWVHPmD
        X/OuU84lr5jKJ6ejVG1saclW33eZKy66UeEg+hI=
X-Google-Smtp-Source: APXvYqxcausnx3GW+S3FZvTp8/cgBtMVP1K10O1AxNokeAGAsUi/i1kdW6Z2YX2hLeGbBK1vVgEDKxezsSzAqPYm0k4=
X-Received: by 2002:ab0:30ef:: with SMTP id d15mr12968172uam.135.1568115580248;
 Tue, 10 Sep 2019 04:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1567623877.git.osandov@fb.com> <8eae56abb90c0fe87c350322485ce8674e135074.1567623877.git.osandov@fb.com>
In-Reply-To: <8eae56abb90c0fe87c350322485ce8674e135074.1567623877.git.osandov@fb.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 10 Sep 2019 12:39:28 +0100
Message-ID: <CAL3q7H6fxfPiNycFrd=OW_jv_kDSU1OyGE+Zgz1hYXdzUKd-3g@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs: add ioctl for directly writing compressed data
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 4, 2019 at 8:14 PM Omar Sandoval <osandov@osandov.com> wrote:
>
> From: Omar Sandoval <osandov@fb.com>
>
> This adds an API for writing compressed data directly to the filesystem.
> The use case that I have in mind is send/receive: currently, when
> sending data from one compressed filesystem to another, the sending side
> decompresses the data and the receiving side recompresses it before
> writing it out. This is wasteful and can be avoided if we can just send
> and write compressed extents. The send part will be implemented in a
> separate series, as this ioctl can stand alone.
>
> The interface is essentially pwrite(2) with some extra information:
>
> - The input buffer contains the compressed data.
> - Both the compressed and decompressed sizes of the data are given.
> - The compression type (zlib, lzo, or zstd) is given.
>
> The interface is general enough that it can be extended to encrypted or
> otherwise encoded extents in the future. A more detailed description,
> including restrictions and edge cases, is included in
> include/uapi/linux/btrfs.h.
>
> The implementation is similar to direct I/O: we have to flush any
> ordered extents, invalidate the page cache, and do the io
> tree/delalloc/extent map/ordered extent dance. From there, we can reuse
> the compression code with a minor modification to distinguish the new
> ioctl from writeback.
>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  fs/btrfs/compression.c     |   6 +-
>  fs/btrfs/compression.h     |  14 +--
>  fs/btrfs/ctree.h           |   6 ++
>  fs/btrfs/file.c            |  13 ++-
>  fs/btrfs/inode.c           | 192 ++++++++++++++++++++++++++++++++++++-
>  fs/btrfs/ioctl.c           |  95 ++++++++++++++++++
>  include/uapi/linux/btrfs.h |  69 +++++++++++++
>  7 files changed, 380 insertions(+), 15 deletions(-)
>
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index b05b361e2062..6632dd8d2e4d 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -276,7 +276,8 @@ static void end_compressed_bio_write(struct bio *bio)
>                         bio->bi_status =3D=3D BLK_STS_OK);
>         cb->compressed_pages[0]->mapping =3D NULL;
>
> -       end_compressed_writeback(inode, cb);
> +       if (cb->writeback)
> +               end_compressed_writeback(inode, cb);
>         /* note, our inode could be gone now */
>
>         /*
> @@ -311,7 +312,7 @@ blk_status_t btrfs_submit_compressed_write(struct ino=
de *inode, u64 start,
>                                  unsigned long compressed_len,
>                                  struct page **compressed_pages,
>                                  unsigned long nr_pages,
> -                                unsigned int write_flags)
> +                                unsigned int write_flags, bool writeback=
)
>  {
>         struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
>         struct bio *bio =3D NULL;
> @@ -336,6 +337,7 @@ blk_status_t btrfs_submit_compressed_write(struct ino=
de *inode, u64 start,
>         cb->mirror_num =3D 0;
>         cb->compressed_pages =3D compressed_pages;
>         cb->compressed_len =3D compressed_len;
> +       cb->writeback =3D writeback;
>         cb->orig_bio =3D NULL;
>         cb->nr_pages =3D nr_pages;
>
> diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
> index 4cb8be9ff88b..5b48eb730362 100644
> --- a/fs/btrfs/compression.h
> +++ b/fs/btrfs/compression.h
> @@ -6,6 +6,7 @@
>  #ifndef BTRFS_COMPRESSION_H
>  #define BTRFS_COMPRESSION_H
>
> +#include <linux/btrfs.h>
>  #include <linux/sizes.h>
>
>  /*
> @@ -47,6 +48,9 @@ struct compressed_bio {
>         /* the compression algorithm for this bio */
>         int compress_type;
>
> +       /* Whether this is a write for writeback. */
> +       bool writeback;
> +
>         /* number of compressed pages in the array */
>         unsigned long nr_pages;
>
> @@ -93,20 +97,12 @@ blk_status_t btrfs_submit_compressed_write(struct ino=
de *inode, u64 start,
>                                   unsigned long compressed_len,
>                                   struct page **compressed_pages,
>                                   unsigned long nr_pages,
> -                                 unsigned int write_flags);
> +                                 unsigned int write_flags, bool writebac=
k);
>  blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bi=
o *bio,
>                                  int mirror_num, unsigned long bio_flags)=
;
>
>  unsigned int btrfs_compress_str2level(unsigned int type, const char *str=
);
>
> -enum btrfs_compression_type {
> -       BTRFS_COMPRESS_NONE  =3D 0,
> -       BTRFS_COMPRESS_ZLIB  =3D 1,
> -       BTRFS_COMPRESS_LZO   =3D 2,
> -       BTRFS_COMPRESS_ZSTD  =3D 3,
> -       BTRFS_COMPRESS_TYPES =3D 3,
> -};
> -
>  struct workspace_manager {
>         const struct btrfs_compress_op *ops;
>         struct list_head idle_ws;
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 19d669d12ca1..9fae9b3f1f62 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -2905,6 +2905,10 @@ int btrfs_run_delalloc_range(struct inode *inode, =
struct page *locked_page,
>  int btrfs_writepage_cow_fixup(struct page *page, u64 start, u64 end);
>  void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
>                                           u64 end, int uptodate);
> +
> +ssize_t btrfs_raw_write(struct kiocb *iocb, struct iov_iter *from,
> +                       struct btrfs_ioctl_raw_pwrite_args *raw);
> +
>  extern const struct dentry_operations btrfs_dentry_operations;
>
>  /* ioctl.c */
> @@ -2928,6 +2932,8 @@ int btrfs_add_inode_defrag(struct btrfs_trans_handl=
e *trans,
>                            struct btrfs_inode *inode);
>  int btrfs_run_defrag_inodes(struct btrfs_fs_info *fs_info);
>  void btrfs_cleanup_defrag_inodes(struct btrfs_fs_info *fs_info);
> +ssize_t btrfs_do_write_iter(struct kiocb *iocb, struct iov_iter *from,
> +                           struct btrfs_ioctl_raw_pwrite_args *args);
>  int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int dat=
async);
>  void btrfs_drop_extent_cache(struct btrfs_inode *inode, u64 start, u64 e=
nd,
>                              int skip_pinned);
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 8fe4eb7e5045..ed23aa65b2d5 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1872,8 +1872,8 @@ static void update_time_for_write(struct inode *ino=
de)
>                 inode_inc_iversion(inode);
>  }
>
> -static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
> -                                   struct iov_iter *from)
> +ssize_t btrfs_do_write_iter(struct kiocb *iocb, struct iov_iter *from,
> +                           struct btrfs_ioctl_raw_pwrite_args *raw)
>  {
>         struct file *file =3D iocb->ki_filp;
>         struct inode *inode =3D file_inode(file);
> @@ -1965,7 +1965,9 @@ static ssize_t btrfs_file_write_iter(struct kiocb *=
iocb,
>         if (sync)
>                 atomic_inc(&BTRFS_I(inode)->sync_writers);
>
> -       if (iocb->ki_flags & IOCB_DIRECT) {
> +       if (raw) {
> +               num_written =3D btrfs_raw_write(iocb, from, raw);
> +       } else if (iocb->ki_flags & IOCB_DIRECT) {
>                 num_written =3D __btrfs_direct_write(iocb, from);
>         } else {
>                 num_written =3D btrfs_buffered_write(iocb, from);
> @@ -1996,6 +1998,11 @@ static ssize_t btrfs_file_write_iter(struct kiocb =
*iocb,
>         return num_written ? num_written : err;
>  }
>
> +static ssize_t btrfs_file_write_iter(struct kiocb *iocb, struct iov_iter=
 *from)
> +{
> +       return btrfs_do_write_iter(iocb, from, NULL);
> +}
> +
>  int btrfs_release_file(struct inode *inode, struct file *filp)
>  {
>         struct btrfs_file_private *private =3D filp->private_data;
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index a0546401bc0a..c8eaa1e5bf06 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -865,7 +865,7 @@ static noinline void submit_compressed_extents(struct=
 async_chunk *async_chunk)
>                                     ins.objectid,
>                                     ins.offset, async_extent->pages,
>                                     async_extent->nr_pages,
> -                                   async_chunk->write_flags)) {
> +                                   async_chunk->write_flags, true)) {
>                         struct page *p =3D async_extent->pages[0];
>                         const u64 start =3D async_extent->start;
>                         const u64 end =3D start + async_extent->ram_size =
- 1;
> @@ -10590,6 +10590,196 @@ void btrfs_set_range_writeback(struct extent_io=
_tree *tree, u64 start, u64 end)
>         }
>  }
>
> +/* Currently, this only supports raw writes of compressed data. */
> +ssize_t btrfs_raw_write(struct kiocb *iocb, struct iov_iter *from,
> +                       struct btrfs_ioctl_raw_pwrite_args *raw)
> +{
> +       struct file *file =3D iocb->ki_filp;
> +       struct inode *inode =3D file_inode(file);
> +       struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
> +       struct btrfs_root *root =3D BTRFS_I(inode)->root;
> +       struct extent_io_tree *io_tree =3D &BTRFS_I(inode)->io_tree;
> +       struct extent_changeset *data_reserved =3D NULL;
> +       struct extent_state *cached_state =3D NULL;
> +       unsigned long nr_pages, i;
> +       struct page **pages;
> +       u64 disk_num_bytes, num_bytes;
> +       u64 start, end;
> +       struct btrfs_key ins;
> +       struct extent_map *em;
> +       ssize_t ret;
> +
> +       if (iov_iter_count(from) !=3D raw->num_bytes) {
> +               /*
> +                * The write got truncated by generic_write_checks(). We =
can't
> +                * do a partial raw write.
> +                */
> +               return -EFBIG;
> +       }
> +
> +       /* This should be handled higher up. */
> +       ASSERT(raw->num_bytes !=3D 0);
> +
> +       /* The extent size must be sane. */
> +       if (raw->num_bytes > BTRFS_MAX_UNCOMPRESSED ||
> +           raw->disk_num_bytes > BTRFS_MAX_COMPRESSED ||
> +           raw->disk_num_bytes =3D=3D 0)
> +               return -EINVAL;

For the uncompressed size (num_bytes), even if it's within the limit,
shouldn't we validate it?
We can't trust for sure that what the user supplies is actually
correct. Can't we grab that from the compressed buffer (I suppose at
least most compression methods encode that in a header or trailer)?
Without such validation we can end up corrupt data/metadata on disk.

Thanks.

> +
> +       /*
> +        * The compressed data on disk must be sector-aligned. For conven=
ience,
> +        * we extend the compressed data with zeroes if it isn't.
> +        */
> +       disk_num_bytes =3D ALIGN(raw->disk_num_bytes, fs_info->sectorsize=
);
> +       /*
> +        * The extent in the file must also be sector-aligned. However, w=
e allow
> +        * a write which ends at or extends i_size to have an unaligned l=
ength;
> +        * we round up the extent size and set i_size to the given length=
.
> +        */
> +       start =3D iocb->ki_pos;
> +       if ((start & (fs_info->sectorsize - 1)))
> +               return -EINVAL;
> +       if (start + raw->num_bytes >=3D inode->i_size) {
> +               num_bytes =3D ALIGN(raw->num_bytes, fs_info->sectorsize);
> +       } else {
> +               num_bytes =3D raw->num_bytes;
> +               if ((num_bytes & (fs_info->sectorsize - 1)))
> +                       return -EINVAL;
> +       }
> +       end =3D start + num_bytes - 1;
> +
> +       /*
> +        * It's valid for compressed data to be larger than or the same s=
ize as
> +        * the decompressed data. However, for buffered I/O, we never wri=
te out
> +        * a compressed extent unless it's smaller than the decompressed =
data,
> +        * so for now, let's not allow creating such extents with the ioc=
tl,
> +        * either.
> +        */
> +       if (disk_num_bytes >=3D num_bytes)
> +               return -EINVAL;
> +
> +       nr_pages =3D DIV_ROUND_UP(disk_num_bytes, PAGE_SIZE);
> +       pages =3D kcalloc(nr_pages, sizeof(struct page *),
> +                       GFP_USER | __GFP_NOWARN);
> +       if (!pages)
> +               return -ENOMEM;
> +       for (i =3D 0; i < nr_pages; i++) {
> +               unsigned long offset =3D i << PAGE_SHIFT, n;
> +               char *kaddr;
> +
> +               pages[i] =3D alloc_page(GFP_USER | __GFP_NOWARN);
> +               if (!pages[i]) {
> +                       ret =3D -ENOMEM;
> +                       goto out_pages;
> +               }
> +               kaddr =3D kmap(pages[i]);
> +               if (offset < raw->disk_num_bytes) {
> +                       n =3D min_t(unsigned long, PAGE_SIZE,
> +                                 raw->disk_num_bytes - offset);
> +                       if (copy_from_user(kaddr, raw->buf + offset, n)) =
{
> +                               kunmap(pages[i]);
> +                               ret =3D -EFAULT;
> +                               goto out_pages;
> +                       }
> +               } else {
> +                       n =3D 0;
> +               }
> +               if (n < PAGE_SIZE)
> +                       memset(kaddr + n, 0, PAGE_SIZE - n);
> +               kunmap(pages[i]);
> +       }
> +
> +       for (;;) {
> +               struct btrfs_ordered_extent *ordered;
> +
> +               lock_extent_bits(io_tree, start, end, &cached_state);
> +               ordered =3D btrfs_lookup_ordered_range(BTRFS_I(inode), st=
art,
> +                                                    end - start + 1);
> +               if (!ordered &&
> +                   !filemap_range_has_page(inode->i_mapping, start, end)=
)
> +                       break;
> +               if (ordered)
> +                       btrfs_put_ordered_extent(ordered);
> +               unlock_extent_cached(&BTRFS_I(inode)->io_tree, start, end=
,
> +                                    &cached_state);
> +               cond_resched();
> +               ret =3D btrfs_wait_ordered_range(inode, start, end);
> +               if (ret)
> +                       goto out_pages;
> +               ret =3D invalidate_inode_pages2_range(inode->i_mapping,
> +                                                   start >> PAGE_SHIFT,
> +                                                   end >> PAGE_SHIFT);
> +               if (ret)
> +                       goto out_pages;
> +       }
> +
> +       ret =3D btrfs_delalloc_reserve_space(inode, &data_reserved, start=
,
> +                                          num_bytes);
> +       if (ret)
> +               goto out_unlock;
> +
> +       ret =3D btrfs_reserve_extent(root, num_bytes, disk_num_bytes,
> +                                  disk_num_bytes, 0, 0, &ins, 1, 1);
> +       if (ret)
> +               goto out_delalloc_release;
> +
> +       em =3D create_io_em(inode, start, num_bytes, start, ins.objectid,
> +                         ins.offset, ins.offset, num_bytes, raw->compres=
sion,
> +                         BTRFS_ORDERED_COMPRESSED);
> +       if (IS_ERR(em)) {
> +               ret =3D PTR_ERR(em);
> +               goto out_free_reserve;
> +       }
> +       free_extent_map(em);
> +
> +       ret =3D btrfs_add_ordered_extent_compress(inode, start, ins.objec=
tid,
> +                                               num_bytes, ins.offset,
> +                                               BTRFS_ORDERED_COMPRESSED,
> +                                               raw->compression);
> +       if (ret) {
> +               btrfs_drop_extent_cache(BTRFS_I(inode), start, end, 0);
> +               goto out_free_reserve;
> +       }
> +       btrfs_dec_block_group_reservations(fs_info, ins.objectid);
> +
> +       if (start + raw->num_bytes > inode->i_size)
> +               i_size_write(inode, start + raw->num_bytes);
> +
> +       unlock_extent_cached(io_tree, start, end, &cached_state);
> +
> +       btrfs_delalloc_release_extents(BTRFS_I(inode), num_bytes, false);
> +
> +       if (btrfs_submit_compressed_write(inode, start, num_bytes, ins.ob=
jectid,
> +                                         ins.offset, pages, nr_pages, 0,
> +                                         false)) {
> +               struct page *page =3D pages[0];
> +
> +               page->mapping =3D inode->i_mapping;
> +               btrfs_writepage_endio_finish_ordered(page, start, end, 0)=
;
> +               page->mapping =3D NULL;
> +               ret =3D -EIO;
> +               goto out_pages;
> +       }
> +       iocb->ki_pos +=3D raw->num_bytes;
> +       return raw->num_bytes;
> +
> +out_free_reserve:
> +       btrfs_dec_block_group_reservations(fs_info, ins.objectid);
> +       btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, 1);
> +out_delalloc_release:
> +       btrfs_delalloc_release_space(inode, data_reserved, start, num_byt=
es,
> +                                    true);
> +out_unlock:
> +       unlock_extent_cached(io_tree, start, end, &cached_state);
> +out_pages:
> +       for (i =3D 0; i < nr_pages; i++) {
> +               if (pages[i])
> +                       put_page(pages[i]);
> +       }
> +       kfree(pages);
> +       return ret;
> +}
> +
>  #ifdef CONFIG_SWAP
>  /*
>   * Add an entry indicating a block group or device which is pinned by a
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index de730e56d3f5..c803732c9722 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -26,6 +26,7 @@
>  #include <linux/btrfs.h>
>  #include <linux/uaccess.h>
>  #include <linux/iversion.h>
> +#include <linux/sched/xacct.h>
>  #include "ctree.h"
>  #include "disk-io.h"
>  #include "transaction.h"
> @@ -84,6 +85,20 @@ struct btrfs_ioctl_send_args_32 {
>
>  #define BTRFS_IOC_SEND_32 _IOW(BTRFS_IOCTL_MAGIC, 38, \
>                                struct btrfs_ioctl_send_args_32)
> +
> +struct btrfs_ioctl_raw_pwrite_args_32 {
> +       __u64 offset;           /* in */
> +       __u64 num_bytes;        /* in */
> +       __u64 disk_num_bytes;   /* in */
> +       __u8 compression;       /* in */
> +       __u8 encryption;        /* in */
> +       __u16 other_encoding;   /* in */
> +       __u32 reserved[7];
> +       compat_uptr_t buf;      /* in */
> +} __attribute__ ((__packed__));
> +
> +#define BTRFS_IOC_RAW_PWRITE_32 _IOW(BTRFS_IOCTL_MAGIC, 63, \
> +                                    struct btrfs_ioctl_raw_pwrite_args_3=
2)
>  #endif
>
>  static int btrfs_clone(struct inode *src, struct inode *inode,
> @@ -5437,6 +5452,80 @@ static int _btrfs_ioctl_send(struct file *file, vo=
id __user *argp, bool compat)
>         return ret;
>  }
>
> +static int btrfs_ioctl_raw_pwrite(struct file *file, void __user *argp,
> +                                 bool compat)
> +{
> +       struct btrfs_ioctl_raw_pwrite_args args;
> +       struct iov_iter iter;
> +       loff_t pos;
> +       struct kiocb kiocb;
> +       ssize_t ret;
> +
> +       if (!capable(CAP_SYS_ADMIN))
> +               return -EPERM;
> +
> +       if (!(file->f_mode & FMODE_WRITE))
> +               return -EBADF;
> +
> +       if (compat) {
> +#if defined(CONFIG_64BIT) && defined(CONFIG_COMPAT)
> +               struct btrfs_ioctl_raw_pwrite_args_32 args32;
> +
> +               if (copy_from_user(&args32, argp, sizeof(args32)))
> +                       return -EFAULT;
> +               args.offset =3D args32.offset;
> +               args.num_bytes =3D args32.num_bytes;
> +               args.disk_num_bytes =3D args32.disk_num_bytes;
> +               args.compression =3D args32.compression;
> +               args.encryption =3D args32.encryption;
> +               args.other_encoding =3D args32.other_encoding;
> +               memcpy(args.reserved, args32.reserved, sizeof(args.reserv=
ed));
> +               args.buf =3D compat_ptr(args32.buf);
> +#else
> +               return -ENOTTY;
> +#endif
> +       } else {
> +               if (copy_from_user(&args, argp, sizeof(args)))
> +                       return -EFAULT;
> +       }
> +
> +       /* The compression type must be valid. */
> +       if (args.compression =3D=3D BTRFS_COMPRESS_NONE ||
> +           args.compression > BTRFS_COMPRESS_TYPES)
> +               return -EINVAL;
> +       /* Reserved fields must be zero. */
> +       if (args.encryption || args.other_encoding ||
> +           memchr_inv(args.reserved, 0, sizeof(args.reserved)))
> +               return -EINVAL;
> +
> +       if (unlikely(!access_ok(args.buf, args.disk_num_bytes)))
> +               return -EFAULT;
> +
> +       pos =3D args.offset;
> +       ret =3D rw_verify_area(WRITE, file, &pos, args.num_bytes);
> +       if (ret)
> +               return ret;
> +
> +       init_sync_kiocb(&kiocb, file);
> +       kiocb.ki_pos =3D pos;
> +       /*
> +        * This iov_iter is a lie; we only construct it so that we can us=
e
> +        * write_iter.
> +        */
> +       iov_iter_init(&iter, WRITE, NULL, 0, args.num_bytes);
> +
> +       file_start_write(file);
> +       ret =3D btrfs_do_write_iter(&kiocb, &iter, &args);
> +       if (ret > 0) {
> +               ASSERT(ret =3D=3D args.num_bytes);
> +               fsnotify_modify(file);
> +               add_wchar(current, ret);
> +       }
> +       inc_syscw(current);
> +       file_end_write(file);
> +       return ret < 0 ? ret : 0;
> +}
> +
>  long btrfs_ioctl(struct file *file, unsigned int
>                 cmd, unsigned long arg)
>  {
> @@ -5583,6 +5672,12 @@ long btrfs_ioctl(struct file *file, unsigned int
>                 return btrfs_ioctl_get_subvol_rootref(file, argp);
>         case BTRFS_IOC_INO_LOOKUP_USER:
>                 return btrfs_ioctl_ino_lookup_user(file, argp);
> +       case BTRFS_IOC_RAW_PWRITE:
> +               return btrfs_ioctl_raw_pwrite(file, argp, false);
> +#if defined(CONFIG_64BIT) && defined(CONFIG_COMPAT)
> +       case BTRFS_IOC_RAW_PWRITE_32:
> +               return btrfs_ioctl_raw_pwrite(file, argp, true);
> +#endif
>         }
>
>         return -ENOTTY;
> diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
> index 3ee0678c0a83..b4dce062265a 100644
> --- a/include/uapi/linux/btrfs.h
> +++ b/include/uapi/linux/btrfs.h
> @@ -822,6 +822,73 @@ struct btrfs_ioctl_get_subvol_rootref_args {
>                 __u8 align[7];
>  };
>
> +enum btrfs_compression_type {
> +       BTRFS_COMPRESS_NONE  =3D 0,
> +       BTRFS_COMPRESS_ZLIB  =3D 1,
> +       BTRFS_COMPRESS_LZO   =3D 2,
> +       BTRFS_COMPRESS_ZSTD  =3D 3,
> +       BTRFS_COMPRESS_TYPES =3D 3,
> +};
> +
> +/*
> + * Write an extent directly to the filesystem. CAP_SYS_ADMIN is required=
 and the
> + * file descriptor must be open for writing.
> + *
> + * Currently, this is only for writing compressed data. However, it may =
be
> + * extended in the future.
> + */
> +struct btrfs_ioctl_raw_pwrite_args {
> +       /*
> +        * Offset in file where to write. This must be aligned to the sec=
tor
> +        * size of the filesystem.
> +        */
> +       __u64 offset;           /* in */
> +       /*
> +        * Length of the extent in the file, in bytes. This must be align=
ed to
> +        * the sector size of the filesystem unless the data ends at or b=
eyond
> +        * the current end of file; this special case is to support creat=
ing
> +        * files whose length is not aligned to the sector size.
> +        *
> +        * For a compressed extent, this is the length of the decompresse=
d data.
> +        * It must be less than 128k (BTRFS_MAX_UNCOMPRESSED), although t=
hat
> +        * limit may increase in the future.
> +        */
> +       __u64 num_bytes;        /* in */
> +       /*
> +        * Length of the extent on disk, in bytes (see buf below).
> +        *
> +        * For a compressed extent, this does not need to be aligned to a
> +        * sector. It must be less than 128k (BTRFS_MAX_COMPRESSED), alth=
ough
> +        * that limit may increase in the future.
> +        */
> +       __u64 disk_num_bytes;   /* in */
> +       /*
> +        * Compression type (enum btrfs_compression_type). Currently, thi=
s must
> +        * not be BTRFS_COMPRESS_NONE.
> +        */
> +       __u8 compression;       /* in */
> +       /* Encryption type. Currently, this must be zero. */
> +       __u8 encryption;        /* in */
> +       /* Other type of encoding. Currently, this must be zero. */
> +       __u16 other_encoding;   /* in */
> +       /* Reserved for future extensions. Must be zero. */
> +       __u32 reserved[7];
> +       /*
> +        * The raw data on disk.
> +        *
> +        * For a compressed extent, the format is as follows:
> +        *
> +        * - zlib: The extent is a single zlib stream.
> +        * - lzo: The extent is compressed page by page with LZO1X and wr=
apped
> +        *   according to the format documented in fs/btrfs/lzo.c.
> +        * - zstd: The extent is a single zstd stream. The windowLog comp=
ression
> +        *   parameter must be no more than 17 (ZSTD_BTRFS_MAX_WINDOWLOG)=
.
> +        *
> +        * If the compressed data is invalid, reading will return an erro=
r.
> +        */
> +       void __user *buf;       /* in */
> +} __attribute__ ((__packed__));
> +
>  /* Error codes as returned by the kernel */
>  enum btrfs_err_code {
>         BTRFS_ERROR_DEV_RAID1_MIN_NOT_MET =3D 1,
> @@ -946,5 +1013,7 @@ enum btrfs_err_code {
>                                 struct btrfs_ioctl_get_subvol_rootref_arg=
s)
>  #define BTRFS_IOC_INO_LOOKUP_USER _IOWR(BTRFS_IOCTL_MAGIC, 62, \
>                                 struct btrfs_ioctl_ino_lookup_user_args)
> +#define BTRFS_IOC_RAW_PWRITE _IOW(BTRFS_IOCTL_MAGIC, 63, \
> +                                 struct btrfs_ioctl_raw_pwrite_args)
>
>  #endif /* _UAPI_LINUX_BTRFS_H */
> --
> 2.23.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
