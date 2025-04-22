Return-Path: <linux-fsdevel+bounces-46930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E48A96982
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 14:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E196189E68D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 12:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A58C27D763;
	Tue, 22 Apr 2025 12:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HcmChmrF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="buM5Bp8X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993BB28135B;
	Tue, 22 Apr 2025 12:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745324929; cv=fail; b=d16GW3Ix7Ad/1Hg6+wogP7TjNbi427NPoBn7KxF4+jTtXAz00eBFwEGNZMU0zC+mhpdOEFiUmBibFVSIViSYyfUKZ6F18GDM/uHBXp9VDPyRbxkZzOPlm7jRpixi2xfkZuvwLvXwLmeqiNbPZLb300J8xY+gc67C57ZmphGBrY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745324929; c=relaxed/simple;
	bh=jkt2dTvqDA+7XgFA8CqtXya3FsSR9oDjqwMU/9d6xLk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qw+XY4aTLd2ZYWTSwLUPMR9CqDhETRYlfAXEPJkOvh/qLNWdFwwNVqIPjHabCNnAgSOHPEMWCV6MCo3WNjYXLBwjrzJPtFrJPwHWadJM+IsaS3Nvvj9SbSPr8XLKfK2csCrQfEbyCX0QAeeXsrIJSwSGGQna2MP22MYkYXk29Gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HcmChmrF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=buM5Bp8X; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53MB3PZP008455;
	Tue, 22 Apr 2025 12:28:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=oB+7chQgRjKC1yB1GLnWgsuYB+a971GfEcdhyhMqGeQ=; b=
	HcmChmrFgHUVNbOi3t8QRC90qHmMWAvBRbXrnZF2j4E40hv/9ffIld+0BjOW99K6
	YWNSrR3EE9u0CaSZ0Dr/8sjBhE+3RRhnTQ6+XmxLX0goliUL/KFt9WJpIf//tpJH
	iFR1ZPaF+8hnoZkuHPYM+2Utr+To6nKOB+WfzAzuZaD0vslcZ5fcPBNECI+aq51z
	48UeBHutOrQ8P44fziFnBQGol7zRSUGrc525n+5k/j579kP23vR2dCOEpuX7tBbL
	0Btk480TsdiK5y0AHb+93h7fIAyDCu+BcJI652IJoNkMncPoO5ZvT1FRII+nVrUi
	xmoD6bylYYEyIXO4kEmWRQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4642e0cde7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 12:28:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53MBOta0033464;
	Tue, 22 Apr 2025 12:28:35 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazlp17013063.outbound.protection.outlook.com [40.93.20.63])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4642999rtr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 12:28:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VEJsH5LxPapQVTiv9v7v5cwD7F+736QcCQQiTMMwcrqD7DfJiJEhJ5appSKFqUo6dHIoxJ9bfLQw2FqZR1gt6Pfsz7q0j0yOtYg/OUx0w+4A1Ky9Dl8+uu5jYMhfKCO7GCoempr/U8fkhzeJe8xlTePIRRNS7drb3adP4zibRqXMoyX7mGHuJyrL9eEJChb4AWrqv8Dlhw5M1x8ES6qB8zV0OahZn0wDDFQMp+ntVETyyOv27ySv4rR4lb6WnL5IYYI2IHF5xEEnBG73zS6G+Brr3fGZhI2wBipABFGTuh0vi+qWcE0JYVKjKwwd0PwIY43ajOPMv0zlMCZWwR7dMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oB+7chQgRjKC1yB1GLnWgsuYB+a971GfEcdhyhMqGeQ=;
 b=hwtV7vipnjyXLApFP216f7zu6i8PbY9SG4RrdVhzEk5vNnk0VvYORA5DbJXpjpbQ1HBWvsxN8B3+qj+dOC6G2umO3+GNdxA51Ep1yFHrbN50r3ZpE/X3+zR6khXvPVi5+y3Y7G0ZpAKphrOCy18zwBmVFFw6IsDOxLY7ykxLfaYzMk688iwbBxXtLPS6RAqlZ8XLk76hIyTy82Q0Ijag2AFesqshRHNcvBmIkgRrkKsTpULynbXhBvSEKiHoxnU4cUIO41sSMhB5rqurzHvKXhkGQJVk0M+zgciMD2+bWKxtPCGBrhblRn7ie+sDi05TLpGjnNXlZeUtschOBfD1Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oB+7chQgRjKC1yB1GLnWgsuYB+a971GfEcdhyhMqGeQ=;
 b=buM5Bp8XxQG8FSP402S45uZ65kUvEEZDnC5o5m2i1Y2SbcTWJVSErLcrAwS4umkFHxZe6GRZ+YDYS0EyEUofP7Dmbj6kbCAR5AwhfPlvia8EW2WxLVaerhkLX713sYEGVmlnfMUzqDnOdfNE1GbFFCkgOUWxGyIcfs7CKmKjYfo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB4895.namprd10.prod.outlook.com (2603:10b6:5:3a7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.31; Tue, 22 Apr
 2025 12:28:32 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 12:28:32 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v8 07/15] xfs: refactor xfs_reflink_end_cow_extent()
Date: Tue, 22 Apr 2025 12:27:31 +0000
Message-Id: <20250422122739.2230121-8-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250422122739.2230121-1-john.g.garry@oracle.com>
References: <20250422122739.2230121-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9P222CA0018.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::23) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB4895:EE_
X-MS-Office365-Filtering-Correlation-Id: ae2a8611-7d40-47c2-620a-08dd8199318c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x3FoWcy9mHgMKtw5SjUCumwJ+VxGUELRdmP5yXH9sSiq0ass/++WkIlmn6lQ?=
 =?us-ascii?Q?Gjscb/NBP7csh0xrzmVmjlqXjUaAouhFmLaxSaYkHRHbKS8UkMnYG8majuBb?=
 =?us-ascii?Q?CiAo/krhGjdZZJMXBAcQn7Eqx3e16599fMxe5JHEoqvUJJUrPe6xf/YQr3I+?=
 =?us-ascii?Q?HOScFl8rbOtCdIBmP4dgDfWsE2AOocFXwRvgPdGjoGJZT4ZzZ1owBtMC9Swr?=
 =?us-ascii?Q?vv/rKn4OWcGsVahoCLPhtUfbYi3ey5TMAps7Mhe0bZG6Y7nXOectrFjXYHGg?=
 =?us-ascii?Q?My9D0xbDusWxlH5/1+rdHrTFWQCgJsemB0Su328ELL1RrzDbx77RnZU8vLWn?=
 =?us-ascii?Q?pvk5EpHVcvewoTxrY5fL4Iy5l0a7+XU7daUYlx+Is+/WCrLZDXYU0Q7NYc7Z?=
 =?us-ascii?Q?+NSxpJ9+tt/Oi4mLPJnbMmwOa5q42c+i1da4XRnknUYptbTo3rln97+oArbS?=
 =?us-ascii?Q?TF6qR3C+8L2U2nu5Do1zy8YWrGuVDtA4lMF5+7+ZqOXMdKqKmKRPxQiIk+kV?=
 =?us-ascii?Q?GpswuizlgBLWHSV55RYxCrq+/aN36mGoZMJ2ZdmaU6aEY0ghRbDtcyXAfZLu?=
 =?us-ascii?Q?c+/YFml7FjpOi1Kyu0XF5BNRjP5XKK8ZmKtubuub4AGX/aJA7zzyqdD5o4d4?=
 =?us-ascii?Q?N1wTf403U/10tl65WKXzUuOqdZn5KoOuwCqZDYjrViSrgvYGkQXGMqcCEMF+?=
 =?us-ascii?Q?MvER3krcZRSD/yUSR5J4i4QZmEcF5TUkcF9mFcomB6qWUJBf72xVWwwFat6Z?=
 =?us-ascii?Q?O2gOt4w1GNK1uFvZXao+iyCTSUuk98wkM1oR7rn/iPYvZabGThpYDbf430Uc?=
 =?us-ascii?Q?zEFie2QcGw1lYcFi2Z5SSxRWU093RkzwD5p4/VY+tkN0hW+G2V1e03gC4Y0/?=
 =?us-ascii?Q?z9VVbqXgbsY6WT5uwgSNkyxrRLDxy+FDbBXn9vJ1uo9v1TwO1oX+SYCJBuN7?=
 =?us-ascii?Q?VgrDWRMaV02PztjQK5/WFeKZu9VBTIB0KihJuqMwrartd1BJFGoN/aDOIcBn?=
 =?us-ascii?Q?n3dGTY0jMNQ67ZMj7DWHyk4asqsjiS9kw0dCppt2/iYf8RO49LVvX7TfY0wu?=
 =?us-ascii?Q?uhBLSBEtN5s7xtyfee/kQz3yV3LnRM3SP2Qgk3AG/B43NjmB7AqKXV4AI08z?=
 =?us-ascii?Q?BO64H8OrZsb9u9lhOfAKrS2Awiw2X5ZCQNwteta0dIK+kbamTY8lZOeEusRh?=
 =?us-ascii?Q?wKTX/BAhzqb2W9PQQugK1AnTK+iHLFyKYyvo457ODoKwK14NInwLgI7d+OPI?=
 =?us-ascii?Q?floYjomM+XPx4hexPnhuemkCFX7KWcZ/2aAGtXs+ot9zEpQy/eHaiN52IRqW?=
 =?us-ascii?Q?d+/FbGRY8UWexLy40tyVXa8M8AIWerFnflmsrm9Za91wJrZyqyXPgOco9Lxv?=
 =?us-ascii?Q?CKN6621tlWY6C+ROd4Mxarq0nKCDmCKd/CKBXuH1o+1fkU7iZDEQSWUhzI9v?=
 =?us-ascii?Q?vQaE5h4WOXM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gk0zRZBYOzdNGlhcVJb6w+Wm/a7s9zfspWxDJAUCvvci3zLeMFO27+04fC0Q?=
 =?us-ascii?Q?t/8SBsEV9ltUdjp9O6ltEjmfPm5N7OBcUIc9/SxbJzeW9Cxn8gLrbxe37Y1Q?=
 =?us-ascii?Q?N37GZL1F5v/sFEa6ATGnLGDBJBHQXrea6oOJSIUQeYcepWnBYPX4VDubTZZa?=
 =?us-ascii?Q?3p6qhiPbhwZJDFftUNYcwRbag9xTTdco5YSoL8eyQsYyMzPNwvSBqomDBhJX?=
 =?us-ascii?Q?S5udSgJiKeT8iCvly0bLOoZSFjA5EA+xVDlu/NiyMHMtplUZFxdVkGeXoV1n?=
 =?us-ascii?Q?eSUGI16J+hION/5V8ZZg64CAgyZQNktUnHOfcihqRC7D2vSeSPUpKTAL0P4S?=
 =?us-ascii?Q?jRFOwgQfn/BoDlkmxSsHnLi4OCYY+FLkAiJcYVzrweDB85DFyGYDpfZ5dLO7?=
 =?us-ascii?Q?FhLPqMjWNh2gRoF88waQEj3xnOdLZ6Syw46QvT9x89TgXwvo5iC3EoPqlhXI?=
 =?us-ascii?Q?mSyn8URhZbr4QJE5jr4RCun0prBZlolPL39MjjPgXuCL1kmr0a8LclQdEFnL?=
 =?us-ascii?Q?UJfA/bXA13/9il+DTeAi/X0NGSc87anqSP7xOtpc9LsI+omEPOQNN3kkNVmk?=
 =?us-ascii?Q?X9o7RPUre4LEtmOgB4wRK4vp49C7iEFpDvG1nC5L2ljOOroRcfJDEGT/KIpN?=
 =?us-ascii?Q?zLDr+R4c9DgpH5s5ahPUYk9a1VUuRALpEFN915qNM9Bpsq0l0MW6uR5tAhWr?=
 =?us-ascii?Q?Vs06a2+eKYnBjaO9dtdpSsJgRMzWUZcfrnmC5LJweqL0cPkZZPLSsFSQ1Vgw?=
 =?us-ascii?Q?n9hvtg+k+bAFbYcAbV0tlNGRFuLlRv7D4R++vVhpDRVyv9NUcV2lTlmqYLjC?=
 =?us-ascii?Q?FiH1lxFWjSHeaLpSCw0lGhdU75CktEkoVJ88c+mgnWVXeQQ2X3NVjWsm5l/O?=
 =?us-ascii?Q?AjnFWgCpskW8DlaQU+8xV4kxwFKGG6nT2nXy9LoOjNSMYIcFmnVImsR5sUy9?=
 =?us-ascii?Q?daGbNl4duRYYtcl6COkczYHy5ay897fOY7RNOV2L5+K8lO7qL3fqSs/TX1rq?=
 =?us-ascii?Q?ZgPMNzeqGVsBo86gT1O8K2eaR25Aj+LV/9G8vLiVinOMewrUDam9rDog25JY?=
 =?us-ascii?Q?R79PmsvO1qTIHtN8G33xeMILYfT5hVkuWXToWWFDjoblSIt5KC8kU9QE7ANz?=
 =?us-ascii?Q?QVL8k06u4w6kEydJPqGdbL5vt7l/+SswpcSlNTQGwy1wxOC/cHA/iyK9Ndvb?=
 =?us-ascii?Q?JexPAsPvGA1CL9+9Qzi9QHUx/mP+GjAFegMogy1FyBZbK7nhuVJUijCB+MgY?=
 =?us-ascii?Q?yyFTO1pbf9CCiMtlCcmOlE+Sw3gyZoCERTsxYqsabDummN4xDM+ED69GXa9B?=
 =?us-ascii?Q?02OFwkIzf1w0H8o+XieO5XZkrPp4ollrtT1HY92uhpcQeTrIke8tE3OpTrpo?=
 =?us-ascii?Q?88AFtfi3swlTfm2LLST91BiisT03BDA02uE9gqPNBKT6+FEOPz+vDb/psv3x?=
 =?us-ascii?Q?0es+Lw7AFeaedfR5fCrnha1gSV5U7k0IyD/0rL9Y3z1jdHyfMKVtSpGVPtun?=
 =?us-ascii?Q?7PLFX/oVEvnH6jGW3Bh6kq5pkvGtT14Ro2e8Qwie2hc+COI6fPD20WbqeFUz?=
 =?us-ascii?Q?Wu0ipDhQQLKNr6dh+GZycXcDLhGmNX8nYn6yHxbaLxFAjysRKt3nLcXTPANe?=
 =?us-ascii?Q?Lw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0hglf86DmUmP3ZlwNZkdENAyHTDVu2HF9V0eEpwKZS5FfdQ+3MLLm5b1ajnZ3G/SVT/XupkYNesjAIHECIu55CVD/ylzkxcot2m5YZkxtpSBWfzZorsXREq3qOpofSmrwsKL3/a/vvM3WaYJU9OYR5MvGjSZFQQC73O4oXV3dFIM4oLr4KlE/VOgWNaD0Atd8lLCFlyaneFM8jIFgzVtVwfE0fxEjoNPVcIXKvXpbw0UKuaw9BDPI6HFskwyyDbLgYViyQwn1vswhO4cAEx2DCWGlSCDB1hiz2vTUlgda/NFA6QhidA/f8K8x+tXeOHcQksriqW7kA4gQaqaMbhDzho70SiAld6v43pefJCj1n8yAGOhvbPDYgIRmshdRy9GqPRaXLrvL1GLIGiSfHikOdhdu+xa8svE1mpcabicoFiZzVgTw01n1LsifU2BXkB4ZD+AwHHYhofjLZKEPIo+FU1hFGCpAjQp2RuzvCwyjQIyHun1rvhd4ztxUMCc6oFFTnvCGN8KSbMS23XPsPQ8MVN4UFsJ6yaHxwtiXIDLri7Y+GGBwK8wCsAJW66tOPdnrVacOE1ryDDn8hIuWjJrsl7u6mmmu5RAkHIbpG9hxn4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae2a8611-7d40-47c2-620a-08dd8199318c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 12:28:31.9677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kKhCPRqsV+85iTGjUKnjcIGdXR5avbSLZrrC4zbqb1U3DJxF+U7YCErJBD6UD23a3G+TwDMkqDLB6/zwTaGflA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_06,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504220094
X-Proofpoint-GUID: aBcz53KoKXYIU40WF0LxSoTJt_ETF2df
X-Proofpoint-ORIG-GUID: aBcz53KoKXYIU40WF0LxSoTJt_ETF2df

Refactor xfs_reflink_end_cow_extent() into separate parts which process
the CoW range and commit the transaction.

This refactoring will be used in future for when it is required to commit
a range of extents as a single transaction, similar to how it was done
pre-commit d6f215f359637.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
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


