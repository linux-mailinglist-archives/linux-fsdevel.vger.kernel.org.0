Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54FB9183B35
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Mar 2020 22:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgCLVT2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Mar 2020 17:19:28 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41719 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgCLVT2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Mar 2020 17:19:28 -0400
Received: by mail-qk1-f193.google.com with SMTP id b5so8852818qkh.8;
        Thu, 12 Mar 2020 14:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JTXt1OEkKePago7QylMBAyiYQ7S4tVDId/6muJlv8kg=;
        b=WDSCCAorJeZ6KuiLgpb2NOSuo5qVP6GWOxv/Q3FR28T2zL7W+mcqNlfnGGZhnDWjJc
         FbZic2wgZZBaJR4YRNQSIU1F7PdbMnH7lg5OIEUOQuGEYXKc3nFeMbkcZyc/3GBYpteA
         8I1D7Ld0Ly3b1oXygzubVBMi69vuzBm+ilXd+LUMJx279TKgeV/XMGmyZGfatd8/qv+c
         dVGuv+qOx23jt+V0u+FdAv69c0ytBhKqK8LKxHlGISNGM/YYv8fdSgL7VRpOvFiGsK87
         4VUhQ8APCO0bRvlsbyb6gdOpwfnTHjJ2nuAaWaRjR4Olio4yjE4sifW/bgIOjL0SCgwv
         IXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=JTXt1OEkKePago7QylMBAyiYQ7S4tVDId/6muJlv8kg=;
        b=blQ5FdEn9sWcCGasb5yQvUb+/930u7q67SPMcIEjUWTEOVefx47ErJyOXbIWuopN6n
         mJ9u9eQMK+RkXcEVCSR8djcm0OiWCa2SeEU+U2qZcy7PuKDbl4xzgKBkOdxggbw3HstJ
         1bLki5qsiCcMxU4E1IWqhxkI5gPmkLm3fLuViXEsU0lHTqrcYl/jvlUHgQT44KCuRuta
         5BQhZPq4kynUiVnv3KHHTHhApgYSJuWwDJaU2mzogcVbwU2TaqTWIKYHiKYb7Kf5ZAmo
         eGq+b53bT0kp2PEUa9WJmFy+Ws96lJNE8ULtXjlctpQyhipTF+Fet/DOv41CNxDhLP4o
         FeNg==
X-Gm-Message-State: ANhLgQ0NwxWkE5bJ4ruNZ1cdWxyhlc8fX8FyykOV6+3pYGGBpWb4kXlM
        I81kA70Y2Sny65X0hiEKWhc=
X-Google-Smtp-Source: ADFU+vtLQ4Uz70cBIlKU4EfvGH0QxhB+QttLTVZQ6WocnigSOkUapTHzj1v5eXA4FAacFoogpLM6vw==
X-Received: by 2002:a37:8b45:: with SMTP id n66mr9701127qkd.380.1584047966472;
        Thu, 12 Mar 2020 14:19:26 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::25ed])
        by smtp.gmail.com with ESMTPSA id b8sm21267063qte.52.2020.03.12.14.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 14:19:25 -0700 (PDT)
Date:   Thu, 12 Mar 2020 17:19:24 -0400
From:   Tejun Heo <tj@kernel.org>
To:     gregkh@linuxfoundation.org, Daniel Xu <dxu@dxuuu.xyz>
Cc:     cgroups@vger.kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        viro@zeniv.linux.org.uk, shakeelb@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v3 0/4] Support user xattrs in cgroupfs
Message-ID: <20200312211924.GB1967398@mtj.thefacebook.com>
References: <20200312200317.31736-1-dxu@dxuuu.xyz>
 <20200312211735.GA1967398@mtj.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312211735.GA1967398@mtj.thefacebook.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 12, 2020 at 05:17:35PM -0400, Tejun Heo wrote:
> Greg, provided that there aren't further objections, how do you wanna
> route the patches? I'd be happy to take them through cgroup tree but
> any tree is fine by me.

Ooh, in case they get routed thorugh another tree, for the whole
series:

  Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
