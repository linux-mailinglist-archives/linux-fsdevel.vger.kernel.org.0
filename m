Return-Path: <linux-fsdevel+bounces-78407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMLkE7V6n2lYcQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 23:41:57 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C589719E61E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 23:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 680E93074787
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 22:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F853451CF;
	Wed, 25 Feb 2026 22:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="RImKPNCZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34A834B42B
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 22:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772059301; cv=none; b=bHzz4zAoS25TG8reP85kpXmI1ZoHueoyG43FanexMqD5Ln5lhcDvwjvX1CrK5JHNxBxydTaOkJoYxi/ZBScwbpg2SOtiEWS0EG+yslfKy4zo4Ds2APZEmTBVZZYCi5eaKADtvZn0WWnC3zmSOau7NoVLfGI0xg4kMBTRjuGkWsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772059301; c=relaxed/simple;
	bh=ekfAVbLYcjxp51ZCBzMQhFzplblwqexTK85RlJKVH8w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fvQ6/IBghAKHEkQ9iDY9jMiCYQKnPV882c3tQd9VemzKJlnRHWtp3ssMgdQ+hqh5ACpNSkNoOhLXmRdd7RL3Eis8eYsYgdb2PlHDByh3HytBXi9BftULWjB/xekga3ktkt2mac4t1++tYe3qKyfzq823fJOm1zSV3FkLTIiEneY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=RImKPNCZ; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Received: from pps.filterd (m0167072.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PMC1HO1601392
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 17:41:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=NwfwFIozanEmKQ2WboEF2eLSp6
	u+ajjzqhBznl9Xp5k=; b=RImKPNCZ8KR3nDEvDi4Gz9JoREnYDKQllwTLwprPHg
	EZofUkqZpuHKMfVkzs+LY3j8dY74beRPFZZqhviKCUh1A2aNAYdfXqAiPMNKe6ks
	loSk5i2FGL9XrTFvsXn+Fj4ikmc+y8v6qRN0pGcWLyoBDKExdlR/F0ck5JmojNjI
	6CWLc67/eX71ODfjr0b3f1m/+oygS+gHi2JrNGQpDfZmE2mf1hqoIkjHVplkAx94
	MuZA83rNfSsk951VH5T/nWxyNcGJ7PcZNqaziom5z3Kb+zCPooeJAAz6nS1ZIV6n
	eVf8ho1hT2KaT6aXMhD0vvQDM44N5ONvCiXmsLg8j3UA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4chxa0p1sa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 17:41:38 -0500 (EST)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-506ab115571so20414531cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 14:41:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772059298; x=1772664098;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwfwFIozanEmKQ2WboEF2eLSp6u+ajjzqhBznl9Xp5k=;
        b=jg6THMegNH+o8ZHlS8llRBIm8WU3440glK5VTqoPElgLDk/5w/YQNQzYabMdbYRcbC
         lgDDPSIf4x338zoL18/mPPIIPsVY4xXP5b003NdaIXOnPXDkg9LjMJtf4uPfz/yuw5Sc
         JmN1Bgt5S4da/hCm+P6xb0OzxpCjmF21XN5ZU0yu2o6Lf8/x234JHFx4QLtALA29CPzD
         kJGlaHVjMbn30dcGNnpR4FNYTrOyHM+I6Y2ci5BAenPUE8E/hrPZqk8KVytAhlWM4GGs
         vrLC8gZUIHXVvOfz8pHmrgJuVw2DDNLIDy5SyIx9IZ6Mk+LSMQJNHvAt/8cOMctLtPuM
         cVwg==
X-Forwarded-Encrypted: i=1; AJvYcCXQUlDzIxy+Gc3YBFPOaR0JQ8nz1pQ9B/q7xh8+BJhjOzoKEek8i34gi5hGPCdWc2RfVFkQqXJsFJZXFDYE@vger.kernel.org
X-Gm-Message-State: AOJu0YyBZbHKbNblRIrA3O32itfkSdO6Fx1aDmRJKMuDQUDcMzuo5mDf
	NXavw0O0OxEi4bJjoSmB+THhbpZITFAP6m/3+DnJq+4QMC/vh3Chh/5pVqVLZ+AhCEUMJJcTwgE
	g0dFNZCwbU5eKyxPZ7DPEHpwKcLeYB9XSGMQVDr7QI1pmXdDCHNd/rf5gAgeXymY=
X-Gm-Gg: ATEYQzwoi9/3tcJpABp3w7wPl1iD28j/XT2n8v48WW7eLZn7oGQjaNEUzTsl8BE+ay0
	4hrVdG4oygHYOu3aHlp+9g4VpuC92HZOG2M+LtH0vD8WdO49t5IMNmRBWJXL5ANv+DN582ScBKl
	2YwGe0/wX5UBhSPva9jLJwDS9CQxL0U75/fc+D8CElwFkLSX/MjPleqI7yqLhNSP05zpQfMg3il
	7EkCDjrXd06as3bKJX1TTHLD+LqHU75svElv40E+IkXvCtC+uYy+zVxA6jY7xD/q5p6spopILpf
	gYQVVLdjh+O4/aTD0vYOtdMloWBg36oRewr10n/HTtvA0Yijk01eXAnkuA5ZJKwSrexWOZ4KktZ
	49XBVGEA/zzUu7JKxcaxCFRsfYYMg7Jet
X-Received: by 2002:ac8:5a10:0:b0:507:3d1:1dd7 with SMTP id d75a77b69052e-5070bba1d4bmr250747161cf.6.1772059297765;
        Wed, 25 Feb 2026 14:41:37 -0800 (PST)
X-Received: by 2002:ac8:5a10:0:b0:507:3d1:1dd7 with SMTP id d75a77b69052e-5070bba1d4bmr250746791cf.6.1772059297257;
        Wed, 25 Feb 2026 14:41:37 -0800 (PST)
Received: from [127.0.1.1] ([216.158.158.246])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-507449be47dsm4196231cf.15.2026.02.25.14.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 14:41:36 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH RFC v2 0/2] block: enable RWF_DONTCACHE for block devices
Date: Wed, 25 Feb 2026 17:40:55 -0500
Message-Id: <20260225-blk-dontcache-v2-0-70e7ac4f7108@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHd6n2kC/3WNywrCMBREf6XctZEmsQ9cCYIf4Fa6SJMbe7FNJ
 GmLUvLvhu5dnhnmzAYRA2GEc7FBwJUieZdBHArQg3JPZGQygyhFXQresn58MePdrJUekEnZcim
 NKU8VQt68A1r67L4H3G9X6HI4UJx9+O4fK9+rP7qVM86sMnXdVGgbbi/aj8vUkzqiWaBLKf0A3
 ZPdNLIAAAA=
X-Change-ID: 20260218-blk-dontcache-338133dd045e
To: Jens Axboe <axboe@kernel.dk>,
        "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Yuezhang Mo <yuezhang.mo@sony.com>, Dave Kleikamp <shaggy@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Bob Copeland <me@bobcopeland.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org,
        ntfs3@lists.linux.dev, linux-karma-devel@lists.sourceforge.net,
        linux-mm@kvack.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772059296; l=3435;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=ekfAVbLYcjxp51ZCBzMQhFzplblwqexTK85RlJKVH8w=;
 b=2wmi7DKqWa1grTlTD1dZPRjRg04r6SzcKRju6wHkROUyXexSvTsDYhaJkZR7D1wKnD2GYouNO
 3Rj5CWfTkXjD0Y32lUMXPSG0+DtraUDXS1xjTx+UYD/cLuEYlAV1ClC
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=Csiys34D c=1 sm=1 tr=0 ts=699f7aa2 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=mD05b5UW6KhLIDvowZ5dSQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=SsB-OO3BMngHh3ZO9fOt:22
 a=VwQbUJbxAAAA:8 a=sdoS8YJ70VgF2Jk85QkA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: RgjRYBox-cLbSsLyPzyGAA4Pahx9UkIP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDIxNiBTYWx0ZWRfX69xxgdEM+/qK
 G6H/vC1DjtE30yVcWci6+qByb4FTy3TLYphvstOPOS8QqZZL0fbKHk5gNQGRxp6paBlgASOApoW
 z6QNcjjs/WvZqzQtEDpsEQ/r/0SJck/23FRmkCHTaVQnrELV+MljWREGbbJfC0CV16mRVkwVGvh
 2/eZUeqn1b23jjQTdSUUzlDAlbt82kYz1Psk2uYJ4uyhSbmCyKk3dSoYwKtKxvm6H9vEdbcWXfc
 xnqDIK0F3gCsqI4zA9moESPRJYSEXuoxCGGN0YenqhmRRLgrjXQaVj5SnnCM/eA51HuqQvlx/Nl
 2VWBjtqc0yvWHO+C7PR30LOfAwjzMfiznHY1md5QoMzieDitX0g57Fy5JzvfaxNZjFeM4WDHxp7
 ilames4wOW9or+AoqeWGcmzVtDMdsqI0mjmVxieJe3Ugt+M/kkSM7YLidy+CFJzaaP0ZNDu0M11
 PH099u71kg79ALFyOzA==
X-Proofpoint-ORIG-GUID: RgjRYBox-cLbSsLyPzyGAA4Pahx9UkIP
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11712
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 lowpriorityscore=10
 impostorscore=10 phishscore=0 suspectscore=0 bulkscore=10 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602250216
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[columbia.edu,none];
	R_DKIM_ALLOW(-0.20)[columbia.edu:s=pps01];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78407-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,columbia.edu:mid,columbia.edu:dkim,columbia.edu:email];
	FREEMAIL_TO(0.00)[kernel.dk,gmail.com,zeniv.linux.org.uk,kernel.org,suse.cz,samsung.com,sony.com,dubeyko.com,paragon-software.com,bobcopeland.com,infradead.org,linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[columbia.edu:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tz2294@columbia.edu,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C589719E61E
X-Rspamd-Action: no action

Add support for using RWF_DONTCACHE with block devices and other
buffer_head-based I/O.

Dropbehind pruning needs to be done in non-IRQ context, but block
devices complete writeback in IRQ context. To fix this, we first defer
dropbehind completion initiated from IRQ context by scheduling a work
item on the system workqueue to process a batch of folios.

Then, fix up the block_write_begin() interface to allow issuing
RWF_DONTCACHE I/Os.

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

 block/fops.c                |  4 +--
 fs/bfs/file.c               |  2 +-
 fs/buffer.c                 | 12 ++++---
 fs/exfat/inode.c            |  2 +-
 fs/ext2/inode.c             |  2 +-
 fs/jfs/inode.c              |  2 +-
 fs/minix/inode.c            |  2 +-
 fs/nilfs2/inode.c           |  2 +-
 fs/nilfs2/recovery.c        |  2 +-
 fs/ntfs3/inode.c            |  2 +-
 fs/omfs/file.c              |  2 +-
 fs/udf/inode.c              |  2 +-
 fs/ufs/inode.c              |  2 +-
 include/linux/buffer_head.h |  5 +--
 mm/filemap.c                | 84 ++++++++++++++++++++++++++++++++++++++++++---
 15 files changed, 103 insertions(+), 24 deletions(-)
---
base-commit: 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
change-id: 20260218-blk-dontcache-338133dd045e

Best regards,
-- 
Tal Zussman <tz2294@columbia.edu>


