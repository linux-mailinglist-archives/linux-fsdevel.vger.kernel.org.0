Return-Path: <linux-fsdevel+bounces-47380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F548A9CE7A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 18:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D6751BA4443
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 16:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FCB1A3152;
	Fri, 25 Apr 2025 16:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Oh+Tv12T";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rKVGqn4/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0B819F11F;
	Fri, 25 Apr 2025 16:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745599549; cv=fail; b=lHaC/bHoz3Ossu5/VYEfw3g2Qaq52jKAQEdHshbNY4NkXQBTAFj8Le4zZ58xHBYrv2Mk/rNxHH3FEE9sb4ilgYYjjjPc9cIjAMOJvd7dKMuhLC2bh6R5bAHqq2Slbdr62RjK1CYC+r1QMosum+PijFyfFlMADdJxIz+/Pnkr+z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745599549; c=relaxed/simple;
	bh=HXoCifz0GuY1M5rkJrFyR/P7ou7T3D5tc2ERXQsB8mc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bCfDCfAzSBa5U4yJloWP+0EX41JXHS0f+PlNJLnUKoHxa54Hy5sM97AEoPfSAHYsRzlT3hpJ4fFojoS6CnNLzS7VuQ//z24GcJnQpQf7hxsTPYUmFwu4B1nNA0218Lt9svjD/Eug7tfFVf8qL8rlwyFDm+074fme7Wxd4yB/czE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Oh+Tv12T; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rKVGqn4/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PF6gVg030116;
	Fri, 25 Apr 2025 16:45:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=PfjAwbhZVoZaFEImTYzZAQtIzj7lCu5hv9mKI611ZXo=; b=
	Oh+Tv12TyraMs4/3EpvzT63PKMlEm8uvwMCtmEfiJM/c0xvaeYjLEMtj6qD7ZW3X
	P/Zk/TZx0UAZTR/554aDUUTIcnPXsPEa96Iv5sfZVrqrJxR468//W82CCjM0K4uV
	rVPjTGlyHceIhpjAfReokes1Rfksxjj8lDL6IMafTG1x4XCP+gPotz1VcNog4fT1
	NpGeBOyTtpsMiWu3cYAhgk9jIw8qaVhl3EB6Tcm690aq9Ib9XBTMIGV4AGz/k7xG
	0srmUgSGoHH0hL9QKOEbJViynQ05wk/5KRnjqDPO2HFE0WQbiyk+38iLDQcNDd0v
	jLDGjDY6957ZKs0gxJ/uJQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 468cr60ead-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 16:45:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53PGGdvt031728;
	Fri, 25 Apr 2025 16:45:33 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazlp17013078.outbound.protection.outlook.com [40.93.1.78])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 467gfsysjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 16:45:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YXoslzWcvx8pRd+tHKcmbFidm7We4hGMC6QbadaESmxAKWDf2Cb/oPhsgrjAS0edlohkV9Gne9HLrCbsMYKSSyvZuyhj+pAjDxy2CjbIfd/FBpWibGzFTM2tUhX6QnZI6iJs6DWjnp/GMXzPTsxEEx4V4pB9HmWHoTxzj9wjNUUC3xpCD1IfyGwzypKJQTA5KQ4U1PT76frYvp1xhVEMu+UYObicueEuJEyzkhF3SEm9YRU2wi0XUgTA3hv8PdMHLQzo7F1TvgpmwX7SUcg0qW4q+5kUG3EGB2SxklTmvqsmbku2L2LF9pYQgEs5oX5f/Y20kMt6peg4LO82fS95dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PfjAwbhZVoZaFEImTYzZAQtIzj7lCu5hv9mKI611ZXo=;
 b=kxZzjKzBB/biZtl4lh2QjzFyIbshPPWFF46ruQXzdrxzWKmoS1kClfqjfeOTYT7K7qOX9bFQIB/i0TOIlieZXW3xKKeL3LmDzmegJB1fG19Gxt5RBXucjOLFgVeGYrSOJ47NFiz78s7f32OLGgogldRcIFNQrwSkxowzuYC+Y6hnC9v9fi3XGtMqEsj9SBbvDfRYrK3dXkmYqN/++Di0QVMnc+SmG/6+oxIukLNz3OJQqcNmmSFVxbUM1+3G0Ram61RV+xUPdyi5GMuY04u6AhCvdXfMHavnTe76tLPOMueKsvIm4tBNcfw+uHDakugXz8L1hcH2laZfCnDPSOwTGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfjAwbhZVoZaFEImTYzZAQtIzj7lCu5hv9mKI611ZXo=;
 b=rKVGqn4/SsnjbRv2pIoXSwhUt1X5F6uoZSH/o6gl1ud/u+3NaVq60xNaC5qh0T9P6MsfsRNp6TzGyDiFp6h4gejFeAPBcbpWhDvnd1AyUbApMrlMfBRURIiXHg3mAGrNRRGgGRef3QdJMSabF1GBZchUBJGdpFIASWw+wfhfyIA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB5699.namprd10.prod.outlook.com (2603:10b6:510:127::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.40; Fri, 25 Apr
 2025 16:45:31 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 16:45:31 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v9 01/15] fs: add atomic write unit max opt to statx
Date: Fri, 25 Apr 2025 16:44:50 +0000
Message-Id: <20250425164504.3263637-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250425164504.3263637-1-john.g.garry@oracle.com>
References: <20250425164504.3263637-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0233.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::28) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB5699:EE_
X-MS-Office365-Filtering-Correlation-Id: e116d9e9-233d-433d-d15e-08dd8418973b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N9Zc97akw3cijV7+VGvoAr5A9jVYjqx2uRHh3vY6SRFK4Bsg5VrbgdiKaivH?=
 =?us-ascii?Q?K40jcHmMwZUIhb4URUefehAA15zS3Ql5necuEJtcha52l3++C87V7C5iDMoH?=
 =?us-ascii?Q?vAa+VeKT5vkzA5xEcLPFN+dy2JHLg+ji72V98rr3bzxUn0W1piDsomnAYGqD?=
 =?us-ascii?Q?HuW4pQ/idvKeylz/ldriIOhkr1nZ+1zArsf1e2+EW9YwJ4yL5YJRhcTTANdI?=
 =?us-ascii?Q?iARLS1r8Rgq/EjApxq9v1+dmWgfP1qtLOes9bK31Ww8hQRYgGPJm6EjylGuo?=
 =?us-ascii?Q?4fdKF22TNBFvzvfqzZEvzUhaXdYxSmkjWnyIyQgE0qxiAsBKi5F2SmGn3lww?=
 =?us-ascii?Q?kcRodDrZL078+bxdrmYsrPI/f/5qA2474fURAL8EIi1ZcHdKOue/aE3hTUEs?=
 =?us-ascii?Q?l+8M8WDvQOptFaO6AwtuYGDttwl9m/LogOoF2uQuOLKl3kfW0xRabGXZzHiQ?=
 =?us-ascii?Q?zn67uEQGTGOM49qxfjq0RlutzQMwSHbTnkcY8QoTvqXD5b9KNCSfd7VhyKya?=
 =?us-ascii?Q?HiBbZik2Mx/Vb9thhltpzgjOPWpRsN2khDb6bdecPw5k3Ff36pITfYHLtxiU?=
 =?us-ascii?Q?0OPtvdVXhDO3Mq/4I/c3V4L0218VuLHau8fnuMRUGqjf1BR+8pMtOfoXQCK+?=
 =?us-ascii?Q?rnl7HRFJ/b0DcO0ZRY9Jn9SDxC7UhpRNuvAR8OPVlAyXlih2+ykbDyLPOsbm?=
 =?us-ascii?Q?0oUtLCXc2dmgW3T1b9hHMEI6GYY5ZI9WfF3tllQBsB/8putAZ1NiHXfkAwk2?=
 =?us-ascii?Q?Mldzi2LjMHWwB1BeB9GdelZSn9idigjI3nG2V5FtXDT1L69cZl+AZon5l37t?=
 =?us-ascii?Q?J4UbJvFGUg/sGM25jECQea1EhVdrPUmcnWfvBowsPyG8n/QZNxbBDzbKpX+l?=
 =?us-ascii?Q?c4WyTjtTB7eAgUNDTq3JUZT8HXs69RdCU2fHxvvKG9/1hO3wi56PayCehVAD?=
 =?us-ascii?Q?vDxj96vPsdLPoMocnZRukcOXd8LkQYtpFlib9n6VVq+r40CCJNG2deOKiCXf?=
 =?us-ascii?Q?Zt9N5L2oOepDsedwWgsvDG/+GlelGiCLrGMP48cx0v/HbHCRNosfJnob/n2m?=
 =?us-ascii?Q?2CG0RLAJQeC0OPey2hkU60U8Sk7K8JKRc5KP84hrl4KgGhOAsc9DJHD7YUtq?=
 =?us-ascii?Q?xTplVh3FN077nMU8BoTruxDyGaxBixfAXOTdMAS2zuWIL5jLWjcVQrzEc9x0?=
 =?us-ascii?Q?G/vhAaRDjq48dpQssMOWxwbqVtUpzGyvxz8AeXKxCRH7+ooi34p7aEwU/4E3?=
 =?us-ascii?Q?KP+oJZdAnsTuIqN3V//1+y1teLGiZ7YDv7usQlsRnG7yEi4/L+GH0GiwVA6+?=
 =?us-ascii?Q?0sGCRom3qDK+fggQP4yRmGBytUH7ir6ic6uGJhMLqtSdy8bp1d9emftMBQeD?=
 =?us-ascii?Q?lq4Gy0hFBPabr/O5BG67TW9vXhocHG8rTuM67Mq8n4TjV9ZFkhJMTX2AtKW5?=
 =?us-ascii?Q?ny9wrl8NEWs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i20T5msiD0gE5gHhzVY5dLmENA6206ZigHN3BdCfBPWBf6WUXIs7TNq2y8/y?=
 =?us-ascii?Q?YvW2X1L1ifeFbDQkzTkD6s/+AWjJRjCpYY9ManTaDh5XMeYEr+vYjM5Q57sT?=
 =?us-ascii?Q?f2pVxSGkpZoy046JfkpyEf/LMBpVlLS0UeoOMwg8nirD1xPgZUkmKASOqp4r?=
 =?us-ascii?Q?4CTJ6DbqZXh/40yisM2NdvDr52l3HYzobQKsYXBRuu/QhJfsFWjZgsapkTk0?=
 =?us-ascii?Q?ELoAD0eYPRY8eaGPNfIm1YxxaDEPHcz9B91wW7+zoo6APpQ9tgLCYRTxGjxC?=
 =?us-ascii?Q?6WDxCUeQEoO9cra+leF2nHj+LOxrMedXc6AiNBUf4rwchHIvlkM72gSTaKjE?=
 =?us-ascii?Q?4c35VUfl1JSmSODGyTYitPNgi35dC7zH4NP/Kd2d0ifsgA9xbpyZvhiZIuG9?=
 =?us-ascii?Q?D+OpP2Y5aPTSWWb/iQOFTTRC+WGMNGScr8Ke+7Mj1lR6nVVWBwlgolTExNWX?=
 =?us-ascii?Q?cFWC6xlG0TmSCqFQPe31JVjFrIU/6iAdChtC8/NXZ3i1kXfqE3TzYj4gqsPd?=
 =?us-ascii?Q?k/LL4XbTH3cThNu7PZLKPBIAEQ+WNP6p3AxGr12Q01x75N78XFCLRa1hN55+?=
 =?us-ascii?Q?ywvIaNTGB4xQJJX76vbkv0NAsFamB2sFvPx52TTRE+Wwz6ArhGuine5zzFK8?=
 =?us-ascii?Q?efV664LtM84+F/9RJ1w42QrFIlZhN/F+C7XGGcR9PW6dHSbhLckAPIA1b2Dk?=
 =?us-ascii?Q?XLkvv7lYsIdzaqA1gE+QvhjGj+sqiavYwX+phyQxgaU8hYx20zbRwu6WGb73?=
 =?us-ascii?Q?KM73Im7niFxe9snTdAedhLNu2nP7aqL/KOGxjs/qp1qTU0xkPKQslRxO+aDq?=
 =?us-ascii?Q?I5y78kjq9fO/OGPvXx896UWZVfXvDyBOLJWLEgRXwbkE0F2oUNYbQBcmfogi?=
 =?us-ascii?Q?u/soMJGOK7aBDzEXfiL693mbTaWOZsx5mJSM90U++ejr8wR/4aKQBZ707r7z?=
 =?us-ascii?Q?2NcbhTJ5QZkgzxVaB5aI7QEIszlIINLrARKI8r3puvSx3o/QNhBNOp7Upvy8?=
 =?us-ascii?Q?jnFhUozvG/yiZUTPA5CHtToa3n8Gr2BQOeGceCYrAYKUJP6hdamjTVGFs1ax?=
 =?us-ascii?Q?xhaZ8DgoBXcBYNOTk7eKD8xK4bcn91U2YuhF2exypnhNEb0cZocJCReKDbZq?=
 =?us-ascii?Q?S9nY61Hd92Tek62iehJkIPpxGX9jnZYeT1yWCuTprNYw/DIxj7k/YV1AUsdx?=
 =?us-ascii?Q?D1ORKJcIJXPZ+pRQ8ELT414470pPonmG5Xc+tMzdsq3UHiujxH9I4vVC3RcD?=
 =?us-ascii?Q?UKPr0XxowtXI2QNTaBn+EIhsBlkyd478tAGxY/lUe/+Kc9Cpzy0bs1UlzBn3?=
 =?us-ascii?Q?h3KQWfaD4/8E7fb/GNpP/53k4xKX4LQD0fE1T2rv8gifv6SnXOE7O1AliUWV?=
 =?us-ascii?Q?ouNctXx7+cd8OnhoIc0h8BT/G2bjA3cT9SGjdqOrY7y7H0KkRRY4cg4r7HsQ?=
 =?us-ascii?Q?6aqsMvpuck61K99FyAdNvfZajxD27wudoKLTvBJT2DwEayuYKfXHOltNwtgE?=
 =?us-ascii?Q?IBnQipH1m+JO6/zXmP9nsiJOQxpisCjoXuYcbrYdqe0vdyNHVzPLwEgsFYPC?=
 =?us-ascii?Q?nCiQjc58ffA7PW4VF16OrluXrqh0rSlCucBh+CiDbkFAjBK55ekJ84UGyf8W?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3QFZU809Bp7Hg84GxYtmet5CXj8/yal4NktI5LMFVNJDf98rzMW17p+pQgZpas8RdMtqAzWdDKGUbGxSOjxFIXln+V6u0A9j1uZbGibmG/OGVkbSVW/WmNAl+WdKfMdks+eLfrE2BXUkGP+i4/QERKXxTlAMYUufLUQgt/Fqd5JHyl7cSEWQcdXWV70txhNJinIxljLaaW4L3+fYJvMUWGAwLJXobAHqyDkmJMhuJYrRxzCFvkSPq6b7605qFzMtyPoEK5sb83TGpsarVeJMaITjoRmNRvdcxPYnq5TV++bVBTQUn0B2v3xlldP9frlorKzwOpMfJotyC3mNLa8zktkiiHhyskh7qFHNnpQ1ltzDo07PAOoPhbvShxnJ0YFAGFpenbkIdkVBbGKvk6N02DWwfvi3XtsvK4xXlq9YBzSOZPIfFJkgH8XxYnXPhtfzEz2cDEDy7vl2PL9fAQ/T5LsU0l2jROVoS9GvxEoH8YXL0A6mwX2kjyi/FWDn57aMmTM2UbIUGTUbswE0O86GIKMHhlLKE+yelniWnDGgoH73hSJfygosBYXdL2MpDuUEz1pCrThQNBXEZey4ZiZT0dwziLwtZjnZPXE8WdGZc6g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e116d9e9-233d-433d-d15e-08dd8418973b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 16:45:30.9499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BDhnJB6NKe3FdoME/6c2MeFreyYY6usEJNVsuNiGnKXCfiYJ6r87dYTjiM5wk0Y+LLuSFrjvmAQGQhGTXv3uOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5699
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504250118
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDExOCBTYWx0ZWRfX6enOg8l+VX2X itRuJatSHG+yviGW93vx0q79SNiU8DE3V8tbU/nRgoXUykhfOuBYVfGRPmdrflfWRCZZ2O3h3Vv tIrLPsb3hXklrPFOf20V4EDpTvQ1nVArSy/gvBioyc6OFCdT8uy9967UL+CFlIN2ITddRLFeE1F
 d8c6t8TqaqdkG+EeDL+yF/PBGR29f+e3VuwsMgQ0374id1gZxhDyzRsNikWpzrDe8V7lVku6WNx txo5Xn3CG/BPj2SIwxp2BNHz7YRAFbTXvPgK9w2zagtrMW8AhC1AdmPvGPd626ZI+1vSEuNO6zT E92/bB/gSWzIh3RMb6dGpij0QZIXkpv7D2L9zsbym+BdANmCUIHkQ1CTnkOiYbl8CJVUuUKTSDO SMjlFiys
X-Proofpoint-GUID: 0r3MGuYQ-8d7Wy9ksJYaZSR2Vmo5YtUO
X-Proofpoint-ORIG-GUID: 0r3MGuYQ-8d7Wy9ksJYaZSR2Vmo5YtUO

XFS will be able to support large atomic writes (atomic write > 1x block)
in future. This will be achieved by using different operating methods,
depending on the size of the write.

Specifically a new method of operation based in FS atomic extent remapping
will be supported in addition to the current HW offload-based method.

The FS method will generally be appreciably slower performing than the
HW-offload method. However the FS method will be typically able to
contribute to achieving a larger atomic write unit max limit.

XFS will support a hybrid mode, where HW offload method will be used when
possible, i.e. HW offload is used when the length of the write is
supported, and for other times FS-based atomic writes will be used.

As such, there is an atomic write length at which the user may experience
appreciably slower performance.

Advertise this limit in a new statx field, stx_atomic_write_unit_max_opt.

When zero, it means that there is no such performance boundary.

Masks STATX{_ATTR}_WRITE_ATOMIC can be used to get this new field. This is
ok for older kernels which don't support this new field, as they would
report 0 in this field (from zeroing in cp_statx()) already. Furthermore
those older kernels don't support large atomic writes - apart from block
fops, but there would be consistent performance there for atomic writes
in range [unit min, unit max].

Signed-off-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 block/bdev.c              | 3 ++-
 fs/ext4/inode.c           | 2 +-
 fs/stat.c                 | 6 +++++-
 fs/xfs/xfs_iops.c         | 2 +-
 include/linux/fs.h        | 3 ++-
 include/linux/stat.h      | 1 +
 include/uapi/linux/stat.h | 8 ++++++--
 7 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 4844d1e27b6f..b4afc1763e8e 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1301,7 +1301,8 @@ void bdev_statx(struct path *path, struct kstat *stat,
 
 		generic_fill_statx_atomic_writes(stat,
 			queue_atomic_write_unit_min_bytes(bd_queue),
-			queue_atomic_write_unit_max_bytes(bd_queue));
+			queue_atomic_write_unit_max_bytes(bd_queue),
+			0);
 	}
 
 	stat->blksize = bdev_io_min(bdev);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 94c7d2d828a6..cdf01e60fa6d 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5692,7 +5692,7 @@ int ext4_getattr(struct mnt_idmap *idmap, const struct path *path,
 			awu_max = sbi->s_awu_max;
 		}
 
-		generic_fill_statx_atomic_writes(stat, awu_min, awu_max);
+		generic_fill_statx_atomic_writes(stat, awu_min, awu_max, 0);
 	}
 
 	flags = ei->i_flags & EXT4_FL_USER_VISIBLE;
diff --git a/fs/stat.c b/fs/stat.c
index f13308bfdc98..c41855f62d22 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -136,13 +136,15 @@ EXPORT_SYMBOL(generic_fill_statx_attr);
  * @stat:	Where to fill in the attribute flags
  * @unit_min:	Minimum supported atomic write length in bytes
  * @unit_max:	Maximum supported atomic write length in bytes
+ * @unit_max_opt: Optimised maximum supported atomic write length in bytes
  *
  * Fill in the STATX{_ATTR}_WRITE_ATOMIC flags in the kstat structure from
  * atomic write unit_min and unit_max values.
  */
 void generic_fill_statx_atomic_writes(struct kstat *stat,
 				      unsigned int unit_min,
-				      unsigned int unit_max)
+				      unsigned int unit_max,
+				      unsigned int unit_max_opt)
 {
 	/* Confirm that the request type is known */
 	stat->result_mask |= STATX_WRITE_ATOMIC;
@@ -153,6 +155,7 @@ void generic_fill_statx_atomic_writes(struct kstat *stat,
 	if (unit_min) {
 		stat->atomic_write_unit_min = unit_min;
 		stat->atomic_write_unit_max = unit_max;
+		stat->atomic_write_unit_max_opt = unit_max_opt;
 		/* Initially only allow 1x segment */
 		stat->atomic_write_segments_max = 1;
 
@@ -732,6 +735,7 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
 	tmp.stx_atomic_write_unit_min = stat->atomic_write_unit_min;
 	tmp.stx_atomic_write_unit_max = stat->atomic_write_unit_max;
 	tmp.stx_atomic_write_segments_max = stat->atomic_write_segments_max;
+	tmp.stx_atomic_write_unit_max_opt = stat->atomic_write_unit_max_opt;
 
 	return copy_to_user(buffer, &tmp, sizeof(tmp)) ? -EFAULT : 0;
 }
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 756bd3ca8e00..f0e5d83195df 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -610,7 +610,7 @@ xfs_report_atomic_write(
 
 	if (xfs_inode_can_atomicwrite(ip))
 		unit_min = unit_max = ip->i_mount->m_sb.sb_blocksize;
-	generic_fill_statx_atomic_writes(stat, unit_min, unit_max);
+	generic_fill_statx_atomic_writes(stat, unit_min, unit_max, 0);
 }
 
 STATIC int
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 016b0fe1536e..7b19d8f99aff 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3475,7 +3475,8 @@ void generic_fillattr(struct mnt_idmap *, u32, struct inode *, struct kstat *);
 void generic_fill_statx_attr(struct inode *inode, struct kstat *stat);
 void generic_fill_statx_atomic_writes(struct kstat *stat,
 				      unsigned int unit_min,
-				      unsigned int unit_max);
+				      unsigned int unit_max,
+				      unsigned int unit_max_opt);
 extern int vfs_getattr_nosec(const struct path *, struct kstat *, u32, unsigned int);
 extern int vfs_getattr(const struct path *, struct kstat *, u32, unsigned int);
 void __inode_add_bytes(struct inode *inode, loff_t bytes);
diff --git a/include/linux/stat.h b/include/linux/stat.h
index be7496a6a0dd..e3d00e7bb26d 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -57,6 +57,7 @@ struct kstat {
 	u32		dio_read_offset_align;
 	u32		atomic_write_unit_min;
 	u32		atomic_write_unit_max;
+	u32		atomic_write_unit_max_opt;
 	u32		atomic_write_segments_max;
 };
 
diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index f78ee3670dd5..1686861aae20 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -182,8 +182,12 @@ struct statx {
 	/* File offset alignment for direct I/O reads */
 	__u32	stx_dio_read_offset_align;
 
-	/* 0xb8 */
-	__u64	__spare3[9];	/* Spare space for future expansion */
+	/* Optimised max atomic write unit in bytes */
+	__u32	stx_atomic_write_unit_max_opt;
+	__u32	__spare2[1];
+
+	/* 0xc0 */
+	__u64	__spare3[8];	/* Spare space for future expansion */
 
 	/* 0x100 */
 };
-- 
2.31.1


