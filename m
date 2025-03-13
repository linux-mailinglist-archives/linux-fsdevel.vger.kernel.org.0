Return-Path: <linux-fsdevel+bounces-43924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 673FBA5FD47
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 18:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3D7519C3A3F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 17:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7313926B2D4;
	Thu, 13 Mar 2025 17:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RVULheZv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sqNiq0d5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFB726B082;
	Thu, 13 Mar 2025 17:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741886029; cv=fail; b=t/dDNKyGluORfU1c+81Oygj6FYNokxO5V9Gshm0YE+o17p9K1R17H+e4EpVg73QsQXlALex2Pn8QNIS+9RMB1k0LTx//35AsHQRntt/3EHelmP/OXGOOyFmrw8aCPOk3flshCQKD1t+JCiYMoNXXv0TBjrStBfIGwsnHL6ivfWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741886029; c=relaxed/simple;
	bh=YNrRGKBJFFpkicZnNH7U3bm4vJfk/iGk3s1giC+txO4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=trfFSDKjH82XqcyRHsm0jFXBaL1quW5JiVoQVxLfjmCJa00ZdSgJfb+fPufN76jHH2mY70+LoogibaEmsYYgGh/dORUHAMUuXvN/D14JMpRbnk0mwfAnM7qwSU+Nqk3+h+PLcX1Vd8RGnN9HkKCk3NW5tZDOSECdeQ9k3+3PiyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RVULheZv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sqNiq0d5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DGtuQS020758;
	Thu, 13 Mar 2025 17:13:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=IAOx81FemV5vPDv7oqqqACxpiKj5LP7fdQEpgfJicJs=; b=
	RVULheZv1a0Ct2YUT2WIsgVLzqdgrRpIdJfYfDii9++icMUTJiRXPLp9cTKyxlCd
	j8kVI8ZiWqSmB65WjCdicbwqT3yr2ErA9ambUnhGZdPq5xwdAY1/coAbcYxsPeRm
	y5lypF8vafF1yj2K3S84TzgNtSDPKYQlyrEIRFalQyNuBWHerGOWswmK7+ecbIUm
	NUmSGsG+SueS78S7KihbNA3V4sHnGlh1oU04IM28fMivs85/wmZQER8mi6xTS2ny
	ZgKuAmjZeMM7/oyFQSWo/UR3psSo3Tzi87KX8yd6re7LTiBZmVwNIjO9FOJ8mdFL
	WBhIuBHNzagcDLuuLZHD7g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4dvpx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 17:13:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52DG50Lq019547;
	Thu, 13 Mar 2025 17:13:36 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45atn26mpc-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 17:13:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cr3cWdlStvtH/GgwnFNpLV7CEzEVWhZg2MRh8CPTE9hMrXLt0+2NW7X7WplLorKN9SG+eIR7AO32SuEI16LAdT6xIn0r364xDjnHyZuC623QGWeGRgbD7g0KIQu4peuPo94Pnncjxag7kqpAI9pY9mD7AVlwxx2nS4ZNFv8VfY8ihxeA8NRRNqgSobyddKZOIBdbogwzYgCavQcKSuBKk+J4Hb065BfBuGPq83wLMSONBXq6DhGpSRhYsDhDnO6ni7SjtVQAsGNrIs5SkGVBo5sSCFhK1Ji7DQyg3eBDxMBqrJkKEfsG2BJQALYIgeAfBJUNddzkM3xfVYRAXOWTiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAOx81FemV5vPDv7oqqqACxpiKj5LP7fdQEpgfJicJs=;
 b=IYmj1WyiQNDMF99LXPycVF38kQVbkRWRGqPDEljxjJ0F9snzP1aa7F78TZBO6hS/w0NjW15eE11Hz9yNG+Yq2Ctmlx2OwOazfA6MgpJDzs0xa2UNizoLDqNMW7y1I4fLFRv9lIEiGGRLb+PPEMzkfvlgcMkPIZs6E4qqXJjq/A0zV7faytGVWRbVYrrMGzjkrF8ZH0my618SwFwwyclxnLIMFfBJBU9Avc3/xPu4KVctITElkd+rymA6bijJgi2m7FxTBAn4OWqqJVkKoDeV2wlwGTrbllwZyDrCkmCff/LvFcRPFc1R78H75aItRqWI5KAW3MV9UhXU7mnjEJ7zlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAOx81FemV5vPDv7oqqqACxpiKj5LP7fdQEpgfJicJs=;
 b=sqNiq0d5ISl82PiGpdjf5GSn05+iXyrBofgDDZO3i6VmUU3K7S3SCYCJghYX/R150NGUptPlr26i7wBMOVR0/5c8nMmN9CZy3oV/ZbjRp17iv3BKWqVA803z9aOhuD5VL5DeaRtQYDZTqmBoMyZHsxcGGZj07kvH7G1p6He3HVQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MN0PR10MB5982.namprd10.prod.outlook.com (2603:10b6:208:3ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 17:13:34 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 17:13:34 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v6 06/13] xfs: switch atomic write size check in xfs_file_write_iter()
Date: Thu, 13 Mar 2025 17:13:03 +0000
Message-Id: <20250313171310.1886394-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250313171310.1886394-1-john.g.garry@oracle.com>
References: <20250313171310.1886394-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0096.namprd04.prod.outlook.com
 (2603:10b6:408:ec::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MN0PR10MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c4184f6-c298-47eb-56df-08dd625262a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zzWuIlyIHrAXjpKIZ6FWbY+8mZclpyFxU36lO0kbYG5xcb46CiPfhyON2Ard?=
 =?us-ascii?Q?gqR9ywSB/vycj21/tKh5Cz7Mx1Vkl6X5Aki8/ABLDbbtswmAeQxmwGm5QBLr?=
 =?us-ascii?Q?rqAKpLUfVaymI7UoMEbHM/vlj6EaOajhfImIQlV5m+bfsV6Wex0dfipAvq7r?=
 =?us-ascii?Q?jJc6kaMpJh1Ly21yY1DNx5NQbxYOICrleqZvOr3hqMgBftyYKAEL5HyeHM4h?=
 =?us-ascii?Q?wZOW/7GZtBCwEBkzpBj6cj8qfNg58WzTzLZSYOZq1KVpCaHP03wHHDLt/6aa?=
 =?us-ascii?Q?GCzU+XOEbl1itnF5CSFLloj2zo+N5kzcKKGESlzZTlfO6ScV1kly88wfTM/R?=
 =?us-ascii?Q?HAbSaOniRtmZDOfD6siWxHPAHGsPrCuWv183NmLcxKRTZrAv2h0HjKyOMvOR?=
 =?us-ascii?Q?Gt42r3pbBRd0aOpGhnmdOQzP28utHZ70OGax8pCVyh0SSFjVTdEq+Skhsxyq?=
 =?us-ascii?Q?tlLn4CwrXyckJVbd41UIcwrToEuA1lKzLSQoQo5ZQw7Bms8qVDj9wci2Fq1E?=
 =?us-ascii?Q?qupECSgbcvYrvbdUaEfZkAVeHMjujDz73zSKp+StLgtIYJJ7e33+BJ/gSexZ?=
 =?us-ascii?Q?vmakTBY83PMbYhpHOmk3iEH69V7F1QpeLrZQk2PzJP2b4wlA6z+yS9J+Axqu?=
 =?us-ascii?Q?Y1/rOOxslxRycsjwTBYPDyRIkLv8M6JWVZL2BrqlUFkYCBIQsZZ9KjyG35M4?=
 =?us-ascii?Q?IyrD96vb5RV24LgrGDcIZttgNdLBr58V4z7oQQ4IR+5ivgP4erixnuq5U2U3?=
 =?us-ascii?Q?ebEOBGymTHVuDSjXrrr76q3VYTOu8+UIXrMrW7EDISUzI63/wXhH0eVY+R1t?=
 =?us-ascii?Q?wdFN9Mh5afviUf+ebCweeAX1eOeW3v9uHV3L7epTVpwvpsWbbH+JhdRD9Exf?=
 =?us-ascii?Q?8F77LWJ+DBsJTxU+yY8fKMXljUFvNpNXKxCI/8rSs67EfE0yaHlTKhnj7v3Q?=
 =?us-ascii?Q?h4xcJauc+jwqulo2a3ila65y8NA59Det48/Z4SsKPXbQQMwvH5yVjXCJoU9j?=
 =?us-ascii?Q?6kCDyMIeT+c0KA8nfEHTKsnxAbwllHmm3jgMOIWI8v+GZNdvexT/ggjoJBJq?=
 =?us-ascii?Q?YUSY5qLwmuBM0w68KBB1qpkfxIpWCvDRG4p5tC1l6KzK1cCbctnAUacvfV4N?=
 =?us-ascii?Q?uRIYrjaqV+NyKQ36l/LY1ytdjupabtMjoUNfEI9ljzbNIJqWSUdLQEzIEJzv?=
 =?us-ascii?Q?8AcKM5EVFcnrlTuF9wFEEeAPBWtRfil3gSRJNLoakS/sRRTRW+vW25rJhgFv?=
 =?us-ascii?Q?bV5T5E5O7mMeS0IOD7Ay75CzV8A8taVViRyd7q+LD6dAz8x2UB6DtdAKyVA1?=
 =?us-ascii?Q?W4UaRr/f4rcmwHwzULrOiJ+uZ849t/yQBNgAD7lIuUXhNAu48QgEvZ3FSF2b?=
 =?us-ascii?Q?9pRsScdlEXVZxxVIUJffpKfWRXwz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ryR+Kz6Evk0L6eFRIYpF6c6ujFua5MTqH0zOGHrzowFNHXRi+Nwan4eq85AH?=
 =?us-ascii?Q?bNsgIicsyF5qOBX6HtdFMaQkOvv27CxODitgnUtTmpANW8YFaoXGX1Zmqm3k?=
 =?us-ascii?Q?Lv7EmVvARiH5nI35JwHLywBY7iedq3Bj+62/cC/ly3sRxTwR1t2wahEbcWhB?=
 =?us-ascii?Q?rgjXJmbcFJgrP/sXBevhjjHFRX9SdTeyHLjIuAnFw7OpAgsjzMF7Y78jTZzR?=
 =?us-ascii?Q?jPvyVtUascodN+0Rdl0F3087RK+XAhNLRpnbO+vqG8me6YcyGQhC3dQzIf3g?=
 =?us-ascii?Q?qgZHfFs0gBsR6TC1CnXc5OWSLSVn+3G23TJm4RDUQxp5z+EIs5IacO+5FnRw?=
 =?us-ascii?Q?rZcNJ7tAxUgWA/Jg9ORIVxId5LvnywjpnnpsSdzrWpc2Va0bqGPQwcejbOP7?=
 =?us-ascii?Q?Ba/R6q9lv2QtfQH7o+blxU0KySZJNvKIbRT8klQiqGyVWgW/D+G/QPtoxVOr?=
 =?us-ascii?Q?xeuGKVA5E61mleBedoA+Ssakd6f3HnQqP8cQuvB9jdzwe5lNvUKlxn6/Bv8j?=
 =?us-ascii?Q?QkMSs35i1CgDmZEZq+V73F4Ko2A40dZfPQTNPE2WXc5VlHxDh7IWQH73H34z?=
 =?us-ascii?Q?vqR9aO9/O43Qi/jZanr0WJn+UuR2qXtFPFJnXJOP8YTciaCYIoA0BCbznRx6?=
 =?us-ascii?Q?GKKsp6bCurNJU7/kvZuEGzVI1reYp6PctuOK69qevT4wljGePfZbDeddElt4?=
 =?us-ascii?Q?Sb44OiCnGqYTnC9BsX8jYTw9KXfTzmLAwHdByAayRLQe+a14OWVOUJ8Jjw/0?=
 =?us-ascii?Q?4o+vmce5vmB54JHExsnCuAUkgF5FnRPia3BYmlAJET7TewNIf0kFj646B0RS?=
 =?us-ascii?Q?M9bRJSoYvkooB0cBUpV4qMNlTvLsSTVRY74RuPdBXYU2MZYQsb6xPUe0mSGr?=
 =?us-ascii?Q?1TllleNe4sxSsozMthJpkiI3JuXW9RYYBmFMcDqsjIqDXAZYIUWxPa70kDST?=
 =?us-ascii?Q?CcDElJ0879WqH7+vM779bS/X8FPqGOesltjhQqBk5EM1gFMLlGSbe5H8azCO?=
 =?us-ascii?Q?w2QOQUiba7vrtYyDDdc1MtFNGBm1D1Dr5/vXH0u1EjRCYMLgrXoqyfY6MFqd?=
 =?us-ascii?Q?eYJLom4PCeW8RZKDjY0MopUwd+Fe1xZSIjakLa7lpMC5ub0vL5b8fRZArr/Z?=
 =?us-ascii?Q?OouOt4fRVqgLA/rE1v6KQWAR681b9tIEFQjs1J3YMxNbyQx021BXmGVv5Oo7?=
 =?us-ascii?Q?bPzjn7/UTmloZewa99Nzsa+xCwZabtInUq887w3ru6ieE5ACMJlIozOMY+Ts?=
 =?us-ascii?Q?vFBQZFep5qmFYCfM9uAO+XIdPMvl0tsK0KSI3plHMEQW+gDKIP+cM2XcuJiP?=
 =?us-ascii?Q?WxoQri7qgICGt7LKs1hASXz4fFAKQhPCtxRkn75XhioFfeAE/bfV6Roh/tkl?=
 =?us-ascii?Q?Ys5SqYZ0V/hVsjz6Gq/bhcFbyzjAXKBWqAQHjcF0BRN8sUWtdbIf7YgrGPWt?=
 =?us-ascii?Q?jRjAjK9GFb/C6kvvgXkzl5WRTlLyuDETK/ZeZcNz9FEci2MsjT9JRQTgGuIJ?=
 =?us-ascii?Q?txUKK9N/vRic3UZPWeLytYE9anwkJZAZwPG0599cde61z2jIaZhMW6qi+ZSn?=
 =?us-ascii?Q?PVurFRAUxWNqnoz6q/QsxysdNrkXcTg2CPYOVyDqRlJ/9fVpYyCEYV+2bAha?=
 =?us-ascii?Q?KQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qAB7q8vrSnbwgPWl6f5dSp5WZR1Xi3q2OnibqvNU34BKyisaB4zzaqKENndQoTN+GdNdMlFegrw+2fYJoyIjHLvLyq1RTDSjwhMcHdSTIyRhDPUt00cq9uV3Fz873wOG01F1rz8pgbyOahOpSEJaDGqsazteI6U2fxfKYo0iTdMVHtEbZWQNKjlEycyQUNwyNwvVgRJ4JO5H02rAxiLUEtpaVe86ISblazfIaJ4U7y01Z77NCq6y01UnpPH0K7FsAOxHCqBhxMfenZqs8V5u4u2IJgzOHTGh3mcCG6pFE2IsE2TOW10FNPBsy+tJZfEp3G+CBajObPZYP4xYF1snkwteBg6T2xQVCBgOZO2ns5+fjpGvVC9ytOa90PZ4gkk2gQBpwW5B+IqZNMHdgQf1SsAEye5oWnNCkzVAgTPQc3Sm0qgi5yami15lSpEhMUDBK8SMRD3Gv+orKu9sfr7DmwWVFST+NdJdtYaSyevQZNCP34HuWVzniyId1d+BpaQ9JLNPCBSpubiu66sJaIfx5Qa7WUnoT1+rXqsStzC2x6RnlIy8rV2kNgUuSL1t2Ctdsj8iSobpfPIygP3GDlqrD5BO2HEDj8PVZxnuQzKOr/I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c4184f6-c298-47eb-56df-08dd625262a5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 17:13:34.0067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 17e8WtDBSTMbUMwJEomN1gnCXE+FN11FMKoipTP0eLCqzWMpdnEJ9PG9tSiLhWrwU4XZFjf6q7fq6RPjaO3m2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5982
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_08,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503130131
X-Proofpoint-GUID: KPTVAT5DxWUvWa0lrYVMku28GZyeYIo5
X-Proofpoint-ORIG-GUID: KPTVAT5DxWUvWa0lrYVMku28GZyeYIo5

Currently the size of atomic write allowed is fixed at the blocksize.

To start to lift this restriction, partly refactor
xfs_report_atomic_write() to into helpers -
xfs_get_atomic_write_{min, max}_attr() - and use those helpers to find the
per-inode atomic write limits and check according to that.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c | 12 +++++-------
 fs/xfs/xfs_iops.c | 28 +++++++++++++++++++++++-----
 fs/xfs/xfs_iops.h |  2 ++
 3 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index fe8cf9d96eb0..7a56ddb86fd2 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1032,14 +1032,12 @@ xfs_file_write_iter(
 		return xfs_file_dax_write(iocb, from);
 
 	if (iocb->ki_flags & IOCB_ATOMIC) {
-		/*
-		 * Currently only atomic writing of a single FS block is
-		 * supported. It would be possible to atomic write smaller than
-		 * a FS block, but there is no requirement to support this.
-		 * Note that iomap also does not support this yet.
-		 */
-		if (ocount != ip->i_mount->m_sb.sb_blocksize)
+		if (ocount < xfs_get_atomic_write_min_attr(ip))
 			return -EINVAL;
+
+		if (ocount > xfs_get_atomic_write_max_attr(ip))
+			return -EINVAL;
+
 		ret = generic_atomic_write_valid(iocb, from);
 		if (ret)
 			return ret;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 444193f543ef..64b1f8c73824 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -601,16 +601,34 @@ xfs_report_dioalign(
 		stat->dio_offset_align = stat->dio_read_offset_align;
 }
 
+unsigned int
+xfs_get_atomic_write_min_attr(
+	struct xfs_inode	*ip)
+{
+	if (!xfs_inode_can_atomicwrite(ip))
+		return 0;
+
+	return ip->i_mount->m_sb.sb_blocksize;
+}
+
+unsigned int
+xfs_get_atomic_write_max_attr(
+	struct xfs_inode	*ip)
+{
+	if (!xfs_inode_can_atomicwrite(ip))
+		return 0;
+
+	return ip->i_mount->m_sb.sb_blocksize;
+}
+
 static void
 xfs_report_atomic_write(
 	struct xfs_inode	*ip,
 	struct kstat		*stat)
 {
-	unsigned int		unit_min = 0, unit_max = 0;
-
-	if (xfs_inode_can_atomicwrite(ip))
-		unit_min = unit_max = ip->i_mount->m_sb.sb_blocksize;
-	generic_fill_statx_atomic_writes(stat, unit_min, unit_max);
+	generic_fill_statx_atomic_writes(stat,
+			xfs_get_atomic_write_min_attr(ip),
+			xfs_get_atomic_write_max_attr(ip));
 }
 
 STATIC int
diff --git a/fs/xfs/xfs_iops.h b/fs/xfs/xfs_iops.h
index 3c1a2605ffd2..3ef3bb632ad8 100644
--- a/fs/xfs/xfs_iops.h
+++ b/fs/xfs/xfs_iops.h
@@ -19,5 +19,7 @@ int xfs_inode_init_security(struct inode *inode, struct inode *dir,
 extern void xfs_setup_inode(struct xfs_inode *ip);
 extern void xfs_setup_iops(struct xfs_inode *ip);
 extern void xfs_diflags_to_iflags(struct xfs_inode *ip, bool init);
+unsigned int xfs_get_atomic_write_min_attr(struct xfs_inode *ip);
+unsigned int xfs_get_atomic_write_max_attr(struct xfs_inode *ip);
 
 #endif /* __XFS_IOPS_H__ */
-- 
2.31.1


