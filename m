Return-Path: <linux-fsdevel+bounces-35766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2AB9D80D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 10:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B53FB28015
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 09:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8575518F2DD;
	Mon, 25 Nov 2024 09:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jXLymftc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DW4muBC5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FE782877;
	Mon, 25 Nov 2024 09:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732525451; cv=fail; b=t8Fk5Y0Wg+wNDeYRa8mqxIuqeGtLSX/JyMNNP073BNlUplU6Eg3i+KuUsGOIu17jqybOO60pZxaQt/8oq/4cb11Cg0SnE9HWlVh5N7QxwEE7vtcogW6XSGpc9ea0QaxuDVQp/cFTAERPWIjDig5xA9C8Orz9rZegFMZxrHZrnfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732525451; c=relaxed/simple;
	bh=y3NePkz5sZbuqRpwi6I2ed2QQUf/agf7c16qKV+EqcY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=vEMNRjsX+7iaokEf7y6vbfdYpUITQv4+gHCXHZydfdVwlfSnLrx1tESzazt9EemByH4f6yLU8C76t/JrFgH6BA3KQU2zLoS6TKF8+tyk2Vm5SfRl5Y6G4sIZBbHI7MhvrPC5xfwQPSWUhB8Yqe6qPHVQosfWiNhnT5Rvz5YrA/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jXLymftc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DW4muBC5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AP6gNZo011384;
	Mon, 25 Nov 2024 09:03:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=vhcgQarsSiu0t7D75SZpYlPUJG/Sb53fpUh5m6FNW+0=; b=
	jXLymftcs7IBEYQhqP8BzxFy0TH5aM9PI4OINp7p9OQCQHjsXPmOJx23EIWV6sYM
	Os8jH4sEn+irvKXMGQdxe6YdsplyguvwANUhTPSEaYOD3cAtR0VnlLeVJww5gdpj
	HcKKrcisOOHqj0s71FiP+j0cAPuYY7APoctQiPL+JijebCGcft2uxcX5cNahZmeM
	od8eYPiDgT+/XOpVDaCbiZpslDeve2Mp5woKcKM9YLptMkMmT8OU5Q4efdbtTCK0
	8ov3dnlTqpGtFow0PuCrOoD14LnZCy1AxmMR/9yzTcrASd8wLrSySXlBP+aT+bRh
	U/e9FxXiDifAkc/DCHdTxw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 433869tn3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Nov 2024 09:03:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AP7OqXx004564;
	Mon, 25 Nov 2024 09:03:55 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2043.outbound.protection.outlook.com [104.47.58.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4335g775ea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Nov 2024 09:03:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U6yiSrBhavnqcoF8lHlHieRlX7OqDc9SOnJL+JQ3aJXpiCJiuPOmrLn7YQ6p1lhTpwbsLTuQ1rVw9Rh8YHfMXkT5oWCl5IzRof1T3AIJHtsZJUAX6mbuI01d0R9sRaI17wLH7TXiUT+PUy5vrgNjgQbrP9g5DJILLbyp0jnXnp2kUunUOcPeLHPWSw5Hvl0d0Qst/WbAcHf+VIkHTveUTuISu0hRAwmsqMgiBNz4nlydBjjEwRIxYXZW58endlryizEds4abEa6STRnpn+jKoA46QURL766ykSInbyEIsADQ3STLjOmxDVe8dtVYZBNRcmrWWH5ovgTqyIbI/jH70A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhcgQarsSiu0t7D75SZpYlPUJG/Sb53fpUh5m6FNW+0=;
 b=a8lbS8CVwiuGwXzIDgqwTaeG3i4j6+KDL/FLmLL9jrJSzgpuizOnuH9U6mzvYWaCaVRV+F1BWtvOi8BIVSV2YnhmXKpwZlla2ZCZ4HRuzjXztPgpbi58ac+vlNQGx/TIhwMP3g/MkjH5zs5JJL+WYSIF7Abx0tYNxyZYpQuLXMpVbv67yKPngXJrILLtV3sbIhcND512bz4ogv/LCfjMP8QDNQHPmLKx88oGCdDw267UHd37G71g14FhV9Qx3OOPqgf/r23FeO1VJaN5XpMThR/nHLB4iaNFDtra5TikCTzLiCZ4PChO1N43/jVZPDsQ8ZAQUwqUWdLhPZGxNW0JyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhcgQarsSiu0t7D75SZpYlPUJG/Sb53fpUh5m6FNW+0=;
 b=DW4muBC5yQsRJN9W2x8kvOVhgA3KGcGa5dFphrs89BqZpOPQUNpAAWRUhhB0HFR5DH9jrFLhx450gyR+jX8LqujvAiMkUMI7QGCDSZvorghoJysRJHz3RK3u6uJOn8IqXd5VzsvZQkZ74s7Vqb/FtsxX/BDD8qBkvnsXoZHkG6A=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by LV8PR10MB7822.namprd10.prod.outlook.com (2603:10b6:408:1e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 09:03:53 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 09:03:53 +0000
Message-ID: <aedc8625-a115-47b0-b3ab-1eec9653da42@oracle.com>
Date: Mon, 25 Nov 2024 09:03:50 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] statx.2: Document STATX_SUBVOL
To: Alejandro Colomar <alx@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>, linux-man@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20240311203221.2118219-1-kent.overstreet@linux.dev>
 <20240312021908.GC1182@sol.localdomain> <ZfRRaGMO2bngdFOs@debian>
 <019bae0e-ef9d-4678-80cf-ad9e1b42a1d8@oracle.com>
 <bjrixeb4yxanusxjn6w342bbpfp7vartr2hoo2n7ofwdbjztn4@dawohphne57h>
 <1d188d0e-d94d-4a49-ab88-23f6726b65c2@oracle.com>
 <7ljnlwwyvzfmfyl2uu726qvvawuedrnvg44jx75yeaeeyef63b@crgy3bn5w2nd>
 <20241124133515.cb7u64jccayt3deb@devuan>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241124133515.cb7u64jccayt3deb@devuan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0037.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::25)
 To DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|LV8PR10MB7822:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f820463-d4b0-49a1-7c2e-08dd0d30159d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2x1eXg3Mk9qWStWSGowR0pwUTVRVVMxYVJWRitXN0NQQkVKUU5JMHIyeU1O?=
 =?utf-8?B?UVZhRC9GN1pUaXhhTzk1TW5iNFNtdWoxRm1Ec2lub3dHa1kvbjhMUkVkZUdo?=
 =?utf-8?B?U05qdkQ5YlZxMzRyMkdJWEdHM0dyOG9oVWdPWFJvdDIyaXFSTEx5NWpQOHkx?=
 =?utf-8?B?eHFiaXNBUmxVV1drZGVxSXlVUnlHT04ra1BmRXhBeG9lTkxpZGY4b3FDRHhp?=
 =?utf-8?B?dzhFR1ZHcS83UUVsbE13aTFwOGdZREV5VkRXNmVDUStjVkQybHgvWTc4bWNx?=
 =?utf-8?B?VTVOYzNDZzVuTlhTbFRrZnpSTUxOb0d4bHh4MWIvNDhiWEIwY3Y4QkVIV0VJ?=
 =?utf-8?B?L0R6b3hIQUlxUXU1L2cwV05tS0JQRnAzeUtTRGtiRm42YStXVkdxSERSV0V2?=
 =?utf-8?B?TjZ3UlFBUXNlcG9WVVVRT2ZSK056YnFRYTkxbmJ6SW9MUnF4STV6YmREUlFY?=
 =?utf-8?B?U2ZlZ3NJT3JtWEJKbC9nbmt3Q1ZXeFFnNTZZNENDMzNHMTd4ZUxTOWJGMnlI?=
 =?utf-8?B?S1ozVWFkU3hxSnRrU0NSMGZjODVxTzFuTXh3b0pFaGgwN3IxczZqdTE2SE1l?=
 =?utf-8?B?a0VSL21rVTF5RFpibWNmUW5rSUNoWUpVay9wN1E3b3N3Y3IwY0w0RXE2V0dN?=
 =?utf-8?B?MWlHNmZFMk4wMGxhYjIyUDJEUnVBdnRwdnRoNjVIclM2L3VXUk9Ub3pKYmpZ?=
 =?utf-8?B?c2lMbWhOMnB4aTBGbitORUl1QkRJOExkMEtnVUhPaDViRDJxZWZiYjJjQnQ5?=
 =?utf-8?B?OWhPRTdieVhpakxSVEpzb3V6ZGVLbDk3OFQzV0tSVWpBcDl0aURhWGNrZmtj?=
 =?utf-8?B?THZkZExRQ01FS3FtMzhlZ0xocDJkSURpVW5Nb3NNZXRJNFRHWWF3NFdNR3NC?=
 =?utf-8?B?bms2K2E5aFd6QW9EQVJ1YUQ1VmllTEVES1k0cXVzdWtOQjJRY3l1d09FUXlv?=
 =?utf-8?B?dmg2YVJHV0MyTnFWeGhobGY4RzBIOU55REFqTjUrSjhYTWZjdWZxU1lEQ0l1?=
 =?utf-8?B?cTRSaFZ4S0lYUkgydkp4SUk4bkFFYng0UkZvU04wbHc2TW5qRzdkN0x0SFk1?=
 =?utf-8?B?WWdWSzBzb1N5ZW8wUktNWVBjNXBJWnczd0VQby9UQlVibnBiaGdrSkpPOWEr?=
 =?utf-8?B?anVaazFUWmJBbjdHMzZMNk44QVZpWFVQeEhKcjNPQzlUazAya2RYMWRWbGQ5?=
 =?utf-8?B?YTV2NitFVE1xVVAyT1JxS1I1MHhFZXRiOS9ubEVYREF1ME10TXVjR0lEbVYw?=
 =?utf-8?B?TDZya2Naa1JBODBXRndqYXhTZ2VDOXBsM0U5Y2lrSXgybDZiUDV0bUlkM2Zj?=
 =?utf-8?B?NENhNHJTUi91bjFJc0hyYVA2M0JMQkprTXdVbGRhNm5NSy9reUFOYjh6T2tR?=
 =?utf-8?B?MWh2SGpRVUNoeHFubWZuNU5yVzJIUE5TL3hTV2lMSnNpaWNsaEFPS3ZvY2NF?=
 =?utf-8?B?V0ppMkNrL25zczZ5WDc0YmtCYXA1RDF6dU41VXR2a3Q1elY0ZDl0YzJvaVll?=
 =?utf-8?B?Y0I1ckJ1SzhVYzBTeFBINHh1cjh2MkR0MTR1eGMrRmhtQk1WV0NucjlkUGZK?=
 =?utf-8?B?M3ZtYkprSGJQZHp5TVJQcStpcVBGWlp1Q3hIMFc0aEZyK1JYTWxmSjM3bkFk?=
 =?utf-8?B?MHU5WEpxak5HNGQ4aGNVd2wxd1UvNWhyQUJibmdjYWxqTG5MeXYrNDRBekZ6?=
 =?utf-8?B?Zm1jdkRWSmd5Wi9sVTVIeVdnUDJuWWhLeENUb01vUDBOWHdSeGZUMGJiTVRu?=
 =?utf-8?Q?enh+Iu2GxvxRY3GH5Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SU1rVjNHOThzSmNhNFYvMzYxcXUwQnJPZ0V3elZSLzhSdW4zZTF0QlBuRHkv?=
 =?utf-8?B?WXBvZkRmV2hjTHFaS0c0cHZvZXZIVjRPSlF1WjJkUWphUFM5VXJiRi96WTE3?=
 =?utf-8?B?RC9IRTRHeXdVdDFoallaa2xwVlEySEd6UVpvczdVclBremRueVpyRUF3QUJ1?=
 =?utf-8?B?MTBWOVVBWW5VK3JLRmNCWmplejE2K1A0Y1BSV2Y1TThjTmRVNzcvTVZJWm80?=
 =?utf-8?B?aHlPK25qZ1V2b0RVMTR5ZnhTSWhwMlFaRko3L1hkUGtDLzRMNFFadlo2WGdF?=
 =?utf-8?B?NzBVdHhKeWhFblc2czhxWnUxKzd4MFl3d0dkMXlDQ2FPZUxhY3hETytVSk5s?=
 =?utf-8?B?ODRxWXJrNFRjSnprTDdHWTdRWDByY0RzVFRzRGwvd0preFg2R2w3UDhoRWFo?=
 =?utf-8?B?QTRyMWY4WDlGSVlvckJXMXZQZFRheTRndVFET1VTb1NPWGVORkptSHN0b2Fj?=
 =?utf-8?B?M2QvR2NmdENKNy9wMnZMZStOekdZeGZra0tCOHdFVVhqczhFVmRaYXczSW1V?=
 =?utf-8?B?VG1LbWswaHAyTWlYbUx4eGY0OHZkOUp3cU5CeDFzcFB2amwwVk1jeVRGN20w?=
 =?utf-8?B?VXVVKzBQTzYzZEN4V1hOSElJNW85Yjk3WlRMUFg0bW9iWFc5ZTM4L0luM25z?=
 =?utf-8?B?RHlWd3pBTVdzT3AraDNScFdUL1JscDR5a3ZoTmhPd0ZrTzJ1UERnZXc3eDVa?=
 =?utf-8?B?MWlwd2RzMzdzMDJwTmkvbUNzRHVZOHN2dExDYjJFSUk2ZVRiNUxDY09GK2Ey?=
 =?utf-8?B?V05CM3VvbmNzdGNLT2JzUFEweUZHczI3cS9TYm5uaythQ081WHJvUE5nMEdU?=
 =?utf-8?B?bWoyZVBLZ2FINEJkMXFFZXlRdCtnUFJvV0F5SDJEWVJzR3I1eGxjZkpzbUl0?=
 =?utf-8?B?SzlJcGZrcFF6alVseld6cUwxUmVPSzgxOTE4ZGFxbjVxQ0hUb0V1UXk3NTZR?=
 =?utf-8?B?VmdyNy90cUJ3Wlk4MUQ3dEhxdTY3dzhZTCtKY2V2c1hxclVPS2Zoc3pOaGpB?=
 =?utf-8?B?SGR1a08vWUJ6WWFkM3ljeHIvTUFNTGprMlBiNlNhM1JrNnJQM0JmcC9jaHpz?=
 =?utf-8?B?SHdBZlV4cUFGTm00VVZ6Y1psanpEQWFWMmh0RWxiaVM5Mi9KMjFlQTh0Tjdl?=
 =?utf-8?B?VFVVSnNDOU5UNjViR1pWMU1hZENONkVPTCt1NjkydlpTTnVJMDJ3WXNOTXBa?=
 =?utf-8?B?UTJhbnhKbEhSWllTdWJSbVFxa3RFdUtWd3VkSkphNXlMcDRNVk9IUE1YQTNl?=
 =?utf-8?B?UlhYVTI4ZWRaYVMzRGRZaTcrN09GbTNHNnZMdldyS2ZxUTRCNFBNMWVpSHIr?=
 =?utf-8?B?dEUvLzdXd2hWREU0cENFZHkzNDFWQ0I3Z1JZTFBYMkFKWnlReHZ1UHlKNUJ1?=
 =?utf-8?B?TVlFa082OUZEZ1ozSStiV04vYllHQ0YwUEw1SU5IM1JvQ200WXBWcGJ3bUVs?=
 =?utf-8?B?TFVxbzRmRW9JR2dWallEemF0K1ZSa1UrSVl1Ymc2TzVONitrczFTUWFrOU9z?=
 =?utf-8?B?R1lkc3RwejQvZkhqdm13UkIxTS9yMzdqakpZSUgwVTlCYWpZUUhweTNiYUxS?=
 =?utf-8?B?YzNCUWxEVkkzZzhkS2VHcHZLaC84OUw2UGJ4a21tR09rbkUvWVpweFFJV055?=
 =?utf-8?B?eWhwQVI3OTJlaUpra2NZOEt2QVFjSjdYSWdHTTB6NndqejZDbnZmV2IzSFBT?=
 =?utf-8?B?VWFKV3VqYk1tNEpWSDlhN2NGUXdXeEhtWFZ1TU5BNisvOWR1RDB6WENhSmND?=
 =?utf-8?B?d2t2S2o0and4UzZaVC9yT0RYWWhZZG9EWGJJVTNiM3FvbjJoTWEvODRGZWN4?=
 =?utf-8?B?RTdMYUVGSU1JeC9SRUNyN3QxbWhUb2pWMlMzZWQrYkZwaGNhb2RoVHM4SlJa?=
 =?utf-8?B?bGF3UUNZZkd0UG03eXFCdmJYTSt6dzhDV2tYcVZvN295Y1l4L2RqcElqZU1o?=
 =?utf-8?B?Mm5rQTh4RkErV3B3T21jVlF1Q1djSjVoUVVSTmdpZW9KaWkrSFpXNVNrRExv?=
 =?utf-8?B?TmViR2xVejVGYzJkVkdvc2ZMUlFVcmVrQzJrckZ1aUZTcFhtTVhwK0xHcDAw?=
 =?utf-8?B?WUxyb2pLTm5sVk43MFBuS0t5M212MFovdldQa1ExRktYb1FiZEtEQzZOcVc4?=
 =?utf-8?B?U3RKVy9HWVlpT25CN3hHTlVzV0FDcHhMWEd6Y1IxRVpvUHJJQXYxbWFmbXgz?=
 =?utf-8?B?a1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	B9IQ/ctPaELVVXuq5JE6WpxJKiKKT5pivBakvEUlqsIQmk23icNvatuuay+bJflyaOlvxoZL2ZZoySvHVEAWm5yAuuuvCDDOKE3qcn8iThs0NFZsigeTM1AFRdjBImPQ3ixEua94c15Fix958l1Ir1UXKW4DzkA8FU/QZ6XySPUUgTqq8F1PyndYpdlup4n2AZJMd5Wvgs9LaFM2UFrM3KS3apBc+kkprEAqJrz81rdLNU0g7D0xkC7rRMP+RlWkCh7haxCLNxA+1OlznG7P6ldmQ1k3T3RZZE9AkylRPWPqJ+9o6TPx6mohhwCTdG3DN54GNhBN4IV7NqOg/r/4BDasK+/Czm8AhDb6aXTWCcGKMFy4RDGWKU/xJ2wy5Ed3IlT7jf4yQYfBvMKS9ZFtT0Mo+4LUDnFwGaunqrvPU5zMl02QUJFlhiJ3yEv7YtMEBnP32hzZp7WFMxaIAfZ9EhRi732SseRItG3DAy4rPgL0ikuQeQfvJNMo6cayfwUFY4EvIQYCZ6bTYTH7c03960kGlkEr8ZvIH0YHih9SjPDBxGaiMlQSAF+oaTCK2cxoxB+kRT4H6kTIZLyqE53GAS8BVZVJdat1d0z/jMCORY0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f820463-d4b0-49a1-7c2e-08dd0d30159d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 09:03:53.0757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ti6cY8+BLUYFWs8nB1S5BjyDCmNcCPSX9Ny7nB4uN3Uuy2QLrr2R7JDGUxi7Wj9YDFJQ2agHb12gXFcdY6In2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7822
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-25_06,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411250077
X-Proofpoint-ORIG-GUID: A0HH-1fB5J0XUHMDgAsQSjYd2fUh7wXa
X-Proofpoint-GUID: A0HH-1fB5J0XUHMDgAsQSjYd2fUh7wXa

On 24/11/2024 13:35, Alejandro Colomar wrote:
> Hi Kent, Eric, John,
> 
> Thread: <https://lore.kernel.org/linux-man/20240311203221.2118219-1-kent.overstreet@linux.dev/T/#u>
> 
> I revisited this thread today and checked that there wasn't an updated
> patch.  Would you like to send a revised version of the patch?

Hi Alex,

Wasn't this done in the following:

commit d0621648b4b5a356e86cea23e842f2591461f0cf
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Thu Jun 20 13:00:17 2024 +0000

    statx.2: Document STATX_SUBVOL

    Document the new statx.stx_subvol field.

    This would be clearer if we had a proper API for walking subvolumes that
    we could refer to, but that's still coming.

    Link: 
https://urldefense.com/v3/__https://lore.kernel.org/linux-fsdevel/20240308022914.196982-1-kent.overstreet@linux.dev/__;!!ACWV5N9M2RV99hQ!JYMR3Qwb11MmwlhEqgGhq3ITse9gIJ2sfyZQHyiVMQsb77VfyLGvmdLonkpcrGymbqfkUZE0DnYahWZPrc-vZG1rkIHW$ 

    Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
    [jpg: mention supported FSes and formatting improvements]
    Signed-off-by: John Garry <john.g.garry@oracle.com>
    Cc: Eric Biggers <ebiggers@kernel.org>
    Cc: <linux-fsdevel@vger.kernel.org>
    Message-ID: <20240620130017.2686511-1-john.g.garry@oracle.com>
    Signed-off-by: Alejandro Colomar <alx@kernel.org>

BTW, on another totally separate topic, there is nothing for this:

https://lore.kernel.org/linux-fsdevel/f20a786f-156a-4772-8633-66518bd09a02@oracle.com/

right?

Thanks,
John


> 
> Have a lovely day!
> Alex
> 
> On Tue, Jun 18, 2024 at 02:14:46PM +0200, Alejandro Colomar wrote:
>> Hi John,
>>
>> On Tue, Jun 18, 2024 at 10:19:05AM GMT, John Garry wrote:
>>> Hi Alex,
>>>
>>>>
>>>> On Mon, Jun 17, 2024 at 08:36:34AM GMT, John Garry wrote:
>>>>> On 15/03/2024 13:47, Alejandro Colomar wrote:
>>>>>> Hi!
>>>>>
>>>>> Was there ever an updated version of this patch?
>>>>>
>>>>> I don't see anything for this in the man pages git yet.
>>>> When I pick a patch, I explicitly notify the author in a reply in the
>>>> same thread.  I haven't.  I commented some issues with the patch so that
>>>> the author sends some revised patch.
>>>>
>>>
>>> I wanted to send a rebased version of my series https://lore.kernel.org/linux-api/20240124112731.28579-1-john.g.garry@oracle.com/
>>>
>>> [it was an oversight to not cc you / linux-man@vger.kernel.org there]
>>>
>>> Anyway I would like to use a proper baseline, which includes STATX_SUBVOL
>>> info. So I will send an updated patch for STATX_SUBVOL if I don't see it
>>> soon.
>>
>> Thanks!  no problem.
>>
>> Have a lovely day!
>> Alex
>>
>>>
>>> Thanks,
>>> John
>>>
>>
>> -- 
>> <https://www.alejandro-colomar.es/>
> 
> 
> 


