Return-Path: <linux-fsdevel+bounces-11839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0838579E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 11:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23CED286E34
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 10:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB5A1C69D;
	Fri, 16 Feb 2024 10:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="u7RYAcMw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA021BF3F;
	Fri, 16 Feb 2024 10:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077997; cv=none; b=SfGO3BeLNUDq7Qv0gVuVAqvinC9c+eu9KJM/XTv3lsK1//uDRRSPaNAvTJ1qWlD00zt0b4POJLZ68HyQUNz04yj/1nta4kA48HoW4qVuEEuuKHjEeLJLF8EkoIBbrrZUv6ltBdc0zIC+nLm7WGpnInac0A3zb3aKq5pn7zMXCkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077997; c=relaxed/simple;
	bh=qalaB5YcsuNePVX7yX2RMrC8XWaEwwf8H40aPA0BNDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvbLhRL55r0rI2uAPoaa8DEvocoOnFg75iy83z2iUD9lsMmPYYo0FT2FLnoZe+3m3DcV7qUSaFpxDh/syqehqeh+9cuDVc9GzBUtcWddkw1VW3RurSEYLreMpkWd2ys9M5fSNBJ/7aOXS+VGNDP7UoRxItWCNmhJHNaBCp2ltE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=u7RYAcMw; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4TbndZ0N6tz9snk;
	Fri, 16 Feb 2024 11:06:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1708077986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qQCyd4+RAcgA/+yjcYQaov3P2x0z6l0myi/TdMlnugk=;
	b=u7RYAcMwMqlhw5zr5alamnS4sLimwlabotnFFKAHV8A+2O03mKdQq4oIOC3ETVYPrh86Vn
	2hA0XKH/bp0takB2EwV1l1+5w3scKiB6LQHdSRMpvgo2xrtBUcprCKYYEGyELVqFJ/Gkmi
	pAhNUBVorXF18ltMbFmUEYHkVMPYLSHEuIFICGYm9udRgqjmDUSZ0pKxzXPONsny67XcMh
	TfMI3GWVSMS60ODyuS/mrdbD6I17s1VJFcuApk0fSpB4IK+VwczFuY/PzjOMcP/Ih+AnMp
	HAnj71mnz4vp5IxANH6iKU+ItyJydsjxkMLT0exQ+fPHouHPDmslbm6uWjDmpQ==
Date: Fri, 16 Feb 2024 11:06:20 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	David Hildenbrand <david@redhat.com>, Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Zach O'Keefe <zokeefe@google.com>, Hugh Dickins <hughd@google.com>, 
	Mcgrof Chamberlain <mcgrof@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [PATCH v4 0/7] Split a folio to any lower order folios
Message-ID: <dvamjmlss62p5pf4das7nu5q35ftf4jlk3viwzyyvzasv4qjns@h3omqs7ecstd>
References: <20240213215520.1048625-1-zi.yan@sent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213215520.1048625-1-zi.yan@sent.com>
X-Rspamd-Queue-Id: 4TbndZ0N6tz9snk

Hi Zi Yan,

On Tue, Feb 13, 2024 at 04:55:13PM -0500, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> Hi all,
> 
> File folio supports any order and multi-size THP is upstreamed[1], so both
> file and anonymous folios can be >0 order. Currently, split_huge_page()
> only splits a huge page to order-0 pages, but splitting to orders higher than
> 0 is going to better utilize large folios. In addition, Large Block
> Sizes in XFS support would benefit from it[2]. This patchset adds support for
> splitting a large folio to any lower order folios and uses it during file
> folio truncate operations.

I added your patches on top of my patches, but removed patch 6 and I
added this instead:

diff --git a/mm/truncate.c b/mm/truncate.c
index 725b150e47ac..dd07e2e327a8 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -239,7 +239,8 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
                folio_invalidate(folio, offset, length);
        if (!folio_test_large(folio))
                return true;
-       if (split_folio(folio) == 0)
+       if (split_folio_to_order(folio,
+                                mapping_min_folio_order(folio->mapping)) == 0)
                return true;
        if (folio_test_dirty(folio))
                return false;

I ran genric/476 fstest[1] with SOAK_DURATION set to 360 seconds. This
test uses fstress to do a lot of writes, truncate operations, etc. I ran
this on XFS with **64k block size on a 4k page size system**.

I recorded the vm event for split page and this was the result I got:

Before your patches:
root@debian:~/xfstests# cat /proc/vmstat  | grep split
thp_split_page 0
thp_split_page_failed 5819

After your patches:
root@debian:~/xfstests# cat /proc/vmstat  | grep split
thp_split_page 5846
thp_split_page_failed 20

Your patch series definitely helps with splitting the folios while still
maintaining the min_folio_order that LBS requires.

We are still discussing how to quantify this benefit in terms of some
metric with this support. If you have some ideas here, let me know.

I will run the whole xfstests tonight to check for any regressions.

--
Pankaj

[1] https://github.com/kdave/xfstests/blob/master/tests/generic/476

