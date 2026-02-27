Return-Path: <linux-fsdevel+bounces-78749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iL7BJJ/JoWmqwQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 17:43:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F3B1BAF0F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 17:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75FFC30A2BAE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FE7349AE6;
	Fri, 27 Feb 2026 16:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="WJ4WE7fY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FEA3469F8
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772210488; cv=none; b=A8/lwFzo4HcEQNgOq4qQ41WPgOV0lpy8Tx2okfuKW+/RNuFOe/HyTdWNEQmYXvNGwbt7YCEGDUftloL8BhyzCvq5OW2f/0/ldqXwXHG+qh4XGN0Tuz5N6Xuf4MUCwlIhMZtMLR2pBi2MC8U+D7Pbb4VZ22KY76DZWR70ofxs7Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772210488; c=relaxed/simple;
	bh=BEeIa88RvYQBpBW8wSWS7+9ZmJtRT8takeYNLITWrCY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aE64f3rTOucsGAnEz02klEq7QTkTQS1S7aKsG1a8cCyZ3Lbbz0RyxePu51F3nFMBN+TUOTdeZW4j4xmwEs7cbu+MaJy3AA9+qXradUP04VxpcOlaM5+7hQE5gE69Xpc9iOBnnkIpCWq2/uCIstGsNVxV7evI6VJWGGJkV/9qvl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=WJ4WE7fY; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RGNDZs4107809
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 11:41:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=kIopnbRq4jN3V/2gTsORTjLWBT
	vRkSveHkD2aWFgnTg=; b=WJ4WE7fYoUyiLGjnYIFC46Hw/0vUjE3nebGm34U/zr
	VZ/f462QjOtqeQqZLHDTtDdmUbsOAHcPrqc/Lvwfx91+uB0xBk8rkq5l4I5FzvrW
	aRsGK8IBpv2Im9i6x0aKDjoeIfX4KrI5kRkOqkW8bYQ5cbetHnqRZ1vnjc/jjE7Q
	2G5FNrqaZJh1N4OAXDAioA8u07YK/p2dQj6SVlccARRyT7vd/9vSGC0EeUPjQjhy
	Iay7JWvyDMuBOyZ2x5+pA6A2MPMgoo8Mj+2c13tnG7vnxK+D2zslW1qwNxiiVvEF
	SY+rN3sSzrh8QadkH7FOQtja5UpCp/iDBWPU4r3bYXWw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4cjppft4be-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 11:41:25 -0500 (EST)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8966c2b187bso313881946d6.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 08:41:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772210485; x=1772815285;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIopnbRq4jN3V/2gTsORTjLWBTvRkSveHkD2aWFgnTg=;
        b=RRxmTDf3GNCocadJ3R4GFONRrZ5FlxcvdTDqGsgHOpbYArYNDdZthZGkGSQm9d1mY9
         O0I0LyUe6HdaH9GXCCP0B1OTQJ5EWixdy6uVZfHuME6OV6q6tLHP1KXBqqydGRIvYRDx
         BRulF736i6LJfsTSs/lhxjii4BFGxpJ+Ug2vM4XpkAmoQV1sSYqrHLw/XFlxrs7lZimU
         /8F3//A/aVX6L5eZO0w93EVAbRXVTeTVsrF1oPicZCMQhGdjcUWY5rdgLEO+AM3MdLIh
         zSm8Eo+TlnxXxP8vUlTUj1Phdt3H2oCZLxfbT+31DYm2CaVoQ2IdXdwZLvBqivcg4ynB
         D0AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPQEZL0O5JFBk+LH81UQm9OPUzXXm9EHfxqaIE331eNPVtb+r1VaUvt5ghO5cz6canWNFdO7uTBaP/5h1z@vger.kernel.org
X-Gm-Message-State: AOJu0YwIoGoXh89AH1jQ2/5s7izkzirD5v0EsK9EJcvawPYupPUZZJFH
	wuVkZkOMVBNmpahL5L5x0fDh+jQ1ZXe+usAHVM2ooNyiBNdfGQaKqilBbVD8Ck0oF4tY9DSVtES
	VXxypvNYufw3HjVnRBIKvy/dXJ9GY9RCrTzyXVGQlw1f8l8XTlkR1wc5ifLhJT1I=
X-Gm-Gg: ATEYQzxSM5pagu+o899ZKQRXWoV3Muy0b+6vdjSpbid2cbHALbog0Z7UtzsjiWA1FGZ
	enW+0hf8wX7scnkv+ljyvqX5PsiX0CQJE4jmNmrcgRukrXaepMJINNnuyJs6jD4zDehfTiCxhhV
	nGulMfL7Y10g7Dx2zVNOTe9rFlwxPuw3CgwewMgpg4/358mR4Xe3Gkt0BCUSK2ZbW+pu5UlXE5W
	dF6b2ZNWszQbrtEbkiw2cv1XilJT9MMpZU9zybl8fLGBEpkq1IlnhQXa/Bw34y9b3rVXfAqUWW3
	9komO+OXcuSAHni6q3S5SwBBvxFud7ZewDX1I0WWrMvHTyoD00gEv9z51nMIfufrWQFHfCPj5Of
	8YRBDqhm5l4whL0gHDG0idjdirQtMy/O9ncMxgtR39OQioilDjtAlkE02YweAv3j9lDk=
X-Received: by 2002:a05:6214:4109:b0:88f:a4a0:2ddf with SMTP id 6a1803df08f44-899d1e5070dmr56245666d6.46.1772210485150;
        Fri, 27 Feb 2026 08:41:25 -0800 (PST)
X-Received: by 2002:a05:6214:4109:b0:88f:a4a0:2ddf with SMTP id 6a1803df08f44-899d1e5070dmr56245036d6.46.1772210484479;
        Fri, 27 Feb 2026 08:41:24 -0800 (PST)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c716caebsm46535886d6.15.2026.02.27.08.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 08:41:23 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH RFC v3 0/2] block: enable RWF_DONTCACHE for block devices
Date: Fri, 27 Feb 2026 11:41:06 -0500
Message-Id: <20260227-blk-dontcache-v3-0-cd309ccd5868@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACLJoWkC/3XNywrCMBAF0F8pWTuSR1+4EgQ/wK24SJOJDdZGk
 jYopf9uyEoKLu8d7pmFBPQWAzkUC/EYbbBuTEHsCqJ6Od4RrE6ZcMprylkL3fAA7cZJSdUjCNE
 yIbSmZYUkbV4ejX1n70ou5xO5pbK3YXL+k39Elk9/uMiAgZG6rpsKTcPMUblhfnZW7lHPGYv8B
 +DVFuBAoaHYSFWmPW03wLquXysbLKrzAAAA
X-Change-ID: 20260218-blk-dontcache-338133dd045e
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772210483; l=3619;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=BEeIa88RvYQBpBW8wSWS7+9ZmJtRT8takeYNLITWrCY=;
 b=P2OAzuWnRvGmfMu3FKgpEoLuWT0SusPENu+T5BBqjDCAzaIIHtNgLjq1p6L6MeydJbtozid2B
 FzfMGcUqZEjAp//Ioln1ll+QavLMRrtpcuVgSj1+WlZ/W6AWGzIkaUw
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: kzmLQcSs3PPrQzKjKMYtxuahVcPjgawc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE0OCBTYWx0ZWRfXwnd992uOkNY5
 kHiyEsHCFFsOKNK1zFVEVQkyJmz43P9lGf/KU6rpIVWu41tyXODyaZyK95ZCYaQLSBk7bWVt9Mn
 hqB4EKi0Y3sUg3vViaPte4hMU/gZUz5PhALQ3UtMrJlUjot1fns7Rgp8Qp0jvwPJeFzqY6HEoCv
 g2RMg8bOLGYdGTDQwFKFcaE0UZLj1jmuxHOFjYqB6ZRsP4Zen8DQyRntD08z/FyKENyIQPgLRBd
 +nPKJsNpli/Cj3vkRm1XnHHY7EZtbE2OIsowp5WN9OYu2yrreUsrqqjoyJ1iIhfu+LrZCZgnJnA
 EqwrSPElSnGU2KwUKsa/2ePqRxk5DEwMG2VPBeHp88RVL6HIm3bcGuEgEkk5/XV8Qj7Jtyl4mv8
 fSy7Ia070ALxAYodE2ZQ6V3JKJeIAuieF784TT+y0ZTuP1eGVp1QobuYBR1UKiewrFZ5W3iTNht
 U6TcgtedzHS3ah42Fwg==
X-Proofpoint-ORIG-GUID: kzmLQcSs3PPrQzKjKMYtxuahVcPjgawc
X-Authority-Analysis: v=2.4 cv=H6zWAuYi c=1 sm=1 tr=0 ts=69a1c935 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=VwQbUJbxAAAA:8 a=sdoS8YJ70VgF2Jk85QkA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
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
	TAGGED_FROM(0.00)[bounces-78749-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: E2F3B1BAF0F
X-Rspamd-Action: no action

Add support for using RWF_DONTCACHE with block devices and other
buffer_head-based I/O.

Dropbehind pruning needs to be done in non-IRQ context, but block
devices complete writeback in IRQ context. To fix this, we first defer
dropbehind completion initiated from IRQ context by scheduling a work
item to process a per-CPU batch of folios.

Then, add a block_write_begin_iocb() variant that threads the kiocb
through for RWF_DONTCACHE I/Os.

This support is useful for databases that operate on raw block devices,
among other userspace applications.

I tested this (with CONFIG_BUFFER_HEAD=y) for reads and writes on a
single block device on a VM, so results may be noisy.

Reads were tested on the root partition with a 45GB range (~2x RAM).
Writes were tested on a disabled swap parition (~1GB) in a memcg of size
244MB to force reclaim pressure.

Results: 

===== READS (/dev/nvme0n1p2) =====
 sec   normal MB/s  dontcache MB/s
----  ------------  --------------
   1         993.9          1799.6
   2         992.8          1693.8
   3         923.4          2565.9
   4        1013.5          3917.3
   5        1557.9          2438.2
   6        2363.4          1844.3
   7        1447.9          2048.6
   8         899.4          1951.7
   9        1246.8          1756.1
  10        1139.0          1665.6
  11        1089.7          1707.7
  12        1270.4          1736.5
  13        1244.0          1756.3
  14        1389.7          1566.2
----  ------------  --------------
 avg        1258.0          2005.4  (+59%)

==== WRITES (/dev/nvme0n1p3) =====
 sec   normal MB/s  dontcache MB/s
----  ------------  --------------
   1        2396.1          9670.6
   2        8444.8          9391.5
   3         770.8          9400.8
   4          61.5          9565.9
   5        7701.0          8832.6
   6        8634.3          9912.9
   7         469.2          9835.4
   8        8588.5          9587.2
   9        8602.2          9334.8
  10         591.1          8678.8
  11        8528.7          3847.0
----  ------------  --------------
 avg        4981.7          8914.3  (+79%)

---
Changes in v3:
- 1/2: Convert dropbehind deferral to per-CPU folio_batches protected by
  local_lock using per-CPU work items, to reduce contention, per Jens.
- 1/2: Call folio_end_dropbehind_irq() directly from
  folio_end_writeback(), per Jens.
- 1/2: Add CPU hotplug dead callback to drain the departing CPU's folio
  batch.
- 2/2: Introduce block_write_begin_iocb(), per Christoph.
- 2/2: Dropped R-b due to changes.
- Link to v2: https://lore.kernel.org/r/20260225-blk-dontcache-v2-0-70e7ac4f7108@columbia.edu

Changes in v2:
- Add R-b from Jan Kara for 2/2.
- Add patch to defer dropbehind completion from IRQ context via a work
  item (1/2).
- Add initial performance numbers to cover letter.
- Link to v1: https://lore.kernel.org/r/20260218-blk-dontcache-v1-1-fad6675ef71f@columbia.edu

---
Tal Zussman (2):
      filemap: defer dropbehind invalidation from IRQ context
      block: enable RWF_DONTCACHE for block devices

 block/fops.c                |   5 +-
 fs/buffer.c                 |  19 ++++++-
 include/linux/buffer_head.h |   3 +
 include/linux/pagemap.h     |   1 +
 mm/filemap.c                | 130 +++++++++++++++++++++++++++++++++++++++++---
 mm/page_alloc.c             |   1 +
 6 files changed, 145 insertions(+), 14 deletions(-)
---
base-commit: 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
change-id: 20260218-blk-dontcache-338133dd045e

Best regards,
-- 
Tal Zussman <tz2294@columbia.edu>


