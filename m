Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0726733C7B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 21:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbhCOUZd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 16:25:33 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:55872 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbhCOUZL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 16:25:11 -0400
Received: by mail-pj1-f41.google.com with SMTP id bt4so9428299pjb.5;
        Mon, 15 Mar 2021 13:25:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X98UQbro7aMmeZHPX6dU+ByuOhafClQ6kyEYLKaULEE=;
        b=Ml205NcaoUINx3y8V2nMlvlMPtLRt4PRbqJZwgVRbxT/uchgGY/nawGAR7JPPaqZEy
         HmVg/vn3JEJ37tPG64jusZpZHhv7YG1DxRxjVJ0IA4s90R+REYAhsNQKW5GoaTtHBG/T
         SSYosGtdYgWuv/5WCj7PDCQ/NWJkP76pp9BWKAJqteYT6VK1sMzPXiuVZBiVxHNfxHk8
         U7IN6iIvrAqZujZyjKNc/Nee55nUCswaE0OKmoG9jlvj7qAik7Bm4qMnKf1iHFQm+/Mv
         eq5KRJgA/m12SeN8d/yUWDRlpW1f20cTigyrDVDc70YtCjqWz9NM71C2yEEGE/jB6wR/
         rsFg==
X-Gm-Message-State: AOAM532nI9U3y4fxGmW0YKlAoOWPy01nXsOaCeliQInCQNWVb1+t+tPv
        q27GWiO/F9fGli1CEd++xxPFVvcnYFu+Nw==
X-Google-Smtp-Source: ABdhPJyoqYMrxepLZ9Y/8aFZnhmESpYIrs2n3C2zImOGAuX5v9oEvE0iRCA78k1vAIFEqxTfqo/gbg==
X-Received: by 2002:a17:90a:2d88:: with SMTP id p8mr877292pjd.159.1615839910684;
        Mon, 15 Mar 2021 13:25:10 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id fh19sm471665pjb.33.2021.03.15.13.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 13:25:09 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id EAB1140106; Mon, 15 Mar 2021 20:25:08 +0000 (UTC)
Date:   Mon, 15 Mar 2021 20:25:08 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     zhouchuangao <zhouchuangao@vivo.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc/sysctl: Fix function name error in comments
Message-ID: <20210315202508.GD4332@42.do-not-panic.com>
References: <1615807194-79646-1-git-send-email-zhouchuangao@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615807194-79646-1-git-send-email-zhouchuangao@vivo.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 15, 2021 at 04:19:54AM -0700, zhouchuangao wrote:
> The function name should be modified to register_sysctl_paths instead
> of register_sysctl_table_path.
> 
> Signed-off-by: zhouchuangao <zhouchuangao@vivo.com>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
