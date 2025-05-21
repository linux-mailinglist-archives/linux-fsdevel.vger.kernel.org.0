Return-Path: <linux-fsdevel+bounces-49591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92145ABFCB5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 20:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D77150007C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 18:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B420D289E0B;
	Wed, 21 May 2025 18:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YLaGFMDc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="t80keK0v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B47C1E3DED;
	Wed, 21 May 2025 18:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747851667; cv=fail; b=t/ukDqvTHpkSC3sSpJ74zYZNdyHG0w4fAhSsx74oWyfRm7j3BLgds4WdJ+6K4Y9AwA80t99/awaeo0c7uWZ01y12IcWlMNz4wbwqzNYN66pCRiJSr3rTqCEu9jwnDs8tCPv7Q4PJ8ZNZtnpJpEpnH767TjoDWZI6iXZPSkPGIDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747851667; c=relaxed/simple;
	bh=/IjYbDSqHfGVtYAnHasg9WGtASy/5248g5JtcoClwEU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=T2OejaIwOR2E6kJhz1b6pTOTxYG//FMmVL4pxy05bONvI8uCkC7IunRuxt4Dy8MLB0i0Y/fXwe39EiCkZwd9cRwK5rVqco8S1m5Xlza8paRkVbycZh03nuOV/w8r2R4FsHQLcXTGBgw/SsMWqLVQDTrPxJdK8IOdKuV9+8w8LYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YLaGFMDc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=t80keK0v; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LIBi9o014408;
	Wed, 21 May 2025 18:20:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=2LlPe1KhXl7L6JGL
	zpAOElIOKIP9ogggvH904MKKSec=; b=YLaGFMDcCrnxwb9m394Jv/VqW3IaMfWC
	PJFSKPEIy/qFUHeny7/HNo4Xma0gmytNXhVBRrfjAA/JSbFn0T38vYzeGXtCpEgR
	XcKAUfnhGge+S0qJ8JqqBe8iAHJk3dhch/Li/wk6FIyJfzYp0mtfFMaAQzv0Ozs9
	uD+Fo4GicaAOAu5wDHUMdqyugdjFUBPQj6mhk0OkShkXm9Hu8hklBEL9C9jsGFw9
	WPOH4C5JNd/zNnVyWACRIWtRSit4EDvPWG7/pPUEhvmC0qFNoQiCjB7sfckdZnLj
	Qrlm8/8ZlKMfctegoU9TJa6DL9YNzoOZJZSzdPMRZRF5FposJIKAyg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46skw6r11n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 18:20:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54LGiNSF001764;
	Wed, 21 May 2025 18:20:43 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010015.outbound.protection.outlook.com [52.101.85.15])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46rwesq7sx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 18:20:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tgd0VB3+7byfplPF58MOxkRj/QToQxZRBQIHwNTkK/mjfLMhFL03Np5GzIesfduii7kdq8ZW8uVQjIvVuoBEcOUM7o8IFyZ+sbp3zCQm9wYMPOaoD8vzBXNoPYv3l+grPVLKfu/vxXb8ssUCHPWmtfnrEpT670E5y7XOqL+0BFffC0CkkkaLM5m9FTnZYeKz+7VllMv6OToOQPnRV4Yj2sNVCK0m+rB94+eOClIQeOx+pX2nOYLf37NScYQkKuoCRG/qoIXLYYSCauJR6ucvPOaw0uTmoQ23a6bDJv84ZaUZ4KGm7PVJuPWvz5zcWHb4rnwlMoRng/G6IzZBJt5gXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2LlPe1KhXl7L6JGLzpAOElIOKIP9ogggvH904MKKSec=;
 b=EcC33ZdKlgK+n7YoAv7h1gbjaHnBn0liES6LtRcJEFqWiXVCwoPzxzyCI9y7nHiIixyudjibrGP9YNITl7Oquqyu6ufvLdZfKG2BB0iiMyaOCn8uW4X51ihaKE6c1pDxtnFJZz/Kzvl+OvQHnSBc9e+HmhEEpRAz5eeZ/I5UwE3FGZCr4jIAOE5YZ7GUEq5boYWCsNYC9Vf6/7zKub0G8rM96D9fbSMJgqPkOrsKuLfhVcmYlye6lxqHTNWObFKESIzkIGgTTb0bVEuG8RWwexhrzQ+KBMbBUZPVZNm2/gVZsV7QLEEYmS10TbqCWMwNSCh30aP4N0+cxjsEn54q/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LlPe1KhXl7L6JGLzpAOElIOKIP9ogggvH904MKKSec=;
 b=t80keK0vHDN0djUD31oUkjRsYIY23b+vttiiRBvonrJFvEUBscuWnkaT933KJ25MmWVfRIdhEPbWczp5mdre42M1xguWpMl0Gdu3xsraEjJkcXDw+MngoGwRA1qWrr4fnsFnysnwSu3pB+OliHKB661B/1ZkYnPZ++U5WttNLok=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA0PR10MB6697.namprd10.prod.outlook.com (2603:10b6:208:443::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 18:20:40 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 18:20:40 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Stefan Roesch <shr@devkernel.io>
Subject: [PATCH 0/4] mm: ksm: prevent KSM from entirely breaking VMA merging
Date: Wed, 21 May 2025 19:20:27 +0100
Message-ID: <cover.1747844463.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0216.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::23) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA0PR10MB6697:EE_
X-MS-Office365-Filtering-Correlation-Id: 56cd28d1-a7f7-4fcd-a897-08dd9894311e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QLn4/CqUVZxl5t0cNc+R2imnLLpRkglbaavW/IkZ6UmkLwxp1Cxn9bbQOSkb?=
 =?us-ascii?Q?OAl6473uXSbH9ZUDe1hdTPsRZebebQBaKSQtP6jERYlOqmn4A/UOg0pZ0mlG?=
 =?us-ascii?Q?fHNaC4jZ/TDWx2roF9gLu7JWeWJzNZjfQekvyjFaSP4UVY6X7riV/3wP4NaV?=
 =?us-ascii?Q?pQwtq/RLcQtG24rkgZtqjIX9HqD6c9ncXuW9Hqx1/thyzv/mb5BNOEu4YpS+?=
 =?us-ascii?Q?78GQmguU5WlJL3I788l/Rz4I3i/Z87Kf0vXk3nesvvmpEheZfajLdOzWSUJr?=
 =?us-ascii?Q?S+1dVPH2LIe8aC0NI2S0lyjHaicT6sgJOqZyFGdY2+s5OX8jfI4E8gaIaNAF?=
 =?us-ascii?Q?gtmfwBr3IHYKC8MMqEGjPFbv72mmqrlLn24m5IH9ucXIsurAu9j+a0qp06aI?=
 =?us-ascii?Q?hylndCdTHbPMvHxUQpCObm7znLt6GSTaq+9b/gluir7UhPuY4YejFPe7dJdB?=
 =?us-ascii?Q?wKevoMZmuAjBq0qqswlR08B6udCK7cVedI6/+Pn3SpgfdfEJ8XWTMbI/Kj3s?=
 =?us-ascii?Q?+CICQ6N004SCgGKd4MyAzNq+aYYkSBAkQnHX36v2qI9sGJ/kvtXQkBlnilde?=
 =?us-ascii?Q?GIsVBwBTMWl2uXrlyIn57oMwLtszvB60gew9RPDVOxX0VoBHwMjLBJPIDAEs?=
 =?us-ascii?Q?AnUxOJtM9plTxyIMMkPauuv1L8nBgnF5ziPOK2HBdvAD/z0rlCYbCtEifobU?=
 =?us-ascii?Q?giuth3vfIpcmIIjn5P7AzEQ34RD9qPGGfiCLIl+/+7qAUmBMcLzCyqBKg3HP?=
 =?us-ascii?Q?Cei0tnB2lh8EC96LfRJc3ADvcXPzGaKFJx0ndcc5NYHImiI0wM7wTJda4Zjt?=
 =?us-ascii?Q?SBGaYezZoTd1aBnb/fzeZt85cKGj4XXU75nhtJ9aN4TANw6nhYo97M6CSacr?=
 =?us-ascii?Q?NBAj/uocn+eeqG6y/Hsag0E0K0jtK5x5+wzmnd0BQk21IMJyYjFyQin4WdoK?=
 =?us-ascii?Q?tdQp4axaec8UKS1hwGJCkvlrUzTs9GD8RWbb4bl4FnvNS55HuusLyMRSCKCk?=
 =?us-ascii?Q?hFWOFuYXOD1nMRtU7PCJgcem6sIL1onSABCSlFtLUCkYOhYoVDOwpnaw5NJP?=
 =?us-ascii?Q?7J13mr8XJjBcqRL7KveNQifczgXiyU+p3WeAnAqEA8cR3n3TwJTSsqEJvw9B?=
 =?us-ascii?Q?KJzYEXpT/GGG2YKPpemDGIF352AgxVBG6DeUvIQIGw99X5gxYFjnXtN95UHc?=
 =?us-ascii?Q?I6UIQM9kS2m2V++oTYn/dlRRoQt/zH2RIdvYVXc3EJk3AFAnW0zeevypLUrR?=
 =?us-ascii?Q?IXEaxGaocTZArt7pDqCsXkgL/+/QmLNG5F3P4KapNZmYCQBZxGKMsDZNLsCO?=
 =?us-ascii?Q?dXHBM3WQLtsACAykVrlGZNZI/YWNlUHS87Lf78KU60K/XM4nRYgFnMJQ/yIe?=
 =?us-ascii?Q?fYDWqhI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ucu1gcVJsAUMhOwG18jQBRDUdCl39Mwuvr5oeCI14yXEtVqrD1QZuFOPHvcf?=
 =?us-ascii?Q?5MaNbpwoTULL3MoR97puCb23ieEsjSM5RVfzhS674u+Lo6N0oGNPkl7dn9+h?=
 =?us-ascii?Q?YwakVUDe6JsXRPD919tFpBP5q+VRZ4swGdmTGTMzHatW0Jjrz6ZjvJ095FHF?=
 =?us-ascii?Q?DomAE9v7Tn1/GzOVknZ8daZ+BWiC1EPiWXt2j7WBCBdO+y6pBotLhzI7GO8r?=
 =?us-ascii?Q?yIURB/+EQc2S5PTPbZmxzS9+GM5P1C22ujfGrLbSNHN+rdIY1t68tXn/6HHs?=
 =?us-ascii?Q?5a5sp+0tRu/nzzXo6JOW+90MGszzlL+WLGm3NVMwhjGlzG3MyVboyeWPIo33?=
 =?us-ascii?Q?WFaiqac+GU+zEF+RuoIHQVJHGSFuaFkVJqrYJopnOGkn1qq6dWtFb8O6rzU9?=
 =?us-ascii?Q?a+kurvWdls7SX1z4xB+ES86zWVi5z06D4wWM5HqzkTznzoWKOo2nbb3X1Rpk?=
 =?us-ascii?Q?xfWGhL2nldUmBUVPvoYGUP3nmDXykEUJif/h/xRiQ0tnfNkrtubXkl3Rzo2+?=
 =?us-ascii?Q?heRMEZqAgz/tbe1m2cjUyyJxLx5G36BU+/V311NKf5aUj8WdsiP8z0r6YDgn?=
 =?us-ascii?Q?bjqInPZ0h7k5KEGuurMvB6yVmXJgbC8orFCfCvlShJsQQ+Z7l3pKZ/s1mcYJ?=
 =?us-ascii?Q?NSCj3n4lLv6oXl+RyM2isIckFtQ5fwJUxp7tLvzt6fX2SuCv3nhyzOWwHDc+?=
 =?us-ascii?Q?Hz7el7LDOFdQSVky2Q+zNSLKqVPgsAQkYHqr0i1uZuc445MW8Sw/eTn5o9Fg?=
 =?us-ascii?Q?UYKZx4tiGUuMjRKM8a0Lnz7dnmHXBIFsfs4HQ41hYQWj4Vz7oMge3vgj+nqR?=
 =?us-ascii?Q?pnAm5p3Xi/QZIwsTV4pYyGUKwIfGC7TCHW4Nc7PR6q6068K9cY8XSH9TCTri?=
 =?us-ascii?Q?BgAD/aA63tMNE4Gxf1SHJkHEyjd5yNh5uhLsNzlKnIKRHdQf88swKBp8N7dU?=
 =?us-ascii?Q?QgvOwrgSsiq+V4sUs+vgUrHoPw7K6TTHg7BHn6UnS1jHQdZ4JfkGX/rz8UOV?=
 =?us-ascii?Q?9S5635OK1svP+0kPz9t8OIPnkJHyHsrFXv3eFPhyRtaEglNa+7vVworL9fps?=
 =?us-ascii?Q?JE95twYNJ1xyBZ2p8NuBI1dvrXdvRGJO6gn8KK5G2mTul0oYU1HkmlTnHxs6?=
 =?us-ascii?Q?LepblIEHml+ZNdXzaYtg7PVDoZy0x+ueJijyMAZFPriDg+3NG87K58BM1b6f?=
 =?us-ascii?Q?p/PVWLjvgKrXLjhrFIMiAfZKEQSoar5jkuBpe7wi6DfXS5Y6cgbORdWPVrno?=
 =?us-ascii?Q?fqMC9k/qtqFJBrR57yxk8L16i9Wnbq+6E6+nRduQhLMcXs56zevgMH5WxE7s?=
 =?us-ascii?Q?u+udWWxtL5Xh4+WKPn+Ku1lL8rUZFX0u0vEiLHuKUGhT83uMxnAg3gW8GUY5?=
 =?us-ascii?Q?bmtBEYNTDI/8HtHTMavrPPByUP25BdWJ5VAZcNVQ+Nh7wzZQuNUrYLhdWCXS?=
 =?us-ascii?Q?jS+RMYbzZwVFoMW+aPdrf1tmW6nMiehTTPr/pAEbyUTrWjSJX4PZ4Ce4VmRY?=
 =?us-ascii?Q?47WlxEOdwFH56OOQ7qOmKOgmo3DaMtapJBggjnfNpz621/Bul7v3u6X32pkj?=
 =?us-ascii?Q?AIUwtgbUyAscYMoT2caojJXuHntLiD+F6aKl8u49zWwUfsL/vwL6ri9teX3l?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AD1KYTPJU6yFandedkm55FCvIcpT56e22H0QZtNza20sMC3Q2YyAa1CNwk36lhHF1VXhkX5GlR4jMX6nBqvbEdIJe0vLexV67oKUQ6YiuWxYtJzD7DvvCt8SNCyH4I1wn9B2a5PO1i3E9dshaXGFnAlOYkh+AzR07LkSAjJAxDS6iyHFSpQwmqp8qQ1QbAVZ5gHn3GPFC8svO3ssgooWtfp2B414pDQio08BqQLPXaf7CInr5HEvCxrt7kkoL5GZFzu6xwBFZSpL3oV8lz3Y3nWojjdezfF5nlvjE0yo/KpefkzHFyzCatQJ1O5L5yO6EE8OV6Hot4OBsl6Ag+aBbs3beDZLDnyvus9sHLBi+/152sgSxZivNKMsgCr20Spc4OxC8rvsRaq72hhFmJ8NNR44P5QBiBpxX0Qw+jEaU7cuddrHBreH1Pli6VHAbLix/juhXdIsk0vc5DOZHFI2eKUPZwffb8ibe8shixMB4JEdAWfZeabZdjTvQXpHWbYYHN/L1KZphiE0Y9RvLmfR3RpLVZmLJ9WUtBJ/rYPP5J1052Dk3I4ktKXg1vjXYDoiIk4wcIRtgxpQzjyB1lSUvjaKp6iQAtBIDDvTBvgGwxk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56cd28d1-a7f7-4fcd-a897-08dd9894311e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 18:20:40.4083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nsFRNIhnSMdG4/6t+Zu0ejAsdditB8Xtri0Nw0OUrOKmU9leWHCFaYPjFqMhF17MvyY4Ina3rcQmDCcdYI9dh8JzelSGa1XP7t3brBqYjAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6697
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_06,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505210181
X-Proofpoint-ORIG-GUID: x8UspSZR_yzyYjNdi2SAF_fAA_ABgSaX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDE4MCBTYWx0ZWRfXwkONxIfKMPib UQMusMdBUj3xGo7OKJjBFeSTjeBHQ4+uHp85MeQl8wFHGWfCK/MRRjJhG6BSTIlwVIfssahrral sFQ0M7dQX8xTF70hsdt1ZGyk/mUwADHi3TBkzxAC/Rfiej7vKsqBuVERF1ksKP9Ug7fRtR4REpA
 j8FZj89DwvOhFoxjOQ2zSbWotdjHbwn5cs3MQGRAJZtuQUTaGZddyQeTnOMFjNSfecZj8HCthhT bDKDaCUEbmRoDxLb9EUY31V5F4rwQiW1j8BT+y5m7ymIRAUgpzaX4Vci+WEuFobr+xeBe80bL3E aKuDMXYnSeTkZMyErVacKOOiJAKA8vbhBvM1eQO4rtOQZhjY20clGuoc7gRfcUKJscyuh5GPLuh
 LLa/2AJZxLQixcLnbAcgTgRZtqvIXiMMDOxg4BDRCSaN5zvHKJZ3MSTo+EGcjDLuua5FeFW4
X-Proofpoint-GUID: x8UspSZR_yzyYjNdi2SAF_fAA_ABgSaX
X-Authority-Analysis: v=2.4 cv=IoYecK/g c=1 sm=1 tr=0 ts=682e197c cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=c547J8xNscFtJrgcwsUA:9

When KSM-by-default is established using prctl(PR_SET_MEMORY_MERGE), this
defaults all newly mapped VMAs to having VM_MERGEABLE set, and thus makes
them available to KSM for samepage merging. It also sets VM_MERGEABLE in
all existing VMAs.

However this causes an issue upon mapping of new VMAs - the initial flags
will never have VM_MERGEABLE set when attempting a merge with adjacent VMAs
(this is set later in the mmap() logic), and adjacent VMAs will ALWAYS have
VM_MERGEABLE set.

This renders literally all VMAs in the virtual address space unmergeable.

To avoid this, this series performs the check for PR_SET_MEMORY_MERGE far
earlier in the mmap() logic, prior to the merge being attempted.

However we run into a complexity with the depreciated .mmap() callback - if
a driver hooks this, it might change flags thus adjusting KSM merge
eligibility.

This isn't a problem for brk(), where the VMA must be anonymous. However
for mmap() we are conservative - if the VMA is anonymous then we can always
proceed, however if not, we permit only shmem mappings and drivers which
implement .mmap_prepare().

If we can't be sure of the driver changing things, then we maintain the
same behaviour of performing the KSM check later in the mmap() logic (and
thus losing VMA mergeability).

Since the .mmap_prepare() hook is invoked prior to the KSM check, this
means we can always perform the KSM check early if it is present. Over time
as drivers are converted, we can do away with the later check altogether.

A great many use-cases for this logic will use anonymous or shmem memory at
any rate, as KSM is not supported for the page cache, and the driver
outliers in question are MAP_PRIVATE mappings of these files.

So this change should already cover the majority of actual KSM use-cases.

v2:
* Removed unnecessary ret local variable in ksm_vma_flags() as per David.
* added Stefan Roesch in cc and added Fixes tag as per Andrew, David.
* Propagated tags (thanks everyone!)
* Removed unnecessary !CONFIG_KSM ksm_add_vma() stub from
  include/linux/ksm.h.
* Added missing !CONFIG_KSM ksm_vma_flags() stub in
  include/linux/ksm.h.
* After discussion with David, I've decided to defer removing the
  VM_SPECIAL case for KSM, we can address this in a follow-up series.
* Expanded 3/4 commit message to reference KSM eligibility vs. merging and
  referenced future plans to permit KSM for VM_SPECIAL VMAs.

v1:
https://lore.kernel.org/all/cover.1747431920.git.lorenzo.stoakes@oracle.com/

Lorenzo Stoakes (4):
  mm: ksm: have KSM VMA checks not require a VMA pointer
  mm: ksm: refer to special VMAs via VM_SPECIAL in ksm_compatible()
  mm: prevent KSM from completely breaking VMA merging
  tools/testing/selftests: add VMA merge tests for KSM merge

 include/linux/fs.h                 |  7 ++-
 include/linux/ksm.h                |  8 +--
 mm/ksm.c                           | 49 ++++++++++++-------
 mm/vma.c                           | 49 ++++++++++++++++++-
 tools/testing/selftests/mm/merge.c | 78 ++++++++++++++++++++++++++++++
 5 files changed, 167 insertions(+), 24 deletions(-)

--
2.49.0

