Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE7D71D8546
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 May 2020 20:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732234AbgERSRv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 14:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728838AbgERSRt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 14:17:49 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7385C061A0C
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2020 11:17:49 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id s10so2962406pgm.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2020 11:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q9RvB5nbI09wHpLfw3yLJLanIbQbqsip0Oo5ChvdNdM=;
        b=QHkMv/WeF/pAoW2hxh1xX1qlre1qL6s8OM9laV1Dprb2X+Kv+QDkyRApG+Qv54H+xi
         mFtUOtyNXm76nMSWE2RvWWDyrdZ8YCY0Aln67yOEVQrVfwph+FoiZfxlbucNEqpnQfzl
         oHDRJomHU8uO4ZYiUHp5YyuxUewGtX/XVK1BE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q9RvB5nbI09wHpLfw3yLJLanIbQbqsip0Oo5ChvdNdM=;
        b=NXCBtoXajtRVJIX+nHVWgQ8p9mHmQb7UZUsWlLOsz/7BiU/5Sy+DIQ9XHDKTgsoME0
         ryK//ZC4XxdAxnu5HKuajHKtVEePb3ttCOZCBWyVSlZFkrPlKOdmXPhLBxvuFQHEk2oE
         OX1bmq/GZTv2UDQb3vNUhLkui72oMQAYSUmxRrnizzi0Qxlb1NWnmaz211BjBmSHAH1R
         Ju5iQyaK8I16fTbtYdXX/48pwYMluaTnlrTtUo/gyESwcTTSGVjzvgiIlDGSdVzwLGwT
         mbePA1yhduo91pJ+vMD5rXE4B3uAUpXVMn94zxKYn+90YOW+DKbxMR2tsOyWjhfCGFgU
         nJ7w==
X-Gm-Message-State: AOAM531Tbh7dy2kgkaxr4YeGBOq1kVhm82K3VyCJJLjTQ5RsVppIEmYT
        okBeoI4V4oXDFWWXg0Zin8EKSgHIySc=
X-Google-Smtp-Source: ABdhPJwWb935U8X4b3gsmekq3Adu+9arHCIUVn//jGRc1Z1HlHZPmASWj6IesI7CMnbrDuo9K8hLug==
X-Received: by 2002:a63:3c17:: with SMTP id j23mr15579357pga.343.1589825869244;
        Mon, 18 May 2020 11:17:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w7sm9014646pfw.82.2020.05.18.11.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 11:17:48 -0700 (PDT)
Date:   Mon, 18 May 2020 11:17:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Xiaoming Ni <nixiaoming@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Kitt <steve@sk2.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl: const-ify ngroups_max
Message-ID: <202005181117.BB74974@keescook>
References: <20200518155727.10514-1-steve@sk2.org>
 <202005180908.C016C44D2@keescook>
 <20200518172509.GM11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518172509.GM11244@42.do-not-panic.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 18, 2020 at 05:25:09PM +0000, Luis Chamberlain wrote:
> On Mon, May 18, 2020 at 09:08:22AM -0700, Kees Cook wrote:
> > On Mon, May 18, 2020 at 05:57:27PM +0200, Stephen Kitt wrote:
> > > ngroups_max is a read-only sysctl entry, reflecting NGROUPS_MAX. Make
> > > it const, in the same way as cap_last_cap.
> > > 
> > > Signed-off-by: Stephen Kitt <steve@sk2.org>
> > 
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> Kees, since there is quite a bit of sysctl cleanup stuff going on and I
> have a fs sysctl kitchen cleanup, are you alright if I carry this in a
> tree and send this to Andrew once done? This would hopefully avoid
> merge conflicts between these patches.
> 
> I have to still re-spin my fs sysctl stuff, but will wait to do that
> once Xiaoming bases his series on linux-next.

Yeah, totally. I don't technically have a sysctl tree (I've always just
had akpm take stuff), so go for it. I'm just doing reviews. :)

-- 
Kees Cook
