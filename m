Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778FA2CDCB6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 18:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731102AbgLCRus (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 12:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbgLCRur (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 12:50:47 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DDCC061A4F
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Dec 2020 09:50:06 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id b12so1556077pjl.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Dec 2020 09:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ppnO25OuYQ/1IjELB2kgBioJi4rv6POx6IlxQIXXNpk=;
        b=HOHj6ayscVe3ZO0DpYfNEMtrxcPpXBfSBduTRP26eJAi9qWeDaEaqvnlWyD1tkgsNn
         WHf/c+iph12AtDq5ZPiB0xBf7vpVwaQ+d4FmzkhPANMYu7p/pjev/8GYudVFNTVY2ars
         R0psmS9bdHBmvimevhcc3vnoNApM2yiWbbZqFciw03VA6B2hsct4V9O85JtoFFYiWG/+
         CQ1HnSZiPPrui+eqkQEZ//rCuCzBXtD68Sm5lSes2CW89A6EAEjmGkSAk95oQI7exFis
         skTuSOtL2uFNQ/9INU1C2swi0XB4WpYbH2P6PwK4LjQvHJAXEczMh6WIpsHUAxlFLy2R
         hq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ppnO25OuYQ/1IjELB2kgBioJi4rv6POx6IlxQIXXNpk=;
        b=avAHZ3rOQ9xZYOCEjcu0JoY7pwVsPB+bfFWJiNFZwBdH5jqeJdtybOcRwj9qP5AnyV
         rw2oECSVtFTUC63Ct8DchIKwyA6h+VokFpIokyydP1CwwnF1fV46F2qcw2JtEHOsUEoL
         TqSLDFyFzxduFjRUGteNFgoO3sGt+t/Nj7C9t8+su/U4D9fdCtrHXMCTySrzYJ8BGI/9
         qcAB7DL02Q5b5lt6GwP2o491RrmqcUQ5fyMdnEPzbAojEN3STE28o+9WVtd7gvGnt7sw
         E64IJsBQPZyxmstxOuVmG+MaLcqWmyJbWq+qIB6w2f6/xtSxejj5RkibMN4QdLpdI6Ke
         qlKg==
X-Gm-Message-State: AOAM533LsBkn/JAZZx6/jiEQVEsgDJrMwMdHxljrDRk7OlFOE/s39kv9
        D1WZSGxHcKfqWY0et5mVwWulMQ==
X-Google-Smtp-Source: ABdhPJxllA5bbSYrFdTd4toUUA9bg5VaxzP3LGpwUAiBmd2AiI89u7amTYs88FKICVUaW8O+Hlmcgw==
X-Received: by 2002:a17:90a:7e0f:: with SMTP id i15mr230116pjl.93.1607017806270;
        Thu, 03 Dec 2020 09:50:06 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id e66sm2251101pfe.165.2020.12.03.09.50.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 09:50:05 -0800 (PST)
Subject: Re: [iov_iter] 9bd0e337c6: will-it-scale.per_process_ops -4.8%
 regression
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>
Cc:     David Howells <dhowells@redhat.com>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>, zhengjun.xing@intel.com,
        Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <160596801020.154728.15935034745159191564.stgit@warthog.procyon.org.uk>
 <20201203064536.GE27350@xsang-OptiPlex-9020>
 <CAHk-=wif1iGLiqcsx1YdLS4tN01JuH-MV_oem0duHqskhDTY9A@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8124ce0d-c934-0771-5e34-cf5ea030fc08@kernel.dk>
Date:   Thu, 3 Dec 2020 10:50:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wif1iGLiqcsx1YdLS4tN01JuH-MV_oem0duHqskhDTY9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/3/20 10:47 AM, Linus Torvalds wrote:
> On Wed, Dec 2, 2020 at 10:31 PM kernel test robot <oliver.sang@intel.com> wrote:
>>
>> FYI, we noticed a -4.8% regression of will-it-scale.per_process_ops due to commit:
> 
> Ok, I guess that's bigger than expected, but the profile data does
> show how bad the indirect branches are.

It's also in the same range (3-6%) as the microbenchmarks I ran and posted.
So at least there's correlation there too.

-- 
Jens Axboe

