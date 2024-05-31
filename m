Return-Path: <linux-fsdevel+bounces-20661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC888D66F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 18:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F453B29C3C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 16:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD126179954;
	Fri, 31 May 2024 16:33:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2796416936F;
	Fri, 31 May 2024 16:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717173215; cv=fail; b=g2gOwaVyX4ybpKrgsL2pbtfxbT8s9Eynv/4DWQXpntLsi99FfSJ+1/8AuoEzcglDZThUypiRfkKG1l96fmO8ntXBuPY/gbVkmZp29q4Da3NWV+YLnTvHPL4PfnPiYEAQox8rhrGRchZd06HFQN8V5pj2hjInWpepHgTlBCISMEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717173215; c=relaxed/simple;
	bh=SRwFQKtjCmJ83mjUv4rYOpA0MKijt/SfMF8g9KcNM38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f4zI+ypbZ5SCbArKqtwjTVB0WopbeGlDoE9YUiLXkgfMkb8071W2n2PoXfauFJN+dvgnjrzp8poLekuaaLTTdpkIfoaf18f/OYG5odo8rHP0F9zpDmhNuyud4fgQmd+v/MMRFMaxoY5O3SaW+ZUpU4ApNdg0PKXDkBGOLFGdc3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44V9TCfx020158;
	Fri, 31 May 2024 16:33:22 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3D92o/3ASbgyxOKlqshYmXS4iV2H2wPgMUuURig1jWyTw=3D;_b?=
 =?UTF-8?Q?=3DZqwxUPGoqG7sfApe+fWU2hbG8IMNIn0j9602LxIiEJKCZH18YXlJ2M3wPjtf?=
 =?UTF-8?Q?sElvY0Df_rxex/iGUfF5j/rE01kJf3h0mCcZ9BdCCHgPTF+D5zqxq2lEBnNR7Jf?=
 =?UTF-8?Q?5WEmwz+ZjYiNJo_WsPhUtww0+Aln60hr/xaPstLTWMAMQOi/6mirCKaKjD9/hfT?=
 =?UTF-8?Q?MTdPsMmVppDrXcv8OhMZ_7DRMtxZ9orYdIcFJgZ8hkDxFWAxKDcMQELiLaYJzS9?=
 =?UTF-8?Q?g3wPSN46v6BCxJlRKpPLlwYCi5_+P+nnhKWWZPGO84PfErwUINewOhK90eD9Ozq?=
 =?UTF-8?Q?VOlaRhZ41gzubevQwOa0u7/YZPXcUlIW_IQ=3D=3D_?=
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8kbbm4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 16:33:21 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44VG0HPV010628;
	Fri, 31 May 2024 16:33:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yc5125p0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 16:33:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5RvLZR2wjPmN3nud7FSQp0uMim/Ndo61TTTW6a4vCBcLHNEao+oeGRngmzeUP9NBiDCwD7+Og2YlvmuZpef0ri5M1/kgObwqZZzyeAGtxPSiAb8MYqpY/ZEVitpdNdp/q7Lz2neQiX+etfkn2LIlEtx6pOLcKbYgPRb2kkA/w6722mk9bw0RbkbiCPgHl3JbTr4c75uyxtjzqjSaqJb8XH8+O5j8TUz6cFUihXyPRSC7BU9hsPNalgBty9d/or1xkhT3w9tDGAd7++qodwc8EI65eAbw5PsLR9RxP1RzA1k/Bz/l1vKCaE+Wbk4QPgzFUSStOjfrEb77JJJZqUE4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92o/3ASbgyxOKlqshYmXS4iV2H2wPgMUuURig1jWyTw=;
 b=lthRaFiC52HIal7T7OkVbioTXqEUwV1coXE3vDThkperYr7fiyqvEBjkT0J2RJD2xQONHSo3KHL6qgkjvrRxHVP2JhhMZe0Ywo6Kwo7zqDu5PMgslRph/EVMXj6ZaHEJnvfJck1B3fCSCFKuhd5cLZ+tjGP8BW1o4D7EMSk7ESLCRyti/brwzG6DSSox+y2zjt0RN9GyaMthtroclzIlamYuocwlHNylRZ8ec1YNvN1Uj4lw832rJIhEWJELmupt7u+djZU9Qhv383E8YRIhG3iMN7sJKsz/2rVxW7KU5EFdqYb5hLEW5LH+WsA9mGD8O37ghty8MlMJgYm2MINT9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92o/3ASbgyxOKlqshYmXS4iV2H2wPgMUuURig1jWyTw=;
 b=q+G+Ihr85RiNd9VQvZC7JDZrLLq0s6YzT6n6yPJJW9wLCs+IPsCt2aLWyoouCwuP2hEaS3+ZXUuFII5of6xryIql6ffV2wtTAsUO3DXud161nIijG2TkofXI/GrY5K88AUCzr1brNX3Tw/RHzgmBFQhCg1GjdX+xOmqzEOwcK1Q=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by MN2PR10MB4238.namprd10.prod.outlook.com (2603:10b6:208:1d3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 16:32:53 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 16:32:52 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, sidhartha.kumar@oracle.com,
        Matthew Wilcox <willy@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 5/5] mm/mmap: Use split munmap calls for MAP_FIXED
Date: Fri, 31 May 2024 12:32:17 -0400
Message-ID: <20240531163217.1584450-6-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240531163217.1584450-1-Liam.Howlett@oracle.com>
References: <20240531163217.1584450-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0252.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::24) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|MN2PR10MB4238:EE_
X-MS-Office365-Filtering-Correlation-Id: 040325da-7007-4d81-d549-08dc818f515f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Cn9B/vQ82Y6/07PeXU8BqZaU20HZVjWl9NM5ufNha+G5BmjhrjFJ6kBUpp5b?=
 =?us-ascii?Q?lJqGsCkakONIhmLUDCJIEfOc7FmL1ymZkKgW9MHPEFnfbGDUKp2Umvw/4//Q?=
 =?us-ascii?Q?BtMYgs4o4kVYIBu/XGBTmG4bsK5OWKy+NNu/Uq3KbIZMQyjFoXAKg1wT70wp?=
 =?us-ascii?Q?iMIawyKPmp5I8208x8Eabu9ZHR5W/SYTubYGqMOpnhMgGeBKi03CvYKS1GcR?=
 =?us-ascii?Q?wHFauTxCcU+tFiIcDp4jdvnWF4eKXqiF5E8I4QThJAApC2+Tj8ckGM3OCRsv?=
 =?us-ascii?Q?txTsaoo48+XOPM9XLhbCwjeIjUJ3+WvvcrJ35le8Y/npBxujNI5F9Z1Ub1Qm?=
 =?us-ascii?Q?TFJ1TldYPiiTAwTeOViYUDEBZpAnxltJvjURFpY+pvvfjvlT9tTbkYFALes7?=
 =?us-ascii?Q?dZr8YaUIiSOamEWgVixwl74Cm4b1jMk0YkIFwZt25+H0fP0iInrRCKDf7nYW?=
 =?us-ascii?Q?ndC/GykZZnV3iePpml/hE2+3BSvPSwsRY2XeGqs/BM6MqtCtRYW4xeiV6MzR?=
 =?us-ascii?Q?Uf+0RuhhA7gzOZXvXQVVfEgPdRNo7fERHATI1t+EWf/fKQ4GTsh0vAUS7kvy?=
 =?us-ascii?Q?zZy2JMfYVjbLWAlU7oVB5foqZ1JteLW9XDiLXe94XCpwmZECH8b9lQxOWB0Z?=
 =?us-ascii?Q?RDkwgxgc5WOPifV6wfM1WgUjjrw/03Dm1IcQD5wIX+6TCPpQr8FNDLA3dFMP?=
 =?us-ascii?Q?eCk6XaGrlt63QSChkLaUEbf/VSOs5RnOO1Zn4llFCngiGLdYruf17xfQ1wK5?=
 =?us-ascii?Q?Y+JxWMuWH0wCxU90iVUTGNfKgDOfChrcFYuAUyn8JBE0wCqZkat3+1dE9yqI?=
 =?us-ascii?Q?+jvPMb8WDDoSAiE0rA+jyU3Z8YqosXPHy24Dk9dJdgpmFaR7sUg3lcdUsD89?=
 =?us-ascii?Q?i72KWTWpGJe2es0FLc0jc9SQO/zi7L6C7pk2eQ1pC9W4pdjlVfxKHFjjT7AH?=
 =?us-ascii?Q?w0ONq51PyQu0Sahr+NpyAq+9xQVsGPbj5Zgcb4KbtLhDJOS/wDI4AWSXQ17Y?=
 =?us-ascii?Q?gcbcOW4bVSXRmp4OseUO81hHC3sLXnDs7KZkoGqvgPG81KccExhMlw+A1Uxj?=
 =?us-ascii?Q?zffYTpDl1Ln3Ld1YJH/+dqeUr/vijJZ+fw+8BJ1GjUczB6VUf2Ngbwk80h5d?=
 =?us-ascii?Q?ZPynYWN9dgdW6Hnw9oFwapzqREamD4n+uv0TnOpe3V0ybqgraVhsrtTWBjzM?=
 =?us-ascii?Q?vFWGMPSb2ZWJKUpc50VFpCO7JvD0YDtTAjvknJdkSB5Cx2+SvkdK/vLaruha?=
 =?us-ascii?Q?KMZY8EwZ43KhEwCk+6H9lqtCwALpuu4CqUunoLa/Zw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?UFLXOusTuO8x3pejriTHl3NYb2YA11J5aFQOdRNL7kNdN0bsgC183F34+Pyg?=
 =?us-ascii?Q?kJBTnPReD2ZbVf7RDinYu5oExN0MR8bGu2FLTgdw7yT9TxpllirJTnlvUhBo?=
 =?us-ascii?Q?E8ZPTwoIs+ZUBI+OWBcKPnU/x2prKoUN6yoV00SC96w3tDreq/KHeWntfxPm?=
 =?us-ascii?Q?4RuJkuxvIjGsm2zgBP3+ZGQdxv8ZGmZEZ+GEuGxmivB4GNp7BOZ/UjNFJTke?=
 =?us-ascii?Q?KF5gunLZESZguOr+5+yy01dBYCNZAe1ugE6o52jcZNJDPeP5V4+aDjzikj2U?=
 =?us-ascii?Q?2iyn42fiVBB+aZGNHEysrl+82SFc1lmk0xwWpsJ45cL6W5fzZ7ijBvAP9SZm?=
 =?us-ascii?Q?t4IfCLs9NANUFep0uiN/1/BYTAoODHpBSHAzRT2O1ityyBG0X0YbUlmza4BN?=
 =?us-ascii?Q?nOuX/epQMUmQzIjHRpFEZqqQisAyFrB+dTK6Ad/+TgMOWoQCOyBNtKeT8F94?=
 =?us-ascii?Q?zp7W94mczlGCWXv6Ux92lELuEyfhiIHPDaCWqIzmi4HbmFFvdA3plzX1TKQi?=
 =?us-ascii?Q?V431O37shjB4rTBbnR7becCUy9MI8IY41BT9c0LCm2EC/zI8hedoZg2Th5vK?=
 =?us-ascii?Q?PeIj24StDzI541YZ4anfSVNHkCbJOCaGsVKS0VTuCWdLFHOQjisRI/ryLNxd?=
 =?us-ascii?Q?tD8bV+jyD8yFhKWk7TcoFEoUhujnirx5GJXm7UUktMuAsZMQP7zIhVsQxv07?=
 =?us-ascii?Q?Rw2pB/Yw/aJsKmvajmm8sQlYYIj/DZMRt/F8o+L8mL4kbCxni7KgPlpT1ed+?=
 =?us-ascii?Q?Yt1+XipXZvC6Eiraw7Wj5Xx5TAFYfFNM2LR3WiYFvmmzRInajX+AkLOVazri?=
 =?us-ascii?Q?Lw5babaO1WV/F8YnHdT/VRV/QDzhBnSAH4Niz5TmOg1TDEmH7lmBU2Ilc3CS?=
 =?us-ascii?Q?UCAOY/sGyb+HNNXjKj8ks9LTVJcfSRvNAqGaJuB4QdOcWEOVHf6mqzalW1AY?=
 =?us-ascii?Q?RUuyJ9whv9HJEUHb1K7PwnSWJXjbloNH8cOsKequSzuaE/Jv7ftfDV4KRC4q?=
 =?us-ascii?Q?YrcHaB8sQxY5znamG5ApWHn7qpy+ewZCKYBGKTGVq8sbqD1lGj7HyWuLNKNR?=
 =?us-ascii?Q?+5Id+odYkqDldjr6ZKnZ9l6DW+spRxbConHBSby9jzEdssP07s+YL9yGF7P6?=
 =?us-ascii?Q?swo9LhnH/+awIn/KFhvDnz9K9444kFV4EuHfFuPD33rQJMyPu0K3B6t0F3b1?=
 =?us-ascii?Q?BVQ3OBeSLNvpFqPiAkln+yuQs47OPZxpar2DVfjSwsgVEzfib7RRPSrf5pRD?=
 =?us-ascii?Q?B18aJE2UYyC7UuLVX1MvNlxk8ZYQeJUxwOsNc3nWt/VxIAMGGPrZ7wzASfNl?=
 =?us-ascii?Q?bWTfU4xUht8Iq+tjH2thT78lb1+4QfMI1AKDKtSfiDMY09N5xzUoULXhDCa5?=
 =?us-ascii?Q?zhts7B6rEWt0Th2vLfLWpqAKvMep3kEFGXQQbyOMw36d6VwZhk+0t9bPA9Nh?=
 =?us-ascii?Q?jgBmqAljWRmSqitCY5HEUx5mjW5bZVfLOuMoJZ6EtvGni3svTuii7kZ2mHt+?=
 =?us-ascii?Q?Krjssqsyhf3D3CtWTIA6xd6wkEwquMLX0oEUJOVO5EKrft1KVieA3CEzQOng?=
 =?us-ascii?Q?AUbi2TZCqt74an2WKFO8v2Ny4Vc46eU06OgUFwOzNmhMkUwlj84TmZ9gx4Jq?=
 =?us-ascii?Q?Vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	XbcGSN66aHjmxdZ2GVLkOT5CvWwzNgbE0fwH/OGGMJzFKyevZkb/gapik9VMEHlJZyneqZFvpWKN/tCHeNVbafrcmjblAs7InscO8VLmn4TUDkQRtIL+dZYDFXzRa7p6V8Zw/jOSJUR7xWnMdvQoMM85oleEmwIvBVPC2RhCiTOGW6Kw3p07KtcsYUzMo64bHc9x3oXY5Vq1+FoxWXIu52U/A50TSGdUolbHtAmGPlcvHUs7TCbVJ0YeqD2+zNmqVwyN2LtZFxrP9PQ/f/5T03M2sbnApLE4yugi97rpuCGKTLW5qOSudeuDdZ8xxyBxosanKaNh8dPZ18bHjp34VO4NtQnkSCPqd6tVJyPPPSV4l+iL0vfENjaSf8O2eAb3ILakOaG4/xVr7WWntDhF1tZMxcZ7DzqAsoYMkn8vTJD2Sbd0Tw5cRB0GAawW/Cugoa8+PzV1XZej/vc9Ij9MZMdNidqkLn1/aMw+mT6mM/FZR4ylQeOyd94iKHpOxcMjDOTMyCDIsHf1PsXPG3NoLNL+USLNEpzdhIaZ0rTs0Rh9Dm7vaLE2Jt3ZwBlAsQSkk+pQbQ2vKQUibBpK3mob/IkLghfXmedhnejtspt8JMk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 040325da-7007-4d81-d549-08dc818f515f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:32:52.6149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Hq6ORONMimXAGWbvrENRZSTSw085k87WF+2ENSKnRqVu9NIGDTGTswKgRRzwnbU4+E4Jtme82aGAjS3dyR4Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4238
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_12,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 spamscore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405310125
X-Proofpoint-GUID: i1yIdGP9yCBuwoSiJ295m-z6MP0-lG38
X-Proofpoint-ORIG-GUID: i1yIdGP9yCBuwoSiJ295m-z6MP0-lG38

Use vms_gather_munmap_vmas() and vms_complete_munmap_vmas() to prepare
and execute the unmapping after the new area is written to the maple
tree.  Delaying the unmapping avoids RCU readers seeing a gap in the
vmas, which isn't supposed to exist logically.

Gathering the vmas that will be unmapped allows for the accounting work
to be calculated prior to checking if there is enough memory.  Using the
number calculated during vms_gather_munmap_vmas() allows code to be
reduced in mmap_region().  This removes the only caller to
count_vma_pages_range(), so the function has been dropped.

This does have the side effect of allowing vmas to be split for unmap
and fail may_expand_vm(), but the number of pages covered will not
change.

Note that do_vmi_munmap() was previously used to munmap, which checked
alignment and overflow.  These checks were unnecessary as do_mmap()
already checks these cases, and arch/mips/kernel/vdso.c
arch_setup_additional_pages() uses predefined values that must already
pass these checks.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 84 +++++++++++++++++++++++++++----------------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 3e0930c09213..f968181fafd5 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -364,23 +364,6 @@ anon_vma_interval_tree_post_update_vma(struct vm_area_struct *vma)
 		anon_vma_interval_tree_insert(avc, &avc->anon_vma->rb_root);
 }
 
-static unsigned long count_vma_pages_range(struct mm_struct *mm,
-		unsigned long addr, unsigned long end)
-{
-	VMA_ITERATOR(vmi, mm, addr);
-	struct vm_area_struct *vma;
-	unsigned long nr_pages = 0;
-
-	for_each_vma_range(vmi, vma, end) {
-		unsigned long vm_start = max(addr, vma->vm_start);
-		unsigned long vm_end = min(end, vma->vm_end);
-
-		nr_pages += PHYS_PFN(vm_end - vm_start);
-	}
-
-	return nr_pages;
-}
-
 static void __vma_link_file(struct vm_area_struct *vma,
 			    struct address_space *mapping)
 {
@@ -2863,47 +2846,61 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	struct vm_area_struct *next, *prev, *merge;
 	pgoff_t pglen = len >> PAGE_SHIFT;
 	unsigned long charged = 0;
+	struct vma_munmap_struct vms;
+	struct ma_state mas_detach;
 	unsigned long end = addr + len;
 	unsigned long merge_start = addr, merge_end = end;
 	bool writable_file_mapping = false;
 	pgoff_t vm_pgoff;
-	int error;
+	int error = -ENOMEM;
 	VMA_ITERATOR(vmi, mm, addr);
 
-	/* Check against address space limit. */
-	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
-		unsigned long nr_pages;
+	vma = vma_find(&vmi, end);
+	if (vma) {
+		struct maple_tree mt_detach;
 
-		/*
-		 * MAP_FIXED may remove pages of mappings that intersects with
-		 * requested mapping. Account for the pages it would unmap.
-		 */
-		nr_pages = count_vma_pages_range(mm, addr, end);
+		/* Prevent unmapping a sealed VMA.  */
+		if (unlikely(!can_modify_mm(mm, addr, end)))
+			return -EPERM;
 
-		if (!may_expand_vm(mm, vm_flags,
-					(len >> PAGE_SHIFT) - nr_pages))
+		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
+		mt_on_stack(mt_detach);
+		mas_init(&mas_detach, &mt_detach, 0);
+		/* arch_unmap() might do unmaps itself.  */
+		arch_unmap(mm, addr, end);
+		init_vma_munmap(&vms, &vmi, vma, addr, end, uf,
+				/* unlock = */ false);
+		/* Prepare to unmap any existing mapping in the area */
+		if (vms_gather_munmap_vmas(&vms, &mas_detach))
 			return -ENOMEM;
+		next = vms.next;
+		prev = vms.prev;
+		vma = NULL;
+		vma_iter_prev_range(&vmi);
+	} else {
+		vms.end = 0; /* vms.end == 0 indicates there is no MAP_FIXED */
+		vms.nr_pages = 0;
+		next = vma_next(&vmi);
+		prev = vma_prev(&vmi);
 	}
 
-	/* Unmap any existing mapping in the area */
-	error = do_vmi_munmap(&vmi, mm, addr, len, uf, false);
-	if (error == -EPERM)
-		return error;
-	else if (error)
-		return -ENOMEM;
-
 	/*
-	 * Private writable mapping: check memory availability
+	 * Check against address space limit.
+	 * MAP_FIXED may remove pages of mappings that intersects with
+	 * requested mapping. Account for the pages it would unmap.
 	 */
+	if (!may_expand_vm(mm, vm_flags, (len >> PAGE_SHIFT) - vms.nr_pages))
+		goto no_mem;
+
+	/* Private writable mapping: check memory availability */
 	if (accountable_mapping(file, vm_flags)) {
 		charged = len >> PAGE_SHIFT;
+		charged -= vms.nr_pages; /* MAP_FIXED removed memory */
 		if (security_vm_enough_memory_mm(mm, charged))
-			return -ENOMEM;
+			goto no_mem;
 		vm_flags |= VM_ACCOUNT;
 	}
 
-	next = vma_next(&vmi);
-	prev = vma_prev(&vmi);
 	if (vm_flags & VM_SPECIAL) {
 		if (prev)
 			vma_iter_next_range(&vmi);
@@ -2950,10 +2947,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	 * not unmapped, but the maps are removed from the list.
 	 */
 	vma = vm_area_alloc(mm);
-	if (!vma) {
-		error = -ENOMEM;
+	if (!vma)
 		goto unacct_error;
-	}
 
 	vma_iter_config(&vmi, addr, end);
 	vma_set_range(vma, addr, end, pgoff);
@@ -3075,6 +3070,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	vm_flags_set(vma, VM_SOFTDIRTY);
 
 	vma_set_page_prot(vma);
+	if (vms.end)
+		vms_complete_munmap_vmas(&vms, &mas_detach);
 
 	validate_mm(mm);
 	return addr;
@@ -3100,6 +3097,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 unacct_error:
 	if (charged)
 		vm_unacct_memory(charged);
+no_mem:
+	if (vms.end)
+		abort_munmap_vmas(&mas_detach);
 	validate_mm(mm);
 	return error;
 }
-- 
2.43.0


