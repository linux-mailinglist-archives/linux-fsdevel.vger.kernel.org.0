Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD71321CF1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Feb 2021 17:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbhBVQ22 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Feb 2021 11:28:28 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:41470 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbhBVQ1T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Feb 2021 11:27:19 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MGJs0Y142729;
        Mon, 22 Feb 2021 16:25:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=D0JAex6wc6RESESBHuPeFY2wFRwnb8lGc8BmIRFOcJ4=;
 b=WcYtJkMHryxfm4LoC6vrpTeHRy2yDWSnmztMWAHxPx1SEnbjm+cCYi2cVs7tZ0SsEM3E
 qgCq2ihjpRxYWV/jnNH6C4kFOq8nKoHMVO36ETM50of93lXnEss+25ezVR7hbBR6taCx
 pYkucxLy6M3Elc0AMpZYvlwvSPsB85s9hC09SHEOT6lQopUf+Hzyrdc7MrYXrA3iCtg6
 ulTKiBDZjcUzIs/9C9u16zqvL2Be74+bMQMpWqyjS3sAX1925UQPhUqnxUKM8L1tqdnb
 D9fZ5q86Zby0sZNkXq3q/YrFCzWz8GYIYtAt9Pq6BdunDtUs/ErXIdmioyI+TZxDZB9/ Zw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 36ttcm47ey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 16:25:35 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MGKIS4116470;
        Mon, 22 Feb 2021 16:25:35 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by aserp3030.oracle.com with ESMTP id 36v9m3fp8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 16:25:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LX1bT5SU/1r8vhK4EIhbmXRqdVxN7et20vu5Ewy+BqFk6Ex7JJ35gMztU1QJoDIxEU1qo+I9DBP27SYIY625LeLPsbNIxqW7H2DLrzgQ6n2SfwloQfxU4ceB5yIDenx/0bh3hXnlpTwtYjeqi/G8t7rYfEMSb4gxYCy7waQEF0lasKnjGLBOZNp1oe4FhtTgF7I9mhtlDTeZVnddkdOpJJumR5tqrfbrnoxWt1NB8Fj9d3L0UUkMU/kkXgfXNBgRtl5uwYzOG/aM4vHUcZUxaYHntVeAgdLlDaNwzF8aGkT/NgRF8S7slZoQKdoyEEDkxZTXgJ9yBlsW44mBGIeDXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0JAex6wc6RESESBHuPeFY2wFRwnb8lGc8BmIRFOcJ4=;
 b=V/fUq6BjeWV93vtIDMKyaEtlh6rxwe/R11tgr+FUIcCgTmwNe4voCOmMcm5uDAIVLobnWLDR642gOll8ncT/qk6K73g66XYagmLljhCPdxZqMUqneiddlXzQvuVmt8Ae7/v/ZxDSUHNxiu3gnMC9w8wwgo6esFKbzVur4kSINYzJAUcshEpmmb4Mbat2ItelV6vug1VrsaVspcLTZjovkYzQO2l1JoZYPaMUiZpdfohy5qTEf+CBdYHhkmy3/uv8FTQIRCPwYbe+xOq9Oy5ZZK2Kg85Q6JVXclMmeMksSXeTZx6IKQY7NTMVtb2wPpxfhgsQtd02Mp+8TD31QcHKQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0JAex6wc6RESESBHuPeFY2wFRwnb8lGc8BmIRFOcJ4=;
 b=l6hWJuDfp82eG2gvljrWkNPd4nDgRW+UNC2mK5P73+H/aAiUd2mY2k9iR3Clv+J8IybRudTsdnysf997ybfVK5U9/fcu0gEOt9hnJYQIjRWHIIN/w83cfn7NQfVS333tgSGa0Xd0pkB1W9RVHcef+SNN9S6b6unl6yFuAhCfyQ8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB2710.namprd10.prod.outlook.com (2603:10b6:a02:b5::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Mon, 22 Feb
 2021 16:25:32 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::a5bc:c1ab:3bf1:1fe8]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::a5bc:c1ab:3bf1:1fe8%6]) with mapi id 15.20.3868.033; Mon, 22 Feb 2021
 16:25:32 +0000
Subject: Re: [PATCH v8] vfs: fix copy_file_range regression in cross-fs copies
To:     Luis Henriques <lhenriques@suse.de>,
        Amir Goldstein <amir73il@gmail.com>,
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
        Christoph Hellwig <hch@infradead.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20210221195833.23828-1-lhenriques@suse.de>
 <20210222102456.6692-1-lhenriques@suse.de>
From:   dai.ngo@oracle.com
Message-ID: <26a22719-427a-75cf-92eb-dda10d442ded@oracle.com>
Date:   Mon, 22 Feb 2021 08:25:27 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <20210222102456.6692-1-lhenriques@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: SA9PR10CA0017.namprd10.prod.outlook.com
 (2603:10b6:806:a7::22) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-154-137-111.vpn.oracle.com (72.219.112.78) by SA9PR10CA0017.namprd10.prod.outlook.com (2603:10b6:806:a7::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Mon, 22 Feb 2021 16:25:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89beccc8-cf9c-4915-2281-08d8d74e79ac
X-MS-TrafficTypeDiagnostic: BYAPR10MB2710:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB271041102AC6EA67E66B05F487819@BYAPR10MB2710.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N1hPMzQsIWjYS3fw/vI3f8WeIKqyH2TFDiNV5fXk9e9hrnbkBA/uRl9Ec2EN92dZudBnfIL9IP4jmmFQv2VgRGn9cv7CkENmIni9kJGxT3LQI1fh2jW15Wp0zcyU/xlc2PBImZJyvKXwrpJomdGrJUqYvTnyWey1xN0tp2E6wcYXRMcz6drgLofxAnnAH/jnV6ygiTPpp+hD/rnB+8buFL33eTAO/XuKg/JnZmWAw4nv74EL1dQc99+TFGiZCXvWhcyXc9YCcaf2fdN2ZU3BZnWhJkTwzuU7d3hgzquCszmiFVrzaAa9Q2nrIfOZxfIbEHjeEnTsw6qa0gL3sQyxEW9P/c1kDU3KfK56eH2qOjH/5wo0Gzi8Bp6LA0M3O7DwvEzuGWMQCjfgdVciWk9hY7NgboIjXDgufP9jfBWLOXCRWpqN+B8mxMHneVAtYQ7mAOHKZEucAyQThx1ZDewj9QESTrKqKvpWEN3zIaHbIBU+Yihvs2wMS+EvFQC/3B+xgBaY6jn2tBUOFM5HE59VPsBCdVtk0to3sddhvfRdKLLl5rfPmAN4IUYocZgaRqRDQz3G1UQei3Enz04fgQn1hBvS3vONt4E7G9pJOZ/8Oj1rD/Cke9pWRQS1Ea1jUTzRmpDS8t3p/FRr2cg98qWidazmgQmiUj26ENN3+vIMtj4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(346002)(396003)(366004)(136003)(66476007)(66946007)(66556008)(921005)(7416002)(53546011)(110136005)(956004)(4326008)(316002)(26005)(8936002)(86362001)(6486002)(186003)(2616005)(966005)(7696005)(478600001)(16526019)(5660300002)(31696002)(36756003)(2906002)(31686004)(9686003)(8676002)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cjdvOFZRYUJFc2ptZy9UZGhQOTAvRnVEbGJxNFM3UTh5LzI2OFlRdGppVG82?=
 =?utf-8?B?N0QrSVJwL2E4ZGZhSlpBNUprT3RxRFM3aDVHMFF3S3FnMU5yaU45NWpDR2Zh?=
 =?utf-8?B?cklDL3pZVlpaRHl5OGY0M3JLY3ZvNU1hYXNqanlyd201QmtWeHYveTh0WC9R?=
 =?utf-8?B?b0NMRXZGaHM2ZTZndXFSWjU3c3BuUzdOcmJoSFRHQmE1YmNpcnJaRy9aaThF?=
 =?utf-8?B?dUNYaTJwdlErYkV4cmJjOGdQUlU1ZzluQm5zSVBQOGFheTRqZDBGTlhzUEZ3?=
 =?utf-8?B?ZHZjZktydXRNV3JzS1hJdEVWenFSU1h0L0ZJQzQxczRRTElNUjd2NmpOV2ZN?=
 =?utf-8?B?YldseFlpUVE5eSs0WnFkbEowZUNJVmppelFBMkZNV2VRU0R3ODdPakcxVXRn?=
 =?utf-8?B?SnpTTlcvU2pGSTB6NVJoY2h1aTdUZnFmMFBsUEl4MUNNcUdNbENCSFVsUHhu?=
 =?utf-8?B?NG1UMU1sMVhWZG42RTBUWXdrZEJtNVNkcFpTNzM5bDR1bzg5WTViREcxUElD?=
 =?utf-8?B?NmpLbWNQYzVkV3V3NVJWeFZZUkNUbGNWWmZjVkFoWjBFQ0Q2Tmx2MFdWWGMw?=
 =?utf-8?B?eVdMMDNEbE9yMFUrTG84TUhUOXNPOGw3a2lDa3dnb21yZXMwZEprdzlSb05T?=
 =?utf-8?B?NGh0VXlFa2tkWExNNlI2b2hxVmZCeFhHSU5wRmRRVjBWNDFyczdpK0E4YzFy?=
 =?utf-8?B?THQ5RkhHR0JOTmVJZHN5YTQwbGZ3Q0VKbk1peDh1bFJBZzBybkFvY1BZYjIr?=
 =?utf-8?B?U1lwd0k0ams1akFDN3owTXp6TVBwYUJMbGUxRWJIdFBSR2Y5dWZHMFNXSEkr?=
 =?utf-8?B?MFVNeTRlR2k0c21UWVYyUXVpczJqNTRHTVJQQnd5ZitkbytzNXhHQkhmcElK?=
 =?utf-8?B?Q3BSaWo0bmhKdGVJd0hCcWdFdEtPUm8yWlVvWHRGMW1ZbjlRbm50Z0JOWERu?=
 =?utf-8?B?cUNFRUp0QzRIZ1kxS1huaWE4S250TXA1aGZUb2h4VkFvMzdpUmsybnpGS1Rz?=
 =?utf-8?B?NzR1dnBxNG5EcGphYWZPMTJnZ0FTQlF5OElXOG95Q1JUeDVSQnJ6V1BBVTY3?=
 =?utf-8?B?WGg4clhndEFkZnpBK252d1VFQzVGcUYvTkk2c2xxSlkzYlNnRFlqRXdVS2dE?=
 =?utf-8?B?N0F1UWQxZXQvQ2g5WHRmZGRBTnRUNW5KWGh1WitMSWY1K1o5cjNoM3hKMk9p?=
 =?utf-8?B?My9zNDFkTHROdVU5RTB0VzliMXJzOVBTQTl2WmJtOGZHblNMamd5ZkFLWjJW?=
 =?utf-8?B?VlpjM3FOL3BmMmRxRzVhOHJPMXZSamo5QTIvUWppZGhGdEdGdlZtdDgxZHBl?=
 =?utf-8?B?Y0FtaVlXUjdabnRSOU1kVDU2YTF5ZFpTYlFjY1lCL2taZnRybW5pREFmYm9K?=
 =?utf-8?B?OGY1TEZNcTd0cEJzKzBueUt5REN1WUc5amprb0FUZ3dtZU8zU2dnSEN0VEdl?=
 =?utf-8?B?aUxjOTd6U25JaXErckZhc1JDUkd5R2lxdENzWGhRQkZpVGJvQ3R3aHg0YWRQ?=
 =?utf-8?B?Rm42eG5pa3ovVzlFKytpU1oxUDRRNS8yOUJrUEpuMlFZOVZteU0wSXlyYXRw?=
 =?utf-8?B?b2l1ZHNtYW8vMlhydTQwWXhwK2hEOEprMUJVaHdBTnQ0L0RmT01Pdk5lanpw?=
 =?utf-8?B?NU43bVJuN0dqTUE5b2NKeitMcXVKa2xOQVJqaGpWS0ZGMXB0UWVjMUpkUnRl?=
 =?utf-8?B?bXRwQVBpQzlOUnZiSUVZd3J2RjZDNWVjZTAvcVUvQlF2d3BFU3psWjcycytT?=
 =?utf-8?Q?/Z87VBHxe3I6drihbvoMQbZb+vfKT+rmWdwXJDc?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89beccc8-cf9c-4915-2281-08d8d74e79ac
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2021 16:25:32.3552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QnD/yZJLfTYIcTDa+I5JL1EpEZsNmZfkmGyrXyPfXNwDdZBywqNe5m4ZVOJyizeyQSY8OTsTS7CAfPRn4ggpZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2710
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9903 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220149
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9903 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0 clxscore=1011
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220149
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 2/22/21 2:24 AM, Luis Henriques wrote:
> A regression has been reported by Nicolas Boichat, found while using the
> copy_file_range syscall to copy a tracefs file.  Before commit
> 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices") the
> kernel would return -EXDEV to userspace when trying to copy a file across
> different filesystems.  After this commit, the syscall doesn't fail anymore
> and instead returns zero (zero bytes copied), as this file's content is
> generated on-the-fly and thus reports a size of zero.
>
> This patch restores some cross-filesystem copy restrictions that existed
> prior to commit 5dae222a5ff0 ("vfs: allow copy_file_range to copy across
> devices").  Filesystems are still allowed to fall-back to the VFS
> generic_copy_file_range() implementation, but that has now to be done
> explicitly.
>
> nfsd is also modified to fall-back into generic_copy_file_range() in case
> vfs_copy_file_range() fails with -EOPNOTSUPP or -EXDEV.
>
> Fixes: 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices")
> Link: https://urldefense.com/v3/__https://lore.kernel.org/linux-fsdevel/20210212044405.4120619-1-drinkcat@chromium.org/__;!!GqivPVa7Brio!P1UWThiSkxbjfjFQWNYJmCxGEkiLFyvHjH6cS-G1ZTt1z-TeqwGQgQmi49dC6w$
> Link: https://urldefense.com/v3/__https://lore.kernel.org/linux-fsdevel/CANMq1KDZuxir2LM5jOTm0xx*BnvW=ZmpsG47CyHFJwnw7zSX6Q@mail.gmail.com/__;Kw!!GqivPVa7Brio!P1UWThiSkxbjfjFQWNYJmCxGEkiLFyvHjH6cS-G1ZTt1z-TeqwGQgQmgCmMHzA$
> Link: https://urldefense.com/v3/__https://lore.kernel.org/linux-fsdevel/20210126135012.1.If45b7cdc3ff707bc1efa17f5366057d60603c45f@changeid/__;!!GqivPVa7Brio!P1UWThiSkxbjfjFQWNYJmCxGEkiLFyvHjH6cS-G1ZTt1z-TeqwGQgQmzqItkrQ$
> Reported-by: Nicolas Boichat <drinkcat@chromium.org>
> Signed-off-by: Luis Henriques <lhenriques@suse.de>
> ---
> Changes since v7
> - set 'ret' to '-EOPNOTSUPP' before the clone 'if' statement so that the
>    error returned is always related to the 'copy' operation
> Changes since v6
> - restored i_sb checks for the clone operation
> Changes since v5
> - check if ->copy_file_range is NULL before calling it
> Changes since v4
> - nfsd falls-back to generic_copy_file_range() only *if* it gets -EOPNOTSUPP
>    or -EXDEV.
> Changes since v3
> - dropped the COPY_FILE_SPLICE flag
> - kept the f_op's checks early in generic_copy_file_checks, implementing
>    Amir's suggestions
> - modified nfsd to use generic_copy_file_range()
> Changes since v2
> - do all the required checks earlier, in generic_copy_file_checks(),
>    adding new checks for ->remap_file_range
> - new COPY_FILE_SPLICE flag
> - don't remove filesystem's fallback to generic_copy_file_range()
> - updated commit changelog (and subject)
> Changes since v1 (after Amir review)
> - restored do_copy_file_range() helper
> - return -EOPNOTSUPP if fs doesn't implement CFR
> - updated commit description
>
>   fs/nfsd/vfs.c   |  8 +++++++-
>   fs/read_write.c | 49 ++++++++++++++++++++++++-------------------------
>   2 files changed, 31 insertions(+), 26 deletions(-)
>
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 04937e51de56..23dab0fa9087 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -568,6 +568,7 @@ __be32 nfsd4_clone_file_range(struct nfsd_file *nf_src, u64 src_pos,
>   ssize_t nfsd_copy_file_range(struct file *src, u64 src_pos, struct file *dst,
>   			     u64 dst_pos, u64 count)
>   {
> +	ssize_t ret;
>   
>   	/*
>   	 * Limit copy to 4MB to prevent indefinitely blocking an nfsd
> @@ -578,7 +579,12 @@ ssize_t nfsd_copy_file_range(struct file *src, u64 src_pos, struct file *dst,
>   	 * limit like this and pipeline multiple COPY requests.
>   	 */
>   	count = min_t(u64, count, 1 << 22);
> -	return vfs_copy_file_range(src, src_pos, dst, dst_pos, count, 0);
> +	ret = vfs_copy_file_range(src, src_pos, dst, dst_pos, count, 0);
> +
> +	if (ret == -EOPNOTSUPP || ret == -EXDEV)
> +		ret = generic_copy_file_range(src, src_pos, dst, dst_pos,
> +					      count, 0);
> +	return ret;
>   }
>   
>   __be32 nfsd4_vfs_fallocate(struct svc_rqst *rqstp, struct svc_fh *fhp,
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 75f764b43418..5a26297fd410 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1388,28 +1388,6 @@ ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
>   }
>   EXPORT_SYMBOL(generic_copy_file_range);
>   
> -static ssize_t do_copy_file_range(struct file *file_in, loff_t pos_in,
> -				  struct file *file_out, loff_t pos_out,
> -				  size_t len, unsigned int flags)
> -{
> -	/*
> -	 * Although we now allow filesystems to handle cross sb copy, passing
> -	 * a file of the wrong filesystem type to filesystem driver can result
> -	 * in an attempt to dereference the wrong type of ->private_data, so
> -	 * avoid doing that until we really have a good reason.  NFS defines
> -	 * several different file_system_type structures, but they all end up
> -	 * using the same ->copy_file_range() function pointer.
> -	 */
> -	if (file_out->f_op->copy_file_range &&
> -	    file_out->f_op->copy_file_range == file_in->f_op->copy_file_range)
> -		return file_out->f_op->copy_file_range(file_in, pos_in,
> -						       file_out, pos_out,
> -						       len, flags);
> -
> -	return generic_copy_file_range(file_in, pos_in, file_out, pos_out, len,
> -				       flags);
> -}
> -
>   /*
>    * Performs necessary checks before doing a file copy
>    *
> @@ -1427,6 +1405,25 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
>   	loff_t size_in;
>   	int ret;
>   
> +	/*
> +	 * Although we now allow filesystems to handle cross sb copy, passing
> +	 * a file of the wrong filesystem type to filesystem driver can result
> +	 * in an attempt to dereference the wrong type of ->private_data, so
> +	 * avoid doing that until we really have a good reason.  NFS defines
> +	 * several different file_system_type structures, but they all end up
> +	 * using the same ->copy_file_range() function pointer.
> +	 */
> +	if (file_out->f_op->copy_file_range) {
> +		if (file_in->f_op->copy_file_range !=
> +		    file_out->f_op->copy_file_range)
> +			return -EXDEV;
> +	} else if (file_in->f_op->remap_file_range) {
> +		if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
> +			return -EXDEV;

I think this check is redundant, it's done in vfs_copy_file_range.
If this check is removed then the else clause below should be removed
also. Once this check and the else clause are removed then might as
well move the the check of copy_file_range from here to vfs_copy_file_range.

-Dai

> +	} else {
> +                return -EOPNOTSUPP;
> +	}
> +
>   	ret = generic_file_rw_checks(file_in, file_out);
>   	if (ret)
>   		return ret;
> @@ -1495,6 +1492,7 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
>   
>   	file_start_write(file_out);
>   
> +	ret = -EOPNOTSUPP;
>   	/*
>   	 * Try cloning first, this is supported by more file systems, and
>   	 * more efficient if both clone and copy are supported (e.g. NFS).
> @@ -1513,9 +1511,10 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
>   		}
>   	}
>   
> -	ret = do_copy_file_range(file_in, pos_in, file_out, pos_out, len,
> -				flags);
> -	WARN_ON_ONCE(ret == -EOPNOTSUPP);
> +	if (file_out->f_op->copy_file_range)
> +		ret = file_out->f_op->copy_file_range(file_in, pos_in,
> +						      file_out, pos_out,
> +						      len, flags);
>   done:
>   	if (ret > 0) {
>   		fsnotify_access(file_in);
