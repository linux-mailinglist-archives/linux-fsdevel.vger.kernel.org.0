Return-Path: <linux-fsdevel+bounces-57725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC507B24C19
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 16:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95FEE6207F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 14:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741612F4A03;
	Wed, 13 Aug 2025 14:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rdKtjD6/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SjRFYvte"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1F71C3F0C;
	Wed, 13 Aug 2025 14:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755095582; cv=fail; b=a95ofMukoZLKiEeR5ytlFmwqyVqA9hNZM/aoIyF4BYRzqY1XREMBuF6WOywrMiCmlu/carR1HFIg0h3A0260MirhJP3YTvtsF6fuRr10CtABkmIBVR2t0PlSJU2REvXhA5HpiJX2DLHnrqqWeDWzJLI0Tbkx/iucFWM4B8LFYwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755095582; c=relaxed/simple;
	bh=wFHvegz5MhWBLXDDFINXgHEelu+RDlcW7aJM3pkvmvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MzBvOAl7DlyvGQsrH5CeAbc2+uw9yqj96XtQCABuBdqglS0zr9Rfae55I/7tYn9+zpI6wGa6kbAfN0rvOUVDEM4ckaY9tJKRvBPqdg9gSG68selwhGR+KLAWrFEa87eTXpPwRcPx2piOsdEWy8888B7dTuRjJ4B3myo6OsHiaYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rdKtjD6/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SjRFYvte; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DDNBMD012742;
	Wed, 13 Aug 2025 14:32:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=eYcmh/bUXqSUspPnyn
	DoRltVoIv/OZ0CqYbg10P8sb0=; b=rdKtjD6/LLzj5faf7g2clE2st06oGOkymu
	Lj5aA9ba17WLN/TdWtl4zDWFcDZe7PpJwCVdLaGb7tRpVTHkvuBvHWLkjQIEmD/f
	HQUy65UPdvFlIWRVILWP7Bw7tl970jqlaFh2brhiZ2grMpovIEs7rUd65EtRavz+
	R9DOXqyBWsszYIchDDG/NtB/Xg/B6YfsnL+RM0n9xX3WQmFeQFg6coC1L3ROq9SR
	380fjphUy3ftmFL9HorkoaMNy6lqI1hzqHs8Nf4JOsVQT67WaGPOvYm7abt2oCLf
	LZJ2Vq8eV+iowKMukXYU8mjItp7bybKMXlnMrO9ixujamlf8CkTQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48guch86x6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 14:32:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57DE1tth009876;
	Wed, 13 Aug 2025 14:32:04 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvshsw1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 14:32:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BPFpBJtfsg9h05k+AeNqw07Z1RdK4fQM5KSYSgpxt5whlBlzKiE9+WldVNvCrvha1YUg+S7jzFd8pX9s4ZwxNUlbRlnFzT4QoJ3U10KsaOvCS84unpeTwt2k1wokq46I2954RJmo5UBOf6lWG0HonikQjM/pfrXM0fS37+BbAqdogwWOtwrdoDJ2FF8SdMLoovCvUj0jf/sfwDmRl+rD2gLBFrcN3OKfN4LbOAoP8Qq8ShYtKh9NOdoB/FWBqvI6xRoD+NzFwoPog6akLmityIsgtQpNl0e7hiymqdHdkvWdHNum+eQdTmi8gGH5XdQLTtEQ7pjtT2CIt+Zg9l9BIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYcmh/bUXqSUspPnynDoRltVoIv/OZ0CqYbg10P8sb0=;
 b=ezTTi+tP9aL0gHnRWIr6dPa0NU6lKNzXPDUS428e1ESkXytfRiu8EPkzH/8DlMhjbIBBSi7lBIZV7uM/oMWTpcW/xW0wpzz6fYJQ26zyWSUf9WdXZZJEZ/evwLrJh93oq1YN2vFdDWvTRkGpijiVzYCYGsy7G7zgokGQ78FcO13QQDEzuraUVGonU9Vmz23N8DfKUg9aXkiTVVIcZYXZA8OmcDPNb3Nrkx5GY2SdvHlr3o8k0lrT8E8fOeqn4DUyRhOHY5AD2vRIPFDLu2kEPq7p3qpLNHIwGulsIsJfvR+rD60tUyEOR85QV1JX1cR2ceBJxuJhLsi/qflgT2vBoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYcmh/bUXqSUspPnynDoRltVoIv/OZ0CqYbg10P8sb0=;
 b=SjRFYvteKsWnSvtLbkovaFg6JEOS8PqntnHZIfkjZcdxJ5HfmBggyo35h1PskylFSNHb+sHqFw5ZKK179oS6znVYoHAeycWSui1wAxR0ReQK0P2JTJBeYhQJa+iN3RXYMg27lhm9V0w45Xu1mHZoMEE+mlIZtP6XgdC+YlSTyEM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PPF9390CCBA1.namprd10.prod.outlook.com (2603:10b6:f:fc00::d33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Wed, 13 Aug
 2025 14:31:56 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 14:31:56 +0000
Date: Wed, 13 Aug 2025 15:31:53 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, corbet@lwn.net,
        rppt@kernel.org, surenb@google.com, mhocko@suse.com,
        hannes@cmpxchg.org, baohua@kernel.org, shakeel.butt@linux.dev,
        riel@surriel.com, ziy@nvidia.com, laoar.shao@gmail.com,
        dev.jain@arm.com, baolin.wang@linux.alibaba.com, npache@redhat.com,
        Liam.Howlett@oracle.com, ryan.roberts@arm.com, vbabka@suse.cz,
        jannh@google.com, Arnd Bergmann <arnd@arndb.de>, sj@kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH v4 5/7] selftest/mm: Extract sz2ord function into
 vm_util.h
Message-ID: <dd423a91-f9ef-4718-9452-fa85a60f1331@lucifer.local>
References: <20250813135642.1986480-1-usamaarif642@gmail.com>
 <20250813135642.1986480-6-usamaarif642@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813135642.1986480-6-usamaarif642@gmail.com>
X-ClientProxiedBy: LO2P123CA0010.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::22) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PPF9390CCBA1:EE_
X-MS-Office365-Filtering-Correlation-Id: b5633fdd-40e2-4bc4-434f-08ddda7627de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KJ0T+8g99j0KMKzDbpXaWMZYPnj+oqpaLmoanL69c4gABb/nhmFNidgWziJt?=
 =?us-ascii?Q?tVzacGSvd9mempiLj7L2SvflqDPgG5lyCXNwemxQ23/KGSP2bdXkWgJ9vSYZ?=
 =?us-ascii?Q?uXbUmfSdgeMGNa6iYR4dpTN40YKNmIPF7gNPwMansjlsnxwcmxzoqMaY1H0j?=
 =?us-ascii?Q?BiH2Cu3u0Ji2IAFcaI7uRpjycmjtsmsTq/bp+r2dSL8JKR4yM4vLg+t/i2vt?=
 =?us-ascii?Q?hp9i8tSfTrQYxOjK/lAUFWpkrGX0kzGqUKgqlbB8Qz5oXMm5wVZ8+p+22wv2?=
 =?us-ascii?Q?VoX+hUuDbSXsLXzZjV39QqT4s0lwLp4pPvHrQpJnlVepdREDow+Ham1Xo3LJ?=
 =?us-ascii?Q?rDOlcE0ZIpWz9OofXJV46O2jmRBe0bCiXXHqFLIttKon0hgpUcHLbZH7Ahpg?=
 =?us-ascii?Q?u7l6i7tyZGgsqroZrdUiu7CN4uvJTMCi/zLPscNM2fyOdDpKYXFQuxjHn7fV?=
 =?us-ascii?Q?3KW/Kag4ws0ePbU2X1sajylYagJHQcnUjDFMErO5htTyF2bFbRCbuNdkqJrX?=
 =?us-ascii?Q?RFbU3RRHmYyYO5mVVUtCfhERZhyVWfn2vCRsMsmyOGnxjimvFww4IsoZ0oaC?=
 =?us-ascii?Q?BWHKejpNrGH+CiWBUCI4UV3Seilf9kVKnPOKc51aVW/DpOvryYhUc/7kwyN6?=
 =?us-ascii?Q?fG9GJ5tX2JAK1L3PkgVbuz3H0bb5dFvkisRAknXv4AZRPddYClM+zMZVp/bb?=
 =?us-ascii?Q?cQ7Pz72bKqZk7RnmPap44KwMOhR/o8XM7UsJBXi/59ai9ZWXRjV55A703ZGg?=
 =?us-ascii?Q?uGlRjR6EAH7Ra+uZS3Q6ao1DwlVq93oZ3HW0RRoh4d7gZLv23xWuvDRMg01q?=
 =?us-ascii?Q?F5751JYEP2zjaZwGoR5Go6l6osEf1Xr5s0iSPuQYvz5Z4dGz0UmGANqShxKA?=
 =?us-ascii?Q?k+l9QRVq+mTYujKkObeOcc9zXGELM3zErDYYlzbf629EEjl18a4voC3FtVQx?=
 =?us-ascii?Q?9gtiE2pcctovg5p9JYiaxIXtJ5kXW7taQ9PiJ4lzga/orDjYIje7KpD5codJ?=
 =?us-ascii?Q?g3G+FwwXhd7V+AN1NaefyM/qt+oVRIAEmkQMIchFdaK9hvgFsR2TeOdPMAZN?=
 =?us-ascii?Q?xPkRPx3T67LfBIXvLhOD/UatSmWtvPq8WGtsyOJ9oUQIXEx+vtJbU0CT0Rf7?=
 =?us-ascii?Q?KTE0754yu4EtkpGEPQT06dixWU2sJ58oeJIXnmZ0eYtAGMINlrN7FJif83aH?=
 =?us-ascii?Q?nUFZ7h/nHbwZXqnFN/OfZNQLgM3iBoON/SnoKVRnFx4njbHRM2pyytG3wU29?=
 =?us-ascii?Q?rNMwPCoMvkS0wJuyP0NUOgCEyrqMgq/X8nKf/uq/6iwSuEaOlpHLgJ4J9uLg?=
 =?us-ascii?Q?xmZtpshi8DcXvJljm4wO/TMPzZaqoZO1qXC1EDzkYWlhQ11zi/aU5us0QUL/?=
 =?us-ascii?Q?M4pTJEDPqwAxnUzqHeEmuqYLmxxVy1EoztLMMIld1ujgZYMZzVki09Z8jRtL?=
 =?us-ascii?Q?XmVCwORaqxY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V5yaNs0aafC+80LL5CQ2MTjxYJIkZXzg2j4cB7bF4ZdPTAAwAI4tpByoVz9/?=
 =?us-ascii?Q?4oVn3FZIBdZFItVdbBioLk3Q1fmDriYafpQsui18Nx5+R7hCzYV6WLk5AQBV?=
 =?us-ascii?Q?sgOOj5qjp8I0exfI8IhIzQksNbf69Y9W6bJ8RG5HRfdlgEZ5pNdSbFYgypqS?=
 =?us-ascii?Q?h9QjaWl646wKzg0bnUVhBsJpmyQCAJMYmcggqsv3CN4tP1rfbxyLfSSSMP6J?=
 =?us-ascii?Q?pzXiQ9G3bdkd1Ma0/rS6gDO1XWmVqF4r4HOnmnBEKKlphDYNAUePs1eH8S0T?=
 =?us-ascii?Q?e3sR2uv/fky/YjFJQxtGMtNtCup+nRYfoKCHLHXyzgH6BwI0v0SoVU/iYPXW?=
 =?us-ascii?Q?2CeScSpvTk33SuF72c6kOLWkfmxWkNTgeRiBDG2ldC2uEy4hsvg3zqgLs9Xv?=
 =?us-ascii?Q?4yPQDH/6uS8h4a+XsZbl5sJ8pJo0ng8feaoCbUJnlO00iwIQL/45rniez/FG?=
 =?us-ascii?Q?qcml9fwHLsPfQ7+5YWH61qEi3H8QGPbua62YuERGS7HX9iAAGBlDUKD9scjc?=
 =?us-ascii?Q?XBFte9AbsCrWioddOOL13eAalSarV3oj1Qmqu0foPmoJLT5EpDJ0IwqYeEys?=
 =?us-ascii?Q?w/uQGQ1qQ8zDN1PB6eQfoaL7JmacRaCyeRpyTLu56WM3j9DEGXM458rq7Yqp?=
 =?us-ascii?Q?biLM9lPcU6NgnyvrHuSgClSosqkzcAITOyUMQ5RobIHpcljRCoX3mXff4Luj?=
 =?us-ascii?Q?r9LsUJKqtJA6HX2xgvIjLuF8IFMfUXYj0iNpPisGm/uULC5Pf68oz61G9Gxq?=
 =?us-ascii?Q?VRS4J5pMop0lwlZSpyhLT1cdXCLTRLjLlyo70/IpuKN0ZzOwnvqGP+C0sgu/?=
 =?us-ascii?Q?FjrKprgNKxjdK4JkQxHx7t7IBrrdPG9ME65AV8/UKPRJSqDkmUPy7Re/aOeH?=
 =?us-ascii?Q?QtPDTBg1STpPkDln+2CB9iH7/DDlvM2MVIqZAia166W8DIrQqC7gEkWPJTpA?=
 =?us-ascii?Q?Eo0420IJHzAvvEZ8LmeOuObQe+Jxh47GLhPAQy+A+RktfoOvQ2fQ4XvcK3Hi?=
 =?us-ascii?Q?3Sth2rUld6AnZNz19Yxdvot0m7rB90l9oJYlEWsg9tWgOTsUjsoV8Jq5qs+C?=
 =?us-ascii?Q?yaj1Jm4tyuxK4uYoEG1yO6PGIHNFp+OQzl05kcCK2Ncd8nngnZPD46hPfq8B?=
 =?us-ascii?Q?H0z9rS5Il1j2johDEn5O7lCcFXQf/BMj3NW5emuup5luMMj2FXHMN58qLklc?=
 =?us-ascii?Q?noW2b1hlonIcAW9I/ndhh6g0Jowu0e20H1nTlZ73rRhC+UUHXkxP4YTvXuEZ?=
 =?us-ascii?Q?oTlcIbvdciuFAsGH/WJeGIrUbaLQ3XpAjsXKVDx62UcTbnRiU5Vx/p2U08CF?=
 =?us-ascii?Q?uOqky2PQul7pQr6ORhCQl3coFxlrLSIK0pPDbCJToXi2lI7vrZJtr/0/xPZr?=
 =?us-ascii?Q?j91AzYWKNG7i1Y391h5gB8Xr5V4Z+zTwI5JeuGeDI8iBbeCgxwjHhNkvij9M?=
 =?us-ascii?Q?UnSnkWWpxXaqwqzyRzZI6HBGzTBBwbnNVcGsbAdXzH7G7X2kiycAuAj2Z2eX?=
 =?us-ascii?Q?aCQ2pBa6pRjmz8ZSlmfVbN+nT+0S+mcGMmUPLwzYDlrifwIWG1RTQ7pOUhx5?=
 =?us-ascii?Q?LRHUbGnlTl6jTFlWXsNDEFd2X0pwRqYeg0LtNo7BVUVxZflRrOY5dwFKWV3x?=
 =?us-ascii?Q?bg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PaJanp+XHD/XB9go169Xj7Yqu+q3SUZCVy661yK6bBkhoJM3Y5fxgH3oYcJFj9wDyNnd6KoW0cNUKMRb3zCb3dh/J2k0brbuq0+OVXVikJIz4XGhPgBEUI5w8PApemOkb3zCCc5qtE/7Gvkzm/BGDT3bhS3U8tjOqGnB5t3ELxp3q8rfP58/KmjZOIau22bUAFfc6i8vVCdPzNc83rRGB1qblsWpO/wmbGWwE6FhAIHWTda56/6JbeL8bycxVvHchX4lk+AtVX4crJ/1D5LKebvcMQF497uwarH183DzhYJOVVUT2ezLMouJ1SZ5dQyX4Ix9diawwYdeyrBh5A3h4Km9uAe06FH9iEOD8gso79JcnO3CZK5NYCw4/aA5mkf6lFHtfahqgIXvKZxomS5ryFuTijcPLdFkT88IUbPbnunHacfnADOo6cKAA16R7kdw4fRruqtBAHmGNuCnqqvPLvauuciY664zLoD2+DzD5ugKUfr8xoCwIBg6rGUuVwkL2b/kIl4bknySy7TTySOq0d4zy4pUY9IlGsYu0KzVrwY4/Zovom1GZXi90PlHCX34Pl1Ln8Uil72M+yjP9MfrdRXTuxeQ19VVkn38bW5l8n8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5633fdd-40e2-4bc4-434f-08ddda7627de
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 14:31:56.6960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +T+bo6+Bx7X0Q5oqqUgMPD77RVw9dTMuJldNrmgFgy9Fg7r5NnhGJTDNP3hKOTV5XdjRvgvJN7R21tN/lZiAGSEfkVJF7yTn2KRdW4F5jQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF9390CCBA1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508130136
X-Authority-Analysis: v=2.4 cv=Eo/SrTcA c=1 sm=1 tr=0 ts=689ca1e5 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8
 a=yPCof4ZbAAAA:8 a=6GJZ3Q2gbqgNMuSkLUUA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12069
X-Proofpoint-ORIG-GUID: JZFlh5cm8K0yMwG2clnlF8QZCXMKayFK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDEzNyBTYWx0ZWRfX6srYAmlqhXlg
 7M7qVEObi5hISvCanwRSa1lOtWUVzlqA7jagYNNUqDDljtX92VEeUYxHdPasQig1dtcp2hbjF2H
 VbNfuQKQi3+RLEc7362dlxNZyX2HctG5wzHTkWBYDDOX43wWyC9W+VJa8yvYEX8QJJzy0Czoy0n
 ObUEL87PkPwOkJYp2YFwpSnmAtVQbXH9H9wy3+ERayrJg7+JYJZx9u6Vhw7sL8/yNh0wGfYMvUQ
 0k+zdtdlEG3xQx38Xgjtsd4f1d0fhGYIgSEznNlCcXfxavVhiNflKz/0YivMabdue1hO3JMOQ5Y
 oCSbrGczMBsEHKlAWyNAYERTH3IISrM/XejIRYyDhtJFDVjRjTAANivIWyyTkKjSO8ZgzijkWTE
 iNsfWzViNy1Ic7XNLWOtUYVvOlZ6lv0On9FxkDsva1n6L88fTWmVPn0lHftXdFCi+YZ1/mq6
X-Proofpoint-GUID: JZFlh5cm8K0yMwG2clnlF8QZCXMKayFK

On Wed, Aug 13, 2025 at 02:55:40PM +0100, Usama Arif wrote:
> The function already has 2 uses and will have a 3rd one
> in prctl selftests. The pagesize argument is added into
> the function, as it's not a global variable anymore.
> No functional change intended with this patch.
>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  tools/testing/selftests/mm/cow.c            | 12 ++++--------
>  tools/testing/selftests/mm/uffd-wp-mremap.c |  9 ++-------
>  tools/testing/selftests/mm/vm_util.h        |  5 +++++
>  3 files changed, 11 insertions(+), 15 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
> index 90ee5779662f3..a568fe629b094 100644
> --- a/tools/testing/selftests/mm/cow.c
> +++ b/tools/testing/selftests/mm/cow.c
> @@ -41,10 +41,6 @@ static size_t hugetlbsizes[10];
>  static int gup_fd;
>  static bool has_huge_zeropage;
>
> -static int sz2ord(size_t size)
> -{
> -	return __builtin_ctzll(size / pagesize);
> -}
>
>  static int detect_thp_sizes(size_t sizes[], int max)
>  {
> @@ -57,7 +53,7 @@ static int detect_thp_sizes(size_t sizes[], int max)
>  	if (!pmdsize)
>  		return 0;
>
> -	orders = 1UL << sz2ord(pmdsize);
> +	orders = 1UL << sz2ord(pmdsize, pagesize);
>  	orders |= thp_supported_orders();
>
>  	for (i = 0; orders && count < max; i++) {
> @@ -1216,8 +1212,8 @@ static void run_anon_test_case(struct test_case const *test_case)
>  		size_t size = thpsizes[i];
>  		struct thp_settings settings = *thp_current_settings();
>
> -		settings.hugepages[sz2ord(pmdsize)].enabled = THP_NEVER;
> -		settings.hugepages[sz2ord(size)].enabled = THP_ALWAYS;
> +		settings.hugepages[sz2ord(pmdsize, pagesize)].enabled = THP_NEVER;
> +		settings.hugepages[sz2ord(size, pagesize)].enabled = THP_ALWAYS;
>  		thp_push_settings(&settings);
>
>  		if (size == pmdsize) {
> @@ -1868,7 +1864,7 @@ int main(void)
>  	if (pmdsize) {
>  		/* Only if THP is supported. */
>  		thp_read_settings(&default_settings);
> -		default_settings.hugepages[sz2ord(pmdsize)].enabled = THP_INHERIT;
> +		default_settings.hugepages[sz2ord(pmdsize, pagesize)].enabled = THP_INHERIT;
>  		thp_save_settings();
>  		thp_push_settings(&default_settings);
>
> diff --git a/tools/testing/selftests/mm/uffd-wp-mremap.c b/tools/testing/selftests/mm/uffd-wp-mremap.c
> index 13ceb56289701..b2b6116e65808 100644
> --- a/tools/testing/selftests/mm/uffd-wp-mremap.c
> +++ b/tools/testing/selftests/mm/uffd-wp-mremap.c
> @@ -19,11 +19,6 @@ static size_t thpsizes[20];
>  static int nr_hugetlbsizes;
>  static size_t hugetlbsizes[10];
>
> -static int sz2ord(size_t size)
> -{
> -	return __builtin_ctzll(size / pagesize);
> -}
> -
>  static int detect_thp_sizes(size_t sizes[], int max)
>  {
>  	int count = 0;
> @@ -87,9 +82,9 @@ static void *alloc_one_folio(size_t size, bool private, bool hugetlb)
>  		struct thp_settings settings = *thp_current_settings();
>
>  		if (private)
> -			settings.hugepages[sz2ord(size)].enabled = THP_ALWAYS;
> +			settings.hugepages[sz2ord(size, pagesize)].enabled = THP_ALWAYS;
>  		else
> -			settings.shmem_hugepages[sz2ord(size)].enabled = SHMEM_ALWAYS;
> +			settings.shmem_hugepages[sz2ord(size, pagesize)].enabled = SHMEM_ALWAYS;
>
>  		thp_push_settings(&settings);
>
> diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
> index 148b792cff0fc..e5cb72bf3a2ab 100644
> --- a/tools/testing/selftests/mm/vm_util.h
> +++ b/tools/testing/selftests/mm/vm_util.h
> @@ -135,6 +135,11 @@ static inline void log_test_result(int result)
>  	ksft_test_result_report(result, "%s\n", test_name);
>  }
>
> +static inline int sz2ord(size_t size, size_t pagesize)
> +{
> +	return __builtin_ctzll(size / pagesize);
> +}
> +
>  void *sys_mremap(void *old_address, unsigned long old_size,
>  		 unsigned long new_size, int flags, void *new_address);
>
> --
> 2.47.3
>

