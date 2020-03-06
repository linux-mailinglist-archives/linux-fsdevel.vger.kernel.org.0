Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D489B17C5EF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 20:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgCFTIN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 14:08:13 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:38352 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgCFTIN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 14:08:13 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 026J5EVV089969;
        Fri, 6 Mar 2020 19:07:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=7IxeGuzA35+xrdEU4Ai5zObBFjpvvFOyDrantokfJbM=;
 b=CzhGUG7VXYVaeeFYe9jbvpj2JAxdGUagmx3uBGsCUoEIEXa/hDJblYKNWneBboX28jLU
 wYRpLcV8zdS2/X0EavL4sYuLUlj94o9p7X2lI0yfQkteKiG/vIfzaeB4QyUTPrpVmeDg
 cZbEGo3SdU3AJ7Du8Y9r1wDbLN/6QI4ryQCi36hAcWUuUjQ/PDx8jsdOET6y++S2FsLL
 /afiumowox7zzydRJCpY17EtBjmBA7AnUj3xtqyHTmG4vlw1y0z6k281yxCoiaAdXQxY
 o/LKlU4DVTmDDkNowS01wzfbiB4nuJjrWoDO4KPbc+ZEJkwIMM6ax43LZTfUeCiUAQE6 +A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2yffwrd13n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Mar 2020 19:07:55 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 026J2g6Z116410;
        Fri, 6 Mar 2020 19:07:54 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2yg1pe0cd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Mar 2020 19:07:54 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 026J7op9026534;
        Fri, 6 Mar 2020 19:07:50 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 06 Mar 2020 11:07:50 -0800
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Matthew Wilcox <willy@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        lsf-pc <lsf-pc@lists.linuxfoundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>, bpf@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [LSFMMBPF TOPIC] Killing LSFMMBPF
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <b506a373-c127-b92e-9824-16e8267fc910@toxicpanda.com>
        <20200306160548.GB25710@bombadil.infradead.org>
        <1583516279.3653.71.camel@HansenPartnership.com>
        <20200306180618.GN31668@ziepe.ca>
Date:   Fri, 06 Mar 2020 14:07:47 -0500
In-Reply-To: <20200306180618.GN31668@ziepe.ca> (Jason Gunthorpe's message of
        "Fri, 6 Mar 2020 14:06:18 -0400")
Message-ID: <yq1eeu51ev0.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9552 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003060117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9552 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=2
 phishscore=0 clxscore=1011 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003060117
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Jason,

> Yes, I can confirm this from another smaller hotel-style conference
> I've been involved organizing on occasion. $600-$800 is required to
> break even without major sponsorship $$ for the ~100 people mark, and
> that is without the usual food and venue perks we see at
> plumbers/lsfmm.

Yep. Our actual per-person cost for LSF/MM/BPF is in excess of $1K. That
limits who we can invite. Personally I absolutely hate the invitation
aspect and process. But we are very constrained wrt. how many we can
actually accommodate by the amount of funding we get. Things appear to
be better this year, but sponsor mergers and acquisitions have been a
major concern the past few years.

The premise of LSF/MM/BPF is to provide a venue where the right people
can talk low-latency, face to face. Without the distractions of a 1000
person event setting. The reason LSF/MM/BPF has been free to attend has
been to ensure that attendance fees wouldn't be a deterrent for the
people who should be there. The downside is that the invitation process
has been a deterrent for other, likely valuable, contributors.

I would love for LSF/MM/BPF/BBQ to be an umbrella event like LPC where
we could have miniconfs with all the relevant contributors for each
topic area to be present. The addition of the 3rd day was done to
facilitate that so that XFS folks, btrfs folks, etc. could congregate in
a room to discuss things only they cared about. But the current
attendance headcount cap means that not all topics can be covered due to
crucial people missing.

Also, there are several areas where I do think that the present LSF/MM
format still has merit. First of all, not all topics are large enough to
justify an entire miniconf or topic-specific workshop. We have many
topics that can be covered in an hour or less and that's the end of
that. The other aspect is that key people straddle multiple filesystems,
subsystems, etc. If we *only* had XFS/btrfs/BPF miniconfs, scheduling
would be near impossible. Hence the current division between scheduled
days and workshop day. Also, we do have cross-track topics that need
involvement across the board. I would personally be happy with 1 track
day and 2 workshop days if we could get critical mass for the workshop
topics.

In the old days, when LSF tracks were 10-12 people each, I felt we got
stuff done. Since then we have more than doubled the headcount for each
track in an attempt to get more people involved. But I feel that the
discussions are much less useful. Despite enforcing the no-slides rules,
etc.

If we combine sponsor funding with per-attendee fees to facilitate a
larger event, the question becomes: What should the headcount limit be?
200? 500? The reason I ask is that I think funding can be worked
out. But I also think it is important enough that we don't exceed the
"productive group size" too much for a given topic. And we usually put
that somewhere between 10 and 15. It is very rare to see more than this
many attendees actively participate in a discussion. This means for an
attendee cap of 200, we should aim to have ~20 concurrent topics
happening for it to be productive. Maybe slash that number in half to
compensate for the people in the hallway tracks?

One thing a few of us discussed a year or two ago was to have actual
per-session headcount limits. And make people bid on the sessions they
wanted to participate in and then cap each session at 15. That would
obviously be very hard to schedule and enforce. But I still think we
need to think about how we can bring N hundred people together and make
sure they congregate in productive groups of 10-15. That's really the
key as far as I'm concerned. We have tried the pure unconference
approach and that wasn't very productive either. So we need to land
somewhere in the middle...

-- 
Martin K. Petersen	Oracle Linux Engineering
