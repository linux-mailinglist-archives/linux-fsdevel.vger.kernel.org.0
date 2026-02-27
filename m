Return-Path: <linux-fsdevel+bounces-78750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFI+DMjJoWmqwQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 17:43:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C031BAF28
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 17:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A8AD3162E7D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A18B34DCD2;
	Fri, 27 Feb 2026 16:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="FM/S0CDV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC4F34EEEE
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 16:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772210492; cv=none; b=nLEztBqaaNyN9pCVf6b4nkinniWW7jz4kPWbpmeF0dGyGVmWOgeFWdifRQtszv3QbB11j3TTJXDrRThLYiXtm/zrsujGAITzYT91PEOiHnQXGJZKVMAILTrS2f5A5vLWXBVgMBk9uRhrZwqzE7Dbu3qZ1iMtLf2mW/KdokgErBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772210492; c=relaxed/simple;
	bh=8jgmldQQbiZzzlvIZlNR4V+9tVlk4w4gZb+9NNCt4y8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LmhsWU/BzqzrDjWrmLDKDnQBpHXzwXJCCBTlUNKmI92fmlsrHWw4JMg6HoDSdzxNR13v1r04h8Co+gGUOtyGf9IkRIlCsm0f+/AtG4YUuErB2T2UC4v0nJB9CNFlDzNCiEhMLuEHcQyRgjve5/TUN0Kh9MvItofpCYu82fMbH4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=FM/S0CDV; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RGNCkD4107754
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 11:41:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=jlmO
	HeLoSvLjpCm3jD8iWkNqxE6EJRsgaFZ0qUuQgW8=; b=FM/S0CDVVFMCT2m5AUDa
	OOFumevWors0oqq7hz6NDLRqsjZtbb+w5BQ34v8yQEwnu2n3lFDEfSqldvNdyEVy
	0ssJO1dDpY8qCk/RgAEmRv9cXwhX56TmsPpwK4nbJYDN4nSff3IfDhbhsLYAclna
	Wa9ga6InnhSRmJ6NqTfz3rMX4dn8n10S/ZiNAU2oPM03q6z+vwwi3+12ndvaO2UI
	lNMKkL7HOaAdQ4Dy6/B9jZlMgvijA8cLlRF0LBz7KRFliypGcf/fvzkS4yCu58IS
	MFNX6vcHiPcShCQ1tg+ZVgP13MMzx1HoK5G9VTgkW41t9/55kWsNz8lehhk04iJY
	BA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4cjppft4c5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 11:41:29 -0500 (EST)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cb3ad1b81aso2604859985a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 08:41:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772210489; x=1772815289;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jlmOHeLoSvLjpCm3jD8iWkNqxE6EJRsgaFZ0qUuQgW8=;
        b=wydvUZNkosUWGwiqPJo3LjsH5ZEkFZkshhk/crobJWajBYeo6XyPT73n4iQBO/GsFB
         x2EjORiGGozQPZ5P1RJfn+bEN8oL9FyaIOX5Q8xUTwbj9x4JAUMu/1HJGkABxKgw0a5O
         ieS93/S21o5yhOWES3Ul9BTX3gVVHLIIb9V/JXUhxh9aRtGhDyTIXnyT4cYdzUAftvwS
         yNXBczHtx83Z6679kna6SrO/+9lC5f3hKJpo8WiQ4h3O1iKOl3NLJ67H1QGfQYFredpe
         SoH1Pafl3LTNz4iEZjIzno4TqDTZ4gBtRRBAvd5vMa+oGrVdWezhwdli3ih0xgsYae4D
         FqVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo60n5/m5fhFX8Dg13r4aEGEuR/u28H8lUv7dHo4JWbKKy3Xvwzl/EixIQM/HJSXrGT5ozeQutvCi+4TU8@vger.kernel.org
X-Gm-Message-State: AOJu0YxFINarfeVcwj0oLBX89+r1udEH5uLcVyQc/fnMTkKSsRSdE8iq
	2DTe6jlGxAuNxkAyjUQxY9F5nbb/qPAojeTasDvnBRFY4JEx/tlofeDmApZlqLKiaqFFXag8ATN
	D53+suN4u/accqv9D51bI8F82r1TUEse/kaFLq57/JVTI/DiAwWSmuWh19qAl4Sg=
X-Gm-Gg: ATEYQzxQ1wyK87cGo6bFyUtxvz1STc4iFGHnQBLcOnom9L6UG14WncLL/oQ8F4hR1Wo
	XhxRIvuEKdVY1HITpUBHNCms2JhCDI+pL6Klo5V09gUJzdT02ZbyIGPvAB9n4A3ADbJxwOZUBBV
	aDfWqUNQnIl7xaft4HJscUrdKQjw/h5VH7GutGRJ4RtM+raXJHtyzzs9QPvrfRWHh2FUVDCEyua
	DboUE5yw/7DwjaqV5tKQKi1RJXJ4N4uWtYC0ultWUG38bMuMB7biEjgwuYsWB3Ahmr0r3JJCs48
	C2j/S8xqYKKxSW8Kj7j19oSC4LLqr0qjBTHwB/+JagsuFReMIQ8DUDlczINyaVWNzMjJYz9ZyY3
	zYlYL2hcQQDbmkj4I0wcsbd9MwPUbsQ2PCwBjWlt8L1g2cBEUDxC0hH3aR3saD9Iqj4Q=
X-Received: by 2002:a05:620a:454e:b0:8c6:e11c:5ec4 with SMTP id af79cd13be357-8cbc8df8884mr430465085a.35.1772210488685;
        Fri, 27 Feb 2026 08:41:28 -0800 (PST)
X-Received: by 2002:a05:620a:454e:b0:8c6:e11c:5ec4 with SMTP id af79cd13be357-8cbc8df8884mr430460585a.35.1772210488048;
        Fri, 27 Feb 2026 08:41:28 -0800 (PST)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c716caebsm46535886d6.15.2026.02.27.08.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 08:41:27 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 27 Feb 2026 11:41:08 -0500
Subject: [PATCH RFC v3 2/2] block: enable RWF_DONTCACHE for block devices
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260227-blk-dontcache-v3-2-cd309ccd5868@columbia.edu>
References: <20260227-blk-dontcache-v3-0-cd309ccd5868@columbia.edu>
In-Reply-To: <20260227-blk-dontcache-v3-0-cd309ccd5868@columbia.edu>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Brendan Jackman <jackmanb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
        Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772210483; l=4224;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=8jgmldQQbiZzzlvIZlNR4V+9tVlk4w4gZb+9NNCt4y8=;
 b=vm0JkGcE+Uz0XFcsWwyvUOREbVMTCc75ksaV58G85KW5Z1ue6w4/8TqYICgOvWLed9AR0ZKdg
 MXRWrkfiaqjDOu1E1bJGDUJ5l8zmf/6G8O+4wBj6LctSBz2MF/pSI8J
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: FTEETp9LzTsqG3wvgTrDyyRJ7fIJ_M20
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE0OCBTYWx0ZWRfX0JDtESi8cNcg
 Uz2NYvjwDNWsTL6yC7YhV9Z9WVnmC1yLAQmPGRJ4+8ubWbOoz13p5P219v0jGHY0S1WxrkkuRi5
 IyFRFYj33KEXk0wkajKI02QJW1FNjffKVoj5473fysXcx1V1m9y/eO8ybTK7D+7/D22xHa4fT4h
 rY3Qfjd5354ez+iZNt9czYzlZHijjFs/8U5nqdmviRZRgRM0N65yrwm4R/2M14DVIegGiSpxzXP
 REdD+Wlka4bgcBjFK0ODbkAlwbNlre5AY9UnKYB6xvxVdMdeKY6wu/5egaAWIUBA6AhC5Do0NPZ
 Dwv9Mve0VcI010MrTeW+jn1Dbr26UTKaJy4qfFIytI3GMPgO4TaoQEHFKtbguCkMjOAfEm19xQm
 smVAHLhiTCk0m/tBm0eTS5b7U57ZIQYKPumoPbRPQyuIKoBUTKcy8mjbeeMRcoQy4Xd+AGHHRlp
 lugfwFOxiq8bY8dOnMA==
X-Proofpoint-ORIG-GUID: FTEETp9LzTsqG3wvgTrDyyRJ7fIJ_M20
X-Authority-Analysis: v=2.4 cv=H6zWAuYi c=1 sm=1 tr=0 ts=69a1c939 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=Kw1KkKa2aV08GXngiw4A:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11714
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=10
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=10 impostorscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270148
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[columbia.edu,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[columbia.edu:s=pps01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-78750-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[columbia.edu:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[columbia.edu:mid,columbia.edu:dkim,columbia.edu:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tz2294@columbia.edu,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B2C031BAF28
X-Rspamd-Action: no action

Block device buffered reads and writes already pass through
filemap_read() and iomap_file_buffered_write() respectively, both of
which handle IOCB_DONTCACHE. Enable RWF_DONTCACHE for block device files
by setting FOP_DONTCACHE in def_blk_fops.

For CONFIG_BUFFER_HEAD paths, add block_write_begin_iocb() which threads
the kiocb through so that buffer_head-based I/O can use DONTCACHE
behavior. The existing block_write_begin() is preserved as a wrapper
that passes a NULL iocb.

This support is useful for databases that operate on raw block devices,
among other userspace applications.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 block/fops.c                |  5 +++--
 fs/buffer.c                 | 19 ++++++++++++++++---
 include/linux/buffer_head.h |  3 +++
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 4d32785b31d9..d8165f6ba71c 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -505,7 +505,8 @@ static int blkdev_write_begin(const struct kiocb *iocb,
 			      unsigned len, struct folio **foliop,
 			      void **fsdata)
 {
-	return block_write_begin(mapping, pos, len, foliop, blkdev_get_block);
+	return block_write_begin_iocb(iocb, mapping, pos, len, foliop,
+				     blkdev_get_block);
 }
 
 static int blkdev_write_end(const struct kiocb *iocb,
@@ -967,7 +968,7 @@ const struct file_operations def_blk_fops = {
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= blkdev_fallocate,
 	.uring_cmd	= blkdev_uring_cmd,
-	.fop_flags	= FOP_BUFFER_RASYNC,
+	.fop_flags	= FOP_BUFFER_RASYNC | FOP_DONTCACHE,
 };
 
 static __init int blkdev_init(void)
diff --git a/fs/buffer.c b/fs/buffer.c
index 838c0c571022..18f1d128bb19 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2241,14 +2241,19 @@ EXPORT_SYMBOL(block_commit_write);
  *
  * The filesystem needs to handle block truncation upon failure.
  */
-int block_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
+int block_write_begin_iocb(const struct kiocb *iocb,
+		struct address_space *mapping, loff_t pos, unsigned len,
 		struct folio **foliop, get_block_t *get_block)
 {
 	pgoff_t index = pos >> PAGE_SHIFT;
+	fgf_t fgp_flags = FGP_WRITEBEGIN;
 	struct folio *folio;
 	int status;
 
-	folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
+	if (iocb && iocb->ki_flags & IOCB_DONTCACHE)
+		fgp_flags |= FGP_DONTCACHE;
+
+	folio = __filemap_get_folio(mapping, index, fgp_flags,
 			mapping_gfp_mask(mapping));
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
@@ -2263,6 +2268,13 @@ int block_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
 	*foliop = folio;
 	return status;
 }
+
+int block_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
+		struct folio **foliop, get_block_t *get_block)
+{
+	return block_write_begin_iocb(NULL, mapping, pos, len, foliop,
+				      get_block);
+}
 EXPORT_SYMBOL(block_write_begin);
 
 int block_write_end(loff_t pos, unsigned len, unsigned copied,
@@ -2591,7 +2603,8 @@ int cont_write_begin(const struct kiocb *iocb, struct address_space *mapping,
 		(*bytes)++;
 	}
 
-	return block_write_begin(mapping, pos, len, foliop, get_block);
+	return block_write_begin_iocb(iocb, mapping, pos, len, foliop,
+				     get_block);
 }
 EXPORT_SYMBOL(cont_write_begin);
 
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index b16b88bfbc3e..ddf88ce290f2 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -260,6 +260,9 @@ int block_read_full_folio(struct folio *, get_block_t *);
 bool block_is_partially_uptodate(struct folio *, size_t from, size_t count);
 int block_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
 		struct folio **foliop, get_block_t *get_block);
+int block_write_begin_iocb(const struct kiocb *iocb,
+		struct address_space *mapping, loff_t pos, unsigned len,
+		struct folio **foliop, get_block_t *get_block);
 int __block_write_begin(struct folio *folio, loff_t pos, unsigned len,
 		get_block_t *get_block);
 int block_write_end(loff_t pos, unsigned len, unsigned copied, struct folio *);

-- 
2.39.5


