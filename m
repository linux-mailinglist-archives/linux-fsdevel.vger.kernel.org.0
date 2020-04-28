Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747A71BCE9A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 23:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgD1VYw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 17:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726282AbgD1VYv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 17:24:51 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73701C03C1AC;
        Tue, 28 Apr 2020 14:24:51 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id y24so355021wma.4;
        Tue, 28 Apr 2020 14:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zb7LzoAznLFO4xh93OzPl5Gk/vjaZwZU1XohHV7MrJc=;
        b=aws0RLC8kF78hcBigDsWrLtx64615jTQ1kP286WBAk3gnucdA/dPcXz+5qx06ab28r
         8SMeiNTy31aTlWPYuknfa9DL/fzfcFyQDAtB7IV0y7YbqoKbZjI16PvsQ+fnR7vVoI04
         n8+IV7mwWcEFdkbT0tKImrTRJG26sn1nj0gKtD9yW0NzgqNlONzg9uNWd7XyKBi4oD6N
         u4k1ZEK1oYB4ofl1vnn4ayBhScEfxI9FlLldXh2KCySlQzNCgQHU8WMvG8LI+NVhxOrR
         Q2fDiFH9c5OSNN3QHql0rEbY6Iyo/Gv361QL8QFX8Ix3cGOxmr52YruscRmHt7mxn67F
         MqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zb7LzoAznLFO4xh93OzPl5Gk/vjaZwZU1XohHV7MrJc=;
        b=N6STyyTbZcoErgkJLmdDeO8/gxOJVBuHyhmWfWtymHYwNR8oFvPJNWhkiBYfBVdbmU
         yCru1oD0DvY8fR8NWCc2ta03T+Db/0Gs+i7A4Cj2RF+yp1OJByIOWSBgBySmgJMTwNeN
         Mpx2YaOFL0pn/k0akB1A5SE6lGr7bZJmdc4vS5r3s4jg0vY4oRIa3xsaT4he7/1q4HS4
         u+LkG4v7NBIOd//SB/yA5kcVb0heASbKFRXP2AhnPomtvvUn3rrKIsCy7IRLW5oH1nDB
         KTLP+/TbKN688HOew2eynjiFOnBicxS/4cGqfnEqyIfPIKRRL6eTYle1AA/yNsWZQ3rD
         dRIg==
X-Gm-Message-State: AGi0Puam1s+UnrI+UEt29DIyNH6v4MQ0Ye2qz0J63YxbYG9w720v73Kr
        Qg/xxi1UoV20nmyFnzcR7fc=
X-Google-Smtp-Source: APiQypIMBVANqX5mS1XhUTfaHLqCbfuUp9eJdnNb6wPSFjXp5rIT+MYNnUAD9kaUtKywbmW2zbvBiQ==
X-Received: by 2002:a1c:4e15:: with SMTP id g21mr6441082wmh.29.1588109090241;
        Tue, 28 Apr 2020 14:24:50 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id j13sm26876116wro.51.2020.04.28.14.24.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Apr 2020 14:24:49 -0700 (PDT)
Date:   Tue, 28 Apr 2020 21:24:49 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] XArray: entry in last level is not expected to be a
 node
Message-ID: <20200428212449.2ww7ftgvrkcn4c7n@master>
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

Hi, Matthew

Would you mind picking up this thread again? Or what other concern you have?

-- 
Wei Yang
Help you, Help me
