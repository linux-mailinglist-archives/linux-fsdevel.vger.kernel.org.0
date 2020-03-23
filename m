Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB30918FB11
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Mar 2020 18:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbgCWRMy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Mar 2020 13:12:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:49366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727112AbgCWRMy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Mar 2020 13:12:54 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8A132074D;
        Mon, 23 Mar 2020 17:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584983574;
        bh=zYY36C+NQw3BWMNbsipgSyupsxr4ozIcZV8x8cgMdVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xop59apFoDrcZyizFT0955ozbcj/3keVwGNoZtLePDK2SGtIx1HaFk8VL6SIEcz8I
         2k6RzoP5xe46UnHeGYqWDMVpmhZbBgTtgmAyYAk0dDSw2WZzD5lAUP9UzK4z4OoSb1
         Puo+jZAZVR7guAK40Rm/crdzrbKVaSQB63ZKZIL0=
Date:   Mon, 23 Mar 2020 10:12:52 -0700
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
Message-ID: <20200323171252.GA61708@gmail.com>
References: <20200318230515.171692-1-ebiggers@kernel.org>
 <20200320052819.GB1315@sol.localdomain>
 <20200320192718.6d90a5a10476626f0e39b166@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320192718.6d90a5a10476626f0e39b166@linux-foundation.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 20, 2020 at 07:27:18PM -0700, Andrew Morton wrote:
> On Thu, 19 Mar 2020 22:28:19 -0700 Eric Biggers <ebiggers@kernel.org> wrote:
> 
> > It seems that people are relatively happy with this patch series now.
> > Andrew, will you be taking it through -mm?  I don't see any better place.
> 
> Yup.

Andrew, can you update -mm to v4 of this patchset?  Right now it contains a mix
of v2 and v3.  In particular the diff for "docs: admin-guide: document the
kernel.modprobe sysctl" is different, and I made some small updates to commit
messages.

- Eric
