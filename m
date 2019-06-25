Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49DE855ABE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2019 00:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfFYWNW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 18:13:22 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43048 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfFYWNW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 18:13:22 -0400
Received: by mail-pg1-f194.google.com with SMTP id f25so112770pgv.10;
        Tue, 25 Jun 2019 15:13:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8gzPjoJjuhl8UL7VUOkU3jqXACXyJKi+qh78CzG1deI=;
        b=QoeUWtoXykCX+Bq53a7A9bl2m/QOc95LCrsFNc/FWV8IUOqhYzou5SH/2BbNSr/pGt
         TFFWVbvaDRX3tyClX1+NQ+wo0YVmPKQ8jC9K+I+5OgjfsC/NL7MBsm7uLpbx1lBgivFC
         YndY34vehKuD1a63b0CbdGf5Y+BEbwNVWx+vzHt5SMPTTz1+RZRgKfaYMEO++NInpPnj
         W9bh9+1AAAclOUzyFR4bpHiPX60/c1yeRY4QJw5ZlU5yFKZgR34Q/oCHbEVxDDcO53Zj
         AngIY4/iLj1p6IBC1MKsZPExsciJh5QjgQDyMhIkn5rY5k71jPikZEQS9KLWBXrfG/fh
         w4HQ==
X-Gm-Message-State: APjAAAU01WyKGR61McyR5fW2lM44tHAZlgvfVxCYWTRImrLOOFEM3cso
        /Az2SrYL9bU24yifMM/2Gzs=
X-Google-Smtp-Source: APXvYqxWuXRncraTED2jeacoTPyN1fvtJGk3Zc52FbqH3XACtitgQolZjqrTP/UYKEopxq0KXI3bTw==
X-Received: by 2002:a63:480e:: with SMTP id v14mr1871131pga.182.1561500800857;
        Tue, 25 Jun 2019 15:13:20 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id x3sm45355pja.7.2019.06.25.15.13.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 15:13:19 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id D102E401EB; Tue, 25 Jun 2019 22:13:18 +0000 (UTC)
Date:   Tue, 25 Jun 2019 22:13:18 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, peterz@infradead.org,
        robh@kernel.org, sboyd@kernel.org, shuah@kernel.org, tytso@mit.edu,
        yamada.masahiro@socionext.com, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-um@lists.infradead.org, Alexander.Levin@microsoft.com,
        Tim.Bird@sony.com, amir73il@gmail.com, dan.carpenter@oracle.com,
        daniel@ffwll.ch, jdike@addtoit.com, joel@jms.id.au,
        julia.lawall@lip6.fr, khilman@baylibre.com, knut.omang@oracle.com,
        logang@deltatee.com, mpe@ellerman.id.au, pmladek@suse.com,
        rdunlap@infradead.org, richard@nod.at, rientjes@google.com,
        rostedt@goodmis.org, wfg@linux.intel.com
Subject: Re: [PATCH v5 06/18] kbuild: enable building KUnit
Message-ID: <20190625221318.GO19023@42.do-not-panic.com>
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-7-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617082613.109131-7-brendanhiggins@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 17, 2019 at 01:26:01AM -0700, Brendan Higgins wrote:
> diff --git a/Kconfig b/Kconfig
> index 48a80beab6853..10428501edb78 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -30,3 +30,5 @@ source "crypto/Kconfig"
>  source "lib/Kconfig"
>  
>  source "lib/Kconfig.debug"
> +
> +source "kunit/Kconfig"

This patch would break compilation as kunit/Kconfig is not introduced. This
would would also break bisectability on this commit. This change should
either be folded in to the next patch, or just be a separate patch after
the next one.

  Luis
