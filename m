Return-Path: <linux-fsdevel+bounces-54076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AACA2AFB10D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 12:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 516561AA24A8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 10:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5BD2957AD;
	Mon,  7 Jul 2025 10:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bJCJbZfL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AovjWj2N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D0D2E3712;
	Mon,  7 Jul 2025 10:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751883672; cv=fail; b=d0eNFYuk1LMtSPF5oaYxP+wnA4a6t4WKHPCS2v0vibA8h3bucNL/9Zk7iJGqJJDXfthELeyg+tLQhB5DsbxlTtWiXEgHpZJT2cugbjXve7CXqKYI8AapA4+EKbjQDRSgyPld8lf8cNRr/2elis68Cin+x0o1KA5vhoxWJtt9+W4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751883672; c=relaxed/simple;
	bh=fobXMeaj3Z0/29o9kgRPWL5vGRb7cVPnz7HOllc3/x0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I8jX7zo4B5m7MR6P+ictWwr0vNUjl9lK3AQIBV5MmirTeeLT452/VsvEY6EM6GS09B7XL4G0/BwlvwqNtGk0K/tZrFiaGVmbXn0fsVB48+cZT9I139Zkap8/0IJYnoLzQUTyFlJIbzkSQAAaUYam3d07JRwirnrFZQkLfzwoTLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bJCJbZfL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AovjWj2N; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567A2VVw011155;
	Mon, 7 Jul 2025 10:20:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Roe2pWsciMdxVcOXRv
	zovjlLW6NP0cP8Ilkt11+59A8=; b=bJCJbZfLhi28oWajQ1+uX7GyAoGRxDCL94
	2t2coYRQ/DAtJjszh57pcXnVUbGXGLj1jW++t9/DaRVuNqRvaYWb9xdRLDvNE9P4
	B8s7n0V4v2ox1nqQ3BraaDyvPk+Z1bZu2CHa7adI9MTNeCsWXyKFQXAtj3XYbx1U
	+ThdfgX2nkZV160YsvEcNPk6pTRgMaqElgrvwclxFumUpe6v4Zdxeiilv86tVYT7
	BoEnTFxx4SGLFS0rdHcAMPUJTx0xe0cyK+N0dTAubJ6xD7cI1VHNm4UTIRzO87ea
	mStnzii0PryHAwNFWXTdYZ9pYDnQbvSxuMGBk7BbGt8iavf7Jpqg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47rc4hg13k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 10:20:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5677xUes014241;
	Mon, 7 Jul 2025 10:20:25 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2088.outbound.protection.outlook.com [40.107.102.88])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg82b3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 10:20:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=reuA8CXLWU9vMKNVjKsjoBrgtR3r1M0aDpNlUxk42uk/2FlipH7c6FK8diW3VoYZTUij+PckXrFwfqa+iQRVMSe0r3WhA4u25ZsgcMXQKe3ocvM1nfuebo5QsvZLvEdxWUFG8ZmwA9BKfWeMoXsa/XeCY8gF8nfk1I3Veq0HxiyV2LOzFMmKPxoMxzfaun5zPSg6BpCm+noGyPKbx0rwVxPy+0KVaGNKOHobvueHJGOy67lSrdVkxahWyj82s0JFL7aNnVcGPGiq+3HV8I/+MBmDwjqyms2TXcTCpzgSaeQL8DfCeEIErMiyyGVxh5KfI3ESImsGFllQ8d0U+esZMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Roe2pWsciMdxVcOXRvzovjlLW6NP0cP8Ilkt11+59A8=;
 b=I22+xFXvCat5P7J6IKfPUplRXIhbVEaB/tzkeg4FLy57CFXFVWzwy6cOzigLKJ1KkMvrJmRJrGi7EGRodVXdp1XX/U/bm+5NizmYoEZNfJrpp7ZSMYghOjhiCTSHU78zNoIIIhM2YamvLkvHuZ0Mph+VM3O7aOS0CM5Ar4X7e4LgJwsKXcCaVDM40f/hMuO2MOOFkR5qFOxa+Pp6Wil4JwWoQNhqjyPaOLpWH65Vlu7xEvYOvxUO3TeQ4lixzsX0++926ks3ENjW+jDQQsZ2jSn6ZNxc/HvHr25vKQGPoUyWLCEHDg+CnFh1sqXzVrrTPFNkY3ZjVTNPLJ1Tft86HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Roe2pWsciMdxVcOXRvzovjlLW6NP0cP8Ilkt11+59A8=;
 b=AovjWj2NopW66l4rw1WCrVLDpeE5P77+CeVUGEkRZaeaWybxfVbwhloXhdrwxtaT0NX1j3x56San/DUKGfAz/0fRFxJBLDP+pnzzgznaveV97pySMf6U/ZtnEpsxGl1IUPV3VYNSNWPa2e/lLOvT5R67pp4ahfnCMcyKKFQZZQE=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DS4PPF3689F8B17.namprd10.prod.outlook.com (2603:10b6:f:fc00::d12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Mon, 7 Jul
 2025 10:20:22 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%4]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 10:20:22 +0000
Date: Mon, 7 Jul 2025 11:20:14 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 05/10] mm/mremap: use an explicit uffd failure path for
 mremap
Message-ID: <82875d66-b498-4631-b293-e6685a8f25bb@lucifer.local>
References: <cover.1751865330.git.lorenzo.stoakes@oracle.com>
 <be3e068c77107d385d89eae634317cb59e04e5ba.1751865330.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be3e068c77107d385d89eae634317cb59e04e5ba.1751865330.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P123CA0082.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::15) To CH3PR10MB8215.namprd10.prod.outlook.com
 (2603:10b6:610:1f5::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DS4PPF3689F8B17:EE_
X-MS-Office365-Filtering-Correlation-Id: ca1d5b25-e2e8-472e-b293-08ddbd3fe1a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p2BKq4NYxoA/pD87wgvASkUehnYGoJ+Aj8YQAbICCyCMB/NX76UkdDUvLO8U?=
 =?us-ascii?Q?msjacT/+dxaNGX+4uOyqKxqgcSBeLFFyd9nj8SKxM/NC3rOWL1WUiXFdsWZV?=
 =?us-ascii?Q?nB3yHOU1VWJpYHGhHsHLg/bgVAGuYW2NFsS+bUItmWTtaFuoj2mOg4dKr3Cc?=
 =?us-ascii?Q?2Iz2bxWABvA4cZr99zbH2zra7j8j01zD9zJaVSp8RqUOmU8c9Ydil2vbZuLw?=
 =?us-ascii?Q?1JmXOBb+ARIcxiynzsVQCuzWC/7E5yzcgMf+CIDoFCucmjEmN0iEuVVKUq6m?=
 =?us-ascii?Q?Z3xzsWWlZDTRpZ3Q9k0g5hJkxIDTbXKXi/AltsdLgeIYFBrOAJ9rgpSvMpqL?=
 =?us-ascii?Q?x9pyXSG9FQ4gRCJz1q3msSGaq3G3qTxf6+8fGCu7pT6yh03sq+GEE6JQVkN3?=
 =?us-ascii?Q?UZmeEQql34UUVKgiFeMZ1Zso1+o41AON7ONm8Iyi3jDnBhxEp0Gij2Ya/078?=
 =?us-ascii?Q?oYUxxGzd42McI+fR6qQyhdXtOvTLjjjj2MbYg6JQ59NIC3YMk1a/WTSyB6XR?=
 =?us-ascii?Q?LW7IjKB69Z+5VdR6M2n+QtSKrd2C34O0ZPDuZ9y5Tzz5tvnoJ0z2AC2O5m1e?=
 =?us-ascii?Q?qNenymYBpghUUwJjDBgBDz5C5y6lYdAwY6RTUmuDjK8iNeOA7nq79noTbl1+?=
 =?us-ascii?Q?wCL4IP0wObGlX+TjvA3H4/jYJF8ltEWqWyjtQ5XcqlqRp4CGspOrVXGLkMng?=
 =?us-ascii?Q?0nEZUxJqHMiEnQAA2E15e37f4IoxyE2y5UnrhmvOCYnWys+UeSH3sBXzipZ4?=
 =?us-ascii?Q?WcvcfX4KzlZv8fhSm1AOFXEWycpoEsStmRWyy0FMEZfiEAZkIzXf6ZZtKdMb?=
 =?us-ascii?Q?QK6+730t9DdP4LRg+QfHKFSDj2Scj649OqQ/vaFtt0mulHDI2FmbF//E4QPU?=
 =?us-ascii?Q?jhgRlv+fr8IAQoHTqa8PxRZPWN1nuRO2LojYW+NrQtcOw8c1mb2AdUzCh0p5?=
 =?us-ascii?Q?TsR3mritF92WILxItQHOmKGEWYwB5t7qK0fXWWTPxrfbh8z6DbcC5dE6Wl14?=
 =?us-ascii?Q?fxTEXXpraKh5fwkTwMx38bPGycKVdQtrtt1xNR+bFmsce+WO2eR8WNMXsTbq?=
 =?us-ascii?Q?Es3n7WRvqemdNwFK0UxCvVfKgjl3XG/EGCxmsdBzNFnur5TsOAHqo9tIDq3L?=
 =?us-ascii?Q?MvvRydkB/1p9mtWKfOsaQML4FssN0e1JviO2qH5OT/n9iqUdZplydxfxw7fz?=
 =?us-ascii?Q?wjmsTHEHnQWBjegMC//h5cgJULcTS2wTBsoiVl5QPOhQPV4wN0onuRw3wMsT?=
 =?us-ascii?Q?2vq3Gdrw7ssaLYqZHYBcGJWTjQ8lJwkp7EjKk2wOOJm4+/5aui5Q9ePvmEHb?=
 =?us-ascii?Q?UdeeTaBbRs8UckiaX+XwNUYxnoZPha/ZtehYt+aRUvz2tAnPXwbZ/Uf4ywf3?=
 =?us-ascii?Q?Dcfr2JLwZ48TnQ84jwSCJysc55j+0n0rhGYqlBOk82+XiXENWMlmgVHiZgh/?=
 =?us-ascii?Q?IljZUFP7/EI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qrWeJRCThN6f7UPeUIjQ385EganJScWLxtg9sEp7990GNwYBG0vjzDRQtTJ6?=
 =?us-ascii?Q?1POMB7KXLoetoafOCoBTeLATz0+By5jMvoPNZCmqE9A/KJ1aTKvv7mjwGrkU?=
 =?us-ascii?Q?oewFxAoL0SMkfw0rIhQ9T74Rk69pxxJcpJUzYaSThuVjlnji2+1jeIcFCMvS?=
 =?us-ascii?Q?ZBCjsV9qBc7JATs7SKd08NwD61cPgHHTMDRiZ2PN+TinZs/Gs5TX2wrgrmLh?=
 =?us-ascii?Q?bbMGiiFeaEANmOgdPUicsn5qY49TNRtTS9H4RPSJ/9CoRAyrSigr7drkpTU1?=
 =?us-ascii?Q?x2oKimFBYsFrdq2mRp2fG0zonSGMZVq0QL4uroWacZ8jSSXezic1bQZ7ilqf?=
 =?us-ascii?Q?gnR6sOtzSROypJfHKI4UsU66nNCwj+b6zJrp4HX3o4Kgfr+DquhSvpsI1VtG?=
 =?us-ascii?Q?6naB/YDRROD9hmOs39Ix88pd79qWfR4Agm4YvzSneYuiGlMvceeSHsYJKigy?=
 =?us-ascii?Q?w0t1aPjLlLbt88Re3Pveb60EQbuUrvcR2RhtZNLvRQ8hFprtfoVIOrkkL6eS?=
 =?us-ascii?Q?mLhpVbkznm5bJERlAOBxLbECnyqasu2qWpal+Ymtg7mzQv+RGmWb1OZKtMS7?=
 =?us-ascii?Q?8NYDJA6N2wzupIVFiryX707LqnCLbtfgWpd9Bzyk8eRtQGNV6fMALlpoL3Ra?=
 =?us-ascii?Q?Fkw02rMUNuQLbUp75ETYuY1HXUpA4fL0jZ9mclfO7XIX87zD4sOveomLFiY0?=
 =?us-ascii?Q?xOOOnFKB8IUvQzZlXZoGS//y5YXpjZN26OmZh18D1RjddFeTP5a6U618ZOiw?=
 =?us-ascii?Q?ftXAx20MS7GMfVM3bUU9yM58YlmHci+VywMFpUjrGDiIyex6GJTlVpLQU2X2?=
 =?us-ascii?Q?gc3ATFwtw80ISdNUkOSsEgk/G9LSKOQ6TYc5YlMsKlL8JLhnchXThUlljJ9M?=
 =?us-ascii?Q?CSd5yYFqpXo5nGx1Fuc4cOjlUgpOfOKi/NxsXsSerUZSEj7FFyIV8fqQHiPo?=
 =?us-ascii?Q?O/oIjWZ08VTeWp0UUqkSIye5eFFS/D03i+VW8naI5kUDeSwOoNq3CiVoP7tQ?=
 =?us-ascii?Q?6zUcRUCSeZK3agWqHtOC1fdZFo8L59SvWFuBgLQljSLjGGU2mU8oMzBEUkLj?=
 =?us-ascii?Q?zI4oly5/VDQRbcibnfBTHwg/czamS5O8UWtF8SaVPYIPCmr8oHtg3QVAQBYS?=
 =?us-ascii?Q?f4oEm7SgKWCpqU3RDgf4i26tik3mQV3npfuTF/wP463Pzbv8ZDsycLMtZuW5?=
 =?us-ascii?Q?X5At03scIXgYkfqd3p99aj7v/S2noinrqRw/0CMn0SXf+KXfU2IQLloHCVE6?=
 =?us-ascii?Q?EtTlkcoSW2VkPhHYXIHNLSGrhnmIurWeK0FdbE9B+lR4ZiZvzxPQzvHewzQ8?=
 =?us-ascii?Q?97PkJS48TKxYrzWpOCPKBFyGNvvu3xwekd6YcjL9SPoNg5uraR1EA22hw+v5?=
 =?us-ascii?Q?WyJ8LFBH/4fbLq/lRW8A8bNKy1ai+QYnY7FFU3KLuY1fYGroVN1N6onalhzd?=
 =?us-ascii?Q?SnAUENsYvyUMaUxlfltfrVuPQe/px/DGb/2JveD03bAoNWCjecvdFDMZ7ZEV?=
 =?us-ascii?Q?zyK5GCMIGhlTsIwSuvnY+vJV9SWlzzEZtnpFfhi6jZIXFllcHm4qZdy+Ch4y?=
 =?us-ascii?Q?YBSoJmSE+kJ0oGJbxCvrPfH/YY02AT3eBM1KhVtwj7wp8Mqn9zYEwgVJsdjd?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	t3+RSsyTYbHFI0oiTMyjd1OMGeMz7MZTzHBm977ujJ10e+0AgRmR43pL43fO9rXX+gZrkrnR4MG0AabuOgsf+3ekhHdnsaxhrjSQhHE1wBiEeY6gKHOUn7KBbMQ5ZopTFkgau7ELYBc8aPikkihdIObfWStcjJRX9myJMITjI8PmWPpAkr9zRb7aCtlNgmaEy7kae32rAbVOJ8o3JuU6fXIbFSDkdj6DnLo+SH+xzw0asU7NLwz2OaPRzGGiy+dmNIxB7p1N+Ruf8Nk6xH+se6wXnX8VzWRBxBiWwM5ObuW8nx3uv/mBBz2uU2iGoJsY2/MoZrFkPnQdopHWqQug3FREXu+g/gBNiRIfJ6aT2STN5Z8f60ofSYjLTF388GwTwXtymqcOY/qj+YWDy+A/Bj8dSBmUO1XJZpGizByZ3s+gdQ1FKGavrUE6sOlMUYFxOHPxUNyOHgik3N3ck/lsi+pcgiy3Ra5feGOfepcUN0ME655woygeeTLz7UtXMaMnqESCUsSGCcW5OW3L0W5PRQAPNyQ+KlJc9f+Eaq0Pb8EgRomoUzJMVUBTsU5qJts0emZGpm2zASrGUhRf3kWrPKZnlDLVnInNZdEpuiP9WKo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca1d5b25-e2e8-472e-b293-08ddbd3fe1a5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB8215.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 10:20:22.7814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9bEkuUmdmNwjCEI9+BjcsPW2gRNRLKVq17IUtq5ym2j76yMXYf8uoaGNxUF29NBdCoatTzANHpRFbfRXBK9dKJz+KskEK+Dv/vHUfJ0ojnE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF3689F8B17
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_02,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507070059
X-Authority-Analysis: v=2.4 cv=N7gpF39B c=1 sm=1 tr=0 ts=686b9f6a b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=961j1mB8GUa5Ns_nWcsA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12058
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDA1OSBTYWx0ZWRfX49bHhbdhz+hu uOzXQ9FF45N57MFNBhHEeNocROxl374d/Vh89ZkKKrHAkd82pJFIaVh+/+3qjSoQDdYlmKXtS7s NB5ZUxqQAF2PiVNIAcx1QcTitcZzdjlI/hJcC5vR8ZAH5we7z5wMtZxOJYgpg/vNSUQka6zgsQr
 aSvzKB7+1AjqZAOIFnm9JKrjt621HOrlguAm7vQWX3Uya+2c1gS5d+OIr8Ko/92OhhQBpzqj6MT YJPY36yOEQrVgcsheHBh36tD7xUBNoiFhD8iClVkb/qXcJ5NFdPVq5r6QGl0/npnxeu1BRY38S/ p1iuK4RC0X4ygg0yRi+ajz1wR8uS01CIncsYZMJPudt5Wsarr65y5QA0xs1jVEnv3RBFhKpKb8/
 9B0UIDZAof4aJtJ4bBTL2eZfdVWAxM2/hquCP8BhCYvZLr0gen1ux/NdecfZo9Iv0H0hhFQC
X-Proofpoint-GUID: 7wdI_QgfKY45Ve-5qOHwSnzOD2vHa1Xq
X-Proofpoint-ORIG-GUID: 7wdI_QgfKY45Ve-5qOHwSnzOD2vHa1Xq

Hi Andrew,

I missed the !CONFIG_USERFAULTFD stub, could you apply the attached fix-patch?

Thanks!

----8<----
From 048bfb6ee415843bd584c64a2c6e6be9b1114962 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Mon, 7 Jul 2025 11:15:18 +0100
Subject: [PATCH] add missing mremap_userfaultfd_fail() stub

This covers the !CONFIG_USERFAULTFD case.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/userfaultfd_k.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 6680a4de40b3..c0e716aec26a 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -372,6 +372,10 @@ static inline void mremap_userfaultfd_complete(struct vm_userfaultfd_ctx *ctx,
 {
 }

+static inline void mremap_userfaultfd_fail(struct vm_userfaultfd_ctx *ctx)
+{
+}
+
 static inline bool userfaultfd_remove(struct vm_area_struct *vma,
 				      unsigned long start,
 				      unsigned long end)
--
2.50.0

