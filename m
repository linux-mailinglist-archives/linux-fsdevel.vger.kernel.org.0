Return-Path: <linux-fsdevel+bounces-77388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFvTNTK2lGlbGgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 19:40:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7607014F447
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 19:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 950833013786
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 18:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B841D374165;
	Tue, 17 Feb 2026 18:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CkHY1h8Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498EA264612;
	Tue, 17 Feb 2026 18:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771353640; cv=none; b=awcutaK9sGAvZ4c+HkZ9gbOH8H0kUW22uoytznGQw5BdacONaJ5oXBZ0iRQOMLTG5yK7GR4XlOOmVMvOn+kuo3huqUN9SOROJpMSlRVIWqx4ufSB8e00+y2AUsjJbZ/Nr8srJNPCVjywoEzby7a5whzXXdO/3NrSRfX+PlRkVIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771353640; c=relaxed/simple;
	bh=BJJXhLsNMFzOT9Ij8EebrcJxW2Zehz2nHGrg3dy7hG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HON9erI36J46Hbxi5fyaqrWqaz+kzdPOkwmqU9KLWmwfiBocMmg73H5hSCombzbQ/aLElkpY7W9pecUEZXS3e2qojKfQjRKigQ4DKPgVSpugfHhLuVEe0RwZt12vxfANRowS+Ppj3403by079B4XWMpJRLgUq5UbR2qFoack88c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CkHY1h8Q; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61H8B8Sp3203603;
	Tue, 17 Feb 2026 18:39:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=TxcPZIGgtQS7YepVQ7fod752PX/TIN
	8xLiQyzMj3Y0E=; b=CkHY1h8QAiC3sEcpX59flMQ3EZBEFAjoRoG17x8jHpwJyP
	PA5i38Js2QIXWMhCUFqBPjEAvCnqqi0V5SfmXAD132QHgpBTC1TDF4qyc2a8HAHP
	868OerukpnhyELmdqZxBhC5g+hmoVN4/mojmuvUFpS1gsZxxgPDuE+C3+BKfOCPQ
	H1xyIYDuWIDHJwANyIqoOEndIJxrO4hOW1PCdyEQzdMsrTmrmm54NakXlCSFc2jP
	hgxy6Z/0jr5SCdFeXN8Bu7s02BKcB59apdJ2hZ+AdtiStUA2NQLzTH47MGVuoplw
	4wocVxh78UZHdyLudseznRPGXEvu+bczj0vdp3yg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6unn9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 18:39:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61HFrwlK017834;
	Tue, 17 Feb 2026 18:39:55 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb28c6h6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 18:39:55 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61HIdrgs37355862
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Feb 2026 18:39:53 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6915320043;
	Tue, 17 Feb 2026 18:39:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 061E920040;
	Tue, 17 Feb 2026 18:39:49 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.222.71])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 17 Feb 2026 18:39:48 +0000 (GMT)
Date: Wed, 18 Feb 2026 00:09:46 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Jan Kara <jack@suse.cz>
Cc: Pankaj Raghav <pankaj.raghav@linux.dev>, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        lsf-pc@lists.linux-foundation.org, Andres Freund <andres@anarazel.de>,
        djwong@kernel.org, john.g.garry@oracle.com, willy@infradead.org,
        hch@lst.de, ritesh.list@gmail.com,
        Luis Chamberlain <mcgrof@kernel.org>, dchinner@redhat.com,
        Javier Gonzalez <javier.gonz@samsung.com>, gost.dev@samsung.com,
        tytso@mit.edu, p.raghav@samsung.com, vi.shah@samsung.com
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Buffered atomic writes
Message-ID: <aZS18m1eIxjDmyBa@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <d0c4d95b-8064-4a7e-996d-7ad40eb4976b@linux.dev>
 <aY8n97G_hXzA5MMn@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <w3vwdaygcz3prsxwv43blo4co666mragpdwaxihbirt5stl4vr@agyz4mnaxghj>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w3vwdaygcz3prsxwv43blo4co666mragpdwaxihbirt5stl4vr@agyz4mnaxghj>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E+/AZKdl c=1 sm=1 tr=0 ts=6994b5fd cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=iox4zFpeAAAA:8
 a=aslz9TACT5FPTi4A7ZoA:9 a=CjuIK1q_8ugA:10 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDE1MiBTYWx0ZWRfX0d3Ip7SDhdjY
 P4P0GIYGgiIwZqwmsi57ko1pjuhZg1n0FAkYp3xjjEYxnfqUIf/B22MnXqUIAUpRXtmpJVwX38G
 XNZ7XaaVOP2SMzD1qbQJ9hE+s/Lf/x4+xJMSspxy+YxbEppOeacCJImyLUdotaJnQo8tKTfpq1w
 WSnBetbUb4/VpKw5WK+zp1dk+czu5E2na0cQLzeUPyCJvgdrDA3x92nAIxRVK9vfzhI2AJ/KSdY
 DT8ZgamtKvIlVsT5ELGB1s9hwUcaW+z6OpbPJyXM3rUjLmP7sjDqhE3+Cul6KU0s0/EcVWDGE3k
 Q+WIUFtMja+w4TB45N9zcEmQolg8EwrkuL58OjlWCprWqGMi5PQMPX4M3WaRCvC4smHpRQo2Fs6
 iuj2U36fawt/kEnKxlf+vEjXyWL1T8zWPwBd8vYXOrTMFdO5EBSh8RltlYV2sphRkimkU0CYdOb
 hg6sUWjH9c9CB8cIC4g==
X-Proofpoint-ORIG-GUID: l1F3a8vSNpswM__jTjETDxGwpBHcWToV
X-Proofpoint-GUID: dRTLfNMeKCgs-tbblFl1C_wpdeX_aTeh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_03,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170152
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77388-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,vger.kernel.org,kvack.org,lists.linux-foundation.org,anarazel.de,kernel.org,oracle.com,infradead.org,lst.de,gmail.com,redhat.com,samsung.com,mit.edu];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com:mid];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojaswin@linux.ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 7607014F447
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 12:38:59PM +0100, Jan Kara wrote:
> Hi!
> 
> On Fri 13-02-26 19:02:39, Ojaswin Mujoo wrote:
> > Another thing that came up is to consider using write through semantics 
> > for buffered atomic writes, where we are able to transition page to
> > writeback state immediately after the write and avoid any other users to
> > modify the data till writeback completes. This might affect performance
> > since we won't be able to batch similar atomic IOs but maybe
> > applications like postgres would not mind this too much. If we go with
> > this approach, we will be able to avoid worrying too much about other
> > users changing atomic data underneath us. 
> > 
> > An argument against this however is that it is user's responsibility to
> > not do non atomic IO over an atomic range and this shall be considered a
> > userspace usage error. This is similar to how there are ways users can
> > tear a dio if they perform overlapping writes. [1]. 
> 
> Yes, I was wondering whether the write-through semantics would make sense
> as well. Intuitively it should make things simpler because you could
> practially reuse the atomic DIO write path. Only that you'd first copy
> data into the page cache and issue dio write from those folios. No need for
> special tracking of which folios actually belong together in atomic write,
> no need for cluttering standard folio writeback path, in case atomic write
> cannot happen (e.g. because you cannot allocate appropriately aligned
> blocks) you get the error back rightaway, ...

This is an interesting idea Jan and also saves a lot of tracking of
atomic extents etc.

I'm unsure how much of a performance impact it'd have though but I'll
look into this

Regards,
ojaswin

> 
> Of course this all depends on whether such semantics would be actually
> useful for users such as PostgreSQL.
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

