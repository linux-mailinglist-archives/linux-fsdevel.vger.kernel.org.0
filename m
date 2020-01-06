Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 554E31312AF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2020 14:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgAFNRW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jan 2020 08:17:22 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34811 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbgAFNRW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jan 2020 08:17:22 -0500
Received: by mail-wr1-f68.google.com with SMTP id t2so49554181wrr.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jan 2020 05:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FR/KySs86ffBpbHH+kpMl4ePalFaMSRboiPIel9rYrI=;
        b=w0ppQOyxa9BpzzUmN9s31SbUIxxKvXZjxngFTwTH+s32uOaLCPYjI/iHVnLLcWlMSj
         yyjUqXbbtGQxjoFWSn+ep7gJJ1grJgq/J5VOaiPeHf+usEwXYKp9d0xdtjoloz777RY+
         MUWECSR/Oz2K/azWLZm6hQla6gYy/D4RHlOo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FR/KySs86ffBpbHH+kpMl4ePalFaMSRboiPIel9rYrI=;
        b=sS5r8coEsNruIIDce1xsHUJ/l33kJXEMJRh/sdETu5tscMpckGDOZ+jIZ6vwkzwKGa
         289aJS4wpmhez4cEImJ346sBDu7DuUlpCgM1DWxT7oyMltYn6U2y4Wg0MgQLHgluK2sy
         ifgTQxunD73Hqq0rFOPPbCNzSU4eVfyitRYyctoitU4IFAp5MVBe4a/En3Wid1TXAFAq
         FjLd9OPij8hMS3Hndo3mtMG3jNOG0l4h8yfeQN7mK5gHCb+8pH7IgclfSvZwPlOFNKKb
         fNuxEa4GDAZoU8P6Hnkxn/L7lgmpit2kwXUFr0ADnn371diwzWowzLh3mPypKIhrgQ49
         kZ2Q==
X-Gm-Message-State: APjAAAUqqIvROt6ZpIozL2KDtL+tknbfN/7Hmr7EYJxlWnNxUtXuf6FD
        l59k/ape08eCOP/CmDSB1p8kvQ==
X-Google-Smtp-Source: APXvYqwydYsFcx/lAJEweADm0F8TYKxbw+Ktk9jZs3fwgCWfVmUr7KAwfkYV5CH+hA+r33UHztVEEw==
X-Received: by 2002:a5d:6441:: with SMTP id d1mr103180769wrw.93.1578316640253;
        Mon, 06 Jan 2020 05:17:20 -0800 (PST)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
        by smtp.gmail.com with ESMTPSA id o4sm70942309wrx.25.2020.01.06.05.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 05:17:19 -0800 (PST)
Date:   Mon, 6 Jan 2020 13:17:19 +0000
From:   Chris Down <chris@chrisdown.name>
To:     "zhengbin (A)" <zhengbin13@huawei.com>
Cc:     linux-mm@kvack.org, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 1/2] tmpfs: Add per-superblock i_ino support
Message-ID: <20200106131719.GB361303@chrisdown.name>
References: <cover.1578225806.git.chris@chrisdown.name>
 <91b4ed6727712cb6d426cf60c740fe2f473f7638.1578225806.git.chris@chrisdown.name>
 <4106bf3f-5c99-77a4-717e-10a0ffa6a3fa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <4106bf3f-5c99-77a4-717e-10a0ffa6a3fa@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

zhengbin (A) writes:
>Use spin_lock will affect performance

"Performance" isn't a binary. In discussions, you should avoid invoking the 
performance boogeyman without presenting any real-world data. :-)

We already have to take this spin lock before when setting the free inode 
count. The two sites can be merged, but it seems unnecessary to conflate their 
purpose at this time.
