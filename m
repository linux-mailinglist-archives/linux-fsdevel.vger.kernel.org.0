Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACB7115B3E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 23:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgBLWgT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 17:36:19 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:39444 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbgBLWgT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 17:36:19 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01CMX9MJ158365;
        Wed, 12 Feb 2020 22:36:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=VFeSDsgSBvkQAC4z/Epd6NqlaYojuS+u2gfW5E/QwC4=;
 b=UP7DA0+DBjoniEOZ2unVe/1twDOMAmw35AUqi1AeAigPOI7kxNDRIhOSGcETQYEngE1p
 qtQgzGiCiedHq185FHlc1VWXbZkvP0fj9fzTuYpDlTv23TfeiY29OFGu9byfet8vGQfi
 zdQqFrsgUDJvXSQeZPpAUTWxiMvaG0BCnzB/xDUS+9kJceM8YBGpx4a4Jqr6qkIxJVNn
 2aa5BltylYYbAJOkhZ5r0WTZjMsbUCUOy0IezgK8XHPWpB3HRvz2fH5ZddDFC932cag5
 XU16lYwR9JGKfsW83yBt510a8cx3Ai93V1AnG6itsUwKJ86xGAAOpN/epnDJ8CpGbK8f +w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2y2p3snvhb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Feb 2020 22:36:11 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01CMVjtS085470;
        Wed, 12 Feb 2020 22:36:10 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2y4k7xh5d5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Feb 2020 22:36:10 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01CMa9ia000619;
        Wed, 12 Feb 2020 22:36:09 GMT
Received: from localhost (/10.159.151.237)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Feb 2020 14:36:08 -0800
Date:   Wed, 12 Feb 2020 14:36:06 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Allison Collins <allison.henderson@oracle.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        xfs <linux-xfs@vger.kernel.org>, Eryu Guan <guaneryu@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lsf-pc@lists.linux-foundation.org
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] FS Maintainers Don't Scale
Message-ID: <20200212223606.GQ6874@magnolia>
References: <20200131052520.GC6869@magnolia>
 <CAOQ4uxh=4DrH_dL3TULcFa+pGk0YhS=TobuGk_+Z0oRWvw63rg@mail.gmail.com>
 <8983ceaa-1fda-f9cc-73c9-8764d010d3e2@oracle.com>
 <20200202214620.GA20628@dread.disaster.area>
 <fc430471-54d2-bb44-d084-a37e7ff9ef50@oracle.com>
 <20200212220600.GS6870@magnolia>
 <CAPcyv4gzGzgYxEDC-hjy9cy2M+V_t9VcALM3jmH=_K8XheOF-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gzGzgYxEDC-hjy9cy2M+V_t9VcALM3jmH=_K8XheOF-w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9529 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002120154
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9529 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002120154
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 12, 2020 at 02:19:40PM -0800, Dan Williams wrote:
> On Wed, Feb 12, 2020 at 2:07 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> [..]
> > I've really really wanted to be able to tell people to just send a pull
> > request for large series and skip all the email patch review stuff, but
> > I'm well aware that will start a popular revolt.  But maybe we can do
> > both?  Is it legit to ask that if you're sending more than a simple
> > quickfix, to please push a branch somewhere so that I can just yank it
> > down and have a look?  I try to do that with every series that I send, I
> > think Allison has been doing that, Christoph does it sometimes, etc.
> 
> This is begging me to point out that Konstantin has automated this
> with his get-lore-mbox tool [1]. As long as the submitter uses "git
> format-patch --base..." then the tool can automate recreating a local
> branch from a mail series.
> 
> [1]: https://lore.kernel.org/workflows/20200201030105.k6akvbjpmlpcuiky@chatter.i7.local/

Yes, I'm aware of the development of git-lore-mbox, but I'd rather just
pull directly from a developer's git repo than create branches on my
computer.  I /already/ have my own script to extract patches and
apply/paste/staple them onto a git tree, and xfsprogs already has
scripts to automate porting of libxfs change from the kernel.

My goal here is more to change the balance of who does what work a
little bit back towards patch authors, than it is to spend less time
putting together git trees.  I mean, most of you already use git already
anyway, right?  :)

--D
