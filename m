Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBFC56263F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 00:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiF3WuH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 18:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiF3WuG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 18:50:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851BE4F66F;
        Thu, 30 Jun 2022 15:50:05 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UM4IWx021945;
        Thu, 30 Jun 2022 22:49:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=4oz0ACPtn54DN46/4lS2fJaFMmQ6BZOChxtds3UUtxQ=;
 b=yA4Nr6IhbW5KaePMVbyrb8m5XJqjooXuYLrufmz1KjL5YmnlLwLH3D/SdJ3GjQGHYZIi
 8mV2nA3UxxJ94ITq7mDQR7PvSGGHJrOW3VFIvppd0y0DfJS1A7czG7cYvI3JvlEFRcHG
 pJaWZFmwtqSpZTBHDtT6Aiat95n8r0aWCPnonZ7VF/dxvV9dzuR5YjkKkqF9f4fJNEWP
 D+K+YkDzFrnk0NPX4RnMdLnzFDHRu97UqCNRtBxCm8g9CE5l6s5FH7C4rEs2uyzcWbHm
 M7vOP9BcB/XLzWmkMzEcDglLVLNT5WsmdJWTEhVjtu/gzJXiVM+l3jQBORTbxAEreqyR 0g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gws52nqx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jun 2022 22:49:21 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25UMfmWL001367;
        Thu, 30 Jun 2022 22:49:20 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrt44u8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jun 2022 22:49:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CkWdD98g7fSQwCuAbg7dXMGGvX3bF5Tbi/Wu1aqDyijSPrUckBoJwffUSyPzpNRB8YTnmiPi6NVnf3KDZT0iSyxMjMJXrX7Qu0H+HB0WWnfiBrKz5SHWnjJthHOZ70SbidHsPH3yN9tmYPYxq9xPg7p5EojPRojuzX27xtBZzoUSjk9YTFmNf4V9NlovWB7aX9TkDQz+yxjyP7dVaQHeYpTeJnVYt4ZdoN/3taK6AQMOSbedA3ezJ2iHXitlO3TFqdy24cMKivFnp9geMN9bcjCMXBern/gZqC2fBpYRglzKV8dE7Dy+KMjV6ksvZlB+h+ieb350xnMQgKGCPmXU1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4oz0ACPtn54DN46/4lS2fJaFMmQ6BZOChxtds3UUtxQ=;
 b=BAmlrB4pKqBS3kIB5DgKzGDLBh6JZN2M2vTl8/qw3Fq78cyP7Rkq5EPFkmpWjyyJBHNfaFirAJuNQ3p/QI7wji8WHYkzWbQdDGM8h7J2Dy19z5ANFv7BoRgZSJT3v6rBpexGESJsFoTrrmiPL+kEJQPbOgf9EUAxGuPk/v0fINfTwoaT2/fSrLqrfGlYrYafe3csHLfAoZcB2qrdgdXDSLKqgoAzrXgwhse2r0KTMmgxP8D/CQvpYG44E6CbM5A/Rb28aN0lj1B8S5eGEQ9+xRL6oO/0rF6QYRthZwoElMm1IHCQqXMVz0xTC9mXyxNwxtQVuNfq0FBQd6dLtK4x/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4oz0ACPtn54DN46/4lS2fJaFMmQ6BZOChxtds3UUtxQ=;
 b=V0cuiIPN/XbC0KrtSA9m5LZkbdS06GTDpsaaRaioO3jmu/uMsmPRkpo3PrGL/DfBQPem1CuP7YeqahtLWOcFdmYRnMf7KYJobQKF+/p/FQzMintc1JsVVxlsvn8q9jlMMCTRPLzFak/RekojkI65KMS4kjFWwtGTHzIiLPcKAzw=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by CY4PR10MB2023.namprd10.prod.outlook.com (2603:10b6:903:127::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Thu, 30 Jun
 2022 22:49:17 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2%3]) with mapi id 15.20.5373.022; Thu, 30 Jun 2022
 22:49:17 +0000
Message-ID: <7f4952e4-fa62-8b62-dcae-c7bd3cb060e1@oracle.com>
Date:   Thu, 30 Jun 2022 16:49:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 3/9] mm/mshare: make msharefs writable and support
 directories
Content-Language: en-US
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        aneesh.kumar@linux.ibm.com, arnd@arndb.de, 21cnbao@gmail.com,
        corbet@lwn.net, dave.hansen@linux.intel.com, david@redhat.com,
        ebiederm@xmission.com, hagen@jauu.net, jack@suse.cz,
        keescook@chromium.org, kirill@shutemov.name, kucharsk@gmail.com,
        linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        longpeng2@huawei.com, luto@kernel.org, markhemm@googlemail.com,
        pcc@google.com, rppt@kernel.org, sieberf@amazon.com,
        sjpark@amazon.de, surenb@google.com, tst@schoebel-theuer.de,
        yzaikin@google.com
References: <cover.1656531090.git.khalid.aziz@oracle.com>
 <397ad80630444b90877625a1e94dd81392fc678e.1656531090.git.khalid.aziz@oracle.com>
 <Yr4W6W1i0WOY6zag@magnolia>
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <Yr4W6W1i0WOY6zag@magnolia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0097.namprd05.prod.outlook.com
 (2603:10b6:a03:334::12) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26d03de6-d550-4a02-9595-08da5aeac31e
X-MS-TrafficTypeDiagnostic: CY4PR10MB2023:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zN/BxhNKDaztyUgK8T+A2lNhF4yvIdzRREpmNK6e9l6tDVa5qxlurDOV7HZgF3JYvwSwIJlqFsdIo9dRMCFRFT0IrOleQF9HP8DbpUlkMjkSGf4QQzXVfOzjD9TTrB4RFQSn4iQVIT/8EtA733kPXLtm+sPcIBuJeJzW59wNsYn1iSm3YzySFAfs8rqjoz9nsiXlDUrVtgZzfwUxr+zZVgJCnyXe17fwAqTqqhtbcmfM54zzwIdZ6Zj3FYSdintFu5taU5TZQGYsT6V+EnQn8fZN6ReHPJDMzBgvEsiQviovDcJSVAnUG9ozRV4X1g9rT2Sv4pPEmag3sayxPHPTrLOSZvSsa78RxHC2XyKSTYy7gNLO8hZiC3pqVDUXLg7xQ34v7icTPVxdEu8c+cvcA7UuJ0vUGs7Ly9UwnK3Hl5QW58mI4mMmuJa04rhw8p6wBWeXjti/9jX5YHPj1N5DwYd8gBIWN6+JjwrHEwGBswRb22YGSwmUDokcNgEf6rYpg/HtUIeWDMiTXak0G2aOtjhiDkfQdxETFYchRA7zUbe8TfTFSr/d8ITczGQJ3lv5sQolOU3XI8/NL1iuRbAdZsX8jDeqYFN+a3Ta/sDKCxB4IsqIHHrlEeD/qQhe6M+Pl0N+tNRBAgUkpxvRI7izXQYF1+pObCbJpdpyI0tOw5JNRsbKwChVIne+dOZ9s4RF9HMUrqOeZEcey20PwYdK/n0bc3ohZBQD9TIPlK0wTdipANXwGcgfUeTCpYWndaFTm9UyI1eAZP702OmDNU1HJNVApqICpf7KObH4zauKEz054pOq4GmmpsNU7i7OnDe20OP999WrRM3GueuXDvRBYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(396003)(136003)(346002)(366004)(66556008)(2906002)(6666004)(53546011)(86362001)(7416002)(8676002)(6506007)(478600001)(31696002)(6486002)(4326008)(66946007)(41300700001)(44832011)(8936002)(5660300002)(66476007)(38100700002)(31686004)(6916009)(6512007)(83380400001)(186003)(2616005)(36756003)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXBXMXBDU2NMTkRYTHRMbkZndkhRR2pha2JnYVkzR3c3cXU2c25OMFpHNEIz?=
 =?utf-8?B?Q1dkTytSckpzRkFOdUt3UVU3TU8yODN0WEhldEt4SkJDc2VzMHFuSVBuMHp5?=
 =?utf-8?B?QUl5NHpITlpzZTZzTEExZlpENzNsK2JteDl6bE1lZjd5TlJwaHZtOEUxRTBV?=
 =?utf-8?B?MVlOMTZCNjBpUFN5N0JIcFlNMHpCeW9GUE9wZ3Y0aXlrcU1zL3FTdkdMd05V?=
 =?utf-8?B?ZE1tampDZHc3b1NweXQ3NzdLK2NSVjRRTW9JakJ0MURleTdQSDlLem1GSFox?=
 =?utf-8?B?VHdnWjBHTFFDMGxKdWxOMTdJVDIzcFBNd1MrSkEycjdtY2d5NkZhZGJ5eTg5?=
 =?utf-8?B?MHc4VHpudlFBbTk5T09wMTRYQzBieDk2cDRKdTArZVpVUktIZW9RRktoTTNi?=
 =?utf-8?B?K0duamFrSEpwZXl6Ump6bTdYbHFHYnhUK3N2bU5FQmNkVGZ1OTkwZnc2YkpM?=
 =?utf-8?B?YXRGZ3A5UTU2amxZb2NlQ0g5KzNKRVQ4b3FUU0NBa1lZenRKaHU5TnJqVGl5?=
 =?utf-8?B?enhJZ1dkNWRRVk9OMldlRmplYWxHK2ZoZXBqQW5yNjAvZzhGMCtBRTlDS0xk?=
 =?utf-8?B?RDVlamY2eDdYdy91YWNIVlhhTjVKNWpQQnI5cUV1bnkweTZJc2dvcUFMR2pW?=
 =?utf-8?B?UnM3UDV5ZlJ2ZWxtMENqejR4SEtiWGtnQmV4SEFMN0dLN0RJcWRRSGNheVMz?=
 =?utf-8?B?MFBBMVZvZDc1TFdSWDFCYkluQzJoQ21QUWE4RzJ6bldXWkFNT29sbERiTTNx?=
 =?utf-8?B?UVJYVGIzeW5ETG9sUTdja1hWRi91V0ZQQ0s1SGRyTFU3dE14THQyQXdGR2FP?=
 =?utf-8?B?T1pvRG1Jc251SGVNZFNYLzd3bE9aalJaSXJqMHQreFd5SmZBemo0OEVhME5E?=
 =?utf-8?B?Vkd1QnZQMWphZ3VhUFMrUEU2c3Yrb0lhUFhvWjF2ZmZRQXZTVlNweWRtYUM3?=
 =?utf-8?B?VDMxYUtGOGRER05tL0VWZ2dIdTdNMkFJc1VKajE0NS8wYWIvdEc5cEwwVHJy?=
 =?utf-8?B?ZkpLM3lxVUYzL3NJMlRlTXF2cHNwanhsenhKWnNPYnRaV2gzY1RtTzR6V0V1?=
 =?utf-8?B?VkxrOWpXeW9mOGpkRmVUN2x2cWszOTNZbzVaZmI3WDNzd3pFV0J1M3VWZE95?=
 =?utf-8?B?QWpxZitUbiswcGJXNWNEcjJQanN5Y3U0ZFhYeUNFcTlvcUtyd0ZwN1RhellO?=
 =?utf-8?B?WDRnL1gwNWRmTlNMZnZjK0NFMHlWaWZITStDeGNIT00wZ3ZDQU55b0hrcXpj?=
 =?utf-8?B?cmJ6Y0hXL0ZYUHlLSG9mRnlRczFNdC9JSFFRWmdSNE5aU2ZJc2dUcllCZVpm?=
 =?utf-8?B?VzBDNW42eUU1SzZhdW1LSlg4cGExRmxoY25UOFJHRmV6aGxNSDFuSXpHM0tD?=
 =?utf-8?B?enpQbXFhbVhSdnNmOThqT3Q1R0JoaW10Uzl6V2l6V0doanQrQ2o1RGlpTVU3?=
 =?utf-8?B?dUZwU3g0R21qbWNOUzhiOU5pVnRpUGY1YVdQVjJmQ1JaT3BLRk16VEtCaitL?=
 =?utf-8?B?Wnl2dk9nN2RhZWR2cVJOR0pjL292QTQ1QmtFeFQ0WUFlMTczNmE5czIxa1Vt?=
 =?utf-8?B?RW1KOFpxdEk0THJuWmFZajVVMDFNb0hNYXp6dzFEdkluT2lBYWZlVE1DemRB?=
 =?utf-8?B?dVl3WUFGSXU5Mkt6UndEaWdSSlJrRmY1R3A0RjRBSkRFMkl2ay9OamRoRlpj?=
 =?utf-8?B?QW5BN2JZaCs4ZHpzT0J5ZWVvS0dtZHI5clErTkUrQ3BLR3FPODd5aFBaZDlv?=
 =?utf-8?B?WS9rZzkzdW4vRnd1SVJtcDRaQU5kbU1XUVVTVTc5dkJ3TFRnUk1MUCtvcGU3?=
 =?utf-8?B?aGc5cU1SdThnUHdDME05UDJ1dUc5U0pTR3BnbGJCZ3d3RUorZGVsTlV5eWU2?=
 =?utf-8?B?cTRZVHZUUHZ3Q1o1WG9tcGlGaXF3WXJmRitCRFlyMkcvRnl5MVFlSHkrSmpv?=
 =?utf-8?B?cUI5ZTdvRHRkcmU4dFNYTXJJRlU1aDZ4US9tZ1RZdWE4bW5NSEdwRWswcGhr?=
 =?utf-8?B?K2MydVFjVnh1cmpDVlRrOElSZjZ0M1pUY0RYN0pmVTc1MjBLRGJVK0wxY1ps?=
 =?utf-8?B?TnF1QmhhSkdhdTJZS2xSTjF1TE5kSkRpQVFhczhRNlFldE10V1dKdlFaQUpE?=
 =?utf-8?B?UE5Da1NlZ25aVU95VWVIbzBXM2JqcHdweUcxL3VLeWt2MDlFbm1yeC8wTHdT?=
 =?utf-8?B?bkVKdmNSRmUxTVFidmlWMlQ3ZDhvMUl4a05BRFZjL3hqSm9KT3ZlQXZHL1Nm?=
 =?utf-8?B?S0MrbU1XMisvb1dSWXJ5Q0lNWFBBPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d03de6-d550-4a02-9595-08da5aeac31e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 22:49:17.0942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7leJWvmIc8whdf6RkTxcRTcno2s9XZI5lnlx3C56oOfC/xirP8t26gn4R1FrlDMq5MIiBk1eJNyVvN146amSMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB2023
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-30_14:2022-06-28,2022-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206300087
X-Proofpoint-ORIG-GUID: 2cNxlfClVqHeL35ciimXZ240Ri_ln6QX
X-Proofpoint-GUID: 2cNxlfClVqHeL35ciimXZ240Ri_ln6QX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/30/22 15:34, Darrick J. Wong wrote:
> On Wed, Jun 29, 2022 at 04:53:54PM -0600, Khalid Aziz wrote:
>> Make msharefs filesystem writable and allow creating directories
>> to support better access control to mshare'd regions defined in
>> msharefs.
>>
>> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
>> ---
>>   mm/mshare.c | 195 +++++++++++++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 186 insertions(+), 9 deletions(-)
>>
>> diff --git a/mm/mshare.c b/mm/mshare.c
>> index 3e448e11c742..2d5924d39221 100644
>> --- a/mm/mshare.c
>> +++ b/mm/mshare.c
>> @@ -21,11 +21,21 @@
>>   #include <linux/fileattr.h>
>>   #include <uapi/linux/magic.h>
>>   #include <uapi/linux/limits.h>
>> +#include <uapi/linux/mman.h>
>>   
>>   static struct super_block *msharefs_sb;
>>   
>> +static const struct inode_operations msharefs_dir_inode_ops;
>> +static const struct inode_operations msharefs_file_inode_ops;
>> +
>> +static int
>> +msharefs_open(struct inode *inode, struct file *file)
>> +{
>> +	return simple_open(inode, file);
>> +}
>> +
>>   static const struct file_operations msharefs_file_operations = {
>> -	.open		= simple_open,
>> +	.open		= msharefs_open,
>>   	.llseek		= no_llseek,
>>   };
>>   
>> @@ -42,6 +52,113 @@ msharefs_d_hash(const struct dentry *dentry, struct qstr *qstr)
>>   	return 0;
>>   }
>>   
>> +static struct dentry
>> +*msharefs_alloc_dentry(struct dentry *parent, const char *name)
>> +{
>> +	struct dentry *d;
>> +	struct qstr q;
>> +	int err;
>> +
>> +	q.name = name;
>> +	q.len = strlen(name);
>> +
>> +	err = msharefs_d_hash(parent, &q);
>> +	if (err)
>> +		return ERR_PTR(err);
>> +
>> +	d = d_alloc(parent, &q);
>> +	if (d)
>> +		return d;
>> +
>> +	return ERR_PTR(-ENOMEM);
>> +}
>> +
>> +static struct inode
>> +*msharefs_get_inode(struct super_block *sb, const struct inode *dir,
>> +			umode_t mode)
>> +{
>> +	struct inode *inode = new_inode(sb);
>> +
>> +	if (inode) {
> 
> Not sure why you wouldn't go with the less-indently version:
> 
> 	if (!inode)
> 		return ERR_PTR(-ENOMEM);
> 
> 	inode->i_ino = get_next_ino();
> 	<etc>
> 

Yeah, good idea. I will change it.

>> +		inode->i_ino = get_next_ino();
>> +		inode_init_owner(&init_user_ns, inode, dir, mode);
>> +
>> +		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
>> +
>> +		switch (mode & S_IFMT) {
> 
> Shouldn't we set the mode somewhere?

mode is passed in as parameter to msharefs_get_inode() which uses this value to determine its actions.

> 
>> +		case S_IFREG:
>> +			inode->i_op = &msharefs_file_inode_ops;
>> +			inode->i_fop = &msharefs_file_operations;
>> +			break;
>> +		case S_IFDIR:
>> +			inode->i_op = &msharefs_dir_inode_ops;
>> +			inode->i_fop = &simple_dir_operations;
>> +			inc_nlink(inode);
>> +			break;
>> +		case S_IFLNK:
>> +			inode->i_op = &page_symlink_inode_operations;
>> +			break;
>> +		default:
>> +			discard_new_inode(inode);
>> +			inode = NULL;
>> +			break;
>> +		}
>> +	}
>> +
>> +	return inode;
>> +}
>> +
>> +static int
>> +msharefs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
>> +		struct dentry *dentry, umode_t mode, dev_t dev)
>> +{
>> +	struct inode *inode;
>> +	int err = 0;
>> +
>> +	inode = msharefs_get_inode(dir->i_sb, dir, mode);
>> +	if (IS_ERR(inode))
>> +		return PTR_ERR(inode);
> 
> ...and if @inode is NULL?

Oh right, IS_ERR() does not check for NULL value. I will add a check for that and return ENOMEM.

> 
>> +
>> +	d_instantiate(dentry, inode);
>> +	dget(dentry);
>> +	dir->i_mtime = dir->i_ctime = current_time(dir);
>> +
>> +	return err;
>> +}
>> +
>> +static int
>> +msharefs_create(struct user_namespace *mnt_userns, struct inode *dir,
>> +		struct dentry *dentry, umode_t mode, bool excl)
>> +{
>> +	return msharefs_mknod(&init_user_ns, dir, dentry, mode | S_IFREG, 0);
>> +}
>> +
>> +static int
>> +msharefs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
>> +		struct dentry *dentry, umode_t mode)
>> +{
>> +	int ret = msharefs_mknod(&init_user_ns, dir, dentry, mode | S_IFDIR, 0);
>> +
>> +	if (!ret)
>> +		inc_nlink(dir);
>> +	return ret;
>> +}
>> +
>> +static const struct inode_operations msharefs_file_inode_ops = {
>> +	.setattr	= simple_setattr,
>> +	.getattr	= simple_getattr,
>> +};
>> +static const struct inode_operations msharefs_dir_inode_ops = {
>> +	.create		= msharefs_create,
>> +	.lookup		= simple_lookup,
>> +	.link		= simple_link,
>> +	.unlink		= simple_unlink,
>> +	.mkdir		= msharefs_mkdir,
>> +	.rmdir		= simple_rmdir,
>> +	.mknod		= msharefs_mknod,
>> +	.rename		= simple_rename,
>> +};
>> +
>>   static void
>>   mshare_evict_inode(struct inode *inode)
>>   {
>> @@ -58,7 +175,7 @@ mshare_info_read(struct file *file, char __user *buf, size_t nbytes,
>>   {
>>   	char s[80];
>>   
>> -	sprintf(s, "%ld", PGDIR_SIZE);
>> +	sprintf(s, "%ld\n", PGDIR_SIZE);
> 
> Changing this already?

Possibly. There is one suggestion to change it to PMD and it might be a better choice.

> 
>>   	return simple_read_from_buffer(buf, nbytes, ppos, s, strlen(s));
>>   }
>>   
>> @@ -72,6 +189,38 @@ static const struct super_operations mshare_s_ops = {
>>   	.evict_inode = mshare_evict_inode,
>>   };
>>   
>> +static int
>> +prepopulate_files(struct super_block *s, struct inode *dir,
>> +			struct dentry *root, const struct tree_descr *files)
>> +{
>> +	int i;
>> +	struct inode *inode;
>> +	struct dentry *dentry;
>> +
>> +	for (i = 0; !files->name || files->name[0]; i++, files++) {
>> +		if (!files->name)
>> +			continue;
> 
> What ends the array?  NULL name or empty name?
> Do we have to erase all of these when the fs gets unmounted?

This code is very similar to simple_fill_super() and I reused the code from there. inodes and dentries will need to be 
erased on unmount through evict_inode.

Thanks,
Khalid
