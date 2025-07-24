Return-Path: <linux-fsdevel+bounces-55931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAFCB1030B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 10:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F41C23B64ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 08:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399EA274FDB;
	Thu, 24 Jul 2025 08:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CY4AXXqQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="spgP6ff+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13603274B23;
	Thu, 24 Jul 2025 08:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753344778; cv=fail; b=fVbbASTMHH/1hjm8y4h5RIShcgeMpYoWzAHwtERIDyoAlcfPgntIPb2kL3xnTMrp/BNfiudH0Dcgu+H+6W2mwhnA6PvpfTrv2y0zHNBgB/whABVmCDQTFazL8K3EE1M+l9UcNdVougmyBod9hnTSTTzpO1mCM675MVQSQMUeFZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753344778; c=relaxed/simple;
	bh=xQWNenkyiOLhyYZH7o0KINx6UDNUk856xSDa5DITotc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EQXkoXaTY/TXv40zSXyugQ+/BhPXvrNVSF0NIjmtJS8bjbKr9AuPaCICTLDNNp3CILhbzTcvERHGxJ89LEc0qTYtpbgUXTAgYkLzrUJKQFbq/YloaMAeZiMs/7soXBWKQS1ErTX6Mr9gi0uRxuyrtSVxwm4v07gNKQOKO6B13Zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CY4AXXqQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=spgP6ff+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O6ukIM030721;
	Thu, 24 Jul 2025 08:12:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=xVQDAxQk6vDhayhbOTBkErCq+ReYNqcVAD/lg1BhNik=; b=
	CY4AXXqQ1jc28UhxdPMdVRgkSXr5ydhwYYkws2RFwgC2+/vwj3qCcCNPuHP3FlO7
	ezf2WNjp3Jev9wjnHQpR9gglSGd9/tEOHaJ5Ko6l6Um5pJ15ixJ8cKIAXp6pI6uW
	0L35BmHpn8ufbtLmIBL4HOEdMrlBcimdWKOPoBEIVaITAjIzzIjk+9mbv9Qz12v1
	5LH8QHZan/tGIoxlGaAmLKeuoJeFWgUQOophsRbhWN3yK3B3wfmCrlp5yhcChw62
	okkRyQuhU4y6huA4Yh9XtBJwyDPcHnKKFgfMtpN9jKimxsJkIYprrKllqFFn8DVL
	FqK+HXZUC5OTM1MTspsADg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 482cwhujhm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 08:12:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56O7swhu014382;
	Thu, 24 Jul 2025 08:12:43 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801thw53c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 08:12:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLXG0eOKwxeK60GM7mAW8vKcMbAHBpvBdzoDQyZz2bJ7qJVPzAAk84DGHhj2BwU+a6YAL02TDGJIZLwWvexZ0Nz2pyqzoKCLlx9PEZnjxg06xgI2xxEBjLSEubwnsjLusZ47u1fCzJhOd36+oDooRhhL85eOe9VnVGCqpzHCcBJLFeQMdwgKdf4+qpwcCxsjr3yLY5Ed4lyuZW6f6GgytwBDrPFGKp37FlZ5/7/lcRYAI5XpBMmOuhmaJ3Z2lShJT6DYj/6C0Kr9OclG3J3H8FStb7tYc7acwldLXJ9jSsSKVlboJn4CB7rBWylnjWoa6+R3k0U29mR9Oe7ij1tc1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVQDAxQk6vDhayhbOTBkErCq+ReYNqcVAD/lg1BhNik=;
 b=HhtJdUXoEujsVCUWfB7O5GFUfl6/MXk3SPCHIV9qQ9bwdbJERsk4jEe73ZbMQXfZJu0dvNWUTD8XEKVQw4hL/fi8lNPNU4ALDHoHt8ii5MejOSzklqcz+waNp5heliuyShjEcVTzLNe6TBoz1qynjWkQJvtYkgCswKPjLO3KnZ1Fmb7KU28ZW71TJvy+M3KbcRNoDaXzJQOps0d78sz83VigMrUTy8Us7ZXWGYKKzW+JbNGHWmn69Yga50ZIgjJ6sUEmXhBkvcQwbG/55aXsgb2Bzkzp/vG4vrLLOFlVemPda6LkDINJaZPslK8yfUbiovK5MVgezxkLFvXHZlIYdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVQDAxQk6vDhayhbOTBkErCq+ReYNqcVAD/lg1BhNik=;
 b=spgP6ff+iN7Arpyf5s1gofWFp6LMbiVsHn2FPYq198r2Cr2bIQJUQnId+ddUlKIjSl2gxbDWEuXg33/FoF6VBrGpG7kCcgiA43HYxkHaJj2OLgYza0kVqsq4IOnje6qXuHklZcsHLY2sF7lNQ1LLPiUHv+DZDFz1fFU+bp46/fw=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by SJ0PR10MB4815.namprd10.prod.outlook.com (2603:10b6:a03:2da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 08:12:40 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.8964.019; Thu, 24 Jul 2025
 08:12:40 +0000
From: John Garry <john.g.garry@oracle.com>
To: djwong@kernel.org, hch@lst.de, cem@kernel.org, dan.j.williams@intel.com,
        willy@infradead.org, jack@suse.cz, brauner@kernel.org,
        viro@zeniv.linux.org.uk
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 3/3] xfs: reject max_atomic_write mount option for no reflink
Date: Thu, 24 Jul 2025 08:12:15 +0000
Message-ID: <20250724081215.3943871-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250724081215.3943871-1-john.g.garry@oracle.com>
References: <20250724081215.3943871-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:510:174::19) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|SJ0PR10MB4815:EE_
X-MS-Office365-Filtering-Correlation-Id: 51d9ad04-245d-4653-4cad-08ddca89dbd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0Hhhza6gemqNxP+121F/viNooOf3HENp2DcHHs2kbnlYOuOxf+sbeWw9FfK0?=
 =?us-ascii?Q?tMUefknPiP6szYSwLEV7VWAZXCZ+ArAJsBCoYQU1h4DiINo/7VE24xnrxWA6?=
 =?us-ascii?Q?2qGjau2D8cc0EReXFKIELNY0XMVhaRogRIex7HCaADpuFCTWq6cI7hf/MwkK?=
 =?us-ascii?Q?ghYz6WbN0JvUvhhB2GIbdUfD5eiPbLYltScDaA2LfsXfVX99Hud14j0DNDCB?=
 =?us-ascii?Q?oPjSEHWmyItfy8RGUf4xxV9WLVwZH6QG9oON+j5/eQ2lMTSjtD/UYk9Xu8QS?=
 =?us-ascii?Q?+EpPvcjy01MMr6C9+40cf/8ETkQb2ruJ8BfYQQHLlWIAa9IvBkGz99owi3pG?=
 =?us-ascii?Q?b4qPyqJEvqVjiEkTak/4F5ZAOnsmWg+6A4m5hjcHqzYFjHy3DX16xlwhJor7?=
 =?us-ascii?Q?T90GVmNXiR+ViDBoa8a6zXfwWvrllV20AubSWPNY6rxv8ecCKgs2NGmn4bRF?=
 =?us-ascii?Q?9OevdKXSsmwpGiRL529azV1umeyufEH0m2zpRkfz63wqlm20YQ+7XsgNIFAq?=
 =?us-ascii?Q?TT3eORLTtCDyk+GJJZw+JIwXnRMdhseH7nZSgKa9IdHUkCIcV7C14dJYraLp?=
 =?us-ascii?Q?BeUEa7jgHYbhvPospEPejv0S6aPpv/47lDaqFV88AlFauTcFbiL+ura0ZXV1?=
 =?us-ascii?Q?NRYEXsxl94/knyXNPudmkZU345zOoVJ7cCFfIoJBxgqCA0X9QOfZ8FDzT6SR?=
 =?us-ascii?Q?UkJmsVjXhMV8IMXguQgrWrZNmiXjxEK+bnQtD1v6XVKKpVg+DIu2Z0sxpT/+?=
 =?us-ascii?Q?5NbzAOAAylMfJAYKzkI39vdp2kx23EDd2xHksV+VnnG1Dk8ItRwNtBkpYUeS?=
 =?us-ascii?Q?unPBQKI1da6d1eBS1zRcAKLriX+srDOkmong7an9+r9Vt+tyuFUgPzBY2Qkz?=
 =?us-ascii?Q?g5DA2Ixb2lDyZOs7aLGUqEtI6XGpH2fBnM9XHpjpotIYfpukRvFN/poun379?=
 =?us-ascii?Q?v/4sKEeYzbP4MuhawCF80aQT4qQ2oULt92Fw0JSiK/yzNh9i+Xw9+Gk18KON?=
 =?us-ascii?Q?oljaxrNfl4FfZqHLopEFz8uJo+gEgYFOGTHmCkRbjH7G6ssnUn56hSVs61Xn?=
 =?us-ascii?Q?UTj8NQEXGEqmvuadR1FfLGAkP+8RGs2CwEmAsjIHEiFagPBCRuBNOsMPs8q5?=
 =?us-ascii?Q?w5SFCVukjLbDUXDEDpI9GciFlVBTEqoXbo/I1Vquc+T6MuICWrVECE1XLXUm?=
 =?us-ascii?Q?JPnFNbr0qvbunRYIPPzKdrnVxeBXZLmboBNiFNv98VgC997NaMfLZZDFQTG0?=
 =?us-ascii?Q?6L1z7kd2buPKJrZzexeN33riv+nvUyyChPxDdEG2GAVNbO3UFDVL5b08B8JS?=
 =?us-ascii?Q?uyHgHpyLOIk+TLp5FwKblQYh3YdvcEyhXOAehI4/aHqJBd6EKdiov0VyTVEE?=
 =?us-ascii?Q?BINn8rGdgPeOhAv0D0CuRezCL93bHjqZxWf22f5wzxi6MvGSoRQyl1j42Xkn?=
 =?us-ascii?Q?KJGU/sY0K5I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aIyF7HtX3cV9vcv/L7Z0RJXZQ8rZJ+M0XBsmz+guChr5Dt9o5n60dVZleWs0?=
 =?us-ascii?Q?aBa1olFhIZuchrbyU27IBMs4Zy4DHmD51uylHhdsr6yq8QI8NQx1xqdr/P2/?=
 =?us-ascii?Q?xcwwjlypGAt/nYDLUQK/QoL0FcSvoYc1PjI0JZbYhvgJpoeL2lib3ZiLzYDn?=
 =?us-ascii?Q?FKmKEOv8Wa+bs+hltwSskL7fSpioJcqatKWF3Jou83DfRT+qsisYrEIcXRnk?=
 =?us-ascii?Q?qv2f7ylkKCR/EnndTifnjBtN9K2xfoUgTNzsSlevkiDTsoG5y66kYlg4AEVn?=
 =?us-ascii?Q?UoXNHzWlAiB/vm1tW+svbMxEhPC9f+iSwoLy+IcYDPFQMchf2YfOXXnrfj5z?=
 =?us-ascii?Q?a3QXk8PN43Bl37CNfSALaxrrUFZ6K1IAzF4XnRvPlS2o8R1Tb4ikeD9Rf3Te?=
 =?us-ascii?Q?iLE6+hyu36tSFNe1mO3DnIsWuVxXJqD4PijIjFI6vSYbuSjRHSq3xYHIvdlo?=
 =?us-ascii?Q?cQ1DgfqURPk2VPl54IDQ186xDU9ETCrmIQ04q7p+oj/eHm+23ILcb5JmYNf0?=
 =?us-ascii?Q?CLlwKJPLBY2Gp35+ivDHQRQrIpvAQdXo33ETxKfJlSqQOHpCGI274YN2HA5Y?=
 =?us-ascii?Q?6cb8XUSlnSrsiIxJBKtu88lxdEkao7KpK69StKrk/8p5twUZExg869CPtgKj?=
 =?us-ascii?Q?rIFCjr/XzXbkRid4cHvURUiY2oItBOZoYSSL56dq+rxh6A8AaU9YP99yCTGF?=
 =?us-ascii?Q?c4jZ9RKtXv/lnzAPvKkdzJVnazD1NpszqODCbHB7KzCdPcYybuNpkFHY36dy?=
 =?us-ascii?Q?GZ53orLYb9YuJddqvAwIotKBPUQKsy39JLFnBnpzt/Gzjs9YadFSUnDDNdQv?=
 =?us-ascii?Q?/pO//nAZ6rHgmN0D33Yn9hDnZorMGhta7vOAkMzzEo92SIVmXdAQ1/MX0Rp1?=
 =?us-ascii?Q?xprj0/wBYNsBNo8SdJvy2HGGUIgboAdszDLCkJVbSzkaV65QY+Izh5OaAaje?=
 =?us-ascii?Q?EEsp22OH4CZhiUTfAV7sMSLPxloZ9vM/yB/mmiz9JQXIsdIxqu1gFmwI38dO?=
 =?us-ascii?Q?9Y799MzFpe+2gbQas7YZ4jBCT7Ra0KDjPJbd6Nf5BrU8sM0jKFnmNTPmd0Y5?=
 =?us-ascii?Q?kEHq5XMmPkpe4XefPpPVAJ/QEs1FrIHRUNTnN1xcJzxY0OG9siQ/TSnoOpU1?=
 =?us-ascii?Q?PWqvm3LgM8ittYemkZBn325fgNEjA2hym1Fdc/9NX4KzrIUiRiBM7QWzae88?=
 =?us-ascii?Q?h/FaLBbjY53M9oSs0MxlRLb9ylnZl4I7BoLyOTC4x7JEcYzO/DZalz++f502?=
 =?us-ascii?Q?C3aqjNekFIG9fL+agG6PNwONC8JFxX6kBAwCePz5bB/lTf9YoYesla9F+P1K?=
 =?us-ascii?Q?NAl2mhuBVLT1YbW8AY6Gn1uWvahk5bSiioz2zwh7OKJED7F/WSyqOaXa/s9r?=
 =?us-ascii?Q?8nhHSOkjepta/hvTOm0HsQVogOvnsmuZwk3LeqvS4OR+3yrnDZbfFxq4ocxL?=
 =?us-ascii?Q?0YJq3bgGvq3BRNc3GwAyJQjhHd94Iewi++09Q4icvgnm9cVuow6If8f1U+GC?=
 =?us-ascii?Q?89rFruWetkl/YgzD87OmUt6Ma+QrNnSqfTs2NqFJCYDqG2xPDoByIFbspWZQ?=
 =?us-ascii?Q?AG6p0xjR1WSwhdcIopi2uNrj3MfGGPrO4IZy09mu7WqyYGSE6jBKC0Kfjc+o?=
 =?us-ascii?Q?IQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sHcmZrK3uPbKA1ID/8Sp6Q+F7obyQ9Xr6xC4bEdrBJ7ElrJY8JlKCCUQst+f8csItf+qk9hZX+L9SeXl5ALakdQ+huLUhpZabpebnPEYG4QtTnfr2KH+00qa9qQ1rNYuk7rs++AXI+FipM4L4DizbjEJVNWiA860WvOTjv+GWX8MDd5MrpRMvvaD+VyLq5Ifb5rQyilI6cTwKw6HItHxxSms7evWm8qdunLc2YBeq/fNsSSGiS8KXMJgCr+0z9j9xPeXkCSIYJcQLfjQ9z/mrNO7F2yR3tWqYGYzSLyDpdvMN07HTfzrr2WWKDr0mSHrPqps8hB0k/0Mqgjg60sX6RM6IAj2opPbIJj3HnETie6lZKZiGxe/ElO2TjT0kTytobiLy+aQDwvQFOgdDRTkIvOmvFdfT/5OHbAU+EZ9Su/ebrJWpiTzLeZACnz4h19QTiNW11Ypa9R8WEmXV0N6nBnAppoq9NodGXoj74w9nkU7EtwAV2gtj8T0KAMb2Amv1i7TTx+ONhIRIbGj1QU2w9VIZ5o9spc9CV7ALEhFpOlCkD7xpuMTadLMN0ZBfuPRW8aASwxsDDyL8VVm4uPzFIPKWvxp4M+dIV0o3H5a0dU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d9ad04-245d-4653-4cad-08ddca89dbd5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 08:12:40.5568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y+oHT0PohPPYOwMJVSi3zP6wLQPU3KQXnwAe9KZARfxF+Yr2a071n/7xsw1/NPen0jxREXS9+x5281Z7veZZ7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4815
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_01,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507240058
X-Proofpoint-GUID: 51o-2ZTNwQUCZhb0CST_BVG6CE1mnV2r
X-Proofpoint-ORIG-GUID: 51o-2ZTNwQUCZhb0CST_BVG6CE1mnV2r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA1OCBTYWx0ZWRfX7IaH59+nCa8M
 K12K6uX4KwgNcZU7pkCANZ3Zgw97yOBouarWdHODmOiqqWch3XuttsTxlqxMBiNxYdplNouMlk4
 +gWfmXuMFjKg7vkWUBqn0hwFfar0ub/v9To567kdLEz9I26dIhsyELquIdAV7FbxUC5RG9tLQX8
 wf5t1ZqdwdYR0nYnNPJHbZULf+wwAAHwrC7hfDgM4i3S07UXaYB2iUEinC8BX3qww5UK9rgJraJ
 RCwaofE5xyJzz6mu6VWQePnt/flX42nZjvjP4QFMPInbOLImW/3dIXZVUTQgR3s6B+o3nN2k3YM
 KiBR6YSGzRfF5fWhTHhnFHU42LK2PWDzYKXU2E9tXPCcOqBhPP90ZQjMo5tAgaqSuO9gfbfUGyO
 2cY8gSOXVcyhDo09qLPlIvqGXbHtJfOoL1vGNZNVaegeoOmwt2FCSJc2AfaaUze5YDkoGmH6
X-Authority-Analysis: v=2.4 cv=IPoCChvG c=1 sm=1 tr=0 ts=6881eafc b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8
 a=qHfuuy2_jPFloYaPpNEA:9 cc=ntf awl=host:12061

If the FS has no reflink, then atomic writes greater than 1x block are not
supported. As such, for no reflink it is pointless to accept setting
max_atomic_write when it cannot be supported, so reject max_atomic_write
mount option in this case.

It could be still possible to accept max_atomic_write option of size 1x
block if HW atomics are supported, so check for this specifically.

Fixes: 4528b9052731 ("xfs: allow sysadmins to specify a maximum atomic write limit at mount time")
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_mount.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index 0b690bc119d7..1ec70f4e57b4 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -784,6 +784,25 @@ xfs_set_max_atomic_write_opt(
 		return -EINVAL;
 	}
 
+	if (xfs_has_reflink(mp))
+		goto set_limit;
+
+	if (new_max_fsbs == 1) {
+		if (mp->m_ddev_targp->bt_awu_max ||
+		    (mp->m_rtdev_targp && mp->m_rtdev_targp->bt_awu_max)) {
+		} else {
+			xfs_warn(mp,
+ "cannot support atomic writes of size %lluk with no reflink or HW support",
+				new_max_bytes >> 10);
+			return -EINVAL;
+		}
+	} else {
+		xfs_warn(mp,
+ "cannot support atomic writes of size %lluk with no reflink support",
+				new_max_bytes >> 10);
+		return -EINVAL;
+	}
+
 set_limit:
 	error = xfs_calc_atomic_write_reservation(mp, new_max_fsbs);
 	if (error) {
-- 
2.43.5


