Return-Path: <linux-fsdevel+bounces-66344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB98C1C555
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 18:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F291565DE0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 16:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F4F34AB0E;
	Wed, 29 Oct 2025 16:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ntGV22Ty";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kcPpbEQu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A9D19E7F7;
	Wed, 29 Oct 2025 16:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761756691; cv=fail; b=kGhzViL0zPuzVtZyGnESKpny4wAkKSpzagrV6g0FzHsOIvyQn8AaaKZGvX5zqeFxCVPXO+WMqOSoKYhBCWcHFNS0fM6WqXtsV+BZNRaq6PacSiYJTiPOZhxL2NxU/Syn8e+tW2rA2vuG1EsKOt8bHP/hn03j5wgDhiHYAwMR8DU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761756691; c=relaxed/simple;
	bh=bomeT28G7JskK2jERGmwOkLyQUUlx+8UqQNQu6E1ay4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Al5WR7r1GH4JNX6ScVsvtWBAibd5gXqCSrgfh0aXc8fgmaWbx+LJ087hzvnEgqXFrvKNToC0cdgDXpoXjAri2O2Ozo4wVtg8ncNnN5af4DUis9SKmZN4IRVYKqm2N3AfbcdzKJSQjpm7D0zXd+CPKBc4KeRDba+8zXlryehHZhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ntGV22Ty; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kcPpbEQu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TGg2vD031999;
	Wed, 29 Oct 2025 16:51:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=K6/T38T5zZKTJldzxmf2c5KhA30BP48594uIkLQc4aQ=; b=
	ntGV22TyNKMELgEK+qrucRVEsBgSDg9uoy/nzd34G7LY9q3b5mnjQjbYMxiNjnRx
	wfOoA4ypI6pGdp11GfoP7M+1OzDtUAlAhsq+1Vwpm7fxdL6g9MHbrYekBPm1akWS
	15XtqeG6FbS7uq/bczH+lut8dBsvJnc+zwxmQ6KacL3/DOthLVGlgdCVJFhmVptv
	wFNnLAf6NgnIbeuKWok1vO8jxAy38/YlF13d8N7WOFz94RYWq57mDDBuqIg/mhn+
	jgIErhS4GMPMG6KzZvvifZua+5oTz82ZNHWP9ieqFBAW8TXkujhBdNcT45jaO/c9
	mEIev191EC7fGjOfeLO5XA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a33vwadep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 16:51:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59TFKAm0007621;
	Wed, 29 Oct 2025 16:51:11 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012056.outbound.protection.outlook.com [40.107.209.56])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a33wkfn4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 16:51:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DF3w/EG6OfwGHiQn5a9VjaQRxb1Mdhr/1z38hsSnv08yLZLBgoO4prxT32J7kpyI5kZIZY+Jl3TU2m8L9a8/sjFgJNTT0wHJLoE2GhxnDpp0FEBj3Xu4mXx894YkiIKJTu4c9tKQr8F42knWlKR4YMtWU7qmU2pPzXfFiBT7MZHtxchtgFc55B+Pt66gx5fvWKnhpYEXZ4dVk/AMOy7ZcfcoXiMCUBpfF4EK97K8sUGZy0gkMTbqtueViFkmIIr/EbnsrchY0Gh/ITdumZQsYziCRr17EdnBMWNKOYiEqLicDWEWaSNMEvkukcfJ/bphGPeCpITFknSAKSoGrPYj4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6/T38T5zZKTJldzxmf2c5KhA30BP48594uIkLQc4aQ=;
 b=t5TYxhUpTw8zK0LF/aLpTzkcebdmTOZy9l8nbHFR7zXZZT7obMluQKg1jEY8X8QY25XLLRYNFlTMeZd1wzDtyJ788EBL9JhML56Qb7yOgEuzG9q8iRgF6F7RL0gNBGSEC62FMjhqjoZ9yQCouw5A8+yR4CUSYxbtO78EIO4Kxh3FzM1ueuqIXskOMKfSQeoG1AF2nwuWwPx1PNTkJzGxlsAwhBc06npxwYrSsaXZIQ2fwNAaNXYaCEszjJRQzHp30BmQRzVfCHrGhADdLr5eog7DxZYBIZ5y2tZTaeJWYo6r9GfCk/uWFCPFeUdpsKd2iHen14qXNouu7KhqOdwaRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6/T38T5zZKTJldzxmf2c5KhA30BP48594uIkLQc4aQ=;
 b=kcPpbEQulxNwMUXX9oDecpDYAB4chBAZ6jty3XBvcu/CZTEs7JU7sQ7p0tWRGxxinCg2YO/aBuN0WB9EEJLHcJ+qzR+oDGQTaNCyNwmhlWEpqT5Nz4T1WTznNocuYuCqOiYN2CK7vUO5pRQFZ3xYLhSfBR8OXlLrfs33pQ+EEVA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM6PR10MB4251.namprd10.prod.outlook.com (2603:10b6:5:21d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 16:51:07 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Wed, 29 Oct 2025
 16:51:07 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCH 3/3] selftests/mm/guard-regions: add smaps visibility test
Date: Wed, 29 Oct 2025 16:50:33 +0000
Message-ID: <9e5ef2bedbff6498d7e5122421f0ea5ff02236b7.1761756437.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1761756437.git.lorenzo.stoakes@oracle.com>
References: <cover.1761756437.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0444.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM6PR10MB4251:EE_
X-MS-Office365-Filtering-Correlation-Id: 067fbad2-5786-4776-63e0-08de170b5b2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GKbyB0hhEJcSgPeZ5Tb3iCnBfyN4uaZdEPlgdXL1mzZJCsFeEgJj+HzpSBut?=
 =?us-ascii?Q?VMeXAp7q79bCxePqmCVZDBHLsdki+ql/bWMvF4QoSfwIQnQZXSJNf+kqQx3L?=
 =?us-ascii?Q?TIgAExOxi7gv+Fv/pt2yKbpu3aAamUNO9I0CWvKRO6UWT/gecQNcAZ8uWGEh?=
 =?us-ascii?Q?ezJBuW54srH4PAKiqYVwSNuiF1ySjpliZyuZU/DcqR7yyZEFlgLmL/xxwI9A?=
 =?us-ascii?Q?wG12LGC0R4yTQRriSy21q9ooDCUcXG0MvPmPnpt8B6e2Ef1uORmM99erjvmr?=
 =?us-ascii?Q?awZTfcLqSLh5oink4yU9nQwYm/nijHveYfK7nyJwP0utsSg4bwoJimtzNa1H?=
 =?us-ascii?Q?mP3ZMObn7Qqn0pODkQRl/mnrO+0469kie6z6ttgWCNNP7fKMlYXoh4VHOlkB?=
 =?us-ascii?Q?zz03LHOlQ8lIv8dYOKese+xYWV/tgTXaIEB7ntWGrWSwZFfd4i3wvBgewS4T?=
 =?us-ascii?Q?7rPK1CP2kKPV/YCm6hrhVkFCaIdJcc255/dSeCB7R+jYjqOYgUFDU3F4/WJb?=
 =?us-ascii?Q?K9h/9GAGBjBtU3tAScY/64OOdKk2Qd6qWTq88irAFF/kjZQCKI840H+tkMk0?=
 =?us-ascii?Q?VkKqPYXBLE5OIfvziJwmlvS2dUyyKncRHqISGuiEOEDwhd3nrWZHLYcLMs1y?=
 =?us-ascii?Q?OOX/2NvDkGQJOXukid6o7QFpEreCrlqJumajAv0MxHTjNshqLxIgxYFbcpgS?=
 =?us-ascii?Q?IFzBCIF83L2Kz5peGOv70U0//EPauWwID43DhDlJfwOCU80Cmp00UrMqJy7r?=
 =?us-ascii?Q?ONVo50AcogLz+sUdhXJr+Y0o2AB9Bsuc4sx+YDIUIsKxhrbLDiWc2jtc4lBP?=
 =?us-ascii?Q?QchMsRtc3dWjiw4KDRZ4wKCey+Cl8vhl9w6hQZNuZxlyQAsc/LryxhEH87qa?=
 =?us-ascii?Q?bT3WrfsaZhSgseiNuGh8jw3oxE91vWE91U8yVbvVaF2bmol/6QSlcQL364WD?=
 =?us-ascii?Q?2/h7lF+m62m1PjVarxpVgBuRZu4YEFbjEdoeKY9wYsJryaLaOMo0MXjcXzAz?=
 =?us-ascii?Q?F4ugPtHJ72mIn8KXIJFM2e9oYoGgWFpuV3RIWnoOkhcPV/jY2Pbv3H+z7FKJ?=
 =?us-ascii?Q?KuppWak3+m2jVLx2KHujfky4zzrOon4/qMpFEOZ5m091OjRlxiFVZXhKHHFh?=
 =?us-ascii?Q?6di++WPEH1c229aOCba2b7M/7rl+TyxSgqFyYBO87fv0DPzI7Os67vNjON9E?=
 =?us-ascii?Q?WYRiAynnSFvvZ3xUrBzTUXnZHzwQIa0tQoZGlTo+iXNMMYZmUWNX74/GzoFv?=
 =?us-ascii?Q?q2X9HLzrVUm8icEs5eKQq1W1dd3p/Z2cNgBwbWdx4tlgrCOXCl0SmLKjNgRp?=
 =?us-ascii?Q?Qe8IZ6Bz03iGibJJIoW93R+rh7wKduaj8BzbAg3IUKr4HECR27nelr4sf093?=
 =?us-ascii?Q?z8apgfnLlKDf4iX954k09EHDb/g6vfkL2ymaUarP7G5saqDaNIAdCUdc65Am?=
 =?us-ascii?Q?OcMOE5bcF8xqCdeg65AE6CkUoi031w34?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RS/HGl92E/17ZU+K2KZ3yFA5nc4NqUQUVo5G5ljshH4sip9F3lpsquDgnEO4?=
 =?us-ascii?Q?+lnXd6B1MIAYKnQ2WbprbIGX9/5VwZRZPp8MgoV8Tek0AMrUMntpveUgQleD?=
 =?us-ascii?Q?xOAnG8k40eGphDe6iBorFb5CGV50L3a0i+GXtjsvcpopaW5QDjoh6dnA5fHk?=
 =?us-ascii?Q?gr6MWSOLDUjQllkIiYHqQhYR5+gJjY39q4Esnrd9gcSD18fzHvMndnDtIuYj?=
 =?us-ascii?Q?S6Em7I4DkRIYYhS0hFHKc+hRtPrhZlJnMMzS3zfp2MYQYetfTZFbD+clZPz4?=
 =?us-ascii?Q?b/1lHNu8EtKUfbV4pO3vUyfaFm4jo3qcBNMUov0LqPR0pmbF+g2jCVmt1M35?=
 =?us-ascii?Q?KapFj7B8XTqg7xdeGmmULFNM5G4CxNVrD7stfk+5vEOzUuLljQvAfeV+5PGc?=
 =?us-ascii?Q?xHVEGc8G5r1UzzDy+vlSiS0nbXys5WuxVKj0ul0BegxIzaFnwOUMonSE4lRu?=
 =?us-ascii?Q?NYDKzOqrMe/08CMIYsF+SWo1mBUPsYoH5SiRCuS9DvrJgxdILHXCR8aGoz53?=
 =?us-ascii?Q?XBT8EgfLqTuyascjUMDZRBgyyiyDeja8exOrPO+4Z+uL+vtDjy/S7VJaY2gs?=
 =?us-ascii?Q?xz6QoXx3vw3TyvS4HGpltUj7dPLlCOmntdDcZ/ub/gcm0BauGZ5i61Q1jH4F?=
 =?us-ascii?Q?ebq11/ml8/Z3KaeAliPadMr+/eMl5CH6rt8NiM9kZDvxWblIBe3yfwhP8qNH?=
 =?us-ascii?Q?n6tzKUHzcusfc8Xf871vbIsqat9FuK25LotmsWCLHq00lUx17U05XRr95AKl?=
 =?us-ascii?Q?WA35NnUwpQRff1kw1rEc8XYMY6sR0573uqd7wjoo0aw4iZ6dsS3QGZsiLPNn?=
 =?us-ascii?Q?0KSRgfOmG5rU6XOLEekMFVOJqOj95pGjRTbT060nn8m6RNJUWJv/OLHYBQQ2?=
 =?us-ascii?Q?YvwOtGs6kZHWNcmV43o+dfR3QSlGIcD3MKrYgjWhDlRFGy6KoJwJ+tkYVUDL?=
 =?us-ascii?Q?+qfAVHQpnrnQ2HNTXiXgz/27rXcSMej8bpVmjY7jKSyCHAsO6TMXRBmLLGKG?=
 =?us-ascii?Q?KcjV0QHRmeKX2qfVxFb2Yv7cAiqybHdomTV+7HQ6JPXZtwX6/1od7JKgat/I?=
 =?us-ascii?Q?nPH2h+RqhzvZ8hBgjChWv93naR4ieqSF5/a84yo75UhftG7h375lhk2I8SiL?=
 =?us-ascii?Q?R1MLWkFyPUV+EWF4NUCKvc2vtN+q/5JXBInHf5weUd5qsJLYLsUSXV3q6F7H?=
 =?us-ascii?Q?ggAtlNMSdIhg2CevvAPaeo5Ym7Y/3E7L07mfa6g3UpQNyarkpSDuQOSF7wNk?=
 =?us-ascii?Q?eUmn4J6egtLP24PoILFRIT7dWElSyg2WNls7PbsDo08SxriU3rYa8iAsqJHJ?=
 =?us-ascii?Q?UVrSnfqoAWioEZNp5tOEilKiliZa7i8+9D+Wjc6/B5+GuYglTapnPs4jwMM7?=
 =?us-ascii?Q?iXpcxGecKFIqs13+QMwz7EtuCRfTFSj1cxLzgdHwNqIZt0uAtU/+yKiBAWZJ?=
 =?us-ascii?Q?EzJ0jz6VmqG7oje6I/PZbDqKinfXdB9fsL5YQ4RPvPRn2xNqT1/cnGL6gf1W?=
 =?us-ascii?Q?1GIMKswBgujNe0UgRH0LocUoYsq0xPzMLvHzMIOhqtOHjg71NdxDxy9d8hKP?=
 =?us-ascii?Q?erSgnEJskE6+dxB8/EaU8as/NzcLrjrQWqR//LBSg0shkUOCVNgPc9BaDbjZ?=
 =?us-ascii?Q?0g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	K943yfw8R0/U0uHs8s7sZZYieE6Xk/tXmr2EcxpAxYyJqI60D6WaczGHuv2cKXH51ndfNNSC0knM3Hgvs5ZPJEZI0Abq1guOeev5wm6qgA3JB9bpFlx+9BHHgcePJMcdvp3NRFhiS06gbiQau9fA0sTjQG1/qjbOFjcvbajCFTRJA4ZhT6SRo0XX2KBsDGtJxOZQ5sdfMJAj9y+g+mI1fSJAxu4wE+berBhwDy1BF6bpvxKNi1NXPhHOMEFbjUjiv7GOLesL6Bk2lEhMcnQ7FQp8B6E+UhnpsYmvA2clC57luCdXjDDP4Xe53rwWtVzdbVFQaWfo+1MGdEWyyShD3j8mZ8FTljuoJo8XsU7QtazYkXQDcjVar3WKOIXSj08jOY2CwO17AjK0s8sY/zevyfOTOePhGBmnLMZdXaOaJJF8j/WWFKL0Y6V/1u3ndb4BuNVQLJxUQKxo/WQM2Q1TeajJYLOXnuuhPU74AOS/DqdD1HbLO2tDjL2OJ1zOnYSyrIoRcPdaA5IS1pEaSZRQW8lYdCSABUEWxrg1B9a40La93IgsYujtNsW6vPS3UhGnG+hQ1VwPHajRCdfYyoDhRrSWdrqQN02m/3e2FTII4RU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 067fbad2-5786-4776-63e0-08de170b5b2e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 16:51:07.5605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GdgKFveNDI8PxCA38JyMBj7hGjH6Bs4ShUrPMI+zg065lbThUSHgtGSSmu4XzomQt03QZZ5QHSF5kk+818pSI7m9EaruxTj0tSCLOn8l2vw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4251
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_06,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510290133
X-Proofpoint-GUID: 8LEMMgbbRmtdVhS5_RYb5042Y5dcnxyb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2MiBTYWx0ZWRfX3CcNEuCvdZjK
 jFYLsrNh38OhMasI/5G9MYddJWsAukSCIwYBR7vv//x8Wk9fWAbHwFv7jef4+SrtM1DqPzgLHEH
 b9V8qjpFbu5Z4tdApwMwNiNXvbmSefh1NZvhXPR6+HqUeVal3+XOgwEQ9RYgWlaQJb5FmT6ctAl
 zWtYWpLWGMwwFGyFD6yuSg2Cw3fFWAoBUdD5/hZqqWakuXYEh3NpMUwUKhG8RYBD6OIyyGW7yOn
 O2mJ1LMdNVXm64cGzXEl9qfWsjboQVAE4QPHCJQPRcNBHi3ovllHCDUhQYf/8jJk62Fc8n+1aci
 5wySc1utYzNn9NSOxhD3ileB1c7D4y5fD5kuZuVYaO1CV5SQ5npqdkaINaLH5A6B6gef7YjGvjW
 hGX20wLmT9pla0RvBTwCT/cVLfWt5g==
X-Authority-Analysis: v=2.4 cv=Uslu9uwB c=1 sm=1 tr=0 ts=69024600 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=7oKVWYA_E11v4TV8rOgA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 8LEMMgbbRmtdVhS5_RYb5042Y5dcnxyb

Assert that we observe guard regions appearing in /proc/$pid/smaps as
expected, and when split/merge is performed too (with expected sticky
behaviour).

Also add handling for file systems which don't sanely handle mmap() VMA
merging so we don't incorrectly encounter a test failure in this situation.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/selftests/mm/guard-regions.c | 120 +++++++++++++++++++++
 tools/testing/selftests/mm/vm_util.c       |   5 +
 tools/testing/selftests/mm/vm_util.h       |   1 +
 3 files changed, 126 insertions(+)

diff --git a/tools/testing/selftests/mm/guard-regions.c b/tools/testing/selftests/mm/guard-regions.c
index 8dd81c0a4a5a..a9be11e03a6a 100644
--- a/tools/testing/selftests/mm/guard-regions.c
+++ b/tools/testing/selftests/mm/guard-regions.c
@@ -94,6 +94,7 @@ static void *mmap_(FIXTURE_DATA(guard_regions) * self,
 	case ANON_BACKED:
 		flags |= MAP_PRIVATE | MAP_ANON;
 		fd = -1;
+		offset = 0;
 		break;
 	case SHMEM_BACKED:
 	case LOCAL_FILE_BACKED:
@@ -260,6 +261,54 @@ static bool is_buf_eq(char *buf, size_t size, char chr)
 	return true;
 }
 
+/*
+ * Some file systems have issues with merging due to changing merge-sensitive
+ * parameters in the .mmap callback, and prior to .mmap_prepare being
+ * implemented everywhere this will now result in an unexpected failure to
+ * merge (e.g. - overlayfs).
+ *
+ * Perform a simple test to see if the local file system suffers from this, if
+ * it does then we can skip test logic that assumes local file system merging is
+ * sane.
+ */
+static bool local_fs_has_sane_mmap(FIXTURE_DATA(guard_regions) * self,
+				   const FIXTURE_VARIANT(guard_regions) * variant)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr, *ptr2;
+	struct procmap_fd procmap;
+
+	if (variant->backing != LOCAL_FILE_BACKED)
+		return true;
+
+	/* Map 10 pages. */
+	ptr = mmap_(self, variant, NULL, 10 * page_size, PROT_READ | PROT_WRITE, 0, 0);
+	if (ptr == MAP_FAILED)
+		return false;
+	/* Unmap the middle. */
+	munmap(&ptr[5 * page_size], page_size);
+
+	/* Map again. */
+	ptr2 = mmap_(self, variant, &ptr[5 * page_size], page_size, PROT_READ | PROT_WRITE,
+		     MAP_FIXED, 5 * page_size);
+
+	if (ptr2 == MAP_FAILED)
+		return false;
+
+	/* Now make sure they all merged. */
+	if (open_self_procmap(&procmap) != 0)
+		return false;
+	if (!find_vma_procmap(&procmap, ptr))
+		return false;
+	if (procmap.query.vma_start != (unsigned long)ptr)
+		return false;
+	if (procmap.query.vma_end != (unsigned long)ptr + 10 * page_size)
+		return false;
+	close_procmap(&procmap);
+
+	return true;
+}
+
 FIXTURE_SETUP(guard_regions)
 {
 	self->page_size = (unsigned long)sysconf(_SC_PAGESIZE);
@@ -2138,4 +2187,75 @@ TEST_F(guard_regions, pagemap_scan)
 	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
 }
 
+TEST_F(guard_regions, smaps)
+{
+	const unsigned long page_size = self->page_size;
+	struct procmap_fd procmap;
+	char *ptr, *ptr2;
+	int i;
+
+	/* Map a region. */
+	ptr = mmap_(self, variant, NULL, 10 * page_size, PROT_READ | PROT_WRITE, 0, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* We shouldn't yet see a guard flag. */
+	ASSERT_FALSE(check_vmflag_guard(ptr));
+
+	/* Install a single guard region. */
+	ASSERT_EQ(madvise(ptr, page_size, MADV_GUARD_INSTALL), 0);
+
+	/* Now we should see a guard flag. */
+	ASSERT_TRUE(check_vmflag_guard(ptr));
+
+	/*
+	 * Removing the guard region should not change things because we simply
+	 * cannot accurately track whether a given VMA has had all of its guard
+	 * regions removed.
+	 */
+	ASSERT_EQ(madvise(ptr, page_size, MADV_GUARD_REMOVE), 0);
+	ASSERT_TRUE(check_vmflag_guard(ptr));
+
+	/* Install guard regions throughout. */
+	for (i = 0; i < 10; i++) {
+		ASSERT_EQ(madvise(&ptr[i * page_size], page_size, MADV_GUARD_INSTALL), 0);
+		/* We should always see the guard region flag. */
+		ASSERT_TRUE(check_vmflag_guard(ptr));
+	}
+
+	/* Split into two VMAs. */
+	ASSERT_EQ(munmap(&ptr[4 * page_size], page_size), 0);
+
+	/* Both VMAs should have the guard flag set. */
+	ASSERT_TRUE(check_vmflag_guard(ptr));
+	ASSERT_TRUE(check_vmflag_guard(&ptr[5 * page_size]));
+
+	/*
+	 * If the local file system is unable to merge VMAs due to having
+	 * unusual characteristics, there is no point in asserting merge
+	 * behaviour.
+	 */
+	if (!local_fs_has_sane_mmap(self, variant)) {
+		TH_LOG("local filesystem does not support sane merging skipping merge test");
+		return;
+	}
+
+	/* Map a fresh VMA between the two split VMAs. */
+	ptr2 = mmap_(self, variant, &ptr[4 * page_size], page_size,
+		     PROT_READ | PROT_WRITE, MAP_FIXED, 4 * page_size);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	/*
+	 * Check the procmap to ensure that this VMA merged with the adjacent
+	 * two. The guard region flag is 'sticky' so should not preclude
+	 * merging.
+	 */
+	ASSERT_EQ(open_self_procmap(&procmap), 0);
+	ASSERT_TRUE(find_vma_procmap(&procmap, ptr));
+	ASSERT_EQ(procmap.query.vma_start, (unsigned long)ptr);
+	ASSERT_EQ(procmap.query.vma_end, (unsigned long)ptr + 10 * page_size);
+	ASSERT_EQ(close_procmap(&procmap), 0);
+	/* And, of course, this VMA should have the guard flag set. */
+	ASSERT_TRUE(check_vmflag_guard(ptr));
+}
+
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index e33cda301dad..605cb58ea5c3 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -449,6 +449,11 @@ bool check_vmflag_pfnmap(void *addr)
 	return check_vmflag(addr, "pf");
 }
 
+bool check_vmflag_guard(void *addr)
+{
+	return check_vmflag(addr, "gu");
+}
+
 bool softdirty_supported(void)
 {
 	char *addr;
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index 26c30fdc0241..a8abdf414d46 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -98,6 +98,7 @@ int uffd_register_with_ioctls(int uffd, void *addr, uint64_t len,
 unsigned long get_free_hugepages(void);
 bool check_vmflag_io(void *addr);
 bool check_vmflag_pfnmap(void *addr);
+bool check_vmflag_guard(void *addr);
 int open_procmap(pid_t pid, struct procmap_fd *procmap_out);
 int query_procmap(struct procmap_fd *procmap);
 bool find_vma_procmap(struct procmap_fd *procmap, void *address);
-- 
2.51.0


