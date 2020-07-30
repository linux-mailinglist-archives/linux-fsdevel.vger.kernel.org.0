Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5250233627
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 17:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbgG3P7a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 11:59:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55811 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729762AbgG3P73 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 11:59:29 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k1Axi-0000b3-Dz; Thu, 30 Jul 2020 15:59:18 +0000
Date:   Thu, 30 Jul 2020 17:59:17 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        adobriyan@gmail.com, davem@davemloft.net, ebiederm@xmission.com,
        areber@redhat.com, serge@hallyn.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/23] ns: Add common refcount into ns_common add use it
 as counter for net_ns
Message-ID: <20200730155917.r3cirkffznwssesa@wittgenstein>
References: <159611007271.535980.15362304262237658692.stgit@localhost.localdomain>
 <159611036589.535980.1765795847221907147.stgit@localhost.localdomain>
 <20200730133526.4lhkmlamgxjdssip@wittgenstein>
 <7d30f8ec-d0b7-3bae-942f-49e2f8f233e9@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7d30f8ec-d0b7-3bae-942f-49e2f8f233e9@virtuozzo.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 30, 2020 at 05:07:05PM +0300, Kirill Tkhai wrote:
> On 30.07.2020 16:35, Christian Brauner wrote:
> > On Thu, Jul 30, 2020 at 02:59:25PM +0300, Kirill Tkhai wrote:
> >> Currently, every type of namespaces has its own counter,
> >> which is stored in ns-specific part. Say, @net has
> >> struct net::count, @pid has struct pid_namespace::kref, etc.
> >>
> >> This patchset introduces unified counter for all types
> >> of namespaces, and converts net namespace to use it first.
> >>
> >> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> >> ---
> > 
> > Any reason the refcount changes need to be tied to the procfs changes?
> > Seems that should be a separate cleanup patchset which we can take
> > independent of procfs changes.
> 
> Yes, patches [1-8] are cleanup, it may go separately. 
> 
> For me there is no a problem to resend them also as a separate patchset,
> say at v2, or if there is a change in 1-8, but I'm afraid to bomb mailboxes.
> 
> If there is no a request for rework in 1-8, can they be picked directly from here?

Apart from the missing include that might be an issue in ns_common.h
this looks fine to me and seems like a good cleanup overall. Afaict it
even loses more code than it adds.

I think resending this part separately is worth it given that we're not
sure whether this series will be part of procfs or a spearate thing.

This won't make it for the merge window of course but unless there are
technical issues with this conversion I'd pick this up for later.

Thanks!
Christian
