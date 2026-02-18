Return-Path: <linux-fsdevel+bounces-77539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCj3OfJnlWk/QgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 08:19:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 966E11539C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 08:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0658D300988A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 07:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01412F9D9A;
	Wed, 18 Feb 2026 07:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vXOVfstn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44C1304BDA
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 07:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771399150; cv=none; b=IkLjH/AAScER+Z3aH+4T/9/eNo0dm8OygvCeSckTi8qaoylahf0w3VR4otRiP++APekZ/Lf0J+EKktgIVEihRg8La51EdEPaOMdf8FTMVKL3iMnr+yDQQTJ5/AFMuqdmgd6QUPKtYhGqdgHFtloKB4typkPpLK+d6GOmiCJocfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771399150; c=relaxed/simple;
	bh=dHCoNWajzoo+lystlDrBYqM5KIVoUr9HUSPQSB3VgDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=kdARaRy9U1bj1on9necuxr62jJaCr0ajM6QJt4LI0nb/9aAhIK5cAcjJpSmSL+LDhEw33OXeUc2ggpM2TqAng6HmcsUjKOfGBIoOYFVQ52iB5amPvnfFxIGXNdZp6HXr+DAG/d7jCc2UNLBm4Zgud+XTD8A1PsUS/U6Z0pwK1Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=vXOVfstn; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260218071859epoutp013780f2500a4f6b0cba806bee5b27acb5~VRiG4NS0b1444514445epoutp01U
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 07:18:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260218071859epoutp013780f2500a4f6b0cba806bee5b27acb5~VRiG4NS0b1444514445epoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1771399139;
	bh=9luwsJeK912R/lFXrfPaMjLOsC/mXZ/L4LYvoHi7d4g=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=vXOVfstn+6eSuAkXNMv+4oTe8pmjtbQQD+CtFAIoB2yDhxf7R074nARVwLk4FO/eC
	 h3p2TTKM6zaObEG/o126N3DYcl2dRvX/SqmUwrESElFlYsRhoSaN8RUVNIogBIDnU7
	 YEuqhSxCbu8w7EO4azIiC93hQUQYXCVnwYM3noeo=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20260218071858epcas5p2674ada589c47791eaafa35673ab9a10b~VRiGap0ZP1431814318epcas5p2d;
	Wed, 18 Feb 2026 07:18:58 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.89]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4fG7D16Pzkz6B9mC; Wed, 18 Feb
	2026 07:18:57 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20260218071857epcas5p2d424ce4ac7f566e2e998614a58b7dee9~VRiFbPcH01431814318epcas5p2b;
	Wed, 18 Feb 2026 07:18:57 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260218071856epsmtip1a92b55b6ba15a1103d43583b611510c3~VRiEFzryN1246212462epsmtip1D;
	Wed, 18 Feb 2026 07:18:55 +0000 (GMT)
Message-ID: <4ac9befb-e99b-4e7a-9b04-aec6da3b837a@samsung.com>
Date: Wed, 18 Feb 2026 12:48:55 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] fs: add write-stream management file_operations
To: Christian Brauner <brauner@kernel.org>
Cc: hch@lst.de, jack@suse.cz, djwong@kernel.org, axboe@kernel.dk,
	kbusch@kernel.org, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20260217-idealerweise-geheuer-ee86894f4792@brauner>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260218071857epcas5p2d424ce4ac7f566e2e998614a58b7dee9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260216053017epcas5p2d6492dd8c33c6d2453b15d79819d97eb
References: <20260216052540.217920-1-joshi.k@samsung.com>
	<CGME20260216053017epcas5p2d6492dd8c33c6d2453b15d79819d97eb@epcas5p2.samsung.com>
	<20260216052540.217920-2-joshi.k@samsung.com>
	<20260217-idealerweise-geheuer-ee86894f4792@brauner>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	TAGGED_FROM(0.00)[bounces-77539-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:mid,samsung.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshi.k@samsung.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 966E11539C0
X-Rspamd-Action: no action

On 2/17/2026 2:02 PM, Christian Brauner wrote:
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index 2e4d1e8b0e71..ff9aa391eda7 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -1967,6 +1967,12 @@ struct file_operations {
>>   	int (*uring_cmd_iopoll)(struct io_uring_cmd *, struct io_comp_batch *,
>>   				unsigned int poll_flags);
>>   	int (*mmap_prepare)(struct vm_area_desc *);
>> +	/* To fetch number of streams that are available for a file */
>> +	int (*get_max_write_streams)(struct file *);
>> +	/* To set write stream on a file */
>> +	int (*set_write_stream)(struct file *, unsigned long);
>> +	/* To query the write stream on a file */
>> +	int (*get_write_stream)(struct file *);
> Let's not waste three new file operations for this thing. Either make it
> VFS level ioctl() commands or add support for it into file_getattr() and
> file_setattr().

In hindsight, I should have added a single 'multiplexed' file operation.
But can move to vfs level ioctl instead. Will this [1] be reasonable?

[1]
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -337,6 +337,20 @@ struct file_attr {
  /* Get logical block metadata capability details */
  #define FS_IOC_GETLBMD_CAP             _IOWR(0x15, 2, struct 
logical_block_metadata_cap)

+/* Structure for FS_IOC_WRITE_STREAM */
+struct fs_write_stream {
+       __u32 op_flags; /* IN: operation flags; GET_MAX|GET|SET */
+       __u32 stream_id; /* IN/OUT: stream value to assign/query; for 
SET/GET */
+       __u32 max_streams; /* OUT: max streams supported by file; for 
GET_MAX */
+       __u32 reserved;
+};
+/* Operation flags */
+#define FS_WRITE_STREAM_OP_GET_MAX     (1 << 0)
+#define FS_WRITE_STREAM_OP_GET         (1 << 1)
+#define FS_WRITE_STREAM_OP_SET         (1 << 2)
+
+#define FS_IOC_WRITE_STREAM            _IOWR('f', 21, struct 
fs_write_stream)
+








