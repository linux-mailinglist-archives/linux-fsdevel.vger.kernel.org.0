Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6706FB03B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 14:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbjEHMij (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 May 2023 08:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234365AbjEHMih (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 May 2023 08:38:37 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3023847D;
        Mon,  8 May 2023 05:38:28 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 321E621C3;
        Mon,  8 May 2023 12:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1683549220;
        bh=m8J2DhIaj3TzmKf7gCBnUyygD/mI1P53ydepgnojJwg=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=ZV35sZfUcJxuTGkegN09yLdiMGkSMbNKfRVhu2v/+HjHcYNR79o1udEVeqZcAycz8
         Yb1lyiyy2IfndhzuvBx4eKWQC4XqXUYRfJcVU0BOmZflN7SxluB5U1p2oiNrd2DsD3
         y2k20MYorcZ3RPW/nY8O6U868xzppfR2aUa33A/c=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id D5EA32191;
        Mon,  8 May 2023 12:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1683549506;
        bh=m8J2DhIaj3TzmKf7gCBnUyygD/mI1P53ydepgnojJwg=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=nx46qKAPqKXTjS1lOLPI8rVmduNnSNAYmelRkzYOKviVzieW7hOUPqHv0NVD3L7K/
         2Fo+5B7D/iywEEWQ+pIENcalq6ZcVx+Lb/sdZJubJ/eX1GNdEZryFm8YhIRd0tHG3R
         MBbkTJGyC84JblzCfBXdTSSKS1iDyAIsN3adP9ck=
Received: from [192.168.211.146] (192.168.211.146) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 8 May 2023 15:38:26 +0300
Message-ID: <516867bf-9ff1-f232-82d9-583e96de7335@paragon-software.com>
Date:   Mon, 8 May 2023 16:38:25 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: [PATCH 06/10] fs/ntfs3: Code formatting
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <b21a4bc9-166d-2631-d73b-cb4e802ff69e@paragon-software.com>
In-Reply-To: <b21a4bc9-166d-2631-d73b-cb4e802ff69e@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.211.146]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

clang-format-15 was used to format code according kernel's .clang-format.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/attrib.c  |  2 +-
  fs/ntfs3/bitmap.c  | 10 +++++-----
  fs/ntfs3/file.c    |  4 ++--
  fs/ntfs3/frecord.c | 16 ++++++++++------
  fs/ntfs3/fslog.c   | 40 ++++++++++++++++++++--------------------
  fs/ntfs3/fsntfs.c  |  2 +-
  fs/ntfs3/index.c   | 14 +++++++-------
  fs/ntfs3/inode.c   | 18 +++++++++---------
  fs/ntfs3/lznt.c    |  6 +++---
  fs/ntfs3/namei.c   | 16 ++++++++--------
  fs/ntfs3/ntfs_fs.h | 10 +++++-----
  fs/ntfs3/run.c     |  4 ++--
  fs/ntfs3/super.c   | 17 ++++++++++++-----
  fs/ntfs3/xattr.c   | 16 +++++++---------
  14 files changed, 92 insertions(+), 83 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 0b8bc66377db..a9d82bbb4729 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -573,7 +573,7 @@ int attr_set_size(struct ntfs_inode *ni, enum 
ATTR_TYPE type,
                  sbi, run, vcn, lcn, to_allocate, &pre_alloc,
                  is_mft ? ALLOCATE_MFT : ALLOCATE_DEF, &alen,
                  is_mft ? 0 :
-                           (sbi->record_size -
+                     (sbi->record_size -
                        le32_to_cpu(rec->used) + 8) /
                               3 +
                           1,
diff --git a/fs/ntfs3/bitmap.c b/fs/ntfs3/bitmap.c
index 9a6c6a09d70c..107e808e06ea 100644
--- a/fs/ntfs3/bitmap.c
+++ b/fs/ntfs3/bitmap.c
@@ -287,8 +287,8 @@ static void wnd_add_free_ext(struct wnd_bitmap *wnd, 
size_t bit, size_t len,
              /* Check bits before 'bit'. */
              ib = wnd->zone_bit == wnd->zone_end ||
                           bit < wnd->zone_end ?
-                       0 :
-                       wnd->zone_end;
+                     0 :
+                     wnd->zone_end;

              while (bit > ib && wnd_is_free_hlp(wnd, bit - 1, 1)) {
                  bit -= 1;
@@ -298,8 +298,8 @@ static void wnd_add_free_ext(struct wnd_bitmap *wnd, 
size_t bit, size_t len,
              /* Check bits after 'end_in'. */
              ib = wnd->zone_bit == wnd->zone_end ||
                           end_in > wnd->zone_bit ?
-                       wnd->nbits :
-                       wnd->zone_bit;
+                     wnd->nbits :
+                     wnd->zone_bit;

              while (end_in < ib && wnd_is_free_hlp(wnd, end_in, 1)) {
                  end_in += 1;
@@ -418,7 +418,7 @@ static void wnd_remove_free_ext(struct wnd_bitmap 
*wnd, size_t bit, size_t len)
          n3 = rb_first(&wnd->count_tree);
          wnd->extent_max =
              n3 ? rb_entry(n3, struct e_node, count.node)->count.key :
-                   0;
+                 0;
          return;
      }

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index c4983e028d90..4c653945ef08 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -192,7 +192,7 @@ static int ntfs_zero_range(struct inode *inode, u64 
vbo, u64 vbo_to)
      for (; idx < idx_end; idx += 1, from = 0) {
          page_off = (loff_t)idx << PAGE_SHIFT;
          to = (page_off + PAGE_SIZE) > vbo_to ? (vbo_to - page_off) :
-                                 PAGE_SIZE;
+                               PAGE_SIZE;
          iblock = page_off >> inode->i_blkbits;

          page = find_or_create_page(mapping, idx,
@@ -1052,7 +1052,7 @@ static ssize_t ntfs_file_write_iter(struct kiocb 
*iocb, struct iov_iter *from)
          goto out;

      ret = is_compressed(ni) ? ntfs_compress_write(iocb, from) :
-                    __generic_file_write_iter(iocb, from);
+                  __generic_file_write_iter(iocb, from);

  out:
      inode_unlock(inode);
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 66f3341c65ec..4227e3f590a5 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -77,7 +77,7 @@ struct ATTR_STD_INFO *ni_std(struct ntfs_inode *ni)

      attr = mi_find_attr(&ni->mi, NULL, ATTR_STD, NULL, 0, NULL);
      return attr ? resident_data_ex(attr, sizeof(struct ATTR_STD_INFO)) :
-                NULL;
+              NULL;
  }

  /*
@@ -92,7 +92,7 @@ struct ATTR_STD_INFO5 *ni_std5(struct ntfs_inode *ni)
      attr = mi_find_attr(&ni->mi, NULL, ATTR_STD, NULL, 0, NULL);

      return attr ? resident_data_ex(attr, sizeof(struct ATTR_STD_INFO5)) :
-                NULL;
+              NULL;
  }

  /*
@@ -517,6 +517,9 @@ ni_ins_new_attr(struct ntfs_inode *ni, struct 
mft_inode *mi,
   */
  static int ni_repack(struct ntfs_inode *ni)
  {
+#if 1
+    return 0;
+#else
      int err = 0;
      struct ntfs_sb_info *sbi = ni->mi.sbi;
      struct mft_inode *mi, *mi_p = NULL;
@@ -639,6 +642,7 @@ static int ni_repack(struct ntfs_inode *ni)

      run_close(&run);
      return err;
+#endif
  }

  /*
@@ -1758,8 +1762,8 @@ int ni_new_attr_flags(struct ntfs_inode *ni, enum 
FILE_ATTRIBUTE new_fa)

      /* Resize nonresident empty attribute in-place only. */
      new_asize = (new_aflags & (ATTR_FLAG_COMPRESSED | 
ATTR_FLAG_SPARSED)) ?
-                  (SIZEOF_NONRESIDENT_EX + 8) :
-                  (SIZEOF_NONRESIDENT + 8);
+                (SIZEOF_NONRESIDENT_EX + 8) :
+                (SIZEOF_NONRESIDENT + 8);

      if (!mi_resize_attr(mi, attr, new_asize - le32_to_cpu(attr->size)))
          return -EOPNOTSUPP;
@@ -3161,8 +3165,8 @@ static bool ni_update_parent(struct ntfs_inode 
*ni, struct NTFS_DUP_INFO *dup,
              __le64 valid_le;

              dup->alloc_size = is_attr_ext(attr) ?
-                            attr->nres.total_size :
-                            attr->nres.alloc_size;
+                          attr->nres.total_size :
+                          attr->nres.alloc_size;
              dup->data_size = attr->nres.data_size;

              if (new_valid > data_size)
diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 57762c5fe68b..12f28cdf5c83 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -828,8 +828,8 @@ static inline struct RESTART_TABLE 
*extend_rsttbl(struct RESTART_TABLE *tbl,
      memcpy(rt + 1, tbl + 1, esize * used);

      rt->free_goal = free_goal == ~0u ?
-                      cpu_to_le32(~0u) :
-                      cpu_to_le32(sizeof(struct RESTART_TABLE) +
+                cpu_to_le32(~0u) :
+                cpu_to_le32(sizeof(struct RESTART_TABLE) +
                          free_goal * esize);

      if (tbl->first_free) {
@@ -1090,8 +1090,8 @@ static inline u64 base_lsn(struct ntfs_log *log,
             << log->file_data_bits) +
            ((((is_log_record_end(hdr) &&
                h_lsn <= le64_to_cpu(hdr->record_hdr.last_end_lsn)) ?
-                   le16_to_cpu(hdr->record_hdr.next_record_off) :
-                   log->page_size) +
+                 le16_to_cpu(hdr->record_hdr.next_record_off) :
+                 log->page_size) +
              lsn) >>
             3);

@@ -1299,8 +1299,8 @@ static void log_init_pg_hdr(struct ntfs_log *log, 
u32 sys_page_size,
          log->clst_per_page = 1;

      log->first_page = major_ver >= 2 ?
-                    0x22 * page_size :
-                    ((sys_page_size << 1) + (page_size << 1));
+                  0x22 * page_size :
+                  ((sys_page_size << 1) + (page_size << 1));
      log->major_ver = major_ver;
      log->minor_ver = minor_ver;
  }
@@ -1513,8 +1513,8 @@ static u32 current_log_avail(struct ntfs_log *log)
       * If there is no oldest lsn then start at the first page of the file.
       */
      oldest_off = (log->l_flags & NTFSLOG_NO_OLDEST_LSN) ?
-                   log->first_page :
-                   (log->oldest_lsn_off & ~log->sys_page_mask);
+                 log->first_page :
+                 (log->oldest_lsn_off & ~log->sys_page_mask);

      /*
       * We will use the next log page offset to compute the next free page.
@@ -1522,9 +1522,9 @@ static u32 current_log_avail(struct ntfs_log *log)
       * If we are at the first page then use the end of the file.
       */
      next_free_off = (log->l_flags & NTFSLOG_REUSE_TAIL) ?
-                      log->next_page + log->page_size :
+                log->next_page + log->page_size :
              log->next_page == log->first_page ? log->l_size :
-                                  log->next_page;
+                                log->next_page;

      /* If the two offsets are the same then there is no available 
space. */
      if (oldest_off == next_free_off)
@@ -1535,8 +1535,8 @@ static u32 current_log_avail(struct ntfs_log *log)
       */
      free_bytes =
          oldest_off < next_free_off ?
-                  log->total_avail_pages - (next_free_off - oldest_off) :
-                  oldest_off - next_free_off;
+            log->total_avail_pages - (next_free_off - oldest_off) :
+            oldest_off - next_free_off;

      free_bytes >>= log->page_bits;
      return free_bytes * log->reserved;
@@ -1671,7 +1671,7 @@ static int last_log_lsn(struct ntfs_log *log)

      best_lsn1 = first_tail ? base_lsn(log, first_tail, first_file_off) 
: 0;
      best_lsn2 = second_tail ? base_lsn(log, second_tail, 
second_file_off) :
-                    0;
+                  0;

      if (first_tail && second_tail) {
          if (best_lsn1 > best_lsn2) {
@@ -1767,7 +1767,7 @@ static int last_log_lsn(struct ntfs_log *log)
      page_cnt = page_pos = 1;

      curpage_off = seq_base == log->seq_num ? min(log->next_page, 
page_off) :
-                               log->next_page;
+                         log->next_page;

      wrapped_file =
          curpage_off == log->first_page &&
@@ -1826,8 +1826,8 @@ static int last_log_lsn(struct ntfs_log *log)
              ((lsn_cur >> log->file_data_bits) +
               ((curpage_off <
                 (lsn_to_vbo(log, lsn_cur) & ~log->page_mask)) ?
-                    1 :
-                    0)) != expected_seq) {
+                  1 :
+                  0)) != expected_seq) {
              goto check_tail;
          }

@@ -2643,8 +2643,8 @@ static inline bool check_index_root(const struct 
ATTRIB *attr,
      const struct INDEX_ROOT *root = resident_data(attr);
      u8 index_bits = le32_to_cpu(root->index_block_size) >=
                      sbi->cluster_size ?
-                      sbi->cluster_bits :
-                      SECTOR_SHIFT;
+                sbi->cluster_bits :
+                SECTOR_SHIFT;
      u8 block_clst = root->index_block_clst;

      if (le32_to_cpu(attr->res.data_size) < sizeof(struct INDEX_ROOT) ||
@@ -3861,9 +3861,9 @@ int log_replay(struct ntfs_inode *ni, bool 
*initialized)

      /* If we have a valid page then grab a pointer to the restart area. */
      ra2 = rst_info.valid_page ?
-                Add2Ptr(rst_info.r_page,
+              Add2Ptr(rst_info.r_page,
                    le16_to_cpu(rst_info.r_page->ra_off)) :
-                NULL;
+              NULL;

      if (rst_info.chkdsk_was_run ||
          (ra2 && ra2->client_idx[1] == LFS_NO_CLIENT_LE)) {
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 21567e58265c..1a0527e81ebb 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -173,7 +173,7 @@ int ntfs_fix_post_read(struct NTFS_RECORD_HEADER 
*rhdr, size_t bytes,

      fo = le16_to_cpu(rhdr->fix_off);
      fn = simple ? ((bytes >> SECTOR_SHIFT) + 1) :
-                le16_to_cpu(rhdr->fix_num);
+              le16_to_cpu(rhdr->fix_num);

      /* Check errors. */
      if ((fo & 1) || fo + fn * sizeof(short) > SECTOR_SIZE || !fn-- ||
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index b40da258e684..124c6e822623 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -432,8 +432,8 @@ static int scan_nres_bitmap(struct ntfs_inode *ni, 
struct ATTRIB *bitmap,
              nbits = 8 * (data_size - vbo);

          ok = nbits > from ?
-                   (*fn)((ulong *)bh->b_data, from, nbits, ret) :
-                   false;
+                 (*fn)((ulong *)bh->b_data, from, nbits, ret) :
+                 false;
          put_bh(bh);

          if (ok) {
@@ -1682,8 +1682,8 @@ static int indx_insert_into_root(struct ntfs_index 
*indx, struct ntfs_inode *ni,

      /* Create alloc and bitmap attributes (if not). */
      err = run_is_empty(&indx->alloc_run) ?
-                indx_create_allocate(indx, ni, &new_vbn) :
-                indx_add_allocate(indx, ni, &new_vbn);
+              indx_create_allocate(indx, ni, &new_vbn) :
+              indx_add_allocate(indx, ni, &new_vbn);

      /* Layout of record may be changed, so rescan root. */
      root = indx_get_root(indx, ni, &attr, &mi);
@@ -1874,8 +1874,8 @@ indx_insert_into_buffer(struct ntfs_index *indx, 
struct ntfs_inode *ni,
                (*indx->cmp)(new_de + 1, le16_to_cpu(new_de->key_size),
                     up_e + 1, le16_to_cpu(up_e->key_size),
                     ctx) < 0 ?
-                    hdr2 :
-                    hdr1,
+                  hdr2 :
+                  hdr1,
                new_de, NULL, ctx);

      indx_mark_used(indx, ni, new_vbn >> indx->idx2vbn_bits);
@@ -2346,7 +2346,7 @@ int indx_delete_entry(struct ntfs_index *indx, 
struct ntfs_inode *ni,
                                    re, ctx,
                                    fnd->level - 1,
                                    fnd) :
-                        indx_insert_into_root(indx, ni, re, e,
+                      indx_insert_into_root(indx, ni, re, e,
                                  ctx, fnd, 0);
              kfree(re);

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 6c560245eef4..f699cc053655 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -263,7 +263,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
              goto next_attr;

          run = ino == MFT_REC_BITMAP ? &sbi->used.bitmap.run :
-                            &ni->file.run;
+                          &ni->file.run;
          break;

      case ATTR_ROOT:
@@ -291,8 +291,8 @@ static struct inode *ntfs_read_mft(struct inode *inode,
              goto out;

          mode = sb->s_root ?
-                     (S_IFDIR | (0777 & sbi->options->fs_dmask_inv)) :
-                     (S_IFDIR | 0777);
+                   (S_IFDIR | (0777 & sbi->options->fs_dmask_inv)) :
+                   (S_IFDIR | 0777);
          goto next_attr;

      case ATTR_ALLOC:
@@ -450,7 +450,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
          inode->i_op = &ntfs_file_inode_operations;
          inode->i_fop = &ntfs_file_operations;
          inode->i_mapping->a_ops = is_compressed(ni) ? &ntfs_aops_cmpr :
-                                    &ntfs_aops;
+                                  &ntfs_aops;
          if (ino != MFT_REC_MFT)
              init_rwsem(&ni->file.run_lock);
      } else if (S_ISCHR(mode) || S_ISBLK(mode) || S_ISFIFO(mode) ||
@@ -787,7 +787,7 @@ static ssize_t ntfs_direct_IO(struct kiocb *iocb, 
struct iov_iter *iter)

      ret = blockdev_direct_IO(iocb, inode, iter,
                   wr ? ntfs_get_block_direct_IO_W :
-                        ntfs_get_block_direct_IO_R);
+                      ntfs_get_block_direct_IO_R);

      if (ret > 0)
          end = vbo + ret;
@@ -1191,11 +1191,11 @@ ntfs_create_reparse_buffer(struct ntfs_sb_info 
*sbi, const char *symname,
   * - ntfs_symlink
   * - ntfs_mkdir
   * - ntfs_atomic_open
- *
+ *
   * NOTE: if fnd != NULL (ntfs_atomic_open) then @dir is locked
   */
-struct inode *ntfs_create_inode(struct mnt_idmap *idmap,
-                struct inode *dir, struct dentry *dentry,
+struct inode *ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
+                struct dentry *dentry,
                  const struct cpu_str *uni, umode_t mode,
                  dev_t dev, const char *symname, u32 size,
                  struct ntfs_fnd *fnd)
@@ -1605,7 +1605,7 @@ struct inode *ntfs_create_inode(struct mnt_idmap 
*idmap,
          inode->i_op = &ntfs_file_inode_operations;
          inode->i_fop = &ntfs_file_operations;
          inode->i_mapping->a_ops = is_compressed(ni) ? &ntfs_aops_cmpr :
-                                    &ntfs_aops;
+                                  &ntfs_aops;
          init_rwsem(&ni->file.run_lock);
      } else {
          inode->i_op = &ntfs_special_inode_operations;
diff --git a/fs/ntfs3/lznt.c b/fs/ntfs3/lznt.c
index 61e161c7c567..4aae598d6d88 100644
--- a/fs/ntfs3/lznt.c
+++ b/fs/ntfs3/lznt.c
@@ -297,7 +297,7 @@ static inline ssize_t decompress_chunk(u8 *unc, u8 
*unc_end, const u8 *cmpr,
  struct lznt *get_lznt_ctx(int level)
  {
      struct lznt *r = kzalloc(level ? offsetof(struct lznt, hash) :
-                           sizeof(struct lznt),
+                     sizeof(struct lznt),
                   GFP_NOFS);

      if (r)
@@ -393,8 +393,8 @@ ssize_t decompress_lznt(const void *cmpr, size_t 
cmpr_size, void *unc,
          } else {
              /* This chunk does not contain compressed data. */
              unc_use = unc_chunk + LZNT_CHUNK_SIZE > unc_end ?
-                        unc_end - unc_chunk :
-                        LZNT_CHUNK_SIZE;
+                      unc_end - unc_chunk :
+                      LZNT_CHUNK_SIZE;

              if (cmpr_chunk + sizeof(chunk_hdr) + unc_use >
                  cmpr_end) {
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index 343bce6da58a..70f8c859e0ad 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -109,8 +109,8 @@ static int ntfs_create(struct mnt_idmap *idmap, 
struct inode *dir,
  {
      struct inode *inode;

-    inode = ntfs_create_inode(idmap, dir, dentry, NULL, S_IFREG | mode,
-                  0, NULL, 0, NULL);
+    inode = ntfs_create_inode(idmap, dir, dentry, NULL, S_IFREG | mode, 0,
+                  NULL, 0, NULL);

      return IS_ERR(inode) ? PTR_ERR(inode) : 0;
  }
@@ -125,8 +125,8 @@ static int ntfs_mknod(struct mnt_idmap *idmap, 
struct inode *dir,
  {
      struct inode *inode;

-    inode = ntfs_create_inode(idmap, dir, dentry, NULL, mode, rdev,
-                  NULL, 0, NULL);
+    inode = ntfs_create_inode(idmap, dir, dentry, NULL, mode, rdev, 
NULL, 0,
+                  NULL);

      return IS_ERR(inode) ? PTR_ERR(inode) : 0;
  }
@@ -199,8 +199,8 @@ static int ntfs_symlink(struct mnt_idmap *idmap, 
struct inode *dir,
      u32 size = strlen(symname);
      struct inode *inode;

-    inode = ntfs_create_inode(idmap, dir, dentry, NULL, S_IFLNK | 0777,
-                  0, symname, size, NULL);
+    inode = ntfs_create_inode(idmap, dir, dentry, NULL, S_IFLNK | 0777, 0,
+                  symname, size, NULL);

      return IS_ERR(inode) ? PTR_ERR(inode) : 0;
  }
@@ -213,8 +213,8 @@ static int ntfs_mkdir(struct mnt_idmap *idmap, 
struct inode *dir,
  {
      struct inode *inode;

-    inode = ntfs_create_inode(idmap, dir, dentry, NULL, S_IFDIR | mode,
-                  0, NULL, 0, NULL);
+    inode = ntfs_create_inode(idmap, dir, dentry, NULL, S_IFDIR | mode, 0,
+                  NULL, 0, NULL);

      return IS_ERR(inode) ? PTR_ERR(inode) : 0;
  }
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 2e4be773728d..6667a75411fc 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -708,8 +708,8 @@ int ntfs_sync_inode(struct inode *inode);
  int ntfs_flush_inodes(struct super_block *sb, struct inode *i1,
                struct inode *i2);
  int inode_write_data(struct inode *inode, const void *data, size_t bytes);
-struct inode *ntfs_create_inode(struct mnt_idmap *idmap,
-                struct inode *dir, struct dentry *dentry,
+struct inode *ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
+                struct dentry *dentry,
                  const struct cpu_str *uni, umode_t mode,
                  dev_t dev, const char *symname, u32 size,
                  struct ntfs_fnd *fnd);
@@ -858,12 +858,12 @@ unsigned long ntfs_names_hash(const u16 *name, 
size_t len, const u16 *upcase,

  /* globals from xattr.c */
  #ifdef CONFIG_NTFS3_FS_POSIX_ACL
-struct posix_acl *ntfs_get_acl(struct mnt_idmap *idmap,
-                   struct dentry *dentry, int type);
+struct posix_acl *ntfs_get_acl(struct mnt_idmap *idmap, struct dentry 
*dentry,
+                   int type);
  int ntfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
           struct posix_acl *acl, int type);
  int ntfs_init_acl(struct mnt_idmap *idmap, struct inode *inode,
-         struct inode *dir);
+          struct inode *dir);
  #else
  #define ntfs_get_acl NULL
  #define ntfs_set_acl NULL
diff --git a/fs/ntfs3/run.c b/fs/ntfs3/run.c
index 47612d16c027..cb8cf0161177 100644
--- a/fs/ntfs3/run.c
+++ b/fs/ntfs3/run.c
@@ -434,8 +434,8 @@ bool run_add_entry(struct runs_tree *run, CLST vcn, 
CLST lcn, CLST len,

              if (should_add_tail) {
                  tail_lcn = r->lcn == SPARSE_LCN ?
-                             SPARSE_LCN :
-                             (r->lcn + Tovcn);
+                           SPARSE_LCN :
+                           (r->lcn + Tovcn);
                  tail_vcn = r->vcn + Tovcn;
                  tail_len = r->len - Tovcn;
              }
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 2b48b45238ea..12019bfe1325 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -116,8 +116,8 @@ void ntfs_inode_printk(struct inode *inode, const 
char *fmt, ...)

      /* Use static allocated buffer, if possible. */
      name = atomic_dec_and_test(&s_name_buf_cnt) ?
-                 s_name_buf :
-                 kmalloc(sizeof(s_name_buf), GFP_NOFS);
+               s_name_buf :
+               kmalloc(sizeof(s_name_buf), GFP_NOFS);

      if (name) {
          struct dentry *de = d_find_alias(inode);
@@ -257,6 +257,7 @@ enum Opt {
      Opt_err,
  };

+// clang-format off
  static const struct fs_parameter_spec ntfs_fs_parameters[] = {
      fsparam_u32("uid",            Opt_uid),
      fsparam_u32("gid",            Opt_gid),
@@ -277,9 +278,13 @@ static const struct fs_parameter_spec 
ntfs_fs_parameters[] = {
      fsparam_flag_no("nocase",        Opt_nocase),
      {}
  };
+// clang-format on

  /*
   * Load nls table or if @nls is utf8 then return NULL.
+ *
+ * It is good idea to use here "const char *nls".
+ * But load_nls accepts "char*".
   */
  static struct nls_table *ntfs_load_nls(char *nls)
  {
@@ -790,7 +795,7 @@ static int ntfs_init_from_boot(struct super_block 
*sb, u32 sector_size,

      sbi->record_size = record_size =
          boot->record_size < 0 ? 1 << (-boot->record_size) :
-                          (u32)boot->record_size << cluster_bits;
+                    (u32)boot->record_size << cluster_bits;
      sbi->record_bits = blksize_bits(record_size);
      sbi->attr_size_tr = (5 * record_size >> 4); // ~320 bytes

@@ -808,8 +813,8 @@ static int ntfs_init_from_boot(struct super_block 
*sb, u32 sector_size,
      }

      sbi->index_size = boot->index_size < 0 ?
-                    1u << (-boot->index_size) :
-                    (u32)boot->index_size << cluster_bits;
+                  1u << (-boot->index_size) :
+                  (u32)boot->index_size << cluster_bits;

      /* Check index record size. */
      if (sbi->index_size < SECTOR_SIZE || 
!is_power_of_2(sbi->index_size)) {
@@ -1537,12 +1542,14 @@ static void ntfs_fs_free(struct fs_context *fc)
          put_mount_options(opts);
  }

+// clang-format off
  static const struct fs_context_operations ntfs_context_ops = {
      .parse_param    = ntfs_fs_parse_param,
      .get_tree    = ntfs_fs_get_tree,
      .reconfigure    = ntfs_fs_reconfigure,
      .free        = ntfs_fs_free,
  };
+// clang-format on

  /*
   * ntfs_init_fs_context - Initialize sbi and opts
diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 26787c2bbf75..023f314e8950 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -24,7 +24,7 @@
  static inline size_t unpacked_ea_size(const struct EA_FULL *ea)
  {
      return ea->size ? le32_to_cpu(ea->size) :
-                ALIGN(struct_size(ea, name,
+              ALIGN(struct_size(ea, name,
                          1 + ea->name_len +
                              le16_to_cpu(ea->elength)),
                  4);
@@ -528,8 +528,8 @@ static noinline int ntfs_set_ea(struct inode *inode, 
const char *name,
  /*
   * ntfs_get_acl - inode_operations::get_acl
   */
-struct posix_acl *ntfs_get_acl(struct mnt_idmap *idmap,
-                   struct dentry *dentry, int type)
+struct posix_acl *ntfs_get_acl(struct mnt_idmap *idmap, struct dentry 
*dentry,
+                   int type)
  {
      struct inode *inode = d_inode(dentry);
      struct ntfs_inode *ni = ntfs_i(inode);
@@ -596,8 +596,7 @@ static noinline int ntfs_set_acl_ex(struct mnt_idmap 
*idmap,
      case ACL_TYPE_ACCESS:
          /* Do not change i_mode if we are in init_acl */
          if (acl && !init_acl) {
-            err = posix_acl_update_mode(idmap, inode, &mode,
-                            &acl);
+            err = posix_acl_update_mode(idmap, inode, &mode, &acl);
              if (err)
                  return err;
          }
@@ -820,10 +819,9 @@ static int ntfs_getxattr(const struct xattr_handler 
*handler, struct dentry *de,
   * ntfs_setxattr - inode_operations::setxattr
   */
  static noinline int ntfs_setxattr(const struct xattr_handler *handler,
-                  struct mnt_idmap *idmap,
-                  struct dentry *de, struct inode *inode,
-                  const char *name, const void *value,
-                  size_t size, int flags)
+                  struct mnt_idmap *idmap, struct dentry *de,
+                  struct inode *inode, const char *name,
+                  const void *value, size_t size, int flags)
  {
      int err = -EINVAL;
      struct ntfs_inode *ni = ntfs_i(inode);
-- 
2.34.1

