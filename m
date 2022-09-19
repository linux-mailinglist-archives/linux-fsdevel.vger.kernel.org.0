Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86DE5BD26D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 18:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiISQtB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 12:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiISQs6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 12:48:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D052E25E84;
        Mon, 19 Sep 2022 09:48:57 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JGO4gS002811;
        Mon, 19 Sep 2022 16:48:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=q7nsF7Y6j8Adg3zUlyVE7tP8c6rDlijvNUspRrEjF30=;
 b=0vmdIaIg1j3viVxyX1jmE9Cpjso5i6kClwSjDsL6hxiENLpMYv4VyeCTO+SvpnPV9x3G
 /MmEa1b5mzDFj6Bg3kbHF3WKtf/o8HlYL7g1bnPZNfpBZUx7wGB3FE2lyaWKLEJ4xU6O
 QweJM0CVyRg9rkLC6BF8lJyVWo7w9DclsxzYOVcgD3SO7u+7Xzfd0Kz8q/xCM2+okvI4
 zIRnL8p4hlUrFQL+r4ONBXUZ6Lgs+bbne8YMJtd0PccR8N3N1jsxnraYXFcRHCnvvaRX
 c3d1KzB6+BON/Cr5zGaeg7KuhLOKNsTJUb5nTdlgVEEvRvCaqTTWB1YYqbinMzfmLeIM +w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn688c9w2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 16:48:56 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28JEdA6A009197;
        Mon, 19 Sep 2022 16:48:55 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jp3c7yea1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 16:48:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L83Dg80SCGoAcijkLYJ82EMi1p8I7Auoyw/7q9+jclNqMfT6Dgm4FGMxo9u2BRz4P2PjSdodlG6TtLXEY/4NDBBDxLo/QUy1Aq5qcCbX++MZcstiLWZ9uYYh1Ao+D3YBGKwEA755wp3GgPNTC8indvzyN8+oVqQH6uyrDmlD5/JsqK6FKJb4hTT6nAyFGKcBhWThXOve+VWJ8iQJ8HSjscXfxxLCMO2L5wA+p+8zn+TJMvsq5s11n6eqDQgrOB2sFH+8vWE2Rr/h98Qxc4KEsto766Qkuwq1t0a1p0tbic7z3ujt3haKug8FHdeCx/cMqd+DyC0rYBCqd/hiOhKjiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7nsF7Y6j8Adg3zUlyVE7tP8c6rDlijvNUspRrEjF30=;
 b=jvYivlRpTLV1shpQY+KBpxe0xr2lrUB7eDjwNkun7iau3rcCtpgfVZ0FxF0dwTDViOLFtIHVeq27BsY0lyy5CcgJaBFpIH6oMglhHKY16FmcJpvVqITt2r9MbzyqWX3Oofu80NBT1XkUJTR+Lru9RTJqEDDUJ/3G+a7cXLqHLXYYu+vNOcXfT6PJ74/DTVwTFrWXeGSZsxCL2zg//byrXKFjkxawrqABW9gjheWgvYlJUGLOsHleylonZB6y/pPUlQAWFKCua4Ar2prUoWwzKwTQS2Th0mwadjxyzTEUe7cod0kif2HWTF6/CdCh4y6Heq74LPQnkNVfejBNNRA3jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7nsF7Y6j8Adg3zUlyVE7tP8c6rDlijvNUspRrEjF30=;
 b=OltWXIQr2/CU2czA9e4mK8J3qErXWwq4G16VFzdcTLWEgqh0NLT/J77e3ndIG+rlkUOq9qUNTCZGJrdjALN2UlNWtNdeSaCW/rhFw8XMMiOooJAgicVPzBZqQQLzZ2iB7Fcd7isbPwtdiew+kPgdFGd6JxNpEBigqOnAfOYftg4=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by DS0PR10MB6845.namprd10.prod.outlook.com (2603:10b6:8:13e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Mon, 19 Sep
 2022 16:48:52 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::90bb:12d:954a:c129]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::90bb:12d:954a:c129%7]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 16:48:50 +0000
Message-ID: <c2f59560-f925-8f43-f967-a8b33c9abd36@oracle.com>
Date:   Mon, 19 Sep 2022 09:48:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: Re: debugging rmmod failures
To:     Steve French <smfrench@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <CAH2r5mve4HKpPOwFuE5+r26xJ7f--M5+wC=kY0km9-T2WGak2A@mail.gmail.com>
X-Mozilla-News-Host: news://nntp.lore.kernel.org
Content-Language: en-US
In-Reply-To: <CAH2r5mve4HKpPOwFuE5+r26xJ7f--M5+wC=kY0km9-T2WGak2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0101.namprd13.prod.outlook.com
 (2603:10b6:806:24::16) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:EE_|DS0PR10MB6845:EE_
X-MS-Office365-Filtering-Correlation-Id: b0e52222-bd29-43f0-94f0-08da9a5ed44f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q4UuTk1ve1cR2/+5BptjFMNSnqr/X+BI43LZiv0yqAMbJ0MV59wLZ7ZBrCBrNW4xxhYhhdFH07aDQWx02O+WXdEtxo6/zwObFd9mf1pxDZxHqREIwviPdaLzSs0fSvKuqDa115/Mq+cIQ5Iz0zLuAIJDLyXl3cDI2QGnJFuNTqMyC6T02s+OLNrBta9wU3xjR2y7dCAzIb8q05iGD6vLV5LaL5JzLzu+k6Hvd+Fv8Gm64vIY6/gYJgGBiIqGDgalmn+rpCKf0ZJfDTFQq2dMXoCs/+R2zSbgu/52VpGH4uxUOjBBNs6pIA7mrfIHx9iWG2zj/zkyGVKLYQbGykViTQzY3+1COLRwkZf9THMncbPvNsxlJX5LRl+GxySdHnLMFxiLWW9G7Qv+qWO/1pO5pSaa64IhGPFX8qhaVaap+hF3ruRCEr+rQgVd/866PRGn8p7gJW2KNpFWWIQkil7httvWHaHtUJHM/8iUf6IhsW8KsBQYaPbUKWCJoUHqqlM3+d6VjgtbSfr1spNgYfKy+G+Hmenif+YRbGQvYenUXriJFbIBR6RgPd5q/m9QnIqnu+nxzXlGOAcIekePJ1cgXbDFl7ImZHeFK/a15ZvPUXjps2SBTL4DTVsfPO06ozBRM+ImmDi4k7cypSNIzM4lAEUZENiDofyY8vr+Mj5CVujMh1G2YWtrwvz2lKUmSVO6xXyU44anSIX+NxPBBykBiYc1szod9VItXxm2/+ZsTtxz5VNECkvRK+HJapjm8cajqpTQY00F/dr5HaHWzD8DK6LUe2C8lyxPIjq9gj3NbNA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(366004)(136003)(39860400002)(346002)(451199015)(2906002)(8676002)(38100700002)(6506007)(6512007)(26005)(478600001)(110136005)(6486002)(316002)(5660300002)(186003)(83380400001)(53546011)(3480700007)(7116003)(66946007)(41300700001)(4326008)(66476007)(66556008)(2616005)(8936002)(31696002)(36756003)(31686004)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ck5oZWNkOGpneWN0NjBVTWk2ck8yejJiR0g5SnFBUGhxaXk4UVRvaEJzdHFS?=
 =?utf-8?B?NWtGOWIwbnRMaCtDRGFsN3BrTCtRUlB4NzBlaExVbnlCZDFraFQ1V1htdlJn?=
 =?utf-8?B?bTNadFpXaHlqTGVxNFRUTmZXeDFFeHplN2wrMTF0K0tkQXlWVDJTZjNWNG5Y?=
 =?utf-8?B?d3lTQlhWUUY1bi9DZThTa0dnR3IxREg1dnBSY2N6VUVmODNFL2ppb21EZnJL?=
 =?utf-8?B?Unh6eTFLQ2NMZERybWxSVHQ1b2FwQSs4bGRGRDMxK2E4ZTVlQ2xOSWcrVjdH?=
 =?utf-8?B?djR0K1Iwa2lJaFg4NlRzeTZoL0NvTy9ZK1FQOS9ZWVE4QzVvSEp0Y0h0SStB?=
 =?utf-8?B?RXArcGIyUk1TaVQwdUdLTzFVOXFYMDRnV2ttbVM1Y2FWdGltSHdiNkp3Y2pj?=
 =?utf-8?B?YUQ5U0hnZ0c0MkZCSnNoOEdQcXg3R1dCaUc5T3Q4ek1YM091ZjhNcFNyNTBq?=
 =?utf-8?B?eDVUYkJmc0ZVQ3VXSVdZR0pPVFgzWWdJemQ4TmtGSjBMZ0s3RnlObng4bTV4?=
 =?utf-8?B?MW5weUFRa0lFbkpLcm9icUtDSGtvTGR2cjhIZ1UyTmhLME01T1ZudDJ3eXdh?=
 =?utf-8?B?YXNLejhCOUFhOCtwbS9GME9YM3lZM3RhTmpWVWI5U21ETkVrUnZSZlZjMStz?=
 =?utf-8?B?RTRqbTNWU0tNUTgrcTNoeUhOR2ZxTUwwNEFrWVBoRFhLRm1uRlNSRk9qVkta?=
 =?utf-8?B?aERZSy9vaUZQbjA0Z3MvNHVzODIwNkpiZVpYUFpsWjdrMXVOd3FmVW5KSkVS?=
 =?utf-8?B?M3N2eFlUVE4vMzRYUjNuV3JUQ3lZQjhKdEN4bHptV0NXSHN3cGRBOU9EakRD?=
 =?utf-8?B?dzFOaDQ3REVaNUdNQ0dmLzFrdWx2N1ZXWGxQSThVTmFQLzlXM0hMeGdWWWNH?=
 =?utf-8?B?L0VuRlBOUk1wd1kvbHRTT0l1VGFOVEZPUFVWSGFjZWJad1JseTN6MzJXZE5P?=
 =?utf-8?B?OGlKN2lpdE5obCtmcTNybkNqb0dVYUdJTlNBTndNMDZaNHBwWHovZUg4YWUv?=
 =?utf-8?B?MGQ5QTBhOGErVFkxWHhkTVZCNEFieEJBMHZTcW5ycEwvc0ZjaEs0Z3R4akZS?=
 =?utf-8?B?UlA5L2YvL3AzSzYzTXRLc3ZxOTlEL2lwUGhxYjE1RUF2Z0pmV1QyRFRrOVll?=
 =?utf-8?B?TGwxNzhNMVJvdXNVbS9QV3pZL09UVEU0REhsdVFINi9MZWo2TzVYTFN2cERD?=
 =?utf-8?B?bWhMV3NRdjNxdnRHcXNCcXBuVDd4RDZEY0xySG0wRDJUNG1jQi83L2lkbDNX?=
 =?utf-8?B?cTd1MmVyUUgrR2Fjcll2clUzTjhlQ0lhSUxRWGNHTUZ1WWNWWkhrSGV6Vzh3?=
 =?utf-8?B?Y20wSEc4eW54MU5kaFdlanh6NGdBZklQdkxZMFY4cE5FVmVpMkE5TmhUM2R6?=
 =?utf-8?B?K1prWCtPclQ3MTcrTnlOcXB6WGdSeDh5bW9DeFRqRnFqUnlkRWVYM1pLd2dJ?=
 =?utf-8?B?ZWhMaHV6TWFNbWRBVVNRVThoc3RxQzBJRE5vUEhQZitNVUphMC9sOXhLdmJt?=
 =?utf-8?B?NVVxaC9VZGc3THVjSGdXTVZidXRvWDlUNk1teTlSU1dGZXMwMWYvaXVGTlpq?=
 =?utf-8?B?emMwa290QWdENDhNL2JYN3B3VEs4d1hVMHM2Q0hIcFo4UnAySVhJQ1Y3RFIw?=
 =?utf-8?B?ODR4ZGE1eWxtSU1XQ3ZaK3ZOVVZoWXpBRit2M2psRW92QThUQ1VJaVpSaThX?=
 =?utf-8?B?T2Y1eitBSm9SSDh3ckxPN20xcHkzL00rLzJJakt2M0NST3lRMUdmWUlLTWw4?=
 =?utf-8?B?cVlON1REVHhUYWt3eG5qTUErMWUzbmM1ZmRRSEJudWI0NWFaVDhHdlBpQjBp?=
 =?utf-8?B?cXRqVENmajA0a1oxWWNIMFZDTVhodEFUS1lLTGJ4bmRlMzFONGp1MG5ncDkz?=
 =?utf-8?B?ckJuMHFucWcrSkkrRW1BbFZtYkE1TE1BS0VqeWErcTQ4aWhvRWxYY0Zwa0t6?=
 =?utf-8?B?YlJBcitiMTBIUzF2eWxlcE1HNGFXTzBCMlROWG5GUDdQSDdmZXZ6U2Z6SWMr?=
 =?utf-8?B?cmo4TEQ0dWVlbFdvMkkyNFFJSWsvM0VUODRXNk04YlVEVlBWU2k5TkJlSkVF?=
 =?utf-8?B?UStvMmFmcUNXV1BBdFk2WXNCTlI1MkEwL21DM0p3VDJleXpOMGRpNHFOMDla?=
 =?utf-8?B?L0tiSG9mVjlLZ0EwZmY5cHhFanJrM25mNmZpdXNLLzEyOVlwaEtid010Z0hX?=
 =?utf-8?B?VFE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e52222-bd29-43f0-94f0-08da9a5ed44f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 16:48:50.7653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LeNQHwW8HnfUBWyqoUVUU1ebuItEel8di6mCXWPIs7e2ca6C9qCXkzBibSPJVRoekowGeCXMtMWdjl4jdyORjoHRC5qimOZ1wfooBbWQ+MQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6845
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209190113
X-Proofpoint-GUID: vqnPhXBV4z2V1W6lQ60Qfp5db4B4DBR2
X-Proofpoint-ORIG-GUID: vqnPhXBV4z2V1W6lQ60Qfp5db4B4DBR2
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/16/22 13:13, Steve French wrote:
> Any suggestions on how to debug why rmmod fails with EBUSY?
> 
> I was trying to debug a problem where rmmod fails during an xfstest
> run but couldn't find useful information on how to get ideas 'why'
> rmmod is failing (in this case with EBUSY) and I could only find two
> places where EBUSY would plausibly be returned but don't see the
> pr_debug message in the log (e.g. "already dying") that I would expect
> to get in those cases.
> 
> It also fails in this test scenario (which takes a while to reproduce
> so isn't trivial to repro) with EBUSY when doing "rmmod --verbose
> --force"  and the --verbose didn't display any additional info.
> 
> I also tried "trace-cmd record -e *module*" which showed it (one call)
> returning 0xFFFFFFF0 but nothing useful that I could see.

In situations like this I sometimes find it useful to use the ftrace
function_graph tracer. It can show you every single function call,
starting from some root function. Of course it's a bit of a footgun, so
be careful with it :)

I used it to trace the delete_module system call like so:

# trace-cmd record -p function_graph -g __x64_sys_delete_module \
                    -F rmmod $MODULE_TO_REMOVE
...
# trace-cmd report
            rmmod-41656 [007]  5506.963846: funcgraph_entry:                   |  __x64_sys_delete_module() {
            rmmod-41656 [007]  5506.963846: funcgraph_entry:                   |    capable() {
            rmmod-41656 [007]  5506.963846: funcgraph_entry:                   |      security_capable() {
...                                                                                ...
            rmmod-41656 [007]  5506.965521: funcgraph_entry:                   |    free_module() {
            rmmod-41656 [007]  5506.965521: funcgraph_entry:                   |      mod_sysfs_teardown() {
            rmmod-41656 [007]  5506.965522: funcgraph_entry:                   |        mutex_lock() {


Of course, my module teardown succeeded, but you should be able to
cross reference your function calls with the source code to see where
an error may have occurred.

Regards,
Stephen

> 
> Any ideas on how to debug *why* an rmmod fails?

