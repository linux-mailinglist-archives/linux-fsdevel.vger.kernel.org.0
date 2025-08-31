Return-Path: <linux-fsdevel+bounces-59714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E737B3D056
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Aug 2025 02:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CF6F189BC2B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Aug 2025 00:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FCB149C41;
	Sun, 31 Aug 2025 00:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jVNtPbXo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VIvzHKmN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459F3F9EC;
	Sun, 31 Aug 2025 00:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756600853; cv=fail; b=TWBCzApEvWDuq+u10n6TXCnMXj72DiqoH/yTg4y23IxISWuu+Gh5mzyv4dO+Ru918GT0R7H5a+pB7TdC+iAKnZZXmvcj4SVbKkc+GW4ESnYDFZGFIp5yskjZdNmkW/378okthugKQp9arS/EjdirX7jbeBBKJVv3w9Cqp8Z/78I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756600853; c=relaxed/simple;
	bh=03Zu0h/UM0Ua6UMoKeDU0PZVqL+huacs0k3WFZGZxbE=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=ktax5LcRbdjjXtrQFujKVqGjh44v6NA/E2/fq1M8bLtpTdZztE1U15UjcCPkREvOCV4nwwOFhvW58UHnNbn/BypdTWMht7E9musSc+yfcyxl4KeQ8vM7yGfmuxCy/jO814Kd9AaVnpGokzxN0bvdlYPOUgk4PjEAGxRfbyfL8EI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jVNtPbXo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VIvzHKmN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57V0165W025949;
	Sun, 31 Aug 2025 00:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=boTAVPBSM5eQRizIMc
	u2WyH64cWEVmFgBsLU+Oc8JnA=; b=jVNtPbXoFdzXbfbt6P5f/UgZxd1TF+k4rP
	4tTVgtcQocuPzCkNAXrQdU6oTdM15lucz62IABg+7uMASvwwcoVdaBX5G0cjoM7i
	pJgnbAay77XMGvz58DYcKjHY486472hrnRgfuFT6FR0XW9YHsPnL/TESkB1sV4h7
	UjmJcNhNosZMjmT0WWgqSOKYjO8tqGLwKhBsY8Mqrm5C+0J/gLhKQP7ywUo3Bjsz
	nq+ekNMaWaZAwqu59vBs+u40VnzB/IB1tblaFLZSqTPGeorHz5zrNzX+ZYJZ8KvO
	rJ1UxJcFjPai1xCFgpGLYhhnBktqbGXMXYz1YrlJV9PJEB3EV4dQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ushgrk7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 31 Aug 2025 00:40:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57UJOq6u011710;
	Sun, 31 Aug 2025 00:40:45 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrd1fpc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 31 Aug 2025 00:40:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jrTFeKwPYxUZDzLF6uFpwNsSz6tpNDyai1hVsfGAB/KcEtKgYzWztiPCH38k+AjGywzecEt+dXa9ncvJVZk1ck10W3oEQZ0eQLM2p0VStqZxvBOnlvzZ7tON8/e43tpZ4/6b6eO4KaU66JUn7UWqIkmeb0HRkeJFnt6linLMweEMRwJ4bUCzYfppFoF4g93S5SrzQ4v9UUSrZk2RhyVKlIbDMlCuWxogLlbj5Mr5VGx3pV335SZ3Mnf8NN92bcuth6DOdN5gX++DDo7EwnAEF/IVj/khTMJLcjWIiAOVtABiGiGgO9r9vvcnuigbwbOt2/GS05FVSU8SArGkvSbcIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=boTAVPBSM5eQRizIMcu2WyH64cWEVmFgBsLU+Oc8JnA=;
 b=AkyilAtvnPYmElZkJMgl9yF8FVPR4Zbmrik4KnB17sto0aJnXQ+h5QWdEG5+pyvRSoszlde1lWJuMABqMmsP6en1K4I9jXYxUwRdC0uE8nm0UnRu94suI6qndRVar5yTc2zka9+IAGY18EBaSSf1WXBIFNAxop5mJUE+VbYyIKQxM76oVWuLl7RpQ23+H4Daf5oRBNYUH06T+HG8/rfVLTf7L7hCbnZFDjQrmuGJVZF2731oNROrCkV3oxUoL1GgwXe7/002S/A2/XEY6RAVZdttEcO9TbDF1HkAmALLJIwVeKK+PkKGhIs8Aw2Rx7umGqBw82v5fBd/JZUmWTRkYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boTAVPBSM5eQRizIMcu2WyH64cWEVmFgBsLU+Oc8JnA=;
 b=VIvzHKmNX+dsQrey9UyHrzwVLUolpT7HR7FPBLQbRT0k+F9+P91WgIdtx46LYAMb/1J+I9KOhgcW33lUkHcvpVoeyCeSVJwBIGZL3uUb6aClh9jD0wZtareOGWH1Vz4OkeeXvxxIzg3Ckk7CFdy6RVhCyRC321xkNqriNuZbplg=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by MW4PR10MB6345.namprd10.prod.outlook.com (2603:10b6:303:1ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Sun, 31 Aug
 2025 00:40:42 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.9073.021; Sun, 31 Aug 2025
 00:40:42 +0000
To: Keith Busch <kbusch@meta.com>
Cc: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <hch@lst.de>, <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv4 2/8] block: add size alignment to bio_iov_iter_get_pages
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250827141258.63501-3-kbusch@meta.com> (Keith Busch's message
	of "Wed, 27 Aug 2025 07:12:52 -0700")
Organization: Oracle Corporation
Message-ID: <yq1jz2kgw77.fsf@ca-mkp.ca.oracle.com>
References: <20250827141258.63501-1-kbusch@meta.com>
	<20250827141258.63501-3-kbusch@meta.com>
Date: Sat, 30 Aug 2025 20:40:40 -0400
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0304.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::7) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|MW4PR10MB6345:EE_
X-MS-Office365-Filtering-Correlation-Id: a601437a-8048-4a7e-f294-08dde82703ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o6hmOgwk9sU90U2wmHUrEyRiHkfEoY9OaIcRG8uaUEhRWkY304USHn85JQy9?=
 =?us-ascii?Q?97Z1m+kUxSYW9wPi3bivEM+l0RqW8lGCOX2hX7fzUeb26bD43BwC5xNcbQBy?=
 =?us-ascii?Q?SCb+9fhXLkMuwQhGZXaKnClxwDt01Iq1wlSF1lBcAOVkSGajg0BpcBRTBL7c?=
 =?us-ascii?Q?YU/88gDnha3GIdwJsKZ+jN/nGAJI5aj+ze4lnLhT5/tANccYnB+oqhiEfzAk?=
 =?us-ascii?Q?VRz9y0XzG6oA3Dfs8rUfBR/FB30fDGFi9Q1vbUolBjNh9CgJW33Dzd8pIxj4?=
 =?us-ascii?Q?HPtvw8CtkZkyNwu1Azg9dVXbd8IZgF75bnFZtf7e07QLC4v72valnVU1iuhX?=
 =?us-ascii?Q?LetI8DdQl3/1FBD0JgB1udu1/oiQzNAYPKV8n4JzeSTHBGd7mpelfeUCdTTv?=
 =?us-ascii?Q?vDHItQQLCyhVeILVEeDH+yA+7FogjCFKKG0S6Z0rdiAAj8QPEKMcmksHf0lO?=
 =?us-ascii?Q?8u9sE7fJ0kNxKJ2gLGEaquUACMSggq8cJniO3UcLoYVcrSS9ULJiB3EqDWnj?=
 =?us-ascii?Q?oToUTf1eSwvOd+QkGMKeoMDSFGNQ+ejMHdsHEUS4O+qq6FnFA3lRenCCE/QF?=
 =?us-ascii?Q?LRD3YWWytunOgbzq0xT5MTLaIOmURpsYByrnFS57vIf9E6nDfKSPqEaHSBWH?=
 =?us-ascii?Q?rYvz4ZjTQ3nSx8m+cDEFK6hBDMkz2ps3RTrSKK4nu0/r8wBLMPRxr6DVgkyz?=
 =?us-ascii?Q?f+WIlMOr5nB73MvtYRNA1K+6WfWL7P+7VaI1JMfTngL+poVKYzvHvhR/XYzv?=
 =?us-ascii?Q?Tu3Lpm4MMP//yHNN2b/oiKRIjxjBuzGd4/TRHGnGA41r2VisZWDforiEw6xb?=
 =?us-ascii?Q?CFmoHLE39Cku9OFaXKKLtGALmOiBpH3QrEUz2f0f1BsQRD3kV9S5h87GBM1H?=
 =?us-ascii?Q?75S03RMPY+icj8Jv0uleehZGVUc/orV7eSHN/PlmLS8GgjfusnPctlwPgCb4?=
 =?us-ascii?Q?H1uMhtXQwMNYovl8Yn9KG6CMydNkPS7VRK2JKAmjSCVSkXUIXvRoSkaE9n92?=
 =?us-ascii?Q?rJksF3W3JKcr7I/VWIOBl3ida2I8LvG2M8W8re/xKevmkicayEFa73eca0NG?=
 =?us-ascii?Q?3GTdxRujjhMS9Oa1wCsiqk5M3FtGJiQ1yBe3OrQkFTWEckWhgilU8sYm8IMH?=
 =?us-ascii?Q?ft3zwCCnDvRst0l41loY40gTigiR2ryL0wsWkkaWFqZlk+5oZ0ZxG6AYFEnv?=
 =?us-ascii?Q?MIoPW5nmGcTj/xDwZqj3aeuXhdIGGDSjSyCZvzpaeAYuwoXQ7DXullMPsLED?=
 =?us-ascii?Q?706pfojcwGO0p/Cwm38lQsJfucmHaKOuW816zxMFzt6a4yY2EUD4/WxyAwQZ?=
 =?us-ascii?Q?k8qjfcVTJNaR1NQzJ1GbeMrgBETkMJZGXJWPSMgchkbUnJxhhuHvhtC0ZjuS?=
 =?us-ascii?Q?9uur2v7pV6zVGGlknvy1NQXZPmTn/ystDRHjpzHOBK5UGEMr7tzN0yst/3S6?=
 =?us-ascii?Q?2qq1b3HnSy4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SxJS6p3dbVUd7zkxg4voSTzSmdNfbTo7gpD53F3wOGOcxKV4bJo7Zr2Cb+Aw?=
 =?us-ascii?Q?17STkTqDxvSUxTUEF80TdK4x8SS71oaCFHOn71oCjVv/LwWTJn4qB6nXA/aO?=
 =?us-ascii?Q?9/D6kWOYKEWrp/5SIXbvIwfdtZuxh/zAjW+N3WmVoKO81GBXZphRkpTuj+sR?=
 =?us-ascii?Q?m7ITqCaq5zFVGvpkTlW9gEJQB7M5zHU0KPC+3cGCfGd7IDZY/gw/B4KEPFKa?=
 =?us-ascii?Q?C/HEiXu1pe2HJ6vMgYpwrfVhPIIK8/ccIhoFc/zcHTIs6okr3RVPGE5V+6eC?=
 =?us-ascii?Q?YdzdR2dLKsnXXHUQRlMNSUImAuaCT17bjf2fUAhH4zWpnELFylLCFtx2Iu1I?=
 =?us-ascii?Q?bWWqeGxiJBUnBf2r87dOFX2ZsI+33PkuM0+mPdWOAdzPxfMzLIYqP8ddQoYM?=
 =?us-ascii?Q?FzyfurI0+bKfBZTQCATU++mEokelFiRh5yRGVwOK7zYxhGbSdYZLPbRNxMTX?=
 =?us-ascii?Q?T6cxjmfjM+cdj7AvC+H97pc93WTXRp5PWhomjDmkucoaDVhQgg6dPEtJRAje?=
 =?us-ascii?Q?czWCkw6xCMc6a8YeNa+frBQR8lw8OlnRcvZYYRxq0C/gTEyh6wIgxyaUUoLi?=
 =?us-ascii?Q?VGLkihtpU09hv6WizwEbQRf5tm49WgIrp9u9hMWY4qj/sbzLDRGeo7kNQOv0?=
 =?us-ascii?Q?avqkdMualqCILJHHoiE6VPiUe/xVNp91PK/lhg8ITosxiwyirLwz+XHHkEA8?=
 =?us-ascii?Q?ct4uMREbeB0ql6qEfOf+Gge3QaOFGDuAsOrdB8TR6t6Dd8nv8kM2Vpm7qufW?=
 =?us-ascii?Q?ir6+ype8zdvUoehBqfCpob20tNBYsO9Pe0wYfaZ8puMh6eOIZgH+t+0q4QNN?=
 =?us-ascii?Q?LDke+6CVKGScXgq2UYV/PDUeKfsAKdKoKy5nFmCrJ/iC2RilQQJTnv3gaZFu?=
 =?us-ascii?Q?MEDkZ68fO4H1IfjaGIIhStaNeoeH3d+1sXpHhRKQih8FhYvmU+SLFsgyp8MW?=
 =?us-ascii?Q?40jCwWL6vTvv4wPgblzqY8ZX3uQgLxRhkWICO7YJTYuAmmB9lxVk+8xaDtu/?=
 =?us-ascii?Q?SGnNuXoiCjyI87g08kng/fqVRQ9mCufUDtxr4AF44JgtjOJzYLwrpYsfY967?=
 =?us-ascii?Q?kiJ9o7WMH3ESXKIF1a95+MsIfY+WoP2N30JHJhkt53gCQL/Zk7uEGQdFBZj2?=
 =?us-ascii?Q?QGkrtN6txa0j53n4UfETSHiBWu2vtcpqCL94epdaz5xwE2v9oo4zheoVbRx+?=
 =?us-ascii?Q?hRRkmBnJCsmoG/IRlbb5rP2fcshK1GV64gxKBRp2FPpUCiDS55hNUaVwF2Mc?=
 =?us-ascii?Q?oJILuZqLyRhPON2QcoBejmfVMSTiQP/NFBJ8HPGRaLKAWHRwkCML88ljl/1F?=
 =?us-ascii?Q?edzX71a5ckuGqQ8tqYtE0jUqeQhXEyNDwfoJJd2+4qv3Tv5NoBos5BgOisaI?=
 =?us-ascii?Q?K+lSFBfD3pMm/Qg7Krn2qe2pAxhoOJ0Rxnpuuh3HTqHqR0beH8VhApYkW76/?=
 =?us-ascii?Q?+ZMRE5ecnvjQ+UTpS5xrI/SMVrQRkyynznrDynJFFj8BNok0h4Z0AXTm5UIH?=
 =?us-ascii?Q?dl6eywBkrfuX5qMVkFy8nsWWzsadrgl36lmDdLTZG+l2KYSQqcFR2L5jxMZe?=
 =?us-ascii?Q?q8hn7m3UnIwLHH+0yFDPSdpHIADIFmXUIAgLIdEZ/o3kXIdiiANk3Wsr642E?=
 =?us-ascii?Q?OA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	v1eCp+5TMXfSbsQwa1wJAG/ueoPtuVkG39Jg6clTu7VXC+fBeJxcO/whhijFUMM9/WGB+x5eTivZI6DvC7EMdUDCh7VhU8OBI4/4RJuqdND4V/C16d10qw3TXTcXVdXYn2gdaqvr+yooKQnk0Ta7ICamwWfa/8Qy6XUkZ3KaEITOxNcMQFwg/Pop8qziVFHoS1CdYMmTN0tmq4kJ5vEY1gHFhgCfTJtT3D1YavDPwxms6zgzituvMPL6UGjYMp3tMbhcH0y+1+pNPGzxQ85LKHavcX1/GF5BTzyhMOzoMgjeZV+2bs/F+iEpENYW+sMnZv29qFmS7SneAz1ua0semaqQtYstoui8b5LuD8Z1J0FayQ9x2n2cEbDJsL30oWVJqgDlechHzt9Si/H09VW1Y6yv4TpMkuDzewucSIawxtLPAV+ik/7Yq4CuQZg7SW0zm95L4T97LGLuppb3TItkJ7fwUBKgfnJ6LWI4JbfysLyF6OogeFKifGQ/NtU4z1/HrPy4L3t48e3rK36KXhOuuEsLt19VkZJC3+KIl2Ujd2u9OJjKvPKon6wGIyB/fhXa2ir2uTZqRap1wDN2I3x+S6jvUBZIx8szK7AfGmMtwP0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a601437a-8048-4a7e-f294-08dde82703ca
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2025 00:40:42.2544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZWEIV2iYwxZwJg+lb4AZT65KHwaiJoJw/CcnfuDjKfmYpGYu/vumaJiwWZfRhEmlXS2e8+qpKv0fhP8duC1VHBvTwqIj4B1Iz69rlc4YluQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6345
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-30_10,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=965 malwarescore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508310004
X-Proofpoint-ORIG-GUID: Fp2nGuxS6eNjDdCmN2mJxTqSwfAdCDpo
X-Authority-Analysis: v=2.4 cv=YKifyQGx c=1 sm=1 tr=0 ts=68b39a0e b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=-MYZIGOmIkehxoHcHHAA:9 cc=ntf
 awl=host:12068
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX1NGKevoe/Rvp
 m9W7MwcvDPYWO9hZ36ZKcxg9IHmVCfWEz5LA10n2yUZDcX+URL5a2B3uE4YEi956SGGM9cp2v0Y
 bxKQ3AzPdE2XUt3mu0gXUdhiQpaPlFyXIluccJv0d0UXHZ67Xr1hHyYZDgDmoEQVj0JR53uOGJM
 YlVtLZMZsoKgxg/0qTinCKD3Twol9nTaUo3ZcKyvXY2+qZ1gx1NjprasgoaB7pd5TbTBBzIigwv
 hJDcOlWdjUUve2CVpGbT+Wmpv9C2XC22MmX8Lz07XJz6s+FPK6p55fKq6QPDb5KMie5+GsG3gAR
 H/jydPw6MRDGZHilcwWppKepKk6/R99utSWcOeQgjvzrWj0q1JgpyxQ/LJ+43n4uwQCuzdlaAaS
 R4zUgXj4fKi6/W5q7bRrf4OvTzCcsg==
X-Proofpoint-GUID: Fp2nGuxS6eNjDdCmN2mJxTqSwfAdCDpo


Keith,

> The block layer tries to align bio vectors to the block device's
> logical block size. Some cases don't have a block device, or we may
> need to align to something larger, which we can't derive it from the
> queue limits. Have the caller specify what they want, or allow any
> length alignment if nothing was specified. Since the most common use
> case relies on the block device's limits, a helper function is
> provided.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen

