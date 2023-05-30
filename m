Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E5F715F26
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 14:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjE3MZt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 08:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjE3MZc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 08:25:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48895137
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 May 2023 05:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685449444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lC0xxmt+fCXQJk9QP/8MJavqADFqJdu+2L4vPdGQzdI=;
        b=IdOCQofAs6LXYFMEXjK/D+eWo/v9RHNpPtC611S2RWrKLRGIW+Dd/Yy4JFnJbV/HqoqHsj
        1t3U4MMK7D4wl+4opknwzqeUXTM/f2YnX/bz410oIOR9vNmsyEr7RG8KDtZRZsCxayupMl
        nSykRGvFiNrzz2Wg6pBQc7Ze852ofc8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-340-AD_SemPKOqmqIW0ZdGj2uw-1; Tue, 30 May 2023 08:23:58 -0400
X-MC-Unique: AD_SemPKOqmqIW0ZdGj2uw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3D13C85A5BF;
        Tue, 30 May 2023 12:23:58 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 31704492B00;
        Tue, 30 May 2023 12:23:58 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 34UCNwqI013857;
        Tue, 30 May 2023 08:23:58 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 34UCNvw6013853;
        Tue, 30 May 2023 08:23:58 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 30 May 2023 08:23:57 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Matthew Wilcox <willy@infradead.org>
cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-bcachefs@vger.kernel.org, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: fuzzing bcachefs with dm-flakey
In-Reply-To: <ZHUVy7jut1Ex1IGJ@casper.infradead.org>
Message-ID: <alpine.LRH.2.21.2305300815490.13307@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.21.2305260915400.12513@file01.intranet.prod.int.rdu2.redhat.com> <ZHUVy7jut1Ex1IGJ@casper.infradead.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Mon, 29 May 2023, Matthew Wilcox wrote:

> On Mon, May 29, 2023 at 04:59:40PM -0400, Mikulas Patocka wrote:
> > Hi
> > 
> > I improved the dm-flakey device mapper target, so that it can do random 
> > corruption of read and write bios - I uploaded it here: 
> > https://people.redhat.com/~mpatocka/testcases/bcachefs/dm-flakey.c
> > 
> > I set up dm-flakey, so that it corrupts 10% of read bios and 10% of write 
> > bios with this command:
> > dmsetup create flakey --table "0 `blockdev --getsize /dev/ram0` flakey /dev/ram0 0 0 1 4 random_write_corrupt 100000000 random_read_corrupt 100000000"
> 
> I'm not suggesting that any of the bugs you've found are invalid, but 10%
> seems really high.  Is it reasonable to expect any filesystem to cope
> with that level of broken hardware?  Can any of our existing ones cope
> with that level of flakiness?  I mean, I've got some pretty shoddy USB
> cables, but ...

If you reduce the corruption probability, it will take more iterations to 
hit the bugs.

So, for the "edit-compile-test" loop, the probability should be as high as 
possible, just to save the developer's time on testing.

Mikulas

