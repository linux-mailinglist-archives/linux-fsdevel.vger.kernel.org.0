Return-Path: <linux-fsdevel+bounces-47989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C953EAA84F4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 11:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98E5E189955F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 09:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3761B19993D;
	Sun,  4 May 2025 09:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OGJ3irG3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kitaBR6h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A94128819;
	Sun,  4 May 2025 09:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746349215; cv=fail; b=dTB9MLeNIET/Lu6z/78iI+FekEa6tCoyAEhHpfLNTRpDpBxlxkXO1H90lUHNXde3vrqoskXi+dBZ0HGn26cSZbWcLnuXNxpMEsiRcY+Rf50qbhb/kaN2ZgIPVEc+3KdN1pHkaUZbT0TXNtxjtBnZXzUvjQQ4lGO1nfdMw9i4Zo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746349215; c=relaxed/simple;
	bh=wZyGZkcWUDkwl2fYixZtEJ1EyvHtw6/GeKeqR+6rOaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ANE1QA8vQLMv1lICqhRNqtBoIMwz89AKSfdSY41oT233fAyW+nb9lGN/dyauMya2GmPzvQqUOIABU0hbCNsI7T/oHpVqsDxNMEP/2sp7p0M9upuy6TguiaLbj2o7Ex7HNGDu+1zCRh5g+DKNmojX3hTe+qZymj7Swax2n4v3bgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OGJ3irG3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kitaBR6h; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5447b0rU008341;
	Sun, 4 May 2025 09:00:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=FGY7X/rVUPMi6d0cWq4YsnWnzlpHNtQ+nFV6a0BaurU=; b=
	OGJ3irG3YUPkRX2/BnJlP+LIi3oIv7cxAhd5K4pGqdh12U1vMFb42fqhN/YMTpK0
	NKP0wvXVQBb8VwZ/JwaBf1vW/zA66VdQ26k4PL0XkQhATFY/w5EY4xkjINuxX539
	aCMtVgi5tUthfA7C7E/MPVK+Z1jMDzqvFy9eOdcN+vlhFuOI1/f/inSIAmGRJA04
	cJNRHa9E7eBrhm1to+ep4MoWd2cyAAa1GPO1jex8O1J+87L+7DFq59maY+l30EI6
	r/IG3zigsruthhJlY9cvzj3bv61j+psFKa74z4g1LTuNiJ6UGs6RPPfFVfdrSMh9
	MWb+8wVUHC6UWfskT/Swbg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46e40gr2wh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 May 2025 09:00:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5443UDQp036077;
	Sun, 4 May 2025 09:00:00 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012052.outbound.protection.outlook.com [40.93.20.52])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9k7ghc9-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 May 2025 09:00:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBgN9y+SU9AJ1Mdev2OH1GxrgdcTk61wsvYo6rJQhignO8DH3vywZ4ro+j3wsl4BuV6m4WOkCVGCEiXu08Ac1mnPuXGAdAMc1+tsyD8niGfaaSnlOtENZL0teUE3UcNzw+zazISYnVHJkppnAtyhvf3maF3WbHoO7YaKr+IG2BCYc4tiuAvO5YpZRSSxVCgNT9VN9urZ4MynsMioXkTDKmBDh97P5WT2a4t0ZF4W+6lYFSKosRrmUXZ5UzSrlkzUQ87u/GgHBsEFCttp44lFNzjta2+trgtjbH07MSpNBKER9AWIxuMh3wZy7BIkQf9VUG1eenSJDvpayD92WD4Tdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGY7X/rVUPMi6d0cWq4YsnWnzlpHNtQ+nFV6a0BaurU=;
 b=xdEcnqXZlZHooAxtskGatZiYH/nF8FJ+2eGzAhGZzNnFbKvPipdgNt1YkMOAze526sHpVfD4bAI9yCAZZij4YltS0K1DqRkz5q49kTJuP4LvpLEcYrtuKF8GfVJk/SqpMSFzK+q3cipCR/tAq06ZNcGbS89eKd+eV3nZYZhdNzuvz7SwCn3mS/RDEj/qVY3w5OEonkD71giUIlmEvIMCOGFLrqFggM8ZRAPsi0YMt/EJnZk+fcuFed8pAakheAMIA5E9qVAWGfUmwYJHepSQoefCHG4LT0W2QnHFcyMHm5z4HbIiehE9uv+9VfIPtRa+0HeZfafSGbHJZz/mW8SEBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGY7X/rVUPMi6d0cWq4YsnWnzlpHNtQ+nFV6a0BaurU=;
 b=kitaBR6hTKEPD/0bLCOcZLfdTNBUHlE2ZSizJ3CuYAvmlf3T7wX+08G6mp+tMwuuHsHW6EfNAhth4mmhTZRTXXwCKouB3dWLk2SldGZ6Eg04V8zEGBvUeth6jvCBgrLH6aJEb6dWX9tyWZR2T39O9Y+chBRvNbQkxV2XBA7+0Zg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB7178.namprd10.prod.outlook.com (2603:10b6:8:e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Sun, 4 May
 2025 08:59:58 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Sun, 4 May 2025
 08:59:58 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v11 02/16] xfs: only call xfs_setsize_buftarg once per buffer target
Date: Sun,  4 May 2025 08:59:09 +0000
Message-Id: <20250504085923.1895402-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250504085923.1895402-1-john.g.garry@oracle.com>
References: <20250504085923.1895402-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0134.namprd03.prod.outlook.com
 (2603:10b6:208:32e::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB7178:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c60d606-f93d-415e-8d41-08dd8aea0bd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5QnnLtshTWSKgRAdrLo+xYvgflyOLtnIItpIuh1WfZsc814VCtFA9J5QtTUk?=
 =?us-ascii?Q?WPNp/M0Ok6TsBIX5AgZTuLX8jK+7vqkjKIrMbNobYiyIksWZrZl1+CMBumiL?=
 =?us-ascii?Q?IQfsrP2rnzDtBPrpU4CvPHcKnbre3oy42lFbyp9f+8lT3/PAB+qvlzygBRr8?=
 =?us-ascii?Q?XaITP6aVFZMmkyYV3trVmhhQhWb4LLaEkiM0znzOFu+QtFYWfqvBaRitv8am?=
 =?us-ascii?Q?+AyJn5wp1/5L+aZarolnPNCVtAiFoKtxt3KtZi0cyP+VzwtSRyhzQkTnkyyX?=
 =?us-ascii?Q?yixWotrxwdzlx4MP8No7RhOhBwXO9faZueMCdOHh5acKukHdEATWb/rpbb/J?=
 =?us-ascii?Q?puVYhih92lCgKlhPDSBbgIB4N7CK3760l7XAygDJiNTCJP8H6XgUjLh5usRx?=
 =?us-ascii?Q?EiuvF0lq8W3jNAYswD+bH2HS9mq/6EtO8Fwiy5vQY5f5d4qcCCg5g0u6/xLG?=
 =?us-ascii?Q?9vdhWQkUA5n/uFEZfJsBs3NNYcd902yv5WXdP/sa0rHLWnVpwe9pN8PL8nKd?=
 =?us-ascii?Q?UGzSQeUc5lGxfHUJ4G7VQ9pGl/vSQFygbmBYXf4DFVxKPXCsUqneV/50kJMS?=
 =?us-ascii?Q?O8TZzCTmQEvUi9joUf+WX5ICD86RDaJOzhclJywdd129cxnyr9tp+wIH2Snz?=
 =?us-ascii?Q?BipiRVwRkQ7L3HzGpp702NuTZKB/LADKu59cMdQy9nOaqiJj5Oi8slMQQBwo?=
 =?us-ascii?Q?hO6+JamWmXIgtouBcKJORYwwGoVriAc/qHvVWUeuC65FCoyUHOBM6LH/X3pG?=
 =?us-ascii?Q?agOEzz3YEwBkA5m1aaCsZzmEKgja4aCYTUAX91+BVP4/ycVHtEUYLr1cKbx7?=
 =?us-ascii?Q?HpakaDOE1sr31ycADlDDkMR8FJvh5hMLrca0XMrATHNhQMC5by+QFLuVhScu?=
 =?us-ascii?Q?+ZknCTxdPVIe1nqEGWDmhhO/GzWm6ydeCcRD3cGwWeoLP8Lrl3fMxaLbcP/2?=
 =?us-ascii?Q?hswLwTBeC6osDBYLa7dOEvHzZWWp4FyRWG8lsSNSU4B3vVVFSHWUiSWbuSxZ?=
 =?us-ascii?Q?TnFQSY9FmGd8IyzbtYsucXWTkFtUHADPrycHu1Dsq+eEQU9ytSFmoxpu5/ak?=
 =?us-ascii?Q?B+k9qBR4KL8SHJ2x+lVV4ZNjDgVI8AaP8659BKfnPFqYVsW9v2op+o/RRX01?=
 =?us-ascii?Q?fAMdsJx95Yh2CnLlnEGK9TRkaoVH6RdofvxXQXmEVzsvMC5JwcfhR54YBywV?=
 =?us-ascii?Q?O+z1o7HN/7xB8UOesqsze307C/f3HPOikv759x1KeKrWGrLEy7KtiNQrSVRg?=
 =?us-ascii?Q?c1syAYRfo2aB7c1Fa+j5DEpx1oB80V3LZEesgx+UblVbyMtyU4b7xasDyrps?=
 =?us-ascii?Q?8UCT1KoBgdH1tagKbEm2VqV2MXnGKbCGJXv5ItqbQ5KMptEq7c66Sl3V0/VN?=
 =?us-ascii?Q?bxHBEt6WlnUgQ7HZKhxPKS1uSFlTAQnswrUKwfBVy5YTpAHlxfTYoJ+j27Ys?=
 =?us-ascii?Q?8owGhPXMgg0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?svEd1GTEjEEgb0PM2oLSzltemtgTWban3gVAHW2HaFMXhnb/zR3BpBNfL2lW?=
 =?us-ascii?Q?iKn1IpQJ8O9gD7pDFHCVaXLU2H1+kNyS8V84emHRro3d0uOs/AFVK38jOQ3L?=
 =?us-ascii?Q?4o/lA3gwE1viw8Ly9YOSXZF66AnQWwJFcqnyNyVhJYqSWRnDZgTs4psgbkl3?=
 =?us-ascii?Q?wK8MHtJNSbEd0/LPxlm8ZwDBtJtjtXVdCe0bGDJ1nvLTcIjfqI0g5ou8pDYZ?=
 =?us-ascii?Q?c7lMzx82mCckYIl7TbDr7aJQTvAthzCBMRTKIr48LF4sCp3wlP6gyrFzFFxW?=
 =?us-ascii?Q?J5RB2OTcxOz5G/BHCBjzapoNiwASecmjjuNZJv6MpIsgAnTj42ccnpzloT2s?=
 =?us-ascii?Q?mrymHNhMFq6iQgrM6zD+U61c6TXvnEBMWksT4oJNrCFnEOOZES45UwhBP3Q7?=
 =?us-ascii?Q?NkdUx/8UVrj00ptgIbBAaM4/vN2JUSgTEpJ9i7HrE6lHntiCYQ83lXaQJVV/?=
 =?us-ascii?Q?jD1JYCpAkLppGO1ZXmmdUNwajxSIEXYHSYBgcwOE1YOdgrlbkyQcT6Ajj52N?=
 =?us-ascii?Q?0beA3Oirog9j6Fae46ze7F65HE5fRnnWSf5WNBJlGHdRtd1qkAkeJjgXlKcY?=
 =?us-ascii?Q?4O+zA84zqQav2hvl6Q8GUpKLPUXaY9b3CyZLAEIDR9XrglMXaN71Goudsnr3?=
 =?us-ascii?Q?wsD0XHsQmoOyQ2+L3Cj8IyKunQqST4Uzx8WmdPTURqMmfdnibN8DSutQrrrE?=
 =?us-ascii?Q?354oVDMDnmyne/DFOo/DOcYH7GKnANUfqpFEy0F+B2r70+Ge3bV5Z6WzU19I?=
 =?us-ascii?Q?iHCI3Ev4xiWBL4/FEbjQ/ohQMdVZ/lejs5h2wfQD0BlFOODFQd8w8BiL0r3u?=
 =?us-ascii?Q?O969PRq6iD/czPk7+YhXCaJGRqNDw3JlxnZDMs9D00M1UXaikiJwF/FmVmWg?=
 =?us-ascii?Q?q1wGGax+J6ky1N8R36F6sYhCJ1c4gCBi5qGWbKjvuV+uwDoQWGGkj6Piw52i?=
 =?us-ascii?Q?LRP9W6npbewimJTwxA5HuIJLO7l4x4cec/Msqa+4Ocx/ejVSud+rwwP+5Umb?=
 =?us-ascii?Q?aYGi38x8cpobyl56cfH3ZO637Od4wDBKDewnwhTLDrmhU2k8xRpuPiyIitfZ?=
 =?us-ascii?Q?9or8B0hx2eJpLoVhNciT4aBy6ihtRcBwSuAyU4ONT0+wa9fSqTpmq+P5r+PH?=
 =?us-ascii?Q?TRJmmKwM3YPQjY7VERmDPh0xv6mKPbSrE1r7pjPCWRWs4OBOnaSEbs3mGEbJ?=
 =?us-ascii?Q?IURWIKdr//fXGn/rE1YX2jMMs3A0ysnKtQAGHsy1dOFcnpxCMVyAmfmgCGtZ?=
 =?us-ascii?Q?WQM1tguBEphNwfoO4HCwUtVfZtAvA0lHjIWcndot5SVCBhFb0Z/RycvGNinW?=
 =?us-ascii?Q?tkCqQhQxEHFB61ph9RTtLcFoAO/MfVtUYeIPPAVKZIgUH1GYWVaP3KpsYz4G?=
 =?us-ascii?Q?KZ8zTeocECiqr2N8CNHUbXlFQoo+jWnefR2/adkz8r1u0//Es3kxVoDRTAsw?=
 =?us-ascii?Q?VUz9He2yankbs1cE3tbD5d6h64kd1VigtnqN8SOVc9T4iKKtgYDhBkSzFkvu?=
 =?us-ascii?Q?WW56iqzJPh4PNrhPEaJqo5KsZ7JUhc1hqprWtK+6R/X7xdpizs0zuW+DSTlX?=
 =?us-ascii?Q?Mf6pJRp7qEopV9VUeM9HhYbxxeoOFHi7Qd4bmUje9/gGTsXesgPsO3tX8u0+?=
 =?us-ascii?Q?Aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ThED+/kUfiACN88SbAcNApwKw60GiCFjmTYpE3uJlFHZUMHCWlo6NvHSmIIw8z2jSo9lN9VOLe6+EYo8lS37OnUE+KMxz5iX+WoBRPTh6hXz/+Ls2N+EOXSzUe3Kf+X4azFYVE7kJwzeD+k9G5jgEPPp6YjUq7s4qCsRhSzWOHY++YTmycr+9vfV06Ay9q3tEW0yZnprwKSpj46+7uTRAABKUoClK0vzSgdkqedWBN/EQXeJuETK0/sJ7yWInksAimNmh0P0EkeKdjK+haW348h8wMioKU19DynNtJ71+fFgWn4EeAyGE5hoOqzjJBtjGvCBxIe9rIqxxzhzOqxSg/agt/Ixgc7X2AQE/Tu2duezdDejcy59j5XFnVjxhebW4HD3i2rwRnrrqrEdtyjlP8u1OJOuDZv3eSmfKoS8BhV19CIfQtAjS+XclRT/XQ2Gp1gdDOM00aesKLy+0VtbII5UOCLqHEPow12WXGA3fK5g7xEKDhkfsGUjzW6d1czYRN+dFU9ESDRnXnJkeM0J7k4NBBMOeWKYUyOopKiD2iQ36DTs8TNh8k4oLEQDKa9xojDjgc2TrSgIijKx1yNH3QlUulmM9SkJq5V+hqSi6tc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c60d606-f93d-415e-8d41-08dd8aea0bd2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2025 08:59:58.2980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fxEI4Wd+S3VSZox+NIsUlwAdGCdmuXB+x3T6A9XfnaxZNIqtP9HNYU1ccu7pBgVnUajj+VjXWgcDd/DnqrFtoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7178
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-04_03,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505040081
X-Authority-Analysis: v=2.4 cv=Y4H4sgeN c=1 sm=1 tr=0 ts=68172c91 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=PEStbzsqZpMx2UUXZgIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA0MDA4MSBTYWx0ZWRfX4JhBsWk3qdwl dpEVgdNp8gzINXrfPoHgGNpZV8H0H2MSpFws1C3qGr6fvZdNJoP7CYRIKUknWfRNzDXNIhFR/0B 6rdsqLkVaO1TSBdlV+I/uNQ4OWkKhEzj1wclIIe12TnV3/2TFYUePVQhhAkfwRX1PfSQlns/mH3
 0M1iDdLjU5YzGwdj28gRQ4JT56nrv6dI4mnQChd36fFHPtqzVBdBD5RhSNCYDbB//x5RL6nQPLU VyQBQcD+SW/3tvqjfDDU+TMRygRiBfT6jLh4g33qACv2M5+x91B2UFWawQJ9+hPQqDvxVrEYMA3 +QvCGgaicvqmus+0Grt8St2nXE3gifqYThXQe0CBvDRHjWBSfQp2a8fkjt9m6bh4BErIXzqZKFQ
 xIGAUQp005B9iIoU//ftE44GjaTUn3AlMHI9fdqWMwnmMXWiVp6v/IUv/vhDTRPOJg4AQizS
X-Proofpoint-ORIG-GUID: rvoprLHMpmkjNy0eFFFvlR0WWSVPpqr4
X-Proofpoint-GUID: rvoprLHMpmkjNy0eFFFvlR0WWSVPpqr4

From: "Darrick J. Wong" <djwong@kernel.org>

It's silly to call xfs_setsize_buftarg from xfs_alloc_buftarg with the
block device LBA size because we don't need to ask the block layer to
validate a geometry number that it provided us.  Instead, set the
preliminary bt_meta_sector* fields to the LBA size in preparation for
reading the primary super.

However, we still want to flush and invalidate the pagecache for all
three block devices before we start reading metadata from those devices.
Move the sync_blockdev calls into a separate helper function, and call
it immediately after xfs_open_devices creates the buftargs.

This will enable a subsequent patch to validate hw atomic write geometry
against the filesystem geometry.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_buf.c   | 14 +++++---------
 fs/xfs/xfs_buf.h   |  5 +++++
 fs/xfs/xfs_super.c | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 5ae77ffdc947..292891d6ff69 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1733,11 +1733,7 @@ xfs_setsize_buftarg(
 		return -EINVAL;
 	}
 
-	/*
-	 * Flush the block device pagecache so our bios see anything dirtied
-	 * before mount.
-	 */
-	return sync_blockdev(btp->bt_bdev);
+	return 0;
 }
 
 int
@@ -1810,10 +1806,10 @@ xfs_alloc_buftarg(
 	 * When allocating the buftargs we have not yet read the super block and
 	 * thus don't know the file system sector size yet.
 	 */
-	if (xfs_setsize_buftarg(btp, bdev_logical_block_size(btp->bt_bdev)))
-		goto error_free;
-	if (xfs_init_buftarg(btp, bdev_logical_block_size(btp->bt_bdev),
-			mp->m_super->s_id))
+	btp->bt_meta_sectorsize = bdev_logical_block_size(btp->bt_bdev);
+	btp->bt_meta_sectormask = btp->bt_meta_sectorsize - 1;
+
+	if (xfs_init_buftarg(btp, btp->bt_meta_sectorsize, mp->m_super->s_id))
 		goto error_free;
 
 	return btp;
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index d0b065a9a9f0..132210705602 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -383,6 +383,11 @@ int xfs_buf_reverify(struct xfs_buf *bp, const struct xfs_buf_ops *ops);
 bool xfs_verify_magic(struct xfs_buf *bp, __be32 dmagic);
 bool xfs_verify_magic16(struct xfs_buf *bp, __be16 dmagic);
 
+static inline int xfs_buftarg_sync(struct xfs_buftarg *btp)
+{
+	return sync_blockdev(btp->bt_bdev);
+}
+
 /* for xfs_buf_mem.c only: */
 int xfs_init_buftarg(struct xfs_buftarg *btp, size_t logical_sectorsize,
 		const char *descr);
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 5e456a6073ca..45e188466e51 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -520,6 +520,35 @@ xfs_open_devices(
 	return error;
 }
 
+/*
+ * Flush and invalidate all devices' pagecaches before reading any metadata
+ * because XFS doesn't use the bdev pagecache.
+ */
+STATIC int
+xfs_preflush_devices(
+	struct xfs_mount	*mp)
+{
+	int			error;
+
+	error = xfs_buftarg_sync(mp->m_ddev_targp);
+	if (error)
+		return error;
+
+	if (mp->m_logdev_targp && mp->m_logdev_targp != mp->m_ddev_targp) {
+		error = xfs_buftarg_sync(mp->m_ddev_targp);
+		if (error)
+			return error;
+	}
+
+	if (mp->m_rtdev_targp) {
+		error = xfs_buftarg_sync(mp->m_rtdev_targp);
+		if (error)
+			return error;
+	}
+
+	return 0;
+}
+
 /*
  * Setup xfs_mount buffer target pointers based on superblock
  */
@@ -1672,6 +1701,10 @@ xfs_fs_fill_super(
 	if (error)
 		return error;
 
+	error = xfs_preflush_devices(mp);
+	if (error)
+		goto out_shutdown_devices;
+
 	if (xfs_debugfs) {
 		mp->m_debugfs = xfs_debugfs_mkdir(mp->m_super->s_id,
 						  xfs_debugfs);
-- 
2.31.1


