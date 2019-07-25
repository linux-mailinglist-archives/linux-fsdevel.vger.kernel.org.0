Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58D6875A17
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2019 00:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfGYWDG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jul 2019 18:03:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35710 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbfGYWDG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jul 2019 18:03:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Z6RYngi3cJJjtiTM0pcFs8c1UrVLGOUye1Guqo9Ye98=; b=ABdMJ/MzOxf5WQbmFkAZaxpyi
        odM/o9V2QsyOs2V6Qibnt/LaE7TxI0D+PhKQ/pTCnE33ld5nWtnGgFNaL5wXY/eb6cMCj1cjsvHQ5
        6PYC27o5vuSD7ZLaj02Bt0h66ZeR5ld1OYHiDGCPQmJw7pn6WZPXhDuOxBmk18J11QFBkstHWtT+3
        gB5ZYi5O4tXzUhYb7A2HDVRwaEi6TflhJOGZXOR5/ZIqQLYthI2eoV+aeHn1qOLpV4YX5SRkiGfLU
        cAhHedU6YJgU9qno/BQtQnjP+jf3RDgYsV8DTLA27h4ZKC1LRQuHi0TA0aR5MMBNd9DskpS+wHMru
        Mw5qWtpaA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=[192.168.1.17])
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hqlpF-0002UC-Ry; Thu, 25 Jul 2019 22:03:02 +0000
Subject: Re: mmotm 2019-07-24-21-39 uploaded (mm/memcontrol)
To:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Chris Down <chris@chrisdown.name>
References: <20190725044010.4tE0dhrji%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4831a203-8853-27d7-1996-280d34ea824f@infradead.org>
Date:   Thu, 25 Jul 2019 15:02:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190725044010.4tE0dhrji%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/24/19 9:40 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2019-07-24-21-39 has been uploaded to
> 
>    http://www.ozlabs.org/~akpm/mmotm/
> 
> mmotm-readme.txt says
> 
> README for mm-of-the-moment:
> 
> http://www.ozlabs.org/~akpm/mmotm/
> 
> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.
> 
> You will need quilt to apply these patches to the latest Linus release (5.x
> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> http://ozlabs.org/~akpm/mmotm/series
> 

on i386:

ld: mm/memcontrol.o: in function `mem_cgroup_handle_over_high':
memcontrol.c:(.text+0x6235): undefined reference to `__udivdi3'


-- 
~Randy
