Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488BB2ACA8E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 02:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbgKJBiA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 20:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730042AbgKJBiA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 20:38:00 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663B3C0613CF;
        Mon,  9 Nov 2020 17:38:00 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id 7so3165599qtp.1;
        Mon, 09 Nov 2020 17:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wuf5qls7r8K2jneK0GG5xYx1Smw/3UiCzX+IOcpMh74=;
        b=jWbPvz4sU1Bh6jIeg+ksMoOFSommY9IoXLnJKWs1ts63jKGgGPtwHOR2oxgX6Qs5wJ
         qprc6ZXed7ihKTRLcW1ZwppwjTjVYLh3L0yJWiSWcQ5jCTswF3KXqx/6b/1QJKqjH0Qv
         CHJFupmHN2mqCa4V5oaS6U5pvM18YYpBr+XKoJxQzxLm/qxtiHYdw1yUnIaWSDxoPNYi
         gRDfScZ9OYFPiya7Oe1HQHVr5jj5Hb2/6UmyZvKWytVnH/NPJgsnpM4KUy4CDs/Q5oBP
         72SoG8ZqCFWsrs8RLD+LzuxC+TvMebA1lyEFgDqoO5v+1JiGRgCZ1XHM+6JjjDUOUU4/
         bcdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wuf5qls7r8K2jneK0GG5xYx1Smw/3UiCzX+IOcpMh74=;
        b=fSbNB4eAl1IrZ1l6SGdUaXogmv7yXxeoa7JemqA5HLL1HouuPZs+Qt6miRbzkJ9FJ3
         bT18CC6J+ITIDTZPBe0zRtqyvlIpo1gTe4tdgbsX0eNTq90jhSISravLK/MJKZ92fa+C
         sElNVDb4MBLFUDyZ//sDR73S7AUP+WWk3qqLm5LgEjKI7ActY3a3asN1yTdC4EH4GhXP
         N1h4psYjpV5uoTFlyogu60hwdyE/CaA3C5CihGirtw4fwtrmXN6cKK7reI6I///HOQb6
         PySPYDZrBnPViMqoNLyHJpzA2g3aXjmIF9J8RDqyvnsT43yXeBA3GpOVaa7lB50OR0oo
         iGwg==
X-Gm-Message-State: AOAM530XX0UbJcaQsHkPvFfUKfFxga0QCyXLQfgu6s1H9l99Zp2rCu1X
        dGKWQzkrZMhRp+DAhKKIMGz8PTjDXL0=
X-Google-Smtp-Source: ABdhPJxmbiNTmK5jwXjXpW6oVA75A3hcHP9A47ipAjsJh3UJp0SfNWLpX/yoT0hXWMupP19gAvW2tQ==
X-Received: by 2002:ac8:6f05:: with SMTP id g5mr5265849qtv.97.1604972279625;
        Mon, 09 Nov 2020 17:37:59 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id z1sm6923870qtz.46.2020.11.09.17.37.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2020 17:37:58 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id AA9C427C0054;
        Mon,  9 Nov 2020 20:37:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 09 Nov 2020 20:37:57 -0500
X-ME-Sender: <xms:9O6pXwTr5ZOQ97wt1Kuy6rXDgbaHrRPi4sxAIktxKild7GPNWqCWuw>
    <xme:9O6pX9zEsPFj9GM7b42ce0w1_IwLylBSAYWiwzb9mtEePeW_PbZrsdVufOm8L6zzS
    z7DDMzMsxp_bYLUCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudduiedgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepieeuveejleehudetfeevfeelgfejteefhedvkedukefggedugefhudfhteevjedu
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudefuddruddtjedrudegje
    druddvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtd
    eigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehf
    ihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:9O6pX93RUfN_PnYZgPmUrE6Jkj0LidCK60rUfR9piiWH-jP5wxDm3A>
    <xmx:9O6pX0BVAn9SOzOc6K3T_budxv7hySfAqO7BJwfhklSlK7fyHBL1gQ>
    <xmx:9O6pX5iQ2X9y_UP5sFyusvDE6Qxm9rsjAmOT1oFCrp6zaP8sJJYCaA>
    <xmx:9e6pX6XrPJt3r-_WifwLuidNxoRIGIzjxSji9V7unK0_DjRB-2X1mdORWUk>
Received: from localhost (unknown [131.107.147.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id ED3113063081;
        Mon,  9 Nov 2020 20:37:55 -0500 (EST)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Filipe Manana <fdmanana@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@kernel.org>
Subject: [RFC] fs: Avoid to use lockdep information if it's turned off
Date:   Tue, 10 Nov 2020 09:37:37 +0800
Message-Id: <20201110013739.686731-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Filipe Manana reported a warning followed by task hanging after attempts
to freeze a filesystem[1]. The problem happened in a LOCKDEP=y kernel,
and percpu_rwsem_is_held() provided incorrect results when
debug_locks == 0. Although the behavior is caused by commit 4d004099a668
("lockdep: Fix lockdep recursion"): after that lock_is_held() and its
friends always return true if debug_locks == 0. However, one could argue
that querying the lock holding information regardless if the lockdep
turn-off status is inappropriate in the first place. Therefore instead
of reverting lock_is_held() and its friends to the previous semantics,
add the explicit checking in fs code to avoid use the lock holding
information if lockdpe is turned off. And since the original problem
also happened with a silent lockdep turn-off, put a warning if
debug_locks is 0, which will help us spot the silent lockdep turn-offs.

[1]: https://lore.kernel.org/lkml/a5cf643b-842f-7a60-73c7-85d738a9276f@suse.com/

Reported-by: Filipe Manana <fdmanana@gmail.com>
Fixes: 4d004099a668 ("lockdep: Fix lockdep recursion")
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jan Kara <jack@suse.cz>
Cc: David Sterba <dsterba@suse.com>
Cc: Nikolay Borisov <nborisov@suse.com>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
---
Hi Filipe,

I use the slightly different approach to fix this problem, and I think
it should have the similar effect with my previous fix[2], except that
you will hit a warning if the problem happens now. The warning is added
on purpose because I don't want to miss a silent lockdep turn-off.

Could you and other fs folks give this a try?

Regards,
Boqun

[2]: https://lore.kernel.org/lkml/20201103140828.GA2713762@boqun-archlinux/

 fs/super.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index a51c2083cd6b..1803c8d999e9 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1659,12 +1659,23 @@ int __sb_start_write(struct super_block *sb, int level, bool wait)
 	 * twice in some cases, which is OK only because we already hold a
 	 * freeze protection also on higher level. Due to these cases we have
 	 * to use wait == F (trylock mode) which must not fail.
+	 *
+	 * Note: lockdep can only prove correct information if debug_locks != 0
 	 */
 	if (wait) {
 		int i;
 
 		for (i = 0; i < level - 1; i++)
 			if (percpu_rwsem_is_held(sb->s_writers.rw_sem + i)) {
+				/*
+				 * XXX: the WARN_ON_ONCE() here is to help
+				 * track down silent lockdep turn-off, i.e.
+				 * this warning is triggered, but no lockdep
+				 * splat is reported.
+				 */
+				if (WARN_ON_ONCE(!debug_locks))
+					break;
+
 				force_trylock = true;
 				break;
 			}
-- 
2.29.2

