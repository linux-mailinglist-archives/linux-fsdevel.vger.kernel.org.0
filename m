Return-Path: <linux-fsdevel+bounces-53882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FA3AF862D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 06:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E38B5658E4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 04:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403D827468;
	Fri,  4 Jul 2025 04:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="cMotMn5T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFB81876
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 04:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751602045; cv=none; b=qJRNF05/3ZOYkXvWeU73zM6o85y1t336tDQXCww+O6qArlObRlJmrlcJwBpnX97goN1RiBI8H1L8/GC9OCS4QCTJruqnGX0+mNHcqQ6usxuEPee2rA7GlbA9gACDlKVlPLL+QxY5CHvt/e13TYtVy14JF/K7BBsx+tWm5uzluHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751602045; c=relaxed/simple;
	bh=qA4gkGQ+w3qeBVyfUx3gPrpKZ7q1fqIaKdjJI/j7YHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/YuUwvCR8P/Ks2dGdLcPhJb5c+mmFAHx826yXMf4KdOoAWth7TDJkIBpUqz1LvvPzzuhFuCg4VsnDBTsuD99W8f3PhbJbnnaVe+92mIEInWdDsO8iRl1WS52r0Y/ohRMriy+Z9iRXIIiBxkyjmavE4y7Yr4dcCPen9ciO9Jh0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=cMotMn5T; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qMZTfLrtIhEeFtw0lenJoQD3j7hmoeNDJQRqb/truAY=; b=cMotMn5T9ALaGfL+D42Yq2Es9E
	d6MDh8KMduFvVKOelAEf+b9PJFVSRBzWmiPwUQUXe1LRFqBJ1z90ZFZ+kz90V+7TRRV2tEu88MSJ/
	5HR8QntXNNa2h5Ip7t/BeW07fgBD80y1L5OXPV82HXVBTH1YfnrKd1mTPPEqxn17v5SUIPZLpMUay
	OLHNYgb4pzZ+JnoXF2z8AIsj2Kwmwm0zBbZO4knJNhhQ8r9n3J9oWtDJqTdPDGMv6FJBP1ZfjNmzn
	/e4T7YyQeknN1hBKYLi3PyhxFXiM/qD8hD9SyHknQOV3c64wdyt7K7+MbLaQa7xD2vH13lfkkb7It
	C5FzTfLA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXXho-0000000913S-0tKf;
	Fri, 04 Jul 2025 04:07:20 +0000
Date: Fri, 4 Jul 2025 05:07:20 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Matthew Wilcox <willy@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 05/11] vmscan: don't bother with debugfs_real_fops()
Message-ID: <20250704040720.GP1880847@ZenIV>
References: <20250702211305.GE1880847@ZenIV>
 <20250702211408.GA3406663@ZenIV>
 <20250702211739.GE3406663@ZenIV>
 <aGZu3Z730FQtqxsE@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGZu3Z730FQtqxsE@casper.infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Jul 03, 2025 at 12:51:57PM +0100, Matthew Wilcox wrote:
> On Wed, Jul 02, 2025 at 10:17:39PM +0100, Al Viro wrote:
> > -	bool full = !debugfs_real_fops(m->file)->write;
> > +	bool full = debugfs_get_aux_num(m->file);
> 
> > +	debugfs_create_file_aux_num("lru_gen", 0644, NULL, NULL, 1,
> > +				    &lru_gen_rw_fops);
> > +	debugfs_create_file_aux_num("lru_gen_full", 0444, NULL, NULL, 0,
> > +				    &lru_gen_ro_fops);
> 
> Looks like you have the polarity inverted there?

Right you are.  My apologies...  Fixed, force-pushed into the same branch,
replacement commit below:

From 51d26db0fd00fbd501f9271550667bab6c5fb107 Mon Sep 17 00:00:00 2001
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Wed, 29 Jan 2025 14:43:44 -0500
Subject: [PATCH 05/11] vmscan: don't bother with debugfs_real_fops()

... not when it's used only to check which file is used;
debugfs_create_file_aux_num() allows to stash a number into
debugfs entry and debugfs_get_aux_num() extracts it.

Braino-spotted-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 mm/vmscan.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index f8dfd2864bbf..27c70848c0a0 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5420,7 +5420,7 @@ static void lru_gen_seq_show_full(struct seq_file *m, struct lruvec *lruvec,
 static int lru_gen_seq_show(struct seq_file *m, void *v)
 {
 	unsigned long seq;
-	bool full = !debugfs_real_fops(m->file)->write;
+	bool full = debugfs_get_aux_num(m->file);
 	struct lruvec *lruvec = v;
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 	int nid = lruvec_pgdat(lruvec)->node_id;
@@ -5756,8 +5756,10 @@ static int __init init_lru_gen(void)
 	if (sysfs_create_group(mm_kobj, &lru_gen_attr_group))
 		pr_err("lru_gen: failed to create sysfs group\n");
 
-	debugfs_create_file("lru_gen", 0644, NULL, NULL, &lru_gen_rw_fops);
-	debugfs_create_file("lru_gen_full", 0444, NULL, NULL, &lru_gen_ro_fops);
+	debugfs_create_file_aux_num("lru_gen", 0644, NULL, NULL, false,
+				    &lru_gen_rw_fops);
+	debugfs_create_file_aux_num("lru_gen_full", 0444, NULL, NULL, true,
+				    &lru_gen_ro_fops);
 
 	return 0;
 };
-- 
2.39.5


