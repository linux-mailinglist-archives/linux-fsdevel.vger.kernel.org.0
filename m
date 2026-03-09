Return-Path: <linux-fsdevel+bounces-79840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGAAGSwZr2nHNgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 20:02:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B17EB23F1AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 20:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DE568300D775
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 19:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49F43603EF;
	Mon,  9 Mar 2026 19:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="d2IgH4d2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E006114A4CC;
	Mon,  9 Mar 2026 19:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773082873; cv=none; b=aZqu906/3H8AZ1W0bOaFhhO3F1b1/f3wkfFQswIL/BTwx2Q9H3xqD2j+QlLBPm1OHEyz66wrqF5yXGEkoRhW06tJWAZ1UZM9tg2IRIDCKu/AoIrpduOw8rxyEGmgZ+aspxn+D5zoNMsthOks5PwDsdNlnFMXxxCKrJRUoAwXHrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773082873; c=relaxed/simple;
	bh=zuZybXxG4NWtCCamlMtgm4GPhCUwWs75GokKHhfMbyA=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=QCmBAwOLqWrnXR8eva6gXElo4OqrkXzQuB5QYgU3FvYWtoDJC7B85wjJTWwGoLp5rzxGkemZmw0E57Jvh2Atm6KSaM5c86CDvWQ/ujg1lSONgiypvYEUN/lpO0DGycqC65/yg5OSCt0zXJJXHxjsbOWwPU75UcJZPDJlQBPVqhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=d2IgH4d2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629BiYp9402979;
	Mon, 9 Mar 2026 19:00:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5swsN0
	rUxxavDq9zMYnPJS2Jv47BUk07HnZRz0pbh40=; b=d2IgH4d2cI76xjXosS08+5
	z7p4cmRM3+vsUQToHiG2nB8DP/joMF596z7727f61cqMRXeNJJpaPHxOajT8sUoA
	4hdB+fd4u1HsuNVMFr3OsadtAG1CKvM35tVtsMpgaqqCM2ZBMMXJkpG++BlAdorh
	a25OzV7jJWb6oFmtakhiLNn+qzaAmqYeRhvuloIidiB6X0BgKDL71O4yfuzN3RUh
	AoqpvZ653XjMWMMwrSPrZbVK8uRNsl6RplSUCc6nWvYsnXyDf2A2VF2Up7qZowSZ
	aJlNA2A77/MP8caSRZkmC6D9PsUx9bOXT5BvUfyuxzfxj3qWmymQF0ir3jH77L1w
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcun7rdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 19:00:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 629FvaW1015771;
	Mon, 9 Mar 2026 19:00:08 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cs121ww0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 19:00:08 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 629J079s4915810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Mar 2026 19:00:08 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B444C58064;
	Mon,  9 Mar 2026 19:00:07 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E09F35805A;
	Mon,  9 Mar 2026 19:00:04 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.72.80])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Mar 2026 19:00:04 +0000 (GMT)
Message-ID: <c9500adc562665d44feaca9206f23a5ba07432c1.camel@linux.ibm.com>
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
In-Reply-To: <f22758116dabd3c135a833bcb5cfcd2ea4f6ecf4.camel@kernel.org>
References: <20260304-iino-u64-v3-0-2257ad83d372@kernel.org>
		 <05b5d55c49b5a1bbc43a5315e3c84872e7e634b3.camel@linux.ibm.com>
	 <f22758116dabd3c135a833bcb5cfcd2ea4f6ecf4.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Mar 2026 15:00:04 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IXXixi4WEaMt5ZLipHNyYmLY2v6HWLsd
X-Authority-Analysis: v=2.4 cv=Hp172kTS c=1 sm=1 tr=0 ts=69af18ba cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=o9bg_TheAfZNAX0b3qsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDE2NSBTYWx0ZWRfX6z/xa1oiKPHE
 y5EqU++9e+D9gbPsThEA40KAIQaMNONuQFv6rphXC4UXK9hbuizpabscJIBcCstT+gR2HtuKysP
 juuUkxGaMl7wxMTZHQleqdpaj1BApzfJEmhJlxbY5TY+zaAhKCE7FmRzIMEIOEQTi0cM+UreNNn
 frwDdmfnFwh4sJREHHlQDdGWVECyjZbYar7Sfrv1WmeMPxeeCh8/LcWzrRHQxRnw2tvA2a4D8NR
 c7ma8KolSpfVjNgJ0OleioMQBwEZGtoJr7jBKqVpvCDiflI9IHYr2EnI/OMDVmsDQcjOAtzHE2E
 Cqs2ZZL0dk00OuX7g/sw5bXFEAXaWjWvfls2vJrY4HNOaz6u97184uDaehJuW5B2dmjBv87lTJU
 mdY20MyhE/Ql/CExB+A/Xcl6KkN3u1kmsdTu44KKD0LP1RVDdsR5dGWPIvWKEchoHvJnuy6WqMG
 FGu2ZyF+vBxNE+HNtfg==
X-Proofpoint-ORIG-GUID: IXXixi4WEaMt5ZLipHNyYmLY2v6HWLsd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090165
X-Rspamd-Queue-Id: B17EB23F1AD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[45];
	TAGGED_FROM(0.00)[bounces-79840-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.ibm.com:mid];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

On Mon, 2026-03-09 at 13:59 -0400, Jeff Layton wrote:
> On Mon, 2026-03-09 at 13:47 -0400, Mimi Zohar wrote:
> > [ I/O socket time out.  Trimming the To list.]
> >=20
> > On Wed, 2026-03-04 at 10:32 -0500, Jeff Layton wrote:
> > > This version squashes all of the format-string changes and the i_ino
> > > type change into the same patch. This results in a giant 600+ line pa=
tch
> > > at the end of the series, but it does remain bisectable.  Because the
> > > patchset was reorganized (again) some of the R-b's and A-b's have bee=
n
> > > dropped.
> > >=20
> > > The entire pile is in the "iino-u64" branch of my tree, if anyone is
> > > interested in testing this.
> > >=20
> > >     https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git=
/
> > >=20
> > > Original cover letter follows:
> > >=20
> > > ----------------------8<-----------------------
> > >=20
> > > Christian said [1] to "just do it" when I proposed this, so here we a=
re!
> > >=20
> > > For historical reasons, the inode->i_ino field is an unsigned long,
> > > which means that it's 32 bits on 32 bit architectures. This has cause=
d a
> > > number of filesystems to implement hacks to hash a 64-bit identifier
> > > into a 32-bit field, and deprives us of a universal identifier field =
for
> > > an inode.
> > >=20
> > > This patchset changes the inode->i_ino field from an unsigned long to=
 a
> > > u64. This shouldn't make any material difference on 64-bit hosts, but
> > > 32-bit hosts will see struct inode grow by at least 4 bytes. This cou=
ld
> > > have effects on slabcache sizes and field alignment.
> > >=20
> > > The bulk of the changes are to format strings and tracepoints, since =
the
> > > kernel itself doesn't care that much about the i_ino field. The first
> > > patch changes some vfs function arguments, so check that one out
> > > carefully.
> > >=20
> > > With this change, we may be able to shrink some inode structures. For
> > > instance, struct nfs_inode has a fileid field that holds the 64-bit
> > > inode number. With this set of changes, that field could be eliminate=
d.
> > > I'd rather leave that sort of cleanups for later just to keep this
> > > simple.
> > >=20
> > > Much of this set was generated by LLM, but I attributed it to myself
> > > since I consider this to be in the "menial tasks" category of LLM usa=
ge.
> > >=20
> > > [1]: https://lore.kernel.org/linux-fsdevel/20260219-portrait-winkt-95=
9070cee42f@brauner/
> > >=20
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> >=20
> > Jeff, missing from this patch set is EVM.  In hmac_add_misc() EVM copie=
s the
> > i_ino and calculates either an HMAC or file meta-data hash, which is th=
en
> > signed.=20
> >=20
> >=20
>=20
> Thanks Mimi, good catch.
>=20
> It looks like we should just be able to change the ino field to a u64
> alongside everything else. Something like this:
>=20
> diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm=
/evm_crypto.c
> index c0ca4eedb0fe..77b6c2fa345e 100644
> --- a/security/integrity/evm/evm_crypto.c
> +++ b/security/integrity/evm/evm_crypto.c
> @@ -144,7 +144,7 @@ static void hmac_add_misc(struct shash_desc *desc, st=
ruct inode *inode,
>                           char type, char *digest)
>  {
>         struct h_misc {
> -               unsigned long ino;
> +               u64 ino;
>                 __u32 generation;
>                 uid_t uid;
>                 gid_t gid;
>=20

Agreed.

>=20
> That should make no material difference on 64-bit hosts. What's the
> effect on 32-bit? Will they just need to remeasure everything or would
> the consequences be more dire? Do we have any clue whether anyone is
> using EVM in 32-bit environments?

All good questions. Unfortunately I don't know the answer to most of them. =
What
we do know: changing the size of the i_ino field would affect EVM file meta=
data
verification and would require relabeling the filesystem.  Even packages
containing EVM portable signatures, which don't include or verify the i_ino
number, would be affected.

Mimi





