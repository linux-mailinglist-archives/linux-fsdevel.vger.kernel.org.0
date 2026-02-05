Return-Path: <linux-fsdevel+bounces-76469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAQDOVfkhGlf6QMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 19:41:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DF2F681E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 19:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A4463021E40
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 18:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF20304BA3;
	Thu,  5 Feb 2026 18:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="t+9eOfVu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED573033D9;
	Thu,  5 Feb 2026 18:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770316879; cv=none; b=swyhcNkLSoGkxYB34n9WJSel39jQsYaJwiHoovI6zIA8ojUOfbPXTatLYwLAwow/zDBLn5h3Zk34I+N7Tz/G+ucc5iMpBbklGeTX5D8zDyNyPoQpZV9STI27OY1zZjXz9eh6MI4heVK3DArv0Pf2QSpq5ArrHBIirHnPaIyOk4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770316879; c=relaxed/simple;
	bh=Hi5UQjuU/DZJSJZTH5qYUoP+Sdou/oFrvriHbYA6PuM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lMTE30I2xz7in5q34qL1j+fmSAJJIIV7/JfCN/Hjw2H4QtKM27QXIWtjJ4YDYiTnhi9d/j5AkqREVLeeVKjwwMsgy0V9pJz4fjVRR4MZ8jLT82rFZM6y2jTczlYcAtN9zFqhAPnVsovsp42ASCCd7PGPsjulm2oc7UYx9xxn9+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=t+9eOfVu; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 615IHT2c2552915;
	Thu, 5 Feb 2026 10:41:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=oM3xrDYNgnBPMbFcD9YzGCr8W3sRHxsocFRPcAhDQAY=; b=t+9eOfVuJ0lh
	8o8aOadc6aewYQhc+yectZHQUqm+KDpZnbFr1txcOfb4GBv6QfSwEzqOI15Rlc3l
	8XED5X4Jx16FPDZiAr+7Pe1nhJBd0GouslCZNODT+CXh/9VhZmpYijf94+XKhk9E
	J9tI2hDWayJiYONNv+9U9WT4PJpitslsu2heD0Jp9rHiJMgfxVdyKjL94DE4ZuJ1
	DID6XS56gZPBd7JbfNhKp1IQ8GJdFQjymQ6+dpW8xzjVQnVnuk81Mv8wUE+b0CWT
	WFAtK1TBRxiEqfiIp5g9el36kWWeRt1/mBan/nKrG4oR2Gyu6sxZWXxVkCawm4q6
	QTPe0jIH+w==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4c4v053t8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 05 Feb 2026 10:41:06 -0800 (PST)
Received: from devbig003.atn7.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 5 Feb 2026 18:41:05 +0000
From: Chris Mason <clm@meta.com>
To: "Darrick J. Wong" <djwong@kernel.org>
CC: <miklos@szeredi.hu>, <joannelkoong@gmail.com>, <bernd@bsbernd.com>,
        <neal@gompa.dev>, <linux-ext4@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 07/10] fuse: enable iomap cache management
Date: Thu, 5 Feb 2026 10:33:26 -0800
Message-ID: <20260205184044.1551228-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <176169812229.1426649.17695442505194165425.stgit@frogsfrogsfrogs>
References: <176169812012.1426649.16037866918992398523.stgit@frogsfrogsfrogs> <176169812229.1426649.17695442505194165425.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: xbfyWG5S63BgPpVffR03KRbbIGhfvgxt
X-Authority-Analysis: v=2.4 cv=YLOSCBGx c=1 sm=1 tr=0 ts=6984e442 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=h9-URPGDUGhjHTz5WgkA:9
X-Proofpoint-ORIG-GUID: xbfyWG5S63BgPpVffR03KRbbIGhfvgxt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDE0MiBTYWx0ZWRfXxJQrvAJZn65F
 fLWtvD+1kHAsQ7ITfHRZW38ayOC9A2HYcfxntHYhsgC7XIOjQr4YfAjv/eJNl/rWBcMY7351BzK
 4iWninrNtR3BMRFDDIwWhxb0Y4hXJvvxJGrjzfrnp0caULjbuzcehSe487/dOxihSHYCCFkvUE1
 tbBqWEf4yXX4pllsmFi4gOAyS8PAoN7UVsyaMhwABEfb+llQaZ5MnRSEtSpZik9AFY7ar6+8qvI
 q5t5ObEOw5AqV1R6bf5ZnL2uSo0fBrAeLaUj5vFhW8EgbG0boz71clSaPCMS5Xy54s8sDJr3pPm
 mh1co7vESLzmVJDXz9A0+jvDn0P4t2FBaYGldxShiuK7peQK8jbSZHJqlmz3mfCJ0ad04F59UmR
 NzingXA8MtI5m1uYI7x6Hm3Vrlp7Y4pTyO3iQUCxea/YCrjb4bxAPkE1qTcXCAR2UTEx5zUIuAN
 FrvTx36HABBBkxT3QGQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_04,2026-02-05_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76469-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[szeredi.hu,gmail.com,bsbernd.com,gompa.dev,vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[clm@meta.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[meta.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:mid,meta.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 87DF2F681E
X-Rspamd-Action: no action

"Darrick J. Wong" <djwong@kernel.org> wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Provide a means for the fuse server to upload iomappings to the kernel
> and invalidate them.  This is how we enable iomap caching for better
> performance.  This is also required for correct synchronization between
> pagecache writes and writeback.
> 

Hi everyone,

I'm trying out my AI review prompts on a few more trees, and I ran it
on the fuse-iomap-cache branch:

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-cache

This was the latest email lore could find, apologies if I grabbed the wrong one.

Hopefully the review below is useful, please let me know if there are places it
has gone wildly wrong.  I kept the header to make it obvious exactly which
commit I'd run through:

commit 84c726dd312b652c0fd2d4f43d65eefd16bfa901
Author: Darrick J. Wong <djwong@kernel.org>

fuse: enable iomap cache management

This commit provides a means for the fuse server to upload iomappings to
the kernel and invalidate them, enabling iomap caching for better
performance and ensuring correct synchronization between pagecache writes
and writeback.

> diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
> index b56718dd256a6..dcadd66f6ec95 100644
> --- a/fs/fuse/fuse_iomap.c
> +++ b/fs/fuse/fuse_iomap.c

[ ... ]

> +int fuse_iomap_inval(struct fuse_conn *fc,
> +		     const struct fuse_iomap_inval_out *outarg)
> +{
> +	struct inode *inode;
> +	struct fuse_inode *fi;
> +	int ret = 0, ret2 = 0;
> +
> +	if (!fc->iomap)
> +		return -EINVAL;
> +
> +	down_read(&fc->killsb);
> +	inode = fuse_ilookup(fc, outarg->nodeid, NULL);
> +	if (!inode) {
> +		ret = -ESTALE;
> +		goto out_sb;
> +	}
> +
> +	fi = get_fuse_inode(inode);
> +	if (BAD_DATA(fi->orig_ino != outarg->attr_ino)) {
> +		ret = -EINVAL;
> +		goto out_inode;
> +	}
> +
> +	if (fuse_is_bad(inode)) {
> +		ret = -EIO;
> +		goto out_inode;
> +	}
> +
> +	if (!fuse_iomap_inval_validate(inode, outarg->write_offset,
> +				       outarg->write_length)) {
> +		ret = -EFSCORRUPTED;
> +		goto out_inode;
> +	}
> +
> +	if (!fuse_iomap_inval_validate(inode, outarg->read_offset,
> +				       outarg->read_length)) {
> +		ret = -EFSCORRUPTED;
> +		goto out_inode;
> +	}
> +
> +	fuse_iomap_cache_lock(inode);
> +	if (outarg->read_length)
> +		ret2 = fuse_iomap_cache_remove(inode, READ_MAPPING,
> +					       outarg->read_offset,
> +					       outarg->read_length);
> +	if (outarg->write_length)
> +		ret = fuse_iomap_cache_remove(inode, WRITE_MAPPING,
> +					      outarg->write_offset,
> +					      outarg->write_length);
> +	fuse_iomap_cache_unlock(inode);
>                    ^^^^

Can fuse_iomap_cache_lock() dereference a NULL pointer here? Looking at
fuse_iomap_upsert() above, there's a check for fuse_inode_caches_iomaps()
before accessing the cache and allocating if necessary. In fuse_iomap_inval(),
there's no such check before calling fuse_iomap_cache_lock().

fuse_iomap_cache_lock() accesses fi->cache and calls down_write(&ic->ic_lock),
which will crash if fi->cache is NULL. This could happen when a fuse server
sends FUSE_NOTIFY_IOMAP_INVAL for an inode that never had mappings upserted
to it.

Should fuse_iomap_inval() check fuse_inode_caches_iomaps(inode) before
calling fuse_iomap_cache_lock()? If the cache doesn't exist, there's
nothing to invalidate, so returning early (perhaps with 0 or -EINVAL)
would be appropriate.


