Return-Path: <linux-fsdevel+bounces-78420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KENMaeKn2nYcgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 00:49:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 871E419F1C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 00:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61AA7311A315
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 23:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463ED389DE0;
	Wed, 25 Feb 2026 23:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="b/yB3FO8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6617D3876B1
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 23:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772063095; cv=none; b=OuSUk2kBRxGaOZNcUS5Smr8HuNdqdnjPEqx+9o2NB+62USCvYlgdHd+lzciH1sqass59cd0b1cYiUK3rb4w6XJJzA3oM12sW7iyPqjPQwHtc4qtBtgs67K1DXCgHC0Z9HxM6iz00vIOWfaomxXfKIhrHkBMLWqefzK7Nie37AK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772063095; c=relaxed/simple;
	bh=zO7GBjiuOn5Q+h+zA8UgP1+Klsw8MQQTt1O0svxg4WA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pGGlSwZcaGMULI91d6VKi5Hq7lubx6lHGsl7gcRahan2p8aUfryoyMJ3jcRISh0OVdzMaNf14qrRHe/xm85H0AliGN+8acmP++fPlfAjAUG57J1FPJAcFa9OMpWIwO/I/AVK8DDZfO+tQ3dhVpaf7dsTK7EFM2iY02hmxxF5G2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=b/yB3FO8; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Received: from pps.filterd (m0167069.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PNNBpQ1399656
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 18:44:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=TE8Z
	hYBQf9fiNswnOLiD0snqyySTRxN7Ufk+GD8fw6E=; b=b/yB3FO8kwgXmET281Jv
	XP+tAXlRZIOQ6OAFR2YSS+792EIr83nP+nakYz8tKWh86IL9kbOyLkg2yn8b3g/q
	S5VPNh8sAcmAlprkg2Cw/wyQbawj3NLSALIkGLq2K8V4kIRt4aYXHS/DHlGsM8fs
	H8cCC3+JhbwQsrjnzdcgeRxONcJg4TG6TN/qWF72MSX7O8ZGhKSU3I2BfZEDoisK
	t1LvqQr0puhEkmBwjqopiEjNDjB9vH7tXsjnfmo+oQfclWfz01qggxeWH6r8fgsq
	rZ0/3X3DzNuyvGFcD+vq2Q7XNExoHO+FQm1lfYBwrgA16DwNSuwMZae97gH/dVl+
	jg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4chx6v6bcg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 18:44:51 -0500 (EST)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-506c0231e63so29612741cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 15:44:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772063090; x=1772667890;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TE8ZhYBQf9fiNswnOLiD0snqyySTRxN7Ufk+GD8fw6E=;
        b=VTVfdvLeuVGVTuSrYu+vWIF6yUwFRTlYkZgsV2DS2yJNVMqWiLO0cn4KHQbaT462ey
         8+tKVgQAfRwXkgjpTlobthZvuGE7JUoCir5dOGNTq8PG1q3e8cHLIr6WVCXRqmMFAhCX
         oC7smFHyeBcgdB5UPf6PVv8f5KYF+90q0W+v2zhU3jzQ5E70Uwp+zQtTn9mjEjpDWYIp
         6J9hcf72tuINiMSyX6TZ4ZDVzbXrKHk6fKJxyPsqU0k7y7ta2xPEePDkkXsKb2ROvsXi
         5TFR1DxchNGoTW4dXgABej7ERssE+0qktVn9QKq/OMDh//S0P4b0tzlK7ruPEqEvR1aL
         qMEA==
X-Forwarded-Encrypted: i=1; AJvYcCUcYzbsEsGBASIsVDzSCBxkEqM0SI6I1VpoKzaxbDE+C0cJ3H1GiTYfEROjuI3IEnwAgnnIBspHr9hXGc4h@vger.kernel.org
X-Gm-Message-State: AOJu0YwNC7j0P8uANJFPIGdd3n2YJTmZ8sT9E4Sp1WmS6FV1C+1gc42O
	bJvAwTWEKsAyPNBAc5MxoiyXJeOJelxAoVfnANccLGbXp56F7jLST3Mey9QvMmj5RLTt67akVru
	Y+mY787dp//bav4zhFkdK1HsznmV+3teHgCEeDVppG5VKRT+V4EXJJ7+nKfpPzlw=
X-Gm-Gg: ATEYQzyAwsfTlsi4cAcYbjqZ51IIoAxJcOJfL/1iJKRa0UyUrhTTTFg1KxzXXXO1HUy
	z4c9jQ7h3cU6ISjETlEyFcU9cpEv14E8jTw3KBQLPtjPTfmwNUzWQdQiGUxUR9A/9GaU+pCDMCJ
	ZeRPb3Ixj0dA/9PkBL+tkBiOlXboi8Gw9i5Vqyringn0jiDl3YAIQ7VFS+rYqryPjJ5NmuWLMLm
	SOAWHRhXTwVVwE/SXRvRu2oWBX5O/ctlVeOJRPMmD86F7/VveuvvRpOk7OOf/UVz0HJv5k04Ktu
	2gj2W8FIs/KATk8Yn/PoLPvI8xdwz1uuAO+niU0m1wP2xiGUmaqlbhk6yE0I4dWRTXWSdRnEote
	bEA5zzD+5VrkVY4xmyZ6JxKFKZW8fWQR2
X-Received: by 2002:ac8:5ac5:0:b0:503:2fe5:f380 with SMTP id d75a77b69052e-507441df64fmr13262981cf.0.1772063090000;
        Wed, 25 Feb 2026 15:44:50 -0800 (PST)
X-Received: by 2002:ac8:5ac5:0:b0:503:2fe5:f380 with SMTP id d75a77b69052e-507441df64fmr13262341cf.0.1772063089401;
        Wed, 25 Feb 2026 15:44:49 -0800 (PST)
Received: from [127.0.1.1] ([216.158.158.246])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c738d80bsm3357606d6.41.2026.02.25.15.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 15:44:49 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 25 Feb 2026 18:44:28 -0500
Subject: [PATCH v2 4/4] folio_batch: Rename PAGEVEC_SIZE to
 FOLIO_BATCH_SIZE
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-pagevec_cleanup-v2-4-716868cc2d11@columbia.edu>
References: <20260225-pagevec_cleanup-v2-0-716868cc2d11@columbia.edu>
In-Reply-To: <20260225-pagevec_cleanup-v2-0-716868cc2d11@columbia.edu>
To: David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Theodore Ts'o <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>,
        Paulo Alcantara <pc@manguebit.org>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Steve French <sfrench@samba.org>,
        Ronnie Sahlberg <ronniesahlberg@gmail.com>,
        Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
        Bharath SM <bharathsm@microsoft.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tursulin@ursulin.net>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, Ilya Dryomov <idryomov@gmail.com>,
        Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>,
        Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>,
        Hugh Dickins <hughd@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-ext4@vger.kernel.org,
        netfs@lists.linux.dev, linux-nfs@vger.kernel.org,
        ocfs2-devel@lists.linux.dev, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-btrfs@vger.kernel.org,
        ceph-devel@vger.kernel.org, gfs2@lists.linux.dev,
        linux-nilfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        cgroups@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772063077; l=5814;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=zO7GBjiuOn5Q+h+zA8UgP1+Klsw8MQQTt1O0svxg4WA=;
 b=KCL19WgRUDAqH63IGvAc3KncLR0mQnluCE5DMTx+wx8s1EMvm5gWiID7it4982lNgTaHXaECH
 ClIpdW+IjPxAETpUADJ+80YGkvu3AQ4uNneZg/M0Lj8/3I89nOh73yK
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: GL4AI6ZjEPZieoOiNkcj-tRqN_XojO7N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDIyNyBTYWx0ZWRfX9FrLq/NgupR2
 WHijD5vqzWtHeXua15iK9qxaNg3ZLuhGxIITxBGFU1pOrhfH4a4M79NP1XLaQ/HThtE0rjxEgi5
 fra3OmLaQatMDwwpjCMzlAj9nFno0IPkL8RdSp+TT2cNJgKdi7G9qYfQ0+bGfBX2ChVY82tggUq
 RsVYqBK5ZQ/tKbVHpbIafAs1JTN8A/8mBrba+s+ZwVSQ6rGem6q/aZ1fuHvcH1K4G6m1nvAo8jm
 1ll954oWnnFfYvAidIzGhoGWy365SkYl2vbGqq1tDvX6ajPt3D/hGLpMxNhOcd3r4htS0LCvrW9
 iPKgt2Yjx328PUayGM3ksn0v8gh+2SsjDPURm1TXE50a6F673wkXhyQryWF5UHdsgzwvPyz/hcH
 gkSm/kcihfPS4h6ch0QZ+JNE4dFKfYDLf3ycgNhrfhPrlZC9Umq4+4Ng5DY8iSP7D+njDb2wp6q
 G3gFFNEjfco5eUiIw5g==
X-Authority-Analysis: v=2.4 cv=FqMIPmrq c=1 sm=1 tr=0 ts=699f8973 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=mD05b5UW6KhLIDvowZ5dSQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=JR4YdQiviy7OQf72WyZ1:22
 a=960X5KZuJcz03JLduyoA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: GL4AI6ZjEPZieoOiNkcj-tRqN_XojO7N
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11712
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=10
 spamscore=0 bulkscore=10 lowpriorityscore=10 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602250227
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[columbia.edu,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[columbia.edu:s=pps01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[dilger.ca,manguebit.org,kernel.org,fasheh.com,evilplan.org,linux.alibaba.com,samba.org,gmail.com,microsoft.com,talpey.com,linux.intel.com,suse.de,ffwll.ch,intel.com,ursulin.net,fb.com,suse.com,redhat.com,dubeyko.com,linux.dev,oracle.com,brown.name,ziepe.ca,nvidia.com,cmpxchg.org,google.com,bytedance.com,lists.infradead.org,vger.kernel.org,lists.sourceforge.net,kvack.org,lists.linux.dev,lists.samba.org,lists.freedesktop.org,columbia.edu];
	FREEMAIL_TO(0.00)[redhat.com,auristor.com,kernel.org,linux-foundation.org,oracle.com,google.com,suse.com,tencent.com,huaweicloud.com,gmail.com,infradead.org,intel.com,suse.cz,zeniv.linux.org.uk,mit.edu];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78420-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[columbia.edu:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,columbia.edu:mid,columbia.edu:dkim,columbia.edu:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tz2294@columbia.edu,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_GT_50(0.00)[97];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 871E419F1C2
X-Rspamd-Action: no action

struct pagevec no longer exists. Rename the macro appropriately.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/btrfs/extent_io.c        | 4 ++--
 include/linux/folio_batch.h | 6 +++---
 include/linux/folio_queue.h | 6 +++---
 mm/shmem.c                  | 4 ++--
 mm/swap.c                   | 2 +-
 mm/swap_state.c             | 2 +-
 mm/truncate.c               | 6 +++---
 7 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c373d113f1e7..d82ca509503f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2095,13 +2095,13 @@ static void buffer_tree_tag_for_writeback(struct btrfs_fs_info *fs_info,
 struct eb_batch {
 	unsigned int nr;
 	unsigned int cur;
-	struct extent_buffer *ebs[PAGEVEC_SIZE];
+	struct extent_buffer *ebs[FOLIO_BATCH_SIZE];
 };
 
 static inline bool eb_batch_add(struct eb_batch *batch, struct extent_buffer *eb)
 {
 	batch->ebs[batch->nr++] = eb;
-	return (batch->nr < PAGEVEC_SIZE);
+	return (batch->nr < FOLIO_BATCH_SIZE);
 }
 
 static inline void eb_batch_init(struct eb_batch *batch)
diff --git a/include/linux/folio_batch.h b/include/linux/folio_batch.h
index a2f3d3043f7e..b45946adc50b 100644
--- a/include/linux/folio_batch.h
+++ b/include/linux/folio_batch.h
@@ -12,7 +12,7 @@
 #include <linux/types.h>
 
 /* 31 pointers + header align the folio_batch structure to a power of two */
-#define PAGEVEC_SIZE	31
+#define FOLIO_BATCH_SIZE	31
 
 struct folio;
 
@@ -29,7 +29,7 @@ struct folio_batch {
 	unsigned char nr;
 	unsigned char i;
 	bool percpu_pvec_drained;
-	struct folio *folios[PAGEVEC_SIZE];
+	struct folio *folios[FOLIO_BATCH_SIZE];
 };
 
 /**
@@ -58,7 +58,7 @@ static inline unsigned int folio_batch_count(const struct folio_batch *fbatch)
 
 static inline unsigned int folio_batch_space(const struct folio_batch *fbatch)
 {
-	return PAGEVEC_SIZE - fbatch->nr;
+	return FOLIO_BATCH_SIZE - fbatch->nr;
 }
 
 /**
diff --git a/include/linux/folio_queue.h b/include/linux/folio_queue.h
index 0d3765fa9d1d..f6d5f1f127c9 100644
--- a/include/linux/folio_queue.h
+++ b/include/linux/folio_queue.h
@@ -29,12 +29,12 @@
  */
 struct folio_queue {
 	struct folio_batch	vec;		/* Folios in the queue segment */
-	u8			orders[PAGEVEC_SIZE]; /* Order of each folio */
+	u8			orders[FOLIO_BATCH_SIZE]; /* Order of each folio */
 	struct folio_queue	*next;		/* Next queue segment or NULL */
 	struct folio_queue	*prev;		/* Previous queue segment of NULL */
 	unsigned long		marks;		/* 1-bit mark per folio */
 	unsigned long		marks2;		/* Second 1-bit mark per folio */
-#if PAGEVEC_SIZE > BITS_PER_LONG
+#if FOLIO_BATCH_SIZE > BITS_PER_LONG
 #error marks is not big enough
 #endif
 	unsigned int		rreq_id;
@@ -70,7 +70,7 @@ static inline void folioq_init(struct folio_queue *folioq, unsigned int rreq_id)
  */
 static inline unsigned int folioq_nr_slots(const struct folio_queue *folioq)
 {
-	return PAGEVEC_SIZE;
+	return FOLIO_BATCH_SIZE;
 }
 
 /**
diff --git a/mm/shmem.c b/mm/shmem.c
index 149fdb051170..5e7dcf5bc5d3 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1113,7 +1113,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
 	pgoff_t start = (lstart + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	pgoff_t end = (lend + 1) >> PAGE_SHIFT;
 	struct folio_batch fbatch;
-	pgoff_t indices[PAGEVEC_SIZE];
+	pgoff_t indices[FOLIO_BATCH_SIZE];
 	struct folio *folio;
 	bool same_folio;
 	long nr_swaps_freed = 0;
@@ -1510,7 +1510,7 @@ static int shmem_unuse_inode(struct inode *inode, unsigned int type)
 	struct address_space *mapping = inode->i_mapping;
 	pgoff_t start = 0;
 	struct folio_batch fbatch;
-	pgoff_t indices[PAGEVEC_SIZE];
+	pgoff_t indices[FOLIO_BATCH_SIZE];
 	int ret = 0;
 
 	do {
diff --git a/mm/swap.c b/mm/swap.c
index 2e517ede6561..78b4aa811fc6 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -1018,7 +1018,7 @@ EXPORT_SYMBOL(folios_put_refs);
 void release_pages(release_pages_arg arg, int nr)
 {
 	struct folio_batch fbatch;
-	int refs[PAGEVEC_SIZE];
+	int refs[FOLIO_BATCH_SIZE];
 	struct encoded_page **encoded = arg.encoded_pages;
 	int i;
 
diff --git a/mm/swap_state.c b/mm/swap_state.c
index a0c64db2b275..6313b59d7eab 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -385,7 +385,7 @@ void free_folio_and_swap_cache(struct folio *folio)
 void free_pages_and_swap_cache(struct encoded_page **pages, int nr)
 {
 	struct folio_batch folios;
-	unsigned int refs[PAGEVEC_SIZE];
+	unsigned int refs[FOLIO_BATCH_SIZE];
 
 	folio_batch_init(&folios);
 	for (int i = 0; i < nr; i++) {
diff --git a/mm/truncate.c b/mm/truncate.c
index df0b7a7e6aff..2931d66c16d0 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -369,7 +369,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
 	pgoff_t		start;		/* inclusive */
 	pgoff_t		end;		/* exclusive */
 	struct folio_batch fbatch;
-	pgoff_t		indices[PAGEVEC_SIZE];
+	pgoff_t		indices[FOLIO_BATCH_SIZE];
 	pgoff_t		index;
 	int		i;
 	struct folio	*folio;
@@ -534,7 +534,7 @@ EXPORT_SYMBOL(truncate_inode_pages_final);
 unsigned long mapping_try_invalidate(struct address_space *mapping,
 		pgoff_t start, pgoff_t end, unsigned long *nr_failed)
 {
-	pgoff_t indices[PAGEVEC_SIZE];
+	pgoff_t indices[FOLIO_BATCH_SIZE];
 	struct folio_batch fbatch;
 	pgoff_t index = start;
 	unsigned long ret;
@@ -672,7 +672,7 @@ int folio_unmap_invalidate(struct address_space *mapping, struct folio *folio,
 int invalidate_inode_pages2_range(struct address_space *mapping,
 				  pgoff_t start, pgoff_t end)
 {
-	pgoff_t indices[PAGEVEC_SIZE];
+	pgoff_t indices[FOLIO_BATCH_SIZE];
 	struct folio_batch fbatch;
 	pgoff_t index;
 	int i;

-- 
2.39.5


