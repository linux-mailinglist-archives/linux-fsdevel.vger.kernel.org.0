Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A48F2CFFF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 22:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfE1UHS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 16:07:18 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55630 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbfE1UHS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 16:07:18 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4SJx2ZL150028;
        Tue, 28 May 2019 20:07:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=U05eCZuG02SBPyEtw5uTntQGOPqDCptRYM6hq30hqJI=;
 b=jSzjbiBKLccZsX5kQiXenaqtAHVHu4sMYHbZ5/hEwIURYgbgMxrZvw6wvq4jbW1spmg+
 G7CSaGzqeBEl/9HK6uVpesa8qFUaoVUeeOMgTJVrEWHLYpsbe9JLq0vjyd09PyOWZT89
 chURnfnTLnz9QbG7crTD67lrMlBHub+mqar8lW/X1axgFzZP/wrXP4eHZLHMBL5hHreX
 4cTlE1va7PglClt9CHv8JLG6gJfPp5AAbnQT+mmquOabE83bsdBqi7TaEFKn9Vbn++ZT
 EeAl5OC+vcEs1qNPE7oEP3p7ZWANDmHkEdQRLn++jMvtBuH+uKMSgpBf9WPCayvMmtMr 1A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2spw4tdm5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 20:07:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4SK65RV116514;
        Tue, 28 May 2019 20:07:03 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2sr31uvahp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 20:07:02 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4SK7106017055;
        Tue, 28 May 2019 20:07:01 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 May 2019 13:07:00 -0700
Date:   Tue, 28 May 2019 13:06:59 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Theodore Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Dave Chinner <david@fromorbit.com>, Chris Mason <clm@fb.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [RFC][PATCH] link.2: AT_ATOMIC_DATA and AT_ATOMIC_METADATA
Message-ID: <20190528200659.GK5221@magnolia>
References: <20190527172655.9287-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527172655.9287-1-amir73il@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9271 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905280125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9271 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905280125
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 27, 2019 at 08:26:55PM +0300, Amir Goldstein wrote:
> New link flags to request "atomic" link.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Hi Guys,
> 
> Following our discussions on LSF/MM and beyond [1][2], here is
> an RFC documentation patch.
> 
> Ted, I know we discussed limiting the API for linking an O_TMPFILE
> to avert the hardlinks issue, but I decided it would be better to
> document the hardlinks non-guaranty instead. This will allow me to
> replicate the same semantics and documentation to renameat(2).
> Let me know how that works out for you.
> 
> I also decided to try out two separate flags for data and metadata.
> I do not find any of those flags very useful without the other, but
> documenting them seprately was easier, because of the fsync/fdatasync
> reference.  In the end, we are trying to solve a social engineering
> problem, so this is the least confusing way I could think of to describe
> the new API.
> 
> First implementation of AT_ATOMIC_METADATA is expected to be
> noop for xfs/ext4 and probably fsync for btrfs.
> 
> First implementation of AT_ATOMIC_DATA is expected to be
> filemap_write_and_wait() for xfs/ext4 and probably fdatasync for btrfs.
> 
> Thoughts?
> 
> Amir.
> 
> [1] https://lwn.net/Articles/789038/
> [2] https://lore.kernel.org/linux-fsdevel/CAOQ4uxjZm6E2TmCv8JOyQr7f-2VB0uFRy7XEp8HBHQmMdQg+6w@mail.gmail.com/
> 
>  man2/link.2 | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/man2/link.2 b/man2/link.2
> index 649ba00c7..15c24703e 100644
> --- a/man2/link.2
> +++ b/man2/link.2
> @@ -184,6 +184,57 @@ See
>  .BR openat (2)
>  for an explanation of the need for
>  .BR linkat ().
> +.TP
> +.BR AT_ATOMIC_METADATA " (since Linux 5.x)"
> +By default, a link operation followed by a system crash, may result in the
> +new file name being linked with old inode metadata, such as out dated time
> +stamps or missing extended attributes.
> +.BR fsync (2)
> +before linking the inode, but that involves flushing of volatile disk caches.
> +
> +A filesystem that accepts this flag will guaranty, that old inode metadata
> +will not be exposed in the new linked name.
> +Some filesystems may internally perform
> +.BR fsync (2)
> +before linking the inode to provide this guaranty,
> +but often, filesystems will have a more efficient method to provide this
> +guaranty without flushing volatile disk caches.
> +
> +A filesystem that accepts this flag does
> +.BR NOT
> +guaranty that the new file name will exist after a system crash, nor that the
> +current inode metadata is persisted to disk.

Hmmm.  I think it would be much clearer to state the two expectations in
the same place, e.g.:

"A filesystem that accepts this flag guarantees that after a successful
call completion, the filesystem will return either (a) the version of
the metadata that was on disk at the time the call completed; (b) a
newer version of that metadata; or (c) -ENOENT.  In other words, a
subsequent access of the file path will never return metadata that was
obsolete at the time that the call completed, even if the system crashes
immediately afterwards."

Did I get that right?  I /think/ this means that one could implement Ye
Olde Write And Rename as:

fd = open(".", O_TMPFILE...);
write(fd);
fsync(fd);
snprintf(path, PATH_MAX, "/proc/self/fd/%d", fd);
linkat(AT_FDCWD, path, AT_FDCWD, "file.txt",
	AT_EMPTY_PATH | AT_ATOMIC_DATA | AT_ATOMIC_METADATA);

(Still struggling to figure out what userspace programs would use this
for...)

--D

> +Specifically, if a file has hardlinks, the existance of the linked name after
> +a system crash does
> +.BR NOT
> +guaranty that any of the other file names exist, nor that the last observed
> +value of
> +.I st_nlink
> +(see
> +.BR stat (2))
> +has persisted.
> +.TP
> +.BR AT_ATOMIC_DATA " (since Linux 5.x)"
> +By default, a link operation followed by a system crash, may result in the
> +new file name being linked with old data or missing data.
> +One way to prevent this is to call
> +.BR fdatasync (2)
> +before linking the inode, but that involves flushing of volatile disk caches.
> +
> +A filesystem that accepts this flag will guaranty, that old data
> +will not be exposed in the new linked name.
> +Some filesystems may internally perform
> +.BR fsync (2)
> +before linking the inode to provide this guaranty,
> +but often, filesystems will have a more efficient method to provide this
> +guaranty without flushing volatile disk caches.
> +
> +A filesystem that accepts this flag does
> +.BR NOT
> +guaranty that the new file name will exist after a system crash, nor that the
> +current inode data is persisted to disk.
> +.TP
>  .SH RETURN VALUE
>  On success, zero is returned.
>  On error, \-1 is returned, and
> -- 
> 2.17.1
> 
