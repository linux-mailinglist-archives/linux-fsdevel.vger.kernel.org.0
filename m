Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975FC530331
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 May 2022 15:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345475AbiEVNCJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 May 2022 09:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237612AbiEVNCH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 May 2022 09:02:07 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E812AE24
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 06:02:04 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id a38so8632303pgl.9
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 06:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aE8wnjrTfspLvkBXfl6S55yjJ3NEdNEHRsOYidnygjc=;
        b=ecXF4I9vzDNpVTvJaFSNGMc1TWTBGhehZ8EBdIFmGrE+JINT4gfNMYrwOGEOCs75BB
         8GBKO5KX3iInqxI3KjPEW0AuYaPbEYbQ+rPvWfZz2I6j9UmBwMnro/rShRB64PX0O1wZ
         9lYnBSZnohLLp91w3EIUVEUY1SohCNYyc/V7qFIhRNKNbU1GLrqTBpDNFkO4KkY/Jsa+
         yk5MFtYLkAuD6Aqym+oyPCzETlhfF22kKlTlPAYXXxOIaHgyLv4IOmEZCuvTRU+ejg1G
         713hRL8vVogWexyjbZp0SEIFwVq+9ZXJ/fkCQy1LDSGdKI87PoSaLvwmHlWZA8+o/1JL
         5NWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aE8wnjrTfspLvkBXfl6S55yjJ3NEdNEHRsOYidnygjc=;
        b=oWOcSiRZHn9GfVE2taqu/wHrAM6pJnPnboQYTjyrSSeaygTk8pPEsCijfPOsPXS6Fz
         /xhpaGQQ+QxvEkaxszP1QCKJCZd5vmMkNkUQc3JVpJ1RzryXtzQ9Nl0JE+5VlrLipbrm
         g3oGJcsyDj3ZkjVeekj28PsQ1DwhqDuwIcDXAcGvIue/iKpVuYQH8BcK2gD669nmInPR
         FgxDHnhl7QZzGx1PnDO12N3WCXEXknca20hR90H3fyZNm82T1aDYO8ccEHcyX+EMeTay
         UvJFr6pHgWkRrNSxRYgbWyeVOTupTeSq4zBx90Q08ieJtfvYAk5ldypp7cxWEIUy43Az
         /oiA==
X-Gm-Message-State: AOAM532JyVfRtSNjIfSaXwcMU3rUbkEhOQMCP1AA/ixBkVhPMFprc753
        D8ZKS+OAUchu8jtYl74THOpyb3zpedOzHw==
X-Google-Smtp-Source: ABdhPJzOC3z+oUkFkLdNVJKgxlD7YvrGaGGTgUd5lhu5vxMTrKyuRltPXGEKvQ02XgqO5dtyCnnW5A==
X-Received: by 2002:a05:6a00:1a55:b0:518:a189:8f7e with SMTP id h21-20020a056a001a5500b00518a1898f7emr453750pfv.48.1653224523830;
        Sun, 22 May 2022 06:02:03 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j13-20020a170902da8d00b0015e8d4eb260sm3078484plx.170.2022.05.22.06.02.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 May 2022 06:02:03 -0700 (PDT)
Message-ID: <96aa35fc-3ff7-a3a1-05b5-9fae5c9c1067@kernel.dk>
Date:   Sun, 22 May 2022 07:02:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC] what to do with IOCB_DSYNC?
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
References: <20210621143501.GA3789@lst.de>
 <Yokl+uHTVWFxoQGn@zeniv-ca.linux.org.uk>
 <70b5e4a8-1daa-dc75-af58-9d82a732a6be@kernel.dk>
 <f2547f65-1a37-793d-07ba-f54d018e16d4@kernel.dk>
 <20220522074508.GB15562@lst.de> <YooPLyv578I029ij@casper.infradead.org>
 <YooSEKClbDemxZVy@zeniv-ca.linux.org.uk>
 <Yoobb6GZPbNe7s0/@casper.infradead.org> <20220522114540.GA20469@lst.de>
 <e563d92f-7236-fbde-14ee-1010740a0983@kernel.dk>
 <YooxLS8Lrt6ErwIM@zeniv-ca.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YooxLS8Lrt6ErwIM@zeniv-ca.linux.org.uk>
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

On 5/22/22 6:48 AM, Al Viro wrote:
> On Sun, May 22, 2022 at 06:39:39AM -0600, Jens Axboe wrote:
>> On 5/22/22 5:45 AM, Christoph Hellwig wrote:
>>> On Sun, May 22, 2022 at 12:15:59PM +0100, Matthew Wilcox wrote:
>>>>> 	Direct kernel pointer, surely?  And from a quick look,
>>>>> iov_iter_is_kaddr() checks for the wrong value...
>>>>
>>>> Indeed.  I didn't test it; it was a quick patch to see if the idea was
>>>> worth pursuing.  Neither you nor Christoph thought so at the time, so
>>>> I dropped it.  if there are performance improvements to be had from
>>>> doing something like that, it's a more compelling idea than just "Hey,
>>>> this removes a few lines of code and a bit of stack space from every
>>>> caller".
>>>
>>> Oh, right I actually misremembered what the series did.  But something
>>> similar except for user pointers might help with the performance issues
>>> that Jens sees, and if it does it might be worth it to avoid having
>>> both the legacy read/write path and the iter path in various drivers.
>>
>> Right, ITER_UADDR or something would useful. I'll try and test that,
>> should be easy to wire up.
> 
> Careful - it's not just iov_iter_advance() and __iterate_and_advance() (that
> one should use the same "callback" argument as iovec case).  /dev/random is
> not the only thing we use read(2) and write(2) on...
> 
> I can cook a patch doing that, just let me get some caffeine into the
> bloodstream first...

Sure, if you want to cook it up. Here's what I did so far, no caffeine
and not even compiled yet :-). It also doesn't do the page copy,
separate advancing, etc. Was going to check all the parts in iov_iter.c
that checks the type and has separate handlers.

The read vs write const and not is not great...


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
index 739285fe5a2f..58e20e83745e 100644
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
@@ -42,6 +43,7 @@ struct iov_iter {
 	size_t count;
 	union {
 		const struct iovec *iov;
+		void __user *uaddr;
 		const struct kvec *kvec;
 		const struct bio_vec *bvec;
 		struct xarray *xarray;
@@ -75,6 +77,11 @@ static inline bool iter_is_iovec(const struct iov_iter *i)
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
@@ -241,6 +248,18 @@ void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state);
 
 const void *dup_iter(struct iov_iter *new, struct iov_iter *old, gfp_t flags);
 
+static inline void uaddr_iter_init(struct iov_iter *iter, int rw,
+				   void __user *uaddr, size_t len)
+{
+	iter->iter_type = ITER_UADDR;
+	iter->nofault = false;
+	iter->data_source = rw;
+	iter->iov_offset = 0;
+	iter->count = len;
+	iter->uaddr = uaddr;
+	iter->nr_segs = 0;
+}
+
 static inline size_t iov_iter_count(const struct iov_iter *i)
 {
 	return i->count;
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 6dd5330f7a99..4239fffd14cb 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -38,6 +38,22 @@
 	n = off;						\
 }
 
+#define iterate_uaddr(i, n, base, len, off, STEP) {		\
+	void __user *base;					\
+	size_t len;						\
+	size_t off = 0;						\
+	size_t skip = i->iov_offset;				\
+	len = min(n, i->count - skip);				\
+	if (likely(len)) {					\
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
@@ -118,6 +134,8 @@ __out:								\
 						iov, (I))	\
 			i->nr_segs -= iov - i->iov;		\
 			i->iov = iov;				\
+		} else if (iter_is_uaddr(i)) {			\
+			iterate_uaddr(i, n, base, len, off, (I)) \
 		} else if (iov_iter_is_bvec(i)) {		\
 			const struct bio_vec *bvec = i->bvec;	\
 			void *base;				\
@@ -662,7 +680,7 @@ size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 {
 	if (unlikely(iov_iter_is_pipe(i)))
 		return copy_pipe_to_iter(addr, bytes, i);
-	if (iter_is_iovec(i))
+	if (iter_is_iovec(i) || iter_is_uaddr(i))
 		might_fault();
 	iterate_and_advance(i, bytes, base, len, off,
 		copyout(base, addr + off, len),
@@ -744,7 +762,7 @@ size_t _copy_mc_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 {
 	if (unlikely(iov_iter_is_pipe(i)))
 		return copy_mc_pipe_to_iter(addr, bytes, i);
-	if (iter_is_iovec(i))
+	if (iter_is_iovec(i) || iter_is_uaddr(i))
 		might_fault();
 	__iterate_and_advance(i, bytes, base, len, off,
 		copyout_mc(base, addr + off, len),
@@ -1061,6 +1079,10 @@ static void iov_iter_iovec_advance(struct iov_iter *i, size_t size)
 	i->iov = iov;
 }
 
+static void iter_uaddr_advance(struct iov_iter *i, size_t size)
+{
+}
+
 void iov_iter_advance(struct iov_iter *i, size_t size)
 {
 	if (unlikely(i->count < size))
@@ -1068,6 +1090,8 @@ void iov_iter_advance(struct iov_iter *i, size_t size)
 	if (likely(iter_is_iovec(i) || iov_iter_is_kvec(i))) {
 		/* iovec and kvec have identical layouts */
 		iov_iter_iovec_advance(i, size);
+	} else if (iter_is_uaddr(i)) {
+		iter_uaddr_advance(i, size);
 	} else if (iov_iter_is_bvec(i)) {
 		iov_iter_bvec_advance(i, size);
 	} else if (iov_iter_is_pipe(i)) {

-- 
Jens Axboe

