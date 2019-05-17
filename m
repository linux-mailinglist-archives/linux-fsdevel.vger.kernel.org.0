Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A525F21F66
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 23:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbfEQVKT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 17:10:19 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43127 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727949AbfEQVKT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 17:10:19 -0400
Received: by mail-qt1-f194.google.com with SMTP id i26so9602461qtr.10;
        Fri, 17 May 2019 14:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fziPkUVPPd8pNB7Q6ntU7Mk+rKbDI7+Yj/Vwva8hPrU=;
        b=JlnpXgjAvmojHhaoUZEOu7nWYTbT1WVJxhAQg/ltq3l00FQgUC0dvQZf2p22una2rm
         9NInH+w++1EZSp6c9V4ArJNMj0EAJLDYIfxVCMfM8rM9MLmdVhjb+eHTRl+Ra78QFxXX
         IG9d8DqbnCZutAMOvfYCXCVqJ5r6A4eEaaUJATicMAJMWc5TGj7ByHGEXGpxYZnxfpyb
         ZYNmbMJhbE7AzeziqiEnETar43KaaApisrhb3zr50qmubOxdvXZfP7n45h3hE/eMx/ho
         FxWTz+5OCOQzvUJxsZDqZhuohZlwCwT9v0M4p5yk49olx6EVw3thkj8ReeaQbn+Tq7sT
         Gltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fziPkUVPPd8pNB7Q6ntU7Mk+rKbDI7+Yj/Vwva8hPrU=;
        b=YazsBqPYZaR59a51u4L7fWL8lmwm9+o78VAbaUTGCwx2TbxoJuT6u7eWoFTpd1hqJY
         T03WEJKtO6jIoi40yTafjpCJIUCWtAnv8Qs90JXjrRXNwZELanZYPQ3FLjkG9j+oQVpS
         /ghnY4kf0J8FmsyAF31EOz32mbmD6beMfzr4mWRNim7Y44inOGGozbdVYNGJqYIhZePe
         ewF/hQVErlDS008yRJrMkfbGtGMfVki9+EvI7ZbqQQe2hpF8/LqCrvR4tRiS9GbecmQu
         Tj1665SppGX5eEa3fSp27+q+2jEAE/QfF6tCGCAmhPHaPoB7lvzw8NltycI8prfATpaa
         Opvw==
X-Gm-Message-State: APjAAAWyhmFx/N9+gGM40YvtyyPAiXKphWekJ4JqGffMHvUrefk34F4n
        UKgbyyl6heN4/yHmGhlWO3M=
X-Google-Smtp-Source: APXvYqyFIiqdHrvDSG3vP/SapftcAOyMi+dlfXg/SB/Ow1xRVTrmglb9Fi0SzpTlVcrCviHw2loSQg==
X-Received: by 2002:ac8:1aa4:: with SMTP id x33mr49219315qtj.69.1558127417674;
        Fri, 17 May 2019 14:10:17 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id c32sm699984qtd.61.2019.05.17.14.10.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 14:10:17 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 17 May 2019 17:10:15 -0400
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     hpa@zytor.com, Roberto Sassu <roberto.sassu@huawei.com>,
        viro@zeniv.linux.org.uk, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, initramfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.vnet.ibm.com,
        silviu.vlasceanu@huawei.com, dmitry.kasatkin@huawei.com,
        takondra@cisco.com, kamensky@cisco.com, arnd@arndb.de,
        rob@landley.net, james.w.mcmechan@gmail.com, niveditas98@gmail.com
Subject: Re: [PATCH v3 2/2] initramfs: introduce do_readxattrs()
Message-ID: <20190517211014.GA9198@rani.riverdale.lan>
References: <20190517165519.11507-1-roberto.sassu@huawei.com>
 <20190517165519.11507-3-roberto.sassu@huawei.com>
 <CD9A4F89-7CA5-4329-A06A-F8DEB87905A5@zytor.com>
 <20190517210219.GA5998@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190517210219.GA5998@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 17, 2019 at 05:02:20PM -0400, Arvind Sankar wrote:
> On Fri, May 17, 2019 at 01:18:11PM -0700, hpa@zytor.com wrote:
> > 
> > Ok... I just realized this does not work for a modular initramfs, composed at load time from multiple files, which is a very real problem. Should be easy enough to deal with: instead of one large file, use one companion file per source file, perhaps something like filename..xattrs (suggesting double dots to make it less likely to conflict with a "real" file.) No leading dot, as it makes it more likely that archivers will sort them before the file proper.
> This version of the patch was changed from the previous one exactly to deal with this case --
> it allows for the bootloader to load multiple initramfs archives, each
> with its own .xattr-list file, and to have that work properly.
> Could you elaborate on the issue that you see?
Roberto, are you missing a changelog entry for v2->v3 change?
