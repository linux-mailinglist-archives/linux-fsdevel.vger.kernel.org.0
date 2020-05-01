Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E13F1C1E38
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 22:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgEAULi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 16:11:38 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51962 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgEAULi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 16:11:38 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 041K90Rn182841;
        Fri, 1 May 2020 20:11:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=tWXXVZbfyWYRhB2LaRYwreVJsO3eoixxNwcIh5l+OR8=;
 b=jXBQh2z4N19PqyDqu93NAf01N6KhXPJz/drQtiVYVMmU3lbh5kKnXzqQjL0rNpHOm2iJ
 X9ehpazA56pKkiHZOzdN1h4E6xKnwmt+hTly8kjXOjdNfVDOzzzDaadtJaiv+27jF9ko
 hV07FaVyghtj8wTZ05ateMp+lV6W62P1TGin3y66d82Hh/H1dEhltnafuskDtWVwFIRJ
 u9aE1I4Abv7KtAlD55pDYi7DIc7k0OXR6QfqlhvbdRCNLFhdl+p2aoAclQO8fv4W8jz0
 gp8HyO3SqkXxLT+jOpVZ6f2oVVWJsl4sJTTPuRap6mdKnfc0TR+Rkq9SVBYLUM952ENA Ig== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 30r7f3kvyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 May 2020 20:11:35 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 041K8V6d074792;
        Fri, 1 May 2020 20:11:35 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 30r7f4v6rc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 May 2020 20:11:35 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 041KBYIt011957;
        Fri, 1 May 2020 20:11:34 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 01 May 2020 13:11:33 -0700
Date:   Fri, 1 May 2020 13:11:32 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Jann Horn <jannh@google.com>
Cc:     linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH RFC 00/18] xfs: atomic file updates
Message-ID: <20200501201132.GA6742@magnolia>
References: <158812825316.168506.932540609191384366.stgit@magnolia>
 <CAG48ez0Fa6NSmO2a5kuzp6GCAXAXQtBzEDO+YcBL4BW105tF+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0Fa6NSmO2a5kuzp6GCAXAXQtBzEDO+YcBL4BW105tF+w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9608 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005010146
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9608 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 impostorscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005010146
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 01, 2020 at 09:46:07PM +0200, Jann Horn wrote:
> On Wed, Apr 29, 2020 at 4:46 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> > This series creates a new log incompat feature and log intent items to
> > track high level progress of swapping ranges of two files and finish
> > interrupted work if the system goes down.  It then adds a new
> > FISWAPRANGE ioctl so that userspace can access the atomic extent
> > swapping feature.  With this feature, user programs will be able to
> > update files atomically by opening an O_TMPFILE, reflinking the source
> > file to it, making whatever updates they want to make, and then
> > atomically swap the changed bits back to the source file.  It even has
> > an optional ability to detect a changed source file and reject the
> > update.
> >
> > The intent behind this new userspace functionality is to enable atomic
> > rewrites of arbitrary parts of individual files.  For years, application
> > programmers wanting to ensure the atomicity of a file update had to
> > write the changes to a new file in the same directory, fsync the new
> > file, rename the new file on top of the old filename, and then fsync the
> > directory.  People get it wrong all the time, and $fs hacks abound.
> >
> > With atomic file updates, this is no longer necessary.  Programmers
> > create an O_TMPFILE, optionally FICLONE the file contents into the
> > temporary file, make whatever changes they want to the tempfile, and
> > FISWAPRANGE the contents from the tempfile into the regular file.
> 
> That also requires the *readers* to be atomic though, right? Since now
> the updates are visible to readers instantly, instead of only on the
> next open()? If you used this to update /etc/passwd while someone else
> is in the middle of reading it with a sequence of read() calls, there
> would be fireworks...

Right.  In XFS, we guarantee read atomicity by by grabbing i_rwsem and
the xfs mmap lock, break any layout leases, drain the directios, and
then flush+invalidate the page cache.  Once that preparation step is
done, we do the actual extent swap.

> I guess maybe the new API could also be wired up to ext4's
> EXT4_IOC_MOVE_EXT somehow, provided that the caller specifies
> FILE_SWAP_RANGE_NONATOMIC?

Sort of.  ext4's MOVE_EXT also swaps the file contents doing the swap
one buffer_head at a time, so you'd have to turn that off since this API
assumes that the caller already set each file's contents beforehand.

Ted has theorized that so long as the extent map size is less than 1/4
of the journal then it would be possible to do atomic swaps in ext4
without adding all the logical log item bits that were a prerequisite
for the xfs implementation.

--D
