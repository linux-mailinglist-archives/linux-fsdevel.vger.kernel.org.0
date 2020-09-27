Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1EA1279D9B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Sep 2020 04:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730222AbgI0C4G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Sep 2020 22:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgI0C4F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Sep 2020 22:56:05 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79F7C0613CE
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2020 19:56:05 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kMMr5-0070QI-P0; Sun, 27 Sep 2020 02:56:03 +0000
Date:   Sun, 27 Sep 2020 03:56:03 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: stat cleanups (resend)
Message-ID: <20200927025603.GB3421308@ZenIV.linux.org.uk>
References: <20200926070401.11816-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200926070401.11816-1-hch@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 26, 2020 at 09:03:56AM +0200, Christoph Hellwig wrote:
> Hi Al,
> 
> a bunch of cleanups to untangle our mess of state related helpers.

Applied to #work.misc, visible in #for-next
