Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E620C4FFDC5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Apr 2022 20:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234796AbiDMSal (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 14:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbiDMSak (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:30:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A699B50E39;
        Wed, 13 Apr 2022 11:28:17 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23DGHwAI018804;
        Wed, 13 Apr 2022 18:28:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=mfFZeS8w2FxgkGdmWZRv7xEtOZsR15TaSvMS0f/4WNE=;
 b=pvty/wzDpUMmlROeNbbtf/WhgzdJiLu6lA39FhYzEIqW+7IMYcAgoi2U5XHRE7XYZK+d
 gcXnmM0H5E/Jtbo9a/WuXfdu7je4ExhPbf2LC2Fek9GR8ynZrpnFEN/DLf7i5KBJXHed
 Ge4BJTUIF8EFmPdt3NeUGHp/ZY0sr2laXcRNJRulbfc9RaWJRkzjtG7/1nb9TxxNVZRS
 xIq57YxFfvsbAg/iYt+pg5RP9MaxyAPtRoAxiUOiYWoBJFn5ushkVz5564JbQiEeKXT0
 D6tvF4+GdyUaF83efhDQKYP7pTKVncPnPQ0P9+RZf22W+YdGmzRXaXx0k+2NnX/l1url tw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0r1jvc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 18:28:13 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23DIRhVW006374;
        Wed, 13 Apr 2022 18:28:11 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k4981n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 18:28:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lExX+whjRb1eYiDOj9+ETHDC9pvIiweaCrs0M8GtVQX+2H1Df4gb6XXKgPmewWMCWvbXzZviTsU9Gk0JPVH2yPbBWA2o1R//09NUcfeJrh9+RyGS3IosezzuUVrLGRZQimOMomAXw8bxpOMLka8CUEqStY6A/p4fGCTtUl3SyCKXE95yC9UTynvmz+J8iYHC33XbAdKZ4mtFFobHVqPke/S4A5arkGBfutqQ/xyMi68mZ4lMLXOLr9Fjvw1vtq/l1wLwlVBClsh6uaoMGgm1MamfEkOxwOnEJD7bzYxFeRESDJfiLFATEgRQdYaoggNgswoAdrW0/gYfqmoiaBabrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mfFZeS8w2FxgkGdmWZRv7xEtOZsR15TaSvMS0f/4WNE=;
 b=cObKiVQXwTqs8N/fdYk2cpO2YlMq/Om0QTyJVkGEDumJFuW3FqQRla2NO9IZabgfS+rbG8yQrWaN1g45W27GiLt6EVxy/q6WmfMwQrUE5N1vPpNEn5z2+nt/y8YNJFUY7iN38awTEr3R1F6490FdLZscpNp3HcY/a8nu6Hzs0bw8X4OH8xNnUjCHwYcouG7l5ypjw8aY37IgKUt/eTqXdNpAzEaeah727WoKv1v6S/SEv3BLn1+OtJb249VvDmlogNVVQgNnhNKfVE6cbZzjNa8RCFmWkla7xwcXOXjYX37/7/NS4LSzYwIujhubnaRqRpkRJie9rgjy3yImZnqBSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfFZeS8w2FxgkGdmWZRv7xEtOZsR15TaSvMS0f/4WNE=;
 b=qpVfRbc8swynEKZA04PyvtfmQWhIQ4JGjXxF53kymH644jzun+9E/zVKwrnoHDL5CAyaeVwRYOJACUMNYFo0kArsGvsG6foFblfMeDIt204PkC3Qyfb/+SYQH3WTrhPFituEEzAVL/02uFsE14VdSB4NjzZ3C7yQ4mYIYTmm1nE=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by DM5PR10MB1497.namprd10.prod.outlook.com (2603:10b6:3:13::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 18:28:10 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::52b:f017:38d1:fd14]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::52b:f017:38d1:fd14%2]) with mapi id 15.20.5164.018; Wed, 13 Apr 2022
 18:28:09 +0000
Message-ID: <a33fae1e-8991-cd5e-1fb7-cbc77165e55c@oracle.com>
Date:   Wed, 13 Apr 2022 11:28:05 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH RFC v19 06/11] NFSD: Update find_clp_in_name_tree() to
 handle courtesy client
Content-Language: en-US
To:     Bruce Fields <bfields@fieldses.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <1648742529-28551-1-git-send-email-dai.ngo@oracle.com>
 <1648742529-28551-7-git-send-email-dai.ngo@oracle.com>
 <20220401152109.GB18534@fieldses.org>
 <52CA1DBC-A0E2-4C1C-96DF-3E6114CDDFFD@oracle.com>
 <8dc762fc-dac8-b323-d0bc-4dbeada8c279@oracle.com>
 <20220413125550.GA29176@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20220413125550.GA29176@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0051.namprd02.prod.outlook.com
 (2603:10b6:5:177::28) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed21f99e-d212-479d-fd35-08da1d7b5c77
X-MS-TrafficTypeDiagnostic: DM5PR10MB1497:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB1497B01F5133E5B78939C85E87EC9@DM5PR10MB1497.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fixYxt+bForDYF1B/YPFUeKGCPkPNTWwh76SikyPsBVTRGZNfAOfko4IQ6GQ5Okeob41A4n9+uc3z2fPackZdDSTwjTDwlKE3xGSmv2lQC1+/S2Q1M/oe0sNIMpiscILTubfEA298w7cv3yfukG79rCsUSCZRhBrq8+dK1EKxEimJcRYeHToliDCXXSdFxHtdq4oDjUdQwa6EEQjyupzAQewLCCM1U8nS8WFwxN9ETeQJhVsBv6pYlEzRTwldoMfqL9nWN10+EHbRNiu39B8YiHOGS0g79bK8IqdySDpSNXHbK/tc4R+3SGmj0jfHz539cPTN5sXMJtvgBtlcWcojdZAhBoMmLD4M8pGg0boQ2yB86Rdq/4jmPBkz58kCgV//CBwA9B1oyqoDpoVd7N+YBr/Ka/3LnvkCWyovLvJc0NpKPXNMf6zeIiCnk4Y7aA1q2MUfiPq3I/7OyeUaZLyN1VkuMLZdGpGH8cKmzrIv0IFxnSlZylSTIRC7ErEDY4ef/ke+hpPKj4JEp37cGFq1dTkw27fr9RUAZPl5K+qdfff8oHHcljivYvU8Ki5QuhjonFAemFiCubKgVDQtfS/OTAW5rcby0ew19GQyVnmavdG/L5H9lMv2MJeUqnVsHv8BKKwPBMAq7fds4ABUh3YLJ2KiI3dGffZPCdRcn3ehDvrNz/QgiYUwaJqC7eunPCjTnB8spOvB97zEChznSLDSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(8676002)(6916009)(316002)(66476007)(4326008)(66946007)(2616005)(8936002)(6512007)(9686003)(6666004)(5660300002)(53546011)(31696002)(54906003)(6506007)(15650500001)(66556008)(31686004)(6486002)(38100700002)(36756003)(186003)(26005)(2906002)(83380400001)(86362001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVBrd3lHbWNjWEFsNzU3MUt0Rng5VXdJLzJMd21JdkpMRnRyc0gzbnIvU1o5?=
 =?utf-8?B?MkkzRFhvNnhWdXlIeG1aWkZmdFlqY2ZCOWdXcUQwRis2d3hneVZIdnk2UVVL?=
 =?utf-8?B?ZEpDYkl1U0hVdEhXWEM4b1cyWm9XSFdvbDZqSldaWkw3YkJhL2wrdlNVVkty?=
 =?utf-8?B?QnRLVjlGWGxld3BFSTRrWUVPUzFSY0hKQ3BacVRJV3dtbVR5SnBscE1RYy9R?=
 =?utf-8?B?OThHbEF5WjBKdmdtN2g1V2ZGMDZqbGx4WXNGWUxYN242a2toSzVnUE5LSzhm?=
 =?utf-8?B?L2xuRmhtMGduWFhOTEdJbjhSUnh5a05ob2U4S2wyUHgvMzdaUHVZNWtROEk1?=
 =?utf-8?B?ZzVoYkk0YTdiRVFmVjBycWVBQ1owN243bXl0bFlKYVkwRXExbGZoM0diV28y?=
 =?utf-8?B?WW5ObTJVN2F5UUJHS3BqLzU3S2RmVXBqVzk5VHJaamxrMW9wcjdtMHc3Z1Q5?=
 =?utf-8?B?ZU00Y3JrTkxZNkZEd0RTM0VOUWJtN245dDBKR0taVFN6Q0VBVitabmZXd1Ni?=
 =?utf-8?B?eEh4aE1IM2JCd3BwaFgrT2tpMmhBV1hRdld1RlViY3EwYTMzM0kvNGxRMFdI?=
 =?utf-8?B?M0lyclRGaUp4RDhyWmJOMzhYOHNGdTk4NlM0YzhyQ1NJU1BuZkFpSDlQeGd5?=
 =?utf-8?B?OXN2OHpKRXViK2d5THJKT1ZvV0RobW16WmJSVFpHdW1hd05sZkFXWWJMdno2?=
 =?utf-8?B?WGFLYS9MVk81Slg5dVJuM0JKSFpFa09GMjB2NkNDMEJpMklHeVdCZnNVU3ho?=
 =?utf-8?B?eDEvZGNTa0ZGYWVoRE92M0ZoTkVYS2VDWEkzWE5samw4a0tpVktvTTNsbDZs?=
 =?utf-8?B?L2JTa1YvZW16SWNMZ25CWE9ONWhhV1dvSWw2SkQwYi9OVGxNV2dzREdOK2h4?=
 =?utf-8?B?blhZaXZBUXF6bFB6NHpraEZ6amJDT3I3VUJVQ0FPdmYveFl0VG1WYyt0Szd4?=
 =?utf-8?B?QjFHNU8wd003Wm0xemFmSmRTem4vNXBzS3pOZlU4RTZmSGxZYWtqdzZFeGxt?=
 =?utf-8?B?MDR3MHowSmN0L3RacDBDWHJiZlYzMXZYMDhWZE1CdWNuQjN4dWlSaFA3WGM4?=
 =?utf-8?B?clZNcm1wdVNLZU9CSHY1RFR4c1l1VmRwZi8vYlZBK3dGeCtVMktlMUFocDBW?=
 =?utf-8?B?d0pkeEpCQ3NEY2M1N1prYXNOb2pwdVJmYzdNcUNTMjU4WGJ0b3B1NnBtKzUr?=
 =?utf-8?B?bmtSNHZCM1ZLMFJhZ1pNQ2RvbkJCSUZrSm5VN24rNGlSY1lKeXd1ZTlTWnBu?=
 =?utf-8?B?RzZncFJQUlRkSnhqSUpyNngxdmloWGZYT1UzWHBML1Njdzg0WjhwdlRmbEc2?=
 =?utf-8?B?aFV5R0lRR21aSSsyWlBxOGw0bWxvUlVSS3RZWndWeWpxUmZldUNTWlJlVnln?=
 =?utf-8?B?bjd2QTdyTmErUXludVk3K3pFYnBhQjJJNUhPQnlqcUFOV1cvdUt5aDFlUlp6?=
 =?utf-8?B?VEpvTjBRNmducXB1Y0lmcDc4YVRjODZYY0I3LzdWd2FJR2k1SFR0Ykt2Y0Vk?=
 =?utf-8?B?NTFXY2xXbzJ6ckl4SEEreFYyWVNFdDI4dGk4YlJUVDBZVmtlMThiWWFqRHVU?=
 =?utf-8?B?QTYvaTM5YmlaZ2pCZThlUlhrWlFURTRKeWhvL0JhQnpjdjY3ck9PQ2VIc0tX?=
 =?utf-8?B?TXNXR1dEVkxNY2I5dTBHQm1lQTM2OFJpcjV0Nk41eXhDQnB6MFVhdTlDZElq?=
 =?utf-8?B?eENINmd6YlQ3bllpb2dYMCtadm54SU5NTDg0biszVXBHczRreFZaZGhBbnN3?=
 =?utf-8?B?NitqZkxpMzRXTkN1dVV3M1pCekI2cWNLN1E4dUlmU0RadEhZSjhqNE5xamJZ?=
 =?utf-8?B?QzA2anVVckNSd1Rxck50V01mV056OVFPQmpqNVhoYlJUUXJKUGhVa2MvREJ5?=
 =?utf-8?B?N3ptaU42MVRaMHVhemFwT2JtQy9NK1NrejAybWNjb0VuL0wzZkFSd0NiZ1Nv?=
 =?utf-8?B?RmNaRVJvU09HZU9YN0hsY3ZSd1doaXFXcm9RWTBQREc2ZFlFOTErNk1CUEZH?=
 =?utf-8?B?c2lpUWpZTUd6WjloM0JHUWtFeDYrckJ3ZGZPaS9qdkFWaU4yZXFYb3BxN3pq?=
 =?utf-8?B?eC9VNU5PUnF5YmNLblN3ZTk3NnBIOHcrUGFsSjdHcGw0RS9BdWI0bDBYUnRN?=
 =?utf-8?B?alV1emVVRlVlVVJTNGJza01KVm1ZemNseEdFRlNMcHJFTlpDYVlKUitUSW1L?=
 =?utf-8?B?Y0E3bHk5eGwvVWhKZnNOanVORGdDVnVXZWhsLzdoeUgyR2JZS0xTTnJsUTFM?=
 =?utf-8?B?YWx1OHdMK2RaZy9jVVBqVjBBZjN4TWVuVUJKMmcveTNjZlpzSW42RGNTSXVa?=
 =?utf-8?B?N2gzOTRYVk1Ua2I0d0lHMWRKVFQ1VldERXhzZ1lnb1RZMTc5TitMdz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed21f99e-d212-479d-fd35-08da1d7b5c77
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 18:28:09.9021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8fzpHw4jpWXTJik7cJMni9nQ3H+tysI1IhRd0mLdVGz8IYvEgvpBRx8YgeIji9AaC1myxz+I1Dy1cRy/S5BeDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1497
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-13_03:2022-04-13,2022-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204130090
X-Proofpoint-GUID: 1Q684CHdJmOAJpoKzZJlTMtF7hqin3UV
X-Proofpoint-ORIG-GUID: 1Q684CHdJmOAJpoKzZJlTMtF7hqin3UV
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 4/13/22 5:55 AM, Bruce Fields wrote:
> On Fri, Apr 01, 2022 at 12:11:34PM -0700, dai.ngo@oracle.com wrote:
>> On 4/1/22 8:57 AM, Chuck Lever III wrote:
>>>> (And to be honest I'd still prefer the original approach where we expire
>>>> clients from the posix locking code and then retry.  It handles an
>>>> additional case (the one where reboot happens after a long network
>>>> partition), and I don't think it requires adding these new client
>>>> states....)
>>> The locking of the earlier approach was unworkable.
>>>
>>> But, I'm happy to consider that again if you can come up with a way
>>> of handling it properly and simply.
>> I will wait for feedback from Bruce before sending v20 with the
>> above change.
> OK, I'd like to tweak the design in that direction.
>
> I'd like to handle the case where the network goes down for a while, and
> the server gets power-cycled before the network comes back up.  I think
> that could easily happen.  There's no reason clients couldn't reclaim
> all their state in that case.  We should let them.
>
> To handle that case, we have to delay removing the client's stable
> storage record until there's a lock conflict.  That means code that
> checks for conflicts must be able to sleep.
>
> In each case (opens, locks, delegations), conflicts are first detected
> while holding a spinlock.  So we need to unlock before waiting, and then
> retry if necessary.
>
> We decided instead to remove the stable-storage record when first
> converting a client to a courtesy client--then we can handle a conflict
> by just setting a flag on the client that indicates it should no longer
> be used, no need to drop any locks.
>
> That leaves the client in a state where it's still on a bunch of global
> data structures, but has to be treated as if it no longer exists.  That
> turns out to require more special handling than expected.  You've shown
> admirable persistance in handling those cases, but I'm still not
> completely convinced this is correct.
>
> We could avoid that complication, and also solve the
> server-reboot-during-network-partition problem, if we went back to the
> first plan and allowed ourselves to sleep at the time we detect a
> conflict.  I don't think it's that complicated.
>
> We end up using a lot of the same logic regardless, so don't throw away
> the existing patches.
>
> My basic plan is:
>
> Keep the client state, but with only three values: ACTIVE, COURTESY, and
> EXPIRABLE.
>
> ACTIVE is the initial state, which we return to whenever we renew.  The
> laundromat sets COURTESY whenever a client isn't renewed for a lease
> period.  When we run into a conflict with a lock held by a client, we
> call
>
>    static bool try_to_expire_client(struct nfs4_client *clp)
>    {
> 	return COURTESY == cmpxchg(clp->cl_state, COURTESY, EXPIRABLE);
>    }
>
> If it returns true, that tells us the client was a courtesy client.  We
> then call queue_work(laundry_wq, &nn->laundromat_work) to tell the
> laundromat to actually expire the client.  Then if needed we can drop
> locks, wait for the laundromat to do the work with
> flush_workqueue(laundry_wq), and retry.
>
> All the EXPIRABLE state does is tell the laundromat to expire this
> client.  It does *not* prevent the client from being renewed and
> acquiring new locks--if that happens before the laundromat gets to the
> client, that's fine, we let it return to ACTIVE state and if someone
> retries the conflicing lock they'll just get a denial.
>
> Here's a suggested a rough patch ordering.  If you want to go above and
> beyond, I also suggest some tests that should pass after each step:
>
>
> PATCH 1
> -------
>
> Implement courtesy behavior *only* for clients that have
> delegations, but no actual opens or locks:
>
> Define new cl_state field with values ACTIVE, COURTESY, and EXPIRABLE.
> Set to ACTIVE on renewal.  Modify the laundromat so that instead of
> expiring any client that's too old, it first checks if a client has
> state consisting only of unconflicted delegations, and, if so, it sets
> COURTESY.
>
> Define try_to_expire_client as above.  In nfsd_break_deleg_cb, call
> try_to_expire_client and queue_work.  (But also continue scheduling the
> recall as we do in the current code, there's no harm to that.)
>
> Modify the laundromat to try to expire old clients with EXPIRED set.
>
> TESTS:
> 	- Establish a client, open a file, get a delegation, close the
> 	  file, wait 2 lease periods, verify that you can still use the
> 	  delegation.
> 	- Establish a client, open a file, get a delegation, close the
> 	  file, wait 2 lease periods, establish a second client, request
> 	  a conflicting open, verify that the open succeeds and that the
> 	  first client is no longer able to use its delegation.
>
>
> PATCH 2
> -------
>
> Extend courtesy client behavior to clients that have opens or
> delegations, but no locks:
>
> Modify the laundromat to set COURTESY on old clients with state
> consisting only of opens or unconflicted delegations.
>
> Add in nfs4_resolve_deny_conflicts_locked and friends as in your patch
> "Update nfs4_get_vfs_file()...", but in the case of a conflict, call
> try_to_expire_client and queue_work(), then modify e.g.
> nfs4_get_vfs_file to flush_workqueue() and then retry after unlocking
> fi_lock.
>
> TESTS:
> 	- establish a client, open a file, wait 2 lease periods, verify
> 	  that you can still use the open stateid.
> 	- establish a client, open a file, wait 2 lease periods,
> 	  establish a second client, request an open with a share mode
> 	  conflicting with the first open, verify that the open succeeds
> 	  and that first client is no longer able to use its open.
>
> PATCH 3
> -------
>
> Minor tweak to prevent the laundromat from being freed out from
> under a thread processing a conflicting lock:
>
> Create and destroy the laundromat workqueue in init_nfsd/exit_nfsd
> instead of where it's done currently.
>
> (That makes the laundromat's lifetime longer than strictly necessary.
> We could do better with a little more work; I think this is OK for now.)
>
> TESTS:
> 	- just rerun any regression tests; this patch shouldn't change
> 	  behavior.
>
> PATCH 4
> -------
>
> Extend courtesy client behavior to any client with state, including
> locks:
>
> Modify the laundromat to set COURTESY on any old client with state.
>
> Add two new lock manager callbacks:
>
> 	void * (*lm_lock_expirable)(struct file_lock *);
> 	bool (*lm_expire_lock)(void *);
>
> If lm_lock_expirable() is called and returns non-NULL, posix_lock_inode
> should drop flc_lock, call lm_expire_lock() with the value returned from
> lm_lock_expirable, and then restart the loop over flc_posix from the
> beginning.
>
> For now, nfsd's lm_lock_expirable will basically just be
>
> 	if (try_to_expire_client()) {
> 		queue_work()
> 		return get_net();
> 	}
> 	return NULL;
>
> and lm_expire_lock will:
>
> 	flush_workqueue()
> 	put_net()
>
> One more subtlety: the moment we drop the flc_lock, it's possible
> another task could race in and free it.  Worse, the nfsd module could be
> removed entirely--so nfsd's lm_expire_lock code could disappear out from
> under us.  To prevent this, I think we need to add a struct module
> *owner field to struct lock_manager_operations, and use it like:
>
> 	owner = fl->fl_lmops->owner;
> 	__get_module(owner);
> 	expire_lock = fl->fl_lmops->lm_expire_lock;
> 	spin_unlock(&ctx->flc_lock);
> 	expire_lock(...);
> 	module_put(owner);
>
> Maybe there's some simpler way, but I don't see it.
>
> TESTS:
> 	- retest courtesy client behavior using file locks this time.
>
> --
>
> That's the basic idea.  I think it should work--though I may have
> overlooked something.
>
> This has us flush the laundromat workqueue while holding mutexes in a
> couple cases.  We could avoid that with a little more work, I think.
> But those mutexes should only be associated with the client requesting a
> new open/lock, and such a client shouldn't be touched by the laundromat,
> so I think we're OK.
>
> It'd also be helpful to update the info file with courtesy client
> information, as you do in your current patches.
>
> Does this make sense?

I think most of the complications in the current patches is due to the
handling of race conditions when courtesy client reconnects as well as
creating and removing client record (which I already addressed in v21).
The new approach here does not cover these race conditions, I guess
these are the details that will show up in the implementation.

I feel like we're going around in the circle but I will implement this
new approach then we can compare to see if it's simpler than the current
one.

-Dai


>
> --b.
