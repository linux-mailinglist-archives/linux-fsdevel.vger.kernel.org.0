Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10CBF3A4C28
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jun 2021 03:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhFLBu7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Jun 2021 21:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhFLBu6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Jun 2021 21:50:58 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0256C061574;
        Fri, 11 Jun 2021 18:48:59 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lrslS-007A6z-H0; Sat, 12 Jun 2021 01:48:46 +0000
Date:   Sat, 12 Jun 2021 01:48:46 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ian Kent <raven@themaw.net>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Eric Sandeen <sandeen@sandeen.net>,
        Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 3/7] kernfs: use VFS negative dentry caching
Message-ID: <YMQSfkgnw/B65bpV@zeniv-ca.linux.org.uk>
References: <162322846765.361452.17051755721944717990.stgit@web.messagingengine.com>
 <162322862726.361452.10114120072438540655.stgit@web.messagingengine.com>
 <CAJfpegunvr-0b1SW2FDNRdaExr=A9OFH1K-g7d0+UiS+9j5V_w@mail.gmail.com>
 <ca79f8feb8ac6b506e7fdf249dfede832ce45a22.camel@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca79f8feb8ac6b506e7fdf249dfede832ce45a22.camel@themaw.net>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 12, 2021 at 08:47:17AM +0800, Ian Kent wrote:

> > Perhaps add a note about this being dependent on parent of a negative
> > dentry never changing.
> 
> Which of course it it can change, at any time.

What?
