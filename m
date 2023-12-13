Return-Path: <linux-fsdevel+bounces-5824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DBA810D84
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 10:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD4AF281793
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 09:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C2A20DD9;
	Wed, 13 Dec 2023 09:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QqxXaKHE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XVfYX788"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB51BBD;
	Wed, 13 Dec 2023 01:32:37 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BD9THVq026875;
	Wed, 13 Dec 2023 09:32:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=9JQ7HbFIzVUkp7Gg9vKN7UdPTFiqThqgfezhSgI+mJ0=;
 b=QqxXaKHEseiuA2PsNfg+IWEht/UE3/oiCIO2++2inkM/VzA+1yO0NADnc99+VZuLWPlU
 jozKz83ezYkjr6R2eiGe6xgHZV49A7NkUMSI9KyJnMJzUcnB0r1rGPotPre8ye2vzA0V
 no1V1T/Mz0EuSNEBhdhu/CK77r/xomrCSbxht2+WcZOpFgAjrwkXUa6boisqWAxsTXP8
 9YFwKTs4ir+rY0jWKKCic0QQPu7ut3Tvmy/NKZ1hJ6knnIk1fxaxMV7Ku0vUrS6LQ/BE
 yeKtvykQWjCUyy0LuLfFPeH+qBKfj7gwVTezePNZ2H3f6NdbtM8aUNxXSpOet5nQBP6C lw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uveu27pv0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 09:32:13 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BD7YIBL018417;
	Wed, 13 Dec 2023 09:32:13 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep7y0y8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 09:32:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUplvEjO3Q4rnu6gmGp6myljBUa2lovTextPBX9azHTeLqgr0yldxl2+SkdwB2m4kvsay7gBoYMTtwk3janQNKV5chIKYMlA1jwA51teahN7IWfujvunGzxzD8Gmy3WWxPWKnT9qWDQHoaLUKI82+eH9aWSWr8ahzPuQxGdKUPJswYkHPbEzizHN8u7X+7doGXQv4xmBGc4ItPD1twk6UTRfnVddVaqisZKRXdYEWRQf9y9BeutK3CsPWXkoIEd/m/5S0UEPLyUdjcQwpdSqJ3W3Hy+nylmNiLwn01hMydmjrcOuzs7gjLhnPoXV+pUJ79J6vJZ6sh/Hc0Zj2IyIZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9JQ7HbFIzVUkp7Gg9vKN7UdPTFiqThqgfezhSgI+mJ0=;
 b=CwVdT96Di7MzRTqmKCUFa2+fqZJuJTk21svkFRyjCVtgBQFxtuajd3/w4mwSOJcfSmIWUYwNLSvWu0GOdXzX05G1yt6ipBzpCPwXUV6dzeCe+tsH9GcYujCiGtdhEzPYzPKyK/zdXyE7/K6tSQ0Tb0pH1U/3CleKwznGvFxVjdhT1SbEniymnAyfM6vRdXREpuMXQF8smJCrTvhFctgklqADIw0/0t15DAwck45YKIK4WxoA63fLQ2HdFV+VuhCrvZrMXTdJVhLpZVtcHeVvNudWW+aDAsUdSRkc9eC6wzUT/AiFQgUyH33nYEzk9QdNwCBdtlDmv8Ov2SEhatJqvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JQ7HbFIzVUkp7Gg9vKN7UdPTFiqThqgfezhSgI+mJ0=;
 b=XVfYX7884+kQMNDgWd/PIG90VE+8P5fLG8ksezwMDZloIRozq/IVPhReftPpJnrPQzB+3sneoJ1KN0NyR7OFrbprmKUTKzL//rhes/gv9DfnRTRKvq+T8mFyhRMEOEFYiRzeE9jPSjzbMoAh4K23CVyBzbbXnvK4dWaeFyw6l9k=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB7391.namprd10.prod.outlook.com (2603:10b6:8:10d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 09:32:10 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 09:32:10 +0000
Message-ID: <b8b0a9d7-88d2-45a9-877a-ecc5e0f1e645@oracle.com>
Date: Wed, 13 Dec 2023 09:32:06 +0000
User-Agent: Mozilla Thunderbird
From: John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v2 00/16] block atomic writes
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me, jejb@linux.ibm.com,
        martin.petersen@oracle.com, djwong@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, dchinner@redhat.com, jack@suse.cz,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-scsi@vger.kernel.org, ming.lei@redhat.com, jaswin@linux.ibm.com,
        bvanassche@acm.org
References: <20231212110844.19698-1-john.g.garry@oracle.com>
 <20231212163246.GA24594@lst.de>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <20231212163246.GA24594@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P265CA0009.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB7391:EE_
X-MS-Office365-Filtering-Correlation-Id: fc460972-9de3-438b-62e9-08dbfbbe6188
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	9tlpEx0bx++oTV2fILiZdVW4GBnAJQxu2eltdGXXyJiikrk5sTfVNWRGy8lP9cvn7TvNJlds7MK/xVS54r/uVax85SKsnc0LHvYgvE2ETLuJmw/amxshr0wdyp2pn8NeRZx2X+bJml9keunlGMFxfdhUbssXFGQ1O53FKpV5XVeWGNP35dQqovASWK9bOAMLKlAgvvUAA7l3UTyBpsKaWfB+Nlxnxl3WbHLCYL0Oslp/coIV2tA98biAspg4EcvkOcydH91hc/2FKrlNQiVrHkMfSLTV0M+8fcH98gtzEkyhRGqkILRR9OkBZcq8AhI2WmAyINbP9Qg2BreI6iQJqvZx16cOAE2pH4XK5XrWYyFobAJ3L4NS6Ae4qIwjYT1+2m59Cmg/NKH1JeY3PYShwVP0pCmNbrEpE2cDsS5Oi9BG4QMQT1IlhmF6QUpO5VaG94/S36Ek+04D1gEYVgL3O+ynrMiDVw7iO4EWJ1j4OOYW3IZEAx0YsEapUAbK/7SLTuD1oPTs660jx58hczzquHsS3SudSXtCxr+Ik7HCMkSTiZrQol5gCSpOek49KGNJ0XyRUWxXvFR+syoyBS7GVao7vuBNoo1EpIBdrAWkljtdJn+cy5fbLtwJKm417qUGv2o2pHTAGq3S7LoqBU8obw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(376002)(366004)(396003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(2616005)(83380400001)(53546011)(26005)(6506007)(6512007)(6666004)(36916002)(38100700002)(4326008)(5660300002)(8676002)(8936002)(41300700001)(2906002)(7416002)(6486002)(478600001)(6916009)(316002)(66476007)(66556008)(66946007)(31696002)(86362001)(36756003)(31686004)(66899024)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eThvMEtkV21GekZ6aGNXc1ByWWZodGY1am5EaGRiRzlyaDgyRFEwNkVnKzVP?=
 =?utf-8?B?ZUc4bktqbVJ3QXdjVjErT1FsTm44c0pMMmtqc3UyWEtONjJNVXJEc1VZaUZm?=
 =?utf-8?B?YUhUbE9qUTFWeUQ5TklSeU5BWUcvdDZ1RHMvcmtoMDVzalZXblNMMDQ2WFZj?=
 =?utf-8?B?NCs4SlE0bFJKMmU1SUpuOXdMTEQyKy9Sb093dTRTR1IrMkwvdnprK2tOQlhB?=
 =?utf-8?B?eHFlNTFLUTRQbGRyYkFOWkpoeTVrOHBscGRhZDJaR2g2a3VGRmsvcmJTT0xp?=
 =?utf-8?B?NWNYMW5pMWs4UVlrRVFVMUpJUG5sMVV3WEd1VzBlWlFUbmNlcnlaZnh5U09O?=
 =?utf-8?B?V3VnTHFtK0RvdkhaYlhZUVF1Qld1TFpLb3V2V0djOWlHWkg2dUorWmRRQ0xN?=
 =?utf-8?B?aXlLSS9qZzZUSXNiQ05GR1FQc0ZxbDZ4VWM2TFhSaXI4SVM4RXRUQ2JuVmNO?=
 =?utf-8?B?bDk2NkZTaXErcTNuKy9pd1BqQXJaOEd1SHVpTjM4TGIrVFhwUnVIOWZObnc5?=
 =?utf-8?B?L3pFWVpIb0JFNlVrZDFESG02QUVCMzFnaS9lMlVEamlQa2hOajRkS3MxL0Nq?=
 =?utf-8?B?WTVpNmZqaDBTNWlPYjZURVVweHVHd1UwOVJsVDA5K3YxN3A0WUIrazRjU09Y?=
 =?utf-8?B?SDRZNDBTVGk0aHhwMXdFYzlSZHlIRHZqSm1oUGQzcWhpSUI5OERXWUl0ME9B?=
 =?utf-8?B?aGhhUHJqUDBxckFvb3JuYlpRWE9STU5XSmtMcnU4VVNMSjV6UEtEQW9PRWVt?=
 =?utf-8?B?ZW9uSmZkUm8yclJhajliR1AySU9CckFueHlkeklMSHJGK1d2c0YySGtQLzh2?=
 =?utf-8?B?c29tZ0lFUnNyd3I4ejlDQnJ5cUtXWXQzUGJGZXdJem5DVVJXaDNxckIwWTND?=
 =?utf-8?B?WFN2Wm9VdUVENlNDcFh3ZkJKL2Z6bkJYbHY5SWpjdXo5eGhGYXFIcDcvaHo1?=
 =?utf-8?B?eStkbnZmOGp3S29jZDZVUWkwQnNwSlhZSzNMTldNbnBacVBjTHBuZ1BQWUJE?=
 =?utf-8?B?ajl3ejNoUURtSEdVb1U0UVVubFFIczBsU0Rwc0h1dWorRldhYWQ3akVuOUQv?=
 =?utf-8?B?Mlo4Z1N4cC9hc0FvUXFzQy9mNWdpRXBPTVAvVm1WTmNNMmtBckdWSmtGdkRk?=
 =?utf-8?B?YmpNblZLTzl3RUJqL3gwY3dvT0YrMUI5WGpjUHNkTEpVTjE0T04waXdRVE42?=
 =?utf-8?B?S0lTU3ptYS9WNGhabkNzaFFRRkpYY2RhQThmVmpPTEFIcC9OUitqelN2Q2xt?=
 =?utf-8?B?VC9Jb2xwb1BrZGF5bTcwdnY0Snc0eUJ4ZGhJeDhodHhkRFpSSnd6Y1VKRUNX?=
 =?utf-8?B?ZWo4Wm1rNTR0ckpBYXR3UXY2c2NqV0g4SGhVWnU2My92UTh3REJxTzRhczNn?=
 =?utf-8?B?M0hmWGNXU09xYlArVWRLSm1OMHJmZnNNdGpTMXBGS1ZmNmRjTS9aT3kwYThU?=
 =?utf-8?B?K2NRQVJlR1ZJa0g3SGVOcVdvV21TQWJxTmYveUVzNEJGeG5ndGZtMkU3ZEE3?=
 =?utf-8?B?M1dMWElMcHRHM3FUSzY2R2tMcXN6V2Y2ZmcwTWpqRDAraWhGVFZ3QmFUTmJK?=
 =?utf-8?B?T3FOOFdRK1JOQVdic1pueTQxZ3lTY05GcnpZZ0lPenFqbUZ5d1kwZU9SODVT?=
 =?utf-8?B?NUlJVlRTcVNpOWRaV3o5d3pyMkhvUnJTOTdKdWdrTWJ1Zk1nVldqTmphaG5G?=
 =?utf-8?B?VmlBRVI1T3FxTGpRajRqYy96empMSE04bUZ1Vk9oQWFwR1M1YVA3VXZOOVZw?=
 =?utf-8?B?aUFjQUlxYmNqVWtxUTBIbUlZMnYyM2FuUjIvMjdRSWwrbTNrOE42cGZZMTBa?=
 =?utf-8?B?eHgzL0ZVNWFRRlV6c3MvVnZmRE5KTmNRS3JGeG1ydXVMemw5aVhJNEZvbU1w?=
 =?utf-8?B?aEMzTlprMnNLcFlIUm5zOFNBL0dod2puNjB0eW9FTTRwOXNGdXhwK1ltZ3Vk?=
 =?utf-8?B?RTU5eVlpbkFtMTU2aEFzYmQvZnlERC9VRVVuSUtIdFlobmtMLytteDJTNzgv?=
 =?utf-8?B?d2ZRS1FhcWpkT0pIVW9LNXFOb3c5YmIvZDZoSjZObmdOa1krYktSRDN0RmpK?=
 =?utf-8?B?M3djb3BVRVBuRjY5N1VOdXBOTDFnSGNHMTMzc1RFUG5xMzlRVlllOW1NWGlR?=
 =?utf-8?B?YUlZd2dPeldWSlVKOEoxSlEzbjJDYzhNSVFlSUtqam5uMmw5QWlWcmVZdzhk?=
 =?utf-8?B?dmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	aXVMtJ285YLsW+SNQroFAZmNZ0AsVsWwr/KMFygTpn3sugdX9pJnDfUgxCNc0gImcGO4cIArkRAkdaou2Hv+6+nfBbPeDba8jjn0AsWW7/SrxhPWs5eiROtbI0IJffiHeKkAxHNsV9xscungWFFAnCiq1RmgNJ88O4UFheLg7S6HidPQluJ0dBoLYLBn+INFgR4pPzyNPVjMgXu2A+uboMJy9Y9F9lQBpiAaF1xjFjz05hI9n3yc/8djX6j4OzBtvOP0h36PRzaKi2OtFiBuzLScXI1tFJa+rM0T3VR1SufrOo+VJw3EUqGLUEkh9MdDoy/QYtqCrBwrdR+6UUe2GXHtuPKbl/nfKxi9nvZD5GyUbvwR0+76jV0t/Xvn4fsMYrJbZJ6WgkvAQu3h/mRQEYbYet9L6VTZTPTtr/YA64sVukPUnwQagpgIjzm/uOIM9vuFZHosO48Ssi88kL+mLqr9Gocb5GLKz7sP01fH/AFj1JpwuxBT22qNPtI5MIEr6kKuBT3XDZSd1dz+owStcxy03nfIm9Pfui35CTHbnBBlzQX3qs9vhgCwuPDErb8KG3sVwVZiBJHA7VWBf31Mz2n3kMYI/AbP80u+X3UBUS4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc460972-9de3-438b-62e9-08dbfbbe6188
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 09:32:10.3760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eM1njiCqQVuVomyuxplsZVnS83dgywUqHyy2MP7pcQmkvWhCSRZj5YGb2hfhjsJR1ZzJwGYa+CHenWXSQ6eDnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7391
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_02,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312130068
X-Proofpoint-ORIG-GUID: RaXrXy1qf9WHtTYwkwzKaHWgaqe7v1QE
X-Proofpoint-GUID: RaXrXy1qf9WHtTYwkwzKaHWgaqe7v1QE

On 12/12/2023 16:32, Christoph Hellwig wrote:
> On Tue, Dec 12, 2023 at 11:08:28AM +0000, John Garry wrote:
>> Two new fields are added to struct statx - atomic_write_unit_min and
>> atomic_write_unit_max. For each atomic individual write, the total length
>> of a write must be a between atomic_write_unit_min and
>> atomic_write_unit_max, inclusive, and a power-of-2. The write must also be
>> at a natural offset in the file wrt the write length.
>>
>> SCSI sd.c and scsi_debug and NVMe kernel support is added.
>>
>> Some open questions:
>> - How to make API extensible for when we have no HW support? In that case,
>>    we would prob not have to follow rule of power-of-2 length et al.
>>    As a possible solution, maybe we can say that atomic writes are
>>    supported for the file via statx, but not set unit_min and max values,
>>    and this means that writes need to be just FS block aligned there.
> I don't think the power of two length is much of a problem to be
> honest, and if we every want to lift it we can still do that easily
> by adding a new flag or limit.

ok, but it would be nice to have some idea on what that flag or limit 
change would be.

> 
> What I'm a lot more worried about is how to tell the file system that
> allocations are done right for these requirement.  There is no way
> a user can know that allocations in an existing file are properly
> aligned, so atomic writes will just fail on existing files.
> 
> I suspect we need an on-disk flag that forces allocations to be
> aligned to the atomic write limit, in some ways similar how the
> XFS rt flag works.  You'd need to set it on an empty file, and all
> allocations after that are guaranteed to be properly aligned.

Hmmm... so how is this different to the XFS forcealign feature?

For XFS, I thought that your idea was to always CoW new extents for 
misaligned extents or writes which spanned multiple extents.

> 
>> - For block layer, should atomic_write_unit_max be limited by
>>    max_sectors_kb? Currently it is not.
> Well.  It must be limited to max_hw_sectors to actually work.

Sure, as max_hw_sectors may also be limited by DMA controller max 
mapping size.

> max_sectors is a software limit below that, which with modern hardware
> is actually pretty silly and a real performance issue with todays
> workloads when people don't tweak it..

Right, so we should limit atomic write queue limits to max_hw_sectors. 
But people can still tweak max_sectors, and I am inclined to say that 
atomic_write_unit_max et al should be (dynamically) limited to 
max_sectors also.

> 
>> - How to improve requirement that iovecs are PAGE-aligned.
>>    There are 2x issues:
>>    a. We impose this rule to not split BIOs due to virt boundary for
>>       NVMe, but there virt boundary is 4K (and not PAGE size, so broken for
>>       16K/64K pages). Easy solution is to impose requirement that iovecs
>>       are 4K-aligned.
>>    b. We don't enforce this rule for virt boundary == 0, i.e. SCSI
> .. we require any device that wants to support atomic writes to not
> have that silly limit.  For NVMe that would require SGL support
> (and some driver changes I've been wanting to make for long where
> we always use SGLs for transfers larger than a single PRP if supported)

If we could avoid dealing with a virt boundary, then that would be nice.

Are there any patches yet for the change to always use SGLs for 
transfers larger than a single PRP?

On a related topic, I am not sure about how - or if we even should - 
enforce iovec PAGE-alignment or length; rather, the user could just be 
advised that iovecs must be PAGE-aligned and min PAGE length to achieve 
atomic_write_unit_max.

> 
> 
>> - Since debugging torn-writes due to unwanted kernel BIO splitting/merging
>>    would be horrible, should we add some kernel storage stack software
>>    integrity checks?
> Yes, I think we'll need asserts in the drivers.  At least for NVMe I
> will insist on them. 

Please see 16/16 in this series.

> For SCSI I think the device actually checks
> because the atomic writes are a different command anyway, or am I
> misunderstanding how SCSI works here?

Right, for WRITE ATOMIC (16) the target will reject a command when it 
does not respect the device atomic write limits.

Thanks,
John

