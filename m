Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440315184A3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 14:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235614AbiECNAr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 09:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbiECNAq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 09:00:46 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E15326D0
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 May 2022 05:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651582633; x=1683118633;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/vh6/MdxLPAFqya3jNysuKAAPDnctjfI7bKL6Lpwimc=;
  b=PR5ENVTD+ItPt6SKfuDmffMwezwTN+DwQAwEOJYYQ3V9p6EM6a+xJNCl
   ch2WfcOCgQQNyfkRa4yraVkcnUUE7aADrawlOC8obBMgNFfl4my96zNwS
   Uti2PSwd6LxFjXP0v94mW63t2Xpzfzh8ePzhEB2vvDXBty7O+8dLHo9zR
   5CKbdcZ/Qj9GI7ql4CFEMvMVbypB8/x/TYxZlos74mXMbf30aLhrTRF/j
   zP674+haLWFhxd/cwh9Sg/a8zTEwaU+60NIe9uE5RHvMshSOa9jWUaKNC
   2cNYSzNzGPxtSU+U4u/ZCbPkdBBtvrdcfoBVDpw71VLoo6h5Qd854i0jp
   A==;
X-IronPort-AV: E=Sophos;i="5.91,195,1647273600"; 
   d="scan'208";a="311393400"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 May 2022 20:57:13 +0800
IronPort-SDR: qfAbA4G5O9RFlWfPp/RNm+XVE//KNPXuDEe0+SgEXe80OEJEu6tvVNkgneCuAMsI9eY+1uckPF
 s2FzphWj/hb4m4ftmZUZXnWbuD5A9CK/c7T0dNX3F59dD8CxEYof9xqhG0Lp9HNTrEqkEr/g2N
 Dat8ARxMjMuMtPRM2OU5lvMsGahqSmObz8fz3do7oXbT+Tk3aNCcDIdwke8PFQTVEaml7ZtHx8
 GQoS3oJBT+TwiJFmShusC4GHw4H4FoWuoe6qXaT1fEnkmYs4xWLBdU5yEuXMky0lpTjigHwFyk
 1Ik/2WuOWS/IpfSHLcaTUUgo
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 May 2022 05:27:57 -0700
IronPort-SDR: BrBz/wAaS4Ta5YpLC1cYACMmeV9t7WG5a289F/JVWVXxZPMLloLcIhIXUiL+BRZCbB0lsAYCp9
 7SD45M62HfBP0dYXdrVXkv82oNsASFa2Q0vMIzTyl3XzBzYoIPsLJuHfVWCLbX7bG3TZOSlvPm
 fIUAQQnEFvWXOkI+it22Rrs8hqq+kfy62udVNitQUvgLaAWzop9GMO5QA5HkTi5gTRYjJynbWW
 +7WKh6SkNQ/Fpr9v6SADbdcyfh9s5sa+rwkNRRAQqOjbpHkWEhdb4HVkAeVFSBexPlt91MC+mY
 mD0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 May 2022 05:57:13 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kt0NS5tRBz1Rvlx
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 May 2022 05:57:12 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1651582632; x=1654174633; bh=/vh6/MdxLPAFqya3jNysuKAAPDnctjfI7bK
        L6Lpwimc=; b=hQl0K5mYZCHVFPZNZNpl3XrJqk99uG9YcsOfVzT3xkSZyRldc/6
        3u+rc6Vp3atpUGddIbrrMfwig+eSSKnwRYPMjCMWc408WmUYtvAwymsG+vOu/np0
        ySDWd6lfyzB7Es/Wk020JKGfLL7ocQIrU00iMTWjb+RmxSFda4n+nulZOMDqDJrg
        2WnDFHQ7dqs3TisIIPukt/uwQEbmBvtBCxj8y2gJKILDcncoVAFPmyxg63vRBpM7
        5ywSHOERb+zf73zNKA0BSZErrxvBpquEczjNvN76Flf+FI775tidO1DHGWT/C6Nt
        pwiv1JHauZTakVA1f/2DM/M+7pnlxCXtlmA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9pBpD0iKixAS for <linux-fsdevel@vger.kernel.org>;
        Tue,  3 May 2022 05:57:12 -0700 (PDT)
Received: from [10.225.81.200] (hq6rw33.ad.shared [10.225.81.200])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kt0NR5Zryz1Rvlc;
        Tue,  3 May 2022 05:57:11 -0700 (PDT)
Message-ID: <f43fdbda-ba95-8864-3fd5-e9251e0de7a6@opensource.wdc.com>
Date:   Tue, 3 May 2022 21:57:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [RFC PATCH 00/10] Make O_SYNC writethrough
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>
References: <20220503064008.3682332-1-willy@infradead.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220503064008.3682332-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/05/03 15:39, Matthew Wilcox (Oracle) wrote:
> This is very much in development and basically untested, but Damian

s/Damian/Damien :)

Thank you for posting this. I am definitely going to play with this with zonefs.

The goal is to allow replacing the mandatory O_DIRECT writing of sequential zone
files with sector aligned O_SYNC writes which "preload" the page cache for
subsequent buffered reads, thus reducing device accesses. That will also avoid
an annoying overhead with zonefs which is that applications need 2 file
descriptors per zone file: one without O_DIRECT for buffered reads and another
O_DIRECT one for writes.

In the case of zonefs, since all sequential files are always fully mapped,
allocated, cannot be used for mmap writing *and* a write is never an overwrite,
these conditions:

+	if (folio_test_dirty(folio))
+		return true;

+	/* Can't allocate blocks here because we don't have ->prepare_ioend */
+	if (iomap->type != IOMAP_MAPPED || iomap->type != IOMAP_UNWRITTEN ||
+	    iomap->flags & IOMAP_F_SHARED)
+		return false;

never trigger and the writethrough is always started with
folio_start_writeback(), essentially becoming a "direct" write from the issuer
context (under the inode lock) on the entire folio. And that should guarantee
that writes stay sequential as they must.

> started describing to me something that he wanted, and I told him he
> was asking for the wrong thing, and I already had this patch series
> in progress.  If someone wants to pick it up and make it mergable,
> that'd be grand.
> 
> The idea is that an O_SYNC write is always going to want to write, and
> we know that at the time we're storing into the page cache.  So for an
> otherwise clean folio, we can skip the part where we dirty the folio,
> find the dirty folios and wait for their writeback.  We can just mark the
> folio as writeback-in-progress and start the IO there and then (where we
> know exactly which blocks need to be written, so possibly a smaller I/O
> than writing the entire page).  The existing "find dirty pages, start
> I/O and wait on them" code will end up waiting on this pre-started I/O
> to complete, even though it didn't start any of its own I/O.
> 
> The important part is patch 9.  Everything before it is boring prep work.
> I'm in two minds about whether to keep the 'write_through' bool, or
> remove it.  So feel to read patches 9+10 squashed together, or as if
> patch 10 doesn't exist.  Whichever feels better.
> 
> The biggest problem with all this is that iomap doesn't have the necessary
> information to cause extent allocation, so if you do an O_SYNC write
> to an extent which is HOLE or DELALLOC, we can't do this optimisation.
> Maybe that doesn't really matter for interesting applications.  I suspect
> it doesn't matter for ZoneFS.
> 
> Matthew Wilcox (Oracle) (10):
>   iomap: Pass struct iomap to iomap_alloc_ioend()
>   iomap: Remove iomap_writepage_ctx from iomap_can_add_to_ioend()
>   iomap: Do not pass iomap_writepage_ctx to iomap_add_to_ioend()
>   iomap: Accept a NULL iomap_writepage_ctx in iomap_submit_ioend()
>   iomap: Allow a NULL writeback_control argument to iomap_alloc_ioend()
>   iomap: Pass a length to iomap_add_to_ioend()
>   iomap: Reorder functions
>   iomap: Reorder functions
>   iomap: Add writethrough for O_SYNC
>   remove write_through bool
> 
>  fs/iomap/buffered-io.c | 492 +++++++++++++++++++++++------------------
>  1 file changed, 273 insertions(+), 219 deletions(-)
> 


-- 
Damien Le Moal
Western Digital Research
