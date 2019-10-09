Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4052CD1027
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 15:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731229AbfJIN3y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 09:29:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:48596 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731083AbfJIN3y (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 09:29:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5A22DAC6E;
        Wed,  9 Oct 2019 13:29:52 +0000 (UTC)
Date:   Wed, 9 Oct 2019 15:29:50 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, Alexey Dobriyan <adobriyan@gmail.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1] mm: Fix access of uninitialized memmaps in
 fs/proc/page.c
Message-ID: <20191009132950.GB6681@dhcp22.suse.cz>
References: <20191009091205.11753-1-david@redhat.com>
 <20191009093756.GV6681@dhcp22.suse.cz>
 <67aeaacc-d850-5c81-bd17-e95c7f7f75df@redhat.com>
 <20191009112424.GY6681@dhcp22.suse.cz>
 <a9659e39-3516-13c8-b9ab-d42bdaf4a488@redhat.com>
 <20191009132256.GZ6681@dhcp22.suse.cz>
 <8f0542f4-92c6-d450-7343-62bf9f08d5ed@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f0542f4-92c6-d450-7343-62bf9f08d5ed@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 09-10-19 15:24:05, David Hildenbrand wrote:
> On 09.10.19 15:22, Michal Hocko wrote:
> > On Wed 09-10-19 14:58:24, David Hildenbrand wrote:
> > [...]
> >> I would be fine with this, but it means that - for now - the three
> >> /proc/ files won't be able to deal with ZONE_DEVICE memory.
> > 
> > Thanks for the clarification. Is this an actual problem though? Do we
> > have any consumers of the functionality?
> > 
> 
> I don't know, that's why I was being careful in not changing its behavior.

Can we simply go with pfn_to_online_page. I would be quite surprised if
anybody was really examining zone device memory ranges as they are
static IIUC. If there is some usecase I am pretty sure we will learn
that and can address it accordingly.
-- 
Michal Hocko
SUSE Labs
