Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09823512BB3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Apr 2022 08:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242890AbiD1GkC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Apr 2022 02:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244166AbiD1GkA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Apr 2022 02:40:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBB143ECD;
        Wed, 27 Apr 2022 23:36:46 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23S6F0F0003693;
        Thu, 28 Apr 2022 06:36:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=O42va8C/t2M9yu37/aHAM7U1d+mlC7a0yUVLIQsojRU=;
 b=gajE4UVzZm1b+FrtBRPuVdWNOkWG7bSilDm4E/HUOVHzqsh9ZNT4MNmCD/tOVcP9IAV4
 uIvx8zNbsydFun0S+udaoqPb7ZFQqg9TpHTTcJkuOVdfqcFgaYdoCXmxrac4tJ2Lgs17
 u0YBdpr47x/5IgU1oMRHmrD83r7OmeUr6IYRfauaHq5AI1wgmHy9Pz/lgsFlsFpSxPbx
 azHUQJmGqCinWmOaH+OzxGY1z/z2Wlr+0DhIYLxhB66cNUlZs3Wwl9C/4Ud6oCzT0rSB
 iqZQrq1K1Kcux1KwRKu2v8gCDhEK3RFdv389fc5vPJPIQ20Khy2Iecx80Ftp+BijLpa9 vQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmbb4tnh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 06:36:43 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23S6UAJh011106;
        Thu, 28 Apr 2022 06:36:42 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2044.outbound.protection.outlook.com [104.47.51.44])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w61x4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 06:36:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5clgfm8V/GGwWo5FWK+WL10bvLn4WDqQlFOwV1rbsmjUQagUDiUzp/6NLN4YYYxJH4pKUCnxookCPUVMAMw93EFF2ZYEzDYsRaImC8WlqBpEz53uZidvQsNLZOValqdZ8YSLILmdVXv3vn7gzF0sloMjpPJaw6x2wxFm6FX1cs+tjOJ9Bs4qpkFA5id6xiPlTS6bAfuVopKEATYCAhr+zqkvg3ca9ip2zSU4tf8Je6x5q7Sqrp+7dj3IZc9b5eZVNBOwNK6tzvO9ffblCPWjDaiHVleanKfcDPrbDvk8F1lJOP/NqWDMXSZjcVmsp552KUeJ7JEYjQh9tuDMd4rKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O42va8C/t2M9yu37/aHAM7U1d+mlC7a0yUVLIQsojRU=;
 b=LprApqSZhnQ42bW8ZlIrI3lqdcdhSDembrHwA/huH+G8kwQa/vpLiypL5p3Omm6sLQW0RMXiO1l7YSfyHSdpgvBGa1kwRmLd/YiTyzlDmQPkPrqaAnd51GV+DwVoW0d+62Wrybe9VH4IS/xFUHr6CgRfwYp56VPkHl3yj1X9sOdVyo/L0C0wLfgGLsMfP/W8OdhHSV4atgl3oeUv29Moko9WwLT+N+V00tOAsumwjGuP1gwtevyp9AlfwSPiHkJI89Uvtcm+ouWv0vuqmMTn6dv2pg0euh/KZtU973p3b91TNriT1YpDQbhpSRFVBlpijM+SzF8RHDTxo6IEQFAcVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O42va8C/t2M9yu37/aHAM7U1d+mlC7a0yUVLIQsojRU=;
 b=adp4Y283Gb8kUo15kuKPFrOq0vQSF/rjE/mIxyEbCbUdaED9ZLehaKgwvXIFPvFAEN+LTXuITy7E7dvtyEHu7BhMmmLLaRsrzzCL0k9739Aw79G7vL7Ebgd2ZoYJ9d7msp5+/uiN7Lznv0RIE9QQcuYSU9vl+XdLm/xKnsZOFrw=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by CH0PR10MB5179.namprd10.prod.outlook.com (2603:10b6:610:c7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 28 Apr
 2022 06:36:40 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8191:d4f0:b79d:a586]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8191:d4f0:b79d:a586%7]) with mapi id 15.20.5206.013; Thu, 28 Apr 2022
 06:36:40 +0000
Message-ID: <a651f61e-f5e4-a96a-2d8d-96b5ca156ea5@oracle.com>
Date:   Wed, 27 Apr 2022 23:36:36 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH RFC v22 1/7] NFSD: add courteous server support for thread
 with only delegation
Content-Language: en-US
From:   dai.ngo@oracle.com
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <1651049573-29552-1-git-send-email-dai.ngo@oracle.com>
 <1651049573-29552-2-git-send-email-dai.ngo@oracle.com>
 <20220427215614.GH13471@fieldses.org>
 <24607d8d-9a69-b139-ce1a-c0f70814de05@oracle.com>
 <20220428015234.GJ13471@fieldses.org>
 <3755605a-40ce-546f-b287-aa1cee10cd86@oracle.com>
In-Reply-To: <3755605a-40ce-546f-b287-aa1cee10cd86@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0027.namprd13.prod.outlook.com
 (2603:10b6:806:21::32) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58a85358-12d4-4640-6939-08da28e17407
X-MS-TrafficTypeDiagnostic: CH0PR10MB5179:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB51794837C725AB39B952230A87FD9@CH0PR10MB5179.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DFEHhDT3M40uuw4fIiq779/iPRYGe56U2rzhL8LSOTQCupt+nVDj0ZUHzvZcmM/ibKrkd7YT3md2eWlRps4XcMJohYHww4unmLu5K40KvNmaJnP8vf9UVEZbJFE3MpQMQyuOhcQ6NWFL6L0jVyHP3WdAQWTmBY0oybUtFCMzR0jM/+9Zl2qnWv2WHd7SpIdQqKu4EM9K+7tKUwPQ3Rahg9qavpXycpi8bGUsF1ow4wipPzd7NLrJqkkLdu9QFP3VT4vngqv/093LGNXgVhPhE36QMr8MjHugHIelT6bdvxOFcgiSOnhAd2QTm5rQ9gE//MYkHLL3yfXK7JKx1AreRFrzDDKjWK3Y6mPQmeGqRjd3aVgX2Pu2cfc5HUa7Te5rKc7SY4Ly2d2QtykUo31yjyCNHU76iXrRKnQQWn6JqhEC7h02fbIwd6SsKum1BCLw4ln9gpV9DIH08R7FOl5fmatdCRL1fw/rfSTrVi4HmHuLRagsdnHZqBUa9MV9ZCu4RZtP/D5JCMO1S5QtVckOw2mvYGsrroeRSDt1m7dF/AjxB/G6QnyE8O/CmJIT74Aord9xM5Ujwbt4uSfUQzNSKcXbdT0NOW5VcRaH/NQpaoLxji/BWPnRoLLwfa/eET8YmiHC9ioq86af3MX9oyNUdwjksC832PnbkcxQCIswEvzztVMIT6ZyQf96jhxdQiwQEdPfIkL78gBUParw3x7ijw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(5660300002)(66476007)(508600001)(66556008)(66946007)(8936002)(4326008)(8676002)(31696002)(86362001)(9686003)(6512007)(31686004)(26005)(2616005)(186003)(2906002)(83380400001)(38100700002)(6666004)(53546011)(6506007)(316002)(36756003)(6916009)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmFsTzZ6VVdOTFRQRnc0OFlZK1BtMGJ4RVU5UE1JUmZaZmI3dG9UVXVTa1Vm?=
 =?utf-8?B?cmM3VVY1WTV5Q1FVbFNiV25uTFovWGF5Q2JBS2hOUDc3VzAwMTZJYzBYWklo?=
 =?utf-8?B?dlRqcHhXNGJDQVVJYXNyWFpkemYrUW9tYS85OWJLZnFndkVGMmorSjBYZ2gv?=
 =?utf-8?B?UlNYekg4VWNmMTFrZ25MbG4zT2cwODZNS05MdmNRVTBqbjdkOWVUcy9sYjRp?=
 =?utf-8?B?YzgrR0FIdGdTdzRkbVVjUHVHWDROY2x3c0NxNnhIQXFENW4wREhwYlR6ZnZw?=
 =?utf-8?B?Q2lySEMzaHhzSW42VGhGWUx0dFd3SlRHVWdWMXduK3l4bkpUcE1XbmNKZGx6?=
 =?utf-8?B?S1VvZ0JvRkl1NEdGbmJGOGE1TXJGSlNiZE5WQkg4WGZVZjZhU0xJSzRyM0ZU?=
 =?utf-8?B?WXhhYUtOcTVUS3VxRHZXY0IreVF2YVFjR3RLdnJxbHpPL1paZzhCa0hXNlhu?=
 =?utf-8?B?emhQUG5YQTRORVlDOThQWUtjY1VJZHZUalN3aE80Yks4Mkg0UDc4VFRZaXNZ?=
 =?utf-8?B?MU9vMnRlR0hxM1dYYWZQeURCc2UwZnFLTHIvdjVaRDkvV00zaW1XYWcwTi9P?=
 =?utf-8?B?dGwzclBMZE16Z2NLWHEzcnZoL0VEOElLanNrLzd3TUVWZk9uaHlNbkdkVEJC?=
 =?utf-8?B?SXV6YzBZTVlHb3JDSy9SYkpMd0p0UFc4Q2kxdTJ0VTY1a2IzeStZSUc1dm9Q?=
 =?utf-8?B?WXdsRWJGNVFNOXBvSjhobzRWVnk0NGJvR0VDRFNLOFQwRW9yZHhFbUo3RlJG?=
 =?utf-8?B?UmZLaDFwekpRMXAwZXRZME9YN0xKblMyYy9nNGpDaFZMSldkazFLUWhwWDNB?=
 =?utf-8?B?enRoclZXNVJKZmxFS2VqTW1za3BOdWswU0xTaFJRdmpLUmtYakRxVWZTb1FC?=
 =?utf-8?B?Sk52QVFXYTR0bkdhdU80c2k4TklVZURWS2JMTUNSbUNwMEpBOGQ2WFc1REQ4?=
 =?utf-8?B?TEVSR2xEKzNFcjVVd1ROVnZDNlZzajdVditjaldiSHFzV0s4ek5nclNRS3cx?=
 =?utf-8?B?RnplQ3NpaXg5MkVTUjIxaFBkU1lFcUJWU3VNK3krSHBwTG5hQ3I2aWlMMldn?=
 =?utf-8?B?QVNnT2dCdThQVWdXaGROeTU1QUdVVFZaQXFweWdxdkpXV1ptVkVuODhuL2Zs?=
 =?utf-8?B?aC93K1dlV25CU05PSFM5b3h5MDZUNDV5MnNpaUNNQmFPaUdmZmxvZUZFMXp5?=
 =?utf-8?B?SkdTeU94VzJBMmNVREVDL1RHU0kvV1JwbFhjWlM2UmxPQTZkeGE2YnluekNG?=
 =?utf-8?B?ZWtNbU9wckMzOXl6UGYzSEZjM0lrYXVVd1FlSlpMbHhOUkVwOWhrcGtVdkNI?=
 =?utf-8?B?REFWTDFOS2QwbGNUL3pTMUJMT2E2d3J2aGFrUTJLNldOMFQvZDhBbE1WLzFR?=
 =?utf-8?B?eXB0S3BvazdOMWRDeVlSQXY1a3UwNjNpWHMvcGVXaXNnMnF2eFhuVHFyYUYz?=
 =?utf-8?B?bm1wc1NSZmNuYndOWHorZlljeHQ4bytFWkJsMWppbG4vVHEzQXQ4b0Y5Nzlv?=
 =?utf-8?B?UmtpekQ5S0dYc2tabnh5WGtrVXJCQUw4R2NwQzRyclZpd2ZrZjNmV3huN0Rz?=
 =?utf-8?B?L29LM005NFBwclo0SHpucXBpVVZKaUE4cXZHazZPSkJyRGQ3UG1wNnhNdEYy?=
 =?utf-8?B?S2ZaajYzaStuSnMrcXBwRmdQNnRFdUJDdXdDUGszeVIwVEpQYld1czBtR3lw?=
 =?utf-8?B?VmdNOVlXMVdiNWxoYkUwbnJZc0hOcWM4UEg0YVIxZ1lHbUJvNjFxaTMvZzJ1?=
 =?utf-8?B?Wm00ajg5cVRNN2huWkhLVzNidzQwbFA2dmNhY3NjVlVDQW9JTkZKcUpVRlF1?=
 =?utf-8?B?M2pGbjFwQjY0MFFYSVhVc1lJQWJxVzJqS3NWdURBRnM0cnhXL2sreDdZcjBz?=
 =?utf-8?B?SC9melAydFBJSEZRdW9MOEY3NXpsOUNNTEJ3QjlqY3ZFSlB6RDBrUjZNMzk0?=
 =?utf-8?B?bjhmSjBOSEYzNmk1Sk1xOGZxZWFld1NYcFoxdUJVRUVEUTBxOXVrTkFYaGN3?=
 =?utf-8?B?ZWczU1V0UVFHK2QvQVlRQXBXdzQvaEUzczAyTGF5WnhzNTUwODFPT0x0cHQv?=
 =?utf-8?B?eG1xektFbmZaeE01Lzc4LytrWCtXUlpIazl1RzNvVGUwcWVNTm5OUnlCeUhH?=
 =?utf-8?B?TDlkLzU3RWRxNWdWbUJ2VHBGdkN0L0xLbUFjR0xodExTb0dRRlE4V3c4UmVY?=
 =?utf-8?B?dnVHb0ptR1dVT2hUeURtbURiNHNJRG9pbmsvUWRRcUFLTEZXMUZLc3ErcWtY?=
 =?utf-8?B?aDBCNVpQUG1odGVveVZmb2VwQWhHYXEzQ0FrWlBEOHQ1S0tDa3pUb2Z1cVUr?=
 =?utf-8?B?aU5QdHBXOUIvNUhSQk1mYWIrQzREd2xYVTJuZW9rOE01QVFCbVZtdz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a85358-12d4-4640-6939-08da28e17407
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 06:36:40.6679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gY9YIuO/ylQM85Yhw/kwfCDF5YQSN0oIAwFmJiEkSe0DPNhWZ9cv5rxDvoTpEIURjuyYjL2j47OchoD51CovwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5179
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-27_04:2022-04-27,2022-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204280038
X-Proofpoint-ORIG-GUID: bcf161Fv8532Mz9Vny-fopeNz01PCBMn
X-Proofpoint-GUID: bcf161Fv8532Mz9Vny-fopeNz01PCBMn
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 4/27/22 8:44 PM, dai.ngo@oracle.com wrote:
>
> On 4/27/22 6:52 PM, J. Bruce Fields wrote:
>> On Wed, Apr 27, 2022 at 03:52:37PM -0700, dai.ngo@oracle.com wrote:
>>> On 4/27/22 2:56 PM, J. Bruce Fields wrote:
>>>> On Wed, Apr 27, 2022 at 01:52:47AM -0700, Dai Ngo wrote:
>>>>> This patch provides courteous server support for delegation only.
>>>>> Only expired client with delegation but no conflict and no open
>>>>> or lock state is allowed to be in COURTESY state.
>>>>>
>>>>> Delegation conflict with COURTESY/EXPIRABLE client is resolved by
>>>>> setting it to EXPIRABLE, queue work for the laundromat and return
>>>>> delay to the caller. Conflict is resolved when the laudromat runs
>>>>> and expires the EXIRABLE client while the NFS client retries the
>>>>> OPEN request. Local thread request that gets conflict is doing the
>>>>> retry in _break_lease.
>>>>>
>>>>> Client in COURTESY or EXPIRABLE state is allowed to reconnect and
>>>>> continues to have access to its state. Access to the nfs4_client by
>>>>> the reconnecting thread and the laundromat is serialized via the
>>>>> client_lock.
>>>>>
>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>> ---
>>>>>   fs/nfsd/nfs4state.c | 86 
>>>>> +++++++++++++++++++++++++++++++++++++++++++++--------
>>>>>   fs/nfsd/nfsd.h      |  1 +
>>>>>   fs/nfsd/state.h     | 32 ++++++++++++++++++++
>>>>>   3 files changed, 106 insertions(+), 13 deletions(-)
>>>>>
>>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>>> index 234e852fcdfa..216bd77a8764 100644
>>>>> --- a/fs/nfsd/nfs4state.c
>>>>> +++ b/fs/nfsd/nfs4state.c
>>>>> @@ -125,6 +125,8 @@ static void free_session(struct nfsd4_session *);
>>>>>   static const struct nfsd4_callback_ops nfsd4_cb_recall_ops;
>>>>>   static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
>>>>> +static struct workqueue_struct *laundry_wq;
>>>>> +
>>>>>   static bool is_session_dead(struct nfsd4_session *ses)
>>>>>   {
>>>>>       return ses->se_flags & NFS4_SESSION_DEAD;
>>>>> @@ -152,6 +154,7 @@ static __be32 get_client_locked(struct 
>>>>> nfs4_client *clp)
>>>>>       if (is_client_expired(clp))
>>>>>           return nfserr_expired;
>>>>>       atomic_inc(&clp->cl_rpc_users);
>>>>> +    clp->cl_state = NFSD4_ACTIVE;
>>>>>       return nfs_ok;
>>>>>   }
>>>>> @@ -172,6 +175,7 @@ renew_client_locked(struct nfs4_client *clp)
>>>>>       list_move_tail(&clp->cl_lru, &nn->client_lru);
>>>>>       clp->cl_time = ktime_get_boottime_seconds();
>>>>> +    clp->cl_state = NFSD4_ACTIVE;
>>>>>   }
>>>>>   static void put_client_renew_locked(struct nfs4_client *clp)
>>>>> @@ -2004,6 +2008,7 @@ static struct nfs4_client 
>>>>> *alloc_client(struct xdr_netobj name)
>>>>>       idr_init(&clp->cl_stateids);
>>>>>       atomic_set(&clp->cl_rpc_users, 0);
>>>>>       clp->cl_cb_state = NFSD4_CB_UNKNOWN;
>>>>> +    clp->cl_state = NFSD4_ACTIVE;
>>>>>       INIT_LIST_HEAD(&clp->cl_idhash);
>>>>>       INIT_LIST_HEAD(&clp->cl_openowners);
>>>>>       INIT_LIST_HEAD(&clp->cl_delegations);
>>>>> @@ -4694,9 +4699,16 @@ nfsd_break_deleg_cb(struct file_lock *fl)
>>>>>       bool ret = false;
>>>>>       struct nfs4_delegation *dp = (struct nfs4_delegation 
>>>>> *)fl->fl_owner;
>>>>>       struct nfs4_file *fp = dp->dl_stid.sc_file;
>>>>> +    struct nfs4_client *clp = dp->dl_stid.sc_client;
>>>>> +    struct nfsd_net *nn;
>>>>>       trace_nfsd_cb_recall(&dp->dl_stid);
>>>>> +    if (!try_to_expire_client(clp)) {
>>>>> +        nn = net_generic(clp->net, nfsd_net_id);
>>>>> +        mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
>>>>> +    }
>>>>> +
>>>>>       /*
>>>>>        * We don't want the locks code to timeout the lease for us;
>>>>>        * we'll remove it ourself if a delegation isn't returned
>>>>> @@ -5605,6 +5617,65 @@ static void nfsd4_ssc_expire_umount(struct 
>>>>> nfsd_net *nn)
>>>>>   }
>>>>>   #endif
>>>>> +/*
>>>>> + * place holder for now, no check for lock blockers yet
>>>>> + */
>>>>> +static bool
>>>>> +nfs4_anylock_blockers(struct nfs4_client *clp)
>>>>> +{
>>>>> +    /*
>>>>> +     * don't want to check for delegation conflict here since
>>>>> +     * we need the state_lock for it. The laundromat willexpire
>>>>> +     * COURTESY later when checking for delegation recall timeout.
>>>>> +     */
>>>>> +    return false;
>>>>> +}
>>>>> +
>>>>> +static bool client_has_state_tmp(struct nfs4_client *clp)
>>>>> +{
>>>>> +    if (!list_empty(&clp->cl_delegations) &&
>>>>> +            !client_has_openowners(clp) &&
>>>>> +            list_empty(&clp->async_copies))
>>>>> +        return true;
>>>>> +    return false;
>>>>> +}
>>>>> +
>>>>> +static void
>>>>> +nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head 
>>>>> *reaplist,
>>>>> +                struct laundry_time *lt)
>>>>> +{
>>>>> +    struct list_head *pos, *next;
>>>>> +    struct nfs4_client *clp;
>>>>> +    bool cour;
>>>>> +
>>>>> +    INIT_LIST_HEAD(reaplist);
>>>>> +    spin_lock(&nn->client_lock);
>>>>> +    list_for_each_safe(pos, next, &nn->client_lru) {
>>>>> +        clp = list_entry(pos, struct nfs4_client, cl_lru);
>>>>> +        if (clp->cl_state == NFSD4_EXPIRABLE)
>>>>> +            goto exp_client;
>>>>> +        if (!state_expired(lt, clp->cl_time))
>>>>> +            break;
>>>>> +        if (!client_has_state_tmp(clp))
>>>>> +            goto exp_client;
>>>>> +        cour = (clp->cl_state == NFSD4_COURTESY);
>>>>> +        if (cour && ktime_get_boottime_seconds() >=
>>>>> +                (clp->cl_time + NFSD_COURTESY_CLIENT_TIMEOUT)) {
>>>>> +            goto exp_client;
>>>>> +        }
>>>>> +        if (nfs4_anylock_blockers(clp)) {
>>>>> +exp_client:
>>>>> +            if (mark_client_expired_locked(clp))
>>>>> +                continue;
>>>>> +            list_add(&clp->cl_lru, reaplist);
>>>>> +            continue;
>>>>> +        }
>>>>> +        if (!cour)
>>>>> +            cmpxchg(&clp->cl_state, NFSD4_ACTIVE, NFSD4_COURTESY);
>>>> I just noticed there's a small race here: a lock conflict (for 
>>>> example)
>>>> could intervene between checking nfs4_anylock_blockers and setting
>>>> COURTESY.
>>> If there is lock conflict intervenes before setting COURTESY then that
>>> lock request is denied since the client is ACTIVE. Does NFSv4, NLM
>>> client retry the lock request? if it does then on next retry the
>>> COURTESY client will be expired.
>> I'm thinking of a local request for a blocking lock.  Yes, the request
>> will be denied, but then the process will block on the lock forever
>> (well, for 24 hours anyway).

Actually if the local request is blocked, it will be blocked for max of
a lease period. When the laundromat runs again, it will detect there is
blockers and expire the COURTESY client.

I will move the setting of COURTESY to earlier as you suggested since
it also makes the code more compact.

-Dai

