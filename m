Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC47240AE8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Aug 2020 18:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgHJQBI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Aug 2020 12:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbgHJQBC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Aug 2020 12:01:02 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EBCC061756
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2020 09:01:02 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id p1so5148210pls.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2020 09:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=LY7XDlS+r9xqSatoqcPSl1dicDyGmLyMn5WxXWX4PDo=;
        b=q3B7YgUm7VMx2mfLqu9k9cVpHrzROCKYAwlYzSD/aBGusdfTe2CDC8f4xuA+QLnSjk
         ROghRiUkxSqgQLgFylgQs+dM1CPaMIXcC9GDsmSUs2N6ioYrKF7MkdEVFDupc3/wSysi
         WnbLT1x6VqiBI2LM2ByCbE/h+1SRYXpBhLMj/7M1CBmRKw/gm/5iVqeoBNZzsuCkoX8C
         JgolzwJ+hdHXK7BMoNHLUxfDoSp3N6Dyg9AvvDT8pzdEwxTCSvtvu6pD+PK3KTVhnSs5
         92iZ3VUnfTrYkKUX3UdtcLW9QcDvUQhj6SqzT3kHJh2mc/Bf4EKsB/tyIA+wcTIUZY6a
         NkGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LY7XDlS+r9xqSatoqcPSl1dicDyGmLyMn5WxXWX4PDo=;
        b=IUNSo1mpgTmB+CkBMq/jfWVjf8KayiV0VbM8joEA9YV7tdSxnoR5BXiaAHh/hjocHn
         8HhFRYEexf4ik2clDg5W91f38/zWDEUQSRpaPV+o1kUC2raErz3q6yExGsD8atf1/TKb
         DHJVRpL9gatrcIaaTYFmxAgwUhG4q2rZKHJdlr4fs/ETUp/Hm4oONUcaFY67OW+U/cBn
         fKNPgaFDH+an/KV9NTVUHRl/IhUwIODgYF8fM+R95uqlSjM3Z9ANJuNtr+aCo4OMJi0G
         XkYkQGWIG8KKZeKRwnjFH/irIoe0YEBvC3se6fRz5XtsAwnhNaLNSneRJ96+C36pP12C
         x19w==
X-Gm-Message-State: AOAM533EbQI7VpQcO1CSBdPH+vnDQQQ0s5iq87XpS2e7mLWcEys9RMjA
        PZ2SOcsPOF1DY8pqOCZn83ruJqkaFjA=
X-Google-Smtp-Source: ABdhPJz8Y5b+PyT3yZofeU3N4BVvdvRUm8Izs7MwOkG4AnMVxYZEFqAM2ncdP19AMntvbbrQhA2z6Q==
X-Received: by 2002:a17:90a:6b07:: with SMTP id v7mr17920pjj.138.1597075261076;
        Mon, 10 Aug 2020 09:01:01 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id c10sm21937840pfc.62.2020.08.10.09.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2020 09:01:00 -0700 (PDT)
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 loop_rw_iter
To:     syzbot <syzbot+1abbd16e49910f6bbe45@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <00000000000066583105ac87dbf4@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f81cc90f-1d09-4a05-1619-02d44189f03a@kernel.dk>
Date:   Mon, 10 Aug 2020 10:00:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <00000000000066583105ac87dbf4@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/10/20 9:46 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    9420f1ce Merge tag 'pinctrl-v5.9-1' of git://git.kernel.or..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13662f62900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=72cf85e4237850c8
> dashboard link: https://syzkaller.appspot.com/bug?extid=1abbd16e49910f6bbe45
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15929006900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15e196aa900000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+1abbd16e49910f6bbe45@syzkaller.appspotmail.com

Already fixed, just not upstream yet:

https://git.kernel.dk/cgit/linux-block/commit/?h=io_uring-5.9&id=2dd2111d0d383df104b144e0d1f6b5a00cb7cd88

-- 
Jens Axboe

