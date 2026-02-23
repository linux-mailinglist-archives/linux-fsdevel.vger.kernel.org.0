Return-Path: <linux-fsdevel+bounces-77901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id exRvAU69m2m45gMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 03:37:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0201716A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 03:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CF2DD3013DF9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 02:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976522777F3;
	Mon, 23 Feb 2026 02:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IQhFTCqr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="x7TECAtH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40BA26D4C7;
	Mon, 23 Feb 2026 02:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771814219; cv=fail; b=WhGszebDWOU5qGdTE11HuNdoZza25Q0LpZYiRXoLiMcs2qHe74Gl0+1apwNqWOpFplW/ybvJy3h1Zyy3QyXDYf7Sulby2FRQSXfcWdhDaRq64roebK0UCt9cSk2l2j2pN7J/K2TAIA9iOtyYqlUy5LResvkgAwOaNWWsKuSs490=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771814219; c=relaxed/simple;
	bh=L6eGBkvrqd25efQsLe6hsYQew1V0wBGIW1VhplK5IaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZczY0t1lOcGslv33BQZB9F3KMqP6zGyxEpbXMcecjSKsgylLPxOBOXd0H/9/caA+O2MwRWtsymqm50T3cnBEPSigRFdUQ2PtYHDHHm8i+7oPq7P4rCROXa85Zs119bxaNbIhJGCbOkLgW+EDZLACEWTWiL7TiMiiAK02/oXVuK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IQhFTCqr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=x7TECAtH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MNfjqg456804;
	Mon, 23 Feb 2026 02:36:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=S7Iko5UqSiMXkJZJK21BZq0Aay8dovDvosrnL4rN/rc=; b=
	IQhFTCqrkxHoxy15EIXxFAgbHAwuqhUUNPgko9XxI0bzmf4vDe62CtwmvD8yRQ6w
	WYQGjf9gzKUCfq93PElp1hnsLHqNNs7uOju9WYTx4z1XMLnZXswJyjeDPRhDrjsm
	CG7cDd+LSwFecNX5t5ExfMXmzU21oE5+HML1lZ757oKsRoH8FWLOFtzpl+VRmn+1
	/Dx95AeNemAcbHWnDll3QFVCh8y0180Lbw9PSZeS4zu6Uglir1gcDRtRltjrUtNj
	9UP0crgZ1t/U39aFV58epJpMbJu1e2txLa87o9eWHtAMpJhzLozB8aijN4touiNl
	59abJ1+42rT1rSA/Q4kQNQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf3g3hf24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Feb 2026 02:36:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61MN2VXj006367;
	Mon, 23 Feb 2026 02:36:24 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010029.outbound.protection.outlook.com [52.101.46.29])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf3582j9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Feb 2026 02:36:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJ+zhpMbPvUhoO2fKKKh57g6txriv5HLEs/bJ6RV8l2MdjfnsD2Pp+m3b3kZgsf4ZvCeUES0RC2Gtu32Bva3rAtTE73rFDBMYOn7HJrrdXEAjnKBdzegMDomNNvffo3Rk2FHsHHcFLZqWVg8idB2DLh1XxU4W5+CjZjCN1+aYOurtDxFO15Qj6QOaoJxXuopNW3xT5jkntRg0VpggbX3JBTcPd8ggRxxoIaLTDW0mmjLqQypO9BBUvcbb4wUDjVwuiFRejqN74C2NWWf4YxCvbbIH+qvSo5Am6nB4VmlTFoZyzXyCq2dQGDGTbFb2/Gzqd0dyzOVza+y2DAPOKkp0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7Iko5UqSiMXkJZJK21BZq0Aay8dovDvosrnL4rN/rc=;
 b=oHgZY+W7lU/Uj1HvFImSDcuxny8PW9TeXVzTfSLKLJUFxnBvFTXGV+bkmDYu2GbpPmPK/cxvXAGLCFJUR+uOJsWVbXvgd+yMnyUbp2yqyK4Wh4M1JF8yPSLKqNkBRlhoq4+xP6MHGRAgPLAp1g+uohESthVY/LaaHke8Y6UVHOlqhFz+zhMeiR4mbKvRPhwOWrXKzRxeCZ6gzvJHqfxj+mFquYmtxT3s7ZK2tJ4r9OzntgLg7uSIQ0mm3qQW26/IzYtufB4wMkNP5gweXDuljPDK5Rx7Nei0OHp3rE4ciNWZ02DfP+PC7kis5xomdFdUGr846Nm1SXOrPVLdkPtYzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7Iko5UqSiMXkJZJK21BZq0Aay8dovDvosrnL4rN/rc=;
 b=x7TECAtHcivQt8evWUsCRifNuHzAtvrqWAtIhPNDiZBT9N1bTYnLi4JN4RbnIBXNQ8/nWh5dfM6YZXRqpIRt7h14GwKVUvRUeIHdoDxX1G3+R2KuVg3XIos5UEIzUhM6WBXCIe1h8ihrUTmx67oayqAInLVuJ8Kft9rUHzyHIEo=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH8PR10MB6525.namprd10.prod.outlook.com (2603:10b6:510:22b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 02:36:21 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 02:36:21 +0000
Date: Mon, 23 Feb 2026 11:36:11 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>, Carlos Maiolino <cem@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>, ojaswin@linux.ibm.com,
        Muchun Song <muchun.song@linux.dev>, Cgroups <cgroups@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>, Hao Li <hao.li@linux.dev>
Subject: Re: [next-20260216]NULL pointer dereference in drain_obj_stock()
 (RCU free path)
Message-ID: <aZu9G9mVIVzSm6Ft@hyeyoo>
References: <ca241daa-e7e7-4604-a48d-de91ec9184a5@linux.ibm.com>
 <aZReMzl-S9KM_snh@nidhogg.toxiclabs.cc>
 <b4288fae-f805-42ff-a823-f6b66748ecfe@suse.cz>
 <ccdcd672-b5e1-45bc-86f3-791af553f0d8@linux.ibm.com>
 <aZrstwhqX6bSpjtz@hyeyoo>
 <aZuR6_Mm9uqt_6Fp@linux.dev>
 <aZuVgStlrvZ87duZ@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZuVgStlrvZ87duZ@linux.dev>
X-ClientProxiedBy: SE2P216CA0082.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c6::17) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH8PR10MB6525:EE_
X-MS-Office365-Filtering-Correlation-Id: 974649a5-01d7-4669-ce81-08de72845432
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REI4Rm14Yzl6aTRDS1pnNlpRZTk5Q3BKQU9ON1ZZbEczc211VVFWaTlTSGli?=
 =?utf-8?B?VFMxdFhuVTU3cWFPVWYvTHlwbHdBbEIxaXFBY09vYWRnVjNjaU9aN2wxK3Zy?=
 =?utf-8?B?NnZVOWR0VDEwTGZBdDBZMXZZKzc5MEU3MzNuTkJWZFJSdkozWkxQNzV2NUlX?=
 =?utf-8?B?ZVRvVzlUTzcvL1kzVEdaeVp4Y3R0dVdHRFo1R1Y2RHYwNFJqVFhpeFpkUXYy?=
 =?utf-8?B?OUp0QWo5K1F4aFNJb1ZXeDhEWU84dHB2enJrOFBDcTVLa0FVdFFlV3FibSs4?=
 =?utf-8?B?djN2YXNLZUpXS0hJbnlwR0xFREo5SjFqb0Y1ZFRXRFE3dzBOcVpKSDFSUWNh?=
 =?utf-8?B?bWwxZElmV1RDdGMzcUZoYnZVUnluNU1Zd2RGNjNkcWpET1BKMWZDaHpsSVlu?=
 =?utf-8?B?VTVxTGZFUExQUXFUT3cyN1p2OXZjdThBTXNhOVFSRkJDa0QyeVByNXc5Qk5a?=
 =?utf-8?B?SGova1lZdEJRckJQVXNNTXhZaVpNVlcweFR0TThSUkRxelRsalFRaU96ZVpO?=
 =?utf-8?B?bENyU2EySW0yU25Yem0xQnFVd2hLR3RJUkw5WkRvazE1ZkJaY2svcU44S0Zt?=
 =?utf-8?B?YnlxYjNOYndUekN2YlB4OTByMWorOFl1Ly9iN1Q5b1JVM3Y0aUlmWnY5NCsx?=
 =?utf-8?B?NWtwMFVxVWVwMXJjYWZsVWRrYXF5ZFdveWZuTWRSVzdwTUtTZ0svRDk2WC85?=
 =?utf-8?B?bHJjdVpaZGhFdVlmcDdHNDBtUHBsTmhtSk9EdXBPS0hwZnloV0o3TEtTZHdB?=
 =?utf-8?B?dUM1SVNUcktkbVpDaDJ1VVlCWDVmZVRuMDRob1laUWFJdVYzcmtlMUhtNmU3?=
 =?utf-8?B?RU1RSzRpR1FqVnBvcEUrL3ViVmcxSUpwSDB5czRBdVEwekJCTGFPQTJHY0pp?=
 =?utf-8?B?ZFR1cE9PYWJpUURCOVJlMEhxb2JCOFpYc1lRcnNTeWkrVGFXQjNqaGRrM0l5?=
 =?utf-8?B?aElPaUJYU1liL29kdW5hOC9DZDZ5a0hyY3hja0thRExucTNPT2pkNms0a0hV?=
 =?utf-8?B?cGpjM3NRTFB3a21XMnNyMDVNb29CWTEzQ2ZrU0ViMW1lUjhwckRSMU0veHN0?=
 =?utf-8?B?Qk1MSThTOU53ek5RWjJHSW9qUkczeHY1dEN4UmU1RFlpdGJPVHVFa1l3T1RQ?=
 =?utf-8?B?T2JrN2VFVHBReVNGOEtNNThENTRxa1pmbDJuQlFqZ2RrUDRrckhKeVk4aklr?=
 =?utf-8?B?a1dVbXpuZGk0WWtOa0JBaXhtd2Q1dUpCMkVkdDZ6elBLN1lWZkh5emJJZDVr?=
 =?utf-8?B?bStxanJmVjBQTklxMzhySU5uemc0amllbWlWcnhSOTNjZmdSM3dqRk0zczlp?=
 =?utf-8?B?ZXVCdlVYVWYvVDIyeFBxbEJUelZlUStPb0NCTmNJNEZCUTZjMHVPa0N3WERs?=
 =?utf-8?B?TkJyanhVaGdPbXRBRisvSlZkZHdlY0FRZHRHWTU0MVlobERNK0crL1FNc203?=
 =?utf-8?B?WjhNWmYyR2Rob1NkZ0E2VUR5ZjlBMkNKNVphMVgrdkxCb2plaDFVeStZc0Y1?=
 =?utf-8?B?cGVSQXJQQWFvVE5xYng5QmlsUS9KbC9DcmJHWWUrTTlXM0VKOXc2ZjM1UHdu?=
 =?utf-8?B?T1lWYUpiMHJIM3NFVStmNWRUMVh3NDM2WVdqb1FKck5tUTU5d2lsS0NMOWh4?=
 =?utf-8?B?RmFvQjQrb0thc2k3Wm1TMW1CMXZZa014S0lGNitFUVdEbmlpMUVrOU5jWXE5?=
 =?utf-8?B?SUo0bVlGL3h6SWdyU2pxWVZRNUFieFp0Z1RBRmZXa1YweGRKQXZsQ1Q0WHlG?=
 =?utf-8?B?cUhDVWhuWG4xc3Q4Z2RncTBkaERMNEl1ZTB0Vmd3T3dXQ2g3VFE2NDlxSHov?=
 =?utf-8?B?WU9kT3JjeFUrZG9WWHVJZGtISE16UWxJUGlWTnBWU2JhQm9WVk5HYnRyS2lG?=
 =?utf-8?B?TFZseVVodlAyWGdBYXljT2JSbXF4cEJlWm15SUFEdEhjeEphUXRIMTNGYUVy?=
 =?utf-8?B?dHozbHpiSTlHUzNrM1ZQeDNlR1N5RDhROEQyWUJZeC9GcnhIalZOR051WENW?=
 =?utf-8?B?UFRxVndRQXVJY2oxWGZZYXhRMlh4UGlOL2pOeklyVkxDMnpObXAzbmREcnll?=
 =?utf-8?B?QTg1VDZXVy9DL3RPREEvZjZleW94cER1NGdFUVgzZXlXMVE1TlpEK1FxM3Bt?=
 =?utf-8?Q?c5ww=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0lSV1JrSWNVRjdHTFlXWi9uM3pwSGwvKzZiV3ZSVGNlZ2FYZ2dua0ttUkNm?=
 =?utf-8?B?OEhrdkpybXhsc0pxTFZLL0lnNEduMnF4Ym5lL3RWUHJMWW5WVjlEcVlzdVFl?=
 =?utf-8?B?QnVTcUxaVkhBR0lHNXR2a0EzeWZNSW5BRjJ2clpYZlpGZDlQOWNGUnA0UWJX?=
 =?utf-8?B?aHpoU1dDNXozck5OcWVBcGgwcXFjQWhoMWF5R01aUkMwQU1MdzlXMy9LdjN1?=
 =?utf-8?B?M2JVblpYeFdGeCtSem1NVkZqN2lUTS9lZWFIOU05QnlKcE12c2g2NC9NQUdi?=
 =?utf-8?B?cGlBK0tHTVVtbVVQS3lHTWpZY0U1WWIzUktXSXVxK295SUpMaGxkYUhyb0dt?=
 =?utf-8?B?eldRYVNwQXBNMEtjL1lYRmJYN0R0SGNoS0hRUWxBM21CMVdPZ3V3VXdKZHlO?=
 =?utf-8?B?RkxmVDFQMWhwVmd0MHl0Ly9VeS9rVGMvN1B3UjI4djN1N3JuYnlDak53Sksy?=
 =?utf-8?B?NzhpQmFtcjdHNFRrbENacFMrSFZEdGNpeU02ZW5yUWtyd2M1NEpoSXh4eUpq?=
 =?utf-8?B?YVBNaElHY0NjQ09aRVcrVGJCTTdNMmtkUmpXVUNDYzF6UXVKQ0ZacyswTjBw?=
 =?utf-8?B?Ykc0TklsOWdFdzdkUUhlSkRPYkdtYXpJNmNmaGRoMXBvNTBGU2hVVWFJeDFm?=
 =?utf-8?B?T3lxMS9oazFYdnNESnJxV2o5bityUWVKeUJOR2MzN213MTZmWUtIZ001S1Zy?=
 =?utf-8?B?ekNYUlBSaENNdDZRamJRVVNBKzBUZnM3U3Z5TUxTOXFEMkdacUNYUldpNmNl?=
 =?utf-8?B?T1lTc3ZpTnYrc1ROcitKakV6QVVqdU80NGMrL1lzKzhUYlAxN3VlSTh2ZGxF?=
 =?utf-8?B?Rkpwajk5RHRPZWRhbTNPcXUrL3lVSXR4RStCYUMwMXFxNkpCMnhGcnNUQ09t?=
 =?utf-8?B?T2JzdFFSNlF1Qi8waTdzOW1LcmY1TGEvNjBJdGdrcWJ6YmFmSGh4VU9PK1d5?=
 =?utf-8?B?Y2xjQzhSRklsSjgrbzllSFRlR0xTTjZxdWtyaVpFMTZBV2tEdEFtQWRVTTRN?=
 =?utf-8?B?SjBGL3FKQXdXQVN3c25OeFMza0Z5Yy8zWkl3elNCSitDQmE0VUw1TUdCNVIy?=
 =?utf-8?B?V3drUXFEYVl6VHIya2F5REJaa0hwaE1FRjVUUXRkUVJqcmZ1NzIxZ2hYdFVm?=
 =?utf-8?B?RHErMDZIbE1Jdzc3V0VaOFNkQTBRVWJaM3NicmpLdlBQeVNKRzNFVnEyL0gv?=
 =?utf-8?B?Vmt2WmdwSkFpdERuSks1QUNBRXFnMUVZOHBsTUpXVGpsYnBkbG9GN1F2TG9Q?=
 =?utf-8?B?T2FSN1hGZEdaS1hHWXFyMkIvRzBSUG9CZTVBQmtSWGhmWWJsK2x3VFdCQjE2?=
 =?utf-8?B?a2E0ZXAyR0JURHBZanlDMEUwYm4xUVhMekg5aW5pK1BXaWR0Q1NhQ2dtbDZz?=
 =?utf-8?B?SHNwY0V4ZDhGNHJ1eGRqRUFYSFpDdGpEb2JsaVh1YlBkL2dZSURQcWNlcEEr?=
 =?utf-8?B?Kzd1cjF0emlVaG53SkxsTFBCSnRWdTh2a1ZMejZqaVpRYnlXb282c2t2dlov?=
 =?utf-8?B?dTNwWlpPaEEwLzBHOGpPTmhCUHRZVVQ4ZDJlcCtGcG5OaTNXaGFrd0YzVDds?=
 =?utf-8?B?bnpEbWZUcGdzVFhsOHRLQ1F0QW5OSGsrUDZ5WDkxZGdBWm5kcWVESEZsMnlW?=
 =?utf-8?B?b0RVT1M4K3V6dnZ6QTE0MG5Nd2NlSFJYMmJwbEhXVktpUEt2Mm8wZTJJbFdo?=
 =?utf-8?B?T2w2dVR0cnBqRUl0azVhWWJENVJ1Z0RsUlJvVE9URDVkSmd4T0NndVJkYjBa?=
 =?utf-8?B?TWR5VmRrWU1Zbml6dUZtOEptV1dsZTh2UTV5SkYveUk4bkt6ZGpYR0JFSjcr?=
 =?utf-8?B?Q29PUFhzS3grcTJuQ2puZDNCd0piUHJRUHNJUnBHS1Z5Wjc5bXJzd2J0a05I?=
 =?utf-8?B?SU1vSWg1dHVQVDhFTEphdWc4UW9NSmd6b3dwZFdac3pBN2RoeGtqSGEyckRL?=
 =?utf-8?B?M2NUN095UHpCem5IekRTQzBuTkx0ZnZiNHNwN0x3S2VDaHVjRjcrb014R2ZS?=
 =?utf-8?B?REFDZ0VSTW9wL3lGUW9jVkZ0K3E2OGF2VitlQjNOQTVsK0hqLzl6NXkrWXBJ?=
 =?utf-8?B?aUVCczg4cUFxMzlwZ0VNQllZa0MrcE9ZQk1Ba0lwRVBPb2pkOUQyRGV5N0Zt?=
 =?utf-8?B?S3dUc3FpbTd4dXF4R0ErVlBRZFlLZE4xVDJzRnpydC8xRUcxTnVidVA4MjNz?=
 =?utf-8?B?QVUzRDJjWWJ1dGhMeUVpWFNWZGM1Nk9kSWZDcmViRWo5a2JjZ2hrK3ZDSXZB?=
 =?utf-8?B?Vmc3Rml2VmFqU29JTTNrQmovUTJ6Z2xjYnJSN0IwNTN3QVdMOW91WktoYmMr?=
 =?utf-8?B?Nks3Umk3ZlcxL0ZIbkJVUHo0UUV2UHlrcGtaejVlZ0pTcktZOHF2dz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tMeJ9rnd7Pm1ilSMi8mRhE0AGg7UugBO2QT8oHDFfC3mNFxC5Ri0PuBWtx2HgBweY32BRbluTC98s8ox7h2eWe/ckGuaSbkI5d68kZ0p7Y9u5IvL6AKlRGDc1exbWmqO1QpgcuPQ1C+tbLgcfXr7pZymbuQWiZETjZ0MUKlsw8gcbzzqFfzXcPo4zzRTCxeev/1e9I9hs06mLsS9iFaD0Hxu5b7ueq5T5e+5kTKQFysHDNTdlOZlLmz4qvoKSES2C3JX7i8fKhtRR1q7rfX+zQsl91n+Gel5kXno9VUn8FFn4qQvm2mLtv9aEM0mxgLWmWVCsHF51zhWm2EsSj0elWY1UNCufpBqgsWUSqWvCKk5kV3qCjBNcPhD9b1VGVvxfo1sWtZL37vnj+NsRSGOHZ37tqdfD/RUra4jftZHV9HPo1BOFvoNEeDs58C3Pi6Dhz2OknP62iM1zpxc8Fcs8L/aU3CKU3wRtuL43CN9YOJr56SOCDQRv8u27sqCes9+pGz/UwaiE7AMcHYcCyRfMfkCzUI2AheT9cOsUT33Ka0FuPlD6YFBLZlQLZ0SqWDV/afG8U3fXB+2hPMFYWTmBq52XoHIiMDHvP3QdpNvORs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 974649a5-01d7-4669-ce81-08de72845432
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 02:36:20.8772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B7p2iFh/jV0J2CkEW65qbnh+Un32Cdo+p4CV/lOJZjccXmEwbPSem9KOXzVUSEKfKaoPZyd/nBBH/J14QrPQYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6525
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602230021
X-Authority-Analysis: v=2.4 cv=Y6r1cxeN c=1 sm=1 tr=0 ts=699bbd29 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=q-rpDZWnhHIED0GX8zUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: umiNdndNqlVGuhgJtu8On2FjvDUkYj_V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDAyMSBTYWx0ZWRfX4dkWf7zN8XHU
 e/xY5reoNxajBM/3NXgzaYFNmm3HUshP7HYFekK0tEB0obu5IV96mYJREamZJz/a1mJgvA36EEq
 zffi+MfPgH4hGLl7gd2w38j/S3cQGOC6BtXSMHlXm5OWQcAmKQTxotlchhdIl/+DDYq7VN4F3mX
 XvX0R/O1/XMMVDZTpeDoZbD21IwHwdtnjoiVrY4C6kl7EhISRp6r2Z5NHlCu+A7KUuzxN74HTiw
 /FAjjq2j1loxSMtBeT94VcxpDbp+t1JxqrTr/dqjLhJ52qPxllLb58hYbO6JzdVy3FQ8rQTZlm/
 VWMcOKjkhlWQ94fEr9TuLTkQq8uxU44arYzNzV6uzFU5fq01nsL4TYb8pZWPXPcVT25f3h7tNdL
 p4zlcv8JS9AFNfG43yjiC6WRpowtLePz5//VbsSwvMQg8ipsICt92/Aqw/qZPo0DzhS3hTGmMka
 XcPsiPoVslCN3fbBlZQ==
X-Proofpoint-GUID: umiNdndNqlVGuhgJtu8On2FjvDUkYj_V
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77901-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:dkim,oracle.onmicrosoft.com:dkim];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry.yoo@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 8D0201716A1
X-Rspamd-Action: no action

On Sun, Feb 22, 2026 at 03:48:53PM -0800, Shakeel Butt wrote:
> On Sun, Feb 22, 2026 at 03:36:46PM -0800, Shakeel Butt wrote:
> > On Sun, Feb 22, 2026 at 08:47:03PM +0900, Harry Yoo wrote:
> > [...]
> > > 
> > > It seems it crashed while dereferencing objcg->ref->data->count.
> > > I think that implies that obj_cgroup_release()->percpu_ref_exit()
> > > is already called due to the refcount reaching zero and set
> > > ref->data = NULL.
> > > 
> > > Wait, was the stock->objcg ever a valid objcg?
> > > I think it should be valid when refilling the obj stock, otherwise
> > > it should have crashed in refill_obj_stock() -> obj_cgroup_get() path
> > > in the first place, rather than crashing when draining.
> > > 
> > > And that sounds like we're somehow calling obj_cgroup_put() more times
> > > than obj_cgroup_get().
> > > 
> > > Anyway, this is my theory that it may be due to mis-refcounting of objcgs.
> > > 
> > 
> > I have not looked deeper into recent slub changes (sheafs or obj_exts savings)
> > but one thing looks weird to me:
> > 
> > allocate_slab() // for cache with SLAB_OBJ_EXT_IN_OBJ
> > 	-> alloc_slab_obj_exts_early()
> > 		-> slab_set_stride(slab, s->size)
> > 	-> account_slab()
> > 		-> alloc_slab_obj_exts()
> > 			-> slab_set_stride(slab, sizeof(struct slabobj_ext));
> > 
> > Unconditional overwrite of stride. Not sure if it is issue or even related to
> > this crash but looks odd.
> 
> I asked AI to debug this crash report along with a nudge towards to look for
> stride corruption, it gave me the following output:

Thanks!

TLDR; I think stride corruption cannot happen because we don't try to
allocate obj_exts if we already have it (w/ SLAB_OBJ_EXT_IN_OBJ).

But the other analysis saying it's memory ordering issue seems
very relevant.

> # Stride Corruption Bug Analysis
> 
> ## Bug Report Context
> 
> - **Crash Location**: `drain_obj_stock+0x620/0xa48` in `obj_cgroup_put(old)` at mm/memcontrol.c:3059
> - **Root Cause**: `percpu_ref.data` is NULL, meaning `obj_cgroup_release()` already ran
> - **Platform**: IBM Power11 (pSeries LPAR, Radix MMU, LE, 64K pages, kernel 6.19.0-next-20260216)
> - **Trigger**: xfstests generic/428
> 
> ## Identified Bug: Unconditional Stride Overwrite
> 
> ### Location: mm/slub.c lines 2196-2223 (alloc_slab_obj_exts)
> 
> ```c
> retry:
>     old_exts = READ_ONCE(slab->obj_exts);
>     handle_failed_objexts_alloc(old_exts, vec, objects);
>     slab_set_stride(slab, sizeof(struct slabobj_ext));  // BUG: UNCONDITIONALLY SET
> 
>     if (new_slab) {
>         slab->obj_exts = new_exts;
>     } else if (old_exts & ~OBJEXTS_FLAGS_MASK) {
>         // obj_exts already exists, BUT stride was already modified above!
>         mark_objexts_empty(vec);
>         kfree(vec);
>         return 0;
>     } else if (cmpxchg(&slab->obj_exts, old_exts, new_exts) != old_exts) {
>         goto retry;
>     }
> ```
> 
> ### The Problem
> 
> The stride is set to `sizeof(struct slabobj_ext)` **BEFORE** checking if `obj_exts` already
> exists. If a slab was created with `SLAB_OBJ_EXT_IN_OBJ` mode (where stride = `s->size`),
> and later `alloc_slab_obj_exts` is called for any reason, the stride gets corrupted.

I think this part is bogus.

It's not a bug because obj_exts saving is applied only during slab
allocation and initialization. If it benefits from the obj_exts savings,
no need to call alloc_slab_obj_exts() later, thus no corruption.

If doesn't benefit from the obj_exts savings, the stride size is always
sizeof(struct slabobj_ext).

> ### Stride Modes
> 
> There are two stride modes (see alloc_slab_obj_exts_early):
> 
> 1. **Normal mode**: stride = `sizeof(struct slabobj_ext)` (~16 bytes)
>    - obj_exts is a separate array or in slab leftover space
> 
> 2. **SLAB_OBJ_EXT_IN_OBJ mode**: stride = `s->size` (object size, e.g., 64-256+ bytes)
>    - obj_ext is embedded within each object at a fixed offset
> 
> ### Consequences of Wrong Stride
> 
> When `slab_obj_ext` is later called:
> ```c
> obj_ext = (struct slabobj_ext *)(obj_exts + slab_get_stride(slab) * index);
> ```
> 
> With corrupted stride (16 instead of 256):
> - **Expected**: `obj_exts + 256 * 5 = obj_exts + 1280` (correct obj_ext for object 5)
> - **Actual**: `obj_exts + 16 * 5 = obj_exts + 80` (WRONG obj_ext - belongs to object 0!)

[...snip...]

> ## CRITICAL: Memory Ordering Bug on PowerPC (Likely Root Cause)
> 
> ### The Problem
> 
> In `alloc_slab_obj_exts` (mm/slub.c lines 2199-2220), there is **NO memory barrier**
> between the stride store and the obj_exts visibility via cmpxchg:

This is actually a good point.
 
> ```c
> slab_set_stride(slab, sizeof(struct slabobj_ext));  // Store to stride (line 2199)
>                                                      // NO MEMORY BARRIER HERE!
> if (new_slab) {
>     slab->obj_exts = new_exts;                       // Store to obj_exts (line 2207)
> } else if (...) {
> } else if (cmpxchg(&slab->obj_exts, ...) != ...) {   // Atomic on obj_exts (line 2220)
>     goto retry;
> }
> ```
>
> ### Why This Crashes on PowerPC
> 
> PowerPC has a **weakly-ordered memory model**. Stores can be reordered and may not be
> immediately visible to other processors. The cmpxchg provides a barrier AFTER it
> executes, but the stride store BEFORE cmpxchg may not be visible when obj_exts becomes
> visible.
> 
> **Race Scenario:**
> 1. CPU A: `slab_set_stride(slab, 16)` (store to stride, in CPU A's store buffer)
> 2. CPU A: `cmpxchg(&slab->obj_exts, 0, new_exts)` succeeds, obj_exts is now visible
> 3. CPU B: Sees `obj_exts` is set (from step 2)
> 4. CPU B: Reads `slab->stride` → **sees OLD value (0 or garbage)** due to reordering!
> 5. CPU B: `slab_obj_ext` calculates `obj_exts + 0 * index = obj_exts` for ALL indices!
> 6. **All objects appear to share the same obj_ext at offset 0**

Yes, that could actually happen, especially when the cache doesn't
specify SLAB_ACCOUNT but allocate objects with __GFP_ACCOUNT set
(e.g. xarray does that).

With sheaves for all, objects can be in different CPUs' sheaves and they
could try to allocate obj_exts and charge objects from the same slab.

> ### Consequences
> 
> - Object 0's objcg is correct
> - Object 1..N all read object 0's objcg (WRONG!)
> - When freeing multiple objects, we `obj_cgroup_put` the SAME objcg multiple times

Yes, reading the wrong stride value is the path to mis-refcounting
objcgs :P

> - Reference count underflows → early `obj_cgroup_release()`
> - `percpu_ref_exit()` sets `data = NULL`
> - Later stock drain tries to put the objcg → **CRASH in `drain_obj_stock`**

> ### Why This Matches the Bug Report
> 
> - **Platform**: IBM Power11 (PowerPC) - weakly ordered memory
> - **Trigger**: xfstests generic/428 - creates high filesystem activity with many allocations
> - **Crash location**: `drain_obj_stock` → `obj_cgroup_put` with NULL data
> - **Pattern**: Stock has cached objcg that was prematurely released
> 
> ### Proposed Fix
> 
> Add a write memory barrier to ensure stride is visible before obj_exts:
> 
> ```c
> slab_set_stride(slab, sizeof(struct slabobj_ext));
> smp_wmb();  // Ensure stride is visible before obj_exts
> 
> if (new_slab) {
>     slab->obj_exts = new_exts;
> } else if (...) {
> } else if (cmpxchg(&slab->obj_exts, old_exts, new_exts) != old_exts) {
>     goto retry;
> }
> ```

I would say this is an overkill. Something like this should suffice:

diff --git a/mm/slub.c b/mm/slub.c
index 865bc050f654..8db93a88bbbf 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2196,7 +2196,6 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 retry:
 	old_exts = READ_ONCE(slab->obj_exts);
 	handle_failed_objexts_alloc(old_exts, vec, objects);
-	slab_set_stride(slab, sizeof(struct slabobj_ext));

 	if (new_slab) {
 		/*
@@ -2272,6 +2271,12 @@ static void alloc_slab_obj_exts_early(struct kmem_cache *s, struct slab *slab)
 	void *addr;
 	unsigned long obj_exts;

+	/*
+	 * Initialize stride unconditionally,
+	 * but override if SLAB_OBJ_EXT_IN_OBJ is set.
+	 */
+	slab_set_stride(slab, sizeof(struct slabobj_ext));
+
 	if (!need_slab_obj_exts(s))
 		return;

@@ -2288,7 +2293,6 @@ static void alloc_slab_obj_exts_early(struct kmem_cache *s, struct slab *slab)
 		obj_exts |= MEMCG_DATA_OBJEXTS;
 #endif
 		slab->obj_exts = obj_exts;
-		slab_set_stride(slab, sizeof(struct slabobj_ext));
 	} else if (s->flags & SLAB_OBJ_EXT_IN_OBJ) {
 		unsigned int offset = obj_exts_offset_in_object(s);

There should be enough memory barriers to ensure the stride and obj_exts
are visible to other CPUs before the slab is accessible by other CPUs
(by acquiring/releasing n->list_lock)

> And correspondingly, the reader side should use a read barrier:
> ```c
> static inline unsigned short slab_get_stride(struct slab *slab)
> {
>     // Need acquire semantics when reading stride after seeing obj_exts
>     return smp_load_acquire(&slab->stride);
> }
> ```
> 
> Or use `smp_store_release` / `smp_load_acquire` pairs for proper ordering.
> 
> ### Also Applies to alloc_slab_obj_exts_early
> 
> The same issue exists in `alloc_slab_obj_exts_early` (lines 2290-2291 and 2308-2309):
> 
> ```c
> slab->obj_exts = obj_exts;                           // Store obj_exts
> slab_set_stride(slab, sizeof(struct slabobj_ext));   // Store stride AFTER!
> ```
> 
> Here the order is **reversed** - obj_exts is set BEFORE stride! This is even worse
> for memory ordering, as other CPUs could see obj_exts before stride is set.

[...]

-- 
Cheers,
Harry / Hyeonggon

