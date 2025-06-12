Return-Path: <linux-fsdevel+bounces-51493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6590FAD73A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 16:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC0983A2D3B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 14:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDDF247DEA;
	Thu, 12 Jun 2025 14:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JKOh6vnl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EOlQM7Vy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A264C2472B6;
	Thu, 12 Jun 2025 14:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749737828; cv=fail; b=gu1aegzgemuTza6LdF5Q+I11jErUwlkatevuGem/jQ8nw7ehOJSubdrblNKVR5pXJHwDP1Wygktu5K36lnEs1Oq8SAghz1gP/+4YgKL9WN1pvhyS51SYlDdu8o5dJHl085Fk00k2P7W5/umkr7tSurGJt92uu31g5oao81QZ9/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749737828; c=relaxed/simple;
	bh=wh75iwSkzPgZtf5dvi+AKCaZ9lJHSNz1rZ6vuF5jzZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q3XamrJbQzKN9z7gnrL/CbZdfsWY34BHvzkSx7yPVbOsV/uu1dwjQdhuupFibKYzyQPwIyEbeuyZURihCyglFJ4kyYrZAfSgw7ppbWKlyAZh3VXB/b8ekufeizfV2RBmxrgdJJRa84+PYC/Kt+BUvr973HCYK3EpIH3Eb8NW94k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JKOh6vnl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EOlQM7Vy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55CDu2eY032377;
	Thu, 12 Jun 2025 14:15:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=H2PsUpfei5npMzjxrp
	2K1BudGv93X+JICYdeyQv9PuM=; b=JKOh6vnlTAmSD5BsvX4yk01g2PnYU5Xv4m
	gBy+Tue0tQFGrtlk2YAY49f8Qmn3UdHdY2MH6AO9+Y9UnnXJVSLFUb0ah1VUJKpu
	0CR7/IZMDp8KLALMAuKhsBrYoiqpr0OpqvZFQ7Y0rtm3H0RRLPmUbAjBo86iF0S+
	qA2ehFSZBLud2AysAfzBLGhv/XFc9mcLw42OuT3sAC5//TvOSF9u+NvBOKmdUbvl
	L6T+9jOqb8ra+HaQDW5GqLr3X3OCQbT9a72tfLK3pmDz6bB1opfzgfYz6qsZhzHZ
	yGXxyE8xZaFEBCxlwaeQmV6OdPgDXnIPl73l6WTMQPuDoaASx7ug==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4752xk182a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 14:15:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55CDem0V016765;
	Thu, 12 Jun 2025 14:15:38 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012045.outbound.protection.outlook.com [40.107.200.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bvbnmfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 14:15:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fu6KghwzJ/WLUm/34LTsVbM2Y6pqhr0xGM6nPFpFSKelFYvsCZn8Ie0kC9Dyqekv0dlgtliU860nCAqJnTdOBYwnChIh/qFEsMVvqs6QLN5T90UuxJpoVPM0fIuAPpDSQDBuYVF0KArmi08Dxcjr9rUhyQngwbWQCUXuDCUgcTt1ATaLXJyo6N73L7FFwXT1ezNcmQp7p1AnBgnYT6KTngpykq6ZExCGPMXYcEU/N8EY4v8M6mH/mhjOrRiPMf7+ijazlMgkTyE4yS57EFc0PKI1/oCTXPrmQB0KJKgeT1Jkj9UTin0DouQI5U6zA1E95SIZtg4tFltcMug9LIdOxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2PsUpfei5npMzjxrp2K1BudGv93X+JICYdeyQv9PuM=;
 b=qVJ6/URnG2ySFmXF+wZSrGID8LIOQvqdcrp5ugVbHomjEJn38QruzFUkpWH3zKDvQs7CUmFulgesHZQEbNASa03/fDow3qDFUl8S5jLjoHs/PgFY2ueAQ34NdDwbsf+PDjL6rpIXMXyL/W1MX3pRVwL9S9YhEJ3zDPmAotZN7abNyFC9gySNU5smfR7wbE6Sa+fK20+LhOS/qXvsOJCSr5nu9yqqeWVzCs45jXdAdDF90wb+L3Tqnl4uYLo8ep98KyJHYDo4NdO2u+EePtSDfFsZ1bbeSrmxbNKErlsO+6iOcW20UhxXuDAjZNTb8r948ZIKJpQijRF47RPp+X7ouQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2PsUpfei5npMzjxrp2K1BudGv93X+JICYdeyQv9PuM=;
 b=EOlQM7VyL6tiIF1FwXxQUaLDDdgfzNs7oamVuyBviWxBG8KlIebDIxhXCvH0DoJon1ynB7lduzMttlaAyBFmdAGcKVB1UtkEZwRLjVTit2QGa/CO/HJho2TfIEUbJY2al46uPFazxemran6ihHcr0zDTV2Hz/UBsTvobyOEOWcY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PPF751CD7230.namprd10.prod.outlook.com (2603:10b6:f:fc00::d2c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Thu, 12 Jun
 2025 14:15:34 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8813.024; Thu, 12 Jun 2025
 14:15:34 +0000
Date: Thu, 12 Jun 2025 15:15:31 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Alistair Popple <apopple@nvidia.com>
Cc: linux-mm@kvack.org, gerald.schaefer@linux.ibm.com,
        dan.j.williams@intel.com, jgg@ziepe.ca, willy@infradead.org,
        david@redhat.com, linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
        zhang.lyra@gmail.com, debug@rivosinc.com, bjorn@kernel.org,
        balbirs@nvidia.com, linux-arm-kernel@lists.infradead.org,
        loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-cxl@vger.kernel.org,
        dri-devel@lists.freedesktop.org, John@groves.net
Subject: Re: [PATCH 03/12] mm/pagewalk: Skip dax pages in pagewalk
Message-ID: <fda482ca-ed0a-4c1e-a94d-38e3cfce0258@lucifer.local>
References: <cover.541c2702181b7461b84f1a6967a3f0e823023fcc.1748500293.git-series.apopple@nvidia.com>
 <1799c6772825e1401e7ccad81a10646118201953.1748500293.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1799c6772825e1401e7ccad81a10646118201953.1748500293.git-series.apopple@nvidia.com>
X-ClientProxiedBy: LO4P123CA0437.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PPF751CD7230:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c095389-e798-4bc3-c10e-08dda9bb98a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OlUFFusLfbx13QM3cpHhxE2zNWfznemflll34bceRobz/0QFM4eYx0hC5e8e?=
 =?us-ascii?Q?lTb5yVDuohp0sexF/rTKeZMix8MKebT9gUVWhOekzYblC486o8suDlZ+sTPD?=
 =?us-ascii?Q?h7tdiAuK+XtlWMX4rQCjaKR8g69779FE54/2svinzL2fM2Cj97mSDtOJg0iX?=
 =?us-ascii?Q?MNVmUsrG+WPq1l9Cw7RM9NUNuwHBYDTjoY4GWvzVWsbniCavJLK89gQmINyV?=
 =?us-ascii?Q?rz8rfiUlkMsCUzoO3z17Edhv8spGXy3fwjt4tExAMYf08NWxKZIEubKWafK4?=
 =?us-ascii?Q?SeJDEIKdRt3enKOmkUNaUTs8g+wUgiL5JZni7LZEg5eWdkHGvAZZiaJupQoV?=
 =?us-ascii?Q?nfNWqUbtdY5YywL1up43W4Rt/5IMi2DHVJjX9AeAqCAChduCNi5C0MrhXCDH?=
 =?us-ascii?Q?/KzCW25jYP13thHEb1vghCEsD3vAlWAmKmGYdtlkyIEtaB5JoTnPlGgQ80At?=
 =?us-ascii?Q?SiTtNTiZioYwxpGO9SrihmAL55mGhUExbB0ihP7CX/9B2inPXdAvY7eob9p3?=
 =?us-ascii?Q?a8sDt+EM26H8hhjv8GSx8iLMn3Bi6Z/DGF5055FSsfSitHWOX2QC6ssSAy8q?=
 =?us-ascii?Q?JnljkxZgUcU3XDZL21b4ZZLk45CSEvnFdDFZSPR7AT+tE3IckF2qfT2yiWhN?=
 =?us-ascii?Q?xNEGEcLogeiLUba+WcEUbvuzAMo9ne8wtU1ysu9UX3vvmB6Hc5/FCLQEYn5h?=
 =?us-ascii?Q?jxbqbjk2enjT7wCA7vVWulX1PTBgV3//VPYqlYDKblvYiyrdzGwtrSdO2Ix/?=
 =?us-ascii?Q?qhu++voRAdT7hhU+ZEHaEjCW5ABP5//MrZtKYdwhCyhdlCt/aEXAqS9grs7U?=
 =?us-ascii?Q?1UD6DrsPSWTG/TTYMku00hAsnofoYFpEKgwucEujPt++qM0QlSCgUTYvVpbg?=
 =?us-ascii?Q?T88v3+m4Z9ygx6aYFT28udpweAhXmWEkqhmQQ5hhplyzRYnlTHajWRwMYIj7?=
 =?us-ascii?Q?jCAl7BMA4VzOmt9R+cYI24Krwc9jco+9SFZ3TPUMWMmHoh/d0voeTNBWNa+7?=
 =?us-ascii?Q?sELzX4uDAGs0WPlujHH4t3qyHJeEQC6HaIoP1Am3BYBw4f0BEI/AZWutFL2u?=
 =?us-ascii?Q?/BwEFCuy/yF0WMhFR70fLD1oAeTHmruIT8pRaIAeBU2cRVntepgHrzI31C6e?=
 =?us-ascii?Q?QZnsRE6va9GiHmNDMXE/P7FvSK81IN+r8r7DCC3lMJ1eRBtMmzwcn4NMxMWd?=
 =?us-ascii?Q?InxnvnDOrKnkK/zOjJwVMX7jJsYinXIoyDPto40vCO1tvsqzW///F3ZmkEGZ?=
 =?us-ascii?Q?ce5Sslrn9g7cMIfv3dUonDLkjjCeoIBKftB0AXrCtnHmmEjOL1EeOYuzVK2E?=
 =?us-ascii?Q?PuXPW85Vg6NSQeDkxVfH9ct+QRsCxh5ban0lvDu2rm01yvEONXI5uAL/5xcQ?=
 =?us-ascii?Q?fjl2hHjeT0CWknTW2BPszmvZUKLtqUQqNid9Fzk7NGD1qsEV+D2aTqzA+pGr?=
 =?us-ascii?Q?w0p/lHEg1Ow=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FWEwriCtUToSfceMZOvbfKA7l3HssoXn14GqZnTV11sNrOj1gETBWIflyMjw?=
 =?us-ascii?Q?VEQRMmh0OpN8v8e/iBNtuI8vNqwkAR7bo6IIEP5XDyih6TbACEoxpi7lV9hc?=
 =?us-ascii?Q?8DDU8TLODtrVS/ZkOnjq9X8WNe0nDtB5XuMEneT6OWE4nVjMT6xgTLndk8B/?=
 =?us-ascii?Q?0Xrov8emIlclOWDXZt1+gjUrD0f5ZGBCNacYinInaNvyFhjwd6mRcsrXkKVO?=
 =?us-ascii?Q?dDGvoXZ1ISjriUxJEA7vjCFGm4PGkKC2rumpO7e/qmAJJmh85E/0RxMA51yw?=
 =?us-ascii?Q?t5ECtOGOMizKQ6Jwglg+ogjgboZ9OjpLR8N7OUK4yOnOWyOn5g7rSnHHxIVB?=
 =?us-ascii?Q?nckd52W4uQfIl2J2/phBKj+GMKZuJHLk8SJSCoGg2s34qmAwJt1h1qDBRSXq?=
 =?us-ascii?Q?0N8TkkU/dcTuUAUBQximdnWyvyveFIvFEPv8/hOPo3iZrlRaw3e5odhXQhFh?=
 =?us-ascii?Q?PQcfLwgsgRceX3xelO0e6pLyr0J/I2j88r1y2DkYJzEw3lENFvQ98xTJbcGg?=
 =?us-ascii?Q?Lzidw0eBCkDsR7RtZHMd79TWCZF7BtfdRiZr/hjVJ5uER5+m6UC2PpX3ul2p?=
 =?us-ascii?Q?pL+6REolaYRRZXdJ+L+MW0fYvsASDPLh0+EJaZxDy2GU0ydT4+LlWFam5pPm?=
 =?us-ascii?Q?I2lUD2z3zlAVyy4GFzeLmorsv1foDdPmPPXA6kkVWDaT8Vbf+c2JjfrS+/Tb?=
 =?us-ascii?Q?mHB8iHQ86b4XNFMVL9AHJWwVTTB/c+QBPCInwvWDiSOj4es7doVYMw7DMXNs?=
 =?us-ascii?Q?6HCXaJ8qviJ5tgvPB/tbNFGoBQ4IXUpiloxPee3EUAp4uExAbLwJUGkg+gPT?=
 =?us-ascii?Q?talMINWGjBBhmzY+FEMbi3c5p7S1QNa+kfwynh0vBAI8mp0EoYftk0kEXJWm?=
 =?us-ascii?Q?dS94YRcbIiaoRemsdqTMvR7bhW/Wwe2YKu+c46byR8l2C5FzcvXrHBvOS4dQ?=
 =?us-ascii?Q?HbLOsQgIpF8gCaCukSqOwtW/het1mUJMAvR48DUFHvqbzfpMotdNSwjs5Hg2?=
 =?us-ascii?Q?VhVIUuzDLcnc5Sb2K/ew2HQc9Mc7jiggo7PLpSzMLdcV0vIltC3GDj89l42s?=
 =?us-ascii?Q?xBeya9fkRc3qpccEYxT10GFF8BGDsCo8Ntk9b4sPB8OcwxX3yXVWjVmYTyOX?=
 =?us-ascii?Q?rMBnJi/e1TQgVooS9kmodY2cnuqhmJw2YZ39/s51QQzRjnMEhRUG4u/pZbaa?=
 =?us-ascii?Q?s/xkGU1+N4cHblOiCxtQzqNyVniDQvySDpzz7dQbTaWnDH9gLtftP2ncR5Eq?=
 =?us-ascii?Q?/QShy+5+24nPce83p8qAFwUIYibhFLa+dHR13Hi7duy9x5TNR3U64CBLcGFw?=
 =?us-ascii?Q?3g2t19hoURA9+xoAkA+svwukrJR7yXWSXQc+sWaraepigmdmsYf9BCCniN9N?=
 =?us-ascii?Q?yHKoxpPU9+pG5OMpOUJp0rPW3QieQcdVkXIQg+IWqJ1P3lYo7EaSw4d7l+86?=
 =?us-ascii?Q?kgrzdgcTTDhrUuUuavZTvRmkySv7nd7OEzwfMmJSVsmcweTTa1Qrx9McxROo?=
 =?us-ascii?Q?bsnpzAP1yfny5VrGZkgA81XQPwJUB8N6emsC8Q4dZjscOZptbdKC0ZCxqN25?=
 =?us-ascii?Q?a2Zk7M5Nxt7cKYijBJKAmdriwTNyNh6JJEG3BUTqzob652Ncc5JK6b3psmqC?=
 =?us-ascii?Q?aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	x1+wQPcWeIteSO9KtZ3BygwTOKXNvrNRhVMKdHUR3Me5+VzD9pFzPhLdD4BI6wB9UnHIpfLOmITMA9cepZGMK3NOBSfY4+zlJVZhcaF2fqU+GyFBMp612b6zYwT+cBnuhg3ci4q5xvcn78EQ9xR8XmfACjuzHlHJTUIqiCXoS6YgR6d8BylhCor/6BGV5xPDEDJNcuPCfSfCdCwdpVcxr7kN3sl2R1P1hhrD0omQu3ZianAznb5763zlI+3j7z4ifE9W0kNjlpmIZ4BGDB/pljfCRzqED8tYUU+KYG6D0VC2bls/m6J4MakKISpvBel/u4IZ34S+b67tQrA3ibusZu6r2EiZClOuE9ZGYGV5k8OGu79roZyK9M/sThSefZ5J7jBnZrhol0TnIzi02BELIxZj7rCzsYAaOqM8GF4Uq73oyeo4KhKcjIg399YY/4VvaPmjOjrkLgbouePfPStNYK1txbgrN/MA1dDsxldHICKTxmErMPXS6qTK2ZA+gXPzUxsOJWaGXyBlu2kIjX1YPyvWfslYg6PKRwbcDGwZbmrxJ3VclCJ+d9q/VU1SRltkXy52TErWOIALwRQpd+pEUCBV00BibUC2iXoq6ou5dO4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c095389-e798-4bc3-c10e-08dda9bb98a0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 14:15:34.2125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0wH01p/gPKez1LQG38k0W8E9NVX+hH28xyy+YWDP9KQeoVR0UKJQzRJ6HpvNmoAzUIPRMYLSs27ztvyf/jselTQ9a2UfMwyg/A4Tk6vjy6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF751CD7230
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_09,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506120109
X-Authority-Analysis: v=2.4 cv=K4AiHzWI c=1 sm=1 tr=0 ts=684ae10b b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=7x8u9wrohGjcWX8-er4A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:14714
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDEwOSBTYWx0ZWRfX3bP5oeiM8iac vw804riXBz5sQqvlt1llDkWseTHZs6BTPjZyHKSpCAnmXTUaUg+xT1U+jkyz/C7mmS9q4qDeIUU jsD5ZuUpQwiy+FTE7e2GWOTywUp39mJ+WbO/HFv+6E4eFQte6Ul/sQxSILlJtfHOqcfV6Y7l8hy
 3byzPp94EnAepjc3tZ3y81sxYodpbe8G+SmJmPVYqicTsx20qQzpRWHHD++jgAbYAX0ApDb3ZUC 8Wu0ZZNWCA2IpUO00+CfB3qrS/NoM2D9D5wYv73m5M16vCBihG7g7G4Wl3Dr0F/WQQZCwgkX37Q ZhtKuWPjDhgKtFKZBb00USWUxM6CvR1jW9J092Qi+ko7QpYicrg332tcy/YLFoDURjN4CtD3x/O
 obDbC8yuvrClARtRqjQ8ApDELyyJZMXJmTuYBCZpUcv0slfzob4T1F7047pNbVoMOwEB4fw8
X-Proofpoint-ORIG-GUID: Gq-_2Ma3mkMBzCraREYeHwYq63A9vngu
X-Proofpoint-GUID: Gq-_2Ma3mkMBzCraREYeHwYq63A9vngu

On Thu, May 29, 2025 at 04:32:04PM +1000, Alistair Popple wrote:
> Previously dax pages were skipped by the pagewalk code as pud_special() or
> vm_normal_page{_pmd}() would be false for DAX pages. Now that dax pages are
> refcounted normally that is no longer the case, so add explicit checks to
> skip them.
>
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>  include/linux/memremap.h | 11 +++++++++++
>  mm/pagewalk.c            | 12 ++++++++++--
>  2 files changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> index 4aa1519..54e8b57 100644
> --- a/include/linux/memremap.h
> +++ b/include/linux/memremap.h
> @@ -198,6 +198,17 @@ static inline bool folio_is_fsdax(const struct folio *folio)
>  	return is_fsdax_page(&folio->page);
>  }
>
> +static inline bool is_devdax_page(const struct page *page)
> +{
> +	return is_zone_device_page(page) &&
> +		page_pgmap(page)->type == MEMORY_DEVICE_GENERIC;
> +}
> +
> +static inline bool folio_is_devdax(const struct folio *folio)
> +{
> +	return is_devdax_page(&folio->page);
> +}
> +
>  #ifdef CONFIG_ZONE_DEVICE
>  void zone_device_page_init(struct page *page);
>  void *memremap_pages(struct dev_pagemap *pgmap, int nid);
> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> index e478777..0dfb9c2 100644
> --- a/mm/pagewalk.c
> +++ b/mm/pagewalk.c
> @@ -884,6 +884,12 @@ struct folio *folio_walk_start(struct folio_walk *fw,
>  		 * support PUD mappings in VM_PFNMAP|VM_MIXEDMAP VMAs.
>  		 */
>  		page = pud_page(pud);
> +
> +		if (is_devdax_page(page)) {

Is it only devdax that can exist at PUD leaf level, not fsdax?

> +			spin_unlock(ptl);
> +			goto not_found;
> +		}
> +
>  		goto found;
>  	}
>
> @@ -911,7 +917,8 @@ struct folio *folio_walk_start(struct folio_walk *fw,
>  			goto pte_table;
>  		} else if (pmd_present(pmd)) {
>  			page = vm_normal_page_pmd(vma, addr, pmd);
> -			if (page) {
> +			if (page && !is_devdax_page(page) &&
> +			    !is_fsdax_page(page)) {
>  				goto found;
>  			} else if ((flags & FW_ZEROPAGE) &&
>  				    is_huge_zero_pmd(pmd)) {
> @@ -945,7 +952,8 @@ struct folio *folio_walk_start(struct folio_walk *fw,
>
>  	if (pte_present(pte)) {
>  		page = vm_normal_page(vma, addr, pte);
> -		if (page)
> +		if (page && !is_devdax_page(page) &&
> +		    !is_fsdax_page(page))
>  			goto found;
>  		if ((flags & FW_ZEROPAGE) &&
>  		    is_zero_pfn(pte_pfn(pte))) {

I'm probably echoing others here (and I definitely particularly like Dan's
suggestion of a helper function here, and Jason's suggestion of explanatory
comments), but would also be nice to not have to do this separately at each page
table level and instead have something that you can say 'get me normal non-dax
page at page table level <parameter>'.

> --
> git-series 0.9.1

