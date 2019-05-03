Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6B513049
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2019 16:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbfECOeo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 May 2019 10:34:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:56600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbfECOen (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 May 2019 10:34:43 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25143205ED;
        Fri,  3 May 2019 14:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556894083;
        bh=/MHif5okGldV0zJQO9uwxXPuEkzcX3tjHeme2xBr56I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NQY37OjiDkyluGn7wp+DEOQ/rusC2ZYGlS4OkQ7N+lGvPlx4i/cOygGh1BvxNcmx4
         rY1AGyNGOTnMTv1qPj+ls8/RXFBM4ovpE9ABphx0LXCOgriZ0pfU6jiokQXi8WZYPY
         1sBgomiACkkAoeaTjbiQILVPV80zL82ux9sv8C8Q=
Subject: Re: [PATCH v2 11/17] kunit: test: add test managed resource tests
To:     Brendan Higgins <brendanhiggins@google.com>,
        frowand.list@gmail.com, gregkh@linuxfoundation.org,
        keescook@google.com, kieran.bingham@ideasonboard.com,
        mcgrof@kernel.org, robh@kernel.org, sboyd@kernel.org
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com,
        dan.j.williams@intel.com, daniel@ffwll.ch, jdike@addtoit.com,
        joel@jms.id.au, julia.lawall@lip6.fr, khilman@baylibre.com,
        knut.omang@oracle.com, logang@deltatee.com, mpe@ellerman.id.au,
        pmladek@suse.com, richard@nod.at, rientjes@google.com,
        rostedt@goodmis.org, wfg@linux.intel.com,
        Avinash Kondareddy <akndr41@gmail.com>,
        shuah <shuah@kernel.org>
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-12-brendanhiggins@google.com>
From:   shuah <shuah@kernel.org>
Message-ID: <8c37fd20-859c-9c34-4465-8adfcfdaab09@kernel.org>
Date:   Fri, 3 May 2019 08:34:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501230126.229218-12-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/1/19 5:01 PM, Brendan Higgins wrote:
> From: Avinash Kondareddy <akndr41@gmail.com>
> 
> Tests how tests interact with test managed resources in their lifetime.
> 
> Signed-off-by: Avinash Kondareddy <akndr41@gmail.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---

I think this change log could use more details. It is vague on what it
does.

thanks,
-- Shuah

