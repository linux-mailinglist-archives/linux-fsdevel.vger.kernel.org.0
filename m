Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96916F2972
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Apr 2023 18:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjD3QLu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Apr 2023 12:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjD3QLs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Apr 2023 12:11:48 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B5D1B7
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Apr 2023 09:11:46 -0700 (PDT)
Received: from letrec.thunk.org ([76.150.80.181])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 33UGBZxx008330
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 30 Apr 2023 12:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1682871098; bh=FISw4lT36oy5KNtg2z3qPViLVehHVSuugYdkc8CEZtU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=n5hm6W4ieRc/LF12HdPof9dHR3mEVoa1y0rZmCVwXTTl2jUPdYNM6AqKqhvM79tgW
         9sTUk1Qy5exwQ+9Hf4BGPFiHr5Tgnr5YLg15QswGvfVG84n4vxo7u5J9SqyTP6KI3C
         50d+BqXVKJc2ukbTJKWQC9LVnSFtaQXfzPhzssAAHdfkTsZuj87fIYmEWccBirTJw+
         lw3VJGOkCiABiaSbgZ5CgpWBJJ+culiwv0MeC86R22Bm6VdpXPPUZ3PAZe2OgJ03v2
         g7EP48M1PPVxz/gYXNKyKWNAkaRd1Tvhm7dE/Gu6l67tCRMJkLaG6YfYHCPXbpqlBR
         FkwgwbSMxs9VA==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 251548C023E; Sun, 30 Apr 2023 12:11:35 -0400 (EDT)
Date:   Sun, 30 Apr 2023 12:11:35 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     syzbot <syzbot+e6dab35a08df7f7aa260@syzkaller.appspotmail.com>
Cc:     brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] INFO: task hung in eventpoll_release_file
Message-ID: <ZE6TNxk+OV8rjMzA@mit.edu>
References: <000000000000c6dc0305f75b4d74@google.com>
 <ZE4L+x5SjT3+elhh@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZE4L+x5SjT3+elhh@mit.edu>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

#syz set subsystems: fs

This somehow got tagged with the ext4 label, and not the fs label.
(And this is not the first one I've noticed).  I'm beginning to
suspect there may have been some syzbot database hiccup?  Anyway,
fixing...

						- Ted
