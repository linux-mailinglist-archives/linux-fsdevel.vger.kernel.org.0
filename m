Return-Path: <linux-fsdevel+bounces-57780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63986B2535B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 20:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 426C69A20E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 18:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506B3302CDC;
	Wed, 13 Aug 2025 18:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D6Og6D8f";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HFfjgMy2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC942FF16E;
	Wed, 13 Aug 2025 18:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755111235; cv=fail; b=nsdSYz9eKCIyFCwdPSceTvH7AkZxbxqxcGwUlkAca/sZUmeIIpCBoWnVftb3rQ7IL/CSfoftykltV4K9amGH4ibankADla73aGfTW1w7U1YGkBWPkvr6/9ixzLIs9ui8A9p9ct6I4PlDRVE1K4ZfBJtZwm1W4W1avbUjiaAUbAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755111235; c=relaxed/simple;
	bh=KyVaooFEBXWjShvMW3P6pgXmuvfiwvJQPt26O7iuf3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Tl2lnKo3K5phwffp0GzybmqycrCOvcllqHsyjGc0/DP+FQA5axChAnvGqGWEmr28gK3yv0Ofmj8xkIJVHI2q7DPSPkMg/4Xb5BJVy13x2liQQl2IzpNfI2uc3NMuwiLUKVYsfoPUaALnzxAhvE/BMRCpE1V8I3mV2nFMFQrduYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D6Og6D8f; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HFfjgMy2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DIN1mb007253;
	Wed, 13 Aug 2025 18:53:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=KnV9A1HwY1RPXICY7i
	tXa+z/q+NIoYync2+k+YtmHYE=; b=D6Og6D8fJvr7Q2oR1Zy5u6VXBT7irPOJPi
	RwaISPSDif8dSrla/AaqRU51se7FHW/ijywAbroIYJS+qvx3gKvxhplgAaKap30I
	icDk5J1JRaCkwU3nKAnipi45V8VapVqL2anRobVt38shOQ1O9alkp101xdpALKxF
	sXtYHrIyiLZKxYSttqU+YzKvINSRvSN4QUrIAHrBNtBSQzUs24yU+oR9Rt9rqwqU
	qp4COmzVv3CuHVxGEz8P9jPpfOjUBluTT7uOYKe4ODAZros6h10D61F7J9volwgU
	aC/dh33Rtc/6iPa9Jj2rtneCQpXlzcHZkQckDJcjEHz9j4hDn0bw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dvrg061f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 18:53:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57DHroFv009928;
	Wed, 13 Aug 2025 18:53:04 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11010025.outbound.protection.outlook.com [40.93.198.25])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsj3g9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 18:53:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sv7Kzu3XI6Ay2CHyg8IKypupPwMZFv0RrgJaE6e6Fa1X450j9+6Gr1OeWtngXYO/seMQtO9zjTaxZKFy+dBibP7PZ8HegfOMhCHQhur28LoHGquZweXOOrlh9W5jLOrVNVEx/vVAQ/PJzmB1DjXLeVoe3+UbriP+UiVfEwvBbQED/wTQAv8g/Ko22a49h2gFPET2Ql0LLogOwsw9sSkCXGHZNNloSxEw5z7UfpfpTNO6ZfoIVVZXy/8gq6CQ9bPHUxSaJcM3Hx1MwFs9sQiLZgZkTYXbdmGLlIu1LUhEfBFzZHghzvBrhDOdxBTuAmbp4BwpUqZGbH1IoPethH8AXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KnV9A1HwY1RPXICY7itXa+z/q+NIoYync2+k+YtmHYE=;
 b=XItPVctyz6dgMc9znx8JRVxhV9H4aPHthqejcDBeBnGcM0DfebfOKFfcqKotccabz6MJI3b+PMkCDXqjErXNOuB5z1i0+9kfvRMRZbs+CUUZCyrkV9ThWwh7VEZArswVGDWz+IRZJut6yq9ZjjqiI+kgqSFJaV6dGaIfKtzRpapqNdleg50z6BrWHKAo+4XP1GKJaaxuBVUCNt3sKBwd1JyJ7DeQDIKIol+129hX5G8KxjebPyEt+kfSw1/XDPHg3XqzM1wUMaAKgWothSJ6PEXYv3o45oaPTY2ygVBv0hYP/BA+rEd1oeRk91XtcOXCa8czw+7cskACbY07OePBnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnV9A1HwY1RPXICY7itXa+z/q+NIoYync2+k+YtmHYE=;
 b=HFfjgMy2sHGbd2GtPi3BCWJ+8FvAXSQfgSk3aA8UUsVED7efTEExNd0JDXeL2uflONaa5L36BW2VD1LobrRi2XEbOdTvluwmMNFlNLjzeKczJpGddSzl9T9OiS9shplL2+csSbDYIRO3W4Tl+7LtTJT0MKCy1QB52Ng1Ww/7SfU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM6PR10MB4122.namprd10.prod.outlook.com (2603:10b6:5:221::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 13 Aug
 2025 18:52:55 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 18:52:55 +0000
Date: Wed, 13 Aug 2025 19:52:52 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Usama Arif <usamaarif642@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, corbet@lwn.net, rppt@kernel.org,
        surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org,
        baohua@kernel.org, shakeel.butt@linux.dev, riel@surriel.com,
        ziy@nvidia.com, laoar.shao@gmail.com, dev.jain@arm.com,
        baolin.wang@linux.alibaba.com, npache@redhat.com,
        Liam.Howlett@oracle.com, ryan.roberts@arm.com, vbabka@suse.cz,
        jannh@google.com, Arnd Bergmann <arnd@arndb.de>, sj@kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH v4 7/7] selftests: prctl: introduce tests for disabling
 THPs except for madvise
Message-ID: <5b341172-5082-4df4-8264-e38a01f7c7d7@lucifer.local>
References: <20250813135642.1986480-1-usamaarif642@gmail.com>
 <20250813135642.1986480-8-usamaarif642@gmail.com>
 <13220ee2-d767-4133-9ef8-780fa165bbeb@lucifer.local>
 <bac33bcc-8a01-445d-bc42-29dabbdd1d3f@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bac33bcc-8a01-445d-bc42-29dabbdd1d3f@redhat.com>
X-ClientProxiedBy: GV2PEPF00007578.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3f5) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM6PR10MB4122:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d8e400a-190f-4553-f011-08ddda9a9d17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NNAfRD0DVvoz5Zbkn1mbewpfn8NB6AXjUrVcZBihoJ2UBdAJrkSIRz71m5B7?=
 =?us-ascii?Q?SRtbcr3jjSoJaotTe0Ma5TukJprlbOGLOawvMD+mxg+J2hrh7j4PjxhRzQKq?=
 =?us-ascii?Q?G7VlKZTKn8CgnX1q2kgs0LucIqA3UXXj4uUgLaCz0o44hPUOg6DuAM0FeFYT?=
 =?us-ascii?Q?zxF+onzRffv+6YlH2pZwim3d5We6w9KZpMlXDbnPl9TOiSythJ3UnQLh6boo?=
 =?us-ascii?Q?sw6zP2YsVWN9HR1zVnyHdEWfsVkVjYdHs0XlEy7Eq0WdIZtN/l8+zOYy6dXS?=
 =?us-ascii?Q?6p4ZlSN6VEiPHMFGwB+o76V259C0ckkwFI2bXIY6/3T+eQwIyEs19Nhy2pNO?=
 =?us-ascii?Q?35lgsxupQ9XnNV+4NcSpESEnNPSYKDaeTOE1mtuw3DLLxo466slQy83JYuQu?=
 =?us-ascii?Q?HUHC6PCKeELzG4NPbhN140Mkhu1lyj7HyYSB8ULNEz1Cd3NknUziBdIGLflU?=
 =?us-ascii?Q?WijrVrj3IBAmXcF/+u3G81orfOS7mNvIFQNY6lXT1MB1trzK6mpkBM3HP9wr?=
 =?us-ascii?Q?7bciFg8Am6eqeNHiubwYC938K809kEc3SKloxZSLrs8y5nj2sRCJJSoIWWoT?=
 =?us-ascii?Q?yaaTLpdgA+oTehbmwdaixmZcHgA+ZCD9Cu9pW27EHaPqF9Ls1bUEk7W3AE8O?=
 =?us-ascii?Q?Qhd2vjoqiZm7bGSINtDKgzUFJle1o6ur9EOdcmmdrPvrHEe57O3tVdhYDejx?=
 =?us-ascii?Q?APv/F8UNBX/81MBL4pscxZmCAbcsE/nBBRdfiitukGsUh/QmlAnzxNJcrT/v?=
 =?us-ascii?Q?sTE5TkYJbGVgPHn1q9iv+TZVCOtOCHyvRtpcD1VE4EZ1G+TlrxaciTFpbRDF?=
 =?us-ascii?Q?NwoR7xx96M8PIVe3CUk8vgcrvyqQp8kfRPxGMwmerRdqkFiL8J3U0vNNNTRF?=
 =?us-ascii?Q?eqDFf80JN49puWTQkJ+nPzvLa1h8cq4Mtv1xSHSsGgw2PEsURXTO1C/W5WVQ?=
 =?us-ascii?Q?wSQzARdCzz4iVPpQ8HTEREgeCF1A4s3pxvp2GcQiOPT9Z9YBcE/42fBtvlpb?=
 =?us-ascii?Q?gHeXPeUB1SG8KMxv2/H6K7tM63DpxE67mTEjlZZVWLlLWyUspLr3XZHixEFM?=
 =?us-ascii?Q?63OyVImDh5PBYggrFQQst+VXNON3wDkwZ9t3jhnxHxtIHpTr8WA0EXVPCvcY?=
 =?us-ascii?Q?SHY9fkFjCc9ZmXXZjeIgbvFh4iHutMZTHZctlEQRsAx26NBO20k+dhPErKOh?=
 =?us-ascii?Q?svSJJvnnKpt9ftwVsOE2OCh3D8rPYM5/0BMC7G7TcL2fZQAmtctegH0MbKSo?=
 =?us-ascii?Q?2SagSTVx9Vv0myWmoQUEfr1nV50OhVS07ttScPOeDDe5t1aMRsd8fptyUnKW?=
 =?us-ascii?Q?hOdnsx3CzARkHnUK1r8HC8TbEpBA+vJDL3z6t8vSFnProEif52+/k9oj2OZR?=
 =?us-ascii?Q?EvCIgRVNGvDbFw51HAdV5fdM5/XzlAPYKgxLZT8cc5ToV4h4YUDviFOl2CNe?=
 =?us-ascii?Q?bfOCjymFGAU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YQfIfWDEDeVvqsC/Hiyd7pEG6XWyGa/e2FGYK+G8Ug5rirYPlSQjaxEAtu5M?=
 =?us-ascii?Q?MVNO3K78EnBrjn2ip2X2jWpegbsUGhGlA/zgrWVPJneRn+X7BakGGomORYe7?=
 =?us-ascii?Q?iEiIfNyIaq3UZX0TXCsh9hd7ZI+/G2Ofq3NcahZtR7ZpJp+An9Dh5M602ec2?=
 =?us-ascii?Q?dCt6R09P1plBUhVBT+HQ5RFHmDm2w8thnWelobVooFmtX+Sy87z0Fmm2VO1j?=
 =?us-ascii?Q?KwQmt/2YFEMzIQ2vdElT2/M3LUTac4SnxbYSVltvCauW2NBeA26lXaWRiABF?=
 =?us-ascii?Q?cNGU/NJrWxzEXufbxNnEcUuCJrwUD0MPHZg7ubo7zLOengKdMcQCIsse+mFX?=
 =?us-ascii?Q?AQ2CnvE/yk3eELVNF7IqoWX0uvgUWfJZd2Skjdeez86jvNB/1fHNwTKDU9yq?=
 =?us-ascii?Q?c0O5ebZjlHTdYtXFH+kzZHYxSeoBJPkV3sDN2+FEzCsfI5Lzz65oEbpqa63d?=
 =?us-ascii?Q?+xO7M5fIv5QG8juyAtcRkAuKjRJdplBCJZWv7zmDVEsy9N5ZQ2NHEfeg98J8?=
 =?us-ascii?Q?TgJo1j1oyOQDb0wCsjCcIHsloOomZ9cqm7yQrbb0grdkIPkW8BCyp5UhJjlt?=
 =?us-ascii?Q?dPRtHoUnmO/5qRSWYP3Am98kMCdED6FcQCgTyy4IDMIl/RMeoyZDxPSBPbUl?=
 =?us-ascii?Q?tCEOfryIUjVl1RUVMldgOx+pk+36vMPI9pcn9+6IyPWtdA7j9o9dOgiLPpbK?=
 =?us-ascii?Q?Y3S9kX3tlk5pM4H0T9jFwYZiH6e7sLJiCiwH7hac1FfsRGdheRAJPJHnB1ru?=
 =?us-ascii?Q?8Pt7p23Rr4xQh5QHENWYngoUG4vOo8nkKLV/0nSmbXhHhoqx/d8qsbYfMwVA?=
 =?us-ascii?Q?gFLCnGtxI55C8NQj7B+JCNoLS9UKnV2Yms7hp3k8cFAsfYYSi0SG0P3llp0Z?=
 =?us-ascii?Q?sVzYCpwNfuoCQRBNu8iqUX034Wi+XUudALbnBcIk2eo0EQqd4QmcF/BSI0wr?=
 =?us-ascii?Q?wFuo3qPBQc5d4/De4JNxAYRNy5oIfev4+HZxr7MM5zaauXtBrt0/muEqdn/3?=
 =?us-ascii?Q?v1hZhp2QC9RO1QkrDPMFqkkPBMWO2jByXdodN0WH1qGFI4QImLeVgVyzQjll?=
 =?us-ascii?Q?aCr0kOJQ0J0rNEetVoQiEIE9recvOHdmnCFTGqpBuADSxVPsK7hkyHA7Srta?=
 =?us-ascii?Q?WvcjlnbEpjE7J3NZV6muySTnKkiTfw7wwGy/sGAVUe4GTAs966hnRZK/1r6F?=
 =?us-ascii?Q?cCpypLRNbdJD5mf2TbRojGk/xQvnwTCFxZ0MhSnE78OsjCbDBMmLOhhWZlal?=
 =?us-ascii?Q?8qiMvNavJK1KOiujXjMaba7n81R+K7o5jSFKlyMSZ5REQSHeDXfKI5ex5zbZ?=
 =?us-ascii?Q?/QvZtiwZ1WvM8L2MXWQACUijdczKNLSOhrmJPw5mAkDU5A5QiU4Vsk4jYvna?=
 =?us-ascii?Q?evrs3bZN/OF4eRKLnMftsCXWIRKke99c4WwvGoggxgOjaVuN8IwqCbikh2Yi?=
 =?us-ascii?Q?kH3wUwYcdQDlm5n/j7fFAgDJIDuBIVefabxP/JJM5NG/g8BV2G7uHuCfDD9Z?=
 =?us-ascii?Q?mBJzBR1HwybmlBW2fCrs8kA/0LEpLNBQtfRbOs66UlyLNdqXWCwxwuxsmdpl?=
 =?us-ascii?Q?zN0O57vmChDUyuAQTF6zHfAwg+W6W1A87yKcxMGCP+aLZpQQ7+8bDNG5kqC8?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7MofOf80dxMZblPiMEeTZbZ9lgqICxSxShhBr7j7vyvaBQiP3ciNSUKo+gzn7WLkoonGTl060m0JzAdcgTa3ZmQxR8lHfW27z5RghYMVKBVaUU8/765Tu1oxNmow4mxQPdi/j1q0F/1tZmAuOG1xQbdp25STIzFv8MR2DO6r7E003lP/jZE+SRMvFUW7tdGXdwpOFVg8EwalCU91MfnqfiQ/ZPl1yK5/2GMCAN/Sfjv3E1eDUdwlxPyL4dG3KFAi+f/66RjWnhN1jfCUv9qTvVWDPtA80naQZM6GkTNBz0uC3zG2DvbXW0gVQCCABSvn/TH7TVNtkNbmRhVFsqxVaG2saKUgOrHk8pY3NnkfD5dz4YnwsdNWJoJYH0iXPOPbRv0sUDGIrJGuib66Y9xgZ3OtYTVw/yn+0LY3fU8A9OatD5V/B7uTRkz2Usk3eXfjhHF//FZzhC5B4DAIoe6ZGkPyiVFq6Wq548/JO77Fx96k+D1KCJnvtHAP1EjPUIkx+voqO/2csphEejzPUIZVcFWRK8dVpzALN0tvstK08O9OZLw+/qre0fcfigQbwzyWLavBe6StoFIUeDc1HXv5Qtg/8RCDczpoxo+uJV/OhsI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8e400a-190f-4553-f011-08ddda9a9d17
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 18:52:55.2788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: olMBp8hFjPOOi0d7XROXGjXW1E0A6Rl1utw6/gkEMVuVCZevx9Y2lTP9Z2JvtQBwEpz7O3a2h0QraPRmAFk757njtHAkjERBo84wlDd/r44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4122
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=734 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508130177
X-Authority-Analysis: v=2.4 cv=B/S50PtM c=1 sm=1 tr=0 ts=689cdf11 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=4-QE9lu3iqRgzUC06WwA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12069
X-Proofpoint-ORIG-GUID: RJKx0ecLRZLuORHZUC-ZPzC1uuNrFz5V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDE3OCBTYWx0ZWRfX/YuPirDppxY5
 0LRahCZEui10iS8Nv2Cjb0GLCUbqxNKJa8PoxJJttZYUJY9XIb2yPXfRFudMYzFhSwvqmTGleg8
 d5G6HW+ONCNDzQ8rRAjxUMn8OYBhUYf6e1jtzu0DNE4tO92hOJ9LJ6z8SkuhmDJSZHXmLKOyx2u
 tbfGxrR2M/nQWTYcEXUWHIGKf8ODV19AQOSs2Cz5k+cLlBQtNmC0pIzaT+AifM/b21E5yHNrpF/
 VWIu2PquZheBwzYFaJ/MayLVlZ4uqwzGhljIHOc5n4+FMdUIANVNnh4ck20jNJpv1GEUVE1JeTP
 4gBFJLZeeP6F7UpJ1K0F+aGDxfQ/4JyXwafn1TqWVRxrF6Gp++bGXCLe1sW3g9qP9cp0HszwwfH
 Dlcx6h6aHaGiPHmSPiyQUhv4Mnf9YHpmphgTxTRQ9E1fPPMhSRYexMBU/9Ih0/PpGmSaxssl
X-Proofpoint-GUID: RJKx0ecLRZLuORHZUC-ZPzC1uuNrFz5V

On Wed, Aug 13, 2025 at 06:24:11PM +0200, David Hildenbrand wrote:
> > > +
> > > +FIXTURE_SETUP(prctl_thp_disable_except_madvise)
> > > +{
> > > +	if (!thp_available())
> > > +		SKIP(return, "Transparent Hugepages not available\n");
> > > +
> > > +	self->pmdsize = read_pmd_pagesize();
> > > +	if (!self->pmdsize)
> > > +		SKIP(return, "Unable to read PMD size\n");
> > > +
> > > +	if (prctl(PR_SET_THP_DISABLE, 1, PR_THP_DISABLE_EXCEPT_ADVISED, NULL, NULL))
> > > +		SKIP(return, "Unable to set PR_THP_DISABLE_EXCEPT_ADVISED\n");
> >
> > This should be a test fail I think, as the only ways this could fail are
> > invalid flags, or failure to obtain an mmap write lock.
>
> Running a kernel that does not support it?

I can't see anything in the kernel to #ifdef it out so I suppose you mean
running these tests on an older kernel?

But this is an unsupported way of running self-tests, they are tied to the
kernel version in which they reside, and test that specific version.

Unless I'm missing something here?

>
> We could check the errno to distinguish I guess.

Which one? manpage says -EINVAL, but can also be due to incorrect invocation,
which would mean a typo could mean tests pass but your tests do nothing :)

>
> --
> Cheers,
>
> David / dhildenb
>

