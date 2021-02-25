Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CECDB32485F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 02:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236726AbhBYBLu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Feb 2021 20:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236689AbhBYBLh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Feb 2021 20:11:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629EEC06178A;
        Wed, 24 Feb 2021 17:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Pxp27Lg5NuoGPtPaAbGFJnB57vNOb6MXHOpCNp3dGHE=; b=ELytS6+uVRKM1ukPLoKbFy8vSa
        MS4sx2xtcJvvGt4ZsZtF2PQ7FRF9quUS7BsML2U4cdqJ0h9iHIeahSuMH8LzUYM9JzGCF/IqvUFev
        xQWHPl3TQAd0HKIlRZkkEXvwkQ8pIysZVRCLHPRcpTefbJNVcramdkLSX1G/cGjBAqtkEzhNeGH7E
        elmKmt/0OMgm1hh89jcajDaA3l1FrsovP9MUisdHuKc2rs8jIrvGHlqODI8nLAOKZ5v7oVH33WYfI
        PaH9hZ4lZvgVN44n9lpR1tCBz3CHcCXnrU8IPvbvkDg7deCWLqfu2A3KagUOSLv3Vob7jWjRLZD6x
        L5CFmEkQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lF5AI-00A71H-Ne; Thu, 25 Feb 2021 01:10:07 +0000
Date:   Thu, 25 Feb 2021 01:10:02 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     kernel-team <kernel-team@cloudflare.com>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Memory allocation issues after "sysctl: Convert to iter
 interfaces"
Message-ID: <20210225011002.GW2858050@casper.infradead.org>
References: <CABWYdi1CU_04GJXC0fK4=Rs+a0117qBr=oZX_oGa=-hmSEH75g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABWYdi1CU_04GJXC0fK4=Rs+a0117qBr=oZX_oGa=-hmSEH75g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 24, 2021 at 05:02:09PM -0800, Ivan Babrou wrote:
> Hello,
> 
> We started seeing allocation failures on procfs reads after
> commit 4bd6a7353ee1 "sysctl: Convert to iter interfaces".

https://lore.kernel.org/linux-fsdevel/6345270a2c1160b89dd5e6715461f388176899d1.1612972413.git.josef@toxicpanda.com/
