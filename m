Return-Path: <linux-fsdevel+bounces-48003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5946AAA854F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 11:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7629D3B7115
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 09:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D590E1B4233;
	Sun,  4 May 2025 09:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SDviCwDb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pmHc8rTY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B851991CB;
	Sun,  4 May 2025 09:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746349339; cv=fail; b=PELLD4Y4wpyF2edtWQ0vLei0t4E4wq8BrdMzL91frGMw8Y3wgrmNoffkgOcFczbCt1TrrDK5XlMGjKRLL4HdbM6CxHjL4alA0Qs92poziJyB85mm1yBUmob9z11y06nLkMKQUx48YbBWRyyDpevIp1Rp65+/w/hRlXjWLiIUl68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746349339; c=relaxed/simple;
	bh=dpuRhYi9OfC7iBRjrcGVgkGhbTm91gW1lkdoPJyjpdc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l9RYlkA8Q1DWXyU4zpUGXQsNfPG928pRP4VcAB/2yME9paWIa1ryEwfWUTar3PJej1UjTlNKI7Om2a9RzNyn+A4sdRiktRa51x+A8Y88sqxlYwi+OBHGzXfrS6qbhKiZe4UnpuIX/mcrYdQ1qC/uBGfsgsL2Rphs47Q2hgieTYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SDviCwDb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pmHc8rTY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5448qV8M010215;
	Sun, 4 May 2025 09:00:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=keV9W0ffoML03s5DKKU92wyZhPD/Bmw9lCz20VCC4ZY=; b=
	SDviCwDbI411BVnENPKR3P3zH0NeBnnLzWkGmWiIPVgssp/LKjhJMEHPEU49Ne5M
	PKtPCTSzgGkH49g3fs3ApxUspLR+febXzxLuKDYHUnrueYonFjDDA9z4j7MwNCam
	qCBPeCd2eL5M1U+aUxPAWzA9fPQmm8OzAbikqKZmqdUuWfUz9nUMc6s8JZP7Qy1G
	PfoXZdUAx9Veu/UR/xq1pa5dKo4tjR/2/CRYI6p278mEVcKoMH6mshq1IdtodvlT
	BEErW9xjLYoQy2gwZdZRFy2JlWMh1VlAsxmMz0nbHbaYSDRVT0P/zeBNo7PPdxnm
	Vo5TkPIVLa59TnL1Ilh3iw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46e53p804k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 May 2025 09:00:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5444fLML036209;
	Sun, 4 May 2025 09:00:05 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012054.outbound.protection.outlook.com [40.93.20.54])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9k7ghfj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 May 2025 09:00:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VLIGgkFT5nYmzaofitBaysC7H8yFDbiL6WannGo4Vl4Fv+4FvdN5NoTz+yw3NFNmGgEs7SaRhHTwOJlaRtueeiQO3k3se2I56OKvfUCXJa8xuwnLYWwIJ2Y/wu+QLLnk2b92yycJG3wnsEjE/mcpy0yMxtuMksFvSKHzLBmhydy+/nmcBcPCBbyp5mYbxsRny2ef4jRv0ytxlX031yt9fykv7E1pIT0nRQsTXtLctCRuFp4pSVx3bo3oDDF6c3YGqo8Me8rvAakLeXtee7KdSFUybBohWNsXi4qeDR3P1WAxJPOCR2nv9xNJ+mJW5LKVPTRrF4kt1Uh2Z9Ff7LX2pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=keV9W0ffoML03s5DKKU92wyZhPD/Bmw9lCz20VCC4ZY=;
 b=EIRVfEZpAGBjXvsx2XplyGtp0dgZBtz3Cb2070ec/Jmm9Ex5udCIeolDuHC5LStcJEF4vSgHpp5JP8QogYQfJi86Bdq5Rrl8dmi73koqFFkmHyCX+VvlGnbAPXNA33/MvEATeMOzE/4pI8dVIrvqPNnvWaDCcGZ1Ywqbm6hDWMd7Ot2EEmRq08CDjinRO61ETIWIWpuzOgWl+DpHpsHtOmvSp5xfPZ+qFi8+TEe/1JNnmxOphhEUzTkpWwJGp7lnUhcdsIwDX5h/CEF8gCW7j58Q7inOMlMSL5QPMJPSfk7Emd2thky0+8k4oMFsXj9BWp1KdBP0LBxKEsK/F40IHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keV9W0ffoML03s5DKKU92wyZhPD/Bmw9lCz20VCC4ZY=;
 b=pmHc8rTYokQtGhYQNJnRx/3vE58GUuOCbCqhT2mDhINsRvdnAGN+sViC8GgAQ9TMKVG4sUXTzeJ/t1GLbHgkES1ASe9G4HnYTi2qRPGw0h/M0hnmjUMcOY4/sVPqRGjnpdEk6cRT1Fd6TMH7qpiKkgfXPTaPzsePw3Fmz6a2q1Q=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB7178.namprd10.prod.outlook.com (2603:10b6:8:e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Sun, 4 May
 2025 09:00:03 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Sun, 4 May 2025
 09:00:03 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v11 06/16] xfs: ignore HW which cannot atomic write a single block
Date: Sun,  4 May 2025 08:59:13 +0000
Message-Id: <20250504085923.1895402-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250504085923.1895402-1-john.g.garry@oracle.com>
References: <20250504085923.1895402-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:208:236::12) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB7178:EE_
X-MS-Office365-Filtering-Correlation-Id: 25228e17-6f11-41a1-1bc9-08dd8aea0eb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?15X/XdBgatdPm7Mk5juGdiL1vhlIpdsqf3uPvTiSD8nWi5VVOuw86c38Y30I?=
 =?us-ascii?Q?pMJoXQynGFfVygGYZj71DcOXS5k/eufsQKe24PGe/GHM3WUSylAtoMOBOCYV?=
 =?us-ascii?Q?WZAHwXRK27l2Zt4Oj5/kTsLSrMAfxN08RgpOPtXCqdLLUIX67gwdAYDmXhdW?=
 =?us-ascii?Q?1aW4fRqS73H1Oa7scmAD7ZjddpPKwL+f4v8r688XZJYzgG3X56mGB4Y0bhNN?=
 =?us-ascii?Q?IYEUtoigxDqQy4BnqubE+BJ6W2PyYqiroBho5elXkEHubBfQJhF3HqbX4cYw?=
 =?us-ascii?Q?ov8P0qyLKh2KExC482MNblO5Og8J+liEjcw7Cnm90uETI/R4hvR/Fyan6135?=
 =?us-ascii?Q?ZQr9A9eP17NDArdcFdGCsl08yaekRMAYrybB9TIxubSpXCxeW4QaefctXHOJ?=
 =?us-ascii?Q?WNSmDtlru7BMNFtpPpKgZaQA+hUP0VO7ALaSoFt/9gLaZzF4dsldo0Y3b3cG?=
 =?us-ascii?Q?rulAV+u1aa3ZzxMh7AS11UxErgeqhhRKiZ3OTUNwNAg0Qvvk9M0zjfjSAm+e?=
 =?us-ascii?Q?GNjyfzn4IE2/CIaDNCR2hV3+nlAxG8buoQ3w46p9nRnmWFY2RxEqQgiDIGxW?=
 =?us-ascii?Q?nIiCXHZHQD5rFVeybSEvuyRmVmUnPm4A8/U3uSpYZUL0ux1M+PuO0TJLKkx6?=
 =?us-ascii?Q?UlE6IljJLKEnp4wKRDZ31K3gOCTiYqWDnaRUnk1PB8WtANjaXJcwrQGvixyV?=
 =?us-ascii?Q?3qmC2LqFy/OOMkKgHshwvF5aPcVQ9aemlquFS4sygPLQ9H1NAOQ360rIrQLp?=
 =?us-ascii?Q?KC98F5CMtJc3U3f5Vo+RM9OaFFBGvO/RtDTQjYBrLJ2sOnmhO+laSsJGIJG8?=
 =?us-ascii?Q?wxrvKUfUr6hpqJqYN/dABPD9AqX6LDpfVBsrq6n4+z3J4gxexUBiashitgaD?=
 =?us-ascii?Q?uJVELWzc0NjComYTrqOya8BlqsxCWLQiDPJ4m0mRioyNAVKBvGx1ceF4gyso?=
 =?us-ascii?Q?snzi0vbOp9arndMRgh3q5uEZQd9B31AGqltwR07D46HdV4QnxOgdaT8OSoGS?=
 =?us-ascii?Q?dyrGqP2VuZ4TTGfgeqJyonUUm7/Zc8s/7mbTDOcG8JedL6Srv6z4c7Eb/B82?=
 =?us-ascii?Q?hJLckbUV1vjzJC+c4tswH4qBk4MEWfO6Q+S1abvlDH/VCQh3HJQsoDOGVgmU?=
 =?us-ascii?Q?Phpzo5GiFNvO/NCyNw+wGYqZC1Wh2GzdwcsGja23lxFRkK+kR2tXzGS8vAwp?=
 =?us-ascii?Q?36rNwWp3gvNNKj5sRbYcA9SIKGhZ+8WEMbm2rAn4Q5kXlqceIiwAdjUiLD59?=
 =?us-ascii?Q?ex1W2CLrXXqn3wqf4pVSfCQ55IYdgcje7PPM8gpTDdgyQruM+Z+4frjcnR0O?=
 =?us-ascii?Q?2kTjwWHlipzR+jKFszgNKD8mNZfZtSsdP5mXZ4sQVHQkTpYIE1VR55h4QVzR?=
 =?us-ascii?Q?Rzgple4tuqlzom5ybsaejKfKMN+esMiOmqi6JQzX0Q8aySJHhlPU9Tl39wIK?=
 =?us-ascii?Q?LZPuuo2gF00=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ztuDxFzXib6kf+2rd+rdHKNwB+n2WmkzVz1nmEXdGM7eQg8woj8nOBZdxP+I?=
 =?us-ascii?Q?C4fGZC8sr/CK+LwAGatL4bqTq1YSzWPepi8RtZx30Hta1IlNxuiBHSZZ6/f1?=
 =?us-ascii?Q?eeEqSvJCBrcFz7FAvWpd9MiGe9NvoRc2e5B6MBHlk1/T83HAaCTNLRUyP11Z?=
 =?us-ascii?Q?8ZlW1CEPc/DFM14/4pEQrqZdMS2XXXNTvKLUfWJ8FisBnGs7rq8rX5yRRMCF?=
 =?us-ascii?Q?shbKI0K4X2njj7QVPZF/s+F5ogxRhfu+RqdPAIAK0rJ+/T44m6B3Z9bvUWcC?=
 =?us-ascii?Q?EPy1UD7UHHgSVa1gTkULcGs0RbTuSSiKEdY6YR7btZX7HTLwwCBDOcFgc6Xs?=
 =?us-ascii?Q?uD+ckZlvSW4/aI6as4APTbPN4LcLdY4ftFlmBt0FmOfNisOwVzGQCU3XZGK/?=
 =?us-ascii?Q?v0AizmZa7X2fqwLFocYinAyPDt4ktkPwqiJ/yNhH++/wNHx8SsZxrqb5rekL?=
 =?us-ascii?Q?6vDlFhVdEceaU1X4V4L22h5DX3Eav2jYb7EfFkTewuRCC+FluuQxlZWPRWc4?=
 =?us-ascii?Q?kkDq9k9ZhUi0vcjWG8ukqDJZ/ufNQI5jgEbxDifLwK4sMgppaibeVL9oRo49?=
 =?us-ascii?Q?FZjLPZQO6xenqcu3hK5DjZ+HYgzGHdqRqbg7v1xdhx1o6Q4u/7x/p3LknipW?=
 =?us-ascii?Q?pb/4fWPxY8yeTKYaR/+5Ww1rZl4OLHiK6b9Q5DY/nNeByltk/SL0r2UzZ3s1?=
 =?us-ascii?Q?rxzdfjvVJaaa0RKmo1s1+TcwRbvDOeAl1OwlFns/lqcNja2pJa8FZdeESihy?=
 =?us-ascii?Q?H7dchgui4uBIkPxclpTxo6jQA89qq1TjFCCroeK5Gz61lL+HsNLXF4sPL1bS?=
 =?us-ascii?Q?adzzak50ilvEnTlmcAP3qo2m9msXPTrRnTsVnKdp69ZjiPPWDkuCcx5Bp2j6?=
 =?us-ascii?Q?Y3ognQnW9+ExqtOIbYHzlEd5IRpJFm6W90A99PrK12W4O4nxItFL6bqJChwX?=
 =?us-ascii?Q?Co9RZRL3tXWu4YcFF1gE3Yvn5ETg1X4McbQrm7DocEzKb6GUsgkrxow1jcKX?=
 =?us-ascii?Q?8oAXFmi/fHfyQ9pTZ/ZKIMHhnLSWyujxSTMB/0WzMpyOt2sEIltuyj8fdpE7?=
 =?us-ascii?Q?tBJ0NCttC6BGkzc5GquNgqSFqrBiPT5MPhqf7IyoXELg6kIGe5UuhwlCHRj1?=
 =?us-ascii?Q?AASV6yYRqXnGf4/8RtD2jWI1NfqiMx0DXKQU4DKRhkCGzcnED2X0LLMsdIs/?=
 =?us-ascii?Q?9XghfGeIs3/jk939RLbediBXjOeTAd5xbt4DA7ZcD9dLi1ss+zyxcsq7p3/E?=
 =?us-ascii?Q?VEYVCMpgZr8S8iKspLkEzorn1d4A8gIjSeuYWAomf/ppwfmAMxOHoV7uQo1P?=
 =?us-ascii?Q?ZvJtFJiGha2ywiCL+b2r/MR+01Y0l13DvUj/nKti5ex8LquS5955UyFx0XbA?=
 =?us-ascii?Q?QpCGf98QOtY6+8lrksamAwQ6IcFO+gX1sMzZRfmJ3/rPDo6ZUkyGzXQ+3CQu?=
 =?us-ascii?Q?JlDSFTGg6FBBA0N0BLungZ0P29j4phvAQNxmhXY6bFDLxW5P6j6A/Jj4FTK6?=
 =?us-ascii?Q?J6MSZluNsnHr96EqU3b4RiO4bvyju5QY0gwPihFS5EMEKka0H/kV4o+qIhur?=
 =?us-ascii?Q?bjnE7DE/Kl7RWMS6z9nc6xII/FzrdDaFz7XC6irrhR4jHKzrmeJKJuvcQdyQ?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5WVFp0riLL6SEFRoI/8/PcfRDOWDz2dIhTm3YVeeDUY0nEmAYVAqc/v4xJED74/D/HtIgESxbl0pBr/R71WECTqMoVHMsURKroae5MM3ZAxUDJr0QyXo6Q/6FBeIvsZAmG/UohUKf3AkH06Zh3LvunDcMEAZjkTF3EnHOUl6IGlOqwgg4iW9862x9dGPlm0Cb5bKaMSwXlAzX9BC3wnOv0kb6/WqVewvVFPANT7MQ2Dc3LSGCPVcNFTQQBLibrH4pcB3YHdOkHtBxT0jqJr8Sfbk66xibHG7YwR/qjxpzasG5D0o7daceoJ+J+Mh5MqUehznp0yIlL5l8plMpcjfO3rsDF/m0kCuzqyIqKxja5DTTMQ0LPBsZhsTrZYp14DONDrh4ayVaGrI3dbfXDlaSQp2c9li/SEadWM4W/w1PJazaAgKqlTIfUMUZYJgh9biCR7HMOV1W6XnjVRRRqc60ukcC9SbgEPTotLuQ8naEbSvbAcccSxjaDzJypEgFZ4a5rakbRSVv1SbPdMQGGX4XId3Jyp79KDgHPr5sGFHcu+zaDlJmiyHAUkT/F21bpCo7N6vjmYT2I4uUVHXgDMQHDiOXykq0xNuTf7aPtU1kGM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25228e17-6f11-41a1-1bc9-08dd8aea0eb0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2025 09:00:03.1566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0RP0u4/CVfSNtpH1WLfMLXrjW5DdUwnCv8krXtVtbEkfoFmWYVYpMY7uaDoS3u4IQSpp0PZ7n/GwyEebS9j0rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7178
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-04_03,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505040081
X-Proofpoint-GUID: hlUJ4WqeLqk8EJt9hwaWifsAYMFy9j3c
X-Proofpoint-ORIG-GUID: hlUJ4WqeLqk8EJt9hwaWifsAYMFy9j3c
X-Authority-Analysis: v=2.4 cv=eMcTjGp1 c=1 sm=1 tr=0 ts=68172c96 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=Aw58oTtQWaA1gqLR3HAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA0MDA4MSBTYWx0ZWRfX2MVYHmrul5j2 xEdJvG0oJEFcd5kjT8ZnaAH1C/6lW4+pj/0KPwwJ2CE1zlNNJ/hWYAfhO+QhGNodb6CwZ/I+ngi AsKGAYAIdDN26Xc06++Rv/6ivE9wjsEDdtJNqWSMNdoy4N5E9Fro4oWPsl5yyxHx/43CBovGCSp
 JYDPsYPjfD7xqgOVW97xRJ7WB3bEJOI9dq4Lv7jMrJAHqEDRk7w5VG5ssw0nR7yj5aEUTnuUvli 9F7ZbSjOQ3VTkuY7N7BL/7DSkUVeYbd3Rxzo2PYYnTYMrAf64Qfzw/lsaUKOyjNtCj85lIOHkJQ vm9MDw+4dSP9TToQHuHWiu81i4g/KryJrH8t/Ks1d+O4U9bE6MsZ11yRcSzRoe+8Il/Ji0nKpPK
 OclWC9faFer6Eb8Hus8pHPZweh5ZaNpwUIuAir04dMWXxjQl4IAPOI76L7QFs04/tDGZAH30

From: "Darrick J. Wong" <djwong@kernel.org>

Currently only HW which can write at least 1x block is supported.

For supporting atomic writes > 1x block, a CoW-based method will also be
used and this will not be resticted to using HW which can write >= 1x
block.

However for deciding if HW-based atomic writes can be used, we need to
start adding checks for write length < HW min, which complicates the
code.  Indeed, a statx field similar to unit_max_opt should also be
added for this minimum, which is undesirable.

HW which can only write > 1x blocks would be uncommon and quite weird,
so let's just not support it.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_buf.c   | 44 ++++++++++++++++++++++++++++++++++++--------
 fs/xfs/xfs_buf.h   |  4 ++--
 fs/xfs/xfs_inode.h | 14 ++------------
 fs/xfs/xfs_super.c |  6 +++---
 4 files changed, 43 insertions(+), 25 deletions(-)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 292891d6ff69..770dc4ca79e4 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1714,13 +1714,45 @@ xfs_free_buftarg(
 	kfree(btp);
 }
 
+/*
+ * Configure this buffer target for hardware-assisted atomic writes if the
+ * underlying block device supports is congruent with the filesystem geometry.
+ */
+static inline void
+xfs_configure_buftarg_atomic_writes(
+	struct xfs_buftarg	*btp)
+{
+	struct xfs_mount	*mp = btp->bt_mount;
+	unsigned int		min_bytes, max_bytes;
+
+	min_bytes = bdev_atomic_write_unit_min_bytes(btp->bt_bdev);
+	max_bytes = bdev_atomic_write_unit_max_bytes(btp->bt_bdev);
+
+	/*
+	 * Ignore atomic write geometry that is nonsense or doesn't even cover
+	 * a single fsblock.
+	 */
+	if (min_bytes > max_bytes ||
+	    min_bytes > mp->m_sb.sb_blocksize ||
+	    max_bytes < mp->m_sb.sb_blocksize) {
+		min_bytes = 0;
+		max_bytes = 0;
+	}
+
+	btp->bt_bdev_awu_min = min_bytes;
+	btp->bt_bdev_awu_max = max_bytes;
+}
+
+/* Configure a buffer target that abstracts a block device. */
 int
-xfs_setsize_buftarg(
+xfs_configure_buftarg(
 	struct xfs_buftarg	*btp,
 	unsigned int		sectorsize)
 {
 	int			error;
 
+	ASSERT(btp->bt_bdev != NULL);
+
 	/* Set up metadata sector size info */
 	btp->bt_meta_sectorsize = sectorsize;
 	btp->bt_meta_sectormask = sectorsize - 1;
@@ -1733,6 +1765,9 @@ xfs_setsize_buftarg(
 		return -EINVAL;
 	}
 
+	if (bdev_can_atomic_write(btp->bt_bdev))
+		xfs_configure_buftarg_atomic_writes(btp);
+
 	return 0;
 }
 
@@ -1795,13 +1830,6 @@ xfs_alloc_buftarg(
 	btp->bt_daxdev = fs_dax_get_by_bdev(btp->bt_bdev, &btp->bt_dax_part_off,
 					    mp, ops);
 
-	if (bdev_can_atomic_write(btp->bt_bdev)) {
-		btp->bt_bdev_awu_min = bdev_atomic_write_unit_min_bytes(
-						btp->bt_bdev);
-		btp->bt_bdev_awu_max = bdev_atomic_write_unit_max_bytes(
-						btp->bt_bdev);
-	}
-
 	/*
 	 * When allocating the buftargs we have not yet read the super block and
 	 * thus don't know the file system sector size yet.
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index 132210705602..7759fe35d93e 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -112,7 +112,7 @@ struct xfs_buftarg {
 	struct percpu_counter	bt_readahead_count;
 	struct ratelimit_state	bt_ioerror_rl;
 
-	/* Atomic write unit values */
+	/* Atomic write unit values, bytes */
 	unsigned int		bt_bdev_awu_min;
 	unsigned int		bt_bdev_awu_max;
 
@@ -374,7 +374,7 @@ struct xfs_buftarg *xfs_alloc_buftarg(struct xfs_mount *mp,
 extern void xfs_free_buftarg(struct xfs_buftarg *);
 extern void xfs_buftarg_wait(struct xfs_buftarg *);
 extern void xfs_buftarg_drain(struct xfs_buftarg *);
-extern int xfs_setsize_buftarg(struct xfs_buftarg *, unsigned int);
+extern int xfs_configure_buftarg(struct xfs_buftarg *, unsigned int);
 
 #define xfs_getsize_buftarg(buftarg)	block_size((buftarg)->bt_bdev)
 #define xfs_readonly_buftarg(buftarg)	bdev_read_only((buftarg)->bt_bdev)
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index bdbbff0d8d99..d7e2b902ef5c 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -356,19 +356,9 @@ static inline bool xfs_inode_has_bigrtalloc(const struct xfs_inode *ip)
 	(XFS_IS_REALTIME_INODE(ip) ? \
 		(ip)->i_mount->m_rtdev_targp : (ip)->i_mount->m_ddev_targp)
 
-static inline bool
-xfs_inode_can_hw_atomic_write(
-	struct xfs_inode	*ip)
+static inline bool xfs_inode_can_hw_atomic_write(const struct xfs_inode *ip)
 {
-	struct xfs_mount	*mp = ip->i_mount;
-	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
-
-	if (mp->m_sb.sb_blocksize < target->bt_bdev_awu_min)
-		return false;
-	if (mp->m_sb.sb_blocksize > target->bt_bdev_awu_max)
-		return false;
-
-	return true;
+	return xfs_inode_buftarg(ip)->bt_bdev_awu_max > 0;
 }
 
 /*
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 45e188466e51..04e361664710 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -558,7 +558,7 @@ xfs_setup_devices(
 {
 	int			error;
 
-	error = xfs_setsize_buftarg(mp->m_ddev_targp, mp->m_sb.sb_sectsize);
+	error = xfs_configure_buftarg(mp->m_ddev_targp, mp->m_sb.sb_sectsize);
 	if (error)
 		return error;
 
@@ -567,7 +567,7 @@ xfs_setup_devices(
 
 		if (xfs_has_sector(mp))
 			log_sector_size = mp->m_sb.sb_logsectsize;
-		error = xfs_setsize_buftarg(mp->m_logdev_targp,
+		error = xfs_configure_buftarg(mp->m_logdev_targp,
 					    log_sector_size);
 		if (error)
 			return error;
@@ -581,7 +581,7 @@ xfs_setup_devices(
 		}
 		mp->m_rtdev_targp = mp->m_ddev_targp;
 	} else if (mp->m_rtname) {
-		error = xfs_setsize_buftarg(mp->m_rtdev_targp,
+		error = xfs_configure_buftarg(mp->m_rtdev_targp,
 					    mp->m_sb.sb_sectsize);
 		if (error)
 			return error;
-- 
2.31.1


