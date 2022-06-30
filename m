Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D31562613
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 00:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiF3W2s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 18:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiF3W2r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 18:28:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680F145533;
        Thu, 30 Jun 2022 15:28:45 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UM41JV016964;
        Thu, 30 Jun 2022 22:27:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=RGD0oHKXTEWoqIqbAwlsLR0J0PJYMKZ538fhbC9fd+g=;
 b=Ug40Dlvvq5UwFUG230BFQ4+H7B07HfeuvvoYYbxFWP875LTv7K0mYE9N3fy9maFvx6Y/
 g3RvkTffNf7cPcYpIOqT/JDFlynD//3+02sMr9X6+xq8bUYmyO5dDA1Pf+caZDDrlYZm
 GQKaB2GqoptT8+tSceB+h8XCkvk84C7p9fyHS4xpOBaoYq3lnd7pKwpETvm+8GotBvom
 DPooTAvMU8Jb/jpdyvnFW0nASZMmwHjb04d3lwj/skYXW01QBzNwBpEdsVI85qEwP3Mm
 1apQRwv4Akal2xgJpP3PN0pnL9TgBHvwUnGylF6JrPxEXR5J141XB9ESuEfnvbZNqqEs IQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwsysnhke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jun 2022 22:27:08 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25UMF2oC006089;
        Thu, 30 Jun 2022 22:27:07 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrt4m43m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jun 2022 22:27:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G97upKGc+Y0S2VtGU4WDMNAnsexDdeYd8dAv8LtHsiOHsBdqb+t1nBer41+FN4oD3ROsdMLccYt+o/HWVXMbBTZbFmZK7Qs9zr687LjwpCSxyjYpZDgJQrEf3YKPiKdiuz4cvp5/rcB+m84KLYTf0D+M09KY7QicccnSKMVhCNgbDX74qq4uVhUX4zydJlP0e8GW9T4cnGtBklxuLHF9u24eyZDEip0bVGo4pMIfLu47RFKiJp/vJibx9i+Ii5chieSFvCoxJSF0dmed5A+UxpY6IokdqlR8Ua7m+zau/OKl5ND0KZRe1ZPoEKdxMkSxZ1vOn2bZEQsFZqeeFNBwzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGD0oHKXTEWoqIqbAwlsLR0J0PJYMKZ538fhbC9fd+g=;
 b=BJjxrB8rTdWytXe4av7u+JdDVB6LIwYcgu8EuKnnq9mxbjJGBPbTjdKdASWEj1PLD+OPqmZpypissBoCZp+esMTNKYNmR0qoTrCasjuTgPBE0z5VswjlZ9MZNnbFcof8tz3UY6jmBDx24HKKXzswqhWI1XKTvH/ByMQVlDSKQ/JPkOhrVh4Z5ysDBWD/jxFvon2nhpyC82T/nyAETLeCgbOvHzoYWXA8nly77hjWCKbelkfWuUxIWVUES2Qey7FVEbryJbo9ZfnVvk8r/KgnIh4qxZojFdewRzb2e5vIP+ZjQQ9tivjwbvdUfa4RqH6zjaGD93mUIcEtvQqucPPXFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGD0oHKXTEWoqIqbAwlsLR0J0PJYMKZ538fhbC9fd+g=;
 b=Sm5Ba+70d9SKJ4RZYzeauHYqzTcAnHQF3ojesAKIg0NdcEUseVoL9kHGf1Hso9mkRXuhoeLia5akA5jwauUddgvBXQTvwlYFWYYE++pTHSXsDX/wx8msxRniE0J/zLvoyjLAM5pQKdwkp0HYjdirL4TdW+S0EhHa3yOPZ7sKWqo=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by MN2PR10MB3152.namprd10.prod.outlook.com (2603:10b6:208:124::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 30 Jun
 2022 22:27:05 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2%3]) with mapi id 15.20.5373.022; Thu, 30 Jun 2022
 22:27:05 +0000
Message-ID: <4bbaa753-f145-4971-2b51-c909b946ae63@oracle.com>
Date:   Thu, 30 Jun 2022 16:27:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 4/9] mm/mshare: Add a read operation for msharefs files
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
 <05649b455e2191642e85cc5522ef39ad49fdeca3.1656531090.git.khalid.aziz@oracle.com>
 <Yr4VVuCzCp50cu0O@magnolia>
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <Yr4VVuCzCp50cu0O@magnolia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0027.namprd05.prod.outlook.com
 (2603:10b6:803:40::40) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0478f98c-f6cf-43c4-5594-08da5ae7a92f
X-MS-TrafficTypeDiagnostic: MN2PR10MB3152:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hDdqxC4gDPdkLF76WMjwOzvBLuscV+viuSeJGtLkCvx6wvqkjXNRlAo43Lz+JWv96PNlIOoz8uLLeD2RIEBKlLntVJaK/C5OuoXF+B1e7FNfAzWp0uPHkZQbjeDuWdkvH/vBdI2vvqXlXeod91n+D6UlNtItRLSGa4L72jhzmN/ty4iBvKpLxaDy2kI4oJOeDnvTeFwbJdBG/Eb0rKT16l7avvUN6CuYlxq1efKoavVT5M4KPkZNkCMEZ0cq9SNcXUD1eXcwT7EZPyHQGENpbbrTnhHc+F9sz+ZrN/gDdGIKbgZ4LGGSP8rbWjqYP7X7u4njSXabpg+A1hBVBJl/Vj2gSMpo6S/NQsMIiB8qQd2E5Xv+b0cEIhAYkNQoJMo93ppYwy9Y/j7gS0pzoZZ0Da0kFO3mJdqX9+8nKhWLsf50zmPx++vlI7lxSsbhIzl3qRgi7jgtk/RFJlUAhBRA0r12oj6X6RGb2tBsfnw5MLXBdrW/LC3T69dT7LcUvXbvL4xWxVfC38rS9/vPlwAX0FMeHmtHiL+NQo36zqzN8r2XxA9MCD1ZZ7M191Q2zRKGawyHjeU14NpIjWwopeTUN6EQH4M3mkGN87kloAajLe1XMElXewaLyz+A0U13Ah+hsTIw/Qi7ZtTm722/e4m0+IzyxZRvBbGBOrLiA9cKeBsoxgzMDBuJEx4XVKt3ZybJcUPcstRjsBrO3p94qrz/o+2mMFPyXb+NTQLc4q7NVZQxYw0kt1vw849qnKLCuaLKmm/W6Mc4aAqHocy5iDMOmwb0VJeoaAw4L7UK2wSjKzf2NBO2oorUSRkgqrMiq0GPU8McBRPIR/4wp5B5a0d9MA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(39860400002)(376002)(136003)(346002)(186003)(2906002)(6512007)(2616005)(36756003)(6506007)(31686004)(83380400001)(53546011)(38100700002)(41300700001)(6666004)(66476007)(6916009)(5660300002)(8936002)(7416002)(478600001)(4326008)(66946007)(6486002)(66556008)(8676002)(316002)(86362001)(31696002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzZoYnozclhXaUYrKzB5ak12aTU1c0ZXejJpYjNCQkt3YU5JUFZoT3hVVDNh?=
 =?utf-8?B?OGk2WExRR1gvVVRaWWlxeUNNZnR0MmY3cEk1S3hScHNoQ0w5UStEL2dQWE54?=
 =?utf-8?B?c01seUpkNTdienZ5N0RNU2RmbTlrZ2RWQlNldE5SSWVpbERoYTdFMTdldVNQ?=
 =?utf-8?B?ZXJpNU9jVnJ4MXBVd1h5OENaSkZEZE5qTnI4YmJQd0xjNDdmZmUzWWRvMzJ0?=
 =?utf-8?B?am1NeDV1KzlSZnFOV1ZtRWt5dlNmMlM4bE1KcnFTczM3MysrTGlUM09haWNm?=
 =?utf-8?B?THlsdkcwdGxaWGJaVm1tTm10dWtZKzNwYzNNOHVUaUpIMkw2ZExEaFBpUW5w?=
 =?utf-8?B?YXFwZjlnT1RrNktJSEppSGhOalZVMGJIaTVESWhTRi8vK0NSVUlPaU15czFH?=
 =?utf-8?B?QlZZaE1STDQxVEJ6aWZ5S255OWNueWhpb0IyaTh5NW9mOTZRME1hY2tVQmh1?=
 =?utf-8?B?Wm9NbjZ6WmhDNW5pS0pheDhESGNiZWlBUGIyNkE5Z1oyN3ZBSzAvQmtpeUx5?=
 =?utf-8?B?cUpNRXFNYjVPVHF0OXQvQmlGamlMSVQxblNkUHkxZnBlQjhmQjZkeVc2Y2hY?=
 =?utf-8?B?ZmR0c0RGRWo5WWFHaDQwd1lFNllsak1UZXdkU0Znb05ub2lSeHhTRndpdHFY?=
 =?utf-8?B?NEllNTBZbmR1dFhXazUybUFVMThaWjR2VlRWR1R4UCtDQVVERUQrWk9NbUJT?=
 =?utf-8?B?VytaT0FIWm5OV0tlbFZFSkdSZXUwK2szZDlNSngrQ3Zhd0dVL1Z4c0xENjZD?=
 =?utf-8?B?Q1g3TGZqQWlHVHBSZ2N4WGF5UnVYU2JaQkJiRVBjdWF6YzZCYVl4aU5LTUgz?=
 =?utf-8?B?Qm9MaE5VdWdLUUFCbER1b0UydVZjWnU5SVJ6K0xGNUVnQjdHWlI5RnhkVmM4?=
 =?utf-8?B?cExpM0FWcVdmQ1pnSjRwZkZ4djJtUDNDazBuNmkyYVNSTGJuVGhkVkNGTmtR?=
 =?utf-8?B?UXowSUdPQzd0QTlNR3RRVlU1eWQrWW8rMjMyS0tDYUFJNWcrYVFtdG9TMjJz?=
 =?utf-8?B?Y1Ivbzh2VUhGSjR6ZUI0VCswamFSMkVxMldOUlVNTm9mK05hYllqR2pZa3Jz?=
 =?utf-8?B?R2kwSkl0dkErMnJzWHdSSFBlWWlBajBJczk3dURiOFM3VlZ6Y0ZSa25XVFJa?=
 =?utf-8?B?S1Mzc3BoVHZIZWhhaEZnYUlhYWpGdlhITWJQYW1rNklSMkJGUDFwUlYyMWdC?=
 =?utf-8?B?WlVCeXRHckxsWGdscDdjYm5Pc0xva1F6VVIzc2FCelVZV0QyTHIxcDE3YmIv?=
 =?utf-8?B?UDJFLzhrR24xWnBYMCtMcS9HZ0NFMTBLMGFmU29nQmRHeXVSTXBJMHdLNWM1?=
 =?utf-8?B?N0d2YU8yOU5XdFh3Wi9vcXdTWkI5cGNQTFY4WTVWc252NnVURURMa3NDeE1F?=
 =?utf-8?B?WEtzSGxZYUJjUzlFYmZmNkJuNmtISUkzTDlucVhIUVhIYVF0V3laOTFmNlE2?=
 =?utf-8?B?TXQzQnVxeUpRYzZlb3kzaU9jUzZaNVFYRmo3Q1hLd0VzZXhtc2xHWDV6Wnlz?=
 =?utf-8?B?bmFEaTlFL2dEQjdRL2dsWlpmZWZTbS9kdm8rWUxUcEZ4Z09Xek44Ym5CRVNR?=
 =?utf-8?B?M0ovNmtGMUVZSGdOVG5oRGhCeW1MM25QOUdFK090M2FTMWg3RUY0ZjNNT3Fs?=
 =?utf-8?B?c0hsaldaRGVqczBZR1ZMUUtnSnpWTEJoLzdTUzRXS0pWTmh2SXdEZXVmYmZk?=
 =?utf-8?B?Y2p2YXc0R3NXMVU5QmxmejdqMTBwNFlnUHUrRUZaSHZQR1dKblpMMlo2Q1Jj?=
 =?utf-8?B?eXVVZGVmYkxZT1BlTWl5TUNFUm9jYWNkNktCNmFQa1NEMXpZSVFwN0dBakxr?=
 =?utf-8?B?bWM5Tzh3dUZtQTE4U2x1NVZZMWFweUcrKzlzN0pEZHAwNGlKTHJ5aVRyZTNn?=
 =?utf-8?B?Z0x0WFl6TDNScjBPOEJ2WCtSOENvZmMvUjR6dmgyOFhJMzJPT1E5eEJiUFZj?=
 =?utf-8?B?WnF4Q0tsODN1L0lyWmRKYXV1bkdnTkFGT3FEQUxuR0tDQ1VKbENBUEdCQ1hX?=
 =?utf-8?B?N1BQeDJCTVBvSHNtQWlXZnEyaEFwTnBNdnpSb1VCSU15QWRycmZja2dNL0lt?=
 =?utf-8?B?K0pwUTUrc2pwdjQwYU1wVUpHbllLb2w1bVYxa3ExZkNVcmhaQlRlbU8yYVRY?=
 =?utf-8?B?U0NtZW9BRTRSbDJpOE5RSGlpWDhIWUdPSFlqN1hhVENFTjJhOEM0YXpoZXdN?=
 =?utf-8?B?ek9uQW91MDhnZ1p2STVYNTBiaG9mZERaK2w4OGZhRjNHdXVvc1pwTkZRdWcx?=
 =?utf-8?B?czNRVFBSZDNjV2I5VkpvQUZBdktBPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0478f98c-f6cf-43c4-5594-08da5ae7a92f
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 22:27:05.0774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zuQaMCsmldBejNU6NMtJPLGE5IXbcIEhuryKbLzOKzHaDnSbYjLo1SCcFOgL9sigO7NDYZlSUJRDuQ8G8jU39g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3152
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-30_14:2022-06-28,2022-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206300086
X-Proofpoint-ORIG-GUID: 1zNyCvbwHxqdaBB13U_zbgN6aVScqtg9
X-Proofpoint-GUID: 1zNyCvbwHxqdaBB13U_zbgN6aVScqtg9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/30/22 15:27, Darrick J. Wong wrote:
> On Wed, Jun 29, 2022 at 04:53:55PM -0600, Khalid Aziz wrote:
>> When a new file is created under msharefs, allocate a new mm_struct
>> that will hold the VMAs for mshare region. Also allocate structure
>> to defines the mshare region and add a read operation to the file
>> that returns this information about the mshare region. Currently
>> this information is returned as a struct:
>>
>> struct mshare_info {
>> 	unsigned long start;
>> 	unsigned long size;
>> };
>>
>> This gives the start address for mshare region and its size.
>>
>> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
>> ---
>>   include/uapi/linux/mman.h |  5 +++
>>   mm/mshare.c               | 64 ++++++++++++++++++++++++++++++++++++++-
>>   2 files changed, 68 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/uapi/linux/mman.h b/include/uapi/linux/mman.h
>> index f55bc680b5b0..56fe446e24b1 100644
>> --- a/include/uapi/linux/mman.h
>> +++ b/include/uapi/linux/mman.h
>> @@ -41,4 +41,9 @@
>>   #define MAP_HUGE_2GB	HUGETLB_FLAG_ENCODE_2GB
>>   #define MAP_HUGE_16GB	HUGETLB_FLAG_ENCODE_16GB
>>   
>> +struct mshare_info {
>> +	unsigned long start;
>> +	unsigned long size;
> 
> You might want to make these explicitly u64, since this is userspace
> ABI and you never know when someone will want to do something crazy like
> run 32-bit programs with mshare files.
> 
> Also you might want to add some padding fields for flags, future
> expansion, etc.

That sounds like a good idea. I will queue it up for next version of patch series.

> 
>> +};
>> +
>>   #endif /* _UAPI_LINUX_MMAN_H */
>> diff --git a/mm/mshare.c b/mm/mshare.c
>> index 2d5924d39221..d238b68b0576 100644
>> --- a/mm/mshare.c
>> +++ b/mm/mshare.c
>> @@ -22,8 +22,14 @@
>>   #include <uapi/linux/magic.h>
>>   #include <uapi/linux/limits.h>
>>   #include <uapi/linux/mman.h>
>> +#include <linux/sched/mm.h>
>>   
>>   static struct super_block *msharefs_sb;
>> +struct mshare_data {
>> +	struct mm_struct *mm;
>> +	refcount_t refcnt;
>> +	struct mshare_info *minfo;
>> +};
>>   
>>   static const struct inode_operations msharefs_dir_inode_ops;
>>   static const struct inode_operations msharefs_file_inode_ops;
>> @@ -34,8 +40,29 @@ msharefs_open(struct inode *inode, struct file *file)
>>   	return simple_open(inode, file);
>>   }
>>   
>> +static ssize_t
>> +msharefs_read(struct kiocb *iocb, struct iov_iter *iov)
>> +{
>> +	struct mshare_data *info = iocb->ki_filp->private_data;
>> +	size_t ret;
>> +	struct mshare_info m_info;
>> +
>> +	if (info->minfo != NULL) {
>> +		m_info.start = info->minfo->start;
>> +		m_info.size = info->minfo->size;
>> +	} else {
>> +		m_info.start = 0;
>> +		m_info.size = 0;
> 
> Hmmm, read()ing out the shared mapping information.  Heh.
> 
> When does this case happen?  Is it before anybody mmaps this file into
> an address space?
> 

It can happen before or after the first mmap which will establish the start address and size. Hence I have to account 
for both cases.

>> +	}
>> +	ret = copy_to_iter(&m_info, sizeof(m_info), iov);
>> +	if (!ret)
>> +		return -EFAULT;
>> +	return ret;
>> +}
>> +
>>   static const struct file_operations msharefs_file_operations = {
>>   	.open		= msharefs_open,
>> +	.read_iter	= msharefs_read,
>>   	.llseek		= no_llseek,
>>   };
>>   
>> @@ -73,12 +100,43 @@ static struct dentry
>>   	return ERR_PTR(-ENOMEM);
>>   }
>>   
>> +static int
>> +msharefs_fill_mm(struct inode *inode)
>> +{
>> +	struct mm_struct *mm;
>> +	struct mshare_data *info = NULL;
>> +	int retval = 0;
>> +
>> +	mm = mm_alloc();
>> +	if (!mm) {
>> +		retval = -ENOMEM;
>> +		goto err_free;
>> +	}
>> +
>> +	info = kzalloc(sizeof(*info), GFP_KERNEL);
>> +	if (!info) {
>> +		retval = -ENOMEM;
>> +		goto err_free;
>> +	}
>> +	info->mm = mm;
>> +	info->minfo = NULL;
>> +	refcount_set(&info->refcnt, 1);
>> +	inode->i_private = info;
>> +
>> +	return 0;
>> +
>> +err_free:
>> +	if (mm)
>> +		mmput(mm);
>> +	kfree(info);
>> +	return retval;
>> +}
>> +
>>   static struct inode
>>   *msharefs_get_inode(struct super_block *sb, const struct inode *dir,
>>   			umode_t mode)
>>   {
>>   	struct inode *inode = new_inode(sb);
>> -
>>   	if (inode) {
>>   		inode->i_ino = get_next_ino();
>>   		inode_init_owner(&init_user_ns, inode, dir, mode);
>> @@ -89,6 +147,10 @@ static struct inode
>>   		case S_IFREG:
>>   			inode->i_op = &msharefs_file_inode_ops;
>>   			inode->i_fop = &msharefs_file_operations;
>> +			if (msharefs_fill_mm(inode) != 0) {
>> +				discard_new_inode(inode);
>> +				inode = ERR_PTR(-ENOMEM);
> 
> Is it intentional to clobber the msharefs_fill_mm return value and
> replace it with ENOMEM?

ENOMEM sounded like the right value to return from msharefs_get_inode() in case of failure. On the other hand, there 
isn't much of a reason to not just return the return value from msharefs_fill_mm(). I can change that.

Thanks for the review.

--
Khalid

