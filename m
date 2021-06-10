Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3864F3A2FC3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jun 2021 17:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbhFJPuE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Jun 2021 11:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbhFJPuE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Jun 2021 11:50:04 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F8DC061760;
        Thu, 10 Jun 2021 08:48:08 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lrMua-006dBF-Hw; Thu, 10 Jun 2021 15:48:04 +0000
Date:   Thu, 10 Jun 2021 15:48:04 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [RFC][PATCHSET] iov_iter work
Message-ID: <YMI0NJkhp4DDEjpn@zeniv-ca.linux.org.uk>
References: <YL0dCEVEiVL+NwG6@zeniv-ca.linux.org.uk>
 <7433441f-b175-8484-240c-d1498c8c43f2@quicinc.com>
 <YMIxMszl0SoCmzcY@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMIxMszl0SoCmzcY@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 10, 2021 at 03:35:14PM +0000, Al Viro wrote:
> 
> Bloody hell.  Incremental, to be folded in:

Folded and pushed out (#for-next at 1130294f1440, #work.iov_iter
at 6852df126699)
