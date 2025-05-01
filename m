Return-Path: <linux-fsdevel+bounces-47854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADCFAA624C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 19:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B5D21BC3A34
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 17:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5627221287;
	Thu,  1 May 2025 17:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sAgAVZqo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xp5ap7uJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FA82144CF;
	Thu,  1 May 2025 17:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746120454; cv=fail; b=JCGlZXAYLdzlU0hCJo3JgEXd097OS3kC/ReDBXjmcAyQ0/ugmpDUsB8QR9x6GRWEM2Yz473WMg3ZdxxdpRcDst35CYYHkb7eaVwx9JEhSGU2tqm4RhLYgoCS3wpgDIgVFLoeRXhTfnEsfrqBFFJH7ygvKNiHfTfmKPX383mPtrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746120454; c=relaxed/simple;
	bh=K9T/wVVLV8cNRXHBSr/FaW5aLK5Geea7NU3v8/pRCio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DLBexcwp8Jmxq1inZZS8kayC8QATQxjOu/CUQsh/FbwHKMf2W4HK46jLvUFaepwnXfAxNeGe2yJKbDKz2iDYMDPa36JYVX0swEm3xcq+ZdilIuEX6Xr26QCZe1DyHZhXppmljdxyYVvYNVhyqBH33xLI4bkFCD3EkzmTTO+SdNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sAgAVZqo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xp5ap7uJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541HMwcK017312;
	Thu, 1 May 2025 17:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=rahkyNLXBWHQwG9Mnt5zLDF/RjGw1PYJNiw9Os1ziUE=; b=
	sAgAVZqoOHkWrHzy+OvPvSjNXFgJrNGP/n+SjGCourN8P3L67Qa3WOAkN7PPAafU
	Q00eqEvoczFhZOWyvzOEvzodVXYh2RRLbZVSDk2wmwCXLjD0//YRQpx64PHePfCD
	7j4FMR1mLhkvjndP97xfNGBFk0iqP2YkrEpppsr8blK5i8rELXXGdixhvlfrhGyt
	JKdS7O2uFiSVe/czGnlDn4u25GkQK4YnffHYLcDZJMS9jfI/5RLMzd4KOUqMtrZI
	9tjxDDeyKQeToj3jcYKL1z1nvo4UnYfw51a29bsJUzJrhuwQhHzF1/nCaIHxj0D+
	Ff9ZZbuKak3LBLqWu0OiEg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6ukkhfa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 17:27:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 541GLSdT011235;
	Thu, 1 May 2025 17:27:13 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17013079.outbound.protection.outlook.com [40.93.6.79])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxda880-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 17:27:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tv+kQ3MiUbbrHFuDfvq04oTvmsOzeTasklwMNoBDdNg2a0gijap+9AN+TDMkVDOKcAVCB9+ZiizI1JR1qZQkB21sb6+A5g/6ip/FLaTTp0sHxtPjLuwksMJqBDy4K6Nov8zGfvcjSSCTv+JQ7PboRBYbdjGoKWzC2kv8AbME/Sa0dX/OCn1OjwXXRtQpqPJRrbu4S8r4pQvqjDDOHWmFMUe2k4AjfoyQUtNi94XdAECG7qItDhJube8tFoQfbazqJpHf++KGP64OeSyYuogcEUBAH+LlwYsmRa3f69Ajap1bl6UGRTKZ627vBQa8ZzeYJGPLo1Zhoz+8Ag0lQGeSIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rahkyNLXBWHQwG9Mnt5zLDF/RjGw1PYJNiw9Os1ziUE=;
 b=wuqgCs/aEBgxPZ0HJBphKwUYg/bcIGd442V2OkIo1qGWBbi+Mz4Yt4ZJw2U/g5oQ4xgKrCLr06z8ZTYhvqyGIbIGZ+RlPmhTpHs2HIjcQIzL24fDasaGL0D6SgMaJGjc+XU//JRIF00z3HUjOsAjoEm4rk41iLDY0Obb6jlbhW3c7+rLhXeD9JfyshNsA3uRVRncRcC0JuJ9YKe4+SDk5seu/ZwifGVYNx0AQai7zTMi1ozMnCp5tXyWieJy6C3DaweXPb7FVR8JxGkfa763Ra9vYzP6jvbezTOcbmaYK/SHBmAobCTOF0ZPN+uIQhUBZsBjg0ofc/o2obu0b8i8Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rahkyNLXBWHQwG9Mnt5zLDF/RjGw1PYJNiw9Os1ziUE=;
 b=xp5ap7uJXKDD02ftxdNJtHV/XEyr1oaW6vPCFBnLGgG8KIvxH0+EdGQ+z7Mi5pZPhGyKq+YXOpml8NcZ0ELJhOKeZhhNcflm6tZgbnGej2myLUo7e3ARswGTh0hEkP6y2Ro3Z7KJ2AmSJMj1TuhPw+IIe/a03kWzCFPxa+eozrc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MW4PR10MB6680.namprd10.prod.outlook.com (2603:10b6:303:21a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Thu, 1 May
 2025 17:27:10 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8699.022; Thu, 1 May 2025
 17:27:10 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Subject: [RFC PATCH v2 3/3] mm/vma: remove mmap() retry merge
Date: Thu,  1 May 2025 18:25:29 +0100
Message-ID: <ab0bb96bbe6d3edc5563d469114ffa4bc88433b9.1746116777.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746116777.git.lorenzo.stoakes@oracle.com>
References: <cover.1746116777.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0290.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MW4PR10MB6680:EE_
X-MS-Office365-Filtering-Correlation-Id: b61cbe01-266a-47f3-b243-08dd88d56754
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nr7TSQNcz2fOUYpRrlIlO1ydlX7gkNo+AZqjBYC5EnWgOw9BwbQ66trzpsVs?=
 =?us-ascii?Q?9zkTSR4tjjX4Hptw4BdJ1Mi6iiedpWABKDhbqCIWe3U2Nk6dtrtnPAdIFsgr?=
 =?us-ascii?Q?ipAP5vJSzwQKXIPQvDQy/BGm4K30swQio4WaGSKHxewMVSIKlawIxKvfLUqN?=
 =?us-ascii?Q?UxwUMB4umCiZGgIKYV2B54EYXQkO4PFLMvcXhAsB4GLzT+T4Zyo1Ra3HgsoL?=
 =?us-ascii?Q?iKMlgRzsvrK9/8df8w4J2lIcuF6detD8Qm4vMJ5K8qqqJo6yY4YC37ruYLIo?=
 =?us-ascii?Q?nOg/5+l3fJojyUmqH4QX3NrGNAlYtjHUATNC4l9euu9jU2Fwrk2QC6tLORLu?=
 =?us-ascii?Q?gsp5e2AYxN5eRs+HtATNYrdMUJZ39wf6bpnaoGAigbbhb8yhWrVsyiFftSUu?=
 =?us-ascii?Q?YOuwiM+JQnl49b6uHO4msUWQ7zm6M3yP0z0Lw+QcZKei8mzbK/8VgaJy38fH?=
 =?us-ascii?Q?57mNwdzN2CGjCiUyVpNL7zumtVCCFaarcd6yKntW/2lFYMuhZ0EKWHN5ZWJG?=
 =?us-ascii?Q?2Fx9YFlnaEpbbKNdojB68itqbsNjzAWKFts6FRw6g1HSKPec1iPTqoqZc5jU?=
 =?us-ascii?Q?NPazJaEJhb6J5Pa2aMZhLqJGd37K809Kf9ZPmT4Ih/vvcjjFgA/w4tZ0Vydk?=
 =?us-ascii?Q?kVOu1GMXd28BG24Hx5BC5C8j8GlAgHLyDKhL0f8bLP+Da/Dukhy1THtPhnss?=
 =?us-ascii?Q?QtLbLo8Cuc78Z6+If6Hu10flRpiP6Bb/Rt6745MNleCVviu3mPXWqkwbmdTA?=
 =?us-ascii?Q?eMSPzpqw4xyCZk0/tOLkoX/MCxr1AxFPSmCouxnm4jtJ7/eSBd1uWDtsQePG?=
 =?us-ascii?Q?WCerwJ8r+S7M4L2XBGNiQsVYt6HsnXblEYjisRB5i1Lz+1DF9+pCHO31Td0d?=
 =?us-ascii?Q?HZN++FPKs//E+VIoaTIy22PByReqKBPubvE8FUk+JAaleTf3YVJqkSEvKBbH?=
 =?us-ascii?Q?uALd+zfSWLEc5pkDdVBfHXp0A/F/6y+hTZhKTLCguF/uOrqz6+B4SEGAH6gw?=
 =?us-ascii?Q?ayJ52+5UulmiSfKRW1HELNTeGDYsGnLnAfYeQPH40roW+ZmkFuNmjtCZkSR1?=
 =?us-ascii?Q?lCVh9Je+6cxWLEB+bQwgBpBRVkUO9WGbmlZzwAA30Zrs0bwk+RWuOZBiLf7i?=
 =?us-ascii?Q?7xNqxAa4mVG8XKYUKoaxP+AbALjrtdEBbbUcbzKpd7h2sjjER7/fFquryjYx?=
 =?us-ascii?Q?Vm/SQ0N2MW2Kux4aFaEaZzYCK5cp0Nhn9S+nsNLwnysCzZCL1Lp3rf10yI7v?=
 =?us-ascii?Q?b44OP6bG5ec8rkn1fpxyebz6koWD8HjdRRHWZ+b5OBYRO2NBwT3Ntx+ldJbu?=
 =?us-ascii?Q?chXZuVGXipQUh6YtB5qw6T6e1WmWq/3h73DuKHXUyfjmqfT8+rJNUi3XV6FL?=
 =?us-ascii?Q?M2s4M2UZJjUpJbOB6hm1sXLP8TtIcZYwPxqUoloWyy0FYyDBmyisqwqzG5HU?=
 =?us-ascii?Q?jykiqerxroc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uNM/zaTRjczX87re1uf1ThAG1dYbxiWRRAueGtz6aEeGLAtPTJStBJ9ra3BP?=
 =?us-ascii?Q?OmXUv1fls4Zvw7W6am9W6Udz5loT15OhWcmgcP7HujCifIxnk+TvBd2J0BzG?=
 =?us-ascii?Q?eQ9ZUIqwHKsKe9UWLvvQRzJIYgQ3qzEFhUbBVDJdXSu9WKABtSo7A3NGdb6q?=
 =?us-ascii?Q?+1HuxmYxDqpQQSSj78WNVDqGdyquyTZKAbN1eMFxmCunm/RakaRQwPeGtV0X?=
 =?us-ascii?Q?yOdO9She5+B1F/07LxkTpOmX4qjZhrSvO8WGjVZc/ClhchCgi39E+lfm6FjB?=
 =?us-ascii?Q?m91/KEyNxX4BIk+wenQYMiLBeC8HBvg25RzcdWghnuGg6OaioJWRy3W69pfB?=
 =?us-ascii?Q?PwYVLtjiaCoCw1fGJKDggn0Wf27pnLzHQqgM1SY+AU12kiNOcVsdYw+ljud4?=
 =?us-ascii?Q?iQ9cRw8CePnRj39lFRZOqH/SK3IzrenERcYB7V3sRjrUIavHaoGWz97UK2tj?=
 =?us-ascii?Q?fdQOH1xeG3WUDjm5oUrwOfb7laxaHMkYwjmqvsP3VIcfUrXRBTWoZkWB1Esu?=
 =?us-ascii?Q?7FI+xQFuLjdRxgRss9jCdXoPoSj3RsoNzV+PNgoOIAmCktwTDQ2iO/7rKqjw?=
 =?us-ascii?Q?tRa2HKGNykovluSBz+tE9gTV0nR4z8uWvYImWK/wDE526+l0/ZT9FdepnPFg?=
 =?us-ascii?Q?0EA+bFXjNwhR8+jeIrwen3i0Onb4Ch8M/CKQwMX4tVUnDCglBWJduHtWRB3i?=
 =?us-ascii?Q?E7NBJj3kgDbSbksINQmnfyv1bo/oaqhvkfjrg+4WN9wdJvSaPU4Rw00qAUzU?=
 =?us-ascii?Q?V/bcU+DjTtkwwA6vrSM9k3zD9xpRxFehRFf5Z7QwRVJ+BzxZ5oOdxNYHYhgj?=
 =?us-ascii?Q?iYb78QDcJesxtzZqou4upbI4C3Xo8i385D153AIwUoh8AjZbqPsEbwYIZzIM?=
 =?us-ascii?Q?7s+kRLN170d4JwAiYzs4M2QCrhNXCU8IqLBw18cMTvljKuRCs6fHf/ce6snW?=
 =?us-ascii?Q?A2TIL5NqLbKNSuaSkDKhipV4r6ZBp27H5QUtHYJYvFhegU0dWkD4DM16PHxZ?=
 =?us-ascii?Q?6AH1giM9QIL3VGF/fCUI0Jm+6JfdgsXhVYEiWCik4YdYwjS5edfwtLBYb8XS?=
 =?us-ascii?Q?e0cz3d9JTLKm+v2C0p498iSddcUJF9zWq54aKwyAhxcg8/zgCzFgKmr6H2H/?=
 =?us-ascii?Q?WkPnxqQyrHZ7iFlv6R6B81wUDqFjQaB6eGfgph9zslWnT9xafgf20W7An+85?=
 =?us-ascii?Q?IlYpv56VSQhbD8kDoNpyK8KS4mlxxXifVpYPIVytpj5gMBN+pud97QH1Vgfe?=
 =?us-ascii?Q?JABqwGNEQw5Bq7DlreN7mFo3cOUB+i4tbdScDLLqBX3e9corKMtf63roJHKF?=
 =?us-ascii?Q?hIDOWGiVeu7qIVjMYlWU0cRQO+cig5cgIXB14VLlpt2OJ4Fq810+xTxN4lvY?=
 =?us-ascii?Q?HU2ZNLub2MFyTioTa7qYJuKUitz+u5rZikk9JYv9NnOMJKMGCZS3KznjxJCy?=
 =?us-ascii?Q?rDFmGqPD55x6ShiFn+fy6Bq8MI+NF2jKsITwRWtik/2dtOwXDXwmdO4ziNDj?=
 =?us-ascii?Q?I1A89nX/QioDTS66O2mFARD9ub83fDTauxSpMahsUtk7F+C6ty+zm57PkO9R?=
 =?us-ascii?Q?ajD/N6Ay2ZRFrFIKMQdsZlnYI3Ew0U2CM9U58Pd8zLEB1zUogV9GkxAUKr6y?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ob/yFzLwjpK7MLK4U5derFgndsHoP4DELgp2GsDpZNQisXKHE9WzegES5vcDKrjNmAKzOOCPCvD7P5tCknGQ2XW6BfFmZo2s9yaTbgd5opOCW3z6n7oWp1quesAvP7G7Psugh7viKIbs6yUtib2wEDxk5SLxGLu+A2Y0+dbDhCxS1GRXQ9KlHW+tbT3mla0SgKDLY11pR5Wh6khuh3Gtys2CM/EkTk3Ij9aOXsTzFaOI5GYL7JK9kMI9yNB2FFeoRir9fYSQXRn0h0XmqVgQsEgZvvVc37ZTKvFLmeOaZHW7nujSpFE1WY4zSq6pc5HPI4T+wDafVq4RVcyJpEG0tkELeLedtJyWYUN2P1W2GlKlrYWGUlAsOo2s7DgP5I27+PRWd5WnIC0jNBi9OdHgy0QMAzSGGdbMXtsteX8lfsH7h6ShjotC02vRz2zJG/MT8wZ5iAVH7+lm3igx2pLlAd7Ox90wtX3kGcZS9lERf92fXgW6n+bTeOwq8zZCmzwhmDMeB0c533EPIwjWovFiOiC0mrv2j2/PQdUTtp05/w8CdrGGmuH+1uQa+C24BGG/iJ2YRFB/+tHXdswpy8Y+9I0r5BSdhTRDb+ZTWRrKZmI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b61cbe01-266a-47f3-b243-08dd88d56754
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 17:27:10.1070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WzNVG1YJgq85mrw7WJeC5SGYzhvcThmDuMgxIgGITJQjMW9DfNyq+g4uJe46J+aKtIUC7F0LjWZF2lOBT5m5HnyIbOZZ1VxWleJ7gL+Hg+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6680
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505010132
X-Authority-Analysis: v=2.4 cv=MIZgmNZl c=1 sm=1 tr=0 ts=6813aef2 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=KWrF3PiNL9PbMbJVJAMA:9
X-Proofpoint-GUID: ejY946-6Z88RW-I00PnO0mZHCMYKkvde
X-Proofpoint-ORIG-GUID: ejY946-6Z88RW-I00PnO0mZHCMYKkvde
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDEzMiBTYWx0ZWRfX5nl3Q5ATJ+d4 LzrWlmy31LXy5I29QHakh4ID1g7L/nARFEdcptrZzHttSX0bgO5R9a4CbQ79fd2+UgkECzD4kvV 874bN23gda6uX8hFoJU/Dhmq3KMlMS5SNe2ku4lcvvjkNusbPdW8fpq3/O5Ue/YJ+GK3IzUdlGx
 iOaHZMiWoMyz9pdoykvaoJ70n70+giRke1hEFHUxh3Yu4hh/UNifn1B7u76sIsAKnuMS4bNjPOt Nihsj6IYMuELVeinLCZcrKwjnwypxLxDktRLnX2/zCJtcTTIfw4N4qVjTHsbKyMh1hS2CuxT08U wDbzcJSeDmL6ST3jvp6LEtPHSBtYO57Hm3jc32Lpt+H6jOR0mdjB5AONxNCw8LiX8YbkjGnVlXE
 l7eeUQ046/uuzqiHJjvBIeZV6G7pMtBoz/EujLOyLijIAsWnbQ4sY++pYgvRD2FPsiWMgBTM

We have now introduced a mechanism that obviates the need for a reattempted
merge via the mmap_prepare() file hook, so eliminate this functionality
altogether.

The retry merge logic has been the cause of a great deal of complexity in
the past and required a great deal of careful manoeuvring of code to ensure
its continued and correct functionality.

It has also recently been involved in an issue surrounding maple tree
state, which again points to its problematic nature.

We make it much easier to reason about mmap() logic by eliminating this and
simply writing a VMA once. This also opens the doors to future optimisation
and improvement in the mmap() logic.

For any device or file system which encounters unwanted VMA fragmentation
as a result of this change (that is, having not implemented .mmap_prepare
hooks), the issue is easily resolvable by doing so.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/vma.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index acd5b98fe087..95696eb44365 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -24,7 +24,6 @@ struct mmap_state {
 	void *vm_private_data;
 
 	unsigned long charged;
-	bool retry_merge;
 
 	struct vm_area_struct *prev;
 	struct vm_area_struct *next;
@@ -2417,8 +2416,6 @@ static int __mmap_new_file_vma(struct mmap_state *map,
 			!(map->flags & VM_MAYWRITE) &&
 			(vma->vm_flags & VM_MAYWRITE));
 
-	/* If the flags change (and are mergeable), let's retry later. */
-	map->retry_merge = vma->vm_flags != map->flags && !(vma->vm_flags & VM_SPECIAL);
 	map->flags = vma->vm_flags;
 
 	return 0;
@@ -2624,17 +2621,6 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 	if (have_mmap_prepare)
 		set_vma_user_defined_fields(vma, &map);
 
-	/* If flags changed, we might be able to merge, so try again. */
-	if (map.retry_merge) {
-		struct vm_area_struct *merged;
-		VMG_MMAP_STATE(vmg, &map, vma);
-
-		vma_iter_config(map.vmi, map.addr, map.end);
-		merged = vma_merge_existing_range(&vmg);
-		if (merged)
-			vma = merged;
-	}
-
 	__mmap_complete(&map, vma);
 
 	return addr;
-- 
2.49.0


