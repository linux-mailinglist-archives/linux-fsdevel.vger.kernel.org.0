Return-Path: <linux-fsdevel+bounces-4561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B466800B06
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 13:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1736CB20B7D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 12:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C972554A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 12:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IS4KlHjW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Icpxe3vd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D29196;
	Fri,  1 Dec 2023 02:48:17 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1A7Y1b029643;
	Fri, 1 Dec 2023 10:48:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ZQQ8XnaRVbaM44nNzF5qemf1JgW/J/CLCUS2GHzVJho=;
 b=IS4KlHjWYcYOdP/RXRoGoulwh/Eodw3XFCPFJEClvlYyUy4VcRR1TeCAUY2Nqt5mosrr
 PVyOJX+KMU92GbcOeAYIZ01hs8LanpcNHNlwHg6c2DIIgWdKeFjC4xOz+WLYFNdV/FPd
 5tkAzPXOWn6KBOaNphmBUNgHprtLbGRJuU7zCCyHx3Ukg2aUoxRKimdHIdD1B+F2LKyB
 4APKWugEpRJjHdGs6mJVDEXpsqu9wykmvyoUG7pyotN0r+z3K7pxpaSdODEXff4LxMlW
 uRunwdntFcbXCXPcP8Oq7BrPAJaTgsATY+skr732ILRhtLeSwdDbLFniQlO3KqXY7MZX AQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uqd62r3u3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Dec 2023 10:48:07 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B19tN73010249;
	Fri, 1 Dec 2023 10:48:06 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7cj3x7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Dec 2023 10:48:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3QWY5qzY2jirvgu87XQ7iy8JyqFqGeh2Dh6MS4T32iNHG3f4NZkpJEyIAHZp4l6VTEbHpQzNyGa+/J5MPNPCmxg2t+mQWxdQ2Fz4GnxOs/ZpwsIV8Y+l+XdsbTl+L/w4FkbaA9a9xC+DIHDOjTn5iWYoVgKzyPqahIAR6+zWhVjNWmUcrQ3Lo0zQYsR9RkR+5GcB37u9TKISn7FsZLuJUxsdlFKH5KSMRhkqJkThuJFlcvi/2hZWDeFd6Jh5ZDxpAsl7OFavRM96Lj8Fxn5KInqvhFhyhMqaaFdMakUI0PPgQsqlivIuOx7+2eR+yBqlsJBVfJ2rDmQp5y77Zl8Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQQ8XnaRVbaM44nNzF5qemf1JgW/J/CLCUS2GHzVJho=;
 b=lmSgMAg3VPDOdaQlBIkoQORjLxhSDHdrYXyafLgrXR+THTRx+dK4J95GqPI/50To16XnH6SO9gI5jBfgHVI17/IdevfGtdTuGYec6ssXv3nQWKQSE1IWWa/ewaAynQh5wAhsHHz/GQVnMFr7pX4zgcMOKZCPS2Aauh0IT3m4quJVwDdnDlz9jz+WeckbXkkUNfVjfyavXX25SyUrBa7Cw+b4aAs25TLEo0KkAHAJs3KGgHdSk70bbmJzjd8PdegxrtFjtgohaxm9pDY+aA1KOxz6qmy45lbeVQXg0SpK9BZ/fy/qqX6CbjtzBhvg1MSN+tdbZpZSl6Ezj9QCExiiIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQQ8XnaRVbaM44nNzF5qemf1JgW/J/CLCUS2GHzVJho=;
 b=Icpxe3vdZYCXae8g+H8Fta+swgWVQB+XwwwHywgOJibr5gvPltz2er99Ueomw4fOjcHyHBySrNnT1NtarYe6/lg0GOfLbMXKEVdcfvha87aRVCE508EtbKMsHmF75p9FxmoVEFjJYXhIffjW6uvXfItaRUm/xkPONQDMEsEMaxM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB6196.namprd10.prod.outlook.com (2603:10b6:208:3a4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 10:48:03 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7046.027; Fri, 1 Dec 2023
 10:48:03 +0000
Message-ID: <cc43b1ba-e9ea-4ff1-b616-be3c11960eea@oracle.com>
Date: Fri, 1 Dec 2023 10:47:59 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 5/7] block: export blkdev_atomic_write_valid() and refactor
 api
Content-Language: en-US
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dchinner@redhat.com
References: <cover.1701339358.git.ojaswin@linux.ibm.com>
 <b53609d0d4b97eb9355987ac5ec03d4e89293b43.1701339358.git.ojaswin@linux.ibm.com>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <b53609d0d4b97eb9355987ac5ec03d4e89293b43.1701339358.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0322.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: ead62a4b-79f2-47a9-5441-08dbf25afe8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	NfS68uhGW5IeCYQ28Rxy9qWZfM9tRtSOn1xgl8EIbBJoXYKyIHEMCQtg+p2RRNleG+cX+1NG0NfgY8qfmsyGevCDUOVxpNxjckApxaReuK/5Rj11IDJtSJ+XTT0MG61PIEHE+VkZi+Ez2X9rEleiFX5r1flUDri+gNKAu47jqVMyJ3uy5A01F5Tf1vz2RlKvJepJvMj5VwQjR3tpCm0bdRoU8EAmvo/ZKYbhBUDtAA4mXmKa6uTYSsjVBj378a24aFTcJeTVz7hzdy03r/rZrZBvadG2byS8Bgrjm40WlJlFlBHidMWleHMwhn8VjTPjtLG5aB/BNHGheSSvdsoxbs9GptNn1mFoXFrAbjSNscRG74syBi1rIkmifNr4bP2RqFMvFa8vNGLFbEiTgTepyj4cWCBo5nDuE2Gk8/Fs3Wv+sBr0gdQJYNTl3tyg++QEOZfgmsQbvsEatG86KmP92Vbcca2Vb3Dy0pui7IajwLHNg0WkrCxN2Fle9KGXtvMjHmRNRU1QCKx6EBHdGymTBvevHfWbm9Jld+42Z+i/k5N6I4Xzh5qEeuoZi6KjjiZ2AiQojK4wlBdBAa28L8xd/rbxjFuWMdc3xdnd6YaeA3MQj11QEZYDkW26i2lSIv+cSWM4agyWVcnPBrtWr/LUIg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(396003)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(7416002)(5660300002)(2906002)(8676002)(4326008)(8936002)(66476007)(54906003)(316002)(66556008)(66946007)(110136005)(26005)(36916002)(41300700001)(6506007)(6666004)(6486002)(478600001)(6512007)(53546011)(31686004)(2616005)(83380400001)(38100700002)(31696002)(86362001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T1JPenZmSkU2OGQ1ZHRtVGVjRWRJL3JuUWI0OWlxZlo1UUgySTBmdnN4dEx4?=
 =?utf-8?B?MHNxejlJN1dVTGVxU3BGeUJTVTZKeForMldwbUVQVVB4dXN3Yk84RkpNbkNI?=
 =?utf-8?B?SkpBNGFFM2VtakZSL1NpOHNhOUhRWE5aZnBEckhBVEZ6UW5CVFRvWWhLRTR0?=
 =?utf-8?B?SGo1ODEzTDNEUkpLR0dEWGpLZG5GSzJHcGl5VXUvYnlvUXBhSGZzQU1UWDVy?=
 =?utf-8?B?NkhFUW43Y0I2K2xCeGVyQTZSNlZDc2h3UXpwZnpNdE9wOWp3UGFiaGhUUyth?=
 =?utf-8?B?N201RVpwMWZJMmtKcHNVanp4RGwrdHl2WGdka0czSUZJanBSTFQyV0UvREpa?=
 =?utf-8?B?ZjhPTldwVElpVmxmUHlPTlR1QUV3NVRQK0JZRGdQUnRsYTlOZXYwWHNTdHps?=
 =?utf-8?B?VjBJRndwVWU2dmlHL1dLSWh6dTBNQ1BNQlgzZTFLVjJBVU1sVFF0TTNtNkwx?=
 =?utf-8?B?RFZ5VE1MaXg4N293Q2pXcjFSTURLQXZrQmlkZCs0WjVwZklHQ2oweUtSdVVx?=
 =?utf-8?B?ajZnYXJVTkNlZEpDZ081MWcxWGFtY3FmeExSalhDNGpEQWpIaitHK1ZNWk1D?=
 =?utf-8?B?ODRTc1hOcWxUWWVhYWh0dnhYNUorei94R1hEam4vNmwzKzA3SkViaVB0aHBa?=
 =?utf-8?B?Ly9hVWV1NHBHSDZkL08xZXV2TTd2VHBoWFp4YW5WVnViM0QxcXhmVGhsT1FO?=
 =?utf-8?B?M1FZWTBjUVVPcjZoUHRncXdIWGxMRWFrc3BMZWFGMHYyV21GdnAwdzlQNGhk?=
 =?utf-8?B?QkRoOTdMN3pERmZXb05KNUNkaCtEMFFJODZWNnAvSkJyZEZ4SjhGc3FSTlcr?=
 =?utf-8?B?YkFxMjBsRjJSR0dhd0gvOWJNOVRLbXA4Sm1ubWdHclFmcllnRktJb2FmR3VB?=
 =?utf-8?B?ZzIxWHFSRkNyQXRXL09oSEh4d2pVY1ZMS2E4ek5qNndXbnlyc0hCVmxyMXFy?=
 =?utf-8?B?dUtKR000RE9udkNFSHYzdndxTDducTdUVFFtYkxMU2hJQmpWS01zeUxOUDQ1?=
 =?utf-8?B?Qk9KYUpLTGcyT2xZWUVycUZvUTFZMkhIN3l5bC9BeVhGZW42VGovbHVYeDN6?=
 =?utf-8?B?YTZMNmpZQko0enlVSC82M0k4Ung4dFFoa2lmOUp0RG1SNHlrZDJ6UlFWVE43?=
 =?utf-8?B?L21lRjRSMWxGdlZMNHVwSWFuSW10Y1dpSDVxaVAzVndkWFBYU3VMMzFHcHlP?=
 =?utf-8?B?aWw3ZVBKcis0TWZaVmRCTytnZ2hFVUVnSzJVNlBOM28wdEx0Vm4yaGttTmpY?=
 =?utf-8?B?dWhQMHc4ZmgrN3lMZ1hjam13dW40WC9EQWpVclNHdXlEMHQ5UFNXTmg0Uytn?=
 =?utf-8?B?Q3JMNHJhTitWallxeUp0M3ZETWJlRVozZnQ4MTFacGI0SCtCQXZvMWswZ0FD?=
 =?utf-8?B?a3paM3dTZGxTZFlZY0tJK3YzcDNnUWxsellBT1FCeUx2aVE1OTZON2htTE1W?=
 =?utf-8?B?ZWU4RTBsQi8xRms4S0ptdFhBK0hXWWVJYWxpNm52OU82Und2a3BZUG0xOFNS?=
 =?utf-8?B?dmMzUGkrcHBCMFhsNG5EcmNjZDVpdVFxeDZCdnZsdEZqeEF1VHRLR29tODhi?=
 =?utf-8?B?K2NDOVpwcTRYYnNmT0xiVlR5YVJueXRTRXhlSWFURXBtaFVTbkl0Yms0NmZv?=
 =?utf-8?B?ODU1MUV4d3RNdVV0TlViZWJqQjFUOW1NNUtybW8wM1F2ZksrMnEwVElMSk5r?=
 =?utf-8?B?czg0U1lDNmJ5dWFVVmdMVmhxaVZKOG1IaGNtd09JeWNIajR4MXEydEpkcUN1?=
 =?utf-8?B?ZzJLM0crVjJIL3FSU25ta0ZvTGFaditNZlc4RGJwYzdyMkp1Ykx1UTI1WFVv?=
 =?utf-8?B?c0ZDRjE4eWc2QVdPeGFvaDFsWmpqTXpGcklDVUt0cUg1R1VXUGJtUFpyS1RU?=
 =?utf-8?B?TzAwd1A2czJzSnh6WTB3YTNsblU3K29tL2hocklnbEIyRTVBV1pRNm5Ld1FR?=
 =?utf-8?B?TDh3VkZKT2FvSTAzc1FUcFlLaWwvLytYRFloMmZDSnlDQTErM1VGSHRtaFRK?=
 =?utf-8?B?TVBlbGJna2tMb1dtVy9yK3BaM25IN2duZTQ2TTRNZ1RybzVKQWZTbVVUaUJZ?=
 =?utf-8?B?MUtvem8rMWVzakZ6bFllUENreEIxbmNIVTZuY0tkL1dTVWFobmkzMnFodzFL?=
 =?utf-8?Q?RFw5ahPpnGmXMd6/JYSU1E45F?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	s0gauSjAv+TuE1LP27Yq5i5EhvMxD02Wzd+N4LVs9+QjXg1TAdqnTBcqcfvwQCYe3F09v9ftBvrwhZEBqYzhAhxgsDVJebuyJZLaS80kQjpy5thIIoMuNwiEbASTgR//MPKxGEgpiI2HjXBTZuoYMS8Lg8OyDLUfWMLCWjnnmmkMh8/uwvNG9wW2Qd9cnDucnajmcqLCdSpQ+jRWlztqLEhMd1sC9XRk0elf5/41IC34AMVuMGyeG/oBxRCJpG0D1j2xPYk0RX+Wh9SsT/R+2dy/rhQTpPP/mOnXoSxnL9CYxLuqMsOLqYWrZ7obDAD3Oqk9+0NJBQVoYE4XASb9KQpIfYNTLoTVDNjNYt/IvWT/bBfJtEuj0UddlFd8oOjvDwI1ymq2T22/KTUZcW8mX2aZDLrIiCcEQGnRrOfxMSBbxMqdFCvEA0x8dW7QEUVGcgtwAt67MZ3f0cshsFFUpE6W5fnj3Vx/yx0Rg/D7ETKjlvyHJnJDvenSi9O8e+g8gzY2Zw7Cb/8bFEALgdgkODk/ZxJ+f/l1QpYOwAbfbCcJzbLirSaYiK2L/OsnIM4kvvniZxPensv2T5twdWlnIsc5uyF31/Owp6Ga+dcW+PVkpVol4w2O88hBvGsVdcp90nJjBx500gnq8cYYdG4WcOEUmE+Qso5OeIBwFTUsdl4aOl9Q0BNNgXYInLZBI8dTFTYYNLcEp7K9Eflwdb5bd/vks343fMbf/guEEPZR4DRZzi0t9cjcwY6oJNaocuEnNbR3U2eslCZsf0QaIH8YLbQLh3y+ufqtYrYH3F8QAwLudCbA9PRVucpOPJ5kVwCaMp50F6GfM7tfHHqorK6ROX8PcnIe0++1QB+YYCZSfA4LWMn8hzz84tQOZtv1EGOSjMLDgbnwm+yYO3YC2wPwUlu4ErjRKFP0+1pub1/lJgk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ead62a4b-79f2-47a9-5441-08dbf25afe8d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 10:48:03.6775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gpNc/usVKjPu2p2sNIJUO+GTowU9P45NuCb6Ytfzp8JNkQ3UhLwZ7plHv3oj03av4/8H8d+J/XO6tsf57rK2MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6196
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_08,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312010070
X-Proofpoint-GUID: BBkE411NJ55O7P00mMKsDuEy9fy05FOY
X-Proofpoint-ORIG-GUID: BBkE411NJ55O7P00mMKsDuEy9fy05FOY

On 30/11/2023 13:53, Ojaswin Mujoo wrote:
> Export the blkdev_atomic_write_valid() function so that other filesystems
> can call it as a part of validating the atomic write operation.
> 
> Further, refactor the api to accept a len argument instead of iov_iter to
> make it easier to call from other places.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

I was actually thinking of moving this functionality to vfs and maybe 
also calling earlier in write path, as the code is really common to 
blkdev and FSes.

However, Christoph Hellwig was not so happy about current interface with 
power-of-2 requirement et al, so I was going to wait until that 
discussion is concluded before deciding.

Thanks,
John

> ---
>   block/fops.c           | 18 ++++++++++--------
>   include/linux/blkdev.h |  2 ++
>   2 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/block/fops.c b/block/fops.c
> index 516669ad69e5..5dae95c49720 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -41,8 +41,7 @@ static bool blkdev_dio_unaligned(struct block_device *bdev, loff_t pos,
>   		!bdev_iter_is_aligned(bdev, iter);
>   }
>   
> -static bool blkdev_atomic_write_valid(struct block_device *bdev, loff_t pos,
> -			      struct iov_iter *iter)
> +bool blkdev_atomic_write_valid(struct block_device *bdev, loff_t pos, size_t len)
>   {
>   	unsigned int atomic_write_unit_min_bytes =
>   			queue_atomic_write_unit_min_bytes(bdev_get_queue(bdev));
> @@ -53,16 +52,17 @@ static bool blkdev_atomic_write_valid(struct block_device *bdev, loff_t pos,
>   		return false;
>   	if (pos % atomic_write_unit_min_bytes)
>   		return false;
> -	if (iov_iter_count(iter) % atomic_write_unit_min_bytes)
> +	if (len % atomic_write_unit_min_bytes)
>   		return false;
> -	if (!is_power_of_2(iov_iter_count(iter)))
> +	if (!is_power_of_2(len))
>   		return false;
> -	if (iov_iter_count(iter) > atomic_write_unit_max_bytes)
> +	if (len > atomic_write_unit_max_bytes)
>   		return false;
> -	if (pos % iov_iter_count(iter))
> +	if (pos % len)
>   		return false;
>   	return true;
>   }
> +EXPORT_SYMBOL_GPL(blkdev_atomic_write_valid);
>   
>   #define DIO_INLINE_BIO_VECS 4
>   
> @@ -81,7 +81,8 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
>   	if (blkdev_dio_unaligned(bdev, pos, iter))
>   		return -EINVAL;
>   
> -	if (atomic_write && !blkdev_atomic_write_valid(bdev, pos, iter))
> +	if (atomic_write &&
> +	    !blkdev_atomic_write_valid(bdev, pos, iov_iter_count(iter)))
>   		return -EINVAL;
>   
>   	if (nr_pages <= DIO_INLINE_BIO_VECS)
> @@ -348,7 +349,8 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
>   	if (blkdev_dio_unaligned(bdev, pos, iter))
>   		return -EINVAL;
>   
> -	if (atomic_write && !blkdev_atomic_write_valid(bdev, pos, iter))
> +	if (atomic_write &&
> +	    !blkdev_atomic_write_valid(bdev, pos, iov_iter_count(iter)))
>   		return -EINVAL;
>   
>   	if (iocb->ki_flags & IOCB_ALLOC_CACHE)
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index f70988083734..5a3124fc191f 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1566,6 +1566,8 @@ static inline int early_lookup_bdev(const char *pathname, dev_t *dev)
>   int freeze_bdev(struct block_device *bdev);
>   int thaw_bdev(struct block_device *bdev);
>   
> +bool blkdev_atomic_write_valid(struct block_device *bdev, loff_t pos, size_t len);
> +
>   struct io_comp_batch {
>   	struct request *req_list;
>   	bool need_ts;


