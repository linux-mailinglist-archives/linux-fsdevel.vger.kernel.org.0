Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93F8915B3AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 23:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgBLW3w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 17:29:52 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:37126 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbgBLW3v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 17:29:51 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01CMT03a167347;
        Wed, 12 Feb 2020 22:29:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=RgTWQukluu2hQ4eOTQOpBHP0DMQCylJWlv53wC9ZQu4=;
 b=dYV99CxS/YG3Fcem3nBW6+QbRvrDFIQRkJw0kbWVcyM5AhwgtVXZCZuY6dJuhrX8nwLW
 K5SXyGonNdmqqLhOAoDNYr/ZKN5HE6m5rPDsshrTrKJErh1f525mWE2H1tZhIBuU/lE3
 n3RFKfF1fQ9zwkEyNqLt9a4n5uPnJTasFHz6eswTZ9yHwu3cDbzBbraFItHmqEuE5mVo
 jLGPArlpJI4/c+f73s6ub/gIzZGFsV64U0m225LK9LnwQ5VOAbl1CaVNIJgfagwCgAlr
 uVvu/5vVZN2YaZNRJBVNBTbnVIxuyM4HBv1MJG+0NUuVj0O7SxDoO+KBdaehz9jOd7/P nw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2y2k88e2x4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Feb 2020 22:29:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01CMRh0h168720;
        Wed, 12 Feb 2020 22:29:41 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2y4kah1ncb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Feb 2020 22:29:41 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01CMTcrQ028305;
        Wed, 12 Feb 2020 22:29:38 GMT
Received: from localhost (/10.159.151.237)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Feb 2020 14:29:38 -0800
Date:   Wed, 12 Feb 2020 14:29:36 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Matthew Wilcox <willy@infradead.org>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        xfs <linux-xfs@vger.kernel.org>,
        Eric Sandeen <sandeen@redhat.com>,
        Eryu Guan <guaneryu@gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] FS Maintainers Don't Scale
Message-ID: <20200212222936.GU6870@magnolia>
References: <20200131052520.GC6869@magnolia>
 <20200207220333.GI8731@bombadil.infradead.org>
 <20200212035139.GF3630@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212035139.GF3630@mit.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9529 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002120153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9529 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002120153
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 11, 2020 at 10:51:39PM -0500, Theodore Y. Ts'o wrote:
> On Fri, Feb 07, 2020 at 02:03:33PM -0800, Matthew Wilcox wrote:
> > On Thu, Jan 30, 2020 at 09:25:20PM -0800, Darrick J. Wong wrote:
> > > It turns out that this system doesn't scale very well either.  Even with
> > > three maintainers sharing access to the git trees,,,
> >
> > I think the LSFMMBPF conference is part of the problem.  With the best of
> > intentions, we have set up a system which serves to keep all but the most
> > dedicated from having a voice at the premier conference for filesystems,
> > memory management, storage (and now networking).  It wasn't intended to
> > be that way, but that's what has happened, and it isn't serving us well
> > as a result.
> >
> > ...
> >
> > This kills me because LSFMM has been such a critically important part of
> > Linux development for over a decade, but I think at this point it is at
> > least not serving us the way we want it to, and may even be doing more
> > harm than good.  I think it needs to change, and more people need to
> > be welcomed to the conference.  Maybe it needs to not be invite-only.
> > Maybe it can stay invite-only, but be twice as large.  Maybe everybody
> > who's coming needs to front $100 to put towards the costs of a larger
> > meeting space with more rooms.
> 
> One of the things that I've trying to suggest for at least the last
> year or two is that we need colocate LSF/MM with a larger conference.
> In my mind, what would be great would be something sort of like
> Plumbers, but in the first half of year.  The general idea would be to
> have two major systems-level conferences about six months apart.
> 
> The LSF/MM conference could still be invite only, much like we have
> had the Maintainer's Summit and the Networking Summit colocated with
> Plumbers in Lisbon in 2019 and Vancouver in 2018.  But it would be
> colocated with other topic specific workshops / summits, and there
> would be space for topics like what you described below:
> 
> > There are 11 people on that list, plus Jason, plus three more than I
> > recommended.  That's 15, just for that one topic.  I think maybe half
> > of those people will get an invite anyway, but adding on an extra 5-10
> > people for (what I think is) a critically important topic at the very
> > nexus of storage, filesystems, memory management, networking and graphics
> > is almost certainly out of bounds for the scale of the current conference.
> 
> After all, this is *precisely* the scaling problem that we had with
> the Kernel Summit.  The LSF/MM summit can really only deal with
> subjects that require high-level coordination between maintainers.
> For more focused topics, we will need a wider set of developers than
> can fit in size constraints of the LSF/MM venue.

<nod>

> This also addresses Darrick's problem, in that most of us can probably
> point to more junior engineers that we would like to help to develop,
> which means they need to meet other Storage, File System, and MM
> developers --- both more senior ones, and other colleagues in the
> community.  Right now, we don't have a venue for this except for
> Plumbers, and it's suffering from bursting at the seams.  If we can
> encourage grow our more junior developers, it will help us delegate
> our work to a larger group of talent.  In other words, it will help us
> scale.

Agreed.  The other downside of Plumbers is that there often isn't a
storage/fs track associated with it, which in the past has made getting
funding for my own participation very difficult.  If I have to choose
between LSFMM and Plumbers, LSF probably wins.

> There are some tradeoffs to doing this; if we are going to combine
> LSF/MM with other workshops and summits into a larger "systems-level"
> conference in the first half of the year, we're not going to be able
> to fit in some of the smaller, "fun" cities, such as Palm Springs, San
> Juan, Park City, etc.
> 
> One of the things that I had suggested for 2020 was to colocate
> LSF/MM/BPF, the Kernel Summit, Maintainer's Summit, and perhaps Linux
> Security Symposium to June, in Austin.  (Why Austin?  Because finding
> kernel hackers who are interested in planning a conference in a hands
> on fashion ala Plumbers is *hard*.  And if we're going to leverage the
> LF Events Staff on short notice, holding something in the same city as
> OSS was the only real option.)  I thought it made a lot of sense last
> year, but a lot of people *hated* Austin, and they didn't want to be
> anywhere near the Product Manager "fluff" talks that unfortunately,
> are in large supply at OSS.   So that idea fell through.
> 
> In any case, this is a problem that has been recently discussed at the
> TAB, but this is not an issue where we can force anybody to do
> anything.  We need to get the stakeholders who plan all of these
> conferences to get together, and figure out something for 2021 or
> maybe 2022 that we can all live with.  It's going to require some
> compromising on all sides, and we all will have different things that
> we consider "must haves" versus "would be nice" as far as conference
> venues are concerned, and as well as dealing with financial
> constraints.
> 
> Assuming I get an invite to LSF/MM (I guess they haven't gone out
> yet?), I'd like to have a chance to chat with anyone who has strong
> opinions on this issue in Palm Springs.  Maybe we could schedule a BOF
> slot to hear from the folks who attend LSF/MM/BPF and learn what
> things we all consider important vis-a-vis the technical conferences
> that we attend?

It seems like Future of LSF Planning has enough interest for its own
BOF, yes.  I'd attend that. :)

--D

> Cheers,
> 
> 							- Ted
