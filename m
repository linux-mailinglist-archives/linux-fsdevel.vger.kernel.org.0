Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663717866EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 06:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239383AbjHXEy0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 00:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239356AbjHXEyT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 00:54:19 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A4010F0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 21:54:18 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-116-73.bstnma.fios.verizon.net [173.48.116.73])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37O4rkR7029647
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 00:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692852829; bh=pHPRRzSzE3sZBcGjtYm3DoD6XWgrcwZFg8tbTibGqK8=;
        h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=bWxz029vUw79AEwNec1FFEciZHOHekAcoXNqhnfX1YANLOlhZi4y31mwcHoNQkgNw
         OUniUvoL2csY6ldMqeGk/p3hmpTT9xGYWisdPfCbF2meNOkBw1Z1r0XMij7/Cw9Rz5
         dy9ChIQllg59CphataMoXGDNvelsl+KHxLIxNEC0sAZEhzUQ3HKv5tz8yenp+B9ff9
         9kEpvnnSXpr6OkKGSj0v5gqPitrC33V4sWNj1PuwE8tVaTHzMbyne4rDJRfSS9o5nF
         7EeM4A7I2O4Oxl6Ws2xIpmvSMX5JTRGsv2eYXITv0Y2rjXVAZv15qP4igd2y7mXlWH
         X/vnSD7QpXxow==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 5C51015C027F; Thu, 24 Aug 2023 00:53:46 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@suse.de>
Subject: Re: [PATCH 0/3] Simplify rejection of unexpected casefold inode flag
Date:   Thu, 24 Aug 2023 00:53:40 -0400
Message-Id: <169285281340.4146427.15192425840892165678.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230814182903.37267-1-ebiggers@kernel.org>
References: <20230814182903.37267-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On Mon, 14 Aug 2023 11:29:00 -0700, Eric Biggers wrote:
> This series makes unexpected casefold flags on inodes be consistently
> rejected early on so that additional validation isn't needed later on
> during random filesystem operations.  For additional context, refer to
> the discussion on patch 1 of
> https://lore.kernel.org/linux-fsdevel/20230812004146.30980-1-krisman@suse.de/T/#u
> 
> Applies to v6.5-rc6
> 
> [...]

Applied, thanks!

[1/3] ext4: reject casefold inode flag without casefold feature
      commit: 3d0f06b5a4e6d09b4a27d701f2ec9a7de8dadbe5
[2/3] ext4: remove redundant checks of s_encoding
      commit: fe9ef4ceae694597fe7318aafd7357cc5b85724e
[3/3] libfs: remove redundant checks of s_encoding
      commit: 6d7772c4427aaa21251c629d4fabb17e5c10a463

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
