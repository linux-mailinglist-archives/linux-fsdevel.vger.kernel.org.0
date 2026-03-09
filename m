Return-Path: <linux-fsdevel+bounces-79874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPtiDrYpr2mzOgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 21:12:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB330240B57
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 21:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44F8A302084E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 20:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE4436A018;
	Mon,  9 Mar 2026 20:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AMPyvjp0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B483A3ED5BA;
	Mon,  9 Mar 2026 20:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773087107; cv=none; b=ciYvgUuT78YlNbZfiANXnFAMqa2fMXWwXF/Nr3pNHCbdtYbtjS95Gcj6Y3CiFWeF1LJbgKt14eO6PWSzxWhbpHutrTYHWvvhGUHRVA9dGB/70tonlWYTkGKk3UqXnqyffvphwTNcnfJ1vROC+3wKdInVU9NMsQjIhHYJDO2NJPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773087107; c=relaxed/simple;
	bh=JlmKdH0Bbz2ZxP9WbCFMzyyjBIEgtG4cMl4nlq+6890=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=PwGdnvMf/WMsYG8REvOTydwDMIxVIS4UmGwAPOUgMkQB1CfFwP0t/ChoJLK45l3/MheqlFQmy16PXalc7laagIRgRsSZbcD0eoDbcWQ0m73xmFOo13TyDuE2PHKOQi93EzYQEltPLeWbtNL7a0Bc/hpp+kUq5HoJB9a58MDCV+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AMPyvjp0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629FwFY71433673;
	Mon, 9 Mar 2026 20:11:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=J+MReH
	kdFCzDINevGmN7BYrD5h16dkVpWOVjmnX1Q/k=; b=AMPyvjp0jQUNgXn6Hk1tmf
	EG4FCBlJk8vU0dzchEkhTCFJFLesmCchgPistcAgAs639vnP9pptng8kXMAbzOia
	q5NshJyvTNfof8gdYp1GzwxZulybshI3PqRKjOb/SaI0UPEJrIt4jyexAIN48Wm0
	w/Mw3wPT6W3BQmrKZWXHn6/DFARVTupqS/iLqqNyLrME9wToruViZdwdbBsu3Qtl
	0zEFIHGN04u6+OjrW21Tgfm9LJbMSCz1cBRZneiIQ0NfJfCZ4Y4F3a9ghOwfDLyJ
	r+N+wncn0OldU7zZnFVO0t6vNaRxLqtcCgLdbScpUcJtgriSZx0KQ9bsYjERgKcw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcuy86s0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 20:11:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 629JvVsj024649;
	Mon, 9 Mar 2026 20:11:06 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cs0jjx73p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 20:11:06 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 629KB6ZU9699942
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Mar 2026 20:11:06 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 276F258051;
	Mon,  9 Mar 2026 20:11:06 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A42F5805E;
	Mon,  9 Mar 2026 20:11:03 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.72.80])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Mar 2026 20:11:03 +0000 (GMT)
Message-ID: <0bd92b4fce00a6111a0fc7764904f7e6ae0ece3a.camel@linux.ibm.com>
Subject: Re: [PATCH v3 00/12] vfs: change inode->i_ino from unsigned long
 to u64
From: Mimi Zohar <zohar@linux.ibm.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        fsverity@lists.linux.dev, linux-mm@kvack.org, netfs@lists.linux.dev,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-nilfs@vger.kernel.org,
        v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
        autofs@vger.kernel.org, ceph-devel@vger.kernel.org,
        codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
        linux-mtd@lists.infradead.org, jfs-discussion@lists.sourceforge.net,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        devel@lists.orangefs.org, linux-unionfs@vger.kernel.org,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        netdev@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-hams@vger.kernel.org, linux-x25@vger.kernel.org,
        audit@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-can@vger.kernel.org, linux-sctp@vger.kernel.org,
        bpf@vger.kernel.org
In-Reply-To: <dd3f9873c7939fba0ca2366effd24e4b6326f17b.camel@kernel.org>
References: <20260304-iino-u64-v3-0-2257ad83d372@kernel.org>
				 <05b5d55c49b5a1bbc43a5315e3c84872e7e634b3.camel@linux.ibm.com>
			 <f22758116dabd3c135a833bcb5cfcd2ea4f6ecf4.camel@kernel.org>
		 <c9500adc562665d44feaca9206f23a5ba07432c1.camel@linux.ibm.com>
	 <dd3f9873c7939fba0ca2366effd24e4b6326f17b.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Mar 2026 16:11:02 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EK4LElZC c=1 sm=1 tr=0 ts=69af295b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=Ohuc5M0UGw20_VvRb6sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDE3OCBTYWx0ZWRfX48NInAXNxJ9I
 cqZ2w42oLBKp6f6ShdJYkvtWo35W1xBR9wJ3/AMrAgqtjjRmHF+LNmGqeG928jRHEGfhi5Dc3Ir
 wmrxB6T58L1jgUeut/UN4ASDb+YKdYMu+ThxKOBJOKt26YDnsAlMtjSvmCcaxE+TT5Ibe0zYC0f
 zBgbUGDl6m62+LPcwjv67C82HPGKVuU4mQ7dUKg2Sv0H9xprcqNV55N1hEVQyFV4pb7QXKtAhGE
 YVUSx215hmiPcMqQdaRgfBi/PErZi+WGgzrtD+EeiIqh5iBJfaUE0yW08tvcIRwoQr42lAufyzB
 vYZKyixwfkjfLVLXUjHMdBtRGJrXaAm82jJw9wIV+5PYqMOONm6AlqMVRpwFh8k3h3nwk8wQiR2
 zhIg8VMnQ/RF3WK3QDU7+acPMfehsyHGr854HkqAG/4Nm9pp74q0YkbWa+CcmHp5NJJ/sMPIvY9
 s27fVbRyzlJIijxgTKg==
X-Proofpoint-GUID: xB1hrjZmRj2bIZxp5d4ApU8QU-_XE2VB
X-Proofpoint-ORIG-GUID: xB1hrjZmRj2bIZxp5d4ApU8QU-_XE2VB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090178
X-Rspamd-Queue-Id: BB330240B57
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[45];
	TAGGED_FROM(0.00)[bounces-79874-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

On Mon, 2026-03-09 at 15:33 -0400, Jeff Layton wrote:
> On Mon, 2026-03-09 at 15:00 -0400, Mimi Zohar wrote:
> > On Mon, 2026-03-09 at 13:59 -0400, Jeff Layton wrote:
> > > On Mon, 2026-03-09 at 13:47 -0400, Mimi Zohar wrote:
> > > > [ I/O socket time out.  Trimming the To list.]
> > > >=20
> > > > On Wed, 2026-03-04 at 10:32 -0500, Jeff Layton wrote:
> > > > > This version squashes all of the format-string changes and the i_=
ino
> > > > > type change into the same patch. This results in a giant 600+ lin=
e patch
> > > > > at the end of the series, but it does remain bisectable.  Because=
 the
> > > > > patchset was reorganized (again) some of the R-b's and A-b's have=
 been
> > > > > dropped.
> > > > >=20
> > > > > The entire pile is in the "iino-u64" branch of my tree, if anyone=
 is
> > > > > interested in testing this.
> > > > >=20
> > > > >     https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux=
.git/
> > > > >=20
> > > > > Original cover letter follows:
> > > > >=20
> > > > > ----------------------8<-----------------------
> > > > >=20
> > > > > Christian said [1] to "just do it" when I proposed this, so here =
we are!
> > > > >=20
> > > > > For historical reasons, the inode->i_ino field is an unsigned lon=
g,
> > > > > which means that it's 32 bits on 32 bit architectures. This has c=
aused a
> > > > > number of filesystems to implement hacks to hash a 64-bit identif=
ier
> > > > > into a 32-bit field, and deprives us of a universal identifier fi=
eld for
> > > > > an inode.
> > > > >=20
> > > > > This patchset changes the inode->i_ino field from an unsigned lon=
g to a
> > > > > u64. This shouldn't make any material difference on 64-bit hosts,=
 but
> > > > > 32-bit hosts will see struct inode grow by at least 4 bytes. This=
 could
> > > > > have effects on slabcache sizes and field alignment.
> > > > >=20
> > > > > The bulk of the changes are to format strings and tracepoints, si=
nce the
> > > > > kernel itself doesn't care that much about the i_ino field. The f=
irst
> > > > > patch changes some vfs function arguments, so check that one out
> > > > > carefully.
> > > > >=20
> > > > > With this change, we may be able to shrink some inode structures.=
 For
> > > > > instance, struct nfs_inode has a fileid field that holds the 64-b=
it
> > > > > inode number. With this set of changes, that field could be elimi=
nated.
> > > > > I'd rather leave that sort of cleanups for later just to keep thi=
s
> > > > > simple.
> > > > >=20
> > > > > Much of this set was generated by LLM, but I attributed it to mys=
elf
> > > > > since I consider this to be in the "menial tasks" category of LLM=
 usage.
> > > > >=20
> > > > > [1]: https://lore.kernel.org/linux-fsdevel/20260219-portrait-wink=
t-959070cee42f@brauner/
> > > > >=20
> > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > >=20
> > > > Jeff, missing from this patch set is EVM.  In hmac_add_misc() EVM c=
opies the
> > > > i_ino and calculates either an HMAC or file meta-data hash, which i=
s then
> > > > signed.=20
> > > >=20
> > > >=20
> > >=20
> > > Thanks Mimi, good catch.
> > >=20
> > > It looks like we should just be able to change the ino field to a u64
> > > alongside everything else. Something like this:
> > >=20
> > > diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity=
/evm/evm_crypto.c
> > > index c0ca4eedb0fe..77b6c2fa345e 100644
> > > --- a/security/integrity/evm/evm_crypto.c
> > > +++ b/security/integrity/evm/evm_crypto.c
> > > @@ -144,7 +144,7 @@ static void hmac_add_misc(struct shash_desc *desc=
, struct inode *inode,
> > >                           char type, char *digest)
> > >  {
> > >         struct h_misc {
> > > -               unsigned long ino;
> > > +               u64 ino;
> > >                 __u32 generation;
> > >                 uid_t uid;
> > >                 gid_t gid;
> > >=20
> >=20
> > Agreed.
> >=20
> > >=20
> > > That should make no material difference on 64-bit hosts. What's the
> > > effect on 32-bit? Will they just need to remeasure everything or woul=
d
> > > the consequences be more dire? Do we have any clue whether anyone is
> > > using EVM in 32-bit environments?
> >=20
> > All good questions. Unfortunately I don't know the answer to most of th=
em. What
> > we do know: changing the size of the i_ino field would affect EVM file =
metadata
> > verification and would require relabeling the filesystem.  Even package=
s
> > containing EVM portable signatures, which don't include or verify the i=
_ino
> > number, would be affected.
> >=20
>=20
> Ouch. Technically, I guess this is ABI...
>=20
> While converting to u64 seems like the ideal thing to do, the other
> option might be to just keep this as an unsigned long for now.
>=20
> No effect on 64-bit, but that could keep things working 32-bit when the
> i_ino casts properly to a u32. ext4 would be fine since they don't
> issue inode numbers larger than UINT_MAX. xfs and btrfs are a bit more
> iffy, but worst case they'd just need to be relabeled (which is what
> they'll need to do anyway).
>=20
> If we do that, then we should probably add a comment to this function
> explaining why it's an unsigned long.

Agreed.

>=20
> Thoughts?

My concern would be embedded/IoT devices, but I don't have any insight into=
 who
might be using it on 32 bit.

Mimi

