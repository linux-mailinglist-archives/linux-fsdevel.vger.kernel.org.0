Return-Path: <linux-fsdevel+bounces-38330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5AA9FFA3C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 15:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8980018836DE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 14:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F75A1B218C;
	Thu,  2 Jan 2025 14:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VKTUKJX2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JM2WKdgS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF479CA6B;
	Thu,  2 Jan 2025 14:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735827086; cv=fail; b=bJnyZbNsbxpY5PhwjwRQaylFPFgqo14dfZBh71GyERn9JbHC3lNkHgWzo4qzu6ZcvjjKpyGEQR8iubEy896u3+8qzJBu8N6/Eo8XMBk8mRo70gxSYRBQHdddE8Yfsud/ZwjQ22T8exbKlnSZNhoNjsvKF9/e4V3n9/J6RrkQSio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735827086; c=relaxed/simple;
	bh=KeK4NB8dbPPbc9IWCEolKiV8+T/SOgi35EAMGFkaIa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JgPuRLCB3gn4vGVEeFhC8sTdLXXFN4og96csThzyxc20GRs2Y8Yyb19viQCHXL/FwfBaI/IYY5cM4fRmFmUUIReHnnwAbV11yDUTbhM6XS1NYZfUgrluX+zAEVXY79VppUfxc/2VpkkesBr3GOapB/kVtUO4DuKLtyjwI1XYGN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VKTUKJX2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JM2WKdgS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 502DtnqT002749;
	Thu, 2 Jan 2025 14:10:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=cfFy/f2UwiTvlDWM6o
	gyTQw6HHOG7XwwildxwRTe3Hg=; b=VKTUKJX2O0sDjTxE846ESj3T4gmL67gBcP
	jAPOOXrEjl2Efz+EXsXTkBt520kk4ZNh4EtpFC8SUWsTOUj8wFwG7XJU4mSIyDaX
	Iq+cdVO7svAsSkH8H4sGXeyE2B8FdD9didWhpDrs9IKNpEdaQT18HwA0/AfXh705
	MmioRuJaPVq9tSLxTelJL962Zx98RQ0Vgco7tpGll87DiUGFYR1tM4jlFysVRBFz
	43f/RmysxSF41+v44YVYc06IlD0vp3inlZcx6RyqpoBBpcvR148L4Q2XJJiMV2UA
	O+Mmnn24P5C1Fjpxj5XQasreFDb4Qrp4UIWglxZSLbEUATkJkz9g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t8xs5d6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 14:10:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 502CkcAm009525;
	Thu, 2 Jan 2025 14:09:59 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43t7s8jmu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 14:09:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vC9Fi76ngzQmesN29+nmW7Vk9PmNM/DQUtXHI3CaNQFksqA7CFCfhzJwBhTdLwMYPwAdJ4sjZUTfd4VrEGXTtlelP65FQcBWhqcaQX+dqpxWH+D85+nrgZXyqR7uDaBjMNyXkrXedI1zmpFSsqkwhjMFQz5Vzf3YHSunSGTkCz9M9hYUhPbASvlK7Aykef2LEumSrn5GptxnuiNl79vNjR368OSrl40yQkBdqTjULgjOn7Rw8dftvKy4YfU6H0qFjiFvJAJgpnJAa0bIToe3kD/KPJBG8waaotS7E2fTnV8m3xgbm40g9UKmCVWuq30c4GMwi2mQ9ieTG9tGhizAJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfFy/f2UwiTvlDWM6ogyTQw6HHOG7XwwildxwRTe3Hg=;
 b=fI1qEY8Y5FLfVZBsZfdPn9PX4nCauH5xbdRaDFrNMNziaknXDDWdxtent65X09p6bUfbwaEY4W26NtRX2RGH+ZJOil8gv5c2RR1sHo02vDKC9JFafTLNvOW7irs0zARG1+VQBUFdg2j9ejVFSc7xPTXZLO2iYFWJ0HBsMy5QlLsxtEIg2wtZnd+yGNLrJheEi4taPXzO5Scsez5cNir+AvQsVaUONV3RW+GgYp/ppmZtWFN3QjTHK0SKtj+mbyl/aYpz/N0HmXz3k+UhXBE3gJQu1ndRw4gPGpguflbVAp3SU4D8X2LtK8tdY0lqj+JtBirgACUX07akwF9KiWS/BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfFy/f2UwiTvlDWM6ogyTQw6HHOG7XwwildxwRTe3Hg=;
 b=JM2WKdgS6UAF2qyQ4iE++gU5F38xPckOrfIPFpOAL0B4tmgZ+V9unrO4ssUTz39ylA/vMuL+x8wh+YtenYNHoEhgAhk1wHdZrSJt1mZRqX7tvYlGyakl+t4pDjY8jONP78RA309x5BYTlVuK19kZbKJKFYA+mn7Ui3HsuxIFVtw=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH7PR10MB7694.namprd10.prod.outlook.com (2603:10b6:510:2e5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.20; Thu, 2 Jan
 2025 14:09:51 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%4]) with mapi id 15.20.8314.012; Thu, 2 Jan 2025
 14:09:51 +0000
Date: Thu, 2 Jan 2025 14:09:47 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Kaixiong Yu <yukaixiong@huawei.com>
Cc: akpm@linux-foundation.org, mcgrof@kernel.org, ysato@users.sourceforge.jp,
        dalias@libc.org, glaubitz@physik.fu-berlin.de, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, viro@zeniv.linux.org.uk,
        brauner@kernel.org, jack@suse.cz, kees@kernel.org,
        j.granados@samsung.com, willy@infradead.org, Liam.Howlett@oracle.com,
        vbabka@suse.cz, trondmy@kernel.org, anna@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, paul@paul-moore.com, jmorris@namei.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org, dhowells@redhat.com,
        haifeng.xu@shopee.com, baolin.wang@linux.alibaba.com,
        shikemeng@huaweicloud.com, dchinner@redhat.com, bfoster@redhat.com,
        souravpanda@google.com, hannes@cmpxchg.org, rientjes@google.com,
        pasha.tatashin@soleen.com, david@redhat.com, ryan.roberts@arm.com,
        ying.huang@intel.com, yang@os.amperecomputing.com,
        zev@bewilderbeest.net, serge@hallyn.com, vegard.nossum@oracle.com,
        wangkefeng.wang@huawei.com
Subject: Re: [PATCH v4 -next 08/15] mm: nommu: move sysctl to mm/nommu.c
Message-ID: <93c2a55b-3f3b-488e-9156-0a7726f30be3@lucifer.local>
References: <20241223141550.638616-1-yukaixiong@huawei.com>
 <20241223141550.638616-9-yukaixiong@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241223141550.638616-9-yukaixiong@huawei.com>
X-ClientProxiedBy: LO4P123CA0213.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::20) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH7PR10MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c391474-455d-4323-2524-08dd2b371fa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NSi7GQcr2ceLtcPlwGd9pMB95usg0aaDHIPDPl8nqADF5YOrj9y1xCtABkbt?=
 =?us-ascii?Q?5azkl8aC7FnFye62ODlPcvmoL7fPykQz+CmqOtk+mRMB5zdYCQIn0Kpu/ZRm?=
 =?us-ascii?Q?VpBWmO8F8QoLHfl+QckPpk0wQzytmX6dvlyPt19Vm3yZU6BiUMRI4EruW3hz?=
 =?us-ascii?Q?TBx52CZFoHX5GpJCHVQWKAWrsCvfBzLMz18itUNTd5q2IFfi1bDwKnv0hNkj?=
 =?us-ascii?Q?uRAqsS9DME6UHnu1hSfhiJuaoChtAECP7GIVQ5n0nhRx47oHr+aAc2F09kRk?=
 =?us-ascii?Q?Ohruh4PLh3LzmAjd/yneKg37N+SyCQYKp4st1jTynsEwKvq4UcWBXNzgysl9?=
 =?us-ascii?Q?1OQXFlECnqah/mNyrY90iEF6xARn6IMvYQSntr8QSFMKw1CHjqmVbIXqV2aD?=
 =?us-ascii?Q?h2UdF2D8CvdyJw/iaCZceQDcMV2nbwHDp5+XE6BS9UiEWSpLRJ9+fH2JQQvt?=
 =?us-ascii?Q?7XjD74B5vdI/0X4zqfKbtidXjKa1dqNjEPraonQeQSwAExDYYVR2sf+IVXwr?=
 =?us-ascii?Q?bGd2iR02/OZRTMOFZ3XGkjGC0zSzMXy5sqmE/QhqIT7N4jilEdnNQRYzXbhg?=
 =?us-ascii?Q?YQlS+/3YQ9w0guPrMpeCiJn7/yQmrR0MuqnokhZBU73PY6HsnpRuTf0F5y0/?=
 =?us-ascii?Q?euVIYKwXVdA37kmQGaNchdf50pAdhu95iMg4E0aRRbD6rGo4ADOvatnsomVM?=
 =?us-ascii?Q?z/23fJgam6l404v0mC5K+fcM/uEGSifX/mOcTpfmMHvBlRUK3fb7w/yN+MYX?=
 =?us-ascii?Q?yD+ARncLzccL4AVUugNchZLorno+bXMEenQoL3LNTnxpeZH71Zra+psrKhPI?=
 =?us-ascii?Q?kesEj1hpG8mt1G6W84tu36FLX5M/blL3m/yM51q0NPPUJxTdS6xKFC08IjhD?=
 =?us-ascii?Q?BnfBJGZoGZY5gKh6KDkYjSZJYKR0Zwd5T1VHKP/NBp7C4euNswDovs4LxFVQ?=
 =?us-ascii?Q?9sNVIp0vMfI6qdzussnZvZU4UWn5hKBqqNV9pYalIncH/w9mJx1f50zgvr0B?=
 =?us-ascii?Q?kP5zRBNrd5Tk6faP1tgMvSr0NZ/CEGDn0d076NrcFamZri3fRR1Lj5KrqPEl?=
 =?us-ascii?Q?o+8k/GZncZyzMSOtO2dtupUA1QbZAbjkHWK8MO8kS9+01BEMALC9SUjrH9az?=
 =?us-ascii?Q?+gImR0SdVjvQ+qKonXrKDeinDTqWscFxXLd/O6U8b7wWtOF5cedGQKFVfufz?=
 =?us-ascii?Q?Pp5/FZ8vTpy/vgza5YPt7E9R7NBgV4ILd3XlyErtNjkI/4uxt00zXgBmKRr5?=
 =?us-ascii?Q?1cBlTqM3Wgw0FugpXLjkLF03RN90fhNUZx41qXo2pjyUMYr8OW/mp7IWZOjL?=
 =?us-ascii?Q?EFNF0TjF5woc4DGxlTE0T7Qt1C1GAegKhkO4Pq5yw98wzH1VKomDMSgGLk3i?=
 =?us-ascii?Q?z9ePvpiBjPFUdmZmmw6yTKHLBhJX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BEaUrxICHNTUI3Fd+L92RP7Rg8O0ulCv28oIPY3jDnIrY2DvHd6wUusRVOla?=
 =?us-ascii?Q?9KzJemb3scStXFpsi/B/rcspQDPZAafYUAjRe+hkGzdI1zu9yBnQjKU2N787?=
 =?us-ascii?Q?s6riQ/YtpGvmdLJpwgfLP2TOoM45DnjqUtSrNP8lKz7Gwm5DvuiSrcBtbx+W?=
 =?us-ascii?Q?OQIfcLFNqPBRgYZJUngzcL1See+24NpteeqKvvV78GFxz2re2oRx+gba4hka?=
 =?us-ascii?Q?YsLnKpHyR3CFm7UepP7/wScFGn8Dm7aswV2Woq8TlwL3ocQ2SPCQQU1Fet6n?=
 =?us-ascii?Q?T90dNA8NqNyBZn8m5c/jgtW5J9Amkn0drGihIHfuqJj4QcTpKy1a4aU317pn?=
 =?us-ascii?Q?I2IBP6wCJ4FEUExz/QlPkWrLj/mY88/RPEovrghlLk1w+caRPYX2DPrfTNX4?=
 =?us-ascii?Q?KTLbWN7IXs1ZHTKKnHILVyQ46aVKELpdCrOOejR+3Qlq6AIZV8+iwRKNwf8A?=
 =?us-ascii?Q?rKKCYKbEDc44Eymr4DVzbzJOTZ4jaRBAxCSR+krWEcVdFd7SiWUjXSvypLIl?=
 =?us-ascii?Q?FMhbNOV9CwTWXLXltifnCzo5V6jer07HhPZHuMArJW0BxpRG0xRGUyB3jgHU?=
 =?us-ascii?Q?at8itKKpndyZ18gWohpHk2tIMQks0HnAd8hh2kbZZTEMRHnoknHXlLIwm1lv?=
 =?us-ascii?Q?GCSTuNwhXZozyJbYqOXAkcKLdAmDWYigUo5NtS+nIG13TAVtYN2sj8DhG0NO?=
 =?us-ascii?Q?dqj3XKB1oLVo3EGZ851s7q5/HoM02Gs6A2GDbvkh2tu7GU9sp9U9p8ssTkbt?=
 =?us-ascii?Q?3Hp5tVIJCjb1BnhqmLe9/60HbLuOQiIN/7M0TkFp++EikPEs0aphx4zMJaGm?=
 =?us-ascii?Q?SNqRJ0wqEw4LY0LFxZa9+3glxx9Y3FgN/YXGXwHHyOEtzadNPnJYJH18x1Ti?=
 =?us-ascii?Q?nSTf2YM2ApFiXeEep3C3udH9iJ4aUoWd+HE6LOR+9UyzDaILpIZ3A3Yypoa2?=
 =?us-ascii?Q?hEUyal5TBPumhBVui8qiMU6bglbDIByKgUySE0b9SFwx/IJZEFZkT0aTZrJT?=
 =?us-ascii?Q?MozvDlva0Z1ihdnqLjLWFRdFsfn6+r0DqLneVVd0xRh7h1FxohSuUW1EZRtV?=
 =?us-ascii?Q?XQMf76KoTn4zcxIvc0KssoIWaWKwN80WqwqJhj2mMBbCiYA5VGjquB/Dun3L?=
 =?us-ascii?Q?/DllMQYrBfKDmA5TStBRo4uesij5idQdx8pcCOuc6KFs6M46C/VG8rE4zCwi?=
 =?us-ascii?Q?UoVNwl6ynR2b/jqx1mNeOFv9jMXvLtNMXP6xFEGxHayG41hd3y18PusODlqS?=
 =?us-ascii?Q?uAtvGy2ws/I5zrMztu+XzNsfL9wQgSjvkDP/qYE1fKPZLHw4wYYhKqetGKGC?=
 =?us-ascii?Q?Dsq1s9v+RlbGLZWnYlxYTvfImUWzg/lgxzrcS1P5gCoAEgXFzfte0/0q3j4g?=
 =?us-ascii?Q?3tF6jj6H6xxmo5F+jKsNV18I2cljalGZ0Me8k7Pfjg0OSQXeZVWO/zlTy+vX?=
 =?us-ascii?Q?7DYMaSGxUU3NB0ldckJinNFOFIeey6YC6KRWfGaJFNvohj20caEbAWfuM7OJ?=
 =?us-ascii?Q?iLcjolyUKZMTDGkljoZZ9pfp6lIMpWR17rWgnFkFbqPB6bbPYcWIxigtSv0s?=
 =?us-ascii?Q?2y9Ra/f8XC5NaLj/EvoKmNBAVs2X2tTe+xTCjGQQjJH8QkQ042NuS7WeXKLI?=
 =?us-ascii?Q?SA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DED5fWA+/hoYlVfKKkuDh/BR7MyzD3fY8WVfiH7EPhSlD+2MQPBdM++N+Fy8LIG8vEYrXKRYmgoAwrizVV/tq2XSgtwASecSSP7tyv6uBBSVByA8JrGeandpgviogC5ELU5fcT4gMhBUmK8V/9IlsF3jx74tCZ4BfzOCKFdAkzK08RZTmmHtdUKgrHdrzRd0RyQMXr8Eo3mVLAGIXeuH79nvLMQBNqjY7SzndI5MaAZYI4k6MIzeugP9EZpDPi52VkbRGpR0xZNkRYvrDT3OOK2Xdl6BNDHYX/4tB/8w9SSHVRvBRwH8YF09cS3PIdbkODtPM574CL5ewcUJu33wSFGvRxnZZVfxFiisihwgowbehnowZ4BJt0m2V4dN+F8GsM8GB4YNJVggnarBvhf1d2hhBr07yg0XoxVbIj4TV5skAcGye8SKnDYA0OJ28tF9CSGCzn7Z0x26Z12S/iaylrfgoqiltx5AvBQD3wJC8mWcGHnLxH8D0nDlMJDNRfxGXcGJJWVOOzWcM1NnduOVOjjiZaQMjhgKT7D4O+p3DIBILedBlYM4QqttQnT17IJ2PybpDwZfg53v2FGKYd33/gVOVZueyceBajxNT3w/JMM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c391474-455d-4323-2524-08dd2b371fa3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 14:09:51.3181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rJOnkmTDcIKPgW5/2YJqP5etpeSWQD7wHnj3FBMXPTkfzSB9KCTpHvuodkgAWfq2vYfreOFPoJWTvptb4BJq7fMQl6i0w7bOddCNz+vsngk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7694
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501020123
X-Proofpoint-GUID: No3zxkomhciURxVzh95VG5cYxnaOli23
X-Proofpoint-ORIG-GUID: No3zxkomhciURxVzh95VG5cYxnaOli23

On Mon, Dec 23, 2024 at 10:15:27PM +0800, Kaixiong Yu wrote:
> The sysctl_nr_trim_pages belongs to nommu.c, move it to mm/nommu.c
> from /kernel/sysctl.c. And remove the useless extern variable declaration
> from include/linux/mm.h
>
> Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>

Looks good to me,

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
> v4:
>  - const qualify struct ctl_table nommu_table
> v3:
>  - change the title
> v2:
>  - fix the build error: expected ';' after top level declarator
>  - fix the build error: call to undeclared function 'register_syscall_init',
>    use 'register_sysctl_init' to replace it.
> ---
> ---
>  include/linux/mm.h |  2 --
>  kernel/sysctl.c    | 10 ----------
>  mm/nommu.c         | 15 ++++++++++++++-
>  3 files changed, 14 insertions(+), 13 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index b3b87c1dc1e4..9813b5b9c093 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4080,8 +4080,6 @@ unsigned long wp_shared_mapping_range(struct address_space *mapping,
>  				      pgoff_t first_index, pgoff_t nr);
>  #endif
>
> -extern int sysctl_nr_trim_pages;
> -
>  #ifdef CONFIG_PRINTK
>  void mem_dump_obj(void *object);
>  #else
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 62a58e417c40..97f9abffff0f 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -2031,16 +2031,6 @@ static struct ctl_table vm_table[] = {
>  		.extra1		= SYSCTL_ONE,
>  		.extra2		= SYSCTL_FOUR,
>  	},
> -#ifndef CONFIG_MMU
> -	{
> -		.procname	= "nr_trim_pages",
> -		.data		= &sysctl_nr_trim_pages,
> -		.maxlen		= sizeof(sysctl_nr_trim_pages),
> -		.mode		= 0644,
> -		.proc_handler	= proc_dointvec_minmax,
> -		.extra1		= SYSCTL_ZERO,
> -	},
> -#endif

Of course later on in the series you do what I asked in a previous commit :P Nice.

>  	{
>  		.procname	= "vfs_cache_pressure",
>  		.data		= &sysctl_vfs_cache_pressure,
> diff --git a/mm/nommu.c b/mm/nommu.c
> index baa79abdaf03..3c32f8b1eb54 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -48,7 +48,6 @@ struct page *mem_map;
>  unsigned long max_mapnr;
>  EXPORT_SYMBOL(max_mapnr);
>  unsigned long highest_memmap_pfn;
> -int sysctl_nr_trim_pages = CONFIG_NOMMU_INITIAL_TRIM_EXCESS;
>  int heap_stack_gap = 0;
>
>  atomic_long_t mmap_pages_allocated;
> @@ -392,6 +391,19 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
>  	return mm->brk = brk;
>  }
>
> +static int sysctl_nr_trim_pages = CONFIG_NOMMU_INITIAL_TRIM_EXCESS;
> +
> +static const struct ctl_table nommu_table[] = {
> +	{
> +		.procname	= "nr_trim_pages",
> +		.data		= &sysctl_nr_trim_pages,
> +		.maxlen		= sizeof(sysctl_nr_trim_pages),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO,
> +	},
> +};
> +
>  /*
>   * initialise the percpu counter for VM and region record slabs
>   */
> @@ -402,6 +414,7 @@ void __init mmap_init(void)
>  	ret = percpu_counter_init(&vm_committed_as, 0, GFP_KERNEL);
>  	VM_BUG_ON(ret);
>  	vm_region_jar = KMEM_CACHE(vm_region, SLAB_PANIC|SLAB_ACCOUNT);
> +	register_sysctl_init("vm", nommu_table);
>  }
>
>  /*
> --
> 2.34.1
>

