Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C181C4DFC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 07:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgEEF6V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 01:58:21 -0400
Received: from verein.lst.de ([213.95.11.211]:33405 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbgEEF6V (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 01:58:21 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B397168BEB; Tue,  5 May 2020 07:58:19 +0200 (CEST)
Date:   Tue, 5 May 2020 07:58:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl: Make sure proc handlers can't expose heap
 memory
Message-ID: <20200505055819.GB3552@lst.de>
References: <202005041205.C7AF4AF@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005041205.C7AF4AF@keescook>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 04, 2020 at 12:08:55PM -0700, Kees Cook wrote:
> Just as a precaution, make sure that proc handlers don't accidentally
> grow "count" beyond the allocated kbuf size.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> This applies to hch's sysctl cleanup tree...

This looks ok o me.  You should probably add Al to the Cc list as
he has picked up my series into a branch of vfs.git.

Acked-by: Christoph Hellwig <hch@lst.de>
