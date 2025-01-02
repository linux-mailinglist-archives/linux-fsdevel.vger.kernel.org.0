Return-Path: <linux-fsdevel+bounces-38327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6F09FFA25
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 15:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 762F0188371E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 14:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E651B4128;
	Thu,  2 Jan 2025 14:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gV+xOJyk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xqXnV1Hh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A56D1B4158;
	Thu,  2 Jan 2025 14:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735826731; cv=fail; b=ZRbXzwS4YAMpDrWMRyD3MxMEx1wyA5bdcofjRKJ1+aYQrpM62rDwc0uSpIIW1xx6kcbyRFcGk1XUPK7KCCYKUbwBKenIay0u+rZKDyoFlY20vSsK4xldcOf+CSlncl4pR2d5S56nsZ/fxNGM06yw2dVGGgb++NlZbc+VF8U0aCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735826731; c=relaxed/simple;
	bh=vlWFwgJrebPTIBt5TtJKW77cf630t2wIXQwgFzzUNWU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=l2bPnRHCZtISOS2IjKLP0q5gB12vUrNF/hvMNThxRgn4g/pBdpNUS7WYl9X+DRljVgxFcySlMYJgHLUJoYNDEU01w1sh+eX5wEr4eQteZlAe+yX2bC+1a4lO1Lmi/shG4upTwI3px1ArkIVjxCy8mrjZjSJyjMPbHBT5tmZKaCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gV+xOJyk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xqXnV1Hh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 502Dtv0O024654;
	Thu, 2 Jan 2025 14:04:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=ovm/gIkhEqZ8fIk2
	ISuofROd/GLBS/u3ANybiJS2erA=; b=gV+xOJyk7193Ejx3MTB/edLuGvAAydGW
	DBlGyL6wlJEg3XKXsf4+OeyXnloXexdpv15lNC7TJJ0OGpKZdkuVYkj/bT2qCGDY
	noN+bv7mooAhp9j2c7ozVJeMMZR3ztlYGCZwgXaZYA4pZytraNBAsknKKe0hR/zI
	C4FjkqIsCkGagWF+Or0y2xvdd++YmIeXblPE8xOAsD/ev9n6SFYuHeqK+X9WP9vK
	eWi6XZ0a1n9NfRPf4ixBKhxGE0K121p6Crv1YDMoAHfQ80FlL2UP3o0YfLkMHRFE
	h5ufKKjA6b/THim29iVU7kyrwQUnSb2GS5ohIHIC+MtPyN87eCy0KQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43wrb889mn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 14:04:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 502CqmBJ033469;
	Thu, 2 Jan 2025 14:04:41 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43t7s8bfxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 14:04:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S5JIMcE22a2U/cvnbJlspPlvUuK/0Hz2REm22RPsW64xCijRjShVzI3xOew/ByW0cn8GYxcyAqUUiyrj+B3zhADDF9lqauICG7vpwiKMm+GM9l6NsonSoRWO5r8K2VxF+JXJEIxPBoUA40kFZo4UrhratNeBcZ2qUA3mXHNci9k6yOLp/EWdyRNqJDnTBrGaB16Th9rRbxl8j470TAFr0UzRVKl5TzYVys5vDXSSjkjZq0BUlh1D9ReF0caoBw8riCMQmyHegtBhxARPas5ChwLr9uhR3VCiNa2k8I8F5dHQNXDVd2G/qAyY9X3qxdNAHEnO1p3C7J67QYGVG8gYCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovm/gIkhEqZ8fIk2ISuofROd/GLBS/u3ANybiJS2erA=;
 b=gsU5fTt6DXNwbJ3LoJ/WDae4rYgtuwBmb59PGb+4qAlh5BRx6uEwyU1B/9JaYVJNyJEu1xM0wOCg1+qHKtJK969J2WzGmL/clIcuFeH3/ovGSf1fc1TdNX7klKk9DaiShxz75STCUyVToX1K6aMieUVS/g7REUyAzmQqGk2XHfDA5lWFyez7rgKZ52IUyqDKPSWVdYz1GQ9Hn7fBakiX5gE3Sm4TBChFonJpfvOZD1LQHdX+ZWTVYk3cmyu3MBiFi0Xyx6CYstuMF41QbtaJEmCr6F7IasO5bMUnzfCOhETcMYrXWy+lsjVhrLVBYAkrgheducu+95yxht5RWGTCXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovm/gIkhEqZ8fIk2ISuofROd/GLBS/u3ANybiJS2erA=;
 b=xqXnV1HhIrUjofCRoTD0vmBCVqNdYNhoAn7mFJJCnRiVZjHyhTlMfEOJZ+wlbzI4FXlKWFrXdVJaDal/xqEsRtOWVgX29LH5wyiL977C08RA7Ow+GwuNLz8rmXxVU6S7CFfz8RfR1aKK0lr+9nkXWNevQjVBlIWsuX9xRqb4lIE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA3PR10MB8164.namprd10.prod.outlook.com (2603:10b6:208:514::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Thu, 2 Jan
 2025 14:04:35 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8314.012; Thu, 2 Jan 2025
 14:04:35 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de, ritesh.list@gmail.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 0/7] large atomic writes for xfs
Date: Thu,  2 Jan 2025 14:04:04 +0000
Message-Id: <20250102140411.14617-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR11CA0018.namprd11.prod.outlook.com
 (2603:10b6:208:23b::23) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA3PR10MB8164:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d02620d-649d-4b97-fe76-08dd2b366334
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7sf25+3A8SJxV+gZrXlXHl01OHV50UJwqF0404lmJmjykEoOufH4ap3i7VBr?=
 =?us-ascii?Q?Id00ZLHovysJZQxs9cn+GTa3nCj/mZ5B9tc5EQn+eGBL2jX5wp5gW+O58mcn?=
 =?us-ascii?Q?UUCXp9mBiVYJzJUWGtSdbIykhi1/qW9GCdP67PCQbeLldZGv1nwwR+oL/jg6?=
 =?us-ascii?Q?I+nH09IklOWJrKELxUQXew+8CZkni124aV7YOYd4O4TCvwqe3UiP+rsit+MO?=
 =?us-ascii?Q?JQtH69Mn43A5VoHXA2wSVK4lUTl+scg/Xv13VzBmuQjOB0NkZ59MbreggZER?=
 =?us-ascii?Q?lEDfGkh6ynLgaZqnSi/cvSda4m6viWR7LWKRu2O/lmXp5INDPDhB6d3Ye1B7?=
 =?us-ascii?Q?l/YI5riZ0bT8BFaOvhyK2T9L4fJqUAAj59fuSFnuga/QmrPwjBsPOV0ioN5F?=
 =?us-ascii?Q?SU9gq/eFCJRjoCb55l9OelnIJ9a3vy0Pg9aLUHsD7vs+k+3QW7NIL86e9s+u?=
 =?us-ascii?Q?z+vrL7uVHIz+1i6//xrwEnIBK366YMZuP8d73MYY3uGuaFZteAXtgzujhLXn?=
 =?us-ascii?Q?UvPOv+6fxY5uIK+l8IaQUCzt39iKhc5A1z8TxK5kQ0GiFc476XUN6fHo9p8I?=
 =?us-ascii?Q?kWI4zQyPAnmlJwiQ3YrfYrPAcVDV0c+ugEqMJm4Z1myjgSZCdRA4PZQ5KONz?=
 =?us-ascii?Q?PVvCRK82K7C+GywYaTgU9p++pQnjntwedpmYoj+z7neNzG2exEB2VmwmVsLj?=
 =?us-ascii?Q?wiTN2+Fo4wPrwgomQkWsNlYbIZz/ReuW1SQdWPhf8oHBs/9ukZrbgK4hVg8j?=
 =?us-ascii?Q?IG1hsvHlpFflzpMf/wUIcU9QntvgFjxNdTx/tENIr+ssSxGjch8vzw4hjBIE?=
 =?us-ascii?Q?zRdG3j7zK6QcTL6P8qR2LKo9KUmWhmoKB0GU0Yr1kTOBZet59WrM2Cqx2dIv?=
 =?us-ascii?Q?avj2TUGlU5IBhxQpVEUrH3buCJXgOI3HEf7rWKjLvDhJesL06RKobBdWwrpK?=
 =?us-ascii?Q?tCBaZ17+ysn95w//0pSHcMXXpZkXf79kZyZ+4UIdNh+w2vX5G9EpevTGc4q0?=
 =?us-ascii?Q?DrXO0nKIcRIFnNr/HIrN/xUeqApj5VUAUQM8Xyc7H8Bl9OUAYArAWYiJ1xy4?=
 =?us-ascii?Q?/WqpqJpsmLuuG5NU9sW93wLNOgNpPzQ83tqum+rjB0tkj/BQhagzcCzaagPu?=
 =?us-ascii?Q?7b8BXUwIJZjGMo2+4NuMWOTmTnjaus0kF+R/3kmzOaLyfxG/IRTXyWzNlTaF?=
 =?us-ascii?Q?HfcHcbfzXlWM2odCqKTupmwsP4v9p58/TP4wKSkEiOCcwoY0/Jxiu8Fyaznh?=
 =?us-ascii?Q?8h4fi5QNJHuRITd/OBQUdWAbAct+vwA2V+xE2J4/6PBI8FBUDcLWRhP8WSJ2?=
 =?us-ascii?Q?xsQzPN5/hsE6ILzBXw1c8MsDulxHQNHTSczq/KqLYRfYsg1BCoP5IrXmqCWf?=
 =?us-ascii?Q?E+LxtpwFJDULvLgMEvnMwaKJ7uAKpulQYqerijJry9ysxAV8Vw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bvc47gnG0kLYGI95rqCulAOaRaVxVP1qGemSJs36W4T2E5yJLHtbuZvDGDSc?=
 =?us-ascii?Q?0xVewma/E8zuytgRvbafCuDjS7yyp8AnrV8Xf4kuHeMI/E8iUcFUaLIuRkpJ?=
 =?us-ascii?Q?okXyWpU91DEqukikYdZBO/rlU7nMFT9edrZJP5ppT/h5qhhMrKVLMlYDSlWy?=
 =?us-ascii?Q?H7oHfykAg00s5BuSjpTFDYv5Rpm7JM//rgXZnsmCoxA393GdBlP7gdviPpVU?=
 =?us-ascii?Q?3PSvKklO3bEEpNN4AIBW1E4ygDRfAxEILlxjFEiiS/fAUHZqzZ53PsfYMh43?=
 =?us-ascii?Q?cb5zloYADajrzZu1OtQQrh1UXJ5f9MQfnfU8GveU2zt+MAx2jeIYgQe+uL6T?=
 =?us-ascii?Q?Mr0gMcZRlLnaZH+9oZlqMA4lUH9RltrlESKuZyf2PfxWsyMFY1XfGf4hIklr?=
 =?us-ascii?Q?C0jnVPcLtsu8ahqqjAKFHkejsQyz3rlYRDwmglqpwYXXQPoBj+29ocX/L9mm?=
 =?us-ascii?Q?NOw0Hg5iPbOPnezYrp41BnqiJ9TVh73DhX3cU+x012zXEGnruf4965LlDxXx?=
 =?us-ascii?Q?FCqixV0MF8v6esGi0xL/Mlqh3iKQdd3GdTwfOnpf9t8CaZcQJXPx/NWHJKtU?=
 =?us-ascii?Q?XhXKUS0I7Cn/LYWuOkGjfHacv7/nuP5iO0uEZBT2MxGPpRPK5ezgzccSPeWh?=
 =?us-ascii?Q?GiSV6xaw1S6W+E49EVIJ10w13Avkm1KiEOVE5mj5h49km0BWFxaqYw8kZ4Uk?=
 =?us-ascii?Q?UCvCV/tuPX2d/69nAyujYh2CsIjfFfu13wIZRk142NhNh09j7M4mcocn8UX4?=
 =?us-ascii?Q?qxxVKpkyWzG1OKKhGVut6VhPTKfZnw3r9nWDi7SBfxwg47QKAqk8KTOd7l0x?=
 =?us-ascii?Q?jx7QjmeYajY+R9UR9wFVkQLVf9K+ge86BLCKM7Cb+LWDlxIiUamUMZpYz7c5?=
 =?us-ascii?Q?m+gXLmtSbQx2gyOWlfV1Ne9ZeMhbRxgRn9JAd8GYEf5BcqgLy+WjWy8J5YZ9?=
 =?us-ascii?Q?oywY3YlK3sZ5Ubrkb98un8wuWhed6G2ECHJpYDzQmb8h+dcsYo2yfXFwXXGg?=
 =?us-ascii?Q?+qblgPUuNkF9BI5/mctuH7nnMoZSEJeA3MmrwpIyEqQsKNb8GfxK6qtjC/yD?=
 =?us-ascii?Q?qc86u/tWyVodW5xNNReQNF6cuuMz+f1Aij8H9jxnN+nZjmCXpl6NpNLMxMEU?=
 =?us-ascii?Q?yxvgA3XqXsfqbZ6nksaIEAtV94/LR1CxDqbgCLntoP+JolD7/jIqBUwRo4uz?=
 =?us-ascii?Q?gIAq5tEMzER/wSFpX7WJRDsreRxsIUlqNujmlhfBoFnXhd1lpko0EDkCoeyv?=
 =?us-ascii?Q?9evb24kOz+8MN7GOiqnHUdMdateemg3HUYI/Cs/UsGIEQ8dEqNJWPny6HvdQ?=
 =?us-ascii?Q?s3xwZt9zIEfoUbduIi2KpQ47Ikw+PELU/y5yq59IsD8njHyGn5ZBq9rlfMUW?=
 =?us-ascii?Q?LSOzgjHXWvNtp+lPh7LqBe7a+DMaexgSIvmRweCLLKo/kEJLyn1BE+scsW0c?=
 =?us-ascii?Q?PMJ0BZXf54a66aHcxpWgGsSvBcTEjt0crjqgjpf3RcJuWYAWyHw0A19VGoYg?=
 =?us-ascii?Q?yHGUi0K5yjmiGzl7PDqP6dq18JBurmY9gFc+dRoeW7nzu/Wz2//yrakeK5VL?=
 =?us-ascii?Q?wl/UA8y1Uqy8HOa8IkK13Fo+0Ip3R2QsONV60QY+cA7Hv6I8gYQ/4vDUKSkb?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	t4KXoc6TuXFz9UGwZ8IUdBg7HxwWydSNABTvHGUCCuuhQ2WvNG8DrrRlq9jV2yD1xmdjMSIlDQ7TAevavBQuL+zxhlum7DCDv7LId76+2KkP1N00KZ7sVXJdcrrD4YUf1ch+MfZh7t4Z4TYSvcn9roZvV9J68rdFvf6lBVeYEb3qR/FUf2/qpzLK6IXDcrzupIYYXRxLOe34mxmRhn+ymv2z8/liJFRKB9RTNpZ1nq4wd7OcBVi3yL6EK+nZoPRYqFfb//m2OahpoSQv55x1W2vXiQ7TQD6+XeKlXGZKHy2nr99XqCt+rfs4V8c9gbqIdyQ9XEIlhf/xUgTe2lKo0iMlEjTlCpBIwAUuuG1mNWKqck+CjaZGwYQGC+SuPnpxm2OIsyfwo/sPFSzHTFMIYnfVy/mObeB1EENsqDQka1tBa7R9JEe0Zql3IapunGHGFp0wn02Dq4dHAzIFQ/DBHfywBCL+lwYSrPRB94YdMAUQOg5LmzwEHy18IaihhOCib3biZLdbrnzIp/LuERgE8qw8gi9yZUSACDVrVkfP4H4NvwAg2QAA5dwf5c+CeiY3/GZ0cThLWpykJwrY7f8m4SiIwNqeev8F1yuFIfuLtOw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d02620d-649d-4b97-fe76-08dd2b366334
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 14:04:35.0621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: koJylSEKTTYezQw4CvL3vi6QI6kwFyVrNkBKcGYQujfvLjtT8a7cwUxlNeGP2YuQ+bGD3ZRlhi4JktW6dbDz3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8164
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501020123
X-Proofpoint-GUID: Io3_rFeQFcV5Md6zB8TZXeCBX3eIJpsH
X-Proofpoint-ORIG-GUID: Io3_rFeQFcV5Md6zB8TZXeCBX3eIJpsH

Currently the atomic write unit min and max is fixed at the FS blocksize
for xfs and ext4.

This series expands support to allow multiple FS blocks to be written
atomically.

To allow multiple blocks be written atomically, the fs must ensure blocks
are allocated with some alignment and granularity. For xfs, today only
rtvol provides this through rt_extsize. So initial support for large
atomic writes will be for rtvol here. Support can easily be expanded to
regular files through the proposed forcealign feature.

An atomic write which spans mixed unwritten and mapped extents will be
required to have the unwritten extents pre-zeroed, which will be supported
in iomap.

Based on bf354410af83 ("Merge tag 'xfs-6.13-fixes_2024-12-12' of
https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into next-rc")

Patches available at the following:
https://github.com/johnpgarry/linux/tree/atomic-write-large-atomics-v6.13-v3

Changes since v2:
- Don't zero unwritten for single block atomic write
- Store RT atomic write unit max in FSBs

Changes since v1:
- Add extent zeroing support
- Rebase

John Garry (6):
  iomap: Increase iomap_dio_zero() size limit
  iomap: Add zero unwritten mappings dio support
  xfs: Add extent zeroing support for atomic writes
  xfs: Switch atomic write size check in xfs_file_write_iter()
  xfs: Add RT atomic write unit max to xfs_mount
  xfs: Update xfs_get_atomic_write_attr() for large atomic writes

Ritesh Harjani (IBM) (1):
  iomap: Lift blocksize restriction on atomic writes

 fs/iomap/direct-io.c   | 100 +++++++++++++++++++++++++++++++++++---
 fs/xfs/libxfs/xfs_sb.c |   3 ++
 fs/xfs/xfs_file.c      | 108 ++++++++++++++++++++++++++++++++++++++---
 fs/xfs/xfs_iops.c      |  21 +++++++-
 fs/xfs/xfs_iops.h      |   2 +
 fs/xfs/xfs_mount.h     |   1 +
 fs/xfs/xfs_rtalloc.c   |  23 +++++++++
 fs/xfs/xfs_rtalloc.h   |   4 ++
 include/linux/iomap.h  |   3 ++
 9 files changed, 248 insertions(+), 17 deletions(-)

-- 
2.31.1


