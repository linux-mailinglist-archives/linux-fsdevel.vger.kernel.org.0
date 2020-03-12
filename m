Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF32C183B30
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Mar 2020 22:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgCLVRk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Mar 2020 17:17:40 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43845 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgCLVRk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Mar 2020 17:17:40 -0400
Received: by mail-qk1-f196.google.com with SMTP id x1so4006663qkx.10;
        Thu, 12 Mar 2020 14:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RLLdpBX2XKQXFbUwZ31dgJPGrBdnYXHSYA1R5S4vBIc=;
        b=nafpvQB+7bG/ZUvDhm5LjCl4nvLQnxxIyec6VTyQay4nPmSqm9GglLBQ41WHplB6Kj
         z65YMzxgI2/c+oherRtGga5POxFF3dzDE6JQnBFz0Q6EQNw3V5ZnRLt4/mttipbB6XYm
         o8P9+pw/t/g/MyuwdXIFhrUurLR4dxznhPLAtr3kAkOMnGIYqyreRDTnL258s2JnodxV
         h1Ju25+Aa8Zs5DsEIdYa7n5NdXeUn95cvLzzkco6S7ut0i+mifEaMIXOMe5UJ6CGLKO4
         I9HuLnfoxqWE5ALbdgC2h30KKkvJMAXzlvUcHxPu/gGkabIEFSOckJPx5m+tZ9g0VbdI
         WCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=RLLdpBX2XKQXFbUwZ31dgJPGrBdnYXHSYA1R5S4vBIc=;
        b=SRmWCOL2iQNNUxPy2hf2j+VZGegLW+kK+IqqiwoN1QnLNLdqdiTJSymEvDfrkm9CHm
         2ku3ORsL039ygO0TYcjNcRREHi5419TdiFbYVSfuRrVnWeJszskoRfuUrn8F7tl9ft1U
         U2QzpBK25gV/yzWWGmvMKPa6w3KOOKOGHWogS0dlBbvukyZB1KvMIM+NKGlXxNZ2s4ci
         sjutDroswiwr7/+KZ31KNeHwgNeMh2JtrOeh3dwOTaGnOM5dGiHiqLAZkXtKUqAJF54b
         zto3EB+tg7LC2gm1xgfO/0mVaxlW87s6m52iR6Po//Xk1E/ZFoB/EpPZBJVSQlkCHenr
         GSvA==
X-Gm-Message-State: ANhLgQ3t0zTn3FmgYiOIfbZ2Qr43273JH6aKFcip2lU1b4bM/QzM4KE6
        JDEggaQ0gduEb4yKWE83GdY=
X-Google-Smtp-Source: ADFU+vv/ttLvSy9SVHIvSLeCKLXPTxanYEzI1C0Ul5P0Gxcc0wCMfp5jYyJrRDuefnvRh9cWb5Ab0g==
X-Received: by 2002:a05:620a:943:: with SMTP id w3mr10149142qkw.85.1584047857109;
        Thu, 12 Mar 2020 14:17:37 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::25ed])
        by smtp.gmail.com with ESMTPSA id q142sm8396730qke.45.2020.03.12.14.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 14:17:36 -0700 (PDT)
Date:   Thu, 12 Mar 2020 17:17:35 -0400
From:   Tejun Heo <tj@kernel.org>
To:     gregkh@linuxfoundation.org, Daniel Xu <dxu@dxuuu.xyz>
Cc:     cgroups@vger.kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        viro@zeniv.linux.org.uk, shakeelb@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v3 0/4] Support user xattrs in cgroupfs
Message-ID: <20200312211735.GA1967398@mtj.thefacebook.com>
References: <20200312200317.31736-1-dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312200317.31736-1-dxu@dxuuu.xyz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

Daniel, the patchset looks good to me. Thanks a lot for working on
this.

Greg, provided that there aren't further objections, how do you wanna
route the patches? I'd be happy to take them through cgroup tree but
any tree is fine by me.

Thanks.

-- 
tejun
