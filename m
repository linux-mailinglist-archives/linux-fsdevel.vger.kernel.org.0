Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEE5195D03
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Mar 2020 18:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgC0RlH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Mar 2020 13:41:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgC0RlG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Mar 2020 13:41:06 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E48FA206F1;
        Fri, 27 Mar 2020 17:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585330866;
        bh=vKPjDs3YP3KyK/z//ZYlLlVkZzZU+vPwURwv25mfl9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eAE/O3qeSYQqU41Fof168BStkeE+GtdEllN+JNJmZvW9l1vulQIWtMAAB5V4rpBV5
         wuHkke+vVXTjTnTD/4Q9mZF4/en5LlHJNKXr/bdd2rjhVKVsSyKcOpcQ1+wgYY6jqL
         VqAnlQxzOEwjMP0C2DepQYYcoGZiJ2avF/vm04/4=
Date:   Fri, 27 Mar 2020 10:41:04 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Jessica Yu <jeyu@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        NeilBrown <neilb@suse.com>
Subject: Re: [PATCH v4 0/5] module autoloading fixes and cleanups
Message-ID: <20200327174104.GA160674@gmail.com>
References: <20200318230515.171692-1-ebiggers@kernel.org>
 <20200320052819.GB1315@sol.localdomain>
 <20200320192718.6d90a5a10476626f0e39b166@linux-foundation.org>
 <20200323171252.GA61708@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323171252.GA61708@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 23, 2020 at 10:12:52AM -0700, Eric Biggers wrote:
> 
> Andrew, can you update -mm to v4 of this patchset?  Right now it contains a mix
> of v2 and v3.  In particular the diff for "docs: admin-guide: document the
> kernel.modprobe sysctl" is different, and I made some small updates to commit
> messages.

Ping?
