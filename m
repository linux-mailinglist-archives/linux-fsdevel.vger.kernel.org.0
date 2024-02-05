Return-Path: <linux-fsdevel+bounces-10316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9DC849B57
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 14:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 913ABB273EA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 13:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FE728E0D;
	Mon,  5 Feb 2024 12:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NpM56kUr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="H9OaLhaD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3D524A19;
	Mon,  5 Feb 2024 12:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137935; cv=fail; b=CS9p5H4tO4k7ZD5N6viQgJJ4jtAhsm8A3484h7/yFAfDVrPLg+CpaA463jNlg89OSKkknSV55uuFi/G8P9sK8SFeHvREm9AhCFIpewblqKSDg/Ie6VjfVGtc+02RHdSIKfjfOjyyUN04tm6B2b+KcFHXUCPP4lixfvA8PzCNdYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137935; c=relaxed/simple;
	bh=09tmCxpFutLL7EddTa66nukK6youlI01fzyTPzrO/PY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C0+AUHFpkYXDyOeST4UL2GMgehc29sCnFg8vd7l/jD5Zud7eX6+uqEWLSHScd06Sp3mZFVg2OcCdvpsMe2WYwmrfagvPkRhxmSJuwOOqOt31fYI25FXQ/4eR89vkzStosZcJF+9nJsHTjAVWkLAryRrqTRCIMN0jWGQVaeN8A78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NpM56kUr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=H9OaLhaD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4159O80g009559;
	Mon, 5 Feb 2024 12:58:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=BORXC/glNi+mjDp3lPEvR778NVlirJThehxn2BeEbQY=;
 b=NpM56kUrNkworomil7U+sdfbRqiJn/Mm7VquSSZaP8fmze028GeWTRIcnhujfyF0lYXh
 ENlAHEPk1N2LMQxB8iHvW0vcxFUPu4vqQX78R1p5LGFkXMQSmWzLX/5W81By18h7lOsW
 2nPcJnyBZJMvCWhWEuXxSXD0FcjmisyQsYeGA4j4gsYBvn3M39v8D/PoVA7TilGe95BM
 nl1zm2GemUYFvNWoHCzjbzRYOVfAEDtWUPOjxbnLcBSbt1Q4ioIscn27HEAlUyof+Q79
 vB2VGeQpmvPIsW+HOBYRFDLiK85ULluWrPQw7hojWhozDeP3DNC2yRYAdQfDiAZBeyGg aA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1dhdbw3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Feb 2024 12:58:39 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 415CUZVM038385;
	Mon, 5 Feb 2024 12:58:38 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx5e4yw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Feb 2024 12:58:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lkwl0iovarMVfNvW6whv0qO+Un3h4veOd3XuIAHXex9PNT8SBGWnFkpPByR6ytUXAJrys65Edi1O2hBloeSad2cVsNQl+zMFpcXUC0hVhzvCQ2so88QUk2BqViKBr8i+ALZtVqbhSaIiLJi+ALeBeWhT+LFMtL9yXS+cy/YHp5enXxfVAH2W1FDerw17M7/D7CKe33q9W7gU91TpAoSzHsLGnsTqk1YsHLcElk3ROahz8haCTOg7IjWGP7yxA44cPU5U/bElYxpwB42xEoyYv3VY/OZINeMtilSWLy4TFJuQQy58PXbZ9YB+XW0GhV5Ruycmig534+vge8Caz32kig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BORXC/glNi+mjDp3lPEvR778NVlirJThehxn2BeEbQY=;
 b=NyCrMWyauIyrP5QnR+0NLArwsVVwdfE0ZMiSC+X6e2OA5U9kQVUFMHvVyD5DLU66zjh7OG+USxCAJu9CkMp+cjrXyMjFCosJOPxW54ZyUDP2lMtoq9qJpEdMtHxkHRHJ7g9Ls0iLs9VBiKmlVDEPlVg46z/DneBkwgDLiR1Y+jJLWPpQWiimg7iDq2gX1kM+L+iH0wh0o9TxRbDq4my7eDj4CSWY9zXzS6ILFJeKYdWHuT7ZNmHOBb+ZHdcyNCv53qz4EqwnoifmWLe9McM62Bp9ib3A97mdu9L7fCVrZ8iN385WoO2vh/wvyAKudzRX2T5zjjnnivydR1XvD2mXXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BORXC/glNi+mjDp3lPEvR778NVlirJThehxn2BeEbQY=;
 b=H9OaLhaDi8ne9mztgD4JA67Y5yqZXeqb6yP3fkBRaecwZRC/Z6gEYRBgKnx+W6jJlCyp+BBCYn8kniPhAJ0FQfQUZjcfdHiRWhhvMOrBKRnEK35YZJiqdW/vksRvCVvmicCfXkLP/DJNWq9ahsSlNbeWm/yPPVeTfqJXw/Okqww=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB6730.namprd10.prod.outlook.com (2603:10b6:930:95::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 12:58:36 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 12:58:36 +0000
Message-ID: <28399201-e99f-4b03-b2c0-b66cc0d21ce6@oracle.com>
Date: Mon, 5 Feb 2024 12:58:30 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] fs: Add FS_XFLAG_ATOMICWRITES flag
Content-Language: en-US
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        dchinner@redhat.com, jack@suse.cz, chandan.babu@oracle.com,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com
References: <20240124142645.9334-1-john.g.garry@oracle.com>
 <20240124142645.9334-3-john.g.garry@oracle.com>
 <20240202175701.GI6184@frogsfrogsfrogs>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240202175701.GI6184@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0125.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::30) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB6730:EE_
X-MS-Office365-Filtering-Correlation-Id: aeddd372-0469-44fa-8921-08dc264a2a47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	vxYyBHUJt10t0qbmRccbydNieWjYmmk7e9RdLTa7XqyvKP55cQFu+vSkjkkeF1gFzbstp/mcr6U14VM3kQ/jagPnquCUu3iz0dEIrbKCAIdKOXJYVEr5aMM2T6EgBybD7xnuZkiWhSarW839NheSYjolWIXFGO35U+kgevaySUqtDAIiOyIO57NigJovk1HXw/P/nPEvWzvVvlVuOsSwf6mBm0QbXOl2apm97f+TwyG7q3MP1mcbckgNfVA+auKYkNmjc+DS45iJyfZ35ru1xtDnWTxj9ki5aEBOA4D2shq4vWlJiE28b2Dm83x7NzgqbwZMswITL3HCdh2Ie0ZQXuI0WZe73igBZqHCIPYgN+K8Tvlc0T23nR1gD7jXEpSngpv9WdGn0I8ayAEipjssKjTGK+fX78TFmPEsP/OuSl1H1K0pW74Os+YWwdv2uQwvdJ+kcQUf65emtPXjEOojpCgCJJrEQJiz0sn4yX/83/BdxS4o/xzOwAW+KJGLwkFk91u9Fe/W/NwshsRrh2T5ntp2+3nnBmZn1+qIZv/8rqc5EKqf0UV8zV/a0PIhwkAatvAWrUPXZmN9VgrsJOOs+DJMMvaFVxAy0dBPJvb7VegE+wHsogDssW9DvutsgDglm0fvTp9tscF44o7uoIfHcg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(41300700001)(31686004)(6666004)(53546011)(6506007)(26005)(36916002)(6512007)(2616005)(86362001)(38100700002)(31696002)(36756003)(478600001)(2906002)(83380400001)(7416002)(5660300002)(66556008)(66476007)(66946007)(8936002)(8676002)(6916009)(6486002)(316002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N3QvNGpFcFJVU2c2STU4YnRud1NoTUVHL2NPdHpFdHRkWm5ucDBoVTZuTVF0?=
 =?utf-8?B?MUFLRHYwM0R0ZnJLZWRlMkptRURmOTd6KzUrdlh4eTIydFRwcUowYnJmbFRJ?=
 =?utf-8?B?RTZFSEJiclErdlQrYThZTndFdHE1ZDVsdEU3Z2NtUDl1dGpxeUJMSUhpekF1?=
 =?utf-8?B?aDF3TXRwZlZHemJBTHdQcTU5UkptQ3JzRGFlREwwL0RCeGwzend3eEhkNHBy?=
 =?utf-8?B?NDZVckVLelJCT3F6OXp2U1FZKzh0ZmtLM2FPaG5pNUVsVWRYYUc2NDRGN0RF?=
 =?utf-8?B?dmo2RWhOUzJCYjN6VnBIZ0tDeGdoUEVSL0t3M3BnYy9CeVFJcjVvaUhUME94?=
 =?utf-8?B?SUhTdWxqTjUwTDBFQ0dhRUVlOTZ6dGY3anFFOFV5Z2hUNDBNTzVBSzNwM1ZJ?=
 =?utf-8?B?M29xRzlVTFd6NmcxSi9FREY0L3VDZzhlQUdhS2tsN2h6QWkyck1hNFc3UzBu?=
 =?utf-8?B?WFk2S0tkYXdCd3NSVFJMTENiNWxVTXlHUUwzRVUyU2YyNFZMNDRoVFpSUDlh?=
 =?utf-8?B?NEN2RFhBb29rM0JYOU4xb2xtTXBkTm1QcmU3bDBodE0rSjh4Ykh5VGpCNitq?=
 =?utf-8?B?bFBBSVg4QUwrRTlHSEU3RURlM3N2RkVOUVNnV2ZreFdHQzJFTDZReUVQOVZn?=
 =?utf-8?B?dTA0YmY0dllvVXJoMGtLRFBXVlJmYlRsNVdKSVFCR3R5L2J0d0pkVEw4Z1pj?=
 =?utf-8?B?VmhsZDNTQWxudkwycW5nYW10bWNncDNLQ25FM3ErTGRuQzZxRFdRVzNicG8y?=
 =?utf-8?B?SUJTMUJxOWxzaDR2TzBua1F4MHhPakpCRE1oblphMFJTZ1NzZW9uV0NuNFNy?=
 =?utf-8?B?cEh2ZFhMMysrSkNqTXVPTlM3RTNhb2NWWW1YanlhMzJWN21NUTV4T0t5TDFq?=
 =?utf-8?B?QVdPYnIwRElLR01wU1NFSVhQajlySHpRelU4R2tCMmdNYkgyUnFxVWFDWXJO?=
 =?utf-8?B?Q2RZaWtQdW1WTDBpWE9BNTdxVzFKSXRMbG5zTnVzUThQSlIrV21DTE5PQ3d6?=
 =?utf-8?B?OTNuVTc4bTlTQlNSbjdHRmFVbDhoUzc2K2grd0ZRVWF5eWM4RGVBbHh5NEJo?=
 =?utf-8?B?TEVwQ3pEcWp5c3VWM3hPYTJNMGhxKzVNVjdCM1ZHSGZRUElVT0w1ODRZeTBV?=
 =?utf-8?B?OU41MndUWWdCVmJva0poUUF5Y3h2K09MLzNueDlrbE5EUzU1UEhudE5MUGlw?=
 =?utf-8?B?Myt5c2RxeDd1b09QN1BpeFRqUm9KUDFVV0pZZWxudyt6a1BUeHNCV3R3aWNa?=
 =?utf-8?B?UE9FRkZVYTRza1NieEFjeG96UGJMeXRGanllc3ArMUtHS2k2U1dNTjh2V2FQ?=
 =?utf-8?B?RXlySW9ra1daSm5XaTZVQmRDYWdpMldzNnlvanFUV05aT3RaUDF4b3FnM0w3?=
 =?utf-8?B?ZlJ3RE9ENHNPeGNMejh6OE84MXQyWUNaVkFsM25XNFRxRE4zU09iOTlOOW9r?=
 =?utf-8?B?MnpMRkd2a1FZM1BFcndqdXo1RG5WRkV5Q0tMQmlhdjEwMEMyaDlwYS9Hd0xv?=
 =?utf-8?B?YmJhbWdlUTJCRHhDTkdMQjdSNzNlV3IvMDUzYytlRFltY0FnamlmRCtNL0dE?=
 =?utf-8?B?bDZlNFpKdzBrelRuM2V2TnF6QnBsTFlJQlJBRkt3OTBMQjJXdzMrSldTYnU5?=
 =?utf-8?B?QzdFM2grU1NKRXJPVlJlSk5QMHRsdHJJelpRMEVjSlpzYXJhQVFCRXZQaFNq?=
 =?utf-8?B?a3RZbSthc0pYSmJ0aE94am8xREZzUnErZk5OZGtyakdkWnE0aVZQVW9CdVIr?=
 =?utf-8?B?dzFHaWRGRlpDODE1eFU5Y3AxdTVxVlNvekM1T3A0Y0preW5VRW9jUytvd0Ex?=
 =?utf-8?B?N1EvOUlzK3RERk1EYVkvMnNuYUR4NnorV3lBdlJ5eDc3WGthMThSQlRvazIr?=
 =?utf-8?B?R2EzUS9uL1dkNzhvV0k3dzk3d09NRmg5L291YTFaUnZiZll4bEdZK2k5VmEz?=
 =?utf-8?B?UjZUMDdUaFd0RVRKaWg3d21zeVVqZVB6ZmszOUgvbElzNjU2Rmx0TUwrQU9p?=
 =?utf-8?B?cEQwRk1xMWZ3c016dUZwVHBSQWlNNithU0pFd04wa3FWUGE0M3VYOXNWakIz?=
 =?utf-8?B?YnowVWdhSXdmSHQyM3BzMUtIUlFPc0lUMG9TalBDZnBuYlMxL0dUL25jeE9L?=
 =?utf-8?Q?bq4McGcwu1dd7lY0vpGYpN1fX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	bvVZR949WCVUnQs94xvl+Ae37EhLb01nuEer4+t1HDp+FSuhhO3lpq0RCs5r0wuJTX/AihdT8ySJVfW1fOmLGCNAGnt7VB+Iyay/6J58sDT0QwJGz1J0wx6/4sViS3ga/y6batBrFDjbfPMAN6cUJGQQDsHUpmyqUuwTKAvVTLxTVrdDABF9K1ntoEAEAK7b4fg6oOjYXP7IN3QzlhyOXxlObw0464+v6ogXEhh4Q5yHqJWJ16ZK/K9WGsynC81HtPX4jHlKjaR5I63hb5dNSljg7PwgZIj8n7PxUPrrxfflF7NhEzhFTkreylkW6/d2fW4ECkKusV9NF2esqAPHCNqmnDh4Fdd5rwUW58Ak+fTN1xxOTDu9bSPhAwWisbkMZh0nANh53gmC7d4oiH4QqZRk8824V6i7XUFn/lp2q57LMQsVRhnGLoWjTqB3Vdx0IFLMDBB3qoZHcskMzfSWjr2mzA80V4ruohHkh4sOOgEWvUw8XJetiefjW2BKEeWk6xsUbEhh/7cBz8GNPbaXA6HzDKj8jVuh2HEyMN4EqnZnXmQBhrudXYAc3hTt1LhLFCHaANxG9uGbSVXYi9qaxcuMl55UcGBU3MS6k8zoG9k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeddd372-0469-44fa-8921-08dc264a2a47
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 12:58:36.0509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wnqRwCSVcEabJ6Dp8F+Nycovwmro4rM5IDoWjhj/Yv4fHU2DGQEJ3Sxc7zlSvPamQ1nav+3tRTk+bV2GCA8Yhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6730
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_07,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402050098
X-Proofpoint-GUID: vWoaa22YWDavXvqJye6pggubXnPj-IKT
X-Proofpoint-ORIG-GUID: vWoaa22YWDavXvqJye6pggubXnPj-IKT

On 02/02/2024 17:57, Darrick J. Wong wrote:
> On Wed, Jan 24, 2024 at 02:26:41PM +0000, John Garry wrote:
>> Add a flag indicating that a regular file is enabled for atomic writes.
> 
> This is a file attribute that mirrors an ondisk inode flag.  Actual
> support for untorn file writes (for now) depends on both the iflag and
> the underlying storage devices, which we can only really check at statx
> and pwrite time.  This is the same story as FS_XFLAG_DAX, which signals
> to the fs that we should try to enable the fsdax IO path on the file
> (instead of the regular page cache), but applications have to query
> STAT_ATTR_DAX to find out if they really got that IO path.

To be clear, are you suggesting to add this info to the commit message?

> 
> "try to enable atomic writes", perhaps? >
> (and the comment for FS_XFLAG_DAX ought to read "try to use DAX for IO")

To me that sounds like "try to use DAX for IO, and, if not possible, 
fall back on some other method" - is that reality of what that flag does?

Thanks,
John

> 
> --D
> 
>>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   include/uapi/linux/fs.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
>> index a0975ae81e64..b5b4e1db9576 100644
>> --- a/include/uapi/linux/fs.h
>> +++ b/include/uapi/linux/fs.h
>> @@ -140,6 +140,7 @@ struct fsxattr {
>>   #define FS_XFLAG_FILESTREAM	0x00004000	/* use filestream allocator */
>>   #define FS_XFLAG_DAX		0x00008000	/* use DAX for IO */
>>   #define FS_XFLAG_COWEXTSIZE	0x00010000	/* CoW extent size allocator hint */
>> +#define FS_XFLAG_ATOMICWRITES	0x00020000	/* atomic writes enabled */
>>   #define FS_XFLAG_HASATTR	0x80000000	/* no DIFLAG for this	*/
>>   
>>   /* the read-only stuff doesn't really belong here, but any other place is
>> -- 
>> 2.31.1
>>
>>


