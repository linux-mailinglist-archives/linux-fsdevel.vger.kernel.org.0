Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32DFF1997B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 15:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730703AbgCaNmN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Mar 2020 09:42:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41549 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730216AbgCaNmN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Mar 2020 09:42:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id h9so25983173wrc.8;
        Tue, 31 Mar 2020 06:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h9LY2iXv/ppo2lNiZE8mQF/9TzGJ001hikG+hgYnB/Q=;
        b=IjyKoAHI3n070pNL8QaDaq5+WNNQSQrpMbrQsHn3KBHh3pPnrmKQJ3HTYGXbKzdx/2
         e3Hh1wzCZZuqnjGl91FW+buR56Oj9S0Vpk/O3XF3QaJvlRLDPRz+5yqLDj+t/vc7JNke
         DCBc+2J35R6xohZ2eSASq6+n1h6ZOxC7MmNp7SxYUrwqZTB1R8UKo7bGnnjDFYutylPv
         h5hH4ZLKLycGmjtOm2RmKSJ9bJyuarCbIeOeWm4qlMvgIU9n1c1Lq1rNKdTemCVEfBy2
         EdkB+aKpz3yO33Rk80J01zCyhQ4VVariqI9x11dl4cp5s9NYBLfF+qVuFa9chVmAHQYp
         RUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=h9LY2iXv/ppo2lNiZE8mQF/9TzGJ001hikG+hgYnB/Q=;
        b=NrHzxtoZ0z7owef1fSA151xxlPdXjC8oCPGnM4Rw1OI4wmBKVYEQiSG1CJCR/eGotM
         H/tVmcNzQjhGaomcpQxzyP94AyzaK4aLhh9Jta2XaNnipPafWDY3USy6yRcHlP8X1fgt
         MMBd9sLPqGiHWP5MRoOzb9eUsnGGq4yy9HQyrbyDHeSUCnsgpht9o/JX80n1kLpD2vGk
         R80s+36WK+HxOPNV9KYJBBRrwQPgCO6Z2pR/aGxxyYqq/vl2vIA8mrIil9/kuDSQ54by
         v+vWVOCZE8W75mP7we5D3X6hlCDDaOz8lZlFAVTXsZFpVlvAY+v9+338LE6qbBtstzua
         pSKQ==
X-Gm-Message-State: ANhLgQ1f2vNEqHIYORSQ58oRS8U+qGe8uB0VUTJ9vhjnA4B/RSssj7C5
        YD+I1MKJEsNM4cLae2FxP80=
X-Google-Smtp-Source: ADFU+vsR2NgjHwweFOJpS9UKtPUxE8zgC3Ubn8W4w1wkp/+qlKfzgNC9l2mHPMeDcupwzdMJCApZrQ==
X-Received: by 2002:adf:9384:: with SMTP id 4mr20327790wrp.214.1585662131336;
        Tue, 31 Mar 2020 06:42:11 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id m11sm3907455wmf.9.2020.03.31.06.42.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Mar 2020 06:42:09 -0700 (PDT)
Date:   Tue, 31 Mar 2020 13:42:08 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] XArray: entry in last level is not expected to be a
 node
Message-ID: <20200331134208.gfkyym6n3gpgk3x3@master>
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

Hmm... I did a make on top of 5.6-rc6, it failed. Would you mind taking a look
into this?

>The IDR tests are the ones which are going to trigger on this.

-- 
Wei Yang
Help you, Help me
