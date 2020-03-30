Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13A60197E18
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Mar 2020 16:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgC3ONx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 10:13:53 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38071 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgC3ONx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 10:13:53 -0400
Received: by mail-wm1-f66.google.com with SMTP id f6so15494753wmj.3;
        Mon, 30 Mar 2020 07:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5Hbf8AcBWNvIVZvkXi6B/8j12b7TidXxp6n59nlnGdM=;
        b=AOw82TdefsS+gSClhWq2M6hN8dIO1s76IOgfnv17X+Juwb/TnBmJVuz+L7ooKIW0Cr
         Lg1m2LL5mPV8zLaw6Ld7wSGaCCA8H9wCS8iFxj6eyvrkQpN87an78utIEH8OdKGSynxL
         cRZ+or3lXVBUqs8qVkSJzP4bP+fbt19xorOaDx+04l1tGfDe84mE2edahjR5/JQJZeLg
         /20GkraiWL5EN66Y29+zxCzXmAeZABDbWEZOO+4q/x359fQ6Prt+va3KCrokmfY7zKFw
         IX6nyBQdit/K9PRQBGYJT8ASsYK+U8OdKKQ+jULhbgTWFQWlN8GDQDQjNb2BTkQkWWDy
         yahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5Hbf8AcBWNvIVZvkXi6B/8j12b7TidXxp6n59nlnGdM=;
        b=Qtf1zdmpjp3R2sjmjIbdaBdjM+iitf8vkGHNbKdB7Bx/Tr4HGF1VKIsyvKSyyRTZFC
         DNrSvj7qiDPR1hleX0Y6JtHCjRc4aTOJ2W/vjE7pKJ1Tb2icvbBmHkUYF+gXLx2HGyWb
         81px0M24fU5u2GmYuvCVmOsK/gmZ09m9ywc64D9rG5UT4oNmrNfjvI3qLMyS8Rit+vKR
         SzglzcI0hEFFJ8nqgb6GiNGtgCSRzSmdkKZvNm/jDtK/t6mgzN6qFJPbJlnNHeTCM+Qd
         t3zHIsGPw1qNMeASPtplfcwVWcrTuhLRJyI8EM8jbv/GLmtDtxnmW4NvXC54qp4OHmsp
         A7jg==
X-Gm-Message-State: ANhLgQ1ANZauw6Z9T5NDHNaYgFq5nk46euaWTsVv2RVu6Qq1biQhtjia
        7V8IBeOylAsECx1I1IB66L0=
X-Google-Smtp-Source: ADFU+vvbTr6f3hrlk0HhRaWr+E9iQ3xeSvlJwLgjKi0OF2Ag8DZTl+wPokNIXvp3UyeNYmIvn1HiUg==
X-Received: by 2002:a1c:c257:: with SMTP id s84mr13119722wmf.0.1585577631355;
        Mon, 30 Mar 2020 07:13:51 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id s131sm21432819wmf.35.2020.03.30.07.13.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Mar 2020 07:13:50 -0700 (PDT)
Date:   Mon, 30 Mar 2020 14:13:50 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] XArray: internal node is a xa_node when it is bigger
 than XA_ZERO_ENTRY
Message-ID: <20200330141350.ey77odenrbvixotb@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200330123643.17120-1-richard.weiyang@gmail.com>
 <20200330123643.17120-7-richard.weiyang@gmail.com>
 <20200330125006.GZ22483@bombadil.infradead.org>
 <20200330134519.ykdtqwqxjazqy3jm@master>
 <20200330134903.GB22483@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330134903.GB22483@bombadil.infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 30, 2020 at 06:49:03AM -0700, Matthew Wilcox wrote:
>On Mon, Mar 30, 2020 at 01:45:19PM +0000, Wei Yang wrote:
>> On Mon, Mar 30, 2020 at 05:50:06AM -0700, Matthew Wilcox wrote:
>> >On Mon, Mar 30, 2020 at 12:36:40PM +0000, Wei Yang wrote:
>> >> As the comment mentioned, we reserved several ranges of internal node
>> >> for tree maintenance, 0-62, 256, 257. This means a node bigger than
>> >> XA_ZERO_ENTRY is a normal node.
>> >> 
>> >> The checked on XA_ZERO_ENTRY seems to be more meaningful.
>> >
>> >257-1023 are also reserved, they just aren't used yet.  XA_ZERO_ENTRY
>> >is not guaranteed to be the largest reserved entry.
>> 
>> Then why we choose 4096?
>
>Because 4096 is the smallest page size supported by Linux, so we're
>guaranteed that anything less than 4096 is not a valid pointer.

I found this in xarray.rst:

  Normal pointers may be stored in the XArray directly.  They must be 4-byte
  aligned, which is true for any pointer returned from kmalloc() and
  alloc_page().  It isn't true for arbitrary user-space pointers,
  nor for function pointers.  You can store pointers to statically allocated
  objects, as long as those objects have an alignment of at least 4.

So the document here is not correct?

-- 
Wei Yang
Help you, Help me
