Return-Path: <linux-fsdevel+bounces-49332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D640DABB7EC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 10:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 785A43AEC69
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 08:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB8426A097;
	Mon, 19 May 2025 08:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aWArihPr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="R61s0WBR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC85269D11;
	Mon, 19 May 2025 08:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747644742; cv=fail; b=hNTx1GtMLBnXDUy0UTlE2f/EezziQ38u050WDrXeNHr/eG9u3kG2MfpYBU99TWfBVSnVJ/t5cy37JZtAENPzM3rmI/UlE19yqwaa5e38ttNRf2VG6qlzX7DYe13snm42VEEmgUzUyx/biduKZKeRkYWt+lkeWSf1ZPBpSkPy0p4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747644742; c=relaxed/simple;
	bh=bF2HK27KdurzMzxGyQbfPDifCb72wN7fZMSRGjnnjAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p5M8wW7ght2oNygWLgRTRGkBjEVNNCj9MuFuL7D2BrdI86ynPo3LsrMUwVRQEY73MwKtsGG3jAW9S2p0WeOEWE4JyThKJu3vlEkjxXMYgzSZ4LavwEnlEyri261Qn2VRRGTCXhMSB2WPqsCsdq10yw8Akt0AYyeVYTvQPYWFyqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aWArihPr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=R61s0WBR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J6j0Np015330;
	Mon, 19 May 2025 08:52:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=xma754bO7EEQEtzMkNfZkJ79BK0CggajKNZMHwoYjV0=; b=
	aWArihPrTzLxEqbyYR2AEW8WrxYXjlmJ9G23G0vm4h2vZXcyR5PSM+fLz4llkr4Y
	l0UuWiFrVp4igdgRLoMwb4ouihrLsYF5M6/uWtggSap1ic0btuRmIkbn1Ft8nYb3
	dhxl8JFQvHphjnL622+g2cq9BCLWPTNbxlvVxmvm5lWYouyG/GxaLTd+A7RwGI/E
	RL/FSFOql/Qa7YJyRAQM+NI8E5f32nuxUBXGkKfw7oh9HMbmNi2CMLfNHpijoIls
	y2Oc2C1YH4b+zeFIUTh3+KpFRmVBeeinIenUWYfT+/T4MJ0d567ozO0K9mmnocqL
	bdjVZE7ZvvAqwrdkqih8Cw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46pjge2fjb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 08:52:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54J8fwMN034500;
	Mon, 19 May 2025 08:52:00 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw6drhq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 08:52:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eMMredCep5n5cswHmVM/wEfemm0g3SPH2qStD7QZPIrVVfx6qWfV5EecMlCdE+duGXquZZ4TFgFkGcXkFHG7D85hdgv69mg2lb3Ka2zrlrUocJ84EEPsNJGRXnb7kvR0IVg34rmhnxQxKtXxfsEFWKmmrYVq6GhRG+SkBRwdSf7D2NjQH3+MvO/UNnFQmBQmuihZCacQAncRjObU5mrujuhT+9wyBuUh/loeeMW9QlD67NzRxwKCFm57mCodZqo3DZ3plPGahc1dX7MmRMUAjSkJvm83YE37wf6WO/dqUHYORVyDew+xozhMSagXMf600u2cm1GpZNDYfSt7TfFKgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xma754bO7EEQEtzMkNfZkJ79BK0CggajKNZMHwoYjV0=;
 b=VHZZzWkIrbC82dkir3gnCfE83mlMSWdEah8dYI+WWaoUZTC5Ur+tl8iOAzJufkhDaS1sbObRyU8D3M3AYF6vuDZwD7g92Wv/actMrzoqZn9VXn01zAFNIWVh3CDE+2MGNOhGXOyGNbXeN3iMkegD21gH4WLTACRGfDkgjZDT3p6gW1eL032k6DQWguPCuSoUOFsFjdZFg65mDIezOI9lDQ1aN7JjbcNl/3SNu+/LpyglY469A+Y387YyUkRHbpE1NBHAFL+rzSBBus2/XkRZxUiOmESCwTVkJXUhT3Gcm3V8O75LE54l/2Jw54+cl7ImuqJ1fq8egP4SR6js+MAtNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xma754bO7EEQEtzMkNfZkJ79BK0CggajKNZMHwoYjV0=;
 b=R61s0WBRmM146ldzgndrB4waklnGfkYfdQgbin2CZDubt5taw5K6BmichNsWgbEp+3tG+t2mJROGfmfOYQPKWwhKaklaevMhQ4m6ATSx9Gb4d24lq0F6G0OcIKcpvCOtIAODiv4zeZyWo3h3KhZJhmFx3KMZEkYuhrsT7l4VAd0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB7767.namprd10.prod.outlook.com (2603:10b6:510:2fe::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 08:51:57 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 08:51:57 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/4] mm: ksm: refer to special VMAs via VM_SPECIAL in ksm_compatible()
Date: Mon, 19 May 2025 09:51:40 +0100
Message-ID: <ec973573540c6871683ee763d291b74bd851990f.1747431920.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747431920.git.lorenzo.stoakes@oracle.com>
References: <cover.1747431920.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0252.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::23) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB7767:EE_
X-MS-Office365-Filtering-Correlation-Id: ebdd7a79-d656-45cb-4a74-08dd96b2699b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gy7piAI9NknkMCUnUAR8p/HRG1s+oIeawsJXArWpb/vVX5PyyaqHV63iRCkL?=
 =?us-ascii?Q?/FWOxqjnTP3+A+5jVgpQT4egih+T3EDXvJRfGCbtuJabrXzKgY9TmYEp61k8?=
 =?us-ascii?Q?SYkG1NiMSoGNNFCbNp8xZDz+wZuBFif1/YM5SkLVCNI45C7dcmk12t2R0Ebs?=
 =?us-ascii?Q?bBBrAydIFMXVR701JQpZzWtpSxnVYc5eaonu9ISz2UGDU+z26gvB+pBTzqeH?=
 =?us-ascii?Q?Fs886QBIcrDv32QClXxzHZp6I6DoowuHZF0qzj3L6lukvrE+dB3zzg5ETjgc?=
 =?us-ascii?Q?xVsQvTjvD7zyotp2bhfRVSan6SdONxN131c9LIzBQawbs2tG9FAp1zQAoZ+C?=
 =?us-ascii?Q?vhdvWU1yxZNXw+ISiwXNmBWIFy6opqR8ki0RM2VDcdmlOavyOlVfNkLz0Y8p?=
 =?us-ascii?Q?9ehOs5VzOd/qgMqrFCtArm5I5sG6by8xH5C35b+RfTi70k+YP2HqDLwO7LZs?=
 =?us-ascii?Q?DSZmVxdnYG0yMNdjlBaoTqn3pLg8yLrXTWZ7QBeKM/z8PJ2pp8r/6AnKFy5B?=
 =?us-ascii?Q?ov3baLFeeSfMVyTW1Htk5RRxIfuziRXmfij56u4FoPsCYoD35q/XFYqQJVYF?=
 =?us-ascii?Q?6WAJ6ov6wA2Q3RgZfEWf8VBdjIgEswTl7++hMGZxbMU+9xY+d1R9dR6uYfh1?=
 =?us-ascii?Q?wFgMcYZ054UxvuMvlUGv83txsIarXcFerja8dVatGfTZHJlzEdOPGxEPwv1H?=
 =?us-ascii?Q?sqt/MPIIP1uUTqlcvcSXD2mntUpFRJ4R0FeDsb6DbeBLAezocBJMpuDcOulu?=
 =?us-ascii?Q?ww1fTN65wTKLT/8xlsyzR80hNb1R0f/ccWcXzZmDcSxWhOiMM9HYJ/Cnw8qD?=
 =?us-ascii?Q?nJTgQ9On1fPD+xOi8/4E1QcXaS7EJF6LQXjph6vlphTEqO5hcw3e41ewqG3l?=
 =?us-ascii?Q?W+4f9nFgIsWkbqIHrfwFh4sl6k0Is4NyXdr9FLtfFg94lb+NBbrCr4KGwApc?=
 =?us-ascii?Q?gAf6ArSFypJe/ZuykLUETdzBHJ+uCdIKEpmxMwHJAzVrVNjkouMOE7nZVLGC?=
 =?us-ascii?Q?/vlQUd2v57vZ1yvozBLad3nSsMVGSUNzI75TjRwELbmfNojIyFmi78cXPhyO?=
 =?us-ascii?Q?S5YEW9xSin3qHQFvfkJ3AJM2yYTuHpdFLp+NF4Ks6OsFlOi1r9ZdvNd2TiLJ?=
 =?us-ascii?Q?vAh2braw4jVOSm4IaKBGhamorUyhe5UolCCEinQ17k0DsmLria4UWy1w9cNC?=
 =?us-ascii?Q?uj6M4Nd+f4ZQBQv6j/qI9vRzmwpGJES7ChwlV0s4EwBNUafelnlkoed9dVGk?=
 =?us-ascii?Q?odjOmJxbN0Pf1SWd6ntoadMsiSOCatHqGXPCdAslzcBZYC5H37sf5k5hLq//?=
 =?us-ascii?Q?Lo1/EfjCPIDq7eQvcTu3UMuT8JO20uVlOpfKl3FVwxFwrbFJvr7E0EfM82Pc?=
 =?us-ascii?Q?zIxT5kPn1W7+PjjUh3+QOctwX/wK8l0W/OVUcby77+b2lWvGuQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aXxv0vs695Vu7HJ4LhGiOTsuHxWQ7DSEpSV4+YzSaom7tmcgXruR6cS8wnRr?=
 =?us-ascii?Q?mJm5ASVycm2FDV4WDGfi4Wm3dVWmaNXyf6peL5v4HBueissdr7a3ZTl2GDp2?=
 =?us-ascii?Q?cc2LTBB+7lSvtSs7p3e97zr5rywqnKRrGnWSgZga7KDRIPKxF6NVQbEjv94H?=
 =?us-ascii?Q?Yw9AaG5YhHXUaYgYAqanP3bhQ9G1k4vwKa57CIkqXoYm9qF6zKiBz2hTNLSt?=
 =?us-ascii?Q?c/y+65NfAcO2dWiK1QnZ8k/W7mFlVIUBmSh6Z51NlBf5lqgqKe/VjOuiGgHt?=
 =?us-ascii?Q?uEH3pqEI+DlmHgTAwaQZFgd1JYgtJpSKZ7fUQInTkcBgBsYJA8TG7yjDKRgF?=
 =?us-ascii?Q?X0qWUwRc4F7xkvmo8i+gEMUWfiVbWFOF6emFKiBrKueuHUvZ5AgTEcfTOLIe?=
 =?us-ascii?Q?1j25gzNlUhg0HbSG+/+0cid7akNBF9SzWF9rmjikvBMOgJ5ma+k10lmiXpRm?=
 =?us-ascii?Q?ooy29Vb0x1KW1/7XzSQEknY2wryJqIARakkq4Zepi9mQWU7REREqh2cqc7Pu?=
 =?us-ascii?Q?sdNOQqB45LdX5jRK924irVfqtxK+xeU+c5nr+r9eJZCuMObaIr4rAgkW7C1l?=
 =?us-ascii?Q?9rr19ckls5qpRhG//Yqp0L4xCuOLmeDQgQJme8UuO1A7obcJreH2pv9ORHzI?=
 =?us-ascii?Q?kqTxRey5FpRQ5EcFnA5qvpyxANoBtIt8q7wp8rlzwa8yws+ZzG33vgJrZVoq?=
 =?us-ascii?Q?93HGSYpjp6XEgimn55bHU0ns9dLdHJQrA5oWaLTMR/08xt/JVKU0xO8vIopc?=
 =?us-ascii?Q?81f5qU2sS1tODMhycTifhXpaqnQSYWh6LHsOxISi0l22SFIEvB6rJbg8/e6T?=
 =?us-ascii?Q?o4lxbThlPoII+SzVhxgeo09wldAVKCT4ByORZZPxvKbwaGExMk4/5gmcd4FQ?=
 =?us-ascii?Q?osvc22YlPng1E1LHIWEMQ3w/LwRWmKd9Wx6TLU2+GmczV6pZrSdEIeluRs5p?=
 =?us-ascii?Q?Fe8kAGz4ij0lY4/k5v7wXmCrhChP4qs4zsGY0xmi0GCGpLQ3wOM/PqhRRnVR?=
 =?us-ascii?Q?J2gi0+1j/S2uWnWnwtgS8CP+c63VEtSm+37TIytPeSRsvZ1m3p5eYvck89fz?=
 =?us-ascii?Q?LrcwcM4DvEYyCeR7BrgzJDY/k5cS/3+UQJa4QGGvZ4DBtPtk9vIfstjCSyLN?=
 =?us-ascii?Q?sf66hxAZiREODAyHtQ4s+h7bvZ3Z4Hm7iruHizNjHipBYYrh+8j7kqfEQDme?=
 =?us-ascii?Q?5LJDpz70W0vBLwOU2fEYSFkdBxNNfUT4AUu9n7OyDo1Indp8jdsH9qNPGwoJ?=
 =?us-ascii?Q?6c8xp4QU1fBM7l3ZoU6QHgi8+rAm8+BSfb75jLeLzRHo+k0whMQLZAQC5pKI?=
 =?us-ascii?Q?XrcnPmKBoMRJDdfyHZihbLLP1s6b8lNRzE6/FYNERb+oAFa7/C698NqrrzOJ?=
 =?us-ascii?Q?GcDmBlFi+5ydHlzdzsg1n9NtALFasiU26Nsj3zO4oNk4C9foNQzB01CauE9Z?=
 =?us-ascii?Q?CtRq5NWVHQMc+iMKqmFKQ8DOwYJt5qHbcKHghUuEKiO8Wp67DiT3rV9nCW84?=
 =?us-ascii?Q?ArUR+dPHCrv0hKSoiKKq7m0G0yZj/WplGy69NETEGvSfy7QrubBrh0Y2Ej0t?=
 =?us-ascii?Q?ZJ8RSI28I96Wa0gqKn6Ec4QmKH1qNLri9nAC56XFq7a3DJ+0ec7mtKK+B/nT?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CEo050ffI0TkZWLP/nA135U+JkC3pEs4/+OEzmvTCpk7eWi2kjusU6xS65ef5rdcbwr1QdgL1smNEUlZnSjw4dylvJ+t8Pq3bPREc9aMbpk0kzjks2I//RXbq6br+LsKpuxJWjToiYKPUEVBSY45E5rPpn1o7h6VCvL4Yo0A2mStyDd2tgJApzJAOl6dwEAxz7pU5klEUNIkuvX2KSUEM7yGt5Yl/nBbDDJQcS7YwQk2irEhkwSzD7ls84l6PBdne8Jxm4H9ubS5CwcHqwHHP6UhF7pjsIKFr7K0IIP6eSmnXEu68fjIyk2IFlXBORsBvNimsUi8n7Lc2ajdlPVlhZAmZzWUnCu9u5Nxlf/QRQEwR4jFvUhaGpxWRM4Pvnca9BE0lnv2NFEXvGFnmLnz3Xui7ryiWvQj0I3VF9vmaNdPnUDLVrdOtUF/5Pskx9W/VJ2T9sU/6AE8EtN3hUC7z8VltV1Ldz6hUXA69B1R8T5iXu5HBy2jaHhtVCAMYl9FimpT9PzwGoJI0/DqX8yc4gguhzllCTuu3UxBPh218ZedvxYmPPdXdpQHWy/yGb/JIcrYWIY2Iy8UBqJ5AtTARhSPmWAvb8v9it0PC1eL/LU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebdd7a79-d656-45cb-4a74-08dd96b2699b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 08:51:57.7227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ObLs0rjVJ7rsXiwhVgXAmWpO2l4jyVvWY4kJ8Dod4E2unOO/c9emjejbxH643BGAG74lKOR2ajG2/id5Il4a0Tv0j93OQC6p1DsR6U9St8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7767
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_03,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505190083
X-Authority-Analysis: v=2.4 cv=RamQC0tv c=1 sm=1 tr=0 ts=682af131 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=JCz4esxvuu-7hMN-IX8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDA4MyBTYWx0ZWRfX7OweDKHQJVuW 4I/eStI2nYTXH+lrP4MV6yy2bqIbKeWX65Gj88hfAv54UAgJYFrY119dt9OMrnSaCKcgfA5VoR9 MePbPhXgkwoDy/bCPrGj9aX39Yufbgz7JJ/Cwt7D6jmvL3pazvfNfKrWl3d6phrmEQPcNcr9ykl
 cLNAbDOSbkiijYVPzCsR+pGTg+Xs/XbhgVAAOZyxTG+Y/QlrO3VYNv+f3N1htt8d8q1leXNzPic KDjiUNM5PZ9jTkBSI3ZmqburzgCxBxALA+W5GwgqA0885N8rcyhYCxCPDkn4w2V06b3qiy2w8iz VCo0/T5Dp9G7hcUspoNvm8rp6VyrrDXt8dW7PW10V1Ihw8HtCuv6X+YVP9B5e+f0SUgMZQ/TZ+H
 pbZIDURlZaQ3qBxjMqp9yKEjob0Gbok+q4ODeFEBHg4CG8dEZVRpFaFRwfYD2Id527xwXs7G
X-Proofpoint-ORIG-GUID: 74Kn8q-GaKAvSGornKjJs4R-aHyevcSg
X-Proofpoint-GUID: 74Kn8q-GaKAvSGornKjJs4R-aHyevcSg

There's no need to spell out all the special cases, also doing it this way
makes it absolutely clear that we preclude unmergeable VMAs in general, and
puts the other excluded flags in stark and clear contrast.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/ksm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 08d486f188ff..d0c763abd499 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -679,9 +679,8 @@ static int break_ksm(struct vm_area_struct *vma, unsigned long addr, bool lock_v
 
 static bool ksm_compatible(const struct file *file, vm_flags_t vm_flags)
 {
-	if (vm_flags & (VM_SHARED   | VM_MAYSHARE   | VM_PFNMAP  |
-			VM_IO       | VM_DONTEXPAND | VM_HUGETLB |
-			VM_MIXEDMAP | VM_DROPPABLE))
+	if (vm_flags & (VM_SHARED  | VM_MAYSHARE | VM_SPECIAL |
+			VM_HUGETLB | VM_DROPPABLE))
 		return false;		/* just ignore the advice */
 
 	if (file_is_dax(file))
-- 
2.49.0


