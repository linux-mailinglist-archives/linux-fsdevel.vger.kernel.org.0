Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91AAB322F37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 17:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbhBWQ7V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 11:59:21 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:39960 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbhBWQ7O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 11:59:14 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11NGsBUY165583;
        Tue, 23 Feb 2021 16:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=3kaEh2nc7vOoaJhnzdB+ftElVWz91gb29BSDo9zWDzc=;
 b=0Smj+Z4NfXc3KHIe6LVKudE4CAS08VH6ihXP1TI42K8Jynv0CdQ5YN4+6HVCHobjmkIw
 kFwKLzm4ffpJNe50mTVguRekuog3slp1HttgPCy0LTAfrXYVRaXNHW6dETJPtaCdCXBf
 JHTP9FiZXJPUnub4+Kxtbhqoyk+qX5iFjMVQFXEFOv2hRmWjAYNF53kECgrWxp9d/L8j
 ZTm7rpa1w8W4eMEKRCFka+rmNoa0Yt6xOMTe8olt/l9DQ/RekWNBaFsnuJeOTeGpyFvv
 B6IWYcwPb9nXUdqKoQrDvrU7NwWq3IXzVnQSP+55x/ZrR1P//brb0UPzQOe6VBDF6zza QA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 36ttcm834e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Feb 2021 16:57:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11NGsUPN004685;
        Tue, 23 Feb 2021 16:57:46 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by userp3030.oracle.com with ESMTP id 36ucbxqya5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Feb 2021 16:57:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJ9MiqCQsSV23GP/qA21kiSDRQ8Iyi246v7eG1XlQ1HeKGgXEqsokeE8ixtyXGGXpffGAPlNHra75mVCrL3AZAWk43jWz7Io0caTZqJKsgGVAXNQP8WykSQUqrdaxuIARe8iDCp2wt0+z1MUgG6BfA0NsyYlK8qaHpgfTAeUWjth2SPyGrPfyecPltPTLRca7MupmPDcppPNfewzOxKqCOW9XNFL0AUk4Fh6hS2fNIuYKNSXz4C3HNU12/73wKpQlDCFLcb2pQFOV/EA2jubkk4mIx8v449Bv3hq0ss8iPAZqUkJq3w+8Lt0+FdCyy3NIa0Nw93XSRgbE+AKxP8zsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kaEh2nc7vOoaJhnzdB+ftElVWz91gb29BSDo9zWDzc=;
 b=gVXZwetX8roEKaRAnqngXTOpvUPUrTbgDf546zpkd2wGhfyrW613hncA0ZOlQd8Dt9+Ssa6yJcFPXoeL0e2qybLwykYYR2CvsxLrVyM9VAtZGNo2QbHKCmxOGCZ53rhnyTcDW5Iz1XubItA7Iq4hd3rNflz7/d8B0oVY5vvFd05BgMEzGe+nZaGux5wd80fVS7os5CLtxaXZBezFp+MkROqXTIrONO0jY/3e6nerlu3YtJhFsRuTFGNboc0FHhV+2MPPO846UtAC99i9G7cHQLSDz+5vVmnqdGibLXcxGu8Tg23bg3qGlrOzFPRkiS4VG4xWSmf4rooiYdlb8jeFfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kaEh2nc7vOoaJhnzdB+ftElVWz91gb29BSDo9zWDzc=;
 b=NnljFcMMAPKM+4+X9syPdSJeo11Dc85YxfQWT5HAnAhevVd62fZdBj2hXZjb4IGEB38tivt1OoxaV9DMeRGMbqimwcmlKJD5od3ATg9vRUUws0GabMQ6yxtiLPXSc5yKq4tld+FS5Cbsyb/XUg4opJW9keHIk+rTXaSyNwELj7Y=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB3109.namprd10.prod.outlook.com (2603:10b6:a03:14d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Tue, 23 Feb
 2021 16:57:43 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::a5bc:c1ab:3bf1:1fe8]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::a5bc:c1ab:3bf1:1fe8%6]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 16:57:43 +0000
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
From:   dai.ngo@oracle.com
Message-ID: <72c41310-85e4-16fe-8d9c-d42abe0566a9@oracle.com>
Date:   Tue, 23 Feb 2021 08:57:38 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <CAOQ4uxh2E2oJjHoOBY3GU__6UcjE67E7qR1uMus7f_xhQyM54g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: SA9PR13CA0083.namprd13.prod.outlook.com
 (2603:10b6:806:23::28) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-154-141-126.vpn.oracle.com (72.219.112.78) by SA9PR13CA0083.namprd13.prod.outlook.com (2603:10b6:806:23::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.9 via Frontend Transport; Tue, 23 Feb 2021 16:57:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a551caf2-6989-4b10-f90f-08d8d81c2303
X-MS-TrafficTypeDiagnostic: BYAPR10MB3109:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3109752F069F2D27B73E351787809@BYAPR10MB3109.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vmE/q4yE6jal61f+DEhJ7BCZl6wMJ0Ue8+aSCJwJG8O1zHDUxkgXV/j3E141vsOO05dePJL2Uo2Gl1hh1H4PUr4MY74g/eh6ENMMy9/JFmkorPv8cyCbYaZ8rX/ta7TagQGDiVx5V9JUxp6FFcWUHlfWS+jLtl10lFVxwrYjAqzOSBJgVdV3Ge1F7ZorLqGdBUe6dFbiDrdIhK4Ev783Zp1yFIvUzZOWSeNLddESZFDo+NT2FC1tzQC9rQ/bL4rvfU7gJiMIpnwkhBLLxDYchcmwojIEAdw4B76xUYvCqbml8HOYER54CfhL2u7l6OVs1hoPJJmtHGu4wEzXzZKVPhp9tsskTlMe60uAbbtu5sYrV2SUVadf1IJOk42AFvCRBc1eoF2MI9GFR71R7Ne3tPlAvaCWFdHM+UT2pvFvv4Wyo3z9r0C2Z9GB2w3Do5RQsqgeJ0+lOlxCmRgH+0aBLsY3yKThjdE+umKDN9gIGzZbeZcx7nwaFNIj8FMg6TNmW938yQess3In6RqlYyEcaXJ/b8NDRhcDAi4LJZIpiD6upCuSdGiGrA5QnfYBp67OE7DUpaKYEvbbt+9LIeaxm+MQUfu/5/pElBNpzvjwT7qa+rgXdtJG0SqF59FrivsJYK2I0M9o2eVO0erA5esr9cEGkCf1c7SewUyzu3Jlrik=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(366004)(396003)(376002)(136003)(7416002)(7696005)(186003)(53546011)(4326008)(478600001)(316002)(36756003)(26005)(6486002)(16526019)(31686004)(5660300002)(2616005)(966005)(9686003)(956004)(86362001)(8676002)(2906002)(54906003)(6916009)(66476007)(66556008)(83380400001)(8936002)(66946007)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cUFyTDROSXBRQVRGSEVvL29IVmF4dTAxai9Xek9uQTA5SzZ3L0JiaGwzSnJi?=
 =?utf-8?B?RUR5QWNuL0RmMmQxLzJRdWphQXkxN1c0WE0wU0ROS2hqT1lVOEVCNlVseGZs?=
 =?utf-8?B?ZUFKTm83Uko4RExicC9sakV3ZXRXTVNYMDRUVlhQcWpUeTNUdWNNQkZrb3ph?=
 =?utf-8?B?VVdQOUQzMkwzUFlMNUxpeFc2TlJVa3VuaERvNEhndW8wRk9MbExCUWlLWE11?=
 =?utf-8?B?b0VuMlJhbUxNYzI4c1RodWo0R3AvTFNJbFl3TkgvOElhU2U1a3lyV0JmVmps?=
 =?utf-8?B?MUx1ZjBna1hlbGpWVEg2QVpDdW42SWtyZ1AxMm9vdjhFZldDaGwrVklmL0pO?=
 =?utf-8?B?d2FDc0U1VGN6NC9ENENMNDZRNXVXZy9udjBHOTZvMlNITUxsT3VSeXd6T3Fw?=
 =?utf-8?B?RjVsNGZORDg1L05Lc2tjQlNTTnZsM0xDK2pZSlorMkRkVHN0RGxRVWRuY3FM?=
 =?utf-8?B?RHJkbjVXTU9JTmhISnFBV1Erc240QlBXNENQdkxKK0JkbFRkUElCZjNJenRY?=
 =?utf-8?B?SWNJbXFwZm5BaEI3azlXSUk5eGgrZktaRFdocElVR1dMRHNRbkNOUVNQSDYr?=
 =?utf-8?B?WSt1VEdERCsxWW5uaW9ReUJENlA4OHpIU1dpTHhaTHYwbnJrWFVRd2tZYzBW?=
 =?utf-8?B?UHZpWGZZeWtuemVMajdQL1ZSZVJUVlNHdktLT0hxR2VHNXdpZ3haRWdQWXcw?=
 =?utf-8?B?TmszaDU5MG55VkVWSG0vK043dzh5ZDRUSDU0RVBOQXBQcWZ5TnpEWnRMN09J?=
 =?utf-8?B?K2tTam9qS24zVmlzelA4K1JpSkNOUjBpanpWcVh0TVVYTkdiWUF5QkVBVGR6?=
 =?utf-8?B?VG5Ybm1MNE5hRnNHVEFmZ3h6L3FIVklmMk05YTJaUkljbFB6SktITGFyNlpi?=
 =?utf-8?B?QlBvMnRtbHpEZUlTYUtFK0FQT1E0UEVicGRDdlBQSFN6M1JNOHF3WDQ4Qk5E?=
 =?utf-8?B?eVdsVEplYS93TE12WGNCcENrYkpoMEE1QXpIMGV6Si9qck9sb2Z1Mk5oTDc3?=
 =?utf-8?B?bVFESVdhMFRhaERtMjlWdCtqaUV1cmtCbU1yVEJHK3JFdU5ITkxzblVSVm9M?=
 =?utf-8?B?eElmMXVhU3d1SGhkOVJHR2NYWXp1bHRLS1dKekFtbzQ2NEk1K0pxR2oyRHVG?=
 =?utf-8?B?QjI4Y1BsMjZ0Q3M2a1l1T09DSUJzUWwwNHRrZGpQK0gxMXJtc0lQdE9ZNGpL?=
 =?utf-8?B?U1lXaFh2WmFXVm45WE9DN3J5TDM1STFrQmwwM0loUzlPWEg2RVFwRUNNVjBQ?=
 =?utf-8?B?RElMTHliclVRVXVsSS94K2w5bUc3U08wVnhTVDdJYUVxaTBsSGxWdFRLRW1x?=
 =?utf-8?B?RXNGWjZYWmRrT2FlQTZzY0M3T2E0VnhjSXpxbzVJZStlTUROVVovTTU2aXZl?=
 =?utf-8?B?eFozZnhPeWJwREZacmwvem9xUU51aDdld2R4a3R4YXdSMjhkSmxreHpXUHRo?=
 =?utf-8?B?b3AvcHpiekQvd0l1MTlKdzMvdVZqSTZYaWpvZ1pDK3VnQWMrTnRaaFRKWXFD?=
 =?utf-8?B?SXlRcEJnOTI2MkZDMjRid3FKQXhSN3VTZ1I1ZjF2QU5FZ0gwOHBIcDBPZ0Fr?=
 =?utf-8?B?TktGc09RVHpjV29qa2t4Z1BKSy9aai9hUktzL1E2UlNPcnJxeURMOEJyTXZz?=
 =?utf-8?B?RzBzSk52ZjZrdHhsYW1wUjF6WTNrcHNYTGNFc3hQcmwxV3UrcHpMYTZQOTMv?=
 =?utf-8?B?TUhYaVBoMUpUZWgzc3I0OXFadktnMlRLamRmOWxVWWhmcmVyclFSd0Q0U3pY?=
 =?utf-8?Q?maGgTIw9Od/KdT/P/R3673y7dn2hTmX1qOIHlvF?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a551caf2-6989-4b10-f90f-08d8d81c2303
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 16:57:43.5383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5M97/Fzdr0DvlZu2Z5alygv40w1kYEB/WJ4b/8I8/PSoAIPKjaRYxevGsg20mnnBY0A0k0u/9r2ZfHHAnSx+vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3109
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230140
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230140
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 2/23/21 8:47 AM, Amir Goldstein wrote:
> On Tue, Feb 23, 2021 at 6:02 PM <dai.ngo@oracle.com> wrote:
>>
>> On 2/23/21 7:29 AM, dai.ngo@oracle.com wrote:
>>> On 2/23/21 2:32 AM, Luis Henriques wrote:
>>>> On Mon, Feb 22, 2021 at 08:25:27AM -0800, dai.ngo@oracle.com wrote:
>>>>> On 2/22/21 2:24 AM, Luis Henriques wrote:
>>>>>> A regression has been reported by Nicolas Boichat, found while
>>>>>> using the
>>>>>> copy_file_range syscall to copy a tracefs file.  Before commit
>>>>>> 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices") the
>>>>>> kernel would return -EXDEV to userspace when trying to copy a file
>>>>>> across
>>>>>> different filesystems.  After this commit, the syscall doesn't fail
>>>>>> anymore
>>>>>> and instead returns zero (zero bytes copied), as this file's
>>>>>> content is
>>>>>> generated on-the-fly and thus reports a size of zero.
>>>>>>
>>>>>> This patch restores some cross-filesystem copy restrictions that
>>>>>> existed
>>>>>> prior to commit 5dae222a5ff0 ("vfs: allow copy_file_range to copy
>>>>>> across
>>>>>> devices").  Filesystems are still allowed to fall-back to the VFS
>>>>>> generic_copy_file_range() implementation, but that has now to be done
>>>>>> explicitly.
>>>>>>
>>>>>> nfsd is also modified to fall-back into generic_copy_file_range()
>>>>>> in case
>>>>>> vfs_copy_file_range() fails with -EOPNOTSUPP or -EXDEV.
>>>>>>
>>>>>> Fixes: 5dae222a5ff0 ("vfs: allow copy_file_range to copy across
>>>>>> devices")
>>>>>> Link:
>>>>>> https://urldefense.com/v3/__https://lore.kernel.org/linux-fsdevel/20210212044405.4120619-1-drinkcat@chromium.org/__;!!GqivPVa7Brio!P1UWThiSkxbjfjFQWNYJmCxGEkiLFyvHjH6cS-G1ZTt1z-TeqwGQgQmi49dC6w$
>>>>>> Link:
>>>>>> https://urldefense.com/v3/__https://lore.kernel.org/linux-fsdevel/CANMq1KDZuxir2LM5jOTm0xx*BnvW=ZmpsG47CyHFJwnw7zSX6Q@mail.gmail.com/__;Kw!!GqivPVa7Brio!P1UWThiSkxbjfjFQWNYJmCxGEkiLFyvHjH6cS-G1ZTt1z-TeqwGQgQmgCmMHzA$
>>>>>> Link:
>>>>>> https://urldefense.com/v3/__https://lore.kernel.org/linux-fsdevel/20210126135012.1.If45b7cdc3ff707bc1efa17f5366057d60603c45f@changeid/__;!!GqivPVa7Brio!P1UWThiSkxbjfjFQWNYJmCxGEkiLFyvHjH6cS-G1ZTt1z-TeqwGQgQmzqItkrQ$
>>>>>> Reported-by: Nicolas Boichat <drinkcat@chromium.org>
>>>>>> Signed-off-by: Luis Henriques <lhenriques@suse.de>
>>>>>> ---
>>>>>> Changes since v7
>>>>>> - set 'ret' to '-EOPNOTSUPP' before the clone 'if' statement so
>>>>>> that the
>>>>>>      error returned is always related to the 'copy' operation
>>>>>> Changes since v6
>>>>>> - restored i_sb checks for the clone operation
>>>>>> Changes since v5
>>>>>> - check if ->copy_file_range is NULL before calling it
>>>>>> Changes since v4
>>>>>> - nfsd falls-back to generic_copy_file_range() only *if* it gets
>>>>>> -EOPNOTSUPP
>>>>>>      or -EXDEV.
>>>>>> Changes since v3
>>>>>> - dropped the COPY_FILE_SPLICE flag
>>>>>> - kept the f_op's checks early in generic_copy_file_checks,
>>>>>> implementing
>>>>>>      Amir's suggestions
>>>>>> - modified nfsd to use generic_copy_file_range()
>>>>>> Changes since v2
>>>>>> - do all the required checks earlier, in generic_copy_file_checks(),
>>>>>>      adding new checks for ->remap_file_range
>>>>>> - new COPY_FILE_SPLICE flag
>>>>>> - don't remove filesystem's fallback to generic_copy_file_range()
>>>>>> - updated commit changelog (and subject)
>>>>>> Changes since v1 (after Amir review)
>>>>>> - restored do_copy_file_range() helper
>>>>>> - return -EOPNOTSUPP if fs doesn't implement CFR
>>>>>> - updated commit description
>>>>>>
>>>>>>     fs/nfsd/vfs.c   |  8 +++++++-
>>>>>>     fs/read_write.c | 49
>>>>>> ++++++++++++++++++++++++-------------------------
>>>>>>     2 files changed, 31 insertions(+), 26 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>>>>>> index 04937e51de56..23dab0fa9087 100644
>>>>>> --- a/fs/nfsd/vfs.c
>>>>>> +++ b/fs/nfsd/vfs.c
>>>>>> @@ -568,6 +568,7 @@ __be32 nfsd4_clone_file_range(struct nfsd_file
>>>>>> *nf_src, u64 src_pos,
>>>>>>     ssize_t nfsd_copy_file_range(struct file *src, u64 src_pos,
>>>>>> struct file *dst,
>>>>>>                      u64 dst_pos, u64 count)
>>>>>>     {
>>>>>> +    ssize_t ret;
>>>>>>         /*
>>>>>>          * Limit copy to 4MB to prevent indefinitely blocking an nfsd
>>>>>> @@ -578,7 +579,12 @@ ssize_t nfsd_copy_file_range(struct file *src,
>>>>>> u64 src_pos, struct file *dst,
>>>>>>          * limit like this and pipeline multiple COPY requests.
>>>>>>          */
>>>>>>         count = min_t(u64, count, 1 << 22);
>>>>>> -    return vfs_copy_file_range(src, src_pos, dst, dst_pos, count, 0);
>>>>>> +    ret = vfs_copy_file_range(src, src_pos, dst, dst_pos, count, 0);
>>>>>> +
>>>>>> +    if (ret == -EOPNOTSUPP || ret == -EXDEV)
>>>>>> +        ret = generic_copy_file_range(src, src_pos, dst, dst_pos,
>>>>>> +                          count, 0);
>>>>>> +    return ret;
>>>>>>     }
>>>>>>     __be32 nfsd4_vfs_fallocate(struct svc_rqst *rqstp, struct svc_fh
>>>>>> *fhp,
>>>>>> diff --git a/fs/read_write.c b/fs/read_write.c
>>>>>> index 75f764b43418..5a26297fd410 100644
>>>>>> --- a/fs/read_write.c
>>>>>> +++ b/fs/read_write.c
>>>>>> @@ -1388,28 +1388,6 @@ ssize_t generic_copy_file_range(struct file
>>>>>> *file_in, loff_t pos_in,
>>>>>>     }
>>>>>>     EXPORT_SYMBOL(generic_copy_file_range);
>>>>>> -static ssize_t do_copy_file_range(struct file *file_in, loff_t
>>>>>> pos_in,
>>>>>> -                  struct file *file_out, loff_t pos_out,
>>>>>> -                  size_t len, unsigned int flags)
>>>>>> -{
>>>>>> -    /*
>>>>>> -     * Although we now allow filesystems to handle cross sb copy,
>>>>>> passing
>>>>>> -     * a file of the wrong filesystem type to filesystem driver
>>>>>> can result
>>>>>> -     * in an attempt to dereference the wrong type of
>>>>>> ->private_data, so
>>>>>> -     * avoid doing that until we really have a good reason.  NFS
>>>>>> defines
>>>>>> -     * several different file_system_type structures, but they all
>>>>>> end up
>>>>>> -     * using the same ->copy_file_range() function pointer.
>>>>>> -     */
>>>>>> -    if (file_out->f_op->copy_file_range &&
>>>>>> -        file_out->f_op->copy_file_range ==
>>>>>> file_in->f_op->copy_file_range)
>>>>>> -        return file_out->f_op->copy_file_range(file_in, pos_in,
>>>>>> -                               file_out, pos_out,
>>>>>> -                               len, flags);
>>>>>> -
>>>>>> -    return generic_copy_file_range(file_in, pos_in, file_out,
>>>>>> pos_out, len,
>>>>>> -                       flags);
>>>>>> -}
>>>>>> -
>>>>>>     /*
>>>>>>      * Performs necessary checks before doing a file copy
>>>>>>      *
>>>>>> @@ -1427,6 +1405,25 @@ static int generic_copy_file_checks(struct
>>>>>> file *file_in, loff_t pos_in,
>>>>>>         loff_t size_in;
>>>>>>         int ret;
>>>>>> +    /*
>>>>>> +     * Although we now allow filesystems to handle cross sb copy,
>>>>>> passing
>>>>>> +     * a file of the wrong filesystem type to filesystem driver
>>>>>> can result
>>>>>> +     * in an attempt to dereference the wrong type of
>>>>>> ->private_data, so
>>>>>> +     * avoid doing that until we really have a good reason.  NFS
>>>>>> defines
>>>>>> +     * several different file_system_type structures, but they all
>>>>>> end up
>>>>>> +     * using the same ->copy_file_range() function pointer.
>>>>>> +     */
>>>>>> +    if (file_out->f_op->copy_file_range) {
>>>>>> +        if (file_in->f_op->copy_file_range !=
>>>>>> +            file_out->f_op->copy_file_range)
>>>>>> +            return -EXDEV;
>>>>>> +    } else if (file_in->f_op->remap_file_range) {
>>>>>> +        if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
>>>>>> +            return -EXDEV;
>>>>> I think this check is redundant, it's done in vfs_copy_file_range.
>>>>> If this check is removed then the else clause below should be removed
>>>>> also. Once this check and the else clause are removed then might as
>>>>> well move the the check of copy_file_range from here to
>>>>> vfs_copy_file_range.
>>>>>
>>>> I don't think it's really redundant, although I agree is messy due to
>>>> the
>>>> fact we try to clone first instead of copying them.
>>>>
>>>> So, in the clone path, this is the only place where we return -EXDEV if:
>>>>
>>>> 1) we don't have ->copy_file_range *and*
>>>> 2) we have ->remap_file_range but the i_sb are different.
>>>>
>>>> The check in vfs_copy_file_range() is only executed if:
>>>>
>>>> 1) we have *valid* ->copy_file_range ops and/or
>>>> 2) we have *valid* ->remap_file_range
>>>>
>>>> So... if we remove the check in generic_copy_file_checks() as you
>>>> suggest
>>>> and:
>>>> - we don't have ->copy_file_range,
>>>> - we have ->remap_file_range but
>>>> - the i_sb are different
>>>>
>>>> we'll return the -EOPNOTSUPP (the one set in line "ret =
>>>> -EOPNOTSUPP;" in
>>>> function vfs_copy_file_range() ) instead of -EXDEV.
>>> Yes, this is the different.The NFS code handles both -EOPNOTSUPP and
>>> -EXDEVV by doing generic_copy_file_range.  Do any other consumers of
>>> vfs_copy_file_range rely on -EXDEV and not -EOPNOTSUPP and which is
>>> the correct error code for this case? It seems to me that -EOPNOTSUPP
>>> is more appropriate than EXDEV when (sb1 != sb2).
> EXDEV is the right code for:
> filesystem supports the operation but not for sb1 != sb1.
>
>> So with the current patch, for a clone operation across 2 filesystems:
>>
>>     . if src and dst filesystem support both copy_file_range and
>>       map_file_range then the code returns -ENOTSUPPORT.
>>
> Why do you say that?
> Which code are you referring to exactly?

If the filesystems support both copy_file_range and map_file_range,
it passes the check in generic_file_check but it fails with the
check in vfs_copy_file_range and returns -ENOTSUPPORT (added by
the v8 patch)

-Dai

> Did you see this behavior in a test?
>
>>     . if the filesystems only support map_file_range then the
>>       code returns -EXDEV
>>
>> This seems confusing, shouldn't only 1 error code returned for this case?
>>
>  From my read of the code, user will get -EXDEV in both the cases you
> listed.
>
> Thanks,
> Amir.
