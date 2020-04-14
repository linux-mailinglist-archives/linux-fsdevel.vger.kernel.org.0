Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB401A8D39
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 23:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633653AbgDNVFC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 17:05:02 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51622 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633645AbgDNVEv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 17:04:51 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03EL469C133804;
        Tue, 14 Apr 2020 21:04:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=7AGgMb1PjME7s9rPiVWSDRYMFiGgWwtSji2SOveCIpQ=;
 b=oHEweahbVZSQKWrSswPx90EP9moF7zB9bjp6JQQucufuN6b+Rety1PhjeHPPRquASDZL
 cmOUhclzlGH7t2NwbSXgDZGYrPnKsdHSBPBLMg8knLjukbfT01J4rET+KJx6VdvhmQDf
 iKY+MVjUWqE6AvT3Q99zjMPEvLPZXU3pJKdBahvzUmtu8hCdR1SB9MG+AuW4YeyBNDFl
 ksY08SpjHKti9NWYT9EJnO4KMkZc5+q+zTvbGLOdNjMIpJLGdcLTN7hwFYuGza58AFDx
 RFhrP5Jdl6jvrwdnxh7lNuZDQG0nt18/mIOHuwzKvXfZG9x1JqFljGKi8kebw3yyEtb/ fQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 30b5um7db5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 21:04:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03EKv9dO108124;
        Tue, 14 Apr 2020 21:02:38 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 30ctab5maj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 21:02:37 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03EL2XOc020543;
        Tue, 14 Apr 2020 21:02:34 GMT
Received: from localhost (/10.159.239.16)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Apr 2020 14:02:33 -0700
Date:   Tue, 14 Apr 2020 14:02:31 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH V7 9/9] Documentation/dax: Update Usage section
Message-ID: <20200414210231.GJ6742@magnolia>
References: <20200413054046.1560106-1-ira.weiny@intel.com>
 <20200413054046.1560106-10-ira.weiny@intel.com>
 <CAPcyv4g1gGWUuzVyOgOtkRTxzoSKOjVpAOmW-UDtmud9a3CUUA@mail.gmail.com>
 <20200414161509.GF6742@magnolia>
 <CAPcyv4hr+NKbpAU4UhKcmHfvDq1+GTM+y+K28XGbkDYBP=Kaag@mail.gmail.com>
 <20200414195754.GH6742@magnolia>
 <20200414200015.GF1853609@iweiny-DESK2.sc.intel.com>
 <20200414201808.GI6742@magnolia>
 <20200414205443.GC1982089@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414205443.GC1982089@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9591 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004140149
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9591 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 bulkscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004140150
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 14, 2020 at 01:54:44PM -0700, Ira Weiny wrote:
> On Tue, Apr 14, 2020 at 01:18:08PM -0700, Darrick J. Wong wrote:
> > On Tue, Apr 14, 2020 at 01:00:15PM -0700, Ira Weiny wrote:
> > > On Tue, Apr 14, 2020 at 12:57:54PM -0700, Darrick J. Wong wrote:
> > > > On Tue, Apr 14, 2020 at 12:04:57PM -0700, Dan Williams wrote:
> > > > > On Tue, Apr 14, 2020 at 9:15 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> > > 
> > > [snip]
> > > 
> > > > > > > > +
> > > > > > > > +Enabling DAX on xfs
> > > > > > > > +-------------------
> > > > > > > > +
> > > > > > > > +Summary
> > > > > > > > +-------
> > > > > > > > +
> > > > > > > > + 1. There exists an in-kernel access mode flag S_DAX that is set when
> > > > > > > > +    file accesses go directly to persistent memory, bypassing the page
> > > > > > > > +    cache.
> > > > > > >
> > > > > > > I had reserved some quibbling with this wording, but now that this is
> > > > > > > being proposed as documentation I'll let my quibbling fly. "dax" may
> > > > > > > imply, but does not require persistent memory nor does it necessarily
> > > > > > > "bypass page cache". For example on configurations that support dax,
> > > > > > > but turn off MAP_SYNC (like virtio-pmem), a software flush is
> > > > > > > required. Instead, if we're going to define "dax" here I'd prefer it
> > > > > > > be a #include of the man page definition that is careful (IIRC) to
> > > > > > > only talk about semantics and not backend implementation details. In
> > > > > > > other words, dax is to page-cache as direct-io is to page cache,
> > > > > > > effectively not there, but dig a bit deeper and you may find it.
> > > > > >
> > > > > > Uh, which manpage?  Are you talking about the MAP_SYNC documentation?
> > > > > 
> > > > > No, I was referring to the proposed wording for STATX_ATTR_DAX.
> > > > > There's no reason for this description to say anything divergent from
> > > > > that description.
> > > > 
> > > > Ahh, ok.  Something like this, then:
> > > > 
> > > >  1. There exists an in-kernel access mode flag S_DAX.  When set, the
> > > >     file is in the DAX (cpu direct access) state.  DAX state attempts to
> > > >     minimize software cache effects for both I/O and memory mappings of
> > > >     this file.  The S_DAX state is exposed to userspace via the
> > > >     STATX_ATTR_DAX statx flag.
> > > > 
> > > >     See the STATX_ATTR_DAX in the statx(2) manpage for more information.
> > > 
> > > We crossed in the ether!!!  I propose even less details here...  Leave all the
> > > details to the man page.
> > > 
> > > <quote>
> > > 1. There exists an in-kernel access mode flag S_DAX that is set when file
> > >     accesses is enabled for 'DAX'.  Applications must call statx to discover
> > >     the current S_DAX state (STATX_ATTR_DAX).  See the man page for statx for
> > >     more details.
> > > </quote>
> > 
> > Why stop cutting there? :)
> > 
> >  1. There exists an in-kernel file access mode flag S_DAX that
> >     corresponds to the statx flag STATX_ATTR_DIRECT_LOAD_STORE.  See the
> >     manpage for statx(2) for details about this access mode.
> 
> Sure!  But I'm holding to STATX_ATTR_DAX...  I don't like introducing another
> alias for this stuff.  Why have '-o dax=x' and then have some other term here?

Ok, STATX_ATTR_DAX then.

> Keep the name the same for consistency.
> 
> Searching for 'DAX Linux'[*] results in 'About 877,000 results' on Google.
> 
> While "'direct load store' Linux" results in 'About 2,630 results'.
> 
> I'll update the rest of the text though!  :-D
> 
> Ira
> 
> [*] Because 'DAX' is some company index and or a rapper...  <sigh>

Don't forget Jadzia and Ezri. ;)

--D
