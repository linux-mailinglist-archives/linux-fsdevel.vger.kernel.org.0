Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3B4B71F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 05:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387539AbfISDp3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 23:45:29 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53118 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbfISDp3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 23:45:29 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8J3j64n134891;
        Thu, 19 Sep 2019 03:45:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=RQE4bMXuARGk/t/4ZdmiK5ZD0ABEJdWhi9nMJhOr3LQ=;
 b=T8vYfqz+LMr5VBMRnBUDER83vzLJRDKVt2V/HAzNQN0OFgnFORPijInRf4ecpPEDGlAg
 uEHVRdoTp2UywXtNbqFALSNGcHLotInHJMHMXcp572hso74eLu9Zl2rFiPG146tKsXvj
 yRbwjPC84QyRDIRqgRNgSO58QaL1fW0YsVzI3Z6tQs/IZ85dY+R4FbJBOYTwfXsuVeVP
 wnLDp2oemLBL0IPhynkgnqkSVPHoSwMFmhCCP9Xs9YPTNa3utCiVkpLE7UzQSct8KzRP
 Xgkgqjdqni3stb2EnDRUZB7+fo2NsFwtbA2LKigeg0JDcHgaXZE85Otim+0Hl3fPseml MQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2v3vb4s1rg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Sep 2019 03:45:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8J3hsBZ140517;
        Thu, 19 Sep 2019 03:45:05 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2v3vbr6kj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Sep 2019 03:45:05 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8J3j3wY001681;
        Thu, 19 Sep 2019 03:45:03 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 18 Sep 2019 20:45:03 -0700
Date:   Wed, 18 Sep 2019 20:45:02 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>
Subject: Re: [GIT PULL] iomap: new code for 5.4
Message-ID: <20190919034502.GJ2229799@magnolia>
References: <20190917152140.GU2229799@magnolia>
 <CAHk-=wj9Zjb=NENJ6SViNiYiYi4LFX9WYqskZh4E_OzjijK1VA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj9Zjb=NENJ6SViNiYiYi4LFX9WYqskZh4E_OzjijK1VA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9384 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909190031
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9384 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909190032
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 18, 2019 at 06:31:29PM -0700, Linus Torvalds wrote:
> On Tue, Sep 17, 2019 at 8:21 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > Please pull this series containing all the new iomap code for 5.4.
> 
> So looking at the non-iomap parts of it, I react to the new "list_pop() code.
> 
> In particular, this:
> 
>         struct list_head *pos = READ_ONCE(list->next);
> 
> is crazy to begin with..
> 
> It seems to have come from "list_empty()", but the difference is that
> it actually makes sense to check for emptiness of a list outside
> whatever lock that protects the list. It can be one of those very
> useful optimizations where you don't even bother taking the lock if
> you can optimistically check that the list is empty.
> 
> But the same is _not_ true of an operation like "list_pop()". By
> definition, the list you pop something off has to be stable, so the
> READ_ONCE() makes no sense here.
> 
> Anyway, if that was the only issue, I wouldn't care. But looking
> closer, the whole thing is just completely wrong.
> 
> All the users seem to do some version of this:
> 
>         struct list_head tmp;
> 
>         list_replace_init(&ioend->io_list, &tmp);
>         iomap_finish_ioend(ioend, error);
>         while ((ioend = list_pop_entry(&tmp, struct iomap_ioend, io_list)))
>                 iomap_finish_ioend(ioend, error);
> 
> which is completely wrong and pointless.
> 
> Why would anybody use that odd "list_pop()" thing in a loop, when what
> it really seems to just want is that bog-standard
> "list_for_each_entry_safe()"
> 
>         struct list_head tmp;
>         struct iomap_ioend *next;
> 
>         list_replace_init(&ioend->io_list, &tmp);
>         iomap_finish_ioend(ioend, error);
>         list_for_each_entry_safe(struct iomap_ioend, next, &tmp, io_list)
>                 iomap_finish_ioend(ioend, error);
> 
> which is not only the common pattern, it's more efficient and doesn't
> pointlessly re-write the list for each entry, it just walks it (and
> the "_safe()" part is because it looks up the next entry early, so
> that the entry that it's walking can be deleted).
> 
> So I pulled it. But then after looking at it, I unpulled it again
> because I don't want to see this kind of insanity in one of THE MOST
> CORE header files we have in the whole kernel.
> 
> If xfs and iomap want to think they are "popping" a list, they can do
> so. In the privacy of your own home, you can do stupid and pointless
> things.
> 
> But no, we don't pollute core kernel code with those stupid and
> pointless things.

Ok, thanks for the feedback.  TBH I'd wondered if list_pop was really
necessary, but as it didn't seem to harm anything I let it go.

Anyway, how should I proceed now?  Christoph? :D

I propose the following (assuming Linus isn't cranky enough to refuse
the entire iomap patchpile forever):

Delete patch 1 and 9 from the series, and amend patch 2 as such:

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 051b8ec326ba..558d09bc5024 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1156,10 +1156,11 @@ void
 iomap_finish_ioends(struct iomap_ioend *ioend, int error)
 {
 	struct list_head tmp;
+	struct iomap_ioend *next;
 
 	list_replace_init(&ioend->io_list, &tmp);
 	iomap_finish_ioend(ioend, error);
-	while ((ioend = list_pop_entry(&tmp, struct iomap_ioend, io_list)))
+	list_for_each_entry_safe(ioend, next, &tmp, io_list)
 		iomap_finish_ioend(ioend, error);
 }
 EXPORT_SYMBOL_GPL(iomap_finish_ioends);

Does that sound ok?  It's been running through xfstests for a couple of
hours now and hasn't let any smoke out...

--D

> 
>               Linus
> 
