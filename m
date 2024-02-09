Return-Path: <linux-fsdevel+bounces-10952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAF084F56A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 13:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E07C71C21B4C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 12:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F256A374EA;
	Fri,  9 Feb 2024 12:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R7en5hYn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pM/Pmhv4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DB22E62E;
	Fri,  9 Feb 2024 12:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707482882; cv=fail; b=QnNKlVllbOggGczsvFSVGwUawvJgyrRoNAXGh7LD2S4TQeBhpW0EUEqCPNh91nfpHKLMD1ew6T2hQhxmHCDbg+F3ZPBLcCUqUMZ5T7eeKmSHK+AqoB3Sbg24KG7mwVZgWwRhJDG64pSYDvlb8/vr7nukbeRY8iiHGYEcCyYm6L8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707482882; c=relaxed/simple;
	bh=UCTrJD4Paw0QmDyGjsN2H5e7D1hhBCJ992IKEFHhDfs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FBGbu2r+EtSsxmdpPLCnBN9VgaIUuMVN5K2sIwah8OtIgBAFxBTjPVJa2qSKNHZk6YjGdlZ6ri4FK/nO3V4YsRBbmhLPbzCI2Y2TZ74ZEA3FdIVsCZnNPGOkL365N8ZRxmq19bTrAnDGSeWKXBnYneJBnzHX44ATjzk8Rnw9BsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R7en5hYn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pM/Pmhv4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4194xZMp001407;
	Fri, 9 Feb 2024 12:47:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=W3iaXT3qJIttlp2NSbNDvyx8LaIOhpnbLrDuuGDV6b4=;
 b=R7en5hYnUJ+bgd6rFIh+E3cjKGI+IWd0pEEdlbBWKsjZ32FHFoJkZ8rVLloZ3pnvqPcE
 isS1KvM+G+0O9SpJtwoMbCI1jHf8lPp59hTgx0yKRCSl2uyArKKHV6z8cXc8os5vOm51
 2p76nFxxmq9oUP75coLuvE4cpDhZJoN87FVwfqan4KscqCRX8VCCddUNycYl81Aa4arz
 kEDv9HEm69Ur+a6dzijhmyZ5yEW2+VFnpFgHyJIXRvrpZgxZwayyZSLpHFmni/IHVkxa
 JJoOwqVAxCXRV1DvZ/oYON2zuC60xAwvjPVlO7Wbq1lH8qUJ39uiWt+gvEb6u8IDWPhk fw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1dhdqedc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Feb 2024 12:47:44 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 419Baqt0019657;
	Fri, 9 Feb 2024 12:47:44 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxjddg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Feb 2024 12:47:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8LTf7qqXT1UaD1SWjqhrVNlJjKJk5cQ409lqrrVOi82cMLx+G5i1IERlsKxoWiwPhRF6hBm4165H0CyB2nPeZLt9PSY3/NDIWdwN4GULtIByFAxDs5rLNSt1A+BEfDRQ0c5I1I7aNr6zBByVZNzAVY2x6M1om8jdfoyenFW62wDXEUsuKB9Q03iL3N4LACo17fFtqTLsAhfGZFQLXgIWHPXbyiD0bYR2bbY2pykfJhXBRV0AbPfAmIv9rvJ5h1szsX97Sf4cgOgVOHm/MBpyDSjIOHhEwhSD+BTE+Vf1BMvzUytymhSsM9F1/pO+HZH0StaQvxpou9FxjZoBCXF1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3iaXT3qJIttlp2NSbNDvyx8LaIOhpnbLrDuuGDV6b4=;
 b=AyWlqVPWobtVsA5QzISYP5U5dBZio2zxGVVwioHCIpfCzpqbQUsDNXrHcaj7RvD7dzU4LxwZpQQ5vvhWGIZ161IpJ7ZfRrcg1CiCSQ7DXCcBBuuCaUrF6a2Y5e9gkHzIT1BqJ/VEBriUU3pclMAk5/RrOKX75s8zuTdSBdW5ZG1FHIdErMNzdn4kBFZ+5TG2PMLWCitrOp0lYUvtMZOwnfBv5RWSy+PQWTGX5CNZE95iPGNPiVyapDVrkxMQWbUoz2KAUL6ZlurY0ahgJukksIzX+YpnuZ7f0aHJCtl9ZPmwm9/Dob0rXIjfM/Crf2fR7aN6PKG4ItmQkPnwsqDsxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3iaXT3qJIttlp2NSbNDvyx8LaIOhpnbLrDuuGDV6b4=;
 b=pM/Pmhv4wnS56wiXvxWaQ+KqR5U1/81rkHgg3qVVC64IHWWI79L07Gpmxg+eDJrlJCg2uAI5Xz9+tfaOcmcxdzp8OzkUAvGBj82CbD47lQ97p3MuDPKdD4QA20B3FSn+Lnd0HTH1psm70msnmCDSbU6J4SKGpmCVftFDcIx8RN8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB5022.namprd10.prod.outlook.com (2603:10b6:5:3a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Fri, 9 Feb
 2024 12:47:42 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7270.025; Fri, 9 Feb 2024
 12:47:42 +0000
Message-ID: <20836bd6-7b17-4432-a2b9-085e27014384@oracle.com>
Date: Fri, 9 Feb 2024 12:47:38 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 5/6] fs: xfs: iomap atomic write support
To: Dave Chinner <david@fromorbit.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, hch@lst.de, viro@zeniv.linux.org.uk,
        brauner@kernel.org, dchinner@redhat.com, jack@suse.cz,
        chandan.babu@oracle.com, martin.petersen@oracle.com,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        ojaswin@linux.ibm.com
References: <20240124142645.9334-1-john.g.garry@oracle.com>
 <20240124142645.9334-6-john.g.garry@oracle.com>
 <20240202184758.GA6226@frogsfrogsfrogs>
 <e61cf382-66bd-4091-b49c-afbb5ce67d8f@oracle.com>
 <ZcGIPlNCkL6EDx3Z@dread.disaster.area>
 <434c570e-39b2-4f1c-9b49-ac5241d310ca@oracle.com>
 <ZcLJgVu9A3MsWBI0@dread.disaster.area>
 <a20b3c07-605e-44c2-b562-e98269d37558@oracle.com>
 <ZcWCeU0n7zKEPHk5@dread.disaster.area>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZcWCeU0n7zKEPHk5@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0014.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::26) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB5022:EE_
X-MS-Office365-Filtering-Correlation-Id: 3861449f-6bd0-44d4-a82a-08dc296d4e3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	dJhFsLjBXeFYhTJSV5efcbvstgibQOIdz7kaYDMISMTwAklm+fGYTvBuD9hIrXKW7BZpI0YFLta2+cD7GmgwRwqoaEE4jatW6aD2IKSIk6YOUH5te5PhPkqZElzjUuNe179MqWe9unCQVzRgR3ia/Smor8OVM4tMu+41R9YrgexhN3227SsOgqsQ8s+1FGoss7y13r9Qtm3nSsp72XIhRAEhskAysAaIeDsyykV28isnULFO0DhYCIlrpJNx/YjhuHQTYWmN0L+JwqpEgda3bMGbrYf/M6324px7mEyLqLwPaOi3wzqP2POC9TMF5cAqZnjqB+EJkcJEvkTJiU8N54seZC6TKWAeKP+VEltARJprGmfUec+PylrZQ15q1cAHR42R/hc2DPGEyQl3SWEMmYMWUbYeBVXHExlZ+19T4haFWPJv32xOqItx4iYQ8J0Evkm+NNWrCBCJbNrxodpmfnOPedhyU6hA6op+MnvV8ZcSgKDeIkJgtwTOjwdbpia7LQ2IzbJ3HAi8YBIhUZHjl4pCqs6U79qMakpT0fB/mvRcQk6ZNL4XcUSVmrhCOb4U
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(39860400002)(366004)(346002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(38100700002)(31686004)(41300700001)(6486002)(2616005)(6512007)(26005)(2906002)(6666004)(6916009)(478600001)(66946007)(66556008)(66476007)(316002)(6506007)(36916002)(83380400001)(66899024)(31696002)(86362001)(36756003)(5660300002)(30864003)(8676002)(4326008)(8936002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QTdYeGZDZ0JGeVRRd1Rib3FYUXprQkJsRGpRWG9WMXN1eG5FNHZxTTR3S1Z3?=
 =?utf-8?B?Zzl4R0JkUDhadEYvZW5qWHpRRUZVNlNwbmpuKzM5MG1vY3NmSlU5KzdqTFVV?=
 =?utf-8?B?dSsvanNkS3d2eEQvcEhxVkFYVFpncTFmaUlnOW1Xb2F2dFJRUUxoSFFtMk9U?=
 =?utf-8?B?K1lYQ0k3Wlp0THpNeXB2bGp0TkhJd2ZhTzFzOEpZSVQ2ODQ0cmV6YWVwV2d3?=
 =?utf-8?B?cGFHd3EzcW9jdzBHU2QvQ3M2amxCZEhPUDJpSG5EdVgwQXZjSWRJMDV0RHJ1?=
 =?utf-8?B?S1h4WGJBMzlDL3lNTkkwNVI0TmdGOGtjZGJacTBHSEhRRXVta2YvVEJacjRF?=
 =?utf-8?B?SUJySVgxa3dRMnR3MXlRV0txTnlPdDNNU3c4U3ZOSDczS1BNUjdvQkdsMmV1?=
 =?utf-8?B?YTY2aGN4T1VEZTk1M3U4dUd5UHJDVVFhUjRnTnNjVHpjb2hRRXRpTld2ekgz?=
 =?utf-8?B?dE9PMUZqRDVDclJ5eFBFS3BzbkthZUJ1enYxSTZ3UWpwN3BMcUVkbjRJUGJI?=
 =?utf-8?B?MkpVU1d5emI3ZXBOanpXM0QzbnBvWXBDMElTOUZlTE80QmQ1MzM1N3plZUFp?=
 =?utf-8?B?bk91T2kzVm81RWFuRDVBenUyL3F5NjdBalJXcmc5Vlc0eDN5SFdMd2RpWk9m?=
 =?utf-8?B?aW80SktkeVFXZDJ4cjcyRUJNam43STRJazZrY2FzbWhLYVFOU3JnZGVIUGxD?=
 =?utf-8?B?bE5uUmFKWnhLQ0FZWVYra2lJSFBHNlpxRmRacFJESy95Ky9HcHVCajNEeVk1?=
 =?utf-8?B?Z3VOVmJyeXZ0ZDNhbTVyYkQzN0I0dVByazR4MnlMT2VNVUV2QmY5VVNGVnVC?=
 =?utf-8?B?RDl5aE4wZEplWFVBT0g1WEpXZUlnSmtzL2t3QUFHeUV5a3A2SlZ6NjBuZUli?=
 =?utf-8?B?dTNhS1hRK0RCQmxxalIwK2sxVUpBaHdsYXBxSC9pMi9XeGVHU1YxaktSU1No?=
 =?utf-8?B?YnpOUWs3aTN4Tmlzanp2allGMGVaTWtnVXlHYi9EdGZ6djVSSzZFbUQ1QkFN?=
 =?utf-8?B?TjdBR0RhU2tlbFJCL3UrbUh0QlgzMStqSXZjalZzQmpZUkVVZDZ2YkswS3hJ?=
 =?utf-8?B?QnVVV1ZhTklQZFJoTFlDQ0lRcFJlcXVNbHBzQ3lPQkp1VS9pNkRNWlBvOUVO?=
 =?utf-8?B?QmV0YVI2NHJDaWNkK2h4M0tBSzdxRkxzY1Q5V29VK0x2L0JsTW9qcVhaNVFz?=
 =?utf-8?B?V3ZsVjRtakZvN3hOTE5CY2IxVTVZeG9wOEIrZllHK1laRjBndzIrSEJvOGZL?=
 =?utf-8?B?TnROUWlwMko5OTJiR0lkSHhDUk9PYjlTaXVYVkRRZzVsUE1UOStmZTVxWXpD?=
 =?utf-8?B?bHBYZXJhYUpPVksxdjhrajZ5SXo4bVlzam5MdzVPVGhYd2ZubWNmYVBYc2lv?=
 =?utf-8?B?L3N0OFBXTS9taUovMDAwWDdTN09LY2o2bkhPWG5sWEE2QVA1VGU1NDJHWW54?=
 =?utf-8?B?NTFVQlI2YmdWY2lsbHBvbVZIRFh0YUlBNWxNRFFkVERmSm40cEJMY0g4QmRE?=
 =?utf-8?B?U2Q4RTA4bGs5VnZsNWY2aDBMNFR2Y0VsOFdqOXIzblZFcEcyc2drT0FndEVr?=
 =?utf-8?B?TS9ZdUVLNGtmdXNneEFLRXdkT1d6YnRzaTVndFNrN1ZpS0E4aURkNmY4UHht?=
 =?utf-8?B?b1l4NzdMS2pGWTJpakxndCtCem90NlhpNnZPMUR4QU9xYzJkRDVXcWVmN1FP?=
 =?utf-8?B?V0IwUHRRcVlPQW1SL1VjZDVWckdmaUs5WVdOQ3EyU1ExRHMzWG9Fa3FMbEFZ?=
 =?utf-8?B?Ymg0dllzYUVKaFBPaU00SW93NSs5K0kzc0lCL1RTMlFJaGpBMG16SEM5Y3p0?=
 =?utf-8?B?VnAzVlNHWHd4SzRCNFNKTmxTWGNldW5WcFZsQnpESExWQlJhZFFBbjNXbkZi?=
 =?utf-8?B?Zml6bGp2WFdSZGh2cHJ0RXR2N1FRTnJ6V2RVSVFoV08wREt6dzBGZnUxSmZY?=
 =?utf-8?B?ZDk2WXY4alhLRnJYRUhsYXljR0cweVdxcFpIUDNRQnMrY1hyTjZhVFFtckZJ?=
 =?utf-8?B?eHkrTWdtMkJDSjJ4V1BWZkNPRkdYS0V3a3BNMkFEYjA1TGJBVU5OblB5YTVL?=
 =?utf-8?B?Vm9sRnVHZDVWTmJuWTZjbCtGM1paZXM1VkJjQ0s5N2ZZTDYzZndGc1JINHZI?=
 =?utf-8?B?WW5Md1ZsNDRtRWZQVndCYVd4UTAvSkJkd2NPWmpoZ2hmS1QvOXdRMllhZkEr?=
 =?utf-8?B?cVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	mq+s0GfxKXFJ8TL7ZhTnfzIsgcslZQLLCxt3n9QSpxHCkBbn/G2qeiIIPMdGJqeF2t32Q7oeK80RciKDetNqsk6afzGzhHV0liBkitVM1RuH6pLFonhNy2GK+KD2mIXxC1MeSmVEJP0zB3D5/5+R8qL2IiQoGXyoeLjHdXqvE9TGn+GGZz3aZcj2HABb8mp1ySKMLLIyROESc4gVAzh0hNuNjYLaGU2oDtjOspfNKa7hrI9TzqS6DHTNktjuT8XKYAzvoYLYhCtBApn6qai9/5w/H3xN+8KU1kRJUpuV0ZKYMRNrcAQti6Q4+TEm40DubY+HVmAQ9gHYWb6PETB2g4gUgMD26UGkkNH0G8oWl4pxWNr/QDd0sxhSSIe4aV438e9xbDHuXjs6g0jHYdf8beWANmW15zifmDtTFf+GX0CL41F+Cfu79XLrgRGAD7CRC18c4dJw/E5kRXsrqdgo5bbUwGwy/FIZ86E/zaxzvQ5oKARF5HiFhy7nuoRxjHUzOiHrlndfbTOIaS6eGilfuF+dBp1o4RntyyZHdFlrr/cF7iEXP0Mq3nbCfhxlcrJfzmD3HG46j0GVmk95CJ3OHMKplQfwKWPS+p3mmm1zWqI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3861449f-6bd0-44d4-a82a-08dc296d4e3d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 12:47:42.2686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xVHPl2h7zK3Yq6oVaoKNwaH8WWY7jSkalRrPVoWaqM/xz8jlYKuQ0b17TE8IE0Op7yP2XV2ugxc0MXyi8WaSqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5022
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_10,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 adultscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402090093
X-Proofpoint-GUID: Mj3OPKjXzTrDTOT5R_7YXteXCDM0JYXj
X-Proofpoint-ORIG-GUID: Mj3OPKjXzTrDTOT5R_7YXteXCDM0JYXj

>>
>> Playing devil's advocate here, at least this behavior should be documented.
> 
> That's what man pages are for, yes?
> 
> Are you expecting your deployments to be run on highly suboptimal
> configurations and so the code needs to be optimised for this
> behaviour, or are you expecting them to be run on correctly
> configured systems which would never see these issues?

The latter hopefully

> 
> 
>>> The whole reason for rtextsize existing is to optimise the rtextent
>>> allocation to the typical minimum IO size done to that volume. If
>>> all your IO is sub-rtextsize size and alignment, then all that has
>>> been done is forcing the entire rt device IO into a corner it was
>>> never really intended nor optimised for.
>>
>> Sure, but just because we are optimized for a certain IO write size should
>> not mean that other writes are disallowed or quite problematic.
> 
> Atomic writes are just "other writes". They are writes that are
> *expected to fail* if they cannot be done atomically.

Agreed

> 
> Application writers will quickly learn how to do sane, fast,
> reliable atomic write IO if we reject anything that is going to
> requires some complex, sub-optimal workaround in the kernel to make
> it work. The simplest solution is to -fail the write-, because
> userspace *must* be prepared for *any* atomic write to fail.

Sure, but it needs to be such that the application writer at least knows 
why it failed, which so far had not been documented.

> 
>>> Why should we jump through crazy hoops to try to make filesystems
>>> optimised for large IOs with mismatched, overlapping small atomic
>>> writes?
>>
>> As mentioned, typically the atomic writes will be the same size, but we may
>> have other writes of smaller size.
> 
> Then we need the tiny write to allocate and zero according to the
> maximum sized atomic write bounds. Then we just don't care about
> large atomic IO overlapping small IO, because the extent on disk
> aligned to the large atomic IO is then always guaranteed to be the
> correct size and shape.

I think it's worth mentioning that there is currently a separation 
between how we configure the FS extent size for atomic writes and what 
the bdev can actually support in terms of atomic writes.

Setting the rtvol extsize at mkfs time or enabling atomic writes 
FS_XFLAG_ATOMICWRITES doesn't check for what the underlying bdev can do 
in terms of atomic writes.

This check is not done as it is not fixed what the bdev can do in terms 
of atomic writes - or, more specifically, what they request_queue 
reports is not be fixed. There are things which can change this. For 
example, a FW update could change all the atomic write capabilities of a 
disk. Or even if we swapped a SCSI disk into another host the atomic 
write limits may change, as the atomic write unit max depends on the 
SCSI HBA DMA limits. Changing BIO_MAX_VECS - which could come from a 
kernel update - could also change what we report as atomic write limit 
in the request queue.

> 
> 
>>>> With the change in this patch, instead we have something like this after the
>>>> first write:
>>>>
>>>> # /test-pwritev2 -a -d -l 4096 -p 0 /root/mnt/file
>>>> wrote 4096 bytes at pos 0 write_size=4096
>>>> # filefrag -v mnt/file
>>>> Filesystem type is: 58465342
>>>> File size of mnt/file is 4096 (1 block of 4096 bytes)
>>>>     ext:     logical_offset:        physical_offset: length:   expected:
>>>> flags:
>>>>       0:        0..       3:         24..        27:      4:
>>>> last,eof
>>>> mnt/file: 1 extent found
>>>> #
>>>>
>>>> So the 16KB extent is in written state and the 2nd 16KB write would iter
>>>> once, producing a single BIO.
>>> Sure, I know how it works. My point is that it's a terrible way to
>>> go about allowing that second atomic write to succeed.
>> I think 'terrible' is a bit too strong a word here.
> 
> Doing it anything in a way that a user can DOS the entire filesystem
> is *terrible*. No ifs, buts or otherwise.

Understood

> 
>> Indeed, you suggest to
>> manually zero the file to solve this problem, below, while this code change
>> does the same thing automatically.
> 
> Yes, but I also outlined a way that it can be done automatically
> without being terrible. There are multiple options here, I outlined
> two different approaches that are acceptible.

I think that I need to check these alternate solutions in more detail. 
More below.

> 
>>>>>> In this
>>>>>> scenario, the iomap code will issue 2x IOs, which is unacceptable. So we
>>>>>> ensure that the extent is completely written whenever we allocate it. At
>>>>>> least that is my idea.
>>>>> So return an unaligned extent, and then the IOMAP_ATOMIC checks you
>>>>> add below say "no" and then the application has to do things the
>>>>> slow, safe way....
>>>> We have been porting atomic write support to some database apps and they
>>>> (database developers) have had to do something like manually zero the
>>>> complete file to get around this issue, but that's not a good user
>>>> experience.
>>> Better the application zeros the file when it is being initialised
>>> and doesn't have performance constraints rather than forcing the
>>> filesystem to do it in the IO fast path when IO performance and
>>> latency actually matters to the application.
>>
>> Can't we do both? I mean, the well-informed user can still pre-zero the file
>> just to ensure we aren't doing this zero'ing with the extent allocation.
> 
> I never said we can't do zeroing. I just said that it's normally
> better when the application controls zeroing directly.

ok

> 
>>> And therein lies the problem.
>>>
>>> If you are doing sub-rtextent IO at all, then you are forcing the
>>> filesystem down the path of explicitly using unwritten extents and
>>> requiring O_DSYNC direct IO to do journal flushes in IO completion
>>> context and then performance just goes down hill from them.
>>>
>>> The requirement for unwritten extents to track sub-rtextsize written
>>> regions is what you're trying to work around with XFS_BMAPI_ZERO so
>>> that atomic writes will always see "atomic write aligned" allocated
>>> regions.
>>>
>>> Do you see the problem here? You've explicitly told the filesystem
>>> that allocation is aligned to 64kB chunks, then because the
>>> filesystem block size is 4kB, it's allowed to track unwritten
>>> regions at 4kB boundaries. Then you do 4kB aligned file IO, which
>>> then changes unwritten extents at 4kB boundaries. Then you do a
>>> overlapping 16kB IO that*requires*  16kB allocation alignment, and
>>> things go BOOM.
>>>
>>> Yes, they should go BOOM.
>>>
>>> This is a horrible configuration - it is incomaptible with 16kB
>>> aligned and sized atomic IO.
>>
>> Just because the DB may do 16KB atomic writes most of the time should not
>> disallow it from any other form of writes.
> 
> That's not what I said. I said the using sub-rtextsize atomic writes
> with single FSB unwritten extent tracking is horrible and
> incompatible with doing 16kB atomic writes.
> 
> This setup will not work at all well with your patches and should go
> BOOM. Using XFS_BMAPI_ZERO is hacking around the fact that the setup
> has uncoordinated extent allocation and unwritten conversion
> granularity.
> 
> That's the fundamental design problem with your approach - it allows
> unwritten conversion at *minimum IO sizes* and that does not work
> with atomic IOs with larger alignment requirements.
> 
> The fundamental design principle is this: for maximally sized atomic
> writes to always succeed we require every allocation, zeroing and
> unwritten conversion operation to use alignments and sizes that are
> compatible with the maximum atomic write sizes being used.
> 

That sounds fine.

My question then is how we determine this max atomic write size granularity.

We don't explicitly tell the FS what atomic write size we want for a 
file. Rather we mkfs with some extsize value which should match our 
atomic write maximal value and then tell the FS we want to do atomic 
writes on a file, and if this is accepted then we can query the atomic 
write min and max unit size, and this would be [FS block size, min(bdev 
atomic write limit, rtexsize)].

If rtextsize is 16KB, then we have a good idea that we want 16KB atomic 
writes support. So then we could use rtextsize as this max atomic write 
size. But I am not 100% sure that it your idea (apologies if I am wrong 
- I am sincerely trying to follow your idea), but rather it would be 
min(rtextsize, bdev atomic write limit), e.g. if rtextsize was 1MB and 
bdev atomic write limit is 16KB, then there is no much point in dealing 
in 1MB blocks for this unwritten extent conversion alignment. If so, 
then my concern is that the bdev atomic write upper limit is not fixed. 
This can solved, but I would still like to be clear on this max atomic 
write size.

 > i.e. atomic writes need to use max write size granularity for all IO
 > operations, not filesystem block granularity.
> 
> And that also means things like rtextsize and extsize hints need to
> match these atomic write requirements, too....
> 

As above, I am not 100% sure if you mean these to be the atomic write 
maximal value.

>>> Allocation is aligned to 64kB, written
>>> region tracking is aligned to 4kB, and there's nothing to tell the
>>> filesystem that it should be maintaining 16kB "written alignment" so
>>> that 16kB atomic writes can always be issued atomically.

Please note that in my previous example the mkfs rtextsize arg should 
really have been 16KB, and that the intention would have been to enable 
16KB atomic writes. I used 64KB casually as I thought it should be 
possible to support sub-rtextsize atomic writes. The point which I was 
trying to make was that the 16KB atomic write and 4KB regular write 
intermixing was problematic.

>>>
>>> i.e. if we are going to do 16kB aligned atomic IO, then all the
>>> allocation and unwritten tracking needs to be done in 16kB aligned
>>> chunks, not 4kB. That means a 4KB write into an unwritten region or
>>> a hole actually needs to zero the rest of the 16KB range it sits
>>> within.
>>>
>>> The direct IO code can do this, but it needs extension of the
>>> unaligned IO serialisation in XFS (the alignment checks in
>>> xfs_file_dio_write()) and the the sub-block zeroing in
>>> iomap_dio_bio_iter() (the need_zeroing padding has to span the fs
>>> allocation size, not the fsblock size) to do this safely.
>>>
>>> Regardless of how we do it, all IO concurrency on this file is shot
>>> if we have sub-rtextent sized IOs being done. That is true even with
>>> this patch set - XFS_BMAPI_ZERO is done whilst holding the
>>> XFS_ILOCK_EXCL, and so no other DIO can map extents whilst the
>>> zeroing is being done.
>>>
>>> IOWs, anything to do with sub-rtextent IO really has to be treated
>>> like sub-fsblock DIO - i.e. exclusive inode access until the
>>> sub-rtextent zeroing has been completed.
>>
>> I do understand that this is not perfect that we may have mixed block sizes
>> being written, but I don't think that we should disallow it and throw an
>> error.
> 
> Ummmm, did you read what you quoted?
> 
> The above is an outline of the IO path modifications that will allow
> mixed IO sizes to be used with atomic writes without requiring the
> XFS_BMAPI_ZERO hack. It pushes the sub-atomic write alignment
> zeroing out to the existing DIO sub-block zeroing, hence ensuring
> that we only ever convert unwritten extents on max sized atomic
> write boundaries for atomic write enabled inodes.

ok, I get this idea. And, indeed, it does sound better than the 
XFS_BMAPI_ZERO proposal.

> 
> At no point have I said "no mixed writes".

For sure

> I've said no to the
> XFS_BMAPI_ZERO hack, but then I've explained the fundamental issue
> that it works around and given you a decent amount of detail on how
> to sanely implementing mixed write support that will work (slowly)
> with those configurations and IO patterns.
> 
> So it's your choice - you can continue to beleive I don't mixed
> writes to work at all, or you can go back and try to understand the
> IO path changes I've suggested that will allow mixed atomic writes
> to work as well as they possibly can....
> 

Ack

Much appreciated,
John



