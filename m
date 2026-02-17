Return-Path: <linux-fsdevel+bounces-77385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBHDF1yzlGlbGgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 19:28:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E67F214F219
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 19:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3AF143014FC9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 18:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADCC372B35;
	Tue, 17 Feb 2026 18:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WWwMhwSY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AA3293C4E;
	Tue, 17 Feb 2026 18:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771352921; cv=none; b=VkBrPd2IDeaqt7dOFC3qQLj6D+y7RlZaXI73/A1hJ5nEs1yibAfFrIhhnTzyVS+lH5ySyKf0YyKHpVC8/cpKcrAHcjx6FtAuqMBhilRXEVo5fXf4fvuJ9DOfGLXTxeM3t137ZEyQcPpBmcMzLv7k47fYKXpm7rSZc8y9EuUTorU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771352921; c=relaxed/simple;
	bh=Rbi04vZTViZA6P4twkWlxwL4FQ93wsw0rCqBLj86fH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ac/7Kvs7Je6KKIt8Y/FjeN1nXRJZk6QUSUKZPehMjxdTejYJrbIQprbUP572iQgkYkOlgosNE1+wOaaynWiy+Wa8oYk2JvKZnKvDycuty1edRqqCEkSRNCAJJGd2kD3CZLOHIcN2hUO+XUaI6o+XmkzalqHY8dVI9nc5U09Cf4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WWwMhwSY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61H8BNEe3393511;
	Tue, 17 Feb 2026 18:28:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=fSi7OI756hAO1rTwq0fgqj1clo9Anz
	bLGnISuhugxpU=; b=WWwMhwSYGGdxUjpDCNtmeF5D/yKdBHxGHC7lkf4NbQ9O9v
	OFtP6HHILcgVKvWtK89StO3ehzWkBq8v3XvoaI61lG5k+yYTix9pO6Oy0UI9sWFc
	2oTVmOMmubSy0LAXl9OOaWdzjE5ryDdTw6edhB0ca5l4mkk0q97X+L1Zv8ALEGKo
	4qkuNdvAi/MVILYgC9JCg0EX5VxtCPonriGX6BmM6O83ZIBxZoLWc1VFMeKfmrrm
	x2aXDX3ilT6yImPtBqXD3TMzTlB46OkI4YhhIjnGeL71DitVCDd+QYSgrlQCwFG5
	PJlpE9LS6FzWux44NpVYi1guKVzKugBo4EfDEUFw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6rwk56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 18:27:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61HFvcTd001391;
	Tue, 17 Feb 2026 18:27:58 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb2bc4p3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 18:27:58 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61HIRvOi56361300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Feb 2026 18:27:57 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F72B20040;
	Tue, 17 Feb 2026 18:27:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D561120043;
	Tue, 17 Feb 2026 18:27:52 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.222.71])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 17 Feb 2026 18:27:52 +0000 (GMT)
Date: Tue, 17 Feb 2026 23:57:50 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Andres Freund <andres@anarazel.de>
Cc: Jan Kara <jack@suse.cz>, Pankaj Raghav <pankaj.raghav@linux.dev>,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org,
        djwong@kernel.org, john.g.garry@oracle.com, willy@infradead.org,
        hch@lst.de, ritesh.list@gmail.com,
        Luis Chamberlain <mcgrof@kernel.org>, dchinner@redhat.com,
        Javier Gonzalez <javier.gonz@samsung.com>, gost.dev@samsung.com,
        tytso@mit.edu, p.raghav@samsung.com, vi.shah@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC] Buffered atomic writes
Message-ID: <aZSzJs3WIuV4SQJp@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <d0c4d95b-8064-4a7e-996d-7ad40eb4976b@linux.dev>
 <aY8n97G_hXzA5MMn@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <7cf3f249-453d-423a-91d1-dfb45c474b78@linux.dev>
 <zzvybbfy6bcxnkt4cfzruhdyy6jsvnuvtjkebdeqwkm6nfpgij@dlps7ucza22s>
 <wkczfczlmstoywbmgfrxzm6ko4frjsu65kvpwquzu7obrjcd3f@6gs5nsfivc6v>
 <2planlrvjqicgpparsdhxipfdoawtzq3tedql72hoff4pdet6t@btxbx6cpoyc6>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2planlrvjqicgpparsdhxipfdoawtzq3tedql72hoff4pdet6t@btxbx6cpoyc6>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=dvvWylg4 c=1 sm=1 tr=0 ts=6994b330 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=leAHCTjhAAAA:8
 a=lWd1w2A5-Lu5v-iIvCYA:9 a=QRzjZtwMIBQA:10 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: evL--lIA6exoNcwaW46-B82XRsHUNBl0
X-Proofpoint-ORIG-GUID: Eg6clXTUfFP1FOnsSB25_pGxdo3Sb38G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDE0OCBTYWx0ZWRfX3JyRUqCz44CC
 I/32EE+ypynDEkxG6x8GC2u8Unb0p4+S1D8fXE+Tsmjap0GT6YnQvxJ1iB4pTaoOS/NMVeA2Ovq
 UkLz5c7rlIcNvg3G/cie1dyDq1NHIZT9orMDooV4JfvAKg/CfnDvUIFMo3AU1dJy7k66Ddgh4Nl
 E7IGMQcq6/QqniEma5Pl96oTZIh3UZ8aAVdCriB1JZcck9fLmTmOfKzectr5ByEFFXO5CAXZzna
 3bRpPZBFTXMY9qbZiLhfZ1bET9xhyEohBGpCP2SHzWyHnX74fFmNd79m9YWBYkP0dXaK+kI5ENS
 TQ2akylM62hW6ziLdc0C1RcBWDFp0wJicHYSNCdu2t4CAWdGAqsE1QEbdjdAhyRC711vLLHBxw8
 XPPrOaoAoQNnUpSOtao7wKEoBbbeYPRhr3cz+g4h5Yy/MLjlmSkF+EWFU9z5buRhMRT395I++Hg
 6y0M7XwFL3YUoxhM4/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_03,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602170148
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77385-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,linux.dev,vger.kernel.org,kvack.org,lists.linux-foundation.org,kernel.org,oracle.com,infradead.org,lst.de,gmail.com,redhat.com,samsung.com,mit.edu];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com:mid];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojaswin@linux.ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: E67F214F219
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 11:13:07AM -0500, Andres Freund wrote:
> Hi,
> 
> On 2026-02-17 13:06:04 +0100, Jan Kara wrote:
> > On Mon 16-02-26 10:45:40, Andres Freund wrote:
> > > (*) As it turns out, it often seems to improves write throughput as well, if
> > > writeback is triggered by memory pressure instead of SYNC_FILE_RANGE_WRITE,
> > > linux seems to often trigger a lot more small random IO.
> > >
> > > > So immediately writing them might be ok as long as we don't remove those
> > > > pages from the page cache like we do in RWF_UNCACHED.
> > >
> > > Yes, it might.  I actually often have wished for something like a
> > > RWF_WRITEBACK flag...
> >
> > I'd call it RWF_WRITETHROUGH but otherwise it makes sense.
> 
> Heh, that makes sense. I think that's what I actually was thinking of.
> 
> 
> > > > > An argument against this however is that it is user's responsibility to
> > > > > not do non atomic IO over an atomic range and this shall be considered a
> > > > > userspace usage error. This is similar to how there are ways users can
> > > > > tear a dio if they perform overlapping writes. [1].
> > >
> > > Hm, the scope of the prohibition here is not clear to me. Would it just
> > > be forbidden to do:
> > >
> > > P1: start pwritev(fd, [blocks 1-10], RWF_ATOMIC)
> > > P2: pwrite(fd, [any block in 1-10]), non-atomically
> > > P1: complete pwritev(fd, ...)
> > >
> > > or is it also forbidden to do:
> > >
> > > P1: pwritev(fd, [blocks 1-10], RWF_ATOMIC) start & completes
> > > Kernel: starts writeback but doesn't complete it
> > > P1: pwrite(fd, [any block in 1-10]), non-atomically
> > > Kernel: completes writeback
> > >
> > > The former is not at all an issue for postgres' use case, the pages in
> > > our buffer pool that are undergoing IO are locked, preventing additional
> > > IO (be it reads or writes) to those blocks.
> > >
> > > The latter would be a problem, since userspace wouldn't even know that
> > > here is still "atomic writeback" going on, afaict the only way we could
> > > avoid it would be to issue an f[data]sync(), which likely would be
> > > prohibitively expensive.
> >
> > It somewhat depends on what outcome you expect in terms of crash safety :)
> > Unless we are careful, the RWF_ATOMIC write in your latter example can end
> > up writing some bits of the data from the second write because the second
> > write may be copying data to the pages as we issue DMA from them to the
> > device.
> 
> Hm. It's somewhat painful to not know when we can write in what mode again -
> with DIO that's not an issue. I guess we could use
> sync_file_range(SYNC_FILE_RANGE_WAIT_BEFORE) if we really needed to know?
> Although the semantics of the SFR flags aren't particularly clear, so maybe
> not?
> 
> 
> > I expect this isn't really acceptable because if you crash before
> > the second write fully makes it to the disk, you will have inconsistent
> > data.
> 

> The scenarios that I can think that would lead us to doing something like
> this, are when we are overwriting data without regard for the prior contents,
> e.g:
> 
> An already partially filled page is filled with more rows, we write that page
> out, then all the rows are deleted, and we re-fill the page with new content
> from scratch. Write it out again.  With our existing logic we treat the second
> write differently, because the entire contents of the page will be in the
> journal, as there is no prior content that we care about.

Hi Andres,

From my mental model and very high level understanding of Postgres' WAL
model [1] I am under the impression that for moving from full page
writes to RWF_ATOMIC, we would need to ensure that the **disk** write IO
of any data buffer should go in an untorn fashion.

Now, coming to your example, IIUC here we can actually tolerate to do
the 2nd write above non atomically because it is already a sort of full
page write in the journal.

So lets say if we do something like:

0. Buffer has some initial value on disk
1. Write new rows into buffer
2. Write the buffer as RWF_ATOMIC
3. Overwrite the complete buffer which will journal all the contents
4. Write the buffer as non RWF_ATOMIC
5. Crash

I think it is still possible to satisfy my assumption of **disk** IO
being untorn. Example, here we can have an RWF_ATOMIC implementation
where the data on disk after crash could either be in initial state 0.
or be the new value after 4. This is not strictly the old or new
semantic but still ensures the data is consistent. 

My naive understanding says that as long as disk has consistent/untorn
data, like above, we can recover via the journal. In this case the
kernel implementation should be able to tolerate mixing of atomic and
non atomic writes, but again I might be wrong here.

However, if the above guarantees are not enough and actually care about
true old or new semantic, we would need something like RWF_WRITETHROUGH
to ensure we get truely old or new.


[1] https://www.interdb.jp/pg/pgsql09/01.html


> 
> A second scenario in which we might not use RWF_ATOMIC, if we carry today's
> logic forward, is if a newly created relation is bulk loaded in the same
> transaction that created the relation. If a crash were to happen while that
> bulk load is ongoing, we don't care about the contents of the file(s), as it
> will never be visible to anyone after crash recovery.  In this case we won't
> have prio RWF_ATOMIC writes - but we could have the opposite, i.e. an
> RWF_ATOMIC write while there already is non-RWF_ATOMIC dirty data in the page
> cache. Would that be an issue?

I think this is same discussion as above.

> 
> 
> It's possible we should just always use RWF_ATOMIC, even in the cases where
> it's not needed from our side, to avoid potential performance penalties and
> "undefined behaviour".  I guess that will really depend on the performance
> penalty that RWF_ATOMIC will carry and whether multiple-atomicity-mode will
> eventually be supported (as doing small writes during bulk loading is quite
> expensive).
> 
> 
> Greetings,
> 
> Andres Freund

