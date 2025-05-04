Return-Path: <linux-fsdevel+bounces-47996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 168ADAA8526
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 11:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF2843BE5B0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 09:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7972F1D9A79;
	Sun,  4 May 2025 09:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qHUy6/FX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ll3JYRg7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07314199931;
	Sun,  4 May 2025 09:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746349230; cv=fail; b=ixpCAZZRZ/lB3RHSLUzLNhZwcg/1fXdavuXgAyTuo0RI/i/DcVT8bry81BL8OSxGO5fNHe4rBdOWCcFDEiJ3Wi3w8VFeuBh0VpRwdceQCNjD31v07R4jZiNmtnTfDp5WFWBNown2OXdfaZ3ddGaUbAmhBx38Ed97koATjyyHNOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746349230; c=relaxed/simple;
	bh=9VFmvw8VF1chdP8OjAH5HxqGEv1269P9oeW+EWcQoRk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GwDtCWDzEQNwBByBhgO0QjOFVYPpdMHA6ZVE7vJjF4weJnAmhkFey8Z8839yznZo0R7z29kCOAYG2JX2NN0Lup0o25EACcI5WFsASPKdGiU9JQSnPtBXsmkkUPB46vedcc3WhPUZ3blyj83R9wdpZrjcaeq4tq01GOWtDMvTMwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qHUy6/FX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ll3JYRg7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5448M51Z029823;
	Sun, 4 May 2025 09:00:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=j9xxB5gxSLG2TwhErVZly1cUqbdL0R17BVPJ3uUQ5Ys=; b=
	qHUy6/FXyN8W6GUs3FmUCzNFfTxbO3+Q53ARM65Qng3U9jEXdY/3LEeA/P7ouQpb
	n3l776Ro6TIho6c3Kd4q7rllvOlXzcs978JKlC0JqBwA++CPtuExMfF9H+nI3tMj
	n6jvwIlp8iTuNgC7sbSU4nA4kxCuTD7a/pMfmkxCFI6uO9Od1YvZwpb0f0k5LzUx
	FYisZv8zb3fjjqxCc/Di6O1qex550H63OjFrbtnwv/3/9Eb4pDq4rYneVW+8wa2I
	q0HpKsHeoiQCOqrJnCBbrwQgMANOgtLulId6qSxvoo9kS3GjJny/n44nad+psh2/
	x1Px7V3Wi9p8aVOMv4qHbA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46e4nqr10v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 May 2025 09:00:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5444Nu7E035905;
	Sun, 4 May 2025 09:00:13 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012055.outbound.protection.outlook.com [40.93.20.55])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9k7ghqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 May 2025 09:00:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ib3Bbn3V7PeGuPGb1PGn7q+krttQOLzYY4cnRoBPFBPZR2Ex2A9r6uc2Eyndwn8Sri4pKHEWDU3Uxt1qEnhTymjzJIJafipLNjiuxILFMZtPkhhrLd8AzTD1afzh10XPUf5k3vRyCc3I5zH5vldxEyYNAYIkcRtQXTcscj+54buWQA62018ddoJZwPbaIbyVCKP+TPfPEC1vV0VTjl8WwZva5Q/8kV2BXrjKbIiVUVsWvXXSZ9p3CpeCpKotoq7+unV4EO5Md6U4sm3XUQcCvC9NUnRyRP/h5/CEwa6khBOw52FkQgw1wLrFFiVkKUnoN1AYQjChX0CDBVe4Ttl1PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9xxB5gxSLG2TwhErVZly1cUqbdL0R17BVPJ3uUQ5Ys=;
 b=C8t82WQCZpe2QtGzxzw6ukipZZtyO9B5UyR4AWsYarao9uIjVfc3voHVSiMsIuZ5z9+PF2pN/T73VC3ELp81PocBQepfEc6hlGQ300rsqmd7nkbdv//d56Otioup7GhK+xEb+UP/Hrw0sJT0OIQE7KH64aHfwPxBH2iXEDuTLwbEFbnjz8EdI7ig0gTAcg8whP1eF2xVbzumadEbF67K9/xeDkq/eW7iARkJitoaTxqHMp/w0m9cPYNRaeYF1Ft1be6xoR7Fa44gYp8Z4wABnFEOFi9MF2/HT2zi9SrcmSTaNmcbwk/U0YkIBLpvoELLEk5dmjniEuILQpKKpZ/11g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9xxB5gxSLG2TwhErVZly1cUqbdL0R17BVPJ3uUQ5Ys=;
 b=Ll3JYRg729Q9Le7sKZzMvI4z3VNNnOqqkuy4JXyg7MhBJ7iGJLAo/ANXPjcGJTFJ00koC5Eypf4lFffvoC3ho54utSK3t+GDMGD7X19eoBcV/mpjFtqn7jTa/Y8eZbYqtmp7xpYb2MvKO6HmvLnzl7XB34MHFY4JDrgkFOBPdqU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB7178.namprd10.prod.outlook.com (2603:10b6:8:e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Sun, 4 May
 2025 09:00:11 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Sun, 4 May 2025
 09:00:09 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v11 11/16] xfs: add large atomic writes checks in xfs_direct_write_iomap_begin()
Date: Sun,  4 May 2025 08:59:18 +0000
Message-Id: <20250504085923.1895402-12-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250504085923.1895402-1-john.g.garry@oracle.com>
References: <20250504085923.1895402-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0030.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::43) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB7178:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ec48e69-afb5-4fc4-68ba-08dd8aea12b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bVvdq85UK5pX4+sBOo1v7yDNLY7WeHxTRZ7/TOyuJMAgteZuuwocKm/tahyp?=
 =?us-ascii?Q?y53klhYyYiqakQSEeQYcqXktbZXMsaXtAE9GBTLLJB8F9olNT9w9yGTt8Y0f?=
 =?us-ascii?Q?MnhpsO7q72s4NucrLrC6vAUMyBELFwqb0hZIlnWUAMuxvuBGLcPl/kTXUGFL?=
 =?us-ascii?Q?DVKsRlH7MyOHCInp7isEPcnKVwHnj88h4LK0d94ADQmQSMceQxDZuymohYmv?=
 =?us-ascii?Q?9fdZ55IlSxF8rfbFUi2k/XbTplqjHs3wBxSasHONnfI0XGT35hB11rZghpGf?=
 =?us-ascii?Q?IOOW1EZd2/aYeAyCDWOzzKbsZtnChfbr5J440GcpaSb0MwgBhjUhpIiEe+GQ?=
 =?us-ascii?Q?s93oIFjEnHXegt+Vp8BjtRgRPF2xTkF+Ch7NUXVzG1AJfORSuS3dTCCpxM5q?=
 =?us-ascii?Q?vEPzj6m++JBXmRW8T7AAc/loC9sjREYPI0LPRPVDr5/meAcroSkmzD4NVDdo?=
 =?us-ascii?Q?TpHiyG5PSLwBEQ7f05Ir1ZjLlMXNS4uOHFL9mQeYLNWgItjkBaa6XAgTsCWE?=
 =?us-ascii?Q?oXkxDkLVMtHzA9/lTRzKjH1n7TZOkiskE+xFhf+gA6MLi7eQq7JQcip1QKK3?=
 =?us-ascii?Q?ReMsiySdLUZmPLqiSjd8U83zSorgTvEh3yTHcQVd7Gg9/suTMQt7K5z9Lza/?=
 =?us-ascii?Q?jIJec/NrVRANkFXkZzk5fvlB0NB0tKGQWJzhgc4+nvIJ5Xynx4JHDof3f0GM?=
 =?us-ascii?Q?TL2KhcD2g3j7oZx7/SX62B/P+wAmqa9E/iv61rL/cKUIDnpjO/t8rEHWn1zF?=
 =?us-ascii?Q?e6pvD45q07MURN31EntE212M2L4I1QJW1K0WgDjUGm++GezuQQPxcAeu+2Xv?=
 =?us-ascii?Q?GW4hcd82lMZXuTkthkqpzMWapH/gvzl6u0Rc0vqyeRscyeF6M/YUW+0Objdi?=
 =?us-ascii?Q?SDHS8a5u6qUUReXsPlq6uECY+rL8s+1/SgOt6UXT5UA9Q3Lo0BonwhhV3xTe?=
 =?us-ascii?Q?fnvL122Z4M4SgbyUt0RGBaAAykOoX4QPDB8cH25gLjTI6SzbaYuF7yhEWw/X?=
 =?us-ascii?Q?S4EgnmK41deO+obgLUER1FxVqT8UZFhj7kZRRnSV5a2xIKWrzbbHit8lIXdO?=
 =?us-ascii?Q?uB0Z3XZ9BFeyveu+UKzS1JG034P6hTnI9uc6a7AhGx5SzRUOxeiA9Nch4XGT?=
 =?us-ascii?Q?FGOEF2CLU5TTaiOUJdPs0kEnLdUeSlbH4jCCNtIOfEClHWQ8DpDpF6XpLO9J?=
 =?us-ascii?Q?KnbbUtO2IMSoMd6G/krbDFOyThP8hYfsN19zuhGXjs+fIb81dUkTRQeD63xQ?=
 =?us-ascii?Q?6FE1YrtXcLkX2r/0cvNzrOuRJvrTp/TKk+70PWREtjxrXPEQ28cF5RqspCFR?=
 =?us-ascii?Q?Wdr4gRP8hnZpjNWZ8U9VvyRVc2Ybuy2jt3dUXewko7KLdt8fT3JytIkRzlXL?=
 =?us-ascii?Q?0kDLaLSSLXUy9wZGJUW01kDJPHFz86KvWcK4nJEw0DnzAlhWKZTGxIBF1i79?=
 =?us-ascii?Q?KrCRpawLPcs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?02yqzo2tJD6JVRrKx9yVSU01i3gBKHnqCz8rB3m1qSkyJUtjW4SiKVUmBKUq?=
 =?us-ascii?Q?R/3CJYmyMN0Jn/HLz+UY4J7Q45m6H3GNh5UH5Jrhgn+WfivkHYax7u0gMmnx?=
 =?us-ascii?Q?bzt9/Kwv5yBFK4ZNbpPAUt+/fSJU/ue4rtFpLtAPQP69EC/Tntr76yzU31fi?=
 =?us-ascii?Q?zRCASaiEnPbTcZT0V1YVhvRYDZsh7wnUnFzwaZVgh5ICogHHQdMVHEEfPkvr?=
 =?us-ascii?Q?qRjCy4uuhQVeRhEDqUqnjTuP7o6f/1LDnLgDQL6jtDOSpATgQS55IwiQ8lA4?=
 =?us-ascii?Q?7t8meDyjxD+cpDLnPV4eBbJJTB4bOy/OOZs3elIqKZe4Cw+8On38Pz3O84Pj?=
 =?us-ascii?Q?bzuxX3+6z+JUI/DMESRet2UWAiX/7HOObg36Fl3m2LYOf0+WhMh/zToSsDlt?=
 =?us-ascii?Q?UuHj8Vt/g6IN8EvVtoEQjcF7MDr4cS6AsTNawI0yG/TPupSjAPq2TeNHnfDc?=
 =?us-ascii?Q?IiE0HA87VnX6z8YKlb+nuypJKJA4B4q94hnfi+ol9ofVbBbJgQtjzdAKcXnC?=
 =?us-ascii?Q?Tuw2wAAE2YTB16hoKMO86YdRyzbUo0c99y4TmET04kCqniNYaSOjBhA8Uqca?=
 =?us-ascii?Q?ZxqbVdn1sJE0CUWRp1hHOeDJxbqtnaABRx3pAlgX33b9JyEUu9DS+HG/OSN5?=
 =?us-ascii?Q?uaRH0DDLtUPSh2GWM9B+440+US04kvlYFp+oW4GsfYYYmFuOQhsK/b0Tc58M?=
 =?us-ascii?Q?iGoyGDk09YgbxqgHa4H/a7Zu/vcv0NtwXAdHwxboPurbgr9ejBEoilm6p7PP?=
 =?us-ascii?Q?fHxYOx27RwMIqqIxceQYAE0k2+vk77a58CPIq8k8qUji9OZoR+3dF/5CsBYS?=
 =?us-ascii?Q?88atv9ycDXojJmejuw8jDHJKxTd8RApZQNmsOshp+bWg3+4R/OB8sZnDYDW0?=
 =?us-ascii?Q?m3unK48mht3CimEygdqViYzOD0oD7sHfnS8xARRRYi44g0/22fSRpoNhZhU8?=
 =?us-ascii?Q?KEVP47xNLoy9RMVdmc4DCaEqfNA2819DClSsI2YwRXocN6hA+jxEu6gjyxYp?=
 =?us-ascii?Q?CKZCTDfvZbampJLPH9roY0zg8g4EFNB06TwXy9vHatVScqlHMF9TDaLVn8+M?=
 =?us-ascii?Q?Ka1EAGEz2g3N+HMqWq/O6XRnpGPKULuOpqnMlx269TnLi9flRKMxz1rbAiWE?=
 =?us-ascii?Q?F24iuVStX7xYhh4PpjryTDJhawyztvJNyCPytPTu2bU+jBohSx0+ABkT5jvQ?=
 =?us-ascii?Q?KUme4zHHekhsDGLdS2e92wodaNraTuQMSSl9b6dG+tW310yTonmZ/a76AR3U?=
 =?us-ascii?Q?lnmcX60o6Z5DkuO7gC+GEEThlzqLBJWrxXuzoBsgohyAR7AE3pDyGd0kJhp7?=
 =?us-ascii?Q?3iu1KXsTsuB9Z7C84n1+aM3hMvjMnifl63xSwrr1VMbT8SyDwtTmjIiGKQmP?=
 =?us-ascii?Q?V8F/k2NwCYtDvQdUf4pYc5W6HrV0ibPxQXSIuQ2OywByq/XtQkPsxjgI0H1u?=
 =?us-ascii?Q?trxPUw+bEI7umKp1wim3GTTktcy2hgRedEHlJM3bQZaJFeSBk2fEubdY5KyT?=
 =?us-ascii?Q?gc7299lS07AnMhbzmhB9Pa0K7mH0XyU/g36dhQjmntqbzgXJstyiGFB4BkSN?=
 =?us-ascii?Q?xOcgI7eKN/dr4XK57wGOo9/WZnEP0bVU7pbSqFkls+OCuNLgYoWASIze3Jj8?=
 =?us-ascii?Q?YQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	h6x3aw245yH46KhHt9KsX+KpGUqDfeeWXwRoxciTJKy0WnBs3dyNr+hgTYDniZjdgQWoPANciXK++D9A0AfmRYztonpjlW4nhQ33FVn0YQWYc1/4eBA7oOwCu8S7betCq7xdkobRCkiQApcK+SWWrZAyE6VG5dod8UaxntuG5Xe5eV+fpAyAWwy5dBbcDYa9n50ithgDvYoXj/I8bA5l/xbjgUpdUSshSMwgrehupwNpezocnU1KJlXfYwsDRk4OL/7BuM1DLF4iy0AbOoGfCeRpNy6R+YUM1AYpyQZ4wcVNAhusLZTN0KF3zCdsfD6ucxUZFioViM1j3yk7nQPZmFQ922F/XP/aoI8CZdV0eYUpmavq/xgPz9UtsPygW4Z1JR50QT0yOZ5DzW9vHJJMbT5EOwW2/P2Lk4ZHmGahP3/lfjjUw2X0hUFNJpBkSrfA0/K5lyXVZoBeUBSoo6h7drjKR9pyErgUodatRcTPv7EslfUUfoAtehgozjYTiU7Ewu1lHWAHt6jDSFA7kVtmhLocHbBUHkdlJORlFtA7YMGZWdhUv5owfJ27LVjJC93aoPeJ4vBWrjh/lg66zAT+FQiK+EF8RgkA9KK6uDDg65M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec48e69-afb5-4fc4-68ba-08dd8aea12b9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2025 09:00:09.8571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sk++8BdQtLrQtQ5hYWYQO9mb3UPYpbi+1JYfFXppgsbdMbbk9Ra41GhB2k7kM6tRnEl6ixI2XZPE3Npp0l/b2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7178
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-04_03,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505040081
X-Proofpoint-GUID: BJ0FETulqHbdlsbZtl2uUWIVW3dtPNC6
X-Proofpoint-ORIG-GUID: BJ0FETulqHbdlsbZtl2uUWIVW3dtPNC6
X-Authority-Analysis: v=2.4 cv=PouTbxM3 c=1 sm=1 tr=0 ts=68172c9e cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=7Xr6i1Xs6TsDAXCDpIQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA0MDA4MCBTYWx0ZWRfX5ERaMfIla8ur zY4+zIJmL4d9wdBrdU5i8HOwc4pGgBji2+wZaOG8XZUi1HX/OEue31QOivi5xROChTC7TebQyTI HgRFXsn2D+suyxAYYbKx+PGVtSc/BlGokddGTSpUJ66hRBhwki2+x9WR3A14NV7LkNmeBHp9dR/
 7xMTLhFo8XJRncBRJsNP8asnqyUNZDJ4DRaa466MIw2IxR9sjVPoBov5Q0/PDtz2NPuK6ig+6wZ 5S8dfjETj8YJqzsD571my5eyDeNQ8+rmfifZ46oDxHCU1iDpDZJql2Wxk2dAAxi+Ka6tnE4vh2N ndPgN+0ztev+zs61IEYwMOw8/p+uj2rK//A+HQFVnDhMr0ylSwFQ4XnD4KHnRxI4zVbNR4K/W8y
 Yygz5kGmumm3VNBsiPYeEzffcSEaZ67Yo7IE2iUrORDOQeRL6w83Uss0T+pWcx4VYfIJsxV1

For when large atomic writes (> 1x FS block) are supported, there will be
various occasions when HW offload may not be possible.

Such instances include:
- unaligned extent mapping wrt write length
- extent mappings which do not cover the full write, e.g. the write spans
  sparse or mixed-mapping extents
- the write length is greater than HW offload can support
- no hardware support at all

In those cases, we need to fallback to the CoW-based atomic write mode. For
this, report special code -ENOPROTOOPT to inform the caller that HW
offload-based method is not possible.

In addition to the occasions mentioned, if the write covers an unallocated
range, we again judge that we need to rely on the CoW-based method when we
would need to allocate anything more than 1x block. This is because if we
allocate less blocks that is required for the write, then again HW
offload-based method would not be possible. So we are taking a pessimistic
approach to writes covering unallocated space.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
[djwong: various cleanups]
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_iomap.c | 62 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 60 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 166fba2ff1ef..ff05e6b1b0bb 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -798,6 +798,38 @@ imap_spans_range(
 	return true;
 }
 
+static bool
+xfs_bmap_hw_atomic_write_possible(
+	struct xfs_inode	*ip,
+	struct xfs_bmbt_irec	*imap,
+	xfs_fileoff_t		offset_fsb,
+	xfs_fileoff_t		end_fsb)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+	xfs_fsize_t		len = XFS_FSB_TO_B(mp, end_fsb - offset_fsb);
+
+	/*
+	 * atomic writes are required to be naturally aligned for disk blocks,
+	 * which ensures that we adhere to block layer rules that we won't
+	 * straddle any boundary or violate write alignment requirement.
+	 */
+	if (!IS_ALIGNED(imap->br_startblock, imap->br_blockcount))
+		return false;
+
+	/*
+	 * Spanning multiple extents would mean that multiple BIOs would be
+	 * issued, and so would lose atomicity required for REQ_ATOMIC-based
+	 * atomics.
+	 */
+	if (!imap_spans_range(imap, offset_fsb, end_fsb))
+		return false;
+
+	/*
+	 * The ->iomap_begin caller should ensure this, but check anyway.
+	 */
+	return len <= xfs_inode_buftarg(ip)->bt_bdev_awu_max;
+}
+
 static int
 xfs_direct_write_iomap_begin(
 	struct inode		*inode,
@@ -812,9 +844,11 @@ xfs_direct_write_iomap_begin(
 	struct xfs_bmbt_irec	imap, cmap;
 	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
 	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
+	xfs_fileoff_t		orig_end_fsb = end_fsb;
 	int			nimaps = 1, error = 0;
 	bool			shared = false;
 	u16			iomap_flags = 0;
+	bool			needs_alloc;
 	unsigned int		lockmode;
 	u64			seq;
 
@@ -875,13 +909,37 @@ xfs_direct_write_iomap_begin(
 				(flags & IOMAP_DIRECT) || IS_DAX(inode));
 		if (error)
 			goto out_unlock;
-		if (shared)
+		if (shared) {
+			if ((flags & IOMAP_ATOMIC) &&
+			    !xfs_bmap_hw_atomic_write_possible(ip, &cmap,
+					offset_fsb, end_fsb)) {
+				error = -ENOPROTOOPT;
+				goto out_unlock;
+			}
 			goto out_found_cow;
+		}
 		end_fsb = imap.br_startoff + imap.br_blockcount;
 		length = XFS_FSB_TO_B(mp, end_fsb) - offset;
 	}
 
-	if (imap_needs_alloc(inode, flags, &imap, nimaps))
+	needs_alloc = imap_needs_alloc(inode, flags, &imap, nimaps);
+
+	if (flags & IOMAP_ATOMIC) {
+		error = -ENOPROTOOPT;
+		/*
+		 * If we allocate less than what is required for the write
+		 * then we may end up with multiple extents, which means that
+		 * REQ_ATOMIC-based cannot be used, so avoid this possibility.
+		 */
+		if (needs_alloc && orig_end_fsb - offset_fsb > 1)
+			goto out_unlock;
+
+		if (!xfs_bmap_hw_atomic_write_possible(ip, &imap, offset_fsb,
+				orig_end_fsb))
+			goto out_unlock;
+	}
+
+	if (needs_alloc)
 		goto allocate_blocks;
 
 	/*
-- 
2.31.1


