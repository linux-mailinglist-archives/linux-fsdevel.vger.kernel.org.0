Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E552AA275
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Nov 2020 06:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbgKGFIt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Nov 2020 00:08:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:59010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbgKGFIt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Nov 2020 00:08:49 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BF4C20872;
        Sat,  7 Nov 2020 05:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604725727;
        bh=55KoHb8qRGofoRpTcqTP6+Sj4wA/iZddMk3945/FVcc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=clH9jKll51JXfmaZOHedvXOzyp7t2WgbUCWUJcFUbBilgShWQhDpvNoMEYLV6qd43
         +Fl/JEjNDA8ao703NxINPTq7DhZShDMQQ3SqcctGfKdjL2V0jw0fCkDbxitCqY1TJo
         ueNrSwM6MnUGAptjcct12z9Zzj6EsXyQ2pksLgGM=
Date:   Fri, 6 Nov 2020 21:08:45 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michel Lespinasse <walken@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        John Johansen <john.johansen@canonical.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-snps-arc@lists.infradead.org
Subject: Re: [RFC] proc: get_wchan() stack unwind only makes sense for
 sleeping/non-self tasks
Message-Id: <20201106210845.e9e95e91b779a01b6751e240@linux-foundation.org>
In-Reply-To: <20201105231132.2130132-1-vgupta@synopsys.com>
References: <20201105231132.2130132-1-vgupta@synopsys.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu,  5 Nov 2020 15:11:32 -0800 Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:

> Most architectures currently check this in their get_wchan() implementation
> (ARC doesn't hence this patch). However doing this in core code shows
> the semantics better so move the check one level up (eventually remove
> the boiler-plate code from arches)

It would be nice to clean up the arch callees in the same patch, at
least so it doesn't get forgotten about.  Are you prepared to propose
such a change?

