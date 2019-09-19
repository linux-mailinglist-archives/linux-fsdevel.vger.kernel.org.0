Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4942EB8322
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 23:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733002AbfISVKd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Sep 2019 17:10:33 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51684 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732968AbfISVKd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Sep 2019 17:10:33 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8JL8v1o045702;
        Thu, 19 Sep 2019 21:10:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2019-08-05;
 bh=OGR/I9WESsuN9yWQ4O+Q+JeJro/YOmh4dCPBKi2YaII=;
 b=O/uuFLrhZ2Q9y8HDQqakHYzyD+MsMAWkA5IysYUJh+ZaOZ4S1e4XUHuD2euzfn37fN1E
 MCLDuN01BSD1357zgU84C552TXULfA10BnsGHTyA56mMpmPvcT1Wk9RnZVtUu4Cwsz4Z
 pV6akRzgRUP5lLNhI5oZfjYcl3v9uZ8Kuq4I9seex9nfmEhFR+d/zYkSgxE8yIoiJ7Q9
 muf+LRdcqIjfaZqgB1mjqmQ3/pVAJl4RigmEPOz5Q6FmY50vo5FWJraZbI/OUwX9qDo/
 MJEns8bz0eGD7Aa8va712HbTfrWyT0Vyb9DaafgRrvG2LrJXP1iiMTfutEOkGxw8jVh/ 2w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2v3vb4xmc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Sep 2019 21:10:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8JL8tMP023121;
        Thu, 19 Sep 2019 21:10:17 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2v3vbguxbu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Sep 2019 21:10:17 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8JLAEZP003095;
        Thu, 19 Sep 2019 21:10:15 GMT
Received: from localhost (/10.145.179.91)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Sep 2019 14:10:14 -0700
Date:   Thu, 19 Sep 2019 14:10:13 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     syzbot <syzbot+3c01db6025f26530cf8d@syzkaller.appspotmail.com>,
        agruenba@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Subject: Re: INFO: task hung in pipe_write (2)
Message-ID: <20190919211013.GN5340@magnolia>
References: <000000000000ac6a360592eb26c1@google.com>
 <d9a957b3-9f0a-20b5-588a-64ca4722d433@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9a957b3-9f0a-20b5-588a-64ca4722d433@rasmusvillemoes.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9385 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909190176
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9385 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909190176
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 19, 2019 at 10:55:44PM +0200, Rasmus Villemoes wrote:
> On 19/09/2019 19.19, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following crash on:
> > 
> > HEAD commit:    288b9117 Add linux-next specific files for 20190918
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=17e86645600000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=f6126e51304ef1c3
> > dashboard link:
> > https://syzkaller.appspot.com/bug?extid=3c01db6025f26530cf8d
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11855769600000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=143580a1600000
> > 
> > The bug was bisected to:
> > 
> > commit cfb864757d8690631aadf1c4b80022c18ae865b3
> > Author: Darrick J. Wong <darrick.wong@oracle.com>
> > Date:   Tue Sep 17 16:05:22 2019 +0000
> > 
> >     splice: only read in as much information as there is pipe buffer space
> 
> The middle hunk (the one before splice_pipe_to_pipe()) accesses
> opipe->{buffers, nrbufs}, but opipe is not locked at that point. So
> maybe we end up passing len==0, which seems (once there's room in opipe)
> it would put a zero-length pipe_buffer in opipe - and that probably
> violates an invariant somewhere.
>
> But does the splice_pipe_to_pipe() case even need that extra logic?
> Doesn't it handle short writes correctly already?

Yep.  I missed the part where splice_pipe_to_pipe is already perfectly
capable of detecting insufficient space in opipe and kicking opipe's
readers to clear out the buffer.  So that hunk isn't needed, and now I'm
wondering how in the other clause we return 0 from wait_for_space yet
still don't have buffer space...

Oh well, back to the drawing board.  Good catch, though now it's become
painfully clear that xfstests lacks rigorous testing of splice()...

--D

> Rasmus
