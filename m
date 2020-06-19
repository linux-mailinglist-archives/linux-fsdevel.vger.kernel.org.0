Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74EEC1FFF8B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 03:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbgFSBFQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 21:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgFSBFQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 21:05:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E98C06174E;
        Thu, 18 Jun 2020 18:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GMs1dTUtRlm7p1ATLk5CmBkboJ8dwdec3LertXCUqnc=; b=JaUPTqF+cHwtDddl5QLHYQLOtF
        NXT5zalnO2mbkuYv8/gsTctH3kewJK8s82hjLGPaIJaMQguP/wtwsc3Pie3YDpZ3tIrs35shKBeAV
        giB46lFiK7WdaCp57s0Lr8sZmsp5H8wMHpSF9ca56Z07uewn/qUAxKSlcn2oUt4xBhJeXXv/ifCjp
        EItlcX+ugstMIAN+L+hw6i8jxCbud4Yo7Oj7btNKlbRF44cfI2Y1Lrz3yz+3SyAVkJLr5uQytkabw
        MCiiKTNeQENQG6EDxRVtntXcxNJ1S65IGvanPzj6om+caGrJYPGvIsQoLo8wSflXgMGA+/YrQ3i9A
        Q31Bvr2Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jm5Sz-0007n5-Sh; Fri, 19 Jun 2020 01:05:13 +0000
Date:   Thu, 18 Jun 2020 18:05:13 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "dhowells@redhat.com" <dhowells@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Parallel compilation performance regression
Message-ID: <20200619010513.GW8681@bombadil.infradead.org>
References: <a1bafab884bb60250840a8721b78f4b5d3a6c2ed.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1bafab884bb60250840a8721b78f4b5d3a6c2ed.camel@intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 18, 2020 at 11:52:55PM +0000, Derrick, Jonathan wrote:
> Hi David,
> 
> I've been experiencing a performance regression when running a parallel
> compilation (eg, make -j72) on recent kernels.

I bet you're using a version of make which predates 4.3:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0ddad21d3e99c743a3aa473121dc5561679e26bb

