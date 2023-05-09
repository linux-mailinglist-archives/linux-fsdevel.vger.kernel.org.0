Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3246FBC61
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 03:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbjEIBMi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 May 2023 21:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjEIBMg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 May 2023 21:12:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAEC6E9E;
        Mon,  8 May 2023 18:12:34 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34900AgF006459;
        Tue, 9 May 2023 01:12:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=bEc7stED7b4H6D8hfuvGqH/zlZfXJvIR7Ln9PAcDRfI=;
 b=lldvNyLf7JvqgNnzvWn/U/NzvwQGKyI4r7k9sqGxZ2MZhW/CcbSskNEml8gkIByWIcin
 FvyBiaQvIE10wuIk117LOUdYAMyMQc9/dFtBuEhrigy0SZtY9ziM1IAOFAwYleIzxJTo
 ysKN69usgIPRi8x+xvRSaKRmvzvWmqZ4U0yT7w5TEMOxKIdKqDuRkIA1SqighReQFl17
 m9a7Nx0OkM8Sg4PX+jt15AAOLwZQwYmt6rtwWHBqwlxmGOwJyf5s7KEca//6e3QeoBEg
 n9iVLqPmWaRgDoKbKiPZlte2IG7+MQRT8avG/vFkiPRFTJlOlVB+Oo2s/K/tzCy10/K8 UQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf77g0j50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 May 2023 01:12:12 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3490dHQS015887;
        Tue, 9 May 2023 01:12:11 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qf77f9dx0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 May 2023 01:12:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9CDYgcvy2T1UlnAT76f1VPzebkTkAFhTnqpe07egCSDstkMpdk9LmX5NF/HK03O3BIlsmD5CUNeq4k9gDI9Fx55jI9tIpRZLw5Urxpr0PKCmnmekmvwsap1yxVdatt302JhFoRbFQoMsUPJTzgXmnwXdyRTnjRfsTl5kpyai5P0eooRh/lSlOEIaMIe74pNKTi63M6UYOmSLr+GyNN43bPvJ56AF7M1yJ+GzVU6IY4rHxbhETBsTB/fpIuDk1+xmJLay/qkcelxL4briqg87FdNRIEeafFibvFPTSFCq0YQtXI7fED1m1TAw099MqfVAwXHtcE0g8zp+qguFVnx8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEc7stED7b4H6D8hfuvGqH/zlZfXJvIR7Ln9PAcDRfI=;
 b=CMUj6I7u7GwUNoDaxhkw3XCkwsbLR7QmTO+Lm7JbWdetT6Qg9Urm2AsQZHPQViBbBcW0iqsRqFPFYnAtWfMmMh0D08Gpo9xoUOYYPss76KdqyiqkW944svGN7kA0fPBmhBah6zykYo9GqhK3uW54z5tmDxqYYSbnimJNlO/naMJFx6yM37L5Zfc+OKXye5bzvEyBdLL/I30gQLjO0PHm5a36iGCiAI0bVUrdJNcgovIcfjM0mrzh6jwi9y1kLzhnUr2HDbDl3NV93Bep33mKqIp5//TFyZ1ExIcfKK4OL1zlCs+c5daLO0jUoc2/itFiAaaiSjviRZiAEUJCiFoEug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEc7stED7b4H6D8hfuvGqH/zlZfXJvIR7Ln9PAcDRfI=;
 b=Q2JxZ4uOHicwpY6lVnqdNLGT/j9QsQTn3ikkuVKfhcqp2CGuthb7+H1pV5BehdDRCadf1sdXFCo6sAn2gPWiVxjYw1G0rFgCdAl3QYSxtsKaWjG8XUMCW3T7p3HwRZYPiTFO9zlfkBplx42jdRLVjdmiQXPRqf0vyAqQbcjmNtI=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by CH0PR10MB5324.namprd10.prod.outlook.com (2603:10b6:610:c3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 01:12:08 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::256d:125b:8053:eeb9]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::256d:125b:8053:eeb9%6]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 01:12:08 +0000
Message-ID: <ba6790e0-23aa-4069-f9e3-982c5aa6ab29@oracle.com>
Date:   Mon, 8 May 2023 18:12:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3] dax: enable dax fault handler to report
 VM_FAULT_HWPOISON
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, willy@infradead.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230505011747.956945-1-jane.chu@oracle.com>
 <64546aa46676f_2ec5d294d1@dwillia2-xfh.jf.intel.com.notmuch>
From:   Jane Chu <jane.chu@oracle.com>
In-Reply-To: <64546aa46676f_2ec5d294d1@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0046.namprd05.prod.outlook.com
 (2603:10b6:803:41::23) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|CH0PR10MB5324:EE_
X-MS-Office365-Filtering-Correlation-Id: db9e86b8-f677-411e-20b0-08db502a68ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NzyaRkpFYEvL+Q5r8MifN0ZHO/T2bytM/G3K2Jo+5ewpaKWhaGNnwzcrSRwKyosE9flYKmM75r7Ka/QuTxE+0YUpDlI7aOhl1jzB7zcKg9cBLjMVTCzxMWEPi5BdMZUYU26mqTZawj/J58ZLViRrbq6r9ZJAaVgHLz2eSykWr6DFD2elHpRxeqZIVYuFhnj3E+dLHY8hbqLBrp59NSmfVThdfCSCmNpAI2V4ssjPDwz3umD7r6lzwujiNxy7HL5BhDAFE+UHgsZCAs+wtkjlRV6/u4Qygoxe0FNQegvCEFdSjFZx4hBci6C5v/kt+NToZkqCfoz6WuAYVh+PUjIDk/9eaU3QfF+r1uA+HbdQmj/Aj72ltmjomJCgNCLuIQ9eWpvZZTL4Qr01dq+TCWWeGr6MHeTlTdXlwvf8OSah9JlLxgPlTvOe3IK8hCZI6U0e7GsYC60utYCo1MLzqqe2Zg8kC1FFhB/Ni7z8Cm82xg5O36ZMRIJY9xtbuDfauSM7F0PjE96qX+ieuQA/6WisPxAab/8Ts2R6e/6FqVw5ip2jXOgSozuqJ/qJ2ah2jqu2C4dHkewCV1XcEwbnlr7Onnk8Cl8jzLuaxitp5e9SZQ4Vt8eZnw0MOlwVdhj0rynbGAo/RfVgVU6aAN8wvlDZnKvZxeWzsK7nNCA4Imwbn6U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199021)(6512007)(26005)(6506007)(53546011)(6486002)(83380400001)(921005)(2616005)(36756003)(38100700002)(31696002)(86362001)(186003)(41300700001)(2906002)(31686004)(5660300002)(66476007)(66556008)(8676002)(8936002)(316002)(478600001)(44832011)(7416002)(66946007)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0tPa3pjT2ZraVF2c1BUSzh5VzRpU2Jmd0w4L1NNeUlmS245QUE1dHBFc1Vm?=
 =?utf-8?B?NlVmdER3YkgzcFVMZ2dMZ2p6dzljeHkzY0hyU2NEM0xrL3FXeGFHM0VmTjN6?=
 =?utf-8?B?UXFvMXJjRmpCK3dFVFBTQTQ2MTZLQmRYTHo3UWRoQ2Q1MXgxWk0wR2FxZlhw?=
 =?utf-8?B?cGlCUlZFLzNHZmtTZ0c0ajRDdktMejJ1NE9SeVZpcFNKQlpld1g4YVovYkNU?=
 =?utf-8?B?NStFeVBwR3V5U1QvR1U3OG96aFZrQldRQ0R1QnRBK3NUUGNvVlgyV3k5UEFW?=
 =?utf-8?B?MWY4Sjljb3lnUHJDQVVQNmYwaHFERXFmMVdPTTlBUllMN3ZhMVdzQ1B3Smpu?=
 =?utf-8?B?TnBYdTJ6TGFreFpJWUtRQTQ1ZHgyYk84ODdRWHU2S1E5S0kxNzdMVlhyK1RF?=
 =?utf-8?B?TVRUZG10N2FwTk9DbDcvNzZONEFKTmU1ZlovT0REenlBdFYvOWNtRFFadmxl?=
 =?utf-8?B?ZVN3NEdMd1Y3VzdNbVZLS3JUbnBjZUhOZ1RkY1o0ditBU0FlWGttaytkZi9u?=
 =?utf-8?B?MTE3d3Zad25XNTNzQ1FSYkI4a0tScHMxaVlHbVFGMlNCNVJNR2hIOFFPRHBn?=
 =?utf-8?B?ZHN3ZW9OMFBtdlJETzZobmhHYzVpSUdkVmtLcHc0dGdCRDlDZmd5TEZ4Z3dj?=
 =?utf-8?B?VWhGRXAvdXB3TnBkYmZucFlKS0JIcG5iYWltQUNhNUovejZiSHpiZy8xUmJo?=
 =?utf-8?B?V1RyUzhtb2dXWS9nZ3k4T1h1dWRoTlBscGFsQ3JCTVNVN1pYOXdqWUdKcXl1?=
 =?utf-8?B?czA5SGhsaDlkaHdDK1ZLTHVJWUY0cmlYRDZkQWdzZVVTV3BCVGRKQ01tak84?=
 =?utf-8?B?OEt4ZUFPZ2psZVd3NXI3andiaEhMenRjckRYYWl3dGZJMXU2S0RCdWkzdEFT?=
 =?utf-8?B?OHZoY0dNZDNuZVNqMkJCZnVXU2liay9xNEg5UWVhbGQrKzV1OTNRZGlkNU1B?=
 =?utf-8?B?dFI0Y2x6QkVhRWMxZ1d0VXpjSlg4OWxsYTN1bERkeU8yMWdBdDExRGNqcHlw?=
 =?utf-8?B?UjVWaU9GOFhVTVpqd21jMWxPUW9NSTdsTnFBZTV3Nzl2VXI0bTNXMWltckZN?=
 =?utf-8?B?RmxNU0hsQW5EZlVPY0NYZ0tpVmZPVWFkQnFJMVRiamtVbkFyVFR5ckNoS0tY?=
 =?utf-8?B?S3kyTHZMSGFoUUR6SXcrWk1pYTNLVEtxeGR3dTU0N29jeXpEVFV3SjdHM3pF?=
 =?utf-8?B?dmtDV0FtR0NyYkVkMGJBNzlYYVFTRGtQQ0RxbUl1VThQRlcvRDZHOTR4ZWpu?=
 =?utf-8?B?TGJXMU52M3pWRjVFNE5RdERjV1Fibk52UEhvS1JjYTRGa0FQWlhMSzAvdjh0?=
 =?utf-8?B?VW9hNlBPN0k3YTRtZGRsZlFZSDQxY1NKOWptcDEyYnZVZFQrU0xFWW41MDho?=
 =?utf-8?B?dGpSN1o2R2VqbW5YWkJ6bS9OZEZkOU13MXNpTkNsbTY0OHdzY1ZPdllDTFZl?=
 =?utf-8?B?eGVLbUtweE5TYzdCT0ZEejJKWWs1akYxVE5RL3EzZVV3L09jUXNNK3IraWoy?=
 =?utf-8?B?N3ppRFZ6SmFqNUM1WWwwTi9kTWI5UktVd1BtNUdaYUsxTFFmdzFHNFN3Mmox?=
 =?utf-8?B?RWJlZ2VaQUNwZGNESWg2WVZPbkJjeFNJaDlZYnRmV2tIWU9OQmMwRk1DVVlU?=
 =?utf-8?B?b3RBK3J0ZWxJbVRGb3hxQjlBYzlFRmNKaE5Lb3plc29kNkdUYnA1RTJGRkd1?=
 =?utf-8?B?UDUyUmYxbjBQT0M3U1NTOVFWTkFZZWZld3ZxakhFUzdCNnRrQ1BPWFFFSndy?=
 =?utf-8?B?NHpMeW0rSjZQSGdwaldnY0d0YmNwUFBlNmkzeUYxdmpodXhHZUh4WEVrci9w?=
 =?utf-8?B?SE04ZmNXaUU1OEI4WElRYlNHd1N0SVhkOUNsT2ttWWp0SGwxZzBtWUdMcUI5?=
 =?utf-8?B?cWFOc1RmQWJZNUZoUW40SGw0YW5UNEN5WnY2WjlJb0xteWdGdDdZam4wdU5p?=
 =?utf-8?B?VVBmUUV0WXNxWXpycHVUTDVic2RHNW5zajd3WHhXeGRaQ1Z4WTJBS2hGbUp2?=
 =?utf-8?B?R3pCcW9aeDE4UkRiZ2t3WVlHeWttTHZaTHFqc0l6WElBQXl5cFk0cVFGY3N3?=
 =?utf-8?B?T2Jiai9SZElyYjVibGdTcGNuUStwS0xiZFpiaUdhUktzMHRjTDY1ZzVVUGw3?=
 =?utf-8?Q?m8c9ll3G3jLzrzDUp5xklVs+H?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?YnBETG9YRjhHOFg5aUZwd01lMGlIK0ZtT1BFMG03QlV3MENBL3FnYlhrRFY1?=
 =?utf-8?B?WE9COE1IRnp4THRKT2xBYTlHR1h5R3BXS09zdlZpWnh6M1JnTS95TTJRckw2?=
 =?utf-8?B?eXlWS2hYNjAwdDJWYzVHL0xKN2tTN3owUVljQU9aYlRUS0ZhNzA0Sm1vWS9E?=
 =?utf-8?B?ckg4RFdENkdsekNHWG9SM2YrOEtYc3hjL3JNaXBZV2wydDlXVk1IV2lxUjZO?=
 =?utf-8?B?WGw5UWl1L3lvSjlxQ25uYnNnMzZKenA1K3Zhb0p1cndnRTVFdmpQaHJkcTNX?=
 =?utf-8?B?ME5zR1BhWXhjaXFJcmw1NmRYVGRXWStJV3ZuQm40K0x5NEhvdlBEaHRZWGJ3?=
 =?utf-8?B?Zm1TTlRjMFNDaWRmNHVPQmx5ak55bkwySlM3SDROOG52TkpWZEVwU1BZaE9p?=
 =?utf-8?B?bjNLSGxEQU9vSlN1cmc3NnFjNkFQaStHUDNyTGN1VGlINElZNzVTSEhqa0ky?=
 =?utf-8?B?M3E3RDE5a2x3QlJDcGNuTGNGdXk5Tmd2ZjhYREJESlRET3JFOU1OQmx2QVYx?=
 =?utf-8?B?RkE4c09pMys5T1ZRTE5VVWtzeUs5N1N2eXRDQXAvSjFJMldIakZnZE9xb3NE?=
 =?utf-8?B?NUp2UWR0OGFmZm93OTh2VkRhczhsZno1bWwyNmVualF4NEFDc1hTd3NYN3Fz?=
 =?utf-8?B?c1Bva1JqdERYTndEd0ZJWjhOSzNhOFA5TndwQXhINTlJWWcydUJ2cTRGSHBk?=
 =?utf-8?B?MWFBZ2tuSkRoSEVTdEI4dUFoaVhlSW53RlJZY3NEYmxpRmE2Ym1lcTN4Sm1G?=
 =?utf-8?B?U21VVlNyQ3o5SGJ3VFNERysrdFlzQUZMb3ZuUzAvUDBodVN3WFdoZS9oSjQw?=
 =?utf-8?B?VDk2K3JwVzcyNnlwVmlaTk1MMldJTG1NTEpBM21lYWhhSFpDTnk1b2ZpRklx?=
 =?utf-8?B?RCtCc2VZTWVJWEFLWXVjeENxMVcrZTBMdDdJN25MMGQ4akk5Tkx6dTJuVjEy?=
 =?utf-8?B?Q1hzVDJTbjh4QkM1cGdWNFQwMWJHdHZrWmZiWGVpd1QrK0pEM096d1VKMW9j?=
 =?utf-8?B?Z2laS1ByMVdqczlrd05qcHpjbCtkcHVuQnUxbVZ6aks4OXQxd1JTUmUxY2xr?=
 =?utf-8?B?ZGU3Zk8rRmN2U0VoQVdzWmVnUWxIdUwyQS8vTjBWTTJOcndtYlUzZkxFdEZo?=
 =?utf-8?B?bWNmRWFLdXQ3bUExWDJMK04vSUFhbFZuR1grVFc4WVdBYzJoWGkvalEyaFRq?=
 =?utf-8?B?MXpxUkFPK09VWmdTZ1NSSXIwTmVGcVowOHpVcU1vR2gra1hGMTJOOW9NNnpy?=
 =?utf-8?Q?WuB/nR0t6UritVe?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db9e86b8-f677-411e-20b0-08db502a68ca
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 01:12:08.2587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kv9oBkH7d5OiK70LhUZZ0SNwBq9RHv1F7WM2M3keqaZ6h17x9Y4h5Rb07injUoDKuKcehGo5H9Agcs5BLuUHNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5324
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-08_18,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305090008
X-Proofpoint-GUID: v0hwXmMQNV-Gx-qyeUlRC8gL1-yZpHPc
X-Proofpoint-ORIG-GUID: v0hwXmMQNV-Gx-qyeUlRC8gL1-yZpHPc
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/4/2023 7:32 PM, Dan Williams wrote:
> Jane Chu wrote:
>> When multiple processes mmap() a dax file, then at some point,
>> a process issues a 'load' and consumes a hwpoison, the process
>> receives a SIGBUS with si_code = BUS_MCEERR_AR and with si_lsb
>> set for the poison scope. Soon after, any other process issues
>> a 'load' to the poisoned page (that is unmapped from the kernel
>> side by memory_failure), it receives a SIGBUS with
>> si_code = BUS_ADRERR and without valid si_lsb.
>>
>> This is confusing to user, and is different from page fault due
>> to poison in RAM memory, also some helpful information is lost.
>>
>> Channel dax backend driver's poison detection to the filesystem
>> such that instead of reporting VM_FAULT_SIGBUS, it could report
>> VM_FAULT_HWPOISON.
> 
> I do think it is interesting that this will start returning SIGBUS with
> BUS_MCEERR_AR for stores whereas it is only signalled for loads in the
> direct consumption path, but I can't think of a scenario where that
> would confuse existing software.

Yes indeed, nice catch, thank you!

> 
>> Change from v2:
>>    Convert -EHWPOISON to -EIO to prevent EHWPOISON errno from leaking
>> out to block read(2) - suggested by Matthew.
> 
> For next time these kind of changelog notes belong...
> 
>> Signed-off-by: Jane Chu <jane.chu@oracle.com>
>> ---
> 
> ...here after the "---".

I'll move the change log to a cover letter.

> 
>>   drivers/nvdimm/pmem.c | 2 +-
>>   fs/dax.c              | 4 ++--
>>   include/linux/mm.h    | 2 ++
>>   3 files changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
>> index ceea55f621cc..46e094e56159 100644
>> --- a/drivers/nvdimm/pmem.c
>> +++ b/drivers/nvdimm/pmem.c
>> @@ -260,7 +260,7 @@ __weak long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
>>   		long actual_nr;
>>   
>>   		if (mode != DAX_RECOVERY_WRITE)
>> -			return -EIO;
>> +			return -EHWPOISON;
>>   
>>   		/*
>>   		 * Set the recovery stride is set to kernel page size because
>> diff --git a/fs/dax.c b/fs/dax.c
>> index 2ababb89918d..18f9598951f1 100644
>> --- a/fs/dax.c
>> +++ b/fs/dax.c
>> @@ -1498,7 +1498,7 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
>>   
>>   		map_len = dax_direct_access(dax_dev, pgoff, PHYS_PFN(size),
>>   				DAX_ACCESS, &kaddr, NULL);
>> -		if (map_len == -EIO && iov_iter_rw(iter) == WRITE) {
>> +		if (map_len == -EHWPOISON && iov_iter_rw(iter) == WRITE) {
>>   			map_len = dax_direct_access(dax_dev, pgoff,
>>   					PHYS_PFN(size), DAX_RECOVERY_WRITE,
>>   					&kaddr, NULL);
>> @@ -1506,7 +1506,7 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
>>   				recovery = true;
>>   		}
>>   		if (map_len < 0) {
>> -			ret = map_len;
>> +			ret = (map_len == -EHWPOISON) ? -EIO : map_len;
> 
> This fixup leaves out several other places where EHWPOISON could leak as
> the errno for read(2)/write(2). I think I want to see something like
> this:
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 2ababb89918d..ec17f9977bcb 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1077,14 +1077,13 @@ int dax_writeback_mapping_range(struct address_space *mapping,
>   }
>   EXPORT_SYMBOL_GPL(dax_writeback_mapping_range);
>   
> -static int dax_iomap_direct_access(const struct iomap *iomap, loff_t pos,
> -               size_t size, void **kaddr, pfn_t *pfnp)
> +static int __dax_iomap_direct_access(const struct iomap *iomap, loff_t pos,
> +                                    size_t size, void **kaddr, pfn_t *pfnp)
>   {
>          pgoff_t pgoff = dax_iomap_pgoff(iomap, pos);
> -       int id, rc = 0;
>          long length;
> +       int rc = 0;
>   
> -       id = dax_read_lock();
>          length = dax_direct_access(iomap->dax_dev, pgoff, PHYS_PFN(size),
>                                     DAX_ACCESS, kaddr, pfnp);
>          if (length < 0) {
> @@ -1113,6 +1112,36 @@ static int dax_iomap_direct_access(const struct iomap *iomap, loff_t pos,
>          return rc;
>   }
>   
> +static int dax_iomap_direct_access(const struct iomap *iomap, loff_t pos,
> +                                  size_t size, void **kaddr, pfn_t *pfnp)
> +{
> +
> +       int id;
> +
> +       id = dax_read_lock();
> +       rc = __dax_iomap_direct_access(iomap, pos, size, kaddr, pfnp);
> +       dax_read_unlock(id);
> +
> +       /* don't leak a memory access error code to I/O syscalls */
> +       if (rc == -EHWPOISON)
> +               return -EIO;
> +       return rc;
> +}
> +
> +static int dax_fault_direct_access(const struct iomap *iomap, loff_t pos,
> +                                  size_t size, void **kaddr, pfn_t *pfnp)
> +{
> +
> +       int id;
> +
> +       id = dax_read_lock();
> +       rc = __dax_iomap_direct_access(iomap, pos, size, kaddr, pfnp);
> +       dax_read_unlock(id);
> +
> +       /* -EHWPOISON return ok */
> +       return rc;
> +}
> +
>   /**
>    * dax_iomap_copy_around - Prepare for an unaligned write to a shared/cow page
>    * by copying the data before and after the range to be written.
> @@ -1682,7 +1711,7 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
>                  return pmd ? VM_FAULT_FALLBACK : VM_FAULT_SIGBUS;
>          }
>   
> -       err = dax_iomap_direct_access(iomap, pos, size, &kaddr, &pfn);
> +       err = dax_fault_direct_access(iomap, pos, size, &kaddr, &pfn);
>          if (err)
>                  return pmd ? VM_FAULT_FALLBACK : dax_fault_return(err);
>   
> 
> 
> ...and then convert all other callers of dax_direct_access() in that
> file such that they are either calling:
> 
> dax_iomap_direct_access(): if caller wants EHWPOISON translated to -EIO and is ok
> 			   with internal locking
> dax_fault_direct_access(): if caller wants EHWPOISON passed through and is
> 			   ok with internal locking
> __dax_iomap_direct_access(): if the caller wants to do its own EHWPOISON
> 			     translation and locking

Got it.  I examined all callers of dax_direct_access() and found a 
couple move places that need the errno conversion.
I'd like to introduce a helper mem2blk_err(err) for that. It could make
the code more self explanatory.

Thanks,
-jane

> 
>>   			break;
>>   		}
>>   
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 1f79667824eb..e4c974587659 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -3217,6 +3217,8 @@ static inline vm_fault_t vmf_error(int err)
>>   {
>>   	if (err == -ENOMEM)
>>   		return VM_FAULT_OOM;
>> +	else if (err == -EHWPOISON)
>> +		return VM_FAULT_HWPOISON;
>>   	return VM_FAULT_SIGBUS;
>>   }
>>   
>> -- 
>> 2.18.4
>>
> 
> 
