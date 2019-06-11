Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1D0D3D5F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2019 20:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404479AbfFKS4Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jun 2019 14:56:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49158 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404245AbfFKS4Q (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jun 2019 14:56:16 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 69C0A81DE1;
        Tue, 11 Jun 2019 18:56:01 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-204-114.brq.redhat.com [10.40.204.114])
        by smtp.corp.redhat.com (Postfix) with SMTP id 013715B685;
        Tue, 11 Jun 2019 18:55:52 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 11 Jun 2019 20:55:58 +0200 (CEST)
Date:   Tue, 11 Jun 2019 20:55:49 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        linux-kernel@vger.kernel.org, arnd@arndb.de, dbueso@suse.de,
        axboe@kernel.dk, dave@stgolabs.net, e@80x24.org, jbaron@akamai.com,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        omar.kilani@gmail.com, tglx@linutronix.de,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Laight <David.Laight@ACULAB.COM>,
        linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] signal: Teach sigsuspend to use set_user_sigmask
Message-ID: <20190611185548.GA31214@redhat.com>
References: <20190522032144.10995-1-deepa.kernel@gmail.com>
 <20190529161157.GA27659@redhat.com>
 <20190604134117.GA29963@redhat.com>
 <20190606140814.GA13440@redhat.com>
 <87k1dxaxcl.fsf_-_@xmission.com>
 <87ef45axa4.fsf_-_@xmission.com>
 <20190610162244.GB8127@redhat.com>
 <87lfy96sta.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lfy96sta.fsf@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 11 Jun 2019 18:56:16 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06/10, Eric W. Biederman wrote:
>
> Personally I don't think anyone sane would intentionally depend on this
> and I don't think there is a sufficiently reliable way to depend on this
> by accident that people would actually be depending on it.

Agreed.

As I said I like these changes and I see nothing wrong. To me they fix the
current behaviour, or at least make it more consistent.

But perhaps this should be documented in the changelog? To make it clear
that this change was intentional.

Oleg.

