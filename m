Return-Path: <linux-fsdevel+bounces-30357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3CA98A3B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 14:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B5D21C22481
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 12:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DE5190696;
	Mon, 30 Sep 2024 12:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TbbJjAMP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TNPj1ou4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA2D18FDA7;
	Mon, 30 Sep 2024 12:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727700925; cv=fail; b=QJfdhr02Ny5r452I4b5p8klDbUBuevWcQ7t1ejFLgT/RFrvB5OTHWeKzwIlj0XkmiDslk8mSwCOwCeZQXOlgHGogkn+gzxkffekqYw1hAYJgNVeOoF3ejesFxWB2LMAXjDzjEAQO2/EmTTMcOoTrBcRLs6B1ZF3by//kDyz/KJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727700925; c=relaxed/simple;
	bh=qKWEsR4/e6Nb62b2ZwQQs8zKoeKPm26PXa3PReEew7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BUQwfTSn8m/c48oIdRVusaaTGD5M8cv+wFJfN+1DIuokuS4rlQV/Dg7oMCWNbQGMH2EHLXSngSyfhQY5u5qoCc39eBS2gypqpvRwtEETKzFxqQ5MQ/jR/eOeHkqvrae1W0MLDlBqQJb/HzJ9Y8v/TJAeeT8m33M4fwggjGvDpm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TbbJjAMP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TNPj1ou4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UCiqrq024890;
	Mon, 30 Sep 2024 12:55:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=9SijhOl5iY1lV3UpdXeQdVISoLFE0ou7Bh7/3E84Bew=; b=
	TbbJjAMPhZ5TBQETwvMMmvBvIoveDF+z5yoxz3EsNgaq1Cb8CSBhHKTjiQZSMsX0
	DacYwDCSj2hl6feQ2xermGS3pOKCGs5+NQ5VnCOsGuRZmKd03X+8xHxVr6Js3SLh
	9Te0vD+viClXCrOQRdbjo+69JQHmrH0D/ECBO+oQWSAPSyH5MhHut0lpq0eA84qx
	i9rwzqVhEadZpo2F30Fn1uZAUqvqMHAuWqTg3OS+v1Fifd6Czc6wjdWDSdjMyCyj
	KBP3y2pnzSUkc0W9uvW6+zvRmTfJQ2uT1kjfqoRYbinJc/oTb+zoxvf25gu5IWJ7
	430xeprex2pB8EmXkug/cg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x9uck7hg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 12:55:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48UBulV2038629;
	Mon, 30 Sep 2024 12:55:06 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41x8860pqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 12:55:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YKIRqic9f2QD83KH0hiVPzxDYdJM0vbQx4B6VY2xV50u/T23lnFsWjvumQc5SApsdE1+IwyqDw/Zi+q6NJ6Nca6S1Q5gaazhkaoM+m/9Etm1FPHz1Mcq9xl7cVUVTrKPRVqPruXFMgHxvvIbCqTmkESp+6lxehuWWKyGTkZfoo8phYZ0Crrj93vBPDzj0ls8n9Xc1SljiXnmEQJRriUr0md9FqI3tmawK5V3aslSB/f+ze3q1q4ZtXKJyJf1Jq8iIAyGjQ9AzvRzST1PwD2z57xdLUIT3xgLyQ69125xSzsX+Zxy/zj6z9VruwgdH4K8mg+y9Rz96XbgoOggikLFnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9SijhOl5iY1lV3UpdXeQdVISoLFE0ou7Bh7/3E84Bew=;
 b=Ald94/JrFaL3uSVgPUUrrvIlvgYZTAt3fyRFIwdTr8Bbdbd3XOZRYWhhSmTxT1WTKZI/oRBHvj/Hq1ILfXYylEkpiTK3TTMI82/UpN87nN4fT1mCpAvME/EnS59WopLGTRRtx6gYae0Fh+ig6mLdcL2omTUqRUhSZEqoutVi8C6gQPM020kUgnSOs5o4v1F0TS3k+EyeZ3YTsLNPhM6Gt9noeHTEdFYDCDT1IMloQCgxZZswImTciNP3+fibWPwoOcKyZaSu9S84I6rqJqOqmROqp8g+xrdYEnD9OwcWf4hu6jMwt3F0ANQunNK2ohTXhY9DaeBBCAvNvMZ/OsQvOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9SijhOl5iY1lV3UpdXeQdVISoLFE0ou7Bh7/3E84Bew=;
 b=TNPj1ou4VtBnwz8KYn6ECrjbbMDcWNXNlNTzjjWubtudf3ocK7ydrlBU8JJjKKkZrXJu11HMW92BT16fRw/RcJG2VkcUQ2GLgOuRV22LShjYEJQMfDQeQjY5VX9lQzayk70HGmIEsBg8xCO/6zQw0gUMjXU0ifQ40ntuJRRndwE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BL3PR10MB6116.namprd10.prod.outlook.com (2603:10b6:208:3bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Mon, 30 Sep
 2024 12:55:04 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.8026.005; Mon, 30 Sep 2024
 12:55:03 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com, hch@lst.de,
        cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v6 6/7] xfs: Validate atomic writes
Date: Mon, 30 Sep 2024 12:54:37 +0000
Message-Id: <20240930125438.2501050-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240930125438.2501050-1-john.g.garry@oracle.com>
References: <20240930125438.2501050-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:a03:40::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BL3PR10MB6116:EE_
X-MS-Office365-Filtering-Correlation-Id: 87cbd0c2-1e8b-4bf9-3d01-08dce14f1a25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A3NG3e/NRQmnWZWjXrUJ64Q712i91H0O2FIzoi4dJifjkuCzfdN8WKdILxLW?=
 =?us-ascii?Q?oKbZjC1WpvWV25OPHeDsTpte+1rmMivr4zQlVb3iS3q6qngSRbPLEjPzK/GU?=
 =?us-ascii?Q?62P1Ql0PTLjHXZRjqOSq1QTw9PPvKqXZRZdZqmx4WPPVBfMyxBLb5X09tBCR?=
 =?us-ascii?Q?ZSdzO8pwDSI+v3cGux//9iP2psRX67mKzvV6hvF+gOUMr5cXbeYRFNQgCT+G?=
 =?us-ascii?Q?8GfZTGys7mlkBwq+lZB5M4nsI2m8fX9dGfCjyN387jcJkgGTlKtT769d40I9?=
 =?us-ascii?Q?2AGimZ2JOVKUguQLWXLzN8TWRMZXjPXorWZCM48+3lk6SYWFgqKDUBkSKXCN?=
 =?us-ascii?Q?rlX0p8a06P4MmC3dxMyACen2v/pAYxbi28LubKUwvXYBnq2kMH3hNEvIJCJu?=
 =?us-ascii?Q?TTnOmb8rgbjL2XbLsAJ1ObAy/NBWAtax9WHtFZ4HU5IKFXJYAQJoz13o44rU?=
 =?us-ascii?Q?6OflhPXTkz9SGFACMCOKKSssGGFgKcmEqd8SDWClP5w7I7EWYXIbb8/RbaJ8?=
 =?us-ascii?Q?Zj8RQfkA1/HLi1GB6edu3/v13cgUJYlhyezRd6ZRpV2/mYmwBjelxsq4ULTD?=
 =?us-ascii?Q?Yh6cm+f6SVdCOm3ADlzijFuBSUX5vj+1BhBTqAT2vhrY4aaupdweI6+mxm87?=
 =?us-ascii?Q?wDfQLZNW5YoT6Wu0cyAw3T9ic32NbheMU6K08reKpiWpOHW97bvP08ImDZSV?=
 =?us-ascii?Q?GXQcZMuWVgzsm3ZncI6hjb0GBnJcY32NXG05/qodh06YC0hOG/9i/hiz0lCL?=
 =?us-ascii?Q?Gba/Nc8bhtzjsUdnPKoPkM+5/Ta2pyodf7NFygb0uN1McxPWOyhL6iL23DZ1?=
 =?us-ascii?Q?4LkFlVwyLqgMJUTA+CiaM+IipacCpbXVCH2Cjajy4Sl6611T4UwxSb3YGleZ?=
 =?us-ascii?Q?pXmiLL2U5bXzwuTHZWx0hcY12ItiKdtgQrBJ74UP4bAqn7g+mMqPYiR+I0z0?=
 =?us-ascii?Q?0gJnvnY2SjACa7NCl0C44O9sHOtwVhAXUlWj3g3VZVfJJYpaquNT1brIAP5y?=
 =?us-ascii?Q?+qh8Fy6d1kjQhV6OiIlwQ8QsjVmDTnCtJuNudHfapFm0NI41DMRpWVhfA2lP?=
 =?us-ascii?Q?9UmZWRgT00orx+BxXBeN5v7jEXVnkE4KapDToMgI9NK+Pji0/DcqMXMSKnl8?=
 =?us-ascii?Q?y7WkZy7pm1DNDQvLmKgEY8ZRRpOdOkCt4SsQE+jlU5gUtbSM/QUpyRzv/RJL?=
 =?us-ascii?Q?4QLp3tLKzJVWCbRhqAfyojKYLy/JnZbJbFCIdJa+kCd4SnoFKQ1UTERQdUi2?=
 =?us-ascii?Q?aKsJSxgoNhQA7XZbR5Uk9GnGtUaHZg7HDQH0i86zaA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xlawT83t+r/BMBowyRFc6SYc3ueStedGhCYIxeS7ldP2uvyXbTXAEIWu5Ugy?=
 =?us-ascii?Q?9k165mighiWqTSIjb4hWX8uyxzcCybiHvxq3rRk+AZFRgKgbpms74MlP1/R3?=
 =?us-ascii?Q?L3D88llgI/jRBeJ21PT8U/Iu91btlI5GFrNJRG6t8y25Q8hcUf34xScoON2J?=
 =?us-ascii?Q?mzeZCV18nkxTLngiJ9KpJNsQQVMSV0CYMSV+KjxO7DCaYxIpInQr0Oajb+DO?=
 =?us-ascii?Q?l/rVLcU8rM91A6aiUgOB0byyxJyvXYpPa1m3BTw9PhNINmLLWpKokbSh2hJG?=
 =?us-ascii?Q?lR17kC+uz3H5F7H8rdTe7jAniVVJbO3AD6voDn6KZRwefoUk9B9XohJSxcsW?=
 =?us-ascii?Q?rAPJ99JnVE9CxhK29hhgohU63uBy3XNVQRKCUMEz9euuPKS7lhHWZV0b+Ldx?=
 =?us-ascii?Q?sRSyKV9OTgJPAv08WQXcjxv50TQ20+DOyqdEQz7MoXvapZFsttKPVnsm0q/L?=
 =?us-ascii?Q?vIrMSKuuvlgykzTSjxkrrmcVmT3N1wDsu+D22qRtH82SSxAnuIbf155ThE+z?=
 =?us-ascii?Q?8VcQGcTbdY93OGnebxacCj6SIEUP3h0Eh3K70JBtEjVQkJT+qNlr1d5YxH8B?=
 =?us-ascii?Q?RzWRdunGWt8KAuLWfXuz5Kdb7KmOLPV3CX+GFgIexaMhbbT/ogWmJ0PxF5kO?=
 =?us-ascii?Q?PBodNSZSsZJIZHRtbGTlPUmgsD16Plpgyr1jtE3g5DFMsNokAGBf2RUyHx5T?=
 =?us-ascii?Q?9SAL27ANSOyMHP69dhDN1sMR56mEKR7WPWLW2ht046qsFxFyuGiGUHgyyuBi?=
 =?us-ascii?Q?U+1BT6KwH5XVECJI1LLm8ozIpsLpUgCiGuL80lIYNc3Q8B4MVTE7LfyTejpH?=
 =?us-ascii?Q?Ys0sSNWi3SmkTGczNQuVQXXZe7JLXJajm6YrmTJRyFgKAylT/N1qh3cYBwrw?=
 =?us-ascii?Q?wB2tejI/1GMdxBptthsFh1QkM/FCOQIscik8w/cEYqvlXlsK62EDJajUk9m/?=
 =?us-ascii?Q?WXnzaf2h5Bz+q/Sj6G32cnTvI6bfM6ZErImNiKOhL5aKU3MV7L+FS4piucPr?=
 =?us-ascii?Q?KUc13FTGePQS9hjOkroYz2VfyEPqWtyFHav490g7HgshIqEMYY75GSPJVJ6P?=
 =?us-ascii?Q?uwxqin6qf0FAGnPltUM0M0XK3lSLRT3hgpphzNR8h49evpR/s4qfOpMWf1qx?=
 =?us-ascii?Q?DyfAeeA81s7XO3FU8yrix0HeR3Ppm+7xmTSMDfXXDlMz6H307Wbk8M1a8aaX?=
 =?us-ascii?Q?1bhBL3RXOS4OivIUotrzS+KC9v++d8Jcli8yMSU19dmQ6aAvNTyUV8abG9Us?=
 =?us-ascii?Q?iEsbLqjtc4HU4CkXqrBxVajtZEhvxSDsMcEdwRV4MoToQNM/Hlcy+U+6se/z?=
 =?us-ascii?Q?ECPvCC0dwHnWoQxEG+MgEVDCGnXdk+byWsd6B6x5z1RE3NoERJexGCI+a3DK?=
 =?us-ascii?Q?8Q6ZGadZUPtHjQf4VM9ujsSRTwAP63uLntrzmsogoemv+8YRDAc+UlLHApgW?=
 =?us-ascii?Q?PbpF76kggBP3Pvz0gaYleQvqKFEAybusbNWLVX9GVFx4Uqij5AYNCKGb2m3S?=
 =?us-ascii?Q?DrAfqSMFvvP7I+OkCN0YkuWm4Xtf4aLr+njD7GWys5SCLrd3kR5TsBBcaieQ?=
 =?us-ascii?Q?cjULhyeXQYZPAQwd9rqq9o9dp+Eu+LrOrJMIWfFnTJ9cCYDttVbUsLPC5OEa?=
 =?us-ascii?Q?dg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TQTxZwEm1IH2ZC0g+A73py5I8Bz9daDkk+tV4jtrB3ZA+0UqGGTnGDkfujK1cXlYjLFw7F1otV/JkhGIEpuOZL4gdo+nAVyleu1KYXo75cSkx0P3mFghine8DbKqsbSoh3PW4Zq427WZLjaaViDLQ8V5QXgr/qGwUY/cWDnoQ6//l9jyX2h2j5w8XbQOc8Nye3gwmE1OWDeIHOygueLEEbp7LDhprUtzyH+CU8H2zYZaAjdWuUwfrnXYL91PlsYwHewH1SEG5QtF4QrTv66LjZfnfywJ3aSo769G8uYcJjMWohtExZTbzoGRRjub5z1sudnMiWdnjePYIoMVeWMpbBlEgowqsPYhtLMEPbMEMjkawjiMdQeIzpO6nJIwbbLiGdmTrUd/3kXF2jc+UU6cA3AgTGDpVOI+Um1mHAGyNtTAVpgh5bB1jWnrLen9vowYLcdFxuWX+r+8bL6J98EaKjxJnIIUyeOkHkwsw25mCPwamqR2WBzuJF7B1xH+g5WHBz6huWnz//L72bnsR48TUiXeIw3/9t7D1cLN04KblUsGSdTp/P6X/ZuObuDJFAQDvZLqWO0VoiryDebEobr4psDO89scMimZTsT7M9iR5Vs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87cbd0c2-1e8b-4bf9-3d01-08dce14f1a25
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 12:55:03.8835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I41gDsnN6P7PRuWl7jpCBL8lUWTn8FrA89b4adaQ2F72MhONKHY9giwgP9WOLn3gMGm0s5y6RGD2Ak/3J69lrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6116
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_10,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409300093
X-Proofpoint-GUID: Y5ZR2WFM07KIjUmYJpluTBlQOrUnmfYR
X-Proofpoint-ORIG-GUID: Y5ZR2WFM07KIjUmYJpluTBlQOrUnmfYR

Validate that an atomic write adheres to length/offset rules. Currently
we can only write a single FS block.

For an IOCB with IOCB_ATOMIC set to get as far as xfs_file_dio_write(),
FMODE_CAN_ATOMIC_WRITE will need to be set for the file; for this,
ATOMICWRITES flags would also need to be set for the inode.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 412b1d71b52b..fa6a44b88ecc 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -688,6 +688,13 @@ xfs_file_dio_write(
 	struct xfs_buftarg      *target = xfs_inode_buftarg(ip);
 	size_t			count = iov_iter_count(from);
 
+	if (iocb->ki_flags & IOCB_ATOMIC) {
+		if (count != ip->i_mount->m_sb.sb_blocksize)
+			return -EINVAL;
+		if (!generic_atomic_write_valid(iocb, from))
+			return -EINVAL;
+	}
+
 	/* direct I/O must be aligned to device logical sector size */
 	if ((iocb->ki_pos | count) & target->bt_logical_sectormask)
 		return -EINVAL;
-- 
2.31.1


