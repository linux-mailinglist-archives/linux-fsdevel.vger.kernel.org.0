Return-Path: <linux-fsdevel+bounces-42246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A9AA3F660
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 14:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6131D17A519
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 13:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D1420DD54;
	Fri, 21 Feb 2025 13:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ETsR3uwQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mHEjf6sG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3037D2AD13;
	Fri, 21 Feb 2025 13:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740145919; cv=fail; b=Is1xTwoNUvDCUDguPWhAV92ljoiZFUdsFx6W4CRfYnv1Srj3TmTq3+zroccw5cJN8QRjNa2Wuq9EEMh+sF6e23RSAEt5CgQy6+RmanIkXfoBxX8Ynr3atTlqKfh4SXs7jWc0r9F5DJ5k3X+qPZq8QXWzQEen5qZFDaC1EmW6pWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740145919; c=relaxed/simple;
	bh=NaLZl2uRktl6Y+y5xVTXw7veun1/0zfFLBL17ImGw60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RbWxjytWva5tgvfnVqrHU/7njzBunW9KZNCyv89QUNldBcay5WgbbDDi0IHxGE2bo9fJUWMVv+d9ZNh0x/TrwUGHjkQjoJhoqqwal64jol6uD+h0C1bZzoTuuLQD7nue8nAzxc7Uvh9iSoPxSBPKRNxJfW3hAL2+yJusxto8fWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ETsR3uwQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mHEjf6sG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51L8fap5029766;
	Fri, 21 Feb 2025 13:51:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=FPQfvdiBUPhKcfx6Ar
	FIW4//ymd/0nM3da6XJWTYg2g=; b=ETsR3uwQ0hyV8s3WTMkF8rjdML9AMekFA2
	+Uv5sPyyLHRKT3q5BAbzaLnfAIlei5kujaX83zryXKoYNpHNjU1BIpWODUqQmj/W
	zcVAY1J/k2WSGxYs8Cf0iRnK3xt5QOteA2KoSMRzuez3pVH0jUoY9AZfrW4byhaE
	ABKnuvk3AJ4F8cp988QW7+/NWwzfrF+xyRGHSeEBXxv2Fz0zcGfaAUoXPBU2sT+d
	wmcSwMa80fz0Stz/KBYD2k6TfrnTVIPriRrXTkEU1P7Qk2bkuqH3Mq16X2k03oeh
	8Y3YXV8n8W1Hue600LIInTkwF7Z/2QZDf8LMjaryRWlPZfXjy3ug==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00n6840-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 13:51:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51LCQ7On002195;
	Fri, 21 Feb 2025 13:51:39 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w0tpx62b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 13:51:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yOdJbLXhItEBda3tUydfwRgCydSy8KLWWbSOKihzA1WQSdXtvWc/S0t9vZGVPrarpE/QrkpMDjofk6SPOIaJuQgOVbjbjQBhSP2pKxNE42pVqBj/J4pIWYzcoqku1pM0Rx2spnVX8g+E5VXHzeXkk+T3zGmtZlRRkUHY5Is06UjcpOIz47v9jdZ+nc1faRXM8u70hRWnluACysfZjln3fVhQFYMI7PBhmTA0waGRNn54BQ+RXI5kCuiAv+/JZ0T5K/w/Vnv3UogjNwtDVSex6lus6gc0blgjXFfo+vgLN1MNpK2qQvFvog/WFF4k0kApSmePWrCLUlVEnQUJ++EfnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPQfvdiBUPhKcfx6ArFIW4//ymd/0nM3da6XJWTYg2g=;
 b=mAMqcNa1iDkfRv0JYTzELQ4NEuYqhOEMqj0UFGAQNf26SAup9I3615FOd5tFaUFCqPsJX0xlCS83dKLYrkaYAS18Bv5xd3C4TS0MglyDI4u5udsFpBeByCkdUjdYLcVt4fjDJdrconCrooHN9fJ9ka4ny6kuQkVyhA7QZ8dZRoRwWAgGYiJ7mhTv1MCdk8rIRMkDJ8RW8+xra3cWdIBrJeK2s6kGu+NCcfkvrmgkjP2gPg2t6Tmf54qXnIGOz6q8dM5kR/EXYRIT50aW3VIqOwVY8fBNDlfqE+y0vzCEmwom54t7hHNjM7rUL5WmmasrbS+nnwtkXs20DBN1qEYIAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPQfvdiBUPhKcfx6ArFIW4//ymd/0nM3da6XJWTYg2g=;
 b=mHEjf6sGWE6VvWDTCHv4VDB2GjPivwa/xOgxFtqygaXZVg5AVlT/De/9a4P0SmCWsoXXeWiyHCrKX2GXRHIkI1GV0htaN+LHMSauMSYy4TMEfQHf/IzANh5rE2YTzfEpDZNhn9f8ctENu9a1HYIy1hXtQyTlg1XxOVbrQ9+4XZU=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by IA1PR10MB7418.namprd10.prod.outlook.com (2603:10b6:208:445::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 13:51:35 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%5]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 13:51:34 +0000
Date: Fri, 21 Feb 2025 13:51:31 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        Juan Yescas <jyescas@google.com>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 2/2] tools/selftests: add guard region test for
 /proc/$pid/pagemap
Message-ID: <32e83941-e6f5-42ee-9292-a44c16463cf1@lucifer.local>
References: <cover.1740139449.git.lorenzo.stoakes@oracle.com>
 <164feb0a43ae72650e6b20c3910213f469566311.1740139449.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164feb0a43ae72650e6b20c3910213f469566311.1740139449.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P265CA0160.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::19) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|IA1PR10MB7418:EE_
X-MS-Office365-Filtering-Correlation-Id: 99a8ec18-1e8e-4fea-c981-08dd527edac6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R4JdZyHNkKwFurFTMoS6UjMFR7y1XRvcl0rQktgtNKSyX2oABSziqqQCSp5x?=
 =?us-ascii?Q?OJZK6FyQTCbhbApazy7qLtbEu6e5+LwVytfYVYOaBERoHKnqHMSDLVGi1CWx?=
 =?us-ascii?Q?JA72gu8cQNjw1rBFRmKsp9gBL8Ud7foHbI5tGgx/Ph9exv9SygoISzkfsRon?=
 =?us-ascii?Q?+w1uqxi3lNtFQlqoTiH1u55vjdDfqkvzqdRN9YLP0iLrJ2sLo3QEqjA+lVqz?=
 =?us-ascii?Q?+fm3og+tHg/RvbcwA0dPzYswZgKb/JaLWoMoYDp4DTh9/6Jhl04//NbDpaow?=
 =?us-ascii?Q?IDDkGAhH5hqzMskX05BFiQAJajIFo+uasaLBp0c26l/3DX4rX9V8j6V6xcnq?=
 =?us-ascii?Q?rkwcxhzAAHW12ln4t6IzQTns/KkZosGgNN3cxWYuK6PPDHD1rV3P46wnIkSo?=
 =?us-ascii?Q?ASPjWFcXSViBNwYp+aFIv0qXeFCA+qWrq/NByvlJ5PJu+gZNeBaQZwkjN57t?=
 =?us-ascii?Q?Ud1lJpm5L9/fSKG95YBfrIHORA4uQyNng6M039c2quxslRMWNTX1n7/LRxBO?=
 =?us-ascii?Q?guR88RehVoDbXE2gXj+E8UKqRTVX393PYPeL/gVk3CNsfcWIYCd646wsk8/l?=
 =?us-ascii?Q?nvWNhma1RKCl0Lz5vHIu7t0fB23EVroRVRDsuMW0uco2lig5q/GFBRaCwYSN?=
 =?us-ascii?Q?Bn1mqmfDdDjJ+Vb1Lx/vP8X3/VQVqZuWKrAJ7+pzpBgh7PH4QSsf9RfadYcB?=
 =?us-ascii?Q?u2V5Q3+woQym1Mbr0Gdld5NFiMEmZoZUcnpNAQJsgYtsXXiO8sgF+uNcSzXr?=
 =?us-ascii?Q?BHupba8eYKITiBbTlCnaSZ7qOqadC5ZwixJGNDfjfsV/CBDLVP0qzCLNvc8V?=
 =?us-ascii?Q?zpiDMIeZx4sC32CpoHJhiPtOQagYepeVnUJipqeJMtex3IMZ0EqI0H4yhd68?=
 =?us-ascii?Q?RFbJas+EzNJfpg3ZjkkHu/02QAM49KjA1jS0wwX4uuhv17YVVph4NuR+SMOL?=
 =?us-ascii?Q?ayIkyVvH76Xp0xSceMBCfptbJYIzLTX/EoqNloybGkySZd+NuEh46yOXpySe?=
 =?us-ascii?Q?HnIYC3CYiUQ/MXwwMVKxvmyPyEczJ31k5Yy4OeKAmGwcH9laahcgynVqr3YQ?=
 =?us-ascii?Q?mh6Td+YeaGgfxgaBpJBfjnj8n4HuWNJd+B4VfV4lWWupb2mhZWH+laGstHsJ?=
 =?us-ascii?Q?G8h21Uy9bjDzyvBlf2oSsvUlW/2acizP3YyBJDxpU4ntYYiFuPtd3rtjVw/o?=
 =?us-ascii?Q?W1G1HAkHW5n+OtgjAHBiu3fGQ50UfO+3nkr2HEigFnnff+NYiaEeY0Adq79Q?=
 =?us-ascii?Q?Ni7XP+RzMeE3QGDqMv79u7WkjDKhsOCCI3Iv7xHBll5xrwTCb3cJB3f9NHnV?=
 =?us-ascii?Q?BUMPfovP+z+mq+65fRvB29cmYccyVv1JDTw478t+26xSlW91MExOE54JOIh9?=
 =?us-ascii?Q?DDiG0Wk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IbdAiU3GS+USU51cQUcOsHrWhapsPeBW/vUDc8d5j9zckR9HG3saHtH2boMn?=
 =?us-ascii?Q?baP82wCV3J8RC2bY6NsIuuw0u/hnBf5xcNB4yELYP7QmJ4eplQNFPZm82i5c?=
 =?us-ascii?Q?E2jHrsv6gYeDUlQSAuA6hDWFIPDe6uZbISx9qL9kw7qf5oEGdUSsxoCyEg8M?=
 =?us-ascii?Q?2cO9rV8jIJR18pTipcsWC5vBAUw8J0kdgiB8VVTzszeJjrQR9mAcRloqFfpM?=
 =?us-ascii?Q?szWhC9/S1uueafGNjMviLw0A4xK1mhpC3ufZONW6rllwCBlWzJPl3Ehl5OcE?=
 =?us-ascii?Q?z2PGgzfrSW2SDGEMOvXTw9QNaWFU9Fm0urQ2CA0e4JBn/6Iq3o0Pb/bIdeFU?=
 =?us-ascii?Q?yOep8EeGXMvaepVxFyVAbtYyWiMSoEiESza6THsmuG1PqTxJgtiiyUnS/76/?=
 =?us-ascii?Q?ovLMZRJgeouGHyhMPlzMLHkidVVxXo3exdDL3TRl8fuj1szOCaW4KnCuGUuk?=
 =?us-ascii?Q?qxWs5tiL0P1SS/AfZM/+XB+eW3vHYWDhINAcWb5HSxTbxEw+oAKdL6KTtuUT?=
 =?us-ascii?Q?U92bUuq+72pvKR9rpUMWBqwih9aQiFnd7aV6XbSES5YMRC1gNr/KjNJUU1vL?=
 =?us-ascii?Q?f4A3zyBKXq3K1GfuvigzBEdFVbjTScXSf19JR6h5nivkxQ61YiuX3MRh2YEg?=
 =?us-ascii?Q?ZIPz3do7kA4guNtpCvhFJOwd0edAxTuzxZkYzbk8HnVdyGZwsOE7OU2wcUer?=
 =?us-ascii?Q?Qii1gu8B+JjLHmxpsp+YzMMuq25P4hBDOHIA+byKe6xgZ06iG1/66MUm3iBS?=
 =?us-ascii?Q?J2tMF7vqojTSOKKKzDJev11+3YAXeXXYgLi6xWbOZP+SSPcF0+rHjE7UxtsN?=
 =?us-ascii?Q?ErXSV1c1MLQauQojfTvDFGzUM6B1yGY/Psi6vz/yNnhzZxuSHgvFHTSId/vc?=
 =?us-ascii?Q?df6YAD79T/OL17I3NgUasH8l9rv+vWY2VR+QL96kgFYa+RoS/qOTc7Sg7+MQ?=
 =?us-ascii?Q?lnEvlir6aOXLAf8f3Ha96XVveYr0iBaKPCiFYuIk2KFcyZAa995GhAPeegC6?=
 =?us-ascii?Q?BaWDb/WyKdXWlbrpbkmY/5RfYv+UdjwU4finyTiE1Dmp3bk5K4kMrePpgAeI?=
 =?us-ascii?Q?YpfIAI627+0QWR8B3elzjytEG2yU5ROOkagSORwHFzRZS6FQLK8CVcUcM1Wv?=
 =?us-ascii?Q?Ep/oGp/QqAx5tXYIJQamOsZXWyC7CcXzxpESQG5X8ueLWtMQDY0Hixz49G5n?=
 =?us-ascii?Q?Hxgv9FrhjlV9WGgqP6C/PyvNyhUiNJqPzvdZTkrN7Lmas/Z7zPc1SKRqBVeE?=
 =?us-ascii?Q?zCHyiE4cUgtJ8njfOd0CkhgtenmXLYkNQRxvHdQxKf1H5ubnm6dqaVE8A6J9?=
 =?us-ascii?Q?bo9rjKyOxdi4psginFrHABDhGhX7X4GZVxswR9tLwA9ZjFQHnaT9tll1I7t9?=
 =?us-ascii?Q?Ep3XKV/KKYGoEc/Upy/LSQIx1ZdizKpRNkrO7Tt4YfGo7P8umjpI/D+5GXge?=
 =?us-ascii?Q?0AalObjejNgjpQd0f7y+ktOvodswHtr0ahVCJj/YLtKrgm0Ftv08QaXQMPTV?=
 =?us-ascii?Q?hH7Ogp5ESHHVsXWecpOhpLfJqGFYDJ/eeCqu5eX1YvjgKtQyVgDw+Mtjtmms?=
 =?us-ascii?Q?ZI3gPmgoJWb6tQbSbtczRQitZmxawwKsmYXGtnFR/ue6g/oSYsEW0STH1vIJ?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mgpetL1Rhq/aWfNgpjlbPEGJdYyMFiSSMvm5+mYyE1SMEkVURYl2UQxf41pEKwxwZdIemneinqouJEceliBV9BH3NfvSi/6dl+YCv7JzkkfY0ofnjKiU/RRg2vwjNHTRBOSqafirqgC5kD51Vrv7goS/tXvgN6xqm43ebxjnE4nFvXJLYjmIC0+xjNRTIPd1gOpbDgLIGU1x2e1CSF5j3dmykKSIsDx2r5TCh+YPSc0nMebPJdv+nZglkhW6Wh77yVcbwV05fnELYStIkI0z08GnCp8GrY+Kq+hv5JNOtaL/Ywr3pzWtxDFgSgARa/Wmx2FFJ3g9OUx3tJssL+Jdv+6XxiNvJS/5QCZ0GALetvei+s0YMsoW578St5/qo4xmKbeYl8JbfPnsjttFaGpu4O+ae9s/johuPvzB5oDKCS5XZLCizOObMNNFiFuQ/NRwO811qx8Fn1UNrCtcIbvbC6DYB/AnWgefaKvZMRAZ0ciX8KOi956O6q5Rd7v9Xg442yzHXJebWm4+3Nu97WPzwOo26q/FgjpcxLxZwCffcfJex8pRFgyXRYX78KINr7LtByXcSl6cNY3u2/Apb87zUA5zlyirvqVmC3URler1n9w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a8ec18-1e8e-4fea-c981-08dd527edac6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 13:51:34.8000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rFY+S7YPVq4Nj+TRUHYPzSQdF/jHVCBnmRyMEFuOboQAbw7dZD8V0yuqGlyITCGIog4UkENabcCf3ZL9MeKJiplzyApbXnBGJCM4SIO7y+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7418
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=985
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502210100
X-Proofpoint-ORIG-GUID: H1cVAaEtcKZhClCaFw0Ggl2SRTINEdVy
X-Proofpoint-GUID: H1cVAaEtcKZhClCaFw0Ggl2SRTINEdVy

On Fri, Feb 21, 2025 at 12:05:23PM +0000, Lorenzo Stoakes wrote:
> Add a test to the guard region self tests to assert that the
> /proc/$pid/pagemap information now made availabile to the user correctly
> identifies and reports guard regions.
>
> As a part of this change, update vm_util.h to add the new bit (note there
> is no header file in the kernel where this is exposed, the user is expected
> to provide their own mask) and utilise the helper functions there for
> pagemap functionality.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Andrew - Apologies,

I managed to not commit a change I quickly made before sending this out
(I'm ill, seems it is having an impact...)

If the series is ok would you mind tacking on this fix-patch? It's simply
to rename a clumsily named define here.

No functional changes...

Thanks!

----8<----
From 60be19e88b3bfe9a6ec459115f0027721c494b30 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Fri, 21 Feb 2025 13:45:48 +0000
Subject: [PATCH] fixup define name

Fix badly named define so it's consistent with the others.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/selftests/mm/guard-regions.c | 6 +++---
 tools/testing/selftests/mm/vm_util.h       | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/mm/guard-regions.c b/tools/testing/selftests/mm/guard-regions.c
index 0c7183e8b661..280d1831bf73 100644
--- a/tools/testing/selftests/mm/guard-regions.c
+++ b/tools/testing/selftests/mm/guard-regions.c
@@ -2054,7 +2054,7 @@ TEST_F(guard_regions, pagemap)
 	for (i = 0; i < 10; i++) {
 		char *ptr_p = &ptr[i * page_size];
 		unsigned long entry = pagemap_get_entry(proc_fd, ptr_p);
-		unsigned long masked = entry & PM_GUARD_REGION_MASK;
+		unsigned long masked = entry & PM_GUARD_REGION;

 		ASSERT_EQ(masked, 0);
 	}
@@ -2070,9 +2070,9 @@ TEST_F(guard_regions, pagemap)
 	for (i = 0; i < 10; i++) {
 		char *ptr_p = &ptr[i * page_size];
 		unsigned long entry = pagemap_get_entry(proc_fd, ptr_p);
-		unsigned long masked = entry & PM_GUARD_REGION_MASK;
+		unsigned long masked = entry & PM_GUARD_REGION;

-		ASSERT_EQ(masked, i % 2 == 0 ? PM_GUARD_REGION_MASK : 0);
+		ASSERT_EQ(masked, i % 2 == 0 ? PM_GUARD_REGION : 0);
 	}

 	ASSERT_EQ(close(proc_fd), 0);
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index 73a11443b7f6..0e629586556b 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -10,7 +10,7 @@
 #define PM_SOFT_DIRTY                 BIT_ULL(55)
 #define PM_MMAP_EXCLUSIVE             BIT_ULL(56)
 #define PM_UFFD_WP                    BIT_ULL(57)
-#define PM_GUARD_REGION_MASK          BIT_ULL(58)
+#define PM_GUARD_REGION               BIT_ULL(58)
 #define PM_FILE                       BIT_ULL(61)
 #define PM_SWAP                       BIT_ULL(62)
 #define PM_PRESENT                    BIT_ULL(63)
--
2.48.1

