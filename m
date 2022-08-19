Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEB759A568
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Aug 2022 20:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350269AbiHSSTM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Aug 2022 14:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350214AbiHSSTK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Aug 2022 14:19:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAE199B53;
        Fri, 19 Aug 2022 11:19:08 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27JHHvOg023015;
        Fri, 19 Aug 2022 18:18:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=D9YpefW+/DAW5QJcazbQ7d/5XT2yxP7iBuYFGYWRO7k=;
 b=lRPGd8mdk/cFbXWF05jYjO9Uu4YkeBp8NEZmkMjPoL+FYx+gsP49/M/AC5wCD0RZ1LW5
 UL96VFatctjlWc7LA5MOVZ4XO9JJ45chwgEHFaCAyvaXYuS+G+vlo+/t7NIIT0yBpz7K
 RzUzyafMF14B/4acRfuzV0TiNqtmREEvlX9vQWFAiv1YhlfQiiI9idWvsbIHwVo0Alfv
 JkZbfxPPIoYnTsnpBs7iPW3OWscBlzSf7+JjdQif3EXURM69VHzf/VSldHUtfan9E5Af
 1d52EvDzdgopM4P/J+enAX966RBozoa8WvjIgbsk/lD/XxslWc62TrTPpaR2nnhATGKw /g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j2esv84uq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Aug 2022 18:18:58 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27JGWaRJ026928;
        Fri, 19 Aug 2022 18:18:57 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j0c6fguf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Aug 2022 18:18:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A462KDxjfKdPjPqtYiiiyMt7TFRSIDOy7rAIUs938ZHXpTZxohWei1VIH79IZP0U4/o5xQ0Aobt6smHnfZlZS84itesw0djjoHrhV2uUrMwJ4msXuATEpp9UEf68rXGFUoh/qiquiMI64xtIb20Kub8C8CXa7+gPcZdePBAWmpY/qTs6EAxD44s7Qa8Jn5lljClzvhZ5+TekLkeAGWP6lNIj20mm6TawzWIe1o+mwrEUyCc71lpZ6p3rQpDVZZqywF4gNiKcoabJZnGdeuCML+LuaC+urKIAGv+OnqEY0CjpSPfSMl3pZ0EuIjwuhvvHODus7mYPDuLK8z81HFjWXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9YpefW+/DAW5QJcazbQ7d/5XT2yxP7iBuYFGYWRO7k=;
 b=ScrqKYMAtnvjVqDjeH1GUg8HrGXmuE+qXLzPRaLbC+I7MxHq6UsiqhIg1Zqo5diCOIbESu3RtC7wGJw9IFZUQG5j5lpJ74ZUx9ctOXuEaa9XrhBCHYgwskN3X3Mubw7ail4Nzja6fDq1X7djwYITaoY/eGSrqJ/VNxoE5rcHx60Bw72q1s1vv7M0gVY9C3eIUZe+sId92hlbOkOlYd90dwS+ItW2XmliFKzOQShbojFORqkvf9Zf9eVBfeectaQpVCz1Jb6E1lDQcH/T1dJBl5MwBWZhOOwo2T2EnLROYyJKc4NbfuKUQ3pcrHenTg4al5mfgQaWvuaiiKZ6gp9P2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9YpefW+/DAW5QJcazbQ7d/5XT2yxP7iBuYFGYWRO7k=;
 b=EvDitlj0hpbm4qnoZmxJsfq5uX/nnnjiyhY83gtJ46fkeHurREYWqoezN/RAwx4e4oA+iVLzEX1roo0AxgrdZYzNsat5oTIY/Pmswb2gvBrXtmEfVteOkwx4puYjLnUK2wPcKCaIg/dz+KWxJy+W6zHe8WaoSEvSXNjgOzRlcPM=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB3656.namprd10.prod.outlook.com (2603:10b6:a03:11e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Fri, 19 Aug
 2022 18:18:55 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::d90f:4bba:3e6c:ebfd]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::d90f:4bba:3e6c:ebfd%5]) with mapi id 15.20.5546.018; Fri, 19 Aug 2022
 18:18:55 +0000
Message-ID: <a9b9a68d-bf8f-2c89-eab5-ef1cbb5be135@oracle.com>
Date:   Fri, 19 Aug 2022 11:18:53 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [RFC] problems with alloc_file_pseudo() use in __nfs42_ssc_open()
Content-Language: en-US
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <Yv1jwsHVWI+lguAT@ZenIV>
 <CAN-5tyFvV7QOxyAQXu3UM5swQVB2roDpQ5CBRVc64Epp1gj9hg@mail.gmail.com>
 <Yv2BVKuzZdMDY2Td@ZenIV>
 <CAN-5tyF0ZMX8a6M6Qbbco3EmOzwVnnGZmqak8=t4Cvtzc45g7Q@mail.gmail.com>
 <CAOQ4uxgA8jD6KnbuHDevNLsjD-LbEs_y1W6uYMEY6EG_es0o+Q@mail.gmail.com>
 <Yv3Ti/niVd5ZVPP+@ZenIV>
 <CAN-5tyHpDHzmo-rSw1X+0oX0xbxR+x13eP57osB0qhFLKbXzVA@mail.gmail.com>
 <b7a77d4f-32de-af24-ed5c-8a3e49947c5a@oracle.com>
 <CAN-5tyH6=GD_A48PEu0oWZYix4g0=+0FwVgE262Ek0U1qNiwvA@mail.gmail.com>
 <debe59b1-35cc-c3b0-f3ca-76d6a56b826b@oracle.com>
 <CAN-5tyHdr_RXPcFpa7fsg=jpOyge0C4pB1waj=BdHHzmeaMdPw@mail.gmail.com>
From:   dai.ngo@oracle.com
In-Reply-To: <CAN-5tyHdr_RXPcFpa7fsg=jpOyge0C4pB1waj=BdHHzmeaMdPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0059.namprd07.prod.outlook.com
 (2603:10b6:a03:60::36) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c64ed38-6127-4bb3-1aa5-08da820f46bd
X-MS-TrafficTypeDiagnostic: BYAPR10MB3656:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TuXAi259sDWCYVeBOkHC4Avod22HWofASnN++ydXSbIF7lUMif77L74iHHJynhqPCIOv08zCbXY/WE45nafMFl7O1Gvp07x2U3/6FQ/B6WRGCrn60CFNBAMqM7V203Wk2s7t/XGbkMhfT7J5pPWGVwkj3+JPRyVtyzgztERQcWY3R9lG5aRaNRo3oxFPzWbWhRjKq4/i9OJLYKViyTLgmDduaSZIrYDBmvV6b1Zp3e2ijXJXkj7wEzzZlxeaoAE2oIx6w577WY7W5mLDAiHuQw/O6osO0vCAdaJJ8RztCJbRzqopsqmEKzwmkowTR7DtkRXpIfZFw97oEuoypcJcMMW3pGe95+w7gi20tkrPHAxUgtzIxl8A5X0wIkDjfGYyh4A9ZUOVh49F6IR5+BhV63Nz/4EHgiHOHDgO7QBofyud31S61zpRNO6wnXme6tJXxuAeOYvF1iXnTwQ0hhRM3p1LXN8EJwRXhFaTjw8YywlfoT80jCvtANR5OPdhMHu3hTTYv2wv+VaoWLnF54Gfgorykezkyu3cTgFGN88mOzRAkm4dTM0m+6jEHAM93qtTttBz6IpfsbMhwYVBuogIYeI9vQPeGNU3JzwZZK6pw0d9LQrco1Ib3q9Q47JwQf61vYovgVfUt1Wi482DGxYfxxKSGyn7MVIK10ryWT2afbF8RoYS4dVuABjd2YiYHjRnnLP0JJnwrAMMRHrCdzMKRxY7gs35FHW2ifxAAmzi53lpv3G/xf5FAFpXZGfjTmnf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(366004)(376002)(396003)(39860400002)(9686003)(6486002)(6916009)(54906003)(36756003)(66476007)(4326008)(31686004)(66946007)(66556008)(478600001)(8676002)(8936002)(41300700001)(5660300002)(2616005)(31696002)(316002)(86362001)(53546011)(6506007)(2906002)(26005)(38100700002)(6512007)(186003)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmxWVHZnK3RORHVGU2lYdnBnd240STRKKzRJK0NTYWNoNUQraWRDTTM5aDNI?=
 =?utf-8?B?TzdqS1QzSGFwYW56N1ZKTGZyUS9ZbzFJWXZyRXlyUlFNd1NUS21KWDlza3lo?=
 =?utf-8?B?VzQ2V0Z1UEQ1bmswREFIWGtoNTVCZjlGMjZJbTYrRStHUkptUTEyRWM2SVRn?=
 =?utf-8?B?V2pQLzdMcFFsU2d3L3dxS1IzUkRjSmE2bnpGVmpXRSswZVRqV3AwUThZUERL?=
 =?utf-8?B?dHlxY0U0U3NndE5kTis1NFZVMFdpeFNxUTNwT3Yxb3lUb3hzNUhGVlpxN2dP?=
 =?utf-8?B?TW80NlU3bUJpNXo0QVc4Q1RCaGxIOFhOSFBqZDhZVzJmZWxBY0U4MUpnTlpy?=
 =?utf-8?B?cGYzeG5pbDdNWmNhZHkvSjFQNEs1L3ZuYkIrd2FFdVRwVyt1UjY5dEQ4NFJS?=
 =?utf-8?B?NDl3YnI0VHJqNmlSUWpId2xKSzg3OUJsWHVmeFZ2V2pkallkN243VzV0ZlNR?=
 =?utf-8?B?LzJZcTV0UGRtcTRRUWl1N1ZZTzFzQVFESStNeFpiNE1MVytOME9xeU44VEZt?=
 =?utf-8?B?ZkFoL1djQytOOTI4UTRJU3JOV2lCeVBRejc5UVhMeC90ZjlhMTZ5U3Y4NlNu?=
 =?utf-8?B?UjE5TFlLTzRaTEFFZUF3VGN1QnVnd1E2aGFjQUFkVlVtOHZ2aE42NW1zTHc2?=
 =?utf-8?B?TTA2RnA0N3VKU3FocklHYmJCZVk2b0hkMWdvcGZobzZVZ2g5NnF4NWxON3VN?=
 =?utf-8?B?WGgrM2ZmVkIvUjhsNDRNaU1xcDlnZTU0NnpKcVZBVFpEKy85SDBGVTJxTk9x?=
 =?utf-8?B?YUhMalN2U2JOcGExVzNEZTNPVDlDWU9PSUZCUm5RU2l6d1d5UXhNL3ZIK0xi?=
 =?utf-8?B?eWdVSVFTc0paQ0paM1Z1bHR2VW1Xcy9iV3pQaFlUQ25mcjVFaFZGV3RXYUty?=
 =?utf-8?B?VVhneUo5T1BiWDRJS2c1TlRwdXNCVVFRZkNZV0JxTXRqektTU0xUbTdDcG5W?=
 =?utf-8?B?cTFHbm1JVVdaQ25pSEo1eFEvdW9CTUlrOFhLUUxnNkNBQ0xsOEF6Z0V3OXh4?=
 =?utf-8?B?T2pWUThnV0lCbWgyUXZHcEI4NjZXRmRtVmZLbGpTRWlvSU04QktGcnBhTVdh?=
 =?utf-8?B?aU5yV0gyTzJIa0dkbWJ2QndSQytQOWRsWVFFOXBFRTJ1bzcrckMydEJNekVi?=
 =?utf-8?B?L0p6WFpOb0RYZm1iVWZEQ3QzM1ZZclczMDZFMVMvazNqY0lkeUN6Tm8rcUV6?=
 =?utf-8?B?SC9rUWRvRmhoZjdpbUFBZ0R3aUxlUlh1SUkvVjB1T1doZUZ4VkswZTRSTDg5?=
 =?utf-8?B?Uy80L1lMaE5oNlVjVEZmU1lJQlVrL1J4bzdpTFNlQTRIVElEOHN4aWFuTnYw?=
 =?utf-8?B?MjhqU0o0NGsrWDMwUlFuSlM3RXBTMllOa2pnR3hEZEwrbUR3M0gwREcwZStw?=
 =?utf-8?B?dDRTR3V1MHRZbzVQUWxPQUJDeTVnaXlWSWJDUk0wT1ExOC9INk5Bc09QMGo1?=
 =?utf-8?B?N0hsRnlsck13eWJtOWoxaWNWc1JWdVpSWEdTM3c5eXlZTENIK0RzaWtVVVpU?=
 =?utf-8?B?d2I5VHAzZkE0SlE5ZUdkelRlRWdJWnA4RFdnK0VRR2ZoNU9pb2ZHOGNCcWhh?=
 =?utf-8?B?RWM4Q01JTmdUd0NhaE8yOW84UjhOMWhzbnJXL25pRWNuTEhBdU15WnY2RGs3?=
 =?utf-8?B?R3F1czY2anlHWDdGbnJzWGp4L3k0SnRMRHFEQTJMaUl6VGRmUzFxYUV3YnhT?=
 =?utf-8?B?UFgxYTNpWXlvT2JJTmNTM1dvbjhkTk00dDV1dTVzNkc1WmJmL2pWcTdiYmV2?=
 =?utf-8?B?OGU3S0hmQTcvTGZkR2dqTHJBZ1o4MWdUelJET1QvdlNvL1FSb3pKbVVBTHE4?=
 =?utf-8?B?R3B6bExCaHg0R2ZPREhDRVc0dU1ORENOdFdCNENxSi9GSW1DbzNQWHdXL2hM?=
 =?utf-8?B?WnU4WG93OVlYSU9wR1U3QVRELzYycndqNlNVT28wWkhXVGJqcHVBUlZ6UGNr?=
 =?utf-8?B?d05BYm00a3R4V3c5NGpLL0I5L0RBMStWaEI4eU5LOWVENmUrWHVGTmdYTy9q?=
 =?utf-8?B?VERMY3A1d0lrRVBHcHE2T0ZPNUw1UlROM25EaTYrWWdrRWFScHhvTW1MMVM1?=
 =?utf-8?B?RHVnRWdMcVpGS1diVHpxTktBZitUWDUvQTFKUTdaajV1V2tiWU5JaHJvNkVY?=
 =?utf-8?Q?Yq5fy12lqo7xplG43KBrdsgJN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c64ed38-6127-4bb3-1aa5-08da820f46bd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 18:18:55.1452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rFth2KtZIoMHQaz56dMCtnnKDuxWuhFmM/rQGO68zcl1EVrAmBzLTNW5MExpTUoFLmmmhPwLsinKvFG0+0XAGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3656
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_10,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208190068
X-Proofpoint-GUID: dKev5wU9kfYi8fEfdQ5dTtklCir6woxM
X-Proofpoint-ORIG-GUID: dKev5wU9kfYi8fEfdQ5dTtklCir6woxM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 8/19/22 10:37 AM, Olga Kornievskaia wrote:
> On Fri, Aug 19, 2022 at 11:42 AM <dai.ngo@oracle.com> wrote:
>>
>> On 8/19/22 7:22 AM, Olga Kornievskaia wrote:
>>> On Thu, Aug 18, 2022 at 10:52 PM <dai.ngo@oracle.com> wrote:
>>>> On 8/18/22 6:13 AM, Olga Kornievskaia wrote:
>>>>> On Thu, Aug 18, 2022 at 1:52 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>>>>>> On Thu, Aug 18, 2022 at 08:19:54AM +0300, Amir Goldstein wrote:
>>>>>>
>>>>>>> NFS spec does not guarantee the safety of the server.
>>>>>>> It's like saying that the Law makes Crime impossible.
>>>>>>> The law needs to be enforced, so if server gets a request
>>>>>>> to COPY from/to an fhandle that resolves as a non-regular file
>>>>>>> (from a rogue or buggy NFS client) the server should return an
>>>>>>> error and not continue to alloc_file_pseudo().
>>>>>> FWIW, my preference would be to have alloc_file_pseudo() reject
>>>>>> directory inodes if it ever gets such.
>>>>>>
>>>>>> I'm still not sure that my (and yours, apparently) interpretation
>>>>>> of what Olga said is correct, though.
>>>>> Would it be appropriate to do the following then:
>>>>>
>>>>> diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
>>>>> index e88f6b18445e..112134b6438d 100644
>>>>> --- a/fs/nfs/nfs4file.c
>>>>> +++ b/fs/nfs/nfs4file.c
>>>>> @@ -340,6 +340,11 @@ static struct file *__nfs42_ssc_open(struct
>>>>> vfsmount *ss_mnt,
>>>>>                    goto out;
>>>>>            }
>>>>>
>>>>> +       if (S_ISDIR(fattr->mode)) {
>>>>> +               res = ERR_PTR(-EBADF);
>>>>> +               goto out;
>>>>> +       }
>>>>> +
>>>> Can we also enhance nfsd4_do_async_copy to check for
>>>> -EBADF and returns nfserr_wrong_type? perhaps adding
>>>> an error mapping function to handle other errors also.
>>> On the server side, if the open fails that's already translated into
>>> the appropriate error -- err_off_load_denied.
>> Currently the server returns nfserr_offload_denied if the open
>> fails for any reasons. I'm wondering whether the server should
>> return more accurate error code such as if the source file handle
>> is a wrong type then the server should return nfserr_wrong_type,
>> instead of nfserr_offload_denied, to match the spec:
>>
>>      Both SAVED_FH and CURRENT_FH must be regular files.  If either
>>      SAVED_FH or CURRENT_FH is not a regular file, the operation MUST fail
>>      and return NFS4ERR_WRONG_TYPE.
> Ok sure. That's a relevant but a separate patch.

Thank you Olga!

-Dai

>
>> -Dai
>>
>>>> -Dai
>>>>
>>>>>            res = ERR_PTR(-ENOMEM);
>>>>>            len = strlen(SSC_READ_NAME_BODY) + 16;
>>>>>            read_name = kzalloc(len, GFP_KERNEL);
>>>>> @@ -357,6 +362,7 @@ static struct file *__nfs42_ssc_open(struct
>>>>> vfsmount *ss_mnt,
>>>>>                                         r_ino->i_fop);
>>>>>            if (IS_ERR(filep)) {
>>>>>                    res = ERR_CAST(filep);
>>>>> +               iput(r_ino);
>>>>>                    goto out_free_name;
>>>>>            }
