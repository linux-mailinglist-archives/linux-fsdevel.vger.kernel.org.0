Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62AAF4D510F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 19:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245269AbiCJSA0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 13:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238595AbiCJSAZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 13:00:25 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4965C19416B;
        Thu, 10 Mar 2022 09:59:22 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22AHw0SK019278;
        Thu, 10 Mar 2022 17:59:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Zn+48f9nCn6garm9wvRt7QhtJIRJlcPYzl/FbZLwLfE=;
 b=i6lBA8FCBCCkVdnzbJU0iEAbWdPsIkdKjQu+aGfq866sC3LVkERbXuZWDEOh7x9UjTSY
 y1SOIrmZpN5OZdyZPBooJyBp/OYtTgD/myRGQFJtfL5Uxd05NZo90ES4yuvH4XsaMUoN
 c5IM+/TYMrCgpvedlUX8iT92OCPqka2600CveUnZxFrF1I8HHrfD2Lz5dsGaQhK3WFcY
 uWF81vorgYjQzf7XPvi4eY7l+yvQXQ1pFWybFpdVhxvY2K8NIyHv8ogjP+7pcB7VIHNh
 vKcdYsqHQnZY6NUXMGCGI5X7V6MXMEjYoQGU+7vgrPdBbnrRbFddkm1BsMagZVstBPvh ug== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekx9cnvm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 17:59:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22AHtotW020304;
        Thu, 10 Mar 2022 17:59:17 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by aserp3030.oracle.com with ESMTP id 3ekwwdjh7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 17:59:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLZpKBT68snvi+cr6eW87CrepR88nA3+KL/Cchd9uM8COSlmwdnTDYEFHRVYaqXKC5e9AGCem+kr7zoZYfwm2xFKSi1REWHL+B89wRfaBOyooRfmS4TrNlYIUSmXQvk3QO8lzzCkT5p5NnmCpFP7n8AnwWWaN0I3v8crEyPwCKN6Wb4YNybXxrRGidb+SZRteCGJKyELlmFxs0759Z/eDyMhZlqIWTMdEcNlm5aIIk3VyAg/tbjWa8DGnpw3QkUbkrvaNQ+pja++UvTU0YWRiRC8bsFWUQ0zfbH3N4dMSdWDsQ+mkAg+moGe20dke74LVUXmIG9mDFJo2/j8bjDiDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zn+48f9nCn6garm9wvRt7QhtJIRJlcPYzl/FbZLwLfE=;
 b=Zt06f8nace7Xe4ejjmAFaB1c7Flz91fFaK8otL/4ApiYYJQoQ5B1nsyJTed8e4RrxslPlvRSU0Xc1HkYU7kRVpWhBta0mareNSUSK8WE322K8QCBIazIiI/RPYpy3Lecq9cs635d8/d0Gv3YtdTncepKwwUJiRSPdxqYPEOzRBwBhIGCgp7sSrn3whMojdhtNgTBCOtbnjXoKDuSPssT/lsjoL5ok+aUVlzuJ4wS9LxQYZRP/ZcCGC1gToBBp6o0FFn6Y4slExT3cs+Irwix+/l4xYbYAETNMQr7Lf4Xo8vonIvsC2bwqQscOARNm8Zhj9nzYoR2JL4ikPadFsdL2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zn+48f9nCn6garm9wvRt7QhtJIRJlcPYzl/FbZLwLfE=;
 b=d1WdMneL2VQCVkLslrHMPNH2LSFMA82W4+e0+asKRFpi72Bqy6M6gNApeVFtRIVn4p1P2TBMc2xs8uav7tg6rBMOuPSDOhNrLpBK5X20lghOUh0Q/dlK9hh1oAHs+7MFUsENl67v2wqhsWh6+PvdPUhTHqUrQ/ZXqir49SjgO+8=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by DM6PR10MB2539.namprd10.prod.outlook.com (2603:10b6:5:ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Thu, 10 Mar
 2022 17:59:07 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2803:98d6:9d00:5572]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2803:98d6:9d00:5572%9]) with mapi id 15.20.5061.021; Thu, 10 Mar 2022
 17:59:07 +0000
Message-ID: <28dae62d-a5e9-7e4b-e9fc-335ace34d310@oracle.com>
Date:   Thu, 10 Mar 2022 09:59:03 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH RFC v15 11/11] NFSD: Show state of courtesy clients in
 client info
Content-Language: en-US
To:     Bruce Fields <bfields@fieldses.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <1646440633-3542-1-git-send-email-dai.ngo@oracle.com>
 <1646440633-3542-12-git-send-email-dai.ngo@oracle.com>
 <E1AF0991-A682-4B98-A62F-3FE55349E30F@oracle.com>
 <c5a82f64-d1a5-3ec5-2bbf-4bd596840cf2@oracle.com>
 <ba8b4983-804d-607f-325e-c9be24c23fcb@oracle.com>
 <892A7E1F-2920-47DB-9E15-21CE73093893@oracle.com>
 <20220310150057.GA6862@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20220310150057.GA6862@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0107.namprd11.prod.outlook.com
 (2603:10b6:806:d1::22) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea1f98ce-2073-42d1-304d-08da02bfabce
X-MS-TrafficTypeDiagnostic: DM6PR10MB2539:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB2539D3A8533581FC90A65F90870B9@DM6PR10MB2539.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f/l1TS4uMKLCWoijN+nlA8CQNLN1Ft53RDzv8FcIPfWad7RNQAs+F+nm9MPxaFRdwyKA1ydOZD+A2lmhgTFgHMgNImGAr+nmSdqhXnFDdzwj9FKQqW1C0NjAbcTdKSjjXdFKAAbMO9kWWNqTFW+OS5WaS8aYH8zKbYpckB+grnT2S4FA5TFOo7j2na84Bl70K2ipC1j2OgYN7EopSVB0g8UvmdYrJyC1S3AarZRPZYeCmU86Ta7ATOkjN0V3tU1UEAGZMiHjdB3kgqScM6IBlPI/ArvYq7g1SDlxtLW4Hz7zpvqxaY8j8Gm5yZEIWzHT42FpKCcySpw4yitKempSbN8dVNvGdq2GN1q3m9yWynW9WADNRAmYNXFMbBREjbipQ+gKY37kGL6dFvNVO4yZ65HDFvJ/YemQOgNFQ44Vcj1ws49UbNgb02M7ciWXc6VeLZXIzdBBFe4htcKe73KpNrGPa86bCeZHvUm34OXucSq/McZq2fh78LWCsktYN9oNtFL4/LXxOnMIK//wcbKbrU2lMvukjaZwUH1K7WEDNRvZQPImftN/bm0Npl0iLD2VBnAo7y4r6nEzLsUuGluLhR99w4AcYrRa1k7rqB+X3Uo3V/x4r+SRIBddiSOB18qmsoe6ILNkNcFulTe9lsUCG/Nl9TohhFluX/I8svnnUTa1LWIPTxCqsv4qf76entCgzP4QzjOcBUoSQjTaQ8yaEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31686004)(6506007)(5660300002)(8676002)(4326008)(66946007)(66556008)(8936002)(110136005)(38100700002)(54906003)(316002)(36756003)(2906002)(66476007)(86362001)(26005)(186003)(9686003)(6486002)(31696002)(6512007)(6666004)(508600001)(53546011)(83380400001)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnVzMzc3eGVHekZnd2RZZmJNM0syR2NOMUpxMWI4OVF6ZVg1YnNHWk5qNXdm?=
 =?utf-8?B?amRDYXd1bTRxMFltVTZsUHlZYW1GdWVtVmhHc1ZTSVdsc1ZzeTlmTTFMZ1Vr?=
 =?utf-8?B?UUczQW9wUUtwK250b285K3QwV3hRUjNlSmgrK1BTMzIxcUlZZS9qS2RKWTVH?=
 =?utf-8?B?R2RFcFlFOHE5dzhTbk1EY0tVSFc5ODZuL05jL1M0Qk9NNEdYTUJrM3lZSGlt?=
 =?utf-8?B?Y0JHRGp0ZDBHM0xMN25JeTlqL0lFeUNCdzJ6UURDNk5KY0hRTGxneGxVSmk1?=
 =?utf-8?B?RGdWT2dIcG1nZVhRVXUzMUpOMU9HWHJ6d1MvbGl6SktmRWg5ODFxdjEzYTNt?=
 =?utf-8?B?QWNuVnR3a1pQTkVaRVBRZCtBNVJaajJiNnF5aitrZ1FGang0a21qQmtSOGMx?=
 =?utf-8?B?UjR1OFo3d3JrTDkxODl6RGlWNG5nZVo5cDJVemwzeXg2NlZxbnFuSEx1ZEhO?=
 =?utf-8?B?b1ZGMlpYSk95SFBOcWw3OXVnN1ZvSnJqTlNWUjRqeXlBbzltOGh5eWNpMmxI?=
 =?utf-8?B?WUFpZ2Mzc29wYlJhWFRxM2YyWU1ianVzdWhZSWZSNzhiT0crckRQS2RWVEQ3?=
 =?utf-8?B?QmdWTVQwb3djZEVlb3lqSjI0MEs2NzNuQzdvUERNT2NyekJ1L21ycEk1Ujgz?=
 =?utf-8?B?K0xscWw4dFc2THdWSHlacjhaZzk1TkNVc243WUlxVkxaMmFEMHRoTGF4K2Mv?=
 =?utf-8?B?cWtKUU9uSTRUeEtmV1l4QmdUT0dTTHp6Q0F2amQ4UGU2OExDS2lnbGU2R2Nz?=
 =?utf-8?B?ZWxtR3VvUVpVVEVPMUwxc2tNdVk0ZXRWbWs0TXord1hrSjNmRXl6SWxRckdT?=
 =?utf-8?B?VXUyUUFpL2VicnJlUTQ1cGtSc2VrRWhlVWppTThHOTZGaDN5bVVxUUhoWGRV?=
 =?utf-8?B?bEUzSWlQRjNRVFhBWkI2MTNvcWdxRE84OWNGRUVuQUhYUm9kVEpaT216cE1x?=
 =?utf-8?B?b3JXOHdlK2NtQ2l0NUFCN09UaGFWRS9QYVhtQTR1MVowVFJXcVVPOEs4RmlR?=
 =?utf-8?B?b2dOM3hscEVmZzFhcmhuTnhwYVAwV0ZHQlRYTC9iamlTcVNzU20yWEh0Y0py?=
 =?utf-8?B?UGtwVXF5cjBLTTdhbWkwVjd1K1drUTY0NGNqZk5YUkVNZUhoTXlHaWEvNTBw?=
 =?utf-8?B?bnBHamxhOTdjVGVyNUlWbitNeUNqZEtCZjFBaVc4Q2dZcGNOdTZsMitqWjRn?=
 =?utf-8?B?OHUwN25EcCttU2pGNzc2dzJPa1kzeC8rZEh6OHRCMTFUZzBaVXE2cEhaODdR?=
 =?utf-8?B?S2kzRHd1VEJJcjdhc0w1N2Q0UmFaZngrYzAvUVpuQ1kxZWhEL24xL1pPb0ZO?=
 =?utf-8?B?OEVsaE14TW9lMjhhZVNPQ1RPZXMzbXpoWXlERGsvYm5NQVhMS3AweVhrNngw?=
 =?utf-8?B?a1FGRGxvUjdjMjZRWGwyY0hvVUk2R3pwZU1BUGtKdVVSV1F6d1NiRlA0MlJV?=
 =?utf-8?B?TGVFZ25KYnc4UGRrREJmRTR3Ui80YloyVUszeGVVbHdudVJ5NFFWM2wvVmNz?=
 =?utf-8?B?aGNvQXdTRSs3Q2FHamQ0ejEvZ1ByRE1aMFZnZGxTMHg4c3pYdkRIZzZNdHVi?=
 =?utf-8?B?QnorMDNja1Rpc0syY0lVU2FseUxhSGZvb1VCeXJJb1cyNnpqVXVOMFMyQjFJ?=
 =?utf-8?B?azY1Mmg3YjFUMXd0bnkyclRjMmJBeVowYk9LNkhXQ3JvYlh1R2FIMnJ5MEdm?=
 =?utf-8?B?MzUvek1FR0dETzhVNEwza0lVSkhWd2tkeU1uK1pXNnJkZS93Z2luejJzOVJ5?=
 =?utf-8?B?MHlyVUtoZjcrOEtMOG81VVU2MXYrZmVQU1AyeDNOYlZSREp4a2IwRDhqK1hC?=
 =?utf-8?B?VWh2QjB0UmdnN1lpQXU0K2tNOHBoNlJnMWRqUDBuY2o2M2FOc1hCRERXd1RK?=
 =?utf-8?B?eWdhSEdlQ3NkWXJ3aWlQdWppcktTUzUrNHgrd0RkVGE0cW1OQUdKVkQySjQz?=
 =?utf-8?B?Z0hrYVdBVndsN0Fyakk5SkZGanJUMklRek1qazlLNndIYkxiY2RGN3p6c2h2?=
 =?utf-8?B?Qzg3MHF2NjBoSXkxUVdiWnNqS0hzVUhjcEduc3JXcllKa1J5QkY5M21mZWVM?=
 =?utf-8?B?NWFiR2REU2VBbGVNQitUdXZETCtSOGxsazRzM0xSYnp1VlZpYml4UElSK0tx?=
 =?utf-8?B?SmlIemtFMVFBK3MvT1FVenU5RU5sVVZWRjlUeUxvbXVUTlJmRHRDQUt0K25y?=
 =?utf-8?Q?2n21/3Ox0r/wGVlhELssw98=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea1f98ce-2073-42d1-304d-08da02bfabce
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 17:59:07.2646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JL4xwrKrXcxh48ouNeZG471rJniEG8qLoMjldCAFrwWCZqIPPSCfbLzEimFTWEO+Q381M/G8U+gwuOktrDy0HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2539
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10282 signatures=692556
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203100094
X-Proofpoint-ORIG-GUID: xM6HasTvV9Hi_OXYXgoMHRj9RzbNE2um
X-Proofpoint-GUID: xM6HasTvV9Hi_OXYXgoMHRj9RzbNE2um
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 3/10/22 7:00 AM, Bruce Fields wrote:
> On Thu, Mar 10, 2022 at 03:27:58AM +0000, Chuck Lever III wrote:
>>> On Mar 9, 2022, at 10:09 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>
>>> ﻿
>>>> On 3/9/22 12:51 PM, dai.ngo@oracle.com wrote:
>>>>
>>>>> On 3/9/22 12:14 PM, Chuck Lever III wrote:
>>>>>
>>>>>> On Mar 4, 2022, at 7:37 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>>>>
>>>>>> Update client_info_show to show state of courtesy client and time
>>>>>> since last renew.
>>>>>>
>>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com> ---
>>>>>> fs/nfsd/nfs4state.c | 9 ++++++++- 1 file changed, 8
>>>>>> insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c index
>>>>>> bced09014e6b..ed14e0b54537 100644 --- a/fs/nfsd/nfs4state.c +++
>>>>>> b/fs/nfsd/nfs4state.c @@ -2439,7 +2439,8 @@ static int
>>>>>> client_info_show(struct seq_file *m, void *v) { struct inode
>>>>>> *inode = m->private; struct nfs4_client *clp; -    u64 clid; +
>>>>>> u64 clid, hrs; +    u32 mins, secs;
>>>>>>
>>>>>>      clp = get_nfsdfs_clp(inode); if (!clp) @@ -2451,6 +2452,12 @@
>>>>>>      static int client_info_show(struct seq_file *m, void *v)
>>>>>>      seq_puts(m, "status: confirmed\n"); else seq_puts(m, "status:
>>>>>>      unconfirmed\n"); +    seq_printf(m, "courtesy client: %s\n",
>>>>>>      +        test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags) ?
>>>>>>      "yes" : "no");
>>>>> I'm wondering if it would be more economical to combine this
>>>>> output with the status output just before it so we have only one
>>>>> of:
>>>>>
>>>>>      seq_puts(m, "status: unconfirmed\n");
>>>>>
>>>>>      seq_puts(m, "status: confirmed\n");
>>>>>
>>>>> or
>>>>>
>>>>>      seq_puts(m, "status: courtesy\n");
>>>> make sense, will fix.
>>> On second thought, I think it's safer to keep this the same since
>>> there might be scripts out there that depend on it.
>> I agree we should be sensitive to potential users of this information.
>> However…
>>
>> Without having one or two examples of such scripts in front of us,
>> it’s hard to say whether my suggestion (a new keyword after “status:”)
>> or your original (a new line in the file) would be more disruptive.
>>
>> Also I’m not seeing exactly how the output format is versioned… so
>> what’s the safest way to make changes to the output format of this
>> file? Anyone?
> It's not versioned.  It'd be good to document some rules; nfsd(7) seems
> like the logical place to put that, though probably knows about it.
> Pointers to it from kernel comments and elsewhere might help?
>
> I suppose the absolute safest option would be adding a new line, but I
> like the idea of adding the possibility of "courtesy" to the existing
> line as you suggest, and that seems very low risk.
>
> There is one utility, see nfs-utils/tools/nfsdclnt.  I'd forgotten about
> it untill I looked just now....

I think nfsdclnt does not parse the 'status' field so we're safe to
update the status to show 'confirmed/unconfirmed/courtesy'.

-Dai

>
> --b.
