Return-Path: <linux-fsdevel+bounces-77571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IC4GbW2lWk/UQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 13:55:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C02FE15672F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 13:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A01043012C68
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 12:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3CA31D74C;
	Wed, 18 Feb 2026 12:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EWdE9Pc+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C5A2D6E76;
	Wed, 18 Feb 2026 12:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771419309; cv=none; b=RdE3y+qMa9OJiCpIFcvphmUYR0R+4P/SmO/uggzBaF0nTvekC/WOYdvgWBDs/lNZdpbCc2icvXmYZLaadv2MKnmJBZiuvlSKTWyRUGzar6NDifKZOi2YhmXBEVLlkvyBy9TrpnxdNAkZaqgIZgrmjtTfhCL+b3npkeus5Dpefx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771419309; c=relaxed/simple;
	bh=dbqw6kTwA+NdAUBcQMVyNOpTUDTOeMi07iknLsGEZ+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEuwM6h/9gNSo01gE5yeB5RCAaZntrklJ5Y1hSs/a+UQNkfHV+AIoWDhye0PUnnboXSQfGxUWYKo2MtFxjnsXfNS3YLmSIG4GjNX1DwPZT+GprVC6b25gb6MRbP3VMz4JMycuxsc4NJLNvY3G4nFprGL8ZqeVAlShUTLuPfR8jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EWdE9Pc+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61I9KWwC3661553;
	Wed, 18 Feb 2026 12:54:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=BlA1AbMzOeTmhaj5e99ZkJ4aaV0Ydz
	pz7qXESwhzBw0=; b=EWdE9Pc+rdxxTC8NAoOgznIV/LjA1IVskBFKXQuVm26iIA
	IHPQ/mZhu82rmbL+PHKciaRpKm2FC20POFYFYT/pCwJ4V7U+qmTBOzPn5LwKwyAK
	nLdlgu264oeKZ7dbqjjG7snnTXAM4Wnz7L8guKvTQvP2elc34nPaRb72ffZtk1/e
	VusELSQfV23whrJXiGBjhzaxjzy7+zKb0h5QPe3ivi4DIfDQGAQVp1jky5TrccsT
	eu4wuYPkzjxcq6Hkdr1aPRIi/XfWoyTxA+1/pruuQarggSnOMgy/w4SnNnNqhxnc
	SCI861u8a1CwDBde0udKshfqUaiWEX847yo5oweQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcjg4tq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 12:54:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61I8e4Zu001419;
	Wed, 18 Feb 2026 12:54:34 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb2bftac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 12:54:34 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61ICsWv553674438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Feb 2026 12:54:32 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E7CA20040;
	Wed, 18 Feb 2026 12:54:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD1A720043;
	Wed, 18 Feb 2026 12:54:27 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.27.220])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 18 Feb 2026 12:54:27 +0000 (GMT)
Date: Wed, 18 Feb 2026 18:24:25 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Dave Chinner <dgc@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Pankaj Raghav <pankaj.raghav@linux.dev>,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org,
        Andres Freund <andres@anarazel.de>, djwong@kernel.org,
        john.g.garry@oracle.com, willy@infradead.org, hch@lst.de,
        ritesh.list@gmail.com, Luis Chamberlain <mcgrof@kernel.org>,
        dchinner@redhat.com, Javier Gonzalez <javier.gonz@samsung.com>,
        gost.dev@samsung.com, tytso@mit.edu, p.raghav@samsung.com,
        vi.shah@samsung.com
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Buffered atomic writes
Message-ID: <aZW2geKlQESzxXzV@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <d0c4d95b-8064-4a7e-996d-7ad40eb4976b@linux.dev>
 <aY8n97G_hXzA5MMn@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <w3vwdaygcz3prsxwv43blo4co666mragpdwaxihbirt5stl4vr@agyz4mnaxghj>
 <aZS18m1eIxjDmyBa@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <aZUHHvNl6cQr-uwd@dread>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZUHHvNl6cQr-uwd@dread>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: -fnHeqLWXVntKC1VPi5-hEcRrUMZ1eZU
X-Authority-Analysis: v=2.4 cv=Md9hep/f c=1 sm=1 tr=0 ts=6995b68b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=mABpun1c11mrw8mCog8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDExMCBTYWx0ZWRfXzmhqwlV11zuf
 HnmAQnAhefdBCrARMdXeJQSd44KB601SjyK/JR0C6gSI9FuU434jMjIZRB9peArV6ksn6dB2Tsi
 +CKCwHjSLZHhmIeidEXc/OuKSEdQiwBeO3dceRy2JWC1wkS4RfklibBsSwHV0g4sP0Go5+lUnrI
 J8w9YDYeei1TO3C51EgMJUXHPoieEjezgBQW7Px/RyxlZlURBGKTsRI709hFtHi9uXlgScWuCOI
 2/+K1Da1QZIKtGU3FvITkQnLC1t7+zZH1tKAWTueD49VcleXglUDjhdvTdqLsxUchkMMoZfwHSY
 GTubwyHEfgWFZFR8jvUMmNph8Hqkv1r7evKqLlI+yTQoFimn0cTTwquPKo0dNZMvUUiRwMz8yR7
 XKHguLAmceAQC1oPsMPCjwDrrjCEi2SSYMojmBcD7OMyTXGmo403Qrfp8IUIC9WfdGFDEIA72Dp
 e9tPMACa/OGWvsZOx6Q==
X-Proofpoint-GUID: VKj-YQ9wKR8GjOpfDRXrT459fMxy1rGC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-18_02,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602180110
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
	TAGGED_FROM(0.00)[bounces-77571-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,linux.dev,vger.kernel.org,kvack.org,lists.linux-foundation.org,anarazel.de,kernel.org,oracle.com,infradead.org,lst.de,gmail.com,redhat.com,samsung.com,mit.edu];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: C02FE15672F
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 11:26:06AM +1100, Dave Chinner wrote:
> On Wed, Feb 18, 2026 at 12:09:46AM +0530, Ojaswin Mujoo wrote:
> > On Mon, Feb 16, 2026 at 12:38:59PM +0100, Jan Kara wrote:
> > > Hi!
> > > 
> > > On Fri 13-02-26 19:02:39, Ojaswin Mujoo wrote:
> > > > Another thing that came up is to consider using write through semantics 
> > > > for buffered atomic writes, where we are able to transition page to
> > > > writeback state immediately after the write and avoid any other users to
> > > > modify the data till writeback completes. This might affect performance
> > > > since we won't be able to batch similar atomic IOs but maybe
> > > > applications like postgres would not mind this too much. If we go with
> > > > this approach, we will be able to avoid worrying too much about other
> > > > users changing atomic data underneath us. 
> > > > 
> > > > An argument against this however is that it is user's responsibility to
> > > > not do non atomic IO over an atomic range and this shall be considered a
> > > > userspace usage error. This is similar to how there are ways users can
> > > > tear a dio if they perform overlapping writes. [1]. 
> > > 
> > > Yes, I was wondering whether the write-through semantics would make sense
> > > as well. Intuitively it should make things simpler because you could
> > > practially reuse the atomic DIO write path. Only that you'd first copy
> > > data into the page cache and issue dio write from those folios. No need for
> > > special tracking of which folios actually belong together in atomic write,
> > > no need for cluttering standard folio writeback path, in case atomic write
> > > cannot happen (e.g. because you cannot allocate appropriately aligned
> > > blocks) you get the error back rightaway, ...
> > 
> > This is an interesting idea Jan and also saves a lot of tracking of
> > atomic extents etc.
> 
> ISTR mentioning that we should be doing exactly this (grab page
> cache pages, fill them and submit them through the DIO path) for
> O_DSYNC buffered writethrough IO a long time again. The context was
> optimising buffered O_DSYNC to use the FUA optimisations in the
> iomap DIO write path.
> 
> I suggested it again when discussing how RWF_DONTCACHE should be
> implemented, because the async DIO write completion path invalidates
> the page cache over the IO range. i.e. it would avoid the need to
> use folio flags to track pages that needed invalidation at IO
> completion...
> 
> I have a vague recollection of mentioning this early in the buffered
> RWF_ATOMIC discussions, too, though that may have just been the
> voices in my head.

Hi Dave,

Yes we did discuss this [1] :)

We also discussed the alternative of using the COW fork path for atomic
writes [2]. Since at that point I was not completely sure if the
writethrough would become too restrictive of an approach, I was working
on a COW fork implementation.

However, from the discussion here as well as Andres' comments, it seems
like write through might not be too bad for postgres.

> 
> Regardless, we are here again with proposals for RWF_ATOMIC and
> RWF_WRITETHROUGH and a suggestion that maybe we should vector
> buffered writethrough via the DIO path.....
> 
> Perhaps it's time to do this?

I agree that it makes more sense to do writethrough if we want to have
the strict old-or-new semantics (as opposed to just untorn IO
semantics). I'll work on a POC for this approach of doing atomic writes,
I'll mostly try to base it off your suggestions in [1].

FWIW, I do have a somewhat working (although untested and possible
broken in some places) POC for performing atomic writes via XFS COW fork
based on suggestions from Dave [2]. Even though we want to explore the
writethrough approach, I'd just share it here incase anyone is
interested in how the design is looking like:

https://github.com/OjaswinM/linux/commits/iomap-buffered-atomic-rfc2.3/

(If anyone prefers for me to send this as a patchset on mailing list, let
me know)

Regards,
ojaswin

[1] https://lore.kernel.org/linux-fsdevel/aRmHRk7FGD4nCT0s@dread.disaster.area/
[2] https://lore.kernel.org/linux-fsdevel/aRuKz4F3xATf8IUp@dread.disaster.area/

> 
> FWIW, the other thing that write-through via the DIO path enables is
> true async O_DSYNC buffered IO. Right now O_DSYNC buffered writes
> block waiting on IO completion through generic_sync_write() ->
> vfs_fsync_range(), even when issued through AIO paths.  Vectoring it
> through the DIO path avoids the blocking fsync path in IO submission
> as it runs in the async DIO completion path if it is needed....
> 
> -Dave.
> -- 
> Dave Chinner
> dgc@kernel.org

