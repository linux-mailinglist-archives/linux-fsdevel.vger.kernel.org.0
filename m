Return-Path: <linux-fsdevel+bounces-26273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23435956DB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 16:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 483771C23AE3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 14:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6009F188CB3;
	Mon, 19 Aug 2024 14:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SHdnZUkn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y5oZqzhL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D45186E2E;
	Mon, 19 Aug 2024 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724078426; cv=fail; b=Z4qKE14/QZ5b4CgDnte4b+lvaZKK2tnmftRIkN/2RV+BeeA8bNg1lgY1al3DfP6MEEOd4zmmV3clYZNE538kQMpzRFhB5IUKrr1vbpE0nrRWrL2gzbaFr/jqkBrEMjTTioIACiUt41IcrGSv+xqkQ52Jk00YJ2CrTwglcMkuXsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724078426; c=relaxed/simple;
	bh=KI5NjDP9WRfbSOczziaztsPAZkwSSG/f+bPItzylbBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LuMKjTyfDE/Qh3/A9pdQ4K412hLnDOq+ey5o7+58Ypvyn/GE9T+0P0ePAREKQNnJXIBHWmVtla1CURwBSlyJY23WNYhoCfVlkGi9xSahBkbHGm/5BjMJKN/KxSV8MdYQGmhkY5W3XPIVNG7Ax0OBCy+fXjW9TYNS/jKHjwcjGUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SHdnZUkn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=y5oZqzhL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JD6sfp003551;
	Mon, 19 Aug 2024 14:40:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=B7vAQM6oLv/uaWE
	PdCedTgxTOzIKi0HcpUR98HPJMPk=; b=SHdnZUknvOpqhZtVuu1d2Wv0ShKIwqe
	7p1QS49D5TWsecYh5A+LS9e79+YoJCBLrxm9ZygOs9I4g15I7qN/veIdZK6z/Thy
	7VihEkF7v5qJC/wERJT8HCwZNJCOhC1tKP2sjh5nIRpyueqXvBUjiuxe9EJpAnEN
	otyVS/y9H4L67cZ3nO+4pwuFnmd1NjzLRqKpy0cqhpcH85dOtB669MiXr4I8jjUt
	nm91+83CWn7oELJ+qIkBoL8TC/jEiONy6rK84htIUR9Shz2NHu0OSV3teLGag3xR
	UvzXhwBeFmwKANmNCmWTInpBRDxqrDlo6IuXUSSbrGzByawOQIwG2lA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m4uts5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 14:40:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47JEbHB5003084;
	Mon, 19 Aug 2024 14:40:07 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 413h8qnwbp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 14:40:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vxFmm6WhiKuR63HwMGf4lVHHBeijJrCMDXhcSGn+SpsnqoYDdVIE0+rKHVprpotzUmX2EzsHs5WUvMOANLDE+kuAV9bn8ueMXZbjpL8621O2NHUGghC0i54Y0YPRzdjKyy3PL8SBhOesepTRjY+k3BBfeOSNlzE4qStKrrSN4rAwLv0CEETVMv4P3q163Ya2rjKGJx8D7ly898ONt2sc1cF5F+Tc38kQNb8pd7H7K3fkbH48KYMUKlqzRZvdtJ081W+SmH0d5FcBfA6QI+I43BKukQmOHl46OCkgHZipk3Kt3E0edwkWvZE4Dh4y2ME8EfIyjwg3/Ltmq1LPPvFWFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7vAQM6oLv/uaWEPdCedTgxTOzIKi0HcpUR98HPJMPk=;
 b=MZCPpcmfVWvNNhOgWt51Y88tbhMXJ2xAMRdMbHN3pkW0XuKjeSyvdZFupQn9V+SRuJ+ScuxsoCNlNg35/0SFaG+FdbwIbMGYOXfNq/Cqz8AYRcM8KKbed0i1ksq2zNaPZmNsrv+x6SvcJkz2h3ZowGKg7o7w5xeCIWle/QjzCtjQcP5NWN3dBsR446jBkrdmWP1NJodoZeOI5v8onNSzNEtvGEa4ZUiM66jzoo4qxaDRINVzWDATzKuTu3HtHn7r/UMcyqIl/7Yw3B8x0yshOWWzs6ttTZmfq5s3JE3yv6Pt3X9r5eNXB0fOzcC1sjv4FohCMOk6pHgouQBShXaQMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7vAQM6oLv/uaWEPdCedTgxTOzIKi0HcpUR98HPJMPk=;
 b=y5oZqzhLJ+z0sVSHdknv5zHvJRpGgJJNacEqOhAeQOF6/dH/q8kuqa2dr5h62Gm6OO1a43DyGnUyZ1GE6O8fr/mPl5cru77A0J6/FXkV4sQC5q47gFzfQpsITkZ6BYYpGxtPIiaz/jWhfUsbQwBpf2qk+AnnoWTZ6lsj//D44Gk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH4PR10MB8146.namprd10.prod.outlook.com (2603:10b6:610:245::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Mon, 19 Aug
 2024 14:40:05 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7897.010; Mon, 19 Aug 2024
 14:40:05 +0000
Date: Mon, 19 Aug 2024 10:40:01 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: andrii.polianytsia@globallogic.com, sj1557.seo@samsung.com,
        zach.malinowski@garmin.com, artem.dombrovskyi@globallogic.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        brauner@kernel.org,
        Sergii Boryshchenko <sergii.boryshchenko@globallogic.com>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH] fs/exfat: add NFS export support
Message-ID: <ZsNZQRajNoZmllBU@tissot.1015granger.net>
References: <20240819121528.70149-1-andrii.polianytsia@globallogic.com>
 <ZsNJNJE/bIWqsXl1@tissot.1015granger.net>
 <CAKYAXd98C6t2+h7Q8UC-p3fCTYtKCwmWvd4jCn1br_crc48KLw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKYAXd98C6t2+h7Q8UC-p3fCTYtKCwmWvd4jCn1br_crc48KLw@mail.gmail.com>
X-ClientProxiedBy: CH0PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:610:76::7) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH4PR10MB8146:EE_
X-MS-Office365-Filtering-Correlation-Id: e9ca4474-5981-4f3f-85c1-08dcc05cd0b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jO20fcJodtAmbiu5iFZZisF0HAyn6OQkOsRsQw5Z+SMwf6gwM/q9GPMQoeJq?=
 =?us-ascii?Q?RqnQiI3GExxdBr5SbPBWoxlZRFC9SvkMmwNkbsLYJYMJgVRKr9DCDh4yceY8?=
 =?us-ascii?Q?fw9DrT2E70CFGIjyeKdQ8fN5VUZm0Hj5oUvm0bvX2onJZYe42+MgVGKCG+n/?=
 =?us-ascii?Q?33GOkxgksQDGiGlFFlpHUnSVSLOA4gRTnOQiG9JEsxoeFL203KaFTitA88z2?=
 =?us-ascii?Q?FV/3KRbl9Z9Sw5CtVGjsscp3qmrTLHfINvbUIuYY49QcCgu/cD4bfW7LC5hT?=
 =?us-ascii?Q?14cloblzGSHMevW8MYrCqQEupy488+FsqBAX97iNdE8uFfyLHC8z3SATrKtE?=
 =?us-ascii?Q?qUNHWx52hO9UlpbeO0u8DB876THuqTvC3XoFHhSteWYxzjCyUETXPprnTDGp?=
 =?us-ascii?Q?DU59j3mhBeIVHCDrvQBSl979Dg9FhEgoB9edIOTMBuTcVcRgamG1TfRzHBuB?=
 =?us-ascii?Q?MspvWS/M6in/wzPiD/DNMOHavG9iWwnQ43RocLCO3oWr+kkuyvromKmEK4p/?=
 =?us-ascii?Q?5T2/C9YR91soJSPDjEXiONNCxdTzcxaRhkMLK6H/MX+AeRU33dC+drHp3rWb?=
 =?us-ascii?Q?3S+1zzOezJRg8dmvmImJeZVHvyn9BGUzQpfEQ7G3HobmZRo9CTYkQlSNG5OP?=
 =?us-ascii?Q?sw9S4LKnoXnMPaJ/shSu1VlJhJn2i1ZJPGazriJfA3Dgu7P/LcyzqLn5uHYN?=
 =?us-ascii?Q?rX3XvrcphYNDFrCs+FBhScM4WOx19lPJlc/guPXlJKBsDUCjPHWW8b6we5Z+?=
 =?us-ascii?Q?nuQ2sOtS3Jr+5LwsgxFJnj+2yAt8yBVFNv+ibC0ZkL2TmdggWIArd6rZpUnp?=
 =?us-ascii?Q?XVfUmQ1pZE7NHxu+IvCoF7CU0E8gMog4NLjI1eyRm7wX+HMRRo7fFXtgfFdI?=
 =?us-ascii?Q?qgEFVRSP211GKBLe19CYNHy/1Al1NLnXpw2OKnE9Zf1SFntFF7H52VvLh7oP?=
 =?us-ascii?Q?rQ0thL5ZRrqVmEBVpu0I3r1nhQI52B0+TyI5GsbWN3HpLQQKOR6WI9PkF8yJ?=
 =?us-ascii?Q?MemVOVyrCWCGuSt7xYKXl4BnaC6KFGbXq4tZQc3lHsoYUpXVpoRIfD6vHAVr?=
 =?us-ascii?Q?CJA+W1t7zPkQCfpHwP9CdGofzVkxaIjKZ4leWPiIKcfI4yi9wHNA1CXjyrF5?=
 =?us-ascii?Q?fz5KpdJ+76s7mpaZwPQhrN6k7cfNthS0w8KGbv1a8lTv3RpbtK51n7DSv5lg?=
 =?us-ascii?Q?i5uimzoHByc8A75Y+r5gtv2OZGy/vm8Oa12k9AkWyh1ZkEjYvLUzq8v1rgzk?=
 =?us-ascii?Q?l5F57FEGEqw3Qg7ir2BHyN2ZtvYRf26lTGmZrXCohH2RR/qV3TTHjnwD7kfm?=
 =?us-ascii?Q?jn1cMVWS9eD8v0XPWCH8E3FCbuVxv3W9xVPUP3i3fKLT2w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UqJ+qWkX88oFL7tZypY9KlWs6lnDYgBH1xmumjeuCWXsZgRgArMHfH3fle8v?=
 =?us-ascii?Q?9qQ1aFv9tGstC/vH+/2ifoZPQTJ0pkQZea1j3p+jrRfQUORjQXjc6zqD5LtO?=
 =?us-ascii?Q?rPX8NSxO6PnAf4silEv2RYb7/iqr5sEc7Cjx9yhcdAuG07cyiEXqYalj1sbT?=
 =?us-ascii?Q?SHKKfCRzo9NbOehrlE2vim6GZBuUaOJ4j+clJpod71PRRgyRXXPdmJuSdNV/?=
 =?us-ascii?Q?okC14wP2kY6EEaO4YrfQfJRhbhI2wd5HPhHXCxe0d/70co6cHWVPAxQwtmxX?=
 =?us-ascii?Q?cUQsFRfrWljkwrvA/6al1iGTdai96iniNNB9PMMIyCyDCbEKtYi1+tWukAFG?=
 =?us-ascii?Q?ZifVarEy53uU1xQGCxD7+fX+/5ldugbBhtU4vAkV+I8E9BeTgVt7st3TnAnR?=
 =?us-ascii?Q?dwXD67bZutAMER0sGt+qhTEVAH2W9Sh3Z2rC18Rs4UHR6do+bt+gfucIXw+9?=
 =?us-ascii?Q?rtb8W53A3QnAA2TxKWCaH3n8SNXBLY/o67+f0ym5rlhkonUXkQR9GX8UVmnU?=
 =?us-ascii?Q?XV054edWRofiSNsueSyuMqra+Ezdfr+AcJ5CRQExz9jjzvhl8VkO1jcTwnzn?=
 =?us-ascii?Q?f4/tV1su8MYspYyxopFwTln+7vEEqLSC2rKdWWbRonfZ+f+8k9KnUti2MG3S?=
 =?us-ascii?Q?eqxfW92taKcElHsc/hT+twSLAVFuk9AtyHEglgKkpkswplHa7TM5P5s5GS+/?=
 =?us-ascii?Q?L/PMg3lB3oA8oyejlE/2GGIQTb1zP9/uo0/ZaCYmgSiSYuEM6tIVV3ekLqrK?=
 =?us-ascii?Q?8rUCMB5hGwS9hNXvAFPXu3QGoC4xtqDXapA9VhIQT8HgXbV9nMJYsQiK02QH?=
 =?us-ascii?Q?GXYo+ahSdWLp978ZYSAYTuVfmO691MbCplzo7GRVoq7pfQwuIoq1Yu8hr0Mk?=
 =?us-ascii?Q?jRv+7vLslGCwbNPKkXb4JedyDMgdDTapf0Td6PYE18b+LilUS4GVBwdgUidd?=
 =?us-ascii?Q?rf0a7Qb2md1e96fUGKbVb/9Tm0ZlEEnH0S7F29/9sfDvIztGbsFbXhZDVQ76?=
 =?us-ascii?Q?PS12FLee4ACkofaLWGlLxQyrtr1S6+Uni/+rtjhO6HXX1JQ1+PJajn0z1w5j?=
 =?us-ascii?Q?+X48suQ8/blHzzrKTK8C/VdDLjWcRGqxuFNkjMmzFs3D0XFBdkfIpw3nvvIn?=
 =?us-ascii?Q?JDZ9ikS847grm+QwTS6lgXLdH1TWB7h//ZURs69izq+BZPw4iwP4qxwuqGj0?=
 =?us-ascii?Q?hB4tY61qzSE/OA4uvsr/0vBap93UGEVKTyNZ7UblgvtJHxW5ePa1ejRtC4MR?=
 =?us-ascii?Q?5T58fZKZpJIR+5B17G2jlSyBHmRyEYHSwppujN+2ZCODCG2bzbQu/dvpJPoC?=
 =?us-ascii?Q?md5K0CTCwRmuI6cVxEB3XVf530hPw4mQpzNOBBP5cPkJe69Dz++LPX4XSPu0?=
 =?us-ascii?Q?CsmPyqwNmA+xnEUTKiCg55IfAi4n/e46kT0vbw9/DO/0RMt6O636+q4rUSOA?=
 =?us-ascii?Q?iouzwfzPclN6rAaOJ2IG4YIkZP9rEhCMeGRGmiKHPmFBpDgZSCdlYjfBLb2J?=
 =?us-ascii?Q?4E2Yww2qSuo2Es5zp/Fh2Bc9fJt14p4bXJoNRQJZWB8CF455/tpWOjHOiIi5?=
 =?us-ascii?Q?z0E6tNS2mHwCUNv5CjNMqx6SVNmC9JvqzfVCwkqW?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XUDBhgtyVtlrSDHI2BixaOj62Iysn9LBEy0cprIFqk9UtdjXoilzl/HSOUlJdXiV3LzIB1R5AIsq20SNNocB74RJ3SmAnSx2RlLWTEdJ4TfSuxEgP8Lnzys6tEx23G7tyI5IKVq1+lPK51LPLQ/tZmfeZPsMGDjSM6cMutoUzla9YKSeceDqzJQRiXqOmJHIo0/sLRfhUoo3adQ4S9FREVME0vccJDgnYlEEB9KN/w5YYxPWr4l5p0hKgpyStMDq62g5wuU5psH6mH/Hj+S49BuxuRb997ercQsEDApzLot62triksdAQknm+Ev1uZCAW61zn44fkaOFDjLnGP++gspmkZZfRYY9FIvp52fTO2waor6eHuklvMvYu8sWDK7H71nfCfeFteXCmN9Bb/lm3pYvE0uOm5zLEy5TF+8iV+a7b5zte4iv4pLk/ltp8yecSekFQklTKh01QHdiYKNlH/AJ719TdB0H8uthhterscLnGoHSOhS31lDPP1/AI9689Q84dtsvIVElq8TdMylWS9vxwPEGVrqbJcPJn7pCAxkHJaZr1WM6aySCR5ndjw7E7/r8lCYk/V5Vdc24HREqNR3ld15K1pvl5aynhyBKAds=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ca4474-5981-4f3f-85c1-08dcc05cd0b3
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 14:40:05.2158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bbc27vOxMUt81/H+8o5S2FhvH5dNo/9IVhDMkEcEgIDTQipMi7mj/m9kS0Jlgtc96zcz43SGK6go/NWKofOw+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8146
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_13,2024-08-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408190097
X-Proofpoint-ORIG-GUID: O5EgPSkor67TRCgLc0Lujn4tilT4Hro9
X-Proofpoint-GUID: O5EgPSkor67TRCgLc0Lujn4tilT4Hro9

On Mon, Aug 19, 2024 at 11:21:05PM +0900, Namjae Jeon wrote:
> >
> > [ ... adding linux-nfs@vger.kernel.org ]
> >
> > On Mon, Aug 19, 2024 at 03:15:28PM +0300, andrii.polianytsia@globallogic.com wrote:
> > > Add NFS export support to the exFAT filesystem by implementing
> > > the necessary export operations in fs/exfat/super.c. Enable
> > > exFAT filesystems to be exported and accessed over NFS, enhancing
> > > their utility in networked environments.
> > >
> > > Introduce the exfat_export_ops structure, which includes
> > > functions to handle file handles and inode lookups necessary for NFS
> > > operations.
> >
> > My memory is dim, but I think the reason that exporting exfat isn't
> > supported already is because it's file handles aren't persistent.
> Yes, and fat is the same but it supports nfs.
> They seem to want to support it even considering the -ESTALE result by eviction.
> This patch seems to refer to /fs/fat/nfs.c code which has the same issue.

Fair enough. I don't see a reference to fs/fat/nfs.c, so may I
request that this added context be included in the patch description
before this patch is merged?

Out of curiosity, is any CI testing done on fat exported via NFS? At
the moment I don't happen to include it in NFSD's CI matrix.


> > NFS requires that file handles remain the same across server
> > restarts or umount/mount cycles of the exported file system.
> >
> >
> > > Signed-off-by: Sergii Boryshchenko <sergii.boryshchenko@globallogic.com>
> > > Signed-off-by: Andrii Polianytsia <andrii.polianytsia@globallogic.com>
> > > ---
> > >  fs/exfat/super.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 65 insertions(+)
> > >
> > > diff --git a/fs/exfat/super.c b/fs/exfat/super.c
> > > index 323ecebe6f0e..cb6dcafc3007 100644
> > > --- a/fs/exfat/super.c
> > > +++ b/fs/exfat/super.c
> > > @@ -18,6 +18,7 @@
> > >  #include <linux/nls.h>
> > >  #include <linux/buffer_head.h>
> > >  #include <linux/magic.h>
> > > +#include <linux/exportfs.h>
> > >
> > >  #include "exfat_raw.h"
> > >  #include "exfat_fs.h"
> > > @@ -195,6 +196,69 @@ static const struct super_operations exfat_sops = {
> > >       .show_options   = exfat_show_options,
> > >  };
> > >
> > > +/**
> > > + * exfat_export_get_inode - Get inode for export operations
> > > + * @sb: Superblock pointer
> > > + * @ino: Inode number
> > > + * @generation: Generation number
> > > + *
> > > + * Returns pointer to inode or error pointer in case of an error.
> > > + */
> > > +static struct inode *exfat_export_get_inode(struct super_block *sb, u64 ino,
> > > +     u32 generation)
> > > +{
> > > +     struct inode *inode = NULL;
> > > +
> > > +     if (ino == 0)
> > > +             return ERR_PTR(-ESTALE);
> > > +
> > > +     inode = ilookup(sb, ino);
> > > +     if (inode && generation && inode->i_generation != generation) {
> > > +             iput(inode);
> > > +             return ERR_PTR(-ESTALE);
> > > +     }
> > > +
> > > +     return inode;
> > > +}
> > > +
> > > +/**
> > > + * exfat_fh_to_dentry - Convert file handle to dentry
> > > + * @sb: Superblock pointer
> > > + * @fid: File identifier
> > > + * @fh_len: Length of the file handle
> > > + * @fh_type: Type of the file handle
> > > + *
> > > + * Returns dentry corresponding to the file handle.
> > > + */
> > > +static struct dentry *exfat_fh_to_dentry(struct super_block *sb,
> > > +     struct fid *fid, int fh_len, int fh_type)
> > > +{
> > > +     return generic_fh_to_dentry(sb, fid, fh_len, fh_type,
> > > +             exfat_export_get_inode);
> > > +}
> > > +
> > > +/**
> > > + * exfat_fh_to_parent - Convert file handle to parent dentry
> > > + * @sb: Superblock pointer
> > > + * @fid: File identifier
> > > + * @fh_len: Length of the file handle
> > > + * @fh_type: Type of the file handle
> > > + *
> > > + * Returns parent dentry corresponding to the file handle.
> > > + */
> > > +static struct dentry *exfat_fh_to_parent(struct super_block *sb,
> > > +     struct fid *fid, int fh_len, int fh_type)
> > > +{
> > > +     return generic_fh_to_parent(sb, fid, fh_len, fh_type,
> > > +             exfat_export_get_inode);
> > > +}
> > > +
> > > +static const struct export_operations exfat_export_ops = {
> > > +     .encode_fh = generic_encode_ino32_fh,
> > > +     .fh_to_dentry = exfat_fh_to_dentry,
> > > +     .fh_to_parent = exfat_fh_to_parent,
> > > +};
> > > +
> > >  enum {
> > >       Opt_uid,
> > >       Opt_gid,
> > > @@ -633,6 +697,7 @@ static int exfat_fill_super(struct super_block *sb, struct fs_context *fc)
> > >       sb->s_flags |= SB_NODIRATIME;
> > >       sb->s_magic = EXFAT_SUPER_MAGIC;
> > >       sb->s_op = &exfat_sops;
> > > +     sb->s_export_op = &exfat_export_ops;
> > >
> > >       sb->s_time_gran = 10 * NSEC_PER_MSEC;
> > >       sb->s_time_min = EXFAT_MIN_TIMESTAMP_SECS;
> > > --
> > > 2.25.1
> > >
> > >
> >
> > --
> > Chuck Lever

-- 
Chuck Lever

