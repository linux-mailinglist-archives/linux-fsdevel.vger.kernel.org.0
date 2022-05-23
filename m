Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E50531AD2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 22:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238893AbiEWQ6Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 May 2022 12:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236640AbiEWQ6O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 May 2022 12:58:14 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF1E3B575;
        Mon, 23 May 2022 09:58:13 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NEoPFX022811;
        Mon, 23 May 2022 16:58:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=6S/Nv/8uqObsCKLERkjbzNGKQTUT1eqea+1ZzkxrOnI=;
 b=kHb9w6++d3yQA4bGsXDI/bA0ByTkhVe99BlgUL5eaMcAI9uYaa4wT6L9FmmhR80cfBcm
 oTgneFGkY0hRO+QhEepfQ7SsIidoKIyzPOKI7CzEejMboU5HsXqfIObUIjp6avTVaERI
 5nFsV5zIern3TiFkK5ODmlTR/3m6gZSYKXLztkJyVkHCCq4xeSTeY/h33c13u4ZsQCK3
 cuDIFj8ySKvzrL9JJpde6oicn3K8LEiThFQwNyutE1rvQVx/wykI6h6nrTX2U91/Sicn
 9sa1MkleShM/Ily8g9Q8fN/shdfQ0vfyqzkGfBp9KvygRyMD7S7aV0dVHhiLBpoNz4tV dw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g6rmtv02s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 16:58:10 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24NGuHN8002578;
        Mon, 23 May 2022 16:58:09 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g6ph1sf80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 16:58:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGfAGYt75dB92uQ/h1JnwOK4oiyUJvvxG5HGYjdb6yhm8HHYWY6iVH9Ij9OM/2+nOzfDTmjlnuEOWQRoJ5quAWm7ef1/rrmcOvf+KzlCT1kZjl9lo7/m/11W5te8m5Z+ycj/tg1eE+Zjjlq0VPFm9nlUAApOvTSQn79JK0IblyxVDLnM7HrrgOsx6K5fhSG35jbKeVVaV7nmLNwnDp+BD/zoaR2qCzg6drvBWQpHkTdlfY6PSSMj0sdf7uRQRO4wUV94fPxEelYTZIIpxjUsRxfbGMRjn3i2L1FcZOG3MgCQS3XR0Yv07j1PuKjOwNvaMhJ+bt2yS+1PAx6XrMy7bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6S/Nv/8uqObsCKLERkjbzNGKQTUT1eqea+1ZzkxrOnI=;
 b=XeaAk4o0VH5dcbLzmjkvolM7HOic8PUM8RYbvOwUYK5JgiS2IDHbXZDAij6KtBCL+PnYEAUqnYC6i6asCMK/xvyfa/OzD0QCfp9FZBPcuH7/DF7L1RQoaN9294LwcinTGl3qNXNSjeaI4eCkerqvujLxcyRprnaAxl79I6H44BUhlmHJ+QpSBa/TvORfcJzsYL2NWo2gXhvKWtu8+KyWmNoC35XIBgxlfiL0Pal69mhflBVS1xRFoNbK8tukYvjbWEu6OTFljb/dQX0zmdlNDMkADS8r24Hd7NCF3cnqwO8MX1QT640cw7dEKmQZ30L7O8JSKKFftA28gMnlCEq06A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6S/Nv/8uqObsCKLERkjbzNGKQTUT1eqea+1ZzkxrOnI=;
 b=BEAISdce2l6/ibEZWtNUPoyEepHouUOh3rPwS1UQxK+makcoE/K0X+RpZNxk/7arXhYmr1HjRRkyr0Y7wkVm5ZHfqCBJnW3KWbh/vZywVXK3dMB5q2NL9lr3HhxVN6VK4jL6YoTI5n3afUYcb6p3Otbcgd6cCbs3NjX4Ztplcms=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ0PR10MB4751.namprd10.prod.outlook.com (2603:10b6:a03:2db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Mon, 23 May
 2022 16:58:07 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::3584:4c8d:491b:33a9]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::3584:4c8d:491b:33a9%5]) with mapi id 15.20.5273.023; Mon, 23 May 2022
 16:58:07 +0000
Message-ID: <f33ae93b-ccd6-c8db-9646-251512f5b096@oracle.com>
Date:   Mon, 23 May 2022 09:57:56 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH RFC v25 0/7] NFSD: Initial implementation of NFSv4
 Courteous Server
Content-Language: en-US
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <1651526367-1522-1-git-send-email-dai.ngo@oracle.com>
 <20220503011252.GK30550@fieldses.org> <20220503012132.GL30550@fieldses.org>
 <9b394762-660b-4742-b54a-2b385485b412@oracle.com>
 <20220523154026.GD24163@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20220523154026.GD24163@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: RO1P15201CA0007.LAMP152.PROD.OUTLOOK.COM
 (2603:10d6:4:15::17) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e58de08a-95b2-4f00-6906-08da3cdd68c2
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4751:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4751CA369AFE492EE520E1CD87D49@SJ0PR10MB4751.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8p0Ag6bf8aBnnXPDhVhz2Jm7nguUQ9cLkhqo3dQrFsIL3HMWwVw34FCZ+r7fel32troitHk2eSDB2busk0BM/D0XScQtlu7kB2ApHwxnTcY5J7rDcYW/9yrR//W1l7dqCPMds+RI3Mog8RDYwhc1BWVucSojqShCJBHNx9SO2/nYTp2djdG3I3xA8rc/81uzneYq7xUeWw+rk4XwF6EAzLFUGFCGg3j32MTjYj8uBNYwIB/DXIDln5qG5jk8Ua4EH9xzXL9NkxbFbmLtq0/OBBFZvtp+KS16NiM+O0YAAiXAOuKEJlxdUZeMnHKOXn3CV34FXXO4vsaIxJDNKOoH/OSnJjDbnIsvv3Vtg7+UyI++beQwiHbbQzioq5tvutfMy5tNRHLLgRlZA80dR1VFqb0fHojpL/DVsFALNC+zEUVIZvQPDAFmhRXoREnBFZ8ndtqeMDgYZ6XqadUXCaIy3i6PFqLE2r3e3KyYsE1BP0KVm+/gihXqJOHp+9GfD0och3TatuFP18fFpJwQs3lZI6sTcP1hluvIMqYclpHzmd9W+jvTV9I3QCP15pysUgWS/QaQKZcnvWfJZtSQ/xnoKLZ5cxy4GVG86lzssW2bOLLXQ0tZc3pk4MF5Re2eBlY0WNBnZ1FuBrc7DtFlG4lVoutBshROm5bH32OTHFihHF5Bk7kAfbgiK7H4s+kQeE73JLLxC+KAX06cR2pfLxA3Aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(6512007)(9686003)(6486002)(508600001)(31686004)(36756003)(5660300002)(2906002)(6506007)(8936002)(53546011)(6666004)(8676002)(4326008)(38100700002)(83380400001)(6916009)(316002)(186003)(66946007)(66556008)(66476007)(31696002)(86362001)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3NHZGpuclgwK2VId2d3c2xoRzZjUDA2dll3ZTkzb2RERUpwNldia285VDU1?=
 =?utf-8?B?SnFZUTE5NTQ1Zmxmdm14cFlsK0dHOWUzTWJiTmF3bUMwN0JtNzFaN2lFeGQw?=
 =?utf-8?B?RTRseE5IbzR4QkdvR3FWY1l4Q2Y3VElVYVNuV3hSRUhFbkp2RVZQMUhiMk1j?=
 =?utf-8?B?TzVhYmtJWXNrNjlHOEhTZ3ZETzlRYnFvbmU0QjFaY0lpZVJUZzIrSitHb1Zj?=
 =?utf-8?B?Smk2a2UycFdnNFVCOFlFY2srMWM0VkU4Nm81Rm42dTNROVIvdmRzS0tpY3dN?=
 =?utf-8?B?cnNVR3FBa00yOE5kQnZBZmhnVTdpSWl6SWI3bm1NaVdsYks1OEl4RzNHSUEr?=
 =?utf-8?B?OG51NU9MMDAwMllnSm4zbVVJQmZsY3R0ZEMrY1owd3NwdjlYR3BFeGtJTURp?=
 =?utf-8?B?RFJtQUxyR3p2RFk2WjR2eEt3ZVlzNUlNVi92UllNdXRQeVdyQWtqMHFnbDZU?=
 =?utf-8?B?MTg4bHFQMzVJeGxyMHhqU3IyOEtFbktFVGM4RklzSzRURUYvSlN6QzlHK0My?=
 =?utf-8?B?VVRGWm8wQmF4ZHRVOTFJOEE0Z0NmSzZVQkRiR2cyTkdobFA0dWx6MWRvT1Zr?=
 =?utf-8?B?RG9ocitOTFMzdDkwekZoaUJEa3RWa3ZwQXhCcU9BcFJoMmlvemt1MlhmYXlR?=
 =?utf-8?B?ZEVmODZ0TEwwYTBZOWJSOGZaUUtuY1Y0NmpZdGxiYXZjZWVwME5aeW53emhT?=
 =?utf-8?B?T1ppRGNpWklWNFY2RWp5VktzbHFBTTIrdzVFelFtamxrZmp4ZlFaZ28vMStm?=
 =?utf-8?B?Y2JoY1RpZE01MHRZZEtyVzd1NnZjWGFzUTF4dUhtcVJnT2JoL3JnN2tyZ1F1?=
 =?utf-8?B?TkVYVmdpcmdWUmlWZGExdFJwMlE0ckNBcUk1TlNLdlhKZS9HWHB2TEJNenBq?=
 =?utf-8?B?c1VjUHEwTmdjc1N4T0w4blU2TENpQUR4L1BmUVNYOEdZUWFESWNWQUpSOERP?=
 =?utf-8?B?ZWlEYWRoYmo3eXRuNDNLYkdQUVkyL2FnWHVCcWR5eDRqcUgwNXI5elVJY3J3?=
 =?utf-8?B?aGREY1B3R29BdDBDR01oOUVxT1BBUHlKV2hnU0I2OGZxNkpZVVZDT2puRW51?=
 =?utf-8?B?MmdhYzcwY1hydGRFU2h5UnJwb0tKUCsrSDEzQWRBMG14UUxTTmVwZXNQUndJ?=
 =?utf-8?B?RUM5WmhscEtPZEJOSGpVNmhrbmhHTG1wVHFYdWFXTVlncjBzaHpIZG83aytN?=
 =?utf-8?B?dHdndHh2V3o4eitTb25oNUpkakZpNC9mYlBMdVFJUllwZnd3OHFFZzdhcGlo?=
 =?utf-8?B?bGxOZFVuYjM0SEQ1QUw4YVJlTjRIOHVrbUF5Q3c2QTNpNEtYUjdvSDllUWdr?=
 =?utf-8?B?TytVNUhXYWhRS0w4QWwwbGxFa0lzd1VuQWp6eUpUYXMvNUZET3VhYnhCSjk0?=
 =?utf-8?B?Zk1JYll6SmJjNE9vZ1RNYU1YeHJKNi9mQ2tVVTBRMVpnUzJQQSsxdFpLU09E?=
 =?utf-8?B?Ykx0NzdNd3oyMlFySmVPYlVFL21KejF1eWN6czhjM2VUeGU3Z2tkQ0gzNEkw?=
 =?utf-8?B?ZHlreGVONGRRRGFFbW16Vng1Q0VsVlp6MmlRTEF1b2ZzVmdsY0FmTFdERFVu?=
 =?utf-8?B?dGUwTSthRDRINUkrMitZK2ZyNm5DWWtRd1VHWmFtRXBpeWlGYi9KMFlpRUVY?=
 =?utf-8?B?bmRkNGU3ek5tem4yTmMyb1ovTXlBbXZLZ0FraElHY2JVbkJCMCttbHNXL3Az?=
 =?utf-8?B?eXNVV09RbE93dDF0bFJVcm1yY2F1UEQxOGF5Vmo3QWFkdjRobzB2N0tXQzZO?=
 =?utf-8?B?b1R4YzkrMWsrd2YwQldxbjZqeUkyaThYWFFidC9iRXFYeUNuK3FWRzhleU9P?=
 =?utf-8?B?R1RSVXlramhNRkorbFkwZEJUeG41S2tlL2FCSXdPZllFdkVxRFBQcE5meHhC?=
 =?utf-8?B?V1ZXWEUxOWF3bWl4SlBjRGxrUit3Wk14cmRPdHNjQUMyZGFxcGRqVkFYUCtW?=
 =?utf-8?B?U3ptVUVPZGQyeUpncHl3cWE1T0hXT3dIV0RwaStFek0rbDU4eGhqYWFQR0Iw?=
 =?utf-8?B?dnNOUE9BOURia1pPZCtNYzhrQVdVMlpKeDg5RHV6VVJ6RlpYb0MyNFQ1OEVr?=
 =?utf-8?B?UnhmOWdnc0loR284d3FIcUJEMitQblB6clU4YmpDMnFlODF2UC9MNHVuVUdL?=
 =?utf-8?B?N3hkU0U0KzRoUEh2YU5tRDlyQ0ZxenJTeDFPVDE5bGZvcFNETDV2eG5xVUZz?=
 =?utf-8?B?ZzB4YndKMUNwK3JiWEduV1NFcjhXSlFWRDRXU1BjY0dSQUtGbGZ5VHdjb29m?=
 =?utf-8?B?dzREdWwxa2dleFJtVVR3NXF5c3IyOHZ5Q1JBdjk4bXVyRnhNR0tXK2x4QS9s?=
 =?utf-8?B?VWxISWNseW5HZ1FXZnZweitpT211UldneCtZV0wzUVByK0lBK3hTdz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e58de08a-95b2-4f00-6906-08da3cdd68c2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 16:58:07.2484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W5eTVxe6sA0mkdhrvfhPh+OSxRbiuLU7OKKqLfn5FtJG7rlDxsHayHV8LVEkoy0feeelfx8iiJZ3sYpsQ5MaKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4751
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-23_07:2022-05-23,2022-05-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205230096
X-Proofpoint-GUID: 0BF3-ym4jYnTkGPBGXJ0dMV1-nI3oXKG
X-Proofpoint-ORIG-GUID: 0BF3-ym4jYnTkGPBGXJ0dMV1-nI3oXKG
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 5/23/22 8:40 AM, J. Bruce Fields wrote:
> On Mon, May 02, 2022 at 06:38:03PM -0700, dai.ngo@oracle.com wrote:
>> On 5/2/22 6:21 PM, J. Bruce Fields wrote:
>>> On Mon, May 02, 2022 at 09:12:52PM -0400, J. Bruce Fields wrote:
>>>> Looks good to me.
>>> And the only new test failures are due to the new DELAYs on OPEN.
>>> Somebody'll need to fix up pynfs.  (I'm not volunteering for now.)
>> I will fix it, since I broke it :-)
> By the way, I have three more notes on courtesy server stuff that I
> wanted to dump into email before I forget them:
>
> 1. I do still recommend fixing up those pynfs failures.  The ones I see
>     are in RENEW3, LKU10, CLOSE9, CLOSE8, but there may be others.

I had the pynfs fix ready, I just wait for the courteous server patches
to go in 5.19 then submit the pynfs fix. Or do you want me to send it
out now?

>
> 2. In the lock case, nfsd4_lock() holds an st_mutex while calling
>     vfs_lock_file(), which may end up needing to wait for the laundromat.
>     As I said in review, I don't see a potential deadlock there, so I'm
>     fine with the code going in as is.
>
>     But, as a note for possible cleanup, or if this does turn into a
>     problem later: vfs_lock_file could return to nfsd4_lock(), and
>     nfsd4_lock() could easily drop the st_mutex, wait, and retry.
>
>     I think the only trick part would be deciding on conventions for the
>     caller to tell vfs_lock_file() that it shouldn't wait in this case
>     (non-nfsd callers will still want to wait), and for vfs_lock_file()
>     to indicate the caller needs to retry.  Probably something in
>     fl_flags for the former, and an agreed-on error return for the
>     latter?
>
> 3. One other piece of future work would be optimizing the conflicting
>     lock case.  A very premature optimization at this point, but I'm just
>     leaving my notes here in case someone's interested:
>
>     The loop in posix_lock_inode() is currently O(N^2) in the number of
>     expirable clients holding conflicting locks, because each time we
>     encounter one, we wait and then restart.  In practice I doubt that
>     matters--if you have a lot of clients to expire, the time rescanning
>     the list will likely be trivial compared to the time spent waiting
>     for nfsdcld to commit the expiry of each client to stable storage.
>
>     *However*, it might be a more significant optimization if we first
>     allowed more parallelism in nfsdcld.  And that might also benefit
>     some other cases (e.g., lots of clients reconnecting after a crash).
>     We'd need paralle nfsdcld--no idea what that would involve--and I
>     think it'd also help to update the kernel<->nfsdcld protocol with a
>     separate commit operation, so that nfsd could issue a bunch of client
>     changes and then a single commit to wait for them all.
>
>     That done, we could modify the loop in vfs_lock_file() so that, in
>     the case where multiple clients hold conflicting locks, the loop
>     marks them all for expiry in one pass, then waits just once at the
>     end.

Thank you for your notes Bruce, I will keep these in mind.

-Dai

>
> --b.
