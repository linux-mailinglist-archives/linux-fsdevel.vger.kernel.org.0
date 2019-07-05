Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCD460282
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2019 10:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfGEIpE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jul 2019 04:45:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbfGEIpE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jul 2019 04:45:04 -0400
Received: from localhost (83-84-126-242.cable.dynamic.v4.ziggo.nl [83.84.126.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 957A2218BB;
        Fri,  5 Jul 2019 08:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562316303;
        bh=GEwAZHym+11LpGma3a5nx4N6HauXHp3MSbJ/q/jAOEw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YApoGUclFpP3s8P76l8Ct6nQ8/oePFNV0NdE/Ky3oj1SjfBC+vbkLWNxamKeWEg6x
         DteXHG3yqymcD+ap9nKVpnCGYfwZRVEBrc8foKpH9LSTxPP2g9QMe7sYqN4WJLfgyv
         9/aOdXmdGl3a5ugl0NkXNwaHIAeflVGaXXVCOexA=
Date:   Fri, 5 Jul 2019 10:44:59 +0200
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
Message-ID: <20190705084459.GA2579@kroah.com>
References: <20190705051733.GA15821@kroah.com>
 <20190703190846.GA15663@kroah.com>
 <156173690158.15137.3985163001079120218.stgit@warthog.procyon.org.uk>
 <156173697086.15137.9549379251509621554.stgit@warthog.procyon.org.uk>
 <10295.1562256260@warthog.procyon.org.uk>
 <12946.1562313857@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12946.1562313857@warthog.procyon.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 05, 2019 at 09:04:17AM +0100, David Howells wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > Hm, good point, but there should be some way to test this to verify it
> > works.  Maybe for the other types of events?
> 
> Keyrings is the simplest.  keyutils's testsuite will handle that.  I'm trying
> to work out if I can simply make every macro in there that does a modification
> perform a watch automatically to make sure the appropriate events happen.

That should be good enough to test the basic functionality.  After this
gets merged I'll see if I can come up with a way to test the USB
stuff...

thanks,

greg k-h
