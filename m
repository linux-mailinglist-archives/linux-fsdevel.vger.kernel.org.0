Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC31B19EF13
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Apr 2020 03:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgDFBY4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Apr 2020 21:24:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33312 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgDFBY4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Apr 2020 21:24:56 -0400
Received: by mail-wr1-f66.google.com with SMTP id a25so15479894wrd.0;
        Sun, 05 Apr 2020 18:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vt1jfJ08UcjXQKwq+YyYHriAKm3jxCzbKToBskSXe3o=;
        b=agLJMsSdM0R0NH4VVIMfJFf4iY5uTObaYJ085JnQruZhy9sBJbcl+S4TyhbFR0HY3X
         wutWmOSqP+wfaNQwkflpL1qZJeFZM72K9W/34OHDEnwM2fK0LJEJhk1uI7UL6Bri/tv6
         ujc6+JzrFUQHByiLMWzsYg0hVDcIo63pgEU0E1XjqNCdBQ44YASTC0PwKWXYypFXGNb5
         QQePJtvWxpESfUe9/5vaHoZD+FRi34H5EtEaKLi0+FVk44xcNbozWPrwKJvSGJoEhvLf
         +6FDoh+yQec8FKrYXzBDkY98EEOdjDz6ZVVfvzE/cE3jiP+fk04382Ysvab3dqoP7KQq
         d+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vt1jfJ08UcjXQKwq+YyYHriAKm3jxCzbKToBskSXe3o=;
        b=MNjOzv5g3VJlE7Cjz11FQtKCQZUhHUP+lwh9b2oltR3KsFeWciONBCz2wgzviSTTeo
         9UH4tu7eo+65Ug28kZStdSr/BEm5kIb3DGAUJn0lLAlQ9FIyvyHsnCL+mn96a8pqvxT7
         ZIYEbf5j/+ctzWot4Mx76zDeIdXTSo+9KT9p3gmn2fzxoVU8PyJTOKKWUAuZiEH3Ra3b
         rUEkcfeyfSPgzNjjY2qXzkMb+PghoadzEAUWKq4uPJOu5YEc/4qvR5GAvBrgMbporYR5
         Wz8Cu4+Ce2dn8g++CO2YBrimy3lg1w2cAJ/YhqSioLq8mOzKt7j6aeBNJmGrJZLjRq8Q
         HuWw==
X-Gm-Message-State: AGi0PuagWcSVKlHnHi/70Hgf67vAIEPsAyxpyzBRXbpcAjNxE1CXjO6A
        Os6w+YoCJyuSpAjFn0KiPzA=
X-Google-Smtp-Source: APiQypLVKLk1nRlDF+SewfywMWPBBK+OenYYCxJTiIneo0/l/rRExIuuaVZjbpqNSqb5Hz9qwHo6+Q==
X-Received: by 2002:adf:e848:: with SMTP id d8mr20608408wrn.209.1586136293937;
        Sun, 05 Apr 2020 18:24:53 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id c85sm22795194wmd.48.2020.04.05.18.24.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Apr 2020 18:24:53 -0700 (PDT)
Date:   Mon, 6 Apr 2020 01:24:53 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] XArray: entry in last level is not expected to be a
 node
Message-ID: <20200406012453.tthxonovxzdzoluj@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200330123643.17120-1-richard.weiyang@gmail.com>
 <20200330123643.17120-6-richard.weiyang@gmail.com>
 <20200330124842.GY22483@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330124842.GY22483@bombadil.infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 30, 2020 at 05:48:42AM -0700, Matthew Wilcox wrote:
>On Mon, Mar 30, 2020 at 12:36:39PM +0000, Wei Yang wrote:
>> If an entry is at the last level, whose parent's shift is 0, it is not
>> expected to be a node. We can just leverage the xa_is_node() check to
>> break the loop instead of check shift additionally.
>
>I know you didn't run the test suite after making this change.

Well, I got your point finally. From commit 76b4e5299565 ('XArray: Permit
storing 2-byte-aligned pointers'), xa_is_node() will not be *ACURATE*. Those
2-byte align pointers will be treated as node too.

Well, I found another thing, but not sure whether you have fixed this or not.

If applying following change

@@ -1461,6 +1461,11 @@ static void check_align_1(struct xarray *xa, char *name)
                                        GFP_KERNEL) != 0);
                XA_BUG_ON(xa, id != i);
        }
+       XA_STATE_ORDER(xas, xa, 0, 0);
+       entry = xas_find_conflict(&xas);
        xa_for_each(xa, index, entry)
                XA_BUG_ON(xa, xa_is_err(entry));
        xa_destroy(xa);

We trigger an error message. The reason is the same. And we can fix this with
the same approach in xas_find_conflict().

If you think this is the proper way, I would add a patch for this.

-- 
Wei Yang
Help you, Help me
