Return-Path: <linux-fsdevel+bounces-5718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC2A80F1F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 17:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 852A41F21364
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 16:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD28977F08;
	Tue, 12 Dec 2023 16:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H8bRt6hN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YSbNqMyy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D898EB;
	Tue, 12 Dec 2023 08:11:17 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCDit5u021377;
	Tue, 12 Dec 2023 16:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=/wMeRPx69EhbjLRgr4ktWdbgeC+QCyUfChSEI6gfSrM=;
 b=H8bRt6hNvw/uNMKlJcIKMWt+46pB92eIoCCb+mAO9ydQJCnXGEgc1T76sbBQ82ZPWq+E
 CswVSTkZq7jaxbMm84ZIz4v7K0akfxS65SjL1Uwh/fvKEnAxoal30B8V69/y0Yzd+pOn
 GfYm3qlW6xyi4ALB+fqWqdl7p2I8PeCnZPIrvhqIyXMJ/ZAi2Lsq3y2NUj50J0Txnbqh
 xp+rG+zgf2Dukj16WcI+sPOm+OH1MSwNXwQSMHSU9PQkbjMmw5rXjV+RxWnaTQBrGD2I
 Os2ITb0s4UChVIw/e7wRkR2fEqhm+BbxA1qVFXTqWO+esNVGwbsHl0mGy5MBkH4EsGQ4 qg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvfuu60tj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 16:11:00 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCFfb65013005;
	Tue, 12 Dec 2023 16:10:59 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvepd28r8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 16:10:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAFLrWuNO6RrX9Bn9Z/R2FxBb5hDv3nSHatlcF+qVMyEzdpAdwPP7Ik5GwhV3wxH5jfTfTUqCOq5oEZMHCa4yMobSurNH55cRPlrme9I23H/mR8TKF9yl5HhQ5mNFb99tAxhO0m5PF2A8s6dQZwKflROMvE1ZE8uzvx7M7C1PpXU0fYpxmj9Jqh+vyBH/fxXX33HaV8y4Jo9PNaLgoI6Kpgv1ruBBgtgovFABpIqa5/nxD/u4uGKDYAZMT21iThidwUUPizSk35MZBuE31MH3mPT2G3BMP7ezqU9piHT7jBlYbXNw24v9sbJ3B4VsRQQ0j3sp4kWHZhXk33BNUG6AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wMeRPx69EhbjLRgr4ktWdbgeC+QCyUfChSEI6gfSrM=;
 b=ZyW2gkkAavdbpUSsGzSUCWRV3Wx6HXlvKAGL1j5jiQ3yOiwv1SaFpuvYE/itKTqG+fVxuRaT1L5++3q5AwZs/1RYIzajpZnh4bkw5mD9xaugnZSMcwK/f66qJvWNtWYXJYw9tSJESNsp+ltH1Kib1msmZnf1xyVD8E0JZZffln1k/xny1IMWFpODi2FLF6zapn5BFHmb2+hQOz6pgo48dhQhTxZwJwT5pavisRpR9TpBSvCB8MDKctAYiQsyw9zY16+7vrxeYKobnpLM6wBGONmMp1xL/ZeHgDS6wSYXMQxM618fRQxFgumMFkeADiSNz93AdJwQQoQ3hdW8NozwMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wMeRPx69EhbjLRgr4ktWdbgeC+QCyUfChSEI6gfSrM=;
 b=YSbNqMyyxbmyzz8v0mP7LKuMtW0mNDPyAHmQvJhanh5t/da5lgDQVCmdCxLq5qfdf8Gma2ylRb2cP0pStSsT3jSOy8kkk5gJtDobKTM9+MuVFeu04RmQDMlwYB76g4prwRoUS9Rk9J3lSJ64BY2ldGFsatbYVWSuCoadnaGIk9s=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ2PR10MB6992.namprd10.prod.outlook.com (2603:10b6:a03:4ce::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 16:10:56 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 16:10:56 +0000
Message-ID: <5f5e92e1-6b77-4c57-958f-9c96101770cf@oracle.com>
Date: Tue, 12 Dec 2023 16:10:52 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/7] ext4: Allocator changes for atomic write support with
 DIO
To: Christoph Hellwig <hch@infradead.org>
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Ritesh Harjani <ritesh.list@gmail.com>,
        linux-kernel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dchinner@redhat.com
References: <cover.1701339358.git.ojaswin@linux.ibm.com>
 <8c06c139-f994-442b-925e-e177ef2c5adb@oracle.com>
 <ZW3WZ6prrdsPc55Z@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <de90e79b-83f2-428f-bac6-0754708aa4a8@oracle.com>
 <ZXbqVs0TdoDcJ352@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <c4cf3924-f67d-4f04-8460-054dbad70b93@oracle.com>
 <ZXhb0tKFvAge/GWf@infradead.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZXhb0tKFvAge/GWf@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0252.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::23) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ2PR10MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: a05ae8f3-2922-4d7a-7a4e-08dbfb2cec67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	k/fFf3YX6yLW3bXMe0nTvmjZ4BUjlQ7nMILH9yrfcdLzlBIjBxcACsspl2GHPa6HqEoVzuaCY1juR0dvtoK8XAsmwG4H1FL+dl71X9tef3egI6kUzxykKTmO+2eiQ+ZKHcKS+wbN6AfnMEPyO3A3vP5fhwlEJMZIFAAkwBuvzmuxODHI32RNNtSCWo+O7wpuKOdiJ7DyQ0N4KjQvGRu3iXB1BHSvBlSMOOA8c0QZ+N2bP0VQcJgdm8/wMqLSk7qnnY/vtZ3gzbVsqF0WzyOQmYQknpBIw5MhIgbF+oCvbinLa+STcFnGOFqR3Hd+PuNkXxexQrvqWd8jHze//u4rEOuyBAHBXDbTyNJwTjsWVABaxYnuRw7X5Qf3TNNMxBM/gj3lhJ7dez7MQIUsyuiQhm6gFGhq5vNPTVpSCBT7HcYUFlG2Jke9aum4p6MBAakyrf0e+JJg4rwopQxcBqT6D7t1beEcACxAQ++uU5QYg/dqVcUesFwByAiTt4w+0EMalDVWeH4xf39dD8QHiZzYSWiz/uWaC80rnTUI/pivnNpA8Y51al5iqNjRaU5N5ZknWBLAKQS0bQ79Dw4irvrAO0zC87HMOPT2h5W+dBep0EqWBsT6668EllIgVQX4WkGsEH75iIWY6k3tfP99ogURvA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39860400002)(396003)(366004)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(41300700001)(2616005)(26005)(31696002)(36756003)(38100700002)(5660300002)(8676002)(316002)(8936002)(4326008)(2906002)(4744005)(7416002)(86362001)(6666004)(6512007)(6506007)(53546011)(36916002)(66476007)(54906003)(6916009)(66556008)(66946007)(478600001)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?M3RYNVBFbmt5MGZhZE9YblpmYWttMnVNRkU1KzdQeHpGS1d5eDR1aFRMM3c2?=
 =?utf-8?B?T2ZYaTE4QXpzRkFKT0ZwMktQTUVGcnI2L2hGRE9vR044RW5qUm13Q3Mzckht?=
 =?utf-8?B?QUdIcm1JYlAwSng3cU5kTnZ1VnVnRVhuL1JDYjhXT0R0ZWN0ZFZIMStyMmZw?=
 =?utf-8?B?N0VPb2VYQzBoOWdNUDdqZnlRZ201a05OSXd0bmlyRWhBeTZUb3dVNnlzTTdu?=
 =?utf-8?B?ZEZrVEdvRkU4aUVmQjRqOVlxcXNreWJBYUsrbWRvTiszck9Yakl6czkwV0th?=
 =?utf-8?B?WkZMaVpaS1N3TytSMmRtQVovNmNOQ3BXb2p1djhTc2xaTXp3QUQ1Y1NHT2tt?=
 =?utf-8?B?ZEwxTFhiNElwT0c1UDlnSWFnZVJOQzVCTnpJeGt5YmY0UTh0T3MyU0s2OEEz?=
 =?utf-8?B?SGZzQ0lGeTF2Um9zZTg2cCsyZnRzSjZ0ejU3eUhxT2lsbHprdEVtaUJEaE1w?=
 =?utf-8?B?VkRDY0I1MitIVEFjbnRQVEVNaU1XL0MzRGF3dysvSzduSEZGK1VtSEZkd2tO?=
 =?utf-8?B?Z1hQditmYzZnWDhIbnkzb2huWHZRbGk0dUxUY0tNYjBFSmZFUmFvdFI5K2h2?=
 =?utf-8?B?MDBvNm9VMWx3U1dleGRCRnMramlQSG9WSUhZdmgrQWZuUi9GVjVBTTBSdS9u?=
 =?utf-8?B?VENIK003TklMbUw3L1Q5ZnkxUmwxdjIrcnpsaGZrTHZOREVtaHgxK2g4TG11?=
 =?utf-8?B?OEVRbzdJYW5BTTFYWmVteFpsVzJuV3ZwZUI5ZnhkbjNwQW1ZMG1XZzduZ09o?=
 =?utf-8?B?ZnlwU3NiTDduQmhjRTJ6QTVJYUhaZ2FJUlNRYlRwVjN0akFRU0JwUTc3OFZu?=
 =?utf-8?B?ZE85SlpoK0k3MkNlQmgxa282MU9SdnYvTndsSi9YZjE1THkvakttU2I2Yk1G?=
 =?utf-8?B?MEhER1N3TVF4RFk2VHAyTHJKdkNlY0ZyUlZ5OFlDdEEwQU1MNTU2YmFqRThi?=
 =?utf-8?B?S2s3MDJrNlBHajArRjh0VkFVeGFjaUYwUzM0THFzenJMdWRGV2dSY0xCaFEz?=
 =?utf-8?B?OUNHN0JHNUViSzR5b1RzTXIxMis5NlBJbGVnZWRKK3pxWFdSd3g0VEtsQ1NB?=
 =?utf-8?B?cE5ablRMYUJ1VjJWWlBYOXlRT213cE1XNlIxQ2VKVW45b283RmtrRDhibzJY?=
 =?utf-8?B?YTdyb1dHbFBUaW5iNmJKaTlGdElQeWYxNmQvQ0xJdjVaR0U4ak9JNTEvUFdV?=
 =?utf-8?B?ZVBOdWJsUHJ3cXhHc1FxV3JDdDY5M0ltYjNWaWJNRThYTVVhdU44U0RhRENG?=
 =?utf-8?B?VlVRaWFEb281UlBZTk1HQjdlNjEybXFYdGRJbEdWOTNiaXoxb0thaGxlV3pk?=
 =?utf-8?B?VWhNNDhPeGt6VkpVUXNWazI0ZlJhWXNsTCtzdkMxSjhEVjZkellCWC8wU2hn?=
 =?utf-8?B?NEF3Y2tIcHdGRUovd21IR0szclZBUVh3M2lJNEo5RGdGTGN3cTFha3VUN1l1?=
 =?utf-8?B?YVYrdXVMNUN6RVRjcjE1eTdPQjJna0gxQ1QzRDdwMDlQWGppNytjRFNGMzZ1?=
 =?utf-8?B?VC9sOTZpaHBCZlN0R0NiejNYTnl3Q0ZBM0dUNnUrYmhYSEVtaFoxa3dyRkM4?=
 =?utf-8?B?U01Yb2swRTBVYjlTVUdlMjhiWWRROGVJTXY5K2JTR3lRTHUwUjBFNHExOVI1?=
 =?utf-8?B?cEtIRnBRTFVwV3NYQ2dRdGt1WWxxMXhUMTc0SGplbTYxRDFTYjNHNDNTWTdP?=
 =?utf-8?B?MTAxYk9XaFJkdFVTcTVLUHp4UU1acmRrd201Tit6ZnBLZWw5ei9qaXM1TnFZ?=
 =?utf-8?B?b1I5bFFjQ2hWTW5nL2tNcndXYWV3TGtYK09vcHNGaERoNExlYzB3d1hOb0RZ?=
 =?utf-8?B?MHRkS1A2em5HQWhGREhTSC81VHNRb01CMUdnazVjQWo2dDNzdnZLeitBM1Bv?=
 =?utf-8?B?eE9RUUJFaktOUTk3RkpVU1dJeUFoUS9JWTg3UVI3OTQ2ZFhnVU00c3VRekor?=
 =?utf-8?B?ZklJb3F2VEZtNHpQZnY3bDZvUkFzTVFoejllVndDeUFOM2N0NG56ZWpJV2l0?=
 =?utf-8?B?TElDRVh2UjJVQm9JblUzVE1tVU02aDdFUmRhbDIyaWxYM0dnSlVCdDNuNUE2?=
 =?utf-8?B?SzBtUWVqYXRYTlFYeXBZTmZGTnoxdXlRdm5WOWcveXd4RWpSMHI5VmRaNmFD?=
 =?utf-8?B?Mk93QjJGczVIb2ZjcGhNZ0hYUUFhcHFkN1V5dDhHa0F5SGhTc1d2eVVBYUd5?=
 =?utf-8?B?aUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?ak93dWRYMUtVRXlDazNZOTJwOWIxRnFOclUxU0dEZDhwSElDRk1nelpvY0JY?=
 =?utf-8?B?d1c2R2MyQ3hSeDY3Q1FvL1ZHUlpFS0hCTmJ3TmRKSkxNaUZ0OTNpWVQ0Tno2?=
 =?utf-8?B?VVdnZHlBcFF4eFh2T2t2UUVGM1pwUGo1cjNiWWE5M2NHcHNDRkFhRjExa1NM?=
 =?utf-8?B?emd2ZWk4bFd2dFppMUQyNXRDblNBRC90WTR2eExBcXdMUzliSzExSC9DN2Z6?=
 =?utf-8?B?UDc2RWh4QmsxOWxxSmRsK2JwVkpUNENJTWdwdzRWOFd0NXcvUkZSTHhUV2tx?=
 =?utf-8?B?Q0dDNTZ6YnpFSTVxYTNBeVRlb2dpeHI3cGFhM0czRUNQNDMzMzVTQkJqWk5r?=
 =?utf-8?B?QWxDRllvdmVDalBiSDFEcFlROTIxQmx3QzZFZEhwTDUrS3VKTUYvdVNpa3RP?=
 =?utf-8?B?OHhrVzI3SmgvTkpzTlV0N1JleGEydHZ2Z0VvamhlWHJDVDVtcG1HL2JnTVQw?=
 =?utf-8?B?cnpYWG93SnJLeFRsbHhxQjhVemN5K1hKbDRjclc5QlAwWUpWVjNnbzFmMnVo?=
 =?utf-8?B?VTFZUUYwM0M0cnhsWTVJeTVMOEp6QW1TS0hBNS9zbkNuRkF4YlVpOVdPZ3FW?=
 =?utf-8?B?anBxYWlEQlByZlhFSmNhWUcxNFcwK3BNSWIvTDVNN0hyR1Y5YzVkeGVLbUI2?=
 =?utf-8?B?TDNrV3M0eUVwcHk2K0V0UkJtaHNGZDd6UkNabzBQY1dFWmIyc1dJQVZVUGtT?=
 =?utf-8?B?ZGU3dTVEeUYrWnFBUVZPUklvTHZzKzNqOFZTWVZpZEkvK0x5N0ZuSm4ycFdx?=
 =?utf-8?B?c3pBcFdob2Q4TFBLMENTSm42VG9memlwMUNJb25jMVdrM25HMWpTbVFtOElt?=
 =?utf-8?B?bFlHUVVITEFiN2toM2tYUC85aDNaeEtWSi9UQUdKOTZMTER2dEo2cU1TTUho?=
 =?utf-8?B?OVo2K2xMckoxd3JLS241Kys3U1h0dllGd3NNSjFOQzMrTkxDTjRPZlpCMlIy?=
 =?utf-8?B?VlJCWVlqQzJRT24xanA0Mzk4emlIMlAzTzRPdG0rQWw4dkNlNUpQY0dhRnM4?=
 =?utf-8?B?WDNwRGxjK2M1SGc5L0dSV0owajJ5NHJuL3p5azZtNEhKSGpSRzA5UVpxR0o1?=
 =?utf-8?B?YzhJOC8yR1dWRXdRWFV1Y0FGNnhrT1RLaWk0ejArZW1UYUxyRFczdnB4L09z?=
 =?utf-8?B?a2Y4MktSSW9GS3ZFdk5yNDBSREU3eE54aXNlQ1B5ekVaZDM5Q3RqemhGNDRP?=
 =?utf-8?B?QjIyb3djZlBZQ1hJcExESlZrSy9OdkFOVWJybmVTeno5bkZCZzY5NjdmRGNp?=
 =?utf-8?Q?Ue/W4+NyaiKY38P?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a05ae8f3-2922-4d7a-7a4e-08dbfb2cec67
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 16:10:56.8760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Nt1yoHckcZDwBwagLLFKa7UjWSUHb4QJQMxS8sL6jcMHhGHhoa83hEPkeRNeHFBMJB95LapEj9Lsgx9qp20IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB6992
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_10,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312120124
X-Proofpoint-GUID: fX7p6JNxk0tGJnY7pndFef27JRnjYIjG
X-Proofpoint-ORIG-GUID: fX7p6JNxk0tGJnY7pndFef27JRnjYIjG

On 12/12/2023 13:10, Christoph Hellwig wrote:
> On Tue, Dec 12, 2023 at 07:46:51AM +0000, John Garry wrote:
>> It is assumed that the user will fallocate/dd the complete file before
>> issuing atomic writes, and we will have extent alignment and length as
>> required.
> I don't think that's a long time maintainable usage model.

ok, sure - as I may have mentioned, this was even causing issues in porting.

I sent the v2 series without XFS support, but the same API proposal as 
before. Let's discuss any potential API changes there.

Thanks,
John

