Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2BC48A48E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 19:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfHLRb7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 13:31:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6506 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727167AbfHLRb6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 13:31:58 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7CHRHwP098825
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2019 13:31:57 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ub9m0r76t-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2019 13:31:57 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Mon, 12 Aug 2019 18:31:54 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 12 Aug 2019 18:31:52 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7CHVpKE38011286
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Aug 2019 17:31:51 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9552D52051;
        Mon, 12 Aug 2019 17:31:51 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.31.57])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id AF04F5204F;
        Mon, 12 Aug 2019 17:31:50 +0000 (GMT)
Subject: Re: [PATCH 0/5] ext4: direct IO via iomap infrastructure
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, jack@suse.cz, tytso@mit.edu
References: <cover.1565609891.git.mbobrowski@mbobrowski.org>
From:   RITESH HARJANI <riteshh@linux.ibm.com>
Date:   Mon, 12 Aug 2019 23:01:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <cover.1565609891.git.mbobrowski@mbobrowski.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19081217-0016-0000-0000-0000029DEA5A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081217-0017-0000-0000-000032FDFB1A
Message-Id: <20190812173150.AF04F5204F@d06av21.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-12_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908120193
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Matthew,

On 8/12/19 6:22 PM, Matthew Bobrowski wrote:

> This patch series converts the ext4 direct IO code paths to make use of the
> iomap infrastructure and removes the old buffer_head direct-io based
> implementation. The result is that ext4 is converted to the newer framework
> and that it may _possibly_ gain a performance boost for O_SYNC | O_DIRECT IO.
>
> These changes have been tested using xfstests in both DAX and non-DAX modes
> using various configurations i.e. 4k, dioread_nolock, dax.

I had some minor review comments posted on Patch-4.
But the rest of the patch series looks good to me.
I will also do some basic testing of xfstests which I did for my patches 
and will revert back.

One query, could you please help answering below for my understanding :-

I was under the assumption that we need to maintain 
ext4_test_inode_state(inode, EXT4_STATE_DIO_UNWRITTEN) or 
atomic_read(&EXT4_I(inode)->i_unwritten))
in case of non-AIO directIO or AIO directIO case as well (when we may 
allocate unwritten extents),
to protect with some kind of race with other parts of code(maybe 
truncate/bufferedIO/fallocate not sure?) which may call for 
ext4_can_extents_be_merged()
to check if extents can be merged or not.

Is it not the case?
Now that directIO code has no way of specifying that this inode has 
unwritten extent, will it not race with any other path, where this info 
was necessary (like
in above func ext4_can_extents_be_merged())?


Thanks
Ritesh

>
> Matthew Bobrowski (5):
>    ext4: introduce direct IO read code path using iomap infrastructure
>    ext4: move inode extension/truncate code out from ext4_iomap_end()
>    iomap: modify ->end_io() calling convention
>    ext4: introduce direct IO write code path using iomap infrastructure
>    ext4: clean up redundant buffer_head direct IO code
>
>   fs/ext4/ext4.h        |   3 -
>   fs/ext4/extents.c     |   8 +-
>   fs/ext4/file.c        | 329 +++++++++++++++++++++++++++-------
>   fs/ext4/inode.c       | 488 +++++---------------------------------------------
>   fs/iomap/direct-io.c  |   9 +-
>   fs/xfs/xfs_file.c     |  17 +-
>   include/linux/iomap.h |   4 +-
>   7 files changed, 322 insertions(+), 536 deletions(-)
>

