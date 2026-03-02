Return-Path: <linux-fsdevel+bounces-78873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MM63IT5WpWnR9AUAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 10:19:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB59A1D5701
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 10:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1F513032991
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 09:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943CA7080E;
	Mon,  2 Mar 2026 09:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nn2/LkKT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B69430BA2;
	Mon,  2 Mar 2026 09:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772443038; cv=none; b=eflg+5RW1TyzayDc7vdOIeTmYRpnNse5mhCgEB6z/LN1zwVt5yggKJb18HaQ6aucoOk0Zq1jn/obsPmzKHzv7Kt58RD6Y4BJTNle3+AemLo2yY1fveaOkryo0MQKdytjwsDqZYlNZJvwZF3sDdZmkGGnfGavndtsTkdPrSPhkgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772443038; c=relaxed/simple;
	bh=Q9kO6X2cy9vTWPB9JjpyH9JbhDCzgr69BRga2YsmE94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1ZdE8OOd9yuZKTGEezpm9WErmfKcwOdBe/hPGdVwPkaXVEaKUENPGaEHDQTjmrvMAHhyZ6EdB0F+65qX6VGICR8MIAXFntE55OKey2Q4ZtUIpb+k/62BajhkSBI0YhlvST6g7JJg1g0cOhvKWlzUObkiwP3O+D2wqCQ/k1zap4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nn2/LkKT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6218h8xF614134;
	Mon, 2 Mar 2026 09:16:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=TrcMKD67sFT7ZB6+eKbCbxTcbOWCpa
	ivxHfSCHoHHJc=; b=nn2/LkKTQSF0o7VlI+2VJ+MIbqdr6t2MAuLFS0IzzYD3al
	fSxkTdbyAVCNmPHa7tpq+6aqXKPCjSXr+O6ln+Esy6WqHn+luIRVU1VKUPYipJw4
	kh5YQFLZwyDT9fTOOOnFSPyP/wWlnkjkZAa29iugA4hniD4RLMAzb4uk2FosV4kq
	1nOh+ZtQpo2s11XsUYoM7wltiZdDVnk7HllNJpzSsJ/XMKtfaVEOF1fFYz9Hw7c6
	cZNTpNaeKSLlkWycp0l3Vr9QNHPgHvix6NE3TclHJ5WWVa8qWU6c47oe7U9z3d2c
	njGjwGTUsGzXrK+Lj3DG58+VCUMogL/xr7nWMzBQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckssmdgxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 09:16:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6228gQCx028908;
	Mon, 2 Mar 2026 09:16:55 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmaprwap9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 09:16:54 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6229GrXG53936410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Mar 2026 09:16:53 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3AA7B2004D;
	Mon,  2 Mar 2026 09:16:53 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC4B920043;
	Mon,  2 Mar 2026 09:16:52 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.111.67.194])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  2 Mar 2026 09:16:52 +0000 (GMT)
Date: Mon, 2 Mar 2026 10:16:51 +0100
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: Chris Hofstaedtler <zeha@debian.org>
Cc: debian-loongarch@lists.debian.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, util-linux@vger.kernel.org,
        Karel Zak <kzak@redhat.com>
Subject: Re: [ANNOUNCE] util-linux v2.42-rc1
Message-ID: <aaVVg4PhVKkdL2C5@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <wid276gkq7tblvkfwc6kum4nacamstiigqjj5ux6j6zd4blz4l@jzq3sgfh6cj5>
 <aaP6atFYpVqulTO1@zeha.at>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaP6atFYpVqulTO1@zeha.at>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA3OCBTYWx0ZWRfXz+m+YVtdLOb5
 GBVf0kFoDS+UCQH86zsHj9lEr4E0yWEiEwhAzjIJE/cw30fb1FfhVFeHoPXPvvj83xI/DCHDK2k
 rDBnJZCNl4+5XoDle9YOdpR8SgaXRQEPrR/jklf0GpWMIqD0fWK1AwnnRJ3fAR0MJlQhhekt/MY
 Rnz++mwdObTyE5FHWTje8dQvmlx6TBUFP2A3kMMmJC2Q8iI76H7vB7J+IWxniWB71R8PM/i09cA
 rwSIbiSrDXoBtSKPaHiy3Uhig/SlDTXffAJGI8hWZcQtZy+ARmLj3UgDA1H3H6J36wePNud8qmI
 F44bDzWWGJmDhwhF5/xo8ebLfwOX/eDdRVtP0qTQxMNEv1pFGgmtis428MfQFhgJYD9Jp8TH2sS
 KrXoAFaPl7ZzADEAu9FCF/QSZaLUMudpivPpCY8n0V5XqEGPcVWf6XFs6KlwOXeWzLxHyxJir9e
 5kc8VJd/Uza3a0KJVDA==
X-Proofpoint-ORIG-GUID: 1WQHlp8Xvs7XjLa4VeuAJyJqhMSBrnu1
X-Proofpoint-GUID: 1WQHlp8Xvs7XjLa4VeuAJyJqhMSBrnu1
X-Authority-Analysis: v=2.4 cv=AobjHe9P c=1 sm=1 tr=0 ts=69a55587 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=xNf9USuDAAAA:8 a=20KFwNOVAAAA:8 a=CWVMYPpm5h6mBys_UeAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 spamscore=0 clxscore=1011 suspectscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020078
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78873-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[sumanthk@linux.ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: DB59A1D5701
X-Rspamd-Action: no action

Hi Chris,

> Hi Sumanth, looong64 porters,
> 
> * Karel Zak <kzak@redhat.com> [260226 14:53]:
> > The util-linux release v2.42-rc1 is now available at
> >  http://www.kernel.org/pub/linux/utils/util-linux/v2.42/
> [..]
> > lsmem:
> >    - display global memmap on memory parameter (by Sumanth Korikkar)
> 
> It appears the test for this is run on looong64 and fails there (failing the
> entire build), at least in the Debian build infra.
> https://buildd.debian.org/status/fetch.php?pkg=util-linux&arch=loong64&ver=2.42%7Erc1-1&stamp=1772312955&raw=0
> 
> See below for log output excerpts.
> 
> Thanks,
> Chris
> 
> 
> log snippets:
> 
> ================= O/E diff ===================
> --- /build/reproducible-path/util-linux-2.42~rc1/tests/output/lsmem/lsmem-s390-zvm-6g	2026-02-28 21:08:31.577617951 +0000
> +++ /build/reproducible-path/util-linux-2.42~rc1/tests/expected/lsmem/lsmem-s390-zvm-6g	2026-02-18 11:33:47.804188659 +0000
> @@ -17,6 +17,7 @@
>  Memory block size:                256M
>  Total online memory:              4.8G
>  Total offline memory:             1.3G
> +Memmap on memory parameter:         no

The ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE feature is currently not enabled on
loong64.

The lsmem tool displays the setting found in
/sys/module/memory_hotplug/parameters/memmap_on_memory.  If this path
does not exist, lsmem will not show the parameter. As a result, the test
fails.

To resolve this, the test should first verify whether the file
/sys/module/memory_hotplug/parameters/memmap_on_memory exists. If it is
missing, the test should skip the output related to the "Memmap
on memory parameter". I will check how the test logic can be updated and
give it a try.

Thanks & Regards,
Sumanth


