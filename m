Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 014A160086
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2019 07:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbfGEFRj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jul 2019 01:17:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:56860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbfGEFRi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jul 2019 01:17:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF97D216FD;
        Fri,  5 Jul 2019 05:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562303857;
        bh=7wlnbU7f7NI4tp/aNkJpCkcXuqZ5WwcXUMv6L1ELc9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ugFyFfFKxNGYgqcsh/MHx4NXJCIKEN54oVlmcVYIMOOV+VWzrlEZvmbebID8zJ5bL
         eqmwYQmbvOmjFYhkaVSALkugyKBmfb1VfnBe27/tme7AWsfKHTvt939Fp5y9LAsG40
         T1T2qcyfsYKp8T79H0xukTrXjRdyvTpc+Fm0NASY=
Date:   Fri, 5 Jul 2019 07:17:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, nicolas.dichtel@6wind.com,
        raven@themaw.net, Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] Add a general, global device notification watch list
 [ver #5]
Message-ID: <20190705051733.GA15821@kroah.com>
References: <20190703190846.GA15663@kroah.com>
 <156173690158.15137.3985163001079120218.stgit@warthog.procyon.org.uk>
 <156173697086.15137.9549379251509621554.stgit@warthog.procyon.org.uk>
 <10295.1562256260@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10295.1562256260@warthog.procyon.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 04, 2019 at 05:04:20PM +0100, David Howells wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > Don't we need a manpage and a kselftest for it?
> 
> I've got part of a manpage, but it needs more work.
> 
> How do you do a kselftest for this when it does nothing unless hardware events
> happen?

Hm, good point, but there should be some way to test this to verify it
works.  Maybe for the other types of events?

thanks,

greg k-h
