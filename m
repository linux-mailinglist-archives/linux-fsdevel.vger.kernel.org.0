Return-Path: <linux-fsdevel+bounces-60182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD56B42853
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 19:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E0375825FA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 17:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC064335BC6;
	Wed,  3 Sep 2025 17:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gADsmUnF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mzrSlqcU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5EF33997;
	Wed,  3 Sep 2025 17:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756921760; cv=fail; b=aTcw6zj2E2HLD+lgwyjJ/9akSCnbMyTi5Ldv0c2s+UIT3HUiABg10huikDkUPReqP+1GN15Cy6xKb7Fr7+aImFCAbLCTM9a2ug2EQCAD19q/OrxNsr6mr5rIH9Ig8dt/iiNO8Pto8Kq1C3iUSW5fYqV127HrAQaspUASaHzkn0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756921760; c=relaxed/simple;
	bh=Zb7wnNX87h7llcq7pq2zMJMi+ODacm5hyKjXL1uhQFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n3apTz6KfWws1CaPKUSohBlXZdPkLq/44y7zsKGUNFdBomfmkjDNcUPzGZHlfnc5Mmi8ytqJwTPNMvUl+ZMWWnVBNAhVTByznLjeiGtrv8H+tf9AILi0wWpnqUxvEz5FCsKXatNu5UK8b/fTi8AXS4JPtvA/WjVWWJ/B16erUIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gADsmUnF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mzrSlqcU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583Gnt9N014203;
	Wed, 3 Sep 2025 17:49:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=OWdi4UbC+L+HEv6pMdg4jK+FRTDUXXAzltKFeKITlO4=; b=
	gADsmUnFs+Ejys11WWxGPgtOwnnlbva10LzufwanEXMutnuljANor93GFbVlZMsv
	opsSAcDCdezngjtsXHaUSXWqyxaIV4eAoZKCFINlvTcIUPIeLQREdM5esWzT1Bi7
	iEaEzehgBFyqbHhSkgK/L+cIH1CIJumlIQYE1LJzxiAaRfCVOh9rPrq1AwynRN+i
	wz2TSYTObr6lDMajqdp2BbPjVVIMmPjUscXx1DPjWeOmt42nUOA7MeRkc2hXMBgh
	lg7+Kp8GJpYMtJz9N4cBywJhw/PKYGOYh9ZqYQNQhE6Mf6cllJOogOFqCWj2BGt7
	A9Zbvfp5WnkyLm5r9UvmrQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48xshmg4bk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 17:48:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 583Gd2CB031052;
	Wed, 3 Sep 2025 17:48:51 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqraq7tg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 17:48:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VaQuHz+ty2WYGC7B54hvrFu8/5xQjCEYfg/+c9WD7WOS9aII43hsHgmNXLCeqBfP3F2V/rxHZfOEv6YClwLbKkNyfkh/UjBn1NKIjSphWQjHX4V0AjUfuP1zNNx5FKp801Wd4m2BYrRQVJ1axl3X6njBlOZL4JFyP3Fzb6aqHszmVmMwOz41oND/zS1psZZcwq5GVpNhlDAoy/1NNeGkSuzahxaNjDNoRgOaiz40qxQ4VzEZ6v2upnhpXtWLV7JkiJ5GijJCM6SUPYCnyfWjWSexsuMkPchwbkh12IbhkHcvg1UGGV5jyKOJgcX/zavGiCdGgGFP4GkENlPKzfR/OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWdi4UbC+L+HEv6pMdg4jK+FRTDUXXAzltKFeKITlO4=;
 b=HKg4UJEQCRhgj+oYtGKKvTnOC+0eehi0+R14wZFee9v3I6hy5PWokHutyz3CfTkIi5V3hgBzEQjEjr+YpRs91MnGymnALsP0VvIJcULzOk7rmVZfbha6Et/s9HFHCReEXb/FUbFcFz9H8bjb3ZXNcpCfAJ0AkmVQIdlvwCoe28zBvDSc4+qi/qRbMi7JQdgi9aHKJjh5bCrRB8vhyx71oy8vYah8fRydalS7evqkuT5VelUusDf1ynYh4XTn9yT9NdPSD55hoohdDTEGrmuOswuhq6zf6b/v3q9WHDFQcWToiHrV+7jK4Nij1nfPyGUQUbLHwIKqy99DKIRa/FlAyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWdi4UbC+L+HEv6pMdg4jK+FRTDUXXAzltKFeKITlO4=;
 b=mzrSlqcUVhb05rdaZlEKxR4JJgVGOlm7CvRgzwwbCVmRZoo6l2NqtxGSYQiG43pOMMQmciFFurxNgK3THK1SNgbUdzUVHVOiNeqL0Xlll4e8823bdI9BrJAHROTn3qPstWKkSDOoG1V0kd8XI0XSafaSsm9vsKAAgTmTHsaI25M=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPF8EEA8AA65.namprd10.prod.outlook.com (2603:10b6:f:fc00::c36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 17:48:49 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.016; Wed, 3 Sep 2025
 17:48:49 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v2 2/2] mm: do not assume file == vma->vm_file in compat_vma_mmap_prepare()
Date: Wed,  3 Sep 2025 18:48:42 +0100
Message-ID: <dd0c72df8a33e8ffaa243eeb9b01010b670610e9.1756920635.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1756920635.git.lorenzo.stoakes@oracle.com>
References: <cover.1756920635.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0107.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::22) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPF8EEA8AA65:EE_
X-MS-Office365-Filtering-Correlation-Id: f220f1fa-3da9-4609-3bb7-08ddeb122394
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xDh+0C2+we274y4PtRTDMwsdL8ojRVV1Sw6+yllbrXg5TiyIM5dR1eE+wj33?=
 =?us-ascii?Q?0rb96wmLbwhuML/EobPTEcK/d2BdNCvbVtZlrowXEbsqg/qlckU615MLecyg?=
 =?us-ascii?Q?6L5ATB8FYMNxo5xnEW2VrKWgjtg59B4tIxCxHPUvYdW49Jsi/lGyPOBcsTmb?=
 =?us-ascii?Q?PfP9ChvI5FeRWGkGHnsmFgP64q7nTJEnwNzAaY23dU2Yymda16ZqyyzL+V5X?=
 =?us-ascii?Q?0OkGko05IlgaaNpLAS3/EjShYF1wfl7DJKK8FuLgwJe8GpjIHjYAUP5/UyTp?=
 =?us-ascii?Q?GvF5+qwZa5hX9tnmzcq4ke2Fw6w1Hs6Hj/yZZbJBv4BsSayKvFY/YQRoBW+z?=
 =?us-ascii?Q?67q2HnnteUjbqW+pHTIiKVqodtZx1Fmtv+ZJEH+R+wzd4XXF0GAcc6cxhX63?=
 =?us-ascii?Q?FIYx87knU2gMsNIegtbjqRmOeBVm6Zns7Kinh/JLFZm6TK6jtjVWFvWg3J9L?=
 =?us-ascii?Q?0f0VKHyrSoAGEtD4fW97PSBU8Yi0bzvbuXEVY4zi89NJu4B6VBvs4LkRPiYI?=
 =?us-ascii?Q?uPmcchT10+4bLEpRh6HChtP6A1vdvt1JkVhAr1MszZh2YfgJjFkgYjzT18O5?=
 =?us-ascii?Q?x3tV4+ZmmsgNQc3417AWZvAXpaXZtqk3YUp0O0sQ7BymnBw7j/d6Nq78piRg?=
 =?us-ascii?Q?DxA+tDE51gdRmPpYgBtoxFFZGFhBC8ipSGmhoh7taXgsTceVSqIlOSsQH7QK?=
 =?us-ascii?Q?Rc8f2sYL9afG2Yhkx9OLrgfaEBBsTHgxE9df9Hvs0GbV07jEoUwqAEeEp4vW?=
 =?us-ascii?Q?pvZyaVeJVON1kYRprcAR7RREwUs6tFx3reODmmzmiO0rmw+YrApAoOso899w?=
 =?us-ascii?Q?nrVKiPFrUMMZ4tBZkAf9+5+x8UmCOEQWsRhnjOzBsTLG0d+ch9eEhgoVGUfE?=
 =?us-ascii?Q?cXoevbzeBpXSAN46HYabY18DiZlp8mg6Za6kfjcZHdAmKd+d7SqfX7lFz2ig?=
 =?us-ascii?Q?EvSi0HW5V8gW3d8w+7/nr3v1B1/TqNJHMaftr62LqdefbnSQ32recb1PbNe+?=
 =?us-ascii?Q?SOY9RQeKKeSaHpydhZVtWtek0FXgjBQqNeve6gJW6yV7HtnAHYkbcNx06X+6?=
 =?us-ascii?Q?kyfJ814D93WqY0ngk9sEFsZIgaXTGsxMl55WnhKxpS8K+IOO8tBbbyqVfRD4?=
 =?us-ascii?Q?+oE1cU3kKA9cj2QGMf9eOskCiZwAJ5JGrBIpYwf2xRCbc1OHemAQIBoSJi+X?=
 =?us-ascii?Q?K9ya/PpKzqlPK28JOkgCaGEZUVANjnNl1uLmLWxDB0n1j4dR5d7PlnJeS7YU?=
 =?us-ascii?Q?nRuEiq+AKFBnfDBK/GI2XYdCpHfjZRIcpAbgGfEIavo5yrDera/lDGFtkbJ8?=
 =?us-ascii?Q?R2OtaD4wh7oTdd3RErXLUx9S/jHgzVFa+wwTCrJn2jZnw504CNLtVZAg+/gO?=
 =?us-ascii?Q?Qlv9PMMQh4CdNhFbddGiJRNMnk8maeSZXrUHcuY70rctwKXRTiK33dMJIr5W?=
 =?us-ascii?Q?Tcinq7AmTZQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RIqP/4pF0+oka1xtJbwRd/p19fU+Gght2Za7PXC0qAm+oDw4Lv6tJ0ivTDoV?=
 =?us-ascii?Q?EQAn7ck5azPIcRcZlC8rZJ6ioWM/O+phAytd4Fp352HcagoSqAa62RzF6kMK?=
 =?us-ascii?Q?xzmBhJP7Cxbk57jAqUWLiokvBmXvM+knUf0GmdmfrSJ40MiNBBNf9bNa6Tzk?=
 =?us-ascii?Q?5AZ8hbRWhknp+0lQ4CJo9IAmKzvZ8hIQweNy21K9pkZOi0ZB7H5K+5VkrYTN?=
 =?us-ascii?Q?rrOsVEJE+vJVMS+zdt+nGQSI9mr6RE9s/ff+jFLLXukw59Lxp0bY6HEq+utY?=
 =?us-ascii?Q?xXv+rozdtsTNFxHq4TF7dqHjTd/Ze5Ok0lBq2OYW9Q7KntmdOu3a4rD7Ld3p?=
 =?us-ascii?Q?CPlsBkFuLZwFfJ6jXiHQNpxsDoRkYZ9eO9IYFquE/pp/8ZD1AQuPkRksM4Ij?=
 =?us-ascii?Q?ecc0yTAHVpV4U1MJG/8NFkHWoLz8+xNdt4mBzLLvKNA3DSDz9fdpxtIrV8Q4?=
 =?us-ascii?Q?dTTZxnq1n4xh8Eag0FRv3oDntoa5HVvzhS9F+rf6rJ1JYQqSHbVQofvjqVcr?=
 =?us-ascii?Q?zPj0zju8Phinf65t64oJoTfMo7oyLEDgCnq5whbup+NF/sQE3Iy9QpgC7f85?=
 =?us-ascii?Q?CNP6ikFN0rgJhwUHqVyXEsdIsdsbSopzMGOY5mTfXEmWiQDEYDrHV5uvta38?=
 =?us-ascii?Q?Wqy2ctcFLuhtzEJNHNtJCyP1FBjQbhcg14eGRlMRRVE8n/ZCbPrsvamrU9O4?=
 =?us-ascii?Q?vILD/Xxylb55Ihp9iz/awYh2fa/7uEsNsFJlGHTHfAuKRQW/7uDYRjy2zo0n?=
 =?us-ascii?Q?J1Fj6PL5tVq2b3jbNcFdLQrllxjsvFzF7zOxFCdWx8jbyYJyzD6Ql4EMQxTj?=
 =?us-ascii?Q?Jdm9TneAq7uQNtP8/+85j81MS3GI1rGFSKhqZnSFla8AJegX9gYRqQ/hygwC?=
 =?us-ascii?Q?kG3UCLF7w9tyhc47Hz96sXFdAfCa3iDxMkR+bdxI0AWkV8mXIxJZ9gK/5BB7?=
 =?us-ascii?Q?IHQ+GEJHX09DWqDNDpJk4QCirI7XH7szJ9v4aLbctZWoWW8cVw0RGITbzPve?=
 =?us-ascii?Q?xPxQC2fHY1eUGWZgVcdkUXc3vuR28BzjERZf9HX3UQI4TcW9hCoBIIeHWbVY?=
 =?us-ascii?Q?xK0x4lRZQBRJPzZpDaBjxsR9A5CvgrTBVLzTQGrBP3sF80W3MHO4iaVJ3naZ?=
 =?us-ascii?Q?IhKYD5NxVsBIKy/Rb36mjNgYYdti7v3J4BEfgV0VFw//cfRQmb93Mq5Yps8c?=
 =?us-ascii?Q?/v8E+N/uveI9ytdnewZdfkMbhIfgNxMuekEpt4QI5z3j38LEdppTFSOQwYxM?=
 =?us-ascii?Q?bWLqfHaWrVh96zjQlYGBQz2l+6YjuII6T6K/7tnxZCjZ9GqZkEEWmCOzljP9?=
 =?us-ascii?Q?cKw5fmEB8s7QpheiIyb2kOawZzfHNV8bQUPRHIPZpY9E6+T4TACa8efNALfb?=
 =?us-ascii?Q?jg/2LhiDIvsGtZMm8MVner63Q6e5mHcbVIcjlkhw9WMifNWJZVCNhx99gGbl?=
 =?us-ascii?Q?wFYQ9LnZMKwdW6UQR147WHFYEYDmtXkR/8M6ahtDxemAl0KDeVPDP8SZdtca?=
 =?us-ascii?Q?kE8h4S689KLUn0dE0RQu4O41UnEimFt1hVRT/EarHdXVLVtyEJNdoYRFrlOL?=
 =?us-ascii?Q?mSsX9mubDGJAIqHypsmmRAfKuup/MaDo1eGENTSstaY1lcJY0eWWk0bAsVWr?=
 =?us-ascii?Q?Hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	i5MsgYDuR/mHmTx1ngS+xgGzdYs1niEkvrkQoLcY4PNoyFlFsDNUbwO8pcuzjbyq+otjHrGjrq+3mlIAfVLegIkQqlctUMKeCKPfT4Mt7fu4SYUyF+nesTsNNXvIrKUSP5Mk8npa5axpp9CTyuuNUKq/yMDRJg3zqOm9rwV0NqKZe/H8z4pP+SBdG7rTutvtelqqj8+uBrhJtb3E/pBVTDlfDBb8aEQbMaC2qMWzqdQs92/P7pkrjV3bnJ394OW7fiWdFljinY8eQR7/VkI2vlm/yntq+VZEsFXX3F9Errropr2iP0BKWZ/TxhKXnv/JyDZjtdPnRJNihzgYW48DYBDBFzdKCvsrN09ulufb73Mxi1JQxEBA0zdLVqpMRO/3sOMWzY6xl7AaFMFmtbv859ADw19qmElfayzhrdR/zErT4Oc5KPU59y/5wK70pou4tZwYzQgYu6JKsnGMjS308eDd97VbsdNdXuSpyBHXnz1/FQnb1ticFzYzrW7Pj2zjF45Dr1XiFSo9kknPqC8yh28hwb19LiIY/bdeqXoAghmuyKQ+BfGFnHcy+seA0hYvccR09pAl4VgJrBPM1CHBcg7e9q10VXsSZCzVWYZkkQk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f220f1fa-3da9-4609-3bb7-08ddeb122394
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 17:48:49.5964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xfcqVgByWUt6TfX5+Rj9tK0guoqi6FT25RdB87KvKmTSVLY2Qr+Ahw7IGHS4NiMr+PjFLy4WhE0itI9kIhttWiouAmnRgYfhdBa/Ytgyg2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF8EEA8AA65
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_09,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509030179
X-Proofpoint-ORIG-GUID: GPtdRfL5NCLx2DaRV7v_jH-dDNM1P9sP
X-Authority-Analysis: v=2.4 cv=SpOQ6OO0 c=1 sm=1 tr=0 ts=68b87f85 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=0GrV74MDpDzFQGT9e-MA:9
 cc=ntf awl=host:13602
X-Proofpoint-GUID: GPtdRfL5NCLx2DaRV7v_jH-dDNM1P9sP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDE2OSBTYWx0ZWRfX3PR645F3bOok
 kArpymavS9Waifm8pdP1GCmtkwHjg+YKuNtr33fboLyo2Xo3kBasSJo1RmQX3PCGLKlZbuKCdgk
 y8DBQEIoTC+NUwiBnyS1/I6qi9bPAEORlM5+D8N4++N46Pc6QEzHQtSeLw2R1vvk/ig+XUWsi5O
 T/yr4JOQcmkHCGOeBw/g2+tYpU4KymwTIOrGPCsJcI5KQAVp67Tm4G2ngwjV4F5uP2bp+0eAFtl
 RrLbaL2mYxO77kV/FAnOpT1awS1bW9U/fT5+THr1e6pk3+3i3+ojqPzkzp38IR45loKIWDqcSMr
 yp5q0rfj1RhuYM6EHb2sCv1FYgtyyIluefrudCNIuvg0XOmWwIRnePOXmkh5a8dnxrtk4qpcQ1Q
 2cLW+SWRebdL7nt0tLQIY/XV8ZwxxA==

In commit bb666b7c2707 ("mm: add mmap_prepare() compatibility layer for
nested file systems") we introduced the ability for stacked drivers and
file systems to correctly invoke the f_op->mmap_prepare() handler from an
f_op->mmap() handler via a compatibility layer implemented in
compat_vma_mmap_prepare().

This populates vm_area_desc fields according to those found in the (not yet
fully initialised) VMA passed to f_op->mmap().

However this function implicitly assumes that the struct file which we are
operating upon is equal to vma->vm_file. This is not a safe assumption in
all cases.

The only really sane situation in which this matters would be something
like e.g. i915_gem_dmabuf_mmap() which invokes vfs_mmap() against
obj->base.filp:

	ret = vfs_mmap(obj->base.filp, vma);
	if (ret)
		return ret;

And then sets the VMA's file to this, should the mmap operation succeed:

	vma_set_file(vma, obj->base.filp);

That is - it is the file that is intended to back the VMA mapping.

This is not an issue currently, as so far we have only implemented
f_op->mmap_prepare() handlers for some file systems and internal mm uses,
and the only stacked f_op->mmap() operations that can be performed upon
these are those in backing_file_mmap() and coda_file_mmap(), both of which
use vma->vm_file.

However, moving forward, as we convert drivers to using
f_op->mmap_prepare(), this will become a problem.

Resolve this issue by explicitly setting desc->file to the provided file
parameter and update callers accordingly.

Callers are expected to read desc->file and update desc->vm_file - the
former will be the file provided by the caller (if stacked, this may differ
from vma->vm_file).

If the caller needs to differentiate between the two they therefore now
can.

While we are here, also provide a variant of compat_vma_mmap_prepare() that
operates against a pointer to any file_operations struct and does not
assume that the file_operations struct we are interested in is file->f_op.

This function is __compat_vma_mmap_prepare() and we invoke it from
compat_vma_mmap_prepare() so that we share code between the two functions.

This is important, because some drivers provide hooks in a separate struct,
for instance struct drm_device provides an fops field for this purpose.

Also update the VMA selftests accordingly.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/fs.h               |  2 ++
 mm/util.c                        | 62 ++++++++++++++++++++------------
 tools/testing/vma/vma_internal.h | 12 +++++--
 3 files changed, 50 insertions(+), 26 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index d7ab4f96d705..3e7160415066 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2279,6 +2279,8 @@ static inline bool can_mmap_file(struct file *file)
 	return true;
 }
 
+int __compat_vma_mmap_prepare(const struct file_operations *f_op,
+		struct file *file, struct vm_area_struct *vma);
 int compat_vma_mmap_prepare(struct file *file, struct vm_area_struct *vma);
 
 static inline int vfs_mmap(struct file *file, struct vm_area_struct *vma)
diff --git a/mm/util.c b/mm/util.c
index ee2544566ac3..0d36eac98eb9 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1133,17 +1133,51 @@ void flush_dcache_folio(struct folio *folio)
 EXPORT_SYMBOL(flush_dcache_folio);
 #endif
 
+/**
+ * __compat_vma_mmap_prepare() - See description for compat_vma_mmap_prepare()
+ * for details. This is the same operation, only with a specific file operations
+ * struct which may or may not be the same as vma->vm_file->f_op.
+ * @f_op: The file operations whose .mmap_prepare() hook is specified.
+ * @file: The file which backs or will back the mapping.
+ * @vma: The VMA to apply the .mmap_prepare() hook to.
+ * Returns: 0 on success or error.
+ */
+int __compat_vma_mmap_prepare(const struct file_operations *f_op,
+		struct file *file, struct vm_area_struct *vma)
+{
+	struct vm_area_desc desc = {
+		.mm = vma->vm_mm,
+		.file = file,
+		.start = vma->vm_start,
+		.end = vma->vm_end,
+
+		.pgoff = vma->vm_pgoff,
+		.vm_file = vma->vm_file,
+		.vm_flags = vma->vm_flags,
+		.page_prot = vma->vm_page_prot,
+	};
+	int err;
+
+	err = f_op->mmap_prepare(&desc);
+	if (err)
+		return err;
+	set_vma_from_desc(vma, &desc);
+
+	return 0;
+}
+EXPORT_SYMBOL(__compat_vma_mmap_prepare);
+
 /**
  * compat_vma_mmap_prepare() - Apply the file's .mmap_prepare() hook to an
- * existing VMA
- * @file: The file which possesss an f_op->mmap_prepare() hook
+ * existing VMA.
+ * @file: The file which possesss an f_op->mmap_prepare() hook.
  * @vma: The VMA to apply the .mmap_prepare() hook to.
  *
  * Ordinarily, .mmap_prepare() is invoked directly upon mmap(). However, certain
- * 'wrapper' file systems invoke a nested mmap hook of an underlying file.
+ * stacked filesystems invoke a nested mmap hook of an underlying file.
  *
  * Until all filesystems are converted to use .mmap_prepare(), we must be
- * conservative and continue to invoke these 'wrapper' filesystems using the
+ * conservative and continue to invoke these stacked filesystems using the
  * deprecated .mmap() hook.
  *
  * However we have a problem if the underlying file system possesses an
@@ -1161,25 +1195,7 @@ EXPORT_SYMBOL(flush_dcache_folio);
  */
 int compat_vma_mmap_prepare(struct file *file, struct vm_area_struct *vma)
 {
-	struct vm_area_desc desc = {
-		.mm = vma->vm_mm,
-		.file = vma->vm_file,
-		.start = vma->vm_start,
-		.end = vma->vm_end,
-
-		.pgoff = vma->vm_pgoff,
-		.vm_file = vma->vm_file,
-		.vm_flags = vma->vm_flags,
-		.page_prot = vma->vm_page_prot,
-	};
-	int err;
-
-	err = file->f_op->mmap_prepare(&desc);
-	if (err)
-		return err;
-	set_vma_from_desc(vma, &desc);
-
-	return 0;
+	return __compat_vma_mmap_prepare(file->f_op, file, vma);
 }
 EXPORT_SYMBOL(compat_vma_mmap_prepare);
 
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index a519cf4c45d3..dfe5b20a9d53 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -1414,8 +1414,8 @@ static inline void free_anon_vma_name(struct vm_area_struct *vma)
 static inline void set_vma_from_desc(struct vm_area_struct *vma,
 		struct vm_area_desc *desc);
 
-static inline int compat_vma_mmap_prepare(struct file *file,
-		struct vm_area_struct *vma)
+static inline int __compat_vma_mmap_prepare(const struct file_operations *f_op,
+		struct file *file, struct vm_area_struct *vma)
 {
 	struct vm_area_desc desc = {
 		.mm = vma->vm_mm,
@@ -1430,7 +1430,7 @@ static inline int compat_vma_mmap_prepare(struct file *file,
 	};
 	int err;
 
-	err = file->f_op->mmap_prepare(&desc);
+	err = f_op->mmap_prepare(&desc);
 	if (err)
 		return err;
 	set_vma_from_desc(vma, &desc);
@@ -1438,6 +1438,12 @@ static inline int compat_vma_mmap_prepare(struct file *file,
 	return 0;
 }
 
+static inline int compat_vma_mmap_prepare(struct file *file,
+		struct vm_area_struct *vma)
+{
+	return __compat_vma_mmap_prepare(file->f_op, file, vma);
+}
+
 /* Did the driver provide valid mmap hook configuration? */
 static inline bool can_mmap_file(struct file *file)
 {
-- 
2.50.1


