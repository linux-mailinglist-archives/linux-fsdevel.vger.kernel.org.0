Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7596B77C71B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Aug 2023 07:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234677AbjHOFer (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Aug 2023 01:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234709AbjHOFaF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Aug 2023 01:30:05 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7F2198C
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 22:30:03 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-82-92.bstnma.fios.verizon.net [173.48.82.92])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37F5TlsN002022
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 01:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692077390; bh=KV8dziXjkt2w+JS9iEHu4PQQdHS/0krnQy5HzZLUJaE=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=HgRUJ5nFM8FqNUDGQuMtyqAjm6sgDHSZnNCFVsd4ImQ4jD0ZEIUlFu+gyzg6L54cx
         bCds0BnTMCc9ptxiyfi7Xk6riBcdjE1/c+mJZXSsdP7GVti85+bylqf0oXq+vTZRZg
         YJdxdK05EMkk6UCDBIK7ET0jROuNqpbJd1eXbQKNcfRufMS1zSa415kZOBX3oMcprT
         vNmH1nfIUPUDJO6u2qKoQOSBOniUHKt5y8Fr5SSmnhKKtQYyvKFwtgw3HRlI5mrM+T
         XLS7ZQP2K/lwDynTBXVMAGmY72VSegtRu2imOk0c9o0fOlgobDBVg5bHt7kkqOaXx/
         R4NeIyGj6ArXA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A9D0615C0292; Tue, 15 Aug 2023 01:29:47 -0400 (EDT)
Date:   Tue, 15 Aug 2023 01:29:47 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-mm@kvack.org, ksummit@lists.linux.dev
Subject: Maintainers Summit 2023 Call for Topics
Message-ID: <20230815052947.GA3214753@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This year, the Maintainers Summit will be held in Richmond, VA on
November 16th, 2023, just after the Linux Plumber's Conference
(November 13--15th).

As in previous years, the Maintainers Summit is invite-only, where the
primary focus will be process issues around Linux Kernel Development.
It will be limited to 30 invitees and a handful of sponsored
attendees.

Linus has generated a list of people for the program committee to
consider.  People who suggest topics that should be discussed at the
Maintainers Summit will also be added to the list for consideration.
To make topic suggestions for the Maintainers Summit, please send
e-mail to the ksummit@lists.linux.dev with a subject prefix of
[MAINTAINERS SUMMIT].

For an examples of past Maintainers Summit topics, please see the
these LWN articles:

 * 2022 https://lwn.net/Articles/908320/
 * 2021 https://lwn.net/Articles/870415/
 * 2019 https://lwn.net/Articles/799060/

Invites will be sent out on a rolling basis, with the first batch
being sent out in roughly 2 weeks or so, so if you have some topics
which you are burning to discuss, why not wait and submit them today?  :-)


If you were not subscribed on to the kernel mailing list from
last year (or if you had removed yourself after the kernel summit),
you can subscribe by sending an e-mail to the address:

   ksummit+subscribe@lists.linux.dev

The program committee this year is composed of the following people:

Christian Brauner
Jon Corbet
Greg KH
Ted Ts'o
Rafael J. Wysocki
