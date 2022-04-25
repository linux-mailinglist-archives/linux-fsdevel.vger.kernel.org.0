Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFAA50E413
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 17:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242632AbiDYPMK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 11:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242753AbiDYPMJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:12:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F31C6E4F8;
        Mon, 25 Apr 2022 08:09:03 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PCxOx6022277;
        Mon, 25 Apr 2022 15:09:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=YLcj3uhNe8ah4UDlazEAg/UPw5KwBuF8sBs4QdC8c2Q=;
 b=lke8TfyFPeJL6J0v1p8qXgzWCSKDVfCrL5YV+r0Eom+dKoLFG1dpnQeARqyvQGa29DUG
 NPyj6lzSuzY+jtVCahK6/f3DSyYmrDogEcRK7/R6yWkweYW1B44wc10GYE7Ba22ycduI
 16cB3puuCh/IDRd/ABoW3/vWy+u2oTX7Vsyy6o+wmqnoSNNvWkKELP0R6tGQTYgpFH1y
 gtREfuEOIs7sPcFhZAq/H2WPtfw86Dij85ldyYI61xQGj0psudtduNxRZ3YKtFvj8+a9
 AniPevKzDRZT9twJWhrH3vbHrQzS4AmU75WksD+TNXvKGiLX3nzMiqJJzAJwHswhk9Qf IA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmaw4bjm5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 15:09:00 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23PF172m007058;
        Mon, 25 Apr 2022 15:08:59 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w2ewq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 15:08:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CCgmRY8hraKcneOtr/81vsA/N9mt5KoUTxcerHQXzVikGW0BHMgj4bGP5cxiaWJ2y0deI7myzEDKyuGEthRk82hM5p5quMhInc1zX3SCoEcNbguT8MufOwVfiSTGpCQTwqgw+jSezflMKYSqyoE7XudF+MRMFNcK2ORXCslH+9ir/qUpuGVu85P5EeVyh6TQUVvZ4xBobtS7olZf2aZYtQ6sxOL1Rg3kKxVuC8R61tp5ZWdRoJ0leQj2UgSlqj+k9bns9Z+9MRycqKfjQCVnubeIK4lO0Yinrdp7JSt0pPpo6xmFfilcD03MIUxz1v9e4ZUEAt7szrImda7IbloK0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLcj3uhNe8ah4UDlazEAg/UPw5KwBuF8sBs4QdC8c2Q=;
 b=aaoAsz9H5cbBl5nj2lWEhLO8qQq3dtaTS3MA+8A4Xxb04hx8Kw+ryWjbQ/Z/ghzCf+XlXDUcfs+na3MrXRHVDNUZXQrjAj8D+WVtCJHi1Re8oAxD9q1U+mP6dJFk84cBINuw3G7aQllTstXNLumMxnfz63UYm6jMGlh+/AS0xRgaHoyscWXJTs5XvQVz174s/a6aivPlHkw/c4+Fmw6fDtLZ+YRmQavhcrA4+bJii+vifDH4O3+aNAjil30/qOfkDk+a3XrjtG7lkPMJPkbXGV9Q223AGyfa5JWaaDQhwDh5YKIT+7wKhFSTRa6jILIHwyIEJKaTZYFkRDb2yTQFFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLcj3uhNe8ah4UDlazEAg/UPw5KwBuF8sBs4QdC8c2Q=;
 b=VsEOP/Y8PHO/3/rMPZMFEVVakgitVWyttI4aINIedp2hX7AwZFBtlvUmUjisLvprkzpcVriPSxdjcAyOvtrFqpNyQ/JfAHLzq6MVIoFBzo89cst3xtxdnd7EbKujcMBHCCFSeufHQ0puFQSPaXsdD/IhWD/KJFoEk+P9UVZnSGc=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BN8PR10MB3394.namprd10.prod.outlook.com (2603:10b6:408:d1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Mon, 25 Apr
 2022 15:08:56 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::29d0:ca61:92c9:32c2]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::29d0:ca61:92c9:32c2%6]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 15:08:56 +0000
Message-ID: <2cb6bc13-8adc-42fa-29d6-a18b7b20c9ca@oracle.com>
Date:   Mon, 25 Apr 2022 08:08:53 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH RFC v21 2/7] NFSD: add support for share reservation
 conflict to courteous server
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <1650739455-26096-1-git-send-email-dai.ngo@oracle.com>
 <1650739455-26096-3-git-send-email-dai.ngo@oracle.com>
 <C0354D9B-B980-405E-B70A-16A8D9761D7F@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <C0354D9B-B980-405E-B70A-16A8D9761D7F@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0068.namprd12.prod.outlook.com
 (2603:10b6:802:20::39) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e6b17a4-1d03-45bd-3872-08da26cd84ac
X-MS-TrafficTypeDiagnostic: BN8PR10MB3394:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB3394CBA99305C64ACA76C74287F89@BN8PR10MB3394.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1YXjhptSMwkI1DhAHgB03YTYFAnY1Ma4Fs6DAkzkYPBU9grSJT5/1WnF5vgyQgeREJuUrQO5xcqTPpxe3awAQaxzZGfqwXzOWx8ha4XtsglX4Q6oxwEi0TjRqWUXWiN4Lme6ECIYOHBbT/wLU136qmFAk8+4uXweDxvsSJ8I37jN7JQMgAXaCSnnxglUxUNVIi7fAImT8OenQc0mBM/iVQj4C3UlCIhkJNpeQ6LWwobq1nsrKUK8oioLC7vlvidZQtxhaCcygIHJ2W4hPziODKfKWFPmlgnJBAvKE1LIbRIA/koppa48ABaqtaiKd5s22Uywqb+DylchC+Dc4lzgfADLX/BXjyd6ARCN5IJXA+fTIG+yX0EOkQOpZO7OkQbxBHAcSBf52V800+X+gzt3fKN34w7kYx7fS+4TMsBBnS6ZiV9jv4mUtP5DNJJ0KmnZu336X32QI3DeX4tjkkwY97LWKw9xFctNZ5tcklrUii5Vu0xTg1WiuzGDIlcTHEHxvuNIOpKGLdNF4z0FFPza6rcBJJX2GRmfwDgl8vH8VCS0CwqRKtNdu9j7Gc6ZabfaL+6avVBwhXwIy4MNd2PH5Rbmuc8BiMjSpMXVXU6tY+HLpcJD5dfCplnmZS663T1cRfCqZF+JzoI1v7hUMki6HcKBGw8Nl551pfKvMa0CuwQf+bWpcJQCYLcjMd6/ccDZbKu3DVaJQp2Va0+Mx3De1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(9686003)(6512007)(83380400001)(6862004)(38100700002)(6666004)(316002)(36756003)(6506007)(31686004)(5660300002)(86362001)(2906002)(26005)(31696002)(186003)(2616005)(508600001)(8936002)(37006003)(54906003)(6486002)(8676002)(66946007)(4326008)(66556008)(66476007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFBKWGdTNDl2dnlqdW0wWk1WT29oS3lYcVRoTjhmK2l6eG5za0hBbzFCZmhi?=
 =?utf-8?B?aGZmOENhelN4S1dzb2FEaGJuMG5KbFVZTWVuR3dZc1RaK3NEbVhBOU1vQ0Jy?=
 =?utf-8?B?V256QlQ0eWdldWFaRkdBbGgxcHYzMmVwUWhwYXAvY08zMUY3SVNmY2Y1bmx3?=
 =?utf-8?B?d0M4UlZaREVteHJFRm0zMXc1RmpYRU0zYnFzK2Y3UWdVY0dtQ21mUHBKK1ln?=
 =?utf-8?B?c01rRW56SC9MR0RZWXJWemh6WDBlcDVzdmk2eG11NlViYTdZOEJvNC9LTVRQ?=
 =?utf-8?B?OTdIQVdtTmR4c1R0OTM3bEpqamVSWFlzcUFNV0phakl2Tm5VdUwzSW5wV0t0?=
 =?utf-8?B?bVROMVFwbXJ4YnA4M3lDRC9ucUtDNVJqY0hDV3lxQ2NQbmZPTFk4RVkxWG1L?=
 =?utf-8?B?Z0RudVA1aDZLdC9xSjVZdWdlVm41dGI3VFBKNGVoYXQyT3cra1MvakZrT25q?=
 =?utf-8?B?WDNvMUVwRktBenhSZzNhcVk5MTJsaDhWVWpaejlSUGhZS3NRRzFCWmNpbG8z?=
 =?utf-8?B?MkRSanVBVnZCeWt3M0szeW1wUGhCR1Y4UnkzcmVHZ09WV0pLa09NZ1hwNTJ4?=
 =?utf-8?B?bDl2RWxjQ0xWTGNCc3NtelRvNFYvbGlMd2J6aXVEQlF3VmRTaEgxSVF3T2Z3?=
 =?utf-8?B?THpDNG5HSVZTSEIyaGFQdm04TjNWdVRRMk1rMFN5TEV6YmVkY3ZYNExJRzAv?=
 =?utf-8?B?bzNSZkNNZVRmbWlZR0ZHeDYzN2doWFRHVWJxQXp3TlFUV1g3Q3I3QkZZNEFM?=
 =?utf-8?B?U3dJU0lTV05hcTloNVl4Q0d1YjM3REI4eVhaOWpPejZjQitTV1FFbzJkSng4?=
 =?utf-8?B?bU5QeFNqWjloZ3BtUVVqRkVIV1RZTWtuNW1oKzkxblBrU2hEeThpc2pjbHp2?=
 =?utf-8?B?aEQzZHBQYTRPUmZ5Ym5JU0w2eUpyMlVVMDRFMUc2TExIUGwyeS9STmxQRlpa?=
 =?utf-8?B?aEgwK1pOZXR3eC9CYWFQZmpjOC9Ma1VjSE5QQkpZU2FOcmNmRGVEc2tEcVlP?=
 =?utf-8?B?K1RRUmJyMWR5VDRXTitOcVB4eEoyWmNjZjBIK2NmeDNhVmNIUER5QXR2c25Z?=
 =?utf-8?B?VE5MZUJlbzJ5OTQ2L1VmTVFUTGdMYjlnQVR5SDA2ZkQ4aExZQVBpSS9nVXov?=
 =?utf-8?B?eEFvdVExY1Y5R3h2czMvWXZrS2c1Q2x5UkF0dlhMZFFtT1VpSHJvdEZFYkEv?=
 =?utf-8?B?QXErdS9MeEpqVXZ5K3IrNllwa3FCNkhTSUYyVzlZL3U4TTZhdGtDNVFSdlE2?=
 =?utf-8?B?SU0wejJKTkRlQUZlWHRPM214RElwN1NQL1dFZ1pOYTFudmJ4d0dEYzhKMHI1?=
 =?utf-8?B?T0orb3FZdWNKQnFrMGpneVlScHhLOWtRQnE1RjVXODh2SWNlSFlaeUdCRDhj?=
 =?utf-8?B?bFhvSDFjUnQwRW5KbE5EZDg1R21haHRBVG1oSndwaTRrdmF5NncrYnpUMEhB?=
 =?utf-8?B?RlFCb29rcGxpUEVQVWdWTjZMcXp6Y0ptRVM5YTBBc2xxMGl3TThnLzFUNysw?=
 =?utf-8?B?K1lvVFRMUStyVVlJeXhiWkpVVXNKMnRkSVFmWjZNWlQxY1RaY1VrUXc3Rzl4?=
 =?utf-8?B?YnQyTS9rUVJKNjgvRVluMGJmSHdTWFplZGNhNUhhTXh3eWVWb0NzaHY3aGlh?=
 =?utf-8?B?Z00xdkRFdzFBeTB1cXNIZkRWTDF5aTJhbVJzWVpGNElyZG5ZWDI3bjZDeVE3?=
 =?utf-8?B?dVJrajFIMUFvWW1wNVJrWjFZZFU5RkxsSVUwTHBpRURuc3gxMThXbVRDMlhK?=
 =?utf-8?B?akRyNzRaNzJtTVZRSWR0eW9Cd0pEb1RzVW1SSXpxemFSWE5Vc2k1cFlocnNw?=
 =?utf-8?B?V2FWZitMK1dkc1MzZjJWUVk3N2tEbWVjQStEOGVLYXYyeU9DMVFzai8ySjdx?=
 =?utf-8?B?blhqQ09iYTFxbi93dEdzRWRHbGlodEdiNHl4dW04R25TQjVtZVlSS3hCZGh3?=
 =?utf-8?B?Qkg1cnJhZUNJeUNYMlZQNWk2SHoxam1qR3ZuTUhzS0FlNThRS2J4ZEhDejdX?=
 =?utf-8?B?R1M5WDIxYzVwVllYVGxIT0dyNm9uMFFUcDlINEUzRVo0Y1lNU01lUXBPN3kr?=
 =?utf-8?B?aC9CdnF6WlZ4THdjTjZUcUlsSkRkU1d2NThiSUMyem1MRllhd0N6d09wUG5v?=
 =?utf-8?B?UGNQZy9xa2xKbUxHWGx3dFp5eHJteTVsMy9FOVZxRXg3SGhxeGdOcjBjakVV?=
 =?utf-8?B?UUNBNENvZWV0cFpiajIwVFVwckJmcHdRSkxkNFVkL0dOOHV2S0QyY3dTUmdr?=
 =?utf-8?B?aFZheE9TK0RZcFplYk9YTnIxQkxSTW82WjkydHNYNDFBcEtoc2ZBcWxpOVJC?=
 =?utf-8?B?cnZsZVRTcVV0aWhZQlcvbU1DMTZrd3dNNHB6TDliUzhGRERYRkNzdz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6b17a4-1d03-45bd-3872-08da26cd84ac
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 15:08:56.3939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M+oFKKYz/4zZxJz2c0EaYK+aOxUOLcI9xlKJ+nuKg8AJzgBSCNSkHzlMfYvbf0ETIrM2886lUzrIaihmWqlEZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3394
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-25_06:2022-04-25,2022-04-25 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204250066
X-Proofpoint-GUID: IJqd-eXZ1k1WzXp2XVXH3GTXgurae7cf
X-Proofpoint-ORIG-GUID: IJqd-eXZ1k1WzXp2XVXH3GTXgurae7cf
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 4/25/22 6:15 AM, Chuck Lever III wrote:
>
>> On Apr 23, 2022, at 2:44 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>> This patch allows expired client with open state to be in COURTESY
>> state. Share/access conflict with COURTESY client is resolved by
>> setting COURTESY client to EXPIRABLE state, schedule laundromat
>> to run and returning nfserr_jukebox to the request client.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>> fs/nfsd/nfs4state.c | 111 +++++++++++++++++++++++++++++++++++++++++++++++++---
>> 1 file changed, 105 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index fea5e24e7d94..b08c132648b9 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -700,6 +700,57 @@ run_laundromat(struct nfsd_net *nn, bool wait)
>> 		flush_workqueue(laundry_wq);
>> }
>>
>> +/*
>> + * Check if courtesy clients have conflicting access and resolve it if possible
>> + *
>> + * access:  is op_share_access if share_access is true.
>> + *	    Check if access mode, op_share_access, would conflict with
>> + *	    the current deny mode of the file 'fp'.
>> + * access:  is op_share_deny if share_access is false.
>> + *	    Check if the deny mode, op_share_deny, would conflict with
>> + *	    current access of the file 'fp'.
>> + * stp:     skip checking this entry.
>> + * new_stp: normal open, not open upgrade.
>> + *
>> + * Function returns:
>> + *	false - access/deny mode conflict with normal client.
>> + *	true  - no conflict or conflict with courtesy client(s) is resolved.
>> + */
>> +static bool
>> +nfs4_resolve_deny_conflicts_locked(struct nfs4_file *fp, bool new_stp,
>> +		struct nfs4_ol_stateid *stp, u32 access, bool share_access)
>> +{
>> +	struct nfs4_ol_stateid *st;
>> +	bool conflict = true;
>> +	unsigned char bmap;
>> +	struct nfsd_net *nn;
>> +	struct nfs4_client *clp;
>> +
>> +	lockdep_assert_held(&fp->fi_lock);
>> +	list_for_each_entry(st, &fp->fi_stateids, st_perfile) {
>> +		/* ignore lock stateid */
>> +		if (st->st_openstp)
>> +			continue;
>> +		if (st == stp && new_stp)
>> +			continue;
>> +		/* check file access against deny mode or vice versa */
>> +		bmap = share_access ? st->st_deny_bmap : st->st_access_bmap;
>> +		if (!(access & bmap_to_share_mode(bmap)))
>> +			continue;
>> +		clp = st->st_stid.sc_client;
>> +		if (try_to_expire_client(clp))
>> +			continue;
>> +		conflict = false;
>> +		break;
>> +	}
>> +	if (conflict) {
>> +		clp = stp->st_stid.sc_client;
>> +		nn = net_generic(clp->net, nfsd_net_id);
>> +		run_laundromat(nn, false);
>> +	}
>> +	return conflict;
>> +}
>> +
>> static void
>> __nfs4_file_get_access(struct nfs4_file *fp, u32 access)
>> {
>> @@ -4995,13 +5046,14 @@ nfsd4_truncate(struct svc_rqst *rqstp, struct svc_fh *fh,
>>
>> static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
>> 		struct svc_fh *cur_fh, struct nfs4_ol_stateid *stp,
>> -		struct nfsd4_open *open)
>> +		struct nfsd4_open *open, bool new_stp)
>> {
>> 	struct nfsd_file *nf = NULL;
>> 	__be32 status;
>> 	int oflag = nfs4_access_to_omode(open->op_share_access);
>> 	int access = nfs4_access_to_access(open->op_share_access);
>> 	unsigned char old_access_bmap, old_deny_bmap;
>> +	struct nfs4_client *clp;
>>
>> 	spin_lock(&fp->fi_lock);
>>
>> @@ -5011,6 +5063,14 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
>> 	 */
>> 	status = nfs4_file_check_deny(fp, open->op_share_deny);
>> 	if (status != nfs_ok) {
>> +		if (status != nfserr_share_denied) {
>> +			spin_unlock(&fp->fi_lock);
>> +			goto out;
>> +		}
>> +		clp = stp->st_stid.sc_client;
> @clp is set here, but the value is never used in this function,
> even in later patches. Possibly left over from the previous
> revision of this series?

Thanks Chuck, will fix in v22.
Kernel test robot also reported the problem.

-Dai

>
>
>> +		if (nfs4_resolve_deny_conflicts_locked(fp, new_stp,
>> +				stp, open->op_share_deny, false))
>> +			status = nfserr_jukebox;
>> 		spin_unlock(&fp->fi_lock);
>> 		goto out;
>> 	}
>> @@ -5018,6 +5078,14 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
>> 	/* set access to the file */
>> 	status = nfs4_file_get_access(fp, open->op_share_access);
>> 	if (status != nfs_ok) {
>> +		if (status != nfserr_share_denied) {
>> +			spin_unlock(&fp->fi_lock);
>> +			goto out;
>> +		}
>> +		clp = stp->st_stid.sc_client;
> Ditto.
>
>
>> +		if (nfs4_resolve_deny_conflicts_locked(fp, new_stp,
>> +				stp, open->op_share_access, true))
>> +			status = nfserr_jukebox;
>> 		spin_unlock(&fp->fi_lock);
>> 		goto out;
>> 	}
>> @@ -5064,21 +5132,29 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
>> }
>>
>> static __be32
>> -nfs4_upgrade_open(struct svc_rqst *rqstp, struct nfs4_file *fp, struct svc_fh *cur_fh, struct nfs4_ol_stateid *stp, struct nfsd4_open *open)
>> +nfs4_upgrade_open(struct svc_rqst *rqstp, struct nfs4_file *fp,
>> +		struct svc_fh *cur_fh, struct nfs4_ol_stateid *stp,
>> +		struct nfsd4_open *open)
>> {
>> 	__be32 status;
>> 	unsigned char old_deny_bmap = stp->st_deny_bmap;
>>
>> 	if (!test_access(open->op_share_access, stp))
>> -		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open);
>> +		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open, false);
>>
>> 	/* test and set deny mode */
>> 	spin_lock(&fp->fi_lock);
>> 	status = nfs4_file_check_deny(fp, open->op_share_deny);
>> 	if (status == nfs_ok) {
>> -		set_deny(open->op_share_deny, stp);
>> -		fp->fi_share_deny |=
>> +		if (status != nfserr_share_denied) {
>> +			set_deny(open->op_share_deny, stp);
>> +			fp->fi_share_deny |=
>> 				(open->op_share_deny & NFS4_SHARE_DENY_BOTH);
>> +		} else {
>> +			if (nfs4_resolve_deny_conflicts_locked(fp, false,
>> +					stp, open->op_share_deny, false))
>> +				status = nfserr_jukebox;
>> +		}
>> 	}
>> 	spin_unlock(&fp->fi_lock);
>>
>> @@ -5419,7 +5495,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
>> 			goto out;
>> 		}
>> 	} else {
>> -		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open);
>> +		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open, true);
>> 		if (status) {
>> 			stp->st_stid.sc_type = NFS4_CLOSED_STID;
>> 			release_open_stateid(stp);
>> @@ -5653,12 +5729,35 @@ static void nfsd4_ssc_expire_umount(struct nfsd_net *nn)
>> }
>> #endif
>>
>> +static bool
>> +nfs4_has_any_locks(struct nfs4_client *clp)
>> +{
>> +	int i;
>> +	struct nfs4_stateowner *so;
>> +
>> +	spin_lock(&clp->cl_lock);
>> +	for (i = 0; i < OWNER_HASH_SIZE; i++) {
>> +		list_for_each_entry(so, &clp->cl_ownerstr_hashtbl[i],
>> +				so_strhash) {
>> +			if (so->so_is_open_owner)
>> +				continue;
>> +			spin_unlock(&clp->cl_lock);
>> +			return true;
>> +		}
>> +	}
>> +	spin_unlock(&clp->cl_lock);
>> +	return false;
>> +}
>> +
>> /*
>>   * place holder for now, no check for lock blockers yet
>>   */
>> static bool
>> nfs4_anylock_blockers(struct nfs4_client *clp)
>> {
>> +	/* not allow locks yet */
>> +	if (nfs4_has_any_locks(clp))
>> +		return true;
>> 	/*
>> 	 * don't want to check for delegation conflict here since
>> 	 * we need the state_lock for it. The laundromat willexpire
>> -- 
>> 2.9.5
>>
> --
> Chuck Lever
>
>
>
