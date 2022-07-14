Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4ECD575752
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jul 2022 00:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239842AbiGNWD6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jul 2022 18:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbiGNWD5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jul 2022 18:03:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33B31FCD2;
        Thu, 14 Jul 2022 15:03:55 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26EL4GdD032716;
        Thu, 14 Jul 2022 22:02:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=789uiKAKILWPU+knD8unDqnW4ZPz7zCJfC5Rxokg+lU=;
 b=G79Z/3ytTNd2sL1a8zFr0EB0fpGcVD+7JaHqrofilldMfFCPS2UFdiq00roG5UvifSmP
 OVn1UoRVbkZrUmrDm0j4DM9HghBKhg1Lum5m9VqJvS7WH9CL1mMqX/JB12QJytqFzVSO
 hC0A7yP+oCswr1bSCbRei59RlEyrqwCLKHmx1IfoV9XB+WKSKlWdNXtCmrRK8K2DHGQ4
 1gJ9AbThIiGoIovj009G+R+ExIMAbSgWSREbhePdfulKUVNpxK5tUHrGWLYHWhsJHQ4T
 WZLJUPFKeDD9L/LGJ5B1Yt+JVrubKsHpyIo09cPdC4E+ri4M8ML8yKBACRs342oqDNI5 vQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71r1dygm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 22:02:56 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26EM1gFX001745;
        Thu, 14 Jul 2022 22:02:55 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h7046ve2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 22:02:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQFxM8R/TRUWI7ERwPIdq+cPPohb+M8IFrq+1GucmqU9c61XNd9FVOB9RffpcJfxQI5u/erS8mId6XggKs5EqVhV8i++4oFmEYjd8FaFHk5/rc8SFOQvdOJAKZbfJi6xUtvxMLXHkec0HRmlRbeBvFkULDuliLxBnMBPlWHpn+6TMXA1wKvXgmihHHRReKNQV0hkWrWMRcEPceELswOLBsH+be1WaxBKAMAIwjtZYgb7wZfReA/BsG6GlU0s608+/aRuj3Oz9M+kUv41P/uQM8RgeQwFCqhSBRTzyc78eol4wu3Y8Gosmr9lgYF9rxStFZIcwzang6roaY0p2r64DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=789uiKAKILWPU+knD8unDqnW4ZPz7zCJfC5Rxokg+lU=;
 b=kF8rZAiaKPhkh4tXq5rrdHbLYYkdS4eRoPCNLbmi4xE+gmqh1aBiIk+W5R+sYEI0dJNIzwdDhCG5pJsaY8s808CZGa7ddezGJDrEsOgdJyB7o9bC47ubD0gzP4oxLK0RgPYoigOKuiM00kf0FfoECz35aBZOvcQcj6YFZxrlxhNviwrMxHIHJ0y0wvgL7odbSaVP5imw1/9rXtmvFKnl1AhlFand30o7S3F99RuAxu5MAyz0/3BpvsDPwFkfLURSU2rBV/GxoJVo1Qx0/wEU2cTbBCy955VPaIx0TOqgBx81HnOZn6uKmiiG0abAHRK4930q2Hg98TpajiLKU5iGyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=789uiKAKILWPU+knD8unDqnW4ZPz7zCJfC5Rxokg+lU=;
 b=P71tSU3g3Mw+uFUPRVqfUcZWeUL4H57c87osf6ZhGoZXbd9rUOGDaL7rem1dAUaH7VEHlyvNBOrekcCZD4rbC11fM0exrh+apTnYIiRgCV3SfsFsEVT1RqPo8GpGEtsBJsP2kZk2iuGcgn5sfRm2X9VYKRcG+e25T3HEQfZ03+M=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by DS0PR10MB6103.namprd10.prod.outlook.com (2603:10b6:8:c8::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.25; Thu, 14 Jul 2022 22:02:52 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::71ec:3c08:c336:cc55]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::71ec:3c08:c336:cc55%5]) with mapi id 15.20.5438.013; Thu, 14 Jul 2022
 22:02:51 +0000
Message-ID: <bca034e9-5218-5ae4-79df-8c40e0aa6d3d@oracle.com>
Date:   Thu, 14 Jul 2022 16:02:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 0/9] Add support for shared PTEs across processes
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     willy@infradead.org, aneesh.kumar@linux.ibm.com, arnd@arndb.de,
        21cnbao@gmail.com, corbet@lwn.net, dave.hansen@linux.intel.com,
        ebiederm@xmission.com, hagen@jauu.net, jack@suse.cz,
        keescook@chromium.org, kirill@shutemov.name, kucharsk@gmail.com,
        linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        longpeng2@huawei.com, luto@kernel.org, markhemm@googlemail.com,
        pcc@google.com, rppt@kernel.org, sieberf@amazon.com,
        sjpark@amazon.de, surenb@google.com, tst@schoebel-theuer.de,
        yzaikin@google.com
References: <cover.1656531090.git.khalid.aziz@oracle.com>
 <20220701212403.77ab8139b6e1aca87fae119e@linux-foundation.org>
 <0864a811-53c8-a87b-a32d-d6f4c7945caa@redhat.com>
 <357da99d-d096-a790-31d7-ee477e37c705@oracle.com>
 <397f3cb2-1351-afcf-cd87-e8f9fb482059@redhat.com>
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <397f3cb2-1351-afcf-cd87-e8f9fb482059@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR14CA0050.namprd14.prod.outlook.com
 (2603:10b6:5:18f::27) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a0256a6-d883-4fec-fef0-08da65e498a7
X-MS-TrafficTypeDiagnostic: DS0PR10MB6103:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TZgKhGJ6YlTSAGe8R12j/POGYxuQ5/DvDs3NKb8g6QOM7WjIog4dNqA+wGwJtDb8bllZfis1aoM1zO7O6LNZfNWwXtL7rI/1Al0Gu7I+g4GkTRP0A0THUhdJTHDzWmEfsEbrBoh7hQUAQPBPJmLkFsNJ8FOnJSCbfqmYVOx7MaE8WcGCs1C+bqfnJKaLh6G41QRKa1EMDks7sFJPHYWVDKruWw+KVXjdk4WxTYcw+EhykhH0PZau9nOEPHWHwc+n6AUZkfeXn4PBh9tRMFtHpRHDIPQGAjdCjffHtEDTwjI2np8cBXsPmtw1CofrZVGEgT16uREoXh80rc3hVk88QZxZWbnYyAZjJ0s0BxC+ygxNM5bowye+kEEHD4cnInXEmV8/JWwfif6/LWGNszxgz0MdAH7DP5DHGjsudNl/GE0XNcCFs5ZFfKUr8z7lwJq2dkz24TjvF3CD+ddIBdBB49bUt/HFqA7NcQFLuT+XNMljActvCQhC8Uw5mbtJLLcumZH7RuJOew2ZVuWveT41ZUXfAYWD2xMewegAOJHUg/qaWnFnw/73xrnq2tlvvHSAaTcEoCHAyr+JE7T/Rmdl7rZldERJ5dhkW4W91KUXKv5oUz1M6v7QA0tzPfxmivVcQxT/HvpyDrgzUTlOH6juedZd3K8QS2Mt9bvP2oaPIEHUejf7WYOLkpak37mYxSXPI9dA1WvimD0Spz3JCE2VGV+GS0l7BAgRXVTkDsj+2eq0JPBAMBxGLc0McxoMNz5+JY0shhYPEleyAUtrSAAi/MbTBo6irzOhYwkhe5S5ghKCQVhOX34u8WdopIETG+jw3v1AO8k3rTZKa93clopFxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(376002)(39860400002)(346002)(136003)(31686004)(38100700002)(44832011)(110136005)(6636002)(2906002)(7416002)(36756003)(2616005)(478600001)(6486002)(186003)(316002)(86362001)(31696002)(83380400001)(66476007)(26005)(6666004)(41300700001)(6512007)(66556008)(53546011)(4326008)(6506007)(8936002)(66946007)(8676002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjFXdmVxVkt1VXZhN0EwODg2LzVCcDhrMDc5QjY1d2RweEpWMndxMnU0dHpF?=
 =?utf-8?B?ZFF4RW9UUi82b3JoYng4Q1NOcjAvdWcwMHo2ZTdzTGI3VlY3Y2tLTkdEQnBI?=
 =?utf-8?B?TkRBcG53SlAwR0RVSys1eSt0dUNWS0dlai82Vm9QdHRDT0dObnZmb0dFUmsy?=
 =?utf-8?B?VXhSVWRZbzVjUGl5bWxWTVR1a2VibllMUFB5ZzFRUWRUOWZoNWxqOEVyWnNa?=
 =?utf-8?B?M3ZFNVAzZUpjcmI5V2ZQV0NsNDUvS1ZMajhpODZCVnpCVEVQb1NHQTFab0dj?=
 =?utf-8?B?RWZiaXZ4dC80MTFKZXhyVDJwS2NzSHNEMWZoeE40R05oS3h6N05hL2JndFgy?=
 =?utf-8?B?T0gxcmZPNGF6NENPUnUwd3NpSnpyamVhOGY1MThUYm5PSzQyYlRqaWp5UFZz?=
 =?utf-8?B?Z05jR1lvSmo5QmJ5b1ZkVFJzeFRPckhESERpdU5vT1I1NEVzZ0dVRjNkcW54?=
 =?utf-8?B?M01hcHFIa1EzU1U5djg0RUlMUU5ERmZDRU4ybVUvMU0vVHdlSHdDSHJZYkdX?=
 =?utf-8?B?aFpLQ3N4a3h1aThDTExIend4cGtnRlJFSC9qdTJvbXRVZkFhOThnVmtQeGQ2?=
 =?utf-8?B?TnJnNmcxcTVXU1RGL2xhT1I4M09tOTFjU0ZTRzFqTVJmU0lIUnp4MHpqYko3?=
 =?utf-8?B?MEhydVZIdFl1aEwrMzlHeVloSTI0dW0vcHk1WVl5RS9wS3dpVTE5eVRmd2Uw?=
 =?utf-8?B?ZmVwSXlUeGVwdDZkTXQydmV5UzNtRHhtWGprN0xvU1hvREMvelkyVzlBQ3NZ?=
 =?utf-8?B?ZHl3dm9VQzdRbGxzVEhwbWdvSFg4ZVNJMHRwTTJvQ2hEa1lRNmxCZURZL21V?=
 =?utf-8?B?UkM3bFUrMnhpWFhnbXVLbG9VaWcxdTVrUHdYajc3Q0hPZjZ0VUgwSkI5d3M3?=
 =?utf-8?B?M3J0VFgxQ0V4SzczUmpueUdGakhHajB4VVNSdnRsODhDRk5lTjUvQ1hKd3NY?=
 =?utf-8?B?Zm1uakJLSnc0UTlOYjlVS3Z5Vm9adjBXQTZ6VWF2RS9Vc1JETU1CMHg5dWEw?=
 =?utf-8?B?TGkvd1YvRThFdXhmODRiK3R4WVlIWUdlQ1I4WVJ5V1JjQmlscGFKYzBWQmx0?=
 =?utf-8?B?V0V5bHROL09HTytHQ2FCSlFjeTNzbXhqOXhIWElYcmRsOTVtSXFuYzF5VGVs?=
 =?utf-8?B?ZHA5czkzcHpiMDVjczB3QS9PT0R0OHF4MmdhRjBmejQwRENRRWFseVBzUkdI?=
 =?utf-8?B?b1EvcE1qOGloMURZVFN5djJ0cEo0cWQzSUlnNE52R3k0QlhoV2U2dnNmQjRW?=
 =?utf-8?B?aS9OcVJrcnpXRitOTVpVYjJLM0E3cGJZcC9ybkQwSUtFaEp2UmQxWm1TOEZ0?=
 =?utf-8?B?dlRHbkVpOEIzUGticW94TWI5K0E1eXdLVEVBZXFmOGMzVEV0cXMxeGY3VkYy?=
 =?utf-8?B?WHUwMXNrRCt3eTJEVTFZSzNmMGRHMzUwVExrNU1VdHVSNzNJcmhsa05RUFNZ?=
 =?utf-8?B?T2JrckhsUTg3dGJWU3U1YVVuckVwWE1LM1gxVEhJMWsrYmlvaW1jZkZIcXdQ?=
 =?utf-8?B?d2dGb2NLcURsMC8wYy9HME1aYUZVcUxGK0tUSmZPN0dxd2h5UXptd0xyRUw3?=
 =?utf-8?B?QjlUTXpZVUNSbXJiclJ2NFBhdmFOcGk3ZENkdVQwcVRrOEpabVkyNDhLNVBo?=
 =?utf-8?B?VjFGZ2NKV0FKOGtKT3F2UGNMM2ZDSmNZWEM0NFBvcWtSYUJXL1RXS1owaXN2?=
 =?utf-8?B?M0VOckphWW84dWVxc1dRc1B0YlhIYlhGMHExbUxHTVJiUDRXK2VMa215MXRY?=
 =?utf-8?B?d3dFcFVUUDdkZFk3ME1YZU1MY3lIWUFvS3gyYlprNTlnSmhGeTAxQk5lS2NW?=
 =?utf-8?B?Sk5yR0lSdStuTHBSSzdPZnJJM1RVaU96UDVVSUFLWU1CUEhBYUdNajJBSzNE?=
 =?utf-8?B?dHVHMGpVOEo3bXRFOWVXMVc0RTNHblJrcHdYUUVGY2FnUHRoODFNWnZzdEJG?=
 =?utf-8?B?ZFUzb1E0SVdpR0p4c0U4RmFPQStYOTVVZjFyWmwxZG1xVERDWVlRbFdtMEhl?=
 =?utf-8?B?aFVkOXMzNTc5Rk1aMTVHL0NBNkJlWXVlWGJDSnBSaW5QckkyeVp1aXRKVHJU?=
 =?utf-8?B?NGJ5Y0ZvOXplWGxSelhQNXdTL3Bjc0d6U09QMkpnTFJwUjhDei9qdlZQK2hD?=
 =?utf-8?Q?0ZHgUm/aax66mTYsiav41GkIu?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0256a6-d883-4fec-fef0-08da65e498a7
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 22:02:51.7254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SHLHl+g5nPYh9hVreQ09rqVg5iqxDYUMxoUrdf06C0wSQwI52hCz4t1b4AMpCUfvfjjYo248NFyD5yggh41PWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6103
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-14_17:2022-07-14,2022-07-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207140097
X-Proofpoint-ORIG-GUID: KVpRYsG9v7RyAE-d0ix2pOGTlC4QQhxH
X-Proofpoint-GUID: KVpRYsG9v7RyAE-d0ix2pOGTlC4QQhxH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/13/22 08:00, David Hildenbrand wrote:
> On 08.07.22 21:36, Khalid Aziz wrote:
>> On 7/8/22 05:47, David Hildenbrand wrote:
>>> On 02.07.22 06:24, Andrew Morton wrote:
>>>> On Wed, 29 Jun 2022 16:53:51 -0600 Khalid Aziz <khalid.aziz@oracle.com> wrote:
>>>>
>>>>> This patch series implements a mechanism in kernel to allow
>>>>> userspace processes to opt into sharing PTEs. It adds a new
>>>>> in-memory filesystem - msharefs.
>>>>
>>>> Dumb question: why do we need a new filesystem for this?  Is it not
>>>> feasible to permit PTE sharing for mmaps of tmpfs/xfs/ext4/etc files?
>>>>
>>>
>>> IIRC, the general opinion at LSF/MM was that this approach at hand is
>>> makes people nervous and I at least am not convinced that we really want
>>> to have this upstream.
>>
>> Hi David,
> 
> Hi Khalid,
> 
>>
>> You are right that sharing page tables across processes feels scary, but at the same time threads already share PTEs and
>> this just extends that concept to processes.
> 
> They share a *mm* including a consistent virtual memory layout (VMA
> list). Page table sharing is just a side product of that. You could even
> call page tables just an implementation detail to produce that
> consistent virtual memory layout -- described for that MM via a
> different data structure.

Yes, sharing an mm and vma chain does make it different from implementation point of view.

> 
>> A number of people have commented on potential usefulness of this concept
>> and implementation.
> 
> ... and a lot of people raised concerns. Yes, page table sharing to
> reduce memory consumption/tlb misses/... is something reasonable to
> have. But that doesn't require mshare, as hugetlb has proven.
> 
> The design might be useful for a handful of corner (!) cases, but as the
> cover letter only talks about memory consumption of page tables, I'll
> not care about those. Once these corner cases are explained and deemed
> important, we might want to think of possible alternatives to explore
> the solution space.

Memory consumption by page tables is turning out to be significant issue. I mentioned one real-world example from a 
customer where a 300GB SGA on a 512GB server resulted in OOM when 1500+ processes tried to map parts of the SGA into 
their address space. Some customers are able to solve this issue by switching to hugetlbfs but that is not feasible for 
every one.

> 
>> There were concerns raised about being able to make this safe and reliable.
>> I had agreed to send a
>> second version of the patch incorporating feedback from last review and LSF/MM, and that is what v2 patch is about. The
> 
> Okay, most of the changes I saw are related to the user interface, not
> to any of the actual dirty implementation-detail concerns. And the cover
> letter is not really clear what's actually happening under the hood and
> what the (IMHO) weird semantics of the design imply (as can be seen from
> Andrews reply).

Sure, I will add more details to the cover letter next time. msharefs needs more explanation. I will highlight the 
creation of a new mm struct for mshare regions that is not owned by any process. There was another under-the-hood change 
that is listed in changelog but could have been highlighted - "Eliminated the need to point vm_mm in original vmas to 
the newly synthesized mshare mm". How the fields in new mm struct are used helped make this change and could use more 
details in cover letter.

> 
>> suggestion to extend hugetlb PMD sharing was discussed briefly. Conclusion from that discussion and earlier discussion
>> on mailing list was hugetlb PMD sharing is built with special case code in too many places in the kernel and it is
>> better to replace it with something more general purpose than build even more on it. Mike can correct me if I got that
>> wrong.
> 
> Yes, I pushed for the removal of that yet-another-hugetlb-special-stuff,
> and asked the honest question if we can just remove it and replace it by
> something generic in the future. And as I learned, we most probably
> cannot rip that out without affecting existing user space. Even
> replacing it by mshare() would degrade existing user space.
> 
> So the natural thing to reduce page table consumption (again, what this
> cover letter talks about) for user space (semi- ?)automatically for
> MAP_SHARED files is to factor out what hugetlb has, and teach generic MM
> code to cache and reuse page tables (PTE and PMD tables should be
> sufficient) where suitable.
> 
> For reasonably aligned mappings and mapping sizes, it shouldn't be too
> hard (I know, locking ...), to cache and reuse page tables attached to
> files -- similar to what hugetlb does, just in a generic way. We might
> want a mechanism to enable/disable this for specific processes and/or
> VMAs, but these are minor details.
> 
> And that could come for free for existing user space, because page
> tables, and how they are handled, would just be an implementation detail.
> 
> 
> I'd be really interested into what the major roadblocks/downsides
> file-based page table sharing has. Because I am not convinced that a
> mechanism like mshare() -- that has to be explicitly implemented+used by
> user space -- is required for that.
> 

I see two parts to what you are suggesting (please correct me if I get this wrong):

1. Implement a generic page table sharing mechanism
2. Implement a way to use this mechanism from userspace

For 1, your suggestion seems to be extract the page table sharing code from hugetlb and make it generic. My approach is 
to create a special mm struct to host the shared page tables and create a minimal set of changes to simply get PTEs from 
this special mm struct whenever a shared VMA is accessed. There may be value to extracting hugetlb page table sharing 
code and recasting it into this framework of special mm struct. I will look some more into it.

As for 2, is it fair to say you are not fond of explicit opt-in from userspace and would rather have the sharing be file 
based like hugetlb? That is worth considering but is limiting page table sharing to just file objects reasonable? A goal 
for mshare mechanism was to allow shared objects to be files, anonymous pages, RDMA buffers, whatever. Idea being if you 
can map it, you can share it with shared page tables. Maybe that is too ambitious a goal and I am open to course correction.

Thanks,
Khalid
