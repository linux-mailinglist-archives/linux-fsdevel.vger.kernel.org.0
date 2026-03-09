Return-Path: <linux-fsdevel+bounces-79821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IC2DNMwEr2knLwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 18:35:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C07C523DB09
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 18:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 58FAA3012B4E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 17:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D220374752;
	Mon,  9 Mar 2026 17:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cmmNWCeb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B415C3ACF0B;
	Mon,  9 Mar 2026 17:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773077706; cv=none; b=IOao3Z6xJeupjIuT4rcvV/HbjPmYS0WnOpCPHHVR9EG6+IArZoNMeC2G90EWVrj06cz780pCsZ4Lk6ul4CVQRvuHOGeHgC9skVTE0sGta0X4wtP0cAzt1HvuNcxGSKfpIvKJesO8RVtJHPiQUBkuzAzMHP4jiTHkFmBQO/o5/qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773077706; c=relaxed/simple;
	bh=kyY//F9eOQX0/Oh3hHtRE3YZIKc2PL/jyPEc4Mn2idQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JGidd7+oSC2DMSGEM+9YMApvfJPJl+Pbatc8UwGdNsgE/YXd8FTv3VUUvSk/vcHpPpOWFBvzvW2oCsagliuXunG+BosWr5rDM/Rr61/JA02ggFla8WEdccYrrA0akhxbt+1/LR0J0/+4u2zDF4ij6J83YNaGVOcrG41HUbrkhVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cmmNWCeb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629F1D2c1587167;
	Mon, 9 Mar 2026 17:34:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=IGjLdmecKjgoDONdoJGj6y4YjmlQfnh79sgI7Z69E
	cw=; b=cmmNWCebIh6eWwa6bfgQ64OrZc8hi0R+BFOdL+GTn7lyDRjMjjwlX8cr3
	/2PM1mKkvno9ra7oHCwA/Vj/VWKTn+Zi4CzBTsXSsRZsowEan9/dcDeyMZqiWshb
	5ecZICoFvBE02DFTYe9CtjALoP8k62+kUx2KK+v7x76oYhMxFp5J1UfD1oJ7VwUs
	isLRXlfsNR6mLz5LFCgC0r8Dpqdh0o3R1Na/1YyovhcxCrt3ArRAFiD69Lyt6AID
	NQmPsKQUJKia43Npe2+YH3gUpbOpjxz9bzxwL3IEZPwqyTDafBAHmE/rhTnRrFLj
	cmUPBLZC8CIuqOUdP5I8I8BMowSJw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvm7rev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 17:34:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 629EDVkq015653;
	Mon, 9 Mar 2026 17:34:39 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4crybn5xdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 17:34:39 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 629HYbw248169298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Mar 2026 17:34:37 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69F1520043;
	Mon,  9 Mar 2026 17:34:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F93520040;
	Mon,  9 Mar 2026 17:34:34 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.22.68])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Mar 2026 17:34:34 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: djwong@kernel.org, john.g.garry@oracle.com, willy@infradead.org,
        hch@lst.de, ritesh.list@gmail.com, jack@suse.cz,
        Luis Chamberlain <mcgrof@kernel.org>, dgc@kernel.org, tytso@mit.edu,
        p.raghav@samsung.com, andres@anarazel.de, linux-kernel@vger.kernel.org
Subject: [RFC 0/3] Add buffered write-through support to iomap & xfs
Date: Mon,  9 Mar 2026 23:04:30 +0530
Message-ID: <cover.1773076216.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: IWp_9BbuKreQFC62Zr9Mz0-b_69QhO-a
X-Proofpoint-ORIG-GUID: 4v1vrtKvWlQdULbiyTJMI18SBiHnclKS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDE1OCBTYWx0ZWRfX2OkHXQHi1vUy
 pti9c1snkGU0j13QCchAiWTTDL/G+p90GnvVwI9OcZraUFELZHDvDimdOyXAXkBogZ6TmRPqkcF
 jYGQ2PRA7C4IB6/Im09ACACZzeBWWaw5mZTPP/h136CMEICWdhVZwnMS2y8BlteVX7/LZfDNk6D
 Uu8AGmHJfWE/DdR3sUM0vlu3o+SruL5QOzviSd1Nf8OBF3ZhFFpUaUsFTgUHa7HnPkoUDNK3rDO
 KfSv0+1u9DSIiTP4d9zICEvXd8T+kfNYyjBECM6GEP+Esjo18l63wuyTvsvy8hx+C9Ux7GRJQgQ
 M6mIweN1PAy5TBBGvPjodhjap3g1YCoiNd+fmwwTSj70nSp1KX+FCTAVbCbbTK2iEPZzQ0DRehc
 DSCq+lF7r+GLiEouKFvqDIPm3n1+HUUju80bk5c2v6JGLPuG6vkotK8t0QZGy/YRrU6cBr/a4cR
 aC6WkuzhTHX5c/yTqUA==
X-Authority-Analysis: v=2.4 cv=B5q0EetM c=1 sm=1 tr=0 ts=69af04b1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=mKH1vGL1XA5uFJBiVzsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090158
X-Rspamd-Queue-Id: C07C523DB09
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,infradead.org,lst.de,gmail.com,suse.cz,mit.edu,samsung.com,anarazel.de,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-79821-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojaswin@linux.ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.ibm.com:mid];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

Hi all,

This patchset implements an early design prototype of buffered I/O
write-through semantics in linux.
 
This idea mainly picked up traction to enable RWF_ATOMIC buffered IO [1],
however write-through path can have many use cases beyond atomic writes, 
- such as enabling truly async AIO buffered I/O when issued with O_DSYNC   
- better scalability for buffered I/O

The implementation of write-through combines the buffered IO frontend
with async dio backend, which leads to some interesting interactions.
I've added most of the design notes in respective patches. Please note
that this is an initial RFC to iron out any early design issues. This is
largely based on suggestions from Dave an Jan in [1] so thanks for the
pointers!


* Testing Notes *

- I've added support for RWF_WRITETHROUGH to fsx and fsstress in
  xfstests and these patches survive fsx with integrity verification as
  well as fsstress parallel stressing.
- -g quick with blocks size == page size and blocksize < pagesize shows
  no new regressions.


* Design TODOs *

- Evaluate if we need to tag page cache dirty bit in xarray, since 
  PG_Writeback is already set on the folio.
- As mentioned in patch 2, we call ->iomap_begin() twice which is not
  ideal but is kept this way to avoid churn and keep the PoC minimal.
  Look into a better way to refactor this.
- Fix support with filesystem freezing.


* Future work (once design is finalized) *

- Add aio O_DSYNC buffered write-through support
- Add RWF_ATOMIC support for buffered IO via write-through path
- Add support of other RWF_ flags for write-through buffered I/O path including
- Benchmarking numbers and more thorough testing needed.

As usual, thoughts and suggestions are welcome.

[1] https://lore.kernel.org/all/d0c4d95b-8064-4a7e-996d-7ad40eb4976b@linux.dev/

Regards,
ojaswin

Ojaswin Mujoo (3):
  iomap: Support buffered RWF_WRITETHROUGH via async dio backend
  iomap: Enable stable writes for RWF_WRITETHROUGH inodes
  xfs: Add RWF_WRITETHROUGH support to xfs

 fs/inode.c              |   1 +
 fs/iomap/buffered-io.c  | 414 ++++++++++++++++++++++++++++++++++++++++
 fs/iomap/direct-io.c    |  64 ++++---
 fs/xfs/xfs_file.c       |  68 ++++++-
 include/linux/fs.h      |   9 +
 include/linux/iomap.h   |  34 ++++
 include/uapi/linux/fs.h |   5 +-
 7 files changed, 568 insertions(+), 27 deletions(-)

-- 
2.52.0


