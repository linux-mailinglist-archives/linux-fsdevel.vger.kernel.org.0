Return-Path: <linux-fsdevel+bounces-45957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A7DA7FC98
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 12:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E16316586F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 10:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016A626A0A6;
	Tue,  8 Apr 2025 10:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CjZ3a6bp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="S17RWhr7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BDA22B8CE;
	Tue,  8 Apr 2025 10:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744108983; cv=fail; b=r/3c6iQu4SmhCBQAQdBtZ7B/ECIUlogZ5wxKimJSZVNQpHI15TsmEAaEjnIrme9uOmjRTqltPZ0EgZSt7cGorqVN3mHtzr+ztt4WPh/FGoEaJhfpgPf0RtWKbKtTUJ8KakwwYCfvTufXkBPs7U45ImuUNTpk64jGt6UDfE9nZyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744108983; c=relaxed/simple;
	bh=8AkaQr8WYXfEC2U/gfJs1iCWyLKb9tVvnjdo5dvbCYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t6sh0noQZTibAIkJXTSdvwiKYmPj9GgBRglNBh1V30rJENM79AuOONmRWMV2ClTf48RmOpd9j3W1JwQ0Upmcqb9K3fUTmvfxbAooN3KZOHWF5jXrmJyDsd06ttRfdhCzsla1SzbWN4QWLWa9v8vJ0xvCxyhNR37pEpJQg5x6Zbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CjZ3a6bp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=S17RWhr7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5381u5gE025697;
	Tue, 8 Apr 2025 10:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=QpUdZIa1cGL+CRVflFJyljcjY09NJGGTBUE6oGA3NFk=; b=
	CjZ3a6bpW9K3/D6CEtxXSnuTNuZuqDrxKMClgHGZwAjlO8hYEn2b9MiQ9Kf+O2e/
	SSKGT9dDZjkdi5raE3lh2/TUA5bFx4kU1kZdXiDvBbh0gATmy25CpsWf7jq1zChe
	CHNihXAF/BLANuObe/HVdUzInxaMRJwMzl2c2CjTrw09wojoNVbXPTUk5bhlvhjm
	EACapEA5MWNTkN3wBcS4kQHEPuGgOz1kfZZ/aPUZJEncCxoXjPGY2XmAwj+/aiKF
	JzHtk52pGfAjfjtUViKtKBGbBBCK1mVwsHJx+m9hCDcQd5TdpdvW08efmagCYIgy
	cxWU4rS9BOQdSGQYeoPLEg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tw2tmfaj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 10:42:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 538A6fsN001900;
	Tue, 8 Apr 2025 10:42:48 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazlp17011027.outbound.protection.outlook.com [40.93.6.27])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45tty93d71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 10:42:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2lhhz+Zqv642kb1oI1LVxsBVHxIgZr26ldWPpVwCB+snXsvmktZ2FtRQXWoK8KRYkoe+l9/RXfyQ9azC+V1KZeAa2HfXLt8YeMQ8Zmk8Ome+ROTLEWVql/apIsOBdo0sNKqtaGPnKole0Ghp1dHqW/OTJ1Kc9LUjm5cXuOeEiWog5kas021bIuinDIy6DIDQroyIkNei+4W3Cc7vbla7uGdDKbib6mYLr87jSFy9GMko6KtrF4bgMf+0abBABc9AdOwH2xJHsYWsSsKgUlnjsqJRf/iugpBL3do2f12tVMyKb9KVhrtgQ74rnmtf6ati6LoTHQBr94OufQqCEPkxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpUdZIa1cGL+CRVflFJyljcjY09NJGGTBUE6oGA3NFk=;
 b=EJ4riAOrpbRO8ExrOLJPs0UVypljvUS1w9/vV2/RWGWi3HErrTSEuolmqKWfb4yDGVz3+Z3WkJ+t1hFMo2Ng958DLnzCf0e0iAjSd/8DR5bchqx85E+x6KZySRTVz/mdk9sguUbWJh/vXORTf8aMNXLscBvF3zyRB8dm3imFGVV5dtpK7IJE1IcsPK1N8kCNVLIetPu4GpWc2Fjuslwo9BOtdD6InMCcqwwI67lLm+VEqbpZC8i3XrfYVv3Q0j72pkYDx690lPV6GYMRAQ7XCwRWLbmyte+9mrgLc8Jjq+2RMb9r0EhkIw0d0/3j/Zh6Rulpm+J/IhiypVCiRQtlcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpUdZIa1cGL+CRVflFJyljcjY09NJGGTBUE6oGA3NFk=;
 b=S17RWhr7L+Q5cA6fwB5lgBf2eBuepBY00yHtDRMKry3RcUR2jT5pWBjUOn8tybesPM3/oqK6HvT9kaiT22+Nswe8fZR5sTZ1LmrSzyudfdAY2/uxjuMldBmGjAZvbmU/1IkXg6+uI2lfVkN5ksWF8LC80/BYMAvPt7w82WtjMv0=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by CY8PR10MB6779.namprd10.prod.outlook.com (2603:10b6:930:9a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 10:42:45 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%6]) with mapi id 15.20.8606.027; Tue, 8 Apr 2025
 10:42:45 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v6 05/12] xfs: refactor xfs_reflink_end_cow_extent()
Date: Tue,  8 Apr 2025 10:42:02 +0000
Message-Id: <20250408104209.1852036-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250408104209.1852036-1-john.g.garry@oracle.com>
References: <20250408104209.1852036-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0069.namprd02.prod.outlook.com
 (2603:10b6:207:3d::46) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|CY8PR10MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bc1c8d0-e316-4dc9-1918-08dd768a18f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gQALbvq9Q9ZZ1Rz+yWPTVEPl20c4qPRwP0q8Cf8SsCf4H7QttObr4akikKXH?=
 =?us-ascii?Q?ypAptGQcEIqKTVWesJe5fxvNr+CAbS7kGnUjm/qV2MCECj9f+wwy5EvSeLVe?=
 =?us-ascii?Q?ZQCFvYOe6A4AkIAubmwT454aTkOJTcYnc9W3YivoW5JACaWQ8x1iQnnfShjy?=
 =?us-ascii?Q?XjMiujkXTXnnhiY7aE3rCo4LogC677KtC6qILKFBy3SwnXHm5HtEoah7iF1Y?=
 =?us-ascii?Q?RH+q/6RP56OfdPk5iQ6C+kcvbvGhL5wZ9lBv3JY++pV2KmOT4J3GkglV7pmW?=
 =?us-ascii?Q?p8LoXSu3VewJh4VGjXgJlO4xxAIz3XRJOleuu40+Yhf1YJ6adz6OTYvlRIsq?=
 =?us-ascii?Q?2A1vrT6Icurr2rzIvHMZqWNB0XHhOrp7HkcnkDd2aVPGIfWH6anvIETPIcBm?=
 =?us-ascii?Q?zMw5PASs+khIHi3RPg93uPWGa/5J4UMqnE8trpqrOiIV4902xQxzXJNLRgIj?=
 =?us-ascii?Q?SXvdrd0t/etVTjbhNgI6H19DwJS27nEauGG+GA/A4WuPQ2GOSYJH6qEG+AMZ?=
 =?us-ascii?Q?b5LV00eDpFjTvXJfcCOjUftTqhYpB+wMJpUrqEK178dWD6gyD5UyoJN/Be+u?=
 =?us-ascii?Q?Df0rEsI+XHmCgamGoxW7XhNDtbeIyVLORDwZ64mMCn5Oba9UqYAHiCqTe4+/?=
 =?us-ascii?Q?VmGhaNbveuZ+ewJyQ776Ej7M6bQj8ftsTBu48Y08siu1KhR95oGj3FbznHYJ?=
 =?us-ascii?Q?ZJOvBBOxYgDy1F3eq8Gxu5yGuRRJz2/LMIYrV7Rvk4vzarVQZ4fVYUknbsLk?=
 =?us-ascii?Q?l2XkoDIQQ7ywfFZM6IkYt5Qf8GAEh4WGp8TY/fn36SIUZOV6oHoCUynqlXlD?=
 =?us-ascii?Q?xiEB9BJIhtryxScWR/vky8AreQOCTeIFBwpsybiwurjbitQI9SN2NmPTrS0l?=
 =?us-ascii?Q?OtVUfDBq8vHC/WzGvyJgLhs8mVv2Zig/cpmCl1NtwnK9TjlHuAs4onjgELJv?=
 =?us-ascii?Q?TX8KtsOTcnQuE6xgHXiJwXG8/YXD0HTQ7roLFjnP5h2OCqDF7951zdEckddf?=
 =?us-ascii?Q?Tf3l1zUWX8GUIh+ewgBdpEhJS/0BMupWQsaTVgbNIGDCAg1ubi4SVklxi0C7?=
 =?us-ascii?Q?p+gaL6pXCA2lMg2e7IlWftTZ5thB4hjdgHFi3UDXoTKNcYpXqTuJQsK+tyym?=
 =?us-ascii?Q?GGybef+iGFcA4/VbDV0fzY64RMV9gCcLIUNx8uExsJAvqYPO8LokOs8gaU0c?=
 =?us-ascii?Q?qgFywftIBzxZafZo45fEKtBYT/M8G6diwybs8c4ecZqNnwhuljun5SR1GgtD?=
 =?us-ascii?Q?myhwIdX6asN5NKTVUiAKFTnj0drBJv27zmIaCtGjRUH33oQRb7qWgk+WlpAP?=
 =?us-ascii?Q?QXStAvf6+0bypdk/aoN6VVle3H9yw9MaCmebc0xv3NOq8YqPGn0XMSlMZCY8?=
 =?us-ascii?Q?xOPl5VDz5QbHLcR2a/3wqS6ZHzNI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eAPUmxQFzPUH5nyhkdyG/CU63dGqnp91ihtASyFB552z/2ef15MZQxluoF76?=
 =?us-ascii?Q?04ZXhUmGGelBb9JcvrloblJWhAPMu3nE/gkYutwjuVwG81V9UoIk55lHNfGE?=
 =?us-ascii?Q?Hd+jT2GhH87s1HDrrpCGj4M/Hn2mMMHmsukzUK0IDwRJCtb0mJwtCSJJKLO1?=
 =?us-ascii?Q?uu+YRmJyT+NkGw1Ua5tfo/vBIDeY1hyjF7Pw0r79/LgttKUFlbH7sZDjYBQA?=
 =?us-ascii?Q?6sPwu8EX/O2BG+d529C03iyXv2ugN6PYOCid37J+x4ktkxxA6YHVMwMJ6M8J?=
 =?us-ascii?Q?+tli2Mh0wpMkuB7nlqnCOZ2R8iNOhRmeZD9zntftcS9DMOz+8NNzqkfJur5K?=
 =?us-ascii?Q?jREGtjjeW+CH5t+vjJP1u4Nh85fOT4RXqOJaaQqExRbxRbBbBjOqLnKLumiB?=
 =?us-ascii?Q?C0nAP21pcBrhu3cnCD036wC+uwIzkgFgcp0GWnc4/Y1+cKzb0sK7Fdec1Kwm?=
 =?us-ascii?Q?ZdFWqRFH4Q+2vrqsH39w2z5otlylT1VsmdLGbUpgyFz3bQIGB1x12nNf8LWf?=
 =?us-ascii?Q?152BqlNRWCpx9ypM3C9sb4QVft293vi725sl/IpD4cYaLUhWrNYTnbAfpojS?=
 =?us-ascii?Q?5NwkbvhJsdHmznMVqXN2J1AjqZ6CBIjkx1ksndXN1RZ2Qn5NUEJxnH9xVLHu?=
 =?us-ascii?Q?77ce+6qb2fL/1RVeBD3WG2J9A//SnGOwbK86twTUw7LvdgYhS0BrE6CzlE5m?=
 =?us-ascii?Q?l3dXfdmpjioTxjJVZkqo5wYAstxMD8RdLoehnfsNgWECmkl5AaXNvlHwNCZV?=
 =?us-ascii?Q?ilJFO8lROzyZqVbW3iLuh/WPZmJYqjyp6Ab4hPp715J7U/9mVOdY/0Rq818g?=
 =?us-ascii?Q?jnb4aI1FbAtpmcSCQsCvRcR+kU2l8473Q8jOvG/phAanL89uxkJX6SDRDpFB?=
 =?us-ascii?Q?fM6m1szyHpEtnmPy1Rng/HjaodgWgvRs+ZDD9jVBgj0YkbWPtZCKbMXi9QDS?=
 =?us-ascii?Q?eOKdd59CB6SSxSQuZiEH/qHoUr6Aef/VL2ItEARNqHXTkiOxzcmc1QbBAFaS?=
 =?us-ascii?Q?11aFSPoGUxS70PW8HZAYm4qVb875miJHavxlEppY4QJjetvHgQ1yux2BIT00?=
 =?us-ascii?Q?wruO37d+HDM/c0p/h8AmGIa9Q6taux+0Rqb3LlcDk6+91RlX4kjFSC3D1Z2Q?=
 =?us-ascii?Q?9uV3RF4dpHJhIzvzPpc5IQ/EIVkcmpRj7QawuGh6xylIIvVWzc1lASdmzbAA?=
 =?us-ascii?Q?uk6yuyPCc+FGxSBaNwZVWUuBxmJ+Pm4gBLa9/FnC2vMn7owxQA5vIYkHo4zW?=
 =?us-ascii?Q?pSSMptSn9J6SRe8hkft0Ekw04ahLgwdVaDlN6ZAkwFJBZtdtvIBs9McvwCL/?=
 =?us-ascii?Q?0967P8PcIYq5NPzO/+TrNW2ZN9ZSx4ZKA1WU3C/GQzq1VL5wxkeW9DhTt+U0?=
 =?us-ascii?Q?anBM2hFlMla9hOlcmDti60YDT43TUhq5mOt5PpzmmgV1db/4wdaQPeA/0SdK?=
 =?us-ascii?Q?61e4PFv4RNUO9gwZytIDW8LheexD7diuKVHd9C/W07nbMISQnY7mJJww0+DM?=
 =?us-ascii?Q?k3vBrRTM3rANEAGupsuUiD1b9IF90cVmHzt31Bf35xp1wzBKhJ1EYhoSHxM4?=
 =?us-ascii?Q?aeYIWFCuMUqdQQVLVuHIrUVcFx4Qioa58GnECj8R9Tsi8zg2CLZnObUARbDl?=
 =?us-ascii?Q?iQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	K3a60Dd6gnyYAoDd2cnRcRKrGm3IGm+DqUIAwbGSGtxyW2lWAsVjVmMdXLQ33hoNjC28Z7FgDklM5io+aZEYYJFAnJVDNbaY2ehaAfIyKmX05Hg1YZmcwZJP7tOu1jFCEEJB6UivDNbQ4Nf0NS7HmxO5BUYTRtGmxDpz2nsdGg30KBFZcYgHfGjidIE8SUz0qsT6LlFVXICseprF3EbeTEqG/zI8z/vLC+C25iL0EfJxogAU+ZmX9VEOvL5bzxAM2y4JGlehCMkS7JtI/syZn+SZ3I3nNw6NnuCVhv1zKWQaV+w5fOei20ga4pbf1TrXlFM/0W1jxHVf7u/Ec+bRWOmNjq2A78AknVEZc+bv8xHwYGOHlP7K0fGCf4GJiecPuZDKEL+3oz8D/URsMCB9c+IQl7qwpd1MHQfN6NrObUNpPDodRAVAqpGWx8LaAGWjZe8F8TGh7XhpKJ8txZX/hYmEgT4JiMH8cCe9Dlm7jnGhZ+A4mtqrqGnY7YzSR9F40Z2CDAuGKyiNPszp9QRtS1h5wYa7djYNfv3NPna0uXJJuJP+orU7kRf7CP5eswnuqLihvwlLAP+ZzrFyjIMf36lS7sfuxsedHdaZ5n31u94=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc1c8d0-e316-4dc9-1918-08dd768a18f0
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 10:42:45.3617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CY3ocwRi0swPBOv08nSRLCFU4JfRkxLzB1is4MfzTCNumNNTRnBsx46IiamgMfG3gTScbOA+VbsloSKdCCMiWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6779
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_03,2025-04-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504080076
X-Proofpoint-ORIG-GUID: HgLrZ4oTK7iLcd7p7oOEPdBCbEvlepYf
X-Proofpoint-GUID: HgLrZ4oTK7iLcd7p7oOEPdBCbEvlepYf

Refactor xfs_reflink_end_cow_extent() into separate parts which process
the CoW range and commit the transaction.

This refactoring will be used in future for when it is required to commit
a range of extents as a single transaction, similar to how it was done
pre-commit d6f215f359637.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_reflink.c | 72 ++++++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 30 deletions(-)

diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index cc3b4df88110..bd711c5bb6bb 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -786,35 +786,19 @@ xfs_reflink_update_quota(
  * requirements as low as possible.
  */
 STATIC int
-xfs_reflink_end_cow_extent(
+xfs_reflink_end_cow_extent_locked(
+	struct xfs_trans	*tp,
 	struct xfs_inode	*ip,
 	xfs_fileoff_t		*offset_fsb,
 	xfs_fileoff_t		end_fsb)
 {
 	struct xfs_iext_cursor	icur;
 	struct xfs_bmbt_irec	got, del, data;
-	struct xfs_mount	*mp = ip->i_mount;
-	struct xfs_trans	*tp;
 	struct xfs_ifork	*ifp = xfs_ifork_ptr(ip, XFS_COW_FORK);
-	unsigned int		resblks;
 	int			nmaps;
 	bool			isrt = XFS_IS_REALTIME_INODE(ip);
 	int			error;
 
-	resblks = XFS_EXTENTADD_SPACE_RES(mp, XFS_DATA_FORK);
-	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0,
-			XFS_TRANS_RESERVE, &tp);
-	if (error)
-		return error;
-
-	/*
-	 * Lock the inode.  We have to ijoin without automatic unlock because
-	 * the lead transaction is the refcountbt record deletion; the data
-	 * fork update follows as a deferred log item.
-	 */
-	xfs_ilock(ip, XFS_ILOCK_EXCL);
-	xfs_trans_ijoin(tp, ip, 0);
-
 	/*
 	 * In case of racing, overlapping AIO writes no COW extents might be
 	 * left by the time I/O completes for the loser of the race.  In that
@@ -823,7 +807,7 @@ xfs_reflink_end_cow_extent(
 	if (!xfs_iext_lookup_extent(ip, ifp, *offset_fsb, &icur, &got) ||
 	    got.br_startoff >= end_fsb) {
 		*offset_fsb = end_fsb;
-		goto out_cancel;
+		return 0;
 	}
 
 	/*
@@ -837,7 +821,7 @@ xfs_reflink_end_cow_extent(
 		if (!xfs_iext_next_extent(ifp, &icur, &got) ||
 		    got.br_startoff >= end_fsb) {
 			*offset_fsb = end_fsb;
-			goto out_cancel;
+			return 0;
 		}
 	}
 	del = got;
@@ -846,14 +830,14 @@ xfs_reflink_end_cow_extent(
 	error = xfs_iext_count_extend(tp, ip, XFS_DATA_FORK,
 			XFS_IEXT_REFLINK_END_COW_CNT);
 	if (error)
-		goto out_cancel;
+		return error;
 
 	/* Grab the corresponding mapping in the data fork. */
 	nmaps = 1;
 	error = xfs_bmapi_read(ip, del.br_startoff, del.br_blockcount, &data,
 			&nmaps, 0);
 	if (error)
-		goto out_cancel;
+		return error;
 
 	/* We can only remap the smaller of the two extent sizes. */
 	data.br_blockcount = min(data.br_blockcount, del.br_blockcount);
@@ -882,7 +866,7 @@ xfs_reflink_end_cow_extent(
 		error = xfs_bunmapi(NULL, ip, data.br_startoff,
 				data.br_blockcount, 0, 1, &done);
 		if (error)
-			goto out_cancel;
+			return error;
 		ASSERT(done);
 	}
 
@@ -899,17 +883,45 @@ xfs_reflink_end_cow_extent(
 	/* Remove the mapping from the CoW fork. */
 	xfs_bmap_del_extent_cow(ip, &icur, &got, &del);
 
-	error = xfs_trans_commit(tp);
-	xfs_iunlock(ip, XFS_ILOCK_EXCL);
-	if (error)
-		return error;
-
 	/* Update the caller about how much progress we made. */
 	*offset_fsb = del.br_startoff + del.br_blockcount;
 	return 0;
+}
 
-out_cancel:
-	xfs_trans_cancel(tp);
+/*
+ * Remap part of the CoW fork into the data fork.
+ *
+ * We aim to remap the range starting at @offset_fsb and ending at @end_fsb
+ * into the data fork; this function will remap what it can (at the end of the
+ * range) and update @end_fsb appropriately.  Each remap gets its own
+ * transaction because we can end up merging and splitting bmbt blocks for
+ * every remap operation and we'd like to keep the block reservation
+ * requirements as low as possible.
+ */
+STATIC int
+xfs_reflink_end_cow_extent(
+	struct xfs_inode	*ip,
+	xfs_fileoff_t		*offset_fsb,
+	xfs_fileoff_t		end_fsb)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_trans	*tp;
+	unsigned int		resblks;
+	int			error;
+
+	resblks = XFS_EXTENTADD_SPACE_RES(mp, XFS_DATA_FORK);
+	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0,
+			XFS_TRANS_RESERVE, &tp);
+	if (error)
+		return error;
+	xfs_ilock(ip, XFS_ILOCK_EXCL);
+	xfs_trans_ijoin(tp, ip, 0);
+
+	error = xfs_reflink_end_cow_extent_locked(tp, ip, offset_fsb, end_fsb);
+	if (error)
+		xfs_trans_cancel(tp);
+	else
+		error = xfs_trans_commit(tp);
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
 	return error;
 }
-- 
2.31.1


