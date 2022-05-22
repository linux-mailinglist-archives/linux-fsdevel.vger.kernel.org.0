Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7EC5530515
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 May 2022 20:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244925AbiEVSGb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 May 2022 14:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbiEVSGa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 May 2022 14:06:30 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408F624F1C
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 11:06:27 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id s14so11254488plk.8
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 11:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=ei1y5fEGbxrbVunTf/PvO8fhwucPehdQ2A21At1ltXk=;
        b=oa8wMHquJbd5iPImdVpXxIn+x7T6DsbNnTpSRcPA6HhKqwTZe6V/k8ZUta4VnpByF7
         CjAj2TT7x7qEHU/L2yTF71jc1RR2Lz5X1wgp9xwBV5durBGEw8MZeQ5AcMhBQSx54YB5
         3oVZWiLV+bPHt3b0esbtmoE+8ZgC5jTkz8N9a746qhoo5UeN9MA+zaTWt0MmetiwLnKR
         VlQSZzlnK50WixEcNgc0LYz+Qqo9jv6FGER57mU0HTzuXkvJWt0gJ+0zRBWp2ju0XClH
         0pDu9Me1RlvE9U+/fbag7jLYh1hK3Zvv4Gnch9AjBRcbKF6JAzQvSZ7NsiHYwk4eNfAl
         nyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=ei1y5fEGbxrbVunTf/PvO8fhwucPehdQ2A21At1ltXk=;
        b=qeUMw5X3szwBxaydQaCZxCQjjIxIYdck0HzX7fFUrM9Vu3g7445SKEdvDCAfehjYCk
         y+x2Edlk/EUNqGaPmg+ZQeTpQHeDaY2TH1Na4xVCWGKHnStSuIZ+0KPETUE5pnuYm8gM
         ccZA7+XRvi3iKoIWse75rIRLl3dploTdp/sRUOgnTFcHFcsQmVd1IEkGfXLT02FQ4o6o
         QN3hqGrQZdVSU71Sew/bDlB9pQCFKcLU1EGEJZZI0gfHxA1ebHt94rBPJUYX4/D4+3Kj
         DavQQD0P/f2SZTcR6JT1KJ/Y+GV10hOmqGG/HdzgsVqQq35MuItVV//FSznZDiYStIr+
         Lemw==
X-Gm-Message-State: AOAM530VqxgvCun//1BmhlZnwCTi6q52bgO8RT9fXh3d/Rgmea8T80K2
        HAFfl2HHnsNdIKFjo1vhWdofjA==
X-Google-Smtp-Source: ABdhPJzAYYXKwePmTzj1mF5pNLvPqTy95jcI+NtxL9opz6IrS24PNaDlPec2qOWlhIa2HRLkubPO1A==
X-Received: by 2002:a17:903:1108:b0:156:73a7:7c1 with SMTP id n8-20020a170903110800b0015673a707c1mr19145319plh.101.1653242786608;
        Sun, 22 May 2022 11:06:26 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id z124-20020a623382000000b005183cf12184sm5359573pfz.133.2022.05.22.11.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 May 2022 11:06:25 -0700 (PDT)
Message-ID: <7abc2e36-f2f3-e89c-f549-9edd6633b4a1@kernel.dk>
Date:   Sun, 22 May 2022 12:06:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC] what to do with IOCB_DSYNC?
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
References: <70b5e4a8-1daa-dc75-af58-9d82a732a6be@kernel.dk>
 <f2547f65-1a37-793d-07ba-f54d018e16d4@kernel.dk>
 <20220522074508.GB15562@lst.de> <YooPLyv578I029ij@casper.infradead.org>
 <YooSEKClbDemxZVy@zeniv-ca.linux.org.uk>
 <Yoobb6GZPbNe7s0/@casper.infradead.org> <20220522114540.GA20469@lst.de>
 <e563d92f-7236-fbde-14ee-1010740a0983@kernel.dk>
 <YooxLS8Lrt6ErwIM@zeniv-ca.linux.org.uk>
 <96aa35fc-3ff7-a3a1-05b5-9fae5c9c1067@kernel.dk>
 <Yoo1q1+ZRrjBP2y3@zeniv-ca.linux.org.uk>
 <e2bb980b-42e8-27dc-cb6b-51dfb90d7e0a@kernel.dk>
In-Reply-To: <e2bb980b-42e8-27dc-cb6b-51dfb90d7e0a@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/22/22 7:09 AM, Jens Axboe wrote:
> On 5/22/22 7:07 AM, Al Viro wrote:
>> On Sun, May 22, 2022 at 07:02:01AM -0600, Jens Axboe wrote:
>>> +static void iter_uaddr_advance(struct iov_iter *i, size_t size)
>>> +{
>>> +}
>>
>> How could that possibly work?  At the very least you want to do
>> what xarray does - you *must* decrement ->count and shift ->iov_offset.
>> Matter of fact, I'd simply go with a bit of reorder and had it go
>> for if (iter_is_uaddr(i) || iter_is_xarray(i)) in there...
> 
> It's just a stub, you said you'd want to do it, so I just dropped what I
> had in the email. As I said, it's not even compiled yet, let alone
> complete or tested.

Had a bit more time, this one actually boots and uses ITER_UADDR for
new_sync_read() and new_sync_write().

A few notes:

- Why aren't we using iter->nofault for the might_fault() check? Didn't
  matter too much before, but it's nice to consolidate with multiple
  iov_iter types that can fault.

- Since checks use iter_is_iovec() to mean "this is user data", we
  should probably add another bool for that since there's a hole.

- There are some non-core spots that check iter type, eg shmem and
  others. Somewhat annoying we don't have core helpers for all things.

No real testing done on this, outside of just checking that it actually
boots in my vm. No guarantees it doesn't have weird corner cases and
breakages...

diff --git a/fs/read_write.c b/fs/read_write.c
index e643aec2b0ef..862ec6c549c6 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -389,14 +389,13 @@ EXPORT_SYMBOL(rw_verify_area);
 
 static ssize_t new_sync_read(struct file *filp, char __user *buf, size_t len, loff_t *ppos)
 {
-	struct iovec iov = { .iov_base = buf, .iov_len = len };
 	struct kiocb kiocb;
 	struct iov_iter iter;
 	ssize_t ret;
 
 	init_sync_kiocb(&kiocb, filp);
 	kiocb.ki_pos = (ppos ? *ppos : 0);
-	iov_iter_init(&iter, READ, &iov, 1, len);
+	uaddr_iter_init(&iter, READ, buf, len);
 
 	ret = call_read_iter(filp, &kiocb, &iter);
 	BUG_ON(ret == -EIOCBQUEUED);
@@ -492,14 +491,13 @@ ssize_t vfs_read(struct file *file, char __user *buf, size_t count, loff_t *pos)
 
 static ssize_t new_sync_write(struct file *filp, const char __user *buf, size_t len, loff_t *ppos)
 {
-	struct iovec iov = { .iov_base = (void __user *)buf, .iov_len = len };
 	struct kiocb kiocb;
 	struct iov_iter iter;
 	ssize_t ret;
 
 	init_sync_kiocb(&kiocb, filp);
 	kiocb.ki_pos = (ppos ? *ppos : 0);
-	iov_iter_init(&iter, WRITE, &iov, 1, len);
+	uaddr_iter_init(&iter, WRITE, (void __user *) buf, len);
 
 	ret = call_write_iter(filp, &kiocb, &iter);
 	BUG_ON(ret == -EIOCBQUEUED);
diff --git a/include/linux/uio.h b/include/linux/uio.h
index 739285fe5a2f..8749139ac64c 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -21,6 +21,7 @@ struct kvec {
 enum iter_type {
 	/* iter types */
 	ITER_IOVEC,
+	ITER_UADDR,
 	ITER_KVEC,
 	ITER_BVEC,
 	ITER_PIPE,
@@ -42,12 +43,14 @@ struct iov_iter {
 	size_t count;
 	union {
 		const struct iovec *iov;
+		void __user *uaddr;
 		const struct kvec *kvec;
 		const struct bio_vec *bvec;
 		struct xarray *xarray;
 		struct pipe_inode_info *pipe;
 	};
 	union {
+		size_t uaddr_len;
 		unsigned long nr_segs;
 		struct {
 			unsigned int head;
@@ -75,6 +78,11 @@ static inline bool iter_is_iovec(const struct iov_iter *i)
 	return iov_iter_type(i) == ITER_IOVEC;
 }
 
+static inline bool iter_is_uaddr(const struct iov_iter *i)
+{
+	return iov_iter_type(i) == ITER_UADDR;
+}
+
 static inline bool iov_iter_is_kvec(const struct iov_iter *i)
 {
 	return iov_iter_type(i) == ITER_KVEC;
@@ -221,6 +229,8 @@ size_t _copy_mc_to_iter(const void *addr, size_t bytes, struct iov_iter *i);
 size_t iov_iter_zero(size_t bytes, struct iov_iter *);
 unsigned long iov_iter_alignment(const struct iov_iter *i);
 unsigned long iov_iter_gap_alignment(const struct iov_iter *i);
+void uaddr_iter_init(struct iov_iter *iter, int rw, void __user *uaddr,
+			size_t len);
 void iov_iter_init(struct iov_iter *i, unsigned int direction, const struct iovec *iov,
 			unsigned long nr_segs, size_t count);
 void iov_iter_kvec(struct iov_iter *i, unsigned int direction, const struct kvec *kvec,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 6dd5330f7a99..6a4ab43324bc 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -38,6 +38,20 @@
 	n = off;						\
 }
 
+#define iterate_uaddr(i, n, base, len, off, STEP) {		\
+	size_t off = 0;						\
+	size_t skip = i->iov_offset;				\
+	len = min(n, i->uaddr_len - skip);			\
+	if (len) {						\
+		base = i->uaddr + skip;				\
+		len -= (STEP);					\
+		off += len;					\
+		skip += len;					\
+	}							\
+	i->iov_offset = skip;					\
+	n = off;						\
+}
+
 #define iterate_bvec(i, n, base, len, off, p, STEP) {		\
 	size_t off = 0;						\
 	unsigned skip = i->iov_offset;				\
@@ -118,6 +132,11 @@ __out:								\
 						iov, (I))	\
 			i->nr_segs -= iov - i->iov;		\
 			i->iov = iov;				\
+		} else if (iter_is_uaddr(i)) {			\
+			void __user *base;			\
+			size_t len;				\
+			iterate_uaddr(i, n, base, len, off,	\
+						(I))		\
 		} else if (iov_iter_is_bvec(i)) {		\
 			const struct bio_vec *bvec = i->bvec;	\
 			void *base;				\
@@ -461,6 +480,13 @@ size_t fault_in_iov_iter_readable(const struct iov_iter *i, size_t size)
 				break;
 		}
 		return count + size;
+	} else if (iter_is_uaddr(i)) {
+		size_t count = min(size, iov_iter_count(i));
+		size_t ret;
+
+		size -= count;
+		ret = fault_in_readable(i->uaddr + i->iov_offset, count);
+		return size - ret;
 	}
 	return 0;
 }
@@ -500,6 +526,13 @@ size_t fault_in_iov_iter_writeable(const struct iov_iter *i, size_t size)
 				break;
 		}
 		return count + size;
+	} else if (iter_is_uaddr(i)) {
+		size_t count = min(size, iov_iter_count(i));
+		size_t ret;
+
+		size -= count;
+		ret = fault_in_safe_writeable(i->uaddr + i->iov_offset, count);
+		return size - ret;
 	}
 	return 0;
 }
@@ -662,7 +695,7 @@ size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 {
 	if (unlikely(iov_iter_is_pipe(i)))
 		return copy_pipe_to_iter(addr, bytes, i);
-	if (iter_is_iovec(i))
+	if (!i->nofault)
 		might_fault();
 	iterate_and_advance(i, bytes, base, len, off,
 		copyout(base, addr + off, len),
@@ -744,7 +777,7 @@ size_t _copy_mc_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 {
 	if (unlikely(iov_iter_is_pipe(i)))
 		return copy_mc_pipe_to_iter(addr, bytes, i);
-	if (iter_is_iovec(i))
+	if (!i->nofault)
 		might_fault();
 	__iterate_and_advance(i, bytes, base, len, off,
 		copyout_mc(base, addr + off, len),
@@ -762,7 +795,7 @@ size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
 		WARN_ON(1);
 		return 0;
 	}
-	if (iter_is_iovec(i))
+	if (!i->nofault)
 		might_fault();
 	iterate_and_advance(i, bytes, base, len, off,
 		copyin(addr + off, base, len),
@@ -850,7 +883,8 @@ static size_t __copy_page_to_iter(struct page *page, size_t offset, size_t bytes
 {
 	if (likely(iter_is_iovec(i)))
 		return copy_page_to_iter_iovec(page, offset, bytes, i);
-	if (iov_iter_is_bvec(i) || iov_iter_is_kvec(i) || iov_iter_is_xarray(i)) {
+	if (iov_iter_is_bvec(i) || iov_iter_is_kvec(i) ||
+	    iter_is_uaddr(i) || iov_iter_is_xarray(i)) {
 		void *kaddr = kmap_local_page(page);
 		size_t wanted = _copy_to_iter(kaddr + offset, bytes, i);
 		kunmap_local(kaddr);
@@ -900,7 +934,8 @@ size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
 		return 0;
 	if (likely(iter_is_iovec(i)))
 		return copy_page_from_iter_iovec(page, offset, bytes, i);
-	if (iov_iter_is_bvec(i) || iov_iter_is_kvec(i) || iov_iter_is_xarray(i)) {
+	if (iov_iter_is_bvec(i) || iov_iter_is_kvec(i) ||
+	    iter_is_uaddr(i) || iov_iter_is_xarray(i)) {
 		void *kaddr = kmap_local_page(page);
 		size_t wanted = _copy_from_iter(kaddr + offset, bytes, i);
 		kunmap_local(kaddr);
@@ -1072,7 +1107,7 @@ void iov_iter_advance(struct iov_iter *i, size_t size)
 		iov_iter_bvec_advance(i, size);
 	} else if (iov_iter_is_pipe(i)) {
 		pipe_advance(i, size);
-	} else if (unlikely(iov_iter_is_xarray(i))) {
+	} else if (iov_iter_is_xarray(i) || iter_is_uaddr(i)) {
 		i->iov_offset += size;
 		i->count -= size;
 	} else if (iov_iter_is_discard(i)) {
@@ -1268,6 +1303,20 @@ void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t count)
 }
 EXPORT_SYMBOL(iov_iter_discard);
 
+void uaddr_iter_init(struct iov_iter *i, int rw, void __user *uaddr, size_t len)
+{
+	WARN_ON(rw & ~(READ | WRITE));
+	*i = (struct iov_iter){
+		.iter_type = ITER_UADDR,
+		.nofault = false,
+		.data_source = rw,
+		.iov_offset = 0,
+		.count = len,
+		.uaddr = uaddr,
+		.uaddr_len = len,
+	};
+}
+
 static unsigned long iov_iter_alignment_iovec(const struct iov_iter *i)
 {
 	unsigned long res = 0;
@@ -1319,6 +1368,14 @@ unsigned long iov_iter_alignment(const struct iov_iter *i)
 	if (iov_iter_is_bvec(i))
 		return iov_iter_alignment_bvec(i);
 
+	if (iter_is_uaddr(i)) {
+		size_t len = i->count - i->iov_offset;
+
+		if (len)
+			return (unsigned long) i->uaddr + i->iov_offset;
+		return 0;
+	}
+
 	if (iov_iter_is_pipe(i)) {
 		unsigned int p_mask = i->pipe->ring_size - 1;
 		size_t size = i->count;
@@ -1527,6 +1584,9 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
 	if (!maxsize)
 		return 0;
 
+	if (WARN_ON_ONCE(iter_is_uaddr(i)))
+		return 0;
+
 	if (likely(iter_is_iovec(i))) {
 		unsigned int gup_flags = 0;
 		unsigned long addr;
@@ -1652,6 +1712,8 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 		maxsize = i->count;
 	if (!maxsize)
 		return 0;
+	if (WARN_ON_ONCE(iter_is_uaddr(i)))
+		return 0;
 
 	if (likely(iter_is_iovec(i))) {
 		unsigned int gup_flags = 0;
@@ -1825,6 +1887,15 @@ int iov_iter_npages(const struct iov_iter *i, int maxpages)
 		npages = pipe_space_for_user(iter_head, i->pipe->tail, i->pipe);
 		return min(npages, maxpages);
 	}
+	if (iter_is_uaddr(i)) {
+		unsigned long uaddr = (unsigned long) i->uaddr;
+		unsigned long start, end;
+
+		end = (uaddr + i->count - i->iov_offset + PAGE_SIZE - 1)
+				>> PAGE_SHIFT;
+		start = uaddr >> PAGE_SHIFT;
+		return min_t(int, end - start, maxpages);
+	}
 	if (iov_iter_is_xarray(i)) {
 		unsigned offset = (i->xarray_start + i->iov_offset) % PAGE_SIZE;
 		int npages = DIV_ROUND_UP(offset + i->count, PAGE_SIZE);
@@ -2040,15 +2111,18 @@ EXPORT_SYMBOL(import_single_range);
  * Used after iov_iter_save_state() to bring restore @i, if operations may
  * have advanced it.
  *
- * Note: only works on ITER_IOVEC, ITER_BVEC, and ITER_KVEC
+ * Note: only works on ITER_IOVEC, ITER_BVEC, ITER_KVEC, and ITER_UADDR.
  */
 void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state)
 {
 	if (WARN_ON_ONCE(!iov_iter_is_bvec(i) && !iter_is_iovec(i)) &&
-			 !iov_iter_is_kvec(i))
+			 !iov_iter_is_kvec(i) && !iter_is_uaddr(i))
 		return;
 	i->iov_offset = state->iov_offset;
 	i->count = state->count;
+	if (iter_is_uaddr(i))
+		return;
+
 	/*
 	 * For the *vec iters, nr_segs + iov is constant - if we increment
 	 * the vec, then we also decrement the nr_segs count. Hence we don't

-- 
Jens Axboe

