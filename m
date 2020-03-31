Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE70219A193
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Apr 2020 00:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731327AbgCaWEo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Mar 2020 18:04:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44637 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728493AbgCaWEo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Mar 2020 18:04:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id m17so28058079wrw.11;
        Tue, 31 Mar 2020 15:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K04d4E619JqJooDocmXBidoUR3eMnXv/Sjm/pn+vcqc=;
        b=P/hQhjn1cnbdOGryaLUrCZZRN/ePZIqY64iDBgsud7Go8Uf3j2zSAaUIYjGq89cAzF
         k8GsKu+tfPbeAVHD+FXCiuFkrHeL+RYrC747Y4TFO0jdVN2sBt5vUNSK6Xuag194imU5
         cDoAjRkVH1KKJtU9OrBsGnm3yRSQ6+SvSNYt/yh91Yi0JxXU6G5oY5t05VaY9+/keaWZ
         q//AfMFQKrY2DCzi7M2KeWPAdBethaKmJZv7XFzYAOvEI1dZx+UyGagUjwN9yktpr7aX
         RJhH0lndhRlKQ/3a8nAHhqXn5aeN7xzvAYRhnkTBLH2po8ncuWdFkglSnJrDbV/Khlj2
         fQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=K04d4E619JqJooDocmXBidoUR3eMnXv/Sjm/pn+vcqc=;
        b=UXqz8KsF5jeufvv83MF/VQxP6Lo4s1/35tS+Q/Vis/gLlr6u++a5JVnN+ltxrBfKfS
         yZetg2I+iBpzpEeUBahRkxUQo/bRDXu6lsG/jvuX3xdqr1oymecB1jcRZbWckzM9U6hx
         lsEQRwwj2Nx+k1qj7TffSSrzsdtZ/njBlA11gL3Q68nZupfEtjephCtFQqADefLtSM7d
         Bmsq8FMz3eLdoa15OW8GYuXxGZF/DCTvm8v6ArCuFQmqv7wOEu7HOXVAoiH4x9AOT9/V
         HJ+3uvo2gC2ClVcV9rZgE2YI9ynzMryNerolEmJA2zmZCagZCrhdQeM+ithmxHSpAGvd
         71Pw==
X-Gm-Message-State: ANhLgQ17yr8884QuubdyCEy1MO/Ve03NMlOgRhcDO2Gw5P/3nNqt5xB/
        WnI6COTNXvjM19f0WpclLqQ=
X-Google-Smtp-Source: ADFU+vsvWZJ8fIiCmHp3Zp0k7J6xxXy43eev5tOznFF7bpC0JTGNOryX5j+MM6Ajs8csBzLFpUOuDQ==
X-Received: by 2002:a05:6000:51:: with SMTP id k17mr19168527wrx.148.1585692282256;
        Tue, 31 Mar 2020 15:04:42 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id b187sm5918614wmc.14.2020.03.31.15.04.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Mar 2020 15:04:41 -0700 (PDT)
Date:   Tue, 31 Mar 2020 22:04:40 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] XArray: entry in last level is not expected to be a
 node
Message-ID: <20200331220440.roq4pv6wk7tq23gx@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200330123643.17120-1-richard.weiyang@gmail.com>
 <20200330123643.17120-6-richard.weiyang@gmail.com>
 <20200330124842.GY22483@bombadil.infradead.org>
 <20200330141558.soeqhstone2liqud@master>
 <20200330142821.GD22483@bombadil.infradead.org>
 <20200331134208.gfkyym6n3gpgk3x3@master>
 <20200331164212.GC21484@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331164212.GC21484@bombadil.infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 31, 2020 at 09:42:12AM -0700, Matthew Wilcox wrote:
>On Tue, Mar 31, 2020 at 01:42:08PM +0000, Wei Yang wrote:
>> On Mon, Mar 30, 2020 at 07:28:21AM -0700, Matthew Wilcox wrote:
>> >On Mon, Mar 30, 2020 at 02:15:58PM +0000, Wei Yang wrote:
>> >> On Mon, Mar 30, 2020 at 05:48:42AM -0700, Matthew Wilcox wrote:
>> >> >On Mon, Mar 30, 2020 at 12:36:39PM +0000, Wei Yang wrote:
>> >> >> If an entry is at the last level, whose parent's shift is 0, it is not
>> >> >> expected to be a node. We can just leverage the xa_is_node() check to
>> >> >> break the loop instead of check shift additionally.
>> >> >
>> >> >I know you didn't run the test suite after making this change.
>> >> 
>> >> I did kernel build test, but not the test suite as you mentioned.
>> >> 
>> >> Would you mind sharing some steps on using the test suite? And which case you
>> >> think would trigger the problem?
>> >
>> >cd tools/testing/radix-tree/; make; ./main
>> >
>> 
>> Hmm... I did a make on top of 5.6-rc6, it failed. Would you mind taking a look
>> into this?
>
>It works for me.  I run it almost every day.  What error did you see?


The error message:

cc -I. -I../../include -g -Og -Wall -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined   -c -o main.o main.c
In file included from ./linux/../../../../include/linux/radix-tree.h:15,
                 from ./linux/radix-tree.h:5,
                 from main.c:10:
./linux/rcupdate.h:5:10: fatal error: urcu.h: No such file or directory
    5 | #include <urcu.h>
      |          ^~~~~~~~
compilation terminated.
make: *** [<builtin>: main.o] Error 1


I didn't touch any code in testing directory.

-- 
Wei Yang
Help you, Help me
