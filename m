Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41502AC33C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Nov 2020 19:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbgKISIu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 13:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729570AbgKISIr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:08:47 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8D4C0613D4
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2020 10:08:46 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id q1so9161807ilt.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Nov 2020 10:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=j47aCS29776hDsXzBL5Yato2CFnib/+OBUg4G/BADhg=;
        b=OaLO5QPX4GFQhPXneAkdIQLvlkZ6S/SqSMH5aC6AKlbOb8oEh23O047VONbDWDo4vm
         7DaanMHctyjub7jt3JnIUY0m7MXYHx13U+Zj4cUn4qyMR7YBqBCBV9tsoSMMdShUFvTZ
         UpzIPsvJjjQwsArjfnOitmP3EPzpzHZXPq2+WLzE1xJnC5OngZ0pE9LU0OXtv7ahXLxT
         yrFq6DFO+zOj3C64NqKYprcDi9vNOS6bveANJsfX7TZETmko76lP/O/eWPHukDo+IAIA
         PutdVIfcTKYzGdGKWN5KQJflVlB5VheL7tvr1MMWx3KM6xPK65H1+agvbjBgjm2JtP4S
         AzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j47aCS29776hDsXzBL5Yato2CFnib/+OBUg4G/BADhg=;
        b=RWushsfdx/hmUAzc2ygcBvhZSgFdhaVF2c9wTZlLYhYQg4nfrCyIfs1FT8r+mJSdss
         cO5+w9PwCPpXQzn5izmcsPknTG40CmKQh80Cp/rNVphtOhvJ/lt+ILrHi6qKTigaRqFg
         InoqSyvFP2AswWWgGQEIWvBxKywogg4CwrX1VUeEnEbCYZfPxrnHzBY7IvR8n0v1zkTb
         tJcCRkGstVi/fyWRhn0YYbBWKGEwU5sU00W/J8uLhWGatVnNYnOXIpGNlRrm2Hgu6rD0
         ZO/ti8KQ6xrUNXkbIDYrDf05zOdfjx8PmkfJb+8mkQiy9Qiz86DnUjnVTvb/kbT8Qvag
         s+1Q==
X-Gm-Message-State: AOAM532r8Txq03icws6dgyA2z7HL+2lTUpMcN13jRfhu5RE9tYHHtPHT
        kDBRU90+uPiWkO/DP5Ug69kazA==
X-Google-Smtp-Source: ABdhPJy5w6MmOQcsBjeteqExZt3kI6+IfQSGLHX68AfxXahU++pOfbmyfo3sEuMDpf2Vc0iZr5zK9g==
X-Received: by 2002:a92:d3c1:: with SMTP id c1mr11449523ilh.271.1604945325477;
        Mon, 09 Nov 2020 10:08:45 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a13sm4036704ilh.0.2020.11.09.10.08.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 10:08:44 -0800 (PST)
Subject: Re: KASAN: slab-out-of-bounds Read in io_uring_show_cred
To:     syzbot <syzbot+46061b9b42fecc6e7d6d@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <00000000000028115c05b3b06bbd@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c3f69180-187b-6801-b74c-a22231323049@kernel.dk>
Date:   Mon, 9 Nov 2020 11:08:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <00000000000028115c05b3b06bbd@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

#syz dup: general protection fault in io_uring_show_cred

-- 
Jens Axboe

