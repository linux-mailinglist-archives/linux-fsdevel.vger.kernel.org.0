Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D539A2A83FC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Nov 2020 17:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731518AbgKEQuN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Nov 2020 11:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731508AbgKEQuM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Nov 2020 11:50:12 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15267C0613D2
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2020 08:50:11 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id r9so2473105ioo.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2020 08:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=LCPf3w7GcOJmMavuxhhy8i+MWkFz77vU9ZNMmXvF0yc=;
        b=VVR99qiiNqLDP9i/eEOA1EFzfdcblQnmRz2qyvWNKrGxDPcquvdkCgI8+n/9r7CS6t
         yRYsInxCLko0aWTyBGm3zxhukaV26969+cHrzdx+Ro4IyE1HgvD9Ier/eMvLlOnZLxUq
         QMWzMjGcevlzjPbbkoubZ5AYtNhlCW3NQ5fpXqqlGoz1wuAzRM1IpdfTMAP53dNJbgVP
         cmv6RNSDLi/tFBz8FPNu+sf1TCkiLa9PpTr//p5JS0AMct7dJvi10TBpgMVwesx3jrpX
         QfU6tzIph3ojSh3gtXVUAdvsnptE0iKFN88PAxKYgrMfUFfOTQOyagMuW9JfuxlygUiQ
         pigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LCPf3w7GcOJmMavuxhhy8i+MWkFz77vU9ZNMmXvF0yc=;
        b=Pwt3p2xZSyVOglp1MaUAxEx2DV7KKP4Zmlygbl6tQ4jEHsU0/48CVCGFEVTPh3sMwJ
         F0mQWZB3Jdt505gLExhK5q4Nqgl5DSP3qxRj9W//MVk7i2mHFKNiqhS1PPSfPd6NAoXh
         kCzE98IAU9yTcGLiTFjkIPEd62RHgPOKiS4OY3mcHtTxozATtnyyJvSLfY9sgn6d1sNA
         g9ffY/aix6KKtuBEVNRq6//K9uPj0Sk/qEhcGF3Uyu9R2oz4pdkJbaY4X6GWbiq7Eusy
         bl+cehVAk2pr0V23Eh7pdSpuroKxOgU3YV522C1BLHYC/AZqkmjINbjIzGjvmu1uJOkM
         7agQ==
X-Gm-Message-State: AOAM532mRw6geGcYX/0YKHBBnu1PbJS5Pl5XPdoIYcX1QmBJh7B0/k0v
        tPOIcnnovjauhZ5lDpd9Z1AuZw==
X-Google-Smtp-Source: ABdhPJwR5k6COpqIu/RRBRupJZMcuya3aOjwRNFTRQkwFJHvEFeDIcg+W1mNgVdxhTeIc/v53THTBA==
X-Received: by 2002:a05:6602:2d4e:: with SMTP id d14mr2414322iow.105.1604595010463;
        Thu, 05 Nov 2020 08:50:10 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v15sm1487038ile.37.2020.11.05.08.50.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 08:50:10 -0800 (PST)
Subject: Re: KASAN: use-after-free Read in io_uring_show_cred
To:     syzbot <syzbot+65731228192d0cafab77@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <0000000000003698a305b35e63fb@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3588ce0a-46cd-91dd-79eb-6ecc13496e53@kernel.dk>
Date:   Thu, 5 Nov 2020 09:50:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0000000000003698a305b35e63fb@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

#syz dup: general protection fault in io_uring_show_cred
