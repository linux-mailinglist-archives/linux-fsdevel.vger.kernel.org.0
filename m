Return-Path: <linux-fsdevel+bounces-45955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 001D5A7FC8E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 12:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4035116990E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 10:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78711269AFB;
	Tue,  8 Apr 2025 10:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ahYO17Np";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Sa+G3vmp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB8A26981C;
	Tue,  8 Apr 2025 10:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744108981; cv=fail; b=FDRSFcNV123MHxDqmWGdlyjlR5dy9OlNjRpMncW3RJ6pInmip3KtNNgxIo235VqZKoYFceFyATz85eEuap82+Ap2AdZ0L415lVwR31Aof9ryvxfaAA3AWOqG8WqZzkKQToskjtSdlkwmtx08rXBvUWoYqgaHz+wjQA8r+QOtYEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744108981; c=relaxed/simple;
	bh=pra161ou/h8chlA9yXUQcjoXcHRvfZfy4MOaTpjse98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D2pdWvwPtxCg50A2pa1uoypvIgn3IdLVO10uOseqdGx2SpVgjIdF0VthQAGtMugpEZTko1aUgD218q35cLZsyY+GrmNra5W4PtkeNFUXvjLl9P+aINzzo5977bzBs7RmggAWZR0KUAZTCon6uAmBMWAKRfQWHuicnVgKJ4gIHfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ahYO17Np; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Sa+G3vmp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5381u6Fg001158;
	Tue, 8 Apr 2025 10:42:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=4MVFHj2jeR3CYDsF+FSYfPKETrPlcvNbqSeNIdTwSqM=; b=
	ahYO17NpqqQdXIAbhcn0gvQlXClckl6QEcLEHiRtBVrZwbycrhupeBi0sHMeQT1R
	gN/wFs+qUMBArvguRhQziUE+rQrAACq7v1wZo+4DkW4eo3yf1ACSxECyPyWWQ4gH
	MKnM5hbHD2vI7pA7Jxr91yMNhs4iu7G/INeWgzLjyb7VTxM5yl0tOwH4+lxIWOfU
	rS7PxMdrJZVmrO7TP6A5ugvDVJY+VF++t4Z8IbvQa8wRfNjRtmkoP4FgnEyMLK1f
	f1lmaSVjcD5TdJWjCrOKyscRIj8Q1c4amEpENFZc+s69yoOEfdXmK9y+96Qw/lDe
	wxZh+ASm6TGYf4lU3QjQEw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tuebmgfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 10:42:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5388s1Qk022488;
	Tue, 8 Apr 2025 10:42:45 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazlp17013062.outbound.protection.outlook.com [40.93.20.62])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45tty9twcj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 10:42:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ex9/UBaM63ZJvlFeFqGXTwiIsheWwAqobZVM7pl4lG+1hi47Dxx66IWY9tC2bNd2ClH7S7KSkbFK1pcHD49q+QVNMWVPtyjzV8n25lmi3fFmLJtZqDT8VW+2YZZ6X0SdCTV1GxCHgrtT8Em7vYmjY/SCfaUgQ1S5F5GrPoA493CF9FMOXuaz6BRjia9bdidao69TAACUcNi0oNRq31OFIBM+UpjL/OnppQe6vE6gwoCO55BPjbrNbyqLaFA+9vPxYRl8zqmHj+7rjuK0tGnWzhFJ3DJuxXkZC8o8Z9VQ9HfpB45w6wjpg04ezkiaE2Z67Lx8SiCYAPu/yyUM0900LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MVFHj2jeR3CYDsF+FSYfPKETrPlcvNbqSeNIdTwSqM=;
 b=vhLO2csYI0Bctu4gQA4fhTMghDcGhw9ZZz5nPpGSlnMNp79d0AcXQAIa/VLk1sFFKER77ZyVJ9XHLtUoRuTIXb3XXKL+junKJCCNWdVuZPC5gdsfigSY1y7lvy7MSeGlH9bAgqa/fZJi0fDxDWmyNfaaTaTSskHCAG59nJrdX4kS1bDt5AYc4P4HniZ3chs+yZIvh8qr1in9dsnbzx8RWN5XuLDSkdXke/tlKgt52kNbwBOHLN1KaxKtfMosd54aVV1/uW8NGZXK3RIl9p9it1/NsTmgY+mjzRq7YrIkiArAlBZ/VH5iQ9VxFEhjtF/1HYRcMYMPy3CQsuv/ECx/cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MVFHj2jeR3CYDsF+FSYfPKETrPlcvNbqSeNIdTwSqM=;
 b=Sa+G3vmpiquJzF5E1K/Fi04oixg7YGHfNOyPCAluIZ59YiyWJlB9BMocHvjVic7Qwhwwzu8sBRErKQpaQJoGkV4f7YPAb6u2IELIYio2f7MV780PyOdV3NdYsZyZiFzBMvozlPEXFFLdbLbeZDHhtlKZuZcBoHc+ue+jH5/Ul1g=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by CY8PR10MB6779.namprd10.prod.outlook.com (2603:10b6:930:9a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 10:42:42 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%6]) with mapi id 15.20.8606.027; Tue, 8 Apr 2025
 10:42:41 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v6 04/12] xfs: allow block allocator to take an alignment hint
Date: Tue,  8 Apr 2025 10:42:01 +0000
Message-Id: <20250408104209.1852036-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250408104209.1852036-1-john.g.garry@oracle.com>
References: <20250408104209.1852036-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0920.namprd03.prod.outlook.com
 (2603:10b6:408:107::25) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|CY8PR10MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: a4ac1df7-196a-4353-c83f-08dd768a1526
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vL9tZfCOHpPvnnqSJ+P0SLyMUty39ZEPNYIIMJ7iar+/1QxDBJIr5+cSb0BJ?=
 =?us-ascii?Q?Ubt3ODFeqx6MKZt312/0+KFmlbh8CpRlvh6vsMturqFzTHPtAM1XyBd1IZGr?=
 =?us-ascii?Q?krV8Wo8v3ZbxxfJapKg3umbq8xVQVvmJWYNdkuFcEIom8DN+OczCkSMfXpeB?=
 =?us-ascii?Q?8Dg8P6MGOJN33dXvJyro8ZZCJ3zo1WdMlEMBr7buv6IhN1Rqx4YbqDly5+Xr?=
 =?us-ascii?Q?QGsmr5l+rwVvn6FS/VZ8nWRaQBtBRRziB2f4xke66UNlMMS0ff9w4XFxe9SM?=
 =?us-ascii?Q?GENdoEPjU3en174o7fMF1cwP8YJtEk+XobmkQYMkrRAbP8EAZ/pJR7UuwvfQ?=
 =?us-ascii?Q?RADduDOdvjI0AwX7WJ80IKk/gizqihwsDmGyZ7bJ9QfR0HKxuHMFqkkuURkE?=
 =?us-ascii?Q?fFFvvDtYZoRHnAcDh+x+aJflNVAzpD7/raVggfYUuaxZLb/E4CBWxm/mLpzw?=
 =?us-ascii?Q?V2cOhKbRFIVtvPPWxm1hnsV/c2+1vZ7clF1608HhdlCemQiFYCdQXVXnxbM5?=
 =?us-ascii?Q?cRhf2UnLZ34HhDm9fXTrd/J0sLDN2LJZT1XPeBJ9UdYEcL2i3NGBveAXrJYE?=
 =?us-ascii?Q?1m0VXSFXt1Mvo1hlojosroZ2XxpsPpms7HZ8DWQlDDbt47AQOUMGwzHzGpUD?=
 =?us-ascii?Q?yNS3sMpen4WETsiSKZuFVqeThJD1rcKuVwVddqltj3uJ5PZ2JQuIPzDKi2nO?=
 =?us-ascii?Q?4W4ri8s7/ryOqU4Qq5vF6gUZNuPFDqGC3OivJNxNU2+bKkB9Jje28ZOUGoCf?=
 =?us-ascii?Q?3Zd2e8Q02QVz90tEJxrng5T8QGGk9HEibiCJEaO/ra941jYMvvW/WTi9+1L6?=
 =?us-ascii?Q?19pm7wzYCQqhvP4qu+K9FJYuhRjC2FKejFTIZuyOEznFpHsmmLKRA+GoJuMl?=
 =?us-ascii?Q?AD7BzEQSfJYxacnFYYTieVspGKDSZQM2h8M1OkJWgG6p0YNlHaU+G37hPknB?=
 =?us-ascii?Q?6hjtT99iSxgJr2sfZYNIfX52BuTuicLK3vq0jTm7sGm4Z+/2dpDhqO+PouDF?=
 =?us-ascii?Q?u8YATy7/nxtZ3cKHFVYkMgeNzS2jB6bMXNiJgvRbWZBRK9m1bH930qILWPhu?=
 =?us-ascii?Q?AIiL/DEODt1kLs1Jf3xK9rViHqmFTBBH01TJvMaXhYPs6vu/WLkrk+mFJ2C7?=
 =?us-ascii?Q?qWtg+fM9NWU7/hvACxV0eD/wMLhki4oC3KnJ5acH3maW7otEcX3GFkh7UiAc?=
 =?us-ascii?Q?hg9Ux9kxXdWNkuFSL4F610HxbpfzBBwu4Ab11m21Bo4eMDony8AFd3l/Pe3x?=
 =?us-ascii?Q?BUI54vaOPlJgsdlk4G+7bByhJEf7yRaZ7f4XBIc0yxC8a7j1qLfYt77rAJbw?=
 =?us-ascii?Q?vGYKIh74gRHSRMrLEq1gCQsjOO9DStV4rJnmyuung/Wiqh/bmNc8fvkjpGYg?=
 =?us-ascii?Q?LvkJqkI0ojqmG13D1bWFhWPl95b6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QnhfIeiFxZ+vf+81HpLPpwALrXiIBYHvSNbPWxFyk/Cm1j6OgWmQSeVbVktk?=
 =?us-ascii?Q?VnuJK0+42d5iuzNSiu12Zt6dIhSBCS7OHLWEdtqE47T8SKR4jPg53zBoEMfo?=
 =?us-ascii?Q?22Y+on8TrS2Kg+UEPq7XjUuUprL8mr52u6PH7gkTixeU+PGBCv++hynejMtv?=
 =?us-ascii?Q?YI/7W4MrGHurevtAfqlRrp0I8trXpL7oXzVsRJORO14d/TSYc6fBWxw7/x4u?=
 =?us-ascii?Q?4r4e3VFnkoA99QteGQMMGC4ai7BYorMv1xp2/mJ5p/GpJDb07+kxP1G5qb2Z?=
 =?us-ascii?Q?3EU8VWXvIrzl8hCGy9OioilkeGuETdE5tW7BPv3MXUjvV0JoIo8lw509YRtH?=
 =?us-ascii?Q?sl5O5d89lIS7NWBMRA9VFD6cUyzCw1IXDO6Bt6h7oz8KbknqGLMHM8A1jDMp?=
 =?us-ascii?Q?2JOiKSMyxMYgbJinLhaFNzULzK2MVgDfj2UZL3WNbgwxdtNMqucni39m3JLF?=
 =?us-ascii?Q?mKPpJ56fyMOPFSiAKfvLw7JlXdbfWXbb6qFab5tqu1YGxHAzWaDkAC88EGfo?=
 =?us-ascii?Q?diJaOctOa0E5ODpEmY3ZZVmg2QmvrU1TenJTVyuz5qSkZNABtH8Hlxuzstw2?=
 =?us-ascii?Q?xDmeJzebJZFBh7xpSScXv0iA2LeboXObyM4HptUU9CPHrD/2jHjkMFcMccJ9?=
 =?us-ascii?Q?pppLvfHj0Rmuazc8avn+uq/GyiP3FuAT/wWv3sgup2/ptx2Gb0oSzxOJ7TII?=
 =?us-ascii?Q?9EVA8LjnQ5hZS4d4HUjEhVu4hHdlQ2L7R1k5Bwor2ySWDOmUciVGKBUIZ2T1?=
 =?us-ascii?Q?vOUTShtYRRLGnFktj2kAJt87RZQKdl9SS3oAal9sxIOAWDxRmRKGQu3hYFHV?=
 =?us-ascii?Q?u01jGj8DpTW6DbBjrXwkoNYTg66y5N8moRLPOeLVs6jf04e66kGYTK6mtTFA?=
 =?us-ascii?Q?jefHaHe3AulmHnB4i+eqNluXb0tkeNxasGdBMc/PQ3eHCgOgVL6GLX2Ad3wL?=
 =?us-ascii?Q?uBHJt8YAgWVFZ2wBYiuy9xM3Ni4/oR9/NiAPAp7Rj83qCsTlFIAym0sZGT94?=
 =?us-ascii?Q?ESpK0ULgRahLK0/jDYKxRQylraiU25/We57M+/+nomic+ONE7OE1sVfNVigP?=
 =?us-ascii?Q?eWEHQ1B1blvpji0QaMd8uXKPQyU3rA7NRAK6h+avH2WdTBU2adyOrSlD3n+t?=
 =?us-ascii?Q?AaQllKVzmE34qfFcq2MlSdO4sY/berNclCkCJEWNP+ydrG+2crT4RGVUG3E2?=
 =?us-ascii?Q?HyEOpICd88xGGjvDVz7aE5i7KoSQcTDLVgkOSk5Qglc11AbrSAGyT43wVzEu?=
 =?us-ascii?Q?mbl48eUnhFGOS7+9919iIVWPx3keNPfdLac6WkaIU6e77kSdxZ2ldVydtqL4?=
 =?us-ascii?Q?iYHwD75a+25Yc9BGN9f6o6FsjVZYuhu0ni01jFFw2KfJiYF7969R0yqwI8xe?=
 =?us-ascii?Q?FJ8y1Di0SfK51EkHdIDFbRNB4EGJZn3ZgOUjeJzUgt5wJwh65stvWcl7YAXT?=
 =?us-ascii?Q?qML65A7VKofjF/ZuihBg5xQ/IrcKHnvG4593ooAMzkrBzvew9w45iGoB5zIV?=
 =?us-ascii?Q?8AB4EvgVExXFtNvVtrY+YsaHNee0DBIDwKkEsbgFc7i0YI4bPLNP5Eicl34+?=
 =?us-ascii?Q?6FIYRWdlWT/+qm83n4TaWkX4H6JFcH6J3Foi1S1nziDqk2fxUT4CVfQQ9RE8?=
 =?us-ascii?Q?1g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	F5RMMNJClxIjYuKPSvrBaFfNPLYoPRSE2lo+h3q9JUM0/yMg5MoBqV8see+9IxdHLEeiXGepZq9zbcQFrNmoK4BEAc1VMqn7zttjMfQo+/8nHz6TImD6f4lkkSMlxzXcAM+BZ1Ab+hMacM7U32Ak19JwUQLcdwje7s3PrPa2EBCIoNv/I0niG8bvv0CGu+M5yWTB5yTMcYEaBe5rYGR5PV0ISwN2OaDHWBaJEwXvk2L+D2yEKzNNoI1IW748MRAgA+0rQJ4UDT9WGxE+BYIL/POu1t74EsbTscFPAhU8M6Qr+W7Uq8sBKl7VDjrzIlEUgbAaC2+8Xj3AncvAPPUjH4EnrvDgNo5iscriEkmf+dRrSN9udxDopDkLptn6VU5qR4UHnWU7Bjsj+yKoep/L+Z52LZP7ufmDWAZ7jUW1MRrMaFrnUdnf+kptRjZwShE51apF5kCGgCrFKgSd3UrgBXDT5YiU/DzjtEO/y2FFRhttHUs0ka23CtZW+j5FLEb61vTiptep1qhdVqQW2bvS26MlqbjCAz5w2g+qj9iuR7++Ow5BJS9SZfanE2pWqsnjo10TWzbCKFAZ/mRcCRGYAqX/JolJVeriBU84WNwS750=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ac1df7-196a-4353-c83f-08dd768a1526
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 10:42:41.6559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cfoNzY/JgxgnLSnNhWVDLncROqzLZ2lesUnnZqhPwAWOXqEO3VKGslvA+1fDG03Qyv5EtZELZIXGRPfkbHLpqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6779
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_03,2025-04-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504080076
X-Proofpoint-GUID: kl5d8kDJYMY6EB4p1yqD_qhIR9opm2ao
X-Proofpoint-ORIG-GUID: kl5d8kDJYMY6EB4p1yqD_qhIR9opm2ao

Add a BMAPI flag to provide a hint to the block allocator to align extents
according to the extszhint.

This will be useful for atomic writes to ensure that we are not being
allocated extents which are not suitable (for atomic writes).

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_bmap.c | 5 +++++
 fs/xfs/libxfs/xfs_bmap.h | 6 +++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 63255820b58a..d954f9b8071f 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3312,6 +3312,11 @@ xfs_bmap_compute_alignments(
 		align = xfs_get_cowextsz_hint(ap->ip);
 	else if (ap->datatype & XFS_ALLOC_USERDATA)
 		align = xfs_get_extsz_hint(ap->ip);
+
+	/* Try to align start block to any minimum allocation alignment */
+	if (align > 1 && (ap->flags & XFS_BMAPI_EXTSZALIGN))
+		args->alignment = align;
+
 	if (align) {
 		if (xfs_bmap_extsize_align(mp, &ap->got, &ap->prev, align, 0,
 					ap->eof, 0, ap->conv, &ap->offset,
diff --git a/fs/xfs/libxfs/xfs_bmap.h b/fs/xfs/libxfs/xfs_bmap.h
index b4d9c6e0f3f9..d5f2729305fa 100644
--- a/fs/xfs/libxfs/xfs_bmap.h
+++ b/fs/xfs/libxfs/xfs_bmap.h
@@ -87,6 +87,9 @@ struct xfs_bmalloca {
 /* Do not update the rmap btree.  Used for reconstructing bmbt from rmapbt. */
 #define XFS_BMAPI_NORMAP	(1u << 10)
 
+/* Try to align allocations to the extent size hint */
+#define XFS_BMAPI_EXTSZALIGN	(1u << 11)
+
 #define XFS_BMAPI_FLAGS \
 	{ XFS_BMAPI_ENTIRE,	"ENTIRE" }, \
 	{ XFS_BMAPI_METADATA,	"METADATA" }, \
@@ -98,7 +101,8 @@ struct xfs_bmalloca {
 	{ XFS_BMAPI_REMAP,	"REMAP" }, \
 	{ XFS_BMAPI_COWFORK,	"COWFORK" }, \
 	{ XFS_BMAPI_NODISCARD,	"NODISCARD" }, \
-	{ XFS_BMAPI_NORMAP,	"NORMAP" }
+	{ XFS_BMAPI_NORMAP,	"NORMAP" },\
+	{ XFS_BMAPI_EXTSZALIGN,	"EXTSZALIGN" }
 
 
 static inline int xfs_bmapi_aflag(int w)
-- 
2.31.1


