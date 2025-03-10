Return-Path: <linux-fsdevel+bounces-43603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7406DA5956E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 13:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CACD163EEF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 12:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B0B229B1F;
	Mon, 10 Mar 2025 12:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DN4sFOX+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cHJf9dsM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC3122156E;
	Mon, 10 Mar 2025 12:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741611569; cv=fail; b=NKJDGxTv1Jcw5ikyFc3jBZDcM+CS6rHDxEXZCTfQjqs5AwYJoW50VClWLyU0MQ5574gLYQtoBDGF4iwfqkNVut/ugTLrTGiK6+710i8iMzpRGSvvlewi4CfQc7RiF/jthymv+ogID5m1/rziHjZqNo2QQx+D9tNMBVM0axX7dJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741611569; c=relaxed/simple;
	bh=TMcuEMHvqAP6i+GWB4nnlS4o4SBrUy0FyTgo7CENgrk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QXOaJ3eLhbn36dVeBBk7X6dNQzh+ucWFPvS1gAyHAqj1C9b/3rZbAgj+kuBiPd7gEUZXEOcMa6ds2TgH4mrDW4lOAOv95pZ26XenP1suOuPfD0vV7ZX54pk7SPVUmh+jg2JijoYFJUxrCHQzvZMW9zuu/pUTwuDve6QtL6GLBfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DN4sFOX+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cHJf9dsM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52A9BlnZ024453;
	Mon, 10 Mar 2025 12:59:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=X63H4OonqoywY/0x5gZa3LiNovHFKaH25YY10p/YcV8=; b=
	DN4sFOX+rym1rlPKF0ICyI2zQXLEz+PvP3iYY2f9EchDewOF3/tqaKYgPjGk99yK
	lO0dXNgItN4h/OSF6gLD797tHF3jAnW33k809p2MqfGlOs1nauqJn7aimxY2SJ+r
	K1gCMbKLls0VDlBGXyk5k6vdb3TGXJcflSOb2Ml/k6JnPdez6VbL6TQnJOV1X9Z8
	laEm2rhikkkahyTB2DFBDPowWxaFNUgx/LsjnT8toDOMKhiVBjnf9FBonCF7HUXH
	KqmPCzrckMFUox+qrfJzQ3ycIA6F9URlq02TNOUSNuGjxcB03+IhtCSeGMLvQheE
	SJJ2rKeDy3yZRxrBarD6NA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458ctb2j0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 12:59:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52ACeOA8030679;
	Mon, 10 Mar 2025 12:59:19 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 458gckvvmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 12:59:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bUe/df9zIj/nCwpWgc7IQFHj1ilG+c84SPvwhvd+93GyvyoN6tG5t989wD5R2f0fa/hLuedbkZ9B8Ca14aln0TmJ40xX1jD+jWfmkxmptiZxfsWRvWMFLRsm00WHV/xlnq7CeMrmY+toRqMFqPa8EPjV19Baq277GglSHA3mTwAZPuwDqlQMdtg/oA3NbdLFV/rsH/Py5d3+FLbJKJ3aQ8MdfLYcaSituALlShaLfOC8iK50yV2SeHorMkAn38eoNjI9nJUU1h0PKFEDbItaEl5efWyqbcYT1X+3eESJTcnzMza3YoM2L9vhpxtbNfoWaNOElv6QzrFXdK2bu7a9sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X63H4OonqoywY/0x5gZa3LiNovHFKaH25YY10p/YcV8=;
 b=LoYWWyjgamhzSjD4pkwq/jVnm9MVU4F3pXYsHxJ/XxD1JM9CksrOXYdT05+UCCm/ECVgo40UijXOQfbdOy5H5bmm5SizbJTivzc/lX6xrL7OrbxNe80H+cj7BOnqeiEn8oOc16+USc42UtJbsPfS2fDL0oQez9ZlBy97ZIfoWyQjaPpcbACrCypQCdx2UH1HqxUa/CwoPrdF1olsTX/gPTaZ6Z8yjHisnvJId2/z9y1rXOxTkf56tYLKOP/2crfOo84i6pGcKJkl1KscdTMtrSOj7agYNBcC1UXoAlJ3a7FVC6+vOKDADRHd46Ro8MCcuZDWx9SaZFKpSTctgbGilw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X63H4OonqoywY/0x5gZa3LiNovHFKaH25YY10p/YcV8=;
 b=cHJf9dsMArRNzpv3A/dNp5KI0ZyPdmEeiV1dx2dK3t2P/B19lkOudhf+Cf4Qq4NT2YvpifjuZGI0nsXq49WnPFElzfqh0zHOAPWwPU3G9RPwUEtIIDgRaN0ELbJQutdHavtHIcgMQ4ymqCtxl/jAM8o8j7dPIe5A5ZMaA6lZ3Ik=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB6719.namprd10.prod.outlook.com (2603:10b6:8:111::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 12:59:17 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 12:59:17 +0000
Message-ID: <f7857671-d566-4393-adf0-8e983f6607a3@oracle.com>
Date: Mon, 10 Mar 2025 12:59:12 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/12] xfs: Update atomic write max size
To: Carlos Maiolino <cem@kernel.org>
Cc: brauner@kernel.org, djwong@kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, tytso@mit.edu, linux-ext4@vger.kernel.org
References: <20250303171120.2837067-1-john.g.garry@oracle.com>
 <2LEUjvzJ3RO3jyirsnti2pPKtOuVZZt-wKhzIi2mfCPwOESoN_SuN9GjHA4Iu_C4LRZQxiZ6dF__eT6u-p8CdQ==@protonmail.internalid>
 <20250303171120.2837067-12-john.g.garry@oracle.com>
 <bed7wptkueyxnjvaq4isizybxsagh7vb7nx7efcyamvtzbot5p@oqrij3ahq3vl>
 <QIPhZNej-x0SeCVuzuqhmRIPUPKvV7w_4DB3ehJ2dYmLS1kwYGIJi1F3F34dhPTCy6oBq_3O-4Kjxxt4cIiP9Q==@protonmail.internalid>
 <c2fdb9bb-e360-4ece-930d-bab4354f1abf@oracle.com>
 <egqflg5pygs4454uz2yjmoachsfwpl3jqlhfy3hp6feptnylcl@74aeqdedvira>
 <Y_Bg5L4XDukci667dxJMc9smhcW9Yz9EtBzX00M1L0lGfTouxvMztMPoBnG7m56FYpJhi_76fdjJ7ShIMbNr4A==@protonmail.internalid>
 <cb7a9d18-c24d-4d90-881b-1914a760a378@oracle.com>
 <vdar74f5jw6je4z2lbpconpitcevl2mdp7hatp62tf4kop6fnq@nhtboaaaar4v>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <vdar74f5jw6je4z2lbpconpitcevl2mdp7hatp62tf4kop6fnq@nhtboaaaar4v>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0072.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::23) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB6719:EE_
X-MS-Office365-Filtering-Correlation-Id: ce27f519-02f0-4b6d-77aa-08dd5fd35d86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WmZqOW1LZVNMNWJlbVZLREZDUGtDN0ZOMWlWS3pSSlVkWGNnK0NRWG9OOGZk?=
 =?utf-8?B?U0JkMXU5MkNINGdtUHFjMWFZdnlYTjI5RzlsQ1pIeVFyWmxEeDFKT0huYW1O?=
 =?utf-8?B?MWEyQmNLOGkxcFZhTVZhclRXSkZmOTZPV0JWWG13dnB2eHJGMFJoQVZIQkwr?=
 =?utf-8?B?YUVjUmFHSUNYamVvQVZ1Kzg1ZytoWk5ndGJXYzJSV1VxQTAyZDZqcUNRZzVo?=
 =?utf-8?B?aGNNUW9UZDV3YW54Q2FZcW4wc21XOGNUL2tndmJSZDVJMDI3QTR6Y2hSQmth?=
 =?utf-8?B?UVVBWW5LV25XT0luQi83bXB2VlpmNE1ETDdQa0hmQTI4M09iSlNEQzhLclBL?=
 =?utf-8?B?WU9FQ2lSTDRBTVZmQzYrcDNheXA3MkpibVdKR1k2ZElvdjd5bkh2ZHVCK3Vq?=
 =?utf-8?B?RmE0clZTTlpQUklmZXM2a2JFSmdhczk4bEVWVHFUNlJiZ050a2ZMcjVSaXhT?=
 =?utf-8?B?VmJwM2IvcFhwaDNHUGRzajJIcHQ3VTJBWDBJWVNuRDFiWTY2K1I1UXhRNWhD?=
 =?utf-8?B?V0Mycmx2UzZQOFBiVWxHbmJsNStYU2g5azl4RUlQdXhTcSs5dkw4Sk9udHJq?=
 =?utf-8?B?aWsrRmVybnBxOHk4c1dVL0xlTDZKWUtpbHk3dnh3RURxYSs2Qnpzd21wclZo?=
 =?utf-8?B?VitWNHRjYlNxclgyV1lheEwvaUtzZ3JCbWxKSGlYUldDUmMwVHBoei9HMTQ3?=
 =?utf-8?B?bzlOWXd4Vit1NWtUT2RnajFsUjFWUHRoNVg5NEExd0V1RGtvTUdDdzhBYk9U?=
 =?utf-8?B?czU5aFZ2Y2YwMmJPT1FLczBkb1V0U002Zkl6U3ltUm03b25FNTZybytLck5B?=
 =?utf-8?B?MjBOaFJVQXRIUVRiTXZQVEFlNUt3b2dsNnZmL3U1aCsxVDlrODJUOFJ5Q2Ri?=
 =?utf-8?B?dnhaWmJGSnpBMFRQVno3RFBRakphMCtLREFtL3lkbTU0eVFEaFFFVzZrODNQ?=
 =?utf-8?B?cURheGRMcTZnWDJkYXJrTUJIYUpROHMrOTZCNExBWjMxK2I1OEFrWm9OWXRZ?=
 =?utf-8?B?QWVVTjFxSlQvTWRGdTl5Z3krZFhuTjh3c01lbXU2VVc3bUN1bGNrR3BBZVlM?=
 =?utf-8?B?ZnpwRnp3YTZsUzQ5OFBKa08xMTMrRW8wdFA5blIxbU5HMXJNcDNMS3lRM21M?=
 =?utf-8?B?TmpUbTFWc3VRczZWNTYwOGlSQTNvQlVUalAyRXUwQnRWOXdRbXdodEU1K2xw?=
 =?utf-8?B?SlhLQ1NnWitXK0h5M2lBR2VvYThEYTdZcW40RzNEZ3Z2ZXVETW0wYnpBeGli?=
 =?utf-8?B?NElLUFB4ODFxZEhMTGJMc1hVT0RBaThrYW5NRG9jR1d4dE54STUyM2Rna1dp?=
 =?utf-8?B?K29QVjRMYVpQZ2lvTkxPaUd0SGZkSlQ4QnJocDIzTjVyVXhrREFJUlUwRFJ0?=
 =?utf-8?B?cnJBaUVwNnFsUy84dHFQQVU1bXkwd1NqLzZGQWkvUDRoQitBa29pWjV0TVM1?=
 =?utf-8?B?NzExQU1mZ1ZIQUZLaHFRZE03M3MxSjViK2JlbEhHbzhqKy9tT1lIL1g2L0Vv?=
 =?utf-8?B?c05GZUNhelBjQU9mSnRyWm5kbndialJ5K1ZXRzdDSlhSTEkzUjI0NExXb3Qz?=
 =?utf-8?B?bHpGVWZGWXhkVDhaZFU0MlVWbzdMZVBsUTFsOUdQeFVCQmpmUnVxWlpncjhx?=
 =?utf-8?B?SjVIOE5wTHBSUnBxaWdHUS9vOFViaEpPRnNpdE9sUW9CTE5hVTVWOUdiQ1Bj?=
 =?utf-8?B?TjZyL24vMDBlZE96cUFlWFdIZnhDamdnQlRMTHVkSUFRVU9DNFFUMklTcUNG?=
 =?utf-8?B?K1RDcUtSVWxJb2VtQ3BDYldSRzRTNVNQUHlPWW5NYWlnV0IzbUdJRmcyUzlG?=
 =?utf-8?B?OG42OCtnVy9FK2ZiVU1XdnFVSWZuOXNFZncvMVh0eHB5ZVVLdEZqekNWTmJR?=
 =?utf-8?Q?YOtTtWZRUq9Gc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDVKZWZMZVNlUG9wMTh4U1JudUJwZnJ3Mml2L0xmazRuL2VoOGZKbVdZZU9r?=
 =?utf-8?B?VGVnY0ZyWEk2Y3JnU2pzMm1XTzhsdktHYjNVSU1zcWJYR1RUUUFleUE0Y01h?=
 =?utf-8?B?VjhaQ2pzaHpVd0QvcVM0K0ZtY1QvSS85dDFiYnBQRWZodVBSVjc1dHJ3dnVV?=
 =?utf-8?B?YldaNWVEdzBhVWN5UHdmc2JrTkNPRkdMM1NhTmdGZnhuTE9aOHRWUStJU3Uw?=
 =?utf-8?B?VTUzRVkyTy9HUXpoTnV5YWxHNS9FdXJaOUVkTERUTzRhSHFKUTRUT21Kc3d4?=
 =?utf-8?B?TXR4QnhmSG1yL1JnWjgwOU10S0h5U3ZIVCt6UkFMK0ZjVFdSaUZveVorcHlP?=
 =?utf-8?B?MEFoMWlxZU5Ebkl0aE5IMUhJV3dWYjUwaGtzQTdHYzRoelhPb0QyVVFsZ3Bv?=
 =?utf-8?B?QjJXaHUrY1BrUzNCUENDeG02ekVkdGx2Z0JJNEp0RG5GWkJ5ak9PUDNUMDZP?=
 =?utf-8?B?ckRkb0dPQ0VvaFVXeFBxYXZvd0VGQXAxZ0ljMWhUYlBERWEzYUFWcnhGcXRp?=
 =?utf-8?B?RmdGWnhieVBmUytObW9Sdlk1Vjh6ZDcwellVekRDY1NmQjdEVDRSZ2NVQnRQ?=
 =?utf-8?B?RGg4TnUvek5EN1doSmJLZ04xaWNiSHZTcjhoWXF1NUcyNDEyaFNLY1ROaHIw?=
 =?utf-8?B?VDh5dG9kVnRLWFVUNC95b2czMTl6UW40TzNjUFhyWWtxZ0dadFhiNGM3MENZ?=
 =?utf-8?B?Z1JDeC8xblhpdjdpbjVBaHA2Q0lkdVhlRmszQ2tlbGMrMmdmaXpvSU9EdTVK?=
 =?utf-8?B?WnlCekpRKy9Nd0tYa0VhN1UwVTI3aXRDdTArb3F4YWtIUmYvVlNzcWt5WmNX?=
 =?utf-8?B?ZEJGSGxYVFppMndGTkpzdzgzSmN5MlNjNFAzR0FTcC9URWRNUjFiMjE1d1p2?=
 =?utf-8?B?THUwRU4rVUEyMlFkOWl2QVU4MjhUY0UvZ2pwNmxvdEF5QU9qWVRqNlhMTjZE?=
 =?utf-8?B?OWc5OTlXM1FMQnlYRXBaL2lXcDhaT1JoYzhWcHpQSkM0ajYxZkpwNmxEYzJM?=
 =?utf-8?B?VTd3QWwrcDNPeldGQVo4MVl2M2tQR3BZYm9ubURQUWJFenhsTEU1K09XTXFI?=
 =?utf-8?B?alFWdjdNUHphT2ZZK2wvUy9UdG05dzBCUjFpWW1ob0h6bU4rWkpaZEZDT0xR?=
 =?utf-8?B?dUF4czRuSmlSVkNpSmdUQ0o3ck1lZjByV0QxWFlBdFo0ZmpSSlFJVzcwMUtx?=
 =?utf-8?B?RHkxSkRDdktSM2pMMWZhMFVteTV3UmVObTd1dHlQY0dDVkpFMVFrNTBMbTJ3?=
 =?utf-8?B?WkMzejlDaDBiU1hzcldwY1NIclBPQldHWUxCVC9rY2tWN3lyL3B3bTZMU0ln?=
 =?utf-8?B?MlpON2duRDNUT2xWRHBmcms1YVFMS1lCdjl0R3UzUlVLdExjem9tdHpvYk01?=
 =?utf-8?B?QmU3VDIzUEQwVjdmY0hCeXVoTXp4U1NKNG91aDRUWis0cFE2OU1kVG1mMkNC?=
 =?utf-8?B?cGRIeUdRckRhWUJTSFZpMzU4dG1meEZPSVhYLzlNemhFK0NWTTJDNVpKSjZr?=
 =?utf-8?B?SUFyc0hrUGQ4aGpSbE1iOWg5M1JXNzdKdTIzeWRTU1A4MVUrQTVsYjNQMHF2?=
 =?utf-8?B?eTduVngrQUYyRkJGWjduYVFONE1qV3JKT2NnQzFMQUdKWS9pYVZKR2xjdWZl?=
 =?utf-8?B?Vi9JSlVGb0g2VlNUb01UdktCNHlrSm93R1RLdjgzOHZyZmhDR2VpRWxPdHBj?=
 =?utf-8?B?QWl3U09RV2FUM3ZMbk1ubTlub3FlUnlNZDVtVTg1NU8xY2p0MjJETmJZZGdP?=
 =?utf-8?B?Z0dxczRPcFV4K1lzRkNWMG5yWlJPUjR1c2FqWDdNWk9jamdOQmp3RGN0bldZ?=
 =?utf-8?B?cFZJZktqVXdNTktML0xCaWx0c1MrQjMyZDFBTGZMM1czMlRqUDI5dEhIbmk0?=
 =?utf-8?B?RjNEQUk3elNiakpJSWpmNzBtUy9kdGdJVS9MdkJUelV1QXpacGE1Sm8xTVFL?=
 =?utf-8?B?aHZaODU3VExlWjU1bWFucGpLdHkyL1JMNTFGRmZneExtZEkyZzlMNEp6TzF4?=
 =?utf-8?B?eHZ3TnMrSjNvaEZlb0dCaWJQN2hreEg4RmhWeVlReEJXb2dEeUp3LzJldStL?=
 =?utf-8?B?bDRNVjFpVzZJazNEZGs0bnBBQi8xZDdCc3lDOFd3SkZJb1NZUk9FbnJrSVdI?=
 =?utf-8?B?cElieFpOU1BxWjVzTWpETk1RYldUeVdiS3FxM3BDMWpMMUJiS1FvbEd5YWFw?=
 =?utf-8?B?Rnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tW9zZ+CNI/xmF3lLU2WbipreH3l0JMmNRDsAbEagDQPpeVOsWPqo1lZKNYeDbvjeKMk2e/AVReyE2ymAM28vXxKuXdXyaMqXMta+mVWhJz430mCoDqcIBtE4X5DDxl9FvriT1xwtNJ8drdVeSF4PBPqoizNUD2F1/cY30tmDr9+t/KiaqvdsIHHN+nWyXNrmOFEI2Fy+rmlLvFfGI42Ov4sQ/JfIzqEVcsggjm+VOmD4sQ2JFtByGE0AmhlClmzeRf2jJRwqkDqXiZgVYGRN4TTCU+vy0ltwk8N2tjrja7RLD9Mn45EuWYMK6d4ougpHZRK1lJLIlZdwK46GEaQmmVFy6O5PoY1CsZR7F31YFddmmqHp+Frdb2ui8zwWjN++M+e5snpU5usZVDQ0ClRrjrxwILj1N5MljraCyA2ogZnyjy4bZioVX5bkVJhiT9m4IpphKeieqwIyEVUh7x6uMvmsY67QBnIQPIJcMImM8/xyhm+SoVIrpgJhS/GXiS94UncvK8rf5E+tTTxZ0fnsNvAjWE/BnXf4gDLTvSNA+umKEnlLSnAHD3Du0p4AtjoEvBtLuPkAZ8jaeSjUPIamt3WRFiBtmjEOvr6OoNrhKbQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce27f519-02f0-4b6d-77aa-08dd5fd35d86
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 12:59:17.0599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nW8NZqGqWh0va4mALXGP1PsvewBM/bTrRUv3VF/t4XG+FJCErGTfLOBmxltaZDagdz2oBq+uxG4p9xW7gNcpcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6719
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_05,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503100102
X-Proofpoint-GUID: Mhy8Gu4JeHOHrs7zqRVAMpnp9xIuTnHY
X-Proofpoint-ORIG-GUID: Mhy8Gu4JeHOHrs7zqRVAMpnp9xIuTnHY

On 10/03/2025 12:38, Carlos Maiolino wrote:
> On Mon, Mar 10, 2025 at 11:20:23AM +0000, John Garry wrote:
>> On 10/03/2025 11:11, Carlos Maiolino wrote:
>>> On Mon, Mar 10, 2025 at 10:54:23AM +0000, John Garry wrote:
>>>> On 10/03/2025 10:06, Carlos Maiolino wrote:
>>>>>> diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
>>>>>> index fbed172d6770..bc96b8214173 100644
>>>>>> --- a/fs/xfs/xfs_mount.h
>>>>>> +++ b/fs/xfs/xfs_mount.h
>>>>>> @@ -198,6 +198,7 @@ typedef struct xfs_mount {
>>>>>>     	bool			m_fail_unmount;
>>>>>>     	bool			m_finobt_nores; /* no per-AG finobt resv. */
>>>>>>     	bool			m_update_sb;	/* sb needs update in mount */
>>>>>> +	xfs_extlen_t		awu_max;	/* data device max atomic write */
>>>>> Could you please rename this to something else? All fields within xfs_mount
>>>>> follows the same pattern m_<name>. Perhaps m_awu_max?
>>>> Fine, but I think I then need to deal with spilling multiple lines to
>>>> accommodate a proper comment.
>>>>
>>>>> I was going to send a patch replacing it once I had this merged, but giving
>>>>> Dave's new comments, and the conflicts with zoned devices, you'll need to send a
>>>>> V5, so, please include this change if nobody else has any objections on keeping
>>>>> the xfs_mount naming convention.
>>>> What branch do you want me to send this against?
>>> I just pushed everything to for-next, so you can just rebase it against for-next
>>>
>>> Notice this includes the iomap patches you sent in this series which Christian
>>> picked up. So if you need to re-work something on the iomap patches, you'll
>>> probably need to take this into account.
>>
>> Your branch includes the iomap changes, so hard to deal with.
> 
>> For the iomap change, Dave was suggesting a name change only, so not a
>> major issue.
> 
> If you don't plan to change anything related to the iomap (depending on the path
> the discussion on path 5/12 takes), I believe all you need to do is remove the
> iomap patches from your branch, sending only the xfs patches.

Right

> 
>> So if we really want to go with a name change, then I could add a patch
>> to change the name only and include in the v5.
>>
>> Review comments are always welcome, but I wish that they did not come so
>> late...
> 
> That's why I didn't bother asking you to change xfs_mount until now, I'd do it
> myself if you weren't going to send a V5.
> But Dave's comments are more than a mere naming convention, but logic
> adjusting due to operator precedence.
> 

ok, working on that now.

Cheers,
John


