Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C62253BBF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 03:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgH0B7v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Aug 2020 21:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbgH0B7t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Aug 2020 21:59:49 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CD9C061368;
        Wed, 26 Aug 2020 18:59:48 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kB7CW-005JMx-9N; Thu, 27 Aug 2020 01:59:40 +0000
Date:   Thu, 27 Aug 2020 02:59:40 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ross Zwisler <zwisler@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Mattias Nissler <mnissler@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Gordon <bmgordon@google.com>,
        David Howells <dhowells@redhat.com>,
        Dmitry Torokhov <dtor@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Micah Morton <mortonm@google.com>,
        Raul Rangel <rrangel@google.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v8 1/2] Add a "nosymfollow" mount option.
Message-ID: <20200827015940.GY1236603@ZenIV.linux.org.uk>
References: <20200819164317.637421-1-zwisler@google.com>
 <20200826204819.GA4414@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826204819.GA4414@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 26, 2020 at 02:48:19PM -0600, Ross Zwisler wrote:

> Al, now that the changes to fs/namei.c have landed and we're past the merge
> window for v5.9, what are your thoughts on this patch and the associated test?

Humm...  should that be nd->path.mnt->mnt_flags or link->mnt->mnt_flags?
Usually it's the same thing, but they might differ.  IOW, is that about the
directory we'd found it in, or is it about the link itself?
