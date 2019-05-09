Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B48F184E1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2019 07:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfEIFiY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 May 2019 01:38:24 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:51288 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfEIFiY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 May 2019 01:38:24 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x495Xd4j138204;
        Thu, 9 May 2019 05:38:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=Hc8xW/AB5uUx6JIALjah1tUfp2CwQe483WIkPQD5bkE=;
 b=c3b/pGnZZt6CsqWm5ODLqF5HzhLz28gKswhDUtgL26Rt4CPajCkDJ5SE3JbzWdjwxkVO
 bYQfq4TPy9hpq0M5u24+Kriwr3mRihDF71vBluTOhPprB4aMYWWEMyCuACdoBKlSX+1h
 sTx8pcnhFqKX0nXcNfN6eLyw/j30GsRMYhfvmdtNBN2Z0jzl0NrIDpNG9GAb8mg7py0R
 +sRxkbt6vIsDIT7nlpS+8qBIF70eL+Wix4z24URdojzl/G7VUN9bmWVKj3PAGydzVMsm
 ef8G+GbPLNL2BrX6W2gK0EYFYga7IRWWGSE4aSz8L5CgSwqqYsgR5ZpsEOSkNbh1Bq9A 8g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2s94b68eeq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 05:38:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x495bOrW092692;
        Thu, 9 May 2019 05:37:59 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2s94agk0bs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 05:37:59 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x495bsLs010113;
        Thu, 9 May 2019 05:37:55 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 May 2019 05:37:54 +0000
Date:   Wed, 8 May 2019 22:37:48 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Vijay Chidambaram <vijay@cs.utexas.edu>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        Amir Goldstein <amir73il@gmail.com>,
        lsf-pc@lists.linux-foundation.org, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jayashree Mohan <jaya@cs.utexas.edu>,
        Filipe Manana <fdmanana@suse.com>, Chris Mason <clm@fb.com>,
        lwn@lwn.net
Subject: Re: [TOPIC] Extending the filesystem crash recovery guaranties
 contract
Message-ID: <20190509053748.GF5352@magnolia>
References: <CAOQ4uxjZm6E2TmCv8JOyQr7f-2VB0uFRy7XEp8HBHQmMdQg+6w@mail.gmail.com>
 <CAOQ4uxgEicLTA4LtV2fpvx7okEEa=FtbYE7Qa_=JeVEGXz40kw@mail.gmail.com>
 <CAHWVdUXS+e71QNFAyhFUY4W7o3mzVCb=8UrRZAN=v9bv7j6ssA@mail.gmail.com>
 <CAOQ4uxjNWLvh7EmizA7PjmViG5nPMsvB2UbHW6-hhbZiLadQTA@mail.gmail.com>
 <20190503023043.GB23724@mit.edu>
 <20190509014327.GT1454@dread.disaster.area>
 <20190509022013.GC7031@mit.edu>
 <CAHWVdUVViC_EJm3K7MfvfSQ+G1u=SX=RXAZWPYjZuS16JWxNEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHWVdUVViC_EJm3K7MfvfSQ+G1u=SX=RXAZWPYjZuS16JWxNEw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9251 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905090036
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9251 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905090036
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 09, 2019 at 12:02:17AM -0500, Vijay Chidambaram wrote:
> On Wed, May 8, 2019 at 9:30 PM Theodore Ts'o <tytso@mit.edu> wrote:
> >
> > On Thu, May 09, 2019 at 11:43:27AM +1000, Dave Chinner wrote:
> > >
> > > .... the whole point of SOMC is that allows filesystems to avoid
> > > dragging external metadata into fsync() operations /unless/ there's
> > > a user visible ordering dependency that must be maintained between
> > > objects.  If all you are doing is stabilising file data in a stable
> > > file/directory, then independent, incremental journaling of the
> > > fsync operations on that file fit the SOMC model just fine.
> >
> > Well, that's not what Vijay's crash consistency guarantees state.  It
> > guarantees quite a bit more than what you've written above.  Which is
> > my concern.
> 
> The intention is to capture Dave's SOMC semantics. We can re-iterate
> and re-phrase until we capture what Dave meant precisely. I am fairly
> confident we can do this, given that Dave himself is participating and
> helping us refine the text. So this doesn't seem like a reason not to
> have documentation at all to me.
> 
> As we have stated on multiple times on this and other threads, the
> intention is *not* to come up with one set of crash-recovery
> guarantees that every Linux file system must abide by forever. Ted,
> you keep repeating this, though we have never said this was our
> intention.

It might not be your intention, but I can definitely imagine others
using such a SOMC document as a cudgel to, uh, pressure other
filesystems into implementing the same semantics ("This isn't SOMC
compliant!" "We never said it was." "It has to be compliant!").  That's
fine for XFS because that's how it's supposed to work, but I wouldn't
want other projects to have to defend themselves for lack of XFSiness.

> The intention behind this effort is to simply document the
> crash-recovery guarantees provided today by different Linux file
> systems. Ted, you question why this is required at all, and why we
> simply can't use POSIX and man pages. The answer:
> 
> 1. POSIX is vague. Not persisting data to stable media on fsync is
> also allowed in POSIX (but no Linux file system actually does this),
> so its not very useful in terms of understanding what crash-recovery
> guarantees file systems actually provide. Given that all Linux file
> systems provide something more than POSIX, the natural question to ask
> is what do they provide? We understood this from working on
> CrashMonkey, and we wanted to document it.
> 2. Other parts of the Linux kernel have much better documentation,
> even though they similarly want to provide freedom for developers to
> optimize and change internal implementation. I don't think
> documentation and freedom to change internals are mutually exclusive.
> 3. XFS provides SOMC semantics, and btrfs developers have stated they
> want to provide SOMC as well. F2FS developers have a mode in which
> they seek to provide SOMC semantics. Given all this, it seemed prudent
> to document SOMC.

Point.  To further soften/undercut my earlier email, I think we can
document the filesystem behaviors that specific projects are willing to
endorse while still making it clear that YMMV and you had better test
your workload if you want clarity of behavior. :)

> 4. Apart from developers, a document like this would also help
> academic researchers understand the current state-of-the-art in
> crash-recovery guarantees and the different choices made by different
> file systems. It is non-trivial to understand this without
> documentation.
> 
> FWIW, I think the position of "if we don't write it down, application
> developers can't depend on it" is wrong. Even with nothing written
> down, developers noticed they could skip fsync() in ext3 when
> atomically updating files with rename(). This lead to the whole ext4
> rename-and-delayed-allocation problem. The much better path, IMO, is
> to document the current set of guarantees given by different file
> systems, and talk about what is intended and what is not. This would
> give application developers much better guidance in writing
> applications.
> 
> If ext4 wants to develop incremental fsync and introduce a new set of
> semantics that is different from SOMC and much closer to minimal
> POSIX, I don't think the documentation affects that at all. As Dave
> notes, diversity is good! Documentation is also good :)
> 
> That being said, I think I'll stop our push to get this documented
> inside the Linux kernel at this point. We got useful comments from
> Dave, Amir, and others, so we will incorporate those comments and put
> up the documentation on a University of Texas web page. If someone
> else wants to carry on and get this merged, you are welcome to do so
> :)

Aww, I was going to suggest merging it with an explicit warning that the
document *only* reflects those that have endorsed it, and a pileup at
the end:

Endorsed-by: fs/xfs
Endorsed-by: fs/btrfs

Rejected-by: fs/djwongcrazyfs

(I'm still ¾ tempted to just put the XFS parts in a text file and merge
it into fs/xfs/ if the broader effort doesn't succeed...)

--D
