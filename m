Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE11933D480
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 14:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbhCPNBU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 09:01:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:49122 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233062AbhCPNBG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 09:01:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615899665; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iGCmVD2U24Jc1j3ZUlBFpOR+1PwTae5lOTW7wdWn/nc=;
        b=oYaYLy/onN6VQ0mbkpsp1XmAwm9kCvD+zdqURtQBChXqq8oq8Z/3QRzxuci6koCkt5weJh
        42yV3GSP1OrkEL884Joq8T7ImN8hcospcJfF80X3nu05JjPDfXjILOWg6Ct9fUURg1tXNa
        C01C1Uk+Q6swtn847u9auldBlksyGFI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D040EAC47;
        Tue, 16 Mar 2021 13:01:04 +0000 (UTC)
Date:   Tue, 16 Mar 2021 14:01:04 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Adam Nichols <adam@grimm-co.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] seq_file: Unconditionally use vmalloc for buffer
Message-ID: <YFCsEGpi6Et3Bu3B@dhcp22.suse.cz>
References: <20210315174851.622228-1-keescook@chromium.org>
 <YE+oZkSVNyaONMd9@zeniv-ca.linux.org.uk>
 <202103151336.78360DB34D@keescook>
 <YFBdQmT64c+2uBRI@kroah.com>
 <YFCn4ERBMGoqxvUU@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFCn4ERBMGoqxvUU@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 16-03-21 12:43:12, Al Viro wrote:
[...]
> AFAICS, Kees wants to protect against ->show() instances stomping beyond
> the page size.  What I don't get is what do you get from using seq_file
> if you insist on doing raw access to the buffer rather than using
> seq_printf() and friends.  What's the point?

I do not think there is any and as you have said in other response we
should really make seq_get_buf internal thing to seq_file and be done
with that. If there is a missing functionality that users workaround by
abusing seq_get_buf then it should be added into seq_file interface.
-- 
Michal Hocko
SUSE Labs
