Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B51A91C72
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2019 07:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfHSFY4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Aug 2019 01:24:56 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33050 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfHSFY4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Aug 2019 01:24:56 -0400
Received: by mail-pl1-f195.google.com with SMTP id go14so400038plb.0;
        Sun, 18 Aug 2019 22:24:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jJIL7ZjMvEAXgkP5fpUb5bzT40PMMs5wbkqwkuRSbyA=;
        b=ofvCyGWaeqMbjzCEkxeVZC194+HUsF2nOmhXk6rZWpOVZgNt5cWTCIKS0buQd8TPKY
         Tziq9zjMRIEN0bC5K37+CFnAuEAFqgQGfLePwFzSD7laFHBDa/QByJipgaIf9IECzV0q
         Mflc+x+0y3TvGFbi429kRuxrekgr+KJ4v5Hg3NF81IhbmnYVJ+In67vkxgDpRzlKaR9P
         JvaMwJZSViVGn4GN4HLJCwuUtzfVj5WXCFaly8Xym2bvWGAqzG0YDcb5CFq5KzbEqWro
         wdXOviAnIVGAcxLWER6jVp+6C0zkmfGVv+r+Q6MqBBFDFbxrHrilwF0rAchkiaFIydhC
         yXcA==
X-Gm-Message-State: APjAAAWTHNeqzqu6u9EL3o72HqeuVcYEgiGY0sr/fFXM05KVNJWj3zHV
        Db07My2LZUUrkgPpzT/YdGo=
X-Google-Smtp-Source: APXvYqzUfydWekfy7TcYfFHF7XWgwiaFZjIivUt1eh2YYc9aTfrcr1GqE0azHZUydyPyMr0Oc4MqFA==
X-Received: by 2002:a17:902:9b94:: with SMTP id y20mr20871503plp.260.1566192295558;
        Sun, 18 Aug 2019 22:24:55 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id x16sm150500pff.99.2019.08.18.22.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 22:24:54 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id F25F740605; Mon, 19 Aug 2019 05:24:53 +0000 (UTC)
Date:   Mon, 19 Aug 2019 05:24:53 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/3] selftest: firmware: Add request_firmware_into_buf
 tests
Message-ID: <20190819052453.GQ16384@42.do-not-panic.com>
References: <20190816000945.29810-1-scott.branden@broadcom.com>
 <20190816000945.29810-3-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816000945.29810-3-scott.branden@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 15, 2019 at 05:09:44PM -0700, Scott Branden wrote:
> Add tests cases for checking request_firmware_into_buf api.
> API was introduced into kernel with no testing present previously.
> 
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
