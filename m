Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8F35EDDAA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 15:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbiI1Nak (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 09:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiI1Naj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 09:30:39 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EB87F0AE;
        Wed, 28 Sep 2022 06:30:38 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id ay36so8551538wmb.0;
        Wed, 28 Sep 2022 06:30:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=+sTNVvjAkH/cc42ksDDWX4JcTFewSmG92wxhIKzNCOw=;
        b=ymlvR/1Poa7l4Gd60xdj4tc+pbIhI6olm6OwSh/W/0vGkwjFaO5L/76VTykre2sIO/
         5ts7jtcI+7ZjOtexSqT4LvRjLGS6MxAGV5VcLoGZMkL9RPp6jt0ML580dtIGHYrga6Pa
         D7ZwzYkztD+/VoB/RcVNcV/I7sanJ3/aDebbRxE5XcGXyO5MFDTrF+lkmHtYFnAhmrNG
         zH8BmT7Druc8SKWcdWWj20jJL917dngfwccb6fMzPnVv9WlZeoTAmd2eAuNYoghR42jy
         3NyedyFS6YwqSTnBeGk5BakiZiDepZqITYc+iPyWGw4/HqSBqCgAw1sCFa3OXV2CefnG
         6c2A==
X-Gm-Message-State: ACrzQf3thNje5ekM9TS9tRS9j2Lqo7yQqftVtSnGPOBTfD1owDqZhPjb
        kxG0QrvEyZA7mtr5GHCL3uE=
X-Google-Smtp-Source: AMsMyM5sKVbrsBg9zQltOPbN1k4kA+TZOqFtvyPUIpHcZCJxYl/jIoQPVGq8bmzIoLwzqnN+bjzPHw==
X-Received: by 2002:a05:600c:458d:b0:3b5:6e85:7094 with SMTP id r13-20020a05600c458d00b003b56e857094mr509671wmo.38.1664371836877;
        Wed, 28 Sep 2022 06:30:36 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id q10-20020a1cf30a000000b003b47575d304sm2041755wmq.32.2022.09.28.06.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 06:30:36 -0700 (PDT)
Date:   Wed, 28 Sep 2022 13:30:34 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v10 22/27] rust: add `.rustfmt.toml`
Message-ID: <YzRMeuVzij17qcVn@liuwe-devbox-debian-v2>
References: <20220927131518.30000-1-ojeda@kernel.org>
 <20220927131518.30000-23-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927131518.30000-23-ojeda@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 27, 2022 at 03:14:53PM +0200, Miguel Ojeda wrote:
> This is the configuration file for the `rustfmt` tool.
> 
> `rustfmt` is a tool for formatting Rust code according to style guidelines.
> It is very commonly used across Rust projects.
> 
> The default configuration options are used.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
> Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Wei Liu <wei.liu@kernel.org>
