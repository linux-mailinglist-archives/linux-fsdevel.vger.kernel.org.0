Return-Path: <linux-fsdevel+bounces-72231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A383DCE8ECD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 08:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0188B3018F7E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 07:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F9A2FE06F;
	Tue, 30 Dec 2025 07:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nfbPGN9+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZObmXyr3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB472FDC3D;
	Tue, 30 Dec 2025 07:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767081279; cv=fail; b=kd2rgcbbIFhXGA63JpnAuDT9wXGgwuXDg4Sewe8CXwMRNnowyDXt/X5R/MHV0n27h1eHTTOO+ajDh8miQ1Rz+9q7q0X+h9Wz4I205Uacv9TZpuH5F2u4/8U74Uvqpeidqgs82Uk70VPkG3CYzIUxPj1dA38l+FRhoXXhwArzXiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767081279; c=relaxed/simple;
	bh=8OjqF1QcsQLfjcYD62s/EK6N2txAgdE9wyoNqu53z3A=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f4zJN3vDtTY2gRYzgxMo7SiNA9IMYg7glmYyioX7QhIqOeAczmrkDMcubXWuf45kt+P1sXA0PNr/2QzJmIY2CbACNfLaDz32Ufd/hVHJY4t5IKQPppP6Z2jqL1U8K1tPG+jK33JiqzO3ZfYteP+t+V6R/4TDyO7eQJHK6AmZBbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nfbPGN9+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZObmXyr3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BU2xdVK3058807;
	Tue, 30 Dec 2025 07:54:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ZW8WWdC8oVmP1cfTXkklean1XaufbUR7W2FelaDqNx8=; b=
	nfbPGN9+s4vMn+91/zyVASf7SY1GHR5UuGtE2uXk+NfVkOOKxQvDtmEjg15qz58L
	JEHCTfIPpM+sROq3gIOO5YU6R+cmyXbZPb1wtRjs8bKT6k/wShwZtGinLHTAzsyb
	X29fA+WhIf/w+HNY077m7rXQY6VAxjxYg5Mxcz+rtlnHoQderr5ArMQKLplwS4R4
	inrrMppIVCRijPlwSUdcBY0knUWw4U8jE8x8TO+fq6YQCEStKIgXKGq4TZEeEAAX
	gdqO05mIU2HpbOTocVoLB10fvSPjRMTUge9Cmm08D6N4KxwI1sszCZTdtZEmujcC
	4EaruBaUZZZLMVofcewoSg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ba61waace-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Dec 2025 07:54:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BU4D0ZH022952;
	Tue, 30 Dec 2025 07:54:30 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010013.outbound.protection.outlook.com [52.101.85.13])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ba5w7p7q5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Dec 2025 07:54:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yEyCYFKfpdelaishpGrpqV2Jo+TeDBs+HFOUbIcjYxx9yeP6AX3VMmFv42a7Pf1b4KVf3rnP/775v5eJ61J/gJp7qqEDI6lga7IpDIPki/omgaTyV01NDBKQk+wYJk37h+Ks57Bma9eBpWbG0MS1PZkwaf1DZSgWzFh0kWEk2vWdv4+oCDCcnBVbODTaey17j6JIU7/4AasnYD6aiwc5Bot7G7TSO0/jI/mpoY1gQL+vDrr+bdeinaZhAnl4RXgvtMBvELasOrr6fLFwW2UcK9umsQ/UdjT4bBCzEktxBKLqCzIAGIBofJP3/x91fz7lXQrpGTQZo+Xz/QAWCBGgxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZW8WWdC8oVmP1cfTXkklean1XaufbUR7W2FelaDqNx8=;
 b=REuhbZq7rQdem88kj7xgd4oORgT8LVEWoItMuMg78mG06aFrkS6T6mVHQJd8jJbRrjGlndIHEwWhlSUb4rEz753MLpglNzkOx8XyiHUnNeocfsuqmzWu4sTdSqaAzybAouZLoUXOfGMdhzi3GAvzGhY9ta6MilCw940dqNXMVqSyG3LiM+guI94MuHh/uu8QqiWm0nSimDvZJfCd3a64uKRurhZ9YNOzqi176B/d2upwWB3QxbEx34/xJtRAtGhrjnYcmUsOexUSKVfmdM7I0Kb4O5E1g9NZP+XyigChmiBohk54sUxlVWlVqobMw9iRs0m9YGpa4yMqXyEOyTKzag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZW8WWdC8oVmP1cfTXkklean1XaufbUR7W2FelaDqNx8=;
 b=ZObmXyr3XFMdk4OhYJyJuFy+x5q6wFFwxJkEz0EdRELTrIdkW8aDm3Ev2wEhD2ezpEUkT6h5x6Bj/XvJCky8KQZhxha8+6xpFKbNXeL+JCYeLMsJKktjeWd3TqPh8VJFzVXmijjA6hexRnGx8EKqkcTRP+LbVCnraildu4qcnwQ=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by CH3PR10MB7260.namprd10.prod.outlook.com
 (2603:10b6:610:12e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Tue, 30 Dec
 2025 07:54:27 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861%8]) with mapi id 15.20.9478.004; Tue, 30 Dec 2025
 07:54:27 +0000
Message-ID: <cc83c3fa-1bee-48b0-bfda-3a807c0b46bd@oracle.com>
Date: Tue, 30 Dec 2025 07:54:23 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: remove power of 2 and length boundary atomic write
 restrictions
To: Vitaliy Filippov <vitalifster@gmail.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
References: <20251224115312.27036-1-vitalifster@gmail.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20251224115312.27036-1-vitalifster@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR02CA0017.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::22) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|CH3PR10MB7260:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e20313f-f9da-4777-6f93-08de4778a7c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3cwbGdMRnNRZDFTVHFNOVlyQzQvbVFTMHdtR24rY05VY1p6aVN2MHpXZCtl?=
 =?utf-8?B?SzVtdjg2eWY5VDJIL1d5L3lxclhQRS91OXlFTG9MK2ZhNi9CLy9HelJRN1Yz?=
 =?utf-8?B?SzlYV0g5aGZsSFlsWlFOTWpBcy9Jd0RkYk5ENTNJVGRLbXdyTlVyKzg2MlV5?=
 =?utf-8?B?Ky9GZ3lJOThhREo1dEwwcXl6a0pQSkFKejR5M0N4M0IwYVU3bUh6UnM0NXdP?=
 =?utf-8?B?MWFSbVVpWlJza1MwbFY0eDFwOEduTGZ1ZGx1cTJ4d0hDYkQwWk1DNWZ6ZGtY?=
 =?utf-8?B?NGlBemVoMUIyZHRuSjRxblE2aGZId0dsZDUyV1BSWEIvQTZRK2xUd0F2OWI2?=
 =?utf-8?B?S0FhM1dqYzlZcTh1KytjM0grY3FZb1phU1phcXAwYjU3SDl3bHJoRWFGYjRh?=
 =?utf-8?B?VURkYzQyOXRWYmlkQVQzTjNCdnU4bWZEN2pnYVhybkd6aFdoakk3MWk5TExx?=
 =?utf-8?B?Q0FGNmJXbFJCUUVhZVR3Y0VtMmJkWTdjQ2FSNGljd1JEa201bWthWHlzSWI2?=
 =?utf-8?B?UXJmZnNQRzl3azVkRWR3Q25GdmlkTHZ0bTI3NjNzYXdKdHJXNXRFOFJBTS9U?=
 =?utf-8?B?UlU2b3NpWUVyOHRkdm1EcklvMVQ5YlNOWTFrVi9lcHpQZGZaaGdFTzBkdUJP?=
 =?utf-8?B?djEzczNJc1NHckZORHU3LzI0R2NaSU5MQkJJem4rVHJjR00vdmF2WTRRTHlG?=
 =?utf-8?B?OFBPSDNPQjJLWUhNOEFxbWlVT01TUFgrMmxkdERVSk5rUHcyL1hSVElrYVpY?=
 =?utf-8?B?bmthRXRaSTNUNXJ6a0dpaVZrNE1IdXlJN1ZPTXpJTTdSUHFrSWFmdTBaRmNN?=
 =?utf-8?B?d2hucHhDeUVXcHBHaDRBS05GUXhrZmJGYUMwcGFLcTl5YkM2YU1LcnJTSkRr?=
 =?utf-8?B?VmlqTkwybTh0NmxpSEw0c3dBL0Q2ZGswVjRwV1hMUkdhL0NrNjJ5Sk5QcFlq?=
 =?utf-8?B?Z01XMk5xaFhoU0Rxb1NVaFFFQ01jZnFrK1N1OEc0eXNyTlh2RFF6aDE2enRD?=
 =?utf-8?B?YzQ4V1pPOHhkRkowTi9USkhBdkFMVVJYMGtVMm82bk5CYm1lbFIwMXpHdlZY?=
 =?utf-8?B?Q1M1NnhFV3MzWXdRdnNkdWQ5NGpFTDN5dHU0ZGRxTnZzb3R1dklMdGV4U3Br?=
 =?utf-8?B?d3liRGFFMk80OWxEcStvSVN0NFRFQWttVWRwMU5UQXROOG03TkpqNmhFRk9O?=
 =?utf-8?B?amZ1TlR6UC90SjcwK1NBOXVJeENMMmwwUFN1NFlzd1BTaERmd1ZUSXc1VWRY?=
 =?utf-8?B?U3VtbDJ2amFBY1l6WXBnWGtIUmYwdEI5RUdsYjd3dUZoTzVKMFN3dUlqdnNj?=
 =?utf-8?B?RkxvRE5BN0w0SHBScGRzMGtCRUpsODlOc3RKQzNBRGJsUVhZcisvVXF6Q0RT?=
 =?utf-8?B?MWJqQ0FwbXh1UmtacUpLb1BadUVNcVJVQlY3RlVJL0VmR0JHN1l0bXRvU3Jh?=
 =?utf-8?B?bzhXZTZrV2FDeDFBS2tjckMwQmlDMHAwekxKcjRlTmhQNFJOMVRHdStQSU5S?=
 =?utf-8?B?Yzk2UWIrTW1GKzJWZ1ZRVi9PUjQwT1ExTUlHSkNNN2trZ3pJdzNkbnZMZStZ?=
 =?utf-8?B?SmJ2VjFBMDMrT00zMTh2NjF2UDlGRHJyekEvWktGajBMVmFlMDVsZHF2Y21z?=
 =?utf-8?B?cjhHa2d0eGZ1aUVQb2UzVXZERXlkcnN1THlHMWtmV1EwUERLSTRKc1ByME9k?=
 =?utf-8?B?czh0R20zdVFFclV2YzduUm9BdnZOSTFjSnkzMVozaG1qRDlOeW9uMTFQNjNl?=
 =?utf-8?B?aUJ1T0ZrNFFRZnBnUHR6UlA4QTZPVmFOcDlIWXBXOGtOUUY4OFo3MmpPUGQ1?=
 =?utf-8?B?VDZMbU4wQlNUbi8wYUtkaHBoT0V3YlhybGZNYTExRDczQW9vT0Y3ZXJlVGV3?=
 =?utf-8?B?U3Z3SHNORk5SZkMvRVFGR3p6VzkrOG9ka0w2enZZWnFUS3pPSGpjNDQzeG40?=
 =?utf-8?Q?oGoOEl9XnwY0xFlplRMI5Ie1qjn83DEp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXFFMWFNdUdZdDBkcTRmT2ZWd0RhVENTNG5oMHhnZWorYWU5QXVteEEwM2NL?=
 =?utf-8?B?RkhaNUR0RFg4NWtPb3BzeDV4aWcra01xOWM0UzhWRndyQWdPQ1ZBcXVEY0J4?=
 =?utf-8?B?ZEx1L0ErLzRMZDM5bktUOG1jOWVaK3cvWFN4ZjB1MTR3RDdJQVFpdzAyMjMr?=
 =?utf-8?B?Sk83QWJESWkvOTVvZms1MngrVnFsTTh6RW01bWk0UmY4WjNGTGVjUnk3eGFi?=
 =?utf-8?B?VGFuYzlzdVYwNWhLUWwvUTdpTG92QzNNc0RTMWdoR2tHTkUyNFdxWVFXTTRh?=
 =?utf-8?B?dWNxRXVHS0N0aVowdXVXYjJVaE5WYlZhbGZpKzU4MERZbTBXQVljTFN6UTVF?=
 =?utf-8?B?OVF0clVFS0NhWTV4VHdhVXJzY2Q3UDUvUHRCcm96aHBRTmMxMFUzTEdzL1p5?=
 =?utf-8?B?RUtHeFhVT2wyMTRkMjRIcnVTUUkwR2RBbzV1eU5sK1ZKeWh5UjZOYVpKeUNE?=
 =?utf-8?B?aDlhaDVBTk5CaGFjVHdiZkJXRms3QUIxaVV1aUViYXhiQ2V0elJPUGFyT0F6?=
 =?utf-8?B?cmpQRzJlMElQTGtvYUoxK25QUjladW1YSk80emJGSSswd2lhMmtlaHV5cGd4?=
 =?utf-8?B?Vk91b0xLYitnc1RLOWZIRzRwM1pyUDAzZkVnVm9wbkFwTzg3WlBQQWVibGh4?=
 =?utf-8?B?T1lweVRvYUk3Sk9DU0pZN2JvYXNWRTJlTGk3Z3FCRUVQOXVleG9NK3VDZFlI?=
 =?utf-8?B?aldyWmU0T3BqRjdvSGRYWGd1S2R1OFZIR2NlalhnbzRxamNHSFJJSkpTbUpu?=
 =?utf-8?B?bHkrWXhnUGlxR25PdmRDc3VBNlQxQTMwbmR2QmRzUG1qTit3blUrd2FuNVp3?=
 =?utf-8?B?MklYR3VsOFFJemxENGhyeFJxK05XZkFpdmV2My9PcERTUXF0bUsvNHV1OWlG?=
 =?utf-8?B?a25TdTR4ZG05OEJid3ZUczVJSmJsUHdublphTkRSZHJMUWtNSkNxdFF1QXNn?=
 =?utf-8?B?RlU3VlFsL2R6cGI2OXdndGRLQmY1QXVVSExRUUtvRUJ4M2Yva2pqc052aXFU?=
 =?utf-8?B?cU9iTnhVU1dFckhtSHdVZWR3UkVMbmdGVk5JOSthYVo5WUI4WE0rMjJTSmIy?=
 =?utf-8?B?bWxvYkNibThIcVJpNENaYW5qRmw0ckZSYkQwV2V0N01vZ1YwcUVwaFpVa2VQ?=
 =?utf-8?B?enplbkU2eDh2UnNTeUtwNVo2QTZocjJXZzNSTWdjUGFZTzVtVkp4ckQvZS9w?=
 =?utf-8?B?UDFkQzQyeU9PQXBPSDIzblh4amp3ajNtcGpFVVBteVF1NmZ1b1JGK0xrODUz?=
 =?utf-8?B?K0dtbGpPRUJGQ1EwVThKazloKzZmOXVNZy9mTkZDZmlRTjg1UVljRWQxUGNQ?=
 =?utf-8?B?eE1rbk9Xcm5HSzkxMGVweEMvTlNmN2FTR0NPb1hWVGloRHRlbVN1ZUkrazFE?=
 =?utf-8?B?OHVROFl1VHdmS3NGOTVtR3hPMGJZbTlrNHJ2Y2ZEcmlCcUFhM0RSNlY4eGUz?=
 =?utf-8?B?Tm5UV0ZzNGNubnJXTFZ1TE5FTTdhOUFkVU5kWjBaT3dPcUp1VXRxNTFWcTBn?=
 =?utf-8?B?N3F4VHdvOERmOW1jWk4rZkhIeDJ2NjdydjhLdHVHekVPUkhVRTlMMTRveVlu?=
 =?utf-8?B?QnI0UVZKRFRwUWRrUEYyWXd3UDNDNzFhMHVGV1RXSDc2Vk9uYzZZbXM4S2ov?=
 =?utf-8?B?M2dhNHJzQTBZRUdEVzlZL1lNK3NVM3M4UGl6OEpLaFZkcnBRVEFZRjRqMmQw?=
 =?utf-8?B?T05nUGhTQXo2bEFIeXRSYXVNc0piTGQ4THRBSWJQYmg0WUdhWVJIVGhkMmtr?=
 =?utf-8?B?Tm1TOVVaMkJNUWN6VkVBeWNaa2NBanhTQWN4QmRnbXE4amJHVU9wMG5BVzgv?=
 =?utf-8?B?U3cyUzR5bFJDNmFNQTgyNW1jYjZzNDc4R3hRS0ViOEYxdGxMNU8rcGtHSEtr?=
 =?utf-8?B?T2tzVjJrbWtCRkFIaVR1bnhTSDVVenVDbXB3VHI4M0t1Z2NSQmJrOGNMS2c5?=
 =?utf-8?B?dFFnVGlFZVdEbTJ3WTh6Q2I3OHdEcC9sUnBPeVBpR1lKNnc1SGpIcFpyUm4z?=
 =?utf-8?B?bzFCdVliL2VhVlo0MnQrTnp2QmN6cXJIV21kbjJZZjZxMEswSjJidWkyNEgx?=
 =?utf-8?B?Q29xcEI2aGtSTWFhaU5IN2ZpU3RJWm45bUpvRGJuQWdHZ04vbXZ6UVBzQ3Na?=
 =?utf-8?B?Q1lMelZ6eE9iTlZ5cFpuSnk1WkJNNC93VHBxMHJWSDNSRjU3dVplYzZWVW9Z?=
 =?utf-8?B?UmduV3FQOTJRRGZIT05SK0FOZnh2cUo2Vk9lVURaM1JKMGdXbGhXM3FjM2ky?=
 =?utf-8?B?RW5QV0dZNUQweDFGUXFEUVYwaXF3R3ZGeTZoMFVBcUhpc1k1Rk0zWUNxN2NS?=
 =?utf-8?B?ZDVBU0ZYdXlsbTBOK2VtTjA4cmlkWHV0UmpaSUxEQ1EwMTNUbFJGRlJqYzZy?=
 =?utf-8?Q?b4HYsGlwlCt9D1As=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ibX3dX0mqcf27Qt5YMTvx0s5ecDxu47X7zvrlhMrZvD+9LHLqALZoqYRYJKuQan1EDV+1H5KnL6nUGD8PQH7ddcwUMFIAtTTuPMKmMmR/mjEbTJhAF/bz8biBKbLnyW205axp6H27GYsprKYlcM3597TK/0Qa1WmDdybXuPlgwu+MQ/Wxh5Gsm1tHJSCIwSy5Ppxb1jMlsLRC2n1o54+Aa74CU2+d/3OUHCsS7EZBF2CE8tAoBaG7ZWE/t/m0NeOSuYVV2Xvc6JQjqELlqSmi2BAdDG5WD7qoI4Ilvdumnzq68x9p03SSVfwkXnKwSMtzJZc5ZqXbqGgdkhQBJY8cJ9ErOWaAHPB28oOvR6jHrFReB4KadoZocG3R+Dz+QmIHFpMOH3yG3XZIbDB8jXinmWBrAoAaHdrKRdR5Mpq1S+uHdt8ZdtnBYg3ex4fO9ZgGLaN6a2bXwceRTJnqoQIvtE0r8tCZ5CN7oIJy0HNmojhqTr1gso9ocu/DNBZ2xKB2jCyGhRZDPLA/XfmAFLNNLAhUTL6l5wZa135nKhX5Sc8jC0812npqbXnbgOw+EQqtfCUnPSMNsORdf2cm6a/JgfX3Y5+skwcRWZIqkaPuDE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e20313f-f9da-4777-6f93-08de4778a7c1
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2025 07:54:27.1489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LDn3iJTAs8COvc9/K4rnmVR8vrS51y/6c4AjEB7YOwqs7j3LdPGSFP8suoTR9ccJI62xWDmeFCpUeniecETarA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7260
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2512300070
X-Authority-Analysis: v=2.4 cv=LL1rgZW9 c=1 sm=1 tr=0 ts=69538537 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=vnroSBewysfMifUhr8UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: wA0qGikajTdvQdo1e8BE9aJ7xfQxhTCu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDA3MCBTYWx0ZWRfX0sy4Cb9/gCtq
 X8ul6rjA2fia8SJ7LKJTgxI1+nacNHpMno1TS59uNYEq65/fftK7J++LcsobsOwmPykCmEmr1gv
 ZYpYQodlbmEbWkh703917YnkpNHs3bJKwrUymmVx7XAL3fDey6fmkd5Mcn6yd2n13edMoiqlvrI
 EIjMgUuComeVZ0K83XqM1EwH3GN7o6vZo4vcwvLhN5LaiEMZYlyLiYPdxbpI9xl34HBjkSa0oo9
 Wu3meJLGCMo0o2vIszJDM90aCWU6LP6d7ogOlVz4sgphx1vSHxIH1kvT1sYe5nqyhdsGPclpBoA
 ZM2T8/gVn0Crrnq1q7ZMtFNOsp5A4huXwa4sGOPSjoflAgxUhaeBuGzg4p1cI0JjcnHj3jIBc/l
 sdwyHVFmsB2gKJxlQo+pEkurDwcbBvXPWGTEwTU2FJVC4liUJLb5hizWPNw0JFz0Cg6X1oL3g5w
 cEqfbJ860BhcgeR5+JQ==
X-Proofpoint-GUID: wA0qGikajTdvQdo1e8BE9aJ7xfQxhTCu

On 24/12/2025 11:53, Vitaliy Filippov wrote:
> generic_atomic_write_valid() returns EINVAL for non-power-of-2 and for
> non-length-aligned writes. This check is used for block devices, ext4
> and xfs, but neither ext4 nor xfs rely on power of 2 restrictions.
> 
> For block devices, neither NVMe nor SCSI specification doesn't require
> length alignment and 2^N length. Both specifications only require to
> respect the atomic write boundary if it's set (NABSPF/NABO for NVMe and
> ATOMIC BOUNDARY for SCSI).


> NVMe subsystem already checks writes against
> this boundary; SCSI uses an explicit atomic write command so the write
> is checked by the drive itself.
> 

Yes, they do check it - this is a safeguard against being sent something 
which cannot be atomically written. But we should not be sending 
something to the driver or disk which cannot be atomically written. So 
we are providing protection against kernel bugs.

The user should not be concerned about atomic boundaries. They should 
not encounter a scenario where they try a write which crosses a boundary 
(and cannot be atomically written). Hence the power-of-2 and alignment 
rule to avoid this.


> Signed-off-by: Vitaliy Filippov <vitalifster@gmail.com>
> ---
>   fs/read_write.c | 8 --------
>   1 file changed, 8 deletions(-)
> 
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 833bae068770..5467d710108d 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1802,17 +1802,9 @@ int generic_file_rw_checks(struct file *file_in, struct file *file_out)
>   
>   int generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter)
>   {
> -	size_t len = iov_iter_count(iter);
> -
>   	if (!iter_is_ubuf(iter))
>   		return -EINVAL;
>   
> -	if (!is_power_of_2(len))
> -		return -EINVAL;
> -
> -	if (!IS_ALIGNED(iocb->ki_pos, len))
> -		return -EINVAL;
> -
>   	if (!(iocb->ki_flags & IOCB_DIRECT))
>   		return -EOPNOTSUPP;
>   


