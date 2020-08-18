Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE7A248F3A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 22:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbgHRUAV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 16:00:21 -0400
Received: from verein.lst.de ([213.95.11.211]:34952 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbgHRUAU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 16:00:20 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 321F368AFE; Tue, 18 Aug 2020 22:00:17 +0200 (CEST)
Date:   Tue, 18 Aug 2020 22:00:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 08/11] x86: make TASK_SIZE_MAX usable from assembly code
Message-ID: <20200818200016.GA681@lst.de>
References: <20200817073212.830069-1-hch@lst.de> <20200817073212.830069-9-hch@lst.de> <202008181244.BBDA7DAB@keescook> <20200818195539.GB32691@lst.de> <202008181258.CEC4B8B3@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202008181258.CEC4B8B3@keescook>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 18, 2020 at 12:59:05PM -0700, Kees Cook wrote:
> > I didn't see a problem bisecting, do you have something particular in
> > mind?
> 
> Oh, I misunderstood this patch to be a fix for compilation. Is this just
> a correctness fix?

It prepares for using the definition from assembly, which is done in
the next patch.
