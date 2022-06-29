Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518825607B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jun 2022 19:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbiF2RtK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jun 2022 13:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiF2RtI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jun 2022 13:49:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4A0294;
        Wed, 29 Jun 2022 10:49:07 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25TFEIXR018657;
        Wed, 29 Jun 2022 17:48:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=lz6FIOfXeMPBzHsO6QA9zcMLNJGtMiscmlnpHITQDXg=;
 b=tRytM+3qAxCOxnWgmyq7V3MZNKt/XX3Tt8OHzpYK4XZ/4/JeRHYYr+JLotYK4G0cs9TS
 BTkUtRP4wIkdkNBFJFWKcrmEQyhehXOZwoBxzgG9li8KydGb5DMsRTUd4UeKLIV6jHNu
 u4RWuR2Qg8FjV29QzjCA3WU7d7jcJ5Y4AN6rFXMyJMxDSv0M7JBWyMiLNoDwah9p55yi
 sEAAJEDWhuAAghmKh0kPoPe26+/35Ernldy8IupAnnA7z9yzvx/C9Go7+kFddXmLGp0L
 ZxFy0HD13pMz8OReQvOPkVlmE5VDQHzgAD9jKPkj85e9sE77v9sOCvcxIRNbxC9KN61F tA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwtwua17p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 17:48:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25THUxmq039766;
        Wed, 29 Jun 2022 17:48:24 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrt3qv0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 17:48:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnGhtdvGfD4DxnRa6GRemyL0nyP0vNjUE58FL6xyViuHEofpSEdW5wXG7DDhMkl2SXQQH17Jf/Us1uqUBXFm0VMzk2K5qQQ1UEYO4m8T2YaIbHkCn0WQ1l2SFq42qCNO/+N5r21tiYVk+3X8076gNI5A5pCmfi9dpCEGE23z6T2vmX+HFtKfE2yerXleoXx+TetepUR2qadfU7CTaZleNyv0oHkEPAC/eyMWAxD9RNaKDX/bMCInKmSIrDyASTuBAHmRJmGpG0hyfylZ+QaFVZcnBcK0TiVCXdejlxAD4AnhL4KhYgyIGQGxS0HcqlSZbUW2B5iJeTT0ZIr0tbLr8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lz6FIOfXeMPBzHsO6QA9zcMLNJGtMiscmlnpHITQDXg=;
 b=fFQGoWM/2m5P+OTZ1xOYdAVl2JWD7SlUEPuI9kyG4kFZISNRzBeju4k+foCirG04bwpGK/MFbAEU/An4c3sw+9Og0FJ3s7hQjTVjHH1wyR1Q3QhH6+eSC0JsnKOmxzUTOFKFhPeI7Dnf5309ZO5zA8h6Q8TDpzDgdJ9j+Iyp/7N3dlYz6qdiA6u/l9rFYcuv39REMQQInIZ04PQdUqqpzKb7+j7rw7PlLb3nHIIS1UqgmWw4uJaPY7/ZjAZWtbxF07vElkWKX8yVPhE9Gc81VkIdOCHCPhex4E6EP2eUmGYLMEW/QWDjhM0vk/YOfoz6CXjswsPRxGC+wd+7SLTFqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lz6FIOfXeMPBzHsO6QA9zcMLNJGtMiscmlnpHITQDXg=;
 b=bJ4PzEFxsoweKn8eDsfSWMkaAumkG9a4sAn0GFByRYBb2D8k8PcvW1gCs3vFOtMNC9vAjSJv4Vhv6JbkKPdLme9oBd9qaMZvM47KcZMGF45yBmx5EQ0ePSApOsK2hmSa9Bx9BgGb3Qlt7a8iC52LGbZwk2sl2KQFXuvjNrV3JcQ=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by BL0PR10MB2786.namprd10.prod.outlook.com (2603:10b6:208:75::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 17:48:22 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2%3]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 17:48:22 +0000
Message-ID: <8bd15f25-a468-e495-25f2-a8657b308bbe@oracle.com>
Date:   Wed, 29 Jun 2022 11:48:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1 00/14] Add support for shared PTEs across processes
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Barry Song <21cnbao@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        ebiederm@xmission.com, hagen@jauu.net, jack@suse.cz,
        Kees Cook <keescook@chromium.org>, kirill@shutemov.name,
        kucharsk@gmail.com, linkinjeon@kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, longpeng2@huawei.com,
        Andy Lutomirski <luto@kernel.org>, markhemm@googlemail.com,
        pcc@google.com, Mike Rapoport <rppt@kernel.org>,
        sieberf@amazon.com, sjpark@amazon.de,
        Suren Baghdasaryan <surenb@google.com>, tst@schoebel-theuer.de,
        Iurii Zaikin <yzaikin@google.com>
References: <cover.1649370874.git.khalid.aziz@oracle.com>
 <CAGsJ_4yXnmifuU7+BFOkZrz-7AkW4CDQF5cHqQS-oci-rJ=ZdA@mail.gmail.com>
 <55109e8f-29b8-4016-dcee-28eb8a70bd12@redhat.com>
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <55109e8f-29b8-4016-dcee-28eb8a70bd12@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0011.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::24) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e48fc51-3bde-4f73-1c0c-08da59f78f61
X-MS-TrafficTypeDiagnostic: BL0PR10MB2786:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7d9KLIXNDLV4JMdi9DnDeXUJvqaoo5M3IKaIowG2vhvjkLIHEGoq8ZimV63KQdNJ5vmcLMMlbYxVcf6iFVB1vm8VYTIC5kUg0jAqk9SHz284nh/oJuFXbhA4on6YIZ2zG6+Aru8BC/jhcPupPKvHlfxHLwpnVyp26CnRnYAHUpVvRbP7iy0Zs9iAC8ZqPcnaxy4TfV7u0qPy+T+IGJhVxqA08uEeOq+UiubarimMbc+nfo5rh7kmM2gm3MNSw9oBbcHYVNgWl8L+APbq/bh1C3+EDfZ7XV21TePzUykL0VMUm62O68n+URAHNWU3p6R+7szm9WKRtPG0kmx5Q0VN9cSeoy59xO91BwYikuwzfVeGXEmz84qx/40HweGlxLCZTtTJZgVHAjWgBTuGWj/3RqQP+Jdlc3nkkZMcyNG1Vu3x22olkCrjRVg8nkkihSyN944Xu8RCb82sjTShqScfIBgcaky0AUC97B9NlefZOpM32PLCV5z32loxbH+l7A5zx/YXnRGwN8elOKNDBzPUnuormSYQWACEbcwYUBgdLh6KstsZSFRDEyw7S8Z5uUDbR8Dc/2PUcvRuXVaCk+IugEkIfioNJyAP2BWE7vt+rIuqRbpIChISIsC4+7fhi3BexiF8DNI2uS9i/MCPZwF98vV9NmEjZmxoWbn5mi54DsOzfe74BDxYDfLJARnU/sZ2M3B9ZpttAOddHFRC6E37Do0h160ZXEwZnp74LVpPWvAgRC2jJP2mvgGqX0Fw3aTJ910DlfwcD/iosCVb9aYhUpWBh68p8YSQj7E+lcgHPAReSpB8VY0TV6I+B7RfriNr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(346002)(376002)(396003)(39860400002)(2616005)(31686004)(6512007)(36756003)(54906003)(66946007)(66556008)(6486002)(186003)(8676002)(4326008)(110136005)(66476007)(316002)(53546011)(83380400001)(38100700002)(41300700001)(44832011)(6666004)(6506007)(86362001)(31696002)(478600001)(2906002)(7416002)(5660300002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmtFMDNlcjEyME9CU21XRGJ6b2RlRXNJSGxOajlTUnJFR0hxNEhxTkJlZFRB?=
 =?utf-8?B?MkJYSDFvbEJjMGU3a0cwbnhUMXB4ZkFLSWNDYTVEcWxIK2FOODBPMEkzN2c0?=
 =?utf-8?B?YS84WXpKU3VZYnQzY3ViaVNaWmhPRFVBSU1iNlgvUVljaW1Odndsek8vODFV?=
 =?utf-8?B?THpyWTBpa1lZdXBVd0IrbnRRVkpyOFBYRUpQSUgzZmRMVmFjMUpqVk52UUs1?=
 =?utf-8?B?aTJHUGI2SlVQM2MwRk9XdVpHVzhlb1JkbjVuczR6TEpZTm9rbFByK2RMV0tv?=
 =?utf-8?B?akdwNndmQlh1UytsOStsQ3doVUU3TWp4eFhYY3VXb242ZHlWN3YvbktkNDhK?=
 =?utf-8?B?T3JOdEJFelVGN0NUNG9lNlRRSUNzV1lMcTNLV25NN2MrY0ErT3EwNTJWRUEw?=
 =?utf-8?B?MnRrMUIxNkhJMTFjbG9vdC9nZ0psSk5ORk8yT3M5OENoZCtNV2ZIU2ZIR0NJ?=
 =?utf-8?B?ZVNxMURqZWpiaGZ3WXo1UDNlQUVJMHoyaFpGQ21pME5nYlVOWGpaOUM1WWF6?=
 =?utf-8?B?RUVtU2VvKzRvZDFnMjQrSDdXaW5zYjdoRlFSNkxJdG9adktUN1JOa1F4d1pm?=
 =?utf-8?B?MlZGNWNKd0VTYjNHU2JaaHpaQWFzM29JVU1oVVA0WXhSQjJDNVp0MTVBMEgy?=
 =?utf-8?B?ZFk0SHNRUXlCRmFIZVVzSGEzR0p5dm5xUWZXaTA0UjdPbmZNY0JOamZWd3dn?=
 =?utf-8?B?QjE4emVJdHdBd3B3K1J4ajJiZ1JJRGw5enpJUW1yYmNtSytaS1hrZ2dNYmw1?=
 =?utf-8?B?UDBoRnMrcFR0V29OcHo0c2dxYmtUc202UkJYemozblR4WDZYQWNIVG5GNjhp?=
 =?utf-8?B?a0Y0R0c5bjNjUlNvRG1meC9EL3hRSmJQNlNNZkRwTmR6WnVSNGgva1p6L3pl?=
 =?utf-8?B?N1lsS1M5ZUE0NDBaWlA5M3M0djd0c0JBc3NVeEphREpwcWhnUGZKT1A1b1Jw?=
 =?utf-8?B?TmwwRmNreWVJTGhwVVpQUnVwNFpkRXlDVEd5L3ducWpoZDkySU1BMUJJcklN?=
 =?utf-8?B?TEFNWGxva3pSajBxc0ljRXdNVFRPV0J1Y05xNDd4alJnekR3SVRPUDllYUVu?=
 =?utf-8?B?WENxeTBXUEI4L1didVorbERkWkRNcjJqMkw5NUZrR2NicS91Znk2cW5kMDlR?=
 =?utf-8?B?Y0s3OGhLYVhOdmFFbDU5a0FOWG9iL0NiRENJZ0c0bnROUUIrbzk2TGc4dFN4?=
 =?utf-8?B?emFyOE5TMFRnNXpISFJUa29sZTR0R2FwaksxVlpyTjdoU25RcE9hQVRYYWZ0?=
 =?utf-8?B?ckJyWkZrNFZrcUNXc1ZYOWJNWVU4ZEV2Q0Q2VnZoak8rUEY1SFpTZGZSMnlj?=
 =?utf-8?B?a1NGWXlRdXYzdWhyVVVUazBPdUR1dzJaanNIRWhjRkZITmkrUGpCTVR2bmhY?=
 =?utf-8?B?MkFLdCtUWXp5OWJ6c3I4WDlKaXNTSHJydXhZdEkxbE5lelNhdjEvV1N2eUgw?=
 =?utf-8?B?ZDRPQmxSRnhnbXRIMlhKVFpONGloUFROYlJaS3ZlMzBJRDlPQnViNWxXcmlP?=
 =?utf-8?B?bGl5TVFJZTUwK1c4UitzOVhacTdRMlZMcmJlR0Zqcnk4NUMwcy9PQ2IzdHJU?=
 =?utf-8?B?eG5odGx5bVJhVC9yK0FqUGRrRitJamRxVmtXcG52V1c4S1FZVGV6MTJRRzhq?=
 =?utf-8?B?S2hMcEhZWXpFTzdkNGNvTDFnS1dNNWJNVENqTEpUT2hBR0t2ZXlQaENnNmUz?=
 =?utf-8?B?TVFaeWgwNlR2dnBRTW1pQTVJTWpXZjREK3RXNWJBdXhWUWFsQklreUZ3OGhy?=
 =?utf-8?B?dHZoSzlQcTQwNjFTL1huQVh5OWlNRlRQOFhxeTFVb2dka0RobUsvaHlDYVJR?=
 =?utf-8?B?dWZ3WWZxUlU3OUVaQm5yeHpzRy9FVEVTbkJvUGF6eXdsUEtrT0VsRzhPNGtG?=
 =?utf-8?B?UGl4T0t5OXZrOUNtR2JsMjY5SS83SG9wTTduZG92dStxUVNuNnpoQkJVeWth?=
 =?utf-8?B?SUNPTzlnQUtwSHZYYXdHOEtrWGR6L01ROUlZVlJnbDlwS2t2ZXkzdDdJZEV0?=
 =?utf-8?B?OVM2N3VYMW1uTlBhNi9SOUlHd3lYMFdNSTZsenBlQnZha0tONzc0b001RnhJ?=
 =?utf-8?B?aS9EQmMrWkpUVlYzSHZlSEZCS2dVaWRPcEZCcFNPaTBaVWdKVUlWMmR0Z1A4?=
 =?utf-8?B?azhhbDUwWFErMWR3VFVIaU41YWhMcDlJZm52bU1QYXVFVmVBVFgvV3Bpa3ZZ?=
 =?utf-8?Q?LTPwLvvlaUwdC971Ab1qFn8s0dmVSokxh0+UaaJgdzYM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e48fc51-3bde-4f73-1c0c-08da59f78f61
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 17:48:22.4896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lVAOMGm91xWJKOnx7nP+VNc78tKEzYOdi6Jbhn6WKXBJea1c7ZRT3LWCegfg8pgx9HP8vtKBnX+GcVmbbvgahA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2786
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-29_18:2022-06-28,2022-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206290063
X-Proofpoint-ORIG-GUID: 6WVrMhsgUZgI1nHMdOSfScJuf-hWbSpV
X-Proofpoint-GUID: 6WVrMhsgUZgI1nHMdOSfScJuf-hWbSpV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/30/22 05:18, David Hildenbrand wrote:
> On 30.05.22 12:48, Barry Song wrote:
>> On Tue, Apr 12, 2022 at 4:07 AM Khalid Aziz <khalid.aziz@oracle.com> wrote:
>>>
>>> Page tables in kernel consume some of the memory and as long as number
>>> of mappings being maintained is small enough, this space consumed by
>>> page tables is not objectionable. When very few memory pages are
>>> shared between processes, the number of page table entries (PTEs) to
>>> maintain is mostly constrained by the number of pages of memory on the
>>> system. As the number of shared pages and the number of times pages
>>> are shared goes up, amount of memory consumed by page tables starts to
>>> become significant.
>>>
>>> Some of the field deployments commonly see memory pages shared across
>>> 1000s of processes. On x86_64, each page requires a PTE that is only 8
>>> bytes long which is very small compared to the 4K page size. When 2000
>>> processes map the same page in their address space, each one of them
>>> requires 8 bytes for its PTE and together that adds up to 8K of memory
>>> just to hold the PTEs for one 4K page. On a database server with 300GB
>>> SGA, a system carsh was seen with out-of-memory condition when 1500+
>>> clients tried to share this SGA even though the system had 512GB of
>>> memory. On this server, in the worst case scenario of all 1500
>>> processes mapping every page from SGA would have required 878GB+ for
>>> just the PTEs. If these PTEs could be shared, amount of memory saved
>>> is very significant.
>>>
>>> This patch series implements a mechanism in kernel to allow userspace
>>> processes to opt into sharing PTEs. It adds two new system calls - (1)
>>> mshare(), which can be used by a process to create a region (we will
>>> call it mshare'd region) which can be used by other processes to map
>>> same pages using shared PTEs, (2) mshare_unlink() which is used to
>>> detach from the mshare'd region. Once an mshare'd region is created,
>>> other process(es), assuming they have the right permissions, can make
>>> the mashare() system call to map the shared pages into their address
>>> space using the shared PTEs.  When a process is done using this
>>> mshare'd region, it makes a mshare_unlink() system call to end its
>>> access. When the last process accessing mshare'd region calls
>>> mshare_unlink(), the mshare'd region is torn down and memory used by
>>> it is freed.
>>>
>>>
>>> API
>>> ===
>>>
>>> The mshare API consists of two system calls - mshare() and mshare_unlink()
>>>
>>> --
>>> int mshare(char *name, void *addr, size_t length, int oflags, mode_t mode)
>>>
>>> mshare() creates and opens a new, or opens an existing mshare'd
>>> region that will be shared at PTE level. "name" refers to shared object
>>> name that exists under /sys/fs/mshare. "addr" is the starting address
>>> of this shared memory area and length is the size of this area.
>>> oflags can be one of:
>>>
>>> - O_RDONLY opens shared memory area for read only access by everyone
>>> - O_RDWR opens shared memory area for read and write access
>>> - O_CREAT creates the named shared memory area if it does not exist
>>> - O_EXCL If O_CREAT was also specified, and a shared memory area
>>>    exists with that name, return an error.
>>>
>>> mode represents the creation mode for the shared object under
>>> /sys/fs/mshare.
>>>
>>> mshare() returns an error code if it fails, otherwise it returns 0.
>>>
>>> PTEs are shared at pgdir level and hence it imposes following
>>> requirements on the address and size given to the mshare():
>>>
>>> - Starting address must be aligned to pgdir size (512GB on x86_64).
>>>    This alignment value can be looked up in /proc/sys/vm//mshare_size
>>> - Size must be a multiple of pgdir size
>>> - Any mappings created in this address range at any time become
>>>    shared automatically
>>> - Shared address range can have unmapped addresses in it. Any access
>>>    to unmapped address will result in SIGBUS
>>>
>>> Mappings within this address range behave as if they were shared
>>> between threads, so a write to a MAP_PRIVATE mapping will create a
>>> page which is shared between all the sharers. The first process that
>>> declares an address range mshare'd can continue to map objects in
>>> the shared area. All other processes that want mshare'd access to
>>> this memory area can do so by calling mshare(). After this call, the
>>> address range given by mshare becomes a shared range in its address
>>> space. Anonymous mappings will be shared and not COWed.
>>>
>>> A file under /sys/fs/mshare can be opened and read from. A read from
>>> this file returns two long values - (1) starting address, and (2)
>>> size of the mshare'd region.
>>>
>>> --
>>> int mshare_unlink(char *name)
>>>
>>> A shared address range created by mshare() can be destroyed using
>>> mshare_unlink() which removes the  shared named object. Once all
>>> processes have unmapped the shared object, the shared address range
>>> references are de-allocated and destroyed.
>>>
>>> mshare_unlink() returns 0 on success or -1 on error.
>>>
>>>
>>> Example Code
>>> ============
>>>
>>> Snippet of the code that a donor process would run looks like below:
>>>
>>> -----------------
>>>          addr = mmap((void *)TB(2), GB(512), PROT_READ | PROT_WRITE,
>>>                          MAP_SHARED | MAP_ANONYMOUS, 0, 0);
>>>          if (addr == MAP_FAILED)
>>>                  perror("ERROR: mmap failed");
>>>
>>>          err = syscall(MSHARE_SYSCALL, "testregion", (void *)TB(2),
>>>                          GB(512), O_CREAT|O_RDWR|O_EXCL, 600);
>>>          if (err < 0) {
>>>                  perror("mshare() syscall failed");
>>>                  exit(1);
>>>          }
>>>
>>>          strncpy(addr, "Some random shared text",
>>>                          sizeof("Some random shared text"));
>>> -----------------
>>>
>>> Snippet of code that a consumer process would execute looks like:
>>>
>>> -----------------
>>>          struct mshare_info minfo;
>>>
>>>          fd = open("testregion", O_RDONLY);
>>>          if (fd < 0) {
>>>                  perror("open failed");
>>>                  exit(1);
>>>          }
>>>
>>>          if ((count = read(fd, &minfo, sizeof(struct mshare_info)) > 0))
>>>                  printf("INFO: %ld bytes shared at addr 0x%lx \n",
>>>                                  minfo.size, minfo.start);
>>>          else
>>>                  perror("read failed");
>>>
>>>          close(fd);
>>>
>>>          addr = (void *)minfo.start;
>>>          err = syscall(MSHARE_SYSCALL, "testregion", addr, minfo.size,
>>>                          O_RDWR, 600);
>>>          if (err < 0) {
>>>                  perror("mshare() syscall failed");
>>>                  exit(1);
>>>          }
>>>
>>>          printf("Guest mmap at %px:\n", addr);
>>>          printf("%s\n", addr);
>>>          printf("\nDone\n");
>>>
>>>          err = syscall(MSHARE_UNLINK_SYSCALL, "testregion");
>>>          if (err < 0) {
>>>                  perror("mshare_unlink() failed");
>>>                  exit(1);
>>>          }
>>> -----------------
>>
>>
>> Does  that mean those shared pages will get page_mapcount()=1 ?
> 
> AFAIU, for mshare() that is the case.
> 
>>
>> A big pain for a memory limited system like a desktop/embedded system is
>> that reverse mapping will take tons of cpu in memory reclamation path
>> especially for those pages mapped by multiple processes. sometimes,
>> 100% cpu utilization on LRU to scan and find out if a page is accessed
>> by reading PTE young.
> 
> Regarding PTE-table sharing:
> 
> Even if we'd account each logical mapping (independent of page table
> sharing) in the page_mapcount(), we would benefit from page table
> sharing. Simply when we unmap the page from the shared page table, we'd
> have to adjust the mapcount accordingly. So unmapping from a single
> (shared) pagetable could directly result in the mapcount dropping to zero.
> 
> What I am trying to say is: how the mapcount is handled might be an
> implementation detail for PTE-sharing. Not sure how hugetlb handles that
> with its PMD-table sharing.
> 
> We'd have to clarify what the mapcount actually expresses. Having the
> mapcount express "is this page mapped by multiple processes or at
> multiple VMAs" might be helpful in some cases. Right now it mostly
> expresses exactly that.

Right, that is the question - what does mapcount represent. I am interpreting it as mapcount represents how many ptes 
map the page. Since mshare uses one pte for each shared page irrespective of how many processes share the page, a 
mapcount of 1 sounds reasonable to me.

> 
>>
>> if we result in one PTE only by this patchset, it means we are getting
>> significant
>> performance improvement in kernel LRU particularly when free memory
>> approaches the watermarks.
>>
>> But I don't see how a new system call like mshare(),  can be used
>> by those systems as they might need some more automatic PTEs sharing
>> mechanism.
> 
> IMHO, we should look into automatic PTE-table sharing of MAP_SHARED
> mappings, similar to what hugetlb provides for PMD table sharing, which
> leaves semantics unchanged for existing user space. Maybe there is a way
> to factor that out and reuse it for PTE-table sharing.
> 
> I can understand that there are use cases for explicit sharing with new
> (e.g., mprotect) semantics.

It is tempting to make this sharing automatic and mshare may evolve to that. Since mshare assumes significant trust 
between the processes sharing pages (shared pages share attributes and protection keys possibly) , it sounds dangerous 
to make that assumption automatically without processes explicitly declaring that level of trust.

Thanks,
Khalid
