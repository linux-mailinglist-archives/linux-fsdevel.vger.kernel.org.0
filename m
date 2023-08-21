Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801A17825B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 10:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbjHUIlz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 04:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbjHUIly (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 04:41:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FE1B5;
        Mon, 21 Aug 2023 01:41:51 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37KMsqEr019545;
        Mon, 21 Aug 2023 08:41:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=5KnmCuHNG2Opbmael/nW6PQslwUCFw16WtcMHdJcPKg=;
 b=PKL2n3sruZ+d5aznBTBxzoNI2YQt7r8wwZIbpD2QMPi89kDSzogrjaTGXNgrT1oqM3dq
 B6+I/4V8wr7rxVOiWHEIzOo5KFNBWnyezYeDViNyYdjLeqXSuVuQtPAfrvn5Hr6r0+Hr
 06C6f/RTnqqGV7eCQhFFK/WezUfmcJUSsScOBoKsIxukBnnuwP+xBC+BUA2Rt+YY8nsN
 7yt6R13pOIEqFQ6jh6hbbgiQIoDoc6S2QJ1CAQ5lcvSoVdATT1xlhD1LTY2U4Hjc+HM6
 2Ta7raWQQHG7QF4Jc8vwG418lRQ8H0Ldts9wXRbpk8kcaoqLPUqX8QzgYBsFbPeJg3Um ig== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sjmb1te8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 08:41:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37L8JuLC017593;
        Mon, 21 Aug 2023 08:41:42 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sjm69nrkh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 08:41:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/nxTqfj9qZf4ZZUkH/RnRFHlwyP2h36YjdkuLXljhAtyhHPatlvzF3PdaaDiUSJ/rpMWqpJqphEVHuGLs3FyIRzMwhUbZ4HAZVFsJb2nShH7P3hdz4FjZf62qLETNmKPlNqBffYTUoUieCxNEWYRIcICYTS/RcJ2fsLwNXu5I1zu54VIhRs4B/3WybsedDJGex4cHrfqowv67rODJADmv30UHxKS2czrAozphZlK/xjxIJfaO89q8R6ANWEMe1pvKa6G7+Y17GTwwERHw71dhC+fFL0YpRTfor4VnQarojpS+UwsANTbHkCSaeu1hCbDPiHVFkP+RFKxJoW39N4YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5KnmCuHNG2Opbmael/nW6PQslwUCFw16WtcMHdJcPKg=;
 b=IzVWI8JckyBxLkJy/FbIw8Ztbq7yCFWUF+5LzFi4uMNdj+kQuyDFr/RxZvYmW5HJFj9iLHgnMf6nOs2Gfl4x99pis7mFy/gbueHF/GolTCdGoxSRkFYsOaxNgfS8vDtgnynobj3cFIWexwU4NjnHiEIp1CWJnhY30nPkc6+En3EV2qlEcfliTQA7Au5MB2/dL5Uk3OUITMC2XDmdbJbWb156WRUe6rHmAi57Isaayuv18cFbZQNr/b3w4K/JX0/gZxXh3/Sdb4ecaLiKTKE3GGDa1n2cKp2jlooAi8143KiTjZSZkWySylDXBxLpJJJTRdxgYn6qCfrJfufcEUhqjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KnmCuHNG2Opbmael/nW6PQslwUCFw16WtcMHdJcPKg=;
 b=qmgpSAvUejuO0+RMzlp6GwlJOhb0osLMyxigIEqm0EzdMcjkDJDNyRLz7liBEYIpK+BQh5kK/hVrQwKSy7e7EXPcWgujOmodW/mi032Y+UM+tMQfujAeaTmI6izW3CjIYMvZQzrB5p1XGXDsmDRdEblJInjgJ1+xKm2utDv3u/M=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by CH2PR10MB4182.namprd10.prod.outlook.com (2603:10b6:610:7a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Mon, 21 Aug
 2023 08:41:40 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::76c:cb31:2005:d10c]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::76c:cb31:2005:d10c%5]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 08:41:40 +0000
Message-ID: <1a738de4-fd87-f585-17ae-2d4b6c0e9715@oracle.com>
Date:   Mon, 21 Aug 2023 10:41:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] procfs: Fix /proc/self/maps output for 32-bit kernel and
 compat tasks
To:     Helge Deller <deller@gmx.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrei Vagin <avagin@openvz.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-parisc@vger.kernel.org
References: <ZOCJltW/eufPUc+T@p100>
Content-Language: en-US
From:   Vegard Nossum <vegard.nossum@oracle.com>
In-Reply-To: <ZOCJltW/eufPUc+T@p100>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0001.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19e::6) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|CH2PR10MB4182:EE_
X-MS-Office365-Filtering-Correlation-Id: 39a79d4f-4f3e-436d-3c44-08dba2226fee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5beWQKyiSUtsa1wd5EtnQGuzX1MItCiAjt5c4F3C+pU4e5F/FipqRE/Ftz4sEcLQq8Trwmug8DfvKuujZ4j6VQkdquCuxD7hvQ6Fdu85WkZgsL2Wwo1SArNgwfI3ekRkfyBYSg/Bk7fnf+S0h4Rb+NLeahdPoXnKiRxFZa/hfISkBeiy9TB39bs6mFK4vlr45/vD7gFT2fl7qpfwgTqBXxS5QlIulaBLz2MrUvShFH1Vvp8YytNbde0FZMAAC3TSKNbgUgZlqYvVcxzwO+86rgrugtECsrnywVsVl1wbjZHIsuRsGgonY/cPCUXLPd7nGCoGhk+Z8U/59ueZ5DnRhEyAumfAnqD6LH7J0NTE0eoylT85ovAkE8JmnmxGKx8Y1/4IpRIEBk7YPvnG9690dEKqZCBEc+uH1amYO4p56zSfHZSJfu0rqN8AYBIva8g6kO0saIfq/i052a8qGN+dFtZyFGndTA0mDYMrxfYMQSNEEP1A9Gd/4b3ws9RiM0xVgc0CyZ93tFaIicb3AybLrTokdiGuYhXCEqH2OMn7aNlQKzE+GYoIAtnSIgNJY+kWoFg2GsYxxr6vjBVSIKoQ6+e67hSGc6FuOlsSDQaOjlcamEA8I//QpoYx137UtllnObydKJQ3ZRCXCbR33MDwOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(376002)(39860400002)(186009)(451199024)(1800799009)(31696002)(2906002)(83380400001)(26005)(86362001)(478600001)(6486002)(6506007)(6666004)(36756003)(2616005)(6512007)(53546011)(44832011)(66556008)(5660300002)(41300700001)(66476007)(66946007)(316002)(110136005)(31686004)(4326008)(8936002)(8676002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjhHdkYxaERIYzhiUy9vWE4zc3NrNVlybEhCT2hta0psWEtBT3kwcExDUmVX?=
 =?utf-8?B?RXJGaXZYWXBKMUY2WmZSaFJid3BESE9QMXRYTkRwU1ZFcWQ4UjhXNEhzODhH?=
 =?utf-8?B?c1hST0RjdmlmRVdzRDRoY1N5aGhvb09qRGlWOFNnL2NFTEVzU05FQWltYlNW?=
 =?utf-8?B?NW8yTUtkZkN4bVJuK01Cb1hyK1FQdHlUWkFlUEMwd1c2TXRKcG1NdTk2NzBS?=
 =?utf-8?B?NG1PSHRXRmlyMHppSDVETTlYdXdFWVlFZ2pjTk1FakV0S0RZQzRCRzYrbGRG?=
 =?utf-8?B?UDNxcVQ0RkFmSFArNmNOaXlXcXplOGRJbXN4bXk0SExkRm1jR2EvdjZDZFVs?=
 =?utf-8?B?VlFja0E2Mk4yVm9QaXdlOEFkeFBMLzJtbVRyeGxpdWxXTzBYaHlGZVJTa3Bz?=
 =?utf-8?B?c0s5R1BIVG0vMzRReGc0NUwwdDRHSFQxRVZaeEJwRzV1WFZYSHZXdlNBYnJX?=
 =?utf-8?B?SjhhQXBZNGs5RkdOZkZNdEpIQkQ0WkpQZnk5empRQUxVOXI3QktVS1gxY1lj?=
 =?utf-8?B?bGVuQW8yanZxS1p4NUY3QUdQVjFTeGN0TEJxbERyNllKYkVzSEVSOGFNa1NU?=
 =?utf-8?B?L3lRc01sMVhNRTI2ajdSVjc1ajBMQjdVRzBjeTNMSk94akdKeTFxcGpIZ3Nj?=
 =?utf-8?B?V0tRc0xwTmhROUxxUTF4UjNZakViUjNhMUFzNHlKTnVyOThWcXdmL1dxZ3Q3?=
 =?utf-8?B?Q2ZXckUxeEFvMkdJdjlFamJsT0p5Q2YzYUhWaU11SVNiL1FXQlBqbmFDN21J?=
 =?utf-8?B?VzZQbXJsTlhhVFQ0UzV0Q1JWbGdTTmsrWkY2ME5URHRmV05oeit5eWNXTXA0?=
 =?utf-8?B?UC9raW5LeER1RVpGcFk1T1NDY0U1UUJZYTArMVR5akhTNGphWTNNN3EzeGdm?=
 =?utf-8?B?bW9zQWlhVi80OHFFZkZBZWIzcFFyQ1FyeWdHSHByZ2tuelhCdTQrSWlXa3dj?=
 =?utf-8?B?aDRaRUh2MHVWUm1zOHRNWndiaENBamw5L2c4U1puSVc3SnRqWU9VWW52ek8z?=
 =?utf-8?B?WVl3eFdkMjJ5NENPQXVySHo4dkQvNEp6ZXVDOVNmLzBjNXVVQjgveGg5N2Z0?=
 =?utf-8?B?ckF4aE9HZHVUU3ZyOXpxcmdMZ1pHSTdCRC9ZNDlQbzJwUzFqdDA1RGdsTlkr?=
 =?utf-8?B?U09QMTgvNHprQTc2UEVETWU0NG5mNkVrdWZoaGN6cERTZXQwM3RhbmtSYjht?=
 =?utf-8?B?bTN5aVNYbjhxVC9IbjZDT2E2b2hIK0dENTlhYkRsNTZIbTh0NlRnYTBnY2hM?=
 =?utf-8?B?SEI5STZLTjB1Um5rZjRVeWlUMThHem1lRUJZNmNIMFB5QVBuNnVwbVZwWFhq?=
 =?utf-8?B?UGlOK0pZSWExOG5oazB5UE9ZYUQxcklBQysvbThpUUIyVkZXNzFSWUxSWDBT?=
 =?utf-8?B?WDR2a2JZK2ZCdGNkbTRDZ1ZDeHY4SnhnMnA1Y3NScldpZzdLTjVEWmh2L1pQ?=
 =?utf-8?B?R3dkL0NSK1ZiNkQvM0RybU5BSnRwWlAyQldMT0VseGlnUkNCa2JNNDdQUEdj?=
 =?utf-8?B?Z3ZTenZWTjMxT0lJWXpRdXBWazBpTERKN05CZHBQOXBUczNSVkl0UTVQWnZO?=
 =?utf-8?B?M3ZSTkE5M2tUbk10V1dnUGRFREYweTdJTWFPZmw1bURUdUdwbXBSbEVIa1FJ?=
 =?utf-8?B?MUVoZGV1VmtJU3IzMWVxZVphVU1kRWZvUFliUHBuMnVtaWpXMkdDNWVjRGRx?=
 =?utf-8?B?ang0K3JXVDFUMTdMekpnVFhSdERCOFE3Risxd0pTZUdaRmMwYUovRkVRbm1o?=
 =?utf-8?B?VG10eHpvTnlsbVNqRy9vR1BWcUlZTTEzU1pVcThQd21Ed01pVHlqNVFVVE9k?=
 =?utf-8?B?aHp3aGJQbEV4ejhSZnc4aXdLdXFQMkxwMEl5eC9kM0NWb3IwNVd0Vjl3Ukcy?=
 =?utf-8?B?Nk5CTGFYYXJuMGg5aFdOR1BCdndJSVJpNlB0cWVDQjMzby9oL3ZmaWtDTTJF?=
 =?utf-8?B?REtoZzk3bTQzcEZJL1NxbXozb3BsQXg4bE9qc3BxZ25VbEVKYnA1bHVyVW82?=
 =?utf-8?B?cjd3Sy8wbDhOblZDZEhqT3RHS2JVMWxvT1BOekpSZ0Y5VXdHUCtlSmxXMzY5?=
 =?utf-8?B?UjVaaEZvR1JackM4czZrN2xlYjY4Tm5rMnVocEZzR0M2V3NlVm5yR1Ftbm9V?=
 =?utf-8?Q?SpsU6CL8uKqnIu4Kcybnafgmc?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: s4PFx/D0uRrwrV7q1AbV+gPb7Q63darF/u8COE92YRmFrq6pR04v0IBde35Gvj0Aep4AWp74PFOnyOOjck/0knBx9F8mFtgPDa938jcdXaCxV3czTdJNcRK4u+h4JMF5NH9eelkLGIuWBIfioECPDWRGsAz/axKxJPk5AY46f8Ur/e7cpM+081TXEPXu+uD9YPEyYvU2RFP1ED3QizIo8/NhY9gfNnlUFrpgYMkHhBlecD8R81D9AmlPzXFBGzFLUztc3YfpDQ4AGoVrtRoD3gmZR7dcNoNQZEShZFvlz1k0XrQ8KdjHQBoryavHrn//uOnsvCf7BRhlIgl3LqRUJw8C7B300E0fW+dQm+ncuWg+w3BynnIjr85OAfOKoKyuwT2CzW8kifuPnjioAECZtbtSzNMVsrQIMgw/dOZdjFOZg8m0nF9huCTJBY+0nF4J3ein7k0FBsk+8jF/H5tt/uXV7h3W09lq3wspJzQslXKOiBXb08a2TDpn1YlPtRyahVTkVMetjRE2KxcLRnTk0VkbLPwN1Yqhy5TMPVr6zeoWMswoeEHwkY9JPu1A7NnYvWOAF/zDy++08Ok8YWu5o7ACN8QyfMhOKZw1zqVtHhHtFVP93RAzzKMcsj4+9p2u1UpHNqNSVTmnL2svR+zyDDOLyDNRzKzIXAVp7uGxjGAlwq+sV21GujTvYHuJ6rU84lxRBxUP6ulseKbSWYf++hia6tOImfmyEx5F4XXLt3DDrKMVd3RzFTzcOco1RcTJ3/R7Vy84woYYnJNRbi1MiUGyR4kQ/LQOHVfitmK5qn8pw+vk4NrYcjhZHpNSaBi+JkHqWC2hVfAkaTj4hVG/zJMU+ACxjs7ePjEA8oWt+H0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a79d4f-4f3e-436d-3c44-08dba2226fee
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 08:41:40.1388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YvTa4BAjoYi/7Bv0ntVuQo9d6To2PLRb2c2Ph3Cbx8VnwXAdRaXh6yn1CNbY7XEg7DkNQ9bgYmXc+/elc3JOUCuQIvFKAWjM2UdVeSX61E8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4182
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-20_15,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308210079
X-Proofpoint-ORIG-GUID: UQhi-ez4Nd0IlNVuspdM6Mk8faoJ_GKP
X-Proofpoint-GUID: UQhi-ez4Nd0IlNVuspdM6Mk8faoJ_GKP
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 8/19/23 11:21, Helge Deller wrote:
> On a 32-bit kernel addresses should be shown with 8 hex digits, e.g.:
> 
> root@debian:~# cat /proc/self/maps
> 00010000-00019000 r-xp 00000000 08:05 787324     /usr/bin/cat
> 00019000-0001a000 rwxp 00009000 08:05 787324     /usr/bin/cat
> 0001a000-0003b000 rwxp 00000000 00:00 0          [heap]
> f7551000-f770d000 r-xp 00000000 08:05 794765     /usr/lib/hppa-linux-gnu/libc.so.6
> f770d000-f770f000 r--p 001bc000 08:05 794765     /usr/lib/hppa-linux-gnu/libc.so.6
> f770f000-f7714000 rwxp 001be000 08:05 794765     /usr/lib/hppa-linux-gnu/libc.so.6
> f7d39000-f7d68000 r-xp 00000000 08:05 794759     /usr/lib/hppa-linux-gnu/ld.so.1
> f7d68000-f7d69000 r--p 0002f000 08:05 794759     /usr/lib/hppa-linux-gnu/ld.so.1
> f7d69000-f7d6d000 rwxp 00030000 08:05 794759     /usr/lib/hppa-linux-gnu/ld.so.1
> f7ea9000-f7eaa000 r-xp 00000000 00:00 0          [vdso]
> f8565000-f8587000 rwxp 00000000 00:00 0          [stack]
> 
> But since commmit 0e3dc0191431 ("procfs: add seq_put_hex_ll to speed up
> /proc/pid/maps") even on native 32-bit kernels the output looks like this:
> 
> root@debian:~# cat /proc/self/maps
> 0000000010000-0000000019000 r-xp 00000000 000000008:000000005 787324  /usr/bin/cat
> 0000000019000-000000001a000 rwxp 000000009000 000000008:000000005 787324  /usr/bin/cat
> 000000001a000-000000003b000 rwxp 00000000 00:00 0  [heap]
> 00000000f73d1000-00000000f758d000 r-xp 00000000 000000008:000000005 794765  /usr/lib/hppa-linux-gnu/libc.so.6
> 00000000f758d000-00000000f758f000 r--p 000000001bc000 000000008:000000005 794765  /usr/lib/hppa-linux-gnu/libc.so.6
> 00000000f758f000-00000000f7594000 rwxp 000000001be000 000000008:000000005 794765  /usr/lib/hppa-linux-gnu/libc.so.6
> 00000000f7af9000-00000000f7b28000 r-xp 00000000 000000008:000000005 794759  /usr/lib/hppa-linux-gnu/ld.so.1
> 00000000f7b28000-00000000f7b29000 r--p 000000002f000 000000008:000000005 794759  /usr/lib/hppa-linux-gnu/ld.so.1
> 00000000f7b29000-00000000f7b2d000 rwxp 0000000030000 000000008:000000005 794759  /usr/lib/hppa-linux-gnu/ld.so.1
> 00000000f7e0c000-00000000f7e0d000 r-xp 00000000 00:00 0  [vdso]
> 00000000f9061000-00000000f9083000 rwxp 00000000 00:00 0  [stack]
> 
> This patch brings back the old default 8-hex digit output for
> 32-bit kernels and compat tasks.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Fixes: 0e3dc0191431 ("procfs: add seq_put_hex_ll to speed up /proc/pid/maps")
> Cc: Andrei Vagin <avagin@openvz.org>
> 
> diff --git a/fs/seq_file.c b/fs/seq_file.c
> index f5fdaf3b1572..1a15b531aede 100644
> --- a/fs/seq_file.c
> +++ b/fs/seq_file.c
> @@ -19,6 +19,7 @@
>   #include <linux/printk.h>
>   #include <linux/string_helpers.h>
>   #include <linux/uio.h>
> +#include <linux/compat.h>
>   
>   #include <linux/uaccess.h>
>   #include <asm/page.h>
> @@ -759,11 +760,16 @@ void seq_put_hex_ll(struct seq_file *m, const char *delimiter,
>   			seq_puts(m, delimiter);
>   	}
>   
> +#ifdef CONFIG_64BIT
>   	/* If x is 0, the result of __builtin_clzll is undefined */
> -	if (v == 0)
> +	if (v == 0 || is_compat_task())
>   		len = 1;
>   	else
>   		len = (sizeof(v) * 8 - __builtin_clzll(v) + 3) / 4;
> +#else
> +	/* On 32-bit kernel always use provided width */
> +	len = 1;
> +#endif
>   
>   	if (len < width)
>   		len = width;

Hi,

I think this is fixing the wrong thing.

seq_put_hex_ll() is a generic routine so the #ifdef/is_compat_task()
doesn't seem to belong there.

Moreover, the kerneldoc comment on this function states:

  * seq_put_hex_ll(m, "", v, 8) is equal to seq_printf(m, "%08llx", v)

The seq_put_hex_ll() call from show_vma_header_prefix() is calling this
with the last argument (minimum padding length) being 8, so why is it
padding to more than that in the first place?

Look at your example:

 > root@debian:~# cat /proc/self/maps
 > 0000000010000-0000000019000 r-xp 00000000 000000008:000000005 787324 
/usr/bin/cat

that's padded to... 13 hex characters? Huh?

Even on my x86_64, short addresses are only padded to 8 bytes, as they
should be in all cases. Could there possibly be a bug in parisc
__builtin_clzll()...?


Vegard
