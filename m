Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DC762C787
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 19:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbiKPSUr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 13:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbiKPSUo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 13:20:44 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242DB27CCE;
        Wed, 16 Nov 2022 10:20:43 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D5A8B2268E;
        Wed, 16 Nov 2022 18:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668622841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tSUpoHWr9wnkVn9HOTb7LULYSyBr+07TUIpU4/QTATk=;
        b=Gx2vckK/5vGEc2zOhBCl7qSITrhTbIWydacZenpqfzShhYxA1nf+4wsQ0nbsIkItym081e
        b1cwZHpqlbr+RiHEd+XgERCfUUaNxtIntG2iifstEd1kz0FySPSpsFNnoRElSnqXNQVgJA
        7Sc50zIqGTUS5raTA02gC0xqdyKesdw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668622841;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tSUpoHWr9wnkVn9HOTb7LULYSyBr+07TUIpU4/QTATk=;
        b=4KTm6OTcQBsaB9fM00TF0repUhYtweyMkHnBYRRv5HSm2o3zxm3mNwC3J968JAipryjVNx
        m9mUVu89zejETCDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 91B8F134CE;
        Wed, 16 Nov 2022 18:20:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 38mGI/kpdWMROAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 16 Nov 2022 18:20:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B3FABA0709; Wed, 16 Nov 2022 19:20:40 +0100 (CET)
Date:   Wed, 16 Nov 2022 19:20:40 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Jan Kara <jack@suse.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Dave Kleikamp <shaggy@kernel.org>,
        Bob Copeland <me@bobcopeland.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net,
        linux-karma-devel@lists.sourceforge.net, linux-mm@kvack.org
Subject: Re: [PATCH 2/9] ext2: remove ->writepageo      
Message-ID: <20221116182040.tecis3dqejsdqnum@quack3>
References: <20221113162902.883850-1-hch@lst.de>
 <20221113162902.883850-3-hch@lst.de>
 <20221114104927.k5x4i4uanxskfs6m@quack3>
 <Y3UMV2mB5BkMM5PY@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="p236ichjbcdiibw7"
Content-Disposition: inline
In-Reply-To: <Y3UMV2mB5BkMM5PY@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--p236ichjbcdiibw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed 16-11-22 08:14:15, Christoph Hellwig wrote:
> On Mon, Nov 14, 2022 at 11:49:27AM +0100, Jan Kara wrote:
> > On Sun 13-11-22 17:28:55, Christoph Hellwig wrote:
> > > ->writepage is a very inefficient method to write back data, and only
> > > used through write_cache_pages or a a fallback when no ->migrate_folio
> > > method is present.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> > Looks good! Feel free to add:
> 
> The testbot found a problem with this:
> 
> ext2_commit_chunk calls write_one_page for the IS_DIRSYNC case,
> and write_one_page calls ->writepage.

Right.

> So I think I need to drop this one for now (none of the other
> file systems calls write_one_page).  And then think what best
> to do about write_one_page/write_one_folio.  I suspect just
> passing a writepage pointer to them might make most sense,
> as they are only used by a few file systems, and the calling
> convention with the locked page doesn't lend itself to using
> ->writepages.

Looking at the code, IMO the write_one_page() looks somewhat premature
anyway in that place. AFAICS we could handle the writeout using
filemap_write_and_wait() if we moved it to somewhat later moment. So
something like attached patch (only basic testing only so far)?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--p236ichjbcdiibw7
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-ext2-Don-t-flush-page-immediately-for-DIRSYNC-direct.patch"

From dc36b90da4c23134ac2fd02d7a21a736fe68d598 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Wed, 16 Nov 2022 19:08:23 +0100
Subject: [PATCH] ext2: Don't flush page immediately for DIRSYNC directories

We do not need to writeout modified directory blocks immediately when
modifying them while the page is locked. It is enough to do the flush
somewhat later which has the added benefit that inode times can be
flushed as well. It also allows us to stop depending on
write_one_page() function.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext2/dir.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
index 8f597753ac12..17efc784af53 100644
--- a/fs/ext2/dir.c
+++ b/fs/ext2/dir.c
@@ -81,11 +81,10 @@ ext2_last_byte(struct inode *inode, unsigned long page_nr)
 	return last_byte;
 }
 
-static int ext2_commit_chunk(struct page *page, loff_t pos, unsigned len)
+static void ext2_commit_chunk(struct page *page, loff_t pos, unsigned len)
 {
 	struct address_space *mapping = page->mapping;
 	struct inode *dir = mapping->host;
-	int err = 0;
 
 	inode_inc_iversion(dir);
 	block_write_end(NULL, mapping, pos, len, len, page, NULL);
@@ -94,16 +93,7 @@ static int ext2_commit_chunk(struct page *page, loff_t pos, unsigned len)
 		i_size_write(dir, pos+len);
 		mark_inode_dirty(dir);
 	}
-
-	if (IS_DIRSYNC(dir)) {
-		err = write_one_page(page);
-		if (!err)
-			err = sync_inode_metadata(dir, 1);
-	} else {
-		unlock_page(page);
-	}
-
-	return err;
+	unlock_page(page);
 }
 
 static bool ext2_check_page(struct page *page, int quiet, char *kaddr)
@@ -460,6 +450,17 @@ static int ext2_prepare_chunk(struct page *page, loff_t pos, unsigned len)
 	return __block_write_begin(page, pos, len, ext2_get_block);
 }
 
+
+static int ext2_handle_dirsync(struct inode *dir)
+{
+	int err;
+
+	err = filemap_write_and_wait(dir->i_mapping);
+	if (!err)
+		err = sync_inode_metadata(dir, 1);
+	return err;
+}
+
 void ext2_set_link(struct inode *dir, struct ext2_dir_entry_2 *de,
 		   struct page *page, void *page_addr, struct inode *inode,
 		   int update_times)
@@ -474,11 +475,12 @@ void ext2_set_link(struct inode *dir, struct ext2_dir_entry_2 *de,
 	BUG_ON(err);
 	de->inode = cpu_to_le32(inode->i_ino);
 	ext2_set_de_type(de, inode);
-	err = ext2_commit_chunk(page, pos, len);
+	ext2_commit_chunk(page, pos, len);
 	if (update_times)
 		dir->i_mtime = dir->i_ctime = current_time(dir);
 	EXT2_I(dir)->i_flags &= ~EXT2_BTREE_FL;
 	mark_inode_dirty(dir);
+	ext2_handle_dirsync(dir);
 }
 
 /*
@@ -566,10 +568,11 @@ int ext2_add_link (struct dentry *dentry, struct inode *inode)
 	memcpy(de->name, name, namelen);
 	de->inode = cpu_to_le32(inode->i_ino);
 	ext2_set_de_type (de, inode);
-	err = ext2_commit_chunk(page, pos, rec_len);
+	ext2_commit_chunk(page, pos, rec_len);
 	dir->i_mtime = dir->i_ctime = current_time(dir);
 	EXT2_I(dir)->i_flags &= ~EXT2_BTREE_FL;
 	mark_inode_dirty(dir);
+	err = ext2_handle_dirsync(dir);
 	/* OFFSET_CACHE */
 out_put:
 	ext2_put_page(page, page_addr);
@@ -615,10 +618,11 @@ int ext2_delete_entry (struct ext2_dir_entry_2 *dir, struct page *page,
 	if (pde)
 		pde->rec_len = ext2_rec_len_to_disk(to - from);
 	dir->inode = 0;
-	err = ext2_commit_chunk(page, pos, to - from);
+	ext2_commit_chunk(page, pos, to - from);
 	inode->i_ctime = inode->i_mtime = current_time(inode);
 	EXT2_I(inode)->i_flags &= ~EXT2_BTREE_FL;
 	mark_inode_dirty(inode);
+	err = ext2_handle_dirsync(dir);
 out:
 	return err;
 }
@@ -658,7 +662,8 @@ int ext2_make_empty(struct inode *inode, struct inode *parent)
 	memcpy (de->name, "..\0", 4);
 	ext2_set_de_type (de, inode);
 	kunmap_atomic(kaddr);
-	err = ext2_commit_chunk(page, 0, chunk_size);
+	ext2_commit_chunk(page, 0, chunk_size);
+	err = ext2_handle_dirsync(inode);
 fail:
 	put_page(page);
 	return err;
-- 
2.35.3


--p236ichjbcdiibw7--
