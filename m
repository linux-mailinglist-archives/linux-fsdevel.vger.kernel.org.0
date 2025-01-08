Return-Path: <linux-fsdevel+bounces-38648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26253A057AE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 11:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 752953A58E3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 10:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D40F1F6686;
	Wed,  8 Jan 2025 10:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BNv0Bh1D";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RUcqpiPs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1851AB511;
	Wed,  8 Jan 2025 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736331031; cv=fail; b=SKDJ27+BBhNlL6faCWHzK+FfkiiUVtxNcKBFbBIP/9SARPzSl/WRShGlB8JmewoCBMzGF/WKciMFX1KHuKXfn2j5Bn0f76lmxtUIHlmVZV/hrUcj3whwBNihFJR8xDfZh1IA8bjAvPEQMnO67JLb4DFsh8VnbUWOHKInCqaWygs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736331031; c=relaxed/simple;
	bh=tMYG9PuT17886jJhGtKMZc6buaO0LtrwPrLe62VvFH4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MQ39sllS352OYOh0HwA8NQbJ2mp0wrci+PT+CiKAncbdpTpG02jsxwtcgwRaUcr6WRkDfc7J24xY/Osj7h/UYKL1t84u9IrIstYzo7Z59NE5lO5zS3hwWqa0tf2HgaE8fZ+xyfm43ciXCnoXrNikO9fCOhPgxA1fQEFy8PtqETQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BNv0Bh1D; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RUcqpiPs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5081tnC7015295;
	Wed, 8 Jan 2025 10:10:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=MaTNLNRjQNGyJRDG5caEAbYKTtpZJzpU1TKpFznY2vU=; b=
	BNv0Bh1DOXxxuSnpJ9AA2ZakcIw7rXC5sXDSDGKKrsvIEfykjmCKYCqdin+Pxc9u
	1l4scBBw2R9PyYG4eiC3E9T4hzHR5VMEjy0JzoQ9umh6NceUWhmUlX78uKgjDT5h
	6MC22DjLO66XTrqJ20vWGxEM1X3cbxyH/taCeB0p24TKT+PN/zKr6Nz8LGOhPXP9
	tWlXxOEVuDEyIl9QPzixSPejXKMPpmy7sUgKqgf1QpbS6ZMcs/p9h8c1ZcwGDkfF
	uGtX+rfRjEvHwBnkcthDKc2FRcxV71FqiXGZ/3MwM2RSiKmQzXzMLqabYhSQKygw
	CFcOvHVG2TLhtylxnHnNkg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xuk06tce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 10:10:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5088rQCi004770;
	Wed, 8 Jan 2025 10:10:08 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43xue9ketf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 10:10:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/xWWAY9zpAN4CW00c5SVaNovWnAZ4zQpCR66cTkdYUgu5gZUwk8E1YzImikczEhl0mj1rJKr5klkIHGvirHrs638399Z2ihTU5CwFEvaU883PsPYOw9CGR6ma/jmu6UBslQnVDmCpWk+owljS783dYwJrrnxFPweLIsaoM04lupig7TBIX6zA3phdjXGglS52ocfgvQn4qy6FGznWEpjCMLgDmaY5l0bImCKrosgSzPKNSXRauIOt7vy/Yb/j3nt0yBgKoH8RzBY5BhOIETgdcWwa3W7h3YHb/eAyuT3bCZwKleMFejSP1LWa6Sy6nk5KTuY4+//FjWUCUaS2owzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MaTNLNRjQNGyJRDG5caEAbYKTtpZJzpU1TKpFznY2vU=;
 b=gDnfClayIQj2OfLFalByoyf+a8ijdplZJoLFadw2VjLm8RiOtI3hnc6c6S+rs/E5GJhf2dHhg3fp5eXk90LDCmR7vi3UPqkAZceBHQNnfVfwGirnPfrWql9M8MJvtRPZspbOZvpzFIOM6mh4Xu6AMdF9fD3bstj0uu/3ouulN2NADfPoHgSq+2hhE0oKVKbrIxXoekbnVEczYPf2nfkBjIjF1NDyQXa2lToPcbwo9nHlDfplw2PoeR9tlEQ8WdnJwxEebmaNocMAsyWJVQ21GOrJZ0fG/UKXE98sroT4os1Cl1NP9Q8QlP76VOavplJ+icsW3JuHsMZ/M36Ce2DJKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MaTNLNRjQNGyJRDG5caEAbYKTtpZJzpU1TKpFznY2vU=;
 b=RUcqpiPsJrexyCAn/L8H5+swWuz2tIoU5aGBF58l1CmEt30Jdy75VdmrHycUoUPOcBvjXHZTGgeAeVr3Wl3eg+nvndOE1ugNMy0gnLFVTl/sV9IV2uwK7cgYsPxPYSfOns9ou4x+mqqTDoOWBl3n1SKO/d8hGCDt9KZQJ3xFqPc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA2PR10MB4780.namprd10.prod.outlook.com (2603:10b6:806:118::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 10:10:05 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8335.011; Wed, 8 Jan 2025
 10:10:05 +0000
Message-ID: <6eb83861-693f-4dce-8236-2fce72168481@oracle.com>
Date: Wed, 8 Jan 2025 10:10:00 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] xfs: report the correct read/write dio alignment for
 reflinked inodes
To: Christoph Hellwig <hch@lst.de>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hongbo Li <lihongbo22@huawei.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
References: <20250108085549.1296733-1-hch@lst.de>
 <20250108085549.1296733-5-hch@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250108085549.1296733-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR05CA0075.eurprd05.prod.outlook.com
 (2603:10a6:208:136::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA2PR10MB4780:EE_
X-MS-Office365-Filtering-Correlation-Id: d342b507-c122-4499-55fc-08dd2fcc9f8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWh0b2NzSGd2WDd1emJCdldDUUFyWW44T0JVLzdMdEFzOHk3bFYxbUQ4dVlP?=
 =?utf-8?B?SWNVc3dNV3p1NlcyeXZlVHJQNkV6bUdQa1lnREVrT0tFK21zUzR5TENUYXVW?=
 =?utf-8?B?ZDg0UkFja01saWtYVXZRa0tNUWNOMFdtVW1QOWR3T3hJSk55WmZFblNJZE1V?=
 =?utf-8?B?bmJDVzRlU1loWFpGbmUxeW90eTlIRkpycm9hbDFUMC9lRHdDd1VtVjI2Q0E5?=
 =?utf-8?B?V0JhVkc2aExFbUs1S2lSRk9HWEUvTGdVcmxzYkJuYWJ5ZWJjcGptd2hSNHZP?=
 =?utf-8?B?eGVPdmFSN0VndzlGTEVVdUh2aHUzdWZrdzBXeTY3K01Id2pvKysyYys3STNQ?=
 =?utf-8?B?V21IOUIzc0JEKzA1Y0FVMjI1Wmcrc3kxSFlzencrY2VSWTF3WURpTCtzSlVQ?=
 =?utf-8?B?a1h4eTBNZWxFaDJFQ3YzT0VMSzZQSk9zV3pSS3lZaERORWpIaFpFcDZ6cmlN?=
 =?utf-8?B?Ti8rQldKNnVnSGRGQUxhaThrNHlGTGIxbG5TVk5aN3Z0a3BrRkhPMTJwV3RG?=
 =?utf-8?B?MytuTzZNZFVvdzJpa1lXWWpMRmxCNEV2SlRyVi9IaVA4RTRPbHN5UXZxenJt?=
 =?utf-8?B?ZWxBUTZ4RUg1azJoOEUwUDZ4UU51T3Q5cW9kdlpLZjdiVUx1T0pMRExKc04v?=
 =?utf-8?B?eTVSdFJGeDRWa2FieWl5UlByeDc3OE43M25mckJ1K1l6cTN1eCtnQ1FESzFL?=
 =?utf-8?B?Y242R25nQXJLSDUvRTFReE95dFNYRS9zMXZvR05lSTl5cjdZTHFwNmVhSC9E?=
 =?utf-8?B?U3prMDdCdlVRaUd5R1NyRnN4L3N4cCt1Rjh3SDAwU3J6UVBvNTZWMmdFM3Ra?=
 =?utf-8?B?Q1UvbU51TTg1R0JvcURqUGpWdTJLMnU4bEQzQjliU3pEZlJOb1Bqa0xockJ4?=
 =?utf-8?B?MDNpUkE4OTFKejVOTVA4VDJ0b2NPd2NJZzJyZUw0cnFsSlFhSUR0Nk1lZE04?=
 =?utf-8?B?QzhTRk5CbGRUMmJlZDVUQURKcnVYZllKTi94eXNiREJ2anlySWp4bGhYbU5t?=
 =?utf-8?B?eHBsRTJwK29MU0NTOXNVR2Y4cDJOdmlkbHErVXp3aWFHQVU1QlFiQUVoY1Nq?=
 =?utf-8?B?QkhXbTJuaUw0UXRTSUY4VUlodWlSWGJkbzdWRklZdS9rNUY1ODlRMW5Wamph?=
 =?utf-8?B?L1FxVUNkZXhCVlIrOHIwblNpL0hrVzN4dTZXTVVuTFA1VVVTVkFHTktOcXpU?=
 =?utf-8?B?dnJCcmlqazNNL3N3NVdmTkpSMnFja25qSHNXTzRoWTJvY0FxeVEwU25iTFBY?=
 =?utf-8?B?NmZ1SDRUUng0T0dLRlFVS1BjR2hqemJ4UlB0MytuK1J2RUJxY2RyM1VLOGRu?=
 =?utf-8?B?UkVvTHVNZENtcS9PbGwvVWtEVE5rU3Evalp2d1lCSS9RdDRlYjJTd05nb1B3?=
 =?utf-8?B?aUUvVlZxK2pycS9pZ0pxS0RGd1ZLb0c4UkVHT0QwLzhmNnkvVUN5a0ZQcEd5?=
 =?utf-8?B?VXpBZ0xDRGdxck1tL0IyUWtwYWI4aEs4b1FIVDhLdU44alhPTXVBVDQrNm5x?=
 =?utf-8?B?Qys1SlR2WURRVjN6UjA1d0wxMWNhZHNvb284QlhDSjQ3VzBVM29POWVHK1lZ?=
 =?utf-8?B?ZHRMS21qYmU0MkNMelZtamwyT2NBZWIxaDZaa25PbzhiR2hMc1V2ZVl2enFW?=
 =?utf-8?B?VVFuaC90c3I0ZWYxcEgxckc2ck9JcDFDRUFheHg1T3pkakQ0V0N2eVN3Z3Fn?=
 =?utf-8?B?d2lGbzYyemEzQ2pBcUU4SFZReW1pOFd5cHJ5TEE2SlBFajBWSVJxajFyOHoz?=
 =?utf-8?B?RG5kZDFqNUM5ZzZ1clM0TGo5SnpVd2gzOHdXbllYMzM0a1UxVU93UDJ0d0xS?=
 =?utf-8?B?SmxabU9YSUoxdFU3MnlJRnBxVVJUZUlPNWZwdHdrMWNMR3pTWEtqbHdDZFRI?=
 =?utf-8?Q?K0dLY3sfoILxq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXk5QmwzRkNhOVp6bnhDOW5aNUtKVE9qM1RqcEVJOVZwei91WnFhZjNoMDB5?=
 =?utf-8?B?Rk9zMXBCNGNoVW5WWkMvVURLbzZZVmJzU2xKcnB4V1doV08wOGpITHJGT0xB?=
 =?utf-8?B?LzhvNE5SbDk1Mm1DSUljRTJncGkzeEltdUxEYXd5MGJTUlNqTFdvSmlTcFNS?=
 =?utf-8?B?Wi9ac25jNUVvZkpSK2JnenFkUkFvUmhlZXZlN1ZYdDE3b0pvNkZkY2lSOVA5?=
 =?utf-8?B?ZFArZkRHdzdBdC9oUFJpaENMWVY0aldFbCtaV0lKY3lPL1pBczZKSGJETXdk?=
 =?utf-8?B?RVRNN3FyWTF1NXY5eGZMQTFUTHpWZE9qZmlSaENGU0RFY2ZHWEN4anQ3QXF2?=
 =?utf-8?B?VUFLUHZKMVhKVG1jRGJlSW5VcXZkb1pxY1B6YlJmZzYyMGJxamNhSyt4ZUxR?=
 =?utf-8?B?a0IwOGhra3pQMlhSb3VJRUdrLzRIQ2s1L2RyRmg2Q28xM0hmVnp3TVQzTUpQ?=
 =?utf-8?B?TVVRRkdlVmI3TTRtSU54SUZNYW1YZEFkZ242QWJBN0ZIdmVaUWtmOFhwcnAw?=
 =?utf-8?B?dERxTm8rNjVNSkNJNU5ZbDAraHBNMUp0L1ZVUHA5eHZJdGU2WnBuQkd0V29B?=
 =?utf-8?B?UEM0RjZmb3dzZ3hPS1NPVzVrY0JUWGpEaG51Rm9LS2NSNmhrQXhGKzA5RkRv?=
 =?utf-8?B?OEtkRUlJRGF4MGU0YkIzMnRZSDlRdFJNTkFqL3prY3ZDajY0M0JEUkdCVC9Y?=
 =?utf-8?B?WHV5QTMzK0JtdEp0a2Y3MlBodnlxUXRSU25VQ09WcXpHNldRcDRWQlg0SVZ5?=
 =?utf-8?B?WjBBbjhacVM0VTRFQ29BSm45aE5xYUhxeGpoMXJXaVNwVmNIaEM5UjM0SjVO?=
 =?utf-8?B?aGlCVlBUU2tzTmljY21kZUdBQTJMYnRBUGVpaGZXTVBoTzBYczJrdDFkNDBs?=
 =?utf-8?B?OG5NbTE0dnIxRFJHYmxCSmswVzBFdlBydnFtdmFIT051UlBTM1JzM0gwR3J6?=
 =?utf-8?B?eTJzdHg4TG40ZEFrOEUzYXlTSFJPMXdUVXZ1WXhPNHFwV3N6NE1xSm52Y2E3?=
 =?utf-8?B?c0lpMkRuSUU4UDFjeU5VTUVBQURvR1RQaDZRQklJVXNybmR1SUZVM0dpSVZu?=
 =?utf-8?B?TExaU0lsb1h4eGUzYlJ0Z0R2KzZZZWVZaWgzVjBXaEEzdzNweEdGRHE3RFhC?=
 =?utf-8?B?MWl2V1M3VnN3QnQ3U21oQUk4VVJUYXhiRUQxOUhRdFphRWdub3kzR3hEa0s5?=
 =?utf-8?B?RDZLSVo1QnFWVlhzSmpFN1NDb1A4NTU1KzZPa0xNWFJiT3ZBNnN1NGhOZ0xs?=
 =?utf-8?B?cEF3dUs4dG9Xc0hzQjJ2Q2xrcjJqN0NaVWxvNm5meG8xYXlGUDFRYXBSa0ZD?=
 =?utf-8?B?TWtCbDVKNFI5bVl2Z2Mxc3RDNWhMUzJ6TmpRZjI3bGx1aE9MWjJlMHNOVHBu?=
 =?utf-8?B?YjNqZHkvZFJSOWxsakZXb2x6VUhlbzhIVmpuV2FEeWpIcnhFQVlQKzNham9P?=
 =?utf-8?B?M0tUbnBWb3o4N3pDb3pOd2FOOEs5VW5tQ25heENOOHF2eXM1UWFNbnM0ZURE?=
 =?utf-8?B?T0pVd1cxZ3Z1NVJKZWtueGVjOUl3RmZPZnN4RmI5eS82VkdocklyTUJGWkdJ?=
 =?utf-8?B?dWl1cFJ3dDFFM3Qvc2dJTUNZQTdCQVp4TTNhRXhTVmFpT29wL3cvYzc0OEg0?=
 =?utf-8?B?dXBYdXV5Q1FxT0NPNERLeEI0OXVDNW9xaU1hSjBTZFlUTHVrelpwaWZuRnBX?=
 =?utf-8?B?a3dBUEZlMlZ4QzFpbmR4WXZrdDRzSWsxYWM1eDdjM1JuRU52V3pIOWZ3ZDJo?=
 =?utf-8?B?TXFVbmtCNW1mWHF0ckYrTkdBeGVjQTFFNm94cnhoVUR1UHpCQ1NMajJTOUxS?=
 =?utf-8?B?T2tpdFduT1Z2bGl6ZHlkODZmZExBTHdKYjNOODNrejg3Q04xd3FFT2kxV1NR?=
 =?utf-8?B?My9hZUR0bXhnQVN4WnFxQlpneHp1STFFSjZkbDRHR254cS9TUGdMdXl0bkoy?=
 =?utf-8?B?c2NBM095NXBTTGlDcDFPYk5VRGZEQjZ4SzY3dnppNzZCZ1BJbThRdFdFc1NN?=
 =?utf-8?B?dk8waHBSTDBwSzdnZU55Z01XT2xhTG92dnphNU8va2JUUzBPRU0xY3BPRjI4?=
 =?utf-8?B?eU9ZMyt0THlRUjQvN3FvSVEyWkxkdXAwU01nMlVKZER1Y3pQRDdpN2Nua2dW?=
 =?utf-8?B?aENxN0FrWTJsVDVPRURQYmtKVy92YTcyYm4zRVZoblp5VDFBaWppVmNaSjhK?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wwX3WoIWRQ0jnennsalW7RHElmQN9d2hc27/PdXWOPf1csqxjD9cnFK8fVc7gcaGDf4BHmTrQ2WjjUxTAlTOIrAxIam7STQQTu2l2NJNKacCwMgDMzLzjAOD4+S87RwfaIOIGt1X6mngMXmDCPBZ0mGGz58k6ZQraJOGudQd3Xp/DfCB+DltCuDErIgs93zKsH3QuXoQCj4W3HtPVZzLWq+ZYo/JawjF8RpgtDKODePBPf1P1Q1PEbMH2XxnrgSxvgKvH6Na6O0cJjo4mgoYUbaMiOJ9XbXSpMGXLoklPEyVAQYhQG/qV5NttpwL92rO8zvKk3vK9RYRy0CZ6w2626jgo1mldyNhBKtzV/t0ooNyBUAgj1aB8U1gJ7OmANt7wx4hnkZxLUwwJzSVI89brz2el2iJ7crRN/6uJs7gGvFZJm6/ikopxlUQBKzq3v1H8PH8ua8ouC9DqBOtQRIdUORsvzInOdwZKVFNAAknk090KbR54EBQz1CcRJVUSY9zxzCmR3A6mFuhmsQ/KhLj/hdcHJYx+d2Tmxn0hj683CD66hhIFbP8n2XCThjgOTGoVDZHjlxUztdHIbDspj90uvGoMsMly+POCihErgEzOYg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d342b507-c122-4499-55fc-08dd2fcc9f8d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 10:10:05.5243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w3vUFIxWxxpPFh9jA7ftcfFCIyuv9z/w4C/XBWhFxTmoRSxBRNslQllGFyt5JnrjnQZs+Ub+8fcspO0GWt6a9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4780
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-08_01,2025-01-06_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501080083
X-Proofpoint-ORIG-GUID: 2B-_M7TQ37Pn8eVMgQmwLlWdAeAZhV8r
X-Proofpoint-GUID: 2B-_M7TQ37Pn8eVMgQmwLlWdAeAZhV8r

On 08/01/2025 08:55, Christoph Hellwig wrote:
> For I/O to reflinked blocks we always need to write an entire new
> file system block, and the code enforces the file system block alignment
> for the entire file if it has any reflinked blocks.
> 
> Use the new STATX_DIO_READ_ALIGN flag to report the asymmetric read
> vs write alignments for reflinked files.
> 
> Signed-off-by: Christoph Hellwig<hch@lst.de>
> Reviewed-by: "Darrick J. Wong"<djwong@kernel.org>


FWIW:
Reviewed-by: John Garry <john.g.garry@oracle.com>

