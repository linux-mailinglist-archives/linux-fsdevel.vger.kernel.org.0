Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBBB64BD36
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 20:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236733AbiLMTYg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 14:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235717AbiLMTYf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 14:24:35 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A278D8A;
        Tue, 13 Dec 2022 11:24:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 899B5CE1409;
        Tue, 13 Dec 2022 19:24:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B92C433EF;
        Tue, 13 Dec 2022 19:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670959470;
        bh=JoyGbc+CLt4wv3FeRw2pIl17kK3ZvDF0ImnJxpQ5c/Y=;
        h=Date:From:To:Cc:Subject:From;
        b=BNjAa4sn7uBdZzM2UUtrfuKyvZ2TkkcjQx+mps27l+EIBJRt/A+XXPDL6U2fWkHeQ
         ehwrbL2J5i9mH2N/Q0K9k8HJ3iKhCow1syUMQqidpUw70i4P22F+Xe9pqI6H6rTzSH
         sVGoZ2IAjmAOFBJdlO3uvhITk21DnSyFXRxQTQ+xDpn2K3Lo6Fm8fLOtBlrj3TfQn7
         Z7vb8hFzixNi89ghpVTypl/OBNZ3O3q/KElOb2cmkJgOl0JEN351XZzM8WpbGlAQrz
         ADNVwXg6qJc4NFfHh5F9zpuMRCJui49m56yS2ynnKaEM9OQ5Dckho9+HyEiRhSLCM0
         OX5eYOYsCD/Ag==
Date:   Tue, 13 Dec 2022 11:24:28 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Separate mailing list (and git and patchwork) for fsverity?
Message-ID: <Y5jRbLEJh3S46Jer@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently, fsverity development is reusing the same mailing list, git repo
(though a different branch), and patchwork project as fscrypt --- mainly just
because I was a little lazy and didn't bother to ask for new ones:

FSCRYPT: FILE SYSTEM LEVEL ENCRYPTION SUPPORT
[...]
L:      linux-fscrypt@vger.kernel.org
Q:      https://patchwork.kernel.org/project/linux-fscrypt/list/
T:      git git://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git
[...]

FSVERITY: READ-ONLY FILE-BASED AUTHENTICITY PROTECTION
[...]
L:      linux-fscrypt@vger.kernel.org
Q:      https://patchwork.kernel.org/project/linux-fscrypt/list/
T:      git git://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git fsverity
[...]

I think this is causing some confusion.  It also makes it so that people can't
subscribe to the list for just one or the other.

What would people say about having a separate mailing list, git repo, and
patchwork project for fsverity?  So the fsverity entry would look like:

FSVERITY: READ-ONLY FILE-BASED AUTHENTICITY PROTECTION
[...]
L:      linux-fsverity@vger.kernel.org
Q:      https://patchwork.kernel.org/project/linux-fsverity/list/
T:      git git://git.kernel.org/pub/scm/fs/fsverity/fsverity.git
[...]

For the branches in the git repo, I'm thinking of using 'for-next' and
'for-current'.  (I'd also update the fscrypt ones to match; currently they are
'master' and 'for-stable'.)

If people are okay with these changes, I'll send off the needed requests to
helpdesk and linux-next to make these changes, and send Linus a pull request to
update MAINTAINERS.  (And update fsverity-utils to point to the new list.)

- Eric
