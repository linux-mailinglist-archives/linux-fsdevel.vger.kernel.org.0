Return-Path: <linux-fsdevel+bounces-79243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GepMpD1pmmgawAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 15:52:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5FE1F1CBE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 15:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F9AC3181BB8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 14:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C9847CC8D;
	Tue,  3 Mar 2026 14:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b="9rIchIxM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx1.manguebit.org (mx1.manguebit.org [143.255.12.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F0747D92E;
	Tue,  3 Mar 2026 14:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.255.12.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772549132; cv=none; b=go1bOf36aqDo6E5QYDWqmbsXcjgYLn9FYWCygocGWpRmoMJVPKvj/pUoK3Wc/19HAHFdCrh0nb6d291qCeUK3sC66VRNGg2tc90V+brnKBBpW1vJNQTil7hOR2JNe2Rg/RBtJDXTxyjoK64PcUl2sWzLUBhCo/5eQg9BP+RgmwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772549132; c=relaxed/simple;
	bh=uWqCFemI7r+X/cbgz+jKv99U9fftwMpeskyPhKG/Evw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P+nhQqy/xxNVYhxpWOMYg7zfqXb8vcSwgdVbepVgvzcaNNcMp9LGIdpA6K3PUD5V7pbFHlu2rmHA3b0QQxnoJ8g/qYbpVzppoZvFM5W9C/q5XxNPgfj4hkg8huVDd1/d4/Mo/eW0NiRTnFNkl7wnymYNwQkf0SZZpaCxSy90xO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org; spf=pass smtp.mailfrom=manguebit.org; dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b=9rIchIxM; arc=none smtp.client-ip=143.255.12.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=manguebit.org; s=dkim; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Content-Type:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=wUO+aCyJo2eWc7hnrMWMxGT1gldL/gBTEFER51cjCdM=; b=9rIchIxMQB6+pDjDkyFYbY1Ue6
	0BPBaaA7J159F5+lhTbqbhma8k21dLnXUWA/L/aTdmiEDsjKl9PMZZkeotz7rFjrD05jkiVE1ncPd
	3v1JIyQpP+G30uVpZf4HLcDA+O8cxNJIpra1qqd/YEnBgPmawbwSGy/rmQ6e7lbw+ASxutJednWah
	ozB/PjyEw9OTCvVsmGFOCo2uHsZLZCaJQjWKDZ1on2SrcFRhnp7d2vaYYQxRvDGKSq6Cou/3lZdZC
	bdeuLkZWIl0pEfpzTHxe+5Egp26GCCdtnuyf/2QzIa14A8wZnb/tGF9nZ688oPekhnCt4ayyPOsvN
	2dS4qAUQ==;
Received: from pc by mx1.manguebit.org with local (Exim 4.99.1)
	id 1vxQzy-00000000A4Y-3cr7;
	Tue, 03 Mar 2026 11:45:22 -0300
From: Paulo Alcantara <pc@manguebit.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Xiaoli Feng <xifeng@redhat.com>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.org>,
	David Howells <dhowells@redhat.com>,
	netfs@lists.linux.dev,
	stable@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] netfs: fix error handling in netfs_extract_user_iter()
Date: Tue,  3 Mar 2026 11:45:22 -0300
Message-ID: <20260303144522.1292521-1-pc@manguebit.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6E5FE1F1CBE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[manguebit.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[manguebit.org:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79243-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[manguebit.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pc@manguebit.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[manguebit.org:dkim,manguebit.org:email,manguebit.org:mid,linux.dev:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

In netfs_extract_user_iter(), if iov_iter_extract_pages() failed to
extract user pages, bail out on -ENOMEM, otherwise return the error
code only if @npages == 0, allowing short DIO reads and writes to be
issued.

This fixes mmapstress02 from LTP tests against CIFS.

Reported-by: Xiaoli Feng <xifeng@redhat.com>
Fixes: 85dd2c8ff368 ("netfs: Add a function to extract a UBUF or IOVEC into a BVEC iterator")
Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
Reviewed-by: David Howells <dhowells@redhat.com>
Cc: netfs@lists.linux.dev
Cc: stable@vger.kernel.org
Cc: linux-cifs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/iterator.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/netfs/iterator.c b/fs/netfs/iterator.c
index 72a435e5fc6d..dc1039b41cf4 100644
--- a/fs/netfs/iterator.c
+++ b/fs/netfs/iterator.c
@@ -22,7 +22,7 @@
  *
  * Extract the page fragments from the given amount of the source iterator and
  * build up a second iterator that refers to all of those bits.  This allows
- * the original iterator to disposed of.
+ * the original iterator to be disposed of.
  *
  * @extraction_flags can have ITER_ALLOW_P2PDMA set to request peer-to-peer DMA be
  * allowed on the pages extracted.
@@ -67,8 +67,8 @@ ssize_t netfs_extract_user_iter(struct iov_iter *orig, size_t orig_len,
 		ret = iov_iter_extract_pages(orig, &pages, count,
 					     max_pages - npages, extraction_flags,
 					     &offset);
-		if (ret < 0) {
-			pr_err("Couldn't get user pages (rc=%zd)\n", ret);
+		if (unlikely(ret <= 0)) {
+			ret = ret ?: -EIO;
 			break;
 		}
 
@@ -97,6 +97,13 @@ ssize_t netfs_extract_user_iter(struct iov_iter *orig, size_t orig_len,
 		npages += cur_npages;
 	}
 
+	if (ret < 0 && (ret == -ENOMEM || npages == 0)) {
+		for (i = 0; i < npages; i++)
+			unpin_user_page(bv[i].bv_page);
+		kvfree(bv);
+		return ret;
+	}
+
 	iov_iter_bvec(new, orig->data_source, bv, npages, orig_len - count);
 	return npages;
 }
-- 
2.53.0


