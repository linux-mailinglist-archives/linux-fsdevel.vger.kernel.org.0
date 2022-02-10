Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744384B167A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 20:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344056AbiBJTmB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Feb 2022 14:42:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235942AbiBJTmB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Feb 2022 14:42:01 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1693E49;
        Thu, 10 Feb 2022 11:42:00 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21AIXWK7027623;
        Thu, 10 Feb 2022 19:41:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=jwHFabDIaOgdchAVfdZB0+0vnHmLcPzOVFvSn4cBj1Q=;
 b=w7dAze0ZDECOuTLaLh682M9crV2OvWC5vnqReBKHJVmBJzDGy5PsqMOQ4aHPEvy0Vmxd
 7Qphld4zlXFVsbGh60HMK/3lNzAVEd5pOx3G3vsMUrfm8gJ/EMEyVk86Uo5EDWBly+gp
 4IT+m9tG+nLZePLdkPsqR9it7lSgonKiuPxA+g1xVLtPK1LSiDWOILqbZMHMW8Tgscu7
 9ResfC3fuDhHIgGpXjaw2Qbm2dCkWA7IcLEhM2rhXFlFc8SRsDvJGRauyG+CBEGissIz
 BmSxbPac5BzA65Nq5w8lBXbEQWyxuabQuXmhWwjhB+4/xRAKgC55auvaATzWn0WHbIWe UQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e3hdt15jd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 19:41:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21AJfuSU130519;
        Thu, 10 Feb 2022 19:41:56 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by userp3030.oracle.com with ESMTP id 3e1ec5pnmu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 19:41:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7rHlj4o7ZBsVyPMuQgQcWlWxSLAQjY0w2woRvgDa82Z6HL1qHZeaAkwX+8fQPmXQ7r0r0+yD181FzSawpaAU+5tud0g3TMCPrBM4OoxRw7sMjEoZd4PsnrUuI7nFfuN1avDaGD8JJDrD+2TT97B3y1J8MUD+6LKwPR8FAO9YOcnARHI6yB0XzgUTGxe2bUPqOu8IzAfm5EXRZsK1EWMT+X8DyQIlfH0LldAWzzaqGuEMD0jk9FYapqKK2DLOiSIjGOx5tU0EZ6eWPyoa521ugRqUiSCa6AmZttyW4tDUt6lFbeNzv5bcpMrRChnS57TYyRO87RgfNtFuNPGPR7tTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwHFabDIaOgdchAVfdZB0+0vnHmLcPzOVFvSn4cBj1Q=;
 b=PbrSB4xDdTeIqv3sw+0LJVdus4TmX6lM0QbUrJTtVvMbChupMREUkZDmYaT+dd5oBfqHbe0JMBsLz7MRmSwhAjriYRUMOcgQA2tDvEl99+LgGNrXFbQ4xqGgsUU5qjJbYXju94MzvKi5dklUJmDUDSjI3ZCVbQXQ9d+F5ePKCp4/xsNnfpbf9hvuNUNCela5YBA2wypOnKmzGMBDh0Qsal1sZWEeCOpQp8z7l6Vi0hDY9IKEf1SMXWSUf6J881q07A1frl5V45vil/LytK1CPb0PNj7u7KO1dGtilxXF7eNu7miEn/79CllWi4K4yhg7tyIWevhvQShj3LojsbtGxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwHFabDIaOgdchAVfdZB0+0vnHmLcPzOVFvSn4cBj1Q=;
 b=MXfMdMaOHIUQWDtSpBtf0eHJzZk9OzHkA/SNJlQyQooznA5dhzmdnM1HLaUhMtZwlU61fxbepwMAXPDZIOl1zfGcfTmLHGfgkPyH4QWkl7oGUqxWlieu8XwCsugssiZ+mc7z6sBKcfCKuGGCyqsrmxDS1S+UNcmN7anhLXiMpCk=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by CH0PR10MB4906.namprd10.prod.outlook.com (2603:10b6:610:c6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 10 Feb
 2022 19:41:50 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::89db:be97:ee10:a192]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::89db:be97:ee10:a192%4]) with mapi id 15.20.4975.014; Thu, 10 Feb 2022
 19:41:49 +0000
Message-ID: <47535edd-9761-f729-1d6b-f474a31eeafc@oracle.com>
Date:   Thu, 10 Feb 2022 11:41:47 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH RFC v12 1/3] fs/lock: add new callback, lm_lock_conflict,
 to lock_manager_operations
Content-Language: en-US
To:     Jeff Layton <jlayton@redhat.com>,
        "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <1644468729-30383-1-git-send-email-dai.ngo@oracle.com>
 <1644468729-30383-2-git-send-email-dai.ngo@oracle.com>
 <20220210142143.GC21434@fieldses.org>
 <c069bb1b0ec50358fc4d093ebd7482c7484d77b4.camel@redhat.com>
From:   dai.ngo@oracle.com
In-Reply-To: <c069bb1b0ec50358fc4d093ebd7482c7484d77b4.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0181.namprd05.prod.outlook.com
 (2603:10b6:a03:330::6) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8589ae0-47c1-42a8-1d7e-08d9eccd614c
X-MS-TrafficTypeDiagnostic: CH0PR10MB4906:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB49064E8EF04B5DC93350160F872F9@CH0PR10MB4906.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oFAOr5M6lsTayGCcQGmUt33U+Ar+4fPF0W5wpZ+eVB07ic/zxLX62RjNjLpSMFaHc0mh9WTNt5fb/cF93UIrTt5Miont0+qj09On9hMQ/svc0irkyQuZ/jB/r7PThGGRzdcsDyWHDq0eKTWwuLu1fpPLwqKdeOkO21xMJoP1GnIgpbmSwJKcSdGwntIFJFcanEhWnMxOQoWGdMW37V/5jJtWWWYuedPw4QFrAY4YScbzDsweuMDuzVQ4ANHv4BuDDxnIZcPi1mPoDYxKwe5iY5oEU8X1ruu5CksI+L4LjrAked+QT+znit5TS7XISk3XgPgDHDxDepSsvdKAuDQKa+mqwJLHb2jQV/CX12sC96mff+9Y1qcePvZp4D+hFlHLjqqDJ3RxJ0p+j+2ibjnc8EHyYO7M39HuNS+r2MqkTb85jlh1sldwvosc4F9tVOEY/+xrANNAUWlHMlnBsmrXsEL4JJ2Kr/m6bfowMJYjZJE57n51oLwXHzwphLFR5N1PLa1v/LoJHx+T7NB1rfRiKsq5MIXqxssWGePMxVJ7zW3YEg80Xm7II5JM79r8kay7QIaoCHlAMHjKmzhmJBmh/KlvH4O9zSBq5rYyIMYRZyM+Lucn5992YCy20eGYYT01YIW33hlJyGAYoQYmtHQ5dYnFKx4ZgW4EryhBGPDsxnNZLFxMcLfIdYgepUaT+sFgy/s268OO0coXDE5GnTpWwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(5660300002)(66946007)(186003)(4326008)(8936002)(8676002)(26005)(316002)(110136005)(66476007)(66556008)(36756003)(31686004)(9686003)(6486002)(6512007)(53546011)(6506007)(31696002)(2616005)(508600001)(38100700002)(2906002)(86362001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmQ1MUpNMjlvV1JSTlZ2Y3pxeXErK2hrdnJOaENaanJWbStZUGxJYzZNbVdy?=
 =?utf-8?B?SnpUMFM2UFpldUxVM2RuaFN0bUtuU3lzWHFKYUx4bWtWYlI4NEhlMFMwNng3?=
 =?utf-8?B?dmNNV0x0ZWVMRHdKWW83WVdreWsyYmtXMk1HYVFOQ0xpKy9ybDhZQi9EdEIz?=
 =?utf-8?B?TXBXQ04xanRiUlhxcFRyTDJrRlRreXdlMGJmR291cTloNHQ1SGFaQ2tDanR0?=
 =?utf-8?B?b2hCM0o0RzNLamNpc0R3T25RbjJvRWJkSktRQmpZbm5EYnlvdVVPOTVwNW45?=
 =?utf-8?B?K3UzMjJzZlBJNExuK21zTklyMXdZVVMvWUcyQ2ZBSThjcmJnWkg3Z21LWjNj?=
 =?utf-8?B?TTE4WUo3eUtiVXVaSStFQWR6Si9HMkFmNk01d3FiRytWWEhTaC9OVHkwNzZ2?=
 =?utf-8?B?dHhPZDNvbG55KzZ0YThYVDBGcGVYTjU0NUxOMFdvZ0JoVkJtQkduRzBEOE5C?=
 =?utf-8?B?WjlFcjN1ZGUzRTZQMU1YR0RzNG4yUE9FMlprdXh4QmZLblFxblp2UXBiRXBQ?=
 =?utf-8?B?M1ZsWEhFUjUxUG9kaDN0UVkzeE9tMnV2UCtKajRrZENzZjNvWFkvOEs3MU1a?=
 =?utf-8?B?SzhUYVByVUdFem44QnIzWGpRL3A0bXB3WWxSa2xLN1RhNkNlM3FFYS80MjZn?=
 =?utf-8?B?Q2RPMDZqaHBjY2orWDRLRGtQcWtUTzIxTjQrN3R3cFk1WWpQbVlmdXZoQlZh?=
 =?utf-8?B?SmIrZmptdFNDMUNFbG41K0hNTlF3OXhmTk1mbmIrK3Q3MGp2M2NNcG1ITG5w?=
 =?utf-8?B?Y0VNT2FoVkhOc1k0LzVCQURIQUV3YXFsU1NzRko3cDY1Nkg2ajRPd3RWaS92?=
 =?utf-8?B?YmgzMW50Q1REb0hNOXdVcERiV0l4YXRJdWhWc1VucFpLUzZaam0wbSthZElV?=
 =?utf-8?B?V1BaNmF5VEorWm1xVVlQaVRBQjVleGwxYngva3NISlc3MnM1U2hsc2RVZVNu?=
 =?utf-8?B?WjBuMnY4TW00dmVscmJFYWhRcUdZZWVVeUpYSXZ5K0FVL2hPRm9NWnlhcDI3?=
 =?utf-8?B?TFgwZ2t3RXNyWGovL2NvaGxOaHhsNmlNRUFtZzc3bjdKcnhNbC91VTJlSVho?=
 =?utf-8?B?cldWcEoxQnV2TXprNTRGUWRKUHNyTHBWSElvWDBiSW1MUm5wTThVZkoxKyt6?=
 =?utf-8?B?VU42c2Z6bS9GYk5WRUp5bjNjRjQwMDRDUno3VkN0S1R1RTJQNEFFYmZKWk9J?=
 =?utf-8?B?ZElRVnVjU2JaQUxSSE5oUXVkYU5ZSmxUbGpIQnBlZ1NqbXBadU8zQ2twMmxJ?=
 =?utf-8?B?VHVBVy8vazNobXAxbkNybGpZVWxPS2c4SGREVXdSa2c4dy9BditBeDg0SjB6?=
 =?utf-8?B?T2ZUcDY0bHB0b1FUaFY0ek9hZTZ1dm1oNElhdGJVVnR3K3FzRGRweXplaThu?=
 =?utf-8?B?MzdrTGgrbUZ5eWxFcm1ybHBxc1preVgvSnJnYU1ZRkpENkpMSzh0ckFjOXly?=
 =?utf-8?B?OHdBMTBxVUpFSUUwRFU2cGJUcXo2Y1J0ZzZqV2Mvai9CRHYrQU53bkdvSk52?=
 =?utf-8?B?Zmk4YWRBTjlmMFIxV2w2ZGwxVngrU0t3dytjSWY5eW50VTdMdFYvRi9RbXpS?=
 =?utf-8?B?b1BEbDRJZkwrOHRGWkxJL0dDN0JqR2RkcUl2WWFkSEd6TmFYUWF1M0EwajJF?=
 =?utf-8?B?TEN6U0hDWUVsUWcrajArd0tlaEFJMVJ5NVVJZnNBcXRVZXg1WUpqSXdLekQx?=
 =?utf-8?B?TzVTZTVtMm9DSVpVaDk0UmhLSmhXTEdETldNMmRkS0tkcUNOdEdOeFljSU4z?=
 =?utf-8?B?aysxT3o4SEFodmNxSjNpUFFYejVkQm8zN0doR3dGTmIzbVVkZTEvMjVnTEVR?=
 =?utf-8?B?RVQzSzlaOG05d1ZHQnZjY2hNbXlVUXdxakkyVDZ0Q2VCUGVxU1FhWVNNOVda?=
 =?utf-8?B?YWZMNGZDUWdJNkV1MzA3WGVRbkFLRW9NQ3ErS1ZrbHVRVU4zSW1vMzRmZWg1?=
 =?utf-8?B?bGpMMmlRM2pLejQzU1crT0htaDlPKy91YjBKL1kremtpMzFFZUdKbVI5UDh1?=
 =?utf-8?B?WVhBckhBRnBLcTAxRjBBTFdoVStmdlNwMEhFY3NMcFFjN25Ybndrak9IQVV1?=
 =?utf-8?B?bk5rSDkyNU9VNjlNVEFiekdObisvTnp0bmI0QXB1N1paQWRCZm1taVJCQlZN?=
 =?utf-8?B?WkNjdnlvVzIvU253UXUvUjJFUnBsZnlSQURmUkRIWUk3RnN4RTltQnZaYkdM?=
 =?utf-8?Q?pxxLg/FTczOjp4AW/bfJhQM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8589ae0-47c1-42a8-1d7e-08d9eccd614c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 19:41:49.8214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GS37SHMYh/lQICQGKgsF0r7SxJqjRu7q6/tatzHGK4ulC6csTYg5/l9Q3NkYbb4BjJzkuS++956FD6mZMlSJnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4906
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10254 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202100104
X-Proofpoint-GUID: gUnel8r1nyBmd0Iffc5fWYjwhrOPnGXN
X-Proofpoint-ORIG-GUID: gUnel8r1nyBmd0Iffc5fWYjwhrOPnGXN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 2/10/22 6:29 AM, Jeff Layton wrote:
> On Thu, 2022-02-10 at 09:21 -0500, J. Bruce Fields wrote:
>> Jeff, this table of locking rules seems out of date since 6109c85037e5
>> "locks: add a dedicated spinlock to protect i_flctx lists".  Are any of
>> those callbacks still called with the i_lock?  Should that column be
>> labeled "flc_lock" instead?  Or is that even still useful information?
>>
>> --b.
>
> Yeah, that should probably be the flc_lock. I don't think we protect
> anything in the file locking code with the i_lock anymore.

Will replace inode->i_lock with flc_lock in v13.

-Dai

>
>> On Wed, Feb 09, 2022 at 08:52:07PM -0800, Dai Ngo wrote:
>>> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
>>> index d36fe79167b3..57ce0fbc8ab1 100644
>>> --- a/Documentation/filesystems/locking.rst
>>> +++ b/Documentation/filesystems/locking.rst
>>> @@ -439,6 +439,7 @@ prototypes::
>>>   	void (*lm_break)(struct file_lock *); /* break_lease callback */
>>>   	int (*lm_change)(struct file_lock **, int);
>>>   	bool (*lm_breaker_owns_lease)(struct file_lock *);
>>> +	bool (*lm_lock_conflict)(struct file_lock *);
>>>   
>>>   locking rules:
>>>   
>>> @@ -450,6 +451,7 @@ lm_grant:		no		no			no
>>>   lm_break:		yes		no			no
>>>   lm_change		yes		no			no
>>>   lm_breaker_owns_lease:	no		no			no
>>> +lm_lock_conflict:       no		no			no
>>>   ======================	=============	=================	=========
