Return-Path: <linux-fsdevel+bounces-56829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3646FB1C30E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 11:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E2217A738E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 09:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1650824BCE8;
	Wed,  6 Aug 2025 09:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i7OTrukN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vzyb2/kN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0507242D9D;
	Wed,  6 Aug 2025 09:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754471755; cv=fail; b=GcumEJwtu+VPpjElgJrORfVVVMHLxsL2W7Ro47ZGo0voBCQvT+vhvMSHSjCV8hyzYP6u40wmdxh7agNDKxjueC7U02xdgo6vwB/vJrH1CyvrTOTC0C3HJSCiiX/IgB3BscaoQ3Nt/r0PNmVANHLLyQZAklwD18oDdzKPxnKtLV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754471755; c=relaxed/simple;
	bh=icLvU9mcvNCT1P86rkhmw5LU5aTz0Um70TK4aWT6v1E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d4iTLIsb0EOA4DgD69WKCsoXE5zONYYfXDcQc9m01CdI3Trwp00Z2BUkZoEyDX4zc4rlwAvHuGqLdQdvTWPZDQeRUlPyf7zeZBkr1Ch13W+s+yszMZ/yrZGiUbAbcZvvzDNT+Z33plS8byKsStIgLIEKQAJUlo6g4cwkW5gi9Hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i7OTrukN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vzyb2/kN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5768RWbm014655;
	Wed, 6 Aug 2025 09:15:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ZbBWvR4J9F5mxyu9IwA3LdHKFZAgcqE7FL+2+cNeuSc=; b=
	i7OTrukNJbGxR85JzoLKjxQ6/ANh5asnpByX7E+NLZyj+4EUkLHWWwnlMb1YWcDg
	hLjl9F/jDmaCPKo/aktCXo1n7bx23NKqL5x0OCeFy2iAFWoDN6LVT3knadzL49pE
	9WnZSr5a2r5cxzc05eoMjKOV45UCaWWS5Zuu9ka08IrMP+ebmOGeQX0nH4pgj6d5
	H72/XV1jLCnenNHCc//Vx0Gc1AUk3gnLdrdABYsRWKqKCgW6qP8oWJDn2trNqsiT
	JLW9WuUIRYPVDVNWxH6RXXwrT+Yw7cdrDiMvXcaCSnJ4Bgw/pSWcsPMIOLaGdJCK
	/7aQXiLdD6zHQLEVcUkH+w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvd17c5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Aug 2025 09:15:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5767dIiL018441;
	Wed, 6 Aug 2025 09:15:36 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwqs8x7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Aug 2025 09:15:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oM6AK81yM0ea3aKScj6FyvXZ6y2p/U2+H+/Qknc/QAep2nbjLlHA8q0qetkFKVy7qYHzHcC4aROPAbrIa3iHLdJnEEd0D26/yvAY9CfR6C8vLOkZS6PuyiCOZWmQQPxGzzh96uH4IpEK1+nb9vaLuHr5Fe30HsHD6poYxaiHDwpiZPlX3WrBtDGZIieyVdpR794/cDws6fe9VsOq/hKJtBZYkI1tnilJWa6EV54w8WOza0cjob1FrdhbVpa7JQ1gFV7CVLqWKfRPShviyrsVaetAB8WJvBSXtzwCDOpbJ7fn2kZDiCtflbeMf3hAmQW9Aw6Sv5Lm0aSASbGS3jHwNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZbBWvR4J9F5mxyu9IwA3LdHKFZAgcqE7FL+2+cNeuSc=;
 b=ZIsEvAYL09gt7kqmY8IT4JYmvpL2wE2Ow+HelF3pLbVMaOagE7LwxoxS+VXrRF4CSYLPgcO6bcx8jnE8eVYckHeG35yFacYMHdIMa3HJOivZAQPrhD6eKGV29PbQJOrJxd65uan5OigKUidHnW8Zuq6I8bZrrhzWgCxzC5NwSU/IfZhbz/gXZNdHbg59MZFg6FEQubeKf/otBJQ4M0863a9inEXszoikpviuXotZQdQvNMQD+x4NrfGVulL1gg103bEGmP/k/KBmGFje+1ma27oreViK6F3P3T/1agPUc4RZbu5WY6+C9IG0UkPA95Gvaj+J61IvR8qmNxr6FsmIcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZbBWvR4J9F5mxyu9IwA3LdHKFZAgcqE7FL+2+cNeuSc=;
 b=vzyb2/kNzK+YsIJiwx00SMqw/UgjZjWIl3LaZqTZIQOCbokYiUyM+HxQxo9MkZIoMzDeYNKnIe3HWUX6d04HnatrVHu5E7XgPulcJT8wBNDe7SiWFbK/Q69TnbTZnCqQP0O/81XQmOhDjYHoPFSclFv9poPV/94nRSxXs76xkvE=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by BY5PR10MB4339.namprd10.prod.outlook.com (2603:10b6:a03:20a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Wed, 6 Aug
 2025 09:15:34 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%3]) with mapi id 15.20.8989.018; Wed, 6 Aug 2025
 09:15:33 +0000
Message-ID: <32397cf6-6c6a-4091-9100-d7395450ae02@oracle.com>
Date: Wed, 6 Aug 2025 10:15:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] xfs and DAX atomic writes changes
To: djwong@kernel.org, hch@lst.de, cem@kernel.org, dan.j.williams@intel.com,
        willy@infradead.org, jack@suse.cz, brauner@kernel.org,
        viro@zeniv.linux.org.uk
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250724081215.3943871-1-john.g.garry@oracle.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250724081215.3943871-1-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0079.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::12) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|BY5PR10MB4339:EE_
X-MS-Office365-Filtering-Correlation-Id: 700f4d59-cdfe-405d-c0d0-08ddd4c9c2f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWN3K3hLcmxJQmpUVXRkQ0JISXAwQWZFbElPWFRsenJvNlBTN2oyQkV4dU9m?=
 =?utf-8?B?Q1hoRUNkSUtCWkl4dEppYnZEUGl6cyswUEFKNXVRS1FFSDRHRi9LNHFKUDhT?=
 =?utf-8?B?WVcwVWZ3OGltaklhSW5FL0R5dE5GV1Azakl4NkQ4V1hkUkMySXFKSTU0QUgx?=
 =?utf-8?B?c0N1azZxemNieWFkMks0QWcwM2h5aU1RQitFRTBSRnBqRmZyV01CM25VOEdv?=
 =?utf-8?B?ZTVTclJqcFI3OXplYnVqR0FwZkdEY3ViKzAyWitxZWlkV1NWanpwakQ0MmQ2?=
 =?utf-8?B?V2J0SzJ5aFQvWkdnY0lFUTRGZkNKelBqeGNZc01CcXhJVkJ0QTlrQ2pOS1ps?=
 =?utf-8?B?RTViQ3p5WUVUdTMvOUxwd0dwQmhjK05CY0xHclh3N2xRK0hhVVV6bDN2Y2lC?=
 =?utf-8?B?VStZRVVGOWFFNjRCL2pKOERldmNXWDZaemNncGNWaWVabVdWMXExcTg4ZFZX?=
 =?utf-8?B?ejBUSkRUdDZIeDUxSFV3SW1ZbG9XTjhaRVhuenRGTDVjdjBNbUQzL3Y4S0U4?=
 =?utf-8?B?V3pKTVkwUFlDa2JVWlZicW9hcWNsQVdrdmh4MFVvek1sVHZucU5rM3JUdE5B?=
 =?utf-8?B?N1hkY2hlM2VYdW5aWitjRnNsTklmWG1mdzlvZGJXaWRaWUNtQVdMSlB2SUpM?=
 =?utf-8?B?UG9FU05jZkVJV1h1MFlqazRlV0E2NlhYYzA2NDFzbGZtVDhOWGpQZzNJOC9x?=
 =?utf-8?B?Njg5OUtDTG9IWUF0SWhUcVNCVzRyMzlGam9PQTRTTDFoVDVRQjVYdmFHZXR4?=
 =?utf-8?B?N2NWcm9DeVZFbUpCMzBQRTJZSVZML1ptN3ozL1BtbHdyb3lIK3lOVGVKT01H?=
 =?utf-8?B?eDhTTm10cU1wSWR1UTlySW4vNEc2ZE1KeTZGQ1Jha1ZxQUhZTXgyK21TTWFs?=
 =?utf-8?B?OWZmdWxNTHNZdGZGUURMdllyWU02T3JjaW95bkZjZnpwSWR3OXVEbGZyZHZ4?=
 =?utf-8?B?QllTSk9nTnVWbWJqOWFrUk9BU2w3aEh0TXBwQzIwc3FKUjlxVUpYVjVGdGxo?=
 =?utf-8?B?UjNVb3F3UjllbTgrcU5kM253ZmJGSHJpMnZlRlNEWTJ3L2UzRlM3bHZMd3VL?=
 =?utf-8?B?N1lLTDZuT3NZZ3lJeENTRzNPNk5zT3RHTjJNaG8wNzUwVG1LV3dSMHhJK3hh?=
 =?utf-8?B?WkFjbFdiU0pHZzJ6UmkweTFrNTF0M1kvRXl4cURlcmYyWlNraWRvVHhRNmdP?=
 =?utf-8?B?M3FzWXpIbjhIb01jUWZRQmlpMDJUTnBiNUZQZkZ3ZjBGUFJRTU4yMnFxY0Nj?=
 =?utf-8?B?WGRmaUtTMWtxQ01XaTRhL2VwejlHYWFIdmIxRm4wdlVnNGkxaVZqdXpyVG53?=
 =?utf-8?B?VVZubHpMN3ZKK3FJZlVhYS9kMUxkNjB0dmFHM3o5SmdNZ21jSGxLanZiRDJw?=
 =?utf-8?B?cjJ2TG1xcENyOWdNSFdNY0VWdGcycUJMMnAwN3BMeHhKNjVhTjJKZi9CUFZm?=
 =?utf-8?B?OFVVN2ZHVXQyM2N6ekp5eVIyMFFxS29PazV4Nk9HTWIvWUFyNGN0U1NVV2c1?=
 =?utf-8?B?R3RhV1VidENDdXZnVXNnZEdpSW5HR2RCem9kQ1pqTVpNY0NjZ3A1cVE1Q3ln?=
 =?utf-8?B?ZEpkNzNTdG1XU0FrMVQyMWRybE1QZkxZTFJyNzhrcnlCYmZYR25SNTJhYnds?=
 =?utf-8?B?NTdGWFFjVHgwOVNkNlNlNTFKSU5vZGhMT2lzNjZ1ZDRXak9GV0VSUFQzcG1P?=
 =?utf-8?B?Z3BiRDh6QjBtSUozd2N6bVkydHorbDdCQ3kvOGMySEtNNnBRNzd5cWs1Ty9R?=
 =?utf-8?B?UitEUVNKU2FiSnplelgvQ2k1b1FNRys2VFNoQTRKQ3BiZFFodW01dTUyeGVO?=
 =?utf-8?B?Y1h0dUY1aTRmWWZ0MGhNbXk2dmhFbWIxMk81Tjg0RmtDWmpEcTJwU3hxcXVC?=
 =?utf-8?B?Wk4wZDkyU2ZqUktsaGEvTGVBK1dPUUZ6NzRRT1hPbmpjOGtTZWUyREJ2OWlJ?=
 =?utf-8?Q?xOCPj9VEzgY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NU9VTjdobnkwR3VxdUtzc0lMU25LWEhlWmY0YitJWTRucDkrUXFKaGthdmpY?=
 =?utf-8?B?c0oxbitzMlBwaEhic1dTWExLWGtyeGlyQWZ5V1hFbmRXSEFjSUxZRFJqeUt4?=
 =?utf-8?B?MU1XWU5nUnJ6VzhpSGl5d2JnZWVKY0VQYllZWmhRNExjSkYyRTJBZmxzbGRk?=
 =?utf-8?B?SlVmUGdyQ2Q5UTc2NUFtdVRxSzZDcTJWQU8xdWkvUjhOejJPTDlSbENuTjkw?=
 =?utf-8?B?MkQ0VFN3d1JEcmlsYTlTMU9pbndMOG1OVkpRRGtMVFVoSC8rSUFyb3kvN25a?=
 =?utf-8?B?eEllQ1lpVDBkYWVSbWRUZ0cwUjRrSXRQdjhuZ1B6L1ZvdG1qRHdUTk1ydk1R?=
 =?utf-8?B?M1hPN2JOa1JSaVFxVll1U0I2TndEMmNNYWZXTmFHdXYxR1dyOHdpN2xJNW1O?=
 =?utf-8?B?R2ViUEZjSGd6dkc3bUV0WkVDTUE3U2NReXd0cWJ3WUxTTXBmQzk5M3A3bWNI?=
 =?utf-8?B?SFRFRDBJemtteFBGbkVTd1UySUt6bEV0REN6OFR0c1BwMm1QY1JnbnhNaWlj?=
 =?utf-8?B?M0REVUZpU3E1eW4xT1lXNFdzZC8xQjhPc01lT2pBSzRpY09jTWlhVU1IamZs?=
 =?utf-8?B?R2FFeFFoUWlteVYvTEsyWmNFcmx1MmZmM2Vad3JaUkZRWkdnTXhCcEhQSHYw?=
 =?utf-8?B?TGJuNVI4TGsyNThHNUJhbkVuMXVOMFZGd09qeVhGWWhObndhNWRJN0xSdWVD?=
 =?utf-8?B?VnQ0WWFMcytpeFdxZitnSWJoME54cnFFcURWQmtDSFVaTXlheGlyc0Fqd2pG?=
 =?utf-8?B?d2VrcDU3dG4xODVhSUVsb3hJaFdnUFlOaWRsUVVndFVMSmVDTEIvMTJoQUZY?=
 =?utf-8?B?aFl5R3Z3Ymo3RzRaK29CSGc5emZCYlY4UzZjS2hKT3R3ZjhjdkZySEdRcm1I?=
 =?utf-8?B?Ym9JNC82VXU2S3lxOFJHK0pvcFJpRzIzREErck5hSFhmcHBaYjlUbDJCbEhJ?=
 =?utf-8?B?bkZGZ3pyL2p1M3ZrRGVVcjdlR1dkeUJMNHpla3R2R3VPS3dXUEllekhscVRE?=
 =?utf-8?B?RlpqTE9OQTI1SVFNU2grckY2TWZBd3NEeThZc3I5MUhubUZDNVgvQU13N3d6?=
 =?utf-8?B?eElHUXZ5eXBiUFRIV1NiZlIreVlpcEwyM2RiWXlsa000YjRqazJ5TEJINzJj?=
 =?utf-8?B?UTYvanhacVB4c2REVDk3Tlh0WTA2a0Y5SHlpMERJaHcwQk1EUVZEN1BoWEts?=
 =?utf-8?B?ZE40WERvVm12QmpHUkwyT3d5RzRMU2ZoaTJhTEgzUWtKaXFDNjZTWVJjR2Nu?=
 =?utf-8?B?UStDbEJLWmJFbXFNeFdrd2JGQTNwT2JSWW5ieTlIZDlsYXFWZkJna3FJWll5?=
 =?utf-8?B?a3lGaStseWFwRmZ0M1F1M3dZaFNWNDNCTnZ4cFB2OUtJSk5GZFRlNHBuYmI3?=
 =?utf-8?B?Ry9Yeno1dUNOY3JuTHBsL1Z3STZ2ZkVvUVpNcld2U0FveWkwZW5FZEZyMm5H?=
 =?utf-8?B?V3BxMll6Z1FOdlBmbUxBenBBZ3MrRzJnVE5zRFJ4SXpUcVlJenNCTkh1dWRV?=
 =?utf-8?B?Y3FYL3NlbWhXYVJTbTlHcUI1RVN2bGJxNmlvQmw0OXFZRGQwR214YjlYVVFY?=
 =?utf-8?B?V25zOHAyVHljM0dYakxmUEovRy9sS1hYdkMzYUZFR2o0ZU5NRFFwMCtQQ1dZ?=
 =?utf-8?B?UWpzUCtqUU05L0FxSVh6T0pnZkdHUlo1SkZVbWFqNTVEY21UaU90UEZRU3BU?=
 =?utf-8?B?dkRwbXh0bWJ3WnJCK3VMQ1U1R0tyUkhDdDMyWDdoTVA0SDlwMHNzek04Wlli?=
 =?utf-8?B?TUd1MWVySEhuWVpUdm56Z1QyRTVVQXBieEJjT0lPUU1VS1JrQXhqcVNKamtR?=
 =?utf-8?B?ZzIvcyt2NWUxbmFKRyt6SDVEUTlXVGNNLzVDV0k2U1ptSU9LOE9xajNwQmF1?=
 =?utf-8?B?QTM3cmFEc2h5RVRPZWd1bk11ODhTd3kzbVNhdnlnd3NWQnRMVVd3UGpVc0hk?=
 =?utf-8?B?YzUyWmFrMlRVblNXVEs0WGhLTzExTDZUMHVhN084Rm5QUGJZcVFzZG1zaGVO?=
 =?utf-8?B?Wk0rdzBMWWUxdXR3QnNBRnBCaXRseXp6eVFsWnFZeE8vZ0QrekppQ2VrU2JW?=
 =?utf-8?B?UnQycTJTZjFsS1VxNDFldGtJMittNkpqSkFXWGJISmRMT2FPTFRXMkc4eHpL?=
 =?utf-8?Q?9PxZNbNsUAUyyHqCYmYDWT6pg?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HeeaZgO07B6K8DHK5F8XJ+jYYYG8PyAdZuFDHxrEtTwYQytoYmLhsTjOR33qDlP4sWUFfECoqS0IMCrNntg6M0dIVTO7w7ly4cYT2QvSxEn+kJKXWlaA/cXw83qTR494FXdSSVcnQfSaLTftLqR6QesUK5siSbkCV7iTT5vBvYLPAseNxCQCfhMYvkE0ccgZ99eJgeqc2pIky568m4DZ+inX9/6r/TUhTQtFVmtSt4uQ+lPnjQVhcav5O3KqkE5ri6ASLcZ8OoemlAm7LvVr22/xdDnWaUzRcOtQjdMRrMPu3jscA1lndHbtP1r8PSyWknYAD3GvpGXNq6evfR9eY6E0bSnPjftOINZr5nA809ypQZm/v6XVLMx2FHZGoqh3q4ARitW5JVBXOl+ELJLxf5OjBDfGODfQOV1y8aFKZLIVdejahXgJRoDU9i2/5GlaeFrRqpZSEyBH8ks5V7vtCPjfW2orw6bWJDbkN3wwUPGohgeqE6VhoinUKkBu2dOs2b9QilSIYSX0FamAwDppBi+BEbMiiE/lmCOqAgYfPrRSD88ZLKz774nwBBAIHdDy00X82xGZPubNLxFR19PAYBCVHZuwkVlbEgMnS7hkV1o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 700f4d59-cdfe-405d-c0d0-08ddd4c9c2f6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 09:15:33.6486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8cg1u/JYyyOS0l0P3yisMJQs4+9h0sSGvoZRNF4ovmtkrH5oMmUIL2rwbfVkueNpDPJ2+Fmf85kGp6InfRVelA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4339
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_02,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508060056
X-Authority-Analysis: v=2.4 cv=fYaty1QF c=1 sm=1 tr=0 ts=68931d39 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=_7Kw5TVXa_LTN56mlfEA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12066
X-Proofpoint-ORIG-GUID: jqEW5AuU_XBWMIcVCT3kuP_0Fv6NPEOY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA1NiBTYWx0ZWRfX+BtG71NwmTDT
 kCs4Ltm6rGrs1nTo42lkaxaT46o3XfAqMgvr4oD10M/HrhoTE95CIUT8SOrY+Kj9cBQVZtxkl5j
 5MeMfwO6xWDFNJ7AN31LafxMSZtTGmfIfyfbTJJXl76+5Yx3ZiLW9E/rp7in8ZPu9PztUIcBq6H
 sa4a8D1nQ8GPECGW1wWavWe7VieReuYWGUr7MP+JG4JWR8aC87NmIEM8EQCjverH35HGlgNI8Lc
 RbZEMvyei5AdfapsghFGoseMgWLwcsr3jXXm1zFHIltSSvTVa75XDb6/jKR+eZt8aoajz0Tbp3w
 MlhjmTFohfr8mRKQzeYwq//wiJuggnX5U46HDmWvfp4k46p9GzaG4l8dPZS8crHqmZ1lahOn3E0
 TfOQBtve8zIR0aJL/VfMZPve9rDvwIy0bDJQMvyFjvt/W87KbdKvCH3/DUDuS7jzADkYn2V1
X-Proofpoint-GUID: jqEW5AuU_XBWMIcVCT3kuP_0Fv6NPEOY

On 24/07/2025 09:12, John Garry wrote:

Hi Carlos,

I was expecting you to pick these up.

Shall I resend next week after v6.17-rc1 is released?

Thanks,
John

> This series contains an atomic writes fix for DAX support on xfs and
> an improvement to WARN against using IOCB_ATOMIC on the DAX write path.
> 
> Also included is an xfs atomic writes mount option fix.
> 
> Based on xfs -next at ("b0494366bd5b Merge branch 'xfs-6.17-merge' into
> for-next")
> 
> John Garry (3):
>    fs/dax: Reject IOCB_ATOMIC in dax_iomap_rw()
>    xfs: disallow atomic writes on DAX
>    xfs: reject max_atomic_write mount option for no reflink
> 
>   fs/dax.c           |  3 +++
>   fs/xfs/xfs_file.c  |  6 +++---
>   fs/xfs/xfs_inode.h | 11 +++++++++++
>   fs/xfs/xfs_iops.c  |  5 +++--
>   fs/xfs/xfs_mount.c | 19 +++++++++++++++++++
>   5 files changed, 39 insertions(+), 5 deletions(-)
> 


