Return-Path: <linux-fsdevel+bounces-30500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FB598BD68
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 15:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7C4F1C23AF5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 13:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2471C3F0C;
	Tue,  1 Oct 2024 13:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SvBfY+jE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DB+gsiSr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95361C2DD6;
	Tue,  1 Oct 2024 13:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727788989; cv=fail; b=ogSWVJgVLEkDRIVPAUteEGUucquEMm7jrqEafAP5meQIV2CyLdmcC0PhZnBlaY5RldqErKHJm9tBXHYLt4wG4NotXcySaujbxr3TpNqG0wHIVlEUxO0xcplZapwvZZWWaWqzZCG/IypCOI7tRR/PNrOODYmfr2oHiMPsowu640M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727788989; c=relaxed/simple;
	bh=kDtDOKIfetDC4RtJkBw7z6DzRG1y7hY4Bb/45rusS44=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nDz3LgmjJoxACFRyZ8HQhMMJBOGLhJ4xqb61Ra1u+G4IcRqAd2IKQ6wYAkaZ+KyNG73unl+K2MoHuxdyMS8+b3BCH6GuNPqJui6hPmUoVzKVV5lKYzvF8Bw3oxNrNvFju7stO/StqU2XRyWY5F3ux58d6RWdAxWFdNMzBbDE0RY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SvBfY+jE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DB+gsiSr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491D5a1G025631;
	Tue, 1 Oct 2024 13:22:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=FvcJFrj1SEmQVQzz6y6b1Seb51DId/gotYqDGi+i0KY=; b=
	SvBfY+jEYVpttZPhw996nNKqdHpLNinUiOSiX+tDTp0awtqTeSB1kwWowslhPDXD
	JN2Q9RFaizrDjolDfUdD20dON5ouN+PiiM84RHP3ELgF9j+jzkoxWL8BOX4xBG+a
	5Syyqcp1/2XknP+M3beSLB6ki28SedMaG6CKcQGmXOKnpPdUmp2/3WYBwt/hHdLm
	2XWFrXrRZSfEGgtNkFr5UKUiqBFobJgbQ137QZPJ81ZwLI3/Qqd2GutHC1GrfoXQ
	5Cuj8vKwnstmfv6csD5tQIGbD52cl/gxSGCv7TpqMrys0kuxBwNl3H/0DDsPdza+
	walM2QGliRMYBCjMI0a5Vw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8d1e7r9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 13:22:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 491ChVE7017372;
	Tue, 1 Oct 2024 13:22:35 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x887gesw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 13:22:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RfswBkATd3Gq13pJ/4kZ9PZI8w1ea1pequBVutFfVfMGz7N8pcuv+6C5RbMRd4J21d1031Ui4o8cxmwHn47h8RyEy6iD9wb9jo+vhddm3tSlv1S+h6QVc6I8y/NgZmiSbZMVPqh0r4jby7pYBy/B8PLyFv+5QPHvb2znxJRyRhMOQJjGisR4YOLQwXumUdSAa2igNVv5p2VkZRIhpI/Mq/VQXF4MHgoKR5suOdVOSKVyoum4WfVMVE2J4kWOHbYVTw2kThOnaPl0UM8wLQSwYXb4VPMwh5MYAvu7jmsubdGUMkmbjyVQd50jHDD4J4HoDpfxdev/n3h3f+M0uweBVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FvcJFrj1SEmQVQzz6y6b1Seb51DId/gotYqDGi+i0KY=;
 b=U3eai5GlUOFj6AhZr2ZfG8GG617YtX1NeCNdpiPXZHZnziKuEsKGi4uo7Sm+qchEWQIOFQlHXLXUp0HLAhkpzCNbmgQwjENdO2cz7D0z+jurnVzZPm2OLy4MgkBAAIVmS75NBTo9TObjgtV6XiBlKrBChBmHti8DMRagcaCPPYRLwveaUsOAEbvwj8GsAYUQdXmBRvcDrBQKh4Ud730zIfP3Pt7xiMhNDSnaQ+yi4BfoHTrQ8oPkkf3HdTjKfu384wBhsBeTQOJ3SgpkKnbex3hCG/4hzRqu1bYFeYH8FKrkYqBEuiGADHkH9TuwXgPGiqv9kIYaxyt+5kx3UsjQPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvcJFrj1SEmQVQzz6y6b1Seb51DId/gotYqDGi+i0KY=;
 b=DB+gsiSrB1iZ82dnHAb0Daqzx6ZuuokE9TriJqqDCtFh2YbgPfzQo+9EtgHlnkGaZyKjZFwdWj/dpo0YM6vO5+4Mnnskcr+vuF5T5XmRzmREw40YSLvvABZhsBmgc3Rvdw65ZIRU/eGGS3TGTFX3eAzkSnkyXBLIl+5q75GogPg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB6301.namprd10.prod.outlook.com (2603:10b6:a03:44d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.14; Tue, 1 Oct
 2024 13:22:28 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.8026.005; Tue, 1 Oct 2024
 13:22:28 +0000
Message-ID: <7fa598f5-3920-4b13-9d15-49337688713f@oracle.com>
Date: Tue, 1 Oct 2024 14:22:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/7] xfs: Validate atomic writes
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: axboe@kernel.dk, brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
        dchinner@redhat.com, hch@lst.de, cem@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com
References: <20240930125438.2501050-1-john.g.garry@oracle.com>
 <20240930125438.2501050-7-john.g.garry@oracle.com>
 <20240930164116.GP21853@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240930164116.GP21853@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0162.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::29) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: 12f87ba2-e074-4249-b309-08dce21c18c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEFXQjRDYWdEQ0RodXE5Uy9RSHZsYUVvZytVWWV6eDQxRCt6eUhlOVVic29s?=
 =?utf-8?B?WUsxQ2ViVGJ2SUxQSWFqSUdZWUk2dGc1TmpxVXI5L3F5aGFrd3dYb3Blc1dW?=
 =?utf-8?B?cXdEYitpSmRhZHV3THVVSDg2QmRyaDVkdTJXdjc3N01MemwzYm5PMG5Md2J5?=
 =?utf-8?B?bkhSZ0NianBMOFRBMTJGSjVuUDRPVmErUmhZSnVXN291ZkFsbTIwV1FBRXBR?=
 =?utf-8?B?STUyM2Rrb0UrZnUwb3NuZk5RWjh6TWZGenQra3AxQVp5ZlA4Z1hIeitGTmFV?=
 =?utf-8?B?b09iTkpPS0pjdERzak15ejI0QWFWUlY4MWc4UC9RUkhTN1F2STdKZEdMeW9R?=
 =?utf-8?B?WHVwRjlGYU0rbW5KOURLSU82dlZhdk9rTnN2YWYvN0wySlkxTTlVdHJ6T1g1?=
 =?utf-8?B?ZGthN3pYWnYxT0dtK1p4N0FTOWpLK05mQkFXMkhzM1c5V0RVQWpleVRUcjds?=
 =?utf-8?B?NkxPZHQrMTdOaGtDN3lFbnRETmlia1hDbDRwdXM4MnBucTNsblBEVDdhVkhP?=
 =?utf-8?B?NURML25RcHF0NVNyZjJhRysybFlnRFNCOFRwQ0RXVFBaKzlnZTFheXBLRm1H?=
 =?utf-8?B?VXFHVVNyLzNybENNMVJobUZmamxlSC9TQng1SEdibkJIbjZqeGxuVjJZOWoz?=
 =?utf-8?B?cFZuekJIRkpia0hYSjZleVZSNzZPK0ZDOEhZcXFXdTVvT1FzZXNVYTZFL1VS?=
 =?utf-8?B?Z003WjhwcGR1TmdvSFd6SDdNVENjMHJsQ1YzRmM5dnE0TmUrN3hRa2tZdWhi?=
 =?utf-8?B?R3k2Slg0T0x3bUZPRytoMi9nNktteFFac1krYUcxNU1FaUhrRDQvTU9ETnhk?=
 =?utf-8?B?TjRqc2tSOWU5S0VGRHFGQ0RQVXB0ajZkaG1uSmEwR3pNbFg5Q2R3K3dJM2wr?=
 =?utf-8?B?ZzRiQkI3TklnRGx5NnBGc0tPU2h4eFdtTzBmVEdpeW1CZjkrUW1JbnFYa1hx?=
 =?utf-8?B?ZWZkN1ZucjFEbEZ4bGNWUzcvcGQwb0tYUVdGaXNJUWJXQlRXYVF1Rk1yT29N?=
 =?utf-8?B?eE85NWFSM1J4NEc4OXNUbDh6ZFlhL2J3aXFlb1dqR3c0d0FuZ01TSFRXNnAv?=
 =?utf-8?B?TlFZOEs1MnIya09lYjJQcEpjREVieXhQRG80ZEVFVUlpdkZBc0dTMmVsWEk4?=
 =?utf-8?B?bGpOSlljTm8vTnovSndwcDdlSmJERXpBendOU2h4Sk1vMElTVUpLL05HSzFy?=
 =?utf-8?B?ZGxELzV1RUxBZWs1ZldGOEw0RmZtclpSTzVIZTk2TGoyM0RRc3l4WUs0V2V4?=
 =?utf-8?B?U3UrbTJ3UmNkaHBhL05CNXZ5NGZyVkJITU0wTElKbkVGWHBHVVdMMkhLUXhQ?=
 =?utf-8?B?L2gvNW53U3g1WDhrT0tpVndNRlQ4cUlLWkZWZllOTFhlZlYvT0NBdUNaZlkv?=
 =?utf-8?B?UUN1MUxHeGdrWjNEa0pvaFliQU5iRm51cUp3bVVOQXE3WFIxczFPbkgrRERs?=
 =?utf-8?B?NlBBTkpPalJSbEZYSUJqSW9rMmdzelZXOFBSa0JOWkhLZHdHMFhBdlRoaHZk?=
 =?utf-8?B?aDFPUllCbTJFTEQrcDFIaGkzNmNVQXdYOWFCQ29CUEN0ODFwcWJuc0p6dWVh?=
 =?utf-8?B?R05UdVBsbTZIL0dCM2JGQjdTMWNlQVFkZ3NMUDBSN2pjT0s5RVAyMDJ1bkJs?=
 =?utf-8?B?cEZtUUt6eEZPQiswR2ZHaE5XQ2I1Y0pHRHdUSm9WWDlpanhGOUlOTXlBZm5B?=
 =?utf-8?B?SzBCK2NWM0hxZ3k5Y1pwYlVUWkdTU0pkTHRFd2tMWTIrVCtnSXhCZ0tnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkF6VE9DVEwyVkdURWFwRGlDVjVpRElIZjExeGxhZ0pTWVlxczNTZGl5SHZV?=
 =?utf-8?B?WC9MSHV0L0FuUWZWMVFicFlKdXhmU0VGNmhXU0ltVUxma1FvUkdEenFLbnpr?=
 =?utf-8?B?a1hMV1R6STdiSkh0UXVDT1hLL2E1WUtBM1ZyeWpROFNYQ0FDS3Q2VVQrTEpa?=
 =?utf-8?B?ejJtM29ua2tDZGcwVi9uejFRMXVXQk1KRmZqRTlkYXN2NmJWZWVUZnN6b2oy?=
 =?utf-8?B?SFlGZG05TzlYTVZyMFZFeWtQUHI3RTM2UEpmeHlvZXZna012dnZXTDFobHRH?=
 =?utf-8?B?QjZGOExNek9lbVNmR25yRmxKTFllSGtlMFR1VjN0dWk5Y3R6WFEwelAzbjRt?=
 =?utf-8?B?a2pqTThXdVVPLzd0SlQ1YnhlanpKN24yc2xmRENDa25HZG1ZcGNJZGdsbjE2?=
 =?utf-8?B?THdCNytwMGE4T3hVdVZDblhKTXNtTUd1a0EvdlppdERNWForT0xNdWJGVndy?=
 =?utf-8?B?Q3VhcFlTczFtaDdHaTVaZStRdlcvbkNaTlpmeXE2OFIrcDc4SVdndFRuKys4?=
 =?utf-8?B?c0NqS0tkYTN1K2ZvQ2I1VGVmTlY2VlEwWGJqNDVYWC9oUFcwVlA1dytPdjJX?=
 =?utf-8?B?Z1p6cS9La3BqeUxjNWxDUUdQaHlKK0N6d2VDQWFRN1lYRktrdVJranJUWG5k?=
 =?utf-8?B?Szg5ejA5MDNhbU5iTDlUOTkvTzNYeHpIbXVPS1dYTzI4azNidzlsbHBlMVdt?=
 =?utf-8?B?WWlManBCR25kT1BqSUJUV0pXVWM2aS8xdWp5bHFnZmRJaDhqSzR4VnZVRVFS?=
 =?utf-8?B?OVplNDZNQ2t1MTgrZGFxL3RlckdxdXB4bVFxRzVaclg5ZzBUcTVDWWtCcTcr?=
 =?utf-8?B?dC96NktPekwwNWJOczJieXJJWFVpQVYveFI5ZXY1dW85VUUwbWYwMUcxYS9I?=
 =?utf-8?B?VUVzTG1DRHZYMkQ2UUpjbFB3RUM5MS9IUW9sZFJ0RmtCc3g2cHhZSUk2WUtI?=
 =?utf-8?B?OFlaY1lPbGJkTmNpbllpQW05RW1BSlNyWXcwYVZOczhwMGNiSlIvVUFJcmVm?=
 =?utf-8?B?dGQvRVpKcTZVN2FDYlNuOVNJb3VaZHpRc1l0SWZKTTBpd0JCa2lQNmVGUE55?=
 =?utf-8?B?Mk1PSmlGbndPSVNMYVM3OFR3NTRFaTk3c28wWnZuMmZ6UTQvZlZpWVZ3Tzgy?=
 =?utf-8?B?UjdubmpubDQrTzNYK1U4UmMzbDdWdE9EaWlnd3k0QWUrdDhzRzRRTEdUZmR1?=
 =?utf-8?B?WG5JSjdoOXhpdTYxZ2s1Q09FN2l5amFyaVVycllXVFpXSnhHc0lDbUhIb2wz?=
 =?utf-8?B?dTViNGNtT3JrNEhWYWRrdXpaZXVLNVdIUXJXR1ZBdDlHNW8zQStEeXR5UmlE?=
 =?utf-8?B?UmYwb1pkaEllL0QwSWVZTHhQbVZEOW1VWEhxZ1RwVVFOUVc4bE1MblNyZDV3?=
 =?utf-8?B?T0xPL2t2Q1ZlQzNITGcrR2JVdmtkV3lJZ29IM3V2WDhlbnhyVXJ1eWpzc3ZW?=
 =?utf-8?B?NUZVYW9ra3I3TXFoR3U5aGZDbnFsYkxqeEh3bS9JWFBudllLWldPVVhMT3Zn?=
 =?utf-8?B?SWhuYUNhd2xkQ0l2K0hIM0c4dy94U0NyTjk5YXdveFVhQ2JEWUNORTE3K2ZE?=
 =?utf-8?B?SXQ5cEphelpLT01BMjZ4SjVKRStCME5RMkhuM1BiQlU5dmVldjhHT2xMZFIx?=
 =?utf-8?B?Zm9XSGtjQnpVRjdTa0QwZzFsMFB6WGRITlVuZDQ1bUtpdkpjRFB3WG5jNmZr?=
 =?utf-8?B?VStqRzRtUW1rVUZtZ2VuQVNRZ3grYmNpT2pvNjNYNDd2cnVncnRFaUZUem9P?=
 =?utf-8?B?cGpEdWRQZXBXaDZlVFJtN1B5SENhQ1AzZnhoV1pXZ0ZnK0dJNDVKL21JV0hN?=
 =?utf-8?B?U2hCcGJscm1LSFMzQnptMlBCZVJyODZGcGk3RU1xcHk1R2svTXZ5MHRETEVG?=
 =?utf-8?B?OTlBL05NaTlrUGYycVdhZ2ozTFg3ME9RemVISkhWcWd1SXRWRXdhc3VicXEz?=
 =?utf-8?B?eTh6UHQxRlhhTFFUazJOdmdMc0lxV2lHRzJkS3VQR2gvMUZrUUlrR1dON0Ji?=
 =?utf-8?B?U1o1a09yOU5ZMU5PY1ZZdDR4V3AyRzFPWE1mUG1xMVNpeUh0RTljckNHajR0?=
 =?utf-8?B?eDVJVnFHdTMwSkE0MkR6anFxTU1mK2Q4ZkJIMktpdWUzL21sbWx0YUE2M2F6?=
 =?utf-8?Q?1in3Evo6CoC4SShOYORN+q1cO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3ChrETXICpXrDCBfhY/O4uTp/lYhqjphv3kkeNJgTOOLFBEnjXaiudiZSYe9wUnPCD2ckNHcol62AgufXyraND5pX4R7VvG2RWm5XwpAOSJkjnkh9kctMLuwolEoQVKOrHSKHiztTS8y5gDE1DA6QWVZmbUyo4A1UwLb2YGaAgD8dez62PwleuArTD0dlsNqL6fEBwsPoyzy9s0XJeBNFSjfySbCrcYXmJ0XDi+rZj+9VTWTumqQWWqiORkl/9253aWOJLDOUb1e0B04M6hhsSoLzh5vCutR/LrQW3FWyHuv6RRwZU8CaHByY7hSXygcQLx01swQ1WlytpSTR7qlssZ1ukAePjvbfDs1pnfr3rGNbFf5JM/s3tBrNi2pxVxmeYB7JN2h2y0epOl7d9CEHizcTVvLsezLq0oZDfrUfFeuUmdzroHRu+BHnMa2C7CZOmUL8m8ZSaDmX2EJOIJBrI2rIyMQb4lgj1QlhfYjVNVYxH5KuudTr8xzuLLr9v7qA56H+UBOYAK23HuiZnixWxnXOGekldionK/WaHI6V+coIKqgfZf6ZCJNC5RLfGa6lXrItm//vSOHmP7rfqZSwZDTELPUr27/qUuoIyAkZks=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f87ba2-e074-4249-b309-08dce21c18c1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 13:22:28.4711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qXWzielIYDMAEpjKEQCwB/3EkQlxf//5IQxwGCF0tbbb3VsnuxPyAqMVZADz2ykKpTuV6P41X97PJ6HeTQegwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6301
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_09,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410010085
X-Proofpoint-ORIG-GUID: JKcpKTLjJrH9E5GB26acZXJgJFztBc8v
X-Proofpoint-GUID: JKcpKTLjJrH9E5GB26acZXJgJFztBc8v

On 30/09/2024 17:41, Darrick J. Wong wrote:
> On Mon, Sep 30, 2024 at 12:54:37PM +0000, John Garry wrote:
>> Validate that an atomic write adheres to length/offset rules. Currently
>> we can only write a single FS block.
>>
>> For an IOCB with IOCB_ATOMIC set to get as far as xfs_file_dio_write(),
>> FMODE_CAN_ATOMIC_WRITE will need to be set for the file; for this,
>> ATOMICWRITES flags would also need to be set for the inode.
>>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   fs/xfs/xfs_file.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
>> index 412b1d71b52b..fa6a44b88ecc 100644
>> --- a/fs/xfs/xfs_file.c
>> +++ b/fs/xfs/xfs_file.c
>> @@ -688,6 +688,13 @@ xfs_file_dio_write(
>>   	struct xfs_buftarg      *target = xfs_inode_buftarg(ip);
>>   	size_t			count = iov_iter_count(from);
>>   
>> +	if (iocb->ki_flags & IOCB_ATOMIC) {
>> +		if (count != ip->i_mount->m_sb.sb_blocksize)
>> +			return -EINVAL;
>> +		if (!generic_atomic_write_valid(iocb, from))
>> +			return -EINVAL;
>> +	}
> 
> Does xfs_file_write_iter need a catch-all so that we don't fall back to
> buffered write for a directio write that returns ENOTBLK?
> 
> 	if (iocb->ki_flags & IOCB_DIRECT) {
> 		/*
> 		 * Allow a directio write to fall back to a buffered
> 		 * write *only* in the case that we're doing a reflink
> 		 * CoW.  In all other directio scenarios we do not
> 		 * allow an operation to fall back to buffered mode.
> 		 */
> 		ret = xfs_file_dio_write(iocb, from);
> 		if (ret != -ENOTBLK || (iocb->ki_flags & IOCB_ATOMIC))
> 			return ret;
> 	}
> 
> IIRC iomap_dio_rw can return ENOTBLK if pagecache invalidation fails for
> the region that we're trying to directio write.

I see where you are talking about. There is also a ENOTBLK from 
unaligned write for CoW, but we would not see that.

But I was thinking to use a common helper to catch this, like 
generic_write_checks_count() [which is called on the buffered IO path]:

----8<-----

diff --git a/fs/read_write.c b/fs/read_write.c
index 32b476bf9be0..222f25c6439c 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1774,6 +1774,10 @@ int generic_write_checks_count(struct kiocb 
*iocb, loff_t *count)
  	if (!*count)
  		return 0;

+	if (iocb->ki_flags & IOCB_ATOMIC &&
+	    !(iocb->ki_flags & IOCB_DIRECT))
+		return -EINVAL;
+
  	if (iocb->ki_flags & IOCB_APPEND)
  		iocb->ki_pos = i_size_read(inode);

---->8-----

But we keep the IOCB_DIRECT flag for the buffered IO fallback (so no good).

Another option would be:

----8<-----

--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -679,7 +679,12 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter 
*iter,
  			if (ret != -EAGAIN) {
  				trace_iomap_dio_invalidate_fail(inode, iomi.pos,
  								iomi.len);
-				ret = -ENOTBLK;
+				if (iocb->ki_flags & IOCB_ATOMIC) {
+					if (ret == -ENOTBLK)
+						ret = -EAGAIN;
+				}else {
+					ret = -ENOTBLK;
+				}
  			}
  			goto out_free_dio;
  		}
---->8-----

I suggest that, as other FSes (like ext4) handle -ENOTBLK and would need 
to be changed similar to XFS. But I am not sure if changing the error 
code from -ENOTBLK for IOCB_ATOMIC is ok.

Let me know what you think about possible alternative solutions.

Thanks,
John

