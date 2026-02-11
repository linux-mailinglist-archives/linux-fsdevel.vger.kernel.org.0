Return-Path: <linux-fsdevel+bounces-76949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4F5/KECfjGmPrgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 16:24:48 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9FC1259B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 16:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AF12830194AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 15:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066362E093B;
	Wed, 11 Feb 2026 15:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oJ4dmcCk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642ED2BDC1C;
	Wed, 11 Feb 2026 15:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770823435; cv=none; b=Xz5t0QG6SEqTX2OHfAWQ9PTLtaZdLF1AOSiWcOmDvQA8jvv5slWqpR7ZhIhxHmTFhRm1Z119gvboJbss9XfzgYPdNDc2WHHdUbC7UKUzL4492zt2cwDrQ2swxrkME8IgUkBPT7OEGjmzEz/swkHdwRdrt8vqFtpGoleBoxbV3LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770823435; c=relaxed/simple;
	bh=bpLwilUnrVqLpzDN9JXpnCm+kQGiMf7IC6BWYBYpApo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCCHT2ENER2h9Y83NKbvLDwKDvxJV3RqIxdW/QUCcQMM7F3/DVZsgH57XvFCVWrXphqdjcba+tGGBarLLh+AtKcP/aUIbuIg6FEb5lzEeLLMYkXUAvwxJVD/uQq1DS/2WbeiEE0QpLsxoYAa1veJOkYIRrGVSnilmnZIEiovIB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oJ4dmcCk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61B0lH6M326349;
	Wed, 11 Feb 2026 15:23:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=K3wFT0pyDB6tkgRotCcA2xtUUvpyT5
	JKzxZZv0esP9g=; b=oJ4dmcCk/6h2uXNmMOSfM2IhVY+Hxq9vvgimWXVYi8+8Ic
	QCfkXwLTUwGM+Oxry7RtywgWb5ml3f9eMuhkHhBqWmWNJSAlPPF9HZS2LS9ni4aU
	bIX3qoe462Zqwo3pbdaN1r2kVdgbf9FDVASaCZeueMlDHKNbptmbUT0CqZDO9JEZ
	7s9NGuLLLmfb9Um/bf7C9ndtveL7M9PbhZtf67bhUF9Tb+63jmTS+ZFXhFso+qAN
	6gsR1DKmcnkd2rNMir+KOsz93lQ3I07dK4AyJ/N5ja7nNxEgm+D9ztGSAYJc+AY/
	ycZ8yYWDhtl216+qnpbCEkqitpLjTowkSj3esLwA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696w9tg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Feb 2026 15:23:09 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61BDUAsl008883;
	Wed, 11 Feb 2026 15:23:07 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6g3yed28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Feb 2026 15:23:07 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61BFN5Bg50921804
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Feb 2026 15:23:06 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7F3A2004B;
	Wed, 11 Feb 2026 15:23:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4A9020040;
	Wed, 11 Feb 2026 15:23:02 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.20.226])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 11 Feb 2026 15:23:02 +0000 (GMT)
Date: Wed, 11 Feb 2026 20:53:00 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yizhang089@gmail.com>
Cc: Zhang Yi <yi.zhang@huawei.com>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        ritesh.list@gmail.com, hch@infradead.org, djwong@kernel.org,
        yi.zhang@huaweicloud.com, libaokun1@huawei.com, yangerkun@huawei.com,
        yukuai@fnnas.com
Subject: Re: [PATCH -next v2 03/22] ext4: only order data when partially
 block truncating down
Message-ID: <aYyetHqxs9leOLFM@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20260203062523.3869120-1-yi.zhang@huawei.com>
 <20260203062523.3869120-4-yi.zhang@huawei.com>
 <aYrYwhO5LvIYbxWg@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <04b0a510-0a97-464f-a6d3-8410fff9243d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04b0a510-0a97-464f-a6d3-8410fff9243d@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=YeCwJgRf c=1 sm=1 tr=0 ts=698c9edd cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=GPuXNhroM0rvTv4RrU0A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: grxl5bsdd3t1dZnRYNG8cnkAXZ7nvdjH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDExNCBTYWx0ZWRfX4X350Jn0a7V+
 YhPmx4nvlp9QqgtfKntXSfbI946LqMnaTW5ENw5ynQzw2buQicRQpgdhq/yVEAkwboVfVj7hP2F
 3lZX85xOz61ujOObRXYKqYFMyknxIoUopel/mxzz4M3z7nObCSreOorYdeABwv9iPfJsStFeztu
 wUMil52miFrFQhZO3I963U+cOmaVdOinHX9jlSWl7Cf9gzZcBT/QZGPGBHo0Hq3YU7hfV3dGjpK
 LQevvZ+lRBQfn3o+0NfKye7WeEHv4lBDbkHOojo07f1onCkWnakEorQK0+yrY4Klq41NxSxXNof
 Ft/XOgQ0FgHwQWsAggpC+cTFmwFslB1hYS9MdgCb9+lRrA8cSzzjaO2G6YOfT42DIw62u1fzoNm
 83ufasyE0BjBVmMg+LjJgHBQwyAp9P5rlZILPQti9meEvev2qTsSldMFY+W/PAbXuRXtwOgoKAw
 DioXUxqZWfkpe3Yxslw==
X-Proofpoint-ORIG-GUID: nOheeMSnXN05aSEBeJYol5xyTh0dZ-Yu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-11_01,2026-02-11_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602110114
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76949-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[huawei.com,vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,infradead.org,kernel.org,huaweicloud.com,fnnas.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojaswin@linux.ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: CE9FC1259B4
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 11:57:03PM +0800, Zhang Yi wrote:
> On 2/10/2026 3:05 PM, Ojaswin Mujoo wrote:
> > On Tue, Feb 03, 2026 at 02:25:03PM +0800, Zhang Yi wrote:
> > > Currently, __ext4_block_zero_page_range() is called in the following
> > > four cases to zero out the data in partial blocks:
> > > 
> > > 1. Truncate down.
> > > 2. Truncate up.
> > > 3. Perform block allocation (e.g., fallocate) or append writes across a
> > >     range extending beyond the end of the file (EOF).
> > > 4. Partial block punch hole.
> > > 
> > > If the default ordered data mode is used, __ext4_block_zero_page_range()
> > > will write back the zeroed data to the disk through the order mode after
> > > zeroing out.
> > > 
> > > Among the cases 1,2 and 3 described above, only case 1 actually requires
> > > this ordered write. Assuming no one intentionally bypasses the file
> > > system to write directly to the disk. When performing a truncate down
> > > operation, ensuring that the data beyond the EOF is zeroed out before
> > > updating i_disksize is sufficient to prevent old data from being exposed
> > > when the file is later extended. In other words, as long as the on-disk
> > > data in case 1 can be properly zeroed out, only the data in memory needs
> > > to be zeroed out in cases 2 and 3, without requiring ordered data.
> > > 
> > > Case 4 does not require ordered data because the entire punch hole
> > > operation does not provide atomicity guarantees. Therefore, it's safe to
> > > move the ordered data operation from __ext4_block_zero_page_range() to
> > > ext4_truncate().
> > > 
> > > It should be noted that after this change, we can only determine whether
> > > to perform ordered data operations based on whether the target block has
> > > been zeroed, rather than on the state of the buffer head. Consequently,
> > > unnecessary ordered data operations may occur when truncating an
> > > unwritten dirty block. However, this scenario is relatively rare, so the
> > > overall impact is minimal.
> > > 
> > > This is prepared for the conversion to the iomap infrastructure since it
> > > doesn't use ordered data mode and requires active writeback, which
> > > reduces the complexity of the conversion.
> > 
> > Hi Yi,
> > 
> > Took me quite some time to understand what we are doing here, I'll
> > just add my understanding here to confirm/document :)
> 
> Hi, Ojaswin!
> 
> Thank you for review and test this series.
> 
> > 
> > So your argument is that currently all paths that change the i_size take
> > care of zeroing the (newsize, eof block boundary) before i_size change
> > is seen by users:
> >    - dio does it in iomap_dio_bio_iter if IOMAP_UNWRITTEN (true for first allocation)
> > 	- buffered IO/mmap write does it in ext4_da_write_begin() ->
> > 		ext4_block_write_begin() for buffer_new (true for first allocation)
> > 	- falloc doesn't zero the new eof block but it allocates an unwrit
> > 		extent so no stale data issue. When an allocation happens from the
> > 		above 2 methods then we anyways will zero it.
> 
> These two zeroing operations mentioned above are mainly used to initialize
> newly allocated blocks, which is not the main focus of this discussion.
> 
> The focus of this discussion is how to clear the portions of allocated
> blocks that extend beyond the EOF.
> 
> > 	- truncate down also takes care of this via ext4_truncate() ->
> > 		ext4_block_truncate_page()
> > 
> > Now, parallely there are also codepaths that say grow the i_size but
> > then also zero the (old_size, block boundary) range before the i_size
> > commits. This is so that they want to be sure the newly visible range
> > doesn't expose stale data.
> > For example:
> >    - truncate up from 2kb to 8kb will zero (2kb,4kb) via ext4_block_truncate_page()
> >    - with i_size = 2kb, buffered IO at 6kb would zero 2kb,4kb in ext4_da_write_end()
> 
> Yes, you are right.
> 
> >    - I'm unable to see if/where we do it via dio path.
> 
> I don't see it too, so I think this is also a problem.
> 
> > 
> > You originally proposed that we can remove the logic to zeroout
> > (old_size, block_boundary) in data=ordered fashion, ie we don't need to
> > trigger the zeroout IO before the i_size change commits, we can just zero the
> > range in memory because we would have already zeroed them earlier when
> > we had allocated at old_isize, or truncated down to old_isize.
> 
> Yes.
> 
> > 
> > To this Jan pointed out that although we take care to zeroout (new_size,
> > block_boundary) its not enough because we could still end up with data
> > past eof:
> > 
> > 1. race of buffered write vs mmap write past eof. i_size = 2kb,
> >     we write (2kb, 3kb).
> > 2. The write goes through but we crash before i_size=3kb txn can commit.
> >     Again we have data past 2kb ie the eof block.
> > 
> 
> Yes.
> 
> > Now, Im still looking into this part but the reason we want to get rid of
> > this data=ordered IO is so that we don't trigger a writeback due to
> > journal commit which tries to acquire folio_lock of a folio already
> > locked by iomap.
> 
> Yes, and iomap will start a new transaction under the folio lock, which may
> also wait the current committing transaction to finish.

Hi Yi,

Ahh okay got it, thanks for confirming.

Regards,
ojaswin

> 
> > However we will now try an alternate way to get past
> > this.
> > 
> > Is my understanding correct?
> 
> Yes.
> 
> Cheers,
> Yi.
> 
> > 
> > Regards,
> > ojaswin
> > 

