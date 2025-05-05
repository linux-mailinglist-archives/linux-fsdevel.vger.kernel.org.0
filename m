Return-Path: <linux-fsdevel+bounces-48026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 414FCAA8DCB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 10:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C05EF188EFEF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 08:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7B01E3DC4;
	Mon,  5 May 2025 08:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RVCy4YN3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kBDjHQhT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA1E1E48A;
	Mon,  5 May 2025 08:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746432175; cv=fail; b=rmAYy8WQ7qvFOUi462diMidaHFvcX3bKpm3yNzNrsQOXrPDHCMZkuMfqT9HJu97WChSjZTZob+ctL6M6M0PrhfucBBqfOSiEakE4CEEemG4XKcIBRZ31a9q0eWdflbeUdb2lkLmUs4vs2lWNNdgXVYIOZGAE5zKk4SJT2pSH1yQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746432175; c=relaxed/simple;
	bh=RAZu42gLnNiOf30mg6fZZtJufXrYuwnwUFOjZyNFQIc=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b+gy+0/SI/wVB8gxp3uWTwDqxAMb79sYYTWgh16lx7y2Al/jmiO6K6ijFCNkbef0ebgyF3O2HC2X5FWkTaC3rUQjG/ob2m8hq8FlLY+M5uzZLo4sbr50iZxQN+29BsTJ6wkrr4imK2xyoxcDzSvWHmESfpFwHIChCEbHXuhG/Jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RVCy4YN3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kBDjHQhT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5457bY34013587;
	Mon, 5 May 2025 08:02:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ckgIYcpdEb/117LwipJL1zNZauq45HM+5zz5ZrX4nrE=; b=
	RVCy4YN3CZNbB1FCK7OfhjhMlQa4FbcMfp7AiAsobhgvJjdI+qhsmtYUha06q8L5
	xNnwy0dE6LYHn1X7Nbp3m0wsQP/Qn1DCG0sD4CYtE9QRP2VD8w9Pws3pyjdUVzMz
	oO0m5Hnb/4I5fmgYeSP5w9B+ckhGdvpH4FVGDerzESPeq41xCvjCyowv5MuwChuo
	Zzf9SEJwaGLeOdmlxNM1V9vQUJU71u90UhEJ0BWaNkOTGytzzfXKhLMW5M/1W++6
	nrJXBDuUSyO9LIr1mMk8Gz69XW1hdJTiQGpee58bN1laBFEsdW/FhPTrOFxKrVkv
	NjPQFOVYxpuRfWICJOw+2A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46es3h819v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 May 2025 08:02:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5457u8Vd011147;
	Mon, 5 May 2025 08:02:38 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazlp17013061.outbound.protection.outlook.com [40.93.20.61])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kdn0x8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 May 2025 08:02:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xCfT+IHlBy2nZ42WtlfqUH6DfNSjO9JymS27g64u4yhaf6AjY6uw5VxXrBXf4Vnq+EWinWgzQHH19UAxuDugC7PKihXlQRNHToR32qAQcmi0nL9nxIhNcU00jzlp6yP1Fwy0tvF9CYWeLihRw+YGQZ1UDMC6QlFmR5ai5JO1JiYNCnAUTVPXzj12s45akNgz95LZySPqzP7aGy7nEjhorvGx0DnN7u0g0/YIpYIfmOiQfVojjD3om9DJ3wbkjptfZnK9vK+oz1cEEW+aemnhTDfLJKuCIK0ClUv4pMJ6RLka031uQkPC3U+kEEmGkuCRd6keBzJzkCX9TfSI+hlV1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckgIYcpdEb/117LwipJL1zNZauq45HM+5zz5ZrX4nrE=;
 b=i2P6XmANQghOeFW2y4+61kuhQyfv10ZfTyIy1QwnfNx6KMBrjdDfu2zA0wkczViNj8AeZAGvYBX+MYMrxaqj5pMKttcAsGaJk6ZT6EKq/ihy43T/DCvryEtYmA4AeWtQJnCErfOlV+ycOOA0Gdc5vfjI5DoXUvh3GI3Zmv9dwoyZGpDfp19NrhuT2GJjpp3gRF+u8UnOgPFSgbO2nfFha7OJm/cx7cQm5aYs5GPPeUf5MCFIHbJEDh/zSzWG8DWbHM3F9th0p3g4fX3nHJLwwAGY7AdobCViwPhqQsf6DCp1/KIa9441PTkb2wGm0mUDdaheMDjyt3s/PY4YE4+qnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckgIYcpdEb/117LwipJL1zNZauq45HM+5zz5ZrX4nrE=;
 b=kBDjHQhTSmcPZieTR2N+k3OksJ/8ziACLqAaIGynYoBhYloHirMcvmxdcrHDFWFGZUmp/T1+JFdBNMiILm9kwc4/g+1VCFRqK93L1RjrySL7+8ny49Mo6PTSachgGO4gbbAdInSknX0YwxnAgJKdtNE1HYyOLidXFtNfEijr/tE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB6826.namprd10.prod.outlook.com (2603:10b6:930:9d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 08:02:36 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Mon, 5 May 2025
 08:02:36 +0000
Message-ID: <9d5d7037-6ed7-4c61-afec-8422d656de37@oracle.com>
Date: Mon, 5 May 2025 09:02:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 14/16] xfs: add xfs_calc_atomic_write_unit_max()
From: John Garry <john.g.garry@oracle.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, jack@suse.cz,
        cem@kernel.org, linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org
References: <20250504085923.1895402-1-john.g.garry@oracle.com>
 <20250504085923.1895402-15-john.g.garry@oracle.com>
 <20250505052534.GX25675@frogsfrogsfrogs>
 <2a5688e8-88ef-4224-b757-af5adfca1be1@oracle.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <2a5688e8-88ef-4224-b757-af5adfca1be1@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P189CA0031.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB6826:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a5d6035-7c3f-413b-cf13-08dd8bab32a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0M0eG01ZTVUK1phclNEQThKN1ZQWnlsMEZHSmxjZElTSFdWcXUwWUV0Y3d0?=
 =?utf-8?B?d016bVRRS3UybjVoQ1p5cWhxTTlnam0rd2RBM1daMXJKbUkxUDR4ZlZsQnU5?=
 =?utf-8?B?VXRyT2ZaMUw5TWVYaDRGeGN5aU9VeWJUcVByUGsyQTJFY04yTHdmSG5yL1BO?=
 =?utf-8?B?aDZGcU5QK252NHY2emZGOXZqdjN1Z0x6dkFJT2lCZ1J1NHpIS1d4U2hxenlE?=
 =?utf-8?B?TEdXdDZOVTNieGJ2U3ZhWFBvTUNXSVF2eUYzN2dCYi9GNk9ObVIwc1lGSkRY?=
 =?utf-8?B?b0tpTDljbHB0MmpBS0tDYkQxZEhISVRpbmQ1NWFVKy9ia3Bxc3I3dlh5eVZa?=
 =?utf-8?B?c3Z1N1pBYlRVTWwzZVo1RXFnMEN2bTRIckxPNk0vMm1BVUl0KzBTdC85aTEz?=
 =?utf-8?B?VXk3TXFSUXU2TTZZL0ZqbWNnMTFxZlhBR3M3M2FXTEZkS1o3ZVdvWGluNkRV?=
 =?utf-8?B?dms0eG1GNk1JSGU1bWFmY0dLYndHaDFNSnljaDNzMmxwVlVMa1N6Y1NuYWhV?=
 =?utf-8?B?dDZsUGV6aFVpOWhUWGQ2VHdRS1I0YWRGRU5SeEZ2cmFNbW1sMDB0T0lEQ3h6?=
 =?utf-8?B?QUFkR0RGWWUvVVVvZW1tUXR2MnFvSStEcFMxMTBkS2NNa2pJZXFDQmZiK1FB?=
 =?utf-8?B?eXNKRk02WXoxR3hkbzdRZlp2SmFFaHhnMHg4aTJhYy8zY1R5ajZSR3R6TWVo?=
 =?utf-8?B?MVBrVUhua0hwRnduVXZkNEJ5eTBnN0xnYW1KU1ZrNzNGRHhycXk1a0lLVVht?=
 =?utf-8?B?SHBqbFhLV2kzOTdocHRtZVBCb0xUM1p2bkxtNnBkNnUzMFFsTUxRMElWckV0?=
 =?utf-8?B?WTlaL0dIMTBGSDZHRlRJQk9zcWpnUDF6emJKVkUyOGRYL1QxMDdVZHBuMEdk?=
 =?utf-8?B?alQ0djRPc3RMVlk4c0J5K1JZK2p3YTVtZVBYWWVrVWc5ZW4ySWMzNmZwV2JC?=
 =?utf-8?B?ZmZHSzExVEdjVmErcG8xZHVQaXMvOFA4YnI2cGtBM3NpT3lzQXBkb1J2T1dl?=
 =?utf-8?B?WTFqNlg0eVorZzVkM1J5MXJrTjhCRExTRjcvSGtZTER3aGVsUVZZL2dFWVVw?=
 =?utf-8?B?N3pvRnQwVjU0bzVWMnZEYklGUUNrUlBOenJvVlVjZVFqR0JNbFRXMStEMkd1?=
 =?utf-8?B?ZVY2Y0V5OTJuMTZPZnlxaTNIdEpMOUltbXIyQm4wV1NPa2xMOVl4b0xtVE5y?=
 =?utf-8?B?WTRJQ0k3b2QzcHBkWUpGZFptbGh6ZUFvQWppWnRRWk4wN05GeXJiS3Uwc1E2?=
 =?utf-8?B?TWtsMG0vVk12VkorYzNVeWZabUI5YzdQODYrQXVvbEFNRmJMWmN0ZnVEMGRP?=
 =?utf-8?B?bGxyZEh1TDVHck9VSkFDN0R2R2UxLzlKNEhIYktEUzJlZ3JaOFptaS9aUnFF?=
 =?utf-8?B?QmMwdUVzQTFML1JvYkRxUE1VN2RkWWVTblhDZExJdVBrUlRGNGtpaHd3TTJC?=
 =?utf-8?B?UU03M0h0RDV1eC93MmlLeFd1R05hVEUrRzNVMTNzRHZGT2grTzlPYXVWSCtK?=
 =?utf-8?B?OEZiUWwvVWR1dzBHczdrSDcvZEpldVBoNnhxZVFHRHhuWllhbkJWY3o1ZVZZ?=
 =?utf-8?B?bkdtRDlNWUpHM1E2M3d3aGs5TS9PMWhHeUREeDNDUTdsVTNFZE1UYnNpeDY0?=
 =?utf-8?B?a3cyZkxQTDNCWjJzSW1sV2JFMGNFOGFiMUJpSkQwb1VZWS9zOVhycThxREhl?=
 =?utf-8?B?SDJJL2t4ZzFhMVNlemFxL3dyeXlrbzVHVmtGc1Iydm1qbnluMEVIbHczVzBu?=
 =?utf-8?B?MnhoQXhrRFdLZ2FqMFFvZDhoMXcxSUtQd0x4WStvVHJHUjBlMVhWZmk5aFg2?=
 =?utf-8?B?QzlseWdyejF4RnJOT0R4c2dtcFVkQnZyQWMrTEhsU3N0M3c4czZZWHVReW5m?=
 =?utf-8?B?ZStVb2hJc25hNnUrWktwVzg5UGlDNGhybTNwZDU0aU12Z1BKUjlrdm5yYTlS?=
 =?utf-8?Q?gn1LhjmRzXU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzNOTUoxVU9wS1pqTDJDV251YUkrUFFzcytxRENvTUp6K3Rvd3pIT2J3KzFx?=
 =?utf-8?B?L0x5K2pybktrcmVYVnlGMkhyelY4bnVQbjN4TGl1R1JKbUZxWkIrKzJDK1lt?=
 =?utf-8?B?dEtaZTVCc1dGUTBjU0tMUlNZZHJGTGxxZlYwZ012czBXMnVxSGhUUG0vRmwx?=
 =?utf-8?B?Z2llaTVyVnJxQy9XUnovOFpaUTdtcGF1ai95SFZOWnpuZEdnQWpCem90TG5N?=
 =?utf-8?B?UFVZOHdaTlZ1SFNSV1huVjRHaW9MbGVVVWZhNHhDbmlGak1wdU9lRXYwZFJu?=
 =?utf-8?B?M2pCK0NDeGxQUmh5ZmhqNHlJc1Vnb2d5S3BwNzQ1RFVXU0kzQVZhR2Y1d0ZX?=
 =?utf-8?B?aDlzcy9qa0RMMjIwalZFR1ZpMnkrK0VRVkI4TFAwU3ppcGJjRE5MSlh3Y0FY?=
 =?utf-8?B?dnlrN3ZtQ3hHM3lxZk5OdnhiZ0Ixd1JkeHMzMmQ2SlptcGhPU2ljdm5jb25Q?=
 =?utf-8?B?U09VSllSNE11Ni8xYmNGQUVkRFVlOC9nUURLajQxR24vWHpaMmFCK0tnM1Jt?=
 =?utf-8?B?Y2tFRzNZTFhKT2l0Rm0wNTZ5bEVueGFybTJNSnhsSW5uQnE3RmJFWXVwOXJD?=
 =?utf-8?B?QjFlSE5GSFNCQjdKN1I4K2JCdHBscytEajVTeG5GNG9xdGpDcHE4aGF4WGdY?=
 =?utf-8?B?THhMRExDcFhUV0FSdHVjRlRXY2d0T1MrZ2h6b2hvSi8yWUdWOUFFOEZJRnZx?=
 =?utf-8?B?cXBTYy9TQVdzQk5SWC9vZTdPNEJVTXJHcURxMTk4OUZueTJmNzJGcHIwclpa?=
 =?utf-8?B?YWYraExkT3daOGdleExxNSt3OHZvVHM2Qm42U2NZcHFBVjQ0OGt1L3l6QTBU?=
 =?utf-8?B?Z0s5aXgzcjlFVFR5ZktCTVU1NFE5YzlkV2dDK0VyaUJycXZlajJYdUtqSEpH?=
 =?utf-8?B?aHJKbWRZOS9IRjRxRnFxdkpsWS9ZM1pzc3BGZGFLMVFFRlhQbGcydTkyQXQ1?=
 =?utf-8?B?L1VsQ0p3a0oyK0JjV0RmUk9SSmpiakRIM0U4QkdOMkpJNDdYZVJHRVBTYjBa?=
 =?utf-8?B?WmFEV1hLWTJoU2MxaGZXajF5Rm1wYmpmOFJYL1pkbE1LS3poRlNLbytyTFZ0?=
 =?utf-8?B?cEtTcS9yUWw2eTI2dU9WMTBvRktablhzSUtWSFlsQ0pwcTY0aXNSK3ZZcTNL?=
 =?utf-8?B?aGNJZmdzNi9TeFUwRUhTSTVwNzN6SGZPZFdXS1E3RXVuZm41dzRUbFUyUm12?=
 =?utf-8?B?bVp4Und5eTlBR3puOEtJbnE2M0U2OVROUCtheklyZHhsSk8xUm9pOGw1Mmdw?=
 =?utf-8?B?NUlJWUlJc1NZV2ZVazNnOEsxblhYVXlDQ0lYbTcwcmdXYnJ3eXRsUlBxUVI0?=
 =?utf-8?B?Z2VxMnVBSXpUY2ErZGZNT25CU3VzdFZxZEhKR3drZ2RxSHcyc2VsRVNkaHJN?=
 =?utf-8?B?Z0hBV2NWa2hyeEhCS1krY1NLRUJFTU9xcFN2VEw0MVorY0l0cmFHU1c4UmNy?=
 =?utf-8?B?M2JaclU5NHEyVU1BSHFoV2c0ak1aSVVYYTZMRU1DZEkzRjdGbzJ0anhCa1l6?=
 =?utf-8?B?UzFjYXZHS2twWXNLVUtiV2ZaNGQvbnA2UnlxeUZETm02TTBiVWVNdW9xMEhT?=
 =?utf-8?B?SFlkTURvcm5Za3J3ZTJ3ekxEK2tTYngxcHFmM0I2cW1LdHBVNnhzbktzV2NQ?=
 =?utf-8?B?aXJkQ3BIbGwzbkljVmVSVVVBdXhWNWxnUENKSjcxS1ZXOWJ6SG9xZ2pJaUZJ?=
 =?utf-8?B?WXVvVGFDNFBRTk1IVVZ0b1ZGWHB4cUJNbFJUY0dySFZFKzVTRk51cU1zNHR6?=
 =?utf-8?B?YlptMkt6VWN3TFF3ajg2NE9JUHJTQXZsN2JHKzYzVHNqYXJBWkNBNFN4Y1NT?=
 =?utf-8?B?Sy9RdzFBcm5XRXFEUXlSTzBEc2c2ZFdFY0RibktZaFJMWFBzVmd5R0owOG9h?=
 =?utf-8?B?WXhseWhKRWwyOXpCKzJsY1JUSVA5OUR3bXF5YkFrekNxeHh5dVJwUWNnTmdI?=
 =?utf-8?B?aFo3MlB0bFU1clpkOEc2SjF1SHkwVEJuU2lhd3piZXkxSVFxV2I5ckF1aWtl?=
 =?utf-8?B?QTNNSVB0a0UxRmw4SjFTbnRHWWk2a0ZFSjBpQk9kcW81a29rWlZiUjN1aFh2?=
 =?utf-8?B?TTRaTEJPWEg4Nml6bStLUk5ZRm40YjN1S1B6RTUxSS9iVjhTaWZuNVFOS1ZG?=
 =?utf-8?B?SFJTdXMrN2lkS1NhSUtxeVNvRllnQmpLcHloaktQUDk3MVZnZ3RZSjFYTXN5?=
 =?utf-8?B?Z0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yJUYRGDcLw89O8yZ8q8jeqhk6wWX5+HkKO0TiTCjWXlLa//55EBpLlxyTreDS/0fe/F0k+BK8l0OUEovMBz5o9KojS3TKfi4mwadCNGNQCcPrkAtQYEg68t8RrbDYAmH+2/eVLP8tbotQjQmQd4kxfyaUTeId3qCG6O9dKx/ezTAlmvdH3R6f6JmI0Sk7Kg1zoXOzlW7ghSkf2VgKZzNdu59fEej2LRFq8C6ZGHdqXir+7Y+mYhXhLv1fkry1e1Bito4ERZ+KDnnYGJcQV0v/hC4b10/wHKVHnVQunIesXW2fDRQkaj6hVDAUJRkL8dvIQqgUFIlgJdUNz5DZ3C300EUGWpBz2NBT3prYQCHmolrT3rLA+/XnNNtZ+uXmXAuoEaEKbPHm4OD33Ng+NkRJf1FlGfUTYZxoiEayHSsoFsQBFZr6EB7WCgxouFIgLDbG5C8oVEmGV+Pr3b3cTXV+rsSkgnRs9/sNi09fCcJYbZyNtAaqqIkGhDrA53K5kNwQy3rRZwPM/FenuIL2W8bBHPWdnPBYUJuoqfrenJQEQuNkoBj09BI1DgQANetIGyl0Lk4DLcQbuF/PmZS3AfueERAaGq783BLQ0fE1me958I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a5d6035-7c3f-413b-cf13-08dd8bab32a8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 08:02:36.4515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xR+fbi8Eo7l6UFfA7iTlZSGceqxXdT3YFWkfpabFkRJyJaZK/6L4kb0AhdpIHeMAuQsIdKTzYNmIKst+ToEyZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6826
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_04,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505050074
X-Proofpoint-GUID: XK61aj5RXlooiCF2wUWc-CdyoioluBeP
X-Proofpoint-ORIG-GUID: XK61aj5RXlooiCF2wUWc-CdyoioluBeP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDA3NSBTYWx0ZWRfX9DdCo1Dv0OJa xSfBRWay/fvCwkrp5yfTa95MHZ8b1pL2d2jh981vDJKCjgaA6AHzqlaTjPSrejpP+cOtfttT6QP g13qHD7FcEwzbi+GIOQELlTRNq2CLgQoSbQOqo3MGZ9yytbXRTO63ZdFlShIIveYi8Z/7ng26dA
 knrnD4AT5CePaPLZpjpf0hC2PCySXeZuziJs/anzzVg8L46EryYa70zNX6zm3eZDw14V/avkDOF NP5eD+SWBHoyGlM8aeJWqT7mqewTEj5068ZvOtjPknQiNG9ltvq22gC9FlbN9ngzjDEktKjI1cj DpEs3Mi2nS3r5QkONZYlst4hgf4UhwH8KnI9nrbYIKfwk6qkOIuUtK0uXH73kMG2SQnheiB1qIT
 IQbhduMQZM2mMueOxaRfKbeTJejA2UZUZRPunhP5iZzfs/dqrnwVdICxZmeFauzqWnqt2LYk
X-Authority-Analysis: v=2.4 cv=f8FIBPyM c=1 sm=1 tr=0 ts=6818709f b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=wkWtjROv9LGLIe49J9YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14638

On 05/05/2025 07:08, John Garry wrote:
> On 05/05/2025 06:25, Darrick J. Wong wrote:
>> Ok so I even attached the reply to the WRONG VERSION.  Something in
>> these changes cause xfs/289 to barf up this UBSAN warning, even on a
>> realtime + rtgroups volume:

Could this just be from another mount (of not a realtime + rtgroups xfs 
instance)?

>>
>> [ 1160.539004] ------------[ cut here ]------------
>> [ 1160.540701] UBSAN: shift-out-of-bounds in /storage/home/djwong/ 
>> cdev/work/linux-djw/include/linux/log2.h:67:13
>> [ 1160.544597] shift exponent 4294967295 is too large for 64-bit type 
>> 'long unsigned int'
>> [ 1160.547038] CPU: 3 UID: 0 PID: 288421 Comm: mount Not tainted 
>> 6.15.0-rc5-djwx #rc5 PREEMPT(lazy)  
>> 6f606c17703b80ffff7378e7041918eca24b3e68
>> [ 1160.547045] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
>> BIOS 1.16.0-4.module+el8.8.0+21164+ed375313 04/01/2014
>> [ 1160.547047] Call Trace:
>> [ 1160.547049]  <TASK>
>> [ 1160.547051]  dump_stack_lvl+0x4f/0x60
>> [ 1160.547060]  __ubsan_handle_shift_out_of_bounds+0x1bc/0x380
>> [ 1160.547066]  xfs_set_max_atomic_write_opt.cold+0x22d/0x252 [xfs 
>> 1f657532c3dee9b1d567597a31645929273d3283]
>> [ 1160.547249]  xfs_mountfs+0xa5c/0xb50 [xfs 
>> 1f657532c3dee9b1d567597a31645929273d3283]
>> [ 1160.547434]  xfs_fs_fill_super+0x7eb/0xb30 [xfs 
>> 1f657532c3dee9b1d567597a31645929273d3283]
>> [ 1160.547616]  ? xfs_open_devices+0x240/0x240 [xfs 
>> 1f657532c3dee9b1d567597a31645929273d3283]
>> [ 1160.547797]  get_tree_bdev_flags+0x132/0x1d0
>> [ 1160.547801]  vfs_get_tree+0x17/0xa0
>> [ 1160.547803]  path_mount+0x720/0xa80
>> [ 1160.547807]  __x64_sys_mount+0x10c/0x140
>> [ 1160.547810]  do_syscall_64+0x47/0x100
>> [ 1160.547814]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
>> [ 1160.547817] RIP: 0033:0x7fde55d62e0a
>> [ 1160.547820] Code: 48 8b 0d f9 7f 0c 00 f7 d8 64 89 01 48 83 c8 ff 
>> c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 
>> 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c6 7f 0c 00 f7 d8 64 89 
>> 01 48
>> [ 1160.547823] RSP: 002b:00007fff11920ce8 EFLAGS: 00000246 ORIG_RAX: 
>> 00000000000000a5
>> [ 1160.547826] RAX: ffffffffffffffda RBX: 0000556a10cd1de0 RCX: 
>> 00007fde55d62e0a
>> [ 1160.547828] RDX: 0000556a10cd2010 RSI: 0000556a10cd2090 RDI: 
>> 0000556a10ce2590
>> [ 1160.547829] RBP: 0000000000000000 R08: 0000000000000000 R09: 
>> 00007fff11920d50
>> [ 1160.547830] R10: 0000000000000000 R11: 0000000000000246 R12: 
>> 0000556a10ce2590
>> [ 1160.547832] R13: 0000556a10cd2010 R14: 00007fde55eca264 R15: 
>> 0000556a10cd1ef8
>> [ 1160.547834]  </TASK>
>> [ 1160.547835] ---[ end trace ]---
>>
>> John, can you please figure this one out, seeing as it's 10:30pm on
>> Sunday night here?


I could recreate this.

> 

I think that we need this change:

@@ -715,6 +716,9 @@ static inline xfs_extlen_t 
xfs_calc_rtgroup_awu_max(struct xfs_mount *mp)
  {
         struct xfs_groups       *rgs = &mp->m_groups[XG_TYPE_RTG];

+       if (rgs->blocks == 0)
+               return 0;
         if (mp->m_rtdev_targp && mp->m_rtdev_targp->bt_bdev_awu_min > 0)
                 return max_pow_of_two_factor(rgs->blocks);
         return rounddown_pow_of_two(rgs->blocks);

My xfs/289 problem goes away with this change.


> 


