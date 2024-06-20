Return-Path: <linux-fsdevel+bounces-21967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7C5910553
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 15:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B7AA1F21FA3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 13:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC171AD4BB;
	Thu, 20 Jun 2024 13:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PtBowW+u";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0MXz2lYh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA531AD4BA;
	Thu, 20 Jun 2024 13:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718888447; cv=fail; b=LsKA8BsqWVsqypQC8OFdsW6cbDvjsSLe3jO8tdjgDs7cyodlMD9rZjVhayMP9RXXvodksrfF4SOqSsplxVuy1QIFtb5gi3TfOmJm8ARIm/ch9GTFxnW7CjZEd07R5FI0dIEUfICbrNQdssVZEX40eo1SiegKQZ8Jg8aBGJEALL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718888447; c=relaxed/simple;
	bh=iYHwp5YcMqCICZEfPr8u3GMu8bDKSlO9lgNyC790kJI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=GmWqguF0QxKxbiRXVJedrifcK1TR4Dqqtqvnx2GSipn+m53Mp8wpGyKuJNaWR3st5BZfdLm4XifUmAR77iNs+WYVrIFQrDUf3dHeDkJN748vt1L0Js7l8F3jVlMCUWlM9za6qTmPnHIEU9HPjv35B4CilylXGceaQRPmlZT4YOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PtBowW+u; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0MXz2lYh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45K5FidN002324;
	Thu, 20 Jun 2024 13:00:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=c6ykB+xORTZQkl
	tZYRbJU6xfmgOm1i91ZMwuoFqPaCE=; b=PtBowW+ua1/+Mu1nqHhZ64inFGP+35
	T4X4BUaFM8TC/3fzku1T7ZdB14yf6WdZJzoKf8mMrPMyT33a7UHXMID1SeXX2O9Z
	qci9TLrz1yGxuWxgsCZ6LkWv7KitEIGKraf0f9NTg+YLIWTmzwy+lNmOUz88QsrX
	MOlhsZIfaArxYaeTUMgyBP9Sczzm2vX+3VB/kveumIk992BM6I6HlyF0fDnW6uw0
	Ke/41kpX/JNjwMmWRfS06Q+t9ETwK1ByQG/VmV+92Wn6DdcXZ0gGc8sHkvSYcNsR
	u67d6m9V59rBWbsfc0sX3WBePTLUCBKjcaoH4kECMsRJA+QcPMxGyBBQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yuj9r3518-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 13:00:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45KCn1Dj032841;
	Thu, 20 Jun 2024 13:00:32 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1daed6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 13:00:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cr8ZqqqCBBdlRCyV5cO327r9Ns5Qk5QX5tXeyRhOYnysq7KcHMsLSSN+owmwoDB6RHA4ZYBA1cKFTrC216WKVw85y4KoGird81TE+QpZOHPkt5ZWJkDCR3uTG+ucCXi4GpyAzNcWXdOc+4d/95F8EHpWHkDJtfyto8qStDCUxzOpCDY+OhpHx4pVCzNtJN686RFIA8t8X/G3bBfsWZony5EV6mW0x8pXOV63p6z0Ce1TGGHAIstePpyOTkh46W3LQIxD1rbk0ud+sSS4eeYFs/gQrldxfsuUJw4ImnB2D9LRYwXLq/i5Qno1BrNZoj2ge+fgqU3PxOrCOtyMz1giXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6ykB+xORTZQkltZYRbJU6xfmgOm1i91ZMwuoFqPaCE=;
 b=aYHDkTaVZDcBCuOPFmk/J8drNeC9fRYmTjne7+3KQDRaTKNKK2xWSCVt8HHzrfUp92jAd3jU9WNJUhjr+uHwH+jEur4C9kqnFH3XccsLUso2KDpOO1QcNEaO8JBs2Yx5r2qi423eqaDn1trU/JeFd7OGRHJ1cRwRahzhtI84NN5EUnxYQ+mP0HldV8XwKg9AnvK3lOQXnY3FcJnFN/A1kWOiE4gUs3JJPIxzd4A8PyDyu1awnhoAis9qrnPhSQ5W/7ERto8tTstoIiBdL2qdIvGKxYJZ6TpdsvYrkRJ2kXO1K3s6L5QkWrZ5hCXd5l7z5suF1Osi3rY3onCm8v8F1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6ykB+xORTZQkltZYRbJU6xfmgOm1i91ZMwuoFqPaCE=;
 b=0MXz2lYhzC/M8x8z752Nv/NOUiEbEvb+PbpcwULt/KXbpcUvi5DTRUq9K2vxTEGCx6F/Gk+MzjobSzCS6rJlwdqw3guC4U7OFKlkFuVRNS8flG5SaXSNGILZuN+f5pXh5AaCPZB3Urvi2CngaVCk/RGoPWaw7uJoVlFOBt9+M6I=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB5661.namprd10.prod.outlook.com (2603:10b6:a03:3da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Thu, 20 Jun
 2024 13:00:30 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 13:00:29 +0000
From: John Garry <john.g.garry@oracle.com>
To: alx@kernel.org, kent.overstreet@linux.dev
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ebiggers@kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2] statx.2: Document STATX_SUBVOL
Date: Thu, 20 Jun 2024 13:00:17 +0000
Message-Id: <20240620130017.2686511-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P123CA0009.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB5661:EE_
X-MS-Office365-Filtering-Correlation-Id: 9983c664-9b89-4a53-01f7-08dc9128f64f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|366013|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?0Nq/P0kiQDYmxR8jkwTPR0xErVac9ShBqvpV7SGx1lZudfwTdjYxEN2Pf2rv?=
 =?us-ascii?Q?C6VA3tB5bmyFYmjCiCX+pWesW/mEttt1KoStaCRUIVgTRTJfXkfQjVyANrNW?=
 =?us-ascii?Q?T60VahOGy4v7SKKS3oSb1/3a1AJolVsSjIjUh57LAS68ch8S2UMuN0hky+yj?=
 =?us-ascii?Q?A8Sd34oKkwzKiI0+Glm545WT/z670y1CuMtXeRdZ9u8JvAoMLxorBOP77SPF?=
 =?us-ascii?Q?bfmba70dXVa5sN0++lVCLI9NZ/txV/FiPSUhACEyzNjjb/3SAPbCjE5OGrC2?=
 =?us-ascii?Q?/8TseXi+RZ/qEnsl0zN9m6T+kA364lNSmSxGWbdKKy7sdkE0zKRJlEXj0yuu?=
 =?us-ascii?Q?MFKw1BzvRIaiLhuIyoEiankVmNyo/W4zCbeRg0nlniKLSmfrip3C1dM6YTke?=
 =?us-ascii?Q?zvnGvdj/PcN7SpZOy5O/YJuRm0MVRMti6yY8++DKvMxNfba6ufhsEsBoZ14G?=
 =?us-ascii?Q?QFjK19PO+wuuV5nNmTOCmvxlWi1I2fOCL1JE3kRLw6TLnAIz98A7hJ47sx1L?=
 =?us-ascii?Q?6RhQFy7v8kRBI2o/ylaxTsHI0KtZDJTqcD8HJ0pCqNaPQLSFzViNNaY5TKdI?=
 =?us-ascii?Q?fYmjnLTyTFgqFmuQqGbngJoNDTO26tcjrRPPnE5BhHk+n5WyDqNTrBmSobG5?=
 =?us-ascii?Q?6bvN5CLcKq82xYe5kcLYU6jvCaSvOeUbhRlNMH1S2jyZakub7aibz4Gr7JJ4?=
 =?us-ascii?Q?O6t2z0BytwNBC0s+hUFCnH9/0tGu+ynHWTn6aUh0JGVls1pSL4LcZbEUYYmN?=
 =?us-ascii?Q?92EYTtpRsbwD9pvVEikrz1yTbwGIDy7wZuJvzmFoooXo716XxyBbwwnVMwx8?=
 =?us-ascii?Q?6JDMITttjwirIFKTTyBilIQ08x6gAylpL3h1NbIghWK1fnz7wpScMVBo+S2T?=
 =?us-ascii?Q?Nl3ZbAhHDBv4WHLz8Ro77B2i0xmp4eD3oWI7zSRxeIJqhg9OPtRM6KxRd/wd?=
 =?us-ascii?Q?G4sTQNEfl+0MjSFpSpdIN32M86uQfkmjdCje8EzR8cDoyCH3TH4Z/yoTa0Nq?=
 =?us-ascii?Q?gGHRjqWQSGyg1ZEj+QYtvI3wxXYClTmzCni2DhcsTtP0CZfa4tqF8selzb+0?=
 =?us-ascii?Q?sdz8GTryonI7gPSUoJQQe8VZw/WMq2Mb4WqXxi5Lqa7KUF9FUsMb+lAMHLKj?=
 =?us-ascii?Q?fLa4VKM1yvG/PdH0vxeCnAO6Lkz12USUzgd9QQFeH7MlAYHIDJp4DXHoWXuo?=
 =?us-ascii?Q?LLuuSdDADdVevJWLQ2kSS2+Ikl2ofHuxMWFc88ItJy4p6wYyNUGIOq8V4MoX?=
 =?us-ascii?Q?g/1Dfvmbty5LyjGuGgzY?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?MN+zrfHSduC9Eueusugtqd12/FGJHI2ltaaavp5b6E2bX1P4sBTs2qPcAFCz?=
 =?us-ascii?Q?MOQ5Ss+KZVaFMIUeKRXAdrQiZ35xNlGziFPZp42mLUjxcRILvYixWU0K+MWO?=
 =?us-ascii?Q?TPlJSZ3SJTHEn2aP6SBwyMMchSresYTIcjobeSTgEdIEvQGkK/N/t1Bn44wN?=
 =?us-ascii?Q?WN/zIRjm2/z+bOhitu1DzbLvkYJIv6RXc1phlBpQupLRycMuL6YrXjfcCbzW?=
 =?us-ascii?Q?YFyVAJpc+IX1kXLvC/uAr0TCs/YSfjRv353YjEgmpjpluXpIqbUy7rw4qke1?=
 =?us-ascii?Q?vobYiN7wj454yXBaQ6lLor1huNlq77y1YyPU9Fy4HoGGp+QWyXVo/SBYXLPr?=
 =?us-ascii?Q?KywHPPK0phE2pKcoe3gM4M2L+5y0GLo+Cxv+0WCcJce6IqEeLmFyWOtgVo7Y?=
 =?us-ascii?Q?Bs3LbexPzHyf/HbHGB7bZbqKMzb7l0moUDKsU6MBSjTWYjCxqM5NE5QNVXDU?=
 =?us-ascii?Q?PEH2nmeoFSz70Ro2KNyCFZBqffQVSBF9gB+Qc+1HSYYcRrxS8hGQTL89neNH?=
 =?us-ascii?Q?InTlr6ek0kisqR8PtYQF+geOafiBZF/LHcXoA99Qyk1BPaGhd7XQq+que39Y?=
 =?us-ascii?Q?V9ftJETqHpkBgWM+csPVFB2aIhfwTQg0zW5luROcdNjDKinqouUsciod+RQJ?=
 =?us-ascii?Q?2zk0lAkUOBwW8p0AwJOtYY6/CcNdVyrA3kq3U5kZaLdRwdX3ljB7ywJGRpCJ?=
 =?us-ascii?Q?uxOspuoz4Co9Lqk9oALMOsd9eAG6vKiUvd8y0VHjJGq5f3uaj1Kf45MlNw7w?=
 =?us-ascii?Q?BIi64nVlA1h3e6Q6E6O+vwYfwyA7T8o/ikfslRA9IIBYMiH+GMR6W70+gusM?=
 =?us-ascii?Q?TTKUAk3Z4nCtb9IWfEtLUJBaXqDYJXeRglSrarcNqCN5pce7qxcdG63u/R3W?=
 =?us-ascii?Q?0hspEDk44aV+PF84FhN9ZPrNpuFLQJmsR1a4jyBGpmZ5SKS8eMFM6HlRX5jP?=
 =?us-ascii?Q?7Qn2GV40ZMZv3U0RgkgJT55C+7dGvs+bmPSLNflXtwQ60kN+Bku3h9EE0yG8?=
 =?us-ascii?Q?bWngh9SJ/Y6eR8itF8aZa9UuLsmZOUdOlysBxNZqk3u4nFtXH1/1EiPFvLda?=
 =?us-ascii?Q?fyZGUTo6hF4Q1cmRqPcP6rEKq0I6KzWdZRm5WbkY3hK080yczTLQzppte/Zq?=
 =?us-ascii?Q?EfLsjX/sF9Thv7oawuo6DfdT124SL8h6W+5JykBQTKughSrfTsgJzZiKhhPO?=
 =?us-ascii?Q?No2IGzvPueen+NkKybU/7Q3weN6LqFRH7ReQ4VYxx2WHVuRtEc9UM3ICTQ47?=
 =?us-ascii?Q?/KWjRYOoatCMTIvmvid6lN65g3hCdfDq/Ltos19mhoAqWJDFU7ho76SJEdUq?=
 =?us-ascii?Q?25piQ+P+CYfEW3KxBOfHOTxkR0iJBBnM7FaP1jGMG2LDCT6PDvSF4Spj9XNv?=
 =?us-ascii?Q?xnXbjsxQNuCX4jZ6DIIocQTT0/LyqpvhnddWydDj+ypBlfZQM9VrLsVQwLri?=
 =?us-ascii?Q?Gb07JUuhtBOjoFNDo0J46h9svekHgStGFMyXpWlbIAWWh0yE8Aicheg2uUdl?=
 =?us-ascii?Q?6qWwZhJMjgD2VkSIBo3OLuywD/1aPwgz3nh+QW20Y0JcSFS0F5oZ2Sd5Ob1J?=
 =?us-ascii?Q?hc0ET5mtgATitax5EshfM1et2b/Rbje9m0ByBsswv2p6UC7+hCE5TH5+WoPV?=
 =?us-ascii?Q?5w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	v/fcJXp4IRRJRffgPWSSSotAyUV/CJybvnZAhwOpD1H2S8QqE9BM627kP6AkGWcQGhoTm5AOA82ad4VRgJRlQUKTjwe+fRA3FZlEhzJRfaJ5QnpsR7NGimVSCSZeUl+iybs9Z9OYHRWfd73UVpH9jzhJ6qRT1iFXQvl05/2cu2tQ75AYGPO5fpIJ0pD3liOpjWOC7ASWS+oR1Hqiy0UTqr/oAORYN3bMOn07stfayWvmntJKi8GI17mp29rtylawYlIII4wnSn/esUwoc70F22p2nzk4bF65n9Rd8/9zm8efDrm9UcserL/SWYz8Z0ogt5hegfYf6psuJLIlHaqyA5AjDBsOx6l9K3f5CLBBFAEsB0XLIL8zQ3/WGBCyerIG/2NZ764OzC3npRSixQ8KcWEstiSsi/mO2ewmgrBND++JLLFfWX/zhn6kwuqnXxiazMZiLFzbXlNHRFYbgbTk2SmxfpYfyA3NKDq5iVdFVc8POT+mOgCbl17Lw1ThZHmqezQq9CxsGf1g4oP2KghjrFbUbMf+VpGdMHNE6g5jk1RzF277ulWawv6OwgBY+gsciOXEN2nxXveCPdg717r4omY6dBpwDjDv6wHn/dE1Ucc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9983c664-9b89-4a53-01f7-08dc9128f64f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 13:00:29.8951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KQsRZD/1plMurU85GbCUzrlApBaT0dyJQzhJdk/B/VSbleIzjGl0/1crjsIMnaXG33uJljCBg+O/t1VJiZ9gqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5661
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_07,2024-06-20_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406200093
X-Proofpoint-GUID: XUBkdaTe-_XdNKCj4w85Ccrn_4EAO-Bo
X-Proofpoint-ORIG-GUID: XUBkdaTe-_XdNKCj4w85Ccrn_4EAO-Bo

From: Kent Overstreet <kent.overstreet@linux.dev>

Document the new statx.stx_subvol field.

This would be clearer if we had a proper API for walking subvolumes that
we could refer to, but that's still coming.

Link: https://lore.kernel.org/linux-fsdevel/20240308022914.196982-1-kent.overstreet@linux.dev/
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
[jpg: mention supported FSes and formatting improvements]
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
I am just sending a new version as I want to post more statx updates
which are newer than stx_subvol.
diff --git a/man/man2/statx.2 b/man/man2/statx.2
index 0dcf7e20b..5b17d9afe 100644
--- a/man/man2/statx.2
+++ b/man/man2/statx.2
@@ -68,6 +68,8 @@ struct statx {
     /* Direct I/O alignment restrictions */
     __u32 stx_dio_mem_align;
     __u32 stx_dio_offset_align;
+\&
+    __u64 stx_subvol;      /* Subvolume identifier */
 };
 .EE
 .in
@@ -255,6 +257,8 @@ STATX_ALL	The same as STATX_BASIC_STATS | STATX_BTIME.
 STATX_MNT_ID	Want stx_mnt_id (since Linux 5.8)
 STATX_DIOALIGN	Want stx_dio_mem_align and stx_dio_offset_align
 	(since Linux 6.1; support varies by filesystem)
+STATX_SUBVOL	Want stx_subvol
+	(since Linux 6.10; support varies by filesystem)
 .TE
 .in
 .P
@@ -439,6 +443,14 @@ or 0 if direct I/O is not supported on this file.
 This will only be nonzero if
 .I stx_dio_mem_align
 is nonzero, and vice versa.
+.TP
+.I stx_subvol
+Subvolume number of the current file.
+.IP
+Subvolumes are fancy directories,
+i.e. they form a tree structure that may be walked recursively.
+Support varies by filesystem;
+it is supported by bcachefs and btrfs since Linux 6.10.
 .P
 For further information on the above fields, see
 .BR inode (7).
-- 
2.31.1


