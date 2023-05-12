Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066F5700CCB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 May 2023 18:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjELQSg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 May 2023 12:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjELQS3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 May 2023 12:18:29 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB775B90
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 May 2023 09:18:27 -0700 (PDT)
Received: from letrec.thunk.org (vancouverconventioncentre.com [72.28.92.215] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 34CGIIad003669
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 12:18:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1683908301; bh=GpnkiRtW7rXjGbeS39dZH0ye9mqW84HZwGVqjHiXw3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=l0z69CSyw8a2Ti+sq7f4p9t4/YRD/GlJVNxaCRNyqR1x/FkhwGqKlicBIQR+Xk+RH
         X5Cao+Ye7fl61Vp3FllUw2EgyJeQSq+DqmDBgdss3QcWmoynuCiQZLIyrPI9twpF2Y
         0bfabnOZ5IPjzVyh5wRHw2mwKsbftv+UC82Spb6Z1qoRFgJXynsNpQZMZfrU3HkGo3
         LSrnIrF/xAbNXyVM+lp/TJzrjerzkMQKfcLqMIEtViLn054eVgAH06l02EWOGkHpZO
         Uu8m6DVCPzAprSuAVgFsFrhc7Tm6PkBuVfztlLHb5BWQqNWbuh87VC6Pz1z6AhTRNA
         VPbI6gR9UM0aA==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id AF0A18C0439; Fri, 12 May 2023 12:18:17 -0400 (EDT)
Date:   Fri, 12 May 2023 12:18:17 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     syzbot <syzbot+344aaa8697ebd232bfc8@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ext4?] WARNING in __ext4fs_dirhash
Message-ID: <ZF5mydRaxa8qe6RQ@mit.edu>
References: <0000000000009b5b5705fb5dfda0@google.com>
 <0000000000001f3bf005fb64ea0a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000001f3bf005fb64ea0a@google.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 10, 2023 at 11:15:26PM -0700, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 08dd966cfd2bef467acd1835ae10c32356037bc3
> Author: Theodore Ts'o <tytso@mit.edu>
> Date:   Sat May 6 15:59:13 2023 +0000
> 
>     ext4: improve error handling from ext4_dirhash()
>

n.b.  This was due to a debugging WARN_ON left behind in the patch.
It's since been removed in ext4 dev tree and the updated commit is in
linux-next.

						- Ted
