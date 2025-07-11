Return-Path: <linux-fsdevel+bounces-54623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4D0B01AC0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 13:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A1F81CA7913
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 11:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5169129A32A;
	Fri, 11 Jul 2025 11:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Cuieq75W";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lZ7Bvtqx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95236295501;
	Fri, 11 Jul 2025 11:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752233996; cv=fail; b=AH2vCF+5eesKr3wdeDwpijxv6AJ03czTvBG4wWIhd7VVFR/qRj/9zNAqvew8hGwXQmkBPEFh6V89iGqR4kAnON3ZK0ID6U5+ly1piQQsBBYQZyCrLxslSPgfamlfrZNON7VVHPbDvw3TTBCxs0ZDLeYJcyv/Ub+QlOdDsK9YcrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752233996; c=relaxed/simple;
	bh=ELCWTjVUKWu9lWDsxrGyIqbVes+UQrULMHIthnl31p0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ssTkYxZ4lbemslslhDhktpaKMhAwKFuHFt2kR9uALp631KWXdxTvzJBBtpvUEnHQ5KO3SCB5dzfZXNENoFM+3mjayDYnpEP4KSPWw0bxZLT/PRmUFrvuH9Nqm74CladRfDc30LXQNcQIJD7xmpE9RfW2fZAUWG16aTVfe68rsrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Cuieq75W; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lZ7Bvtqx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BBbENW018547;
	Fri, 11 Jul 2025 11:38:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/6/5GxZyNlGBOsA1ixk1CmOFmpuMo6iGz4f82q6m2mg=; b=
	Cuieq75WRSXAn/wzu4OrYazzmB1Fmwfa1ODB+0Rv19W2wsezC6jzAyR+0Q9ykbvH
	PlBLXCTY/9Y/DoWRK8+Hq0FKr7FAYahg8LiQQiU2de3uqMz0W6w/D1JdNgjp1xa/
	Jk6yoo/v3ghyv/R+obzt8xA0uR5kgl2809hsY/Q8xZzi+Gvo6GnjL01oZU9iRgMn
	ttnF+STqi+cCnfLZ74OY3W6DbmdCXYNx7piFkA1QA6RyjW5FxONX+GjtnpV04n+c
	lUVRZW+tv0v524Cisg5HC3Z9HBRY79TOWLnfg8F6MygeSH9cYcb8GBQ7O1QoDE/i
	T+P3zv741/SZbPtSD9A/zg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47u1w2g02v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 11:38:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56B9nqUQ021432;
	Fri, 11 Jul 2025 11:38:39 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgde6h5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 11:38:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vWCuEt7CoWcEw7Yxb9VWF4R5ZcmDKEzgYCldsXGbevMW3qI0Im0FhJPylb0haWjxJDWEHS2hcewPUeEALAZtrzYjHEdChjtk1L44p+8v3YTkmOOObmOdubahNDL2Ax2As4aOgy3ILKQoHnX+s6lZkESf0+6tkQcEwvbFWELlovzug7fFN0fSco+6mVbN76BzIUtu2ZDb2ryt/r1jZUTrquXD6HI/j4fTW3e8lXm6UhQhng6EkdHAfNafdkGgFgQuXQdNHakJud9mDlIkMSZAcY8gY7yqzLnNIbAa1zI8O7ehKsIEY2nrRHJ1Wj4gsNtu1r5XMM9gN+wtftNxvuU2sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6/5GxZyNlGBOsA1ixk1CmOFmpuMo6iGz4f82q6m2mg=;
 b=lj3bGUw/IpXnmYjJWLHCbgQkQPNmIqAnq7ZVJKMRlh+ULEseIL16F3dxls0MtipIlDdiWZwLVi/EHPaWD+oVabQSi7Ep3ZY/a/Jy0U881SbpwlTTeOYadtkxv8rcqx7UIxuMFzTzRGevoA5OcI45CSZ/qnGwiKBmCbznyeaw7SVjADES3yUDVAUVb9ZCAXh+PZePyFkTADQVTaebAXeV+Rp4/sCwdMhNOKhAxnrTVN0keVIGSOlQMvOXicgkOBaHnTZ1LyO8w1YgVtLQesueIS8nKRCKupL/GMviq4S6rzYvu6SwCSFhQToVUY4uQrXP/SoaUrhr/SVsilRh9d8ibQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6/5GxZyNlGBOsA1ixk1CmOFmpuMo6iGz4f82q6m2mg=;
 b=lZ7BvtqxMHw2MdI2hG0zOnCeCv67P5nchTCaSFZWORQAnCctMg/i7XI93QUUWsxPioVrGI0bLUdgVgzHcHYWujHxj7U/Opv96GPf/zguRSKw0DjSwzvRI/BcCHKM97d3DoY2+xyFL2WeLRNw2YYEeiUMd4U19FaTWzDv9QpxzWE=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by IA1PR10MB7285.namprd10.prod.outlook.com (2603:10b6:208:3fe::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 11:38:35 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%4]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 11:38:35 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v3 02/10] mm/mremap: refactor initial parameter sanity checks
Date: Fri, 11 Jul 2025 12:38:16 +0100
Message-ID: <87f17c67a4a477e92645189bb2f67049a6973ece.1752232673.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1752232673.git.lorenzo.stoakes@oracle.com>
References: <cover.1752232673.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0349.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::12) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|IA1PR10MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f5e9246-b65e-452d-5901-08ddc06f78cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MIGTIoVuxMJEXYSRRE3Q+1kw4q2aQAN5jq5VXbMELJUdp2wqWnLuIWeR1xAa?=
 =?us-ascii?Q?PDm+K4a+4NllF5gj4FCi4tPTSv3TzAeOHiSZAoHgCPTbG0yiAD2zFlAwUsjM?=
 =?us-ascii?Q?7OzRj6RAvhyDH9qYj+fSVUNNxESOPvggFZr4KoNpcKKiMdGTgv4cAsfdXvRL?=
 =?us-ascii?Q?LfR3ykUipcP9dOgjP3rB51o2a9Ju/f7H1Zf/C/3YsQXn78yY1kvKo8Mb8gNE?=
 =?us-ascii?Q?0FsNoEpzMY+W0LC0SwEx+f49UYSnHPLkki6rHSV3tU6cvtMhVNi8lwikh7aQ?=
 =?us-ascii?Q?PnA5X8bs8gpWIiwBaFuDH+ph/rvBH4YVW6HJjsDyvWsBrbKvCXQUeV8lR01z?=
 =?us-ascii?Q?aD43UkoNsOTAVkHnLtYBWiNmjyBFCdK+nKnTS9wWqoYaYr27jdEkagG7Azv8?=
 =?us-ascii?Q?QywzKi2bK/9OknaBndq78/kisUJb7SWwuexDuwm2H0s8Cw46N9V/FmL2E6+U?=
 =?us-ascii?Q?xGWqvGqQTpWgUxTFHRcnQ9Hk7+fMy544m/ljd2mSGCGuaL1pfO2gdbbPuOge?=
 =?us-ascii?Q?/eSU7cFEaiLi8jl6WMBlS4q7hSOj/AN1L4ZcneAiP6iYE+VykeQmtopLPoyj?=
 =?us-ascii?Q?j7TXwrGL1MyVUbOlZx1uScKPk1XBO/wFuX6COUyivxL23IKT/2QoJmc5INV2?=
 =?us-ascii?Q?dhS7c/iPS2pfVZamSY0Cotjrc3xKFDoJwDOX9pi2K1fEZML6YxGJ5txLLfNf?=
 =?us-ascii?Q?CBkKARIllY+PN9tbrT6so0EO3SSa2ic0gUKUyPBXfFBpiEEm7YPhC93ZFnEK?=
 =?us-ascii?Q?KQ6nuu2xfgSEvUK/1m3kt4cLXS/3RxrgxkeREhnFr/RrZ8tA0aDfTQrUU3LR?=
 =?us-ascii?Q?SLE/jdoJYiPlxTZeqaQ7jFdXiw9aLmBxfED1bc9+XrVimqI4Fs8OGZjZfu+a?=
 =?us-ascii?Q?7DGlcLOs4h5TRMjgPWThcntFGiz1KuXtCqdg2f2tf5zr90AVbRj9oOXwzvzH?=
 =?us-ascii?Q?1DzFp4eWlGhSkmnVqJAlTroBsJ4XYSgN93vi0bwE7q/CEnAMQyQxh3dWdTZm?=
 =?us-ascii?Q?R4x4GOu/a8EGY/OiReIrScebVxrn6i9Hrvo39uqxJUn/WPclWZ4kri0/jx9X?=
 =?us-ascii?Q?7mAEutZ2tgCcmEz4OlKxfr6hFSXKfhXldEjWSWx6XLVvhEJ4jjb+EtVqjU5q?=
 =?us-ascii?Q?/eYU2k5EggkDjIKJ4HFq3NDsw0sPeF/WwPyZRcR+tmq78/JDuUyRKxrd51ML?=
 =?us-ascii?Q?0zrpthU/H9RlLGPzbulgnHftNRtkv//flVRP6N+PUeOAqob/KzG73U6vassW?=
 =?us-ascii?Q?09nNMIO1cLlOu5RrHM/VrpG36HSFSmP44dw+TRJh6t3pn1XtWy2oc04n/sjR?=
 =?us-ascii?Q?5mYu04hOwTKImqjMEiTLTHvJgC29EQ03vMgLF/js62dJHYNI823NkiWf0EdU?=
 =?us-ascii?Q?iltGpwBBrueGXGYX4yXOdsax3+DKDLANq0f98688uZyglS6zHWpYr/Ebebn3?=
 =?us-ascii?Q?bUTv0leTuNE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CPL9FdPKYLil95ly/rExIXUT49q9ovq8zP0xfocC/Rkjvw6eh+1IBS24PDdm?=
 =?us-ascii?Q?vCncuTes1ZKM1ExAHa8NhHjXyHPRXExrXURcNqCWOOMjAlIqq+vfNEWc7Sjc?=
 =?us-ascii?Q?A6awucfRatpXZZS8yb94T6o/a3L3zlKyiiO3Ye1POrDUC4uoHE14kK91wJ1N?=
 =?us-ascii?Q?AERBvorXwHEuU8lsy+IjE1fqfVGq0Peir3r20nADeqNQVNZ06W4+ccsVmzES?=
 =?us-ascii?Q?CUSlnaLl/Cr+EOjHLaXdAW/NMJ3alV0aQ1oozsQr6vVST6YTtrJFVBlI2IHY?=
 =?us-ascii?Q?2GMaoE5sfITfiBzdLAiy/QjGvtJlmzwns7M/Bu2fFgKU+Jb9zKdkyTai2whh?=
 =?us-ascii?Q?pG5s8vRs6hfTUlBeGBnqLO08Ht0F4YsES/YMOui9ytKRtcMuum36gI96hAnp?=
 =?us-ascii?Q?sl2O+RqBKS+bzPAPWz3zUdyUGMQP9Q2D4WHeGXIi08WzvyCNlEjXhU1OFdAZ?=
 =?us-ascii?Q?j0/dv0XFiI+Bdv3sqz8RqVrMm/THwzE58l2BRKZyt/GqvEA9oONgmhsvIUx3?=
 =?us-ascii?Q?Wl3OEmm6+j+zEHdd8Q3hW3F6irD5s0plkrPcE2vFMjPBqrZoxg4JOGK/1n+a?=
 =?us-ascii?Q?gOs83ZsrxXJTBAwIeIR0SPyg034Vv+tnpAqHWTGFKsGRvnrk8o6IoNZsscUX?=
 =?us-ascii?Q?SK8v3Vete5EphRde6H6sIaS/eMANdpmhIaikBAaZHOoWDWh3ZlLNWmEOMSwD?=
 =?us-ascii?Q?g1uHfI/O/+n6gPbc90oEZh6zHOm+6ls4v3K/2WPcb4RAwaYBkiMVY/oNePbc?=
 =?us-ascii?Q?UQy1l3qfOrIDtV4hS/efMOJW0On2yIPmmHBx/XcwIdoifrJO2DW0KoUlRBCR?=
 =?us-ascii?Q?ONpdnY2SHz8wL9K9gSQYl2q6rtBOrs//T8Evy7jS7dynctb9Fgu5SUJ65Cph?=
 =?us-ascii?Q?z0Erp4imcwf3yf7qQUkpxX6e4EgCcTUDku4qn8wsZR60MqKzwKxRvlaDyVCE?=
 =?us-ascii?Q?mtotB9qP8pIe7tjK5U3eEG/huH/V9M2/zAaiA3pwqHRqjbIyHcz25z/5E5Y8?=
 =?us-ascii?Q?nmGJjopvh/djbkm3TTpre8W7kotPzCqQourf69EaJDllZUyjZOSIRbTyspUU?=
 =?us-ascii?Q?vLqvaIM1DnocZFQaBd8r0VKlekb1dMzp1ikgv6lAqHQuBGr5d4ERrHOoERJa?=
 =?us-ascii?Q?D1AUfmITktP7W3L2GSFu1NC0i5KzwrxDdG/D/YnKP8fVLMZxykJaz47NC56s?=
 =?us-ascii?Q?Vf8W0ymWaNSiuaxjxXPvZ3oJecrIGZeh883vbrKyAYU5gwzlZxLGjCvlS7s0?=
 =?us-ascii?Q?V0m1h2iqwuID1TRFtjuuFqVe+mBR07d0nV3RnObWbXXAnD+APZ72qaTZVDLP?=
 =?us-ascii?Q?mNkVRkB2qK+Sp7vHZYcOHCZVzSy+THfFWuT8ShqXKBWQmbvKfZaGIM9c8+g7?=
 =?us-ascii?Q?m/65uY/Hza/2PZ+3nBjA0MUPwV9q6X0tHKDz3SOGhfETYGywtWqvrgRHf1yk?=
 =?us-ascii?Q?3mOWn2eYKHQOyHU4Mz2ORAu7XU2TsTIsIBCpWkDzy9l4iDX5O2N8LcZfQs/F?=
 =?us-ascii?Q?z9qsSabHGaDMHWIw7TUREqoXYLpk8CwVBdH2/OOTRnopVLjjzdgt14TlJsxc?=
 =?us-ascii?Q?vKH25LrXNxBGuU8OVNf8iUQndIGdc4Wqliy4fHmwwm3/qE21ukPNY2t81Mcc?=
 =?us-ascii?Q?1A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9X+rDR2gDkZGS4c8IP3675cNx6t+8+e0GcsZzBTezJBtcCbcb8JWZFDm3mLiPNC1dTr2+k9P0cVVmzENEvs1FMFOcjoKpUKiR/hGjkob1P5D8P9ipbmzvcqGtP6lgSsFhIa/NO3KuJQJRcbqpP+eiUxeL6XNlZfm53Tf2BBeHxNaPOqvR9catqNWozsjMMowq+JnFbItHRJHKBdwKr6DI28LJQNZHs5mLWm8E8OHW3KQPEPs/WpKHkqZt0oI1BMu+kRhxwj3dkLCX9e2cZPCAF9ZC4gt7BtflKaeI/DVCS4NKHeTzR3aPOidgyr/dx12ZVk8hzXnQ5FIO2CxK5adXXrSHhdM14lySMgRhS64emC3lxNWVsGrDItyNveqgk+IYkm4/w6MSQMXfajzT5q5V1p5JASmFras7L/Go8pgSYFeRxjk//8MupZ6YImxUP5JPCHJxnrns6j7aohPdKJuSeYxkbDGJShB11NnY7yA1f+neJLChXs/SBjkQoh1nQrNsOGqkmzWXa3KLEhwB+cn5OYdU8U5lyxtPAVklBbJ/75BjrYRedo2zLSnFN8zOahpKfclGRK5vvckbqa1ZoP7ZOUVSkLMdBFIL0//lxuhehY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f5e9246-b65e-452d-5901-08ddc06f78cd
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 11:38:35.7624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ugux75u1s251y+8Cscvh+pewax0J0/31y8pXloeBLjKecxF8LfBsWXey61yzMNYpdHB5oU+0YqgxYRTiszpoaZu+mS/b44xLwUJVZ1m3rcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7285
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507110082
X-Authority-Analysis: v=2.4 cv=X95SKHTe c=1 sm=1 tr=0 ts=6870f7bf cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=44BLHjD3IfhdABlFFWYA:9
X-Proofpoint-GUID: ooi5GZPXvOf42gdtT7gSV1rmxkTO7YGL
X-Proofpoint-ORIG-GUID: ooi5GZPXvOf42gdtT7gSV1rmxkTO7YGL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA4MiBTYWx0ZWRfXxOew3WpEt1Q5 6LRPOOvVjJwg7C4jWHHzbDowEVVb5oIqRTNJUZv3hdnexK7TG9L4hiL5bwV4c6UqEVSu+TNLk8K nYJ9M/IbB9La9b+UjnDi4L5seFBRP9bJ4qeoBa2NTPo5uM+YFzR9R0Em0mcucJbE4HRxOPTO/jS
 tjzxOiOIgZ4nGcvzCcGjR0RaGouCk8fTvyPbnZbad9g7pWJM5nJci3kQ3zct27zW4BTkx8A3+44 U/b0WDDYlymi69eXtMW1zwW9BjKq8eL3ZlkHbHPS2JESuJIiwK0MR92rAQixh8yW7Hu3fMoQe07 1VDlhfL/lr6yNTEbLnicTXFeIlY/aSpbbbdxWgertGiPJ7h3Rwruj4lEBOffXOKqGmsaEm5fD8f
 gOCy67ISiLZ0vUQEqcv++pkTLD9jHEAXK5lATk9qyDVck4uIyPVQLH9DI83eKYJL9dPLFu8H

We are currently checking some things later, and some things
immediately. Aggregate the checks and avoid ones that need not be made.

Simplify things by aligning lengths immediately. Defer setting the delta
parameter until later, which removes some duplicate code in the hugetlb
case.

We can safely perform the checks moved from mremap_to() to
check_mremap_params() because:

* If we set a new address via vrm_set_new_addr(), then this is guaranteed
  to not overlap nor to position the new VMA past TASK_SIZE, so there's no
  need to check these later.

* We can simply page align lengths immediately. We do not need to check for
  overlap nor TASK_SIZE sanity after hugetlb alignment as this asserts
  addresses are huge-aligned, then huge-aligns lengths, rounding down. This
  means any existing overlap would have already been caught.

Moving things around like this lays the groundwork for subsequent changes
to permit operations on batches of VMAs.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mremap.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 1815095c4bca..a00da0288c37 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1415,14 +1415,6 @@ static unsigned long mremap_to(struct vma_remap_struct *vrm)
 	struct mm_struct *mm = current->mm;
 	unsigned long err;
 
-	/* Is the new length or address silly? */
-	if (vrm->new_len > TASK_SIZE ||
-	    vrm->new_addr > TASK_SIZE - vrm->new_len)
-		return -EINVAL;
-
-	if (vrm_overlaps(vrm))
-		return -EINVAL;
-
 	if (vrm->flags & MREMAP_FIXED) {
 		/*
 		 * In mremap_to().
@@ -1527,7 +1519,12 @@ static unsigned long check_mremap_params(struct vma_remap_struct *vrm)
 	 * for DOS-emu "duplicate shm area" thing. But
 	 * a zero new-len is nonsensical.
 	 */
-	if (!PAGE_ALIGN(vrm->new_len))
+	if (!vrm->new_len)
+		return -EINVAL;
+
+	/* Is the new length or address silly? */
+	if (vrm->new_len > TASK_SIZE ||
+	    vrm->new_addr > TASK_SIZE - vrm->new_len)
 		return -EINVAL;
 
 	/* Remainder of checks are for cases with specific new_addr. */
@@ -1546,6 +1543,10 @@ static unsigned long check_mremap_params(struct vma_remap_struct *vrm)
 	if (flags & MREMAP_DONTUNMAP && vrm->old_len != vrm->new_len)
 		return -EINVAL;
 
+	/* Target VMA must not overlap source VMA. */
+	if (vrm_overlaps(vrm))
+		return -EINVAL;
+
 	/*
 	 * move_vma() need us to stay 4 maps below the threshold, otherwise
 	 * it will bail out at the very beginning.
@@ -1622,8 +1623,6 @@ static bool align_hugetlb(struct vma_remap_struct *vrm)
 	if (vrm->new_len > vrm->old_len)
 		return false;
 
-	vrm_set_delta(vrm);
-
 	return true;
 }
 
@@ -1723,14 +1722,13 @@ static unsigned long do_mremap(struct vma_remap_struct *vrm)
 	struct vm_area_struct *vma;
 	unsigned long res;
 
+	vrm->old_len = PAGE_ALIGN(vrm->old_len);
+	vrm->new_len = PAGE_ALIGN(vrm->new_len);
+
 	res = check_mremap_params(vrm);
 	if (res)
 		return res;
 
-	vrm->old_len = PAGE_ALIGN(vrm->old_len);
-	vrm->new_len = PAGE_ALIGN(vrm->new_len);
-	vrm_set_delta(vrm);
-
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
 	vrm->mmap_locked = true;
@@ -1753,6 +1751,7 @@ static unsigned long do_mremap(struct vma_remap_struct *vrm)
 		goto out;
 	}
 
+	vrm_set_delta(vrm);
 	vrm->remap_type = vrm_remap_type(vrm);
 
 	/* Actually execute mremap. */
-- 
2.50.0


