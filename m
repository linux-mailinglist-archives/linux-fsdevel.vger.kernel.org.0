Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56839198703
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 00:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbgC3WKS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 18:10:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41405 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729142AbgC3WKS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 18:10:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id h9so23548674wrc.8;
        Mon, 30 Mar 2020 15:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=znoWPrzZPPeMBlwYAXU/ZXkwjJfA37xc5jbQZ/l+0OQ=;
        b=G35reuvYKP/V2qYll9ynDb8qbZEFe0G7rvXJopY8cVCQgH8zHGhQXD3EWMq+YQNIVQ
         fV3heedl2t9PMktRv2XIBxkVfZFNr6h08UaS+DFbGInp3FZuYSkgyA7U6UsFruaCSL4E
         a61YJd3oc8EX308yNACgKiQKQaopWkTHMES8GzQSN0oSXLgW0wLXNvheTxGcKkprsuvX
         ze8Q1IPrhUz4acS69pzyx6FG7JjcjmS0aNnRpipaeF3BoDH3Z9/cQKs7IS+Rr5dEAboJ
         UmbShFnnPJ6l+B4tkur0PhxJ4DYFiqPOPbThqpcUOo3RQDPH/jJ6e9LLLfQOhh8vgJr0
         KJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=znoWPrzZPPeMBlwYAXU/ZXkwjJfA37xc5jbQZ/l+0OQ=;
        b=harmS0AX27Nlfp4Ka6Y71g03Vn614I6Dq/TAZQJzp2mF0pxU7s5UIs1DSitGXEGPQy
         9dDnB61MNb3hxNkLx6C2UdV9ok6T+UprIAt/lMX6YDW7jUgi8+k2ucVCx3sKIlgRsaev
         V5IP3XaFhZh/g7+H6Umw/dal9sTUqfKhVmt5/r9vzByhkUAqSP+0Cyize1c1lACHCkcp
         chYyCK5b/xVtwYlE8Efji7dBqxVWOmUhxw4Qc95rgC8pZJgTi32iY5FXfi0grDblgwqY
         FXQJv0A3p/NUIOnaRkuVegJDK9lLvfOI5iE+luYzO9Pg3JiHQl8LJERO16V9ytnaLo5o
         lImg==
X-Gm-Message-State: ANhLgQ09QMvIO73OPcf38HvxrsMslkrr6I16eYoyhYGglEI24eyKnrgA
        pohTje1Yrfj3M+s0CAG20rI=
X-Google-Smtp-Source: ADFU+vvKGoP43xQtMj0sdWabkOaAX7yuRVcdGH7v+cJ0IPdXVxI3A2u8aB/f6NypUH5xb/xIN78U4A==
X-Received: by 2002:adf:f791:: with SMTP id q17mr8654344wrp.166.1585606216219;
        Mon, 30 Mar 2020 15:10:16 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id h81sm1195302wme.42.2020.03.30.15.10.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Mar 2020 15:10:15 -0700 (PDT)
Date:   Mon, 30 Mar 2020 22:10:14 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] XArray: entry in last level is not expected to be a
 node
Message-ID: <20200330221014.ppabot7qef2jhwx3@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200330123643.17120-1-richard.weiyang@gmail.com>
 <20200330123643.17120-6-richard.weiyang@gmail.com>
 <20200330124842.GY22483@bombadil.infradead.org>
 <20200330141558.soeqhstone2liqud@master>
 <20200330142821.GD22483@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330142821.GD22483@bombadil.infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 30, 2020 at 07:28:21AM -0700, Matthew Wilcox wrote:
>On Mon, Mar 30, 2020 at 02:15:58PM +0000, Wei Yang wrote:
>> On Mon, Mar 30, 2020 at 05:48:42AM -0700, Matthew Wilcox wrote:
>> >On Mon, Mar 30, 2020 at 12:36:39PM +0000, Wei Yang wrote:
>> >> If an entry is at the last level, whose parent's shift is 0, it is not
>> >> expected to be a node. We can just leverage the xa_is_node() check to
>> >> break the loop instead of check shift additionally.
>> >
>> >I know you didn't run the test suite after making this change.
>> 
>> I did kernel build test, but not the test suite as you mentioned.
>> 
>> Would you mind sharing some steps on using the test suite? And which case you
>> think would trigger the problem?
>
>cd tools/testing/radix-tree/; make; ./main
>
>The IDR tests are the ones which are going to trigger on this.

Thanks, I will give it a shot.

-- 
Wei Yang
Help you, Help me
