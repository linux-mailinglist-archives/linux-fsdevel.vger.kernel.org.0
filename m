Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6283F4B9F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Aug 2021 15:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237333AbhHWNWT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Aug 2021 09:22:19 -0400
Received: from verein.lst.de ([213.95.11.211]:47946 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235813AbhHWNWS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Aug 2021 09:22:18 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 46C7967357; Mon, 23 Aug 2021 15:21:32 +0200 (CEST)
Date:   Mon, 23 Aug 2021 15:21:32 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>,
        Jane Chu <jane.chu@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@lst.de" <hch@lst.de>, "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>
Subject: Re: [PATCH RESEND v6 1/9] pagemap: Introduce ->memory_failure()
Message-ID: <20210823132132.GA17677@lst.de>
References: <20210730100158.3117319-1-ruansy.fnst@fujitsu.com> <20210730100158.3117319-2-ruansy.fnst@fujitsu.com> <1d286104-28f4-d442-efed-4344eb8fa5a1@oracle.com> <de19af2a-e9e6-0d43-8b14-c13b9ec38a9d@oracle.com> <beee643c-0fd9-b0f7-5330-0d64bde499d3@oracle.com> <78c22960-3f6d-8e5d-890a-72915236bedc@oracle.com> <OSBPR01MB2920AD0C7FD02E238D0C387AF4FF9@OSBPR01MB2920.jpnprd01.prod.outlook.com> <CAPcyv4gS=sYbC3gzMN0uQ5SAhDJ8CAC81tz7AtMueqLfuzGDOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gS=sYbC3gzMN0uQ5SAhDJ8CAC81tz7AtMueqLfuzGDOw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 18, 2021 at 10:10:51AM -0700, Dan Williams wrote:
> > Sounds like a nice solution.  I think I can add an is_notify_supported() interface in dax_holder_ops and check it when register dax_holder.
> 
> Shouldn't the fs avoid registering a memory failure handler if it is
> not prepared to take over? For example, shouldn't this case behave
> identically to ext4 that will not even register a callback?

Yes.
