Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1F9661CE4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 04:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236204AbjAIDtr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Jan 2023 22:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236108AbjAIDth (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Jan 2023 22:49:37 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0408011445
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 Jan 2023 19:49:36 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id g16so8156592plq.12
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Jan 2023 19:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KP691JFoFX0F9mveORmXODQf26CLdeHZBmwv8xyQAK4=;
        b=NKsNbgg8wksBTkZA9izhAmGudq3SmRArU6MnD4q6AvxhNbdbEwaVAJIsqrxO+1H4Rs
         Y3exk+A6aNMAFitufjcpUqS7scx8AUaJWK4L1JPRqro5B6yWDE23LAsby3dCacOv3CHw
         RRsz8Jun5oxlhTeH7dNjxbGo0EGOArhSqpeC1ZXusSx0X6cpSGd3gXBjMbWS5sHK3gOq
         X7ipV5HabAtO9ScPChsqUwls0yO6vpl1iqnoZ+eVQuo7QAHCaHHXC6rWU4qMwjmXMDD3
         cdpABbOsWBUIJ/yd/Q2WFAe+autl8rYIabU9HCaYgMTLPeQeYmsf6fjDGF4B0uVnK1ar
         JdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KP691JFoFX0F9mveORmXODQf26CLdeHZBmwv8xyQAK4=;
        b=kbCnSduTUpHwtmtMZQA72Zr20fmmPLdZxo5Po1xehVqr9feC7q45Y1QjgXyA/kLba4
         VPMq9HOjfJOCi893uVGcEjSMQq+TFIuJjP4ls2tcnRFwyx6sFFVvqNzmO/p8L3UQxkjN
         pcV0opaEXMiMrioBQrPLL7/Lnn8XauGLjJF8PCHFbgLc++nYfOEkZkN+mJn2m565BNFX
         PTLA4yWuUq+mPgBzelNucre/5RZQYiaxh86qjTDIH/bPG61aK4BQoOz0nF8jRy6GkeJn
         +o/UgHfRgmKvOpeYfHMGShthKM1N5vxqul5Hd7O2ui8dB7Znb/OLn2E0QwR3BwAWn0iP
         O9zw==
X-Gm-Message-State: AFqh2kpzTizg7jdefOan8HJa7koxFL2iOPdD6hZDXLVybN+Y0/0FfyTP
        Xn6v4bjZoge1qH2Kjq3YjoVRZQ==
X-Google-Smtp-Source: AMrXdXvyRJwqKDgZCDuZ6jAXItL4F2pZpF0BzEckjsAGNoNIPaBgXmEAP/wdvWmCLDP+ZAakP42bMw==
X-Received: by 2002:a17:902:b08f:b0:193:2a8c:28c7 with SMTP id p15-20020a170902b08f00b001932a8c28c7mr926386plr.5.1673236175471;
        Sun, 08 Jan 2023 19:49:35 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s6-20020a170902ea0600b001913c5fc051sm4819955plg.274.2023.01.08.19.49.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jan 2023 19:49:35 -0800 (PST)
Message-ID: <92fb9521-9ae6-d43c-71a4-cc1b2e6e8c62@kernel.dk>
Date:   Sun, 8 Jan 2023 20:49:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCHv2 02/12] io_uring: switch network send/recv to ITER_UBUF
Content-Language: en-US
To:     Keith Busch <kbusch@meta.com>, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-aio@kvack.org, linux-fsdevel@vger.kernel.org, hch@lst.de,
        io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, davem@davemloft.net,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Paul Moore <paul@paul-moore.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        netdev@vger.kernel.org, Keith Busch <kbusch@kernel.org>
References: <20230105190741.2405013-1-kbusch@meta.com>
 <20230105190741.2405013-3-kbusch@meta.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230105190741.2405013-3-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/5/23 12:07 PM, Keith Busch wrote:
> From: Jens Axboe <axboe@kernel.dk>
> 
> This is more efficient that iter_iov.

Looks like that s/that/than typo ended up in a few spots throughout
this series... Nothing major, but figured I'd bring it up.

-- 
Jens Axboe


