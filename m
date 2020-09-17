Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C871E26E12D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 18:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgIQQwP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 12:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728680AbgIQQvE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 12:51:04 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314B7C061756;
        Thu, 17 Sep 2020 09:50:55 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIx7R-000Vhx-9T; Thu, 17 Sep 2020 16:50:49 +0000
Date:   Thu, 17 Sep 2020 17:50:49 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     x86@kernel.org, Jan Kara <jack@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/3] compat: lift compat_s64 and compat_u64 to
 <asm-generic/compat.h>
Message-ID: <20200917165049.GV3421308@ZenIV.linux.org.uk>
References: <20200917074159.2442167-1-hch@lst.de>
 <20200917074159.2442167-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917074159.2442167-2-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 17, 2020 at 09:41:57AM +0200, Christoph Hellwig wrote:
> lift the compat_s64 and compat_u64 definitions into common code using the
> COMPAT_FOR_U64_ALIGNMENT symbol for the x86 special case.

OK...  Unlike the previous series it's not trying to wean arm64 off the
direct includes of asm/compat.h, avoiding the breakage you've got there.

Looks sane, applied.
