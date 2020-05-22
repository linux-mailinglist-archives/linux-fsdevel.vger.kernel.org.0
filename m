Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C111DEE48
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 May 2020 19:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730636AbgEVRcX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 May 2020 13:32:23 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:38327 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730600AbgEVRcW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 May 2020 13:32:22 -0400
Received: by mail-ej1-f66.google.com with SMTP id h21so13908399ejq.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 10:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SyPJvkOwtsfRkEygo13pRg6+wPBwKMFYl5m53jmPnhA=;
        b=FmhaJErwcEoDXVSO7gIPXX+KwanAr/iyNxffsWbdP7XSyMmQH+kzwgL7Cud3cj0k7G
         pDFKM+D/OvBUT6ZPj6PJ0+Qt/Pap247YuMGiOGjTw6N9vXNMAIkv4bc3DWHVUs5h+gTl
         7yDFjM9+DVocpoxWojbBawXEhwgXStsm0f2eK/bo4RSbtvgjTza6Fre1ubqU5rKlV7Ii
         PekPd5mWofBO3AizsSlXtJtXObe0spovEtVUrVqpry8X0cqJrjZwKTCcV9szQzW7RHxn
         IBwAogO4n3l44Icv9F25/x/JGiv9e6DvPwDhrJOFAgss6B1j3emmBuRkHZOpV3A6Uvto
         0I8A==
X-Gm-Message-State: AOAM530yPh/JLgQpYc+Qt/htAGXoc6wwKdaXqGvtPxdLnAHQ4PXflNzW
        7OTbK2ue1jUKUqP7oHA0ZqUxfuWhgPc=
X-Google-Smtp-Source: ABdhPJzRv5MY8vTa8m85pyMRg7v9P0AJHj0r+03kIRZKsCd6RGW+kdUaER1QSll/uo+dpvMbHciMzA==
X-Received: by 2002:a17:906:4947:: with SMTP id f7mr9004105ejt.373.1590168740769;
        Fri, 22 May 2020 10:32:20 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id ef13sm8821240ejb.24.2020.05.22.10.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 10:32:19 -0700 (PDT)
Date:   Fri, 22 May 2020 19:32:18 +0200
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: Remove duplicated flag from VALID_OPEN_FLAGS
Message-ID: <20200522173218.GB40716@rocinante>
References: <20200522133723.1091937-1-kw@linux.com>
 <20200522154719.GS23230@ZenIV.linux.org.uk>
 <20200522170119.GA31139@bombadil.infradead.org>
 <20200522171856.GU23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200522171856.GU23230@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Al and Matthew!

On 20-05-22 18:18:56, Al Viro wrote:

[...]
> > I think the patch is actually right, despite the shockingly bad changelog.
> > He's removed the duplicate 'O_NDELAY' and reformatted the lines.
> 
> So he has; my apologies - the obvious false duplicate in there would be
> O_NDELAY vs. O_NONBLOCK and I'd misread the patch.
> 
> Commit message should've been along the lines of "O_NDELAY occurs twice
> in definition of VALID_OPEN_FLAGS; get rid of the duplicate", possibly
> along with "Note: O_NONBLOCK in the same expression is *not* another
> duplicate - on sparc O_NONBLOCK != O_NDELAY (done that way for ABI
> compatibility with Solaris back when sparc port began)".

Apologies.  The v2 is coming and will have proper commit message along
with subject that explains what the intended change is, etc.

Krzysztof
