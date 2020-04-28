Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFBE91BC778
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 20:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbgD1SFv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 14:05:51 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47218 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728313AbgD1SFv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:05:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588097150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LuQ1QRx1zxKaFisNAhvu4KiUYVW6FXy89qzAIYTurio=;
        b=OSkb/6UXrzV7dPK5+Wb9Sc/GpuHw1/su+f25OreN8+ymJT7/BZ8ryGSgvHYmq2xA9xyEJu
        sEKjmmK8/LejAIMXrir/v0YdstDr+b/UZ6k0QUmej6Fmc46xGaMWqaXoiPE8pwcjL6CttD
        nfzrA0De4Wv3sAA7PLSSYKOA5cYJFqQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-_wnZ237vOZiNnM2Ufq9ccg-1; Tue, 28 Apr 2020 14:05:46 -0400
X-MC-Unique: _wnZ237vOZiNnM2Ufq9ccg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98B4D468;
        Tue, 28 Apr 2020 18:05:44 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.231])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0A2E65C1D4;
        Tue, 28 Apr 2020 18:05:41 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 28 Apr 2020 20:05:44 +0200 (CEST)
Date:   Tue, 28 Apr 2020 20:05:41 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v4 0/2] proc: Ensure we see the exit of each process tid
 exactly
Message-ID: <20200428180540.GB29960@redhat.com>
References: <20200419141057.621356-1-gladkov.alexey@gmail.com>
 <87ftcv1nqe.fsf@x220.int.ebiederm.org>
 <87wo66vvnm.fsf_-_@x220.int.ebiederm.org>
 <20200424173927.GB26802@redhat.com>
 <87mu6ymkea.fsf_-_@x220.int.ebiederm.org>
 <875zdmmj4y.fsf_-_@x220.int.ebiederm.org>
 <CAHk-=whvktUC9VbzWLDw71BHbV4ofkkuAYsrB5Rmxnhc-=kSeQ@mail.gmail.com>
 <878sihgfzh.fsf@x220.int.ebiederm.org>
 <CAHk-=wjSM9mgsDuX=ZTy2L+S7wGrxZMcBn054As_Jyv8FQvcvQ@mail.gmail.com>
 <87sggnajpv.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sggnajpv.fsf_-_@x220.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04/28, Eric W. Biederman wrote:
>
> In short I don't think this change will introduce any regressions.
>
> Eric W. Biederman (2):
>       rculist: Add hlists_swap_heads_rcu
>       proc: Ensure we see the exit of each process tid exactly once

Eric, sorry, I got lost.

Both changes look good to me, feel free to add my ack, but I presume
this is on top of next_tgid/lookup_task changes ? If yes, why did not
you remove has_group_leader_pid?

Oleg.

