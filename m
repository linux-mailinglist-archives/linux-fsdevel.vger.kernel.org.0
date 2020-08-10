Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40012411E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Aug 2020 22:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgHJUpT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Aug 2020 16:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgHJUpS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Aug 2020 16:45:18 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28613C061787
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2020 13:45:18 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 17so6355785pfw.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2020 13:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=bSPnxn3kyrwVbRID2Yxgnq1PnNVuxdGlfum9Ij0n2vw=;
        b=a8927blXkuuZ77vcJAPIc1fCrs3Z/XvpAT5yK/HJZMyDdd6sPzS44TtPc9CZmzVzgW
         tmYNMFKu3pmkvywv+sYJF46Mo+op2XhIwM/AqPfTWYskr6N0/0njCZ1t55ced7+wZnld
         bmDr8++wf0/rdkT2od5ARNoaV3e/P0ctYt7QqqSNtSSmSddNLSdalBUS7yX5ytRqQTNl
         09G6532ra5wArLu/htXZqbyjCFRy4Xr5PJLQC+8EipSuzPQttCS+jXputk+kAi3Wvgl+
         OdF645lAAl/TnSHN5z0O4AW9D1VsKtvcSrdKOk1nO4akJq7uMajQf6TiApC/XcP4Gmq+
         KhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bSPnxn3kyrwVbRID2Yxgnq1PnNVuxdGlfum9Ij0n2vw=;
        b=FZ7KbC/X2J0RB/rzEP05bJ47+2tZh6p2Mk8e0iuSrw0VRIQeiaNyQbsCJxHKs7vD+e
         kN0UJMEvIiCv71vmyK8Wl0Fknj4WtSqGQlbrCzzhu82zdoc+34yWy7UappDmcHGmuEtp
         SCTmI3h02E97kq9D6cDH7SbWlt8YG1C8Q1R455P+hlLr6Em+6Ygx1IALyrzMKPgZkIJF
         AHQEraJJgHwj15NzmeWyKd3JRBxycbGMVjkNQbqg/fnWaYIwB+mRnnM55EwxhQ47GqT+
         7Bl0uaiMkNheNCa415aq1c8RCEVyBdsKyHTLH4cCm1ySJtlggMvTDRuD0+S42n0B7mDA
         sK2g==
X-Gm-Message-State: AOAM532b1Rffa9zKdhFb1toiqlX1641qgaV3rSFY6VUlwBz/MQ46td2r
        03bq1tj/CyUYb7xtWLAyrm4HMw==
X-Google-Smtp-Source: ABdhPJxKiSSq6UWiaNnF1Pac7zVqzamjjJOvuEPwlk6vbhwUi47n/I0zTu2dbu7uhLcKtBTPOAFBLQ==
X-Received: by 2002:a63:b0a:: with SMTP id 10mr23515903pgl.166.1597092317352;
        Mon, 10 Aug 2020 13:45:17 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id d1sm397055pjs.17.2020.08.10.13.45.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2020 13:45:16 -0700 (PDT)
Subject: Re: INFO: task can't die in io_uring_flush
To:     syzbot <syzbot+6d70b15b0d106c3450c5@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <000000000000991ae405ac8beb12@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d458ed96-32f9-edce-a8b1-e9941c6a8ef5@kernel.dk>
Date:   Mon, 10 Aug 2020 14:45:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <000000000000991ae405ac8beb12@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

#syz dup: INFO: task hung in io_uring_flush

-- 
Jens Axboe

