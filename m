Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF9EA11BB19
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 19:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731080AbfLKSJ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 13:09:57 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36412 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730281AbfLKSJ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 13:09:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576087796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=DjdU2OmaeCrCML7Z3SM+Bw8StC7ApXHGySv/mxZQmdI=;
        b=E1t0M/Yg84qsH76YAqRuUJzLrOcHshKvmeRWwO3mv0zjfqQs/rxKBjEl/S1Fb0ssF9Xc4H
        NeXDnr4LM3DdDTejEKPtO+cgX/igIWBnVbf8UkNpvpzi1Gc19rKlyOYES1sHV0GI/rn2qI
        MjOuEhl5uWxV/qqmpqpr2SSg93wEBnE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-sfvTOy9pNgO7qN-050Z9RA-1; Wed, 11 Dec 2019 13:09:51 -0500
X-MC-Unique: sfvTOy9pNgO7qN-050Z9RA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 935FB8CB827;
        Wed, 11 Dec 2019 18:09:49 +0000 (UTC)
Received: from greed.delorie.com (ovpn-116-25.phx2.redhat.com [10.3.116.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5DA6AA7EB;
        Wed, 11 Dec 2019 18:09:49 +0000 (UTC)
Received: from greed.delorie.com.redhat.com (localhost [127.0.0.1])
        by greed.delorie.com (8.14.7/8.14.7) with ESMTP id xBBI9i8x004393;
        Wed, 11 Dec 2019 13:09:45 -0500
From:   DJ Delorie <dj@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     vincent.guittot@linaro.org, dsterba@suse.cz, dhowells@redhat.com,
        ebiggers@kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@kernel.org
Subject: Re: [PATCH 0/2] pipe: Fixes [ver #2]
In-Reply-To: <CAHk-=wicgTacrHUJmSBbW9MYAdMPdrXzULPNqQ3G7+HkLeNf1Q@mail.gmail.com> (message from Linus Torvalds on Mon, 9 Dec 2019 09:48:27 -0800)
Date:   Wed, 11 Dec 2019 13:09:44 -0500
Message-ID: <xnpngusphz.fsf@greed.delorie.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:
> [ Added DJ to the participants, since he seems to be the Fedora make
> maintainer - DJ, any chance that this absolutely horrid 'make' buf can
> be fixed in older versions too, not just rawhide? The bugfix is two
> and a half years old by now, and the bug looks real and very serious ]

Builds for F30 and F31 are in bodhi, waiting on testing and karma...
https://bodhi.fedoraproject.org/updates/FEDORA-2019-bd81ed62bf
https://bodhi.fedoraproject.org/updates/FEDORA-2019-a056aa61d4

F29 is already EOL.

