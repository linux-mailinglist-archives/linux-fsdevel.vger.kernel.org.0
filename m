Return-Path: <linux-fsdevel+bounces-36373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F679E2A4C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 19:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B07BE1666A6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 18:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83FC1FC0FD;
	Tue,  3 Dec 2024 18:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AB2IShO+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hA7i061Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAB51F1302;
	Tue,  3 Dec 2024 18:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733249147; cv=fail; b=OZdoMFLdFNcBZpFJePpc64teastjZ59X0+SGjsMhqQ+Vcxc2WrisyrqSuab3nOA2hcHAfzGNYGj/Jh6Zpcb3ZXSKUm6yQ07zmgU17mf2KBNMhPoRBnPbubKq5fcXu9qehB69Jv4Qe+Rv9KwBZnLHPrRCZUIk7VG2GHL+AKH2DLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733249147; c=relaxed/simple;
	bh=j3ESQz3DQ3jEiEv913m9ThwDbQC3SMIBEm6+VVYxJcA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FXlzfVcon4LdTpBeqMgqPSVm8FQgPkdwsKUzDpmxw7Qt1z04bOnXuOZRRpVGhqmT5BDQ6j6Mt8zWnA2AU92gvTMyYURkwL3bKeoSS9NIKJX1aMqXcUfOpyBAkLAyDxmwMoVL5rXF8s7/D63mtabDMa60Wp2RLeelmynibTY25Kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AB2IShO+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hA7i061Q; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3HtarJ032563;
	Tue, 3 Dec 2024 18:05:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=pVQZ7IZpM+mrxkcf
	X/JNZAZ1VT43L7FRc7e4RZtzlc0=; b=AB2IShO+gNXmkDpomgn3Jg9pyVALYfHL
	NreATOumtzg66f6NECdOnIYCHMz/URjFWSBZ5j4bI1WUc4W7BFsuw+CVWTuRsBaI
	unzpQK5fpscyzyWSNot01AcjktlumhobXdOKPDMpHNElApVPH7UuizD4zCwR8lL/
	+L5b8JsPJa/C7RzNMJTA2tGX6VgSKxuo9+lEUIQT89HA66HNswWYbNocyVHbhce9
	Tb9XZptRaeL73vePwtuml7fLtWAaBZOuGCg0EyGSkU0j49n8mWJaAOxs76hjxLpK
	iv1YhcQpZ1LnAJQ7RHuhzvbgRf1hBpiSNWhS7vN2EbWnwhAmlG/HKw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437u8t6mry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Dec 2024 18:05:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3HArUa031178;
	Tue, 3 Dec 2024 18:05:29 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437wjcupuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Dec 2024 18:05:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qmirec2opiW7xndR/PJxi6Q10maP/B4EGLKADK3EljSVxq10EROn0D141Tu/8F5l7ViWacNzfPhsjE/AaujQXtcpVPHx6Xgv79h3y+EG0j8YFOY5o87cH1jZYKJk0uTvRrOgLrhlO2/J+rcjOE6BOSqrBHpg+2+/Zl9YxtZry1x9ATNieQXaiVQxBcQbMK5tbcuRsc6XKxwoKQivGAlU2KwnJkZyi5k11h8UXDJtbVK3gjEzdP64vGI1SDZohQiKtQm7mr8fd9C1GxyKLDfGfdXx//kDUAJ4tx8+tKR5g684Ke92Njqqqrl0C2BiZX1ZAZmVzatJDn9cAV+DjEl1/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVQZ7IZpM+mrxkcfX/JNZAZ1VT43L7FRc7e4RZtzlc0=;
 b=W4EY42YHdf7AmwYglVUfD32geXMV5Hew2yuhigdf5ClIc/I9u7Pyh6ZRl+wF19hcJWmkCkONgBxJQf8zFIxUor60SXfqpz0xbZFXjF3RdqyD9X3HsR8rSgkF+B0Djw2Ks9ME8PlAKMkcUnonEYVzhKaR7TmSa03B3euATZlWInyL6XHRhnqLqNh1xbGWWpEFNfM/hg6Mcpq4rNEcMFTAVNhUByERiIyyUSEQOLr4lSVj1xunIaKQrlc+nJHnijY/Emw9Fhp70MVGjV/DO5Y5JFNw2VXmvs17yCb7MlfdFf/uwVefYDYnOwbHTDRhZ8H24TaHfiWidJRfi+lWebgvhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVQZ7IZpM+mrxkcfX/JNZAZ1VT43L7FRc7e4RZtzlc0=;
 b=hA7i061QDFMkVkEvdcamZy9YTHAt0WNQ2BjUr37r4w+54/5kyZsSfHArD26djqJwbBG1+WjmzZW8LsidLh90hZIBkvwCO658boZf9Ao/anZHLvyFIdtwcOjiuf5oJmZBwEAz224gzqBc1BjqOeVX3NcyglZFz6x/PTwEBOT9Nfw=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by LV3PR10MB8129.namprd10.prod.outlook.com (2603:10b6:408:285::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 18:05:27 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 18:05:26 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] mm/vma: make more mmap logic userland testable
Date: Tue,  3 Dec 2024 18:05:07 +0000
Message-ID: <cover.1733248985.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0253.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::25) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|LV3PR10MB8129:EE_
X-MS-Office365-Filtering-Correlation-Id: 5798af3d-d7a9-457c-9751-08dd13c510a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hjr+I3Cm+u0CGuWUVo4Jggy1ylJ7Nzd473Vx+lKYrg2+yhU8LA0hnqaYwMn+?=
 =?us-ascii?Q?KPH4qiYpx1INLlhLo52n+RYVUiLW6C0V4sZs2ycD/MpQnl1qJw7JH0g3sk0x?=
 =?us-ascii?Q?ppD8TnJDx5OrnaR6GJgz779+odoi8w8ayiPDfW6TAi+6C29EILnQmvsIbOG5?=
 =?us-ascii?Q?pzSl8gjesaP3TzYPWJZrgXHl5zl7LzCGldk9rZ/GLbHt7ZxYsbFGrgCfq0DP?=
 =?us-ascii?Q?lDyA4ObisYJ0Y3g0nREnywG21kxR0m0PmFhStnF/LWj6kpDGktHb82UYmMGF?=
 =?us-ascii?Q?FKm8HfDpcRHB1+sBWZGE1da6ApppoTUOsXjsWdoEKhpi1kY9d+PdGv7T0cAK?=
 =?us-ascii?Q?WFlaEH7ajPAyV/ntGKCXfL/ItVcVwx3hLfDl6xT69PUkFq9vwF4veE9On+YJ?=
 =?us-ascii?Q?0IXyB+xNjQs0aJOGwhNUftMTzfbpXpisyP1Bs+D5G7PRvTDCsNnvi3gaSgBH?=
 =?us-ascii?Q?Qw8arg6jdfON7LtHx842OlYb/t/3DNBTH9cPJit1vkoCUGzXEY1CYxHQIMZX?=
 =?us-ascii?Q?49ObODxV4dEbSBcughsowezKLEIJvgqJ94nOS1ofGVQy8atngCVcUgJqAYWz?=
 =?us-ascii?Q?E1yotrlgVGh3iz08pJ79KZ2YFfSPwhkePvV9Pl+OPIL8s9oXK5xbrH7sKCDc?=
 =?us-ascii?Q?r+GOtjsS74Xu0OX1j3sMUsXDfcBtoAw4WX/IMiwCCqtolROOlWkwh5PWn7PX?=
 =?us-ascii?Q?pb6rChguOBKlozCj8lAfl2UKSKUbXLqw69bQIKEjaDeqkIFL5U3gNGfuaPl+?=
 =?us-ascii?Q?WmMf8lRy4Axo4gLnNxaOIlhNtkYWldh479pvRX6mHqZ7z+lmsgvl7jDRe/UO?=
 =?us-ascii?Q?bjDuYQQ39H7TzUeqLXr25EFNge/19azdovyacoKRl7+IEPw1sWG3CDdVibnY?=
 =?us-ascii?Q?pd3FVbgyemYZQvGto+N4nU/UQXQa7naL+2lDUW9YiaQrHsBW1Crc0F5BVFsz?=
 =?us-ascii?Q?AfTI2Ou2gCq/sfMqRTuumeOZZwU2GC3LKFenrfhu99D41eyLoaSJTAL0rD37?=
 =?us-ascii?Q?5e38KrG4lFn/ZnxOE5Y07mE2c2CDbCFeJsXN3OjcGKA/oQwLRYqcm+FDb9Kc?=
 =?us-ascii?Q?LRdoaUncekvy5SVUw2oVoJgjkuTJEO7JZQaub/Aw5WiyAI0pIB1+WBf5l0d1?=
 =?us-ascii?Q?7m2nMjUTpAjpw1/eGbzopNUZiWwkzjJZbxEoWObEoUXtdI3Kpmp5f+FfSRqk?=
 =?us-ascii?Q?WlJ6PMlKrsoAKzb7hxJ7bjRWdbazRFiOmmVBXX7W82BV/DvqXKNpcHv/ylVL?=
 =?us-ascii?Q?P5jAJG991u5U9Jc9lm2uRaAmMagwGizEWp2ksI3bDpo2VJTA1cLci6vYxFqJ?=
 =?us-ascii?Q?wkhVD8yiO7fMOaXeOoLFEsyQxdrocuUPbsFf1gGJluczgA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eR1eFiiesklYC14hhsMztG8PP6mJQ5Q2unGSFt21PFAYs0R1QNoag+tHS00k?=
 =?us-ascii?Q?EFYcVjmVJb8iXXmoOK6vtEdQD0V4WBEpxn+r/ZCwKmU1fimpXQsbHXOTy6ah?=
 =?us-ascii?Q?9wuOaIGtLuhR3mvmA/G07Xt3QSzIlSCcAyz1nr74XN61TbUHLyDawjyIUFEd?=
 =?us-ascii?Q?OWd5vKR6uS3Bs5QIJPFMgADIw4MekPVH4Ex0ZP1KEbnF/hi/mJZLND31VEsl?=
 =?us-ascii?Q?3uzFfTRTcIxcDb84bRcfn1pVE1n2PACFtvyV27jJ8TpiEnKwYbm/O7jHKyhy?=
 =?us-ascii?Q?Aoq5rlk/XFgNnsUTi643N/rdRkX7Db89WtOgjJICUCcm/d4y4a1RfVGQ9BRz?=
 =?us-ascii?Q?2Wpu/7PuED9R5CuY1Hr7y43V9DUkflnGT0FxxVuZyS3bnRdwY3XGo/zmEXvl?=
 =?us-ascii?Q?GvzegH96oUmzvBG/1odJRqSE++1sWVnCBPd7AU8z2aZfVVN9LtvraSPj2wSb?=
 =?us-ascii?Q?c/Vc1TiXw3FUmF1Q1i4takX8pv7u3dEjQRzgf5tbWNDXIQ8GA8oC4YLQdmpH?=
 =?us-ascii?Q?QvTRaIituNyiBS9dys3dTi+C/oaLazVxXgsOGHu9ukHD1JCGwe1rK17VH6ZQ?=
 =?us-ascii?Q?9p8qFcZ4rBLDdls+mq+Y5KCzeUJqzFuICCJK5+5t4jMhYGYLnXFExyP2MZ30?=
 =?us-ascii?Q?t7WBMJ0VyahqYsDRY6mntzVcCw3DmsyNVz36C/U77uYM6Lj2XC80Y7Hf56CT?=
 =?us-ascii?Q?vy/OfYRRZtUCAoR0gMalQxDixeOJGrpDgctTFL6FaFqabfZp5SDiK8il3M1k?=
 =?us-ascii?Q?GnFneeod7nR8cGutwDzDAB7NAMlEuIKqmuy/Yq8IIuqcur83UPqxIpk+aRgX?=
 =?us-ascii?Q?mz52oHHGeX1Ig1VFd7FxTRP76GeuPUNT6ws1FIXrwcpt+ejwECH+gTy0u6LZ?=
 =?us-ascii?Q?rslqYI4ZTRB/3Rdlbg3SG8YligOT/Crsqqak1RONBPjiR6+ARqg4K5dA5F8f?=
 =?us-ascii?Q?jNso8kvhavUx333HOYXm03e5kwvEC4wnjmki7BZFtt2Yu3UG7TAn0Uh2Ol6u?=
 =?us-ascii?Q?SeBgWuR3QPicHoEUqwwBlawqnd2GKNQgbPdM9DhAa27HRp/lXnMvmTpFQ9I8?=
 =?us-ascii?Q?mgG3IVJfPWxZZ5VymYhW9SiF+Zvhj3H6nvwV+qok63Zm2Ii8XI0ejWBMmKgI?=
 =?us-ascii?Q?Z0Pfi9K31y5PAwEhoqHJqZhBbNYFn7I7TVhNkbzEDntm1wgAdyZKHh0BM/lV?=
 =?us-ascii?Q?OOrwlawB4Txr0ub+eUWUNn5v4XeMoSC2WBbjtZs/BrePfS30QyjHByoYv4oT?=
 =?us-ascii?Q?/if6QGya8xoJ3iogTRsDotBbHNAvNLvmUZgrA7+Bl4xHbRteEcUryWpjrdu7?=
 =?us-ascii?Q?j9beCplTlbUDQr87hRtyz9cK6tUAzFpbqYD1rXCZBD3FdtXiqiubSNDYxevP?=
 =?us-ascii?Q?7G3/ry3CixZN51YdKxcRir2MI3rcMy6Z7nxKnlkeGoX2epNcZ41K5fJXuqfb?=
 =?us-ascii?Q?BIeGimyAlfrPrkGa6sQVbwZIOTrcgzr7sMoz86+s1KZfXJUFhvEg8lFPygPp?=
 =?us-ascii?Q?UxR7PwUeLVvAz4Bp8NKS1fEFqMrqL3TITHLvyLvTDcauqIqZQ29ju0wM/5r6?=
 =?us-ascii?Q?OndXzgtgj3HUGcvw/lcywR1XP/rNL8Ww1EUnffj2qsW6WjOOt4wAePB3+5kc?=
 =?us-ascii?Q?6Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zV80u7FA5qX6KoE//yGVLoPQQ7TtO5K0bttKRvG2jqaUfuFJqTJPqkcOvDRz55ccTJ5t6xbmgiko3CnsxViftuIVk6R5XYdPF0dCHwqeIwxBXyfEwKVTuJFV43yNdLSQNcHbqsiqgHnnJa3dsN80rje7um5kdUPO4+NNAI8GUphZVADpT/ekoMjyFUj1fZCQ98yNetwVlueFmMzslk1Rv2LbBKuoF1Xcv9Ww7XxTGJ51Ix2z0iqu2KTRfsll76ZppkqYAdoTCgOv+uQPwusXDbkax+y6jCTRSSe0EMl0slEdR8gFHUHFX9LdEU2dVUu1pqPzlL//Zry/+wMdxlOJt1f0R4Kq02eXMJ3RQo1dcbcW8cGbNDqlAOGXeDaD2hejVFql/GIPnKkN8DflLo5SBwWZlFulSUDKTTGFGzpTEfxKxlpIVJFGJnUmaEmOv+xMvlzFDuKFLLITdWYVb4zZbU3ZR4fvAytCt+hJpOd7JzGNoySSYRR6nlMGFkQrNCaKLWeNTxaAvGD5I9UZChyOTBMO6Ig5hfGefpC0uHT2je70t9T/3s9dh5z0jjZIcsQIUkUX1OU+/d7ZZJemCaSU3duRqOOqkPASEnTqNXi7MOY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5798af3d-d7a9-457c-9751-08dd13c510a4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 18:05:26.6570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eTpwRfow153VTw39AYgzB3RovVZKfzgPmsWYUMQwMNBRunaKfyvmGpnFRAPVUSsd0o1ZNdZVCpnWSEC+h0SpnlN1kQY5aPjaZiI3e4qidic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8129
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-03_06,2024-12-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxlogscore=998
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412030151
X-Proofpoint-ORIG-GUID: P8KLB9qigLHGue4HrDNcMuDMkXB_Pp_s
X-Proofpoint-GUID: P8KLB9qigLHGue4HrDNcMuDMkXB_Pp_s

This series carries on the work the work started in previous series and
continued in commit 52956b0d7fb9 ("mm: isolate mmap internal logic to
mm/vma.c"), moving the remainder of memory mapping implementation details
logic into mm/vma.c allowing the bulk of the mapping logic to be unit
tested.

It is highly useful to do so, as this means we can both fundamentally test
this core logic, and introduce regression tests to ensure any issues
previously resolved do not recur.

Vitally, this includes the do_brk_flags() function, meaning we have both
core means of userland mapping memory now testable.

Performance testing was performed after this change given the brk() system
call's sensitivity to change, and no performance regression was observed.

The stack expansion logic is also moved into mm/vma.c, which necessitates a
change in the API exposed to the exec code, removing the invocation of the
expand_downwards() function used in get_arg_page() and instead adding
mmap_read_lock_maybe_expand() to wrap this.

Lorenzo Stoakes (5):
  mm/vma: move brk() internals to mm/vma.c
  mm/vma: move unmapped_area() internals to mm/vma.c
  mm: abstract get_arg_page() stack expansion and mmap read lock
  mm/vma: move stack expansion logic to mm/vma.c
  mm/vma: move __vm_munmap() to mm/vma.c

 fs/exec.c                        |  14 +-
 include/linux/mm.h               |   5 +-
 mm/mmap.c                        | 469 ++++--------------------------
 mm/vma.c                         | 478 ++++++++++++++++++++++++++++---
 mm/vma.h                         |  20 +-
 tools/testing/vma/vma.c          |  11 +
 tools/testing/vma/vma_internal.h | 152 ++++++++++
 7 files changed, 681 insertions(+), 468 deletions(-)

--
2.47.1

