Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9DB6781A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jul 2019 06:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbfGMEHp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Jul 2019 00:07:45 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42692 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfGMEHp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Jul 2019 00:07:45 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6D46fqx094060;
        Sat, 13 Jul 2019 04:07:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=vnKYntI7sF00JDhKZXOi05w0MftGqOYfOop5mleI+uI=;
 b=XODvCtOpjEKEpUeqfR2hWl41heoVpjOvtKyKkDEJyKdVQCbYvtrLk+NNn6oR0PJPMLtI
 0E4QMiutlmIvp0BhdXLE6jOV66xWKgEXGayiztJP9ghuKMN8FxxtNMjwdBwuEvIBU1S0
 g5zrSFZVz4S2QdLgzBO5OO0unZLA8wc5Cp4BuDu2l9M2F80l0lBO+DpCcl8gxSY9UA6i
 1015OSng4gFvNiC8Em5Fg8sjORbcgpvkJ6YYFyHNZmKhNsKV6JUBl41Pw7BrCpZ9FS4X
 DyI2KcHrb4rhq8CaHGfl6wqk1V0f93KMqFfWBTSVKVVacxSJk83lbHJspeVCjmcQm6GV bg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2tq6qt835y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Jul 2019 04:07:35 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6D42XDV075742;
        Sat, 13 Jul 2019 04:07:34 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2tq5bb1ng6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Jul 2019 04:07:34 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6D47UYA016736;
        Sat, 13 Jul 2019 04:07:30 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 12 Jul 2019 21:07:30 -0700
Date:   Fri, 12 Jul 2019 21:07:28 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [GIT PULL] xfs: new features for 5.3
Message-ID: <20190713040728.GB5347@magnolia>
References: <20190712180205.GA5347@magnolia>
 <CAHk-=wiK8_nYEM2B8uvPELdUziFhp_+DqPN=cNSharQqpBZ6qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiK8_nYEM2B8uvPELdUziFhp_+DqPN=cNSharQqpBZ6qg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9316 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907130046
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9316 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907130046
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 12, 2019 at 05:27:15PM -0700, Linus Torvalds wrote:
> On Fri, Jul 12, 2019 at 11:02 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > The branch merges cleanly against this morning's HEAD and survived an
> > overnight run of xfstests.  The merge was completely straightforward, so
> > please let me know if you run into anything weird.
> 
> Hmm. I don't know what you merged against, but it got a (fairly
> trivial) conflict for me due to
> 
>   79d08f89bb1b ("block: fix .bi_size overflow")
> 
> from the block merge (from Tuesday) touching a line next to one changed by
> 
>   a24737359667 ("xfs: simplify xfs_chain_bio")
> 
> from this pull.
> 
> So it wasn't an entirely clean merge for me.
> 
> Was it a complex merge conflict? No. I'm just confused by the "merges
> cleanly against this morning's HEAD", which makes me wonder what you
> tried to merge against..

Doh, it turns out I was merging against the same HEAD as my last two
pull requests because I forgot to re-pull.  Sorry about that.  It's been
too long of a week. :/

--D

>             Linus
