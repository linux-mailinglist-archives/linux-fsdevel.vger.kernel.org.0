Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E13791356
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Sep 2023 10:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352567AbjIDIXq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Sep 2023 04:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244270AbjIDIXp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 04:23:45 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874AC11D;
        Mon,  4 Sep 2023 01:23:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 98642CE0E26;
        Mon,  4 Sep 2023 08:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D95C433C7;
        Mon,  4 Sep 2023 08:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693815818;
        bh=X9oWyqCbB2rKdV0IJ5r05rZOHmU/29ZmUxFASRi2Z9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZscYfV13IpDaANAevgUJdJjM6qFYc5HNCJpHq/PXpmC61Mm9m3E+Bh17g4gMIWLeu
         WqVzJXRcG1+nPOS411eMQ/8Knh9Hnj0Ak4c1klRHcSuGzOI+Posap06lQYg9GcuYqn
         mRLwdrjAMn1qREeyKbsdIxfm9f81b5sw1v690WRK5pNRhfEJRO9RwCMQ59WeYPuS+i
         uQ3Rp+ZzgIrlXXbyP+LAXeDS6MjKJOzHFppQuq9+YMsUboug2syKJvfiSPLV11Wrwn
         sE/o8DRjEPHjnxYwDy5IFA5RK5MsAnh5jQTU9lCrkAuJV+zLzrAAqUvfGLV9HxOHqT
         eCPaOa+AD+jFg==
Date:   Mon, 4 Sep 2023 10:23:33 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Mateusz Guzik <mjguzik@gmail.com>,
        syzbot <syzbot+e245f0516ee625aaa412@syzkaller.appspotmail.com>,
        djwong@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com,
        viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [xfs?] INFO: task hung in __fdget_pos (4)
Message-ID: <20230904-nashorn-gemeckert-3ca91ef71695@brauner>
References: <000000000000e6432a06046c96a5@google.com>
 <ZPQYyMBFmqrfqafL@dread.disaster.area>
 <20230903083357.75mq5l43gakuc2z7@f>
 <ZPUIQzsCSNlnBFHB@dread.disaster.area>
 <CAGudoHE_-2765EttOV_6B9EeSuOxqo1MiRCyFP9y=GbSeCMtZg@mail.gmail.com>
 <ZPUSPAnuGLLe3QWH@dread.disaster.area>
 <20230904-beleben-adipositas-ac1ed398927d@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230904-beleben-adipositas-ac1ed398927d@brauner>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > Which is pretty much the case for all filesystem bug reports from

I think we should at least consider the option of reducing the number of
filesystems syzbot tests. Filesystems that are orphaned or that have no
active maintainers for a long period of time just produce noise.
Slapping tags such as [ntfs3?] or [reiserfs?] really don't help to
reduce the noise.
