Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB22F3234F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Feb 2021 02:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbhBXBJV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 20:09:21 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:54714 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbhBXASd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 19:18:33 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11O08UX6004592;
        Wed, 24 Feb 2021 00:13:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=+Ne8CYPzPQdf5wdDrRYtSqZ8q7MyyTT/Unft49OssfA=;
 b=EEGe1LHG6n7TAeUw+8iPsxlsuM/jQlAZz6nJsoYGdMv2Y87I7TV/DZ1SrQw5hLpVk3Sc
 RHRKgY8i90THMT8mNt6i5w0fHrj+0M0f4W1mq6EYu7aePyEwjlHAGGqoEq67+ZO0Y/7I
 vfkxuSq59jhmGzfARVetwbq5Sbd5r08viJdoVbuibo6tMz8jbmrPE1jHVYy5tSTLwLiv
 /EH/yU4YjFhZzm96bf3AEI4bMBXqvsm7EzFIDR+eihisuLRu4zqlasf58Zlo6h6cWb/5
 /LQ28gov+UbG2STk11nyuZyW8FnHPav1SpeYGAatU2+O0Ke++jLh7lCzBP3lA5VJr0rz NA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 36ugq3g3wr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 00:13:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11O0AZ6w033855;
        Wed, 24 Feb 2021 00:13:08 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by aserp3020.oracle.com with ESMTP id 36ucb02f6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 00:13:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNc94tI4ve0zUNb9+hJRg4Q3l/zFcWPORNWyz3bAhPgdcUKNuvqkCHsez+GD44VtJH2iE512/P2Z0fX+QO//wN70U9/zVEc0pXPnD2o8onfG25QWEMGf0L1AdZOQX/NE1JAvv2UisX7M+5EPWcI0ZfH5uZc4zaDXgratYAzYtcnqpl9ttUJqvAoJgBU8oHVB+ZeAANRo5x+KQi87wAMv3OrY+eMu+2WsfgvhCvu8uztg7lk4usKJ0ot/yYXV2Ota9kij6lfPaJyWm3LTOLO/JN2ldNKISW1aAfj1+M8Y8rTntHZsI0u9IhMBIOAuLnrOtAa1PNRR9XQmiiSSEEwKBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Ne8CYPzPQdf5wdDrRYtSqZ8q7MyyTT/Unft49OssfA=;
 b=gOjqcSGHoxTpF/4CbJ54tB7nXCRm/9iYeEYolSw92OhOoZwqDhrpYgMp51GaM9aSK2VCvK+7oSsK9dHdumSgrndL1b+Ukx5aS2BWq7r3+jXZ6UgOOcZQ2/isue4TH7y4Ovh2ixc257bTC2SngZ9+pEpJp54u1lCMUSowmKEgtj7HvH7l4aQoFGmuUTuZcg/Yywj8dnWld1Njwj9T3GmagiJ++LXJ31u0msbv5V7x3198MzgIscax3Nzcumq21/uDjZWZmYVF9c+nWcD7uAVHCc4PagucIXbCbKy8ZnuZQeYpf9n4l1DHZQM9kJ1QWmQqm0WZEl85j/+QOCKfG1OGhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Ne8CYPzPQdf5wdDrRYtSqZ8q7MyyTT/Unft49OssfA=;
 b=Yr28eUdnWbg0aQVvRUevdcLtgM6PUgoveBXy96szHySD7CET2CzP0wwssUlg+LXW+1p9ZU8Tm5qVRUs+Pgk4PCATGst8vhMZch8iaqreV0PmRUyV7SNRi/g/PA7983VDJR87cO6LDPlSNRFsw+Jo9MYy3KVskQ/8++maB4kX8jQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ0PR10MB4558.namprd10.prod.outlook.com (2603:10b6:a03:2d8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Wed, 24 Feb
 2021 00:13:04 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::a5bc:c1ab:3bf1:1fe8]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::a5bc:c1ab:3bf1:1fe8%6]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 00:13:04 +0000
Subject: Re: [PATCH v8] vfs: fix copy_file_range regression in cross-fs copies
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Luis Henriques <lhenriques@suse.de>,
        Jeff Layton <jlayton@kernel.org>,
        Steve French <sfrench@samba.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Olga Kornievskaia <aglo@umich.edu>,
        Christoph Hellwig <hch@infradead.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <20210221195833.23828-1-lhenriques@suse.de>
 <20210222102456.6692-1-lhenriques@suse.de>
 <26a22719-427a-75cf-92eb-dda10d442ded@oracle.com> <YDTZwH7xv41Wimax@suse.de>
 <7cc69c24-80dd-0053-24b9-3a28b0153f7e@oracle.com>
 <7c12e6a3-e4a6-5210-1b57-09072eac3270@oracle.com>
 <CAOQ4uxh2E2oJjHoOBY3GU__6UcjE67E7qR1uMus7f_xhQyM54g@mail.gmail.com>
 <72c41310-85e4-16fe-8d9c-d42abe0566a9@oracle.com>
 <e3eed18b-fc7e-e687-608b-7f662017329c@oracle.com>
 <CAOQ4uxg4diJwpdhUydZ4rtCo2vv0uKwXmr1QiybLt0XVFOB8Eg@mail.gmail.com>
From:   dai.ngo@oracle.com
Message-ID: <55606452-b4f6-a42e-faff-796fdd295730@oracle.com>
Date:   Tue, 23 Feb 2021 16:13:01 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <CAOQ4uxg4diJwpdhUydZ4rtCo2vv0uKwXmr1QiybLt0XVFOB8Eg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: SJ0PR05CA0132.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::17) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-154-141-126.vpn.oracle.com (72.219.112.78) by SJ0PR05CA0132.namprd05.prod.outlook.com (2603:10b6:a03:33d::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.13 via Frontend Transport; Wed, 24 Feb 2021 00:13:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7489838-15d0-47dc-4be2-08d8d858f415
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4558:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4558D43A157E5B0159F977A4879F9@SJ0PR10MB4558.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Do+Pt6cAINzZGGryimNoYo1w1YQrMVPM1KpQZ2xXeXA6pqyjCQj+xQaGc5GQRrDiFwx+Mict3w86SAOh9C4SC8f4ySDs8XUu8nn/tfPH7NjG748j3kg0gkBkRreg95fXcqNY/kTZSYVq7JEqCTc49Js5q2R7klDxofCzQOp2vjyKmymscAa86z5sJaskELFpEA8gclE0UnSyy6BsGAy6D8RWyEdslX7g9t+HflbNJi58HXryIW4CRHB5jlVRf+/ymLyrBzUs3/R6kQtaOMP+peBayKKHUB+ehGtGq85XLeuYPh6jjG/hH6gqbCdsXax/iyLRkAP9eZVaYSNvDyF9YuI45xF1xu+g4a8a6Nj98TnRhA0HED0bByzm+BnsrgceWetDHlnKZNoTklvgUn6hWpR+GcaiqqvmU5VpSOh2D9IXxx9HlvU4lQEJVPes0OKyB9sEo6nf09rRcaBUiLaCQueYISwD9VbuclIjQdbNfqgAFzp2oASODI1t5Fi6ua/aiFV2kKGZc/SYCgRpK8TWq1mLnx5PEPC73vG+8PSG7yDH9o/wWozJQOLsf3nuzY/qEXL5RW8T/EfT3Avp1C/lB1gj5jXojthUXMosJQ4jz8XBn96SzPnbTXNbdCJGUkqsXChLClLffq5PefdYH5QyTraV+JP1vUuqXcSKSSAHlQM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(396003)(136003)(346002)(366004)(8676002)(53546011)(8936002)(6486002)(16526019)(9686003)(4326008)(5660300002)(478600001)(186003)(26005)(966005)(54906003)(956004)(2616005)(66946007)(66556008)(36756003)(30864003)(7696005)(66476007)(31686004)(86362001)(316002)(7416002)(2906002)(83380400001)(31696002)(6916009)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YmNxVi9HWG14QXB3VXJrY2xaVm1DNmEwYTR5bHpqeVRMVHk2MVZ6WjFjSlIv?=
 =?utf-8?B?RXZZWGtZS2Mvem5UU09aRWl6ZUNOdTRTNTdqTU4rblZJNzJlSW9IclliZUxD?=
 =?utf-8?B?bGV2blNRWUZ2NU0rczFpc3h6anVBbnlYMDdYM3pqZnphRVluQ3dxSmhpY1dP?=
 =?utf-8?B?aEZLcktuTUZHT3VnbkdZY1hyckN1TE8vUGljQ2VOdHNqNVJVZFE2YlBaYjh5?=
 =?utf-8?B?d2FKbFdsUFU3d3RLcnU5dmREYStqd1FyZ1YySDdTWmxkNDl1RmwzZnV5dUlk?=
 =?utf-8?B?UVluNzR3WS9UQ2NJbkl1L0dEZW54UGlkZm5ibXFQMGxjcnhWOXNheUQwQVVm?=
 =?utf-8?B?dFFxTjRhcnV1NHVqbE5DNTlPNXU0Vmh1bm9qMUt4UVo1NjBKVjdYK2JTTGg0?=
 =?utf-8?B?cFBBSW5JOVJWOTMxR0NqTGVBZHhua2JNSGVSdTBmWnN5M3RSU1Zrbkc0aW9S?=
 =?utf-8?B?L1Q3MTRiY2VkQzVjdWR3UmVRYXFyaFhHU29najhsSzZlRkp4VnJUekMvcWtz?=
 =?utf-8?B?ckhDOVpjVXFib3lXUGNBbUs4T1NiMDV3NGZ3Z0hlcVhvUDUwUVhEdU0zNW5F?=
 =?utf-8?B?Y1czNHJld2huL0Q3TW9OMDhaVWtrYW1DdlQ5bzc4TnpSUVB4UFEzZjRUaEhl?=
 =?utf-8?B?QmhrTThwNU5wSVBWbmkvcnUxVkpEMFNKK2R4SlMzaG1EdExPbXNoSnZralk3?=
 =?utf-8?B?MFZWNFNKWXZCNDFnREttVnlFUXkvYzhzMEViTWxhTmtHbUhWNTZzbVRrcVF5?=
 =?utf-8?B?dFdUU3NqRlE1ZldkcEFXNjVVcnFZa1pCN2ZQQnVVaExoVEVURHhFeUJLbmI2?=
 =?utf-8?B?TXJ0Z010UWoxWDRZQ0VZUFNMWC94V3ByYmZKMU40NnJkMWNTelBwekpZWmN0?=
 =?utf-8?B?SVdVMFNpVGRRblpZY1B3cjN1RVR6cVhXbm5hbXV3NEdGOFRHZi94TkUwYUJN?=
 =?utf-8?B?WjNMU3JzaUpQU0xodUsrZWc3TDBQY3B0eHB6R09BWW5UUjdrTnJJTldkdGxa?=
 =?utf-8?B?WW5BVU4zUitVRlp3UElhc2YxT1hWdEFnN2FzdVJBNE1jL2N6T25QSUk2VkZQ?=
 =?utf-8?B?ZldaSkFwNHJsNXYvSXU5aGxzZDE2cVdERXczSFV0Y2NqUzZsYzExTDNjY096?=
 =?utf-8?B?VjlqMUtOSUNRdDZ4UG13T0Q5NW9obDlGY1J4ZWNnbnpVUlpUWW41cVMxMWh0?=
 =?utf-8?B?WkhWVUdKN3pSWnQ1YXhxQkRyUURGbEM5NEpCSDZ6cnFsMnA5d3htM3JySG1P?=
 =?utf-8?B?NXJwdDZwL0pQQnR4SHBwWlN6eEdZanZOS1VJakV1c0FaeXFrVHFIL0ttRHZD?=
 =?utf-8?B?TUkwa3FuZmhYTFE2V3NaeEVrUURoUUpsQmc3eSswSTRKSXNMdjlmdlhVODJ2?=
 =?utf-8?B?cVV1OFVWTStOR3hjWjZRVlNabEp5Y05aeGZ3ekZueVVMdFhVVWU2T01YaUxV?=
 =?utf-8?B?SUtOVjBxd0VKZmFxc05Ua3BtQWJCd0QwdS9ydlFpUHRJdUVqR213NTF5Vlpa?=
 =?utf-8?B?LzNPTW0xS1RaUzhJMWFtaVJkYUpwNUN6c1NER0lkenAvbXpvTmJMaVJvRE5M?=
 =?utf-8?B?RzhqNkdZQWp4aVJLMUV5RHFCVk1YcXoxaXNYUU9iZ3B6SkpMSnBzbVd4cG5l?=
 =?utf-8?B?Z0xiRVhSa244dmV2cUJiT1ZnWXdGVDdENy9vbnlCN2JKNjlnUmVqVFpzR3M0?=
 =?utf-8?B?TkFnM1FHZ3d4Vm16MDFhUXdFd25nOHFMTFpWVmNOckE0REVmZFIxWkx3TGtV?=
 =?utf-8?Q?1Wpp3oX9RxYSpjhwRs2Gfhyrv0U6ppGwsVsilDh?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7489838-15d0-47dc-4be2-08d8d858f415
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 00:13:03.9998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9smeMEWDlLbEHFoskgH83GhobxRTplVSUfM00N7sTkbw9o4wjDXU9vcGCY0FEE/uXgzNh8R23xPorEyqAQpymg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4558
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102240000
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102240000
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/23/21 9:33 AM, Amir Goldstein wrote:
> On Tue, Feb 23, 2021 at 7:31 PM <dai.ngo@oracle.com> wrote:
>> On 2/23/21 8:57 AM, dai.ngo@oracle.com wrote:
>>
>>
>> On 2/23/21 8:47 AM, Amir Goldstein wrote:
>>
>> On Tue, Feb 23, 2021 at 6:02 PM <dai.ngo@oracle.com> wrote:
>>
>>
>> On 2/23/21 7:29 AM, dai.ngo@oracle.com wrote:
>>
>> On 2/23/21 2:32 AM, Luis Henriques wrote:
>>
>> On Mon, Feb 22, 2021 at 08:25:27AM -0800, dai.ngo@oracle.com wrote:
>>
>> On 2/22/21 2:24 AM, Luis Henriques wrote:
>>
>> A regression has been reported by Nicolas Boichat, found while
>> using the
>> copy_file_range syscall to copy a tracefs file.  Before commit
>> 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices") the
>> kernel would return -EXDEV to userspace when trying to copy a file
>> across
>> different filesystems.  After this commit, the syscall doesn't fail
>> anymore
>> and instead returns zero (zero bytes copied), as this file's
>> content is
>> generated on-the-fly and thus reports a size of zero.
>>
>> This patch restores some cross-filesystem copy restrictions that
>> existed
>> prior to commit 5dae222a5ff0 ("vfs: allow copy_file_range to copy
>> across
>> devices").  Filesystems are still allowed to fall-back to the VFS
>> generic_copy_file_range() implementation, but that has now to be done
>> explicitly.
>>
>> nfsd is also modified to fall-back into generic_copy_file_range()
>> in case
>> vfs_copy_file_range() fails with -EOPNOTSUPP or -EXDEV.
>>
>> Fixes: 5dae222a5ff0 ("vfs: allow copy_file_range to copy across
>> devices")
>> Link:
>> https://urldefense.com/v3/__https://lore.kernel.org/linux-fsdevel/20210212044405.4120619-1-drinkcat@chromium.org/__;!!GqivPVa7Brio!P1UWThiSkxbjfjFQWNYJmCxGEkiLFyvHjH6cS-G1ZTt1z-TeqwGQgQmi49dC6w$
>> Link:
>> https://urldefense.com/v3/__https://lore.kernel.org/linux-fsdevel/CANMq1KDZuxir2LM5jOTm0xx*BnvW=ZmpsG47CyHFJwnw7zSX6Q@mail.gmail.com/__;Kw!!GqivPVa7Brio!P1UWThiSkxbjfjFQWNYJmCxGEkiLFyvHjH6cS-G1ZTt1z-TeqwGQgQmgCmMHzA$
>> Link:
>> https://urldefense.com/v3/__https://lore.kernel.org/linux-fsdevel/20210126135012.1.If45b7cdc3ff707bc1efa17f5366057d60603c45f@changeid/__;!!GqivPVa7Brio!P1UWThiSkxbjfjFQWNYJmCxGEkiLFyvHjH6cS-G1ZTt1z-TeqwGQgQmzqItkrQ$
>> Reported-by: Nicolas Boichat <drinkcat@chromium.org>
>> Signed-off-by: Luis Henriques <lhenriques@suse.de>
>> ---
>> Changes since v7
>> - set 'ret' to '-EOPNOTSUPP' before the clone 'if' statement so
>> that the
>>       error returned is always related to the 'copy' operation
>> Changes since v6
>> - restored i_sb checks for the clone operation
>> Changes since v5
>> - check if ->copy_file_range is NULL before calling it
>> Changes since v4
>> - nfsd falls-back to generic_copy_file_range() only *if* it gets
>> -EOPNOTSUPP
>>       or -EXDEV.
>> Changes since v3
>> - dropped the COPY_FILE_SPLICE flag
>> - kept the f_op's checks early in generic_copy_file_checks,
>> implementing
>>       Amir's suggestions
>> - modified nfsd to use generic_copy_file_range()
>> Changes since v2
>> - do all the required checks earlier, in generic_copy_file_checks(),
>>       adding new checks for ->remap_file_range
>> - new COPY_FILE_SPLICE flag
>> - don't remove filesystem's fallback to generic_copy_file_range()
>> - updated commit changelog (and subject)
>> Changes since v1 (after Amir review)
>> - restored do_copy_file_range() helper
>> - return -EOPNOTSUPP if fs doesn't implement CFR
>> - updated commit description
>>
>>      fs/nfsd/vfs.c   |  8 +++++++-
>>      fs/read_write.c | 49
>> ++++++++++++++++++++++++-------------------------
>>      2 files changed, 31 insertions(+), 26 deletions(-)
>>
>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>> index 04937e51de56..23dab0fa9087 100644
>> --- a/fs/nfsd/vfs.c
>> +++ b/fs/nfsd/vfs.c
>> @@ -568,6 +568,7 @@ __be32 nfsd4_clone_file_range(struct nfsd_file
>> *nf_src, u64 src_pos,
>>      ssize_t nfsd_copy_file_range(struct file *src, u64 src_pos,
>> struct file *dst,
>>                       u64 dst_pos, u64 count)
>>      {
>> +    ssize_t ret;
>>          /*
>>           * Limit copy to 4MB to prevent indefinitely blocking an nfsd
>> @@ -578,7 +579,12 @@ ssize_t nfsd_copy_file_range(struct file *src,
>> u64 src_pos, struct file *dst,
>>           * limit like this and pipeline multiple COPY requests.
>>           */
>>          count = min_t(u64, count, 1 << 22);
>> -    return vfs_copy_file_range(src, src_pos, dst, dst_pos, count, 0);
>> +    ret = vfs_copy_file_range(src, src_pos, dst, dst_pos, count, 0);
>> +
>> +    if (ret == -EOPNOTSUPP || ret == -EXDEV)
>> +        ret = generic_copy_file_range(src, src_pos, dst, dst_pos,
>> +                          count, 0);
>> +    return ret;
>>      }
>>      __be32 nfsd4_vfs_fallocate(struct svc_rqst *rqstp, struct svc_fh
>> *fhp,
>> diff --git a/fs/read_write.c b/fs/read_write.c
>> index 75f764b43418..5a26297fd410 100644
>> --- a/fs/read_write.c
>> +++ b/fs/read_write.c
>> @@ -1388,28 +1388,6 @@ ssize_t generic_copy_file_range(struct file
>> *file_in, loff_t pos_in,
>>      }
>>      EXPORT_SYMBOL(generic_copy_file_range);
>> -static ssize_t do_copy_file_range(struct file *file_in, loff_t
>> pos_in,
>> -                  struct file *file_out, loff_t pos_out,
>> -                  size_t len, unsigned int flags)
>> -{
>> -    /*
>> -     * Although we now allow filesystems to handle cross sb copy,
>> passing
>> -     * a file of the wrong filesystem type to filesystem driver
>> can result
>> -     * in an attempt to dereference the wrong type of
>> ->private_data, so
>> -     * avoid doing that until we really have a good reason.  NFS
>> defines
>> -     * several different file_system_type structures, but they all
>> end up
>> -     * using the same ->copy_file_range() function pointer.
>> -     */
>> -    if (file_out->f_op->copy_file_range &&
>> -        file_out->f_op->copy_file_range ==
>> file_in->f_op->copy_file_range)
>> -        return file_out->f_op->copy_file_range(file_in, pos_in,
>> -                               file_out, pos_out,
>> -                               len, flags);
>> -
>> -    return generic_copy_file_range(file_in, pos_in, file_out,
>> pos_out, len,
>> -                       flags);
>> -}
>> -
>>      /*
>>       * Performs necessary checks before doing a file copy
>>       *
>> @@ -1427,6 +1405,25 @@ static int generic_copy_file_checks(struct
>> file *file_in, loff_t pos_in,
>>          loff_t size_in;
>>          int ret;
>> +    /*
>> +     * Although we now allow filesystems to handle cross sb copy,
>> passing
>> +     * a file of the wrong filesystem type to filesystem driver
>> can result
>> +     * in an attempt to dereference the wrong type of
>> ->private_data, so
>> +     * avoid doing that until we really have a good reason.  NFS
>> defines
>> +     * several different file_system_type structures, but they all
>> end up
>> +     * using the same ->copy_file_range() function pointer.
>> +     */
>> +    if (file_out->f_op->copy_file_range) {
>> +        if (file_in->f_op->copy_file_range !=
>> +            file_out->f_op->copy_file_range)
>> +            return -EXDEV;
>> +    } else if (file_in->f_op->remap_file_range) {
>> +        if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
>> +            return -EXDEV;
>>
>> I think this check is redundant, it's done in vfs_copy_file_range.
>> If this check is removed then the else clause below should be removed
>> also. Once this check and the else clause are removed then might as
>> well move the the check of copy_file_range from here to
>> vfs_copy_file_range.
>>
>> I don't think it's really redundant, although I agree is messy due to
>> the
>> fact we try to clone first instead of copying them.
>>
>> So, in the clone path, this is the only place where we return -EXDEV if:
>>
>> 1) we don't have ->copy_file_range *and*
>> 2) we have ->remap_file_range but the i_sb are different.
>>
>> The check in vfs_copy_file_range() is only executed if:
>>
>> 1) we have *valid* ->copy_file_range ops and/or
>> 2) we have *valid* ->remap_file_range
>>
>> So... if we remove the check in generic_copy_file_checks() as you
>> suggest
>> and:
>> - we don't have ->copy_file_range,
>> - we have ->remap_file_range but
>> - the i_sb are different
>>
>> we'll return the -EOPNOTSUPP (the one set in line "ret =
>> -EOPNOTSUPP;" in
>> function vfs_copy_file_range() ) instead of -EXDEV.
>>
>> Yes, this is the different.The NFS code handles both -EOPNOTSUPP and
>> -EXDEVV by doing generic_copy_file_range.  Do any other consumers of
>> vfs_copy_file_range rely on -EXDEV and not -EOPNOTSUPP and which is
>> the correct error code for this case? It seems to me that -EOPNOTSUPP
>> is more appropriate than EXDEV when (sb1 != sb2).
>>
>> EXDEV is the right code for:
>> filesystem supports the operation but not for sb1 != sb1.
>>
>> So with the current patch, for a clone operation across 2 filesystems:
>>
>>      . if src and dst filesystem support both copy_file_range and
>>        map_file_range then the code returns -ENOTSUPPORT.
>>
>> Why do you say that?
>> Which code are you referring to exactly?
>>
>>
>> If the filesystems support both copy_file_range and map_file_range,
>> it passes the check in generic_file_check but it fails with the
>> check in vfs_copy_file_range and returns -ENOTSUPPORT (added by
>> the v8 patch)
>>
>> Ok, I misread the code here. If it passes the check in generic_copy_file_checks
>> and it fails the sb check in vfs_copy_file_range then it tries copy_file_range
>> so it's ok.
>>
>> I think having the check in both generic_copy_file_checks and vfs_copy_file_range
>> making the code hard to read. What's the reason not to do the check only in
>> vfs_copy_file_range?
>>
> You are going in circles.
> I already answered that.
> Please re-read the entire thread on all patch versions before commenting.

I'm fine with the patch as it is, as long as it does not break NFS.

I just think it's easier to read if the checks are done in
vfs_copy_file_range such as:

@@ -1495,6 +1473,11 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
  
         file_start_write(file_out);
  
+       if (file_out->f_op->copy_file_range == NULL &&
+           file_in->f_op->remap_file_range == NULL)
+               return -EOPNOTSUPP;     /* not sure this error is needed */
+
+       ret = -EXDEV;
         /*
          * Try cloning first, this is supported by more file systems, and
          * more efficient if both clone and copy are supported (e.g. NFS).
@@ -1513,9 +1496,10 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
                 }
         }
  
-       ret = do_copy_file_range(file_in, pos_in, file_out, pos_out, len,
-                               flags);
-       WARN_ON_ONCE(ret == -EOPNOTSUPP);
+       if (file_out->f_op->copy_file_range &&
+           file_out->f_op->copy_file_range == file_in->f_op->copy_file_range) {
+               ret = file_out->f_op->copy_file_range(file_in, pos_in,
+                               file_out, pos_out, len, flags);
  done:
         if (ret > 0) {
                 fsnotify_access(file_in);

Thanks,
-Dai

>
> Thanks,
> Amir.
