Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B1E496289
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jan 2022 17:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381766AbiAUQBz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jan 2022 11:01:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43700 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1381745AbiAUQBr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jan 2022 11:01:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642780906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=juqMzEmzIRv+9PxXvTzIHJDGlUg5TvTdn7+F99E8dgk=;
        b=ZfPMYYUM6/NTGYtgImxGKfmfvqTUKGEO7b5V/iyHyE3YKCcZblPZLUeWk2jLQZzwOB6/RJ
        a9K+nowL54rihiToOg9AyTO2EgjQnDxnxMuXi47D/XAc9R+LMGbChI6RfvQgxjIAUMMtHR
        doC7MWrskcC0TgfbYMEIYSNEyuTfeVA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-cPeA97QOPZOq2pSrDN_TTA-1; Fri, 21 Jan 2022 11:01:43 -0500
X-MC-Unique: cPeA97QOPZOq2pSrDN_TTA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48B0D8519E6;
        Fri, 21 Jan 2022 16:01:38 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CFF861091ED6;
        Fri, 21 Jan 2022 16:01:37 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [libaio PATCH] harness: add test for aio poll missed events
References: <20220106044943.55242-1-ebiggers@kernel.org>
        <YeoLAu++cORO5mRL@sol.localdomain>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Fri, 21 Jan 2022 11:04:17 -0500
In-Reply-To: <YeoLAu++cORO5mRL@sol.localdomain> (Eric Biggers's message of
        "Thu, 20 Jan 2022 17:23:14 -0800")
Message-ID: <x49k0etf532.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> writes:

> On Wed, Jan 05, 2022 at 08:49:43PM -0800, Eric Biggers wrote:
>> From: Eric Biggers <ebiggers@google.com>
>> 
>> Add a regression test for a recently-fixed kernel bug where aio polls
>> sometimes didn't complete even if the file is ready.
>> 
>> This is a cleaned-up version of the test which I originally posted at
>> https://lore.kernel.org/r/YbMKtAjSJdXNTzOk@sol.localdomain
>> 
>> Signed-off-by: Eric Biggers <ebiggers@google.com>
>> ---
>>  harness/cases/23.t | 255 +++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 255 insertions(+)
>>  create mode 100644 harness/cases/23.t
>
> Jeff, any feedback on this?  It looks like you're maintaining libaio.
>
> I feel that this should go in the libaio test suite given the other aio tests
> there already (including the one for aio poll), but I'd also be glad to put this
> in LTP instead if you would prefer that.  Just let me know...

Sorry for the late reply.  I'll get this integrated.  Thanks a lot for
providing the test case!

-Jeff

