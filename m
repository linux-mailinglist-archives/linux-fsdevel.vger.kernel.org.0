Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A729117CC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 13:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfEBLCX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 07:02:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:49998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbfEBLCX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 07:02:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5A6B20656;
        Thu,  2 May 2019 11:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556794942;
        bh=nOdygw9Kk1rPOSBt7SYd7W2YRVezyBvv7bv92jfZhHM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QVhLNVl+kFCGa4qKMxbE3iXUhUTDNoqNjOrwG/PTklDuyc/zZitjl4iGVIUEcK9mq
         ZjtTSTPd/IYzKKg9UaCBiZ1iUe+zjqgu6eX3MtWFfMyatUxvweOtiAQ0LBZimoeXJA
         oWjvyASNbWkhMa6vm3fnEL/GbAHDE6uY2kQH7jq4=
Date:   Thu, 2 May 2019 13:02:20 +0200
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
        rostedt@goodmis.org, wfg@linux.intel.com,
        Felix Guo <felixguoxiuping@gmail.com>
Subject: Re: [PATCH v2 12/17] kunit: tool: add Python wrappers for running
 KUnit tests
Message-ID: <20190502110220.GD12416@kroah.com>
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-13-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501230126.229218-13-brendanhiggins@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 01, 2019 at 04:01:21PM -0700, Brendan Higgins wrote:
> From: Felix Guo <felixguoxiuping@gmail.com>
> 
> The ultimate goal is to create minimal isolated test binaries; in the
> meantime we are using UML to provide the infrastructure to run tests, so
> define an abstract way to configure and run tests that allow us to
> change the context in which tests are built without affecting the user.
> This also makes pretty and dynamic error reporting, and a lot of other
> nice features easier.
> 
> kunit_config.py:
>   - parse .config and Kconfig files.
> 
> kunit_kernel.py: provides helper functions to:
>   - configure the kernel using kunitconfig.
>   - build the kernel with the appropriate configuration.
>   - provide function to invoke the kernel and stream the output back.
> 
> Signed-off-by: Felix Guo <felixguoxiuping@gmail.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>

Ah, here's probably my answer to my previous logging format question,
right?  What's the chance that these wrappers output stuff in a standard
format that test-framework-tools can already parse?  :)

thanks,

greg k-h
