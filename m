Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41604275F81
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 20:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgIWSLl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Sep 2020 14:11:41 -0400
Received: from mother.openwall.net ([195.42.179.200]:60277 "HELO
        mother.openwall.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726422AbgIWSLl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Sep 2020 14:11:41 -0400
Received: (qmail 8044 invoked from network); 23 Sep 2020 18:11:39 -0000
Received: from localhost (HELO pvt.openwall.com) (127.0.0.1)
  by localhost with SMTP; 23 Sep 2020 18:11:39 -0000
Received: by pvt.openwall.com (Postfix, from userid 503)
        id 73B4DAB844; Wed, 23 Sep 2020 20:11:36 +0200 (CEST)
Date:   Wed, 23 Sep 2020 20:11:36 +0200
From:   Solar Designer <solar@openwall.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Pavel Machek <pavel@ucw.cz>, madvenka@linux.microsoft.com,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, oleg@redhat.com,
        x86@kernel.org, luto@kernel.org, David.Laight@ACULAB.COM,
        mark.rutland@arm.com, mic@digikod.net,
        Rich Felker <dalias@libc.org>
Subject: Re: [PATCH v2 0/4] [RFC] Implement Trampoline File Descriptor
Message-ID: <20200923181136.GA8846@openwall.com>
References: <20200922215326.4603-1-madvenka@linux.microsoft.com> <20200923081426.GA30279@amd> <20200923091456.GA6177@openwall.com> <87wo0ko8v0.fsf@oldenburg2.str.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wo0ko8v0.fsf@oldenburg2.str.redhat.com>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 23, 2020 at 04:39:31PM +0200, Florian Weimer wrote:
> * Solar Designer:
> 
> > While I share my opinion here, I don't mean that to block Madhavan's
> > work.  I'd rather defer to people more knowledgeable in current userland
> > and ABI issues/limitations and plans on dealing with those, especially
> > to Florian Weimer.  I haven't seen Florian say anything specific for or
> > against Madhavan's proposal, and I'd like to.  (Have I missed that?)

[...]
> I think it's unnecessary for the libffi use case.
[...]

> I don't know if kernel support could
> make sense in this context, but it would be a completely different
> patch.

Thanks.  Are there currently relevant use cases where the proposed
trampfd would be useful and likely actually made use of by userland -
e.g., specific userland project developers saying they'd use it, or
Madhavan intending to develop and contribute userland patches?

Alexander
