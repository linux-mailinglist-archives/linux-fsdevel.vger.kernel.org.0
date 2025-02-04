Return-Path: <linux-fsdevel+bounces-40743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6410EA271B9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 13:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E06B0162BAD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 12:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E597E20DD59;
	Tue,  4 Feb 2025 12:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ofdV5L93";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nn3gicBp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718211DC745;
	Tue,  4 Feb 2025 12:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738671648; cv=fail; b=dXUbeamGK+SCqe1MQQjt+LFrlDVDnys7qPcqyD8iwmfPMe+1jyuivoOgZGJTMy3uH05qtl+SWClUMuizgbvhT3jzz1Lhh5ZdOYrsjJ9f6LcOH0NM23SC9J0OHKjuNgwiV1QHOJunBYUf7UwdGGPOKCtj8iNncxVnkTx/xakMKCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738671648; c=relaxed/simple;
	bh=FKj1AjMmL64MIjvwgAqoLIrV0nvgomfNmeqIE8irGLM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ngnVXwgT91v8NhiT5BLSYSpH4r20xhYDVOmFiwFx29bBfQtQVPzXo6LJgQ2ItYZzPogMXSFGXzX6IB8vetHmeJQ+Tigbe2ZvUgwKXVGClfGYtN/kdqEZTVug5PiPbH5nC5vi3+WXw6XZOO3vIaV0VHe9V0j4MQSk/EEyxmBbZ9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ofdV5L93; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nn3gicBp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514BfVNK013676;
	Tue, 4 Feb 2025 12:20:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=zS4jHZ2kt23wEDE+AD09Ak+wiMQ78Zn1s/A9gAKsP0w=; b=
	ofdV5L93gvJ399rvUmWqZ/cbomPqE4fHMFairsqLI6EbSBKcfIFmvEtnnJ9cpq/J
	DCmArta66PyO7PKnPIEsMSXM18/vCo+i94IzSVfXCE2UgNxU3EOmZCK5eKzYUX5Y
	r2Q11EKBAg/psIVvNmKpUGTEGgLybFmgIYdhb9ZrG6HQWaCpxORR5AnFW4hBuSB2
	oXM4iBS77w4YyZAbZRbs+35uHIQvH2VTRqWKoC2oIj8FRgdsyPOKUN1g93T88U0n
	mGZOqva86shQC1+51Y1thoaLmJgqiw3vw0fdMkdLkUHzkZJcEepolTQbniufeBqM
	/WgV1lKuZLJu0RRovKPGZA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hhsv4qny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Feb 2025 12:20:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 514AUpfl030645;
	Tue, 4 Feb 2025 12:20:31 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8dm60p4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Feb 2025 12:20:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jcQBb5UgKGXupAjChF1EjfFOLp4L+wf4yNdB8uvyTBp5G9b6DikkfHBrVf7e3A4oMCmCWhe2NvqhB6+GL6YvSl3wH3uyB1y+tvGiUm3B4IgjE5C1b57LHzsyzhWto/r1OS/caLZFyixQ5xgVQ9FlHhVdxVdMJIv6oycYlMmHy21sQWYpKj0Wmo+Dbowt1NlNToL8TI2FNG4bhw9vnSJysTHO62HYEuTjPZ9UtHUY3SVq0Q8GZ9YC53M6/PfEmt6kayHcDQwmWHz193myeXfXOraql6aizFKumP4JNPghYlDT/SYN2NpUEngZdk3sBsuz5FNJqsRCnHDXM0rjSom3rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zS4jHZ2kt23wEDE+AD09Ak+wiMQ78Zn1s/A9gAKsP0w=;
 b=GlwtTlfncgYj3kxRpo/xTH9HsMuMPbqDh434CSmFnVnzgIsn+0kO/rKSue+E4X5UlFLSqZHOF/mibiUGAq/Yk983JVTSTZbDAkt72iT/OPblasqhMQwJEcIzFPQGbueaBOKWGcqqRPAJGF7OrIemPqCvLKEJtCNgPhUe32VniQENLwScDsNqbCclYMljwtcf6vDrahzrylTQ9wDC3n1gg9FavhsfEN0RQP2WEgZcLH25nmrTGLbOUpUtkbHyVjNooqnxRO45KYtYd4uKLwljmlBQbQI9qUjVQ8Iq0f0WRLl/Zi5aMcpRofHRsRvPyN1LkwKS5s9xai/eJw4QylJqTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zS4jHZ2kt23wEDE+AD09Ak+wiMQ78Zn1s/A9gAKsP0w=;
 b=nn3gicBphlw2SEpnMwTBzBFj0Q9/JQOEnZ4/MDGPrHwPOB6Eql/dwMmu70K9MSZZ4pw8eZUI+3jEgdyX00SB9whq24v9X2kBfnabKn8Ik8JP1FQ/N0R5X4iJtgab/6s95NJg6gKN97MOG0UTCYxTRDzIZSgXBrA26sh/XJnEVx0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA0PR10MB6817.namprd10.prod.outlook.com (2603:10b6:208:43a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Tue, 4 Feb
 2025 12:20:29 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 12:20:29 +0000
Message-ID: <4a492767-ee83-469c-abd1-484d0e3b46cb@oracle.com>
Date: Tue, 4 Feb 2025 12:20:25 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] extsize and forcealign design in filesystems
 for atomic writes
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de, ritesh.list@gmail.com, jack@suse.cz, tytso@mit.edu,
        linux-ext4@vger.kernel.org
References: <Z5nTaQgLGdD6hSvL@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <35939b19-088b-450e-8fa6-49165b95b1d3@oracle.com>
 <Z5pRzML2jkjL01F5@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <e00bac5d-5b6c-4763-8a76-e128f34dee12@oracle.com>
 <Z53JVhAzF9s1qJcr@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Z53JVhAzF9s1qJcr@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0009.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA0PR10MB6817:EE_
X-MS-Office365-Filtering-Correlation-Id: 54a69719-c0e0-4921-3b36-08dd45165012
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2M5M292MTQ0c2NBaHRQVk9BMjkzRmFkY3AyZmZLcm9XR1YyNXJDeFNYaHZ1?=
 =?utf-8?B?d2RtSnR0U3dOem9YWWNqaHU5V0JVN2xib3J5ak9SNHdReTNld3dQUzZhVzY1?=
 =?utf-8?B?YitsdmlKYVlUMDBuSWJXbzhMZ0NXaCtEbFBvbmJRS2lxYkRXMytGeC9KY0hv?=
 =?utf-8?B?NTVqNlRBeDhFT1FiU1ZjOXBBeU5JNHZkenZBQTRKSTNlZTg1SzJlU2VNbmVu?=
 =?utf-8?B?RjMyN25RWjB5R0hiT3VvMnRHbURBQ1hZTUljMEUzZFl2STJtcnVlNWxpQmUx?=
 =?utf-8?B?b1AzenNaeWpxbUZYaHNYbGNqTlFuWnNNM25NQXJGOWF4TlNnZG42V3dkdmlW?=
 =?utf-8?B?UmUzbW9aM1FzZlZqN1BJVC9QV0I5UjRqRC9hYytweW1sUmR6UnllODN1eWlp?=
 =?utf-8?B?TG1KZGw1R2p5dXRiRFhEcEwwbXZTbDc2SWoyM1d2MzAxL1hpdmdjVmxpL3Z6?=
 =?utf-8?B?ajlLS0N6NnNMcEdITmpqKzFSR1NMT0lpTkw1elkxYXNFbUtlOFRKVFNYYWE5?=
 =?utf-8?B?UE5PNk16WmtJaVltQS9XMVpvNlNHbk5TR3Zrb0d0eFVjNzdJNUhvTm9PODNX?=
 =?utf-8?B?bER0QjNyckdFZHgzVGQwT05NbkRlWm5GYjZNbEZSejlqaEk1SDdzQlVwajBQ?=
 =?utf-8?B?WXFOSE1jT2ppSG9udEM1S2tJTlpIVjQ4TXduVHBiWSs5QTg4dTNlaE51Uy9h?=
 =?utf-8?B?c2xtUEQveG1NM2kvK2FDd2pWa3ZDaE1zUFdlQlZ5Z2FlcXA1bXU3aFVPVnl6?=
 =?utf-8?B?RDA1MFJpQThVVW92KzV4bzdUTDRNRTg2cDV3cXdQbDNMYVNtNStrUnNxVDZw?=
 =?utf-8?B?cEhBU1hJNTlZWDJ6dVNqQ0lZNDNDdW5LZkw5NEczVElRSXQ0MW4wNXgyM0dU?=
 =?utf-8?B?WDViNjEvYStEU3ZqTjJZYzNZMEh2dEFaeHVUZW5KTVllQWlBWmJhUDZLendB?=
 =?utf-8?B?RUdmL0dDaGdBVmJkRFlaMzB0emhrOVBvdjd3ak54cGUrajBlM1JlMG9qNTRs?=
 =?utf-8?B?V24weVdDM3VWOStUOFBEak1JSHdjQU9iNndGOFFNbVpCbytTSmh3T2hwUlVP?=
 =?utf-8?B?cGdnWVRob2JxbStGajQzOThqTGNaekR3NnZoS1RTQ0dIR1FYUHN6WFNtS01l?=
 =?utf-8?B?UHpaOGZpQ1RUOXh6cElscXIwdUVMOGFqM2VhdEVCSU1paEplL0IwVUkvSTZI?=
 =?utf-8?B?cVdwOEVOZkNTQ2t5TndEbEExeEVNazFWZEZBK1c0WWwyakFDM2MwL3FobFFs?=
 =?utf-8?B?OXdNTUxobUowRUhpN0g5S3VOdk1FVVU3K2hXZERlMjl2MWRJcURtRGQvYXR1?=
 =?utf-8?B?RnNmNml3aERHZWE1eU1NR0RzK1VvaVIwc3Q0VzhWdExPajYvSlZOVmp6YUh6?=
 =?utf-8?B?dzZmZFhFb1FGb0xtUEpEa0c2NFV5NVNoc1l4TkZodlNNaUNLZ21zS01jSUxK?=
 =?utf-8?B?WnFoVVM2THowY2x1d3gvYlR5MUlkUW1ZZWEwRytmK3BmY0VwcCtaQWxoZVJ6?=
 =?utf-8?B?STdlRGJyU1RwUVpXWDU0VStQbFpSNVBYdHFuVWwxWm8wNDNETisvWGFYd29j?=
 =?utf-8?B?YWFNcWZMK05BYjFvUFJNRDRLQ3lkSFdKc1FMU3hLWUt5MlF6cU1aRlpZcnMz?=
 =?utf-8?B?UmlvNldsK04vUTVFdUZneG05QlgwM1pDYUhvZWZselRjL0ozVVVWQW41UDhm?=
 =?utf-8?B?TEZ4My9VT0piWlBHaUx5Z1ZSRks2dGVsbHJ1L1FYS25DSHNMTFNuU1JzU05k?=
 =?utf-8?B?TElwZUYzZVBkY2VMa2ZlWDlhRmEwdnVrMGdtMGJCVHE1UHAzalM3YVA0T2Zr?=
 =?utf-8?B?NG5qYlZhMFZ5SG9XU09LcGUwYUdjck1MREcyMThEVUJsVjA0ZnFNbE9HTVJ4?=
 =?utf-8?Q?hI3m7K4zjunAD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXdQUm1pZ01LTDEvNy9kUE8rZlcwRUZGWjFTalYyS2tWaitTaGFnZDd5bWVL?=
 =?utf-8?B?QmowS1czeFYrR1JYeXl1VWdHMkZMczlVazFSR0JhUmFUSVpLcXdCSWJCR0Rz?=
 =?utf-8?B?SkR4L1NVKzVCdzZMSFIxRGFIZTgrZWFkbmp0QnVzZGJVZzJ5U0JNUmZSdnhH?=
 =?utf-8?B?Y3BGeGVBMDQ2RkpFb2lvNDJHTjB6aGgzTDMwVEZzaFpDOUkwN0haTUJYTWhm?=
 =?utf-8?B?ZHEveDFZdjVSd2dhRnhEZ1ZHcHl1ZUpGRXBPSFFEa1c5UzU2UE44WE4zSWVh?=
 =?utf-8?B?SDF3cURjeWlMa2ZwZFRzK0dZbzQyYnpPeXpEd1VueDE1SlI5QWpabThMbmZs?=
 =?utf-8?B?Z0pmU2pvYTNtN0RVNEY2RU80WjVYb0lvUEtnQ1dTYXNRZGMvNkpUajlZVFI2?=
 =?utf-8?B?UitIR3pEOVFtbThNa2cyMGhzdXRseVNoaGJhRVdDbStWTzdxOHJ3N2t3UVdL?=
 =?utf-8?B?bXhxZ2NDT2dwUnI4NmpveEloVy91UGExU01jUGl4azFEd3NTaHJVMFAyV2Z2?=
 =?utf-8?B?RnFybCtOcHhSQjNxUHNNOFFPUXNHelY2ZGVjV2o4eU50Y21ZUlo0OWI3K1dY?=
 =?utf-8?B?SnNoNGlzbzVHbStMdTFKZEl0c29ENytoN0w1bXROajhqNXJZTGtINlpGY2FK?=
 =?utf-8?B?b2Y1RitoVXZkU3IrYkMrdXBxcnFaSzZKYllWZlRqaWlxOGV2VSt5bmQvUFFD?=
 =?utf-8?B?dmFYNXBoL0Q1SVp1SzFxaXZVZ3c2cGxLeENMTU9FWjgzT2RLM0orWTVpb3NR?=
 =?utf-8?B?TzZHRVU2YmVoSEM0T3lwWTRPeGxpUTZGeXFqcG5STHNJZWlVRHh4clRYcm9C?=
 =?utf-8?B?elN1ekQ3SWQ4bEJlRVhiM28vcVMyVVR5Z0p3SW0zNk5FWk5CYVZUNlRoMXky?=
 =?utf-8?B?aXhQZ1BWZ1UzV3ZFMW1WcUN5d3JnbVAvUFFPRExHNzVaSnEydUVGRjB5cUtj?=
 =?utf-8?B?TkJpZEV3TkF5NmlSNGVVaVB5VUR4YnFWeTVrU2MvdDl0TEhOeExGc01RRlox?=
 =?utf-8?B?dXVUajBSZmdha0dVM3RpLzZtQXZJaDdmZzFUK3FYSmd1WE1CeWdaVTdadms2?=
 =?utf-8?B?SDlERCtSOWJnWW1GQlpVTllXL0Z2c0RYVDhEdHJVNnY3SVh6b3hNdmpiSVBH?=
 =?utf-8?B?empZQ2FWenRxdVF6V2FwbzA3ZnB1WEQxa2FHVFI2TWxwSDU3SW9rVklHaXlx?=
 =?utf-8?B?K3FPcUtyQnR3cHlSS3V5TUhmNzdSWWxqMjUyWkRjMm94eHh2cE1sMC9EdmZ2?=
 =?utf-8?B?RnJacHJHUHpaUFRwK29ZSXlnL1NUM0RsVmhvNEdnVmhIQjJ3UkdyQ1Y3WnVJ?=
 =?utf-8?B?OEh0a0hjS01HcFI1bVRYZ3hVY21qd3BBNDBSNnN3NXZQQ1pXSmNoV0R1SS9J?=
 =?utf-8?B?OHZwRGZvMHhhT0N4V0FlMklCTS9jOXNQUWFKSzlrV1FwR05IQnRYNWJ6ZDZh?=
 =?utf-8?B?U1dKTCtDTEJyMFpKR3VDYnhXOEh6ZU01TWUyMmFJRktwUHRpMCtmcVhqMm5m?=
 =?utf-8?B?eHZaMFlaVlBaR3J0YjcwV0lXMFRxUUFyaUx5cGR1cFp3NVhjYngwd2g5WjhX?=
 =?utf-8?B?V2hzV01UWGRKQmE4UngyR3lHaDhRMnpSb1ZBdlRFbkhWRkJmanA2bFRxcVdN?=
 =?utf-8?B?NDByeVhmUkVBQ0RSUFNPWmc0cVltTUUrK1Q1cDd0eTdzb01JcVhWWjVsYUhZ?=
 =?utf-8?B?c0VOZGRrZGNhQWI1VVVRMHlrQkM2N0tkNGZNZXJwSHV0QlJ1NVpQM1VnbUFO?=
 =?utf-8?B?L0pGTHRXQ3lET1hsV3dwQVBEcllUaklsRDlJSCtBRFBVQ0xoeGVYNWl0bU4v?=
 =?utf-8?B?ZlZUTDZhMlAwK25CbGlFbTBSVnYyODREVWxNMjdQYjdxUWpnc0VwOGRrK3Vw?=
 =?utf-8?B?KzY0Z09qZ1V1YXZYeHNKYkRDTkpxTk9hc2NkSW9MdkN5RzM1T3Rod1FiQW0x?=
 =?utf-8?B?RFB1NEZrVHM2REppNjR1emJWcG40NFdBNDBwcDBnN3MrcEE5YmxXVlVlQnZN?=
 =?utf-8?B?VXJIanZjU3puQ2NieEpMdmFkSE5oSnU5R05PaWJXTVRlYXlwc1Y1a2RHM2tU?=
 =?utf-8?B?KzVlSzZaSnNBUWNBUE5PMFdBYzR2QW1hVjlUK0NYYWV4WittKzVVM0JadFRr?=
 =?utf-8?B?T1ROZXdkZ0VCMng4THlwNXQxWjBDTkUvYTdHS0lacTlWdTVJT1BGNnZ6aEw4?=
 =?utf-8?B?blE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tpIgsZIyQXADK1ZMCummKe42cbnMkt85uwGPtTUaC0SbFMiYdgQ83k1ikjAS9U1bnV+iBepSGnWJBR/ZGQZUq5H1ZUM9lIVHhcvha2uRc4fwGM3vNlB8HMchsjwKJYBiShQUZ1fV28UKeNWz87trfav/UQwAB1d2xiz9e6HXTN4rvHsaWVdHBDzvi0TPpr7KOOZumj0D1wuOc9Kl7VSsTMhakIvgGKyew6SFJiDsxJFzwooYAihrpfjxk4hCMAOE0mVp5uaLLcpLu3ISm0AhUM5RVQYxwvYnPcxwO2aksY2HQ37W1pDQ/tduMjbeAU9M0kuEBogBsvRxwkoiNgHH97csEkL88JzFn30EpMs1mNOY+9/RujvtPPL/tVVBxkkfzAreabVoseVgcIbTl0GyoJrAGO7A+/PHHS2lcFp36p9cCZM39m/XtWNbC9gQcF41M7aw/f4sPCwT6hTE5coeNE9msQeZAR6d/KnzcSBTZFXrYx5m60s9BFzuC1zdCPJ/hhoMbzR4njszrYj4O178/K7AMG5k3/IQuI48vZAdznP+n9srjNUe+GnbN6RlEeP6+ykREPYCoSFuzq9YWxg1dD7dz1QpDGhlYPdyzapUvB0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a69719-c0e0-4921-3b36-08dd45165012
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 12:20:29.4243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 04CrbuVZiYAuQNwSFqKTWybrLuaT+5GlSM2ePNZKayDICnJFUk3Go0OeCrS5A8nhXmEJJXgKDynlz9vmBVjtPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6817
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_06,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502040098
X-Proofpoint-GUID: qFytuKrQVqU8mNRQwH2v1yk_8wYErhLK
X-Proofpoint-ORIG-GUID: qFytuKrQVqU8mNRQwH2v1yk_8wYErhLK

On 01/02/2025 07:12, Ojaswin Mujoo wrote:

Hi Ojaswin,

>> For my test case, I am trying 16K atomic writes with 4K FS block size, so I
>> expect the software fallback to not kick in often after running the system
>> for a while (as eventually we will get an aligned allocations). I am
>> concerned of prospect of heavily fragmented files, though.
> Yes that's true, if the FS is up long enough there is bound to be
> fragmentation eventually which might make it harder for extsize to
> get the blocks.
> 
> With software fallback, there's again the point that many FSes will need
> some sort of COW/exchange_range support before they can support anything
> like that.
> 
> Although I;ve not looked at what it will take to add that to
> ext4 but I'm assuming it will not be trivial at all.

Sure, but then again you may not have issues with getting forcealign 
support accepted for ext4. However, I would have thought that bigalloc 
was good enough to use initially.

> 
>>> I agree that forcealign is not the only way we can have atomic writes
>>> work but I do feel there is value in having forcealign for FSes and
>>> hence we should have a discussion around it so we can get the interface
>>> right.
>>>
>> I thought that the interface for forcealign according to the candidate xfs
>> implementation was quite straightforward. no?
> As mentioned in the original proposal, there are still a open problems
> around extsize and forcealign.
> 
> - The allocation and deallocation semantics are not completely clear to
> 	me for example we allow operations like unaligned punch_hole but not
> 	unaligned insert and collapse range, and I couldn't see that
> 	documented anywhere.

For xfs, we were imposing the same restrictions as which we have for 
rtextsize > 1.

If you check the following:
https://lore.kernel.org/linux-xfs/20240813163638.3751939-9-john.g.garry@oracle.com/

You can see how the large allocunit value is affected by forcealign, and 
then check callers of xfs_is_falloc_aligned() -> 
xfs_inode_alloc_unitsize() to see how this affects some fallocate modes.

> 
> - There are challenges in extsize with delayed allocation as well as how
> 	the tooling should handle forcealigned inodes.

Yeah, maybe. I was only testing my xfs forcealign solution for dio (and 
no delayed alloc).

> 
> - How are FSes supposed to behave when forcealign/extsize is used with
> 	other FS features that change the allocation granularity like bigalloc
> 	or rtvol.

As you would expect, they need to be aligned with one another.

For example, in the case of xfs rtvol, rextsize needs to be a multiple 
of extsize when forcealign is enabled. Or the other way around, I forget 
now..

> 
> I agree that XFS's implementation is a good reference but I'm
> sure as I continue working on the same from ext4 perspective we will have
> more points of discussion. So I definitely feel that its worth
> discussing this at LSFMM.

Understood, but I wait to see what happens to my CoW-based method for 
XFS to see where that goes before commenting on what needs to be 
discussed for xfs

> 
>> What was not clear was the age-old issue of how to issue an atomic write of
>> mixed extents, which is really an atomic write issue.
> Right, btw are you planning any talk for atomic writes at LSFMM?

I hadn't planned on it, but I guess that Martin will add something to 
the agenda.

Thanks,
John


