Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E2641A199
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 23:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237488AbhI0V7y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 17:59:54 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:20830 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237399AbhI0V7x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 17:59:53 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18RLZPkT021997;
        Mon, 27 Sep 2021 21:57:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=4trTbYw/jtfp7mYiILbIAivaOvtZ6QWuhRjUR8YH1tI=;
 b=hhwaaGGjFzayEa9ixKp1kp1xqTsZMXfPUEN22IwyUKguRCIx3fN9hM1XXsGEJcmsm92g
 coWUFs2xtGHuaEthErbjkGhS/A1Co9vbwgDwoPxRK5fdckd1KsVFdL4s0QSeN+FnwwNr
 rdXWosErgAGB8Jxg4t9dDkmmLy1hzMKt5WJde/r5biH6ZD3I70ugOoPiPHTIWPfnd2kl
 mvJ8rmkZshNQdM1j1VP2xTYy0akHAjoUh0aIGarQXTTfjWGhbfl002ZhnHuCtuljDuiI
 SebcyKfnNGltFKlBkgv20MuiRvzdv1+WisNbWugGVAbYAWt6D5fmuS8NDLmc0tlUeQP7 hw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bbejecp2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Sep 2021 21:57:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18RLt8pZ009319;
        Mon, 27 Sep 2021 21:57:52 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by aserp3020.oracle.com with ESMTP id 3b9x513663-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Sep 2021 21:57:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FjP/FIB9+H8dtg3mTQhh8sWRdfG+qlNx5OyNC2ONhwR77l7+ELOY++KEW9Q+d7zltCjb+NJkGglUf0wgQZz+sTrx6mBtkwpiFib1z+/FkQ2GMqTpu0pYVShO3ri90xmEHaYPPRUDo9P0cY7DC/tLZPr24Ro1zqF1YR12ahhxbr347bS9zM2CbKxDV77Rr6TA32xUpCZ482isFdjRcMx40Z9L2vpc6WAFQ07s0ZkxT4s2+E7+hM35Jk74WbvJFYgbmN6d/JL6LzLa+OurTIgCPjqOs7pmHzWWYHHdxav7SUCp2/Pp8qBEduBTJ1fhQUVDKKwLYpUxe9pkdU/7TREJGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=4trTbYw/jtfp7mYiILbIAivaOvtZ6QWuhRjUR8YH1tI=;
 b=Bz5J0AUnj6vAFCeZrJhvX/fzd4rH7GYSAwTAXAI/tjSGGq34WRxRz0PaMjcdj0PGmZcNnphhzW8eDirYJY1vfIIhHruOwAL8oBYgePRWekMdBL2TGLn0PN6NvhZCG6VkLtbVbuDmFvEc4+4pCaThQg85FOsAqhOGQzZbu5QcKK3aunIff3I1kcsPssODYmJqa2ZRn4f+s66kvozl+82tazaA2Z4y2OcGWo6Tp0TEeN2GYwlBKULqY6CUOsXy5+uT6P4lfiV4iu41j40xVstO5HXuC1nitYnseWwzCDYHvHZsBejkBnHrkfhDQFXRADTJm583WUYCaFUDrMyJH0e+6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4trTbYw/jtfp7mYiILbIAivaOvtZ6QWuhRjUR8YH1tI=;
 b=wVPGKgHNUVWQj/ADDHTIkUaliFIRnurY3GUh6po0ycMdyiU1k2b3RWJp5TQm7liPUWLUZa31GmrFqUmlme+C+YX0fR7f+x+XauNCyHJWKmZEExMnkLGeAY3mYnuHo8Nyxh65uoU7qdWqWNaP4d4cY8RMm4uJwXUHHzcbWmlG86U=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by SJ0PR10MB5566.namprd10.prod.outlook.com (2603:10b6:a03:3d8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Mon, 27 Sep
 2021 21:57:50 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::401:1df2:3e9a:66c]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::401:1df2:3e9a:66c%5]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 21:57:50 +0000
Subject: Re: [PATCH 3/5] vfs: add a zero-initialization mode to fallocate
To:     Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20210922054931.GT1756565@dread.disaster.area>
 <20210922212725.GN570615@magnolia> <20210923000255.GO570615@magnolia>
 <20210923014209.GW1756565@dread.disaster.area>
 <CAPcyv4j77cWASW1Qp=J8poVRi8+kDQbBsLZb0HY+dzeNa=ozNg@mail.gmail.com>
 <CAPcyv4in7WRw1_e5iiQOnoZ9QjQWhjj+J7HoDf3ObweUvADasg@mail.gmail.com>
 <20210923225433.GX1756565@dread.disaster.area>
 <CAPcyv4jsU1ZBY0MNKf9CCCFaR4qcwUCRmZHstPpF02pefKnDtg@mail.gmail.com>
 <09ed3c3c-391b-bf91-2456-d7f7ca5ab2fb@oracle.com>
 <20210924013516.GB570577@magnolia>
 <20210927210750.GH1756565@dread.disaster.area>
From:   Jane Chu <jane.chu@oracle.com>
Organization: Oracle Corporation
Message-ID: <b0861cd0-f5c3-6a56-29f9-cd4421c221c4@oracle.com>
Date:   Mon, 27 Sep 2021 14:57:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20210927210750.GH1756565@dread.disaster.area>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0034.namprd13.prod.outlook.com
 (2603:10b6:208:257::9) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
Received: from [10.39.219.78] (138.3.201.14) by BL1PR13CA0034.namprd13.prod.outlook.com (2603:10b6:208:257::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.9 via Frontend Transport; Mon, 27 Sep 2021 21:57:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4adcd34b-7324-4619-402f-08d98201d94e
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5566:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB556689864113ED1BAB808BA7F3A79@SJ0PR10MB5566.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uGRxahwSdsEnclDV2AK1jouk0muL8zwU3C9HkMOqruNzq22nkzNrXfpqgPLl32CgfhPvuVGWGGRWwdyXvaQ5oOc8IzuvTXf/+JWYlKMWlGsuFdbKKFeMcevBoqhhq13h67Up/2Qvl241wJqWyQN2meFTbCk70lY3jswB9wUi4g47OFUXU8/5mTjXLgZxwfwl4ZoOiyGFTOIZskVCDBkq8SyYKNLe6kW4AXJ1bL2ptJcFiGFA8+v0elPEynGA4VAxCA9uzgmkR39ePjva2HcvS0e7ZMSFZnt/mc1RSurJLcCRb1CMfYlKNB5AvJRWRaohAgM/ijT5E/VUSvYnwqNtvNI2w0mF8DBdrcyBHHFkXO48JwqB6KIfBc9jubLtZVUVdCWDmA32Ut+boKNO4IRa+pMA/mZa6JbobCLqUfUomrv7zS1i0fBKgprt5UyZH5Ot+5GZSqL6+WywmGIY3NF0AOhBXqbo9iN32wEghXYYzZeovJ0FSQG43WFtPqmYFtrrGskkN/QB0M/XfiaMkAJFh4fmgArGCX9G74fwLLqA4LIpWk5VkqOQOp9c70KxpyR/PHAStEf5ReZen//zxkR1UK+wFSJmSEf/k/Hld150risFuWEFP2o3UYD/Nu3PaXGwOhhIV1/dlnWcHmpDxKwDtjMoI0fzxFf10DBEp31MPfAGQT7ewHp8iaEKqfBvkaBJKhOLrOytAyBcpyhwqUs3pYDayyoQfCvMBo7cG0Gfe+Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(86362001)(508600001)(2616005)(66946007)(6666004)(53546011)(26005)(956004)(6486002)(316002)(54906003)(66476007)(66556008)(16576012)(110136005)(44832011)(8936002)(31696002)(5660300002)(31686004)(36916002)(4326008)(38100700002)(8676002)(2906002)(83380400001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elJKQ3hOMVV0S3JVNjM2ZGdkcWQ4eHdheDJTVlJhQm91SS8yTk1Ma3ZLci9G?=
 =?utf-8?B?NnBFbVBMMS8yV0hkUFJQeG9zTkJXdERKQjZ4RTZSK0g0ZU5USUhUcjkxcnRZ?=
 =?utf-8?B?YnpBUi9yb3FJbUVqMVU0RGhaejJKNWZTTEhjUlBWcGhKbFBLdzBPa2lISnpB?=
 =?utf-8?B?RCtaODdPS3dFSkNxWFp1T0ptVVRJaUExNEd5SngzZitBMUg4RTFuVkNLUTNB?=
 =?utf-8?B?NEs3c1MxV0VqSzJmU3NDc0laRzRYNUwwMXh2SkFyeTBrbVR6SVpSQUJRMm1F?=
 =?utf-8?B?bXM0UHpvVmpkTEpFdnJyS0taNjU2QmF2eHJmTHB3bk50eW92OGJ2SWlNbjJu?=
 =?utf-8?B?U25ZV3lhSk1RMGUwTmg0YTA0bDZ6dFg2R0RBUlBhTm1xaUxLSUpOODdpWEM5?=
 =?utf-8?B?L3dSYUpsOHpYczJOT0R2QWNLZFE2UE40VVFoRVVRUHhMZVZqZXdtK3R4bXo4?=
 =?utf-8?B?RTlLZEpSSE9USVRLekx6WWRTM3U4U0hJd1JXVW1aYnJqRFdMenFuWXVUN1VI?=
 =?utf-8?B?STFsQWxmNFBGM3VyalhKQU1ZSkhtQVVSd2t2ZVlZY1k1QW9PT0l0dll5alRj?=
 =?utf-8?B?enkwM2ZlbTJHdi9lMFVad0xEdlRsdS9YNzlUa0dHdCtkbFEvd3YwRGFSWW1t?=
 =?utf-8?B?dUZsZXFnK1M1cVJuNm1Qd0NybTA0WGVVb014RmlvVVJ0aWhrc21VWlRQSjQ3?=
 =?utf-8?B?NjBGQlJtK2NkdkVOK2hLNk5YRm93a3plQlc4ZURKVjM1UDE2aUtzU1FzN0dD?=
 =?utf-8?B?QnhKNlN1MjNwK0JoZXAzWXhRWEpnYXNscnF4S0w1SFEzVmozYVJBc2VsK1hv?=
 =?utf-8?B?Wll3dEU1bi9STlMrRmVyajZGSnJDMU5qODYvTytDeUxuSlVUUnh2aFhVUWFu?=
 =?utf-8?B?T2kwcXpHRy9ZZFhMSUxKU0N5U1hHMTA3STlVbFFwbjRZQ3lFeE5lVnpDcUdZ?=
 =?utf-8?B?NlUwc05salZKR3ZMYWozUllsck43akRoeTdveDVNaXJiQ2ErYUhnZEdtN21i?=
 =?utf-8?B?dmIxNjdRT0VsRnhMcXZ3NHVta21aSnlkUnBoNVVZNjMzbEl0UGhUblBXL2pW?=
 =?utf-8?B?Ump4Uyt1MXVRamF2cWVSZXRXakIwNlRjSkV2YUlDM3VnZXREZU1wTGhXOU5X?=
 =?utf-8?B?VXl2MEVFZUNydVZscGNKTmkybEM4YmN2VDJYYVFabzM1Z3EvNkgrU2wxek5B?=
 =?utf-8?B?bDIvOWFPZDR3VldiNHlSQld1OG9XcFNuZnpnN2xZQ2QwR0h1d0RsRFMzazhu?=
 =?utf-8?B?a25GeklqbzJXUW5YR25BdEdieG5MZVJ0eEllZ3p1U1BUVXZxTkRFSmZMblZL?=
 =?utf-8?B?ZGF0OVI5QnpjalNsYklBanpnQVROSTN5S09hMGE5TGxsL01vVHRUU2VlRlFn?=
 =?utf-8?B?WFBvdDlpM1lzeUduWUNIZmwvditUSzNpOGlLT0VRVFlGdFZsWEpTcXY2emsw?=
 =?utf-8?B?NWJFSmtqTDlnVVBwUWxsdS9NQm10UUZ1S1NaWTVhMFF1QXhYakdPTnNIUUJH?=
 =?utf-8?B?MUFFd3JLQ2FvblNwMG9lVWZRYkFTYjdaTjRaNEprb2duZ000SkRqK3RaV2M0?=
 =?utf-8?B?K0pxODJPcER2L2FkcXZuQUJlcXl2MG92SlQxenE0TFkxQ29OSmxCWE9KcUpG?=
 =?utf-8?B?Qmo5bXRoN3MvVGtYVVJuSVBSV2I0OW42d0tTYWwxSU9zdDFvdml6MDFmRTFl?=
 =?utf-8?B?NDhsTUpQeW1yemJRVDJiNitmMitWMTdqVG9GRGV5NXl1YnMyRW1uNE93OEFw?=
 =?utf-8?Q?jQZYONlsmaYRPDg5jotbMU1cs7o514vfFvyndrB?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4adcd34b-7324-4619-402f-08d98201d94e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2021 21:57:50.4258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uNjDanvG4Tl+HhDXcFF06nTQhkOLvaX+zFNjmqsm2y1hpiBNvdFgYDWkAExhfJ3KLf7Khl2EXciwd53z8vb5+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5566
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10120 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109270146
X-Proofpoint-GUID: CLaONnHQfN4qczxktcOrhK6emCSHs6Kp
X-Proofpoint-ORIG-GUID: CLaONnHQfN4qczxktcOrhK6emCSHs6Kp
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/27/2021 2:07 PM, Dave Chinner wrote:
> On Thu, Sep 23, 2021 at 06:35:16PM -0700, Darrick J. Wong wrote:
>> On Thu, Sep 23, 2021 at 06:21:19PM -0700, Jane Chu wrote:
>>>
>>> On 9/23/2021 6:18 PM, Dan Williams wrote:
>>>> On Thu, Sep 23, 2021 at 3:54 PM Dave Chinner <david@fromorbit.com> wrote:
>>>>>
>>>>> On Wed, Sep 22, 2021 at 10:42:11PM -0700, Dan Williams wrote:
>>>>>> On Wed, Sep 22, 2021 at 7:43 PM Dan Williams <dan.j.williams@intel.com> wrote:
>>>>>>>
>>>>>>> On Wed, Sep 22, 2021 at 6:42 PM Dave Chinner <david@fromorbit.com> wrote:
>>>>>>> [..]
>>>>>>>> Hence this discussion leads me to conclude that fallocate() simply
>>>>>>>> isn't the right interface to clear storage hardware poison state and
>>>>>>>> it's much simpler for everyone - kernel and userspace - to provide a
>>>>>>>> pwritev2(RWF_CLEAR_HWERROR) flag to directly instruct the IO path to
>>>>>>>> clear hardware error state before issuing this user write to the
>>>>>>>> hardware.
>>>>>>>
>>>>>>> That flag would slot in nicely in dax_iomap_iter() as the gate for
>>>>>>> whether dax_direct_access() should allow mapping over error ranges,
>>>>>>> and then as a flag to dax_copy_from_iter() to indicate that it should
>>>>>>> compare the incoming write to known poison and clear it before
>>>>>>> proceeding.
>>>>>>>
>>>>>>> I like the distinction, because there's a chance the application did
>>>>>>> not know that the page had experienced data loss and might want the
>>>>>>> error behavior. The other service the driver could offer with this
>>>>>>> flag is to do a precise check of the incoming write to make sure it
>>>>>>> overlaps known poison and then repair the entire page. Repairing whole
>>>>>>> pages makes for a cleaner implementation of the code that tries to
>>>>>>> keep poison out of the CPU speculation path, {set,clear}_mce_nospec().
>>>>>>
>>>>>> This flag could also be useful for preadv2() as there is currently no
>>>>>> way to read the good data in a PMEM page with poison via DAX. So the
>>>>>> flag would tell dax_direct_access() to again proceed in the face of
>>>>>> errors, but then the driver's dax_copy_to_iter() operation could
>>>>>> either read up to the precise byte offset of the error in the page, or
>>>>>> autoreplace error data with zero's to try to maximize data recovery.
>>>>>
>>>>> Yes, it could. I like the idea - say RWF_IGNORE_HWERROR - to read
>>>>> everything that can be read from the bad range because it's the
>>>>> other half of the problem RWF_RESET_HWERROR is trying to address.
>>>>> That is, the operation we want to perform on a range with an error
>>>>> state is -data recovery-, not "reinitialisation". Data recovery
>>>>> requires two steps:
>>>>>
>>>>> - "try to recover the data from the bad storage"; and
>>>>> - "reinitialise the data and clear the error state"
>>>>>
>>>>> These naturally map to read() and write() operations, not
>>>>> fallocate(). With RWF flags they become explicit data recovery
>>>>> operations, unlike fallocate() which needs to imply that "writing
>>>>> zeroes" == "reset hardware error state". While that reset method
>>>>> may be true for a specific pmem hardware implementation it is not a
>>>>> requirement for all storage hardware. It's most definitely not a
>>>>> requirement for future storage hardware, either.
>>>>>
>>>>> It also means that applications have no choice in what data they can
>>>>> use to reinitialise the damaged range with because fallocate() only
>>>>> supports writing zeroes. If we've recovered data via a read() as you
>>>>> suggest we could, then we can rebuild the data from other redundant
>>>>> information and immediately write that back to the storage, hence
>>>>> repairing the fault.
>>>>>
>>>>> That, in turn, allows the filesystem to turn the RWF_RESET_HWERROR
>>>>> write into an exclusive operation and hence allow the
>>>>> reinitialisation with the recovered/repaired state to run atomically
>>>>> w.r.t. all other filesystem operations.  i.e. the reset write
>>>>> completes the recovery operation instead of requiring separate
>>>>> "reset" and "write recovered data into zeroed range" steps that
>>>>> cannot be executed atomically by userspace...
>>>>
>>>> /me nods
>>>>
>>>> Jane, want to take a run at patches for this ^^^?
>>>>
>>>
>>> Sure, I'll give it a try.
>>>
>>> Thank you all for the discussions!
>>
>> Cool, thank you!
> 
> I'd like to propose a slight modification to the API: a single RWF
> flag called RWF_RECOVER_DATA. On read, this means the storage tries
> to read all the data it can from the range, and for the parts it
> can't read data from (cachelines, sectors, whatever) it returns as
> zeroes.
> 
> On write, this means the errors over the range get cleared and the
> user data provided gets written over the top of whatever was there.
> Filesystems should perform this as an exclusive operation to that
> range of the file.
> 
> That way we only need one IOCB_RECOVERY flag, and for communicating
> with lower storage layers (e.g. dm/md raid and/or hardware) only one
> REQ_RECOVERY flag is needed in the bio.
> 
> Thoughts?

Sounds cleaner.  Dan, your thoughts?

thanks,
-jane

> 
> Cheers,
> 
> Dave.
> 
