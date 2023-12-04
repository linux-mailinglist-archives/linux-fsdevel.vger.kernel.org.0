Return-Path: <linux-fsdevel+bounces-4760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A90B18030B1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 11:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFAE9B208FC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 10:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155D1224C6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 10:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mJV9Ikd3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="F8ZXv0pz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD346B2;
	Mon,  4 Dec 2023 01:48:26 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B49HYKS021232;
	Mon, 4 Dec 2023 09:47:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=XGx9OY7irmvDw8LBvMGoJASKgqx+21oSelP6FqtXb58=;
 b=mJV9Ikd3t9UWnBBCuxo/wHzUbii92nBfieW4klb91WQFegIYtqaNZicR0warFpUaRmtK
 mojxfILfvNAgtM4qewNpf//8/eRILP8CpkV8BzbZ5BujC2V7v0TR81Kr+6DpnGILIi8K
 bQl5BF48+w/oCs5SWKrr9cdP0eYNnMUS7o/bC8QPnHfZWDEaiFhMRQzk6tAghbL2ivlf
 cv5IzsGO5H21nWVk5YqtaZTOYTPhO4sMssu2E3N3pa2OmxLMxqKR9l1h2fEwTY0iVU/I
 aclZH1cLl5/Xks8Vr78v3zROmcRvl8FVFFPzRLmZ/Eq/TEOQcoEr6g11jvXwds27phqM Fg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3usc0fg3wm-62
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Dec 2023 09:47:52 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B47k3Kf005969;
	Mon, 4 Dec 2023 09:35:26 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uqu15achg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Dec 2023 09:35:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PyaYQB8+ZDFKy95P7KYl5tMctftXdw7+FRvpXrmbolrtIXyT/iFVGEzjxlSyP3bWV/let2t8WDqhjM6FaDzjfsn3fnH+DsaJ25HLnfzis24mbLdIRxbZhRTzYhQKaSMNLTSJFuod6lmIaaUsaZw/8hy13Bm9Fe/xnNOFBF+MpRpRLyL+HYSBvV+Wmw4XnQTl+QMINdkVhvpbnwVFcU5VR+H4SshDWrWjNdtsSZiJftiQ5hqyJBMxOMUp+hPiZcQn66k++tB8ILEw0Lu5le4H9nC26ogx1cQiP/TgenLInGZtHslAvY26dq5UOknxNdlBZ02Q+PkVvhaGpSNYcpZZJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGx9OY7irmvDw8LBvMGoJASKgqx+21oSelP6FqtXb58=;
 b=XYmdoqyfaRGqpisR5YS75oFgq3JSHmde75bDKDl8rRlzjxHSiPsxdKdQ7ccfvYq2SdtvEhNPiPCLFR/PmDuohL4G8yiSxMOQ2YenrfDlz5/Iqu/z/DNHFPuH1nIt9nI9qh771tyQ3KwN05gDXBDcO1mFR/0rLIwjD4LmNk+OjuaUxRukQGKBWfqXjpvpbI/nR5/MSDWBumHvWTxQ5u/V/sky7KJo1CuTEAIUnioB6cLFP1xJ3H+RrG0azq9pi9T1bINwUIF9g1VEqiXUrDsNyCHz8gGtRrW481G+ny3K76ltwh6eC1scRG6eqcZM/og+yTYN0efABm0PZTgSRIaMDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGx9OY7irmvDw8LBvMGoJASKgqx+21oSelP6FqtXb58=;
 b=F8ZXv0pzqz7z+kBziAmQ9bZbTNDhxz7D+DrOv6Dw3/de4dTcLMDinwY/1fOKQ9InaDID0wTZv+w07FqNRF6B0gVggmFIq1t9jHnlJQGbP9ekx1QhRdYsWULpC9LI6pzR+PeDU+E86FuVeldxNkI8pu56jfWsHVSDqzoqSB27Bdk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ2PR10MB7656.namprd10.prod.outlook.com (2603:10b6:a03:53e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 09:35:23 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 09:35:23 +0000
Message-ID: <ff43517e-ad30-4608-a8ec-401108129ea5@oracle.com>
Date: Mon, 4 Dec 2023 09:35:18 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/21] block: Limit atomic writes according to bio and
 queue limits
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, chandan.babu@oracle.com,
        dchinner@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, linux-api@vger.kernel.org
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-3-john.g.garry@oracle.com> <ZW1FOFWsUGUNLajE@fedora>
 <ZW1NxiEh2x82SOai@fedora>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZW1NxiEh2x82SOai@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0019.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::9) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ2PR10MB7656:EE_
X-MS-Office365-Filtering-Correlation-Id: ec379542-c92d-4756-c7dc-08dbf4ac5724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6jx1w7fIh32vQ0il/GjaOAkQ7a7j64uV3QTf6jnxbJM52tt4TvRrsTgeZraQbVRHt0bT5uYg3NVm27lDS3ljcBMRGGvWi7QBhjPyYKWVvh2SsG/fsditV0G+41XYXKgyLw2CIk6pBPKeAmX2mMl1zu3ofIrCzpwwjXHsuZoPMjmRu3NbJ5L8ppDtBm0u3Wf9FZB18iv9pRz1uVMlojS0IOB5HFTlOUO623y1mbfjv/SzhqIQmK5s9l8i0ExYiUxgXMZN6zRTC+VokjRZMVW65t9s25ufs6vupyBH3kXjW0rzjcKykLgsVpKf5W6xPnmI+mdiwW2/NaaZqokGItFUqT4SAepEorTfIzSa9/DkWmECFtwtXesEgQPwL37FkXolrJzvT7GLkK20qxZlGyJ/iOLn2CKaRutf/YqyQVe5qrUgnQZIDqX8iYHJ/1d3jO/gQWnO8+8+RY/F9beu0US4imU1iWT9omR6IeBffqvXVZuh3G7NRT47ftkd2a0bYwDwVDfFAz9utNS8RL4AA1D3sQ/06MmajGx+PsCwDgDA4mlmrmXTXTxtBp9L9VPKDFL+RP9IlIUpVIrbwEaJxElc6Epzjs1xMuLU4juvBt9CL5TOBIQ0yY5iK0eJjURfjuS6E+nJuZVIHHXEwCw/i5eFNA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(396003)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(2616005)(8676002)(8936002)(86362001)(83380400001)(38100700002)(53546011)(6506007)(36916002)(31686004)(6512007)(26005)(6666004)(6486002)(478600001)(6916009)(316002)(66946007)(66556008)(66476007)(4744005)(2906002)(36756003)(41300700001)(31696002)(4326008)(5660300002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Tk9jQlVOUms0U1k5b2lHTXV3T2ZLa1N6a2VPeVdPOGhTWmh2eGNFcHRYZUto?=
 =?utf-8?B?QldvTzlIVW9ORGFQa2FpYXdTR0N0SXppU2RqbWRDV3krOFNrQjB2ZE1XT0Ry?=
 =?utf-8?B?K3NJMDV5eWZCaHJVaitWM1hKNGpqbEJxYzFGbGNJalpVL1BWMnhPWTdSeDl2?=
 =?utf-8?B?ck16Rmt5d3RYTmZjbDNxSzJQY2RNU3FBRzFNcG5GZVBrelN0ODRMNlBXYzFp?=
 =?utf-8?B?SHQzUGNRQ2xRYjJoWXRHVm1pSnBBNkd5YURsOGZWZXdOdE9COGZIZ3RwYTJ3?=
 =?utf-8?B?V1JaU2lZQTYyaHpXaVBJRC8yNzBkYURHbFpERkptQklqS0hEc2ROcW1qYW5a?=
 =?utf-8?B?Z1FZaWNrVHZhQ0o2c29JdVhUSVdKd3cwbTJhUUpoOGpocllCamx4akRtUzIw?=
 =?utf-8?B?VU1abTVGNFJwbUlxWFdoQWt0TC81MzJlWkZ5RWNWbXNEazRJWnVIZmhPS1N5?=
 =?utf-8?B?cmo1UDdJUTJlYTB4NW1rWFJFcFRnNm5scUZlbWlmdlI0c0psSGQxUXRXeTcw?=
 =?utf-8?B?aFV1WXRObHJha3Z4bzNxdnk2QXF4eTlVWTIwRVZONnBXZU9ISVErMnN1VHpt?=
 =?utf-8?B?R2RNa3cwQzZTd24xWERSVW5QN2MyT0k4emFCRnl4emtubng1M1d4bUdRMk5I?=
 =?utf-8?B?blUrYkhjZkIvSVM4Y2hvTGNzMHozQVUrZHFNc2ZCeDhGVHUySHpoSzA1M3NK?=
 =?utf-8?B?QmwyaEhWQjIyS3M1UjV5VGhCQTRKd1hBM0RjZG5LamNEZ1lFL25USklmU2Vo?=
 =?utf-8?B?L04zZnh6am0vR3Jrd3dWbEdMWHYvcmMrbmV3UEZaRDhnVm1aOVhjQk5wV3Uy?=
 =?utf-8?B?OFQ3T09ucjRUN0RqN20wY2IrMHNvYlcwTTlITG8ydGZYOFp1SVRJM2pNcEVC?=
 =?utf-8?B?dlE4VElWcVdFWDRFSTVXVGhGcUxsRlpEcjl1YjJMUVFMbEd1b1oxTUprRFRY?=
 =?utf-8?B?b09FMHpFa0tGdDNNS2xYSWtSNk5YcW4zU0lqQWg1d1VHTGVWU0pKTXhYdDFD?=
 =?utf-8?B?T0xlWklHalRDRU1VT2Z3bkYraTRDYkkrd2oxRUZVU2VpdDc3L0ttMGpLd0Mx?=
 =?utf-8?B?K0UxWndrUE9LU3Q2TWoyc1ZUbkN5ZERMNkxtdWdGaWgzMldXbFRHMml4eGVn?=
 =?utf-8?B?UlovMXlmK0F6S3hhcGxwN0ViY1VVUTVVL3NsNEtVM0VSR00yaTdFdE1xVHNS?=
 =?utf-8?B?dk5JdWh5NXBsa1ltMldJVlN6OGFqbytVTUFGR0RPc2lJSU10Q282RGhVK2pB?=
 =?utf-8?B?L0cwSUI2QVRBVXJhc1NycUZhbkNVNGtGd1hYQkFUYWdma2EzdTYvWTJnTEtN?=
 =?utf-8?B?S0g0Z0xvcVFycTRhV3RVRUNRQjVwZzdqZDl3NSszZ0t1M1BZT1JLQ3c3RTNk?=
 =?utf-8?B?dmNlSTN5SWl4dktHRWQ0d1R2bVdIbm9VY3RnOUVVM1h1UlJwSHhoaEx4dnQw?=
 =?utf-8?B?K1hZaUhpT1c1SE1UczFPZllsaXZjaE9hSUt6T3huWWlKclliakpJa2tEbWkz?=
 =?utf-8?B?ekhzbGZOSFJGeVF0MFFoTmdOcW40czBDSC9kMCtDY3JGUXVweVF4SGJPWHBV?=
 =?utf-8?B?N2Z4RkFDRnBNT2JXanh2VUEwRUcvWXdkZzJPN0ZyMEhGUmIxcmdnUzVCSVBS?=
 =?utf-8?B?NWhzd3lwbjZyOU03NWNiMjZUUHVjTE1SeER3TU4zRWJxMXIyeHc3N0xjcWll?=
 =?utf-8?B?aTFpS2NJdnNtRmEreTJIOTNOL0RaTzkxLzc0TVRSSmcxYjA2SFZKNDNYSnhB?=
 =?utf-8?B?ZmZ4RUxCNlF5TmpiOElXdjFMOHErV0l3TE9ud3hOWWZnT1UxL3J2QkhXYU1O?=
 =?utf-8?B?WUZSeWM4Vlluc0ordkIvT0lFWnBibDA5d2FOWTFPeHhGTFp0MlNSbi91dldV?=
 =?utf-8?B?SEwyQU05VWVmcXRyY2xZaWRCeVNpMDE2TldPRld2eEdVd0RmZjV6TXlZK0Na?=
 =?utf-8?B?K05LNzd4ZHcyY1BtNUNZTnpnTml3SzBjazk1bHd5TlpUTVc1ckZxTVRJdUps?=
 =?utf-8?B?S2xmY2RqSFFacFJkWlpMeE13WWQzWS9rdzV0MmF1RXNkcXpFSDdsUlF2RHF6?=
 =?utf-8?B?d0gxNlNiNjhDOUxSTTQyNldsTkEvRnJYdnVCTlRoTjhZYTdBcGJtYmN3UlVt?=
 =?utf-8?Q?3DsqrT5GA80cikvHh3GeO0baV?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?SWxiNU1DbnRwRFQ3ckVibDlNam0yWHVBaUVlODdKR0pIU0FxNUpCT2FOOTdL?=
 =?utf-8?B?NTFtRElHYnoycGVYN2QyTkp4L2dwSWMzdTV3d2o2blBFb00ySEc0bFdvK09m?=
 =?utf-8?B?aityQlVUWWdTVW8vUkIwN0NyeXV4TklYS1JWdWdaRHVvZmZWVW5MRlhia3NB?=
 =?utf-8?B?c2FPRm5BWXVZNEwrYmxUdjBYQkxXQ3RvcUdNeGNHcWFIZjc3N3hSNk81bjc4?=
 =?utf-8?B?b1JhTXBYQkxQWHUwWkZWdFZ6a0Nqc0s1VGlkbm4ySVRQV25yRFFSbm1ya1Jo?=
 =?utf-8?B?enpsZ29lVW0xOHNlWHU5dzB6L0oyVDA1QjdmeVd5TS9FMmpyK1ljaDVVNFZl?=
 =?utf-8?B?RmxxNEhkb21FNktTUFlRei9wR2JkVWg4K0tJajh1ZzNHdHBJM1JGSHFmdkU2?=
 =?utf-8?B?Y3Z6eUtZbTNRYllXZlQ2UFNEc0o5RXlxMzNKYVJoYkl4MitHdHZlTmlNZExH?=
 =?utf-8?B?NTJPR1JWbTVlbHB0NUJ0WlBaL1dSQVM2UThCbUNVZXVDa2JJU1pCelNUV0lx?=
 =?utf-8?B?a29ReGVzbGhBcHowdURWaTVQRXdHSUl4dWFWcHBJRysvZzV6bnJPbk9qZFB0?=
 =?utf-8?B?Lys4QUw1V1FqNDNjajJCZGU5TEg2UGdOR2NjaTFxdkJNQnNkSjFDYWRBeTNH?=
 =?utf-8?B?SnBQSEdQUUg3eHVKT3NrcmcxcWo4V0xUeVp2TForb0RMR3Jwa1REQW0xU1hQ?=
 =?utf-8?B?T2dHWDNDUnRBbnpmdDhjZDdBb3JqenNaL25GZ2VxMjNnWFVOUDFMbkZVYUdh?=
 =?utf-8?B?Q1RoTS9TL1BmZnh0MGdhWEdUK1hWRU56NThScEdPQlViaFVvM1ppN3pOamNZ?=
 =?utf-8?B?ZHFoMzl5T3AyK2wvM3c2OCtnRnYrdUN3eFZWcTkxbUFIdUdCbzB4YVM5Vlh3?=
 =?utf-8?B?YlpVRThuSCtZTzlrb0hOVS9kU1VZWjRBOW9xbUplL0tyK0JUeUNnOSt1UlRz?=
 =?utf-8?B?ODdYcjRyc1RhT0o0TWxNYkovY09la3A4aEltaHo0UXhoempKZFdCeVo5Ymdv?=
 =?utf-8?B?VkRNQzI5UGtNQUtsbmR0NStXSFF2a2t2REVjc3lrR1p4WjE3ajBFWlg2RGFP?=
 =?utf-8?B?V3ZiOW0rUFd1dU5xVmxkYytTWDdQdnFUbnpzT0VWVURQQ1BEdThxd0lkVTJB?=
 =?utf-8?B?a1dFYlFvN3Nobk9reGhjeXJ5VkhaTjhYeE1wajdMNEZhNU1QK0ZENjMzUWtn?=
 =?utf-8?B?Y21SdWtDZS94cVZTT0xiek02NmMyNEw3MjU0c01hMVNkTUJUVEI3QzhOVEU1?=
 =?utf-8?B?eit6Qjkwc3ZTNGVhejE5c2dSQXdEYXltUWs1L0g1TTdIbm84Y0ZUTW4xMWNO?=
 =?utf-8?B?dGt5MlExeDBmRnZ2ei9rMWlISzR4NC8vcS9jQVNhSVlqT2dIZ2Y5dHBYT2ZG?=
 =?utf-8?B?STBWRm5rYW04RGN4Y0VaN3ZvdTZhNTZ2aFlwTWUvcXdOUFJRb3ZiWk0yeHNz?=
 =?utf-8?B?T01vcDJ2Y05xUGgzb3lpempPaDZKN2RKaHk1dmNRPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec379542-c92d-4756-c7dc-08dbf4ac5724
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 09:35:23.8858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 96w5qNAANp0OdINdt8ZOMKOqe+QM1ZTtw3sUyDRQmkFQm8CRig0F1K4hq/nMnbAVjOcb73HKwTn4Aay5bw45Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7656
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_06,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040072
X-Proofpoint-GUID: NHfy_dSQwI_vO_hWpkMoQVdr5fHwZauk
X-Proofpoint-ORIG-GUID: NHfy_dSQwI_vO_hWpkMoQVdr5fHwZauk

On 04/12/2023 03:55, Ming Lei wrote:

Hi Ming,

> On Mon, Dec 04, 2023 at 11:19:20AM +0800, Ming Lei wrote:
>> On Fri, Sep 29, 2023 at 10:27:07AM +0000, John Garry wrote:
>>> We rely the block layer always being able to send a bio of size
>>> atomic_write_unit_max without being required to split it due to request
>>> queue or other bio limits.
>>>
>>> A bio may contain min(BIO_MAX_VECS, limits->max_segments) vectors,
>>> and each vector is at worst case the device logical block size from
>>> direct IO alignment requirement.
>> Both unit_max and unit_min are applied to FS bio, which is built over
>> single userspace buffer, so only the 1st and last vector can include
> Actually it isn't true for pwritev, and sorry for the noise.

Yeah, I think that it should be:

(max_segments - 2) * PAGE_SIZE

And we need to enforce that any middle vectors are PAGE-aligned.

Thanks,
John


