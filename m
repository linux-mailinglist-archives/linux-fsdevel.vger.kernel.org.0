Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E350559BDD8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Aug 2022 12:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbiHVKvu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Aug 2022 06:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbiHVKvt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Aug 2022 06:51:49 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B773F2F659
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Aug 2022 03:51:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2C378CE10B7
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Aug 2022 10:51:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA922C433D6;
        Mon, 22 Aug 2022 10:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661165505;
        bh=yRJ3QwEwglPb0WOB7B+MxY3myU+aCICps2Fb/JE1tug=;
        h=Subject:From:To:Cc:Date:From;
        b=pvcKMjsMxpMWSgowaKB2TEYaQBE5lK386Voub30YO83eCqOpimRqEWBcrxWZ+vVZy
         WeKR4wYeRYiHqtcc1wfMw8iHdhfhRZ07rjANjfHlGKe8oZ9GgQFReLgeosqIUD8gEE
         s0WsQmRUlqJ5PdnDno4mEj/zc9x99BiGF7XzLpcc17wS1G+7EJSH+IbzH9qvrZsFi7
         2d1j7u5sLxiodupJJFlialUIX7O3Vczrd1KRUi6i2Fief87QpdROKWbd3GaTt+8DYo
         EcxzF2yNAjCvL1Cl9t9cuMCsIRr0aAb4SU2vEzEQmCuv/RRBZv7odxzg9HzlTBrLK1
         axEmYLfCTEG4Q==
Message-ID: <c700310868333ab8fc3f8a94f12f910590bc365c.camel@kernel.org>
Subject: [GIT PULL] fix file locking regression for v6.0
From:   Jeff Layton <jlayton@kernel.org>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Marc Dionne <marc.dionne@auristor.com>
Date:   Mon, 22 Aug 2022 06:51:43 -0400
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 274a2eebf80c60246f9edd6ef8e9a095ad121264=
:

  Merge tag 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/ms=
t/vhost (2022-08-17 08:58:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git tags/file=
lock-v6.0-2

for you to fetch changes up to 932c29a10d5d0bba63b9f505a8ec1e3ce8c02542:

  locks: Fix dropped call to ->fl_release_private() (2022-08-17 15:08:58 -0=
400)

----------------------------------------------------------------
Hi Linus,

Just a single patch for a bugfix in the flock() codepath, introduced by
a patch that went in recently.
----------------------------------------------------------------
David Howells (1):
      locks: Fix dropped call to ->fl_release_private()

 fs/locks.c | 1 +
 1 file changed, 1 insertion(+)

--=20
Jeff Layton <jlayton@kernel.org>
