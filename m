Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC164322D94
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 16:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbhBWPbQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 10:31:16 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43094 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbhBWPa4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 10:30:56 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11NFOjKm141506;
        Tue, 23 Feb 2021 15:29:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=W8ehPxc34T8WWD/zKT402w5j6OEwr3CXXBA6UBBHx4Q=;
 b=lu1ArIv/fKwdk7NLOa54fYf+y9u7CUg0/CJ6Ys++GcZsKYUXDSblzzb1tqkEpL4pqk2l
 whMsh883prt9zfd9DDRdgJE2rs2m7DidQfXJ5ckS6YrZA3KIF7rvLTlEToXbzwLTok6/
 t8vHJrGw15gkfArr7CRXk89QY1MnutiehWpyQgNcVykjfBiJFoHh1qh2uEp0iBX4hC/N
 o+is+jQR+CdRwQrQ9Z8qEmu3I9YG7xJsvYZBowddgZ75G2eUpw5aSmpF9fuPmY5v/kKF
 mT2F1w2omZZ10GBQdXzjn15NEwgNHzd4gyMEiEtO3lWfJCF+FypCEmKkT711Y3iEC6TM 4A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 36ugq3emgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Feb 2021 15:29:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11NFQeqi190382;
        Tue, 23 Feb 2021 15:29:17 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by aserp3030.oracle.com with ESMTP id 36v9m4qcq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Feb 2021 15:29:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8akxt3YY5O0LUnUSs9T7ZvN4pZrL5/ltqdZd05XKCzEstTvyroTss1JU7F/w/vwzlIpQye7sFnNXWhOO8VII6aD6U2JyLPhVBm2P7s3jpaDZmRpqimHbUU7HdGJBk9A68WMu7EKBYL1yRIo0yBdbkCsLhQuzeGQj1mDm6kIWbQl73jB21b2H7JOLDJF9NMtbSrdaMjwHw4CdEPJ2z4ZvEYT9sgZyIWRP+99RWx6IvGY8flCCpliyKmx8rFWHnDKe5jkfPWmUuLr8HQy570xRm4U3g1JVjpJIuFs/heiSnefIJ0+ZhHL02ErazxP+Kz+T9ToIV5TP7wQY2be1yIWeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8ehPxc34T8WWD/zKT402w5j6OEwr3CXXBA6UBBHx4Q=;
 b=B7GRDITc+auisHRxvCn1T6zKWNzWTfKGYdevwaee/UiXe79n6HfFZjNPdslvHGbvzqH7ZqlJXqU4XIb5tYC7ffY8gMJvKVThOFmtOrtkeGzsYGVe5v73lQo02rCXtLbmAAKoV5P81+ckeZe+DRg93XQZOptZCiYOUCoyr6edLDt/FnPbUaC0uBbT4Cc0OfWr5y7rsOMKC5sHAnbkH3EHhiMAn1izvXamAcOljsOMeOeoRzgmAV2+enWat7Yq8HG2Dl+Co5DSE+75tfDE4UxaZMLJfbMnQd86y4PgFHbVa3l24NMGZGI1ai1t6zHdO1HUFjEPiwlswKSWKpnPmSRisA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8ehPxc34T8WWD/zKT402w5j6OEwr3CXXBA6UBBHx4Q=;
 b=W2UHUOpEoyXbdEXh6ze+ygf1jpRc8eC4PQas0Sf7k92eeOhtnFGxeWKMAWQ9fgzTuYB75T0ypRPzSwKMqyY02zLMfe63gM7q3tkImSWveVDitFKIOXpElgR4ueX3gzgM4tLKuHcFRoseJ4+7/jRSKeFvGAxrawUYQKWn1KFMPyI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BY5PR10MB4177.namprd10.prod.outlook.com (2603:10b6:a03:205::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Tue, 23 Feb
 2021 15:29:15 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::a5bc:c1ab:3bf1:1fe8]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::a5bc:c1ab:3bf1:1fe8%6]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 15:29:15 +0000
Subject: Re: [PATCH v8] vfs: fix copy_file_range regression in cross-fs copies
To:     Luis Henriques <lhenriques@suse.de>
Cc:     Amir Goldstein <amir73il@gmail.com>,
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
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20210221195833.23828-1-lhenriques@suse.de>
 <20210222102456.6692-1-lhenriques@suse.de>
 <26a22719-427a-75cf-92eb-dda10d442ded@oracle.com> <YDTZwH7xv41Wimax@suse.de>
From:   dai.ngo@oracle.com
Message-ID: <7cc69c24-80dd-0053-24b9-3a28b0153f7e@oracle.com>
Date:   Tue, 23 Feb 2021 07:29:09 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <YDTZwH7xv41Wimax@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: SA9PR13CA0098.namprd13.prod.outlook.com
 (2603:10b6:806:24::13) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-154-137-111.vpn.oracle.com (72.219.112.78) by SA9PR13CA0098.namprd13.prod.outlook.com (2603:10b6:806:24::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.9 via Frontend Transport; Tue, 23 Feb 2021 15:29:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a43f933f-7192-49b8-1a76-08d8d80fc6f0
X-MS-TrafficTypeDiagnostic: BY5PR10MB4177:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB417716F5A815B772F006FEC187809@BY5PR10MB4177.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CgKKVzkBYMv/XEblzleC/EQEXk9EAC/dfpTvjIfmnj6ETs2qUiuL+sFr5G/ydgBxIFFAH557J2Vc95VpBrR4+E91M9xO5R3pftCGURnVmxlT9wPkARPgUbgwRZeZf5wt9/yBMSkBZJphfaTZ2d8YTRySusUzv05sF6fTRnqz2zhOYHYrY5hFbSX8azbZVNwUzaWnD6Mu17WLRYJO8QdRklJHD7RzwmaQK7fFkCVpy8mSp5KdEJlK5JBlGj/sfvgqIZDbRacBVBW1G9RgyeGpD/2x0z/7mWI5KEuiLv9bbdXQ+2O5zqNx5au/onnj0u9h4BR1gd00vtmuAvxURcTnouaYLbiaSSXHwo2cykM2kqPCGxVd3fR1iEMWL4TCwNVcI/5xpGHwQvVAPNOTf0fH+cJvtwZbvFDbcLf6Fpw07zHrClz0u9osE/pvNGmtKXHU1IXYCe0mp8q/o5g9wbJDWnU+HpGcvJUtY8aQGZABMccS9Jt1JBYhU5FFhH/ePgxLp1GSqBqIC6O5TnHj4YjJUsIaE9ANj2Z2UNV5kPbgX3skmav4CYEbWJZQeupX0Qzs/+j91F6e5D/9vMlo4cbWmt1c6MlREc9WA6d7NGmFbmJcJDHlkSpoTjxiNXqnddriaU1i2m9YXuyo2uuShLRewYeuh02ws5+1VKQtpxrWuEk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(39860400002)(366004)(346002)(8936002)(5660300002)(31686004)(36756003)(8676002)(54906003)(186003)(83380400001)(2906002)(478600001)(966005)(53546011)(86362001)(66574015)(66946007)(66476007)(6486002)(66556008)(6916009)(7696005)(6666004)(956004)(2616005)(7416002)(316002)(26005)(4326008)(31696002)(16526019)(9686003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Q0NDeE85ZDI1ZWZDN0NIZERrY2lWL29WU3JicXJvbVF3MzU3UTIrRkVZSmUv?=
 =?utf-8?B?ckR1RDJmajRrYXVYbmtEaWs2M01vbmNDckhGVWkwMTZQS1ZPTHFoa0orVHk2?=
 =?utf-8?B?TXUxL3g1bCtBc3EvWWladnJ5dE5pdmFXTzVteTNjdWJnOWNhbjYvUjFINWsr?=
 =?utf-8?B?TkVWbTlpckhET3JmamljSlVuTHVodFA2T2E0NGl1ZFBEWWdMS2ZSeUdPWDNs?=
 =?utf-8?B?MGtSMHJ0WFNuMlBlZXM5NEdXUVFQZ2J0bHVzOEZuVlV0SkZ5Y1VET2hTZ2NT?=
 =?utf-8?B?ZVdOeXFKcWVhcFplVXdvd0hMTVBpS0pOZW5qMWZIMUlsWC9pMXRrbmZBUlRS?=
 =?utf-8?B?QUJXVGZWazUxM0xPMUppRjY0Z3N6TFU1YjJUN3FYV0dGZE1uZmZUNzZ4QTdk?=
 =?utf-8?B?Y25HMXRUbzlHM2xEWWdBUlRQRG10S2x2eGlURkpBUEUvZkJ5cDhDcCt0OTRn?=
 =?utf-8?B?eFE4dzBpQWZiTXE4QUs1bmZuSVBZUmYwVTNMVVN0QjV0VE9DQ3puTGwvRXor?=
 =?utf-8?B?aGdDMVJmc2pCbW1rZ2lZbENPQUhaL0crNkZkZGcvcVRoWXBxUmhGdE9KWXQ5?=
 =?utf-8?B?eVZ3TjEzOVdsNEpIaE1FR1FXbjEwREVYeUtXOG1KZkdiQjAyOFRkL1FtYzdE?=
 =?utf-8?B?bHhmOEd2WnpUZzhzVWtQYzdlT3Z5ODRpQlNsbkZMTS96Q3VTbjlKaEQ4NmJv?=
 =?utf-8?B?NEEwQzJNcnV4dFN5ZUJ1YkVydGtNZkhDV2E0U0RZNlZtcVlQbm04VjYvME1v?=
 =?utf-8?B?QkdYT2FmbnJ5UFFSSExONzFpYkMyUmF2UWczRGRBZ0p4S2N2VDZXcEdjRS9s?=
 =?utf-8?B?NFI0d2NEWjlRaWdJb3JCUGducS8zZTloaFBDenl3eEpNYklKeGlqQ1J2YXZz?=
 =?utf-8?B?UGJrVERURVkwTXdpSVZPK29wM1l2T3FydlNUUEs0WEhURnEvRzh3Y0E1M2ZD?=
 =?utf-8?B?L0kxRUFuSWxNVnVjUHhjUU9rS2pMNTYyMi9mQm1FYWlDVmFqeHdSUU9ydTcz?=
 =?utf-8?B?NEtjcFZUY2hheFVBTUtLNk12RnZQbHVxQjJZbll0UkpFY3dtNU4vRElnNXZN?=
 =?utf-8?B?VTVZYnQrU0VXVk1YamV6VGhuRVBEdk8vYzV6Qlpvdlp6Uzd6R3hZMmN1VUdt?=
 =?utf-8?B?bVFTRjhLaGdra01tZmFmYmQyWEtiZUhXejRKcmc0Z2drbUk4RW5VVTlBL0ND?=
 =?utf-8?B?c1BCSm5GQjRFWHMzdlltTDMwOU54U3JjSlFBV0huUzN6a1VQVjFNZlJab2JS?=
 =?utf-8?B?ZE5CWk95T0ZYU1RsYy93YjE4OW5oQmNldWFoNzFMb1Q3dGRVdnEwMkQwcDk2?=
 =?utf-8?B?RXVlMDZVcEFjSFhyTGVEOUc4djRKNldSdGowVVBsZkYxeGR0bGxYUzlmQVRr?=
 =?utf-8?B?ZkxkYVhzSjB5eC9jNldTYTE0ZE0yQ1RidktnQTVyMnZTc1VmTSttaUQxT2xI?=
 =?utf-8?B?MlZzOEI3ckpqQ0xPT25vNjA0WGxvZWphTWJsSkxWcW5RTHpzS2tpTUNaUWRZ?=
 =?utf-8?B?V1JJNjd1U1NQRmJOb2pHbndURnRlRGdCWStqU240ZCtYc2JLUG5UcjY0RnlM?=
 =?utf-8?B?MHBZaVVEVlNlWDU3akFHVjNxdGhHb1JaMWZlUi9MazFlWkJqUUFZUFJ6dXFB?=
 =?utf-8?B?T0xsV2F1TEJ4ZFh1d05nWjZoMFcwRHNHODV0dGZ5bWdYYUFYem9iWVBNWktQ?=
 =?utf-8?B?SVIwOTR0Q3VZS0Zxb2Jwbm1BWmFPZm82Nm5ZVWcwdVpWbmdFdXZmbGRTSVBt?=
 =?utf-8?Q?4VJa7jN99uqfD3osGMG7aTOKKkifbF68/84/vgK?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a43f933f-7192-49b8-1a76-08d8d80fc6f0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 15:29:14.9127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aBwlZ8+zcvtspnEkNxqfk7oogd1Nas5y+H42qrkDF6BDyG58hSRbXgbfLRuhJAmdOAe6nBiXcv7/9bzxVRbnkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4177
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9903 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230131
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9903 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230131
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 2/23/21 2:32 AM, Luis Henriques wrote:
> On Mon, Feb 22, 2021 at 08:25:27AM -0800, dai.ngo@oracle.com wrote:
>> On 2/22/21 2:24 AM, Luis Henriques wrote:
>>> A regression has been reported by Nicolas Boichat, found while using the
>>> copy_file_range syscall to copy a tracefs file.  Before commit
>>> 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices") the
>>> kernel would return -EXDEV to userspace when trying to copy a file across
>>> different filesystems.  After this commit, the syscall doesn't fail anymore
>>> and instead returns zero (zero bytes copied), as this file's content is
>>> generated on-the-fly and thus reports a size of zero.
>>>
>>> This patch restores some cross-filesystem copy restrictions that existed
>>> prior to commit 5dae222a5ff0 ("vfs: allow copy_file_range to copy across
>>> devices").  Filesystems are still allowed to fall-back to the VFS
>>> generic_copy_file_range() implementation, but that has now to be done
>>> explicitly.
>>>
>>> nfsd is also modified to fall-back into generic_copy_file_range() in case
>>> vfs_copy_file_range() fails with -EOPNOTSUPP or -EXDEV.
>>>
>>> Fixes: 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices")
>>> Link: https://urldefense.com/v3/__https://lore.kernel.org/linux-fsdevel/20210212044405.4120619-1-drinkcat@chromium.org/__;!!GqivPVa7Brio!P1UWThiSkxbjfjFQWNYJmCxGEkiLFyvHjH6cS-G1ZTt1z-TeqwGQgQmi49dC6w$
>>> Link: https://urldefense.com/v3/__https://lore.kernel.org/linux-fsdevel/CANMq1KDZuxir2LM5jOTm0xx*BnvW=ZmpsG47CyHFJwnw7zSX6Q@mail.gmail.com/__;Kw!!GqivPVa7Brio!P1UWThiSkxbjfjFQWNYJmCxGEkiLFyvHjH6cS-G1ZTt1z-TeqwGQgQmgCmMHzA$
>>> Link: https://urldefense.com/v3/__https://lore.kernel.org/linux-fsdevel/20210126135012.1.If45b7cdc3ff707bc1efa17f5366057d60603c45f@changeid/__;!!GqivPVa7Brio!P1UWThiSkxbjfjFQWNYJmCxGEkiLFyvHjH6cS-G1ZTt1z-TeqwGQgQmzqItkrQ$
>>> Reported-by: Nicolas Boichat <drinkcat@chromium.org>
>>> Signed-off-by: Luis Henriques <lhenriques@suse.de>
>>> ---
>>> Changes since v7
>>> - set 'ret' to '-EOPNOTSUPP' before the clone 'if' statement so that the
>>>     error returned is always related to the 'copy' operation
>>> Changes since v6
>>> - restored i_sb checks for the clone operation
>>> Changes since v5
>>> - check if ->copy_file_range is NULL before calling it
>>> Changes since v4
>>> - nfsd falls-back to generic_copy_file_range() only *if* it gets -EOPNOTSUPP
>>>     or -EXDEV.
>>> Changes since v3
>>> - dropped the COPY_FILE_SPLICE flag
>>> - kept the f_op's checks early in generic_copy_file_checks, implementing
>>>     Amir's suggestions
>>> - modified nfsd to use generic_copy_file_range()
>>> Changes since v2
>>> - do all the required checks earlier, in generic_copy_file_checks(),
>>>     adding new checks for ->remap_file_range
>>> - new COPY_FILE_SPLICE flag
>>> - don't remove filesystem's fallback to generic_copy_file_range()
>>> - updated commit changelog (and subject)
>>> Changes since v1 (after Amir review)
>>> - restored do_copy_file_range() helper
>>> - return -EOPNOTSUPP if fs doesn't implement CFR
>>> - updated commit description
>>>
>>>    fs/nfsd/vfs.c   |  8 +++++++-
>>>    fs/read_write.c | 49 ++++++++++++++++++++++++-------------------------
>>>    2 files changed, 31 insertions(+), 26 deletions(-)
>>>
>>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>>> index 04937e51de56..23dab0fa9087 100644
>>> --- a/fs/nfsd/vfs.c
>>> +++ b/fs/nfsd/vfs.c
>>> @@ -568,6 +568,7 @@ __be32 nfsd4_clone_file_range(struct nfsd_file *nf_src, u64 src_pos,
>>>    ssize_t nfsd_copy_file_range(struct file *src, u64 src_pos, struct file *dst,
>>>    			     u64 dst_pos, u64 count)
>>>    {
>>> +	ssize_t ret;
>>>    	/*
>>>    	 * Limit copy to 4MB to prevent indefinitely blocking an nfsd
>>> @@ -578,7 +579,12 @@ ssize_t nfsd_copy_file_range(struct file *src, u64 src_pos, struct file *dst,
>>>    	 * limit like this and pipeline multiple COPY requests.
>>>    	 */
>>>    	count = min_t(u64, count, 1 << 22);
>>> -	return vfs_copy_file_range(src, src_pos, dst, dst_pos, count, 0);
>>> +	ret = vfs_copy_file_range(src, src_pos, dst, dst_pos, count, 0);
>>> +
>>> +	if (ret == -EOPNOTSUPP || ret == -EXDEV)
>>> +		ret = generic_copy_file_range(src, src_pos, dst, dst_pos,
>>> +					      count, 0);
>>> +	return ret;
>>>    }
>>>    __be32 nfsd4_vfs_fallocate(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>> diff --git a/fs/read_write.c b/fs/read_write.c
>>> index 75f764b43418..5a26297fd410 100644
>>> --- a/fs/read_write.c
>>> +++ b/fs/read_write.c
>>> @@ -1388,28 +1388,6 @@ ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
>>>    }
>>>    EXPORT_SYMBOL(generic_copy_file_range);
>>> -static ssize_t do_copy_file_range(struct file *file_in, loff_t pos_in,
>>> -				  struct file *file_out, loff_t pos_out,
>>> -				  size_t len, unsigned int flags)
>>> -{
>>> -	/*
>>> -	 * Although we now allow filesystems to handle cross sb copy, passing
>>> -	 * a file of the wrong filesystem type to filesystem driver can result
>>> -	 * in an attempt to dereference the wrong type of ->private_data, so
>>> -	 * avoid doing that until we really have a good reason.  NFS defines
>>> -	 * several different file_system_type structures, but they all end up
>>> -	 * using the same ->copy_file_range() function pointer.
>>> -	 */
>>> -	if (file_out->f_op->copy_file_range &&
>>> -	    file_out->f_op->copy_file_range == file_in->f_op->copy_file_range)
>>> -		return file_out->f_op->copy_file_range(file_in, pos_in,
>>> -						       file_out, pos_out,
>>> -						       len, flags);
>>> -
>>> -	return generic_copy_file_range(file_in, pos_in, file_out, pos_out, len,
>>> -				       flags);
>>> -}
>>> -
>>>    /*
>>>     * Performs necessary checks before doing a file copy
>>>     *
>>> @@ -1427,6 +1405,25 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
>>>    	loff_t size_in;
>>>    	int ret;
>>> +	/*
>>> +	 * Although we now allow filesystems to handle cross sb copy, passing
>>> +	 * a file of the wrong filesystem type to filesystem driver can result
>>> +	 * in an attempt to dereference the wrong type of ->private_data, so
>>> +	 * avoid doing that until we really have a good reason.  NFS defines
>>> +	 * several different file_system_type structures, but they all end up
>>> +	 * using the same ->copy_file_range() function pointer.
>>> +	 */
>>> +	if (file_out->f_op->copy_file_range) {
>>> +		if (file_in->f_op->copy_file_range !=
>>> +		    file_out->f_op->copy_file_range)
>>> +			return -EXDEV;
>>> +	} else if (file_in->f_op->remap_file_range) {
>>> +		if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
>>> +			return -EXDEV;
>> I think this check is redundant, it's done in vfs_copy_file_range.
>> If this check is removed then the else clause below should be removed
>> also. Once this check and the else clause are removed then might as
>> well move the the check of copy_file_range from here to vfs_copy_file_range.
>>
> I don't think it's really redundant, although I agree is messy due to the
> fact we try to clone first instead of copying them.
>
> So, in the clone path, this is the only place where we return -EXDEV if:
>
> 1) we don't have ->copy_file_range *and*
> 2) we have ->remap_file_range but the i_sb are different.
>
> The check in vfs_copy_file_range() is only executed if:
>
> 1) we have *valid* ->copy_file_range ops and/or
> 2) we have *valid* ->remap_file_range
>
> So... if we remove the check in generic_copy_file_checks() as you suggest
> and:
> - we don't have ->copy_file_range,
> - we have ->remap_file_range but
> - the i_sb are different
>
> we'll return the -EOPNOTSUPP (the one set in line "ret = -EOPNOTSUPP;" in
> function vfs_copy_file_range() ) instead of -EXDEV.

Yes, this is the different.The NFS code handles both -EOPNOTSUPP and
-EXDEVV by doing generic_copy_file_range.  Do any other consumers of
vfs_copy_file_range rely on -EXDEV and not -EOPNOTSUPP and which is
the correct error code for this case? It seems to me that -EOPNOTSUPP
is more appropriate than EXDEV when (sb1 != sb2).

>
> But I may have got it all wrong.  I've looked so many times at this code
> that I'm probably useless at finding problems in it :-)

You're not alone, we all try to do the right thing :-)

-Dai

>
> Cheers,
> --
> Luís
>
>> -Dai
>>
>>> +	} else {
>>> +                return -EOPNOTSUPP;
>>> +	}
>>> +
>>>    	ret = generic_file_rw_checks(file_in, file_out);
>>>    	if (ret)
>>>    		return ret;
>>> @@ -1495,6 +1492,7 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
>>>    	file_start_write(file_out);
>>> +	ret = -EOPNOTSUPP;
>>>    	/*
>>>    	 * Try cloning first, this is supported by more file systems, and
>>>    	 * more efficient if both clone and copy are supported (e.g. NFS).
>>> @@ -1513,9 +1511,10 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
>>>    		}
>>>    	}
>>> -	ret = do_copy_file_range(file_in, pos_in, file_out, pos_out, len,
>>> -				flags);
>>> -	WARN_ON_ONCE(ret == -EOPNOTSUPP);
>>> +	if (file_out->f_op->copy_file_range)
>>> +		ret = file_out->f_op->copy_file_range(file_in, pos_in,
>>> +						      file_out, pos_out,
>>> +						      len, flags);
>>>    done:
>>>    	if (ret > 0) {
>>>    		fsnotify_access(file_in);
