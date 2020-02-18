Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08D3A162E5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 19:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgBRSWb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 13:22:31 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37034 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgBRSWa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 13:22:30 -0500
Received: by mail-pg1-f194.google.com with SMTP id z12so11363636pgl.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2020 10:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OA/leHKYo8E0m/uN7yH7vLY6aAq5W71bNQ4zaVt1YAQ=;
        b=bMT1cl0A50XBAxT6a4EXDbABdH5yjYLfCj2oSh7ERqVMjMGte8z6xGFRiPmZnReT6f
         mY8lke2SPH9v2LPaUsqOYhqcrQUHbvIOFcGjopFiJRCkkwSh0log+Yw+t6ruk+iKeQ0t
         8V6KqTYhrXPnOCi25MDgfNoCKSf9QlNxpgrhxYW0SFA5ZFqforuH6tfDQylWzP2CWx5A
         gkLsyVItL1ue5rZpakLGyVuHT8IcVioc4BG7rKmEtRB/b2LmkmeWuttDFCSE5kYypbSo
         g7FcmHE9xLvfxBairPHO+KXf5j0/XeqVwhPgSRlqlfNYVgEewcZWfQWtGnU1TMAgOSN1
         7hMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OA/leHKYo8E0m/uN7yH7vLY6aAq5W71bNQ4zaVt1YAQ=;
        b=C6xjqydSl0Muur5Hk1wgtTH3MiI6G3e7ZCSoi4Zi/EhqUuCawTHZMzq5xO9r4v6uGu
         XflnwaTn+EolDJS1ckd5ElpbQXBWQkTCGUFhyxr0K8UHxn5dQUOgnDgalgdp3z3DN6Yj
         7gChYcVQyDSaEfPej8fe6wdSqhnh2rxphuJdw+1q0n7a94Dp4X/jXVdjoLxgEYUSsPp+
         q1xUBzB3fVeq+W5ADNYfvPfUDBa2Vp0Oi+Rb+TQnbq0K0soaqxHO9/7AnoQUIr6hypNA
         v3Yvy7+UOcYuXB/yP3/H2Yqn5AQi6BvMrwWvyZnNwE3ladWAQMYymOvI4NfgapmXJdyj
         JC5Q==
X-Gm-Message-State: APjAAAXo0xuasa6QyMywvUxVyu5V8czML6SHwFwic5QtN/6Om1PAfq4t
        W8o4A727THI3Rao4or2+dwoO5g==
X-Google-Smtp-Source: APXvYqwhzCvUjtjFn8vnB6Tn1FwjdTQfQa6cEYagqG9JJopOzh3ICxi7iYA/N5vmbOSxF30bjSHJbw==
X-Received: by 2002:aa7:8502:: with SMTP id v2mr21735685pfn.232.1582050150169;
        Tue, 18 Feb 2020 10:22:30 -0800 (PST)
Received: from ?IPv6:2605:e000:100e:8c61:e155:33dd:95af:8080? ([2605:e000:100e:8c61:e155:33dd:95af:8080])
        by smtp.gmail.com with ESMTPSA id l26sm5389586pgn.46.2020.02.18.10.22.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2020 10:22:29 -0800 (PST)
Subject: Re: [PATCH] io_uring: remove unnecessary NULL checks
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20200217143945.ua4lawkg22ggfihr@kili.mountain>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <93921160-d063-83d3-1064-a70247def2ac@kernel.dk>
Date:   Tue, 18 Feb 2020 10:22:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217143945.ua4lawkg22ggfihr@kili.mountain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/17/20 7:39 AM, Dan Carpenter wrote:
> The "kmsg" pointer can't be NULL and we have already dereferenced it so
> a check here would be useless.

Applied, thanks Dan.

-- 
Jens Axboe

