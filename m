Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72D2D60C95
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2019 22:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbfGEUpk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jul 2019 16:45:40 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36285 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfGEUpk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jul 2019 16:45:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id l21so755599pgm.3;
        Fri, 05 Jul 2019 13:45:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NINMgNCtdp9VxxGck6fqsoIqX8vCQf36P/6C5pYBqDM=;
        b=YQepM3QfaLPrt38a06JLOG8+Sq+RthHTJT8ayAHe+a2sZFbhJHR0vrzdfGuv3uIS6g
         LgSaqxZx8w3LOZ5d2xXa+wI8ODSGZw1ljVBMPgII5DuXYA09vvGrXrMEpPCkCC1Ro2wn
         nElxs1KnW40X3XGGibm8ejsU+PtMo+8XY41bMdnUg49KaU9A250siGSFXlpnjF99wM7S
         DJNenFTGXfHVNJcNSR1yrlwDcD5GgA6y5c9BobIy1E7ozvKxw7+3JrAJARmHRJvBu+Ar
         TtDz4w1XK4PSEsDyURA6pi6BiSQ8xLgh/Lr4iOFpqvNhWSpCPXNr3QH2c7x8uw6r+O5g
         pWSw==
X-Gm-Message-State: APjAAAXD0rjwvWEAnJeescaKlWUENqU8iF4mYe6KY8/+IOJofpCcNGHK
        gy34Hj/LyjZfOVKpRsnUTCs=
X-Google-Smtp-Source: APXvYqzORz85r9dXJ+0VShptntCI2Ba5VbMOY6v1/mI3RdkuGvkVnROUEZV4rccMgxpa1+keGNumHQ==
X-Received: by 2002:a17:90a:d58c:: with SMTP id v12mr89451pju.7.1562359539502;
        Fri, 05 Jul 2019 13:45:39 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id b17sm14479029pgj.73.2019.07.05.13.45.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 13:45:38 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 9D53F40190; Fri,  5 Jul 2019 20:45:37 +0000 (UTC)
Date:   Fri, 5 Jul 2019 20:45:37 +0000
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
Subject: Re: [PATCH v6 02/18] kunit: test: add test resource management API
Message-ID: <20190705204537.GC19023@42.do-not-panic.com>
References: <20190704003615.204860-1-brendanhiggins@google.com>
 <20190704003615.204860-3-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704003615.204860-3-brendanhiggins@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 03, 2019 at 05:35:59PM -0700, Brendan Higgins wrote:
> diff --git a/kunit/test.c b/kunit/test.c
> index c030ba5a43e40..a70fbe449e922 100644
> --- a/kunit/test.c
> +++ b/kunit/test.c
> @@ -122,7 +122,8 @@ static void kunit_print_test_case_ok_not_ok(struct kunit_case *test_case,
>  
>  void kunit_init_test(struct kunit *test, const char *name)
>  {
> -	spin_lock_init(&test->lock);

Once you re-spin, this above line should be removed.

> +	mutex_init(&test->lock);
> +	INIT_LIST_HEAD(&test->resources);
>  	test->name = name;
>  	test->success = true;
>  }

  Luis
