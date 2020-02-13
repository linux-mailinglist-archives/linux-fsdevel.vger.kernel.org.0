Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D91815C017
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 15:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730177AbgBMOKr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 09:10:47 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43918 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730078AbgBMOKr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 09:10:47 -0500
Received: by mail-lj1-f196.google.com with SMTP id a13so6743998ljm.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Feb 2020 06:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5uuw5VB1crC2RtuhzMZXUp9a6S2yRCWA3BqEb1joj7w=;
        b=WaNoUJKz4mohQBxuF4aFQZbMebf0zDm0pXdHvDk6F8zWcaHQAVyXVDmTqyiyRKGco0
         TBiJwCy82N6TDxTD/xD+Gm/GraQMWMgE4MN1ferm/Fx0wO7Bg70/iYY83lpZiLwMaUSv
         YZ2Q4EC7R09YWoR8K2EHUR2HNycnNy89BUIMTQY9Gq5vzA9E/YTzftWnKRzY5dgKacxo
         A2nL1XiHU9wydJwCPRtQLinO00vWwW3e+rG1IYnJHP+mZpfCj7nUWb7m8RHQJGm6qgQX
         SeuhCnivW2+Ty9ifcoK0OlySRwdxwHFWcsMsZ+iVmIB9LBcjW3uOsUgpNvkgf3l0Hm0w
         n/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5uuw5VB1crC2RtuhzMZXUp9a6S2yRCWA3BqEb1joj7w=;
        b=lA0ApDXoGWV8SKkJe5ICmnRGbju2FXf7lgiCKF+ajmB3eRaBa6JHyjHQZptxrabwHp
         P4ZwixDISg1pnriUac9h7V1486SuQBlbAUOaGeR4nrM2SftEOz71/dVGc1Slr2wCj3GX
         5J58dAKrqgiaFmZIKXYed/rzvh96EuMNv9oHwQOOaPDQiepI68p2psooLC4vqiriPYAq
         2I/6EXdoMu9h+jOBaxlF1TJHhj/qE9qtRIYeDSuf6cuLAWhIwSJSNIRXck8CiehUhro8
         tqb34+KFoqImREYR0IxMrVTz8ODsl2fm1m7rIuCPUBcEaOzbfiqnm0rh3e1Wz22KDr32
         8LbQ==
X-Gm-Message-State: APjAAAUQQbYT1WsArqmLHwFHdC4TUDEj3RJ55sfyDuyc20YwpGXfYIaX
        DOvLhpZzFjkp9EzwWIII/El2dQ==
X-Google-Smtp-Source: APXvYqx1hls1kSmZ4MnFS5qpOx2IsToARKVnISthSeQjnQGn2/e3ilt3jan9a3LpAHVf6dwHWo7KAQ==
X-Received: by 2002:a2e:b0c9:: with SMTP id g9mr11578372ljl.134.1581603046071;
        Thu, 13 Feb 2020 06:10:46 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id x29sm1671116lfg.45.2020.02.13.06.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 06:10:45 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id ACAC3100F25; Thu, 13 Feb 2020 17:11:07 +0300 (+03)
Date:   Thu, 13 Feb 2020 17:11:07 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/25] mm: Allow hpages to be arbitrary order
Message-ID: <20200213141107.ftfnenli72eburei@box>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-7-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212041845.25879-7-willy@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 11, 2020 at 08:18:26PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Remove the assumption in hpage_nr_pages() that compound pages are
> necessarily PMD sized.  The return type needs to be signed as we need
> to use the negative value, eg when calling update_lru_size().

But should it be long?
Any reason to use macros instead of inline function?

-- 
 Kirill A. Shutemov
