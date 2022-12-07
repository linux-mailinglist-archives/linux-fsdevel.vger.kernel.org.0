Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F110645EA7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Dec 2022 17:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiLGQWy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Dec 2022 11:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiLGQWv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Dec 2022 11:22:51 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E801D25C49
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Dec 2022 08:22:47 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id i83so5678334ioa.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Dec 2022 08:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bn9I9xV79fJUCgoxsa3ub+uGmmlj3Tv0J26ZcN9So2c=;
        b=oktSzxAShr3BHoD72bP4RFPVPK2PQ9754FcMwUZLSN4JtDJnGYSSmZWOGHv94kk8p2
         hRwss1tlAVG7p8Av2GnMo81SayC6jYcGxuvgfQjOmrGY3anuIuUmHTnrOwK4bjFlrHLH
         8X2zXyi3q6BymHi1hN9CxD5+hoxVUb4cv+kVB+LerzeBetWY4WfSZ5+f327qAreMbIrn
         68t4pMOeqqBpF9HLmnL9+4GnvtxCjB6tGckAQYSJQEdBSt77fS7PfaRqOq6S74eXp1OI
         HyGz4pZzTJh8yNYLubKPUaRkK+fiekioy/q9ElL9E6hHGOMvjaC1n0ZrZ+A9RVFAaNNK
         rmtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bn9I9xV79fJUCgoxsa3ub+uGmmlj3Tv0J26ZcN9So2c=;
        b=PcAP4bvcW38hQv+zmVsmo5bpuUcp/WYeGQeG8RvTq/FXrrqIj31R/DDvTF38+J+oxZ
         9DVzTQnIj2b2lJ/y4w1QAGET+c0MkuZaYY9uI++w77FQ5hVjg4iQmrz5BteK59S0d/Va
         QQP+TXvyP/B6gMhtsdmA4QBGz2qFc3exBh+2tlkm9gss9F4CZdzWUayI/2R5dchc26o2
         uAgy/bHyuqI23VCOdWxVHNYJRETv/jgUAhGjacIDMHQf81YUdCH89kEMcTZqlx4nH7C9
         YC7CE+TP0eDuyiMEsWZ2NXgT2tQ3rCClolvuXCfGLEFEpjVbetKHzhVCjpUn1+AHHd9D
         d4sg==
X-Gm-Message-State: ANoB5plF90KA+DWVaEpjtbXtgOLAAFzi4LmViNOWudT9gOzk+hpDQORX
        U7EADW9Nqf1DyOIz/8qAqmjIkQ==
X-Google-Smtp-Source: AA0mqf4ybGl8vC1UVIEO3y/JfQbgJP/6fnnH7vd2PgBXxTLGzha4ra0sC3Q2OFIDuj9XNhFK1cMt4Q==
X-Received: by 2002:a02:334d:0:b0:376:22fe:5e7c with SMTP id k13-20020a02334d000000b0037622fe5e7cmr43131407jak.126.1670430167275;
        Wed, 07 Dec 2022 08:22:47 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id p12-20020a056e0206cc00b00302f958e71dsm7202366ils.49.2022.12.07.08.22.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 08:22:46 -0800 (PST)
Message-ID: <b7d8193c-7e15-f5cd-08d4-8ef788d9bb36@kernel.dk>
Date:   Wed, 7 Dec 2022 09:22:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: next: LTP: syscalls: epoll_clt() if fd is an invalid fd expected
 EBADF: EINVAL (22)
Content-Language: en-US
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, regressions@lists.linux.dev,
        lkft-triage@lists.linaro.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, chrubis <chrubis@suse.cz>
References: <CA+G9fYv_UU+oVUbd8Mzt8FkXscenX2kikRSCZ7DPXif9i5erNg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CA+G9fYv_UU+oVUbd8Mzt8FkXscenX2kikRSCZ7DPXif9i5erNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/7/22 8:58?AM, Naresh Kamboju wrote:
> LTP syscalls epoll_ctl02 is failing on Linux next master.
> The reported problem is always reproducible and starts from next-20221205.
> 
> GOOD tag: next-20221202
> BAD tag: next-20221205
> 
> tst_test.c:1524: TINFO: Timeout per run is 0h 05m 00s
> epoll_ctl02.c:87: TPASS: epoll_clt(...) if epfd is an invalid fd : EBADF (9)
> epoll_ctl02.c:87: TPASS: epoll_clt(...) if fd does not support epoll : EPERM (1)
> epoll_ctl02.c:87: TFAIL: epoll_clt(...) if fd is an invalid fd
> expected EBADF: EINVAL (22)
> epoll_ctl02.c:87: TPASS: epoll_clt(...) if op is not supported : EINVAL (22)
> epoll_ctl02.c:87: TPASS: epoll_clt(...) if fd is the same as epfd : EINVAL (22)
> epoll_ctl02.c:87: TPASS: epoll_clt(...) if events is NULL : EFAULT (14)
> epoll_ctl02.c:87: TPASS: epoll_clt(...) if fd is not registered with
> EPOLL_CTL_DEL : ENOENT (2)
> epoll_ctl02.c:87: TPASS: epoll_clt(...) if fd is not registered with
> EPOLL_CTL_MOD : ENOENT (2)
> epoll_ctl02.c:87: TPASS: epoll_clt(...) if fd is already registered
> with EPOLL_CTL_ADD : EEXIST (17)

This should fix it:


diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index ec7ffce8265a..de9c551e1993 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2195,6 +2195,7 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 	}
 
 	/* Get the "struct file *" for the target file */
+	error = -EBADF;
 	tf = fdget(fd);
 	if (!tf.file)
 		goto error_fput;

-- 
Jens Axboe
