Return-Path: <linux-fsdevel+bounces-77387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INBJDEm1lGlbGgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 19:36:57 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6BB14F375
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 19:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 814EB303DF5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 18:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D355B371062;
	Tue, 17 Feb 2026 18:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jivbenFJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417E82D8393;
	Tue, 17 Feb 2026 18:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771353409; cv=none; b=lUhuiCDKDN72PkDSU7YVR7PJ0WO0XnFvUfUGxod0gJg5aneQAk9T7x+D3f7pdq64CeRSQewba9I90X0gYYB5JJqWwzYXKet1NaSN19dZFB6mlL+p40gWBDQL1/sVwTYCPn6q89/7yxpQSnAbtEw5KS/TQgWx5DjI0FiLqyJf5yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771353409; c=relaxed/simple;
	bh=CfvFwN3NlPrXupTbM87FfzPOeVPFXKjeEYdbEM4oTro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIaCxNU4x5/9gTNXv2TcLyypm/hdHhyTfUJDhWcCc3wsGoHRacqN5OmJQSVq6ciJblHoLvFr6rooVXNrtA8f/O/93lmb0Je7TQS+xk7+t0aR4+FrL3Y77JlccYbMq9bq6XqCU9qLmCeyFNluxE1grMwhAPnjnoVxklCIv6JmrJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jivbenFJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HBfUgj1201555;
	Tue, 17 Feb 2026 18:36:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=yKajDEOKb2YbRCBKt7UgZWxuta6aP/
	Ox0M0jTvkoeMk=; b=jivbenFJB5+ir4PKC0a6OR/5c/D3rdoY6bxeXB/2Wnk8M+
	EfooQST/RbjvaTvqlcspoKrwffOVx091kRFdaJxOkWFNQ37WcjGlPLfLXvE553Q4
	l1/OSX6A9zVk8Bfc/SC7/vauxbSxMP6kfrJ5RM7l6GrjXcYpmq+276gOUuH1e4Nn
	jeizff8WGTjdVDMNPDb4ONX1iEv5BFhjylaRpmYx/g4Et0wKYxFJ/d6FozJBFWAW
	ja0u+TmQnFcrprogw0kPUVDQ6Y88qKuO0j/O8TrheGFvEzCqP45c+4U4jsPpOapQ
	gimlESwNqmSGA0nRC46SNBdDP/r09JyMzG1+vECQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcjcsbw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 18:36:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61HFnIOT024414;
	Tue, 17 Feb 2026 18:36:23 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb454642-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 18:36:22 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61HIaLaS53674384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Feb 2026 18:36:21 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 574E620043;
	Tue, 17 Feb 2026 18:36:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E834A20040;
	Tue, 17 Feb 2026 18:36:16 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.222.71])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 17 Feb 2026 18:36:16 +0000 (GMT)
Date: Wed, 18 Feb 2026 00:06:14 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Pankaj Raghav <pankaj.raghav@linux.dev>
Cc: Jan Kara <jack@suse.cz>, linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org,
        Andres Freund <andres@anarazel.de>, djwong@kernel.org,
        john.g.garry@oracle.com, willy@infradead.org, hch@lst.de,
        ritesh.list@gmail.com, Luis Chamberlain <mcgrof@kernel.org>,
        dchinner@redhat.com, Javier Gonzalez <javier.gonz@samsung.com>,
        gost.dev@samsung.com, tytso@mit.edu, p.raghav@samsung.com,
        vi.shah@samsung.com
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Buffered atomic writes
Message-ID: <aZS1HreP3ZTbfJVJ@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <d0c4d95b-8064-4a7e-996d-7ad40eb4976b@linux.dev>
 <aY8n97G_hXzA5MMn@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <w3vwdaygcz3prsxwv43blo4co666mragpdwaxihbirt5stl4vr@agyz4mnaxghj>
 <c29d36eb-0706-4f3c-aaed-de7d9ef74bed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c29d36eb-0706-4f3c-aaed-de7d9ef74bed@linux.dev>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: VqZQkfvPpD088y7s_ZIuXzDZ85l1fGd_
X-Authority-Analysis: v=2.4 cv=Md9hep/f c=1 sm=1 tr=0 ts=6994b528 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=pNaSbsGRAAAA:8
 a=_-3aNh2cLU6TeR9iss4A:9 a=CjuIK1q_8ugA:10 a=cz0TccRYsqG1oLvFGeGV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDE0OCBTYWx0ZWRfX54UuNLAijDPA
 frC4GZlaugcZmhlaUh7PoMQytLIux8dJsBoQQwJ8ABImLjIIR2tCOCZGs4amQEVk53E7y3ZWCJG
 SwpZ/CJfXQYlFI3kS8R6a4KrvXyaK6auyHKCkLZxjV5I/G7iYObcAXn23NINKL9PKSqXoj+Pn7B
 NlyRRr50wFri48nk+WZRGYnmSgCcmctsEM3nQH9o62CGlzoLlIWgWbcBOXRsdMPLBlX/+wUhakC
 7rtaQEZNnMbgaSeHcK14v6Vv3TNj20sr9FCT83RSS5thbB5grbecuSsqHwf0r3MqFw7Md0AVs9T
 3xT7JXTu2Rv7XX82VSWCTwp2hS9Ll1w8yA5g0ydf2Zp6QGWPqvHnNZDZKHWq5gdzXc9wdshWik4
 NfMb8fISeEVpnyFHv0NSeF3WD/vxY1RzDlreEpRkhlVzHPtZG8OHTClFlomRt6HBqZaDHABu2tW
 ANvTybK5GXxCSbABj0Q==
X-Proofpoint-GUID: EAXju9l5Vdzng-kr7mVrOXvFL9mVXBcs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_03,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170148
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,kvack.org,lists.linux-foundation.org,anarazel.de,kernel.org,oracle.com,infradead.org,lst.de,gmail.com,redhat.com,samsung.com,mit.edu];
	TAGGED_FROM(0.00)[bounces-77387-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvmexpress.org:url];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ibm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojaswin@linux.ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	HAS_WP_URI(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 9A6BB14F375
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 02:18:10PM +0100, Pankaj Raghav wrote:
> 
> 
> On 2/16/2026 12:38 PM, Jan Kara wrote:
> > Hi!
> > 
> > On Fri 13-02-26 19:02:39, Ojaswin Mujoo wrote:
> > > Another thing that came up is to consider using write through semantics
> > > for buffered atomic writes, where we are able to transition page to
> > > writeback state immediately after the write and avoid any other users to
> > > modify the data till writeback completes. This might affect performance
> > > since we won't be able to batch similar atomic IOs but maybe
> > > applications like postgres would not mind this too much. If we go with
> > > this approach, we will be able to avoid worrying too much about other
> > > users changing atomic data underneath us.
> > > 
> > > An argument against this however is that it is user's responsibility to
> > > not do non atomic IO over an atomic range and this shall be considered a
> > > userspace usage error. This is similar to how there are ways users can
> > > tear a dio if they perform overlapping writes. [1].
> > 
> > Yes, I was wondering whether the write-through semantics would make sense
> > as well. Intuitively it should make things simpler because you could
> > practially reuse the atomic DIO write path. Only that you'd first copy
> > data into the page cache and issue dio write from those folios. No need for
> > special tracking of which folios actually belong together in atomic write,
> > no need for cluttering standard folio writeback path, in case atomic write
> > cannot happen (e.g. because you cannot allocate appropriately aligned
> > blocks) you get the error back rightaway, ...
> > 
> > Of course this all depends on whether such semantics would be actually
> > useful for users such as PostgreSQL.
> 
> One issue might be the performance, especially if the atomic max unit is in
> the smaller end such as 16k or 32k (which is fairly common). But it will
> avoid the overlapping writes issue and can easily leverage the direct IO
> path.
> 
> But one thing that postgres really cares about is the integrity of a
> database block. So if there is an IO that is a multiple of an atomic write
> unit (one atomic unit encapsulates the whole DB page), it is not a problem
> if tearing happens on the atomic boundaries. This fits very well with what
> NVMe calls Multiple Atomicity Mode (MAM) [1].
> 
> We don't have any semantics for MaM at the moment but that could increase
> the performance as we can do larger IOs but still get the atomic guarantees
> certain applications care about.

Interesting, I think very very early dio implementations did use
something of this sort where (awu_max = 4k) an atomic write of 16k would
result in 4 x 4k atomic writes. 

I don't remember why it was shot down though :D

Regards,
ojaswin

> 
> 
> [1] https://nvmexpress.org/wp-content/uploads/NVM-Express-NVM-Command-Set-Specification-Revision-1.1-2024.08.05-Ratified.pdf
> 

