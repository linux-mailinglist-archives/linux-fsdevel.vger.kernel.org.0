Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21F958921D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Aug 2019 17:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfHKPHc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Aug 2019 11:07:32 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48780 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbfHKPHc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Aug 2019 11:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YTsKJqq2wUXkpfMIFp/5oZ3lJcMC4RqIqdLLYb/+7HY=; b=m4P923SNqw3Oj+btPzeF8xXxHW
        8UW7HQ24RJL1nOO7dn3Vkb9vX1+cXtl9TR6eoazWE0xBCDl6AzWc/9uVAyfn5ZNwEIn/68GIrqSu5
        heecoNWgMapddK0Hvq7FOQK+RtnHGgB5X+CXPLNV9lGTqqGIkSdhcns94cFfeUR3DofU/MyWSE16p
        DkyBHe+++TnfTSARgdoreO5j6wKfZYdIFHclSdRx2tHKVOk9GGSy9M/jOnvqz50ploZex3nN8mxF/
        vueXTqOYob9Ie2wKqJMuLyxBp3Hv9cRNXDv5uLe1ZySDMhClyXUwnzFfeD3ilfa7pcQ43lRDnOxVf
        TgVVowKw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=[192.168.1.17])
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hwpRN-0004qN-Si; Sun, 11 Aug 2019 15:07:26 +0000
Subject: Re: [PATCH v12 resend 0/1] fs: Add VirtualBox guest shared folder
 (vboxsf)
To:     Hans de Goede <hdegoede@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org
References: <20190811133852.5173-1-hdegoede@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8277d9de-4709-df2d-f930-d324c5764871@infradead.org>
Date:   Sun, 11 Aug 2019 08:07:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190811133852.5173-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/11/19 6:38 AM, Hans de Goede wrote:
> Hello Everyone,
> 
> Here is a resend of the 12th version of my cleaned-up / refactored version
> of the VirtualBox shared-folder VFS driver. It seems that for some reason
> only the cover letter of my initial-posting of v12 has made it to the list.
> 
> This version hopefully addresses all issues pointed out in David Howell's
> review of v11 (thank you for the review David):
> 
> Changes in v12:
> -Move make_kuid / make_kgid calls to option parsing time and add
>  uid_valid / gid_valid checks.
> -In init_fs_context call current_uid_gid() to init uid and gid
> -Validate dmode, fmode, dmask and fmask options during option parsing
> -Use correct types for various mount option variables (kuid_t, kgid_t, umode_t)
> -Some small coding-style tweaks
> 
> For changes in older versions see the change log in the patch.
> 
> This version has been used by several distributions (arch, Fedora) for a
> while now, so hopefully we can get this upstream soonish, please review.

Hi,
Still looks like patch 1/1 is not hitting the mailing list.
How large is it?

-- 
~Randy
