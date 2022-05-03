Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FF4517BB6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 03:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiECBlo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 May 2022 21:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiECBlm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 May 2022 21:41:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90DD329B3;
        Mon,  2 May 2022 18:38:11 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 242MBvaN027626;
        Tue, 3 May 2022 01:38:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=O8O9rxo0pNFoipLAKCmSPd3i4zrfKrfPtC+2mNWNNZg=;
 b=bFD/9jvBHGR5QPqOw8GcmnwDmwzAf5/0twcXy7xRTXJd7mFdC24/ImjDt/IwhPTAZKAR
 OsKR5KyRDJmeNWwfcItw/nBuIZ19fPTqSlr9z4a0XtHC59atAL8LVGVp0YghHYcXmihd
 fAc8IHP/o8d5cXbk3UirdaZnbeg95/9bwh6tkF64X74yQIBuSovt/vpOHbwjWqigfZof
 kxdRX6ESVAGUxgp6Ql1MOrp0ZJhKsrziHenBULgditruNEaPV+lI0zfgxWSNYz81/q2c
 BUtSSXRRhWH9PQbeoGaLlUytB/9mF0pwOOeRQG/Hkx0kQB+mST/m24/+dYf4sN6v1lSj /Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruw2cqag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 01:38:08 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2431aPLa003257;
        Tue, 3 May 2022 01:38:08 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj8jnb5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 01:38:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ta2Qnpv3AGHTAH37lcq6CQjt2M7soHNqaFrj3eBZbaUVULvRu/ITU7gpqfWuvxDd4CyRgayE9JBdeC/Crx99t7tqEYMYRVoVhFG6oAdKTGPh/Pn1jtAeuugfM3Ca2DQkIOm+X9HOdyobTgO+aGmBCIOmlhqjc0ok9WuUw+9Q7TnD3PDo5ySZg+C+O8fV1EJTBVBWrBbf0nrhkuN2F4NfyvnysHrILv5jttU8yLL8uIUtr6hGMY2QV+5gK3Kk2uhnytS5ROkhKjplVGZXGXgLkJZY4/146E0bisHv+/kXEP5gMpN/WMfBSzh3JLUPfP8nH6zAiJcePh/BcCQifItvKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8O9rxo0pNFoipLAKCmSPd3i4zrfKrfPtC+2mNWNNZg=;
 b=JaJ2CZOx5io7brNPlDGmWSoqqSpaPoAmEo2S7SpZp9hI1uRggT8Vb9o/7VDEOiWemf7fNQD0d4UaAMYqELFroVjrMio4klk9zbcX7XV3Jl5R24xwE8HDaA8HjsBvdp2UgpurxzmXIPT+WfakC3ezsXTpN7xusuiY1NnmqC9kYZ5/SMKv5nd81Y7+8zT7NvDSsg9aCzQ7X1Rhav6C+BoDPrRoBVD8X7Q04EIjQxX6pwsdWVhhvRr+cAV4g08P6cLFBjlGs1UjCLKXfy0Ysa4O1HWixn/oe8DvnFLzMV7Vlw3IvJT2p33/5LzsDbc1hse44dO93Mi8MvBBcaqIipRP2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8O9rxo0pNFoipLAKCmSPd3i4zrfKrfPtC+2mNWNNZg=;
 b=GN4VaWX10fraVoLWo2QaHQWmfpVXEU2tGtDq1ouujSSIkHZ1UWGvbA1gba7CGulJ3G4EeAXFFmeVGE275O2oO1+t0rDHkspv+BESp7bVFLxFL3iE6vefcl3di3VQ+E137RfP68zvcXd3QHtV0PH3po4gDYEeEY1/B1f6d8e73eY=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by MWHPR1001MB2238.namprd10.prod.outlook.com (2603:10b6:301:2d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Tue, 3 May
 2022 01:38:06 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8191:d4f0:b79d:a586]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8191:d4f0:b79d:a586%7]) with mapi id 15.20.5206.024; Tue, 3 May 2022
 01:38:06 +0000
Message-ID: <9b394762-660b-4742-b54a-2b385485b412@oracle.com>
Date:   Mon, 2 May 2022 18:38:03 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH RFC v25 0/7] NFSD: Initial implementation of NFSv4
 Courteous Server
Content-Language: en-US
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <1651526367-1522-1-git-send-email-dai.ngo@oracle.com>
 <20220503011252.GK30550@fieldses.org> <20220503012132.GL30550@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20220503012132.GL30550@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0048.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::25) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 891dd92e-5faf-4f18-6de4-08da2ca59261
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2238:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB22385B4A08E35D9BAC01F4B887C09@MWHPR1001MB2238.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OI51W0wiIDSwYwjUynhCQO2z/Px8kNuKP99df1RnVKxoo8nUYWqVNpAE6+e1X+fYO4GYrkOf5OA5TnsXGud3WjKPFlSJxanKSShqatv5gd7aEs1sKKIiRwu5+E3nqswUfpfX6D00TjunyMzuyvqiVft9u0eWBXibN1v88/cRFXDseNstZ0jUsqNG1FyWd9l2LmAbS/mw96hDqteQnLG4EglBZwbY6NirbMbXV+Kk+lF/B/xhX9MmW8mGlyfGmxK0hZwri/deStkMRj/UmFeiySHx7NU20msBidwsKEVeuVjGe3xQFBToErHZ9dzHaIHj8Igv6gNMP1NH3MqRBOtxQqtlNq+lsSg7+uLzp+OTpbzja67Bf5LyfuMzJooSzwlYqW6GQDB2vCitRZU62a5nXiAJn+4YsekGyX9MmuxGPwAGOBqJlXa7UHC/e21xr/K50kPt+vQmJyXusydIpTPmYlkk8tT8TxM2lSGGQMI93MiWc+qgqgSaMuZJ8rLgJhUd77ViWOMB18yr5a4MN4QW07YzjDSzYIu3grvh8bUsWyqfY5KaKdZYo+AhfdR4XBJnToE1HbnsA6VCb9IG3Q0UDWVRipsx8q1Ht9uts9zZ5lUiCUjQySnTtgE8X1fLD6tuoySgBZX/GtFjexSGEloazsQXY0T8M4Y9ygxAy+yM89dvHEplra/c7ySSSkQKn9WPRkaYqaHcPOq+lAmLF1/yNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(2616005)(508600001)(6486002)(6512007)(6506007)(53546011)(9686003)(186003)(83380400001)(66556008)(66946007)(66476007)(36756003)(31686004)(86362001)(31696002)(4326008)(8676002)(2906002)(5660300002)(8936002)(4744005)(38100700002)(316002)(6666004)(26005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2t6RUJrOEdmcENMS0ZZSzVQNm1SbGVZT1Y5RXk2Nit3OFdlWmUzeDlGTGpZ?=
 =?utf-8?B?NUxKUFZXMVk2Sy9jdDdIQWVvNXVwWCsxTnpXU3dVQ2Fjbmt2S1E4M2JNZDVp?=
 =?utf-8?B?a1IrYS96TW84SmFoMHZKSlhrbW9Kc0NvQy9uODVOMXJrNzl0SGdLWHRCcGJY?=
 =?utf-8?B?R09WOGhaSVpvNE1yZU5DenB0ZUVmOXFPTUdlTUc4YTNlU0ZEMlJsOWR4R0Zv?=
 =?utf-8?B?VHlFYlBZbk8rQWVYcXU3UnhCNkNVT0hVbVNldU1hRE0wbG9qc0NESjhFWnE2?=
 =?utf-8?B?MUg5QXdaRDdpU0NnRGV0MlNSemVESjNRR3hEUXlEQTdtVTVYcWczbUYwemxs?=
 =?utf-8?B?eWFpRnJtV0o2Z0U0OURoM3lIcGpCRmlwalMxdnVIaWJaQXMzdWRDanhPTnEz?=
 =?utf-8?B?RWxXM3FDUjdHeEp3VW9hVXNpYzdKQi9WbjJtTzdCd2JRMHc5ejczZTZEZjAr?=
 =?utf-8?B?c21RajQrUUNaSmUxd3M2alFxZGNJNVlFUlJOQk8wUzM1QVdWTU1MRHFXZ0ND?=
 =?utf-8?B?SVYvY2lpVVVtMzFockZ4cE1rbzlkb3M3RUtZY1pZRG1kRi9DN3Q1VXk5S1Q1?=
 =?utf-8?B?alVuNERCU1FkRGw3OVJsSERaZ240QXVBWGU4eGovNDk5TVpPWTlTYVpTaDg3?=
 =?utf-8?B?MlpFMUZYTFZnaGJPWGFDaVRlWVVRaDRhb1cwQUVDVnN6UXo4MEp6SGxtcUps?=
 =?utf-8?B?dGtMKzJLUFJjQmhsT2lvTUNseW9jaXlJMFVnOVk3NVRHWWZJVTBab09wTWt6?=
 =?utf-8?B?cDlhQWxOQUsxTHVDQmNqVXV0RWlXQVA0Q0NCZkx5OGFpWkN1cHA4Z205c1pW?=
 =?utf-8?B?VElpVDZJUjI5RitKb2VjL1BtdlhIVXpSUDdobkovNGFNdWg4NGNJY2xKanRh?=
 =?utf-8?B?MXZBeDg0dG0rS28zNFNJMVZZK0hsWlJMeCtvc3pHdFFNTGhZYm1OTjA5UDNr?=
 =?utf-8?B?N3NyWDBjUWlwUE9hQWtUeUVSR3JDbk9Vc2drU0JuZU9zckowbUppMEtGK1cz?=
 =?utf-8?B?VSs5OTUxM1RGcmhZYXJFcnJNTHQ5TVVxTWJWTVVxTWVOc1I5MHRPZzE5ZVc2?=
 =?utf-8?B?Y09OUGYwTDlURkZ3VkRtaXFMUlhuNWJWOVMwZm9VdVl3dlFXUzYxT0JDZTZy?=
 =?utf-8?B?TjlVTFB0Rk9TeDYwOFZzMTlPOVdPZ0h0ZkJtSFBSejJhU3I1SGVaN3EvdlVV?=
 =?utf-8?B?M0E1aFpodDRqTzE2U3ZucWowa0FZSS9jNUtGN2RocW9UcW0vZGh0U2d2RDAr?=
 =?utf-8?B?YXozZjJpdmN6NG53ejdHLy9FS3p0WVNPeGRBL0h5ZjlHWFBEUzRQZk1yVi9v?=
 =?utf-8?B?Y05LQzA5ak1LdUVvWUQwRmhCbmpDUnlBUFBpbXZ6WnAzZjNDb3dPcC9oWFRk?=
 =?utf-8?B?YWNNQjM2RlpuYzJUWi9DQ1o0aWdxUysvK1ZwNzNWK3Vici91QmdHdVFjU2Jn?=
 =?utf-8?B?Sm56Wm5DQUgvMmEwYjZqdzdzMFA0cDF5MzRYUjRPUUx5ejFMdEFSNTVlSnJr?=
 =?utf-8?B?b2ZZZVRBSXZxV1ZxYjE3YU1vTVAzSDV5MW0xdTN2SEUvU2NoTGNFenNScVRL?=
 =?utf-8?B?L1hUWHJsSi9ZbjljN0pCbTlpbjIxb0dCSTZPeHF5eVNacEFXMFNDZGVmZWxP?=
 =?utf-8?B?bEowSXdaa2hxd0h5OFdCZWVwZHFWWGVDU1Q0aStaeFdMcHNUTUJ0ZDAvL0ho?=
 =?utf-8?B?THdSRzhZMEg4TWVpek0vMXhvM2RiTm1FeFdmZWtxaUdoeGNHb3c1U0lkRlMy?=
 =?utf-8?B?bTRla1VlOWpMK3FIdU5HcGwrVDhXMGJSdElud251UE4yUHR3aXdwaGhsK0RX?=
 =?utf-8?B?dWlvSGgzUys1aUFnVVczd3Z4Z09BUVFHZnJBSnl3R2duWEFMMWxIbkhMZkNx?=
 =?utf-8?B?U0t5U1pOb1RhNk9hYWpFUG0veTc1OEUyY041NlFCZ0p2aWdaTjNLZU9WY01B?=
 =?utf-8?B?ZlJQVlptQ0hKWXA1KzNCZUdTMU5meVhScVBhTTdQcE1wcktWclUxMTVEeURU?=
 =?utf-8?B?dUY3bEFWelJnMkMrcFZPT0FUVWlnVEs5ZCt3OWJyUVoybXNwSVhXVlB6bHNE?=
 =?utf-8?B?NWk2dThjTTdIbWg4STMxaXV0bXpVb3BCRkpSR3JMSVFqelFkdnVpR05YMmE2?=
 =?utf-8?B?Z3pmb1p4eFhkeEwveGx3YVpkdUEyMTNVTWYxQUxTZ1FtNUlZN01NVTZHUlVs?=
 =?utf-8?B?NW5kUEsyOWswNEUrVjVYb3FBc3BDWUJHR1hKUG1IaXZ3R1QxRU5CRTkweTFk?=
 =?utf-8?B?ZU15S05lQnd2ZmZBamdKOXcxV1VKTTZYcXdYVXh3eDdwSWRlMXljZzNGWldw?=
 =?utf-8?B?cEZqdkJ5Umw0NDc4OWpJV1BrRW1XMjlybTBFaHdOY2tGUEpaMGw4Zz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 891dd92e-5faf-4f18-6de4-08da2ca59261
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 01:38:06.5305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NoNrT5+ObA0nBaAEq9p6JuK03LbXf5n8Hvd9gha/y22BKQkRy2UtpjguPlpgeiicyzJYtCt5HduHj6ZkGPey7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2238
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-02_08:2022-05-02,2022-05-02 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205030010
X-Proofpoint-GUID: GOOq1_OOLClzIqHQJnPTdNc3_xiZHYKr
X-Proofpoint-ORIG-GUID: GOOq1_OOLClzIqHQJnPTdNc3_xiZHYKr
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 5/2/22 6:21 PM, J. Bruce Fields wrote:
> On Mon, May 02, 2022 at 09:12:52PM -0400, J. Bruce Fields wrote:
>> Looks good to me.
> And the only new test failures are due to the new DELAYs on OPEN.
> Somebody'll need to fix up pynfs.  (I'm not volunteering for now.)

I will fix it, since I broke it :-)

-Dai

>
> --b.
