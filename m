Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD0419C13A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Apr 2020 14:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388264AbgDBMgz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Apr 2020 08:36:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38377 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388192AbgDBMgz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Apr 2020 08:36:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id c7so3991897wrx.5;
        Thu, 02 Apr 2020 05:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TWFDO6DAngHODy5evaPvvXD3sOorWkJ7n0UXEP154M0=;
        b=ddHX8DEpcZV+T3ir/gC7AVowRcQMFQWUFq5Lqx6N43Hkn5R8r8sb4A78K68gDoVerk
         KRJZHDTGf+Ux14Uw5b1IjPUyucJbv3b4ZRuRd6X+Uzg/Id8WT4cP+FROSH72wRIpmRZv
         /t4iw2MyQgzp4BWWZ0gvXeX6bspdHbLnF0iQCNkoADfTvF+qIOE8KizEKsijURh/7Nyo
         rTPYYA8a9Vggol50N/8fhysDJ4X1C3e9+d42N75VyTfmw1FdYY+i7uMtSUrBmPNpRVFG
         UnV4AbPa9zqWtA2Ehwsjdy+GPwhQTpbzEX/k3XlRl6fxPF3mUMKLpScNR4CLdUYuHF32
         1FPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=TWFDO6DAngHODy5evaPvvXD3sOorWkJ7n0UXEP154M0=;
        b=WebyrBIJhaSIFFMbRdqtJrIuxbN6ORoMu1SAi9yYMAuL8/JmuzGYsk7b7ZXwrlrnxG
         MyKmvRI7Rs5DWow9cVMy5jaPnOP1MNuhRqJH2dOHYgoHQhYXnyregN8AuPuOvZPTazJx
         XazzD3jhNO8kuCh+u58/iQQGKHXv1Hl7r7LgwAN4rZLD1A5aVfyV5aIiMnjlhv5WbFDe
         h6ZlnPexUdiBqJn+0hmJ9mZ7QI65aY20vjrQcin4XDvwwlRKo5lxeqDam4QnjW7uLaPj
         QDwmaPP8O7VFUyfoc5osw6I8/8IMC2j8+syPLTUTiv5qpC/tpWUDu/NV/3LiDO1dq2pO
         a1tA==
X-Gm-Message-State: AGi0PuZiSAYT4D9j3DYK6Q9jRgmq4ngsQCrKdhIh86Qb0nigGr5JUnuG
        vBZCHv4iUD4y0jMMBJiTI0XX52N5
X-Google-Smtp-Source: APiQypLkhVIKrkZjtZjgqYKQCN6D8CBcjcnSdlYyVaHVIYw6H0Jb7uSjCljcLHi5yc3kaYGm2lZtJQ==
X-Received: by 2002:a05:6000:51:: with SMTP id k17mr3470982wrx.148.1585831012736;
        Thu, 02 Apr 2020 05:36:52 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id o67sm7192806wmo.5.2020.04.02.05.36.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Apr 2020 05:36:51 -0700 (PDT)
Date:   Thu, 2 Apr 2020 12:36:51 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] XArray: entry in last level is not expected to be a
 node
Message-ID: <20200402123651.zyrqwmecnmcqaxs6@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200330123643.17120-6-richard.weiyang@gmail.com>
 <20200330124842.GY22483@bombadil.infradead.org>
 <20200330141558.soeqhstone2liqud@master>
 <20200330142821.GD22483@bombadil.infradead.org>
 <20200331134208.gfkyym6n3gpgk3x3@master>
 <20200331164212.GC21484@bombadil.infradead.org>
 <20200331220440.roq4pv6wk7tq23gx@master>
 <20200331235912.GD21484@bombadil.infradead.org>
 <20200401221021.v6igvcpqyeuo2cws@master>
 <20200401222000.GK21484@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401222000.GK21484@bombadil.infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 01, 2020 at 03:20:00PM -0700, Matthew Wilcox wrote:
>On Wed, Apr 01, 2020 at 10:10:21PM +0000, Wei Yang wrote:
>> On Tue, Mar 31, 2020 at 04:59:12PM -0700, Matthew Wilcox wrote:
>> >On Tue, Mar 31, 2020 at 10:04:40PM +0000, Wei Yang wrote:
>> >> cc -I. -I../../include -g -Og -Wall -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined   -c -o main.o main.c
>> >> In file included from ./linux/../../../../include/linux/radix-tree.h:15,
>> >>                  from ./linux/radix-tree.h:5,
>> >>                  from main.c:10:
>> >> ./linux/rcupdate.h:5:10: fatal error: urcu.h: No such file or directory
>> >>     5 | #include <urcu.h>
>> >>       |          ^~~~~~~~
>> >> compilation terminated.
>> >> make: *** [<builtin>: main.o] Error 1
>> >
>> >Oh, you need liburcu installed.  On Debian, that's liburcu-dev ... probably
>> >liburcu-devel on Red Hat style distros.
>> 
>> The bad news is I didn't find the package on Fedora.
>
>Really?  https://www.google.com/search?q=fedora+liburcu has the -devel
>package as the second hit from https://pkgs.org/search/?q=liburcu

Thanks, I will try this.

-- 
Wei Yang
Help you, Help me
