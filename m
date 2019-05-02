Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D03E3117A1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 12:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfEBKu5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 06:50:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:46836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbfEBKu4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 06:50:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 862482075E;
        Thu,  2 May 2019 10:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556794256;
        bh=Ayblsy3jHDm2CChtokJ923ivXLZjfyjL6uNubfrhVOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QXN7qfD9kVZ8X14uPJyJaEtMH+8kKfNVIsH6ibUWlQkRylnV/zLp9rQ6le2tunE78
         SSJF7dmrJsP0QsUsoC9j31We0mjmXawkaN8LppVzAyCBUPD5b9pzAyl6ekchbNAzFq
         btjAwtKByeIBqfun6usLtq6HFfVq7lLUJLvG54Zg=
Date:   Thu, 2 May 2019 12:50:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     frowand.list@gmail.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        robh@kernel.org, sboyd@kernel.org, shuah@kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com,
        dan.j.williams@intel.com, daniel@ffwll.ch, jdike@addtoit.com,
        joel@jms.id.au, julia.lawall@lip6.fr, khilman@baylibre.com,
        knut.omang@oracle.com, logang@deltatee.com, mpe@ellerman.id.au,
        pmladek@suse.com, richard@nod.at, rientjes@google.com,
        rostedt@goodmis.org, wfg@linux.intel.com
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
Message-ID: <20190502105053.GA12416@kroah.com>
References: <20190501230126.229218-1-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501230126.229218-1-brendanhiggins@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 01, 2019 at 04:01:09PM -0700, Brendan Higgins wrote:
> ## TLDR
> 
> I rebased the last patchset on 5.1-rc7 in hopes that we can get this in
> 5.2.

That might be rushing it, normally trees are already closed now for
5.2-rc1 if 5.1-final comes out this Sunday.

> Shuah, I think you, Greg KH, and myself talked off thread, and we agreed
> we would merge through your tree when the time came? Am I remembering
> correctly?

No objection from me.

Let me go review the latest round of patches now.

thanks,

greg k-h
