Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D385036FDE9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 17:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbhD3PlB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 11:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhD3Pk7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 11:40:59 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF774C06174A;
        Fri, 30 Apr 2021 08:40:10 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lcVFP-009dW5-SB; Fri, 30 Apr 2021 15:40:07 +0000
Date:   Fri, 30 Apr 2021 15:40:07 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        lkp@lists.01.org, lkp@intel.com
Subject: Re: [iov_iter]  2418c34937: Initiating_system_reboot
Message-ID: <YIwk1xTixeJpuDB0@zeniv-ca.linux.org.uk>
References: <20210428023747.GA13086@xsang-OptiPlex-9020>
 <YIjT+lZNn46VgscR@zeniv-ca.linux.org.uk>
 <20210430155431.GB20100@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210430155431.GB20100@xsang-OptiPlex-9020>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 30, 2021 at 11:54:31PM +0800, Oliver Sang wrote:

> not sure if this soft_panic=1 test is still useful, but from test, it seems
> not generate more useful information (attached one for example).
> 
> and if you still want this test, could you help check our command line and
> maybe supply further information how to enable it properly?

Should be fixed in the current branch.
