Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1AB40A689
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 08:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240015AbhINGOX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 02:14:23 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:30504 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237875AbhINGOT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 02:14:19 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18E5xeSa018222;
        Tue, 14 Sep 2021 06:13:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=fHanRq02DdqHMbdF4WS0Fk2bIRSMeezwI8O4MNulkTM=;
 b=H5t4A6m/1/W6QR2UImETkde1H387SfOlTWl2duFChe/dg0+EsqFv242FwNst0aXehTEU
 2mY1SSf0sn1BAalYb8lSabiXUeqH8SkYY68+UQPxAaH3jHtJTa6hXqJWVqFo9U1XOXu6
 5vzhkRb3lwtHh0IoenNgJ/19h6kxOp5V3HMVV8nC8VZz6PIb6bcsKs4a63JKwrqW735f
 ji6H+Y1kjys8Ip1IQNUmklYoi3g1XJxu7s7gsRLA4WjkXpOgecJFmqGTwnG2UqhVY2p/
 9hHbpHWbK/7TOtI0tB1r9wmWvokpbRk1lH21VWC8MkA/a2SAqZEKP4lPm2QVNAv0rbHM YA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=fHanRq02DdqHMbdF4WS0Fk2bIRSMeezwI8O4MNulkTM=;
 b=zeetB9G1CKO0AdDknldTmzKeXqaF2+FRaCxYipHoIqEUgVeeYqpywlLDncHXqOzvn257
 yI4NrXsrEDgIdD5f8N5UjA5nbJw4B3A3qsADaYgHJmc67VqbhtnzcllwLY0a/NsKP7yL
 WUmeTmt741RVTH5iWW+UL8G1/f001vLn51vO1oQxtrHFG9My7K7FA/dAHFcSRbFcrINf
 BcbokmVBIhJsaTGeZLKgSXA+TVhHUZcNA31Fo4liZm5513REQ36ooS+bd+iupYxgNrH0
 jxUGCpp+y9Wqe1U3NGeaq7F/ygwGTrnSG+laKJdpoMTuMg/TXIzu/uPT/F8O6i7+1j8J LQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b2kj5rddw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 06:13:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18E6AVsm168719;
        Tue, 14 Sep 2021 06:12:59 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by aserp3020.oracle.com with ESMTP id 3b0m95s5p9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 06:12:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+0+X2qLLBBDNO5lVUMVPFhjlZvb5jZRUaGXWB/weu2NSuzXbA8UWlK+qsI8XC80Wa+3P/kMh7KmNmlErYwhDPptxNgdfqXr9FK2MizLXIKR/pukuKvBVIa+HUjM/cj8Sm8LuzlUQ2vpbiY+6J6wUIpB1eM2Ewl9qjonRVq7+X59S4SQUeeO3a+yC+NztVHIs3z51bgcUpdR7DH8XiRdLXswiGDUVd21v6ulsg3s/kzQ6NDBcLPC2cwphxidyQzkZy4NzxilYNkPQjbh2CeWa12x1b5L6Qcz7RbpNTWp9DGLhsZJUxtVTkLt+AH14CEFlx/EmAQWRz6kNf+HZBCo+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHanRq02DdqHMbdF4WS0Fk2bIRSMeezwI8O4MNulkTM=;
 b=WYMqTcQiuA7Aaq4aBgl/KyZE6Pqz3qNqFPeMyVbNJapkiz8T4fgpD2YUSxOk2X2k/s2k696IvAG/czezMksVpfCLD5W6LnLw4XKA+/o1aLGBQtG2aZVtHjSXqz/BP7JOyJRV3COz4BBb/+hKExLs/KKzKrvtzbSWYZ/RPYw063A4YDB4jpQTngRNfZmxIjQ0If8pL1NYKT/40nmVEUER7YKoSu11wjr+K6G0YpmSradoPtXukXJA0XJxiaFxNUeomdvB90YoVzVIb/cf6zF5wOEM0vM7xXjMFoXtoFaQEXLQPNT71fFMgIxEvu6wvdjYG2k3eSw2aCx375uykZlwiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHanRq02DdqHMbdF4WS0Fk2bIRSMeezwI8O4MNulkTM=;
 b=BJED1QpjpFd2ihhC1H81cbhKjt5iz/JbCSuVqcCeWZlLiuhyhPW4H/+BHjAPT36E7mtxlcla7gEKLDhOIdTIS3lGdEH/U9R0tJ9QO4/Aszmos2f5HEPAeOkVPAqM5CqcI5rEZpwjiEaGzNdxbgn+0Vk1irJ+FPhbmSnHLKPHloU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by BYAPR10MB2440.namprd10.prod.outlook.com (2603:10b6:a02:b2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Tue, 14 Sep
 2021 06:12:57 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b054:cb04:7f27:17fd]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b054:cb04:7f27:17fd%6]) with mapi id 15.20.4523.014; Tue, 14 Sep 2021
 06:12:57 +0000
Subject: Re: [TOPIC LPC] Filesystem Shrink
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <3bffa6b2-981f-9a64-9fed-f211bfe501cd@oracle.com>
 <7F4D357F-152A-48F2-A43E-DE835BA6EAFC@dilger.ca>
From:   Allison Henderson <allison.henderson@oracle.com>
Message-ID: <d3cfe17c-6104-741f-7549-89c46dc691ee@oracle.com>
Date:   Mon, 13 Sep 2021 23:12:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <7F4D357F-152A-48F2-A43E-DE835BA6EAFC@dilger.ca>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0003.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::16) To BY5PR10MB4306.namprd10.prod.outlook.com
 (2603:10b6:a03:211::7)
MIME-Version: 1.0
Received: from [192.168.1.167] (67.1.243.157) by BY5PR17CA0003.namprd17.prod.outlook.com (2603:10b6:a03:1b8::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15 via Frontend Transport; Tue, 14 Sep 2021 06:12:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05b63724-4141-4058-532f-08d97746b235
X-MS-TrafficTypeDiagnostic: BYAPR10MB2440:
X-Microsoft-Antispam-PRVS: <BYAPR10MB244066F56E29D4F78AEAD66D95DA9@BYAPR10MB2440.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 51UYFxRwSqMiIy9xe5XRymSeOnnQ9xHG1aH1CKPjmKtsI8dg3ywLpUuPB2RIrx1p/PCMTU6Fh1JPYZihQaW06lembnqGA09TI5Y//NnDO+BhAz1Oq9j+5xPa491xIUl/W+ZysgONIukF4LWo9ht5GCg9dRkb+83n4rmhBxVa92w73/+i7nhCq0Eh8Kn1q+Wi5z7zfnLE8DMpxQT61nwGNF/Gr/ZthG2HV5bfnOMIeKRfEFtX/0eBlsKCcw67cV5e3/A8x25jgX627F5nCqoAwXWJUtypSjVJFIHNkFy4S6bG2x6VPjCbKkN9A454diRqC4jfug7OCGK5uIuwDlGFi1fpcroVtCUYCrw+CFKuDaQ0apWr0TJA4FIDIKS9uXv3ssxAAW+3rhCJmKb5absX0zi+7NeizrVz+oSIcNoULWW0GyA1f/6+kd2/PQwODI4X2jKTUt1MkBX6JWf/qJNxozLZ5vOWd000YGggmMozXZ9zOjNe3y3leDEuWU0b1l6hX0p5t2HnHW238f38scV0zyt+UVakvKAHn2nZwmSaDLU9/LMfFntGlLaVKk8UFjeftQgNOWRIHM/qI9G22XYTjzbKLYiFmZDjBfpvOpkzKsmTjxOfLLHY6diya40VOBPTPFGUQ0gtLkxeJI2HQG7Wv1eoJ1E/gA1hm3Hd8/oVEOLUICbdJnR+yWj96b8tIBXUmeY4lDPumrOIXxEebZWDZBhcME4q5FPXmRVYLgFQ8R1TBq4TV4WMpuF25G1MNzHRMQGAYIaC6TOL89p18lUB2jhJmSqyDHebgIyP188oVf/Npmwk6RMUWNBYXNCHc+3KhsgzCEY9XqrrBQVtqWfyFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(366004)(39860400002)(396003)(2616005)(86362001)(31686004)(8936002)(8676002)(966005)(478600001)(36756003)(52116002)(38350700002)(956004)(53546011)(83380400001)(316002)(6916009)(16576012)(44832011)(66556008)(26005)(186003)(4326008)(6486002)(2906002)(38100700002)(31696002)(5660300002)(66476007)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?ruqFcrXuZNIWolB0O3yhiOmN01B13BBPmqxmUVKiOnCtCXNjG1CARH0U?=
 =?Windows-1252?Q?oumgxQwHW8p/yPvzzlPAeBVGj8XbS+WAizhuBzOjMZNIvOHtD3U1uK1P?=
 =?Windows-1252?Q?VKzUYKoeiNFvlSAzL80km04i3ME7Yz2JzBHNY+ceDWpz/M2EwgMMtRWx?=
 =?Windows-1252?Q?vvcRBHmp4qaaBjFI72HUIRos+FJ2lulUGKyZpaM35JJyQ2Q0Zo/ifzRh?=
 =?Windows-1252?Q?b6nMRZUVuMw1h9g8YN8rnlLGzKmda0SmbAHBe2NbfG+diHlCxHj7grfo?=
 =?Windows-1252?Q?UKeNpvo0CThH+lciSVTiKg4jUooL1HjoagwqlP/auX3WV4yrQnc3dihm?=
 =?Windows-1252?Q?KOtLUgwyRMa22r2uMaJVHxHUgyvFD8/QCeZDL/QnneuHYyz4SHs3Wz95?=
 =?Windows-1252?Q?hO7GAgMCj1glTrZ8tD67dqKxbkAbLlJ/SXtzuO1Ce15zTCnKoCpeNRou?=
 =?Windows-1252?Q?F+l9I/3j2YWmqfgN31wNaSa7Ldi5obztQNUY7RninGRYqtRevZTc/qxY?=
 =?Windows-1252?Q?pOIgONcCS4e42rmhxglr0LOj1Czv+S9G+uCvATja/2G1h7YSxpi9mD0K?=
 =?Windows-1252?Q?SqGbh94md24iDT+YKPo3XszfH8+YtwG7WHXNk+0hQu2jPJo2kZjjDmL0?=
 =?Windows-1252?Q?tiN6C4l0I3irS9OgLXzYipysjaRcKdQ11pHZzKillx31s1dLgHwSCi6m?=
 =?Windows-1252?Q?bSF5RTvCAGz6tuD7jBzmtBGQh9E6NyYk6hc17BaqCht16Y4qB/++piar?=
 =?Windows-1252?Q?feHl+h5CbgfYXLLj85YOoBh9tGKDfDUQsWPJhJU1G71BLwSYJLAJ4FZl?=
 =?Windows-1252?Q?bhDD181eEKArImadbZmdRQYP3On9w0rKQ1JJrm8wkxwc9yh/jaxMMFTf?=
 =?Windows-1252?Q?+/cOq8F64h6KDPtcfFPeF/pQCy1STYOsSguZK3infVlbZSMeRHOyzGAz?=
 =?Windows-1252?Q?SQ1w7ea+rNy8MODtHWH563qdAsz2PYcS8NFT1qq7APWNeVANJ/4dir/T?=
 =?Windows-1252?Q?KWB2GZkDZRzGdsoDsQzQ+kcATOVuyRaiMR5zb1SZoCsZBYQ0LKpG2d9Z?=
 =?Windows-1252?Q?W6RdnF8sS/utL1jixZnzpfa4J8iYzvcJSar6DB83tupdnzXPhzOoCBDe?=
 =?Windows-1252?Q?j3fGIDN3qZ8D7zYewAofID5kCl4n/92K3z8aNRMhaJ6vIwNCSeFfC2ZT?=
 =?Windows-1252?Q?9IuV/7LAyToP6kd6wGrKHtLgdQvtJirsp0CtlsWFNAUpBQQ+IVgtqmQA?=
 =?Windows-1252?Q?Bh6uwB6qo8MmBdEh+TgW+Pe0+SRw855kG3Fv5N5imjFWaI0Va1mmhXbD?=
 =?Windows-1252?Q?CD07Q3hNAW8Rs991LmAX/mCIHNd9r/YXiw0cCfzuQx76dvT5LMp/YU2X?=
 =?Windows-1252?Q?o0v9SEjh9E/SBSWmTOkAxGSxBNj8EfFVbaGlHZi/OQDHfOeEm0UVQvmj?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b63724-4141-4058-532f-08d97746b235
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 06:12:57.3698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2KedN/VTc+AIqC47XbQSFIoqN2Oq+6l5xa3bRY6gTLkrbqCWt4IPiVeYOBk8zRFYHy5PN2syOztDk+uRGtGtnRiwmwXD7e4CSpLcdfCzRps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2440
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10106 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109140035
X-Proofpoint-ORIG-GUID: A00jlsSoyi_hPhYItW0w2fZJZ-g07wvj
X-Proofpoint-GUID: A00jlsSoyi_hPhYItW0w2fZJZ-g07wvj
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/8/21 3:25 PM, Andreas Dilger wrote:
> On Sep 8, 2021, at 1:27 AM, Allison Henderson <allison.henderson@oracle.com> wrote:
>>
>> Hi All,
>>
>> Earlier this month I had sent out a lpc micro conference proposal for
>> file system shrink.  It sounds like the talk is of interest, but folks
>> recommended I forward the discussion to fsdevel for more feed back.
>> Below is the abstract for the talk:
>>
>>
>> File system shrink allows a file system to be reduced in size by some specified size blocks as long as the file system has enough unallocated space to do so.  This operation is currently unsupported in xfs.  Though a file system can be backed up and recreated in smaller sizes, this is not functionally the same as an in place resize.  Implementing this feature is costly in terms of developer time and resources, so it is important to consider the motivations to implement this feature.  This talk would aim to discuss any user stories for this feature.  What are the possible cases for a user needing to shrink the file system after creation, and by how much?  Can these requirements be satisfied with a simpler mkfs option to backup an existing file system into a new but smaller filesystem?  In the cases of creating a rootfs, will a protofile suffice?  If the shrink feature is needed, we should further discuss the APIs that users would need.
>>
>> Beyond the user stories, it is also worth discussing implementation challenges.  Reflink and parent pointers can assist in facilitating shrink operations, but is it reasonable to make them requirements for shrink?  Gathering feedback and addressing these challenges will help guide future development efforts for this feature.
>>
>>
>> Comments and feedback are appreciated!
> 
> This is an issue that has come up occasionally in the past, and more
> frequently these days because of virtualization. "Accidental resize"
> kind of mistakes, or an installer formatting a huge root filesystem
> but wanting to carve off separate filesystems for more robustness
> (e.g. so /var/log and /var/tmp don't fill the single root filesystem
> and cause the system to fail).
> 
> There was some prototype work for a "lazy" online shrink mechanism
> for ext4, that essentially just prevented block allocations at the
> end of the filesystem.  This required userspace to move any files
> and inodes that were beyond the high watermark, and then some time
> later either do the shrink offline once the end of the filesystem
> was empty, or later enhance the online resize code to remove unused
> block groups at the end of the filesystem.  This turns out to be not
> as complex as one expects, if the filesystem is already mostly empty,
> which is true in the majority of real use cases ("accidental resize",
> or "huge root partition" cases).
> 
> There is an old a patch available in Patchworks and some discussion
> about what would be needed to make it suitable for production use:
> 
> https://patchwork.ozlabs.org/project/linux-ext4/patch/9ba7e5de79b8b25e335026d57ec0640fc25e5ce0.1534905460.git.jaco@uls.co.za/
> 
> I don't think it would need a huge effort to update that patch and add
> the minor changes that are needed to make it really usable (stop inode
> allocations beyond the high watermark, add a group remove ioctl, etc.)
> 
> Cheers, Andreas
> 
I see, thanks for the link, I didn't know there had been effort made on 
the ext4 side, I had been looking more at the xfs implementation.  This 
certainly looks like it might be a good starting point for ext4, it 
seems both solutions need to limit user allocations one way or another. 
  And I suspect both will have to deal with similar statfs reporting 
challenges discussed for the xfs approach too.  Virtualization issues 
seem to be a common motivator for shrink support in both fs types, so 
it's a good indication that is a worthwhile pursuit.  Perhaps then this 
discussion topic will be of interest to both xfs and ext solutions.

Thanks for the feedback!
Allison


> 
> 
> 
> 
