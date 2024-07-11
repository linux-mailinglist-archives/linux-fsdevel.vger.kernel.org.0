Return-Path: <linux-fsdevel+bounces-23590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 476C492EE73
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 20:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAF3D1F22318
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 18:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71ECB17108C;
	Thu, 11 Jul 2024 18:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NkLEzYYL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Mrm9t3ws"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4CE16EB40;
	Thu, 11 Jul 2024 18:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720721259; cv=fail; b=QjXqERMNfkoC5RMYZxLG86t8HbNfS3/EK9SLVe+OdPkdc8AwrpN2mJOc28A+U+yxObTyhmOrbI6bY5M+lhAgH+uRBqInLAOmsMnsJWzTF4dWMzbPnYiBQynOpeYYF/2xXihR654bv5MXpvDDwlNnU6y6O4GAbHlAyzndDXivPa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720721259; c=relaxed/simple;
	bh=dnuB7UNQMSyNIDqcLtjYcdBUG+Qrva0h3hUsE16jnZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W2biQVfVRI6ESfuGtG+VUcs3PZmJ9BtvG5nlcKD3tX9xSIclffTqppepBUIqFYsrsvfnDTVWVyIJJ2JE+dGodm4dLYXgME5+q3uMt6YSDGORYBsbwGHpcGnR2O+X14pHpxNtIhfgSp3P2pliApAtUzZ4CSxgp1g8YzNmczLd4BM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NkLEzYYL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Mrm9t3ws; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46BFBVG7012948;
	Thu, 11 Jul 2024 18:07:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=YkYtoiK/RFEs1O+
	jOO1DHVHVodPiQM9rCTdM8F+sfBE=; b=NkLEzYYLCfqPszgNZ0i1JaLbHlY6+qw
	jQdaBeNAnOmyhICZG2r87kjm/zyZ0ocp+3tUCCecFVs7AXLbBFKxGm3TJrqEKVHr
	nLYac/Ja2y0u1WbhE1Vy3zy3pAf4J1bLJ0WhPJbSy70jUmOFHx11s3CQBRfxHzqo
	RZAotXCF6m4xh//39x0yd0rISS53hJCs+VLcDvl+wQ5n+sbFsgbAeLBkZdf48QHm
	rWbIl3NRg6q1BbOuKEEQlc0JdOJvCf/jNoKJFgq4eg7jfVnE9TjDOgj/zPrfkEhv
	NRh+nObDIhh7dbusxlCn+FKfcdhE4pVqfmrBRVSXOzmEXv2xmsc/AeA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wknt80f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 18:07:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46BH0x7u030233;
	Thu, 11 Jul 2024 18:07:24 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 409vvbmh68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 18:07:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ilKgGT9fMae0ZW/huzg2pNUBr/tfeFHRjnIPw9mrfooW5HCTKIdyEVZNb2wzC0q7y5aAAODUBHu/A8zpp0myUMK0YTcqLPOzmiGPxnU3YEy9FBdCRjDFfuGnJSt8RRczS52zEZmcfFXHpJ7irWH/pOo33j9leZO74R5dInQSfCWNkz6J0u3NvYiCSZQYFlp0w/WecdjGA7dfcmI3iyFv96TPPX2S2iXfwtQ9b0stdG2Oc1eVGDeG154l6g4VgwONLtLgXv9rYwD5YMg4JPlgV/nTvlSyZ4BzacQV2aaGmMEOWQpuLJiXdnBYn4+aFoy2T/r5r8JF+uYB/3gt8nxVrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkYtoiK/RFEs1O+jOO1DHVHVodPiQM9rCTdM8F+sfBE=;
 b=aMDiClzkzXhmYR6vGjW1TakT690buA+Y06fQue7gDWTHt1lToImCcsTL4g2GpBMb3etCieKLI5PIfSaCDa/ai6zOqR7jiYyHr5xDQyjeaD+dvQ+h5QVKySuyL1qlWSjbtkwiEthLn76okvl9xjJBzAqyZSSsecKe9hpiJE6saurSRAYJJHEGm4I88qKj37eQap1SqsnbCBuhXiWuy+KFj5hus6lJ2myYwrZWOLFQes2qAq9TN64OfLtdFkksc0J1fZBhfjXO9wO1zPhsmYvtrGQcayAHRrbTJzlioi80B9LECcUMGt+jMWsbIMws6cS63yh/h5+Y5mZNxHLeCMELHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkYtoiK/RFEs1O+jOO1DHVHVodPiQM9rCTdM8F+sfBE=;
 b=Mrm9t3wsK5LmUsYyfD70OGcWTPlzceVVNHW8YB/F1Y+wSsdi0fqwsDRvTWPa0D4pTlvhXPOq18Yd8ro8cxttNmwu3UQU6gOG9gJcnG51wGdi9+DcmXsF/3Lhhw9jlojkVJV4xqudDoCV7kp/8j9VkV9WVjFFUPlN0MkNJD5iAQ4=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Thu, 11 Jul
 2024 18:07:21 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 18:07:21 +0000
Date: Thu, 11 Jul 2024 14:07:18 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, gregkh@linuxfoundation.org, linux-mm@kvack.org,
        surenb@google.com, rppt@kernel.org, adobriyan@gmail.com
Subject: Re: [PATCH v6 0/6] ioctl()-based API to query VMAs from
 /proc/<pid>/maps
Message-ID: <yv6k4j4ptmyhheorcu6ybdcyemxez6wy6ygn64l4v75zwbghb4@wewfmb3nmzku>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, gregkh@linuxfoundation.org, linux-mm@kvack.org, 
	surenb@google.com, rppt@kernel.org, adobriyan@gmail.com
References: <20240627170900.1672542-1-andrii@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627170900.1672542-1-andrii@kernel.org>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4P288CA0041.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::22) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|MN2PR10MB4320:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d1fcfdb-21ee-4677-6113-08dca1d44ef7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?AmGmygCaOYHLooBolWK8lEj42uwkKPkZq025LysXYVJCVKoNP09eFRe/aa+i?=
 =?us-ascii?Q?KdEt2PVxJQzDAKUt7G4sb9461JQwM22hdjTpe1aghB80TN4Czo4F65mBzSQ2?=
 =?us-ascii?Q?qBmotza5llnaNWrtelz9KwX6ea+K5/vZOggyaYlqklb024SThCYJ7tGWBHb0?=
 =?us-ascii?Q?HiuSZxHPTW5j4WlnYH+8Svl1JV/ZatGv2rcu6MyE8NxUMptkocXmUVljlJn4?=
 =?us-ascii?Q?oQe0fnSarsbae+QP+8yRFKyvwwe9xAVSz/piJUDGz9ppaG8orabUDq6IU53o?=
 =?us-ascii?Q?0aM5ZxcBiEgjAAMjNz9Qtda5H2gSAQNMugrjaxlguHTDJ/tRwBzuYsQvTPWi?=
 =?us-ascii?Q?YiyYl66JoM+WV86tU+AMvbZWbuwY/7aONxyCXBRx+I3KLf9uFFCLq77qvkXF?=
 =?us-ascii?Q?+UISzBynQ94Px1N5gqVaz/ZL7deHPyHjxG0TC3EXBZsfGHgxcYYtdbccfQHJ?=
 =?us-ascii?Q?pQMjiSYKdy8rYPAMs32OBakdb6bmViP7MNWNOYB5Z4BVM+6C8uExfQTy97H5?=
 =?us-ascii?Q?MmIaAl+t+H2sYZgdwZlxdegPVSFZrCwpV7cBk+qBu0v0/Rv8IjNA9XhtvBy9?=
 =?us-ascii?Q?O5iRUgPKjJwRS6twEyScuAi4wPn9rvDJJ2Emp3wSs6X3iqKUdEY5SSqdUwqH?=
 =?us-ascii?Q?CJ8xWz9OEX5oTiqwgfvqY1DfStEUA+VE1n8ZhQsjpy3woK8+zLw71FQe9zmn?=
 =?us-ascii?Q?292jb65SiY0IKwmliYxlpalGCYJe8ZaVk++U/R8mlY7dL4riOquZJx2FSdi6?=
 =?us-ascii?Q?ffKu8b8WRWLWZgrqtIy9MPMKvadp/LTdJOPeo5+E3htl/17BUZr1gksSQYyC?=
 =?us-ascii?Q?acn4RiVRAAythGcof9OByllrj2h+CFmKCTYKHLuWmeVeOcK2E7DWMQ7sE6GA?=
 =?us-ascii?Q?a5/taSnEYcoBqQ2yihH4HCn4IU9dqBzvqm7+9d2rU+bSIw7WVHaCqzyPbKXv?=
 =?us-ascii?Q?sV9/cj8fSgprqAfL+xN7xmJ73ZAyznDz7k9dH3fyNRQCeDLoW3iqpRo6IrhN?=
 =?us-ascii?Q?2YZP8yx8t2pmZ4LD+vaiuE/P86iyBVQZqh4rppHiUCLAu4+baCEGLyNeUk4l?=
 =?us-ascii?Q?OD4fKnqrA7GBAqAVA+w+/iCteIkmAFfKZfZehtn+1uwXiB6WyMjt8lXjj9jX?=
 =?us-ascii?Q?EMcKAodjYowIuBsLakW0xcW3ftRT+CffLuV+hN6+z+CiFfmWsnsDNv1XBaAb?=
 =?us-ascii?Q?Oz+7LNR+QODFiKti2TUjWLLEISm7zLkKihvMyxMUfMh2VDRYnMAl5dgsD/d3?=
 =?us-ascii?Q?TFye0JkjoqbP8wC6tNIPVStx+dJTGqScGeaAgAsZjHbsK0Dyh4uRpYUtE5NL?=
 =?us-ascii?Q?cJSrclGgrqdoDfqQyz7M7oD9hRCnOfGBzLCysJxqi2Di3g=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?IA7APx0ZfE22ujlpkKP2TG1XS1W7ta6BMhCC4ThfnKVb9cC4HZQF68Xl8RXe?=
 =?us-ascii?Q?plJ878lSf51UzPglLV+qaU/0esK6RB2haNnJHt3xZsJWe3CaCJmBbXfK7zVi?=
 =?us-ascii?Q?cG9fJUSc1Ya8FFW4MYEHL84bgKuj+EBbXcZTnKFypcC+7Oz5+mrUIfsr7PEw?=
 =?us-ascii?Q?NmDWy5ijn9INeG3q/CayPijDU/l/6Qsu+8b28TmxEX5XGzZZXfyOxZEhBxg/?=
 =?us-ascii?Q?JUwnW1zsVPG6VPPEmhO7M8nTMQcF2FR8WkTwlNo7f4pJyL83j4A0Z8454S+x?=
 =?us-ascii?Q?VpHFdZrjBtVJTYtlFo/uBGHzLyhaHVa7ireEjEOJj1wUlosWhnk2pT0kiDhY?=
 =?us-ascii?Q?mY+QniK5IUsJnQoCMQUKvxREpywhhHNuVeB1BVotTHc4vP/qs6OTyJRkcNSS?=
 =?us-ascii?Q?x25UGym8d0Z/QfKfJgXxlJglHggOmywqGe/UOF9U3KHDgZSEOYQnVRUYMciX?=
 =?us-ascii?Q?6m2Sxfm5EuKIgvkFKnXQMWMNzAmu+bdWn3ugGCxmDrBgL6qNHeypR8XFcuXJ?=
 =?us-ascii?Q?gxiK02uK7Svet2ApKOk5QgwuAgmVXDquKYiCxiWxOl1xjJpfz8LzmDpl41YI?=
 =?us-ascii?Q?o5pweX1fNtlNZ09GGAFPIjqA6fWd8NGERixwEtUU+BQy5iGF0rQU0bEAw3B7?=
 =?us-ascii?Q?r4iZk4IuhpHQw7Yd7/KdhDWvUN6UltDCq3EDRvteFFHb0tS084ryJ16I5rV6?=
 =?us-ascii?Q?3EDEz+imDZllqzcWqVpoJDHxeQfJ+P5OzBDJahtOAcfM1wsHqEdEP8siHtuK?=
 =?us-ascii?Q?+Xny0QWp3xXkA6H/LyXIPQP4tBnFRlWti6xNLWnb2yiCcodJfnopMKSJLfaD?=
 =?us-ascii?Q?DKLz5pZ/AWsyVsdWsC7oNAK+NUc3T0h20y5Z4stWSj0Ufj+meOx0B+zSzJoD?=
 =?us-ascii?Q?YrOnOa+v/uxVSL3fAHRv9iNKy+rMTowxwwq6BXGr0yh1kDhsxwxiQWHgDrlW?=
 =?us-ascii?Q?wViWCffROHk0GI4dkGckXS4tA8cgfbsMZZpHGZqDZP5DDYyF6+yvZ+n+37H4?=
 =?us-ascii?Q?5LPmJWqwmtQOkfF9Tzi5tse6RE4PR9q1zYuRjMVrYO+ON8Kk3lWKvtcSzZ7z?=
 =?us-ascii?Q?p9INFoxZnitVU3Mkcnm352pqCJqdm4POWFEq+AqNgQg/1Noo+NWKdHDocmjH?=
 =?us-ascii?Q?32iyH2xSa/ND56UzbI1WEeC+dcQYSqscrLfBwcb6rngFw/DpeMv1WCoeqOta?=
 =?us-ascii?Q?oZ40n/cPhso5VQSvVRfXUyuAbAxX6wKzm9Zhs8IXYeer1OKgtLMuqx/aMlId?=
 =?us-ascii?Q?Q1aAxBWNdh+2rdFTSj5eqDt54ZaEGHI9jn8TwtkG2HDLswHUtOKy+gMwilZY?=
 =?us-ascii?Q?+aE9kfQHJLT9vHLJaQvcHvF9SMnwaEL3xN2BNIaLXQnmzi/g4VRzLSlNG6G5?=
 =?us-ascii?Q?ebUlJ3F9Fk5qcQ2VYmxKyuHpWRbscM2Fi0NHmERUuS6dlmpzP+9cdzAEcCV0?=
 =?us-ascii?Q?wTBsarIZaOF+cjnzmGiTdrLUaptxfT+nujzk+b4QQWUSlIeWeX3JUdn0Z4CW?=
 =?us-ascii?Q?wzGqK1GgHg9nPXLSlBM2HrDHDJZyVgWkIAyJwFYKrp2AVrbsHXvMlkQEfBcX?=
 =?us-ascii?Q?ML7qgWLONAkXe8Berrn2xMYCVHuibxcQAFuVobjHatu2y3c/a+wreDGteBln?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+jY/oOy5hLUrMxcPVje4MC5WO0YgU3Dkw1zlHyowfjMCE8ze/+IzOXluc2oqqhXx37wUQm+KQZugx+VVU5kQuACMYRzz6KMtKgGXT06YRyq0o0l32B/1daGo+1ekWe3WvuN7A7OzzDIt+uhAjaJu24SIUXWDCTctxkuZvmLClMJ4U/B3ZrgH3uuDpkwUIQSENaA4p6svYgwSqEHf94Tj9erCPPEJhmwtFNg6nCxOZO9ee+mepQwI9vNu+8+LfEj5ntbZzlhdR7OVQIQwXojpzHLuPxhTaFcIN8cZQegR4JtKqg8QLmxnEOtPPe1jy1//GLEy/wafGWHk7jlZyEq00rEbv0tmPvs4JrjmzeDWalEbz9NTlLPo2SQlNEvAUo+FpBqiMVigGJMo88DQFJMCxw3Mr6DiXZ6IK9V8hoiK4ovjH24Dv9HZ50yZ0TwXQYzy7V8WqfSYy+H8Jpv4T+Kdfuteo+G+JphYBa11DlG6jQ9B9IzrPY5mVpfdCyYMBykuwYDz8tI/s2gKCK1gWZwO43zp5F6Q7w4W0z13Cu1vjRFx7OdyQGhCyXwXfqyy0Sq7UfmGDj3ctmpDX6H1L16FZu0yH4t4VxpsBHpSHL9f6QA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d1fcfdb-21ee-4677-6113-08dca1d44ef7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 18:07:21.1028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FyD0AbHcKPsG/DAGQdcL9dlx2OV2aZNqsH6fKzBSzAZ7Z/4HqrQrzhLsJJrvbmk0J5fZtQpTXk6VntGmWyYI2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4320
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_13,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407110126
X-Proofpoint-GUID: A8aZXG8SNe-pD8jFe4rpuKekfypFif9i
X-Proofpoint-ORIG-GUID: A8aZXG8SNe-pD8jFe4rpuKekfypFif9i

* Andrii Nakryiko <andrii@kernel.org> [240627 13:09]:
> Implement binary ioctl()-based interface to /proc/<pid>/maps file to allow
> applications to query VMA information more efficiently than reading *all* VMAs
> nonselectively through text-based interface of /proc/<pid>/maps file.
> 

Thanks for doing this Andrii.  It looks to be a step forward for a lot
of use cases.

Acked-by: Liam R. Howlett <Liam.Howlett@Oracle.com>


