Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 259D0179A6D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 21:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbgCDUuu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 15:50:50 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34699 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbgCDUut (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 15:50:49 -0500
Received: by mail-ed1-f67.google.com with SMTP id c21so2455896edt.1;
        Wed, 04 Mar 2020 12:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=zt0RLm7OTdsp3yOD+OCYiUKlYSum620aC9kq/4VQu2c=;
        b=b6XelXILrfVo4hOq8Bxsv/Ld0eB3+mY3MTj88ek+YrPTQGEUfBk/ETftrELd4JEMFF
         S4zkxC+lWlrYJzpv5jTaTixOGpneRoR4kxzY762Uw1basiuicdGEtHL3VuPxw7h0fV2O
         qqhR49z9mT3VgNmtaYbKvgY2g4MmdmEPwliE/nXBNoTwpd19yy6d8SmvrUZo1ERnqdV6
         VbMszUyDOxEuAcpH8X/GCH+jvFAgPyBOlF7QrJrVtkFA/Tpe5IXp/WqlYzpn6s6D58bF
         /USdzLTL07HyT8o2zDHmwkHm8IS9s29ypYAITTvjWmwxRIbpTJkQP7LTkOyyrar7P8hn
         jXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=zt0RLm7OTdsp3yOD+OCYiUKlYSum620aC9kq/4VQu2c=;
        b=ebfvW469mA6/kz+KFRt1iTQ75A0CiCXdPgdvzlawdVvLUshftIoohhwLB61iPWR5RY
         AsmOYajkd3CFh8Bn9QXJcfQXSeA5OnuyK2Tkw8zzcSVw+z9UHoFFi/y8W3NaKs8jzLmA
         +ojO+LeCl9SXhrPu6yttlP3KsjlsGBSmUKT5sUiN6AvMJ9YsFTfTkhR8HJXjrIYVWp3r
         J+YOdvpFg94FfM+1dpnJHEp+ZAVf8k3lq3neEgiJJ6/mmzT6KqmSLuEKUywrmryx7Zfd
         QaGWQXLcmqyziP7602WIUOX3wI0ZGJQx7csXsxKaWIUo6DCJ3fciE8DSP9PzOIdNoNxx
         20DA==
X-Gm-Message-State: ANhLgQ0jfxC7H+JQhBgd1nexZEnnEVEnwkH1ZeOrJd5pfgLHOHWphMWf
        fZc8XMZjb3tOfobid9HuZLg=
X-Google-Smtp-Source: ADFU+vsa8BpqTZFAAWs88Do5WrkxCwKcJwPQ4lgHcetbGp8wCV2tilCvbDjuH441aG9SvMa7IFQxHA==
X-Received: by 2002:aa7:c54a:: with SMTP id s10mr4665670edr.345.1583355047588;
        Wed, 04 Mar 2020 12:50:47 -0800 (PST)
Received: from felia ([2001:16b8:2d16:4100:5c62:5f:595c:f76d])
        by smtp.gmail.com with ESMTPSA id q3sm1384115eju.88.2020.03.04.12.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 12:50:46 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Wed, 4 Mar 2020 21:50:39 +0100 (CET)
X-X-Sender: lukas@felia
To:     Jonathan Corbet <corbet@lwn.net>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: adjust to filesystem doc ReST conversion
In-Reply-To: <20200304131035.731a3947@lwn.net>
Message-ID: <alpine.DEB.2.21.2003042145340.2698@felia>
References: <20200304072950.10532-1-lukas.bulwahn@gmail.com> <20200304131035.731a3947@lwn.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Wed, 4 Mar 2020, Jonathan Corbet wrote:

> On Wed,  4 Mar 2020 08:29:50 +0100
> Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> > Jonathan, pick pick this patch for doc-next.
> 
> Sigh, I need to work a MAINTAINERS check into my workflow...
>

I getting closer to have zero warnings on the MAINTAINER file matches and 
then, I would set up a bot following the mailing lists to warn when anyone
sends a patch that potentially introduces such warning.
 
> Thanks for fixing these, but ... what tree did you generate the patch
> against?  I doesn't come close to applying to docs-next.
>

My patch was based on next-20200303, probably too much noise on 
MAINTAINERS, such that it does not apply cleanly on docs-next.
If you want, I can send a patch that fits to docs-next. Anyway, merging 
will be similarly difficult later :(

Lukas
