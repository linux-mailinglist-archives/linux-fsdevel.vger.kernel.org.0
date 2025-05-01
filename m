Return-Path: <linux-fsdevel+bounces-47841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B856DAA61C7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 19:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBB6B1BC303F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 17:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0700A224B0E;
	Thu,  1 May 2025 16:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gwXcu5/i";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Qam8CiYd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300E5214812;
	Thu,  1 May 2025 16:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746118726; cv=fail; b=GeuPsslHR0EfS6fKR3ynooOOwVP3O1w168XmDGFPfRT5vywydDVUwGEQNZO+RHA1GPsanwtGh6v378E76Diqoxg+y4+VnblTN3WEuVf4tlEeqeVyqeobjvX09UbMS1SNpfM0i0gBiogoTPTLhzOHSGSPQeouTdPP1uzN+LIBS+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746118726; c=relaxed/simple;
	bh=zin1cGnHDBDRrW3jNLQStqqddLgWyLLs2LbDahuY/MQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uHFIECH6xTZUmJgar8u69ds5nXeuPfGJVTm+fshTECdzzO/zOoNYPOkr9OL5VeGNLXX2/+t4cnPTsrW9xqLKz73ESEfAT5EOLq/k57Y9TKIU17eRapPDS7TrA3UEGaF2l2C7Mo9AYT0oYoR6z/5NuzWiIstYfzZqMq6B3b6jha8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gwXcu5/i; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Qam8CiYd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541GjxbQ019717;
	Thu, 1 May 2025 16:58:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=srLclYblBb9JiBMt5Z335oUdMAMav4Fb0kt3AvrsdFQ=; b=
	gwXcu5/iV2tbKXvqFnewzajSdgciw0s6cj/HoGJFPp1re/JpUY+llOp6kBq0lxOj
	pUhx+aK9uuRt1k4qRInAOM9XSHDnypnEQ7iJrdGT/TpYhv+aIZu/ao6yyZTPvk3V
	hq08Mwh3ptDpXkGym6eKNKxL2HSjygwQ5L/GT94SgYEz5e/g+/DAbokj7RFiz/gv
	LRM5WIVWV077DFlGOwIzDxP/SvGGhxPiJr92HT3kIGMgfQfMBsXH5qR1Z0M5waRS
	yIk6f41kH+rda1ArlxS9IGd98cTwlA4Y/W4aSwUKLXh3VDqjitkgLlOmn5f7o9L9
	VggjicP4FCpQVUS7WqO1Yw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6umbemx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 16:58:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 541FbSq5035440;
	Thu, 1 May 2025 16:58:31 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nxchjk1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 16:58:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ns/EG6XQOFSHgT7nde/jgfNdvsYKfCR3LvK3qFCcVvqKxUyIjt93QOvxaT4ltDL6d8Q6aK2l9CsRnPV2DT6N+AZb2YasGDK2jSlb/z3J20mSlu2zaUvz2R0gNUZfJlburu0VtyYwyGjwuFJ9xfU/mRmMele9TnNC+C3r6Tnp/RUBG+qAEt2Zuq6xp5d3kJEQoTs4M4IqVbEemMCBHMgDiL35mAVZw29rPKuB88BmajSJ0OQDcDY+NCvtVB1zhbh0fcAiIiGk8l+y/vnjNJi3pfafozjr7bKEFpJ4S+p5NEFQF6fXp25RYlDiSFsdqGjHDD7HO3G7j52V9CoOT82UXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srLclYblBb9JiBMt5Z335oUdMAMav4Fb0kt3AvrsdFQ=;
 b=K3pF9CsVqcLUDZ/8gRStmHXP2g6xJYPYXvzH/ti9eh5vaZ213E2pRcZbwZBSagMCCx6EBYHhmuzej2Xb5G9A8q1l2RiQxX9Lkoi93u8bBdT3rCDHs+lkpbRocN/Bv9mvpO5m2MfmtWn75xUXODDPUzQPfcEBuZMe4LfNvgG4TzLvhpSygev+p95j8yJ300jBR1QM0aO7RSqhCefvf12r13jHl07tL1WztVHx3NDK33gm3TS8dBxQS3Nl3VXYGvETSDNyEWMf34+Grqvz4P5sH2zXxFXrgUWUO2O9QNTD9/3fQLwZFWZG0HefjcTfoXu0jB/d/2nfHcqQ5nDKiy2/Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srLclYblBb9JiBMt5Z335oUdMAMav4Fb0kt3AvrsdFQ=;
 b=Qam8CiYdTthqYtxg7ldaWLTvr2BAzTgmUhaXkLywPOfWEYw+pwJOmuHwk1Dsr8CXhPqiPhx/wosW/NxSbZuGkh2HnEXe53zYVgTpS8mw4GEHi4EG+Xcc3+Crpf8q0VoYYiQfRCing6PMIGzDIp6UPRGW1+Wf6u4/7ML6e2oMFGM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Thu, 1 May
 2025 16:58:05 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Thu, 1 May 2025
 16:58:05 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v10 12/15] xfs: add xfs_file_dio_write_atomic()
Date: Thu,  1 May 2025 16:57:30 +0000
Message-Id: <20250501165733.1025207-13-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250501165733.1025207-1-john.g.garry@oracle.com>
References: <20250501165733.1025207-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0329.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::34) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH8PR10MB6290:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a8e45d5-d5da-4490-1ee3-08dd88d15720
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PSPfcWoev21DFiLSfl0UBie1lRd7SGwGHq8Wy1TPBK9QaeWqq1kYCjTd255i?=
 =?us-ascii?Q?zjw80mbUufJ/uY8DwbnD+xmoGQh83p+MLVHws95azhMlBz36tqQwr2SRLJ8G?=
 =?us-ascii?Q?KBz9DAst002z0seEhXjdqwdDKyZ4XAq3QX4croqIAWknesK4S7CAqUU0t/Y/?=
 =?us-ascii?Q?L18FYkXVB+qzGjTk0WqyrSrRNcTDaq2v7Pb55Tu+BmXEn+Ugyv2dAS8pGkpu?=
 =?us-ascii?Q?6v9TW7BWPr+V192+v523uww2Vp+8mx4OxdYyxe6FNZAZqvW4N8YeAEKme/c7?=
 =?us-ascii?Q?Hz6Qj9kIVzM4fCo9+imZShYWBa3N5Q7qjVWIivd59YD0Bu/UWWvmjAk9X4ZX?=
 =?us-ascii?Q?zjW9PExO5F2gyuEULjS2PRRwlK01JZoLjJOs50bIgk/R3JcslZryiTJYbFsg?=
 =?us-ascii?Q?OGKGrGa5nsXGWNoFL0c7uY4a0W6F8AVWWkBVN12anF69lJHo8DvtW5H103h9?=
 =?us-ascii?Q?JwRLMp5GtdbJRZ4duWRkTNf+ABmXYP+byRuRtVx5zX4KLbusD757uPUkCc6m?=
 =?us-ascii?Q?KuPQurlAsSgB7YO7hBgeZhTgzD2GR+VYmvwD1xP+I4+f5Rtf1otwC/1SwL0H?=
 =?us-ascii?Q?kZN4fE/+ZVSZmdE7gzGC6WB7FZhgm412aNiafCgFB5mtUiCR02y1Rd66bhC6?=
 =?us-ascii?Q?ejmtBYeBttRnndm0SXZnhBTnf0ryKvPKRxiHZ62cSKDAaqVi5q4i9YndoBDq?=
 =?us-ascii?Q?AtDRd+PzAJUJNN+JO/uiOUcyjGt5078zbAVF9s8SGeKQPj2yCOItFvnkbcEw?=
 =?us-ascii?Q?tSsqCHvgWAEic0ZCaSPk5ojNcFVubKJXSVMXEZWYtVN1mpC3igROZDIwQZTw?=
 =?us-ascii?Q?ZvxCz5ufC0r+M/ck/BzMBI11JXyCj0Q+siq8zBKnhG8sfB2V3nlKkqj8JlaD?=
 =?us-ascii?Q?uQt+CiFT7yAyg9HsGL/R8Zbv29ixGnZMHCu/rN49HRBS8ynYKRrfzQ1UBKHi?=
 =?us-ascii?Q?Apw082PQw+vMmKtgo9nOmA1H7FTeEWi/WIuKbeTTg0FfjwcK2cqrNIISgFO6?=
 =?us-ascii?Q?mqSuParOGkgpkAraLLNzNljYb2Gw3pV0hm+6YHVee1/uldEnXYvI/B1ypHs/?=
 =?us-ascii?Q?BE10LSfR9wpWSR/ocsZfmY0O9oO49Bf4an+aL5TE/ByfNVDe5PBkG8WhjdwV?=
 =?us-ascii?Q?lMJtIZt2jYnvCXd/F55cKYZwnhhH7KCwkDYAJZAVG1NtTHkClG3OuiicMgj+?=
 =?us-ascii?Q?Y5Re7t3qIvu4Riop5cHyc8lhnIodjeV06g20LAK75HogRuhoSxkLQw/NO27g?=
 =?us-ascii?Q?h8gw/g8sjtEDo87xtEbYcBbYLNZAiRrrDYGaPH1eHGd4ODNdsZrUvOUq4muc?=
 =?us-ascii?Q?PMq/S3A+AVa+pTsoia73BO/R3DPxGt/LBb+FzFFG735wsnvfqFF560bs1Nnl?=
 =?us-ascii?Q?v21Ewupq7trL3MZ+F2LvT8GFq5heOt9RIhiwwCe7Ys657Tgmtg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gji4aDM4oab+3+IFApB/4AGBBM+Cv5DytaxyLSJkTiXZo/jqO1iKgkfiRRdk?=
 =?us-ascii?Q?UxsZZ7iv7MnEdegF3vQUF4XIpLNHvxP68QFM3bqvCEAJyaZjZ4bu9MuDnQ1t?=
 =?us-ascii?Q?bT17gtGYU4+BTDdA+kireeZk+MEX+/6dnUr85uT5UqugZvRAEekOxUXzhTuI?=
 =?us-ascii?Q?X+qI8dI6AX0j+ygZDDgY99Bzzzh1xPHJeE9hW68UC9EQtkMNk2j5MTqjeA/B?=
 =?us-ascii?Q?83uBVIRWtor7HyN7HKOAWWix92xsG8iV5lydju324krkYREURq6xLgzhUdKq?=
 =?us-ascii?Q?bdAXwjqZmDjEen7R27m7hHkTsnPS8J7o0WsYxRzt2Y0O36VV8rPUWICKHfgN?=
 =?us-ascii?Q?hTCwIjChzy8twTXc6ZJ2hVaFEg8A+AfoXcJDmnnX+s+G4MVMOgiSxB7YYAjk?=
 =?us-ascii?Q?y2AEuK21LxTmp091uOIhXtK5RrsD5MyW0PYpueu+dp3Sz6muy8cda/6BEv22?=
 =?us-ascii?Q?P6WIK/U6SKQOvMf1gq2U3pBWiR3MFLQGhKgFoTQMvkRLaAT5PTQuM/VzXKJI?=
 =?us-ascii?Q?bbau5O8fy0P+2WpBdvpeca0Op2Z3A5QiL5E2Ae7TxnyQ4Fpx21TKkgQ/ryjh?=
 =?us-ascii?Q?ujUSAt06CcjUEwbCDimmjeOVQYXM7kjZ2+WOhPorWvBw1uJOMduEWnxTL3cm?=
 =?us-ascii?Q?Cm750rqtrQoabP+8NQ97yw5Xvn5Gh8qvj8sieo7szJNBJHY5iNLlRyUMKmcs?=
 =?us-ascii?Q?Ab58n6ZjD+JGxNdth7MaxNGOVOsPOecmaghN4N+nkEMolQNCoYFuNxajrA+k?=
 =?us-ascii?Q?JVgwPYeGqAcGDMCCuJNJk/2PsWf/GYjDMDUpF6LMT6iW96S7+kUrWErekdn8?=
 =?us-ascii?Q?TkygiHt1S7eg4xsi5H3HHbONs0cgB29w9VUmBBSQ3HjtkQBdlh78R96HKW+m?=
 =?us-ascii?Q?x9/tl+Op4UaixMG+sDqayplnbkV3pqzZnfPd13hrmoFs6LM+cIXAByaLlpiP?=
 =?us-ascii?Q?qDQrxt1vVbSWv1qigUG9x9QQBSq1rZ4i+WNnYlKctcKTgY5pNw1xBYuN9KX2?=
 =?us-ascii?Q?bSBGzuuaJtQN9S8qJbLIzwaZ6bxMXYDQV6q8fPvHB7d7T37CUDl1nDESxw+X?=
 =?us-ascii?Q?B9bqQKJGOR+Un1E49ZWDXXHL7NPgAjGRcSLF7vLOx35Kz+vD/jIbn+RW2vXr?=
 =?us-ascii?Q?TSEz1dETtXEhRFNj6QlT4ZbRrTX8K8FWL300slgfMqC8dsQC/q+iU1jPT/vx?=
 =?us-ascii?Q?jbxZANJHKCZOl0qnr9jbwPEvi+cG5OwyvZdv1vt5eb7iAO1tbw+JQtDpmxxS?=
 =?us-ascii?Q?mR7kSPXF73cKIMAe9P9S6fPquDxM4rD1hYeqzG92D39tSg+C6U0Oa0ArDco4?=
 =?us-ascii?Q?AnjfSmCCw/spmZwH217ifMZdDpdEGXdTEjImV/1wxJ/uZRfYlDfczVAnnMgf?=
 =?us-ascii?Q?fqwJKZalfwuhMEaEYO68jAdUDXYsLhLbmAeO/MAuZ5kINIAxxvP+hXOaldIr?=
 =?us-ascii?Q?Zkqjl+4ipwO1qgNO9rsGrAFKVuhxdIeMKe01qZYtKWfwCro93IraW0Cv6s4t?=
 =?us-ascii?Q?kJpOKbUmZNkbJtOgmUjVEmKtCd6Kh7540dKF5kLXofx5lLTHbepwZF1vTcBs?=
 =?us-ascii?Q?XS2gzoA14C1pPJA7AQrMQqpy37GdbcUcGn1GaKxcsOpCbX/5Vv+WONjesHIr?=
 =?us-ascii?Q?Lg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nq4aUx3g9PitOutRVcS4rWPefWwhkdFF5KcSVZZMGIEU4EUIJsepsEdyyy/LqQthA3DNrqJik+/kbmkmbFnm5TaYChfvjeOiIES2RJ4za/Xd46vsNfcEotLl2T8jryZ0QkqNjLM4F2WWSxE1JSjt+dryMVljRFgOduHDAhTiyo6hGOW6T+noSkaW8Ev86N6Ai3ckR3nfqjMQYTTdvP53kK6mLQbCvvo7gtBpy5kcJm336HA50enTpE53kH6Cl1vUvgWVAsPM1ZsdZ6eb4nMK2zZUmPphYMaFSqJ9Ktwl+DzlMNJ2z1Hu6KZPaalXP3unQZL031oydobTIgbxiq1xDiKiNod8QI/UpTWbFQ7mXWKoxIAotIT0otUVNXP5xkPiv1qe2orwIeP6QV6b0rqJjCRXSaV3+Mk6+QPb/caNTrMKUzJdcl5EFeapxEzwSXgS07fOAaSv6soJ5FyEs+OBFIG4heMDKyWxRNGhsjj5EqyoCtgLKLiHuYl4P3i0Lr59d7ALkQnzz0HwBTVVC87kKlT0iu6T94MmXTWUkD0ltifDnOmkPVa6aLsSRKUzCvvIhHeae2CYCAHfGK8A71GiB9rSaL4VE2Do8aU9jy5pSZs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8e45d5-d5da-4490-1ee3-08dd88d15720
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 16:58:04.9608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b5KotZ4e2ZmDtTTGS6Me7prU07ebGDeLDmB5AkPatLnmRspqvuZzW9679VE6/GBVDNxVdrA0T8X4ZmBEeQJ2Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6290
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505010129
X-Authority-Analysis: v=2.4 cv=dfSA3WXe c=1 sm=1 tr=0 ts=6813a838 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=Y8Big0Z5EXcV7lnze7oA:9 cc=ntf awl=host:14638
X-Proofpoint-GUID: OZVeK7uh8f4Aopwb0KNRoI1LZ5eMAt3R
X-Proofpoint-ORIG-GUID: OZVeK7uh8f4Aopwb0KNRoI1LZ5eMAt3R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDEyOSBTYWx0ZWRfX+GOn0BO4axmS 92fn53y5HgQamVgWisVy3zyX2fWH7fzIVpH4ze1P5/4bDhq7J7eoYnhlUpMn/WYipN/iDXmSVHf 68gJc6WxRcw1AggNk54aYNtSbcqQXpR3qQ1xkSkaNG8/uitWW28xYOcr2XQYPSwfwIyHGPGnpoa
 Np2oLclF2h88RjXvBKsMNx+I7PZS2JoEjoIW5DJDU4B7wLXdZnWpA586ITZIrJsTbUzMYSw9CkT Ji11CsE/tObaQBiVVfLU1gFfo9crN3+fN+wR42o8GlQkmNFLSXXbnxNSn4K9u3xfN8eh8jgvfrk FTXPgW00Ij4TxJk0t5dTB38EAxdA3n7UrFQ13+wvvBsSjYXEObJf5iI0xrHrTflHoUtDYN+aqnS
 Fube7mFIShr+L8VbV5uDKTLgK8Ma+08dV8vvqEY9noa0/b0P50S+UIRev8cMB4mf27JiWEwP

Add xfs_file_dio_write_atomic() for dedicated handling of atomic writes.

Now HW offload will not be required to support atomic writes and is
an optional feature.

CoW-based atomic writes will be supported with out-of-places write and
atomic extent remapping.

Either mode of operation may be used for an atomic write, depending on the
circumstances.

The preferred method is HW offload as it will be faster. If HW offload is
not available then we always use the CoW-based method.  If HW offload is
available but not possible to use, then again we use the CoW-based method.

If available, HW offload would not be possible for the write length
exceeding the HW offload limit, the write spanning multiple extents,
unaligned disk blocks, etc.

Apart from the write exceeding the HW offload limit, other conditions for
HW offload usage can only be detected in the iomap handling for the write.
As such, we use a fallback method to issue the write if we detect in the
->iomap_begin() handler that HW offload is not possible. Special code
-ENOPROTOOPT is returned from ->iomap_begin() to inform that HW offload is
not possible.

In other words, atomic writes are supported on any filesystem that can
perform out of place write remapping atomically (i.e. reflink) up to
some fairly large size.  If the conditions are right (a single correctly
aligned overwrite mapping) then the filesystem will use any available
hardware support to avoid the filesystem metadata updates.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 32883ec8ca2e..f4a66ff85748 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -728,6 +728,72 @@ xfs_file_dio_write_zoned(
 	return ret;
 }
 
+/*
+ * Handle block atomic writes
+ *
+ * Two methods of atomic writes are supported:
+ * - REQ_ATOMIC-based, which would typically use some form of HW offload in the
+ *   disk
+ * - COW-based, which uses a COW fork as a staging extent for data updates
+ *   before atomically updating extent mappings for the range being written
+ *
+ */
+static noinline ssize_t
+xfs_file_dio_write_atomic(
+	struct xfs_inode	*ip,
+	struct kiocb		*iocb,
+	struct iov_iter		*from)
+{
+	unsigned int		iolock = XFS_IOLOCK_SHARED;
+	ssize_t			ret, ocount = iov_iter_count(from);
+	const struct iomap_ops	*dops;
+
+	/*
+	 * HW offload should be faster, so try that first if it is already
+	 * known that the write length is not too large.
+	 */
+	if (ocount > xfs_inode_buftarg(ip)->bt_bdev_awu_max)
+		dops = &xfs_atomic_write_cow_iomap_ops;
+	else
+		dops = &xfs_direct_write_iomap_ops;
+
+retry:
+	ret = xfs_ilock_iocb_for_write(iocb, &iolock);
+	if (ret)
+		return ret;
+
+	ret = xfs_file_write_checks(iocb, from, &iolock, NULL);
+	if (ret)
+		goto out_unlock;
+
+	/* Demote similar to xfs_file_dio_write_aligned() */
+	if (iolock == XFS_IOLOCK_EXCL) {
+		xfs_ilock_demote(ip, XFS_IOLOCK_EXCL);
+		iolock = XFS_IOLOCK_SHARED;
+	}
+
+	trace_xfs_file_direct_write(iocb, from);
+	ret = iomap_dio_rw(iocb, from, dops, &xfs_dio_write_ops,
+			0, NULL, 0);
+
+	/*
+	 * The retry mechanism is based on the ->iomap_begin method returning
+	 * -ENOPROTOOPT, which would be when the REQ_ATOMIC-based write is not
+	 * possible. The REQ_ATOMIC-based method typically not be possible if
+	 * the write spans multiple extents or the disk blocks are misaligned.
+	 */
+	if (ret == -ENOPROTOOPT && dops == &xfs_direct_write_iomap_ops) {
+		xfs_iunlock(ip, iolock);
+		dops = &xfs_atomic_write_cow_iomap_ops;
+		goto retry;
+	}
+
+out_unlock:
+	if (iolock)
+		xfs_iunlock(ip, iolock);
+	return ret;
+}
+
 /*
  * Handle block unaligned direct I/O writes
  *
@@ -843,6 +909,8 @@ xfs_file_dio_write(
 		return xfs_file_dio_write_unaligned(ip, iocb, from);
 	if (xfs_is_zoned_inode(ip))
 		return xfs_file_dio_write_zoned(ip, iocb, from);
+	if (iocb->ki_flags & IOCB_ATOMIC)
+		return xfs_file_dio_write_atomic(ip, iocb, from);
 	return xfs_file_dio_write_aligned(ip, iocb, from,
 			&xfs_direct_write_iomap_ops, &xfs_dio_write_ops, NULL);
 }
-- 
2.31.1


