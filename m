Return-Path: <linux-fsdevel+bounces-45959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D41E0A7FCEB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 12:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D6233A97F4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 10:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4928C26AA84;
	Tue,  8 Apr 2025 10:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bgfLZrkn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UOd7SeEl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E4D26A0DF;
	Tue,  8 Apr 2025 10:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744108988; cv=fail; b=QbbibjV41Cqk/l3+T2C+oJx1sIXWE/BK7nrRT5mgvWmX+X3hF+PQ2/yHdkxeOri5DOXawn8XMENN4jRJSeCLZtdyo5yXUl22T0KlQv+8IeHQRIKb2swvC8FTSYN6E2g1hLeR12ZMATy8RTK15GaYKpfHjFN9TCecyPhfPDj0Jz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744108988; c=relaxed/simple;
	bh=tCLhW3SmDeqPqy0NfzQVxVwZ0QIWSIEgLzir2TkZSEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cFnoK8gG8TKLc0YP1XD2kOYepeu3aGpfQQu6kdNeigQLCmBk7v5jL6FgqWpNwyHz1TmidXqZ6feyE7j65AUANZcMz3ys8icyo3fX0b6KRY8TnMfZMw/t4nasDhZi6HjEgyrQqdp0QndXDTEFL5lka/jorQAGZ5CIZzkGHVu6+mI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bgfLZrkn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UOd7SeEl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5381unqA029521;
	Tue, 8 Apr 2025 10:42:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=QGUEX+k1c830+1cg9sMujhhw2cob7Q6KkVPAw/H4Ax4=; b=
	bgfLZrknWAeYUZ2D5Zn9Uqi91MwpvMlo7TWHJPV0nWmwxrHClkfb8fCkM43/EQl2
	i6Ox5ZCkAxznMDI0iyALLEd4dgnEl56AyhGDBlmxjLTRIuwbVocm27bQgxsUdLCf
	60ttzVCUW6umw76HpSbHjtVeIc7P1YzS+iN4pYZf+jo6NnPxvSNTkBAO6etDsD8G
	HHq6KfsPBcGumt0o5DSSJF7WzkuPVie2P4fzM6lxFKWR5Ruoa015G3ZPMdRiu34N
	py8KD5vvVKAXaIP0IRL+qDPzBzi7qndPePUuPCJtc/gTsZRMlHR1aEMpQoOIrpCE
	VJyHaG480CYgMTUHQdNi+g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45ttxcvf3j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 10:42:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 538AJTWL021221;
	Tue, 8 Apr 2025 10:42:54 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazlp17013058.outbound.protection.outlook.com [40.93.20.58])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ttyfchy1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 10:42:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LS5ePnQ3fBdJNBt9ORZ0ibLQjQP/BLMA6ia7w/cmbw52gmeGgDUwBAMS9UoF1fsL4VyozrpyapEvvSEawEWXHQav3xxTju315tv3X4jsr7wXNV3EFi7Fic4X0bYQpdMMfPguDkpGaTFfOE1ui0pjFsJAIpzwVAZuhuZ4XNdth72H23gagUIB8BD1csfpmjsZ17Dgfu/HhTGm/OCvo/WA6xvqz6kErnzX2VoMcUeEAl/IanYNPqR//CqSEX0ADfMbR16RGSOC4/r9ovfXqkjYvh+TBgzD7YCzZgAdb+6nzYn1jzfGMRK9QJ1/ouAr6S7K9xHY9xxhHIg0Cb7Tq3+L8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGUEX+k1c830+1cg9sMujhhw2cob7Q6KkVPAw/H4Ax4=;
 b=xwDOK3ZEjgpBdNOQaECUuksF+t+l01WH1YnyRW20ZBchxsSv8LquDaFvphpwncSZNZe2x35a7Fm0ieWFIW+JKBr3vEcCySF0zRzP6CofF2mKgs7Lr3ORrxPQX5XEMbHxog2jvIKghg8ZnRJ2R/MgNZvQp9ARgkQ0RuitOYrb6d1V2hyXH492F182Ex41zyJ+iGD8G4yiLVja81yOlKIG3reLnMEX8po6sjvnZYIfh0ulJdqToy7Lyy3WVb3vJKLRmen2YxCJPhr9JUX3JAuoH630uXJW5pWNKNnRWXwB85NVPfa0REzxSx3l2bG7BIcxhFZU70ZWJ10cv5mcr6tQFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGUEX+k1c830+1cg9sMujhhw2cob7Q6KkVPAw/H4Ax4=;
 b=UOd7SeElVWqGc8QexKBcJSkvsRlwloRdbEUy4pYFW69GPdnA/WAoAfLnYeecw0ugE3kd7DBV8dLqUAT9jgv6wELVbiYAjeXKLCSW+fcB9OCO6A9amYnWSPzs6hA6nk5QdDoUUIHtVaIs96LYaWrTt5CQN7+P8RMSqEye68HMziU=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by CY8PR10MB6779.namprd10.prod.outlook.com (2603:10b6:930:9a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 10:42:52 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%6]) with mapi id 15.20.8606.027; Tue, 8 Apr 2025
 10:42:52 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v6 11/12] xfs: add xfs_compute_atomic_write_unit_max()
Date: Tue,  8 Apr 2025 10:42:08 +0000
Message-Id: <20250408104209.1852036-12-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250408104209.1852036-1-john.g.garry@oracle.com>
References: <20250408104209.1852036-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0985.namprd03.prod.outlook.com
 (2603:10b6:408:109::30) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|CY8PR10MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: a0ebeb42-add5-4152-4778-08dd768a1d56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xGFSs+NuapPIs5VXvqxgPZyvdjCdEIpJCBf58/hhA0O1D85wZ1Jtr+Hz965Q?=
 =?us-ascii?Q?NQe8om7KKCsqaGt5/Q6Vq72YDrjJQrGAC7LcyvuLNy8fj0+P7pqPxaxeE2G/?=
 =?us-ascii?Q?oskr7wz6pbeSA8bfi9w5tsJPO2L/LXglA56M6mRSOVccTcJniBYzU8UuRFLS?=
 =?us-ascii?Q?xgM1L2Cb6bK6sg6qm8GnTadbb7L+ACu7LVrIm3eIYGWAf4gCCSV1oR4fyvjf?=
 =?us-ascii?Q?szxd8Yf56FYUO6IMVA3Ytr/na9zTesGnBJ6FpdHWS8/cLUa6so/roSsVZ/DT?=
 =?us-ascii?Q?hmI6VtDJ9//AlyLNkQQkwQkWu06CbLFHwb08rb8LmaFV/ONkwfMsqte40uT2?=
 =?us-ascii?Q?zsnjMdW8jlI42N68MsQSsbM2E1ss/sZ68Oyig1iyHJQ0N7BBLoXcHNwNDtq+?=
 =?us-ascii?Q?vR5BbOCY1dpU0SoUclzMg6TaRTXbdslNAAGbdPUlj+VcD689AiKTO74NoTbH?=
 =?us-ascii?Q?O0Pv6u017p8A1UuL/leD7MAWoUoexoQq9CEp9pXqoKjbZe1kHyUZV37PWiaO?=
 =?us-ascii?Q?R4ZOsqSrV/qauRJtlPDarJr6E555FTpns/6ioLiGUqWH67MBGhkh7/b9sOtj?=
 =?us-ascii?Q?L2Rp8Fh45YM2tAphG63Oc/0gD1hzuD56Bg426zi7D/PQW7DwUoVaSNJ0nvXS?=
 =?us-ascii?Q?6gQjvivAXJdR3EGP/DBEwaZrKVkpTJEOBemh1M43Vh01hBQL7ADcBz+6NjV/?=
 =?us-ascii?Q?sOla7LvH1WxdG+hOfawHxDqNusf+GoxR/3ouHAxF43OX0lTAFSaIEWsVIu/J?=
 =?us-ascii?Q?myLHi/pMJaTzpoRJL5ELiKFrtWhgjVRyWoeU0aaTWT1r46MWXqa9jwT9VVD+?=
 =?us-ascii?Q?vfKw33+w+2GcNJYAZ86eO065UKehw2NQ+0ghcn09dM7nrTlQxsrd2+G8Yzxl?=
 =?us-ascii?Q?FHKkTO0BOUH+s4kOlSEeZuoEitxaT96PHGFyKmGa85dt4vWS9LJNq1IETxTr?=
 =?us-ascii?Q?C42FibEa/iLigvJ3z+onKwNsr1GGCQJtJ++EUvAV0zy7l2hUymyUjTEPPXWs?=
 =?us-ascii?Q?yXUgU6bTjavINYhwphxP5ln5aXHntGd8DBbY+ubSBKBVwoP2HS8e1mr99WQf?=
 =?us-ascii?Q?Q2ACWO4pA2DfZvyWZkMp1dkLc3sZv3Oi2ducdsLJQkjQy/FVoQcjFw6jrkhF?=
 =?us-ascii?Q?xll+50uvQf4x5UkDvLgKKTLPjTQCvEGI909vSmoMDv/YcF2kPfH75iJ3WdQq?=
 =?us-ascii?Q?dB0uNx79rB0RJYxVDjV/PJvXtMNw1MSXAzM4/tnS1hskTrYAAOiBKiE5yY40?=
 =?us-ascii?Q?jdy35HnAdY/l+bhgDRPylTetd3z9MQ4Vj7wSqcGdQCSvHU/xuky0vnUDhpT8?=
 =?us-ascii?Q?rHDnuNUhjPJ8DsY7vn843T8btme0pcIDjF6ibedvT8gpU7HyifcdlM3MJtcN?=
 =?us-ascii?Q?/TfsJfYf4DakZgfwKxP79PSHHwg/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sl2JQ5SzdJ4bo/YEgCuViffZizUwFMk1IOgjMa6buYTEyJ00NtlBRIcK5VfW?=
 =?us-ascii?Q?au6RbJvJLk5VZEbuNrvPcFyRUPfC7IAZxvRQy7Hr5nr2SjXGsWKZBoPsnmQp?=
 =?us-ascii?Q?C4SlRheMJOtHDfrevdebrX3CA4V77HXMO32eOxgUxptn9LssRlDMd9kRF9wz?=
 =?us-ascii?Q?IgmKOZCvQsLTgI7gSSu04upa9garRCPrFNHm5RRDW6JBNFTKIC/bffrYk/yI?=
 =?us-ascii?Q?dBI/5X3pqiGb5H88hEC9/e8SgcvRyRial+S47zj9AMKu1itghisPxHYHnwOt?=
 =?us-ascii?Q?pLKvCi3l16doQhE7kkQ/l2VzFkKuB74YuKyCXrO7iM9b+XNxci4EavLy6Wyn?=
 =?us-ascii?Q?SYGHtf56OVFw22/jzTI/Vt3dv6BKUrycN81/Jj0UKYEsQdv6OBDsMbtSM9T6?=
 =?us-ascii?Q?8JSir41vzfH2nyPoLtCh7HVrG6eNpc9o7xLvdCT9HEiZh5ym/YHkPhydmlCj?=
 =?us-ascii?Q?IaIiJbRUVCqveqqHT4bev/lTVH/8xDuwJP/gWs5woy59XA/fMGBzgM9f1blG?=
 =?us-ascii?Q?Q9zIb0EUcjBT89SgFqbNYMGyqNmjxpqs+BUI+LT89OzGpLI2BZQ+Ta5uAIRQ?=
 =?us-ascii?Q?pGJn40E6yahNQRde5tGIyf9+mhrVdmJV3MBuhId49xltadLP/Q7l2cdlAktE?=
 =?us-ascii?Q?QOxH/re9RnGT8nV/zNnrdRjFoVJYPo//yBoXAX/hiwBM47/OQki2lIE61yL3?=
 =?us-ascii?Q?7c1dDlqIGLS/YIR5OdqhaOthxAtM2+nHGdFM8oBfGKoWJLyevHAc41qnjEgn?=
 =?us-ascii?Q?y+PclQ7IgffPVe6kHDAk3nzcUGhpWo2qSMhtD4oPo/7Wb7ozMG9VzU2IFal+?=
 =?us-ascii?Q?1nTOtor4waSjWqiuWLXnKFpXgPrO+h12E5u0IQxA/z2FML6ERt9YbsSpOF8p?=
 =?us-ascii?Q?alsswebgS+QCIML0rSpfUrViV4gJMEeoGVKOIrg8sx9Z21KY3/Uq951lg+fD?=
 =?us-ascii?Q?/j71FokqVTld4QBj3+K5sX/OoebUf23nbb06oq11Us+nlOAzN4Q7GZG5xZwa?=
 =?us-ascii?Q?9OMGf1ju7pAxeqetMilJC23jziJehFd90B5xMztiknxVuqcZ7vR7++hc1VsB?=
 =?us-ascii?Q?e4rr2YeesomHd7UiQ/5iWV6Td2jIz7TpYykZREzbz3qdM1c6Z1F7YV/l6yNZ?=
 =?us-ascii?Q?+qSfmzMUTuN/KCd7hlDyaIcdvfNi6eAmnr0dBHF8tPtGBgNmOpJJpsGr7E45?=
 =?us-ascii?Q?/4OIInwQadz+XwF8WyxC0QZOvJO/P7UrMykOkz7U5OXrT/GOquXnJi6+l8tA?=
 =?us-ascii?Q?SA8QgMEKT82XcJgCkBFQC+lylKA2swHgblmEnkap5pyX3xH5H02QrurCUAsc?=
 =?us-ascii?Q?Ecae2DvJiZ+aBHX705ICXcJzQhnQPj/Vu2a1ASSf8Wr7PW3BpD+qgdrEtasM?=
 =?us-ascii?Q?10Iylte83g2N+RfPr/z9N13pYNWmKw+q7Y4+n5MbM1m8de9asHcGbORdaWad?=
 =?us-ascii?Q?CTwxbLSRbDfUv6gG31fwwDxgF5bsA+yDLXPYS4MJJiUkFGuPDG+0B/Kp1sxd?=
 =?us-ascii?Q?QKKNrRUhFKy+uCloeHkDVxAPmFbuaVAtbjiONXA1+xOuJ8tznlXxloxyFVnN?=
 =?us-ascii?Q?HcG8ELQaMFNr9IGRQbTf4FizOvCRG66+mQqcI2gyehEU963iTaU0KfiNuTMH?=
 =?us-ascii?Q?xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0FzgH7/1tXxUCU6lNPV+c6Vb4WQD+5aZiyF3+0FjeDyeULizWKlt7h2KYEwISh45jsXa44paX/kIh5BgcMdJ2MnxNr4HwgLt7oE2x6fbvueMe81yBur59aGp6FAZZLDslXkOn2ViVW73sXL/5OwpJANuniCbd2Eo+Y5TQ65UL/j+xNncTYX4AYtpVgjwrVFD29Plgr/b/UL2SPUr9eW+uNbjvpRiyQ1H9S5x6uiPCCSZAXVqWZK9hQzgVIHhtBGEBHe1WUqRdgZnIR2rgLlsBb/Km99+9HnfCr4MCfMS8MdQcI35oBqrcBGKEejhWmJ0rqfJfWw6qs22+RgPZAz90lhA/Ni3i5ZxEmAPG8anWCBTXktBCp8+1+o4/XaGrBGvs08YvoLb08Bd9UKXZJBJwmdFelUZhjzO2wlaRTtwkHZVUlpeKH6jyDv/NeLTKWiAamVQssbbPO/E05orRlR5gAmyftQHDNsFMVX5PiE5SoGyJJ46bVViNs09W3CQfbeYP+FTAaobHnHwBFgvXwpdHE0FGNAduY0VdA7QxHXskHc4Kqz7QbwSwkAW3VEOIgGoWGxQxgEhtEy+yjA8HiYcMCXOo97QgXgorgglcYYuAF4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ebeb42-add5-4152-4778-08dd768a1d56
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 10:42:52.7798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3xT0dt3xmTpcpC18p9wsplhe12M5ogfgWU6qDY4QQHDzrKjbIhWlbvEDhQ4CI9dKz7i29vNU9mIWIHCuXqK8Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6779
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_03,2025-04-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504080076
X-Proofpoint-GUID: hpTE6Z_UzdRoNjIBNh67_SHwpkuNGylH
X-Proofpoint-ORIG-GUID: hpTE6Z_UzdRoNjIBNh67_SHwpkuNGylH

Now that CoW-based atomic writes are supported, update the max size of an
atomic write for the data device.

The limit of a CoW-based atomic write will be the limit of the number of
logitems which can fit into a single transaction.

In addition, the max atomic write size needs to be aligned to the agsize.
Limit the size of atomic writes to the greatest power-of-two factor of the
agsize so that allocations for an atomic write will always be aligned
compatibly with the alignment requirements of the storage.

rtvol is not commonly used, so it is not very important to support large
atomic writes there initially.

Furthermore, adding large atomic writes for rtvol would be complicated due
to alignment already offered by rtextsize and also the limitation of
reflink support only be possible for rtextsize is a power-of-2.

Function xfs_atomic_write_logitems() is added to find the limit the number
of log items which can fit in a single transaction.

Darrick Wong contributed the changes in xfs_atomic_write_logitems()
originally, but may now be outdated by [0].

[0] https://lore.kernel.org/linux-xfs/20250406172227.GC6307@frogsfrogsfrogs/

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_mount.c | 36 ++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_mount.h |  5 +++++
 fs/xfs/xfs_super.c | 22 ++++++++++++++++++++++
 fs/xfs/xfs_super.h |  1 +
 4 files changed, 64 insertions(+)

diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index 00b53f479ece..27a737202637 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -666,6 +666,37 @@ xfs_agbtree_compute_maxlevels(
 	mp->m_agbtree_maxlevels = max(levels, mp->m_refc_maxlevels);
 }
 
+static inline void
+xfs_compute_atomic_write_unit_max(
+	struct xfs_mount	*mp)
+{
+	xfs_agblock_t		agsize = mp->m_sb.sb_agblocks;
+	unsigned int		max_extents_logitems;
+	unsigned int		max_agsize;
+
+	if (!xfs_has_reflink(mp)) {
+		mp->m_atomic_write_unit_max = 1;
+		return;
+	}
+
+	/*
+	 * Find limit according to logitems.
+	 */
+	max_extents_logitems = xfs_atomic_write_logitems(mp);
+
+	/*
+	 * Also limit the size of atomic writes to the greatest power-of-two
+	 * factor of the agsize so that allocations for an atomic write will
+	 * always be aligned compatibly with the alignment requirements of the
+	 * storage.
+	 * The greatest power-of-two is the value according to the lowest bit
+	 * set.
+	 */
+	max_agsize = 1 << (ffs(agsize) - 1);
+
+	mp->m_atomic_write_unit_max = min(max_extents_logitems, max_agsize);
+}
+
 /* Compute maximum possible height for realtime btree types for this fs. */
 static inline void
 xfs_rtbtree_compute_maxlevels(
@@ -842,6 +873,11 @@ xfs_mountfs(
 	 */
 	xfs_trans_init(mp);
 
+	/*
+	 * Pre-calculate atomic write unit max.
+	 */
+	xfs_compute_atomic_write_unit_max(mp);
+
 	/*
 	 * Allocate and initialize the per-ag data.
 	 */
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index 799b84220ebb..4462bffbf0ff 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -230,6 +230,11 @@ typedef struct xfs_mount {
 	bool			m_update_sb;	/* sb needs update in mount */
 	unsigned int		m_max_open_zones;
 
+	/*
+	 * data device max atomic write.
+	 */
+	xfs_extlen_t		m_atomic_write_unit_max;
+
 	/*
 	 * Bitsets of per-fs metadata that have been checked and/or are sick.
 	 * Callers must hold m_sb_lock to access these two fields.
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index b2dd0c0bf509..42b2b7540507 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -615,6 +615,28 @@ xfs_init_mount_workqueues(
 	return -ENOMEM;
 }
 
+unsigned int
+xfs_atomic_write_logitems(
+	struct xfs_mount	*mp)
+{
+	unsigned int		efi = xfs_efi_item_overhead(1);
+	unsigned int		rui = xfs_rui_item_overhead(1);
+	unsigned int		cui = xfs_cui_item_overhead(1);
+	unsigned int		bui = xfs_bui_item_overhead(1);
+	unsigned int		logres = M_RES(mp)->tr_write.tr_logres;
+
+	/*
+	 * Maximum overhead to complete an atomic write ioend in software:
+	 * remove data fork extent + remove cow fork extent +
+	 * map extent into data fork
+	 */
+	unsigned int		atomic_logitems =
+		(bui + cui + rui + efi) + (cui + rui) + (bui + rui);
+
+	/* atomic write limits are always a power-of-2 */
+	return rounddown_pow_of_two(logres / (2 * atomic_logitems));
+}
+
 STATIC void
 xfs_destroy_mount_workqueues(
 	struct xfs_mount	*mp)
diff --git a/fs/xfs/xfs_super.h b/fs/xfs/xfs_super.h
index c0e85c1e42f2..e0f82be9093a 100644
--- a/fs/xfs/xfs_super.h
+++ b/fs/xfs/xfs_super.h
@@ -100,5 +100,6 @@ extern struct workqueue_struct *xfs_discard_wq;
 #define XFS_M(sb)		((struct xfs_mount *)((sb)->s_fs_info))
 
 struct dentry *xfs_debugfs_mkdir(const char *name, struct dentry *parent);
+unsigned int xfs_atomic_write_logitems(struct xfs_mount *mp);
 
 #endif	/* __XFS_SUPER_H__ */
-- 
2.31.1


