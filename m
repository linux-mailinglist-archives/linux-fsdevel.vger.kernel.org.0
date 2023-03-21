Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778456C3462
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 15:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjCUOhR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 10:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjCUOhP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:37:15 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2884DBFD;
        Tue, 21 Mar 2023 07:37:14 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id eh3so60503145edb.11;
        Tue, 21 Mar 2023 07:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679409433;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iHEqN7BarmB0XfV9NF5gycuaqpBq0s3WoFUcLxi5+4k=;
        b=VGvMDHg7IAZVxzH2gfoNgMSOji5IfjSe5JCEZiAbT7Ro12HxXutcQs3nrUqMrmZaQa
         YTjVp2EgGLLiDw6JuPaXagf+kufzeJNwYYYLUs0fk7VA/aD/pax06JOC2gsjHDAXPntV
         cfNRwERJFhpsYBbF/Vwvjh6s34xtgWvWcko31v4S0Oeqwq2N2NzgoJ1Fye42plrr2Ypj
         nGtABjWvI/3YVwzxii7IzcVFIXGMfK9v4SXSrlFLf1g09Ka+U3qKrVzH5PffZpj3N+5v
         M/ZbS6B/UiQpB1a392GUZonq7hdTT+iANRtaXP+0pfqFy7Hi88K244RqT7o2MTOOdBxR
         bEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679409433;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iHEqN7BarmB0XfV9NF5gycuaqpBq0s3WoFUcLxi5+4k=;
        b=FNhMuE8NoUGkJ37xEev8Kxn7OdjrKXArWu2zNlcwrP+OJRtwN9R2iuq+BRJ0WgJLb3
         +SxD5ninrj7MfKlBidMCe+QZFFLq23HttZ/DYbktJEX4O+vCqZQNRyrb7E/QNImt0PYj
         uHbVhJdhS1/hLr4NZ1LIDmB23SBrLwc8glo82PhQTiE1vy4Cb9d3woFO8lPcF7TcMbDy
         v550RXWo+d89nKIEqwnfQfRglvKA8q00JVABA7FwIbjQC944birCinBFo0MSdDldAmMu
         uAsMMLSd/0Q7fXirkUOXgJxkCTFIBW74KTuk7Yw5fCAjvikWGA6wWWocpT1QwKqXK9+x
         9FlA==
X-Gm-Message-State: AO0yUKXE3dZh2B549QvAFveaVJWvJra6RCzWrmLVOxc96q4SVnTOnaHu
        ZNu2apl4kI9PgP3goZ0tTg==
X-Google-Smtp-Source: AK7set/uV6swtI6Cha2IBxu6FSeT/CGJESekpZ8We0l6hTyn2lZuhQ5yhr67rv0UD8ZpLfE8F26Xvw==
X-Received: by 2002:a17:906:2e8e:b0:933:44ef:e5b5 with SMTP id o14-20020a1709062e8e00b0093344efe5b5mr3716363eji.30.1679409432985;
        Tue, 21 Mar 2023 07:37:12 -0700 (PDT)
Received: from p183 ([46.53.248.97])
        by smtp.gmail.com with ESMTPSA id f3-20020a17090624c300b0092a59ee224csm5828944ejb.185.2023.03.21.07.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 07:37:12 -0700 (PDT)
Date:   Tue, 21 Mar 2023 17:37:10 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     brauner@kernel.org, frank.li@vivo.com
Cc:     mcgrof@kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] fs/drop_caches: move drop_caches sysctls into its own
 file
Message-ID: <226a6fc1-f6f4-4972-b76e-774094ffb821@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > +static struct ctl_table drop_caches_table[] = {
> > +	{
> > +		.procname	= "drop_caches",
> > +		.data		= &sysctl_drop_caches,
> > +		.maxlen		= sizeof(int),
> > +		.mode		= 0200,
> > +		.proc_handler	= drop_caches_sysctl_handler,
> > +		.extra1		= SYSCTL_ONE,
> > +		.extra2		= SYSCTL_FOUR,
> > +	},
> > +	{}
> > +};
> > +
> > +static int __init drop_cache_init(void)
> > +{
> > +	register_sysctl_init("vm", drop_caches_table);
> 
> Does this belong under mm/ or fs/?
> And is it intended to be moved into a completely separate file?
> Feels abit wasteful for 20 lines of code...

It is better to keep all sysctls in one preallocated structure
for memory reasons:

	header = kzalloc(sizeof(struct ctl_table_header) +
                         sizeof(struct ctl_node)*nr_entries, GFP_KERNEL_ACCOUNT);
