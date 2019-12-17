Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA82C12265B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 09:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfLQIMo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 03:12:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30008 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726524AbfLQIMo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 03:12:44 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBH87KfL041256
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2019 03:12:42 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wvw5c2wyb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2019 03:12:42 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Tue, 17 Dec 2019 08:12:39 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 17 Dec 2019 08:12:36 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBH8CZG155705752
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Dec 2019 08:12:35 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B3DD4C059;
        Tue, 17 Dec 2019 08:12:35 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A81214C040;
        Tue, 17 Dec 2019 08:12:33 +0000 (GMT)
Received: from [9.199.158.112] (unknown [9.199.158.112])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 17 Dec 2019 08:12:33 +0000 (GMT)
Subject: Re: [PATCH 0/1] Use inode_lock/unlock class of provided APIs in
 filesystems
To:     willy@infradead.org, linux-fsdevel@vger.kernel.org,
        jlayton@kernel.org, viro@zeniv.linux.org.uk
Cc:     ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, devel@lists.orangefs.org,
        linux-unionfs@vger.kernel.org
References: <20191205103902.23618-1-riteshh@linux.ibm.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Tue, 17 Dec 2019 13:42:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191205103902.23618-1-riteshh@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19121708-0020-0000-0000-000003990467
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121708-0021-0000-0000-000021F01F27
Message-Id: <20191217081233.A81214C040@d06av22.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-17_01:2019-12-16,2019-12-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxlogscore=757 mlxscore=0 bulkscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912170071
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al, do you think this can be picked up via your tree?
Please let me know if anything needed from my end on this.

-ritesh

On 12/5/19 4:09 PM, Ritesh Harjani wrote:
> Matthew Wilcox in [1] suggested that it will be a good idea
> to define some missing API instead of directly using i_rwsem in
> filesystems drivers for lock/unlock/downgrade purposes.
> 
> This patch does that work. No functionality change in this patch.
> 
> After this there are only lockdep class of APIs at certain places
> in filesystems which are directly using i_rwsem and second is XFS,
> but it seems to be anyway defining it's own xfs_ilock/iunlock set
> of APIs and 'iolock' naming convention for this lock.
> 
> [1]: https://www.spinics.net/lists/linux-ext4/msg68689.html
> 
> Ritesh Harjani (1):
>    fs: Use inode_lock/unlock class of provided APIs in filesystems
> 
>   fs/btrfs/delayed-inode.c |  2 +-
>   fs/btrfs/ioctl.c         |  4 ++--
>   fs/ceph/io.c             | 24 ++++++++++++------------
>   fs/nfs/io.c              | 24 ++++++++++++------------
>   fs/orangefs/file.c       |  4 ++--
>   fs/overlayfs/readdir.c   |  2 +-
>   fs/readdir.c             |  4 ++--
>   include/linux/fs.h       | 21 +++++++++++++++++++++
>   8 files changed, 53 insertions(+), 32 deletions(-)
> 

