Return-Path: <linux-fsdevel+bounces-973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 241E77D476D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 08:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F01F281817
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 06:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3856111BF;
	Tue, 24 Oct 2023 06:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LVyU92IX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F134D79F4
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 06:26:22 +0000 (UTC)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506B3111
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 23:26:21 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a822f96aedso42097677b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 23:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698128780; x=1698733580; darn=vger.kernel.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MRLwLQJKqVoT8fAKMRJ96SHZ2jjS/GjWK4rsxxnvJlw=;
        b=LVyU92IXWcr6lzH7jV0dRJgAY+uYSTscjxqOU5Ycbqoh2H2u4cEwmgsf/IBaELuCXd
         /L38REceOHcKbggOb8wD13PXKDk40eJNZSgMMJR1VyyJOopU09xu76Tmnwi/cqsEBHPD
         BXWsskepUUimPHeGZHAu0T5OPJkoZoKZsxUSOrtu/4vLLM1d645c0fLuUzABJIVBnlaQ
         F2lZjHliuZjgH/+o4RiPHzvMJC+ulXfveXXZmklH5LB53BUx2IZAIfhA4QJzZkZGfChW
         Zs3AtBIUDKV2yS2fLWZOi9CrmhMy6xPT6h6XJl5lNP9LuhjeXjchppQNU9Ywmlep4KaH
         8dbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698128780; x=1698733580;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MRLwLQJKqVoT8fAKMRJ96SHZ2jjS/GjWK4rsxxnvJlw=;
        b=AxcAY3PNvakqJgAOcoh21n/7/F5MneK8BwS58TjPGhtWlKldm9TmcIUn8LbUYXAlWT
         x5JGMqk/TlhaOJNiza4jiGf6VgHaC6euaRQku5eKSKDYwwpRR7DgcoroqG/yPo4aIZEk
         OsqYgfQL4eVjGDInnpLlUi8LVi211sK7o66FYaQ11nq+kIhZy3KygXxnoGjiYvh3FtTj
         gkBPs3qvPur3g9CRXhZEfXUUDS1qEGeSQM5KRUdIaJZCJJVqYq7NE++2FhW3zEMj50+i
         QQ6R71lXdpx2zdCTqsPH6DHZprSbXtyKv6K/7R905nP6WYq7xvLGNkEXMQ8ehB2FU9TA
         vxWg==
X-Gm-Message-State: AOJu0YyTOK8p9/T7SSHS9VwUuJMLr30qlrZCHFqoX8oHwTJthNGxxtZL
	fx/+z8b4UHZzdX4iI1aVlbX7vw==
X-Google-Smtp-Source: AGHT+IHkd91huJN9SozlpT3bpFGAimQGDOyF8TB28iFOdp/ZJ3Ha6mPQMckl0DxRoAFPL47z13RAig==
X-Received: by 2002:a0d:cc44:0:b0:5a7:c49e:3f5c with SMTP id o65-20020a0dcc44000000b005a7c49e3f5cmr11383544ywd.21.1698128780387;
        Mon, 23 Oct 2023 23:26:20 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d7-20020a0df407000000b0057a8de72338sm3783004ywf.68.2023.10.23.23.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 23:26:19 -0700 (PDT)
Date: Mon, 23 Oct 2023 23:26:08 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To: Andrew Morton <akpm@linux-foundation.org>
cc: Matthew Wilcox <willy@infradead.org>, Hui Zhu <teawater@antgroup.com>, 
    Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>, 
    linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
    linux-mm@kvack.org
Subject: [PATCH] ext4: add __GFP_NOWARN to GFP_NOWAIT in readahead
Message-ID: <7bc6ad16-9a4d-dd90-202e-47d6cbb5a136@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Since mm-hotfixes-stable commit e509ad4d77e6 ("ext4: use bdev_getblk() to
avoid memory reclaim in readahead path") rightly replaced GFP_NOFAIL
allocations by GFP_NOWAIT allocations, I've occasionally been seeing
"page allocation failure: order:0" warnings under load: all with
ext4_sb_breadahead_unmovable() in the stack.  I don't think those
warnings are of any interest: suppress them with __GFP_NOWARN.

Fixes: e509ad4d77e6 ("ext4: use bdev_getblk() to avoid memory reclaim in readahead path")
Signed-off-by: Hugh Dickins <hughd@google.com>
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c00ec159dea5..56a08fc5c5d5 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -262,7 +262,7 @@ struct buffer_head *ext4_sb_bread_unmovable(struct super_block *sb,
 void ext4_sb_breadahead_unmovable(struct super_block *sb, sector_t block)
 {
 	struct buffer_head *bh = bdev_getblk(sb->s_bdev, block,
-			sb->s_blocksize, GFP_NOWAIT);
+			sb->s_blocksize, GFP_NOWAIT | __GFP_NOWARN);
 
 	if (likely(bh)) {
 		if (trylock_buffer(bh))
-- 
2.35.3


