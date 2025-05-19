Return-Path: <linux-fsdevel+bounces-49331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E58ABB7E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 10:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C78D188841E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 08:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CE4269D15;
	Mon, 19 May 2025 08:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OLEEbfGu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sBvGQds9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9757B19B3EC;
	Mon, 19 May 2025 08:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747644741; cv=fail; b=Lq173PBUuOuMEMO0GQhe9LhJXEl4hCEfKNH7t3Akzc7GN5y40fQO6MG2LI9N5L8OMlACREd6jACjpgaIQgC7ghks7RiTBXb8W9kEMAJ+n832akBW1Ke2X4qfpr5baU3kj2CreBFi0K1Au2qEGwlPXJWYMH/IrENlQlCU8leqfp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747644741; c=relaxed/simple;
	bh=ou0e0ysUXjzaL7tc10Ydhkjj7jiUz/G6yvX9hwRPVcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QiRZlK8L3LRA1sarKhEymC/c9aX4rGI/L8KkMfmDTT7M+X6cEPMJWSrb0xkcJ3vJkOvvaq+chWe0ejVRRT8MxzYu5BHbjarBnvj9E3+esdwyaF/iE0oMjOJUIz/wWZp6DAVw6Si016fVmhN4sovYlhSWGRYm0gq2fFnW1eVmIG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OLEEbfGu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sBvGQds9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J6ijNi013002;
	Mon, 19 May 2025 08:51:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=YpeG8+j6MaPVVYPP
	K1mOTktzXbEHbB8bQWSjZYblmpk=; b=OLEEbfGutyjetT4VltSE/QUrVH44ihYu
	EeskKo6RV+pYwf2LJD45lNQ9YwBCLFYMj4eCWWEE8xrTEz+Xtb6ngPr2RDc+o5aO
	1Bk/s7k1r4KzmjNv5xN51Z/a8tCg0BDB7qKa9fi/A0c0A8nwk3sX3hz2HtZrTHCO
	MF9JBSGmMnkP21LGjJqH8/HxJv5Vjj2Lw6mJvmSKpts3t/Hm7qQO2/M9DNMJuCRA
	wBIrsnM+0jFdkvbi4EP1BfAJCQre9T5/jGQP8g1Q/Iy6cKR6Z+kyBURmWEeq/rfB
	V84s46Z28Gkxccglbo3ebJYU1BCjCmTVxUEz+DBeSyWuuofTzAFnhw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46pj2uaeen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 08:51:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54J70enS029005;
	Mon, 19 May 2025 08:51:55 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw6684y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 08:51:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mD4wEmjGUXTMDTqYBnWZPPeEv61cIbD0MXXoKsIddTOTFTESCc7257oo4P7Kz2zSpwJSkwik3tL93m0JnZE8kIR/YR4lfaNjwJpFixkG+UDAKeDuxEaDMyEECFxEaa4ljCYWNpmXyv3xxypQ8X6kzx5x57/9g6QMYTtpf62m+JIBErGf1oluwbfSdqCbcOZiEI3Arvj+H8fNvVIkLuaW3IsYMyiYUpTYWMh+I/aOL03XoKlREgdQNqxkOgF4h3ME7Gup6DtEqhSxT7VmAcE0skqS8YlWIEibj1HuizDwaPy3GT658YThK0aRB+exwgrVculli53YiBJ8aU8aCHvE6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpeG8+j6MaPVVYPPK1mOTktzXbEHbB8bQWSjZYblmpk=;
 b=LQLqeOP+3glZjVTfX+iElshvcaBGonZ6luiIKahp3rVEJuQftq59okrlzELXNNA1ilJSLs2r4Fxg48jpfqjm8LgGSx3GXIwjO61PCOruNAJqo8i3l7K8nSBowM398aKwAx8ErTfIjxdT0zRgbRQOB3c+iHR9Rq+265jWnYLfcGu925DAQJENO1DA3gOGujto+7JxymQpSjOoPUNH19tea4qrYMru5SN0qMAR8HUG6avqlTx37Nxq9ethKOxTc9x0nRLUcASpQ4zL+bZm6gwNpEWWDobRe4wlI16nh/KTTZMNp7BVOuU7Ej8Xo8d3ljKZBxBubCynBvN3QmBWHGVl7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpeG8+j6MaPVVYPPK1mOTktzXbEHbB8bQWSjZYblmpk=;
 b=sBvGQds9V4mBB+jBxQRViAOcrjBKc6QUV1DigElaCcPG4XYEITpbNtjTRVvF3ry6m6osgyF1OS4WrNKN4Ov9i1Z8kT4IuunhVJkcscBO7H2X+43XylDzpS4Qjc20XEmnryf6RzcfaFclRglYHusok8kjMGbuFeYq1GAX8pZVqS0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB7833.namprd10.prod.outlook.com (2603:10b6:610:1ad::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 08:51:52 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 08:51:52 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/4] mm: ksm: prevent KSM from entirely breaking VMA merging
Date: Mon, 19 May 2025 09:51:38 +0100
Message-ID: <cover.1747431920.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0236.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB7833:EE_
X-MS-Office365-Filtering-Correlation-Id: 77e71d87-6961-410a-e26c-08dd96b26697
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HRYWy0vugsAve5YsZpspdfkLlT8totH7L8/PIhn1zeNoQzmONGokHfZF+PBe?=
 =?us-ascii?Q?WwO9FoXnMMUYXBxb9SjIrponURJQkzimq/2Vc3I69MkHKWJkiqO4WsDhDkLL?=
 =?us-ascii?Q?hgOOq0/kz4AwUYHfUfPQGUgz6jMWBccBvD/hCXdxOhKa9EvCmRsR5DwVPPkJ?=
 =?us-ascii?Q?lo+JokIaCV05xwSWhcd1V7V1smS0fGgZRzmK2lLSqwOTuoJB3iGDiOnoVQjA?=
 =?us-ascii?Q?AN/21urYNKMk9kWnFjgOIbeht877P8T6iCc4RtcmL2YYCBDT9Uo93LHO4vtX?=
 =?us-ascii?Q?sh87axuhSshj73jYqJlh0I24zyRUVRrRFHXpsLWRBxLMqGw2C+R9k0S/uB4c?=
 =?us-ascii?Q?zPV+5xKZQO+OvaiOivVKH7YzN09XrvQbsNoKr0ARiKW3J/7VPAWIKTxpFHRE?=
 =?us-ascii?Q?qknXtT3/AJdjEAHtKzj7QNN2Iu7l506HQZgNxpxFXCFtSyjnK0zozY34EA4P?=
 =?us-ascii?Q?o7otkGfIenOmBSFYkTbV3aCaSP1SwSWSYTxIa7KFqvN6YiwvTE+o8YLmGiPf?=
 =?us-ascii?Q?4ucflzf6BLOVtsgDL3+37owPvQkShWu9Q6y/pm3JfNiHJl7U7HDrvirx2wg+?=
 =?us-ascii?Q?Lm1Du2BLH2atgX094w5ZrRkA2j0DQsvp9+hUeoj18sMki7cTlYijQNzaw6Wh?=
 =?us-ascii?Q?EomTLSMwjfagxe3fKx+sIcufELECN2JyfiHodT9J0j1ArZihtaJp/mKpuX+R?=
 =?us-ascii?Q?GchMWr4HZ9lf/sxFzgx82Fi3JmXZ0kZLtJTM8NMLMAG5OuIphNzGrKxmoPRd?=
 =?us-ascii?Q?+q/u0H4tQh73HAkDCXhAFRb7qhCJhZ4Gvypq/fAWOG/PHsWGUhzbvIRu322s?=
 =?us-ascii?Q?YBjZkhJD9UW2eyW2vwcP5suAcLlr5SqMvARjxX02KMjvusf0HacQGfWTBksb?=
 =?us-ascii?Q?rGDf3+PM2z+F4xG2TV1ruxadzvxFjJNPTNLpr/a0tyt+a3ywfl314JtobUJE?=
 =?us-ascii?Q?u7SFGMMoF3Hkis7ofFxcfhDTasA8uIcBD/6YHIOyb7H/TqCXrqPQ5YOWyWXR?=
 =?us-ascii?Q?XM+j6YBbH6hnNBFgYDYGgDNYICsc/5L3vJ8W42eNrhEx1qfUtaTDdZGa/k+l?=
 =?us-ascii?Q?tWDQvsGV5uMLmK1Thr6BtYIPWT8b0oxSiznGjCNwocbqB/qFvcZdI4y712WD?=
 =?us-ascii?Q?0D/nSm+TxlEg0w+iq/KttUz4J7vIPKJIjmYDiNNj/e7JX6VOl3BjoZI4iwow?=
 =?us-ascii?Q?DUW1D1+2DNPppsyM9SjVa0bRJ50F5DX58R79oCeb7KbjWl9fmDYI95aNbKYq?=
 =?us-ascii?Q?m/ueEu4NpZZSp83CKYFEa6F8m6PWQotuBxPsjpJGNV1ZPuZ53pRq5wUWEpwZ?=
 =?us-ascii?Q?l6KNoo5zUaAaKJPaBd8xzMdbZd9ZWiinKCHqwquXASCklLmYGccsQhVPARLA?=
 =?us-ascii?Q?0rabVmMbkk62SXigZZAS6REhA7xLsbhN4x/nRZ35f6rVJJRnkkSwKG9q5nkN?=
 =?us-ascii?Q?oTrvEImNjrc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T3f36YQXHkBpKpjZg0A5+oa+ZKbluDYQcsM/G6szu0skUXxByzjscBlMcaxs?=
 =?us-ascii?Q?6x5DZHhEz9m/YZL8R0wwXdE+m/xrxfnVn49bjjDojg3GEc1vaprfjZj8Id/n?=
 =?us-ascii?Q?S37Wa8lJjcCLrxpg0H32HlxwswTGVAanHKJc09555klHDcyEYL0/zqSDoEG6?=
 =?us-ascii?Q?dh3+1drTx264gm04sIGSdedE+737g/AsAePhlyVxMaa+/elyIoIYRp5AiROV?=
 =?us-ascii?Q?Am25/MbLl9+9/O8T9GjOOVBB+WRc2x9j3740sX6padIo9C8wKI0iw0Qie51Z?=
 =?us-ascii?Q?eee8eaGl5mNoPR8U2a2r61sVfdC2Jitt1ttwZ39uu/fLHqU5t3bM+7RHDrmO?=
 =?us-ascii?Q?eNUL1rwhHQxnXy5nH/PWerXghbmUbNSduvaDlrYoAqOLSl/PqklEb6xyHEQX?=
 =?us-ascii?Q?xjRuIu2HkXGOCMsPkcecDRBkVL7hV+DosvAQl5gA55seN0/zNV2KATolwXHx?=
 =?us-ascii?Q?mx82q9VpBFpElN/1tRpabSGxJbfe5LD2VRslKCGoO5mFEZ31/750vRjkd5Ji?=
 =?us-ascii?Q?5cyEsVG7iefNyiCtQvhUe3A6nsRNhXxnIxZFgYfwv0qGiWDkufS+F2yaMtw5?=
 =?us-ascii?Q?7kTzrXcquv7Cb3cU6JH9ziQRcG7Aco5O2n7x3xCZt8p62aU45SeuTXZqeJxO?=
 =?us-ascii?Q?0mB64GtXZ4rdWbcs1z2AbxaS5i2yhSfF9HN41y86/qAs//An7NSlksLHrn+B?=
 =?us-ascii?Q?ndEraLcf9xo36Yj4N2+zHLu139tljkTltX8T3iAjsrr0wPQDQ8pBAHOESh51?=
 =?us-ascii?Q?HHQI7G2po8oISolK5d3g8kLLGIlf9M0UpNexv7EQzbKM4NXwVXlVYiKWVzEM?=
 =?us-ascii?Q?UJoVgUFScG0slrvyIvJjI3dTY/gqY3cddUnIVHr/n9QTcIEoBXqkAlBlkxIN?=
 =?us-ascii?Q?JUcQko1J9quhk+rYpSa8ObznVD8vpVYxBMT9yvCULSagfvfC9r0PXBcfBedO?=
 =?us-ascii?Q?EDM/5QgROboP+rKlti/2oDIiKBClAEv/1l5VLovm3sgiBm2EGGw7b88lhKip?=
 =?us-ascii?Q?QqjSV1VXFZjjzwWvxdSYSVOZrfuL9wR0oHMoZjsstOsiLT7/H4k6GVFjOLiJ?=
 =?us-ascii?Q?XwPUMYfKq9spjq0RZImT7I51jQWDp+hvD6VWgaiQO2aan7sEOqY6hzqCqwcL?=
 =?us-ascii?Q?pa5XCnNFbH3UVWoUjWsFUEWTE5asEofb9qvrdlDDHMb+riCqYtvGaY/vW355?=
 =?us-ascii?Q?++ISFS2ipKQPmpPxlBIDWHp/z9+CoysgsSeTSQXAsA/LFEKnqKCJhu7P02BM?=
 =?us-ascii?Q?LLBeBLVaqfGsXzGWOzI3XRZUPRXbvIH8cQKGhQHvr7bSATqzb5gSA8nX0Rrf?=
 =?us-ascii?Q?KKV2VxgK4ltYdv4c/DL15LHgynZg0CC26Lqrw37R829CO+aNh/wEx4D+1mwt?=
 =?us-ascii?Q?zz9zBzqP3q5YP6SQmTzmh3M9kSkDtm2kQoeNnALPjH10pkKn6E/0PimllC4f?=
 =?us-ascii?Q?IHMb+mymkoUdyNUn8J5X7F8et33greUWXxsjH6pkW16B/adppVw+CJy5qkLb?=
 =?us-ascii?Q?oXRYQG50/Ir3s/m8Xxl4MV9ZUy6d9CKKFW5i+1vy5bC8pWNd8oKmRpp6cEOw?=
 =?us-ascii?Q?uUbt4fQxfUz4T1Z0yGPYoPXrfmA25xBD63z6Zcnb565E2jvSHgl836gp0m4v?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	McwZIW7Y/2DvV7jbBKNiFWMfpjDI3LJrnOJRcgRuVI7jOhPWuxU+M9hUhC6mzuwCxeVdrL24p7dqsr6r1Gw+uzbb4oSRk+SHoqECq89QVtVC/B1vQoKWwrYu1kZA4jTkUMDIlvhV6C3tCOTTN8JpSOuIjF5V+rk0fVydqydX5b94U2i72QLp2fNPMP7uiQV3lVtH/FzYq7sggqSnru1xjZ2kbY4p1jpALx6jCCLpwdxJ8OF92hrNoyTI5tD2qr9ItxEIoWcRSFqupeCPgH17dplamFdRBap8oBCnL32BskYx1DHGh4Uh84zntbcP7J/RDVwl79aVCnamslalsdN3QVio8i9ikXJkqweYMqq3mQ6M0tq6EONJMAzYVpOQR8orvt+5cR+Jh59koESUxuBBILC902SDgti/62+NkQfNjLvzIbmarrHnjtbBGkHZi+TIyog1HcgK73ttmhhWPGnC/r576JOp5s5HRcCM8Z70ezXl+qcsCK5ci0QiN8vt2gCLU45ZmIwWcnu06630TCkqgxq4EL2WclWxbcqE6bBiuxT72CtFEekYFxmA/LiNL1E9uU6e3/hy/XRTYLEaUBNyXn+JZ5LTZC8UX1OV4JJNxKI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e71d87-6961-410a-e26c-08dd96b26697
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 08:51:52.6917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6OxU55C0uG9TayUe8/hA/hSe7mwow/ZGSSbdQw9X569Nj09tgrkDiG2x2ducEtzmTQNYVUtWpqdqxGyaXz3OP4DSDnajjmlm21/ZsNEUzrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7833
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_03,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 bulkscore=1 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505190083
X-Authority-Analysis: v=2.4 cv=UKndHDfy c=1 sm=1 tr=0 ts=682af12c cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=wP4JhQTrMU2qUWX1qwwA:9
X-Proofpoint-GUID: LEaMN8_OzTZiSHEWLQC4_lpKlPk8x5hf
X-Proofpoint-ORIG-GUID: LEaMN8_OzTZiSHEWLQC4_lpKlPk8x5hf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDA4NCBTYWx0ZWRfX6thQ8v7aWCTw 9nIwEZzDqNVivkubVPkOo+cIg8eC3oXCZ0HqokLO8V+vJ0N1OwxUusQ5Jr1cfR5qxPdtngCRtJ1 iutid31AsRlMJ4Bb0974lwLy4UdM53g7K3NSXTXlNNztS1tR83mEPqiTugtMiw7Kh0In5hgARMA
 WPaLetJ3qsK9KCCwgBqjbDqOxqlNEI26KdyJ9uGYFd2WRUED2rrffrG/aYN9qH4t5kmBoXQzB2b BRV3lgiUYuCIsgfaP10RXj/MGBq/fU5p5EHk1GPCkwOSiGjm5WZe2PeYk7KxTar/b7iodTp/Efx 5phnzYXFCTjufn0qRQcv3ToIiEGzFKHgSMIv82bS+7xdW/CioX85na2xON+578FYfYuiZQEQtw0
 d9FZF+XEfGPCiXLjV4sQj2x8OsdlmuF27k3Ykxc1CSvZj30xFVMb0Dr084cdKZmUPu4S+LDS

When KSM-by-default is established using prctl(PR_SET_MEMORY_MERGE), this
defaults all newly mapped VMAs to having VM_MERGEABLE set, and thus makes
them available to KSM for samepage merging. It also sets VM_MERGEABLE in
all existing VMAs.

However this causes an issue upon mapping of new VMAs - the initial flags
will never have VM_MERGEABLE set when attempting a merge with adjacent VMAs
(this is set later in the mmap() logic), and adjacent VMAs will ALWAYS have
VM_MERGEABLE set.

This renders literally all VMAs in the virtual address space unmergeable.

To avoid this, this series performs the check for PR_SET_MEMORY_MERGE far
earlier in the mmap() logic, prior to the merge being attempted.

However we run into a complexity with the depreciated .mmap() callback - if
a driver hooks this, it might change flags thus adjusting KSM merge
eligibility.

This isn't a problem for brk(), where the VMA must be anonymous. However
for mmap() we are conservative - if the VMA is anonymous then we can always
proceed, however if not, we permit only shmem mappings and drivers which
implement .mmap_prepare().

If we can't be sure of the driver changing things, then we maintain the
same behaviour of performing the KSM check later in the mmap() logic (and
thus losing VMA mergeability).

Since the .mmap_prepare() hook is invoked prior to the KSM check, this
means we can always perform the KSM check early if it is present. Over time
as drivers are converted, we can do away with the later check altogether.

A great many use-cases for this logic will use anonymous or shmem memory at
any rate, as KSM is not supported for the page cache, and the driver
outliers in question are MAP_PRIVATE mappings of these files.

So this change should already cover the majority of actual KSM use-cases.

Lorenzo Stoakes (4):
  mm: ksm: have KSM VMA checks not require a VMA pointer
  mm: ksm: refer to special VMAs via VM_SPECIAL in ksm_compatible()
  mm: prevent KSM from completely breaking VMA merging
  tools/testing/selftests: add VMA merge tests for KSM merge

 include/linux/fs.h                 |  7 ++-
 include/linux/ksm.h                |  4 +-
 mm/ksm.c                           | 51 ++++++++++++-------
 mm/vma.c                           | 49 ++++++++++++++++++-
 tools/testing/selftests/mm/merge.c | 78 ++++++++++++++++++++++++++++++
 5 files changed, 166 insertions(+), 23 deletions(-)

--
2.49.0

