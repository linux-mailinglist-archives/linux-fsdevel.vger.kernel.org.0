Return-Path: <linux-fsdevel+bounces-32871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E3D9AFEA2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 11:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 834CF285232
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 09:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C702003DE;
	Fri, 25 Oct 2024 09:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T7SIR7zr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JzmotlE4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710662003A2;
	Fri, 25 Oct 2024 09:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729849339; cv=fail; b=ft/h/jNPd3osznwuM0IOX/iiEkGNWV2FD+kZX82lf0gOi//5O029cG246SntyE47ZFFwRAY0Ukl8kSxl0BddoYVHkERvuHYsI2+Q/jm7ILW/KKtOCKdGKpZTrbBxHW8Q61XwL89Ua4bAfsfvfhoNFIEZwdOsrWUb0Pz/ps8o02c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729849339; c=relaxed/simple;
	bh=nmd33tz+RsvGErxgfURnJZUoF6Jk9JXr5vUjQjkwjU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CxPlzO/VaZ880cphClyprdH/VriSB9Ab151sWNfFHtfiqAhquzJ8mHHCxN/YUGRvXQug3gmj2fK8MxIoK315WNXOAe/Fwf2TbXDjEMSZEku2bkInlNyCxfRu1sDTVZNXUdT01Sw415vz7IDveMDjJ3/n7crbfsuEi7orrJl+TWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T7SIR7zr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JzmotlE4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49P8BXd1026773;
	Fri, 25 Oct 2024 09:42:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=wY6kdgChMItf6mowLK+7M+e6qDkjxAzv9eXffTxVzSk=; b=
	T7SIR7zruLPBUdWn69jxBGKZ1lnV9mJk9rc/XaYI+q0hd+Z+u+tBFqQPXG1IMwQU
	PuAtKufm4sc2bzgYnG7BBz6ZGRQ/4uIQ5M2J9myBCX2cif1x3nrQ0htRo9l4bQ6A
	e9S/zcBveV20+XUuSH35WpOdseW/o/Ge5Fe95NYQ8V3YhihQas9AO9ay7jb4kDAH
	GpcYetaYQ09QYSBtKgXvUDfE+MNXkQEeqaTQ6eRc2iJcj0aJsghtBCYyH7Cl/c0h
	inZvAMfjJrAkh67P02JUt75VQA31smB3fOKtZDNV1s3S9ZmZnGvcPNMSKiGtO62q
	egpe5BLTo0c8JyTQhtx6hQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55v4kf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 09:42:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49P8Mfjc002210;
	Fri, 25 Oct 2024 09:41:59 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42g36a9ybt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 09:41:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qfWEdDcI6JMq4cvoz9tEjbhSB/rPbgzUnHhBg9RNk7cKdQLRIE8gCEdZtgP5DMWU1UNY75lKX4YECo+BPea4o0x8eYfzkD+o6QYAHIkdTgT3zJNR5Lpst4keUCdYsJLAqBFS9eJSeP3OWmCp69YUUGbkC8y/Wg581u23orILrV1ZipngOMVmqUX0jQMVAHo/m9RvMiJVQ5OtCyfq+o0aU8s+NQ1IoGAN7a3eN7mASfMs+Fu1T8bgSvYb08mbA1At5Db2haxQeKHhnL48rCBZnv1Th41ZuprmyXZTYFpn+8JBMjy0vd8FXwXVqec/tLPbwUwKgDdwQBU6gPqAHiqM9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wY6kdgChMItf6mowLK+7M+e6qDkjxAzv9eXffTxVzSk=;
 b=dbrD9fEwLHQl1LFLJ2bkPkW96MF/lo4nP1P05RAF8+Pf0FAE57T+g6TMZHK9jtmSgKOcka0guRjcKVeWDjlLaYwWdh1Ae+/epRaIjCqHpSOEWeFyCLfMfsf73wmgzSaiydNx4P4jlLUhEHV4xvtzG1tWaKFmYgvcvdJeTvN8yLqKb9u2oOqEUR39IQB4drMdIZujM0oxWwsAoqI3O/x7+LqTo8xTL9nU+pFRCttRGDZ14w2+MGf/3ZFzr2D/NEui7OhHwzLlpF/qr+QBY4B0xkbTzWYQAkUy+n8xlimwpAooA8+b/5bpc+n4Xfby0IB+INwnBO+42PrjIzJkh430IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wY6kdgChMItf6mowLK+7M+e6qDkjxAzv9eXffTxVzSk=;
 b=JzmotlE4Gd2v1juemedHvlZySF2mZbQD0x7376EXToXyVUzY0Hob93MRNhACy2OYjqIvBF5MxRiEgLttYTcOBqnu+Axw3rlH4ONQHMoS0TWnjtD6f0Bf00RZV0ZsO+M8EF69qQVKlVj+uVG3RG+GRIv6+1q5D+3nlqJX/qhnR8U=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by IA1PR10MB6121.namprd10.prod.outlook.com (2603:10b6:208:3ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Fri, 25 Oct
 2024 09:41:56 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 09:41:56 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <christian@brauner.io>
Cc: Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v5 5/5] selftests: pidfd: add tests for PIDFD_SELF_*
Date: Fri, 25 Oct 2024 10:41:34 +0100
Message-ID: <36d9dbea7475850ac9206fcd0d3ea1f1d02312fb.1729848252.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729848252.git.lorenzo.stoakes@oracle.com>
References: <cover.1729848252.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P123CA0031.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::10) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|IA1PR10MB6121:EE_
X-MS-Office365-Filtering-Correlation-Id: 5837dcf0-4138-4b4e-4aff-08dcf4d943fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7y7I41QU/uHo360g6gBhDjMAJBfro2kqm/f1ZUFANDCRbI7sm5Vk90nftW0f?=
 =?us-ascii?Q?35MPCLyrJqkVfD/VHREB5dpt+XdzzsJ43mCKBNhCJoaf9V8v7hpw5jWeTcFZ?=
 =?us-ascii?Q?I12gs55LMJIFzX6SfkKnhKubAOxWTPEH2jTeerLEgifqo4BzjxV89WD8W54k?=
 =?us-ascii?Q?qtlW8A1c6ap7yX8UeBT70yyhPi1cxvNPcJOPh4lwczyBcoWtSZwXHgxzJHHw?=
 =?us-ascii?Q?hMQrs+v4Dmau55WCZkchPMxhvXxZKF8tuxJIsUyfAiR9sNv7u4Ee5Ds+Q1ij?=
 =?us-ascii?Q?ozk73nLfu/c+GYejMMMWpzaUMXfoJ4X540Wn3ybRgm4ZwkPLSzM7v8XTA73B?=
 =?us-ascii?Q?uTYCjSAeefYZGDWuPj9M5JNpnXrdOUeFwdgN3UtcV/idfdv+73f0sXKi1tzW?=
 =?us-ascii?Q?lsLGH3HLzLPGnbaMuzEewxfyfwTLynb8/HMs9J/NfzrgzksGI04JmrBC8pwF?=
 =?us-ascii?Q?SzLRceJCHV37dlhOqNZ05u1sry86c9Dtb7PaqCYjCk8uN33z73ZYNsUhpmTT?=
 =?us-ascii?Q?J51cX+3AQHcDKQ/EOQmlJW32ejN+w8x+fwZ1RCN/8VCO3+yX2AhDyvXbrvyp?=
 =?us-ascii?Q?Yr3QBnWRm20xtpDEPwM+npc3iEwYCfqWYrFXcOm6q43C99TJbpqCh9geEZhN?=
 =?us-ascii?Q?Uuv3fNQRs+F/WQEKJE+YhUps8+SwHiCYkjN7OcntFrMs3SkA5iMkEZd+n76T?=
 =?us-ascii?Q?1HPaaO3CyH2DMFBr6fvZyYtWayHLMtsRDKbF7dQqsxywxsiP9QgKti6tpph/?=
 =?us-ascii?Q?+HC1JqLjZwDS+Cu6jgFs3w4nfgjsOiawxlAUgpUkFbiIsv69+fWJAqsz3ccx?=
 =?us-ascii?Q?itaZyppuREFS9UV9XCApt6jt9buko5OhwxuxBn8rPfdcct8Oxa/TRkvd7UKn?=
 =?us-ascii?Q?G8/wueq20Iz4IgC4/aAhqMLxqDtFUc5xARoLWtrfRyDU+OIJ43uJGra4WmQJ?=
 =?us-ascii?Q?e9x6yCQ3NSKiHwtK72bDg5FxnhT1fDB0S55ppwb/fc3LLRJVBu/MGMs7IAp+?=
 =?us-ascii?Q?gCabhGf/z/zjtoj57uOCrHaRUlE+w9B4zkHTbNo2tgqRFRZppVCPzz0kBuyM?=
 =?us-ascii?Q?VJhS2HfdFA8DbTNtmM5J0XE76/fRwjhSWNTckIcl7+bsGRwR7WsFdjVYcXN2?=
 =?us-ascii?Q?uTD58HVJ9v67EaXV+UiJQ06xM84ehSaHiokbF97VnEwBePZpnh7LcIQFBiGn?=
 =?us-ascii?Q?1AHnkI773LDHNSBYagj9dCA7OeTYCAYQXLJS5jGVNP7AVmOUSqoxyu76sXUb?=
 =?us-ascii?Q?GajahZ853iG62LLGxhRVWs0LvLOQwnzG2KqNTlHS9cSoFTD/Zmts/N3iCqM+?=
 =?us-ascii?Q?qOo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d2tWEioTJC8LAkL+0WpzxZg8GE62VPfEj1kV4UyNZfB/F/4c0bYtACZVTzGW?=
 =?us-ascii?Q?hkMWkdslPW7D85yfqGfnVOnkTttKcn4Tp0LsTKmNr8gwxji1M7K2EZBf5XoZ?=
 =?us-ascii?Q?VkQZ/NkfdJR8Ad0bgSL2frD+MkTeF8H0fPtXC8uOHHIfOCwlMlg/sxSU1v9u?=
 =?us-ascii?Q?vOoIrUjrKFD7R731C51uJrDZP+Ezo6NrAuKE2S4JTXeZgaXL9BHwQ0n1xR+v?=
 =?us-ascii?Q?lYSPEtn9QFzdB3DFWuR+HuoDAgrCRdQpzrABpWU5D5Vyb9r7eauT3ItH+IWH?=
 =?us-ascii?Q?FD2mvAX4QgBjIhBuW0TBE8/NrztngiE44jGPwhOmdls1tP0vsOb2gAeEz3VH?=
 =?us-ascii?Q?l1VkWiDyIPtYf4A3qM9rUBm7ZgVEh9mGGO6e3icRDHh29D9cWF/uu3M37det?=
 =?us-ascii?Q?+q3wD3/82kLW/AEYV+X7kyNgNz7rvOMHvml3gxdDfPXV7z0P8CCf8AdH8Gs2?=
 =?us-ascii?Q?1rDHR2GQ1AjUriekW9Oi/Q+xoKN7X8osyB6pTn+PJHyIqIkN2rdiFORFgA/h?=
 =?us-ascii?Q?8hnruDzgAC5IujLjiaIsiUn/EJPNNNU2zwCMLE9+iqeKGTl7UhF4+Oq86vrq?=
 =?us-ascii?Q?pJijx6+XynJr3WAbUKPHNSGsD1QAP42c2oOt2xtwn7rswi/fuNynRMOsVnqc?=
 =?us-ascii?Q?6noLiptbQLXTut0KYGYhrZsV2NvMDFsPlcLMzma6fxoDg4VPSSyCc8B9H5rI?=
 =?us-ascii?Q?7A1m1SLDhA6Uqdc+7bJOAs/nccT/DEBJgaiAQFY7CiWR6eF6xPESzBWhSE9L?=
 =?us-ascii?Q?zSHpci4MnxaiM9gh2uQtBogQnvBfr4FNI8qbYTpDunwcdUKsdwHuvBH4ZPKw?=
 =?us-ascii?Q?XinGpwrkOe05g09Bdh7WziMTGah0uR+u1KbA0UldoN9lj5MznMybiMJPvQuo?=
 =?us-ascii?Q?yQia9a3EBcyf2+/5sNNuWJhITiNbM01+AGO7BKFODvWcV3zbf90DK02kq78p?=
 =?us-ascii?Q?YsWI78Blp4KF+lUbhkQR8afLMuDKKt9XwxFqBPyRqpy1gnjV6W2NzXIFcbO7?=
 =?us-ascii?Q?xFlkDNdSkS3UZhYMcSGMuVywCx71l00OZjj5uwufSpW7DiZIssHACAfZFBdo?=
 =?us-ascii?Q?AxriTGJBjh1fYJGeeu4JagYr/hplzKI94vfrZOTlwpYCCug9SR/cNtfjegOh?=
 =?us-ascii?Q?3FVehSkAdADECWBQs5v9n5RB8FBgA/bRpTabvFYlPDrcD7fBJXvrSLmIameO?=
 =?us-ascii?Q?n62VKc2OttLJG4689jI/kJlddyc3xJ3+iVxylpqiWLV+Iz2zbKXzENXLKt6M?=
 =?us-ascii?Q?SREVoMSPDP6AtTuD4U0vrJUPIjd+Uh/gsGZO2XhOS3y5leRWD16pUmwoW6pS?=
 =?us-ascii?Q?nh+GwYWlSX95jIhraF2c1WacpFE2PLeOWqEZbqXqcVavSydjbQFHRODOJGKh?=
 =?us-ascii?Q?yLpm9K8GiM8a5ZnApBgjMeM5lXanyr9INEh7Nj2dZqvCAIch2lHQvFzQsNKq?=
 =?us-ascii?Q?nX8o+0c6S2yQKYdUHIciJdQ2bZG6JGW2aIQIy0mPeNsK4V9exFPk2LuYdIW6?=
 =?us-ascii?Q?PC47iqe/xGghHJLRZI1zXdMno6kHeZuhe2ChrhbvfkYwBUU9waYunf3BwiRv?=
 =?us-ascii?Q?u2WMgasECi9IvrD3Si+QPEfGPNlcKr1Yxn0JF1YBTmDRwkbcP/BxSmbXNy8o?=
 =?us-ascii?Q?aDh1BemEdDL0/GLZXGPeCNC1GY0wUq9TAQU5pklX18O2YJiTbmMniDlBF00z?=
 =?us-ascii?Q?NsLHHg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+Qpu+I6Nr+FZmZSwcag+LVp8y5Ws2vcdcjvZReCwygKchJC06gP6rBTAfiCmAcfdieERQKY6cnPsOF/GyJPsft3yDF0/q5EKMA2xKvpoZDBcmMFQ6uHlRj3RhWNqLYBqvfAAXmZ/ncP1Ze9gwd6sAHecK8lapUeU49eKujD7RGWzRl8xYxytJ2QXLX28lboOtRTpoM3KrwKlte8RVv9aQC1CoazidwQcVwZfDnNdvBwW5kGXQqPYwAHStidoAlLTt0UrtJ7lW17m7/2g3MnKCb6Vm672NqzmOtfRHmIqY2L/3c+9kam5gJOV1kVh2dmYdgm6RpZ0tHN+4f9MtB2uFNX1lTjmcHmvZxPEVZT6BU3nOt7wOtGCcrVnYrd4HmspEm6DC1aPGg3MgkZQT/eKuR29cpWt44Vtym39o4MVw2Byt8zpZ0tJMsvGb2wXLvUP9BKccY/WPfuATwZg6JvF8y0KezOenfejYFFWZIvVChS0Ov67DxvnjDzjR5ZbMRx6fRJW1CKWHG6QZSMPmb3aEO+bzHqiSIcMxtLeI3bCSkYsaBwfyvdzDqUbJMiLrjUCpUbQOGQ207RXMLTCa21SJU9JuQge08WjUrF2Glui95E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5837dcf0-4138-4b4e-4aff-08dcf4d943fb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 09:41:56.6619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fW9Qg/7O8fW9a6gk+PHCaGJBp0vyU224R4eAq27i1JLNIrmq8EhhDNj2Ug6s7FFhfEHboIzm2d5JILi/YZRcsGOm1gcGHFKFsSqXmr2QvNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6121
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_06,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410250073
X-Proofpoint-GUID: fZaWXAsNQzc4D_kL-EFj7EnRL01cgrnR
X-Proofpoint-ORIG-GUID: fZaWXAsNQzc4D_kL-EFj7EnRL01cgrnR

Add tests to assert that PIDFD_SELF_* correctly refers to the current
thread and process.

This is only practically meaningful to pidfd_send_signal() and
pidfd_getfd(), but also explicitly test that we disallow this feature for
setns() where it would make no sense.

We cannot reasonably wait on ourself using waitid(P_PIDFD, ...) so while in
theory PIDFD_SELF_* would work here, we'd be left blocked if we tried it.

We defer testing of mm-specific functionality which uses pidfd, namely
process_madvise() and process_mrelease() to mm testing (though note the
latter can not be sensibly tested as it would require the testing process
to be dying).

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/selftests/pidfd/pidfd.h         |   2 +
 .../selftests/pidfd/pidfd_getfd_test.c        | 141 ++++++++++++++++++
 .../selftests/pidfd/pidfd_setns_test.c        |  11 ++
 tools/testing/selftests/pidfd/pidfd_test.c    |  76 ++++++++--
 4 files changed, 218 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index 0f3fc51cec73..1dbe48c1cf46 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -16,6 +16,8 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 
+#include <linux/pidfd.h>
+
 #include "../kselftest.h"
 #include "pidfd_helpers.h"
 
diff --git a/tools/testing/selftests/pidfd/pidfd_getfd_test.c b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
index cd51d547b751..48d224b13c01 100644
--- a/tools/testing/selftests/pidfd/pidfd_getfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
@@ -6,6 +6,7 @@
 #include <limits.h>
 #include <linux/types.h>
 #include <poll.h>
+#include <pthread.h>
 #include <sched.h>
 #include <signal.h>
 #include <stdio.h>
@@ -15,6 +16,7 @@
 #include <sys/prctl.h>
 #include <sys/wait.h>
 #include <unistd.h>
+#include <sys/mman.h>
 #include <sys/socket.h>
 #include <linux/kcmp.h>
 
@@ -114,6 +116,94 @@ static int child(int sk)
 	return ret;
 }
 
+static int __pidfd_self_thread_worker(unsigned long page_size)
+{
+	int memfd;
+	int newfd;
+	char *ptr;
+	int err = 0;
+
+	/*
+	 * Unshare our FDs so we have our own set. This means
+	 * PIDFD_SELF_THREAD_GROUP will fal.
+	 */
+	if (unshare(CLONE_FILES) < 0) {
+		err = -errno;
+		goto exit;
+	}
+
+	/* Truncate, map in and write to our memfd. */
+	memfd = sys_memfd_create("test_self_child", 0);
+	if (memfd < 0) {
+		err = -errno;
+		goto exit;
+	}
+
+	if (ftruncate(memfd, page_size)) {
+		err = -errno;
+		goto exit_close_memfd;
+	}
+
+	ptr = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+		   MAP_SHARED, memfd, 0);
+	if (ptr == MAP_FAILED) {
+		err = -errno;
+		goto exit_close_memfd;
+	}
+	ptr[0] = 'y';
+	if (munmap(ptr, page_size)) {
+		err = -errno;
+		goto exit_close_memfd;
+	}
+
+	/* Get a thread-local duplicate of our memfd. */
+	newfd = sys_pidfd_getfd(PIDFD_SELF_THREAD, memfd, 0);
+	if (newfd < 0) {
+		err = -errno;
+		goto exit_close_memfd;
+	}
+
+	if (memfd == newfd) {
+		err = -EINVAL;
+		goto exit_close_fds;
+	}
+
+	/* Map in new fd and make sure that the data is as expected. */
+	ptr = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+		   MAP_SHARED, newfd, 0);
+	if (ptr == MAP_FAILED) {
+		err = -errno;
+		goto exit_close_fds;
+	}
+
+	if (ptr[0] != 'y') {
+		err = -EINVAL;
+		goto exit_close_fds;
+	}
+
+	if (munmap(ptr, page_size)) {
+		err = -errno;
+		goto exit_close_fds;
+	}
+
+exit_close_fds:
+	close(newfd);
+exit_close_memfd:
+	close(memfd);
+exit:
+	return err;
+}
+
+static void *pidfd_self_thread_worker(void *arg)
+{
+	unsigned long page_size = (unsigned long)arg;
+	int ret;
+
+	/* We forward any errors for the caller to handle. */
+	ret = __pidfd_self_thread_worker(page_size);
+	return (void *)(intptr_t)ret;
+}
+
 FIXTURE(child)
 {
 	/*
@@ -264,6 +354,57 @@ TEST_F(child, no_strange_EBADF)
 	EXPECT_EQ(errno, ESRCH);
 }
 
+TEST(pidfd_self)
+{
+	int memfd = sys_memfd_create("test_self", 0);
+	unsigned long page_size = sysconf(_SC_PAGESIZE);
+	int newfd;
+	char *ptr;
+	pthread_t thread;
+	void *res;
+	int err;
+
+	ASSERT_GE(memfd, 0);
+	ASSERT_EQ(ftruncate(memfd, page_size), 0);
+
+	/*
+	 * Map so we can assert that the duplicated fd references the same
+	 * memory.
+	 */
+	ptr = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+		   MAP_SHARED, memfd, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	ptr[0] = 'x';
+	ASSERT_EQ(munmap(ptr, page_size), 0);
+
+	/* Now get a duplicate of our memfd. */
+	newfd = sys_pidfd_getfd(PIDFD_SELF_THREAD_GROUP, memfd, 0);
+	ASSERT_GE(newfd, 0);
+	ASSERT_NE(memfd, newfd);
+
+	/* Now map duplicate fd and make sure it references the same memory. */
+	ptr = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+		   MAP_SHARED, newfd, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	ASSERT_EQ(ptr[0], 'x');
+	ASSERT_EQ(munmap(ptr, page_size), 0);
+
+	/* Cleanup. */
+	close(memfd);
+	close(newfd);
+
+	/*
+	 * Fire up the thread and assert that we can lookup the thread-specific
+	 * PIDFD_SELF_THREAD (also aliased by PIDFD_SELF).
+	 */
+	ASSERT_EQ(pthread_create(&thread, NULL, pidfd_self_thread_worker,
+				 (void *)page_size), 0);
+	ASSERT_EQ(pthread_join(thread, &res), 0);
+	err = (int)(intptr_t)res;
+
+	ASSERT_EQ(err, 0);
+}
+
 #if __NR_pidfd_getfd == -1
 int main(void)
 {
diff --git a/tools/testing/selftests/pidfd/pidfd_setns_test.c b/tools/testing/selftests/pidfd/pidfd_setns_test.c
index 7c2a4349170a..bbd39dc5ceb7 100644
--- a/tools/testing/selftests/pidfd/pidfd_setns_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_setns_test.c
@@ -752,4 +752,15 @@ TEST(setns_einval)
 	close(fd);
 }
 
+TEST(setns_pidfd_self_disallowed)
+{
+	ASSERT_EQ(setns(PIDFD_SELF_THREAD, 0), -1);
+	EXPECT_EQ(errno, EBADF);
+
+	errno = 0;
+
+	ASSERT_EQ(setns(PIDFD_SELF_THREAD_GROUP, 0), -1);
+	EXPECT_EQ(errno, EBADF);
+}
+
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
index 9faa686f90e4..440447cf89ba 100644
--- a/tools/testing/selftests/pidfd/pidfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_test.c
@@ -42,12 +42,41 @@ static pid_t pidfd_clone(int flags, int *pidfd, int (*fn)(void *))
 #endif
 }
 
-static int signal_received;
+static pthread_t signal_received;
 
 static void set_signal_received_on_sigusr1(int sig)
 {
 	if (sig == SIGUSR1)
-		signal_received = 1;
+		signal_received = pthread_self();
+}
+
+static int send_signal(int pidfd)
+{
+	int ret = 0;
+
+	if (sys_pidfd_send_signal(pidfd, SIGUSR1, NULL, 0) < 0) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	if (signal_received != pthread_self()) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+exit:
+	signal_received = 0;
+	return ret;
+}
+
+static void *send_signal_worker(void *arg)
+{
+	int pidfd = (int)(intptr_t)arg;
+	int ret;
+
+	/* We forward any errors for the caller to handle. */
+	ret = send_signal(pidfd);
+	return (void *)(intptr_t)ret;
 }
 
 /*
@@ -56,8 +85,11 @@ static void set_signal_received_on_sigusr1(int sig)
  */
 static int test_pidfd_send_signal_simple_success(void)
 {
-	int pidfd, ret;
+	int pidfd;
 	const char *test_name = "pidfd_send_signal send SIGUSR1";
+	pthread_t thread;
+	void *thread_res;
+	int err;
 
 	if (!have_pidfd_send_signal) {
 		ksft_test_result_skip(
@@ -66,25 +98,45 @@ static int test_pidfd_send_signal_simple_success(void)
 		return 0;
 	}
 
+	signal(SIGUSR1, set_signal_received_on_sigusr1);
+
+	/* Try sending a signal to ourselves via /proc/self. */
 	pidfd = open("/proc/self", O_DIRECTORY | O_CLOEXEC);
 	if (pidfd < 0)
 		ksft_exit_fail_msg(
 			"%s test: Failed to open process file descriptor\n",
 			test_name);
+	err = send_signal(pidfd);
+	if (err)
+		ksft_exit_fail_msg(
+			"%s test: Error %d on sending pidfd signal\n",
+			test_name, err);
+	close(pidfd);
 
-	signal(SIGUSR1, set_signal_received_on_sigusr1);
+	/* Now try the same thing only using PIDFD_SELF_THREAD_GROUP. */
+	err = send_signal(PIDFD_SELF_THREAD_GROUP);
+	if (err)
+		ksft_exit_fail_msg(
+			"%s test: Error %d on PIDFD_SELF_THREAD_GROUP signal\n",
+			test_name, err);
 
-	ret = sys_pidfd_send_signal(pidfd, SIGUSR1, NULL, 0);
-	close(pidfd);
-	if (ret < 0)
-		ksft_exit_fail_msg("%s test: Failed to send signal\n",
+	/*
+	 * Now try the same thing in a thread and assert thread ID is equal to
+	 * worker thread ID.
+	 */
+	if (pthread_create(&thread, NULL, send_signal_worker,
+			   (void *)(intptr_t)PIDFD_SELF_THREAD))
+		ksft_exit_fail_msg("%s test: Failed to create thread\n",
 				   test_name);
-
-	if (signal_received != 1)
-		ksft_exit_fail_msg("%s test: Failed to receive signal\n",
+	if (pthread_join(thread, &thread_res))
+		ksft_exit_fail_msg("%s test: Failed to join thread\n",
 				   test_name);
+	err = (int)(intptr_t)thread_res;
+	if (err)
+		ksft_exit_fail_msg(
+			"%s test: Error %d on PIDFD_SELF_THREAD signal\n",
+			test_name, err);
 
-	signal_received = 0;
 	ksft_test_result_pass("%s test: Sent signal\n", test_name);
 	return 0;
 }
-- 
2.47.0


