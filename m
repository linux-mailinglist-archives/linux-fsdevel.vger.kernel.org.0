Return-Path: <linux-fsdevel+bounces-76821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DIeEjPZimnrOAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 08:07:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3579117AA6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 08:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9B2C303982F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 07:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7D632F745;
	Tue, 10 Feb 2026 07:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AL+i7A8l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661C732ED29;
	Tue, 10 Feb 2026 07:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770707175; cv=none; b=T5R55zXrzssUzKQ5QZzp4TveswBIeklr7SuChO97XnRrIajhvaRQeyzPM5OlAIC6wsvPpm7Vc9PyBloHVxh3bB3pltuWicZlJczH3e4Snk5ZrPCv2NK0KXgeKibnMfvZQnsFtB8wj/G/RSBzcoXgTN/yuuCalhmLUGs/m52AFXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770707175; c=relaxed/simple;
	bh=jwsv2/KtgFMkKHil0XDlMSA5/KLwQXAsmOj1m8Km++I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qAZeiOJJUdB0CqfZ3PG7zjksbE7LnBhr7d+o0nKgDu4+nm4MVDnhjrncns6LXbzYTaFBZpQRClPXW3+MHTYi770qRJSCYPt4u+/Qh7cJ10gFPXaVH2KIwxvQqDrmN3YlbEe97c+mARe4IVEqV+cbnUHLIjBAdpTj4TFRl/dqJe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AL+i7A8l; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619KE8FV2412224;
	Tue, 10 Feb 2026 07:05:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=5OjoYUPE3yK/YinjqtBe8xGXMDL85l
	aQJ0o8ZZGfjOg=; b=AL+i7A8lEevLghY0FzytrAi2mjsap3EV2+bmnsd8feFZ45
	aAuv1cpOC6pwKDLZXpbJqN0WVucemhqhBkBmxxFNUkRXPg1Se7IMCTbfh/jRp8hk
	FJImVkZMkQULXC+A1mMNiEro+h+n8sKgMdblRy/r1N6zThzYeqiT+Y86CqUlADpc
	6Tp3U4YeHbwRPj3SfOcUi5YsByMFkhq4l+3U5IpdQck84Q63TfPwUviK2fIUWcfp
	wdv4ikz/nsAiOyZSbyclEX6/hDR7xgjZgIr/3ycY6ZVPfx3NWC5GF3K1Tlbnc6Dp
	+ec8+3SQAcdkF6an0bLJsAzZthAPPPAh3MX9gkMw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696v1004-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 07:05:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61A62IBH019221;
	Tue, 10 Feb 2026 07:05:29 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6hxk03b6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 07:05:29 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61A75RrE47710572
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Feb 2026 07:05:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8770C20043;
	Tue, 10 Feb 2026 07:05:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66CB22004F;
	Tue, 10 Feb 2026 07:05:24 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.158])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 10 Feb 2026 07:05:24 +0000 (GMT)
Date: Tue, 10 Feb 2026 12:35:38 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huawei.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, ritesh.list@gmail.com, hch@infradead.org,
        djwong@kernel.org, yi.zhang@huaweicloud.com, yizhang089@gmail.com,
        libaokun1@huawei.com, yangerkun@huawei.com, yukuai@fnnas.com
Subject: Re: [PATCH -next v2 03/22] ext4: only order data when partially
 block truncating down
Message-ID: <aYrYwhO5LvIYbxWg@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20260203062523.3869120-1-yi.zhang@huawei.com>
 <20260203062523.3869120-4-yi.zhang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203062523.3869120-4-yi.zhang@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: xrnWYPAb_WWWp3nTvsajyB6nsqL1Kt23
X-Proofpoint-ORIG-GUID: cUootUO0_1JFpKkNdOG_TWzKn3Vbv28w
X-Authority-Analysis: v=2.4 cv=JdWxbEKV c=1 sm=1 tr=0 ts=698ad8ba cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=i0EeH86SAAAA:8
 a=1d5E5kGQmFa6-cc4gocA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDA1NSBTYWx0ZWRfX1vZyyCyaXbjb
 RS8b+SiZXoxFvMvfpL+3yZeVQV/zgAN0qb2XjOdZYGw7NvVDQBfDViooBml8UWM1YKOzTzqVGY6
 9h8FQ6uI6CEHVjEuufDrhHF2ZA4VCweDEJjULOCplSGT4cDbzU+Xb2Wcmz+//s+9AHlDvKwZMJP
 op1QkCQVwzSovrsdtci3BomzK4dz11dVdN4PgtOoS4QP/J+88pcEHtt5laYQsgvFFJ3bKTxHUZH
 ScpLd+f6wQXaYohPtsxM+jRI/tSF7qCiX8WldEddO8UOJGsaQ4lZwiUyg0jd1ilvPKhqXyYfRJz
 Pm9UL8ETOHQDA41C8pW+GqUaOZyibs9eZhPUT2FnXof672BWnzwgn2qe1Tqw2lt81ZuxLPHi6Bh
 YcTpJBJRqAgXQF3Nl/eogksStXp94y5uCoPxDi3y/D0IjTyEB60jOKhk/778M4lvYAgOkUDtxQu
 DekylsoWQBlrIef8GKw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1011 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100055
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76821-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,infradead.org,kernel.org,huaweicloud.com,huawei.com,fnnas.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com:mid,huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojaswin@linux.ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: D3579117AA6
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 02:25:03PM +0800, Zhang Yi wrote:
> Currently, __ext4_block_zero_page_range() is called in the following
> four cases to zero out the data in partial blocks:
> 
> 1. Truncate down.
> 2. Truncate up.
> 3. Perform block allocation (e.g., fallocate) or append writes across a
>    range extending beyond the end of the file (EOF).
> 4. Partial block punch hole.
> 
> If the default ordered data mode is used, __ext4_block_zero_page_range()
> will write back the zeroed data to the disk through the order mode after
> zeroing out.
> 
> Among the cases 1,2 and 3 described above, only case 1 actually requires
> this ordered write. Assuming no one intentionally bypasses the file
> system to write directly to the disk. When performing a truncate down
> operation, ensuring that the data beyond the EOF is zeroed out before
> updating i_disksize is sufficient to prevent old data from being exposed
> when the file is later extended. In other words, as long as the on-disk
> data in case 1 can be properly zeroed out, only the data in memory needs
> to be zeroed out in cases 2 and 3, without requiring ordered data.
> 
> Case 4 does not require ordered data because the entire punch hole
> operation does not provide atomicity guarantees. Therefore, it's safe to
> move the ordered data operation from __ext4_block_zero_page_range() to
> ext4_truncate().
> 
> It should be noted that after this change, we can only determine whether
> to perform ordered data operations based on whether the target block has
> been zeroed, rather than on the state of the buffer head. Consequently,
> unnecessary ordered data operations may occur when truncating an
> unwritten dirty block. However, this scenario is relatively rare, so the
> overall impact is minimal.
> 
> This is prepared for the conversion to the iomap infrastructure since it
> doesn't use ordered data mode and requires active writeback, which
> reduces the complexity of the conversion.

Hi Yi,

Took me quite some time to understand what we are doing here, I'll
just add my understanding here to confirm/document :) 

So your argument is that currently all paths that change the i_size take
care of zeroing the (newsize, eof block boundary) before i_size change
is seen by users:
  - dio does it in iomap_dio_bio_iter if IOMAP_UNWRITTEN (true for first allocation)
	- buffered IO/mmap write does it in ext4_da_write_begin() ->
		ext4_block_write_begin() for buffer_new (true for first allocation)
	- falloc doesn't zero the new eof block but it allocates an unwrit
		extent so no stale data issue. When an allocation happens from the
		above 2 methods then we anyways will zero it.
	- truncate down also takes care of this via ext4_truncate() ->
		ext4_block_truncate_page()

Now, parallely there are also codepaths that say grow the i_size but
then also zero the (old_size, block boundary) range before the i_size
commits. This is so that they want to be sure the newly visible range
doesn't expose stale data.
For example:
  - truncate up from 2kb to 8kb will zero (2kb,4kb) via ext4_block_truncate_page()
  - with i_size = 2kb, buffered IO at 6kb would zero 2kb,4kb in ext4_da_write_end()
  - I'm unable to see if/where we do it via dio path.

You originally proposed that we can remove the logic to zeroout
(old_size, block_boundary) in data=ordered fashion, ie we don't need to
trigger the zeroout IO before the i_size change commits, we can just zero the
range in memory because we would have already zeroed them earlier when
we had allocated at old_isize, or truncated down to old_isize.

To this Jan pointed out that although we take care to zeroout (new_size,
block_boundary) its not enough because we could still end up with data
past eof:

1. race of buffered write vs mmap write past eof. i_size = 2kb,
   we write (2kb, 3kb). 
2. The write goes through but we crash before i_size=3kb txn can commit.
   Again we have data past 2kb ie the eof block.

Now, Im still looking into this part but the reason we want to get rid of
this data=ordered IO is so that we don't trigger a writeback due to
journal commit which tries to acquire folio_lock of a folio already
locked by iomap. However we will now try an alternate way to get past
this.

Is my understanding correct?

Regards,
ojaswin

PS: -g auto tests are passing (no regressions) with 64k and 4k bs on
powerpc 64k pagesize box so thats nice :D 

> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  fs/ext4/inode.c | 32 +++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index f856ea015263..20b60abcf777 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4106,19 +4106,10 @@ static int __ext4_block_zero_page_range(handle_t *handle,
>  	folio_zero_range(folio, offset, length);
>  	BUFFER_TRACE(bh, "zeroed end of block");
>  
> -	if (ext4_should_journal_data(inode)) {
> +	if (ext4_should_journal_data(inode))
>  		err = ext4_dirty_journalled_data(handle, bh);
> -	} else {
> +	else
>  		mark_buffer_dirty(bh);
> -		/*
> -		 * Only the written block requires ordered data to prevent
> -		 * exposing stale data.
> -		 */
> -		if (!buffer_unwritten(bh) && !buffer_delay(bh) &&
> -		    ext4_should_order_data(inode))
> -			err = ext4_jbd2_inode_add_write(handle, inode, from,
> -					length);
> -	}
>  	if (!err && did_zero)
>  		*did_zero = true;
>  
> @@ -4578,8 +4569,23 @@ int ext4_truncate(struct inode *inode)
>  		goto out_trace;
>  	}
>  
> -	if (inode->i_size & (inode->i_sb->s_blocksize - 1))
> -		ext4_block_truncate_page(handle, mapping, inode->i_size);
> +	if (inode->i_size & (inode->i_sb->s_blocksize - 1)) {
> +		unsigned int zero_len;
> +
> +		zero_len = ext4_block_truncate_page(handle, mapping,
> +						    inode->i_size);
> +		if (zero_len < 0) {
> +			err = zero_len;
> +			goto out_stop;
> +		}
> +		if (zero_len && !IS_DAX(inode) &&
> +		    ext4_should_order_data(inode)) {
> +			err = ext4_jbd2_inode_add_write(handle, inode,
> +					inode->i_size, zero_len);
> +			if (err)
> +				goto out_stop;
> +		}
> +	}
>  
>  	/*
>  	 * We add the inode to the orphan list, so that if this
> -- 
> 2.52.0
> 

