Return-Path: <linux-fsdevel+bounces-51087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BDDAD2B95
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 03:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B4B33B26A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 01:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5021C549F;
	Tue, 10 Jun 2025 01:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U5jbqM4P";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aAlVCLHr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B1C20E6;
	Tue, 10 Jun 2025 01:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749520073; cv=fail; b=ABc9LUMHS4eLik32k3tQE0kTOFBvGBhBzXcmxsYIyAtV61eycBP8isCmZn74z0h74SwNOg1IzLT/UA76RIxRZv+LPFXINhseUxg1rpD6jZgnatJjQXOSy42X3283P2Xl+amHS2NUWlquWv5O9B23IXz8tjrudQMhz2hDap4Gfbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749520073; c=relaxed/simple;
	bh=9eO6Twtl+KqxYXyqHkA7jON4tEKMrzcKYZmwTExJGjY=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=F01m74IyBrui8NUwJS34dr/DGHyR3NfcVeHvHSOtE1WOShQyVSTLHUNciErMFn2kdtaDWr/dGuW5hWJAx05IULL+UIB3lJdINpPn4VdWf13vhq071ll+ggAQPpqAKZS5hY/7eU9HUdCVIY4qYWvf95RY026l5vU4F4BcWUDHDGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U5jbqM4P; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aAlVCLHr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 559FtF61005868;
	Tue, 10 Jun 2025 01:47:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Dc+uA+Z13z9S/oMGg1
	NiO9uroRPuC8yNXhVdLQ3vVUE=; b=U5jbqM4PZnJxGPkaA7aDvtniwKp8UAa0Eg
	0EOx3iGNAlITFVcFdk40fuSFCsgM6uObNSSQvRcP/eTkVJ5LnkFBmZEJpFUCW5fa
	eKm7yHdIlm1stM7du3pjMhvMYmeBooILhFMsmlkgElmqTWrYJSNutOmaLRfuDd9L
	jJseKa6FMzeei4W3UpyORky7pDdqIMLs+p3bi8LW/0dIQPOBHclspZtG5/1cyLiX
	TuV8JKTYbqbei6y5FJo4Kvw2nWBjED2Bb1G35jwmTBgbHYQ2JU9IIdtF9wqQzjqF
	tNtZzJm5jVeMQom7x/idchJRkE/3zWWQDAVEb0/Ox3j1V+rFchCw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474dad36n5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 01:47:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55A14bON012043;
	Tue, 10 Jun 2025 01:47:17 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bv93x5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 01:47:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ewcH9OBdorJSduk7t5lXqMa71qygSdOvIYecnFpTmQEbC0caXL8uDMd3eoofd1piZQCpa1wgRA3MdtBfvCGP2RK0qvLuMAhmwEFqj2wBxQxGdcAkQb2ieb77VEnURAWSfFbDYZAF4l33EecuMBW13m5UDq7nY4PLqGtB8A55GVygraftV6FcQr0xKV7bEyNRpnTsdvACGsN7w+gNiP3f/6UCZLkXvEOp0rmSx0CG1aeGMBUfOydOJpxELUxObtWEPlHuoI1CAUJgaasBfd8Gt+To8kVGF8ErGXv7YqcOyVyq+7kKN/riQwjw/54ErIMu9+8ympEfi4iQUOKtkW5WRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dc+uA+Z13z9S/oMGg1NiO9uroRPuC8yNXhVdLQ3vVUE=;
 b=m+qkTtWXArdWUQv83HE2EOwIry0/FvczQOMLxMSksg61czVGMUzP9KVvC/R3N85pKxw0Ajai6UE+fpns1lPjWBeip9jdPS63887RB27sSCg/qyrb1Gtk5DjV55VBLpqb40J38S56U2DJosPU0nAbxKLdesR449lIdNtw/X9VsTjK/5/XwHJwVqKDK/qjJ05w42my/VfnZNBctuV4nf9sItR2nQhqJhxpSmmxi1kh9bW+WuXjKMYrce2/UtltE6/haw1fNt/OOyyiOoKwqeupNqRnTlqPgKTpDNg3ohEJashjAI+9HShpQZRDoR9UZiih1ACVQgZwoqAcZgPWnMVGAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dc+uA+Z13z9S/oMGg1NiO9uroRPuC8yNXhVdLQ3vVUE=;
 b=aAlVCLHrOb2bS6kNIb/gW3IZ9jmxclXGDV+Q2fV7605n7gRr4jSHTXfiDROfnbinZXpsPLtVmfbaI1N1jyAfJDcKU5VuDPd4CurXRdW1FEE/r0NVOBCKwFSKAduXi3meIADRzg9zl9WrHXm0nwBf/D/ZkbY3K1rWdwVbXfAyORk=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by SA2PR10MB4793.namprd10.prod.outlook.com (2603:10b6:806:110::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.24; Tue, 10 Jun
 2025 01:47:15 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%7]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 01:47:15 +0000
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de,
        tytso@mit.edu, djwong@kernel.org, john.g.garry@oracle.com,
        bmarzins@redhat.com, chaitanyak@nvidia.com,
        shinichiro.kawasaki@wdc.com, brauner@kernel.org,
        martin.petersen@oracle.com, yi.zhang@huawei.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH 00/10] fallocate: introduce FALLOC_FL_WRITE_ZEROES flag
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250604020850.1304633-1-yi.zhang@huaweicloud.com> (Zhang Yi's
	message of "Wed, 4 Jun 2025 10:08:40 +0800")
Organization: Oracle Corporation
Message-ID: <yq17c1k74jd.fsf@ca-mkp.ca.oracle.com>
References: <20250604020850.1304633-1-yi.zhang@huaweicloud.com>
Date: Mon, 09 Jun 2025 21:47:13 -0400
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0366.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::11) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|SA2PR10MB4793:EE_
X-MS-Office365-Filtering-Correlation-Id: 35ddda93-0f0d-4030-2d26-08dda7c0b9b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rB/2d/pf0VKqjNXFncBeDxg67FdjmaE49kRYtTPyAe9Y9hQRlA5bF6yGp0aC?=
 =?us-ascii?Q?GcMvzqaoa1wvg7Kluq+iCrahEU33eZRv0Zza832Z0q/hWGIF+KQnkZQHWOda?=
 =?us-ascii?Q?O3TUaLsDv6hwQU22iCHS/JLsvf7TO3udbSoR1pvLb3nHKoCRIpWSbjnCJQRH?=
 =?us-ascii?Q?TFMWUiICGUTZtJdvncZzgpCXf9J9qPH9u9y+0oyrc1obrG1n6YE3Qe7po0rO?=
 =?us-ascii?Q?6zgVeHuPdq6UiSfzO+sf2vLO1L1QEW6NySQLvWoRYACOEbA3QAhYAHDB4ER8?=
 =?us-ascii?Q?Qf14LCN3PjThEGTl73DqOh7IC3c4RD1lXPtkPJKuT1ONP0EFwahiUwgUBuBZ?=
 =?us-ascii?Q?pxo+CICeg0rZkjrqMokrCpBq+o7uZGozFX8j3GlFmMR6AUV6E+OxbFFw3dUk?=
 =?us-ascii?Q?wtJ7ZKQyV/1Yqfvj8MDSU1J58icY2c4P8djW2JuX77nyT+WXStv19EnfZlc7?=
 =?us-ascii?Q?nNL+xzHVoGqwY4lvatqCnkKBtA0Mzy7tHuiquQytEiSAonpvBIv23zAVOJlz?=
 =?us-ascii?Q?iJ6X7A/xo6eU2eJO3WUBM5XAZKCnJLkF4LCGeiwv3/2500BdEqt+ns8l79rd?=
 =?us-ascii?Q?38PNpLZvftj0DdBVoC1PS2lj5mYRl5Qt1GNz484AMPxYG61UZ0geN4MkAvCz?=
 =?us-ascii?Q?f2ZdZ8PD/2gS5s4dCcsWLCSiUGz8BzmqWwI747GnvP1Tqc+1C43Bbv0Duyvs?=
 =?us-ascii?Q?YKHMpN75paMm1oRThhTz5H/+49uwYFkNp2e1pX8Wowoo64QYsrqy0uWgdUcV?=
 =?us-ascii?Q?f0M6rVg1nlBeCHMmyBdNkUz/eNQ0MjKnayn76+1UZ9vubf69u6jsY3+t2OG9?=
 =?us-ascii?Q?rGaIdZhgj7cy4nfffyTdDk4fkMEJecek5XdXKu+9ZgTc2ss+Kre1rUq50GxD?=
 =?us-ascii?Q?Yib8uI/d5xAOJr7r3BUfNmV3eMW+pzE0XF56LCsiyfEz0Es6OHOf4v1qaN9f?=
 =?us-ascii?Q?uEZUekzfHhthiYyNo0QQJSjOeuhP+O2/3z0b+V2h4q71hsz5NuIW4Fg0MJGa?=
 =?us-ascii?Q?jSfACY3qprTN7QLHtHbSRub59e8e5PK3GaQivFAqOZr3y0xfUxHHiiPJLXNg?=
 =?us-ascii?Q?bviUfPQhkspMaBHALVQ2RC6/VYYtkZ7AvlAohs1Bzpyjs1fyqEr0BE5XpRFc?=
 =?us-ascii?Q?WEy+Hvi3HmmFiJ09ALC6c6eA86nzW4O23Ua1TUDIpA3Zg3M6IN52fA3mprWE?=
 =?us-ascii?Q?RGSmWOfttKzBojdTRZzvhjwharbSrSlsrKxOLI6bx24pUNW+D4MFuGfCm2uw?=
 =?us-ascii?Q?EwqHFx2EIV3cQ35mb1Zt6GqW8bgti3NbjqJ6ARiSbLB/al/wfqJlvdUNEb1i?=
 =?us-ascii?Q?MPcXjL6INcg6fbuYPkcpGlisxWrNYlzcQ1GaTXQ9+sSHLm1sSbPEez/HMmiI?=
 =?us-ascii?Q?RMaMFbIO3Cerj0kqHH1vRxy56+6W8altcXbsqMpjDPKc+yXJzA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f7XpkTCiDJyXKQCGAnKmZhJIwYzo9J287JV11gwtoDKZVvhJJEBHGKuWfKyf?=
 =?us-ascii?Q?yCh0XD/hsNtoxlGiesVIxj1dFD3qTsCjTG1fvBXwfF8UsCqtWLBySQZstci0?=
 =?us-ascii?Q?TwnKd6e8wa8cNhNedRpMi9yPTIy6J8mJjplNEBSRdY+54mWrhDi7Y71vC8k3?=
 =?us-ascii?Q?oYvEEZn6t2oXa76zAWgb7UTozSHbovpPejJxRr5fYXsx6ANREWMiaFyxMhTW?=
 =?us-ascii?Q?2Vk3VZJG/MCC2ttHbJLU3LOl3LLWCywmuKfYlQo+0DIiIqQ7rNHFe0R3zQuA?=
 =?us-ascii?Q?+Vzu17cgTirlpjJpPI49T07KdlGMaAV1vdG96XdPlJdd/8C6qzGg63N6gY/U?=
 =?us-ascii?Q?kEyHPjKzGjfQNtqQhmI9dIFFLbWOQ7asnjvLuHV+XEl3Uf3ozt8y7d9f50LF?=
 =?us-ascii?Q?YftcKQEmuneRyzdMzHcPMGf82WPv9T6U/ajBTpqR9A98/Qs2nCgmtFJPhf88?=
 =?us-ascii?Q?pIfkPT1u7zcCyuOK4XFzHOrXFmS2keXbKbCtfsbNwez1WadqxDIIUj87vmjS?=
 =?us-ascii?Q?V+HkOzyDc7w/505XBaCzsmQRcJt8CWbhtgFtn8fw1wLFSMb7zvouzw7iv1Kq?=
 =?us-ascii?Q?nOJ4If5lErrOrd5W2OBw+uj6OYZkP+9xLOC5kiBfzX3vJzaZMPDFdQoju8cQ?=
 =?us-ascii?Q?3jh1OROhsyh5cI+IiWsJSduj7ZEZ6uTsEj57HjGphz/y6Hur/fQofqelFXg3?=
 =?us-ascii?Q?DeIbu9VK2CRA+z2+ITYJ+ucl64ngxf386V21EV+KQg+vyywm+SdHkzeRkxIN?=
 =?us-ascii?Q?6H0WwcjBMty+mlNMbRp8FJOGjdvwUfzz8B4o18xkAaP6IlcF9n3v2ujpw19S?=
 =?us-ascii?Q?qyYU+QFZNdQlRiZR5/KiJt0Ns7TmuKPwcCcCLIVbo8np/vwU8uY4MeJhArEp?=
 =?us-ascii?Q?RdFBgCiXB5L5WzFlg4tCnSNgWNQ1vt0Eo9voo8VEX9V305HCwA4c4YhIWuVH?=
 =?us-ascii?Q?/Z+Cr8S+1v1Aizs/AC+F1BDOPA8Qc0HAW54EoVZts4sjnRED5tSkhD0kfrst?=
 =?us-ascii?Q?30IuHfafYjKDU7icy8tbOiaRm5YykBxE7fOFvXZhnRu/wtmUc5YMLlHl0Cl8?=
 =?us-ascii?Q?jCDTR7njt0Denl9ZNlfIIl0zNkacjaEYfs3qUM4a4I2OqkNV10N0HYPVRitT?=
 =?us-ascii?Q?TdP35oUEG/UrKoJYY82NODKFGIHOLeFrNvNFaW1nKtkWR4CtgeFarhgWgNeU?=
 =?us-ascii?Q?fTy7s1p/IanRkXys79fx0enTTHx+yq+oQPetntC+3Y+ft46B6SsJ4RCxH5Vn?=
 =?us-ascii?Q?xmZ/shEEQdO4SJ6h2B6GYFWP7fFVH74hBfJtkV3wDlMuVjnwQu8PHXYNmq97?=
 =?us-ascii?Q?H11prBArYvaQ1szttCeC7/cxF30wFe/AehWWX5JD/ObTfjctbSiYleHTs+ZF?=
 =?us-ascii?Q?8wzYeGvtlWzPiivDOWADJVBtewalAfWahhuhEKhV2bvpoEqHsRPuEnJCG/rl?=
 =?us-ascii?Q?B24cBAOWDd68jNGORqh+/SoyqaHaigNqhdoXahSgN8qP7CQsJKDstF5Nsael?=
 =?us-ascii?Q?YuhxfMzkLaueyha14BOrYy4W4l+DZ3yQSLojAIHukYE3sWfzw6YQjg7vR1vx?=
 =?us-ascii?Q?HhP+y/thXtPvgiGcb03MISVaWuHttLdFK2n007aeH3/nosN6eQNiyyd/N/OT?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9fSYs+QzpntBHPEKwfhF3cTRaz1E1cX6mucZzRqEZIxuk4KwLn95G/kTU5QoBIp4xt9WtAK5Ha/yVmtXOS+yJa9R0agTOQcCvFa+tfnTsVXhkvz+kVh1gmS7WnDf70fBtJnnxwQoRqnwLiauTJEmxAQi5bmBsQH5vXoMQxvYLboAlFJP0hU/2VsD4zk4ZIo8IzkCXjO1FvHU5hwVRRXmXSwn4NP6NMM7Et4YYnOaRoPakTypij5ZFQ3J6Slzfe4mFrMdl7/JKtl6T1M9GKHy+mT0Nw99qZZr2Ss+fGBHh/U30epf/J9m/8V4yH1G4kvzgHfZZ5ZB0bpV7qfgmwCnf0WVo8vIJBt2cIcqwNropZuuM8xfFc2sLjocJ/xOtrV5HX+cL+6l/9Ql6GVDSVqEfosbalaLt1SGwyI8TQsMPkeX4H6VOkkGugwNWYrDCGEpTp7Lcp956NID1+qHRsdWrq75N1C5B3FiRdyojksllKwrwQY3j3hhS/VNm/E7FzIc180uDyl8a0jltwqXAMPugDKO+J5X3HWsZfkomaArzCyEgserBLztHvamJq8EF0GwJZtUdr8Ys1yqW8kFkJgjY2Dsf1D40w8nI0I99qrMpDg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ddda93-0f0d-4030-2d26-08dda7c0b9b6
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 01:47:14.9029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D24ViCB61l67skoHHMJgWdmjk3PDd93ZndVDg6uscNj7kCGs+xQh/nAGUwtTlhfk2h+c1+5vuKBBvKtyKq2thJEmXEBulA9wpgXOLbyuPHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4793
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_10,2025-06-09_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100012
X-Proofpoint-ORIG-GUID: GZHeU5CPcajlVhjSbdqYpwQSdt1zRBRc
X-Authority-Analysis: v=2.4 cv=EJwG00ZC c=1 sm=1 tr=0 ts=68478ea6 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=nBxOl_bkpJgnWtLUi3YA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDAxMiBTYWx0ZWRfXxdVYiG+HpSb2 YeLjJWdEm1ivxCM/8lgxjj7APMRFai11DUxxnhjMA8fov7H79B6dEIvv3zXU+32CKfItqjelio8 EXrvqP41c4rjlDcnzyGToNH9p82yqnn9HZHUpGSe7UQwzrn+vYtTL2PcjLNidkWlke9SRiO3qGA
 Nb0egEPqtpto0IW94MWCQzowrtu632LI0j+AQyi3Dq5tqG0BDT1FzEXnImxt0+kT6O+D21NC9gx 6JrzRfXupXnXvVG2KxESeTWzESy/lqruFTMsy6b+NynP2dqHarRqm1/4xHKDj4lNXm705U2LTa1 j1ZG0+Xk1B4W3QkSJmgdVFEfmgetq+pdeOpfYZKzoh9+5SJ51zdeI/RiownRo3Lh1vuyU9Bfmrf
 AxVrAjY46DOpu5Tjtz+gbPDJXSlypx/Yv8veZPFWbeve0pRIBiE8MIBKHlHGTPKMt2mTegLl
X-Proofpoint-GUID: GZHeU5CPcajlVhjSbdqYpwQSdt1zRBRc


Zhang,

> Changes since RFC v4:
>  - Rebase codes on 6.16-rc1.
>  - Add a new queue_limit flag, and change the write_zeroes_unmap sysfs
>    interface to RW mode. User can disable the unmap write zeroes
>    operation by writing '0' to it when the operation is slow.
>  - Modify the documentation of write_zeroes_unmap sysfs interface as
>    Martin suggested.
>  - Remove the statx interface.
>  - Make the bdev and ext4 don't allow to submit FALLOC_FL_WRITE_ZEROES
>    if the block device does not enable the unmap write zeroes operation,
>    it should return -EOPNOTSUPP.

This looks OK to me as long as the fs folks agree on the fallocate()
semantics.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen

