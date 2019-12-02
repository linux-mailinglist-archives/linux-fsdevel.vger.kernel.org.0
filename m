Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7826210F3AF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 00:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfLBX7b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Dec 2019 18:59:31 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:38698 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfLBX7b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Dec 2019 18:59:31 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB2NsNgT149510;
        Mon, 2 Dec 2019 23:58:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=+ZmXwAnD2Aq57WrF0VXR5s5mei/X7zf/fv/3U7krmxY=;
 b=an0kG+K7UhIa6GsG2pz03eOO1JmV4CUTsRUcIfDRsdfpv3x6lRqVDXpHR0gP+1UW8arH
 1Oiaw6z5x8Q1a4C6DJxjhxF+2nxQKb503IXyUBfYFoolZ9ixVJoR1pVpttNekdfyjBp/
 oRNEHC5dbwWJTsygXxlVdogulTCqu2INb5iUiUj8o0wZM0C81UCbaB3h9j5snlcJRsE0
 uYbP0EEu9ZAU9Kr929dIMHofg1MKhbRuxW0iig+amj5EJE8TPLu362olVZz8ocmR/Cyy
 hE36UBQMCy6mglvTakKXoIjkfYpq126UkADHMA3RWCN2Citupkg/qhWQ1acg9jSt6Kc4 XQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2wkh2r3g91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Dec 2019 23:58:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB2NwmOs013799;
        Mon, 2 Dec 2019 23:58:58 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2wn8k1bf53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Dec 2019 23:58:58 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xB2NwMbH026350;
        Mon, 2 Dec 2019 23:58:23 GMT
Received: from localhost (/10.159.148.223)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Dec 2019 15:58:22 -0800
Date:   Mon, 2 Dec 2019 15:58:21 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [GIT PULL] xfs: new code for 5.5
Message-ID: <20191202235821.GF7335@magnolia>
References: <20191201184814.GA7335@magnolia>
 <CAHk-=wi+0suvJAw8hxLkKJHgYwRy-0vg4-dw9_Co6nQHK-XF9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi+0suvJAw8hxLkKJHgYwRy-0vg4-dw9_Co6nQHK-XF9Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9459 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912020206
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9459 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912020205
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 02, 2019 at 03:22:31PM -0800, Linus Torvalds wrote:
> On Sun, Dec 1, 2019 at 10:48 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > FYI, Stephen Rothwell reported a merge conflict with the y2038 tree at
> > the end of October[1].  His resolution looked pretty straightforward,
> > though the current y2038 for-next branch no longer changes fs/ioctl.c
> > (and the changes that were in it are not in upstream master), so that
> > may not be necessary.
> 
> The changes and conflicts are definitely still there (now upstream),
> I'm not sure what made you not see them.  But thanks for the note, I
> compared my end result with linux-next to verify.

Aha!  I pulled master yesterday morning, tried a test merge with xfs,
saw the lack of merge conflicts, and sent you the xfs pull request.  A
few hours later you pulled in the compat ioctl changes from Arnd's git
tree, but the branch in his repo that feeds the -next tree doesn't
contain the compat ioctl changes, so I assumed that meant he wasn't
going to send them for 5.5... and then thought better of myself and
attached an FYI anyway.

> My resolution is different from Stephen's. All my non-x86-64 FS_IOC_*
> cases just do "goto found_handler", because the compat case is
> identical for the native case outside of the special x86-64 alignment
> behavior, and I think that's what Arnd meant to happen.

Yeah, that looks correct to me.  Stephen's solution backed out the
changes that Arnd made for the !x86_64 compat ioctl case, so I or
someone would have had to re-apply them.

> There was some other minor difference too, but it's also possible I
> could have messed up, so cc'ing Stephen and Arnd on this just in case
> they have comments.

<nod> Thanks for sorting this out.

--D

> 
> 
>                Linus
