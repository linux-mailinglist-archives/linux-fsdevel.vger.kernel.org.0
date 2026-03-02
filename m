Return-Path: <linux-fsdevel+bounces-78935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMnnI5G4pWkiFQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 17:19:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 970A11DC9FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 17:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 47BB9305859E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 16:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F631421F11;
	Mon,  2 Mar 2026 15:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ij84L/5z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FFF41B37F;
	Mon,  2 Mar 2026 15:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772467164; cv=none; b=cg1l76EgxdkvIVaOcEH8xEGKbTsBSxr94hpGmSKGaJhHBZsO1Bdy0iFxI/ajkrzREISKL3QC1dI38Z1W2Axugv4uYvwoOh6Jl3XXdZ4uZkyRoFj2etGt56mCAc6cy5kuoG+GmjD52bVe9nzxyUbGCmFMQlqhHQnWGhFPRurNs+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772467164; c=relaxed/simple;
	bh=JGr33/CfROWThcucoXZAeSxGxZmk9tRO6A92w2xfUZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0CA3vtbu9wYk5DKz+tm7hnw0VUWGnENIu0C/FQOzDO4QbYxcWTl4u6Is6fqI3cgXWG+aLKpA8Bq0umRCd0vRX9vo1rE+YWxypoSzH1zG9xvCTix+06TpRJMXidjYLum7rnoGNUAuZADa2yR7SnOR1YDtCxoMLCz5X50jchxKms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ij84L/5z; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6224Swed2804450;
	Mon, 2 Mar 2026 15:59:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Yb10Q2+KFBz/D82HEszwQEjX4pL2LS
	HtX5eu/sRiZiM=; b=Ij84L/5z6hOAp8B791Is8400vKc0nQi1K7GOus1oUdJG3u
	IxSZHYE3mRE/HzJJ23hHK1AIeE772JbU2OO23JCzaoCT5uAUMGrRLAGsW+bR4D8O
	qEoSSRfQtooOHLSFv7n7Vwb1DGOVUAN9OK+oAFymvyNat1yegS0bCtC4wvnr1UTV
	5mq9dfkXZQkqPfsF+AV3yh7/mKe3d6dyQ0TxBVxUhW2bVmnLh38IRiASurhQbQOw
	jDo3wY01w1LIgHsA1LmqYWtLZKkt0SBEAvt54gp6Pp9w+lTkO6quRrbseXQQO8t/
	Zr05O6sMH7ndY68HMwK1YtD2EIld4LuBQxWD5vqw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskcqd7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 15:59:11 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 622DNMMO010309;
	Mon, 2 Mar 2026 15:59:10 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmc6jxpaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 15:59:10 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 622Fx8FC51839438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Mar 2026 15:59:08 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39AAA2004B;
	Mon,  2 Mar 2026 15:59:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C52DC20040;
	Mon,  2 Mar 2026 15:59:07 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.111.67.194])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  2 Mar 2026 15:59:07 +0000 (GMT)
Date: Mon, 2 Mar 2026 16:59:06 +0100
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: Chris Hofstaedtler <zeha@debian.org>
Cc: debian-loongarch@lists.debian.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, util-linux@vger.kernel.org,
        Karel Zak <kzak@redhat.com>
Subject: Re: [ANNOUNCE] util-linux v2.42-rc1
Message-ID: <aaWzysmPNrkPm4p1@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <wid276gkq7tblvkfwc6kum4nacamstiigqjj5ux6j6zd4blz4l@jzq3sgfh6cj5>
 <aaP6atFYpVqulTO1@zeha.at>
 <aaVVg4PhVKkdL2C5@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaVVg4PhVKkdL2C5@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: grVP-tZ7soYwac2-zyzxy-ey-F-qYPwn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDEzMSBTYWx0ZWRfXz663CW43zClA
 0dDDmpvepOAJF5N3NtySeOcPrajr6liAif0agCxCIXnznSScEC+3c8AZGV7UpP7Gj4YhnXwpdnj
 6D94LaBqi1mdjr0+lflEJh3m/OgIAn0dLeV/+xW7WImwNA2w281p/NfoRc/bpcZtJSdTuWFCyNQ
 DI6mAINEzYbukzvtMZMkS/+mbsE4P0LDuO0IuCSuyGeg2pQXFy1kyV2fDVHxeY9+9pYMG6/djWE
 u6ySj4Sp5iqBLlkAC7CgQ0fbpSDjBybWwC1z7278KvI2nJuE80orVUCoWvW5HhSJVuyLEI+bJc/
 GgdclhfGYjZ4xuJaaF+KNS9uhnCw1Asi0vYbb34ae7c0bAXwHZ0T39z3NDIyrumHmgMDDqAoRj+
 nPKVoKJNNhbDRYd+WWPg8VbPkt2EGKqnG0EEGFJXTASgUn6YgHUa37k9zjYy1Kc1SdskluHcbDo
 JLCHt3185ACV+73EEVQ==
X-Authority-Analysis: v=2.4 cv=H7DWAuYi c=1 sm=1 tr=0 ts=69a5b3cf cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=xNf9USuDAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=Cz2h6EHwldfL-D86zEMA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: grVP-tZ7soYwac2-zyzxy-ey-F-qYPwn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020131
X-Rspamd-Queue-Id: 970A11DC9FF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78935-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[sumanthk@linux.ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 10:16:53AM +0100, Sumanth Korikkar wrote:
> Hi Chris,
> 
> > Hi Sumanth, looong64 porters,
> > 
> > * Karel Zak <kzak@redhat.com> [260226 14:53]:
> > > The util-linux release v2.42-rc1 is now available at
> > >  http://www.kernel.org/pub/linux/utils/util-linux/v2.42/
> > [..]
> > > lsmem:
> > >    - display global memmap on memory parameter (by Sumanth Korikkar)
> > 
> > It appears the test for this is run on looong64 and fails there (failing the
> > entire build), at least in the Debian build infra.
> > https://buildd.debian.org/status/fetch.php?pkg=util-linux&arch=loong64&ver=2.42%7Erc1-1&stamp=1772312955&raw=0
> > 
> > See below for log output excerpts.
> > 
> > Thanks,
> > Chris
> > 
> > 
> > log snippets:
> > 
> > ================= O/E diff ===================
> > --- /build/reproducible-path/util-linux-2.42~rc1/tests/output/lsmem/lsmem-s390-zvm-6g	2026-02-28 21:08:31.577617951 +0000
> > +++ /build/reproducible-path/util-linux-2.42~rc1/tests/expected/lsmem/lsmem-s390-zvm-6g	2026-02-18 11:33:47.804188659 +0000
> > @@ -17,6 +17,7 @@
> >  Memory block size:                256M
> >  Total online memory:              4.8G
> >  Total offline memory:             1.3G
> > +Memmap on memory parameter:         no
> 
> The ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE feature is currently not enabled on
> loong64.
> 
> The lsmem tool displays the setting found in
> /sys/module/memory_hotplug/parameters/memmap_on_memory.  If this path
> does not exist, lsmem will not show the parameter. As a result, the test
> fails.
> 
> To resolve this, the test should first verify whether the file
> /sys/module/memory_hotplug/parameters/memmap_on_memory exists. If it is
> missing, the test should skip the output related to the "Memmap
> on memory parameter". I will check how the test logic can be updated and
> give it a try.

Hi Chris,

Could you please try the following?

Thanks

From e47cae41f00bdcc3663088b1324a89b67ee9c5df Mon Sep 17 00:00:00 2001
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
Date: Mon, 2 Mar 2026 16:52:46 +0100
Subject: [PATCH] lsmem: correct memmap-on-memory test output

* The "Memmap on memory parameter" line may show "yes", "no",
  or may not appear at all if the feature is not supported.
  Because this changes between systems, stop checking this line
  in the tests.

* When --sysroot is used, do not read /sys/firmware/memory
  (used on s390). This makes sure lsmem reads only the memory
  directories inside the given sysroot, so the directory list
  is correct.

Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 sys-utils/lsmem.c                      | 2 +-
 tests/expected/lsmem/lsmem-s390-zvm-6g | 7 -------
 tests/expected/lsmem/lsmem-x86_64-16g  | 7 -------
 tests/ts/lsmem/lsmem                   | 2 ++
 4 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/sys-utils/lsmem.c b/sys-utils/lsmem.c
index c68f2317c..65b141c51 100644
--- a/sys-utils/lsmem.c
+++ b/sys-utils/lsmem.c
@@ -806,7 +806,7 @@ int main(int argc, char **argv)
 		err(EXIT_FAILURE, _("failed to initialize %s handler"), _PATH_SYS_MEMORY);
 	lsmem->sysmemconfig = ul_new_path(_PATH_SYS_MEMCONFIG);
 	/* Always check for the existence of /sys/firmware/memory/memory0 first */
-	if (ul_path_access(lsmem->sysmemconfig, F_OK, "memory0") == 0)
+	if (!prefix && ul_path_access(lsmem->sysmemconfig, F_OK, "memory0") == 0)
 		lsmem->have_memconfig = 1;
 	if (!lsmem->sysmemconfig)
 		err(EXIT_FAILURE, _("failed to initialized %s handler"), _PATH_SYS_MEMCONFIG);
diff --git a/tests/expected/lsmem/lsmem-s390-zvm-6g b/tests/expected/lsmem/lsmem-s390-zvm-6g
index fe3892f6e..40dcfe982 100644
--- a/tests/expected/lsmem/lsmem-s390-zvm-6g
+++ b/tests/expected/lsmem/lsmem-s390-zvm-6g
@@ -17,7 +17,6 @@ RANGE                                  SIZE   STATE REMOVABLE BLOCK
 Memory block size:                256M
 Total online memory:              4.8G
 Total offline memory:             1.3G
-Memmap on memory parameter:         no
 
 ---
 
@@ -28,7 +27,6 @@ RANGE                                 SIZE
 Memory block size:                256M
 Total online memory:              4.8G
 Total offline memory:             1.3G
-Memmap on memory parameter:         no
 
 ---
 
@@ -42,7 +40,6 @@ RANGE                                  SIZE   STATE
 Memory block size:                256M
 Total online memory:              4.8G
 Total offline memory:             1.3G
-Memmap on memory parameter:         no
 
 ---
 
@@ -76,7 +73,6 @@ RANGE                                  SIZE   STATE REMOVABLE BLOCK NODE
 Memory block size:                256M
 Total online memory:              4.8G
 Total offline memory:             1.3G
-Memmap on memory parameter:         no
 
 ---
 
@@ -220,7 +216,6 @@ RANGE                                  SIZE   STATE REMOVABLE BLOCK          ZON
 Memory block size:                256M
 Total online memory:              4.8G
 Total offline memory:             1.3G
-Memmap on memory parameter:         no
 
 ---
 
@@ -242,7 +237,6 @@ RANGE                                  SIZE   STATE REMOVABLE BLOCK NODE
 Memory block size:                256M
 Total online memory:              4.8G
 Total offline memory:             1.3G
-Memmap on memory parameter:         no
 
 ---
 
@@ -262,4 +256,3 @@ RANGE                                  SIZE   STATE REMOVABLE BLOCK
 Memory block size:                256M
 Total online memory:              4.8G
 Total offline memory:             1.3G
-Memmap on memory parameter:         no
diff --git a/tests/expected/lsmem/lsmem-x86_64-16g b/tests/expected/lsmem/lsmem-x86_64-16g
index d3232470c..52975be9b 100644
--- a/tests/expected/lsmem/lsmem-x86_64-16g
+++ b/tests/expected/lsmem/lsmem-x86_64-16g
@@ -37,7 +37,6 @@ RANGE                                  SIZE  STATE REMOVABLE   BLOCK
 Memory block size:                128M
 Total online memory:               16G
 Total offline memory:               0B
-Memmap on memory parameter:         no
 
 ---
 
@@ -49,7 +48,6 @@ RANGE                                 SIZE
 Memory block size:                128M
 Total online memory:               16G
 Total offline memory:               0B
-Memmap on memory parameter:         no
 
 ---
 
@@ -61,7 +59,6 @@ RANGE                                 SIZE  STATE
 Memory block size:                128M
 Total online memory:               16G
 Total offline memory:               0B
-Memmap on memory parameter:         no
 
 ---
 
@@ -199,7 +196,6 @@ RANGE                                  SIZE  STATE REMOVABLE BLOCK NODE  ZONES
 Memory block size:                128M
 Total online memory:               16G
 Total offline memory:               0B
-Memmap on memory parameter:         no
 
 ---
 
@@ -523,7 +519,6 @@ RANGE                                  SIZE  STATE REMOVABLE   BLOCK  ZONES
 Memory block size:                128M
 Total online memory:               16G
 Total offline memory:               0B
-Memmap on memory parameter:         no
 
 ---
 
@@ -563,7 +558,6 @@ RANGE                                  SIZE  STATE REMOVABLE   BLOCK NODE  ZONES
 Memory block size:                128M
 Total online memory:               16G
 Total offline memory:               0B
-Memmap on memory parameter:         no
 
 ---
 
@@ -603,4 +597,3 @@ RANGE                                  SIZE  STATE REMOVABLE   BLOCK
 Memory block size:                128M
 Total online memory:               16G
 Total offline memory:               0B
-Memmap on memory parameter:         no
diff --git a/tests/ts/lsmem/lsmem b/tests/ts/lsmem/lsmem
index 179f0ef15..057a30fd5 100755
--- a/tests/ts/lsmem/lsmem
+++ b/tests/ts/lsmem/lsmem
@@ -34,6 +34,8 @@ function do_lsmem {
         echo "\$ lsmem $opts" >>${TS_OUTPUT}
         ${TS_CMD_LSMEM} $opts --sysroot "${dumpdir}/${name}" >> $TS_OUTPUT 2>> $TS_ERRLOG
 
+	sed -i '/^Memmap on memory parameter:/d' ${TS_OUTPUT}
+
 }
 
 for dump in $(ls $TS_SELF/dumps/*.tar.bz2 | sort); do
-- 
2.53.0


