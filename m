Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD64239FBD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jun 2019 14:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfFHMzm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Jun 2019 08:55:42 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34907 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbfFHMzm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Jun 2019 08:55:42 -0400
Received: by mail-wm1-f67.google.com with SMTP id c6so4283762wml.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 Jun 2019 05:55:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JehieNv3Z3JAn33NF7oRPkax/e43lw8MBqlUfaxV85Y=;
        b=ixMcI459EeDBmVpq+b3mugMK7s0l9VfHQeDa5hR1oGejk+ZUc+RNovGDG6z7YjDbxK
         9w7Am9ymwkhPlaQoe8Ld/i/LlUYthCnqFzuz8QGwFcLbgu/oKW9+IV9BEVzxOa+wEma4
         FSDX6Sv7pNBhvIEOeiVOgEq5CcVqmrsiCfxGO9rdZPtVLko3CpBnKjJ+Ohi6sqvSVmdt
         3HXmnu3l4pp20FIyOch/9ACit4VjcH5agAn2FbOTnsUoHJeB38DIJhad3GK5/pza3uVK
         aHyeWV/xEYGKfuR6Sz65iJ5v548E9yXhcqGBV3tcwm5WKJ6p5s9vzryY8t9n4updtwy8
         Cbfw==
X-Gm-Message-State: APjAAAUeP/P8L1ccdNvcyaK/vJyfydmRWm3w+ZeW4tM9fTgRpKJay4M8
        /duRFuEmHbGjYnMtySVoaFqKVm4oA9A=
X-Google-Smtp-Source: APXvYqyCcFUx+bD287gAh7i1h9gAi1gk07G0XeCLNrgQ/dGExl6Txh8HXrUh+QsBjxQqoNv8NHpZIw==
X-Received: by 2002:a1c:6585:: with SMTP id z127mr7657708wmb.25.1559998539935;
        Sat, 08 Jun 2019 05:55:39 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id o4sm4067783wmh.35.2019.06.08.05.55.39
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 05:55:39 -0700 (PDT)
Subject: Re: [PATCH v12 0/1] fs: Add VirtualBox guest shared folder (vboxsf)
 support
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org
References: <20190608125144.8875-1-hdegoede@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <78489261-c9d5-5eee-1583-a016d10d745d@redhat.com>
Date:   Sat, 8 Jun 2019 14:55:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190608125144.8875-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 08-06-19 14:51, Hans de Goede wrote:
> Hello Everyone,
> 
> Here is the 12th version of my cleaned-up / refactored version of the
> VirtualBox shared-folder VFS driver.
> 
> This version hopefully addresses all issues pointed out in David Howell's
> review of v11 (thank you for the review David):
> 
> Changes in v12:
> -Move make_kuid / make_kgid calls to option parsing time and add
>   uid_valid / gid_valid checks.
> -In init_fs_context call current_uid_gid() to init uid and gid
> -Validate dmode, fmode, dmask and fmask options during option parsing
> -Use correct types for various mount option variables (kuid_t, kgid_t, umode_t)
> -Some small coding-style tweaks
> 
> For changes in older versions see the change log in the patch.
> 
> This version has been used by several distributions (arch, Fedora) for a
> while now, so hopefully we can get this upstream soonish, please review.

Hmm, a space which does not belong there has snuck in at the start of super.c
line 151:

         /* Load nls if not utf8 */

Sorry about that, I will fix this in the next version.

Regards,

hans
