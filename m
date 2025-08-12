Return-Path: <linux-fsdevel+bounces-57558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E996B2355E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 20:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 089764E4578
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 18:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C23C2FAC06;
	Tue, 12 Aug 2025 18:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XoQlJPID";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RF+vo+/S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0855C2CA9;
	Tue, 12 Aug 2025 18:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755024574; cv=fail; b=fc7IJ8dStqBNpIw1ddBx0GR2I7DT3ipuA0U6GUusXQiO8nX/a6yF2SkY0E60kqkqo/GiIbSE62BGgEpfJbv3IsZfT2ACbBe24PlyuAINF1jrlysG1lWhtMCrr0G5skXi//aEj2zNnUmU4StU1tRz7tK6z/rAnev0m/zuvqscuUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755024574; c=relaxed/simple;
	bh=muJGXrjXOzORlxEbbRkqo1Uee/GJFKGAftv2ixBjs8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vh0TxO3vYhgD51QiNldWEI/c/L0AiFQFEiuj36/126RPMY8aDL4/UbKKPXI1U8wL2wOOqMbD3914S/8gAPtidPHTDbsznGICuy3DfvblzbtXBaQnzuygZd90L5Ui6k3+36/cier5siCC+wRlk9SGCjd/M++iWP9KpDQbjmh9488=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XoQlJPID; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RF+vo+/S; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDBwBR012369;
	Tue, 12 Aug 2025 18:48:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=nIlD8P8xaNha1RdD+F
	0AElqcb5gozmTZL74ETofIeLI=; b=XoQlJPIDDXatqs/XPkypizi/fQLtl/FL74
	r86uXg4lD1JNmXn+omb2rYoRRxW+7VkF22t14dNY9Q8z+ElxWEt58loDgV51Kzj8
	BBn2Uqj2nNx6Bz1Ks5rj0WWMaIe7wDSEDuxlr/FBjF+BLQbbZ1xpYjOPwKR4j/Pz
	kQQmirGGFeLXFBGZiIPXUJnc6RtoyIdmsrv1ii04UgGo5w+FOZ/Hff+fDqrlK++N
	27w2tCy/Chbn8mP5PUYkTcfKWc9P6s2i+ru+9KxxWYTmcC4gxwlzvDydvuooCnR7
	B4aAOCNugSWI3VpVRJHRyI+6VIkt5ccDA1rlQf+llCzkh/IUvYmw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dw44wegu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 18:48:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57CHcjHV009640;
	Tue, 12 Aug 2025 18:48:36 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsgnp2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 18:48:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u7YEksGOsjDt1Ic1w666tQzSWAqUT8W0NHeptsgsh4RS8rv4pjseOTCcKnAEXxmyOPAU65LpM3JJLW3p/d40tEgqBxznpgRN6855UySF3iEWfNxe/o/b4LwkPUyEgmzUXAyutka++/4/WSzObqbP98AgUn526u+T+6WTJ+aCwWBqQKC80dXdP5fzhfq6X5YomQr5bvidXBxbcoICBaVtqxDWEegscWDSEsJKW/I93zAV9iOOXxjvteQ6wEyiI2eKIiYid9ip0cCDt/M4lRv+xTYD1oN8prUkC/gawTr3cSUr1GzBFZBcKSQK/RWCOcGts1aGDYCME1AKi01odRM3Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIlD8P8xaNha1RdD+F0AElqcb5gozmTZL74ETofIeLI=;
 b=g4x8P0d3LvHkG2oqm4HGH6f2y/3xT/in5M1RcFlQYmjo0QeVZglcML7IkSH6levXDOcCiQQIvZMRRGiOvWIJu9g4d7z7FU55FR0gqfu542OFzcIc49HmFJltOHBTKGEX2r8t4/bzVUMkyfFBpUlqVnJ/tGHKmhulNkp+2VNp2SojWUwSBu7lvbYvDfmlrUbvg2MrJ6GeZPlStUWbPVDfPZ58zyx3EwdR6BH8evi7OHaBljsfYXCH/uDSF2NEGG7bCb5boI724cmpc1ArZLwjt3bW1MBvE21Sf0xWqA16dNnPBmtf7dGwaAhwZrxhAekELYVHP9RcaddHDeqjbVprlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIlD8P8xaNha1RdD+F0AElqcb5gozmTZL74ETofIeLI=;
 b=RF+vo+/SVKdxmsCaPYclMITKwzX1Nx03HHUNmeOy3zwEhk9UnLLclaR+1HP2o6alNQ1IAjGcmVDSvew+kGT3qHjy4LdjlSb6CuSc+Lv/7fxqk8N2+Ww1v9Um1hkOxKdYt3toKQcoPK8huUDYUBYnM2dBUuBrmAY48Zhg0bk5F2A=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA1PR10MB7168.namprd10.prod.outlook.com (2603:10b6:208:3f0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 18:48:17 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 18:48:17 +0000
Date: Tue, 12 Aug 2025 19:48:07 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org,
        nvdimm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Hugh Dickins <hughd@google.com>, Oscar Salvador <osalvador@suse.de>,
        Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v3 08/11] mm/memory: convert print_bad_pte() to
 print_bad_page_map()
Message-ID: <4258d819-7226-491a-b140-bcb6e64d426c@lucifer.local>
References: <20250811112631.759341-1-david@redhat.com>
 <20250811112631.759341-9-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811112631.759341-9-david@redhat.com>
X-ClientProxiedBy: GVX0EPF00011B64.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:8:0:7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA1PR10MB7168:EE_
X-MS-Office365-Filtering-Correlation-Id: fc03db2e-3be7-416e-ed54-08ddd9d0ccfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3AM8eOfHai/kpIgyNs+VM3W/jMFER69Q5cDUgcIttV3P2bMQnqXCfkAI94wr?=
 =?us-ascii?Q?iEgLaQvr11HU9/yAn//Vv0aXSxRoA/1g+JUKHmRhQIW05giIZPRZcYI1LVXB?=
 =?us-ascii?Q?exeQ3lpFGbheD1ZWkJql7rwp030F04ud06DM3o2D/DJJHM374T78S+kJ8iWr?=
 =?us-ascii?Q?BgiARVND0V/H95zISyk6vrbkHaAsfRBmz3WdoJ/phKzZ4dAeqCVQs2vh7xuL?=
 =?us-ascii?Q?7J1D5SIjeRSR16ro3fUimuur5vMUqaEHxx0dz25wETzQT5Lq5qYyMVuolnSg?=
 =?us-ascii?Q?kvIZhMgNVgbxfmpZ1/rDznCHZ9DBwGpN7N6q1mG432WiPUuGes7dCsZcrhPL?=
 =?us-ascii?Q?UXh+fszRxBSi93G++QjbcVVdDttbI+Btcr8VuzPnXd/VfQPrRuHnpFksiFLO?=
 =?us-ascii?Q?T4ZzOumtHae+DhR8XX7eBPJefscofVABPxDTDTkKtfFk1PIhzWzTd4D6fJ3F?=
 =?us-ascii?Q?c5PIlHApR31BhQhN19rM2QzjJPB9ztI4FH/2V56VHq61BZZk3SAym/CiImR1?=
 =?us-ascii?Q?whVedc8/nHzbVcJAbrR56993SA+XuyGMZUEvqzHRptTCGwjYpw+ZiYyWVglO?=
 =?us-ascii?Q?wGLdFnydhv6O3yAN2f5uYpT0S9pJ5A8+JxX3LjhxnC0C1yr5cgNvrJKlzEat?=
 =?us-ascii?Q?+ZQTJmvZwZWG9NVoPoVowChyIABlfWqp8vYmjZjRzvHzjYx0vEacyiriYH6n?=
 =?us-ascii?Q?uk881y8E9yYdTFqxrmo+taZ1ZoPuVHGP4zwU697PkPBe6ljm5CBGDQYpFPyA?=
 =?us-ascii?Q?81bA0sOI5eI57ORtIzZs2DaAfeyuxIrBO3ElCNDb2oLC5zWpi9lGaQMd4kWi?=
 =?us-ascii?Q?dDwJseE67YrPYlgw06eQFh2iMK/nzVHkFBVmIovNQNcXisWPd9gxAUM16thM?=
 =?us-ascii?Q?nXZrztLY4au0sFLoi7XU6YPEfTrBfrn1uFelguapdwIyolh64g2I1t3bHW7+?=
 =?us-ascii?Q?BUBgxSYCUTCxiXqPD5cZiPkRHCe5pBg9/4vnub+Hi/6IvckpEcO92IFespAR?=
 =?us-ascii?Q?UpZKmxFgqrgv1y5D0HPMYmF3qAqWYcAlfH8xBT/cxZnw2JlIad7RpCDSf+J9?=
 =?us-ascii?Q?40TA2KLxPfwr/0pmdfaydhgmgFP5KezKdU5K2wW2fHB1jZrzBEGnZPJ/IIPt?=
 =?us-ascii?Q?H/6yDH7sjFol27eQjPaPmFfvR8L20foByYxQqhSFrFKGQehnXSP+jYY9TvWQ?=
 =?us-ascii?Q?VnoM0n/qSbMAlpsogewzGiV0X1mxNv4aeDtm94jIIYbP6Qi1rRzAIVJy8k8Q?=
 =?us-ascii?Q?NcOSbnZFugkBzW3Cq8x1nlnjY9RyXcFojmHA1lGP0PBJwjcB3uFudvgEtTI4?=
 =?us-ascii?Q?u8SOMlsMGuCaFMc86DgrQgFI0h9ZVa+f5CyhJD6Da11xaMZsJKc1DLmHYwlA?=
 =?us-ascii?Q?OZJ00gDldnnIVGepKMWg1oEP8zYab4tbTzQmomFtNc7OLptw+EMHveYCH7aK?=
 =?us-ascii?Q?FV7UbG7bq2Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iCCA4yp03UYHSAQ23YYY8gsJSAkI5EBEMy2uzvzYuplgiejnrx26EsJ00LO+?=
 =?us-ascii?Q?+JTeHfnGPAWI/iGp7HmFCwsc61xjKjIIVh9cgPaf1AH4aH3abyfphFUaeT3H?=
 =?us-ascii?Q?kxONdj6QaSvXsH8TQze0RXefoFWFF1D75ZcDkBrXRaFc5QulDpcRn71hOAwK?=
 =?us-ascii?Q?BjpxRycbwmrRq+LYARrCOpEDUBNztgTxw22Y3OnTcBxSFnTLB/9uOvf6RMi5?=
 =?us-ascii?Q?RfCHmnAK6RxIDIpitUap8PYJN/d/LGuoZ2krcCWnuJVaaFX9cl1by1qBtQUd?=
 =?us-ascii?Q?1wjGPkdLWt5PqhBxbDtcvdirkh0SNpPJl0or4u9R7aH7aIPiMtjFZ/8IHQJa?=
 =?us-ascii?Q?ANmNl1ORLQKNR6ovK0Fnosm//ipw75W+NUt29DNV8TNYkWx45++pwQWEbfOh?=
 =?us-ascii?Q?yH0cdtGcnktG/KAH3HcMlDL5rIyTwDoWuVr5TIRaHpN44Tj+CDOYogXCfO+J?=
 =?us-ascii?Q?RFBOJC8zXpBfiyHGg7Z6rC2xFFAlW+twItigGX2aa46Jl3IxeSnuSGj/r9mg?=
 =?us-ascii?Q?s/BjAAtLhQDCg0B+uAFgzilwx2XjdTACBgkKxnvStlNS0pxfwIGB8vKc1+bm?=
 =?us-ascii?Q?CnViMy+BTq5x+BybDRGclFtIzn8NxD5+In7D7+rIMK3HWK8RRS0QpaupjfFW?=
 =?us-ascii?Q?kbWIzmS21h37vhwolkSzQMxqkT0l5knEuqtVUQUEpz+Yx9ma0S4n1753ypKl?=
 =?us-ascii?Q?cHb/sz0ivn3C1U6MUNY2zz+lYv9dpmfSgl4GpqxUxTpPcH5jBEbJGeDp00Z3?=
 =?us-ascii?Q?VvY8ar73tuZpN63EtxItbw4TXsSmP6Nwjqet7CT0mUtccdTPOCUMuqFMjXaw?=
 =?us-ascii?Q?3X80F/9ONLmkypdFiu193DX78nbYFBjv20ntgV1+CvIbyEXri4elDbjMXkor?=
 =?us-ascii?Q?YVV4xZ/WoKBNgX2jJ+mZedwH6hr2zB2nShqMFtKdOMrBpVT311BYvucbMAjp?=
 =?us-ascii?Q?wsYk4uUgb6pXnHftin8rhTtASYJDNGlfhi8OnuZLbzO/dB9SLmnHf/JV0fUl?=
 =?us-ascii?Q?ZCPK9JkfoiHM2K83iuZ0hGRfQDe/bba/BEOwW7qoeBuJx7/cfcw4HFesdT7v?=
 =?us-ascii?Q?CSHAuphf1+lxHqCP73tzk12P7MB5QAqsdwDCS5tesGp0AQ3CYbi9Vh9jn8yK?=
 =?us-ascii?Q?OBLSjINXfUALtvgo9KS5nbd6XxEtCPaDa7uf9gFY4Sj/c1EOsjFBj3ypPx1+?=
 =?us-ascii?Q?XvdZSzgsSxSe4JqWdKTy2WcXopCUQgmxKbm7HEYBcR2G+LyAKADe887FYy3/?=
 =?us-ascii?Q?G5109+KliwXRWFz9+1MoSh/Bt8DtHC2ALubig2z5zK3oEdihJwfr0Fv3J/Tw?=
 =?us-ascii?Q?uvZzyjUwmlKcIwrcNfnwRuV1/pid2NQDgAofNJdzggRQl+BnBwNpr+IkAo84?=
 =?us-ascii?Q?JPLqwCEfK1RPoU5hXuu42kMmeikxZo7+deD5iOj4jUo2hEuoFdmXhLD4Xxzr?=
 =?us-ascii?Q?cqPdT4R+f5vzBgIiHjx2ngs/fncm4WlZ3xQCtfI58UgGtQYr/byYPctjhW1c?=
 =?us-ascii?Q?1a1/wRcY4DIa03bgbVl4k1zze2yczjjcw7+XT2PjF4W04OMiF8RP1isWBBpO?=
 =?us-ascii?Q?dpN+3fU6+bfg7Lq95CGmp8alBi91+ygCFA0cBIujuHYTskoJgchYvC4Tk5Mp?=
 =?us-ascii?Q?KQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bNLtK90Jem4yGMCYuLAseuTgf4uD7U88BzAMrDG1fzEXFfpRUwYv+IVrB9Xh5QHPmkO72fZPkl/tYTzvBaU15auG+F7zxHhtrUOHxwdcawXhRJsaoU1UTNNLGnYOa9WgeK7PbGeXtN1Y3XlKcUM7UQ47R5hgfcGqA3vsnEM239l6lKLU55DOVgfN1TkvLLTZTJS4if4ykM//NJnGPTX1ow+psu5+Io0R8EWBTOkJEv+YKkoPqVRiCUhJTapiquUkE03CmlZ5R/XZTHsp2WLhdX84GllGwUfcIjf3JX5QEz4OeE9EsILSpEVqW0b413E2fCaUBcVnzl9n9dUN7RYEzjedYkljMW1DdgDWv/YGciXK1wyviaEdg/CZDJQpHazKExBXjx+Mlh2I610dvZ1Pu8IHi4JBgS13BrwTGT4ULNHvZpJEcC6os9tQ894790WWlkNy8VB5jF6R6BoVDpVWBupWvFp7eHHmk1OKKktkaIshyMu+mFp33yARIKUHem9CyrntUbUf2g2uPQNeDK1SfItM+yEfztBTR4tWshPTYEWDx8ANyLiXYaEsMpxp+z0prIHHTymT6sc2z62zxqmCx+xLOfo2DfxmMy361M7dEOw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc03db2e-3be7-416e-ed54-08ddd9d0ccfc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 18:48:17.4064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hcBzDuZKLRa7IqmduT0H6PtqirN4HOZpWiuuCyp/hVe+LY7g7/0mA8UKfzlklodp/6uqh5sFOHJr2Hg5Ik4kjCYac2zAjdiFUWJGlQ71N7U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7168
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508120181
X-Proofpoint-ORIG-GUID: 7uRCPUQqvZHWuhp49wdB-OQCDP8NFqjM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE4MSBTYWx0ZWRfX9wz3aszOjYbg
 QqRZMoYFXfHyNv1LdFztuljl+9wA9mtCltMdP6QOsbqAL1OvY4oISADzBOen+c29EFkm2FMaTxv
 y7hogd+XpBxDXRNyGOvJdkxa130f57qaByL2xWJgts8Fcje/8SQNVs1zfECb2g1CpLdJ7/7aalF
 pc5pDMwJ3DkSufcwZ5731PQLMP9anpQEofv6xovXNPqJjl9vOLvl3IHupX7vgm45OSbVht2GGLs
 lvelsjA8QTmqF5gTKjMGWwRejCMZXSL4RUWTWc8FSLkj/2/KnwNmvJrw6B7C//4/mBBsgfTJah/
 AEETH8DAtW7w6cD2k1CXwFR9wqxt8IN7erRJw/gH+Ru2ZlUO04s46s98zQ4tjetI5OrqNFDk9GX
 i1FBHZXvkl1IVdGK/QGjvojTK2DJoAgCmngMu4E6+KncHIguvWuNGYciJqZaxhSktDtms+gE
X-Authority-Analysis: v=2.4 cv=X9FSKHTe c=1 sm=1 tr=0 ts=689b8c85 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=3cV1On-_EGWI4EocTlcA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12069
X-Proofpoint-GUID: 7uRCPUQqvZHWuhp49wdB-OQCDP8NFqjM

On Mon, Aug 11, 2025 at 01:26:28PM +0200, David Hildenbrand wrote:
> print_bad_pte() looks like something that should actually be a WARN
> or similar, but historically it apparently has proven to be useful to
> detect corruption of page tables even on production systems -- report
> the issue and keep the system running to make it easier to actually detect
> what is going wrong (e.g., multiple such messages might shed a light).
>
> As we want to unify vm_normal_page_*() handling for PTE/PMD/PUD, we'll have
> to take care of print_bad_pte() as well.
>
> Let's prepare for using print_bad_pte() also for non-PTEs by adjusting the
> implementation and renaming the function to print_bad_page_map().
> Provide print_bad_pte() as a simple wrapper.
>
> Document the implicit locking requirements for the page table re-walk.
>
> To make the function a bit more readable, factor out the ratelimit check
> into is_bad_page_map_ratelimited() and place the printing of page
> table content into __print_bad_page_map_pgtable(). We'll now dump
> information from each level in a single line, and just stop the table
> walk once we hit something that is not a present page table.
>
> The report will now look something like (dumping pgd to pmd values):
>
> [   77.943408] BUG: Bad page map in process XXX  pte:80000001233f5867
> [   77.944077] addr:00007fd84bb1c000 vm_flags:08100071 anon_vma: ...
> [   77.945186] pgd:10a89f067 p4d:10a89f067 pud:10e5a2067 pmd:105327067
>
> Not using pgdp_get(), because that does not work properly on some arm
> configs where pgd_t is an array. Note that we are dumping all levels
> even when levels are folded for simplicity.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>

This LGTM, great explanations and thanks for the page table level stuff!

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  include/linux/pgtable.h |  19 ++++++++
>  mm/memory.c             | 104 ++++++++++++++++++++++++++++++++--------
>  2 files changed, 103 insertions(+), 20 deletions(-)
>
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index bff5c4241bf2e..33c84b38b7ec6 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -1966,6 +1966,25 @@ enum pgtable_level {
>  	PGTABLE_LEVEL_PGD,
>  };
>
> +static inline const char *pgtable_level_to_str(enum pgtable_level level)
> +{
> +	switch (level) {
> +	case PGTABLE_LEVEL_PTE:
> +		return "pte";
> +	case PGTABLE_LEVEL_PMD:
> +		return "pmd";
> +	case PGTABLE_LEVEL_PUD:
> +		return "pud";
> +	case PGTABLE_LEVEL_P4D:
> +		return "p4d";
> +	case PGTABLE_LEVEL_PGD:
> +		return "pgd";
> +	default:
> +		VM_WARN_ON_ONCE(1);
> +		return "unknown";
> +	}
> +}
> +
>  #endif /* !__ASSEMBLY__ */
>
>  #if !defined(MAX_POSSIBLE_PHYSMEM_BITS) && !defined(CONFIG_64BIT)
> diff --git a/mm/memory.c b/mm/memory.c
> index 626caedce35e0..dc0107354d37b 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -491,22 +491,8 @@ static inline void add_mm_rss_vec(struct mm_struct *mm, int *rss)
>  			add_mm_counter(mm, i, rss[i]);
>  }
>
> -/*
> - * This function is called to print an error when a bad pte
> - * is found. For example, we might have a PFN-mapped pte in
> - * a region that doesn't allow it.
> - *
> - * The calling function must still handle the error.
> - */
> -static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
> -			  pte_t pte, struct page *page)
> +static bool is_bad_page_map_ratelimited(void)
>  {
> -	pgd_t *pgd = pgd_offset(vma->vm_mm, addr);
> -	p4d_t *p4d = p4d_offset(pgd, addr);
> -	pud_t *pud = pud_offset(p4d, addr);
> -	pmd_t *pmd = pmd_offset(pud, addr);
> -	struct address_space *mapping;
> -	pgoff_t index;
>  	static unsigned long resume;
>  	static unsigned long nr_shown;
>  	static unsigned long nr_unshown;
> @@ -518,7 +504,7 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
>  	if (nr_shown == 60) {
>  		if (time_before(jiffies, resume)) {
>  			nr_unshown++;
> -			return;
> +			return true;
>  		}
>  		if (nr_unshown) {
>  			pr_alert("BUG: Bad page map: %lu messages suppressed\n",
> @@ -529,15 +515,91 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
>  	}
>  	if (nr_shown++ == 0)
>  		resume = jiffies + 60 * HZ;
> +	return false;
> +}
> +
> +static void __print_bad_page_map_pgtable(struct mm_struct *mm, unsigned long addr)
> +{
> +	unsigned long long pgdv, p4dv, pudv, pmdv;
> +	p4d_t p4d, *p4dp;
> +	pud_t pud, *pudp;
> +	pmd_t pmd, *pmdp;
> +	pgd_t *pgdp;
> +
> +	/*
> +	 * Although this looks like a fully lockless pgtable walk, it is not:
> +	 * see locking requirements for print_bad_page_map().
> +	 */

Thanks

> +	pgdp = pgd_offset(mm, addr);
> +	pgdv = pgd_val(*pgdp);
> +
> +	if (!pgd_present(*pgdp) || pgd_leaf(*pgdp)) {
> +		pr_alert("pgd:%08llx\n", pgdv);
> +		return;
> +	}
> +
> +	p4dp = p4d_offset(pgdp, addr);
> +	p4d = p4dp_get(p4dp);
> +	p4dv = p4d_val(p4d);
> +
> +	if (!p4d_present(p4d) || p4d_leaf(p4d)) {
> +		pr_alert("pgd:%08llx p4d:%08llx\n", pgdv, p4dv);
> +		return;
> +	}
> +
> +	pudp = pud_offset(p4dp, addr);
> +	pud = pudp_get(pudp);
> +	pudv = pud_val(pud);
> +
> +	if (!pud_present(pud) || pud_leaf(pud)) {
> +		pr_alert("pgd:%08llx p4d:%08llx pud:%08llx\n", pgdv, p4dv, pudv);
> +		return;
> +	}
> +
> +	pmdp = pmd_offset(pudp, addr);
> +	pmd = pmdp_get(pmdp);
> +	pmdv = pmd_val(pmd);
> +
> +	/*
> +	 * Dumping the PTE would be nice, but it's tricky with CONFIG_HIGHPTE,

Sigh, 32-bit.

> +	 * because the table should already be mapped by the caller and
> +	 * doing another map would be bad. print_bad_page_map() should
> +	 * already take care of printing the PTE.
> +	 */
> +	pr_alert("pgd:%08llx p4d:%08llx pud:%08llx pmd:%08llx\n", pgdv,
> +		 p4dv, pudv, pmdv);
> +}
> +
> +/*
> + * This function is called to print an error when a bad page table entry (e.g.,
> + * corrupted page table entry) is found. For example, we might have a
> + * PFN-mapped pte in a region that doesn't allow it.
> + *
> + * The calling function must still handle the error.
> + *
> + * This function must be called during a proper page table walk, as it will
> + * re-walk the page table to dump information: the caller MUST prevent page
> + * table teardown (by holding mmap, vma or rmap lock) and MUST hold the leaf
> + * page table lock.
> + */

Thanks this is good!

> +static void print_bad_page_map(struct vm_area_struct *vma,
> +		unsigned long addr, unsigned long long entry, struct page *page,
> +		enum pgtable_level level)
> +{
> +	struct address_space *mapping;
> +	pgoff_t index;
> +
> +	if (is_bad_page_map_ratelimited())
> +		return;
>
>  	mapping = vma->vm_file ? vma->vm_file->f_mapping : NULL;
>  	index = linear_page_index(vma, addr);
>
> -	pr_alert("BUG: Bad page map in process %s  pte:%08llx pmd:%08llx\n",
> -		 current->comm,
> -		 (long long)pte_val(pte), (long long)pmd_val(*pmd));
> +	pr_alert("BUG: Bad page map in process %s  %s:%08llx", current->comm,
> +		 pgtable_level_to_str(level), entry);
> +	__print_bad_page_map_pgtable(vma->vm_mm, addr);
>  	if (page)
> -		dump_page(page, "bad pte");
> +		dump_page(page, "bad page map");
>  	pr_alert("addr:%px vm_flags:%08lx anon_vma:%px mapping:%px index:%lx\n",
>  		 (void *)addr, vma->vm_flags, vma->anon_vma, mapping, index);
>  	pr_alert("file:%pD fault:%ps mmap:%ps mmap_prepare: %ps read_folio:%ps\n",
> @@ -549,6 +611,8 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
>  	dump_stack();
>  	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
>  }
> +#define print_bad_pte(vma, addr, pte, page) \
> +	print_bad_page_map(vma, addr, pte_val(pte), page, PGTABLE_LEVEL_PTE)

This is a nice abstraction.

>
>  /*
>   * vm_normal_page -- This function gets the "struct page" associated with a pte.
> --
> 2.50.1
>

