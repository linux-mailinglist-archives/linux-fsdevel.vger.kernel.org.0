Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF912411B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Aug 2020 22:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgHJU3u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Aug 2020 16:29:50 -0400
Received: from namei.org ([65.99.196.166]:58402 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbgHJU3u (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Aug 2020 16:29:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 07AKTHpc002600;
        Mon, 10 Aug 2020 20:29:17 GMT
Date:   Tue, 11 Aug 2020 06:29:17 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Pavel Machek <pavel@ucw.cz>, Sasha Levin <sashal@kernel.org>,
        snitzer@redhat.com, dm-devel@redhat.com,
        tyhicks@linux.microsoft.com, agk@redhat.com, paul@paul-moore.com,
        corbet@lwn.net, nramas@linux.microsoft.com, serge@hallyn.com,
        pasha.tatashin@soleen.com, jannh@google.com,
        linux-block@vger.kernel.org, viro@zeniv.linux.org.uk,
        axboe@kernel.dk, mdsakib@microsoft.com,
        linux-kernel@vger.kernel.org, eparis@redhat.com,
        linux-security-module@vger.kernel.org, linux-audit@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jaskarankhurana@linux.microsoft.com
Subject: Re: [dm-devel] [RFC PATCH v5 00/11] Integrity Policy Enforcement
 LSM (IPE)
In-Reply-To: <268edec96cbe7d2626c9158b806e8865b6b1b8ed.camel@linux.ibm.com>
Message-ID: <alpine.LRH.2.21.2008110628260.792@namei.org>
References: <20200728213614.586312-1-deven.desai@linux.microsoft.com>  <20200802115545.GA1162@bug> <20200802140300.GA2975990@sasha-vm>  <20200802143143.GB20261@amd>  <1596386606.4087.20.camel@HansenPartnership.com>  <fb35a1f7-7633-a678-3f0f-17cf83032d2b@linux.microsoft.com>
  <1596639689.3457.17.camel@HansenPartnership.com>  <alpine.LRH.2.21.2008050934060.28225@namei.org>  <b08ae82102f35936427bf138085484f75532cff1.camel@linux.ibm.com>  <alpine.LRH.2.21.2008060949410.20084@namei.org>  <eb7a2f5b5cd22cf9231aa0fd8fdb77c729a83428.camel@linux.ibm.com>
  <alpine.LRH.2.21.2008080240350.13040@namei.org>  <4a764c86a824a4b931dd7f130ce7afce7df140e4.camel@linux.ibm.com> <268edec96cbe7d2626c9158b806e8865b6b1b8ed.camel@linux.ibm.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 7 Aug 2020, Mimi Zohar wrote:

> > > Are you planning to attend Plumbers? Perhaps we could propose a BoF 
> > > session on this topic.
> > 
> > That sounds like a good idea.
> 
> Other than it is already sold out.

Mimi advised me off-list that she is able to attend, so I've submitted a 
BoF proposal:

https://www.linuxplumbersconf.org/event/7/abstracts/732/


-- 
James Morris
<jmorris@namei.org>

