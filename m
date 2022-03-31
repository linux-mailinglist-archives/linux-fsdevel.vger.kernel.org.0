Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42AF94EE2BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 22:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241483AbiCaUjS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 16:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbiCaUjR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 16:39:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6497B1DF843;
        Thu, 31 Mar 2022 13:37:28 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22VHh6Hu027896;
        Thu, 31 Mar 2022 20:37:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=WRd9LDfGsTT3NzSND7j5C5gp7c8xwtV+v+xn0qlxRjA=;
 b=eQEFkELZW18iuNrymxUAZ3x23KUMr8UJuhHZVoiqw+xaiYgY9wFU4I1NH7dzeYXdzjIO
 KPS09Caf6ZfRgbw50hSN6v4W/+9rNZgr68RLzYRGU4NiLLrPsuhY8W2HevnPyJrf9wxT
 BKt9axEuQGzWmqi57JqmbmOS4UhSvCICAkioISjTnBYT+zScIM14Xa9JrNAsbL2Dq4dZ
 9jQzXTBUOh34aGz4UuLMGMWj2kXxJioqoyM2TwbJvYRpDls5FOx+STntsqA3VL0rLQ34
 +a7L9VlscM69g5h0zotJaBrAaFNzurKYhiEgXzIUqt+uhLeK+HJvZ+wT8gf96JfhHE+v sQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1sm2nf3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 20:37:09 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22VKaYYi020647;
        Thu, 31 Mar 2022 20:37:08 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f1s95vbs2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 20:37:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPMpRlvhmwnz5fJCmviJChzht28N1FV7UewrUU3aE2vN9Gxutfk27w4IeEgJpQPLeQlH7E5jARXUzZwDQYKPX3RkU2ScB0NzL3LBH+DniW+SiYND4tHQsYW3D9z6fQEH46SlZm5Gi6L+OLfQFXQgNPjmbRB5jfmwu85raYA+X385UZfEG24xvobgony7XINag8JZBlfRRkT3eeramzWZ8BViWeNfQjwmJKcJP6IB2ekJhG1WLdOR/v/31mCOiWv95lQaLbk6dh/H3et0VEhFblsQI4OBVBQHkJ9ijYK+8epxhmbDrURY73Ow8Rs/dEVDalhzKoyxwhdwQiyEgwFNLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRd9LDfGsTT3NzSND7j5C5gp7c8xwtV+v+xn0qlxRjA=;
 b=SuidDvzj14EjN6l1gvSyw9awJqdT9yh+aWa2+yuFxpsU7konERIdVE98GolYw1H0gR4Cc3XeanqCGVaZiGyHFx/tCaXagbPoUyDz85Zw+T1/a9gtZbhqqUN5N1Ks+PgjKqml6j6VmbrDFI0XU84znFfwOYJvmp815ycvwA8lUuC0/NtJexI5vo8/WlmwHgIx+YyV4VIDYuOl9RVNvaLh7lcEGCvzCl4TkfSeIQBA9feSXcnGNJ3pIdbTmNgsV/Tdq7878txvvxP/JqjXU5YBXqEbiIfYx+EikmA+CVMh8nOjOZwPfl88Du8zbxzsfph7xFbn/rQsERnwLZ83ZGFIJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRd9LDfGsTT3NzSND7j5C5gp7c8xwtV+v+xn0qlxRjA=;
 b=sErpGe2ubVbLG7eQW7lecaMTJ6dKRf1ftv+g6BfB+lKlO05S/oEptoEpuw7QLWt7FL7hUkfkOu03utMC1kgzNQNvLtgVwaiMmxozp6VqdwKxeg4qvncX2rsMbT1dlYCTGkox5iREqyYrG8lPmhWPMzcp6W7KMZIcnTui9Hq+VVo=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by BN6PR10MB1987.namprd10.prod.outlook.com (2603:10b6:404:103::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Thu, 31 Mar
 2022 20:37:06 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::9ca1:a713:90c3:b5b3]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::9ca1:a713:90c3:b5b3%7]) with mapi id 15.20.5123.021; Thu, 31 Mar 2022
 20:37:06 +0000
Message-ID: <a0a311d6-bf23-4b62-e2ed-874c116bda6b@oracle.com>
Date:   Thu, 31 Mar 2022 13:37:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH 2/2] fs/dcache: Add negative-dentry-ratio config
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthew Wilcox <willy@infradead.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Dave Chinner <david@fromorbit.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Colin Walters <walters@verbum.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220331190827.48241-1-stephen.s.brennan@oracle.com>
 <20220331190827.48241-3-stephen.s.brennan@oracle.com>
 <YkYE7RXgP8hL9aLd@zeniv-ca.linux.org.uk>
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
In-Reply-To: <YkYE7RXgP8hL9aLd@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0179.namprd03.prod.outlook.com
 (2603:10b6:a03:338::34) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d616e19-6e57-4414-cef9-08da13563836
X-MS-TrafficTypeDiagnostic: BN6PR10MB1987:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB19871E89B758CFA4D290931CDBE19@BN6PR10MB1987.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QGPYqY/ViDgF/RuiJPbD25yup1iMDvdo0cLxfNXqnTMUT99M9fqf7XvqGdwhJtTuzxDnD3tJvcCyZ84FGOAEP4/9qrNIMOBUunr4pLUp0Qta+9aUBiHX3uSwDEjOCIY7f8QknYhHv9v9iSzLslKzbzaf/NKYrK8iYGOLZaDIm5BIvx0eZwbR/PX6p+ZdVrl9C98lBEhykY4gvu+I+Plm+8lqztdet/gNcVA+/I2w/qYws/XYLr9zkF4b0A1Jw0tqkhVLpmv2r1GKludS2tkejtn17hUmsGP5NfZnHdC6L6NoC9K4MxPLgtkh0UCSDfg1KZi9lwNd98ptqbNzq4H9xLN7Zh9yBP5ee4lrGNRdSzLrPm+kk0mN4HYmwj7nJwfnRpTJytyO8fRPKCo/hxoQl6a0Raiwi/Ldoukg5I9MozPSClnaM/wRV3gwweDkhGvVnIiru3+3okyl0yxrjBwnMTreDab6ZuPvsnTonXkXFDvty41OnMvwCctuv5Cap3RMtdlg26wpwk4nJxGVO3WSmUmD37godJ5Z8vdAWEW6RPVHusiRQg0N4L5cHUPawhRCW78a+8ogRdkIukuPsFQu8Mm9c2baIyas4hWPk+D8emmxltO3OiWwrAn628ArYHXfFB052w6uAXQzWXidVwDoEMoEt8Pvi+46lxkKS2mxs9FUeUUO0S+1WnjEZJnXb358Qc74T6okDhanWXYqvKvjux5bEaBPIjV5Fh1NP717pfE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(31686004)(508600001)(2906002)(38100700002)(36756003)(186003)(5660300002)(7416002)(83380400001)(6486002)(86362001)(66946007)(66556008)(6916009)(54906003)(31696002)(66476007)(4326008)(2616005)(8936002)(6506007)(53546011)(8676002)(6666004)(6512007)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NC9sSTYxQUdnZndKT0tNaEFZb3VCU1lBVEc0aEJDb3NXQmw3U0llSnNnaDBO?=
 =?utf-8?B?eVpKNXgzM3VqRzhva0lTUEZkWUR5c0x2cjlyMTU2WXFrMm1JdTMvZmhOMFor?=
 =?utf-8?B?L1ZaSW9CQnpUcDRlVXRYazdmb09zck9wYk1nRzZkOTdNS1cyclhIUzA2Sjh1?=
 =?utf-8?B?Q2hwdGNzcVRrQjk5TVpIb2hyNU5pa3J1K2dHek85NTdCTm5NMzZnMFBZSlFH?=
 =?utf-8?B?cEM5MVBmNUpUTVhOZzF0TTJaYm9vN00yVXlYaFQrck1YcUZTeUpWbFp1Vy9E?=
 =?utf-8?B?dnQ4dzJKU3dSM1REbldHQ0NRSDVEWlY0cUQwZG5mb2s4czFNN2MwZXA4TTdz?=
 =?utf-8?B?YTY0SUNTN0w2MVlFR1JFR2pQb2owdnp4dytrU0U1MlZCOVRQSlVZdWFnVW1t?=
 =?utf-8?B?enYvb0g1cEpIUEhzRE1YSExEc1RCUkdnMXpLQS9NY3J3S1U3SGVyNTMrRWpX?=
 =?utf-8?B?YW01bklrZzR6Q2tlTVNaT3dpUFdKcEdmcmFXUDlFakFhUkdFNGsweFdmb3Fz?=
 =?utf-8?B?eGhLZFVjMTBXQnpsVWZ6aGR4aGRyRmpQaTdSbzl3ZWdWWWZpMHloVmlkeEh3?=
 =?utf-8?B?R0dzTStzcVhxakc1YkphUEQ5V3ZzQXIxVEdXdlBUMU52NUpabWEzR3dtSlRJ?=
 =?utf-8?B?YWNTcFpFTVRMeno1ekh6S1czWkZ5VHQzT2k2M1NrTTVTczlaSy91eGdDdGh1?=
 =?utf-8?B?ajZGS1RiT1lFdzZ2YnMvVXJwMmVhRm4zNXpzdCtJcTFKNGVPZ0pZL0ZIZC9G?=
 =?utf-8?B?R0pJUEdWdXMxbFdjMkhWa25jTVRBV2t0aCtyNWgwMy8ydWV0YzUzNUNqa0NV?=
 =?utf-8?B?endRaDdpUnB4bmgzQkgyRnFob1JiVmVFWkhycWoyRkRNMWthSG9oMGgwUDJi?=
 =?utf-8?B?RVBOMmdOMW5PM3ZkUlM2VFkzajRDbDZyRXo3UXVMZVRYMnFpSHN3L2xyV3pT?=
 =?utf-8?B?SkxCdk9VNmZLUTlhaGRYNnVLeVhCNnF2cjc5MjBtby9xM3dML2I5THdreGYv?=
 =?utf-8?B?N3BhVmoxR3RzYUx4aUdQMzRrdUk0THpiZElqaVN0VGJJVWs0TWZHMkROengr?=
 =?utf-8?B?T1pNYjduL0tmTVJ0UlNFeGkwT0VPYTlqNFRYL2VuUTZaL2JjV2x1VVJTaThR?=
 =?utf-8?B?QXJDU2lwOUFXc25Ddmx3ZUVwSW1ZRnp3MXhZSHZvTXRvSnlRRVhjdHlxYURZ?=
 =?utf-8?B?VlloUm1ET2pFUnQvalYwMnN3eWhHOXUvemNvSDEvY1NaYkg4eldFMHdjd3hY?=
 =?utf-8?B?cjZsNDhqWE9rSEo1clJoekliWURZbGpJM2tTL29ZV1dOaDhyc2N0Y1NKTEFJ?=
 =?utf-8?B?cERWelZhR0RndmFZaW9BOE5aOUhOanhkRElTd2ZvQUtqdUs0ZVdaWlI3dWNl?=
 =?utf-8?B?T1R3aU5tenNXeG92SmNyeFhaK2IvOUVlNERBR0xQMlgxQ1Z3bXVyOXlPcXNx?=
 =?utf-8?B?MS95SGxzV3JSc1cvdWdkWGNwT0ZhUDRhZGRQMlVtcEFERzEraTlBOXZJRnNq?=
 =?utf-8?B?UUFyRUJ5S1RaWVVIT095cE5xOWE0TnB3M0QrcmtYeDZCdW1IOUY5UzJqdFdW?=
 =?utf-8?B?Sk9KbDJWMmIycnhaV0swVFNxTWc5eC9TRXUzMElVRFR6M09NZmpQSG5ObnlX?=
 =?utf-8?B?bDBqQUNkTEVxeTBUQVNmK0FQVy9iT3diSWdnV0FVTVd2U2lSRGgwemk3Z3dO?=
 =?utf-8?B?bTZKZGswL0V0Ny9ZZWFlM29xdjVlS2g1bVVlcTMxSzVoa0VxVE1xOXViUGRJ?=
 =?utf-8?B?TlRMV0MyVC9HWno2MGhWckNCQUFjYldWMWpaRWlBaEw0b0ZLYWl4cHRGVFl2?=
 =?utf-8?B?SDJHVFBMNys4YS80VE1XMjQ5R21kcmRCL1BGVHBzUTRjS2ZlNERlYnlvWDFt?=
 =?utf-8?B?aktnZ1ZaUG1INGNrbGdjcnlXeHhVcnEyRk9tL292TVB0QVRZOFZhWHdwR2J5?=
 =?utf-8?B?T1ZqVHdEeTN6YU55R0xCZjJsUUpqcEk5TkVNS3dUUHh2WmFDcm1ORUN6V1Ro?=
 =?utf-8?B?MGtqVWpjd3lQdU9CWGVTSEJQTHZmSHc2bUlaQzdjUjR0VnlyZnhuSkxhdGpt?=
 =?utf-8?B?YXBkYmQwNWxiUGpwTnNQazRRVS9ldXhRbDVyV2FvRE5XaVF1ZGFNRlM2UU52?=
 =?utf-8?B?U2pkTVBTVTFXQmVydi9HalhvVnAzaWxWOCtHQlArU2lpZFU3T2IzQW5LU1lv?=
 =?utf-8?B?RklnMVAranBrelBCZ1NuYit3cWtDY3RXTk83bUtDTUhZT3pUZC9iYkkyNHk2?=
 =?utf-8?B?WTJOcm91azl6ZS9nYXZidTRvMVNBbVpJcmZZMU8zT0VOaUllK0FkSFhvQ3FW?=
 =?utf-8?B?QnNWUFJtelJ5OXU3M2dPZ2JoZ1hhOHAxaXlkMzQ2aXU5MFVCL2JIdHNHQjRW?=
 =?utf-8?Q?XtvvIQOi/MJu0zAo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d616e19-6e57-4414-cef9-08da13563836
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 20:37:05.9452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BQfXo6oDqqY+6oASUXPMG6yyxEIjmCucrkRGiVqZ9x5AYSPc7rCWgLG/dSGSX3jeOTtk0D6yseEiNrU66sxZUdZlZnftRBfqB8a5vcw+Gu0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1987
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-31_06:2022-03-30,2022-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=816
 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203310109
X-Proofpoint-ORIG-GUID: NXueq_5pyf7j__4u_Tsxkq3GlbdwP1Sx
X-Proofpoint-GUID: NXueq_5pyf7j__4u_Tsxkq3GlbdwP1Sx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/31/22 12:45, Al Viro wrote:
> On Thu, Mar 31, 2022 at 12:08:27PM -0700, Stephen Brennan wrote:
>> Negative dentry bloat is a well-known problem. For systems without
>> memory pressure, some workloads (like repeated stat calls) can create an
>> unbounded amount of negative dentries quite quickly. In the best case,
>> these dentries could speed up a subsequent name lookup, but in the worst
>> case, they are never used and their memory never freed.
>>
>> While systems without memory pressure may not need that memory for other
>> purposes, negative dentry bloat can have other side-effects, such as
>> soft lockups when traversing the d_subdirs list or general slowness with
>> managing them. It is a good idea to have some sort of mechanism for
>> controlling negative dentries, even outside memory pressure.
>>
>> This patch attempts to do so in a fair way. Workloads which create many
>> negative dentries must create many dentries, or convert dentries from
>> positive to negative. Thus, negative dentry management is best done
>> during these same operations, as it will amortize its cost, and
>> distribute the cost to the perpetrators of the dentry bloat. We
>> introduce a sysctl "negative-dentry-ratio" which sets a maximum number
>> of negative dentries per positive dentry, N:1. When a dentry is created
>> or unlinked, the next N+1 dentries of the parent are scanned. If no
>> positive dentries are found, then a candidate negative dentry is killed.
> 
> Er...  So what's to stop d_move() from leaving you with your cursor
> pointer poiting into the list of children of another parent?
> 
> What's more, your dentry_unlist() logics will be defeated by that -
> if victim used to have a different parent, got moved, then evicted,
> it looks like you could end up with old parent cursor pointing
> to the victim and left unmodified by dentry_unlist() (since it looks
> only at the current parent's cursor).  Wait for it to be freed and
> voila - access to old parent's cursor will do unpleasant things.
> 
> What am I missing here?

Thanks for this catch. Since d_move holds the parent's lock, it should
be possible to include the same condition as dentry_unlist() to ensure
the cursor gets advanced if necessary. I could make it a small inline
helper to make things easier to read. I will go ahead and fix that.

Thanks,
Stephen
