Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820B5418D86
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 03:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbhI0Bmt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Sep 2021 21:42:49 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:20616 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbhI0Bmt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Sep 2021 21:42:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632706872; x=1664242872;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xJ0TLHwb9tSGKFai8gOTtlCcwirLmQjZkSZn+OmDpkI=;
  b=j0BYjf5Ulk8E3mvqPz2nJjLb44kDMpdtH9VujN1fjll4P4q9x70Wq4QV
   f9BO34L024UP7lDPGaWE4f9Ah934jarjAGe+ifimAOIRNXfVvfsRzUhuw
   zWOZDM3q0mdivrU63+PY2N16j12jimppqEhpNJXVwUkfLEBJ1cyNdsXa+
   KFEeKCslN0PV8jrxcyRTDjykfNf+lSZW17vBwLiXtdf9BRr0ZT2zOty+v
   2bAM4oQpLrSUthxt21OnenU5xWRhYvffVDKkiQXO9Rr/z4J/WD37B49Nt
   xPdNE00ALDlvVpW9jI5oGGnx0k3d+z5MWmr2wL3ac92dvwqGeg5bMT0bk
   g==;
X-IronPort-AV: E=Sophos;i="5.85,325,1624291200"; 
   d="scan'208";a="180083656"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2021 09:41:10 +0800
IronPort-SDR: EyuA7iUshtC7TEzxzD2sMIk6V9R5POZ5rks6TE/iozsTt5frJCTRZFlQsqEVAOPi0lEH2w/Zyd
 2TzjLNGqR1HM18jD2/WhIDzOMNPRwMpTU84GSXb4gH6kqfKWM6SLHTcOMIlYr+5I8vMym6xMdb
 MqbI12hVIvzVrvLIC6v6SgYmV43gUUD8uO4O5vUa5qtpoicL94VF1h0veMGw809JX846VMumGM
 VMAaN89kP0l82KYX9HBUztN9Wk3srBEWj6zlZaPaTMuTCZFz7A/uxm0qDug6gUbiytETBJDano
 dxgb05MRYD8SlkEGLlLQCGCb
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2021 18:15:44 -0700
IronPort-SDR: aXuKvZmJLKdqw1TKkLOsglTMIQvGDVCCAb6Za0lMfhlf4hSIbgdUEFcC77s0REmDWbAXI7R+cL
 Cq7Nupz0qLjIQ+iHS8Qle33Xs8rTOpD8mzF8peAnuVGniPyv1kc8bfH2KHBebpeKGRui2tal8Y
 uQsc+47qTjBIVFOS+esk5LG0wFPrR9ahjuItsPYD0E70spy55EXnVL1m45d6X7+o901OEB7S3/
 /SZffD/APoC+2dFdhIzCYnaQhFRinHytDyaYpdh21rOhUyQQl1XXyrtbtYXop0C5vNxS3yJgxa
 Hag=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2021 18:41:11 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HHlj20Yyxz1SHw0
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Sep 2021 18:41:09 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1632706868; x=1635298869; bh=xJ0TLHwb9tSGKFai8gOTtlCcwirLmQjZkSZ
        n+OmDpkI=; b=npb96tVOh2amL4wcWfcn8zEsxjLX1X7F3RZ7pcp3TvJdX5eKIWy
        ENOdmUNDhyk8NhAPkrtcKIlgvbI7+ti2G3ZKmiE7mTgK7ExDNoEyKPWmx4pnelEy
        EGdB1++rDYiSdenFumsBFr081L2FoQ2NG9yyhHtjHr2GPx89Hx+VrmVslRSK4MWg
        XgTtuRJ6jAFtNY45IJE0xPzy6CRA6vX9N18kY2PKYxIqg+9Y4k2F+sIw1VgODh45
        eQ7/dOSe98QZh96mYcoWjWixxq1BCNv9RBj/WixHeth67mi1cB+HcikkY/TA6CJJ
        hEsrG2D910B8cSZrdsVOdajhSMhGN1i7hiQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vXjxhdMxIGl4 for <linux-fsdevel@vger.kernel.org>;
        Sun, 26 Sep 2021 18:41:08 -0700 (PDT)
Received: from [10.89.85.1] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.85.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HHlhy0bYrz1RvTg;
        Sun, 26 Sep 2021 18:41:05 -0700 (PDT)
Message-ID: <2f933d26-541c-06eb-e5d3-336c05f31f1d@opensource.wdc.com>
Date:   Mon, 27 Sep 2021 10:41:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.1
Subject: Re: [PATCH v3 9/9] mm: Remove swap BIO paths and only use DIO paths
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>, hch@lst.de,
        trond.myklebust@primarydata.com, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, darrick.wong@oracle.com,
        viro@zeniv.linux.org.uk, jlayton@kernel.org,
        torvalds@linux-foundation.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <YU84rYOyyXDP3wjp@casper.infradead.org>
 <163250387273.2330363.13240781819520072222.stgit@warthog.procyon.org.uk>
 <163250396319.2330363.10564506508011638258.stgit@warthog.procyon.org.uk>
 <2396106.1632584202@warthog.procyon.org.uk>
 <YU9X2o74+aZP4iWV@casper.infradead.org>
 <5fde9167-6f8b-c698-f34d-d7fafd4219f7@opensource.wdc.com>
 <20210927012527.GF1756565@dread.disaster.area>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20210927012527.GF1756565@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/09/27 10:25, Dave Chinner wrote:
> On Mon, Sep 27, 2021 at 08:08:53AM +0900, Damien Le Moal wrote:
>> On 2021/09/26 2:09, Matthew Wilcox wrote:
>>> On Sat, Sep 25, 2021 at 04:36:42PM +0100, David Howells wrote:
>>>> Matthew Wilcox <willy@infradead.org> wrote:
>>>>
>>>>> On Fri, Sep 24, 2021 at 06:19:23PM +0100, David Howells wrote:
>>>>>> Delete the BIO-generating swap read/write paths and always use ->swap_rw().
>>>>>> This puts the mapping layer in the filesystem.
>>>>>
>>>>> Is SWP_FS_OPS now unused after this patch?
>>>>
>>>> Ummm.  Interesting question - it's only used in swap_set_page_dirty():
>>>>
>>>> int swap_set_page_dirty(struct page *page)
>>>> {
>>>> 	struct swap_info_struct *sis = page_swap_info(page);
>>>>
>>>> 	if (data_race(sis->flags & SWP_FS_OPS)) {
>>>> 		struct address_space *mapping = sis->swap_file->f_mapping;
>>>>
>>>> 		VM_BUG_ON_PAGE(!PageSwapCache(page), page);
>>>> 		return mapping->a_ops->set_page_dirty(page);
>>>> 	} else {
>>>> 		return __set_page_dirty_no_writeback(page);
>>>> 	}
>>>> }
>>>
>>> I suspect that's no longer necessary.  NFS was the only filesystem
>>> using SWP_FS_OPS and ...
>>>
>>> fs/nfs/file.c:  .set_page_dirty = __set_page_dirty_nobuffers,
>>>
>>> so it's not like NFS does anything special to reserve memory to write
>>> back swap pages.
>>>
>>>>> Also, do we still need ->swap_activate and ->swap_deactivate?
>>>>
>>>> f2fs does quite a lot of work in its ->swap_activate(), as does btrfs.  I'm
>>>> not sure how necessary it is.  cifs looks like it intends to use it, but it's
>>>> not fully implemented yet.  zonefs and nfs do some checking, including hole
>>>> checking in nfs's case.  nfs also does some setting up for the sunrpc
>>>> transport.
>>>>
>>>> btrfs, cifs, f2fs and nfs all supply ->swap_deactivate() to undo the effects
>>>> of the activation.
>>>
>>> Right ... so my question really is, now that we're doing I/O through
>>> aops->direct_IO (or ->swap_rw), do those magic things need to be done?
>>> After all, open(O_DIRECT) doesn't do these same magic things.  They're
>>> really there to allow the direct-to-BIO path to work, and you're removing
>>> that here.
>>
>> For zonefs, ->swap_activate() checks that the user is not trying to use a
>> sequential write only file for swap. Swap cannot work on these files as there
>> are no guarantees that the writes will be sequential.
> 
> iomap_swapfile_activate() is used by ext4, XFS and zonefs. It checks
> there are no holes in the file, no shared extents, no inline
> extents, the swap info block device matches the block device the
> extent is mapped to (i.e. filesystems can have more than one bdev,
> swapfile only supports files on sb->s_bdev), etc.

OK. But I was referring to the additional check in zonefs_swap_activate() before
iomap_swapfile_activate() is called. We must prevent that function from being
called for a full sequential write only zone file since such file will pass all
checks (no hole, all extents written etc) but cannot be used for swap since it
is not writtable when full (no overwrites allowed in sequential zones).

> 
> Also, I noticed, iomap_swapfile_add_extent() filters out extents
> that are smaller than PAGE_SIZE, and aligns larger extents to
> PAGE_SIZE. This allows ensures that when fs block size != PAGE_SIZE
> that only a single IO per page being swapped is required. i.e. the
> DIO path may change the "one page, one bio, one IO" behaviour that
> the current swapfile mapping guarantees.
> 
> Cheers,
> 
> Dave.
> 


-- 
Damien Le Moal
Western Digital Research
