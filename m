Return-Path: <linux-fsdevel+bounces-43267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C79A502FB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 16:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FA42174716
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 14:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993F624E4B4;
	Wed,  5 Mar 2025 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vc7HaZ00";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0Be1sFsP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC68248885;
	Wed,  5 Mar 2025 14:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186560; cv=fail; b=YgKyrOpf7+Wj8K2QZcxEPXhcU+eKgC0InEKoD0guSLBXLiFzPavrdPyNxEwG37sFw2v1fnLiPGJH+gAU0Vft5BrP8lsOkGop/5zGbs5e4yG95pp87BhVCfM6abrXnpw9NXYk9Tv+D/xfJjg1YUBe0728XDvkrd+DiH1cZb2X02c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186560; c=relaxed/simple;
	bh=fhp94OUypVQBFNCYhC5UOcwCRWIOQ+iHVCyy9yO8OtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YVHnx3SCc4JjnRS9xLk4YPhUUFoFD1GLRVcXcdmga1cUza8KhhaCN/g0Y9uI9GOMCDz7oS5dXwLWdLF2osnpuQVQCtTpJX7Ehd06CyHI1MOklaS659oehq+dR9GZeQM8bnCQlmy0CKLeSDluHuN+UWdjKPRadLO7lDybTlP8PBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Vc7HaZ00; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0Be1sFsP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525C3rfG030573;
	Wed, 5 Mar 2025 14:55:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=M7gGcLKH3IpOHgWB++/+rWN6P98ks4GzNL4Rn3SjFHc=; b=
	Vc7HaZ00S0KkPhc3lnoVkjcmJabXW/u1T0w7tJi6UK2RGsMzj3Au7Exxemq6CH7h
	zto+t2k5AtfzZVbScni5voJmc1oySrNPxkese1xyxqq91tbTa6viQ4ocqT/vOU3V
	JtfE87ig5W1GVD9kBDECnZlLJFV5H8bSdtH9yNEK/aLtJdtaB8oHgxO/Zu5NZJxc
	MUgizvj4TOrafAspKMkR1CnAqiakpp29CFYIytw33tUIr0qqZLTrSjdifzupmbTh
	a1gBqMUmbQDF81N3lsaMysZzilzqUW1Tbnyc1OD1g4fVy0CRCv10CTO6lMqhqxTg
	1sIjLab0krLqgdmmN35emw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4541r47nkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 14:55:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 525EOmWp003302;
	Wed, 5 Mar 2025 14:55:36 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpah3vj-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 14:55:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LwrWsGZ1SVOVg03J1vwARN4bnXd4+ClGK6FUKEVdCgig7GKc5wxox+nQVLIeBZXSEKa3BimcJ/U0cc2mmPNYDDHBQSTAjjVG7OB1UX8lyn+29ZvK/4NufkGs1HcQldoQe5afiYS5MEsR0dAJiGtEnYPMM2o9jFMsBSLN9ka35i24bf1TGt6ZSGhNR835FfE/JdpJNkbi3r58L8IXut6bBcXz+c7hmzg6TYK3fjVVEsWLHhq5MVsrAAu52cIPP+jmgryYvsbQPseWYVv1z///gIkB3gwRwvnMCYQBe6u92WGRokmPyv2jqvLqIabj6qTkTtcK/K8jjBbfig90sekuuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7gGcLKH3IpOHgWB++/+rWN6P98ks4GzNL4Rn3SjFHc=;
 b=MHZJ3nQbop7xYye0/t7JfpbpiqzMDkw+8L5k+NCEF7lTEPBfzbYNcQgVpCU666+/iHQ/qUg88xUolyTjMmWkiR8QF9gdtdDFW/AUlxpWIKblJk2Qm2GoQQ8nS5tNGzb+CYxrcv9tJZAiQ7E+BivZNZzFx0UXceU47zJGhjviD1l0HqD57c+Hrp4uWsdehxNgnIevz4a9s6GAmvzkoZ8AdFESFih4yytbcBfQGbX/dZy6/V42vKwxTOGT1satCOu7iIZBkbplDEaJ2xmc4zHECveTdgYN8PudstgQ7cVVXY5Ky1gE078wlBkfDRiskJoddi2neX9ZaapIM/QamyWJwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7gGcLKH3IpOHgWB++/+rWN6P98ks4GzNL4Rn3SjFHc=;
 b=0Be1sFsP731mU5hl5ulVHjSyItVw9EIiLM1CHeIoxR3ep61JOtOamj363NhLI/a9mFzfHddIJZgwZdF4Qp2SOGNQrGbFs6U0oRpXOkm8mmPjJCiwzafhQbCE6g4vIcuhHTXBZ+UcABw5/d5PCuqgXyG4ZfrB36zngywZj/fES5U=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by SN7PR10MB6547.namprd10.prod.outlook.com (2603:10b6:806:2aa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 14:55:28 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 14:55:28 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        selinux@vger.kernel.org
Subject: [RFC PATCH 2/2] mm/madvise: utilise anon_vma unfaulted flag on guard region install
Date: Wed,  5 Mar 2025 14:55:08 +0000
Message-ID: <e954a5eae62d701771878572717c9872928cd929.1741185865.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741185865.git.lorenzo.stoakes@oracle.com>
References: <cover.1741185865.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0124.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::21) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|SN7PR10MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: ba0638b5-ec67-4dab-31b3-08dd5bf5c476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JrhqecSOGgFOtlDVVUPe9gGxjW9i9mONaepxnTN53cPEQxtj0gT2Hi7xhfQK?=
 =?us-ascii?Q?OoW1PZCQqe3+013xGZcooNWj7n+LqLE4P4JRj+ZOuo3Y3sj6fkEsDHtN5ov+?=
 =?us-ascii?Q?c221L8VIK9cloZ6gXpd29iYzTWpDhmBWJK0XUSrXvJHt9H+n/U/gPQdFYlIl?=
 =?us-ascii?Q?7fmM38bQnFYm3gVvYw7ydK3KMAOIZnq42zURdbwFZZqlnFZ7WTMUhyzZf8Y7?=
 =?us-ascii?Q?z0oeTaviZRTacC8EBuRol66nHwppxH4JE0dPRNvO1qOLzEZVCzuYFOEbA4Ol?=
 =?us-ascii?Q?E3UPtE0sr5NmjflO/v7YpjlyLRfznOM7uxZ1JJrR7sP4Svqv+XRnWEP3RRmp?=
 =?us-ascii?Q?0w0BgQHJX0x6wCBK3Xa7wuv1XC6r5455cWY+IOcyH15+E1PkC4kpP+Hy8Wy8?=
 =?us-ascii?Q?zAkmLRwP2sfCB3io4y7gz4CGi5u4NEPSugMVLesoREtIpXkNa+57DlPmgcCK?=
 =?us-ascii?Q?xv5S8xT8U85UuJ6XFGNTjuu8AyhXfn84+FkVwZ/40EvSzP0AGsJHDNqjSVoG?=
 =?us-ascii?Q?+Ur4AruhhCPhjykODG8VyR7WmPZf14/+/rwzuxos8a6qbqPJP6cZUCbgn5Qa?=
 =?us-ascii?Q?pQ9wa+Cm+nsKB65z4Mpjw105GKNsnABiXhc/m6TGQUuc4p4Jb0CkthqzGleb?=
 =?us-ascii?Q?0Ev5MstAq1OFaIHlEm+TlriwB52HnlyhOS+30uFDpA/xD/1X/NhwL8L6AUSP?=
 =?us-ascii?Q?hWk+m8/0NIlLY9kZZ5PWXUkhFrPcGOWYm4PGJ+Cjl3ghp6ry4CQp23JthY6T?=
 =?us-ascii?Q?WzYy9EjfhAPwgoTVAq3dUQQTn9eVQaMNmD62ZPJAtdSiWSNJANWYVNOdzFLi?=
 =?us-ascii?Q?FL6rVw8vGfpKPwKHSfv7gM9RJWIeNn/J9EJeB9n7GjOJyqntvROB2OekM1N3?=
 =?us-ascii?Q?lmk4bRdn8AKM8o6fg8aSB4/bbXQc4RCeNj7wcr8yjykT89b1dESbFlhZSGsI?=
 =?us-ascii?Q?lGdNneCY9+wu/HgCAvGT828WBLPeAeAgtCaKH+QvraPgNkZCGNZUL21hKkij?=
 =?us-ascii?Q?JykvG7yaNDJVmdDUz9I6fv+GTgqkaAiaAvLiczzgpNh5jLCXMXj2/aeARINr?=
 =?us-ascii?Q?gzTloTbIQYFspwwqVUl46wFbPsQAMxeqIU4EuViyguxDzPNIgh6+eBHsQsLq?=
 =?us-ascii?Q?Pc7nydw0S5kGO6Z8NVSvkmRy4/0kFv+X0J5YGs49UGUvnAkd9XPfoiaIfCJN?=
 =?us-ascii?Q?meTgs60FpWk2BsNG0HenCue8gA6cS/BGzMevEyqg6Z8h/5G/YWHQ81ctxgT4?=
 =?us-ascii?Q?hfqqvnqfjPCJIpj9HbVezLzpDsABa3/h/yRFnWZNOOfbCgM0sgdW8yEYCBJR?=
 =?us-ascii?Q?vp+Bh9WNAshBUvdp/t7NDzcoZAxftvMAxWAb3j/xrgoSSUXR9jT/EkpdCku+?=
 =?us-ascii?Q?s2WjTBCsJ3Y3WlMRzEN+YZB5x0Ri?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZiOblB5MSfVM4S27/B/BWcUduDmhkNJwakCb4p5G7Cuh+lyYJ0Byb4LTinPU?=
 =?us-ascii?Q?Gqef/Cqb25wXSzFytPd8nkh5MtEM+uKfbYNm6yGigNl2NdJ1Cv+SGZaDzn7w?=
 =?us-ascii?Q?Y+RlqcuRoRVGL8EkSlAZmq9Cyt6zPeYMZKiYf7lbSgT9F8BGcncOUs5xu/SM?=
 =?us-ascii?Q?xlQGBgRK9eAT7H7RnofvbkCEuFtECA7h4XALZsxYD37DcP30D7DV+a8fFwN7?=
 =?us-ascii?Q?ZsVVYDPTGck1c+5V9oisC3WNlRedE0Q6B28PhUqUV3r3t43obxD/EgDHbo4B?=
 =?us-ascii?Q?6e9Z2XMT0Bpc3r1+7AyXAkxZrB2yXKi9YitTxsRPxPBo0Bd1/vqZkrHJ17Im?=
 =?us-ascii?Q?eGApnFpo+N8Yi1aXWWKKULmvk3MzSmyLXHTefersrhkT3Zkv7qFXPc0dh7di?=
 =?us-ascii?Q?g3V1aBtfaUa9aWa7Eib3/E3d5iSoLzofGFvpeFFNdyU4n0b3tcchTIM1QgQi?=
 =?us-ascii?Q?gLjJEjrzBm02G8bJJSyGUsI4jYomN3vKXU77+8M+fZR99AQ+ewJGtzJdm2D5?=
 =?us-ascii?Q?KDyLNx27DSw9/8sxCljnJkeEArFviT1VAZbuC+qUWlJFIKpCxDUu53UsdVIa?=
 =?us-ascii?Q?G2JN1zDB+NSBGbbpOR0MPEJAiQVHmCeZ/KdraxEaLQaIQVVSqy/H0hXnnHXo?=
 =?us-ascii?Q?7ruUutX45pE3KNoGweNm4UfoxbWi6fe4QBG4gXYGa5J7AH0+VDzNvPp+EkNI?=
 =?us-ascii?Q?TyP+2YlVHoGsR1mjKMKHUjNMysjObnIC7GrKXzej/O6gB/Pg75BWWIRJmB6X?=
 =?us-ascii?Q?hDmyWlm1zQT2DCjWHQ150pjTDBLnRvdcO9y0G2JNZrCfJoee4PijjPXJnRhw?=
 =?us-ascii?Q?3hGVPsclnKJPmFVFv3FdNw1V1bmmnoW43NEM7fObg2mxijzxOT21MRSB4PEN?=
 =?us-ascii?Q?zF5JoSBDQK5se6HlFnrC2U+vCaNm83qCMWcAqGDrKl2A7Zc0IUVBp6LdKFRR?=
 =?us-ascii?Q?o1fYNxTmktufGoaYPZBqc54KeSxMMGadbHcsLiIjxn49BfJOpPUBuw0EXfA0?=
 =?us-ascii?Q?pKu7nuw1zBdGeBDAxU1Fgl6l38g0YuxWP2JL3wb8C1q7C4dnMZaAEZE3XNol?=
 =?us-ascii?Q?PdaNCMYfiLoys1BXxARpJ2a3+OikfrCM7wdMe1FniKnT4T4kZz1x+A4a2SGU?=
 =?us-ascii?Q?A3wZpwNesBWwfiHWjUgpJgmY2umPuwTJjciUrAJecWsyjRk17a/s2G+O65uY?=
 =?us-ascii?Q?aZsP+1s0wsjNj2B2jy1hu0BrNRFL/GhCthrg2PTAlFLCzy66aQ60PuENB7po?=
 =?us-ascii?Q?6dRHoq4Q840G+TyTFxgZUbOArbrnX3bvYLoSIBnhFXdi6xQlVZpnGSihvSiT?=
 =?us-ascii?Q?mv5y01Ulhx2KrHGvdgeDkf3+/2aOmTxgF82xR2N2ykDZA5pmbUgTlpOTJ0NE?=
 =?us-ascii?Q?aLigVazr7Ih1r18SC5w1l0mA67Yd3jgvY/U/DxWUX88gxWerqvtt4NMpiwUs?=
 =?us-ascii?Q?ccSyJ+70bPixAA+LDuK4zN6h/JrwnTdw1TUDfE/EA+13U/AIRsrR/EC1grMq?=
 =?us-ascii?Q?FHwpkRGVdx1dMQD+Ha1Jkb6/KePgi2f2BaYYm4sI5jX4AzGD1YRf8Ufzd0JI?=
 =?us-ascii?Q?HTUFK0Nwk01Jv4csJbzRjrDKoDGSinuSlNECO7RikdH5j0hLwhRGDws1+GyB?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JPuhOsQtJqBg37vVapB8hZyWXBTKqRHSuBM0qzrmBUqagkva2hZx4/+LSWPYfweD6oMUuhgW3FZ3+9e97oGkghkQsilh1YJm53hbgMrrrP9QXjRtxw5yJAhNmNuU9TXaIF2CdWc9NaIRAGZ2zgjIlJqWpnbjRVoEpMGww3EMR+yRzMu48V0tMiY3Fjd+ZU4UaYPwbHNEjvy1gRjwNCMENxvOPwhixhU+8crd3kfvI/ogMRWJo6qIRTUEo9oLUlFe3BxqHj6T7uZDMVpgAGyBWnDdDLeCHdySDLRtgIPh0D9i1ZL3emEzkd/dwmgrhoqQY+nJ5kdkdI6paEhC91BUlBVPWRW9qF1hYrI+onQAJev17OCU1aGyT28bu51vAJgVDcjlX+U5hmk3sRPHOOn2lYxQsWrI6LLxlPhbcK+zLmx5R9wPPl7B3p0ZSWE+PDBFf+LWxpJXSE6+3XIi+6ku435NclkQcEVxl1vZBhbsKIlegTVtb7HHQ4cO0srXXxtyT10PLw4fcSiLoPRsImIdYL1rSiaF+GNYjF4tDU/7Kh5iGHw283Xw8uKGPtm6LtArrjJQl10jxUDUb5XpZYwioTkhy4hwI5P+PEDPYdPs8XQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0638b5-ec67-4dab-31b3-08dd5bf5c476
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 14:55:27.9200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1y3s5pbO4eRnPLFaz54yVz6Gg8Enja5ZNhQYxYlCaquXnym1GPVrG78e8kXQq6Wk4vC3g2T/jbTqsL9u9mZkqvuqtXubt3GiA9q0k+Ac8Kw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6547
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_06,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503050116
X-Proofpoint-ORIG-GUID: KbWiCS-_UknY8dHyaZ6WJTzjsB9w9AHD
X-Proofpoint-GUID: KbWiCS-_UknY8dHyaZ6WJTzjsB9w9AHD

We have introduced the ability to indicate that a VMA's anon_vma field is
'unfaulted', that is that we have a desire for there to be propagation of
page tables on fork, but no anon_vma is yet initialised.

Utilise that on guard region installation (via MADV_GUARD_INSTALL) to
ensure that page table propagation on fork occurs, but without occupying
one byte of memory more than is required.

Note that this is a no-op if a 'real' anon_vma is already in place.

This also avoids any issue with THP inferring that it should not
immediately attempt huge page collapse.

More importantly, for file-backed mappings, this avoids otherwise
unnecessary kernel memory allocation purely for the purposes of indicating
on-fork page table propagation requirements.

We adjust when we do this, so we do it only after a successful guard region
installation and one which installs a guard region of at least one page in
size.

This means we only set this once guard regions are definitely installed. We
are safe from a fork racing here, because we hold the mmap read lock, and
the fork requires a write lock.

We also adjust MADV_GUARD_REMOVE to remove this flag if the range specified
spans the entire VMA (and no 'real' anon_vma has been installed yet),
meaning we do not cause unnecessary page table propagation.

This is protected from racing with guard region installation through use of
the mm->page_table_lock, which is being used to prevent races between mmap
read-locked modifiers of vma->anon_vma.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/madvise.c | 49 +++++++++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 388dc289b5d1..0e2ae32f057b 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1119,24 +1119,14 @@ static long madvise_guard_install(struct vm_area_struct *vma,
 				 struct vm_area_struct **prev,
 				 unsigned long start, unsigned long end)
 {
-	long err;
+	long err = 0;
+	unsigned long nr_pages;
 	int i;
 
 	*prev = vma;
 	if (!is_valid_guard_vma(vma, /* allow_locked = */false))
 		return -EINVAL;
 
-	/*
-	 * If we install guard markers, then the range is no longer
-	 * empty from a page table perspective and therefore it's
-	 * appropriate to have an anon_vma.
-	 *
-	 * This ensures that on fork, we copy page tables correctly.
-	 */
-	err = anon_vma_prepare(vma);
-	if (err)
-		return err;
-
 	/*
 	 * Optimistically try to install the guard marker pages first. If any
 	 * non-guard pages are encountered, give up and zap the range before
@@ -1150,19 +1140,20 @@ static long madvise_guard_install(struct vm_area_struct *vma,
 	 * with no zap or looping.
 	 */
 	for (i = 0; i < MAX_MADVISE_GUARD_RETRIES; i++) {
-		unsigned long nr_pages = 0;
+		/* We count existing guard region pages each retry also. */
+		nr_pages = 0;
 
 		/* Returns < 0 on error, == 0 if success, > 0 if zap needed. */
 		err = walk_page_range_mm(vma->vm_mm, start, end,
 					 &guard_install_walk_ops, &nr_pages);
 		if (err < 0)
-			return err;
+			break;
 
 		if (err == 0) {
 			unsigned long nr_expected_pages = PHYS_PFN(end - start);
 
 			VM_WARN_ON(nr_pages != nr_expected_pages);
-			return 0;
+			break;
 		}
 
 		/*
@@ -1172,12 +1163,19 @@ static long madvise_guard_install(struct vm_area_struct *vma,
 		zap_page_range_single(vma, start, end - start, NULL);
 	}
 
+	/* Ensure that page tables are propagated on fork. */
+	if (nr_pages > 0)
+		vma_set_anon_vma_unfaulted(vma);
+
 	/*
 	 * We were unable to install the guard pages due to being raced by page
 	 * faults. This should not happen ordinarily. We return to userspace and
 	 * immediately retry, relieving lock contention.
 	 */
-	return restart_syscall();
+	if (err > 0)
+		return restart_syscall();
+
+	return err;
 }
 
 static int guard_remove_pud_entry(pud_t *pud, unsigned long addr,
@@ -1229,6 +1227,8 @@ static long madvise_guard_remove(struct vm_area_struct *vma,
 				 struct vm_area_struct **prev,
 				 unsigned long start, unsigned long end)
 {
+	long err;
+
 	*prev = vma;
 	/*
 	 * We're ok with removing guards in mlock()'d ranges, as this is a
@@ -1237,8 +1237,21 @@ static long madvise_guard_remove(struct vm_area_struct *vma,
 	if (!is_valid_guard_vma(vma, /* allow_locked = */true))
 		return -EINVAL;
 
-	return walk_page_range(vma->vm_mm, start, end,
-			       &guard_remove_walk_ops, NULL);
+	err = walk_page_range(vma->vm_mm, start, end,
+			      &guard_remove_walk_ops, NULL);
+
+	/*
+	 * If we have successfully cleared the guard flags, and we span the
+	 * whole VMA, clear the unfaulted state so this VMA doesn't
+	 * unnecessarily propagate page tables.
+	 *
+	 * The operation is protected via mm->page_table_lock avoiding races
+	 * with a guard install operation.
+	 */
+	if (!err && start == vma->vm_start && end == vma->vm_end)
+		vma_clear_anon_vma_unfaulted(vma);
+
+	return err;
 }
 
 /*
-- 
2.48.1


