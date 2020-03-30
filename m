Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73489197E24
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Mar 2020 16:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgC3OQC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 10:16:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37871 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbgC3OQC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 10:16:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id w10so21900963wrm.4;
        Mon, 30 Mar 2020 07:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x+8Uj9b/3JpyVdRDH/R//D7u0C6UtUrAY1uSKsRQ9zE=;
        b=t54WtOGsxkvO32SeerS0tBpmoyY/Gk0fOgAJ8Mwk/dXjs1jx+DdmU44Uxbp5yr5Jsl
         rl6SqjDk/Ww9PGwtsPd9ofND93okQcYp1bDHcnGiwvqsSIQXvDAdTg0AAwvJ8ewBgaah
         6c3J5CZ9vrwIxihgErHrQodue0QsghAMe3Mh7/k+x55F18jAAkbpflKHaZHxVNBq6oGI
         cRWAb0/dMD4X/G8hU4jpxm8jGvXinAoOBQ5kT7m+Sp105pHnaKTkTQuB958fN4/9Oi6R
         8NJWdFF2P9/Lfiw8Q2X8VvbKo0efBgnmcIRymtXw3FETi0CG5JVd4gcPoUeGpvXKUWLf
         2zvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=x+8Uj9b/3JpyVdRDH/R//D7u0C6UtUrAY1uSKsRQ9zE=;
        b=LBIBI0ZA166Le5exHZJZi/sJSnj4Ec2CybBqC/SqOfxQuxHrrnHro37lxj5h13oUZc
         W34/FrghmSTrJTdCMDJo+nqb+5e++GYXnSBliLO/P5nGVGaNr0Fk13wkJfYV1DSQq6Qq
         o+Kj3cqVeppFLGkApLKVPQdCciewpzDovRjOk88mSM7E6FCfk0VcxR3fLyrQa+ehO600
         H33XikwD6IFoUT0l6RWuJ/MyHGf3/e+5P2bnzAWqHP4Q5EGFVveD9L0dEviJNUPa1ByD
         gCDGxxIP4i4W3pzZ4Z39w9/AoHw++G77b7gx7bUOFcAtvHE3KOyga7y6jBLoS+ZQDScE
         m7FA==
X-Gm-Message-State: ANhLgQ2f0raE0dLcM/hg/zjwRgRUufUuWK5zW7F56x9GRXTUjvg2E/5h
        aogqBXHWOpKgOxuhJTMC3GIR44/j
X-Google-Smtp-Source: ADFU+vtgriQEK814h9Q+lram7pClR6qI6cTqtJ0viMKylbDg3CAmVf9tqZYIV5ky5wiGQp2MkLO2lA==
X-Received: by 2002:a5d:6a43:: with SMTP id t3mr14531633wrw.87.1585577760852;
        Mon, 30 Mar 2020 07:16:00 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a73sm21067244wme.47.2020.03.30.07.15.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Mar 2020 07:15:58 -0700 (PDT)
Date:   Mon, 30 Mar 2020 14:15:58 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] XArray: entry in last level is not expected to be a
 node
Message-ID: <20200330141558.soeqhstone2liqud@master>
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

I did kernel build test, but not the test suite as you mentioned.

Would you mind sharing some steps on using the test suite? And which case you
think would trigger the problem?

-- 
Wei Yang
Help you, Help me
