Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C734248F1F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 21:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgHRTzl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 15:55:41 -0400
Received: from verein.lst.de ([213.95.11.211]:34922 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbgHRTzl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 15:55:41 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 61B1668AFE; Tue, 18 Aug 2020 21:55:39 +0200 (CEST)
Date:   Tue, 18 Aug 2020 21:55:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 08/11] x86: make TASK_SIZE_MAX usable from assembly code
Message-ID: <20200818195539.GB32691@lst.de>
References: <20200817073212.830069-1-hch@lst.de> <20200817073212.830069-9-hch@lst.de> <202008181244.BBDA7DAB@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202008181244.BBDA7DAB@keescook>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 18, 2020 at 12:44:49PM -0700, Kees Cook wrote:
> On Mon, Aug 17, 2020 at 09:32:09AM +0200, Christoph Hellwig wrote:
> > For 64-bit the only hing missing was a strategic _AC, and for 32-bit we
> 
> typo: thing
> 
> > need to use __PAGE_OFFSET instead of PAGE_OFFSET in the TASK_SIZE
> > definition to escape the explicit unsigned long cast.  This just works
> > because __PAGE_OFFSET is defined using _AC itself and thus never needs
> > the cast anyway.
> 
> Shouldn't this be folded into the prior patch so there's no bisection
> problem?

I didn't see a problem bisecting, do you have something particular in
mind?
