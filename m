Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C97322E49
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 17:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbhBWQEX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 11:04:23 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:36512 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbhBWQDs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 11:03:48 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11NFseJe105601;
        Tue, 23 Feb 2021 16:02:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=HzCzE19vGNp6BOZDYHNGjGwzjI8TysK92kuKCKf3B68=;
 b=nMpqxyjnYE2E077IK0lausv6lCctqfVtNZtSZULNjIDS6IIzWTa7LBdSb6tXZqCa/prv
 IcK7xSdN7cuGQov112fXzJhcrEzJ41cifVdYE+7/c0HUIBXu+5emyGTctMRAjmX7vLaC
 wY8XdZ14qN/P2X7jo9e1Mok6F7Su5rq7uR9lbmzICo0IxIsb7z4hZu4zir0VT5MUBQNA
 WxHyXUHME0nbB8v88+g1sDdD5jIH+eNa6RznnzgHGDFA23V0NwTNgUG7ny2kwmamvh3k
 U6wofRh9E7ShZ+6J5p5J+ZYpqe3Rku2VgE4C91+wMdF39WlunOWrv3kDAmRTGd/Gd4Lf wQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 36vr6227uy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Feb 2021 16:02:10 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11NG08Np110795;
        Tue, 23 Feb 2021 16:02:09 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by userp3020.oracle.com with ESMTP id 36uc6rwtp6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Feb 2021 16:02:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cEFMbSAimKT/oAsJ5rdkjEGQpGzqdYf6jEsW862+zYHN+MV57iGTttBIAgxJCDY97dTYlb2uxPT25z7MiVY+9kZA36H6SmhX+B0mtNQrYbDv8zILQs2VdgbTbWyWKSmNooBANGtzEvpHFuefdCQW05ksb+VAzhILxJ7pS3+RMQz7jytUMhSBHcyKmA6A9ODKd30jHZCRHuCrb7eGXdQLouQaIjgJAZBr3zNUDMMdBmShwconLGQG726CM6xqMD+kt1KqSdIYUrV+p0ACLBEaQ6E7FhZM+VxovZZQZnugDSOKXxJCFbhYIMHBnhZuPWBgcC5DMET7VYz3oU7yJi2Arg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzCzE19vGNp6BOZDYHNGjGwzjI8TysK92kuKCKf3B68=;
 b=diyaDhF7ars3WJtO5K2/vYIxPCuMZtn0MIGKnfplBDi+f7GcVk6uQpgQQ/YtuUMzKILrJ3/WgyJ2BzOHRr26WI+i899kWpIj4wX3Hwaesc8mNkgAjt+BUMObAQgS2C4kWXisZOY5rBY4GMI/OJaWRC2siocIE566EfyUculknzo/W7pEy3mljjVwoggz2dbza9dwaIrqK+TXMM1GLODBIwNRQ3B0aegmRkDX6z419j15X/OKzYbP5HRLwTkkn2FtZxBZ5TqRpb7M/ulzr/dixp0AZOt/CNCzSbnIjFshpljzkS4ZPBD0g+Deynsm2Fiu+un0mhzxb251YA2BE2VWtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzCzE19vGNp6BOZDYHNGjGwzjI8TysK92kuKCKf3B68=;
 b=tdGcghu2NpObOTCq72m553q1Oh/AR/tRzsue2oD/9XASyiwIek2CwoRNy+UOarxXu7BwSv/ftXPVX7Y06HE6Z1+L6wJK6g99rqeBEJdeOpaVhA+m0Srz98gerXCIxjihbtNm0XVmvHyBYfs1LI1QwdBbBLj3OswASW2n4ISgsBc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ0PR10MB4495.namprd10.prod.outlook.com (2603:10b6:a03:2d6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Tue, 23 Feb
 2021 16:02:07 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::a5bc:c1ab:3bf1:1fe8]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::a5bc:c1ab:3bf1:1fe8%6]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 16:02:07 +0000
Subject: Re: [PATCH v8] vfs: fix copy_file_range regression in cross-fs copies
From:   dai.ngo@oracle.com
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
 <7cc69c24-80dd-0053-24b9-3a28b0153f7e@oracle.com>
Message-ID: <7c12e6a3-e4a6-5210-1b57-09072eac3270@oracle.com>
Date:   Tue, 23 Feb 2021 08:02:03 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <7cc69c24-80dd-0053-24b9-3a28b0153f7e@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: BY3PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:a03:254::18) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-154-137-111.vpn.oracle.com (72.219.112.78) by BY3PR05CA0013.namprd05.prod.outlook.com (2603:10b6:a03:254::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.8 via Frontend Transport; Tue, 23 Feb 2021 16:02:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aae53c18-c429-4acc-4365-08d8d8145e40
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4495:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4495ED91D5F1B4195F46C1C687809@SJ0PR10MB4495.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 62mGcfi1gR/w27a7On1BP5jpirkyTzATwLjly15S5BUtVWSlBMYgu7X2VjTxNRCk482gHyu8PkZpFogwMdkWuLQ44tuBES+CkGx3tSOyp9FpHDopEOQH1ciiVaNXl+7i9fUTd+JSgHpBPiuByluWv2p7gw0pJ8vRx9OsnNAmHRdpdJoCT66x7MQhIPBy0uReA86htlm9D2dMobWpkIL4HHhl6EvT+igQNY2H9Fe4MyKsMgQssVPEPlE4TPLEsFRz07xY0bEIB/rwisWFAbgYV3rcVH5ACVis5tMz6B6iHobT3YbOxkqIkOGUbyF+jOI6SHuy6qbxOrrtA7hFKa50s5xoku7x1titD6VEFHb4SvgtiHcrcMkanwmmD3qr2Rsg/8xP/XJpx+eWOLfcb/oYUkGWKh1RWS/GowwZWmdbe8+gUyR9omftvY51JLG9lFOZC17dRwCkvGnHV9P4/5e0p/z6vKzGZ2LKVA9ZB3h3h6p8PPVPr9z2xoaP2o5/r8mCucjjM6X7jxnOGgvKwg11iCDTi++QPzimFhx8pUZY+rVr3fkXE9jFtEBTJTsYDEgRc8qKUczyyn1sakbsL6/GmlfKD1w+B3vhIJsRjrwliD6FxxIUj2piYc1vlQFTLx5ElJuiLHncGKqQygBxqOjN1zRHIz2BqWqS46V6A152N8g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(396003)(366004)(136003)(376002)(26005)(31696002)(966005)(2906002)(8936002)(6486002)(83380400001)(31686004)(2616005)(7416002)(66556008)(9686003)(6916009)(316002)(66946007)(66476007)(956004)(478600001)(86362001)(54906003)(36756003)(53546011)(4326008)(5660300002)(7696005)(16526019)(186003)(66574015)(8676002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RExNeHJISk1abktOVGxiU0lVZ0g3bk5RSmI3dEtBaXoyZXJnZ0VWaThER3c5?=
 =?utf-8?B?QjRIcnVVanZOcFFaV2hoTjdNWmtxNUw0cDdiVlBtellkT1RjZXFRVHBzNnoy?=
 =?utf-8?B?dUVLVlhNcVdzamJ6Y08yTVZvQnNMRm1IWFBhN0pjYzRkNXRXazBuZjBISGxt?=
 =?utf-8?B?b3VwcVZ1MkFFMm9kU3g2WTl0dGo1cVh2ZEFKWkl5ZERKSEFLRnZ2eXNmdHhw?=
 =?utf-8?B?NzNiRUovd2kvTDNVSXI3alVQSlhWWW0rdWJHbndnVHNuU0IyTmZqZnNZY2k5?=
 =?utf-8?B?aVY3TWdvcDZsczRuSFlVU1QrdTJ3MEpaeVBpSEpkRnA3U3ZFaTNHbmovYTdX?=
 =?utf-8?B?S2U2WlJBallITjhPTHVhNGJ4VXdiSEplMUxoa3ZFM3F3THUzSzhxYjMxK21w?=
 =?utf-8?B?bVNLSzh2R0gvRVRxYTJOdzRaaC9kOHhERWJlcWw2Nmo1dmJwcWZ2T0JJYTRk?=
 =?utf-8?B?RXBYeE5Jdkxzb0p6MXFsLzl1Y0tpdHAzOXRoZGxnbFJsSG5lb1d5aTZCcU50?=
 =?utf-8?B?T3RFMGxCbTl4UnpLdFl3YThPQ0lxdUZWZHlXQmF6ZXdFTFBYRGkzaDZRTHJT?=
 =?utf-8?B?Nm9yREd2aVdRNGxjWFVFNFUzMngzWGY3R3NUdHR1SmMyRktyYi9PUkxJZzgz?=
 =?utf-8?B?VUwxQ0hBMHhQVVBacmdhOEN0ZnRNY1ExU3QwSUcxNkI1dG5JbDlZd2xmUjYw?=
 =?utf-8?B?U2ZFU1BLN09lVmRSWHNKeFJwOFNVaW5XaWdSOUtnUHNubzNFMUVMTGplS0g4?=
 =?utf-8?B?TGZUNDRHK3p2dFpYTDdDSit3TDRibWJLZGNLSSs1TEoyT2t3a1lvNnZpalVx?=
 =?utf-8?B?Z0NjVGNyMEh2UHNzNGtHREtYbzE0dTFNVU13U2JyQ1dPUm9EWmFUZHo4ZWVY?=
 =?utf-8?B?bHpBbjlBMGxMdHEzUTI4QUVJRDZOTmtrTHdIbVJJTDAzcy9hMldVVTBxVlhL?=
 =?utf-8?B?RlhCNklDM28zWGp4UVVkZEoxZmcwd2VhTDZ3bDZWdmhXUkdUcFNuTFZndk4y?=
 =?utf-8?B?d05EcUFTNnlTYzFGZkpaSTgyeFdSUVV6WXhjdjB2Z0RhckNRNU13akpFalZN?=
 =?utf-8?B?S2RDMFozK1kwdmQxeElsUEtuclV2S1MyeUxQeDV3OW93NEs4ODB3QVVvV2dU?=
 =?utf-8?B?ZUZnV0NBSGFucnd3Y2N4ZnVxQVdsWkZtSU5VZFhiZTNyNlFDR1ZXSU10Ti9t?=
 =?utf-8?B?bjYxcUZKNmtTdjlSMkZ3Q0VTYWZNRmdsSjdUd01HQ0NYQUJzK0J1TlAvSzZm?=
 =?utf-8?B?djM5YlZXVnk2VUVSUTMxdythT1c4WnpwdjQ3NTZkeTJ1Q1RLSC9ubStBVUl2?=
 =?utf-8?B?Rlo2Z0VCOEMxOFhFZzBkRFM1VmRWNWthVEhuT2F5Wi9oaGF0d3NtM01NWm9D?=
 =?utf-8?B?UCsxV0xaNmU5MTk5YkpnbksyQ21RT0l2ajUwQXIzMHZkMDI1TE5UMEtVdmNK?=
 =?utf-8?B?THpQN2todmdZSmQvVUZ5R29tS0U0cWFJZVNGS05JWTlnOUlLV1RaOEN5UWRH?=
 =?utf-8?B?SWF3cC9zS2dWMlpxbUhMZ1VtOWd4ZU9JWVpjS0FDcnZMYkROTGkxLzVLMS95?=
 =?utf-8?B?TjhWRGJ6Yjc1N2ZzRU9NVjJUdEh6Zi9mSHRVYlpzY1orM005QW1MaTNFYVc1?=
 =?utf-8?B?clhGUVRCUWFCeHJDRlEwWlhkUzYrR1Q4dWtib3RYdkNsU0hrTGNrVTgrdGlE?=
 =?utf-8?B?WExuMmdGRVkwUTRVVHZXczV5VE4yajh2VEZ2SjU3SVVuVytSSUpkMmpWaVN3?=
 =?utf-8?Q?jH5nLwRDHLesQlD++MVwDs65uNe3JfA0tTdqSbQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aae53c18-c429-4acc-4365-08d8d8145e40
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 16:02:06.9491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ss4J20oQ/kuJwEtZ8ljjx8VVv/UDA6gcT7+NjGp5WBJCsDjQ/hpl9rgsREKkYqFyPc2sCISdPhYVT+pZtrs++A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4495
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9903 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102230135
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9903 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 impostorscore=0 adultscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230134
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 2/23/21 7:29 AM, dai.ngo@oracle.com wrote:
>
> On 2/23/21 2:32 AM, Luis Henriques wrote:
>> On Mon, Feb 22, 2021 at 08:25:27AM -0800, dai.ngo@oracle.com wrote:
>>> On 2/22/21 2:24 AM, Luis Henriques wrote:
>>>> A regression has been reported by Nicolas Boichat, found while 
>>>> using the
>>>> copy_file_range syscall to copy a tracefs file.  Before commit
>>>> 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices") the
>>>> kernel would return -EXDEV to userspace when trying to copy a file 
>>>> across
>>>> different filesystems.  After this commit, the syscall doesn't fail 
>>>> anymore
>>>> and instead returns zero (zero bytes copied), as this file's 
>>>> content is
>>>> generated on-the-fly and thus reports a size of zero.
>>>>
>>>> This patch restores some cross-filesystem copy restrictions that 
>>>> existed
>>>> prior to commit 5dae222a5ff0 ("vfs: allow copy_file_range to copy 
>>>> across
>>>> devices").  Filesystems are still allowed to fall-back to the VFS
>>>> generic_copy_file_range() implementation, but that has now to be done
>>>> explicitly.
>>>>
>>>> nfsd is also modified to fall-back into generic_copy_file_range() 
>>>> in case
>>>> vfs_copy_file_range() fails with -EOPNOTSUPP or -EXDEV.
>>>>
>>>> Fixes: 5dae222a5ff0 ("vfs: allow copy_file_range to copy across 
>>>> devices")
>>>> Link: 
>>>> https://urldefense.com/v3/__https://lore.kernel.org/linux-fsdevel/20210212044405.4120619-1-drinkcat@chromium.org/__;!!GqivPVa7Brio!P1UWThiSkxbjfjFQWNYJmCxGEkiLFyvHjH6cS-G1ZTt1z-TeqwGQgQmi49dC6w$
>>>> Link: 
>>>> https://urldefense.com/v3/__https://lore.kernel.org/linux-fsdevel/CANMq1KDZuxir2LM5jOTm0xx*BnvW=ZmpsG47CyHFJwnw7zSX6Q@mail.gmail.com/__;Kw!!GqivPVa7Brio!P1UWThiSkxbjfjFQWNYJmCxGEkiLFyvHjH6cS-G1ZTt1z-TeqwGQgQmgCmMHzA$
>>>> Link: 
>>>> https://urldefense.com/v3/__https://lore.kernel.org/linux-fsdevel/20210126135012.1.If45b7cdc3ff707bc1efa17f5366057d60603c45f@changeid/__;!!GqivPVa7Brio!P1UWThiSkxbjfjFQWNYJmCxGEkiLFyvHjH6cS-G1ZTt1z-TeqwGQgQmzqItkrQ$
>>>> Reported-by: Nicolas Boichat <drinkcat@chromium.org>
>>>> Signed-off-by: Luis Henriques <lhenriques@suse.de>
>>>> ---
>>>> Changes since v7
>>>> - set 'ret' to '-EOPNOTSUPP' before the clone 'if' statement so 
>>>> that the
>>>>     error returned is always related to the 'copy' operation
>>>> Changes since v6
>>>> - restored i_sb checks for the clone operation
>>>> Changes since v5
>>>> - check if ->copy_file_range is NULL before calling it
>>>> Changes since v4
>>>> - nfsd falls-back to generic_copy_file_range() only *if* it gets 
>>>> -EOPNOTSUPP
>>>>     or -EXDEV.
>>>> Changes since v3
>>>> - dropped the COPY_FILE_SPLICE flag
>>>> - kept the f_op's checks early in generic_copy_file_checks, 
>>>> implementing
>>>>     Amir's suggestions
>>>> - modified nfsd to use generic_copy_file_range()
>>>> Changes since v2
>>>> - do all the required checks earlier, in generic_copy_file_checks(),
>>>>     adding new checks for ->remap_file_range
>>>> - new COPY_FILE_SPLICE flag
>>>> - don't remove filesystem's fallback to generic_copy_file_range()
>>>> - updated commit changelog (and subject)
>>>> Changes since v1 (after Amir review)
>>>> - restored do_copy_file_range() helper
>>>> - return -EOPNOTSUPP if fs doesn't implement CFR
>>>> - updated commit description
>>>>
>>>>    fs/nfsd/vfs.c   |  8 +++++++-
>>>>    fs/read_write.c | 49 
>>>> ++++++++++++++++++++++++-------------------------
>>>>    2 files changed, 31 insertions(+), 26 deletions(-)
>>>>
>>>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>>>> index 04937e51de56..23dab0fa9087 100644
>>>> --- a/fs/nfsd/vfs.c
>>>> +++ b/fs/nfsd/vfs.c
>>>> @@ -568,6 +568,7 @@ __be32 nfsd4_clone_file_range(struct nfsd_file 
>>>> *nf_src, u64 src_pos,
>>>>    ssize_t nfsd_copy_file_range(struct file *src, u64 src_pos, 
>>>> struct file *dst,
>>>>                     u64 dst_pos, u64 count)
>>>>    {
>>>> +    ssize_t ret;
>>>>        /*
>>>>         * Limit copy to 4MB to prevent indefinitely blocking an nfsd
>>>> @@ -578,7 +579,12 @@ ssize_t nfsd_copy_file_range(struct file *src, 
>>>> u64 src_pos, struct file *dst,
>>>>         * limit like this and pipeline multiple COPY requests.
>>>>         */
>>>>        count = min_t(u64, count, 1 << 22);
>>>> -    return vfs_copy_file_range(src, src_pos, dst, dst_pos, count, 0);
>>>> +    ret = vfs_copy_file_range(src, src_pos, dst, dst_pos, count, 0);
>>>> +
>>>> +    if (ret == -EOPNOTSUPP || ret == -EXDEV)
>>>> +        ret = generic_copy_file_range(src, src_pos, dst, dst_pos,
>>>> +                          count, 0);
>>>> +    return ret;
>>>>    }
>>>>    __be32 nfsd4_vfs_fallocate(struct svc_rqst *rqstp, struct svc_fh 
>>>> *fhp,
>>>> diff --git a/fs/read_write.c b/fs/read_write.c
>>>> index 75f764b43418..5a26297fd410 100644
>>>> --- a/fs/read_write.c
>>>> +++ b/fs/read_write.c
>>>> @@ -1388,28 +1388,6 @@ ssize_t generic_copy_file_range(struct file 
>>>> *file_in, loff_t pos_in,
>>>>    }
>>>>    EXPORT_SYMBOL(generic_copy_file_range);
>>>> -static ssize_t do_copy_file_range(struct file *file_in, loff_t 
>>>> pos_in,
>>>> -                  struct file *file_out, loff_t pos_out,
>>>> -                  size_t len, unsigned int flags)
>>>> -{
>>>> -    /*
>>>> -     * Although we now allow filesystems to handle cross sb copy, 
>>>> passing
>>>> -     * a file of the wrong filesystem type to filesystem driver 
>>>> can result
>>>> -     * in an attempt to dereference the wrong type of 
>>>> ->private_data, so
>>>> -     * avoid doing that until we really have a good reason.  NFS 
>>>> defines
>>>> -     * several different file_system_type structures, but they all 
>>>> end up
>>>> -     * using the same ->copy_file_range() function pointer.
>>>> -     */
>>>> -    if (file_out->f_op->copy_file_range &&
>>>> -        file_out->f_op->copy_file_range == 
>>>> file_in->f_op->copy_file_range)
>>>> -        return file_out->f_op->copy_file_range(file_in, pos_in,
>>>> -                               file_out, pos_out,
>>>> -                               len, flags);
>>>> -
>>>> -    return generic_copy_file_range(file_in, pos_in, file_out, 
>>>> pos_out, len,
>>>> -                       flags);
>>>> -}
>>>> -
>>>>    /*
>>>>     * Performs necessary checks before doing a file copy
>>>>     *
>>>> @@ -1427,6 +1405,25 @@ static int generic_copy_file_checks(struct 
>>>> file *file_in, loff_t pos_in,
>>>>        loff_t size_in;
>>>>        int ret;
>>>> +    /*
>>>> +     * Although we now allow filesystems to handle cross sb copy, 
>>>> passing
>>>> +     * a file of the wrong filesystem type to filesystem driver 
>>>> can result
>>>> +     * in an attempt to dereference the wrong type of 
>>>> ->private_data, so
>>>> +     * avoid doing that until we really have a good reason.  NFS 
>>>> defines
>>>> +     * several different file_system_type structures, but they all 
>>>> end up
>>>> +     * using the same ->copy_file_range() function pointer.
>>>> +     */
>>>> +    if (file_out->f_op->copy_file_range) {
>>>> +        if (file_in->f_op->copy_file_range !=
>>>> +            file_out->f_op->copy_file_range)
>>>> +            return -EXDEV;
>>>> +    } else if (file_in->f_op->remap_file_range) {
>>>> +        if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
>>>> +            return -EXDEV;
>>> I think this check is redundant, it's done in vfs_copy_file_range.
>>> If this check is removed then the else clause below should be removed
>>> also. Once this check and the else clause are removed then might as
>>> well move the the check of copy_file_range from here to 
>>> vfs_copy_file_range.
>>>
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
>
> Yes, this is the different.The NFS code handles both -EOPNOTSUPP and
> -EXDEVV by doing generic_copy_file_range.  Do any other consumers of
> vfs_copy_file_range rely on -EXDEV and not -EOPNOTSUPP and which is
> the correct error code for this case? It seems to me that -EOPNOTSUPP
> is more appropriate than EXDEV when (sb1 != sb2).

So with the current patch, for a clone operation across 2 filesystems:

   . if src and dst filesystem support both copy_file_range and
     map_file_range then the code returns -ENOTSUPPORT.

   . if the filesystems only support map_file_range then the
     code returns -EXDEV

This seems confusing, shouldn't only 1 error code returned for this case?

-Dai

>
>>
>> But I may have got it all wrong.  I've looked so many times at this code
>> that I'm probably useless at finding problems in it :-)
>
> You're not alone, we all try to do the right thing :-)
>
> -Dai
>
>>
>> Cheers,
>> -- 
>> Luís
>>
>>> -Dai
>>>
>>>> +    } else {
>>>> +                return -EOPNOTSUPP;
>>>> +    }
>>>> +
>>>>        ret = generic_file_rw_checks(file_in, file_out);
>>>>        if (ret)
>>>>            return ret;
>>>> @@ -1495,6 +1492,7 @@ ssize_t vfs_copy_file_range(struct file 
>>>> *file_in, loff_t pos_in,
>>>>        file_start_write(file_out);
>>>> +    ret = -EOPNOTSUPP;
>>>>        /*
>>>>         * Try cloning first, this is supported by more file 
>>>> systems, and
>>>>         * more efficient if both clone and copy are supported (e.g. 
>>>> NFS).
>>>> @@ -1513,9 +1511,10 @@ ssize_t vfs_copy_file_range(struct file 
>>>> *file_in, loff_t pos_in,
>>>>            }
>>>>        }
>>>> -    ret = do_copy_file_range(file_in, pos_in, file_out, pos_out, len,
>>>> -                flags);
>>>> -    WARN_ON_ONCE(ret == -EOPNOTSUPP);
>>>> +    if (file_out->f_op->copy_file_range)
>>>> +        ret = file_out->f_op->copy_file_range(file_in, pos_in,
>>>> +                              file_out, pos_out,
>>>> +                              len, flags);
>>>>    done:
>>>>        if (ret > 0) {
>>>>            fsnotify_access(file_in);
