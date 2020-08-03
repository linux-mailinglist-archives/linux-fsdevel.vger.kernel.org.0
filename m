Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654A923A9BD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 17:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgHCPm4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 11:42:56 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:37566 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728232AbgHCPmz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 11:42:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 0C8748EE1DD;
        Mon,  3 Aug 2020 08:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1596469374;
        bh=Uum3YBzktKJNuHiR6OJu5HmfTF5qQnA5gi/i5G/rXrQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=O9JK86TcVP7gbxm2fb/8Q61ppK2NKKQTxTKNuHlV2ceyKu1aTztA5xAoiJrD2pxW/
         Q+qv2hXr5mwEzJ3gdctVri6mhLMR5/CHlIiEsE/4/lI+JZDaI0KDvNumWeAJkyX13U
         OCGvKNLxJrKe8ou8wqztvVdP+b2dZwwO98fcCXtA=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EdiLDuzcATav; Mon,  3 Aug 2020 08:42:53 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 81ED08EE14D;
        Mon,  3 Aug 2020 08:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1596469373;
        bh=Uum3YBzktKJNuHiR6OJu5HmfTF5qQnA5gi/i5G/rXrQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=s4K2YpwDLz+5kMilTgP8ZNMakkD9GePIXlmZcfIzJDFHwQHhqnSrKdXx2dgkvpwtr
         hAqE4Wy7TqMCx3r3hCV4Hpap0/QxwKCr2EbyGneLKFgGD6GJ8mv6m1pfA0xUdlMOoP
         UgLcD2xTWanH2eZI7HU/ES49TBMi0ZvSvbsfkml4=
Message-ID: <1596469370.29091.13.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Steven Sistare <steven.sistare@oracle.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org, mhocko@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        arnd@arndb.de, keescook@chromium.org, gerg@linux-m68k.org,
        ktkhai@virtuozzo.com, christian.brauner@ubuntu.com,
        peterz@infradead.org, esyr@redhat.com, jgg@ziepe.ca,
        christian@kellner.me, areber@redhat.com, cyphar@cyphar.com
Date:   Mon, 03 Aug 2020 08:42:50 -0700
In-Reply-To: <877dufvje9.fsf@x220.int.ebiederm.org>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
         <20200730152250.GG23808@casper.infradead.org>
         <db3bdbae-eb0f-1ae3-94dd-045e37bc94ba@oracle.com>
         <20200730171251.GI23808@casper.infradead.org>
         <63a7404c-e4f6-a82e-257b-217585b0277f@oracle.com>
         <20200730174956.GK23808@casper.infradead.org>
         <ab7a25bf-3321-77c8-9bc3-28a223a14032@oracle.com>
         <87y2n03brx.fsf@x220.int.ebiederm.org>
         <689d6348-6029-5396-8de7-a26bc3c017e5@oracle.com>
         <877dufvje9.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-08-03 at 10:28 -0500, Eric W. Biederman wrote:
[...]
> What is wrong with live migration between one qemu process and
> another qemu process on the same machine not work for this use case?
> 
> Just reusing live migration would seem to be the simplest path of
> all, as the code is already implemented.  Further if something goes
> wrong with the live migration you can fallback to the existing
> process.  With exec there is no fallback if the new version does not
> properly support the handoff protocol of the old version.

Actually, could I ask this another way: the other patch set you sent to
the KVM list was to snapshot the VM to a PKRAM capsule preserved across
kexec using zero copy for extremely fast save/restore.  The original
idea was to use this as part of a CRIU based snapshot, kexec to new
system, restore.  However, why can't you do a local snapshot, restart
qemu, restore using the PKRAM capsule to achieve exactly the same as
MADV_DOEXEC does but using a system that's easy to reason about?  It
may be slightly slower, but I think we're still talking milliseconds.

James

